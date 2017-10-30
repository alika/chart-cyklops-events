#!/usr/bin/env bash

export CHART_VER=${CHART_VER:-0.1.1}
export CHART_REL=${CHART_REL:-$(git rev-parse --short HEAD)}

envsubst < Chart.yaml.in > cyklops-events/Chart.yaml
