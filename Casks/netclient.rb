cask "netclient" do
  arch = Hardware::CPU.intel? ? "amd64" : "arm64"
  version "0.24.1"

  if Hardware::CPU.intel?
    sha256 "4559442a876080b6ae9f6b45a91367f89240e9ca2a22fa0229648fe59a97ca1d"
  else
    sha256 "908f45828d2b8185e859b2b46e9a0718d0a7d0b1d27a84aafb3fd047021e14cd"
  end

  url "https://fileserver.netmaker.org/releases/download/v#{version}/netclient-#{arch}.tgz",
    verified: "https://fileserver.netmaker.org"
  name "netclient"
  desc "A platform for modern, blazing fast virtual networks"
  homepage "https://github.com/gravitl/netmaker"
  depends_on formula: "wireguard-tools"
  binary "netclient",  target: "netclient"

  postflight do
    set_permissions "/Applications/netclient", '0755'
  end

  installer script: {
    executable: "#{staged_path}/install.sh",
    sudo: true,
  }

  uninstall script: {
    executable: "#{staged_path}/blank.sh",
    sudo: true,
  }

  zap script: {
    executable: "#{staged_path}/uninstall.sh",
    sudo: true,
  }

end

