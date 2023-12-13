## Defining Topology and Relationships

The combination of extension framework 2.0, Unified Analysis screen and Generic Types, allows the extension creator to define Generic types with their extension and to create custom screens using Unified Analysis. 

### Topology

First, we will create a [generic type](https://docs.dynatrace.com/docs/extend-dynatrace/extend-topology#custom-topology-model) called, `python:perform_host_performance`. Custom Topology definition is covered in the [WMI Tutorial](https://docs.dynatrace.com/docs/extend-dynatrace/extensions20/data-sources/wmi-extensions/wmi-tutorial/wmi-tutorial-04) in our Documentation. 

When defining a Custom Type, the key is to define a rule that allows each entity to be identified uniquely using available metric dimensions. Dynatrace automatically enrichments metric with several dimensions that can be useful when creating a generic type. Since our extension is running locally on a host we can use the automatically enriched `dt.entity.host`  dimension.

In the **sources** section of the definition we instruct the rule to use all metrics that use the `metric_prefix` we defined in our extension code.

In the `extension.yaml` file:

```yaml
topology:
  types:
    - enabled: true
      name: python:perform_host_performance
      displayName: Perform Host Performance
      rules:
        - idPattern: python_host_performance_{dt.entity.host}
          instanceNamePattern: "Perform on {host.name}"
          iconPattern: server
          sources:
            - sourceType: Metrics
              condition: $prefix(custom.perform_host_performance)
          attributes:
            - key: host
              pattern: "{host}"
```

### Relationships

Next, we will create a relationship between the created entity and the host that they entity is running on. 

Code completion is useful here as we can view the `typeOfRelation`  that are available. They are:

- `CALLS`
- `CHILD_OF`
- `INSTANCE_OF`
- `PART_OF`
- `RUNS_ON`
- `SAME_AS`

In the `extension.yaml` file:
```yaml
topology:
  types:
  ...
  relationships:
    - enabled: true
      fromType: python:perform_host_performance
      typeOfRelation: RUNS_ON
      toType: host
      sources:
        - sourceType: Metrics
          condition: $prefix(custom.perform_host_performance)
```