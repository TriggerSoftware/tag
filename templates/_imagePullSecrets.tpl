{{- define "common.secretName" -}}
{{- if not (eq .Values.global.repotype "public") }}
{{- printf "%s-%s" .Values.global.imagePullSecrets.name .Values.global.repotype | trunc 63 | trimSuffix "-" -}}
{{- else }}
{{- printf "null" }}
{{- end }}
{{- end -}}

{{- define "common.imagePullSecrets" -}}
{{- if not (eq .Values.global.repotype "public") }}
imagePullSecrets:
  - name: {{ include "common.secretName" . | quote }}
{{- end -}}
{{- end -}}
