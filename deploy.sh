docker build -t jaderpereiralima/multi-client:latest -t jaderpereiralima/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t jaderpereiralima/multi-server:latest -t jaderpereiralima/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t jaderpereiralima/multi-worker:latest -t jaderpereiralima/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jaderpereiralima/multi-client:latest
docker push jaderpereiralima/multi-server:latest
docker push jaderpereiralima/multi-worker:latest

docker push jaderpereiralima/multi-client:$SHA
docker push jaderpereiralima/multi-server:$SHA
docker push jaderpereiralima/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jaderpereiralima/multi-server:$SHA
kubectl set image deployments/client-deployment client=jaderpereiralima/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jaderpereiralima/multi-worker:$SHA
