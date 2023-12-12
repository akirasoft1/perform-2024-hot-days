## Python Extension Framework 2 Primer

In EF2, components that originate in `plugin.json` are split to separate logical files. This increases the number of files but results in a more logical and modular design. 

This new structure means that:

- The extension is a standalone Python module. 
- It can run independently
- It generates a wheel file when built
- Parameters are separate from metadata.
- Parameters are mandatory
- Metadata is optional 

### EF1 to EF2 Comparisons

#### Mapping EF1 Components to EF2 

| Component                                        | EF1               | EF2                   |
| ------------------------------------------------ | ----------------- | --------------------- |
| Metadata, version, properties, screens, topology | `plugin.json`     | `extensions.yaml`       |
| Extension configuration                          | `plugin.json`     | `activationSchema.json` |
| Dependencies                                     | `plugin.json`     | `setup.py`              |
| Development parameters                           | `properties.json` | `activation.json`       |
| Python development library                       | `plugin-sdk`      | `dt-extensions-sdk`     |
| Extension code                                   | Python class      | Python module         |
| Artifact                                         | .zip file         | Signed .zip file      |


#### Method Conversion

| Purpose                | EF1                                              | EF2                                                         |
| ---------------------- | ------------------------------------------------ | ----------------------------------------------------------- |
| Logging                | `self.logger.info('message')`                    | `self.logger.info('message')`                               |
| Get user configuration | `self.config.get('param_name', 'default_value')` | `self.activation_config.get('param_name', 'default_value')` |
| Report an event        | `self.results_builder.report_custom_info_event`  | `self.report_dt_event`                                      |
| Report a metric        | `device.absolute`                                | `self.report_metric`                                        |

#### New Methods

| Purpose                    | Method                   |
| -------------------------- | ------------------------ |
| Report a log event         | `self.report_log_event`  |
| Report multiple log events | `self.report_log_events` |
| Report multiple metrics    | `self.report_mint_lines` |
| Schedule a method          | `self.schedule`          |



