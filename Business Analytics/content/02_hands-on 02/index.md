## Hands-on 2 (Brian Chandler)

Required setup command

```
source /home/dtu_training/supporting-files/export-env-vars.sh; echo $CLIENT_ID; echo $CLIENT_SECRET; echo $TENANT; echo $SSO_URL; cd /home/dtu_training/supporting-files
```

### 1) JSON event
1. Run the command `$ ./get-token.sh`
1. Edit the file post-bizevent.sh to adjust the content-type
1. Make sure it's set to 
    ```
    application/json
    ```
1. Run the command `$ ./post-bizevent.sh payload-json.json`

### 2) CloudEvent event
1. Run the command `$ ./get-token.sh`
1. Edit the file post-bizevent.sh to adjust the content-type
1. Make sure it's set to 
    ```
    application/cloudevent+json
    ```
1. Run the command `$ ./post-bizevent.sh payload-cloudevent.json`

### 3) CloudEvent Batch event
1. Run the command `$ ./get-token.sh`
1. Edit the file post-bizevent.sh to adjust the content-type
1. Make sure it's set to 
    ```
    application/cloudevent-batch+json
    ```
1. Run the command `$ ./post-bizevent.sh payload-cloudevent-batch.json`
1. You will see a line that says "undefined"

### 4) View the events in the instructor's tenant

### 5) RUM API event
1. Navigate to http://easytrade.dtulab673309665.dynatrace.training/#/login
1. In your browser, open developer tools and navigate to the console
1. Run the command:
    ```
    dynatrace.sendBizEvent("type-RUM", {"custom-attribute": <YOUR_NAME>})
    ```

### 6) View the events in the instructor's tenant
