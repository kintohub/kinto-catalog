# Catalog for KintoHub

## How to add them on KintoHub

1. Create **Custom Service** `Helm Chart` KintoBlock
2. Type the correct **Source Folder Path**
3. Build the `master` branch
4. Copy the environment variables from `values.kinto` to the **Default Settings** of the KintoBlock
4. Tag it
5. Mark the block as `Public` so that it appears in the catalog (might do a trick in DB at the beginning)

## How to add them on the repo

1. Create a `values.kinto` file with the variables that need to be exposed on kintoHub
2. Make the values as simple as possible (at least for the moment - people using KintoHub don't really know about helm)
3. Make resources mandatory
4. Add
```
alias: {{ .Values.kinto.alias }}
workspace: {{ .Values.kinto.workspace }}
blockName: {{ .Values.kinto.blockName }}
envId: {{ .Values.kinto.envId }}
```
to your deployment/statefulset so that the pods get these labels
5. Change the `fullName` in `_helpers.tpl` to be `cs-{{ .Values.kinto.alias }}`
6. Make sure the helm chart does not try to create forbidden resources (daemonset)
