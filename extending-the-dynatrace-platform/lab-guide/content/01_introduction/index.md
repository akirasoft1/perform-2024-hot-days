## Introduction 
The EEC executes our EF2.0 extensions, but it isn't enabled by default.  

1. Go to your Dynatrace tenant. Settings -> preferences -> Extension execution controller  
2. Select Enable Extension execution controller and local pipe/HTTP metrics.
3. Save changes

## Create a token
The vscode add-on interacts with the Dynatrace via API calls so it requires a token. This token is placed on your desktop. If you want to create it manually, here are the steps:

1. Settings -> manage -> access tokens.  
2. Generate new token, name = perform, no expiration.
3. Add the following scopes:   
    WriteConfig  
    ReadConfig  
    credentialVault.read  
    credentialVault.write  
    extensions.read  
    extensions.write  
    extensionEnvironment.write  
    extensionEnvironment.read  
    extensionConfigurations.read  
    extensionConfigurations.write  
    metrics.read  
    entities.read  
    settings.read  
    settings.write  
4. Generate token
5. Save your token (Notepad++)  

## Set up VSCode add-on  
The add-on saves a lot of time by automating tedious development stages such as SSL certificates. It can build and deploy your extensions for you as well.  

1. Start Visual Studio Code
2. Click on the Dynatrace logo on the left and select add environment
3. Enter your tenant URL in the box (cut and paste from your browser). Press enter
4. Enter your token created in the previous step. Press enter
5. Type perform in the environment label box. Press enter
6. Select Yes
7. Select Open folder and create a folder for your workspace (For instance Desktop\training\projects\snmp)
8. Click on the Dynatrace logo and select initialize workspace (choose the latest schema)
9. Certificates: Generate new ones and use it for all work spaces
10. When prompted to upload to your environment, select yes
11. Under certificate name, enter perform
12. Description, perform
13. Do you want to distribute to OneAgents and Active gates, select yes

Note: If you need to re-run any steps, use f1 and search for the relevant step. Type Dynatrace to only return Dynatrace commands such as distribute certificate.

You are ready to write a new extension


