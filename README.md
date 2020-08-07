# Setting up a cluster

## Switching from Docker to VMWare

On Windows
- Enabling docker `bcdedit /set hypervisorlaunchtype auto`
- Enabling VMWare `bcdedit /set hypervisorlaunchtype off`

## VMWare encountered issues

- In case VM tools is not working after install `sudo systemctl restart open-vm-tools.service`

## Installing new parcel / service in cloudera

See [here](https://docs.cloudera.com/documentation/spark2/latest/topics/spark2_installing.html) for the official doc (i.e., upgrading Spark).

In summary:
- Remove the old service descriptor JAR from `/opt/cloudera/csd`
- Download and add the service descriptor (CDS) JAR to `/opt/cloudera/csd`
- Set correct permissions `644` and ownership `cloudera-scm:cloudera-scm`
- Restart the cloudera-scm-server service
    - `sudo systemctl restart cloudera-scm-server`, or
    - `sudo service cloudera-scm-server restart`
- In Cloudera Manager, deactivate the parcel corresponding to the older version of CDS
- In Cloudera Manager, distribute and activate the parcel corresponding to the new CDS
- Restart services and deploy the client configurations

## Docker image for travis

    apt update && apt install --yes rubygems build-essential ruby-full git
    gem install travis
    git clone GIT_REPO
    cd REPO_FOLDER/
    travis login --pro
    travis encrypt --pro 
    travis lint --pro .travis.yml
