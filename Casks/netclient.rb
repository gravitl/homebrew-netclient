cask "netclient" do
  arch = Hardware::CPU.intel? ? "amd64" : "arm64"
  version "0.20.1"

  if Hardware::CPU.intel?
    sha256 "278b9075bdf9076f472e2e965700572c2d988baeda10664f37ffdde4c4158fdc"
  else
    sha256 "f17d73d29128fc0bd55196c1786015083212bb5e81d9f0de6af5ab49c0de11fe"
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

  uninstall script: {
    executable: "#{staged_path}/blank.sh",
  }

  zap script: {
    executable: "#{staged_path}/uninstall.sh",
    sudo: true,
  }

end

