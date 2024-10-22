# templates/voice_app_values.yaml.tpl

webapp:
  image:
    repository: docker.io/abhikgho/text_to_speech_web_app
    tag: ${webapp_image_tag}
  replicaCount: ${webapp_replica_count}
  resources:
    requests:
      memory: "256Mi"
      cpu: "100m"
    limits:
      memory: "512Mi"
      cpu: "200m"

worker:
  image:
    repository: docker.io/abhikgho/text_to_speech_web_app
    tag: ${worker_image_tag}
  replicaCount: ${worker_replica_count}
  resources:
    requests:
      memory: "256Mi"
      cpu: "100m"
    limits:
      memory: "512Mi"
      cpu: "200m"

ingress:
  enabled: ${ingress_enabled}
  host: ${ingress_host}

service:
  type: ClusterIP
  port: 5000

redis:
  enabled: true
  master:
    persistence:
      enabled: true
      storageClass: standard
      size: 5Gi
  auth:
    enabled: false
  replica:
    persistence:
      enabled: true
      storageClass: standard
      size: 5Gi
    replicaCount: 2

persistence:
  enabled: true
  storageClass: standard
  uploads:
    enabled: true
    size: 5Gi
  output:
    enabled: true
    size: 5Gi