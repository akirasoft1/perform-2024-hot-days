## Service Naming

1. Navigate to Settings->Server-side service monitoring->Service naming rules
    * Click on Add a new rule
    * Set the Rule name: {your_name Services}
    * Set the Service name format: ‘{Service:DetectedName} ({your_name})’
2. Click on Add condition
    * Search for the Service tags property
    * Set Operator to equals
    * Insert {your_name_tag} as the Value
3. Preview matching entities 
4. Navigate to the Services Overview Dashboard 
    * Filter for your services via your tag
