# Azure Functions - Node.js, Containers, and DevOps

## Links

- https://docs.microsoft.com/en-us/azure/azure-functions/functions-create-function-linux-custom-image?tabs=nodejs
- https://hub.docker.com/_/microsoft-azure-functions-node

---

## Create a DevOps Project for your Function

### DevOps - Create Project 

Create a new DevOps project for your JavaScript (Node.js) Function similarly as with
the [Java Function](java-function.md) in this repo.  DevOps project is named 
**cjoakim-function-node-1**.

Clone the repo to your workstation:
```
$ git clone git@ssh.dev.azure.com:v3/chjoakim/cjoakim-function-node-1/cjoakim-function-node-1
Cloning into 'cjoakim-function-node-1'...
warning: You appear to have cloned an empty repository.
```

---

## Create a Resource Group for your Function App

Create a resource group for your Java Functions; for example 'cjoakim-functions-java'.
The Azure CLI can be used to do this as follows:
```
$ az account list-locations

$ az group create -l eastus -n cjoakim-functions-node
```

---

## Create the Node.js Function With azure-functions-core-tools

Change to the root directory of your new DevOps project git repo.
```
$ cd cjoakim-function-node-1
```

Then use the **func** program from the **azure-functions-core-tools** to generate
the initial code and files for a JavaScript HttpTrigger Function.
```
$ func new
Select a language:
1. C#
2. JavaScript
3. PowerShell
4. TypeScript
Choose option: 2

Starting from 2.0.1-beta.26 it's required to set a language for your project in your settings
'node' has been set in your local.settings.json

Select a template:
1. Azure Blob Storage trigger
2. Azure Cosmos DB trigger
3. Durable Functions activity
4. Durable Functions HTTP starter
5. Durable Functions orchestrator
6. Azure Event Grid trigger
7. Azure Event Hub trigger
8. HTTP trigger
9. IoT Hub (Event Hub)
10. Azure Queue Storage trigger
11. SendGrid
12. Azure Service Bus Queue trigger
13. Azure Service Bus Topic trigger
14. Timer trigger
Choose option: 8

HTTP trigger
Function name: [HttpTrigger]
Writing /Users/cjoakim/github/cjoakim-function-node-1/HttpTrigger/index.js
Writing /Users/cjoakim/github/cjoakim-function-node-1/HttpTrigger/function.json
The function "HttpTrigger" was created successfully from the "HTTP trigger" template.
```

## Testing Locally

In the same directory, the root of the DevOps project git repo, execute
the following to start the Node.js Azure Function runtime.
```
$ func start

...
Now listening on: http://0.0.0.0:7071
Application started. Press Ctrl+C to shut down.

Http Functions:
	HttpTrigger: [GET,POST] http://localhost:7071/api/HttpTrigger
...
```

With your browser, visit URL **http://localhost:7071** and see that your Function App
is running:

![node-func-app-started](img/node-func-app-started-localhost.png)

Invoke the generated HttpTrigger with curl:
```
$ curl "http://localhost:7071/api/HttpTrigger?name=Miles"
Hello Miles
```
