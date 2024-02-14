{{- define "posterdownloader.mongodb.fullname" -}}
{{- include "mongodb.fullname" .Subcharts.mongodb -}}
{{- end -}}

{{- define "posterdownloader.mongodb.service.nameOverride" -}}
{{- include "mongodb.service.nameOverride" .Subcharts.mongodb -}}
{{- end -}}

{{- define "posterdownloader.mongodb.uri" -}}
{{- $replicaCount := int .Values.mongodb.replicaCount }}
{{- $fullName := include "posterdownloader.mongodb.fullname" . }}
{{- $serviceName := include "posterdownloader.mongodb.service.nameOverride" . }}
{{- $uri := printf "mongodb://%s:%s@" .Values.mongodb.auth.rootUser .Values.mongodb.auth.rootPassword -}}
{{- range $i := until $replicaCount }}
  {{- if ne $i 0 }}{{- $uri = printf "%s," $uri -}}{{- end }}
  {{- $uri = printf "%s%s-%d.%s:27017" $uri $fullName $i $serviceName -}}
{{- end }}
{{- $uri = printf "%s/%s" $uri .Values.mongodb.auth.database -}}
{{ $uri }}
{{- end -}}