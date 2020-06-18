docker build -t chloeseymour/multi-client:latest -t chloeseymour/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t chloeseymour/multi-server:latest -t chloeseymour/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t chloeseymour/multi-worker:latest -t chloeseymour/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push chloeseymour/multi-client:latest
docker push chloeseymour/multi-server:latest
docker push chloeseymour/multi-worker:latest

docker push chloeseymour/multi-client:$SHA
docker push chloeseymour/multi-server:$SHA
docker push chloeseymour/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=chloeseymour/multi-server:$SHA
kubectl set image deployments/client-deployment client=chloeseymour/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=chloeseymour/multi-worker:$SHA