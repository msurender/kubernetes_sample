docker build -t msurender/multi-client-k8s:latest -t msurender/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t msurender/multi-server-k8s:latest -t msurender/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t msurender/multi-worker-k8s:latest -t msurender/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push msurender/multi-client-k8s:latest
docker push msurender/multi-server-k8s:latest
docker push msurender/multi-worker-k8s:latest

docker push msurender/multi-client-k8s:$SHA
docker push msurender/multi-server-k8s:$SHA
docker push msurender/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=msurender/multi-server-k8s:$SHA
kubectl set image deployments/client-deployment client=msurender/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=msurender/multi-worker-k8s:$SHA