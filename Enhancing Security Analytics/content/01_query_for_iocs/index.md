## [Link to Lab Exercise 1 Notebook Template](https://sel18797.sprint.apps.dynatracelabs.com/ui/document/v0/#share=8cdc6403-8ec7-4f2b-96fd-9ed49c33f54c "## Link to Lab Exercise 1 Notebook Template")


## Query For Specific IOCs

You are working for Y, formerly unguard, a very popular social media company. The Cybersecurity team of Y has reached out to you as they have received information about a ransomware gang that is targeting large organizations trying to exfiltrate data and threatening to publish it on the dark web unless they get paid. The Cybersecurity team has received a list of Indicators of Compromise (IOC) and asks you to verify if you can find any evidence of an attempted attack. 

They provided you with the following list of IP addresses: 

| Indicator | Type |  Date Added |
|----------|:-------------:|------:|
| 198.12.76.214 |  IPV4 | 2024-01-28 |
| 5.149.248.68 |  IPV4 | 2024-01-28 |
| 35.245.59.16 | IPV4 | 2024-01-28 |
| 188.241.58.0/24|  CIDR | 2024-01-28 |
| 104.211.177.0| IPV4 | 2024-01-28 |

### Task 1: find if any of those IP addresses accessed the environment

1. Login to your given Dynatrace Lab Environment. Access Notebooks.
2. You can access your notebook template for this lab exercise here: [[Lab 1] Template](https://sel18797.sprint.apps.dynatracelabs.com/ui/document/v0/#share=8cdc6403-8ec7-4f2b-96fd-9ed49c33f54c "[Lab 1] Template")
3. Click on the notebook template name -> Make a copy.
4. Once the template is duplicated, rename the newly created notebook by navigating, Template Name -> Rename. Give a unique name for easy identification of your notebook.
5. Good job. You now have your notebook ready to dive into the lab exercise.

------------


### Task 2: **Use DQL to find traces of the given IOCs**
   Below you find DQL documentation that will help you to complete this lab exercise. Please take a moment to go through these links to understand various functionalities and options available in Dynatrace to query, slice and dice the data.
1. Write a simple DQL to fetch logs for the last 24 hours.
Help?: [Query Grail to fetch logs](https://docs.dynatrace.com/docs/platform/grail/dynatrace-query-language/dql-best-practices "Query Grail to fetch logs").

2. Add a filter to search for any one of the IP addresses from the list of IPs above to narrow down the search.
	Help? : [Filter Commands](https://docs.dynatrace.com/docs/platform/grail/dynatrace-query-language/commands/filtering-commands "Filter Commands")
3. Search to see what all log sources produced traces. This will give visibility into how far the attacker has reached.
	Help? : [Aggregation Summarization Commands](https://docs.dynatrace.com/docs/platform/grail/dynatrace-query-language/functions/aggregation-functions "Aggregation Summarization Commands")
	Help? : [Guidance on DQL format and syntax](https://docs.dynatrace.com/docs/platform/grail/dynatrace-query-language/functions "Guidance on DQL format and syntax").

4. Note: There are multiple ways to achieve one objective in DQL. The give help hint is just one way of doing it.

------------

### Hints: **Step wise tips to hunt for IOCs.**

#### 1. Write a simple DQL to fetch all logs.
   Hint: Should be as simple as fetch logs. But type *fetch* and give a space and see what other options are suggested. This will help you to understand what other type of data is accessble via Notebooks.
#### 2. Filter events to show only Windows Events.
Hint: There are more than one way to search for Windows events.
1. Find out what all fields can be useful for this task. Example: log.source field will contain information about the source machine that sent this log. Content field will have the entire log payload.
2. Run matching filter to get Windows events only.
	1. `Example 1: contains(log.source, "Windows")`
*This will return logs from all the sources that has the word Windows in it.*
	2. `Example 2: dt.process.name=="Windows System"`
*dt.process.name field is auto populated by Dynatrace for easy search. So dt.process.name=="Windows System" will return similar results.*
	3. `Example 3: Fields Content, dt.security_context`
*Now try running different searches on other fields such as Content, dt.security_context.*

#### 3. Further filter the events to find out any login attempts.
1. Finding events of interest is an art that comes with practise. As we go deeper into forensics, this becomes a hunt for needle in a haystack. Thanks to Dynatrace's underlying architecture of Grail, you can play with your data the way you like.
	1. Step 1: Use the contains function to run mutliple combination searches on top of step 2 above.
		1. `Example 1: contains(content, "login")` - Get all windows logs with string login in it.
		2. `Example 2: contains(content, "failed")` - Get all windows logs with string failed in it.
		3. `Example 3: contains(content, "bad password")` - Get all windows logs with string 'bad password' in it.
		4. Review the returned results and see how better the search could have been done.
		5. `Example 4: winlog.` - Look at the fields those name starts with "winlog.'.
	>Tips: Scroll to the right of the displayed results to see the parsed fields. (or) Change the visualization to a different one that is comfortable for this analysis.

#### 4. Modify the displayed results to show only the fields/details of interest from IOCs.
1. Play with the fields that starts with 'winlog.' and list down all the fields of interest.
2. Some fields contain usernames, ip addresses, or any other useful information for this investigation you think.
	1. Example: use the function 'fields' to display only the required fields, and hide rest of the fields. Syntax can be found on our documentation.

#### 5. Hunt for any activity from the given known IOCs in Windows.
1. Now that the fields of interests are displayed, we can look for IOCs. We have received the list of IOCs. Let's run a match function or an operator function to see if we can find a match for any of the IPs. Tips and Hints for this step is given in next section below (Expand Scope of Threat Hunting)
2. Use functions such as ipIn. Example: `ipIn(field-to-lookup, ip-to-lookup)`
3. *Reference: https://docs.dynatrace.com/docs/platform/grail/dynatrace-query-language/functions/network-functions*
	>Note: You may or may not find any results for the IP searches on windows. This is quite common in Security Analytics. This is a positive state. This means, the attackers have not managed to reach this point. So we go back one step to see if the attacker traces of the IPs are found in other security tools.

------------


### Expand Scope of Threat Hunting

#### 1. Search with One IP Address
1. By now, you are familiar with running functions in DQL such as contains, filter, fields, = operators etc.
2. Take one IP address from the given list of IOCs and run a broader search for any traces.
   	1. `Example 1: contains(content, "ioc-ip-address")` - This runs a search across all logs content field looks for any matches of given IP.
   	2. Run a similar search for other IPs and see if you can see traces of these IPs.
3. If you see a trace of IPs from the given list, investigate which log source generated traces.
   	1. Leverage the query syntax and fields you used in step 2 of hunting for IOCs in Windows logs.
   	2. Run a summarization query to list all log.sources from which the traces of these IPs are detected.
   	3. Pro Tip: Combine multiple IP address searches here to see if any of the IPs are found in any of the log sources.
   	4. `Example: summarize count(), by:{log.source}` - This will summarize the log.source field for the given search query.
4. Narrow down search to the log source that has traces of IOCs.
	1. Pick a log.source of interest, add that to filter. Tip: click on the log.source field to see if you can generate an updated DQL without writing it manually.
5. Remove the contains filter on IP address and see if you can run the same query in a different way.
   	1. Look for the extracted fields in the logs.
   	   	1. Is there any fields that contain IP addresses?
   	   	2. If yes, how can you directly run the IP match queries on those fields instead of running it on content field?
   	   	   1. `Hint: ipIn()` - This function will help you match for IP addresses on the field.
   	   	3. Run a query now using ipIn function to search for all IPs in a single query.
   	   	   1. `Question: can ipIn function help you search for multiple IP addresses in single query?`

7. **Search for Multiple IOCs in a Single Query.**
	1. Duplicate the above Query block to continue the investigation.
	   Help?: Duplicate a notebook query block
	2. Modify the query to search the logs from the last 24 hours to look for all IPs given above.
	3. You are welcome to refer to the official documentation of Dynatrace DQL to use any method to achieve this.

	Help?: [Query Multiple IPs at once in DQL](https://docs.dynatrace.com/docs/platform/grail/dynatrace-query-language/functions/network-functions "Query Multiple IPs at once in DQL")

8. **Find the attacker in logs.**
	1. Once you have found some traces of these IPs in our environment. Now it is time to find what the attacker was doing.
	2. Review the results at a glance to see if you can make sense out of it.
	3. Look for a field that helps you to look at events from one log source. (Example: Microsoft Windows, Network Firewalls etc. From Step 3.c)
	4. Duplicate the query block once again. In the new query block, add a filter to look at events only from one log source.

9. **Format, Extract the search results for clear visualization. (Optional)**
	1. Identify useful information from these logs. (Example: port numbers, service names, usernames, target IP addresses, any description of type of activity)
	2. Look for any extracted value from log content for easy visualization.
      	`*Example: Bar Chart, Pie Chart, Line Chart, etc*`

	>Use DPL from the next exercise and DPL official documentation guide to write simple expressions for extracting useful information that helps to understand the attack type and advanced visualization.
