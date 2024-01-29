## Hands-on 2 (Gabriel Prioli)

# Setup
1. In Dynatrace, open "Access Tokens"
1. Click on "Generate new token"
1. For Token name, type "Bizevents"
1. Type "bizevents" in the search bar
1. Mark "Ingest bizevents" 
1. Click "Generate token"
1. Click "Copy" and save it to a file in your computer
1. Click "Done"
1. In the server terminal, run the command
    ```
    cd /home/dtu_training/supporting-files
    ```
1. Run the command
    ```
    nano credentials.sh
    ```
1. Copy the token and paste it on line 2
1. Copy the URL of your Dynatrace tenant and paste it on line 3
1. Make the following modifications: remove the ".apps" and the leading "/"
1. It has to look something like "https://<your id>.sprint.dynatracelabs.com"
1. Type "CTRL + X", then "Y", then hit <Enter>.
1. Run the following command
    ```
    source /home/dtu_training/supporting-files/credentials.sh; echo $TENANT; echo $TOKEN
    ```


### 1) JSON event
1. Run the command `cat json-payload.json`
1. Run the command `./json.sh`

### 2) CloudEvent event
1. Run the command `cat cloudevent-payload.json`
1. Run the command `./cloudevent.sh`

### 3) CloudEvent Batch event
1. Run the command `cat cloudevent-batch-payload.json`
1. Run the command `./cloudevent-batch.sh`

For all the event types, run the followingquery:
```
```

### 5) RUM API event
1. Navigate to your easyTrade application
1. In your browser, open developer tools and navigate to the console
1. Run the command:
    ```
    dynatrace.sendBizEvent("type-RUM", {"custom-attribute": <YOUR_NAME>})
    ```
