# Java Function: cjoakim-function-java-1

This repository is the **private** Azure DevOps repo.

A **public** version of this repo is here: https://github.com/cjoakim/azure-functions-devops

Other DevOps & Docker GitHub repos of interest:
- https://github.com/cjoakim/azure-devops-node-web-1g  (diagram)
- https://github.com/cjoakim/azure-springboot-devops


## Generation

Simply use the Maven **mvn archetype:generate...** command, as in this script.
```
$ ./create-function.sh
```

This **generates a standard Maven project**, with a pom.xml file and the standard
Maven directory structure.

This script essentially runs the following:
```
mvn archetype:generate \
    -DarchetypeGroupId=com.microsoft.azure \
    -DarchetypeArtifactId=azure-functions-archetype \
    -DappName=$APP_NAME \
    -DappRegion=$REGION \
    -DresourceGroup=$RG \
    -DgroupId=com.$PKG.group \
    -DartifactId=$PKG.function \
    -Dpackage=$PKG
    -DinteractiveMode=false
```

## Enhance the Generated Code

Added the following to **pom.xml** - the **javafaker** and **jackson json** libraries.
```
        <dependency>
            <groupId>com.github.javafaker</groupId>
            <artifactId>javafaker</artifactId>
            <version>1.0.1</version>
        </dependency>

        <dependency>
            <groupId>com.fasterxml.jackson.core</groupId>
            <artifactId>jackson-core</artifactId>
            <version>2.9.10</version>
        </dependency>
        <dependency>
            <groupId>com.fasterxml.jackson.core</groupId>
            <artifactId>jackson-annotations</artifactId>
            <version>2.9.10</version>
        </dependency>
        <dependency>
            <groupId>com.fasterxml.jackson.core</groupId>
            <artifactId>jackson-databind</artifactId>
            <version>2.9.10.1</version>
        </dependency>
```

See the edited code in file:
**src/main/java/com/cjoakim/functions/java1/Function.java**

## Testing Locally

Again, simply use Maven to compile and execute the Function locally.
```
$ ./run-local-function.sh
```

This script essentially runs the following:
```
mvn clean package
mvn azure-functions:run
```

Invoke the Function with curl in another terminal window:
```
$ curl "http://localhost:7071/api/HttpTrigger-Java?type=address" | jq
{
  "result": "12140 Jacquline Glen, Haagville, Honduras",
  "type": "address",
  "version": "2019/11/08 11:03 EST"
}
```

## Deploy to Azure 

```
$ mvn azure-functions:deploy

[INFO] Scanning for projects...
[INFO]
[INFO] --< com.com.cjoakim.functions.java1.group:com.cjoakim.functions.java1.function >--
[INFO] Building Azure Java Functions 1.0-SNAPSHOT
[INFO] --------------------------------[ jar ]---------------------------------
[INFO]
[INFO] --- azure-functions-maven-plugin:1.3.4:deploy (default-cli) @ com.cjoakim.functions.java1.function ---
[WARNING] Azure Functions only support JDK 8, which is lower than local JDK version 11.0.4
[INFO] Authenticate with Azure CLI 2.0
[INFO] The specified function app does not exist. Creating a new function app...
[INFO] Set function worker runtime to java
[INFO] Successfully created the function app: cjoakimfunctionjava1
[INFO] Trying to deploy the function app...
[INFO] Trying to deploy artifact to cjoakimfunctionjava1...
[INFO] Successfully deployed the artifact to https://cjoakimfunctionjava1.azurewebsites.net
[INFO] Successfully deployed the function app at https://cjoakimfunctionjava1.azurewebsites.net
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  01:28 min
[INFO] Finished at: 2019-10-21T16:51:32-04:00
[INFO] ------------------------------------------------------------------------
```

Invoke the deployed Function with curl:
```
curl "https://cjoakimfunctionjava1.azurewebsites.net/api/HttpTrigger-Java?code=ReR...==&type=address" | jq

{
  "result": "189 Jose Mission, Port Shannan, Lebanon",
  "type": "address",
  "version": "2019/11/08 11:03 EST"
}
```

## Deploy with Azure DevOps

See the **azure-pipelines.yml** in at the root of the repo.

The DevOps pipeline code is co-resident with the Function code itself.
