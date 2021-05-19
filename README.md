# Interlok, Prometheus and Grafana

## What is this

This image runs an instance of Interlok with profiling enabled along with Prometheus & Grafana to showcase how to get various metrics from Interlok.

## Quickstart

```shell
./gradlew clean check assemble
docker-compouse up -d
```

## Dashboards

### Grafana

- [JVM](http://localhost:3000/d/K9kmttsGk/jvm)
- [Interlok](http://localhost:3000/d/XyHj4tsMk/interlok)

### Prometheus

- [workflow_avgnanos](http://localhost:9090/graph?g0.expr=workflow_avgnanos&g0.tab=1&g0.stacked=0&g0.range_input=1h)


## Logging

Since the various management components re-use interlok components to provide statistics we are in a situation where we want to filter out logging which _isn't all that interesting_ out of the console logging.

- We use javascript to filter out the log events where the context map contains "ManagementComponent". This uses the built in `nashorn` engine in Java11 which is deprecated.
- We filter out logging from `com.adaptris.profiler` to avoid logging from the aspect activity.
- Since we are using the logging aspect as well we can use `%notEmpty{[%X{messageId}]}` to display the messageID that is being acted upon in the logfile.
