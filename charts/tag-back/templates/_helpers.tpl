{{/*
Common labels
*/}}
{{- define "tag-back.labels" -}}
release: {{ .Release.Name | quote }}
application: {{ .Values.global.product | quote }}
{{- end }}

{{/*
Image url
*/}}
{{- define "tag-back.imageUrl" -}}
{{ .Values.global.imageRegistry }}/{{ .Values.global.repotype }}/{{ .Values.appName }}:{{ .Values.global.tag_back.tag | default .Chart.AppVersion }}
{{- end }}

{{- define "tag-back.annotations" -}}
{{- with .Values.global.tag_back.annotations }}
{{ toYaml . | trim | indent 4 }}
{{- end }}
{{- end }}
