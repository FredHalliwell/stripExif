# stripExif
Stripping exif metadata from images.

# Bootstrapping
To run this project, we first need to set up the remote backend.

1. Clone the project

2. Run `bootstrap\backend_config\dev_setup.sh`

This script first builds the S3 bucket required to hold the statefile using local state, then switches the backend to S3, then finally migrates the state over to the S3 bucket.

You can change any settings in *dev.conf* and *dev.tfvars* if required.

Follow the instructions in the script to complete the backend setup.

