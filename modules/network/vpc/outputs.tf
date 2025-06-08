output "vpc_id" {
  value = aws_vpc.main.id
}


output "nat_gateway_id" {
  value = aws_nat_gateway.nat.id
}



output "public_subnet_ids" {
  value = [for subnet in aws_subnet.public : subnet.id]
}

output "private_subnet_ids" {
  value = [for subnet in aws_subnet.private : subnet.id]
}

output "public_subnet_id" {
  value = aws_subnet.public[0].id
}

output "private_subnet_id" {
  value = aws_subnet.private[0].id
}