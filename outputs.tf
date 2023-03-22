output "ipam_id" {
  description = "The ID of the IPAM"
  value       = awscc_ec2_ipam.main.id
}

output "ipam_pool_root_id" {
  description = "The ID of the root IPAM Pool"
  value       = awscc_ec2_ipam_pool.root.id
}

output "ipam_pool_us_east_1" {
  description = "The ID of the us-east-1 IPAM Pool"
  value       = awscc_ec2_ipam_pool.useast1.id
}

output "ipam_pool_us_east_2" {
  description = "The ID of the us-east-2 IPAM Pool"
  value       = awscc_ec2_ipam_pool.useast2.id
}
