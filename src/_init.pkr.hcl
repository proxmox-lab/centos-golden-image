# Placeholder to Load Custom Plugins Hosted on Github
packer {
  required_plugins {
    salt = {
      version = ">= 0.0.1"
      source  = "github.com/hashicorp/salt"
    }
  }
}
