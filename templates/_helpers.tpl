{{/*
Expand the name of the chart.
*/}}
{{- define "tag.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "tag.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "common.ServiceMonitor.metadata.labes" -}}
tag.observability/scrape: "true"
{{- end -}}

{{- define "tag_front.ingressAnnotations" -}}
{{ if .Values.global.ingress.annotations -}}
{{ toYaml .Values.global.ingress.annotations }}
{{ end -}}
nginx.ingress.kubernetes.io/ssl-redirect: "true"
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "tag.selectorLabels" -}}
app.kubernetes.io/name: {{ include "tag.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "tag.labels" -}}
{{ include "tag.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
{{- end }}

{{- define "tag.redisSecretName" -}}
{{- $tag_secret_redis := "" }}
{{- if .Values.global.redis }}
{{- $tag_secret_redis = .Values.global.redis.secret }}
{{- else }}
{{- $tag_secret_redis = nil }}
{{- end }}
{{- printf "%s-%s" .Release.Name $tag_secret_redis.name | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{- define "tag.postgresSecretName" -}}
{{- $tag_secret_db := "" }}
{{- if .Values.global.db }}
{{- $tag_secret_db = .Values.global.db.secret }}
{{- else }}
{{- $tag_secret_db = nil }}
{{- end }}
{{- printf "%s-%s" .Release.Name $tag_secret_db.name | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{- define "tag.timescaleSecretName" -}}
{{- $tag_secret_timescale := "" }}
{{- if .Values.global.timescale }}
{{- $tag_secret_timescale = .Values.global.timescale.secret }}
{{- else }}
{{- $tag_secret_timescale = nil }}
{{- end }}
{{- printf "%s-%s" .Release.Name $tag_secret_timescale.name | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end -}}

{{/*
Create block for init-wait containers
*/}}
{{- define "InitWait.postgres" -}}
- name: init-wait-postgresql
  image: "{{ .Values.global.imageInit.repository }}:{{ .Values.global.imageInit.tag }}"
  imagePullPolicy: IfNotPresent
  command: ["sh", "-c", "until nc -zw1 {{ .Values.global.db.secret.data.dbhost }} {{ .Values.global.db.secret.data.dbport }}; do echo waiting for PostgeSQL; sleep 2; done;"]
  terminationMessagePath: /dev/termination-log
  terminationMessagePolicy: File
{{- end }}

{{- define "InitWait.redis" -}}
- name: init-wait-redis
  image: "{{ .Values.global.imageInit.repository }}:{{ .Values.global.imageInit.tag }}"
  imagePullPolicy: IfNotPresent
  command: ["sh", "-c", "until nc -zw1 {{ .Values.global.redis.secret.data.host }} {{ .Values.global.redis.secret.data.port }}; do echo waiting for Redis; sleep 2; done;"]
  terminationMessagePath: /dev/termination-log
  terminationMessagePolicy: File
{{- end }}

{{- define "tag.ingressAnnotations" -}}
{{ if .Values.global.ingress.annotations -}}
{{ toYaml .Values.global.ingress.annotations }}
{{ end -}}
{{- if .Values.global.ingress.tls }}
cert-manager.io/cluster-issuer: letsencrypt
{{- end }}
nginx.ingress.kubernetes.io/ssl-redirect: "true"
{{- end }}

{{- define "tag.nginx.add_header" -}}
      # security headers
      add_header X-XSS-Protection "1; mode=block" always;
      add_header X-Content-Type-Options "nosniff" always;
      add_header X-Frame-Options "SAMEORIGIN" always;
      add_header Strict-Transport-Security "max-age=31536000; includeSubDomains; preload" always;
      add_header Referrer-Policy "no-referrer-when-downgrade" always;
      add_header Permissions-Policy "geolocation=(), camera=()";
{{- end }}
