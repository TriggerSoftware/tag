{{/*
Common labels
*/}}
{{- define "tag-license.labels" -}}
release: {{ .Release.Name | quote }}
application: {{ .Values.global.product | quote }}
{{- end }}

{{/*
Image url
*/}}
{{- define "tag-license.imageUrl" -}}
{{ .Values.global.imageRegistry }}/{{ .Values.global.repotype }}/{{ .Values.appName }}:{{ .Values.global.tag_license.tag | default .Chart.AppVersion }}
{{- end }}

{{- define "tag-license.annotations" -}}
{{- with .Values.global.tag_license.annotations }}
{{ toYaml . | trim | indent 4 }}
{{- end }}
{{- end }}
