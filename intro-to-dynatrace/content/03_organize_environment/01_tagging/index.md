## Tagging

1. Find you hosts IP Address
2. Navigate to Settings->Tags->Automatically applied tags
    * Click on Create Tag
    * Set the Tag name: {your_name}
3. Click on Add a new rule & set the following: 
    * Rule Type: Monitored entity
    * Rule applies to: Services 
4. Click on Add condition
    * Search for the Host IP address property
    * Set Operator to equals
    * Insert {your_IP_address} as the Value
5. Toggle the following: 
    * Apply to underlying hosts of matching services
    * Apply to underlying process groups of matching services
6. Navigate to your host & click on Properties and tags