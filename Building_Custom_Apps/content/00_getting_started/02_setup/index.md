## Environment setup

This section will guide you through the steps to setup your editor and access the Dynatrace app you'll be working on.

On the Dynatrace University page, you will find the details of your VM and your Dynatrace environment.
Going forward you will need the IP address, username, and password, as well as the URL to the environment.

### 1. Configure your connection

To configure a connection to your VM, follow these steps:
1. Open the Remote Explorer view
2. From its settings, open your SSH config file

   ![configure](../../assets/images/02_configure.png)

3. Add your VM's details. For example:

```text
Host Perform
   HostName 10.0.0.1
   User dynatrace
   PasswordAuthentication yes
   StrictHostKeyChecking no
```

4. Refresh the list to see your host
   
   ![refresh](../../assets/images/02_refresh.png)

### 2. Connect to your VM

Connect to your VM by following these steps:
1. Click the arrow button next to the host
2. Choose `Linux` for the platform
3. Type your password
4. Open the `easytrade-analytics` folder

### 3. Optionally, install helper extensions

To have a great coding experience, we recommend you install two additional extensions for your editor:
- ESLint: used to highlight any syntax errors in your code
- Prettier: used to format your code

Search for these in the editor's Extensions menu and make sure the button says "Install in SSH":

![install in ssh](../../assets/images/02_install_in_ssh.png)

### 4. Point the app to your environment

Modify the file at `~/easytrade-analytics/app.config.ts`, and change the `environmentUrl` based on your URL.

### 5. Run the app

Your editor should have already opened a terminal window for you. If not, please open one from the **top Menu > Terminal > New terminal**.

In the terminal window, run the command:

```shell
npm run start
```

Complete the login with Dynatrace SSO and verify that your Dynatrace Environment now shows your running app:

![easytrade blank](../../assets/images/02_easytrade_blank.png)

### Troubleshooting

When starting the app, the first step is the SSO authentication. If this doesn't complete, and instead you're left with a browser tab open and pointing to `localhost`, then cancel the command using `Ctrl + C`.

Follow these steps to forward port 5343 to your VM:
1. In the editor's bottom panel, click `PORTS`
2. Click `Foward a Port`
3. Type `5343` and press `Enter`. The rest of the details will complete automatically

Now, try the `npm run start` command again.
