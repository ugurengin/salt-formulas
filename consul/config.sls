{%- from slspath + '/map.jinja' import consul with context -%}

{% set secure = salt['vault'].read_secret('secret/saltstack/consul', 'encrypt') %}
{% do consul.config.client.update({'encrypt': secure })%}

{%- set nodename = salt['grains.get']('fqdn') -%}
{% do consul.config.client.update({'node_name': nodename })%}

{%- set ip4addr = salt['grains.get']('fqdn_ip4') -%}
{% do consul.config.client.update({'advertise_addr': ip4addr[0] })%}

{% if pillar['dc'] is defined %}
  {% do consul.config.client.update({'datacenter': pillar['dc'] })%}
{% else %}
  {% do consul.config.client.update({'datacenter': 'dc1' })%}
{% endif %}

{% if pillar['retryjoin'] is defined  %}
  {%- for ip in pillar['retryjoin'] -%}
    {%- do consul.config.client.retry_join.append(ip) -%}
  {%- endfor -%}
{% else %}
  {%- do consul.config.client.retry_join.append('') -%}
{% endif %}

consul-config-generate:
  file.serialize:
    - name: /opt/consul/config.json
    - formatter: json
    - dataset: {{ consul.config.client }}
    - user: {{ consul.user }}
    - group: {{ consul.group }}
    - mode: 0644
