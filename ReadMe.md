# JiraInsightPS

## Abstract

Provides a PowerShell interface to Jira Insight add-on. Currently only the get functionality is available.  There are a few steps to making your connection to insight more enjoyable:

*Fire up a PS console on a Windows tools box

*First you have to setup the repo that hosts this module as well as the Vault dependancy module, then install and import.  Directions for this are here:
https://itgwiki.ohsu.edu/display/CASI/NuGet+Package+and+PSModule+Distribution

*Using the Vault PSmodule, store your credentials or the svcJiraOps credentials in your Windows Vault (Credential Manager).  svcJiraOps credentials are stored in Ecsv KeePass. The config file for this module when it is downloaded has all settings to connect to the OHSU Jira Insight instance in ITGJIRA with svcJiraOps, but you can change this at any time.

~~~
Add-VaultEntry -PsCredential $credentialToAdd -Resource mytoolsbox
~~~

At this point the module should be functional now.  There are two public cmdlets at this time:
Get-InsightObject
Get-InsightObjectType

Utilize the Get-Help cmdlet for more information on each command.

