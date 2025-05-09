output "region" {
  value = var.region
}

output "azs" {
  value = var.azs
}

output "project_name" {
  value = var.project_name
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "ig" {
  value = aws_internet_gateway.ig
}

output "bastion_net_id" {
  value = aws_subnet.bastion[0].id
}

output "bastion_net_cidr" {
  value = aws_subnet.bastion[0].cidr_block
}

output "bastion_net_name" {
  value = "${lookup(aws_subnet.bastion[0].tags, "Name")}"
}

output "lbs_net_ids" {
  value = aws_subnet.lbs
}

output "lrs_net_ids" {
  value = aws_subnet.lrs
}

output "dbs_net_ids" {
  value = aws_subnet.dbs
}

output "efs_net_ids" {
  value = aws_subnet.efs
}

/*output "lbs_net_az1_id" {
  value = aws_subnet.lbs[0].id
}

output "lbs_net_az2_id" {
  value = aws_subnet.lbs[1].id
}

output "lbs_net_az3_id" {
  value = aws_subnet.lbs[2].id
}

output "facs_net_az1_id" {
  value = aws_subnet.facs[0].id
}

output "facs_net_az2_id" {
  value = aws_subnet.facs[1].id
}

output "facs_net_az3_id" {
  value = aws_subnet.facs[2].id
}

output "lrs_net_az1_id" {
  value = aws_subnet.lrs[0].id
}

output "lrs_net_az2_id" {
  value = aws_subnet.lrs[1].id
}

output "lrs_net_az3_id" {
  value = aws_subnet.lrs[2].id
}

output "dbs_net_az1_id" {
  value = aws_subnet.dbs[0].id
}

output "dbs_net_az2_id" {
  value = aws_subnet.dbs[1].id
}

output "dbs_net_az3_id" {
  value = aws_subnet.dbs[2].id
}

output "efs_net_az1_id" {
  value = aws_subnet.efs[0].id
}

output "efs_net_az2_id" {
  value = aws_subnet.efs[1].id
}

output "efs_net_az3_id" {
  value = aws_subnet.efs[2].id
}*/
