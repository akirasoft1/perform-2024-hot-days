## Deploying Dynatrace

The OneAgent Operator has already been pre-installed on each student's EC2 instance. However, we need to restart the pods in order for the OneAgent to deep inject.

1. Access your environment tab in your DTU course (reccomend doing this in a seperate tab)
2. Now navigate towards the bottom where you can see the details on your EC2 instance
3. Open the SSH terminal and enter this command:
```shell
kubectl rollout restart deploy -n easytrade
```