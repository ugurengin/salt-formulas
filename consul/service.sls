{% from slspath + '/map.jinja' import consul with context %}

consul-service-sync:
 file.managed:
   - name: /etc/systemd/system/consul.service
   - source: salt://consul/files/consul.service
   - template: jinja
   - defaults:
       consul_user: {{ consul.user }}
 module.wait:
   - name: service.systemctl_reload
   - watch:
     - file: consul-service-sync

consul-template-service-start:
  service.running:
   - name: consul
   - enable: True
   - require:
     - file: consul-service-sync
