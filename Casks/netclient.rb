cask "netclient" do
  arch = Hardware::CPU.intel? ? "amd64" : "arm64"
  version "0.20.4"

  if Hardware::CPU.intel?
    sha256 "85f64de901e94474df710eae96a66e8d9e6da22184d8a19e582e8f21feaa4b1d"
  else
    sha256 "2327be5da7b486d58478b4eb7447c7ecfa67a6639551084a5c16bcf435ee9065"
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

