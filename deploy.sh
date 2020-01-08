docker build -t mvi1/multi-client:latest -t mvi1/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mvi1/multi-server:latest -t mvi1/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mvi1/multi-worker:latest -t mvi1/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mvi1/multi-client:latest
docker push mvi1/multi-server:latest
docker push mvi1/multi-worker:latest

docker push mvi1/multi-client:$SHA
docker push mvi1/multi-server:$SHA
docker push mvi1/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=mvi1/multi-server:$SHA
kubectl set image deployments/client-deployment client=mvi1/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mvi1/multi-worker:$SHA