cask "netclient" do
  arch = Hardware::CPU.intel? ? "amd64" : "arm64"
  version "0.18.7"

  if Hardware::CPU.intel?
    sha256 "d21a4b297b8e94be2a89b99b6d6806d3c3e59a0970e5dc2988f9d3949f13550c"
  else
    sha256 "c5568b9d331251a0b0ab069aaca61aa3fe271c2863c920f4113ba4812791ea2c"
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

