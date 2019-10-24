# Azure Functions - Local Workstation Setup

## Setup

It is assumed that you have **Node.js**, **Java 8**, and the **Azure CLI** (Command Line Interface) installed.
Then install the **Azure Function runtime**, and login to Azure with the CLI.

[Install the Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)

```
$ npm -g install azure-functions-core-tools
$ az login
```

List the Azure Regions available for your subscription.  You'll use one of the
region names to provision your Azure Function App:
```
$ az account list-locations | grep name | grep us | cut -c13-99
"centralus",
"eastus",
"eastus2",
"westus",
"northcentralus",
"southcentralus",
"westcentralus",
"westus2",
```
