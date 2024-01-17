## App Detection Rule

1. Get your EasyTrade URL for your instance
    * Find this by going to the environments tab in DTU
    * Open terminal for your EC2
    * You will see your URL printed on the terminal when it launches
2. Navigate to Settings->Web and Mobile Monitoring -> Application detection
3. Add item
4. Configure as follows
    * Matcher = URL Contains
    * Pattern = your URL copied in step 1
    * Application = create new application with EasyTrade (your name)