variable "eks_cluster" {
    type = String
    default = eksclusterdemo
}

variable "subnet_id" {
    type = String
    default = [aws_subnet.subnet-1.id, aws_subnet.subnet-2.id]
}