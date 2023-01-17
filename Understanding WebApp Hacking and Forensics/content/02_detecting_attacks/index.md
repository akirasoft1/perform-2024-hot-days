## Launch an attack on insecure-bank

Navigate back to the insecure-bank application
- You can bypass the login using a SQL-injection: enter `'or 1=1--` in the username field
  - You can add your name (or another identifier) before at the beginning or at the end to see if you can find your attack in Dynatrace

![injection-attack](../../assets/images/2-1-insecure-bank-injection.png)

![dashboard](../../assets/images/2-2-insecure-bank-dashboard.png)

## See how Dynatrace detected your attack
Open to the Dynatrace instance and got to *Application Security > Attacks*. 
- You will see all the attacks that Dynatrace detected, since we all use the same Dynatrace instance, you will see the attacks of the other participants. Try to find the one that you executed. 

![vulnerabilities](../../assets/images/2-3-attacks.png)

![vulnerabilities](../../assets/images/2-4-attack-detail.png)