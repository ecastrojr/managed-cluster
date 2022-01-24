apiVersion: helm.toolkit.fluxcd.io/v2beta1
kind: HelmRelease
metadata:
  name: monitoring
  namespace: flux-system
spec:
  chart:
    spec:
      chart: kube-prometheus-stack
      sourceRef:
        kind: HelmRepository
        name: prometheus-community
      version: 14.4.0
  install:
    createNamespace: true
    disableWait: false
    remediation:
      retries: -1
  interval: 5m
  releaseName: monitoring
  storageNamespace: monitoring
  targetNamespace: monitoring
  values:
    prometheusOperator:
      admissionWebhooks:
        enabled: false
        patch:
          enabled: false
      tls:
        enabled: false

      resources:
        limits:
          cpu: 150m
          memory: 256Mi
        requests:
          cpu: 50m
          memory: 128Mi

      tolerations:
      - key: dedicated
        value: infra
        effect: NoSchedule
      - key: CriticalAddonsOnly
        effect: NoSchedule

      nodeSelector:
        role: infra

    prometheus:
      service:
        type: ClusterIP
        loadBalancerIP: null
        sessionAffinity: ClientIP
      ingress:
        enabled: false
        annotations:
          kubernetes.io/ingress.class: nginx
          nginx.ingress.kubernetes.io/auth-realm: Authentication Required - Monitoring
          nginx.ingress.kubernetes.io/auth-secret: monitoring-basic-auth
          nginx.ingress.kubernetes.io/auth-type: basic
    #      cert-manager.io/cluster-issuer: letsencrypt-staging-http01
        hosts:
          - prometheus.example.com
    #    tls:
    #    - hosts:
    #      - prometheus.example.com
    #      secretName: prometheus-ingress-tls

      prometheusSpec:
        replicas: 1
        retention: 7d
        scrapeInterval: 30s
        enableAdminAPI: true

        resources:
          limits:
            cpu: 1
            memory: 2Gi
          requests:
            cpu: 100m
            memory: 1Gi

        externalLabels:
          cluster: cluster
        prometheusExternalLabelName: cluster

        ruleNamespaceSelector: {}
        ruleSelectorNilUsesHelmValues: false
        ruleSelector: {}

        serviceMonitorNamespaceSelector: {}
        serviceMonitorSelectorNilUsesHelmValues: false
        serviceMonitorSelector: {}

        tolerations:
        - key: dedicated
          value: infra
          effect: NoSchedule
        - key: CriticalAddonsOnly
          effect: NoSchedule

        nodeSelector:
          role: infra

        storageSpec:
          volumeClaimTemplate:
            metadata:
              labels:
                pv.label.getup.io.velero.io/exclude-from-backup: "true"
            spec:
              resources:
                requests:
                  storage: 100Gi

    alertmanager:
      alertmanagerSpec:
        replicas: 2

        logFormat: logfmt

        tolerations:
        - key: dedicated
          value: infra
          effect: NoSchedule
        - key: CriticalAddonsOnly
          effect: NoSchedule

        nodeSelector:
          role: infra

        resources:
          limits:
            cpu: 50m
            memory: 256Mi
          requests:
            cpu: 10m
            memory: 128Mi

      service:
        type: ClusterIP
        sessionAffinity: ClientIP

      ingress:
        enabled: false
        annotations:
          kubernetes.io/ingress.class: nginx
          nginx.ingress.kubernetes.io/auth-realm: Authentication Required - Monitoring
          nginx.ingress.kubernetes.io/auth-secret: monitoring-basic-auth
          nginx.ingress.kubernetes.io/auth-type: basic
          #cert-manager.io/cluster-issuer: letsencrypt-staging-http01
        hosts:
          - alertmanager.example.com
    #    tls:
    #    - hosts:
    #      - alertmanager.example.com
    #      secretName: ${ try(helm_releases.monitoring.monitoring.template_vars.alertmanager_ingress_tls, "alertmanager-ingress-tls") }


      config:
        global:
          resolve_timeout: 6h

        route:
    #      receiver: slack
          receiver: blackhole
          group_by: ['alertname', 'cluster_name']
          group_wait: 15s
          group_interval: 5m
          repeat_interval: 3h

          ###
          ### Routes
          ###

          routes:
          # watchdog aims to test the alerting pipeline
          - match:
              alertname: Watchdog
            continue: false

    #      # Ignore too noisy alerts
    #      - receiver: blackhole
    #        match_re:
    #          alertname: CPUThrottlingHigh
    #          namespace: ^(.*-system|logging|monitoring|velero|cert-manager|.*-operator|.*-ingress|ingress-.*|.*-provisioner|getup|.*istio.*|.*-controllers)$
    #        continue: false

    #########################
    ## External alert systems
    #########################

    #      # Cronitor
    #      #############################
    #      - receiver: cronitor
    #        match:
    #          alertname: CronitorWatchdog
    #        group_wait: 5s
    #        group_interval: 1m
    #        continue: false

    #      # Slack
    #      #############################
    #      - receiver: slack
    #        match_re:
    #          alertname: .*
    #        continue: true

    #      # MSTeams
    #      #############################
    #      - receiver: msteams
    #        match_re:
    #         alertname: .*
    #        continue: true

    #      # Opsgenie
    #      #############################
    #      - receiver: opsgenie
    #        match_re:
    #          alertname: (KubeCronJobRunning|KubeDaemonSetRolloutStuck|KubeDeploymentGenerationMismatch|KubeDeploymentReplicasMismatch|KubePodCrashLooping|KubePodNotReady|KubeStatefulSetGenerationMismatch|KubeStatefulSetReplicasMismatch|KubeCronJobRunning|KubeDaemonSetRolloutStuck|KubeDeploymentGenerationMismatch|KubeDeploymentReplicasMismatch|KubePodCrashLooping|KubePodNotReady|KubeStatefulSetGenerationMismatch|KubeStatefulSetReplicasMismatch|AlertmanagerFailedReload|CertificateAlert|ClockSkewDetected|EndpointDown|HighNumberOfFailedProposals|PrometheusOperatorReconcileErrors|PrometheusConfigReloadFailed|PrometheusNotConnectedToAlertmanagers|PrometheusTSDBReloadsFailing|PrometheusTSDBCompactionsFailing|PrometheusTSDBWALCorruptions|PrometheusNotIngestingSamples|KubeNodeUnreachable|KubeClientCertificateExpiration|KubeNodeNotReady|KubeAPILatencyHigh|HighNumberOfFailedHTTPRequests|KubeStatefulSetUpdateNotRolledOut|KubeJobCompletion|KubeJobFailed)
    #          namespace: (kube-.*|logging|monitoring|velero|cert-manager|.*-operator|.*-ingress|ingress-.*|.*-provisioner|getup|.*istio.*|.*-controllers)
    #          severity: warning
    #        continue: true
    #      - receiver: opsgenie
    #        match:
    #          severity: critical
    #        continue: false

    #      # PageDuty
    #      #############################
    #      - receiver: pager_duty
    #        match_re:
    #          # alertname: (KubeCronJobRunning|KubeDaemonSetRolloutStuck|KubeDeploymentGenerationMismatch|KubeDeploymentReplicasMismatch|KubePodCrashLooping|KubePodNotReady|KubeStatefulSetGenerationMismatch|KubeStatefulSetReplicasMismatch|KubeCronJobRunning|KubeDaemonSetRolloutStuck|KubeDeploymentGenerationMismatch|KubeDeploymentReplicasMismatch|KubePodCrashLooping|KubePodNotReady|KubeStatefulSetGenerationMismatch|KubeStatefulSetReplicasMismatch|AlertmanagerFailedReload|CertificateAlert|ClockSkewDetected|EndpointDown|HighNumberOfFailedProposals|PrometheusOperatorReconcileErrors|PrometheusConfigReloadFailed|PrometheusNotConnectedToAlertmanagers|PrometheusTSDBReloadsFailing|PrometheusTSDBCompactionsFailing|PrometheusTSDBWALCorruptions|PrometheusNotIngestingSamples|KubeNodeUnreachable|KubeClientCertificateExpiration|KubeNodeNotReady|KubeAPILatencyHigh|HighNumberOfFailedHTTPRequests|KubeStatefulSetUpdateNotRolledOut|KubeJobCompletion|KubeJobFailed)
    #          # namespace: (kube-.*|logging|monitoring|velero|cert-manager|.*-operator|.*-ingress|ingress-.*|.*-provisioner|getup|.*istio.*|.*-controllers)
    #          severity: warning
    #        continue: true
    #      - receiver: pager_duty
    #        match:
    #          severity: critical
    #        continue: false

          # ignored all alerts (default)
          - receiver: blackhole
            match_re:
              alertname: .*
            continue: false

        ###
        ### Receivers
        ###

        receivers:
        # does nothing
        - name: blackhole

    #    # Cronitor
    #    #############################
    #    - name: cronitor
    #      webhook_configs:
    #      - url: https://cronitor.link/${alertmanager_cronitor_id}/run
    #        send_resolved: false

    #    # Slack
    #    #############################
    #    - name: slack
    #      slack_configs:
    #      - send_resolved: true
    #        api_url: https://XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    #        channel: "#${trimprefix(slack.channel, "#")}"
    #        color: |-
    #          {{- if eq .Status "firing" -}}
    #            {{- if eq (index .Alerts 0).Labels.severity "critical" -}}
    #              #FF2222
    #            {{- end -}}
    #            {{- if eq (index .Alerts 0).Labels.severity "warning" -}}
    #              #FF8800
    #            {{- end -}}
    #            {{- if and (ne (index .Alerts 0).Labels.severity "critical") (ne (index .Alerts 0).Labels.severity "warning") -}}
    #              #22FF22
    #            {{- end -}}
    #          {{- else -}}
    #            #22FF22
    #          {{- end -}}
    #        title: '{{ template "slack.default.title" . }}'
    #        pretext: '{{ .CommonAnnotations.summary }}'
    #        fallback: '{{ template "slack.default.fallback" . }}'
    #        text: |-
    #          {{ range .Alerts -}}
    #          *Severity:* `{{ .Labels.severity | title }}` (<{{ .GeneratorURL }}|graph>)
    #          *Description:* {{ .Annotations.message }}
    #          *Labels:*{{ range .Labels.SortedPairs }} `{{ .Name }}={{ .Value }}`{{ end }}
    #          {{ end }}

    #    # MSTeams
    #    #############################
    #    - name: msteams
    #      webhook_configs:
    #      - url: "http://prometheus-msteams:2000/alertmanager"

    #    # Opsgenie
    #    #############################
    #    - name: opsgenie
    #      opsgenie_configs:
    #      - api_key: ${alertmanager_opsgenie_key}
    #        # sla-none (no-ops) sla-low (dev/test) sla-high (prod/hlg)
    #        tags: ${cluster_name}, sla-${cluster_sla}

    #    # PagerDuty
    #    #############################
    #    - name: pager_duty
    #      pagerduty_configs:
    #      - service_key: ${alertmanager_pagerduty_key}
    #        send_resolved: true

        inhibit_rules:
        # Inhibit same alert with lower severity of an already firing alert
        - equal: ['alertname']
          source_match:
            severity: critical
          target_match:
            severity: warning

    grafana:
      service:
        type: ClusterIP
        sessionAffinity: ClientIP

      tolerations:
      - key: dedicated
        value: infra
        effect: NoSchedule
      - key: CriticalAddonsOnly
        effect: NoSchedule

      nodeSelector:
        role: infra

      deploymentStrategy:
        type: Recreate

      persistence:
        enabled: true
        accessModes: ["ReadWriteOnce"]
        size: 10Gi

      resources:
        limits:
          cpu: 1
          memory: 256Mi
        requests:
          cpu: 50m
          memory: 128Mi

      env:
        GF_EXPLORE_ENABLED: "true"

      plugins:
        - grafana-kubernetes-app
        - camptocamp-prometheus-alertmanager-datasource
        - grafana-clock-panel

      additionalDataSources:
        - name: Loki
          type: loki
          url: http://loki.logging.svc:3100
          basicAuth: false
          access: proxy
          isDefault: false
          jsonData:
            maxLines: 100000
        - name: prometheus
          type: prometheus
          url: http://monitoring-prometheus:9090/
          access: proxy
          isDefault: false
          editable: true

    #%{ if try(helm_releases.monitoring.grafana-extra-dashboards.enabled, false) }
    #  dashboardProviders:
    #    dashboardproviders.yaml:
    #      apiVersion: 1
    #      providers:
    #      - name: 'grafana-extra-dashboards'
    #        orgId: 1
    #        folder: ''
    #        type: file
    #        disableDeletion: true
    #        editable: true
    #        options:
    #          path: /var/lib/grafana/dashboards/grafana-extra-dashboards
    #
    #  dashboardsConfigMaps:
    #    grafana-extra-dashboards: grafana-extra-dashboards
    #%{ endif }

      adminUsername: admin
      #adminPassword: prom-operator

      grafana.ini:
        auth.anonymous:
          enabled: false
          org_name: Main Org.
          org_role: Admin
        auth:
          disable_login_form: false
          disable_signout_menu: false
        auth.basic:
          enabled: true
        # Admin user/pass comes from a secret
        #security:
        #  admin_user: admin
        #  admin_password: admin

      ingress:
        enabled: false
        annotations:
          kubernetes.io/ingress.class: nginx
          nginx.ingress.kubernetes.io/auth-realm: Authentication Required - Monitoring
          nginx.ingress.kubernetes.io/auth-secret: monitoring-basic-auth
          nginx.ingress.kubernetes.io/auth-type: basic
    #      cert-manager.io/cluster-issuer: letsencrypt-staging-http01
        hosts:
          - grafana.example.com
    #    tls:
    #    - hosts:
    #      - grafana.example.com
    #      secretName: grafana-ingress-tls

    kubeApiServer:
      enabled: false

    kubelet:
      serviceMonitor:
        https: true
        cAdvisor: true

    # TODO: habilitar o bind do kubeproxy no seu configmap
    # https://github.com/aws/containers-roadmap/issues/657
    kubeProxy:
      enabled: false

    nodeExporter:
      enabled: true

      resources:
        limits:
          cpu: 15m
          memory: 40Mi
        requests:
          cpu: 15m
          memory: 40Mi

    prometheus-node-exporter:
      #priorityClassName: high-priority

      # This only appends `processes` subsystem
      extraArgs:
      - --collector.filesystem.ignored-mount-points=^/(dev|proc|sys|var/lib/docker/.+)($|/)
      - --collector.filesystem.ignored-fs-types=^(autofs|binfmt_misc|cgroup|configfs|debugfs|devpts|devtmpfs|fusectl|hugetlbfs|mqueue|overlay|proc|procfs|pstore|rpc_pipefs|securityfs|sysfs|tracefs)$
      - --collector.processes

    kube-state-metrics:
      tolerations:
      - key: dedicated
        value: infra
        effect: NoSchedule

      nodeSelector:
        role: infra

      collectors:
        verticalpodautoscalers: false

    kubeScheduler:
      enabled: false

    kubeControllerManager:
      enabled: false

    kubeEtcd:
      enabled: false

    coreDns:
      enabled: true

    kubeDns:
      enabled: false