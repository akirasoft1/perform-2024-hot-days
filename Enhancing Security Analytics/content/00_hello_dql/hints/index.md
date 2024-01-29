## Userfule commands
- filter: restricts the output by a certain condition. 
    - Example: filter the log content by the endpoint */login*
``` 
fetch logs
| filter contains(content, "/login")
```
- fields: limits the result to certain fields
  - Example: Show only the timestamp, content and log.source
``` 
fetch logs
| field timestamp, content, log.source
```
- filterOut: The inverse of filter, useful to exclude certain results
- summarize: 
  - Example: count the number of results
``` 
fetch logs
| filter contains(content, "/login")
| summarize total=count()
``` 
  - Example: count the number of results
``` 
fetch logs
| filter contains(content, "/login")
| summarize by:log.source total=count()
``` 

## Userfule functions
- contains: searches for a text occurence
  - Example `contains(content, "/login")`
- toUid: converts a string to a Uid
  - Example `toUid("6c06857d74bbff7161fb8ae19aa5b6a5")`
