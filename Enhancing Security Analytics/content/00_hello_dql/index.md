## Hello DQL
This first ab is to verify the access to the environment that will be used and do your first steps with Notebooks and DQL.

### Access Lab Environment
You can find the details about the environment in Dynatrace University on the Environment tab of the event. You will see a buton that brings you to the Dynatrace environment and right above that it shows you the crendentials to access Dynatrace.

![Environment](../../assets/images/0-1-environment.png)

### Unguard

We will us an application called unguard for this lab, it is an insecure cloud native microservices demo application. The application is a simple twitter clone, which allows to post messages, images and URLs. 

You can access it using the following URL: http://unguard-lb-tsv10597-1232203251.us-west-2.elb.amazonaws.com/ui

![unguard](../../assets/images/0-3-unguard.png)

##### Notebook Template for tasks: https://tsv10597.sprint.apps.dynatracelabs.com/ui/document/v0/#share=98235fdb-4a78-484e-8c2e-155f93714346

> #### Task 1: Create a new user
> - Open the unguard app from the Ace-Box as described above
> - On the top right, click on *Login/Register*
>   - Choose a unsername and password 
>   - Click on *Sign up* 

> #### Task 2: Find it in the logs
> - Go to Dynatrace and open the Notebook App
> - Create a new Notebook
>   - Click on the *+ Notebook* button to create a new notebook
> - Rename it to *Lab0* (click on title and select rename)
> - In the Notebook, create a new *Query Grail* selection
> - Write your first DQL query: `fetch logs`
> - Try to find the log entry for when your user was registered
> - Restrict the fields to only show what your interested in
> - What was the name of the process that logged this information? On which host is it running?
> - Can you find a list of all users that registered?
>   -  There might a lot of entries from Robots, can you filter them out?
> - Count the number of users that registered