variable "GOOGLE_PROJECT" {
  type        = string
  description = "GCP project name"
}

variable "GOOGLE_REGION" {
  type        = string
  default     = "us-central1-c"
  description = "GCP region to use"
}

variable "GKE_MACHINE_TYPE" {
  type        = string
  default     = "g1-small"
  description = "Machine type"
}

variable "GKE_NUM_NODES" {
  type        = number
  default     = 1
  description = "GKE nodes number"
}

variable "GKE_CLUSTER_NAME" {
  type        = string
  default     = "main"
  description = "GKE cluster name"
}

variable "GKE_POOL_NAME" {
  type        = string
  default     = "main"
  description = "GKE pool name"
}
variable "github_owner" {
    type = string
    default = "SartSR"
}
variable "FLUX_GITHUB_REPO" {
  type        = string
  default     = "flux-gitops"
  description = "The name of the Flux GitHub repository"
}
variable "github_token" {
  type        = string
  description = "GitHub personal access token"
}