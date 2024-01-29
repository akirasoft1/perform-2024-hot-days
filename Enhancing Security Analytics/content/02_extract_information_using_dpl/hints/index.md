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
- summarize: Groups together records that have the same values
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
- parse: parse and extract information using DPL
  - Example:
``` 
fetch logs
| parse content, """LD '"' WORD:method """,
``` 

## Userfule functions
- contains: searches for a text occurence
  - Example `contains(content, "/login")`
- toUid: converts a string to a Uid
  - Example `toUid("6c06857d74bbff7161fb8ae19aa5b6a5")`


## Userfule Matchers for DPL
- [LD](https://docs.dynatrace.com/docs/shortlink/dpl-lines-strings#line-data): matches any characters
- [WORD](https://docs.dynatrace.com/docs/shortlink/dpl-lines-strings#posix-character-classes): Matches words: letters a-z; A-Z; numbers 0-9 and underscore _
- [SPACE](https://docs.dynatrace.com/docs/shortlink/dpl-lines-strings#posix-character-classes): Matches all white space characters
- Single (') or double (") quote match [literal expressions](https://docs.dynatrace.com/docs/shortlink/dpl-literal-expressions)
