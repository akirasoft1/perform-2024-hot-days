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