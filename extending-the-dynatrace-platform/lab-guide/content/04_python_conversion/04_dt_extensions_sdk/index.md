## Getting started with dt-extensions-sdk

### Using dt-sdk

The v2 SDK is a fully featured SDK that allows you to create, build, sign and deploy a Python extension. In this course, we will focus on using the SDK through the VS Code extension.  

`dt-extensions-sdk` is available on [PyPi](https://pypi.org/project/dt-extensions-sdk/) with [detailed](https://dynatrace-extensions.github.io/dt-extensions-python-sdk/) documentation. 

To try the SDK directly:

1. Create a directory to test using `dt-sdk` directly 
    - `test_directory`
2. Create and activate a virtual environment
    - `py -m venv venv`
    - `.\venv\Scripts\Activate.ps1`
3. Install the SDK
   - `pip install 'dt-extensions-sdk[cli]'`
4. Confirm the install
   - `dt-sdk --help`
5. Initialize an extensions
   - `dt-sdk create my-extension-name`
6. Explore the extension scaffolding created

You can now open this folder in the code editor of your choice and continue work on your extension. 

### Using the VS Code Dynatrace Extension

1. Choose the Dynatrace Extension in the sidebar
2. Click "Initialize" or "+". 
3. Choose (or create) a folder.
4. Choose a version of the schema (1.270).
5. If necessary, agree to download the schemas and generate keys, otherwise use existing certs and schemas.
6. Choose "Python Extensions 2.0".
7. Name your extension.
8. Examine the created scaffolding.
9. Type "Dynatrace" in the Command Palette to familiarize yourself with the commands that are available to use in the extension. 

![](../../../assets/images/04_python_04_scaffolding.png)