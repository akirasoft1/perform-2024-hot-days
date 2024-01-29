## Lab 0: Hello DQL
This first ab is to verify the access to the environment that will be used and do your first steps with Notebooks and DQL.

### Access Lab Environment
You can find the details about the environment in Dynatrace University on the Environment tab of the event. You will see a button that brings you to the Dynatrace environment and right above that it shows you the credentials to access Dynatrace.

![Environment](../../assets/images/0-1-environment.png)

### Unguard

We will us an application called unguard for this lab, it is an insecure cloud native microservices demo application. The application is a simple twitter clone, which allows to post messages, images and URLs. 

You can access it using the following URL: [http://unguard.dtulab716448863.dynatrace.training/ui/login](http://unguard.dtulab716448863.dynatrace.training/ui/login)

![unguard](../../assets/images/0-3-unguard.png)

#### Notebook Template
You can find the instructions and the template for the lab in this notebook: 
[https://sel18797.sprint.apps.dynatracelabs.com/ui/document/v0/#share=cb85893f-b591-441a-a7b9-da1a2cd63b62](https://sel18797.sprint.apps.dynatracelabs.com/ui/document/v0/#share=cb85893f-b591-441a-a7b9-da1a2cd63b62)
> - The notebook is read-only, duplicate it to create your own copy which you can use to work on the exercises. 

#### Task 1: Create a new user
> - Open the unguard app using the link above
> - On the top right, click on *Login/Register*
>   - Choose a username and password 
>  - | ⚠️ the password is logged in clear text and will be visible to everyone
>  - Click on *Sign up* 
>- Now you should be able to login with your newly created user.

#### 2. Filter by username
The query above fetches all logs and returns the first 1000 values, but generally, we want to restrict the output to certain criteria by using the [filter command](https://docs.dynatrace.com/docs/shortlink/filtering-commands#filter).
> - Try to find the logs related to the user you just created
> - Hint: you can use the [contains function](https://docs.dynatrace.com/docs/shortlink/string-functions#contains) to search for text occurrences

#### 3. Show only relevant fields in the result
By default, all fields are shown in an output, but most of the time we want to focus on specific information. Using the [fields command](https://docs.dynatrace.com/docs/shortlink/dql-commands-overview#selection-and-modification-commands).
> - Find out which process logged this information and the name of the Kubernetes cluster on which it is running.
>   - Hint: you can then use the *Options* to change the way the results are displayed"

#### 4. Find all new registered users
Since all participants registered a new user, you should be able to find this in the logs as well. But as you don't know the usernames they chose, you will need to find other criteria to filter by. Take a look at the content from the log above and try to find a criteria that allows you to filter out all logs for user registrations.
> - Query the logs to find all registration events
>   - Hint: Based on the result above, try to find a criteria that matches log entries about new user registrations.

#### 5. Exclude robots from the result
As you can see, there are a lot of robots that register new users, how can you remove them from the results?
> - Filter out all Robots to only see registrations by real users
>   - *Hint: take a look at the [filterOut command](https://docs.dynatrace.com/docs/shortlink/dql-commands-overview#filtering-commands)*"

#### 6. Count the number of new registrations
Now that we filtered the logs for entries about real users that registered, we can use DQL to count them.
> - Count the number of users that registered
>   - Hint: take a look at the [summarize command](https://docs.dynatrace.com/docs/shortlink/dql-commands-overview#aggregation-commands)
>   - Hint: you can change the way the result is displayed with the options menu
