#!/bin/bash

# Bash script to create a Java Azure Function with the CLI and Maven.
# The generated Function is generated to a subdirectory, but copied
# to the current (Azure DevOps) directory.
# Chris Joakim, Microsoft, 2019/10/21

# Set these script variables per your specific configuration:
RG=cjoakim-functions-java
REGION=eastus
ORG=cjoakim
FNAME=java1
APP_NAME=$ORG"function"$FNAME
PKG="com."$ORG".functions."$FNAME
OUTDIR=$PKG".function"

# Display the script variables and their values:
echo 'RG:       '$RG
echo 'REGION:   '$REGION
echo 'ORG:      '$ORG
echo 'FNAME:    '$FNAME
echo 'APP_NAME: '$APP_NAME
echo 'PKG:      '$PKG
echo 'OUTDIR:   '$OUTDIR

# RG:       cjoakim-java-functions
# REGION:   eastus
# ORG:      cjoakim
# FNAME:    java1
# APP_NAME: cjoakimfunctionjava1
# PKG:      com.cjoakim.functions.java1
# OUTDIR:   com.cjoakim.functions.java1.function

rm -rf $OUTDIR

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

# Move the generated Function from the output subdirectory to the current directory.
cd $OUTDIR
jar cvf newfunction.jar .
cp newfunction.jar ..
cd ..
jar xvf newfunction.jar
rm -rf META-INF/
rm newfunction.jar
rm -rf $OUTDIR

echo 'done'
