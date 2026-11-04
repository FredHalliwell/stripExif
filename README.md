# stripExif
Stripping exif metadata from images.

# Bootstrapping
To run this project, we first need to set up the remote backend.

### 1. Clone the project

git clone https://github.com/FredHalliwell/stripExif.git

### 2. Update variables

In `bootstrap\backend_config\dev.tfvars`, update the empty variables to allow an OIDC connection from Github to AWS. All OIDC details can be found at https://api.github.com/repos/[username]/[repository]".

For example, this project uses the details from https://api.github.com/repos/fredhalliwell/stripExif

You can change any other settings in *dev.conf* and *dev.tfvars* if required, such as the environment name.

### 3. Run the deployment script

Run `bootstrap\backend_config\dev_setup.sh`

This script first builds the S3 bucket required to hold the statefile using local state, then switches the backend to S3, then finally migrates the state over to the S3 bucket. It also builds the OIDC identity provider for Github. It uses the details provided in dev.tfvars

Follow the instructions in the script to complete the backend setup.
