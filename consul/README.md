### Usage

Basic consul setup.

```console
# salt-call state.sls consul -ldebug
```

Setup consul agent with optional arguments to register target consul servers.

```console
# salt-call state.sls consul pillar='{"retryjoin": ["<consul_ip1>","<consul_ip2>", "<consul_ip3>"], "dc": "<dc_name>" }'
```

Check the client status to check it was joined to the consul server.

```console
# /opt/consul/consul members|grep $(hostname)
```
