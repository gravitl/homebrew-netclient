cask "netclient" do
  arch = Hardware::CPU.intel? ? "amd64" : "arm64"
  version "0.20.6"

  if Hardware::CPU.intel?
    sha256 "6f6b8a7684db7ceb95cb53775af1705959fab6571da39950ca4f9bbea4f38fcf"
  else
    sha256 "839c7ef695d61348b55d354eac7b19b6bc8af9a6a352a7da4b7311cc69cc5e9e"
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
  }

  zap script: {
    executable: "#{staged_path}/uninstall.sh",
    sudo: true,
  }

end

