# Docker configuration for big data

It includes:

- Spark
- Python
- Zeppelin

## Switching from Docker to VMWare

On Windows
- Enabling docker `bcdedit /set hypervisorlaunchtype auto`
- Enabling VMWare `bcdedit /set hypervisorlaunchtype off`

In case VM tools is not working after install `sudo systemctl restart open-vm-tools.service`

## Docker image for travis

    apt update && apt install --yes rubygems build-essential ruby-full git
    gem install travis
    git clone GIT_REPO
    cd REPO_FOLDER/
    travis login --pro
    travis encrypt --pro 
    travis lint --pro .travis.yml
