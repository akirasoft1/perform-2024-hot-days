## Search by IP

You are working for Y, formerly unguard, a very popular social media company. The Cybersecurity team of Y has reached out to you as they have received information about a ransomeware gang that is targerting large organizations and tries to exfiltrate data and threatens to publish it on the dark web, unless they get payed. The Cybersecurity team has received a list of Indicators of Compromise (IOC) and asks you the verify if you can find any evidence of an attempted attack. 

The provided you the following list of IP addresses: 

| Indicator | Type |  Date Added |
|----------|:-------------:|------:|
| 198.12.76.214 |  IPV4 | 2024-11-22 |
| 5.149.248.68 |  IPV4 | 2024-11-22 |
| 35.245.59.16 | IPV4 | 2024-11-22 |
| 188.241.58.0/24|  CIDR | 2024-11-22 |
| 104.211.177.0| IPV4 | 2024-12-02 |

## Task 1: find if any of those IP addresses accessed the environment

1. **Login to your given Dynatrace Lab Environment. Access Notebook.**
	a. Menu -> Apps -> Notebooks (or) Ctrl+K -> Type "Notebook"
	b. Click on the + symbol to create a new notebook. Click on the notebook name to rename it to your preference.
	Click on the + icon below the Notebook name, select **Query Grail**.

    Help? : Screenshot here for visual guidance.
	
2. **Query for first IOC IP Address.**
	a. Write a simple DQL to fetch logs for last 24 hours.
	b. Add a filter to search for any one of the IP address from the list of IPs above to narrow down the search.
	c. Search to see what all log sources produced traces. This will give visibility into how far the attacker has reached.

	Help? : Screenshot here for visual guidance on DQL format and syntax.

		Note: There are multiple ways to achieve one objective in DQL. The give help hint is just one way of doing it.

3. **Search for Multiple IOCs in Single Query.**
	a. Duplicate the above Query block to continue the investigation.
	   Help?: Duplicate a notebook query block
	b. Modify the query to search the logs from last 24 hours to look for all IPs give above.
	c. You are welcome to refer to the official documentation of Dynatrace DQL to use any method to achieve this.

	Help?: Query Multiple IPs at once in DQL

4. **Find the attacker in logs.**
	a. Once you have found some traces of these IPs in our environment. Now it is time to find what the attacker was doing.
	b. Review the results at a glance to see if you can make sense out of it.
	c. Look for a field that helps you to look at events from one log source. (Example: Microsoft Windows, Network Firewalls, Web Proxy and etc. From Step 3.c)
	d. Duplicate the query block once again. In the new query block, add filter to look at events only from one log source.

5. **Format, Extract the search results for clear visualization. (Optional)**
	a. Identify useful information from these logs. (Example: port numbers, service names, usernames, target ip addresses, any description on type of activity)
	b. Look for any extracted value from log content for easy visualization.
      *Example: Bar Chart, Pie Chart, Line Chart, etc*

	Help?: Extract critical information from logs

		Use DPL from next exercise and DPL official documentation guide to write simple expressions for extracting useful information that helps to understand the attack type and advanced visualization.
