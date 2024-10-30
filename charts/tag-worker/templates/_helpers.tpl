{{/*
Common labels
*/}}
{{- define "tag-worker.labels" -}}
release: {{ .Release.Name | quote }}
application: {{ .Values.global.product | quote }}
{{- end }}

{{/*
Image url
*/}}
{{- define "tag-worker.imageUrl" -}}
{{ .Values.global.imageRegistry }}/{{ .Values.global.repotype }}/{{ .Values.appName }}:{{ .Values.global.tag_worker.tag | default .Chart.AppVersion }}
{{- end }}

{{- define "tag-worker.annotations" -}}
{{- with .Values.global.tag_worker.annotations }}
{{ toYaml . | trim | indent 4 }}
{{- end }}
{{- end }}
