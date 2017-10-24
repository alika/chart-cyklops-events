# Cyklops Events Chart

[Cyklops Events](https://github.com/samsung-cnct/cyklops-events) is a cluster alert relay service.

## Chart Details

This chart will do the following:

* create a docker config secret for private image repo access
* create a secret for VictorOps credentials
* create a deployment of cyklops-events that listens on port 8000

## Installing the Chart (#TODO) 

To install the chart with the release name `my-release`:

```bash
$ export CHART_REL=$(git rev-parse --short HEAD)
$ export CHART_VER=0.1.1
$ envsubst < Chart.yaml.in > cyklops-events/Chart.yaml
$ helm install --name my-release cyklops-events/
```

## Configuration

The following tables lists the configurable parameters of the Cyklops Events chart and their default values.

| Parameter               | Description                                     | Default                               |
| ----------------------- | ----------------------------------------------- | ------------------------------------- |
| `image.repository`      | FQDN repository/image name                      | `quay.io/samsung_cnct/cyklops-events` |
| `image.tag`             | Image tag                                       | `0.1.1`                               |
| `image.pullPolicy`      | Agent image name                                | `nil`                                 |
| `registry.dockerConfig` | Base64 encoded docker config for private repo   | ``                                    |
| `victorops.accountID`   | VictorOps account ID                            | `20131114`                            |
| `victorops.apiKey`      |                                                 | `<victorops-api-key>`                 |

## CI/CD Pipeline 

The build, test, publish, and deploy pipeline for this chart looks like this:

    build-branch ===>|             |===> publish-alpha ===>|
                     |===> test ===|                       |===> deploy-staging ===> deploy-production
    build-tag ======>|             |===> publish-stable ==>|

Note: This project makes use of GitLab secret variables to contain credentials needed for CI jobs.
