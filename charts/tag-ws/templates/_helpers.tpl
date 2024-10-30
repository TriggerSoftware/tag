{{/*
Common labels
*/}}
{{- define "tag-ws.labels" -}}
release: {{ .Release.Name | quote }}
application: {{ .Values.global.product | quote }}
{{- end }}

{{/*
Image url
*/}}
{{- define "tag-ws.imageUrl" -}}
{{ .Values.global.imageRegistry }}/{{ .Values.global.repotype }}/{{ .Values.appName }}:{{ .Values.global.tag_ws.tag | default .Chart.AppVersion }}
{{- end }}

{{- define "tag-ws.annotations" -}}
{{- with .Values.global.tag_license.annotations }}
{{ toYaml . | trim | indent 4 }}
{{- end }}
{{- end }}
