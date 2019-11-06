# Java Function: cjoakim-function-java-1

## Generation

Simply use the Maven **mvn archetype:generate...** command, as in this script.
```
$ ./create-function.sh
```

This **generates a standard Maven project**, with a pom.xml file and the standard
Maven directory structure.

## Enhance the Generated Code

Added the following to pom.xml
```
        <dependency>
            <groupId>com.github.javafaker</groupId>
            <artifactId>javafaker</artifactId>
            <version>1.0.1</version>
        </dependency>
```

See the edited code in file:
**src/main/java/com/cjoakim/functions/java1/Function.java**

## Testing Locally

Again, simply use Maven to compile and execute the Function locally.
```
$ ./run-local-function.sh
```

Invoke the Function with curl in another terminal window:
```
$ curl http://localhost:7071/api/HttpTrigger-Java?type=address
01790 Edward Pike, Jeaneneside, Japan
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
$ curl "https://cjoakimfunctionjava1.azurewebsites.net/api/HttpTrigger-Java?code=ReR...==&type=address"
52082 Hodkiewicz Prairie, East Ervin, Canada
```

## Deploy with Azure DevOps

See the **azure-pipelines.yml** in at the root of the repo.

The DevOps pipeline code is co-resident with the Function code itself.
