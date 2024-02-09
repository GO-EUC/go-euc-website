---
layout: post
toc: true
title:  "Terraform: NetScaler Deployment"
hidden: false
authors: [mick]
categories: [ 'Development' ]
tags: [ 'NetScaler', 'Terraform', 'Citrix', 'Automation', 'Best Practice']
image: assets/images/posts/108-terraform-netscaler-deployment/terraform-netscaler-deployment.png
---

# Terraform: NetScaler Deployment
GO-EUC publishes & uses NetScaler deployments with best practice settings. Please mind that best practice is not always 'best solution', especially in research.
These settings should assist you in getting a solid out of the box deployment going, that is easily re-deployable.
The code is capable of both deployment and configuration.
You can find the complete repository [here](https://github.com/GO-EUC/go-euc-lab/tree/develop/terraform/citrix-adc){:target="_blank"}.

Sleep deprived contributors:
[Sven Jansen] (https://www.linkedin.com/in/sven-jansen-b763b654/)
[Mick Hilhorst] (https://www.linkedin.com/in/mick-hilhorst/)

#### Please review the tables for an updated overview.

| Deployment Type | Supported |
| -------- | ------- |
| ESXI     | ✅      |
| Azure    | Planned |
| AWS      | Planned |

## Prerequisites

#### NetScaler
A NetScaler would be advised.

#### Credentials
Administrative credentials for the NetScaler are required.

#### A  `.tfvar` file
Please find the `.tfvar` file example [here](#tfvar){:target="_blank"}.

#### License
A license is required for some deployment types, but freemium is supported.
Depending on your license type, you need to edit the `.tfvar` (see example) boolean value:

```
base_configuration = ({
  # Deploy advanced features (if licensed with advanced or above only!)
  advanced = true
})
```
| Deployment Type | Supported | Advanced Boolean Value|
| -------- | ------- | ------- |
| Freemium    | ✅ | False
| Standard    | ✅ | False
| Advanced    | ✅ | True
| Premium    | ✅ | True


## Architecture

The goal of the Terraform code's architecture is to give flexibility and provide a baseline best practice deployment. Your needs can differ if you want to use this code for production deployments, but it should provide a good start if you want to create a custom deployment.
### Variables
The goal of the Terraform code's architecture is to give flexibility and provide a baseline best practice deployment. Your needs can differ if you want to use this code for production deployments, but it should provide a good start if you want to create a custom deployment.

Throughout the code,  a `.tfvar` file will be used. A baseline `.tfvar` file will be [supplied in this article](#tfvar){:target="_blank"}.  It's adviced to use this approach as it makes it easy to create multiple deployments. If you are not familiair with `.tfvar` files, please review the [official terraform documentation.](https://developer.hashicorp.com/terraform/language/values/variables)


We want to maintain a proper code base where reproducability is at the core. It needs to be easy to use and edit for the sake of research. 



### NetScaler Settings

The code deploys best practices out of the box. Please find the tables / documentation below.

#### NetScaler Modes (Enabled / Disabled)
| Mode | Default | Actual|
| -------- | ------- | ------- |
| Fast Ramp    | ✅ | ✅
| Use Source IP    | ❌ | ❌
| TCP Buffering    | ❌ | ❌
| Edge Configuration    | ✅ | ✅
| Layer 3 Mode    | ✅ | ❌
| Static Route Advertisement   | ❌ | ❌
| Intranet Route Advertisement   | ❌ | ❌
| IPv6 Route Advertisement   | ❌ | ❌
| Media Classification   | ❌ | ❌
| Layer 2 Mode   | ❌ | ❌
| Client side Keep Alive  | ❌ | ❌
| MAC based forwarding   | ❌ | ❌
| Use Subnet IP   | ✅ | ✅
| Path MTU Discovery   | ✅ | ✅
| Direct Route Advertisement   | ❌ | ❌
| IPv6 Static Route Advertisement   | ❌ | ❌
| Bridge BPDUs   | ❌ | ❌
| ULFD   | ❌ | ❌

### Provided Templates

|.TFVAR Templates|
|-----------------------|
|VSphere (ESXI) Deployment |
|Hostname / Timezone etc|
|License Deployment |
|NSIP / SNIP Setup |
|Service Creation |
|Service Group Creation | 
|Virtual Server Creation|
|Gateway Creation |
|Advanced Authentication Policies|

|Other Templates|
|-----------------------|
|Lets Encrypt Setup (present in module)|



# <a name="tfvar"></a> .tfvar example


```
#####################################################
Global Flow Control
#####################################################
# Global deployments settings for deployment logic
terraform_settings = ({
  # Deploy NetScaler to vSphere
  deploy_vsphere = false
  # Deploy NetScaler configuration
  deploy_settings = false
  # Deploy Lets Encrypt on NetScaler
  deploy_letsencrypt = false
})

# Login Information for the NetScaler to authenticate API calls
logon_information = ({
  host     = "https://yourIP"
  username = "nsroot"
  password = "nsroot"
})

#####################################################
Optional: Vsphere deployment 
#####################################################
# Variables for the NetScaler VM deployment in vSphere
vsphere = ({
  server       = "xxx.xxx.xxx.xxx"
  user         = "administrator@vsphere.local"
  password     = "password"
  datacenter   = "Datacenter"
  host         = "xxx.xxx.xxx.xxx"
  datastore    = "datastore1"
  network      = "VM Network"
  timezone     = "GMT+02:00-CEST-Europe/Berlin"
  resourcepool = "ResourcePool"
})


# NetScaler VM Details
vm = ({
  ovf     = "./Resources/OVF/your.ovf"
  network = "VM Network"
  mac     = "00:00:00:aa:bb:cc"
  ip      = "xxx.xxx.xxx.xxx"
  gateway = "xxx.xxx.xxx.xxx"
  netmask = "255.255.255.0"
  name    = "adc1"
})


##################################################### 
NetScaler configuration only
###############################################

# Base uncategorized configuration variables
base_configuration = ({
  # NetScaler hostname
  hostname = "GOEUC-ADC-01"
  # Timezone to be set in the NetScaler
  timezone = "GMT+02:00-CEST-Europe/Berlin"
  # Prefix/Suffix for profile names in the NetScaler
  environment_prefix = "GO-EUC"
  # Deploy advanced features (if licensed with advanced or above only!)
  advanced = true


})

# Automate license deployment
license = ({
  filename = "FID_licensename.lic"
  filecontent = "./Resources/License/FID_licensename.lic"
})


# NetScaler Default Subnet IP data
base_configuration_snip = ({
  ip_address = "192.168.1.249"
  netmask    = "255.255.255.0"
  icmp       = "ENABLED"
})


# All the backend services to be created
servers = {
  srv_storefront01 = {
    hostname   = "srv_storefront01"
    ip_address = "192.168.1.10"
  }

  srv_storefront02 = {
    hostname   = "srv_storefront02"
    ip_address = "192.168.1.11"
  }

  srv_dc01 = {
    hostname   = "srv_dc01"
    ip_address = "192.168.1.12"
  }

  srv_dc02 = {
    hostname   = "srv_dc02"
    ip_address = "192.168.1.13"
  }
}

# all the service groups to be created 
service_groups = {
  svcg_storefront = {
    name = "svcg_storefront"
    type = "HTTP"
    port = "80"
    # Define backend servers: Name + port + weight
    servers_to_bind = ["srv_storefront01:80:1", "srv_storefront02:80:2"]
    # Define the virtual servers to bind this service group to:
    virtual_server_bindings = ["lb_storefront"]
  }

  svcg_dc = {
    name = "svcg_ldaps"
    type = "SSL_TCP"
    port = "636"
    # Define backend servers to be included in the servicegroup: Name + port + weight
    servers_to_bind = ["srv_dc01:636:1", "srv_dc02:636:1"]
    # Define the virtual servers to bind this service group to:
    virtual_server_bindings = ["lb_ldaps"]
  }
}


# All the virtual servers to be created 
virtual_servers = {
  #Example server, would still require a certificate / backend
  lb_ldaps = {
    name            = "lb_ldaps"
    servicetype     = "SSL_TCP"
    ipv46           = "192.168.176.142"
    port            = "636"
    lbmethod        = "ROUNDROBIN"
    persistencetype = "SOURCEIP"
    timeout         = "180"
    sslprofile      = "ssl_prof_GO-EUC_fe_TLS1213"
    tcpprofilename  = "tcp_prof_GO-EUC"
  }

  lb_storefront = {
    name            = "lb_storefront"
    servicetype     = "HTTP"
    ipv46           = "192.168.176.143"
    port            = "80"
    lbmethod        = "ROUNDROBIN"
    persistencetype = "SOURCEIP"
    timeout         = "180"
    sslprofile      = "ssl_prof_GO-EUC_fe_TLS1213"
    httpprofilename = "http_prof_GO-EUC"
    tcpprofilename  = "tcp_prof_GO-EUC"
  }
}

# The settings for an LDAPS policy/action with global binding
auth_ldaps = {
  action_name        = "act_ldaps"
  policy_name        = "pol_auth_ldaps"
  policy_expression  = "True"
  serverip           = "192.168.176.142"
  serverport         = "636"
  sectype            = "SSL"
  authtimeout        = "1"
  ldaploginname      = "username"
  ldapbase           = "dc=go-euc,dc=local"
  ldapbinddn         = "CN=Administrator,CN=Users,DC=go-euc,DC=local"
  ldapbinddnpassword = "Password1!"

}

gateway = {
  name          = "gw_go-euc"
  servicetype   = "SSL"
  ipv46         = "192.168.176.199"
  port          = "443"
  dtls          = "OFF"
  sta           = "192.168.150.2"
  storefronturl = "https://storefront.go-euc.local/Citrix/StoreWeb"
}
```

Photo by <a href="https://unsplash.com/@clemhlrdt?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Clément Hélardot</a> on <a href="https://unsplash.com/photos/black-and-silver-laptop-computer-on-table-95YRwf6CNw8?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a>
  
