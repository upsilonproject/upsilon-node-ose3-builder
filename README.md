# upsilon-node-ose3-el7

This repository makes it easy to spin up the latest upsilon-node el7 release in
an OSE3 container via the S2I process.

## OSE3 Setup

Node: You need to create the app using the command line because the interface (@3.1) doesn't allow you to create a builder from a source repository, which is what we need to do. 

1. Create a project with any name you like, which will contain your app. 

```
oc new-project upsilon-node
```

2. Create the new app using the Git URL of this repository. You should to specify the deployment configuration environemnt variables here or the first deployment will fail. If you don't though, you could always edit the environment variables later in the deployment config. 

```
oc new-app https://github.com/upsilonproject/upsilon-node-ose3-el7.git -e UPSILON_IDENTIFIER=testing-node -e UPSILON_CONFIG_SYSTEM_AMQPHOST=amqp1.example.com
```

This creates a new imageStream, BuildConfig and DeploymentConfig. It will spawn a new build in the background. 

3. After a minute or two, you should see the `-build` pod has completed, and a deployed pod;

```
user@host: oc get pods
NAME                            READY     STATUS      RESTARTS   AGE
upsilon-node-ose3-el7-1-build   0/1       Completed   0          6m
upsilon-node-ose3-el7-1-p6ut2   1/1       Running     0          5m
```

4. You can view the logs as normal; 

```
user@host: oc logs upsilon-node-ose3-el7-1-p6ut2
DEBUG Logging override configuration exists, parsing: /etc/upsilon-node/logging.xml
INFO  Upsilon 2.1.0-1458766566
INFO  ----------
INFO  Identifier: testing-node
INFO  Setting AMQPHost from ENV: amqp1.example.com
...
```

After the node has sent it's first heartbeat which is inserted into the database, the node can be configured from upsilon-web. 

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
