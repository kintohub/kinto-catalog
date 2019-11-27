set -e

WORKSPACE_ID="3640a6a2-3ffe-467d-8d3b-1504e4296a97"
D_REGISTRY="asia.gcr.io/linear-bounty-174410"
BASE_IMAGE="kintodeploycustomservice-0948d792-3e89-4208-a121-8ad5b0718ba1"
BASE_TAG="2.0.0"

build() {
  SERVICE=$1
  BUILD_ID=$2

  echo "Generating {$SERVICE}"

  echo "FROM ${D_REGISTRY}/${BASE_IMAGE}:${BASE_TAG}" > Dockerfile
  echo "COPY catalog/${SERVICE}-${BUILD_ID} /chart" >> Dockerfile

  TAG=${D_REGISTRY}/${SERVICE}-${WORKSPACE_ID}:${BUILD_ID}

  docker build -t $TAG .

  echo "Pushing to Registry..."

  docker push $TAG

  echo "Done..."
  echo
}

build cassandra 551a99ba-68f5-44bf-8989-1cae831a52f4
build elasticsearch f6e9aa74-d41e-4191-9e22-d9047a81aa13
build influx-real a63e6579-af22-4640-a845-c95458ebbd5e
build mariadb 0f4bbf74-c5b4-47da-bb29-1b29de33765c
build minio cc9b5f21-8382-4e98-a98c-12e50bc60dd8
build mongodb replicaset-ba171298-8d5a-4d98-943f-b4cacd19b757
build mysql 4926f99a-6ccb-4918-b89d-c3aa001fac81
build nats fd9c0c29-7b73-4cb9-af26-cd47d163a2eb
build patroni 9eac3f3f-ec7c-41ae-82d8-b6783ef69352
build rabbitmq 09597d1d-6243-4dad-92a1-4b30a2dea4b5
build redisha bf325345-47b0-453e-9764-d52e076fcb32
build selenium eb3d2992-0c57-4a19-9db8-b372044e1005
build wordpress cd38dec9-948e-411a-8dfd-d548b348c9a9

rm Dockerfile
