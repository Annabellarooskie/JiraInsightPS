# JiraInsightPS

## Abstract

Provides a PowerShell interface to Jira Insight add-on. Currently only the get functionality is available and the objects returned only contain the attributes and their values. There are a few steps to making your connection to insight more enjoyable:

*You will need a Windows credential manager module called Vault, which is a dependancy module.  Install and import. https://github.com/LastMisadventure/Vault

*Using the Vault PSmodule, store your credentials in your Windows Vault (Credential Manager):

~~~
Add-VaultEntry -PsCredential $credentialToAdd -Resource mytoolsbox
~~~

The config file for this module will need to be set up for the account you are using to connect to Insight, as well as the top level object type and Insight Schema ID.

At this point the module should be functional now.  There are two public cmdlets at this time:

~~~
Get-InsightObject
Get-InsightObjectType
~~~

Utilize the Get-Help cmdlet for more information on each command.

