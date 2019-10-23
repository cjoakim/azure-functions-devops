#!/bin/bash

# Bash script to execute the Azure Functions Runtime locally, with your Function.
# Chris Joakim, Microsoft, 2019/10/21

# The Functions runtime requires Java 8.  I have both Java 11 and Java 8 on my system.
# https://www.azul.com
export JAVA_HOME=/System/Volumes/Data/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home

java -version
# openjdk version "1.8.0_232"
# OpenJDK Runtime Environment (Zulu 8.42.0.21-CA-macosx) (build 1.8.0_232-b18)
# OpenJDK 64-Bit Server VM (Zulu 8.42.0.21-CA-macosx) (build 25.232-b18, mixed mode)

mvn clean package

mvn azure-functions:run

# $ curl http://localhost:7071/api/HttpTrigger-Java?type=address
# 01790 Edward Pike, Jeaneneside, Japan
