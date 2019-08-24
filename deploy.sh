docker build -t pradsi/multi-client:latest -t pradsi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pradsi/multi-server:latest -t pradsi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pradsi/multi-worker:latest -t pradsi/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push pradsi/multi-client:latest
docker push pradsi/multi-server:latest
docker push pradsi/multi-worker:latest

docker push pradsi/multi-client:$SHA
docker push pradsi/multi-server:$SHA
docker push pradsi/multi-worker:$SHA
kubectl apply -f k8s

kubectl set image deployment/server-deployment server=pradsi/multi-server:$SHA
kubectl set image deployment/client-deployment client=pradsi/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=pradsi/multi-worker:$SHA