# templates/voice_app_values.yaml.tpl

webapp:
  image:
    repository: docker.io/abhikgho/text_to_speech_web_app
    tag: ${webapp_image_tag}
  replicaCount: ${webapp_replica_count}

worker:
  image:
    repository: docker.io/abhikgho/text_to_speech_web_app
    tag: ${worker_image_tag}
  replicaCount: ${worker_replica_count}

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
      size: 5Gi
      storageClass: standard
  auth:
    enabled: false
  replica:
    persistence:
      enabled: true
      storageClass: standard
    replicaCount: 2

persistence:
  uploads:
    enabled: true
    size: 5Gi
  output:
    enabled: true
    size: 5Gi
