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
| `image.pullSecretEnabled | Flag for image pull secrets                     | `false`                               |
| `image.registry          | Image registry name                             | `nil`                                 |
| `image.username          | Image registry username                         | `nil`                                 |
| `image.password          | Image registry password                         | `nil`                                 |
| `victorops.accountID`    | VictorOps account ID                            | `20131114`                            |
| `victorops.apiKey`       |                                                 | `<victorops-api-key>`                 |

## CI/CD Pipeline 

The build, test, publish, and deploy [pipeline for this chart](.gitlab-ci.yml) has the following overall flow:

    build ===> test ===|===> publish-beta ====>|===> deploy-staging
                       |                       |
                       |===> publish-prod  ===>|

- **beta**: The beta channel is for tested release candidates. Suitiable for internal consumption.
- **prod**: The prod channel is for tested and vetted releases. Suitiable for external production consumption

### Required CI Settings

- Secret Variables
  - `REGISTRY_USERNAME`: required fer to publish to registry
  - `REGISTRY_PASSWORD`: required for to publish to registry
  - `TEST_KUBECONFIG`: required to test a deployment of chart This is a base-64 encode kubeconfig.
  - `STAGING_KUBECONFIG`: required to deploy to staging environment. This is a base-64 encoded kubeconfig.
  - `STAGING_VICTOROPS_API_KEY`: required for integration between victorops and cyklops-events staging instance.
