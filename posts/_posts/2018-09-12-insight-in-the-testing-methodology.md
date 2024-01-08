---
layout: post
toc: true
title:  "Insight in the testing methodology - 2018 / 2020"
hidden: false
authors: [ryan]
categories: [ 'infastructure' ]
tags: [ 'infastructure', 'testing', 'data' ]
image: assets/images/posts/000-insight-in-the-testing-methodology/000-insight-in-the-testing-methodology-feature-image.png
---
When doing different performance researches it is important to have a clear understanding of the testing methodology used. With all the information available you must be able to reproduce the exact same results. In case of a performance research, we use various tools to measure the impact from the performance perspective. The reproducibility is very important to publish reliable and consistent results. The following section will describe some details about the tooling, data sources, and automation.

## Software and tools
The primary tool to generate a reliable load on the environment is done by the product Login VSI. Login VSI is an industry standard in simulating users on virtual desktop environments. Each performance research will be tested using Login VSI unless there is a reason to use another solution.

For all organizations using centralized virtual desktop environments to provide applications to their end-users, we offer the Login VSI Enterprise Edition, the complete solution to protect VDI performance and availability.

> Login VSI offers a unique combination of synthetic load-testing and pro-active monitoring capabilities, allowing enterprises to design, build and maintain VDI environments (both infrastructure and applications) that can provide, and safeguard, an optimal End-User Experience.
>
> The Login VSI load-testing solution generates a large number of synthetic users to test and protect the performance and scalability of your new and existing VDI, SBC and DaaS deployments.
>
> The Login VSI is the complete solution to optimize and protect the performance of business-critical applications running in SBC and VDI infrastructures such as VMware Horizon View, Citrix XenDesktop, Citrix XenApp, and Microsoft Remote Services (RDS), previously Terminal Services.
>
> For more information about Login VSI please visit: [https://www.loginvsi.com](https://www.loginvsi.com){:target="_blank"}

Login VSI contains a set of workloads that represents various user types. By default, we use the Knowledge Worker Workload as this is known as the facto standard. The Knowledge Worker is designed for 2(v)CPU environments. This is a well-balanced intensive workload that stresses the system smoothly, resulting in higher CPU, RAM and IO usage.

The Knowledge Worker workload uses the following applications:

  * Adobe Reader
  * Freemind/Java
  * Internet Explorer
  * Microsoft Excel
  * Microsoft Outlook
  * Microsoft PowerPoint
  * Microsoft Word
  * Photo Viewer

It also uses native Windows apps (Notepad and 7-Zip) to complete the print and zip actions used by the workload metafunctions.

For more information about the available workloads please visit: [https://www.loginvsi.com/documentation/index.php?title=Login_VSI_Workloads](https://www.loginvsi.com/documentation/index.php?title=Login_VSI_Workloads){:target="_blank"} or [https://www.loginvsi.com/blog/login-vsi/665-simulating-vdi-users-introduction-to-login-vsi-workloads](https://www.loginvsi.com/blog/login-vsi/665-simulating-vdi-users-introduction-to-login-vsi-workloads){:target="_blank"}

Login VSI comes with a default set of various resources, including documents, websites, and videos. Login VSI provides an additional Pro library to extend the default set of resources. The Login VSI Pro library is applied to the {{site.title}} environment. More information about the Login VSI Pro library can be found here: [https://www.loginvsi.com/documentation/index.php?title=Login_VSI_Pro_Library](https://www.loginvsi.com/documentation/index.php?title=Login_VSI_Pro_Library){:target="_blank"}.

The default Login VSI settings do not always suit our needs. Consequently, we’ve made some changes to the test runs. The default PDF printer is DoroPDF which is not always reliable under maximum load which results in stuck sessions. As this effect the results we decided to disable PDF printing by default to ensure smooth execution of the workload.

## Data source and testing methodology
Measuring the impact requires performance metrics. During each test, data is collected from multiple sources. By default, we use the data produced by Login VSI. Furthermore, we collect data from the hypervisors, the virtual users, using the Remote Display Analyzer and various infrastructure components. By using all the data from various sources {{site.title}} can ensure results are reliable and are capable to report the impact from multiple perspectives.

The testing cycle is automated with the following execution order:

1. Reboot the Login VSI Launcher infrastructure.
2. Disable Desktop pool and shut down all machines.
3. Reboot the hypervisor.
4. Enable Desktop pool and start all machines.
5. Idle 45 minutes to ensure the VM’s and the host is idle/ready.
6. Start the performance data captures.
7. Start the Login VSI test.
8. Wait for the Login VSI test to complete.
9. Collect all performance data.

For each scenario, the test cycle is repeated 10 times. All performance results published on the {{site.title}} platform are based on multiple test cycles and reported in the average. This way we can ensure the findings of the results are consistent and correct.

It may occur a test cycle fails which affects the average. When this occurs, the specific cycle will be removed from the data set. If 3 or more cycles have failed, the results as not reliable. The data set from the tested scenario won’t be used and the scenario will be repeated.

## The default Login VSI workload
The following workload is used by default for all our tests unless mentioned otherwise. The difference can be found inline 10, 363 and 375-377. Additionally, the videos used in the workload are increased from 360p to 720p.

```
#$WLH$02a64a92b5870a7472eb1adaf9817f56
#WLProp:Version#4.1.5
#WLProp:Date#2016-04-13
#WLProp:Description#The Login VSI 4.1 Knowledge Worker Workload
#WLProp:ConnectionMode#1
##### Start segment Prepare
Segment("Workload", "Prepare")

# Start Remote Display Analyzer
VSI_ShellExecute("RDA", "PowerShell.exe", "-ExecutionPolicy ByPass -File  %VSI_SHARE%\_VSI_Tools\RDA\CaptureUserData.ps1 -Share %VSI_SHARE% -TestName %VSI_ACTIVETEST%", "C:\Windows\System32\WindowsPowerShell\v1.0")

# Disable adobe in seperate instances
VSI_RegWrite("Workload", "HKEY_CURRENT_USER\Software\Adobe\Acrobat Reader\DC\AVGeneral", "bSDIMode", "REG_DWORD", "1")

# Set Outlook PRF location
VSI_RegWrite("Workload", "HKEY_CURRENT_USER\Software\Microsoft\Office\%VSI_Office_Version%.0\Outlook\Setup", "importPRF", "REG_SZ", "%TMP%\VSI\Runtime\Outlook.prf")

# Set IE compatibility mode to 0
VSI_RegWrite("Workload", "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\BrowserEmulation", "IntranetCompatibilityMode", "REG_DWORD", "0")

# Set RunOnce as Completed in IE8 & IE9+
VSI_RegWrite("Workload", "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main", "RunOnceComplete", "REG_DWORD", "1")
VSI_RegWrite("Workload", "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main", "RunOnceHasShown", "REG_DWORD", "1")
VSI_RegWrite("Workload", "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main", "IE8RunOnceLastShown", "REG_DWORD", "1")
VSI_RegImport("Workload", "%TMP%\VSI\Runtime\IE8_RunOnce.reg")

# Remove recovery in IE
VSI_RegDelete("Workload", "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Recovery", )

# Set default my documents folder
VSI_RegWrite("Workload", "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders", "Personal", "REG_SZ", "%VSI_Userhome%\")

# Prevent excel book is windowed
VSI_RegWrite("Workload", "HKEY_CURRENT_USER\Software\Microsoft\Office\%VSI_Office_Version%.0\Excel\Options", "Maximized", "REG_DWORD", "3")

# Deleting Office auto-repair documents
VSI_RegDelete("Workload", "HKEY_CURRENT_USER\Software\Microsoft\Office\%VSI_Office_Version%.0\Excel\Resiliency" , )
VSI_RegDelete("Workload", "HKEY_CURRENT_USER\Software\Microsoft\Office\%VSI_Office_Version%.0\Powerpoint\Resiliency" , )
VSI_RegDelete("Workload", "HKEY_CURRENT_USER\Software\Microsoft\Office\%VSI_Office_Version%.0\Word\Resiliency", )
VSI_RegDelete("Workload", "HKEY_CURRENT_USER\Software\Microsoft\Office\%VSI_Office_Version%.0\Outlook\Resiliency", )

# Disable Hardware Notification for PowerPoint
VSI_RegWrite("Workload", "HKEY_CURRENT_USER\Software\Microsoft\Office\%VSI_Office_Version%.0\Powerpoint\Options", "DisableHardwareNotification", "REG_DWORD", "1")

# Disable balloon in Adobe Reader to prevent 100% CPU spike
VSI_RegWrite("Workload", "HKEY_CURRENT_USER\Software\Adobe\Acrobat Reader\11.0\AVGeneral", "bReaderShouldShowInfoBubble", "REG_DWORD", "0")
VSI_RegWrite("Workload", "HKEY_CURRENT_USER\Software\Adobe\Acrobat Reader\11.0\AVGeneral", "bReaderShowCPDFToolsPaneInfoBubble", "REG_DWORD", "0")
VSI_RegWrite("Workload", "HKEY_CURRENT_USER\Software\Adobe\Acrobat Reader\11.0\AVGeneral", "bAppInitialized", "REG_DWORD", "1")
VSI_RegWrite("Workload", "HKEY_CURRENT_USER\Software\Adobe\Acrobat Reader\11.0\AVGeneral", "bReaderShowEPDFToolsPaneInfoBubble", "REG_DWORD", "0")
VSI_RegWrite("Workload", "HKEY_CURRENT_USER\Software\Adobe\Acrobat Reader\11.0\AVGeneral", "bReaderShowSignPaneInfoBubble", "REG_DWORD", "0")

# Overrule the Windows.Reader FTA with Adobe for Windows 8
VSI_RegWrite("Workload", "HKEY_CURRENT_USER\Software\Classes\AppX86746z2101ayy2ygv3g96e4eqdf8r99j\CLSID", "", "REG_SZ", "{B801CA65-A1FC-11D0-85AD-444553540000}")
VSI_RegWrite("Workload", "HKEY_CURRENT_USER\Software\Classes\AppX86746z2101ayy2ygv3g96e4eqdf8r99j\CurVer", "", "REG_SZ", "AcroExch.Document")

# Disable Doro PDF Writer auto updates
VSI_RegWrite("Workload", "HKEY_CURRENT_USER\Software\CompSoft\Doro", "Flags", "REG_DWORD", "18")

# Set flash security to allow accessing videos in VSIshare
VSI_FileWriteToLine("Workload", "%VSI_AppData%\Macromedia\Flash Player\#Security\FlashPlayerTrust\LoginVSI.txt", "1", "%VSI_Weblocation%")

# Start Word
App_Start("WordPrepare", "", "winword.exe", "Title", "Word")
App_Focus("WordPrepare", "Title", "Word", "", "Maximize")
App_Close("WordPrepare", "Title", "Word")

# Set the default printer to Doro PDF Writer
Set_DefaultPrinter("Workload", "Doro PDF Writer")

# Random wait before starting workload
Workload_RandomIdle("Workload", 5, %VSI_RandomInitialWait%, "Waiting to start workload")

# Set mouse position
VSI_Mouse_Position("Workload")

################################################################
##### 					Start segment 					   #####
################################################################
Segment("Workload", 1)

#############
VSI_Timer41()
#############

App_Start("Outlook", "%programfiles%\Microsoft Office\Office%VSI_Office_Version%", "Outlook.exe", "Title", "lang:Outlook:lang")
App_Focus("Outlook", "Title", "lang:Outlook:lang", "", "Maximize")

Web_Start_Random("IE1", "%VSI_WebLocation%", "BBC", "Website", %VSI_Web_BBC%)
App_Focus("IE1", "Title", "BBC", "", "Maximize")
VSI_Type_Fixed("IE1", "{home}")
VSI_Read2("IE1", 26, 5, 4, 5000, 1500, 750)

VSI_Random_File_Copy("Project1", "docx", "%VSI_Userhome%\Project1\1.docx", 1)
VSI_Random_File_Copy("Project1", "docx", "%VSI_Userhome%\Project1\2.docx", 1)
VSI_Random_File_Copy("Project1", "docx", "%VSI_Userhome%\Project1\3.docx", 1)
VSI_Random_File_Copy("Project1", "docx", "%VSI_Userhome%\Project1\4.docx", 1)

VSI_7Zip("Project1", "%VSI_Userhome%\Project1", "%VSI_Userhome%\Project1.zip", 9, 15)

VSI_ShellExecute("OutlookMSG", "Outlook.exe", "/a %VSI_Userhome%\Project1.zip")

App_Focus("OutlookMSG", "Title", "lang:OutlookMessage:lang")
VSI_Type_Fixed("OutlookMSG", "dummy")
VSI_Type_Fixed("OutlookMSG", "{tab}{tab}{tab}{tab}{tab}")
VSI_Type_Fixed("OutlookMSG", "Please check this out")
VSI_Sleep(1)
VSI_Type_Fixed("OutlookMSG", "^s")
App_Close("OutlookMSG", "Title", "lang:OutlookMessage:lang")

VSI_File_Delete("Project1", "%VSI_Userhome%\Project1.zip")
VSI_DirDelete("Project1", "%VSI_Userhome%\Project1")

App_Focus("Outlook", "Title", "lang:Outlook:lang", "", "Maximize")
VSI_Type_Fixed2("Outlook", "{down}{down}{down}", 5000, 0)

App_Focus("Outlook", "Title", "lang:Outlook:lang")
VSI_Type_Fixed2("Outlook", "{down}{down}{down}{down}", 5000)

App_Focus("Outlook", "Title", "lang:Outlook:lang")
VSI_Type_Fixed("Outlook", "^n")
App_Focus("Outlook", "Title", "lang:OutlookMessage:lang")
VSI_Type_Fixed("Outlook", "dummy")
VSI_Type_Fixed("Outlook", "{tab}{tab}{tab}{tab}{tab}")
VSI_Type_Time("Outlook", 10)
VSI_Type_Fixed("Outlook", "{ctrldown}s{ctrlup}")
VSI_Type_Time("Outlook", 10)
VSI_Type_Fixed("Outlook", "{ctrldown}s{ctrlup}")
VSI_Type_Time("Outlook", 7)
VSI_Type_Fixed("Outlook", "{ctrldown}s{ctrlup}")
VSI_Type_Time("Outlook", 20)
VSI_Sleep(1)
VSI_Type_Fixed("Outlook", "{ctrldown}s{ctrlup}")
VSI_Sleep(2)
VSI_Type_Fixed("Outlook", "{esc}")
VSI_Sleep(1)
App_Focus("Outlook", "Title", "lang:Outlook:lang")

#############
VSI_Timer41()
#############

VSI_Random_File_Copy("Project1", "pdf", "%VSI_Userhome%\Project1\1.pdf", 1)
VSI_Random_File_Copy("Project1", "pdf", "%VSI_Userhome%\Project1\2.pdf", 1)
VSI_Random_File_Copy("Project1", "pdf", "%VSI_Userhome%\Project1\3.pdf", 1)
VSI_Random_File_Copy("Project1", "pdf", "%VSI_Userhome%\Project1\4.pdf", 1)

VSI_7Zip("Project1", "%VSI_Userhome%\Project1", "%VSI_Userhome%\Project1.zip", 9, 15)

VSI_ShellExecute("OutlookMSG", "Outlook.exe", "/a %VSI_Userhome%\Project1.zip")

App_Focus("OutlookMSG", "Title", "lang:OutlookMessage:lang")
VSI_Type_Fixed("OutlookMSG", "dummy")
VSI_Type_Fixed("OutlookMSG", "{tab}{tab}{tab}{tab}{tab}")
VSI_Type_Fixed("OutlookMSG", "Please check this out")
VSI_Sleep(1)
VSI_Type_Fixed("OutlookMSG", "^s")
App_Close("OutlookMSG", "Title", "lang:OutlookMessage:lang")

VSI_File_Delete("Project1", "%VSI_Userhome%\Project1.zip")
VSI_DirDelete("Project1", "%VSI_Userhome%\Project1")

Workload_Idle("Idle", 20, "Getting a tripleshot cappucino", 1)

Web_Start_Random("IE2", "%VSI_WebLocation%", "TheVerge", "Website", %VSI_Web_TheVerge%)
App_Focus("IE2", "Title", "The Verge", "", "Maximize")
VSI_Read2("IE1", 39, 5, 4, 5000, 1500, 750)

App_Focus("Outlook", "Title", "lang:Outlook:lang")
VSI_Type_Fixed("Outlook", "^n")
App_Focus("Outlook", "Title", "lang:OutlookMessage:lang")
VSI_Type_Fixed("Outlook", "dummy")
VSI_Type_Fixed("Outlook", "{tab}{tab}{tab}{tab}{tab}")
VSI_Type_Time("Outlook", 10)
VSI_Type_Fixed("Outlook", "{ctrldown}s{ctrlup}")
VSI_Sleep(1)
VSI_Type_Time("Outlook", 5)
VSI_Type_Fixed("Outlook", "{ctrldown}s{ctrlup}")
VSI_Type_Time("Outlook", 10)
VSI_Type_Fixed("Outlook", "{ctrldown}s{ctrlup}")
VSI_Type_Time("Outlook", 10)
VSI_Type_Fixed("Outlook", "{ctrldown}s{ctrlup}")
VSI_Type_Time("Outlook", 10)
VSI_Type_Fixed("Outlook", "{ctrldown}s{ctrlup}")
VSI_Type_Time("Outlook", 10)
VSI_Type_Fixed("Outlook", "{ctrldown}s{ctrlup}")
VSI_Type_Time("Outlook", 10)
VSI_Type_Fixed("Outlook", "{ctrldown}s{ctrlup}")
VSI_Sleep(2)
VSI_Type_Fixed("Outlook", "{esc}")
VSI_Sleep(1)
App_Focus("Outlook", "Title", "lang:Outlook:lang")

#############
VSI_Timer41()
#############

VSI_Random_File_Copy("WinWord1Office", "doc", "%VSI_Userhome%\UserEdit1.doc")
App_Start("WinWord1Office", "", "%VSI_Userhome%\UserEdit1.doc", "Title", "UserEdit1")
App_Focus("WinWord1Office", "Title", "UserEdit1", "", "Maximize")

VSI_Read2("WinWord1Office", 20, 5, 4, 5000, 1500, 750)

VSI_Type_Time("WinWord1Office", 10)
VSI_Type_Fixed("WinWord1Office", "^s")
VSI_Type_Time("WinWord1Office", 5)
VSI_Type_Fixed("WinWord1Office", "^s")
VSI_Type_Time("WinWord1Office", 10)
VSI_Type_Fixed("WinWord1Office", "^s")

Workload_Idle("Idle", 20, "Talking to a colleague about some awesome stuff", 1)

VSI_Random_File_Copy("WinWord2Office", "doc", "%VSI_Userhome%\UserEdit2.doc")
App_Start("WinWord2Office", "", "%VSI_Userhome%\UserEdit2.doc", "Title", "UserEdit2")
App_Focus("WinWord2Office", "Title", "UserEdit2", "", "Maximize")
VSI_Type_Fixed("WinWord2Office", "^s")
VSI_Type_Time("WinWord2Office", 10)
VSI_Type_Fixed("WinWord2Office", "^s")
VSI_Type_Time("WinWord2Office", 10)
VSI_Type_Fixed("WinWord2Office", "^s")
VSI_Type_Time("WinWord2Office", 16)
VSI_Type_Fixed("WinWord2Office", "^s")

App_Focus("WinWord1Office", "Title", "UserEdit1")
VSI_Read2("WinWord1Office", 20, 5, 4, 5000, 1500, 750)
PDF_Print("PDFWriterOffice", "Doro PDF Writer", "%VSI_Userhome%\Output\Winword1Print.pdf", "Word")

App_Focus("Adobe", "Title", "Winword1Print.pdf")
VSI_Read2("Adobe", 20, 5, 4, 5000, 1500, 750)
App_Focus("Adobe", "Title", "Winword1Print.pdf")
App_Close("Adobe", "Title", "Winword1Print.pdf")

App_Focus("WinWord1Office", "Title", "UserEdit1", "", "Maximize")
App_Close("WinWord1Office", "Title", "UserEdit1")

#############
VSI_Timer41()
#############

VSI_Buffer("Workload", 30)


################################################################
##### 					Start segment 					   #####
################################################################
Segment("Workload", 2)

#############
VSI_Timer41()
#############

App_Focus("IE1", "Title", "BBC", "", "Maximize")
VSI_Type_Fixed("IE1", "{home}")
VSI_Read2("IE1", 30, 5, 4, 5000, 1500, 750)

VSI_Random_File_Copy("Project1", "docx", "%VSI_Userhome%\Project1\1.docx", 1)
VSI_Random_File_Copy("Project1", "docx", "%VSI_Userhome%\Project1\2.docx", 1)
VSI_Random_File_Copy("Project1", "docx", "%VSI_Userhome%\Project1\3.docx", 1)
VSI_Random_File_Copy("Project1", "docx", "%VSI_Userhome%\Project1\4.docx", 1)

VSI_7Zip("Project1", "%VSI_Userhome%\Project1", "%VSI_Userhome%\Project1.zip", 9, 15)
VSI_ShellExecute("OutlookMSG", "Outlook.exe", "/a %VSI_Userhome%\Project1.zip")

App_Focus("OutlookMSG", "Title", "lang:OutlookMessage:lang")
VSI_Type_Fixed("OutlookMSG", "dummy")
VSI_Type_Fixed("OutlookMSG", "{tab}{tab}{tab}{tab}{tab}")
VSI_Type_Fixed("OutlookMSG", "Please check this out")
VSI_Sleep(2)
VSI_Type_Fixed("OutlookMSG", "^s")
App_Close("OutlookMSG", "Title", "lang:OutlookMessage:lang")

VSI_File_Delete("Project1", "%VSI_Userhome%\Project1.zip")
VSI_DirDelete("Project1", "%VSI_Userhome%\Project1")

App_Focus("Outlook", "Title", "lang:Outlook:lang", "", "Maximize")

VSI_Type_Fixed("Outlook", "{down}{down}{down}{down}{up}{down}{down}{down}{down}{up}{up}", 3000, 0)

VSI_Random_File_Copy("Project1", "pdf", "%VSI_Userhome%\Project1\1.pdf", 1)
VSI_Random_File_Copy("Project1", "pdf", "%VSI_Userhome%\Project1\2.pdf", 1)
VSI_Random_File_Copy("Project1", "pdf", "%VSI_Userhome%\Project1\3.pdf", 1)
VSI_Random_File_Copy("Project1", "pdf", "%VSI_Userhome%\Project1\4.pdf", 1)

VSI_7Zip("Project1", "%VSI_Userhome%\Project1", "%VSI_Userhome%\Project1.zip", 9, 15)

VSI_ShellExecute("OutlookMSG", "Outlook.exe", "/a %VSI_Userhome%\Project1.zip")

App_Focus("OutlookMSG", "Title", "lang:OutlookMessage:lang")
VSI_Type_Fixed("OutlookMSG", "dummy")
VSI_Type_Fixed("OutlookMSG", "{tab}{tab}{tab}{tab}{tab}")
VSI_Type_Fixed("OutlookMSG", "Please check this out")
VSI_Sleep(1)
VSI_Type_Fixed("OutlookMSG", "^s")
App_Close("OutlookMSG", "Title", "lang:OutlookMessage:lang")

VSI_File_Delete("Project1", "%VSI_Userhome%\Project1.zip")
VSI_DirDelete("Project1", "%VSI_Userhome%\Project1")

App_Focus("IE2", "Title", "The Verge", "", "Maximize")
VSI_Type_Fixed("IE2", "{home}")
VSI_Read2("IE2", 32, 5, 4, 5000, 1500, 750)

#############
VSI_Timer41()
#############

VSI_random_File_Copy("Adobe1", "PDF", "%VSI_Userhome%\PDF1.pdf")
App_Start("Adobe1", "", "%VSI_Userhome%\PDF1.pdf", "Title", "PDF1")
App_Focus("Adobe1", "Title", "PDF1", "", "Maximize")
VSI_Type_Fixed("Adobe1", "^2")
VSI_Read2("Adobe1", 30, 5, 4, 5000, 1500, 750)

Workload_Idle("Idle", 20, "Telling a bad joke to a colleague", 1)

VSI_random_File_Copy("Adobe2", "PDF", "%VSI_Userhome%\PDF2.pdf")
App_Start("Adobe2", "", "%VSI_Userhome%\PDF2.pdf", "Title", "PDF2")
App_Focus("Adobe2", "Title", "PDF2", "", "Maximize")
VSI_Type_Fixed("Adobe2", "^2")
VSI_Read2("Adobe2", 40, 5, 4, 5000, 1500, 750)

VSI_Random_File_Copy("WinWord1Office", "doc", "%VSI_Userhome%\UserEdit1.doc")
App_Start("WinWord1Office", "", "%VSI_Userhome%\UserEdit1.doc", "Title", "UserEdit1")
App_Focus("WinWord1Office", "Title", "UserEdit1", "", "Maximize")
VSI_Read2("WinWord1Office", 39, 5, 4, 5000, 1500, 750)
VSI_Type_Time("WinWord1Office", 20)
VSI_Type_Fixed("WinWord1Office", "^s")
VSI_Type_Time("WinWord1Office", 10)
VSI_Type_Fixed("WinWord1Office", "^s")

App_Focus("Adobe2", "Title", "PDF2", "", "Maximize")
App_Close("Adobe2", "Title", "PDF2")

#############
VSI_Timer41()
#############

######## MICROSOFT POWERPOINT ACTIONS ########
VSI_random_File_Copy("PowerPoint1Office", "PPT", "%VSI_Userhome%\UserPresentation.ppt")
App_Start("PowerPoint1Office", "", "%VSI_Userhome%\UserPresentation.ppt", "Title", "UserPresentation")
App_Focus("PowerPoint1Office", "Title", "UserPresentation", "", "Maximize")

VSI_Type_Fixed("PowerPoint1Office","{f5}")
VSI_Sleep(3)

#Added more time from 34 to 64 to compensate with the vsi_read2 in Adobe2
VSI_Read2("PowerPoint1Office", 64, 5, 4, 5000, 1500, 750)
VSI_Type_Fixed("PowerPoint1Office","{esc}")

App_Focus("PowerPoint1Office", "Title", "UserPresentation")
VSI_Type_Fixed("PowerPoint1Office","{ctrldown}{end}{ctrlup}")
VSI_Type_Fixed("PowerPoint1Office","^m")
VSI_Type_Time("PowerPoint1Office", 10)
VSI_Type_Fixed("PowerPoint1Office","{ctrldown}{enter}{ctrlup}")
VSI_Type_Time("PowerPoint1Office", 10)
App_Focus("PowerPoint1Office", "Title", "UserPresentation")
VSI_Type_Fixed("PowerPoint1Office","^m")
VSI_Type_Fixed("PowerPoint1Office","{ctrldown}{enter}{ctrlup}")
VSI_Type_Time("PowerPoint1Office", 10)
App_Focus("PowerPoint1Office", "Title", "UserPresentation")

App_Focus("PowerPoint1Office", "Title", "UserPresentation")

#Removed because of stuck sessions
#PDF_Print("PDFWriterOffice", "Doro PDF Writer", "%VSI_Userhome%\Output\PWP1Print.pdf", "PowerPoint")

VSI_Sleep(2)
App_Focus("PowerPoint1Office", "Title", "UserPresentation")
VSI_Save("PowerPoint1Office", "{ctrldown}s{ctrlup}", "%VSI_Userhome%\UserPresentation.ppt")

Workload_Idle("Idle", 20, "Getting a Coke from the fridge", 1)

App_Focus("WinWord1Office", "Title", "UserEdit1", "", "Maximize")
App_Close("WinWord1Office", "Title", "UserEdit1")

# Removed because of printing part
#App_Focus("Adobe", "Title", "PWP1Print.pdf")
#VSI_Read2("Adobe", 34, 5, 4, 5000, 1500, 750)
#App_Close("Adobe", "Title", "PWP1Print.pdf")

#############
VSI_Timer41()
#############

VSI_Buffer("Workload", 30)


################################################################
##### 					Start segment 					   #####
################################################################
Segment("Workload", 3)

#############
VSI_Timer41()
#############

App_Focus("IE1", "Title", "BBC", "", "Maximize")
VSI_Type_Fixed("IE1", "{home}")
VSI_Read2("IE1", 30, 5, 4, 5000, 1500, 750)

VSI_Random_File_Copy("Project1", "docx", "%VSI_Userhome%\Project1\1.docx", 1)
VSI_Random_File_Copy("Project1", "docx", "%VSI_Userhome%\Project1\2.docx", 1)
VSI_Random_File_Copy("Project1", "docx", "%VSI_Userhome%\Project1\3.docx", 1)
VSI_Random_File_Copy("Project1", "docx", "%VSI_Userhome%\Project1\4.docx", 1)

VSI_7Zip("Project1", "%VSI_Userhome%\Project1", "%VSI_Userhome%\Project1.zip", 9, 15)
VSI_ShellExecute("OutlookMSG", "Outlook.exe", "/a %VSI_Userhome%\Project1.zip")

App_Focus("OutlookMSG", "Title", "lang:OutlookMessage:lang")
VSI_Type_Fixed("OutlookMSG", "dummy")
VSI_Type_Fixed("OutlookMSG", "{tab}{tab}{tab}{tab}{tab}")
VSI_Type_Fixed("OutlookMSG", "Please check this out")
VSI_Sleep(1)
VSI_Type_Fixed("OutlookMSG", "^s")
App_Close("OutlookMSG", "Title", "lang:OutlookMessage:lang")

VSI_File_Delete("Project1", "%VSI_Userhome%\Project1.zip")
VSI_DirDelete("Project1", "%VSI_Userhome%\Project1")

App_Focus("Outlook", "Title", "lang:Outlook:lang", "", "Maximize")

VSI_Type_Fixed2("Outlook", "{down}{down}{down}{down}{down}{down}", 3000, 0)

VSI_Random_File_Copy("Project1", "pdf", "%VSI_Userhome%\Project1\1.pdf", 1)
VSI_Random_File_Copy("Project1", "pdf", "%VSI_Userhome%\Project1\2.pdf", 1)
VSI_Random_File_Copy("Project1", "pdf", "%VSI_Userhome%\Project1\3.pdf", 1)
VSI_Random_File_Copy("Project1", "pdf", "%VSI_Userhome%\Project1\4.pdf", 1)

VSI_7Zip("Project1", "%VSI_Userhome%\Project1", "%VSI_Userhome%\Project1.zip", 9, 15)

VSI_ShellExecute("OutlookMSG", "Outlook.exe", "/a %VSI_Userhome%\Project1.zip")

App_Focus("OutlookMSG", "Title", "lang:OutlookMessage:lang")
VSI_Type_Fixed("OutlookMSG", "dummy")
VSI_Type_Fixed("OutlookMSG", "{tab}{tab}{tab}{tab}{tab}")
VSI_Type_Fixed("OutlookMSG", "Please check this out")
VSI_Sleep(1)
VSI_Type_Fixed("OutlookMSG", "^s")
App_Close("OutlookMSG", "Title", "lang:OutlookMessage:lang")

VSI_File_Delete("Project1", "%VSI_Userhome%\Project1.zip")
VSI_DirDelete("Project1", "%VSI_Userhome%\Project1")

App_Focus("IE2", "Title", "The Verge", "", "Maximize")
VSI_Type_Fixed("IE2", "{home}")
VSI_Read2("IE2", 60, 5, 4, 5000, 1500, 750)

#############
VSI_Timer41()
#############

Workload_Idle("Idle", 20, "Thinking about the way the cookie crumbles", 1)

######## MICROSOFT EXCEL ACTIONS ########
VSI_random_File_Copy("Excel1", "XLSX", "%VSI_Userhome%\Spreadsheet.xlsx")
App_Start("Excel1", "", "%VSI_Userhome%\Spreadsheet.xlsx", "Title", "Spreadsheet")
App_Focus("Excel1", "Title", "Spreadsheet", "", "Maximize")
VSI_Type_Fixed("Excel1","{f5}")
App_Focus("Excel1", "Title", "lang:ExcelGoto:lang")
VSI_Type_Fixed("Excel1","A1{enter}{esc}{esc}")

App_Focus("Excel1", "Title", "Spreadsheet")
VSI_Type_Fixed("Excel1","^s{ctrldown}s{ctrlup}")
VSI_Type_Fixed("Excel1","=(98*323){+}(312*97){enter}{ctrldown}s{ctrlup}")
VSI_Sleep(1)

App_Focus("Excel1", "Title", "Spreadsheet")
VSI_Type_Fixed("Excel1","{f5}")
App_Focus("Excel1", "Title", "lang:ExcelGoto:lang")
VSI_Type_Fixed("Excel1","X650{enter}{esc}{esc}")
VSI_Sleep(1)

VSI_Browse("Excel1", 10, 600, 15, 1, 500, 3750, 500, 3)
VSI_Type_Fixed("Excel1", "{home}{end}{right}", 300)
VSI_Sleep(1)
VSI_Browse("Excel1", 6, 23, 15, 1, 500, 3750, 500, 4)

App_Focus("Excel1", "Title", "Spreadsheet")
VSI_Type_Fixed("Excel1","^s{ctrldown}s{ctrlup}")
VSI_Type_Fixed("Excel1","243789897324987238991{enter}")
VSI_Type_Fixed("Excel1","^s{ctrldown}s{ctrlup}")
VSI_Sleep(1)

VSI_Sleep(2)
App_Focus("Excel1", "Title", "Spreadsheet")
VSI_Save("Excel1","{ctrldown}s{ctrlup}", "%VSI_Userhome%\Spreadsheet.xlsx")
App_Focus("Outlook", "Title", "lang:Outlook:lang", "", "Maximize")

VSI_Type_Fixed("Outlook", "{down}{down}", 3000, 0)

App_Focus("IE1", "Title", "BBC", "", "Maximize")
VSI_Type_Fixed("IE1", "{home}")
VSI_Read2("IE1", 28, 15, 4, 5000, 1500, 750)

App_Focus("IE2", "Title", "The Verge", "", "Maximize")
VSI_Type_Fixed("IE2", "{home}")
VSI_Read2("IE2", 13, 5, 4, 5000, 1500, 750)

######## FREEMIND ACTIONS ########
VSI_random_File_Copy("Freemind1", "MM", "%VSI_Userhome%\UserMindmap.mm")
App_Start("Freemind1", "", "%VSI_Userhome%\UserMindmap.mm", "Title", "UserMindmap.mm")
App_Focus("Freemind1", "Title", "UserMindmap.mm", "", "Maximize")
VSI_Type_Fixed("Freemind1", "{esc}{esc}")
VSI_Sleep(1)
VSI_Type_Fixed("Freemind1", "{right}{up}{up}{right}{right}", 500)
VSI_Sleep(2)
VSI_Type_Fixed("Freemind1", "{esc}")
VSI_Sleep(1)
VSI_Type_Fixed("Freemind1", "{left}{up}{up}{left}{left}{up}", 500)
VSI_Sleep(3)
VSI_Type_Fixed("Freemind1","^s")

VSI_Type_Fixed("Freemind1","{insert}")
VSI_Type_Time("Freemind1", "18", "170")
VSI_Type_Fixed("Freemind1","^s")
VSI_Type_Fixed("Freemind1", "{enter}{enter}{esc}")

#############
VSI_Timer41()
#############

App_Focus("Freemind1", "Title", "UserMindmap.mm")
VSI_Type_Fixed("Freemind1","^s")
VSI_Type_Fixed("Freemind1", "{esc}{esc}{esc}")
VSI_Sleep(1)
VSI_Type_Fixed("Freemind1", "{right}{down}{down}{down}{right}{right}{down}{down}{right}{right}{right}{right}{down}", 500)
VSI_Sleep(3)

Workload_Idle("Idle", 10, "Spinning around on the chair", 1)

VSI_Type_Fixed("Freemind1","{insert}")
VSI_Type_Time("Freemind1", "20", "170")
VSI_Type_Fixed("Freemind1", "{enter}{enter}{esc}")
App_Focus("Freemind1", "Title", "UserMindmap.mm")
VSI_Type_Fixed("Freemind1", "{esc}{esc}{esc}")
App_Focus("Freemind1", "Title", "UserMindmap.mm")
VSI_Save("Freemind1", "{ctrldown}s{ctrlup}", "%VSI_Userhome%\UserMindmap.mm")
VSI_Sleep(3)

VSI_Random_File_Copy("WinWord2Office", "doc", "%VSI_Userhome%\UserEdit2.doc")
App_Start("WinWord2Office", "", "%VSI_Userhome%\UserEdit2.doc", "Title", "UserEdit2")
App_Focus("WinWord2Office", "Title", "UserEdit2", "", "Maximize")
VSI_Type_Time("WinWord2Office", 20)
VSI_Type_Fixed("WinWord2Office", "^s")
VSI_Type_Time("WinWord2Office", 20)
VSI_Type_Fixed("WinWord2Office", "^s")
VSI_Type_Time("WinWord2Office", 10)
VSI_Type_Fixed("WinWord2Office", "^s")
VSI_Type_Time("WinWord2Office", 20)
VSI_Type_Fixed("WinWord2Office", "^s")
VSI_Type_Time("WinWord2Office", 30)
VSI_Type_Fixed("WinWord2Office", "^s")
App_Close("WinWord2Office", "Title", "UserEdit2")

Workload_Idle("Idle", 10, "Mindmapping", 1)

App_Focus("Freemind1", "Title", "UserMindmap.mm")
PDF_Print("PDFWriter", "Doro PDF Writer", "%VSI_Userhome%\Output\Freemind1Print.pdf", "FreeMind")

App_Focus("Adobe", "Title", "Freemind1Print.pdf")
App_Close("Adobe", "Title", "Freemind1Print.pdf")

#############
VSI_Timer41()
#############

VSI_Buffer("Workload", 30)

################################################################
##### 					Start segment 					   #####
################################################################
Segment("Workload", 4)

#############
VSI_Timer41()
#############

App_Focus("IE1", "Title", "BBC", "", "Maximize")
VSI_Type_Fixed("IE1", "{home}")
VSI_Read2("IE1", 18, 5, 4, 5000, 1500, 750)
Web_Quit("IE1")

VSI_Random_File_Copy("Project1", "docx", "%VSI_Userhome%\Project1\1.docx", 1)
VSI_Random_File_Copy("Project1", "docx", "%VSI_Userhome%\Project1\2.docx", 1)
VSI_Random_File_Copy("Project1", "docx", "%VSI_Userhome%\Project1\3.docx", 1)
VSI_Random_File_Copy("Project1", "docx", "%VSI_Userhome%\Project1\4.docx", 1)

VSI_7Zip("Project1", "%VSI_Userhome%\Project1", "%VSI_Userhome%\Project1.zip", 9, 15)
VSI_ShellExecute("OutlookMSG", "Outlook.exe", "/a %VSI_Userhome%\Project1.zip")

App_Focus("OutlookMSG", "Title", "lang:OutlookMessage:lang")
VSI_Type_Fixed("OutlookMSG", "dummy")
VSI_Type_Fixed("OutlookMSG", "{tab}{tab}{tab}{tab}{tab}")
VSI_Type_Fixed("OutlookMSG", "Please check this out")
VSI_Sleep(1)
VSI_Type_Fixed("OutlookMSG", "^s")
App_Close("OutlookMSG", "Title", "lang:OutlookMessage:lang")

VSI_File_Delete("Project1", "%VSI_Userhome%\Project1.zip")
VSI_DirDelete("Project1", "%VSI_Userhome%\Project1")

App_Focus("Outlook", "Title", "lang:Outlook:lang", "", "Maximize")

VSI_Type_Fixed2("Outlook", "{down}{down}{down}{down}", 3000, 0)

VSI_Random_File_Copy("Project1", "pdf", "%VSI_Userhome%\Project1\1.pdf", 1)
VSI_Random_File_Copy("Project1", "pdf", "%VSI_Userhome%\Project1\2.pdf", 1)
VSI_Random_File_Copy("Project1", "pdf", "%VSI_Userhome%\Project1\3.pdf", 1)
VSI_Random_File_Copy("Project1", "pdf", "%VSI_Userhome%\Project1\4.pdf", 1)

VSI_7Zip("Project1", "%VSI_Userhome%\Project1", "%VSI_Userhome%\Project1.zip", 9, 15)

VSI_ShellExecute("OutlookMSG", "Outlook.exe", "/a %VSI_Userhome%\Project1.zip")

App_Focus("OutlookMSG", "Title", "lang:OutlookMessage:lang")
VSI_Type_Fixed("OutlookMSG", "dummy")
VSI_Type_Fixed("OutlookMSG", "{tab}{tab}{tab}{tab}{tab}")
VSI_Type_Fixed("OutlookMSG", "Please check this out")
VSI_Sleep(1)
VSI_Type_Fixed("OutlookMSG", "^s")
App_Close("OutlookMSG", "Title", "lang:OutlookMessage:lang")

VSI_File_Delete("Project1", "%VSI_Userhome%\Project1.zip")
VSI_DirDelete("Project1", "%VSI_Userhome%\Project1")

######## PHOTO VIEWER ACTIONS ########
App_Start("PhotoViewer", "%TEMP%\VSI\RunTime\Lib", "VSIPictureViewer.exe", "Title", "VSI Picture Viewer", "", "%VSI_GroupDrive%\jpg\%VSI_Random_jpg%")
App_Focus("PhotoViewer", "Title", "VSI Picture Viewer", "", "Maximize")
VSI_Browse("PhotoViewer", 28, 500, 1, 0, 3000, 50, 50, 2)
App_Close("PhotoViewer","Title","VSI Picture Viewer")
VSI_Sleep(1)

App_Focus("IE2", "Title", "The Verge", "", "Maximize")
VSI_Type_Fixed("IE2", "{home}")
VSI_Read2("IE2", 20, 5, 4, 5000, 1500, 750)

#############
VSI_Timer41()
#############

Web_Start_random("IE1", "%VSI_WebLocation%\Player", "720p", Video, %VSI_Web_Player%)
App_Focus("IE1","Title", "Video Player", "", "Maximize")
VSI_Sleep(50)
Web_Quit("IE1")

App_Focus("IE2", "Title", "The Verge", "", "Maximize")
VSI_Type_Fixed("IE2", "{home}")
VSI_Read2("IE2", 26, 5, 4, 5000, 1500, 750)
Web_Quit("IE2")

Workload_Idle("Idle", 20, "Walking around in the office", 1)

App_Focus("Outlook", "Title", "lang:Outlook:lang")
VSI_Type_Fixed("Outlook", "^n")
App_Focus("Outlook", "Title", "lang:OutlookMessage:lang")
VSI_Type_Fixed("Outlook", "dummy")
VSI_Type_Fixed("Outlook", "{tab}{tab}{tab}{tab}{tab}")
VSI_Type_Time("Outlook", 20)
VSI_Type_Fixed("Outlook", "{tab}{tab}{enter}")
VSI_Sleep(1)
VSI_Type_Fixed("Outlook", "{ctrldown}s{ctrlup}")
VSI_Sleep(2)
VSI_Type_Fixed("Outlook", "{esc}{esc}{esc}")
VSI_Sleep(1)

Web_Start_random("IE1", "%VSI_WebLocation%\Player", "720p", Video, %VSI_Web_Player%)
App_Focus("IE1","Title", "Video Player", "", "Maximize")
VSI_Sleep(50)
Web_Quit("IE1")



#############
VSI_Timer41()
#############

Workload_Idle("Idle", 20, "Getting a phone call", 1)

Web_Start_random("IE1", "%VSI_WebLocation%\Player", "720p", Video, %VSI_Web_Player%)
App_Focus("IE1","Title", "Video Player", "", "Maximize")
VSI_Sleep(50)
Web_Quit("IE1")

VSI_Random_File_Copy("WinWord1Office", "doc", "%VSI_Userhome%\UserEdit1.doc")
App_Start("WinWord1Office", "", "%VSI_Userhome%\UserEdit1.doc", "Title", "UserEdit1")
App_Focus("WinWord1Office", "Title", "UserEdit1", "", "Maximize")
VSI_Read2("WinWord1Office", 24, 5, 4, 5000, 1500, 750)
VSI_Type_Fixed("WinWord1Office", "^s")
App_Focus("WinWord1Office", "Title", "UserEdit1", "", "Maximize")

VSI_Random_File_Copy("WinWord2Office", "doc", "%VSI_Userhome%\UserEdit2.doc")
App_Start("WinWord2Office", "", "%VSI_Userhome%\UserEdit2.doc", "Title", "UserEdit2")
App_Focus("WinWord2Office", "Title", "UserEdit2", "", "Maximize")
VSI_Type_Time("WinWord2Office", 24)
VSI_Type_Fixed("WinWord2Office", "^s")
App_Focus("WinWord2Office", "Title", "UserEdit2", "", "Maximize")
App_Close("WinWord2Office", "Title", "UserEdit2")



App_Focus("WinWord1Office", "Title", "UserEdit1")
PDF_Print("PDFWriterOffice", "Doro PDF Writer", "%VSI_Userhome%\Output\Winword1Print.pdf", "Word")
App_Focus("WinWord1Office", "Title", "UserEdit1", "", "Maximize")
VSI_Type_Fixed("WinWord1Office", "^s")
App_Close("WinWord1Office", "Title", "UserEdit1")

App_Focus("Freemind1", "Title", "UserMindmap.mm")
VSI_Type_Fixed("Freemind1", "{esc}{esc}{esc}")
App_Focus("Freemind1", "Title", "UserMindmap.mm")

VSI_Sleep(1)
App_Close("Freemind1", "Title", "UserMindmap.mm")

#############
VSI_Timer41()
#############

App_Focus("Adobe", "Title", "Winword1Print.pdf")
App_Close("Adobe", "Title", "Winword1Print.pdf")

App_Close("Outlook", "Title", "lang:Outlook:lang")

App_Focus("Excel1", "Title", "Spreadsheet")
VSI_Save("Excel1","{ctrldown}s{ctrlup}", "%VSI_Userhome%\Spreadsheet.xlsx")
App_Close("Excel1", "Title", "Spreadsheet")

App_Focus("Adobe1", "Title", "PDF1", "", "Maximize")
App_Close("Adobe1", "Title", "PDF1")

App_Focus("PowerPoint1Office", "Title", "UserPresentation")
VSI_Sleep(2)

VSI_Save("PowerPoint1Office", "{ctrldown}s{ctrlup}", "%VSI_Userhome%\UserPresentation.ppt")
App_Close("PowerPoint1Office", "Title", "UserPresentation")

VSI_Buffer("Workload", 30)

```

We hope this provides enough insights into the testing methodology used in the {{site.title}} lab environment. If you have any comments or question please leave them below.

Photo by [Veri Ivanova](https://unsplash.com/photos/p3Pj7jOYvnM?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"} on [Unsplash](https://unsplash.com/search/photos/stopwatch?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText){:target="_blank"}
