### Usage

Basic consul setup.

```
# salt-call state.sls consul -ldebug
```

Setup consul agent with optional arguments to register target consul servers.

```
# salt-call state.sls consul pillar='{"retryjoin": ["<consul_ip1>","<consul_ip2>", "<consul_ip3>"], "dc": "<dc_name>" }'
```

Check the client status to check it was joined to the consul server.

```
# /opt/consul/consul members|grep $(hostname)
```
