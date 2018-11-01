{% from slspath + '/map.jinja' import consul with context %}

consul-useradd:
  user.present:
    - name: {{ consul.user }}
    - shell: /sbin/nologin
    - createhome: False
    - unless: id -u consul

consul-folders:
  file.directory:
    - names:
      - /opt/consul
      - /opt/consul/data
    - makedirs: True
    - user: {{ consul.user }}
    - group: {{ consul.group }}
    - recurse:
       - user
       - group

consul-download:
  file.managed:
    - name: /opt/consul/{{ consul.version }}_linux_{{ consul.arch }}.zip
    - source: https://{{ consul.download_host }}/consul/{{ consul.version }}/consul_{{ consul.version }}_linux_{{ consul.arch }}.zip
    - source_hash: sha256={{ consul.hash }}

consul-yum-unzip:
  pkg.installed:
    - name: unzip
    - require:
       - file: consul-download

consul-extract:
  archive.extracted:
    - name: /opt/consul
    - source: /opt/consul/{{ consul.version }}_linux_{{ consul.arch }}.zip
    - archive_format: zip
    - enforce_toplevel: False
    - user: {{ consul.user }}
    - group: {{ consul.group }}
    - require:
      - file: consul-download
      - pkg: consul-yum-unzip

consul-clean-tar:
  file.absent:
    - name: /opt/consul/{{ consul.version }}_linux_{{ consul.arch }}.zip
    - watch:
      - archive: consul-extract
      - file: consul-download
