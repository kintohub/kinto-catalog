{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "elasticsearch.name" -}}
cs-{{- .Values.kinto.alias}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "elasticsearch.fullname" -}}
cs-{{- .Values.kinto.alias}}
{{- end -}}

{{/*
Create a default fully qualified client name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "elasticsearch.client.fullname" -}}
{{ template "elasticsearch.fullname" . }}
{{- end -}}

{{/*
Create a default fully qualified data name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "elasticsearch.data.fullname" -}}
{{ template "elasticsearch.fullname" . }}-{{ .Values.data.name }}
{{- end -}}

{{/*
Create a default fully qualified master name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "elasticsearch.master.fullname" -}}
{{ template "elasticsearch.fullname" . }}-{{ .Values.master.name }}
{{- end -}}

{{/*
Create the name of the service account to use for the client component
*/}}
{{- define "elasticsearch.serviceAccountName.client" -}}
{{- if .Values.serviceAccounts.client.create -}}
    {{ default (include "elasticsearch.client.fullname" .) .Values.serviceAccounts.client.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.client.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use for the data component
*/}}
{{- define "elasticsearch.serviceAccountName.data" -}}
{{- if .Values.serviceAccounts.data.create -}}
    {{ default (include "elasticsearch.data.fullname" .) .Values.serviceAccounts.data.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.data.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the service account to use for the master component
*/}}
{{- define "elasticsearch.serviceAccountName.master" -}}
{{- if .Values.serviceAccounts.master.create -}}
    {{ default (include "elasticsearch.master.fullname" .) .Values.serviceAccounts.master.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccounts.master.name }}
{{- end -}}
{{- end -}}

{{/*
plugin installer template
*/}}
{{- define "plugin-installer" -}}
- name: es-plugin-install
  image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
  imagePullPolicy: {{ .Values.image.pullPolicy }}
  securityContext:
    capabilities:
      add:
        - IPC_LOCK
        - SYS_RESOURCE
  command:
    - "sh"
    - "-c"
    - |
      {{- range .Values.cluster.plugins }}
      /usr/share/elasticsearch/bin/elasticsearch-plugin install -b {{ . }}
      {{- end }}
  volumeMounts:
  - mountPath: /usr/share/elasticsearch/plugins/
    name: plugindir
  - mountPath: /usr/share/elasticsearch/config/elasticsearch.yml
    name: config
    subPath: elasticsearch.yml
{{- end -}}
