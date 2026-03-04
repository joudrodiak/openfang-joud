Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
    vb.cpus = 4
  end
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y pkg-config libssl-dev build-essential curl gcc clang llvm
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
    cd /vagrant
    cargo build --release -p openfang-cli
    tar -czvf openfang-x86_64-unknown-linux-gnu.tar.gz -C target/release openfang
  SHELL
end
