# AWS Account ID
# account_id = "${AWS_ACCOUNT_ID}"

# # AWS Region
# aws_region = "${AWS_REGION}"

# Allow access to the environment from any location or restrict it to your public ip
# Example:
#   access_ip      = "<YOUR IP>/32"
access_ip = ["10.0.0.1/32"]

# Environment Name
environment = "scanner"

# Path to Playground One
one_path = "."

# XDR for Containers deployed
xdr_for_containers = false
