{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "dev-env.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- $releaseName := regexReplaceAll "(-?[^a-z\\d\\-])+-?" (lower .Release.Name) "-" -}}
{{- if contains $name $releaseName -}}
{{- $releaseName | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" $releaseName $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "dev-env.labels" -}}
helm.sh/chart: dev-env
app.kubernetes.io/name: dev-env
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "dev-env.selector-labels" -}}
app.kubernetes.io/name: dev-env
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
