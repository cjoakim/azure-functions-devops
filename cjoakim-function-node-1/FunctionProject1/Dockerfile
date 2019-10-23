FROM mcr.microsoft.com/azure-functions/node:2.0

ENV AzureWebJobsScriptRoot=/home/site/wwwroot \
    AzureFunctionsJobHost__Logging__Console__IsEnabled=true

COPY . /home/site/wwwroot

RUN cd /home/site/wwwroot && npm install

# Build and run locally:
# docker build -t cjoakim/azurefunctionproject1 .
# docker image ls | grep azurefunctionproject1
# docker run -p 8080:80 -it cjoakim/azurefunctionproject1:latest

# Tag and push the container to Azure Container Registry (ACR):
# az acr login --name cjoakimacr
# docker tag cjoakim/azurefunctionproject1:latest cjoakimacr.azurecr.io/azurefunctionproject1:latest
# docker push cjoakimacr.azurecr.io/azurefunctionproject1:latest
# az acr repository list --name cjoakimacr --output table
# Result
# ---------------------
# azurefunctionproject1
# ...
