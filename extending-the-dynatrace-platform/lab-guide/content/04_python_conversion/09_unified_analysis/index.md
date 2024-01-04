## Unified Analysis Screens

Extensions Framework 2.0 provides extensive customization options for Unified Analysis screens. For this lab, our focus is on converting the experience of a version 1 extension to version 2. Since our version 1 extension presented data on the old host screen, our version 2 extension will inject a metrics card onto the new Unified Analysis Host screen.

```yaml
screens:
  - entityType: HOST
    detailsInjections:
      - type: CHART_GROUP
        key: host_injection_card
        conditions:
          - relatedEntity|entitySelectorTemplate=type(python:perform_host_performance),fromRelationships.runsOn($(entityConditions))
```
In this example, we set a condition that uses the relationship we defined earlier. The condition says, "inject a card called `host_injection_card` only if there is a related entity of type `python:perform_host_performance` that is running on this host".

Next, we need to define the `host_injection_card` that we referenced above. This definition below defines each chart type, color and style to showcase the kinds of customization possible. It is possible to omit most of these customizations.

A full copy of all files is available in the Resources folder.

```yaml
screens:
  - entityType: HOST
    detailsInjections:
    ...
    chartsCards:
      - key: host_injection_card
        displayName: Perform Host Performance Metrics
        description: Metrics from the Perform Host Performance Extension
        mode: NORMAL
        numberOfVisibleCharts: 3
        entitySelectorTemplate: type(python:perform_host_performance), fromRelationships.runsOn($(entityConditions))
        charts:
          - displayName: Disk
            visualizationType: GRAPH_CHART
            graphChartConfig:
              stacked: true
              connectGaps: true
              metrics:
                - metricSelector: custom.perform_host_performance.disk.total:splitBy()
                  visualization:
                    displayName: Total
                    seriesType: LINE
                    themeColor: RED
                - metricSelector: custom.perform_host_performance.disk.used:splitBy()
                  visualization:
                    displayName: Used
                    seriesType: AREA
                    themeColor: BLUE
                - metricSelector: custom.perform_host_performance.disk.free:splitBy()
                  visualization:
                    displayName: Free
                    seriesType: AREA
                    themeColor: GREEN
          - displayName: CPU
            visualizationType: SINGLE_VALUE
            singleValueConfig:
              showSparkline: false
              thresholds:
                - value: 80
                  color: "#ff0000"
                - value: 20
                  color: "#ECB22E"
                - value: 0
                  color: "#21A366"
              metric:
                metricSelector: custom.perform_host_performance.cpu.usage:splitBy()
          - displayName: Memory
            visualizationType: GRAPH_CHART
            graphChartConfig:
              metrics:
                - metricSelector: custom.perform_host_performance.memory.usage:splitBy()
                  visualization:
                    displayName: Usage
                    seriesType: AREA
                    themeColor: BLUE

```