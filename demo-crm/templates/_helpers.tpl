{{- define "posterdomloader.mongodb.fullname" -}}
{{- include "mongodb.fullname" .Subcharts.mongodb -}}
{{- end -}}

{{- define "posterdomloader.mongodb.service.nameOverride" -}}
{{- include "mongodb.service.nameOverride" .Subcharts.mongodb -}}
{{- end -}}

# mongodb-uri.yaml

{{- define "posterdomloader.mongodb.uri" -}}
{{- $replicaCount := int .Values.mongodb.replicaCount }}
{{- $fullName := include "posterdomloader.mongodb.fullname" . }}
{{- $serviceName := include "posterdomloader.mongodb.service.nameOverride" . }}
{{- $uri := printf "mongodb://%s:%s@" .Values.mongodb.auth.rootUser .Values.mongodb.auth.rootPassword -}}
{{- range $i := until $replicaCount }}
  {{- if ne $i 0 }}{{- $uri = printf "%s," $uri -}}{{- end }}
  {{- $uri = printf "%s%s-%d.%s:27017" $uri $fullName $i $serviceName -}}
{{- end }}
{{- $uri = printf "%s/%s" $uri .Values.mongodb.auth.database -}}
{{ $uri }}
{{- end -}}