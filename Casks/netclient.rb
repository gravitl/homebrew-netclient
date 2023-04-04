cask "netclient" do
  arch = Hardware::CPU.intel? ? "amd64" : "arm64"
  version "0.18.5"

  if Hardware::CPU.intel?
    sha256 "74da15793a2da1d5dc0821e23cca099d1cbfcb730023f83adc63c706eff7beeb"
  else
    sha256 "7a7c8857a40a562c87ef7e2c077edcb130e0480ea95633842eb852ca6c7a5781"
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

