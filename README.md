# soos-digitalocean-dast-droplet
The DigitalOcean droplet definition for one-click SOOS DAST scanning

## Updating the image

### Deploy a DigitalOcean Droplet

[Create the initial Droplet](https://cloud.digitalocean.com/droplets/new) from the existing Ubuntu 20.04 image.

Use the basic 5/mo plan.

### Copy Repository Files
Push the src files from this repository to /usr/tmp/soos-dast. Use scp or WinSCP etc. to transfer files.

Ensure the directory exists first, by running:

```
mkdir -p /usr/tmp/soos-dast
```

### Install Packer
Install packer (which will verify and build the image)

```
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install packer
```

### Export DigitalOcean API Token
Export the environment varible for the API token that allows the snapshot to be pushed to DigitalOcean

```
export DIGITALOCEAN_TOKEN={token}
```

### Make your template changes and Verify
Make the changes you need to the scripts and marketplace template json.

Then move to the /usr/tmp directory:
```
cd /usr/tmp
```

Verify the template:
```
packer validate soos-dast/marketplace-image.json
```

Build the template:
```
packer build soos-dast/marketplace-image.json
```

(and then go get a coffee - it takes a few minutes :) )

### Test the Snapshot
Create a droplet from the new snapshot image.

Go to [Create Droplet](https://cloud.digitalocean.com/droplets/new) and choose Snapshots as the image source.

You should see your timestamped image in the list.



## Links:
[DigitalOcean Marketplace Partner Tools](https://github.com/digitalocean/marketplace-partners)

[DigitalOcean Vendor Guidelines and Resources](https://marketplace.digitalocean.com/vendors/guidelines-resources#droplet-1-click-apps)
