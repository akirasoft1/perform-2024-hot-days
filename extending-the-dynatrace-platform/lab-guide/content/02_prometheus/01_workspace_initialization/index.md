### Initialize workspace in VS Code

Open up a new folder within VS Code (e.g. `prometheus-windows_extension`).

Use the command pallete (F1 or ctrl+shift+p) and run the `Dynatrace extensions: initialize workspace` command.
* Select schema `1.280.0`
* Use existing certificates
* Select the default project type `Extension 2.0`

This will generate the skeleton structure of your extension.

Open the `extension\extension.yaml` file and review.

Update the metadata at the top to give your extension a meaningful name and set yourself as the author.

```yaml
name: custom:windows-prometheus
version: "0.0.1"
minDynatraceVersion: "1.280.0"
author:
  name: Alice Smith
```

This is the simplest valid extension. But with no other sections installing it will have no effect. Next we'll look at collecting our Prometheus metrics.