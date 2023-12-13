## Converting plugin.json

`plugin.json` is a single file that describes the metadata, version info, properties, UI, configuration and dependencies of an extension. In EF2, this file is split up into three separate files. 

For this exercise we will work our way down the `plugin.json` file, updating the appropriate files as we go.

#### Mapping EF1 Components to EF2 

| Component                                        | EF1               | EF2                     |
| ------------------------------------------------ | ----------------- | ----------------------- |
| Metadata, version, properties, screens, topology | `plugin.json`     | `extensions.yaml`       |
| Extension configuration                          | `plugin.json`     | `activationSchema.json` |
| Dependencies                                     | `plugin.json`     | `setup.py`              |

#### setup.py

`setup.py` contains information related to extension name and version as well as dependency info. In `plugin.json`, we can see that there is single defined dependency.

From `plugin.json`

```json
    "install_requires": [
        "psutil>=5.9.6"
      ],
```

To update `setup.py`, we simply need to update the `install_requires` parameter.

```python
from setuptools import setup, find_packages

setup(name="my_new_perform_extensions",
      version="0.0.1",
      description="My_new_perform_extensions python EF2 extension",
      author="Dynatrace",
      packages=find_packages(),
      python_requires=">=3.10",
      include_package_data=True,
      install_requires=[
            "dt-extensions-sdk",
            "psutil>=5.9.6",
      extras_require={"dev": ["dt-extensions-sdk[cli]"]},
      )

```

#### ActivationSchema.json

Next up in the `plugin.json` file is the **ConfigUI** section. This information is moved to `ActivationSchema.json`.

From `plugin.json`

```json
    "configUI": {
      "displayName": "Perform Host Performance Extension",
      "properties": [
        {
          "key": "interval",
          "displayName": "Query frequency",
          "displayOrder": 1,
          "displayHint": "Query frequency in minutes"
        }
      ]
    },
```

The scaffolding provides us with a working `ActivationSchema.json`, including a few pre-configured properties (url, user, password). The easiest way to approach this change, is to rename and repurpose the existing properties.

First, since our extension only uses a single property, we will remove the "user" and "password" properties. Here, VS Code's built-in JSON formatter and linter are your friend, as it is easy to break the JSON when editing properties. 

We are now left with a single "URL" property in our JSON file. Complete these steps to add an interval property to the `ActivationSchema.json`. 

1. Rename the property `url` to `interval` (line 9).
2. The new `interval` property has several sub-properties.
   1. Update the value of `displayName` to `"Query frequency"`.
   2. Add a `"description"` sub-property and set the value to `"Query frequency in minutes"`.
   3. Change the value of `"default"` to `1` (We want an integer value here so no quotes).
   4. Change the value of "type" to "INTEGER".
   5. A constraint of type "LENGTH" refers to the character length of a string. Since we are using the type "integer", we will change the constraint "type" to "RANGE" and allow a range of 1 to 600 minutes.
3. Update the value of "summaryPattern" to remove the reference to the now removed "url" property.

```json
{
  "types": {
    "dynatrace.datasource.python:python_perform_host_performance-endpoint": {
      "type": "object",
      "displayName": "Python_perform_host_performance Endpoint",
      "summaryPattern": "Python_perform_host_performance",
      "properties": {
        "interval": {
          "displayName": "Query frequency",
          "description": "Query frequency in minutes",
          "type": "integer",
          "nullable": false,
          "default": 1,
          "constraints": [
            {
              "type": "RANGE",
              "minLength": 1,
              "maxLength": 600
            }
          ],
          "maxItems": 1
        }
      }
    },
    ...
```

Lastly, will will adjust the constraint that determines how many endpoints this extension can support. In the properties titled, `pythonLocal` and `pyhtonRemote`, change the `maxItems` to 1.

```json
"minItems": 1,
"maxItems": 1,
```

This will give us working Monitoring Configuration UI that will allow the end user to define the query frequency interval and, once we've updated the Python code, successfully build and run the extension. Later, we will come back to `plugin.json` to update `extension.yaml` with Metric metadata and Unified Analysis screens. 

