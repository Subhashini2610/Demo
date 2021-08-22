# Sample-Service-With-Deployment
This space is created for a hands-on experience on SpringBoot app + Docker + Kubernetes, to understand how MicroServices are deployed

Agenda:
1. Create a sample Springboot application using Maven
2. Host the Dpringboot app on github
3. Create a docker image
4. Deploy the packaged file to Docker
5. Deploy onto Kubernetes

## Commands

**Create a Springboot application** using [Spring initilaizer](https://start.spring.io) with Spring Web as a dependency (so that TomCat can be automatically used to host on localhost).

mvn clean

mvn install

java -jar demo-0.0.3-SNAPSHOT.jar

**Maven deploy**:

Mvn deploy //to Azure feeds - if already existing, it will check for new changes and push only if new changes are present

Mvn release:prepare —batch-mode //creates a maven release and makes changes in pom.xml like tag and version increment

Mvn release perform// to push to azure feeds

**Create a docker image**:

docker build -t azdev -f Dockerfile . //azdev - name of docker image, f is for docker file path, context is directory structure sent from local system to docker daemon.

docker run -it -p 3000:9090 azdev //interactive terminal-it, 9090 is the port it runs on Docker container and map it to 3000 on my local machine. This still runs Docker images locally on my system. Push to https://hub.docker.com/u/subhashini9426

**Pushing to docker hub:**

docker login -u <username> -p <password>
  
docker tag azdev subhashini9426/firstimage //docker tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]
  
docker push subhashini9426/firstimage // docker push TARGET_IMAGE[:TAG]
  
**Pushing to Azure Container Registry using CLI:**
  
az login
  
az acr login -n azdev //azdev - name of azure container registry(acr)
  
docker tag azdev azdev.azurecr.io/azdev:1.0 //tag the existing docker image, command from azure, 1.0 is the tag; after this one can see it in acr repositories
  
mvn deploy
  
**AKS Deployment**

az account set --subscription <subscription name>
  
az aks get-credentials --resource-group azdev --name azdev

ACR_NAME=azdev
  
ACR_REGISTRY_ID=$(az acr show --name $ACR_NAME --query id --output tsv)
  
ad sp create-for-rbac --scopes $ACR_REGISTRY_ID --role acrpull
  
kubectl create secret docker-registry cred --namespace default --docker-server=azdev.azurecr.io --docker-username=<app id> --docker-password=<password> //username is appId, password is password

kubectl get secrets

kubectl apply -f k8s.yaml //creates a service

kubectl get svc // gives the public endpoints as EXTERNAL-IP


**Expose the deployed service to outside world (only if the type of service is LoadBalancer) using Minikube:**
  
minikube start
  
minikube dashboard
  
kubectl create -f k8s.yaml
  
Kubectl get services
  
minikube service azdev

## Author
[Subhashini](https://github.com/Subhashini2610)

## License
Swift Concepts is released under the terms of the MIT license. See [LICENSE](./LICENSE) for more information or see https://opensource.org/licenses/MIT.

## Development and Contributions
Development is ongoing; all volunteers are welcome to contribute in their branches and raising pull requests.
