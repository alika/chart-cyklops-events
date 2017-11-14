# Cyklops Events Chart

[Cyklops Events](https://github.com/samsung-cnct/cyklops-events) is a cluster alert relay service.

## Chart Details

This chart will do the following:

* create a docker config secret for private image repo access if enabled (`image.pullSecretEnabled=true`)
* create a secret for VictorOps credentials
* create a deployment of cyklops-events that listens on port 8000

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
$ build/build.sh
$ helm install --name my-release cyklops-events/
```

## Configuration

The following tables lists the configurable parameters of the Cyklops Events chart and their default values.

| Parameter                | Description                                     | Default                               |
| ------------------------ | ----------------------------------------------- | ------------------------------------- |
| `image.name      `       | FQDN repository/image name                      | `quay.io/samsung_cnct/cyklops-events` |
| `image.tag`              | Image tag                                       | `0.1.4`                               |
| `image.pullPolicy`       | Agent image name                                | `nil`                                 |
| `image.pullSecretEnabled`| Flag for image pull secrets                     | `false`                               |
| `image.registry`         | Image registry name                             | `nil`                                 |
| `image.username`         | Image registry username                         | `nil`                                 |
| `image.password`         | Image registry password                         | `nil`                                 |
| `victorops.accountID`    | VictorOps account ID                            | `20131114`                            |
| `victorops.apiKey`       |                                                 | `<victorops-api-key>`                 |

## Continuous Deployment

This project uses [GitLab](.gitlab-ci.yml) to continously integrate and deploy the [`cyklops-events-chart` application](https://quay.io/application/samsung_cnct/cyklops-events-chart) with the following [GitLab pipelines](https://git.cnct.io/help/ci/pipelines.md):

1. Latest Master
  - Only triggers on commits to master
  - Will publish to the **beta** application release channel
  - Stages
     - build
     - test
     - publish-beta

2. Version Tag
  - Only triggers on well formed tags
  - Will publish to the **prod** application release channel
  - Will deploy to a staging environment.
  - Stages
     - build
     - test
     - publish-prod
     - deploy-staging

### GitLab Configuration

The following project level [GitLab secret variables](https://git.cnct.io/help/ci/variables/README.md#secret-variables) 
are required:

  - `REGISTRY_USERNAME`: The application registry user. (appropriate quay.io robot account)
  - `REGISTRY_PASSWORD`: The associated registry password. (corresponding quay.io robot token)
  - `TEST_KUBECONFIG`: A kubernetes config to a test environment. (See [notes](#deployment-provisioning))
  - `STAGING_KUBECONFIG`: A kubernetes config to a staging environment. (See [notes](#deployment-provisioning))
  - `STAGING_VICTOROPS_API_KEY`: An environment and app specific config for integration between victorops and cyklops-events.

### Deployment Provisioning

This project deploys to various Kubernetes cluster environments. Each environment currently requires
an `<ENVIRONMENT>_KUBECONIG` secret variable at the GitLab project level. This variable contains a
base64 encoded Kubernetes config that should specify a single cluster. This can be done with the
following command:

```
#encode config into base64
cat ~/.kube/config | base64
```
