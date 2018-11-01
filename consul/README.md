### Usage

This consul formule is setupping a single consul node, and also integrating consul agents to the consul cluster. It is querying through to vault server to get "encrypt" key to put it in json file of client to communicate with cluster nodes. 

Eventually salt master need to be speak with vault within proper token, and following key should be create on vault which contain consul encryt key. 

**secret/saltstack/consul**

Basic consul setup.

```
# salt-call state.sls consul -ldebug
```

Setup consul agent with optional arguments to register target consul servers.

```
# salt-call state.sls consul pillar='{"retryjoin": ["<consul_ip1>", "<consul_ip2>", "<consul_ip3>"], "dc": "<dc_name>" }'
```

Check client status to check it was joined to the consul server.

```
# /opt/consul/consul members|grep $(hostname)
```
