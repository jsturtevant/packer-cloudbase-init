# packer-cloudbase-init

Simple packer example for cloudbase-init on Azure.

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
```

# Notes
The Cloudbase init configuration are from the example: https://github.com/cloudbase/windows-openstack-imaging-tools/tree/master/Examples/config/azure