## JMX Extension

All supporting materials are available [here](https://github.com/tukanuk/supporting-materials/tree/main).

Java Management Extension (JMX) Mbeans are a way of collecting information about a given Java process.

Dynatrace provides you with a framework that you can use to extend your application and services observability into data acquired directly from JMX Management Beans (MBeans). The Dynatrace extensions framework can instrument Mbeans to extract metrics and metadata about the Java process.

We will use a simple Kafka application that exposes various Mbeans and go through new concepts. Rather than starting from scratch we will convert an existing JMX extension from the 1.0 framework to the latest 2.0 extensions framework.

At the end of this lab, we will have:

1. A built 2.0 JMX extension for Kafka processes
2. A monitoring configuration in Dynatrace
3. Metrics ready to be used on dashboards
4. A packaged and ready to distribute version
