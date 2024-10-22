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
  annotations:
    kubernetes.io/ingress.class: gce
    kubernetes.io/ingress.global-static-ip-name: voice-app-ip

service:
  type: ClusterIP
  port: 5000

redis:
  enabled: true
  architecture: standalone
  auth:
    enabled: false
  master:
    persistence:
      enabled: true
      storageClass: standard
      size: ${redis_storage_size}
  replica:
    persistence:
      enabled: true
      storageClass: standard
      size: ${redis_storage_size}
    replicaCount: 2

persistence:
  enabled: true
  uploads:
    enabled: true
    storageClass: standard
    size: ${uploads_storage_size}
    accessModes:
      - ReadWriteOnce
  output:
    enabled: true
    storageClass: standard
    size: ${output_storage_size}
    accessModes:
      - ReadWriteOnce