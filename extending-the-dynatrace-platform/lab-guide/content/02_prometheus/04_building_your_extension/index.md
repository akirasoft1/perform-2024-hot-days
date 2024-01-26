## Building your extension

Inside VS Code open a new windows and select to open the `prometheus-demo-extension` folder. Then open up the command palette (ctrl + shift + p) and search for "Dynatrace" and choose the `Dynatrace: Build Extension` option. 

![Build Extension](../../../assets/images/03_prometheus_build_extension.png)

This will sign and package your extension into a zip file called custom_prometheus.demo-1.0.0.zip

The Dynatrace Extension Copilot will then offer you to upload and activate this new version of the extension. 

![Upload Extension](../../../assets/images/03_prometheus_upload_extension.png)
![Activate Extension](../../../assets/images/03_prometheus_activate_extension.png)

Inside the Dynatrace UI -> Dynatrace Hub -> Manage & upload extensions -> custom:prometheus.demo -> Add a monitoring configuration

![Monitoring configuration](../../../assets/images/03_prometheus_adding_configuration.png)

Select your host. This will automatically make it a `LOCAL` extension and click `Next`.

![Monitoring host](../../../assets/images/03_prometheus_selecting_monitoring_host.png)

Add a new Prometheus endpoint and point it to `http://localhost:9182/metrics`. This prompt came from the **prometheus** data source we entered in the yaml file.

![Add endpoint](../../../assets/images/03_prometheus_add_endpoint.png)

**Note: If you see a slash at the end '/', remove it**

Leaving a slash at the end will make the Prometheus data source try to collect data from a Prometheus API and not scraping a metrics endpoint

Next, select which Feature sets you want to enable, and to see the service info enter a valid filter pattern. This could be for specific PIDs or just the following to ensure that only running services are reported: `$not($eq(0))`

![Feature sets](../../../assets/images/03_prometheus_featureset.png)

After activation it is not uncommon to first see an Error status reported while the extension/configuration get send to the configured host(s).

We can see and verify data by going to **Data Explorer** or **Metrics** and searching for our metrics keys.

![Data explorer](../../../assets/images/03_prometheus_data_explorer.png)

We are done!