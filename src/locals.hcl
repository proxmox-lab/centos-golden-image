locals {
  git_host       = "github.com"
  git_repository = "git@${local.git_host}:proxmox-lab/cm-configuration-private.git"
  gitfs_root     = "salt"
  gitfs_base     = "production"
}
