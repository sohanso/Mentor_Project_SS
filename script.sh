## NOT USING THIS SCRIPT , FOR NOTES and ROUGH WORK ONLY
!/bin/bash 
sudo apt -y update
sudo apt-get install -y software-properties-common
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt install -y ansible


## Docker
sudo apt -y update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
"echo 'deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable' | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
sudo apt -y update
sudo apt install -y docker-ce
sudo systemctl start docker
sudo systemctl enable docker

  // provisioner "ansible" {
  //   user = "ubuntu"
  //   use_proxy = "false"
  //   keep_inventory_file = "true"
  //   playbook_file = "./playbooks/ansible_docker.yml"
  // }

  provisioner "shell" {
    script       = "script.sh"
    pause_before = "20s"
    timeout      = "20s"
  }