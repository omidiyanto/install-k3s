sudo modprobe br_netfilter
sudo modprobe overlay

# Persist sysctl settings
cat <<EOF | sudo tee /etc/sysctl.d/99-k3s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables  = 1
net.ipv4.ip_forward                 = 1
EOF

# Reload sysctl
sudo sysctl --system
curl -fsSL https://get.docker.com -o install-docker.sh
sh install-docker.sh --dry-run
sudo sh install-docker.sh

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --docker --disable traefik --write-kubeconfig-mode=644" sh -s -
