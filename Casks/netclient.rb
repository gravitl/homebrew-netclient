cask "netclient" do
  arch = Hardware::CPU.intel? ? "amd64" : "arm64"
  version "0.22.0"

  if Hardware::CPU.intel?
    sha256 "824ca3a103cd7b0f2c1556943aa53cc4990e701c21fa77d8ca81d1dcadbf63d5"
  else
    sha256 "3aa58641da3a1c839df7056722fbb437c7dd94fabceab995b6590000e096c67f"
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

