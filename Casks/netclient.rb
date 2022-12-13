cask "netclient" do
  arch = Hardware::CPU.intel? ? "amd64" : "arm64"
  version "0.17.0"

  if Hardware::CPU.intel?
    sha256 "20af8ace3317630d3bec788614631e58e543ace95afb59dfc413aca9f1314d7b"
  else
    sha256 "c5ab83a37b2f630a975c4764a2090b986779f73f82234ef3ca2bd64ca4c47491"
  end

  url "https://fileserver.netmaker.org/v#{version}/darwin/netclient-#{arch}.tgz",
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

  zap script: {
    executable: "#{staged_path}/uninstall.sh",
    sudo: true,
  }

  uninstall script: {
    executable: "#{staged_path}/uninstall.sh",
    sudo: true,
  }
end

