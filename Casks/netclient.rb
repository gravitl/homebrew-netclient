cask "netclient" do
  arch = Hardware::CPU.intel? ? "amd64" : "arm64"
  version "0.20.6"

  if Hardware::CPU.intel?
    sha256 "d6d0492f63673e11d9fef2fec78a9ba61008abc1253f97c476bcda593066fa22"
  else
    sha256 "03baad5dd3c3fdfc18d77fe43b0f7d7397fc735d6b81fd1f4bce8bf771b4e988"
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

