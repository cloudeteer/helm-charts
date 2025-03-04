{{/*
Expand the name of the chart.
*/}}
{{- define "m365-exporter.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "m365-exporter.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "m365-exporter.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "m365-exporter.labels" -}}
{{ include "m365-exporter.selectorLabels" . }}
helm.sh/chart: {{ include "m365-exporter.chart" . }}
app.kubernetes.io/version: "{{ replace "+" "_" .Chart.Version }}"
app.kubernetes.io/part-of: {{ include "m365-exporter.name" . }}
release: {{ $.Release.Name | quote }}
heritage: {{ $.Release.Service | quote }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "m365-exporter.selectorLabels" -}}
app.kubernetes.io/name: {{ include "m365-exporter.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "m365-exporter.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "m365-exporter.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
