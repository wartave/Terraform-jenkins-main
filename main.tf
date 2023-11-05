terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.28.1"
    }
  }
}

provider "digitalocean" {
  token = file("${path.module}/token.txt")
}

resource "digitalocean_droplet" "app" {
  image    = "ubuntu-20-04-x64"
  name     = "terraform-victor"
  region   = "nyc3"
  size     = "s-1vcpu-1gb"
  ssh_keys = [file("${path.module}/ssh.txt")]


  user_data = <<-EOF
    #cloud-config
    runcmd:
      - set -o errexit
      - sudo apt-get update -y
      - sudo apt-get install git -y
      - sudo apt-get install docker.io -y
      - sudo systemctl start docker
      - sudo usermod -aG docker root
      - sudo curl -L https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
      - sudo chmod +x /usr/local/bin/docker-compose
      - git clone https://github.com/wartave/laravel-apache
      - cd /home/root/app/
      - sudo chmod 666 /var/run/docker.sock
      - echo "Ha finalizado"
  EOF
  
}
