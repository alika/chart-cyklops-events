
# Prerequisites

- To deploy this chart successfully you'll need to create a docker-regsitry secret in the target kubernetes 
  namespace.

```shell
kubectl create namespace $TARGET_NAMESPACE

kubectl create secret docker-registry $DOCKER_SECRET_NAME --docker-server=$DOCKER_SERVER --docker-username=$DOCKER_USERNAME --docker-password=$DOCKER_PASSWORD_OR_TOKEN --docker-email=$DOCKER_EMAIL -n $TARGET_NAMESPACE
```
