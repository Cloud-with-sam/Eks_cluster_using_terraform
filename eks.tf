module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "example"
  kubernetes_version = "1.33"
  vpc_id                                   = module.vpc.vpc_id
  subnet_ids                               = module.vpc.private_subnets
  control_plane_subnet_ids                 = module.vpc.intra_subnets
  enable_cluster_creator_admin_permissions = true
  endpoint_public_access                   = true

  # EKS Managed Node Group(s)
  eks_managed_node_groups = {
    my-eks-cluster = {
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t2.medium"]
      min_size       = 1
      max_size       = 2
      desired_size   = 1
      capacity_type  = "SPOT"
    }
  }

  tags = {
    Environment = local.env
    Terraform   = "true"

  }
}