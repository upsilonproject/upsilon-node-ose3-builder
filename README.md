# upsilon-node-ose3-el7

This repository makes it easy to spin up the latest upsilon-node el7 release in
an OSE3 container via the S2I process.

## OSE3 Setup

```
	oc new-app https://github.com/upsilonproject/upsilon-node-ose3-el7.git
```

## Configuration

When running upsilon-node inside a container, it makes sense to do all the 
configuration remotely via upsilon-web, therefore a blank config.xml is shipped.

Editing the config file should not be necessary, and instead you can do a 
bootstrap configuration via environment variables

### Environment Variables

- `UPSILON_IDENTIFIER` - The identifier used to name this node within the
upsilon-web interface and network. eg: `ose3-testing-cluster-node`

- `UPSILON_CONFIG_SYSTEM_AMQPHOST` - The hostname of the AMQP host to connect to.
eg: amqp1.example.com. upsilon-node will create its own queues and the `ex_usilon` 
exchange if necessary.

#### Example of Environment Variables in OSE3 deployment configuration

```
      spec:
	    containers:
		  ...
          env:
            -
              name: UPSILON_CONFIG_SYSTEM_AMQPHOST
              value: amqp1.example.com
            -
              name: UPSILON_IDENTIFIER
              value: ose3-testing-cluster-node
```
