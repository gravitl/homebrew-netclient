cask "netclient" do
  arch = Hardware::CPU.intel? ? "amd64" : "arm64"
  version "0.24.2"

  if Hardware::CPU.intel?
    sha256 "dec5b91f198eebce0c5500dc4af97b006c348813e5e63ca05859c9925d3fbc09"
  else
    sha256 "410918c96bb784f240f0ed636b992996cbde2920f5628648672e6650a511fe06"
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

