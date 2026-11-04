cd bucket_setup

terraform init 

terraform apply --auto-approve -input=false -var-file=../dev.tfvars

cat >> providers.tf << 'EOF'


terraform {
  backend "s3" {}
}
EOF

printf 'Please update dev.conf with the name of your bucket (printed above), then press Enter to finish setup'
printf 'Do not migrate the state to S3.'
read -r _

terraform init -reconfigure -backend-config=../dev.conf

printf 'Backend setup complete.'
