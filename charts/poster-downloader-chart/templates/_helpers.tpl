{{- define "posterdownloader.mongodb.fullname" -}}
{{- include "mongodb.fullname" .Subcharts.mongodb -}}
{{- end -}}

{{- define "posterdownloader.mongodb.service.nameOverride" -}}
{{- include "mongodb.service.nameOverride" .Subcharts.mongodb -}}
{{- end -}}

{{- define "posterdownloader.mongodb.hostList" -}}
{{- $replicaCount := int .Values.mongodb.replicaCount }}
{{- $fullName := include "posterdownloader.mongodb.fullname" . }}
{{- $serviceName := include "posterdownloader.mongodb.service.nameOverride" . }}
{{- $hostList := list -}}
{{- range $i := until $replicaCount }}
  {{- $host := printf "%s-%d.%s:27017" $fullName $i $serviceName -}}
  {{- $hostList = append $hostList $host -}}
{{- end }}
{{- join "," $hostList }}
{{- end -}}