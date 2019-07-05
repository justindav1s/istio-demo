#Istio

##OCP Tech Preview

Docs here :

https://docs.openshift.com/container-platform/3.11/servicemesh-install/servicemesh-install.html

Use scripts in this folder 

##Most up-to-date version

Download from here :

https://github.com/istio/istio/releases

Go here :

istio-1.0.x/install/kubernetes/ansible

oc adm new-project istio-system --node-selector='capability=infra'

ansible-playbook main.yml -e '{"cluster_flavour": "ocp", "istio": {"auth": true, "addon": "kiali", "delete_resources": true} }'

KIali by default doesn't know where jaeger and Graphana are edit its config.yaml 

server:
  port: 20001
  web_root: /
external_services:
  jaeger:
    url: http://tracing-istio-system.apps.ocp.datr.eu
  grafana:
    url: http://grafana-istio-system.apps.ocp.datr.eu
identity:
  cert_file: /kiali-cert/tls.crt
  private_key_file: /kiali-cert/tls.key
  
and restart  


this is interesting

https://istio.io/help/faq/security/

ElasticSearch Resources

          resources:
            limits:
              cpu: 400m
              memory: 3Gi
            requests:
              cpu: 200m
              memory: 3Gi