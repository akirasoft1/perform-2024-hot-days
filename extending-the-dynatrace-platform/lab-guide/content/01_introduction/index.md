## Set up VSCode add-on  
The add-on saves a lot of time by automating tedious development stages such as SSL certificates. It can build and deploy your extensions for you as well.  

1. Start Visual Studio Code
2. Click on the plugin logo on the left and select add environment
3. Enter your tenant URL in the box (cut and paste from your browser)
4. Enter your token created in the previous step
5. Type perform in the environment label box
6. Select Yes
7. Select Open folder and create a folder for your workspace (For instance Desktop\training\projects\snmp)
8. Click on the plugin logo and select initialize workspace (choose a recent schema)
9. Certificates: Generate new ones and use it for all work spaces
10. When prompted to upload to your environment, select yes
11. Under certificate name, enter anything, such as Perform
12. Description, enter anything, such as Perform
13. Do you want to distribute to OneAgents and Active gates, select yes

Note: If you need to re-run any steps, use f1 and search for the relevant step. Type Dynatrace to only return Dynatrace commands such as distribute certificate.

You are ready to write a new extension
