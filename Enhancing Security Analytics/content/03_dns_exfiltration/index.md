# The DNS Exfiltration lab

## The scenario
In this scenario we have a Windows Server hosting a business critical application.
The hostname is WCLIENT and - as per ACME_datacenter policy - the DNS Server set on the host is 168.63.129.16.
Dynatrace instance has been configured to ingest DNS client logs from Windows Event Viewer.
The server has been configured to log DNS client activity, as per ACME enforcement requirements.

## Clues
A. Dynatrace Application Security is monitoring the application and you've been informed that CLV
(code-level vulnerabilities) reports CMDi exposure on the WCLIENT host in the datacenter.

B. The CMDi vulnerability may have been exploited to inject a Powershell script used to exfiltrate data.

C. You suspect that a possible exfiltration may have happened up to 2 months ago. 

## Task 1: use Notebook to explore 
Open the Dynatrace instance and go to the App *Notebooks*.
Create a new Notebook and add a new section "Query Grail".
Start from filtering up to 2 months ago, focusing on Windows DNS Client logs.

*Hint:*
```
fetch `logs`, from ...
| filter log.source == "..."
```

## Task 2: let's extract the clues
Ok, this is a good start point!
Now we found DNS Client logs from the server but we have to got in depth, looking for specific messages.
You have to work in order to parse the following specific log message structure (see the exeample here):

```
DNS query is called for the name some_uppercase_letters_and_numbers-.sometext.sometext, type 1, query options 196616, Server List 172.16.122.4, isNetwork query 0, network index 0, interface index 0, is asynchronous query 0
```

Everytime that the exfiltration script starts to exfiltrate data, DNS queries are crafted in order to generate a query record for a fake A record. Windows will log these queries in the EventViewer like in the example above.
You also need to extract fields from this specific log message:

-> name requested as "dns_query"

-> type of the query as "query_type"

-> dns inquired server as "dns_queried_server"

*Hint:*
```
Open the "extract fields" on content fields and use DPL architect to parse the log message creating the variables with fieldsAdd command.
```

## Task 3: adjust the findings
Well done!

You are interested into some detailed findings only, i.e. those ones not intended to our 
DNS lab server. Now please let's format the table in order to display only:

-> the host name of the server (target)

-> the "host" queried (we know that it is an hash chunk used to exfiltrate data)

-> the DNS server used (that is the fake DNS)

*Hint:*
```
fetch `logs`, from ...
| filter log.source == "..."
| parse content, -use DPL architect here-
| filter contains(dns_query,"-.") and query_type == "type 1" and dns_queried_server != "168.63.129.16"
| fieldsAdd ...
| fields ...
| sort timestamp desc
```
