## Next Steps

### Scheduled Query

To implement the simple scheduler used in the v1 extension, we can use the `self.schedule` method. A common implementation of `self.schedule` is to move the iteration of the endpoints that we original setup in the `query` method into the `initialize` method. Once we've done this we can schedule a query method for each endpoint, according to the schedule defined by the configuration.

In `__main__.py`:

```python
    def initialize(self):
        self.extension_name = "python_perform_host_performance"
        self.last_event = datetime.now()

        self.logger.info(self.activation_config)

        for endpoint in self.activation_config["endpoints"]:

                self.schedule(
                    self.scheduled_query,
                    interval=endpoint.get("interval", 1.0),
                    args=(endpoint,),
                )
```

The we can rename the `query` method to `scheduled_query` and update the method by removing the iteration through the endpoints.

```python
def scheduled_query(self, endpoint: dict):
    """
    The query method is automatically scheduled to run according to the query interval
    """

    self.logger.info(f"scheduled query method started for {self.extension_name}.")
    self.logger.info(f"Endpoint: {endpoint}")

    # Collect the metrics
    total, used, free = shutil.disk_usage(__file__)
    cpu: float = psutil.cpu_percent(percpu=False)
    ram: float = psutil.virtual_memory().percent

    self.logger.debug("A debug message")
    self.logger.info(f"CPU -> {cpu:2.2f}%")

    # Report metrics with
    self.report_metric(key=f"{METRIC_PREFIX}.disk.total", value=total, dimensions={"my_dimension": "dimension1"})
    self.report_metric(key=f"{METRIC_PREFIX}.disk.used", value=used, dimensions={"my_dimension": "dimension1"})
    self.report_metric(key=f"{METRIC_PREFIX}.disk.free", value=free, dimensions={"my_dimension": "dimension1"})
    self.report_metric(key=f"{METRIC_PREFIX}.cpu.usage", value=cpu, dimensions={"my_dimension": "dimension1"})
    self.report_metric(key=f"{METRIC_PREFIX}.memory.usage", value=ram, dimensions={"my_dimension": "dimension1"})

    self.logger.info(f"Last event was at {self.last_event}")

    # Report a resource event
    if (datetime.now() - self.last_event) > timedelta(minutes=5):
        self.logger.info("Reporting a resource contention event (v2)")
        self.report_dt_event(
            event_type=DtEventType.RESOURCE_CONTENTION_EVENT,
            title="Reporting a resource contention event (v2)",
            properties= {
                "free": str(free),
                "cpu": str(cpu),
                "ram": str(ram),
            },
        )
        self.last_event: datetime = datetime.now()

    self.logger.info("query method ended for python_perform_host_performance.")
```

### Metric Metadata

In the "metrics" sections of `plugin.json`, metric metadata is defined. In Extensions 2.0, this metadata is moved to `extension.yaml` in the `metrics` section. 

In `extension.yaml`:

```yaml
metrics:
  - key: custom.perform_host_performance.disk.total
    metadata:
      displayName: Total disk capacity
      description: The total capacity of the disk
      unit: Byte
      dimensions:
        - key: my_dimension
          displayName: My Dimension
  - key: custom.perform_host_performance.disk.used
    metadata:
      displayName: Disk used
      description: Total disk used
      unit: Byte
      dimensions:
        - key: my_dimension
          displayName: My Dimension
  - key: custom.perform_host_performance.disk.free
    metadata:
      displayName: Disk free
      description: Total disk free
      unit: Byte
      dimensions:
        - key: my_dimension
          displayName: My Dimension
  - key: custom.perform_host_performance.cpu.usage
    metadata:
      displayName: CPU Percent usage
      description: Total CPU usage
      unit: Percent
      dimensions:
        - key: my_dimension
          displayName: My Dimension
  - key: custom.perform_host_performance.memory.usage
    metadata:
      displayName: Memory Usage
      description: Total memory usage
      unit: Percent
      dimensions:
        - key: my_dimension
          displayName: My Dimension
```

### Bundled Dashboard

From the Command Palette, type "Dashboard" until "Dynatrace Extensions: Create Dashboard" is highlighted. This tool will guide the developer through the steps of created an overview dashboard of the extension. The dashboard will be bundled with the extension. It is recommended that you wait to generate this dashboard until you have defined your topology as the dashboard relies on these definition for full functionality.


### Feature Sets

Feature sets allow the developer to group metrics to together into related sets. This allows the end user to choose to collect only the metric data that is relevant to their use case. 

Feature sets are first defined in `exension.yaml` and then implemented in the Python code.

In `extension.yaml`:

```yaml
  featureSets:
  - featureSet: disk
    metrics:
      - key: custom.perform_host_performance.disk.total
      - key: custom.perform_host_performance.disk.used
      - key: custom.perform_host_performance.disk.free
  - featureSet: CPU
    metrics:
      - key: custom.perform_host_performance.cpu.usage
  - featureSet: Memory
    metrics:
      - key: custom.perform_host_performance.memory.usage
```

There are three properties available to help handle feature sets in the Python code.

| Method                              | Purpose                                                                                         |
| ----------------------------------- | ----------------------------------------------------------------------------------------------- |
| `self.enabled_feature_sets`         | Dictionary containing enabled feature sets with corresponding metrics defined in extension.yaml |
| `self.enabled_feature_sets_metrics` | List of all metric keys from enabled feature sets                                               |
| `self.enabled_feature_sets_names`   | List containing names of enabled feature sets                          

There are many ways to integrate feature sets into the code, here is one example of how it could be done.

In `__main__.py`:

```python
if "disk" in self.enabled_feature_sets_names:
    self.report_metric(key=f"{METRIC_PREFIX}.disk.total", value=total, dimensions={"my_dimension": "dimension1"})
    self.report_metric(key=f"{METRIC_PREFIX}.disk.used", value=used, dimensions={"my_dimension": "dimension1"})
    self.report_metric(key=f"{METRIC_PREFIX}.disk.free", value=free, dimensions={"my_dimension": "dimension1"})
if "CPU" in self.enabled_feature_sets_names:
    self.report_metric(key=f"{METRIC_PREFIX}.cpu.usage", value=cpu, dimensions={"my_dimension": "dimension1"})
if "memory" in self.enabled_feature_sets_names:
    self.report_metric(key=f"{METRIC_PREFIX}.memory.usage", value=ram, dimensions={"my_dimension": "dimension1"})
```

