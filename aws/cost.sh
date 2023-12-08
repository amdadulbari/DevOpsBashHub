#!/bin/bash

# Set required variables
START_DATE=$(date -d "-30 days" +%Y-%m-%d)
END_DATE=$(date +%Y-%m-%d)

# Fetch cost and usage report in JSON format
aws ce get-cost-and-usage \
    --time-period Start=$START_DATE,End=$END_DATE \
    --granularity MONTHLY \
    --metrics "BlendedCost" "UnblendedCost" "UsageQuantity" \
    --group-by Type=DIMENSION,Key=SERVICE \
    --output json | \
jq -r '.ResultsByTime[].Groups[] | [.Keys[], (.Metrics.BlendedCost.Amount | tostring), (.Metrics.UnblendedCost.Amount | tostring), (.Metrics.UsageQuantity.Amount | tostring)] | @tsv' | \
column -t -s $'\t'