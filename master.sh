# Pull necessary images for kubeadm
sudo kubeadm config images pull

# Initialize the Kubernetes control plane
sudo kubeadm init --cri-socket=unix:///var/run/crio/crio.sock

# Set up kubeconfig for the regular user
mkdir -p "$HOME/.kube"
sudo cp -i /etc/kubernetes/admin.conf "$HOME/.kube/config"
sudo chown "$(id -u)":"$(id -g)" "$HOME/.kube/config"


# Verify kubeconfig
cat $HOME/.kube/config

# Set KUBECONFIG environment variable
export KUBECONFIG=$HOME/.kube/config
echo 'export KUBECONFIG=$HOME/.kube/config' >> ~/.bashrc
source ~/.bashrc


# Install Calico network plugin
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.0/manifests/calico.yaml

# Create a join command for worker nodes
kubeadm token create --print-join-command


mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config