# packer-cloudbase-init

repoduction of issue with packer and cloudbase-init:


Set up environment variables for packer variables:
```
       "azure_location": "{{env `AZURE_LOCATION`}}",
        "subscription_id": "{{env `AZURE_SUBSCRIPTION_ID`}}",
        "client_id": "{{env `AZURE_CLIENT_ID`}}",
        "client_secret": "{{env `AZURE_CLIENT_SECRET`}}",
        "resource_group_name": "{{env `RESOURCE_GROUP_NAME`}}",
        "storage_account_name": "{{env `STORAGE_ACCOUNT_NAME`}}",
```

```
#run packer
packer build windows.json
# lots of output

# create vm with image from packer
az vm create -l westus2 -g test-cluster-api-images -n cbi-1 --image /subscriptions/b9dsdf07/resourceGroups/test-cluster-api-images/providers/Microsoft.Compute/images/capi-1601332624  --admin-user 'azureuser' --custom-data ~/customdata.text
Deployment failed. Correlation ID: 2eabd6-5c91-480b-b1a4-7b929368. {
  "status": "Failed",
  "error": {
    "code": "ResourceDeploymentFailure",
    "message": "The resource operation completed with terminal provisioning state 'Failed'.",
    "details": [
      {
        "code": "OSProvisioningClientError",
        "message": "OS provisioning for VM 'cbi-1' failed. Error details: This installation of Windows is undeployable. Make sure the image has been properly prepared (generalized).\r\nInstructions for Windows: https://azure.microsoft.com/documentation/articles/virtual-machines-windows-upload-image/ "
      }
```
