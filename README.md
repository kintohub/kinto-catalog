# Catalog for KintoHub

## Steps to add a chart in the catalog

### New kintohub values

Add the following at the top of `values.yaml`.
This will allow you to test your chart manually.

```yaml
#kintohub
kinto:
  alias:
  workspace:
  envId:
  blockName:
  workspaceTier:
```

### Resources

Replace the `resources` part in `values.yaml`.
You can change the value of `memory` and `cpu`.
But it should always be `enabled`.

```yaml
resources:
  enabled: true
  memory: 256Mi
  cpu: 250m
```

Then change all the statefulset and deployment templates to use this new form.

```yaml
{{- if .Values.resources.enabled }}
    resources:
        requests:
        memory: {{ .Values.resources.memory }}
        cpu: {{ .Values.resources.cpu }}
        limits:
        memory: {{ .Values.resources.memory }}
        cpu: {{ .Values.resources.cpu }}
{{- end }}
```

### Labels

Add the following labels under `spec.template.metadata.labels` in all the statefulset and deployment templates.

```yaml
type: cs
alias: {{ .Values.kinto.alias }}
workspace: {{ .Values.kinto.workspace }}
blockName: {{ .Values.kinto.blockName }}
envId: {{ .Values.kinto.envId }}
```

### Helper

Modify the name and full name of the chart in `templates/_helpers.tpl`
Examples:

```tpl
{{- define "minio.name" -}}
cs-{{- .Values.kinto.alias}}
{{- end -}}

{{- define "minio.fullname" -}}
cs-{{- .Values.kinto.alias}}
{{- end -}}
```

### Notes

Modify `templates/NOTES.txt` if needed to only keep the minimum of information