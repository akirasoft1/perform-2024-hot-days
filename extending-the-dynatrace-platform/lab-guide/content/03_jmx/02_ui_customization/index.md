## Customizing the UI

The conversion process takes care of all of the heavy lifting and complexity of converting a 1.0 JMX extension to the new framework but you still may be interested in making a few customizations. You may also be simply interested in how some of it works so that you can make any additional JMX extension you create from scratch even better.

You'll find the charts and other cards display on the entity screens defined in the **screens** section with an entry for each entity type.

Locate the automatically created `JMX Metrics (tech.kafka)` metric table definition (on the host page) and make a few small changes:
- Give it a different display name
- Adjust the number of charts displayed

![Conversion](../../../assets/images/03_jmx_metric_table.png)

Build and activate your extension then observe the resulting changes.