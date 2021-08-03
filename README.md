# Sample-Service-With-Deployment-
This space is created for a hands-on experience on SpringBoot app + Docker + Kubernetes, to understand how MicroServices are deployed

Agenda:
1. Create a sample Springboot application using Maven
2. Host the Dpringboot app on github
3. Create a docker image
4. Deploy the packaged file to Docker
5. Deploy onto Kubernetes

## Commands

Create a Springboot application using [Spring initilaizer](https://start.spring.io) with Spring Web as a dependency (so that TomCat can be automatically used to host on localhost).

mvn clean
mvn install
java -jar demo-0.0.3-SNAPSHOT.jar

Maven deploy:
Mvn deploy //to Azure feeds - if already existing, it will check for new changes and push only if new changes are present
Mvn release:prepare —batch-mode //creates a maven release and makes changes in pom.xml like tag and version increment
Mvn release perform// to push to azure feeds

Create a docker image:
docker build -t azdev -f Dockerfile . //azdev - name of docker image, f is for docker file path, context is directory structure sent from local system to docker daemon.
docker run -it -p 3000:9090 azdev //interactive terminal-it, 9090 is the port it runs on Docker container and map it to 3000 on my local machine. This still runs Docker images locally on my system. Push to https://hub.docker.com/u/subhashini9426

Pushing to docker registry:
Docker login -u <username> -p <password>
Docker tag azdev subhashini9426/firstimage //docker tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]
Docker push subhashini9426/firstimage // docker push TARGET_IMAGE[:TAG]

Expose the deployed service to outside world (only if the type of service is LoadBalancer) using Minikube:
Minikube start
Minikube dashboard
kubectl create -f k8s.yaml
Kubectl get services
Minikube service azdev

## Author
[Subhashini](https://github.com/Subhashini2610)

## License
Swift Concepts is released under the terms of the MIT license. See [LICENSE](./LICENSE) for more information or see https://opensource.org/licenses/MIT.

## Development and Contributions
Development is ongoing; all volunteers are welcome to contribute in their branches and raising pull requests.
