{{/*
Common labels
*/}}
{{- define "tag-front.labels" -}}
release: {{ .Release.Name | quote }}
application: {{ .Values.global.product | quote }}
{{- end }}

{{/*
Image url
*/}}
{{- define "tag-front.imageUrl" -}}
{{ .Values.global.imageRegistry }}/{{ .Values.global.repotype }}/{{ .Values.appName }}:{{ .Values.global.tag_front.tag | default .Chart.AppVersion }}
{{- end }}


{{- define "tag.tag_front.nginx.client_max_body_size" -}}
{{ printf "%dm" (div .Values.global.tag_front.maxFileSize 1048576) }}
{{- end }}