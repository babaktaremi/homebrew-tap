cask "proxydog" do
  arch arm: "arm64", intel: "x64"

  version "1.1.0"
  sha256 arm:   "886f2315b6f35f35b069a88acfd069a2ecbac1b5a68742240c2dd050ff3a6945",
         intel: "1a28a877fed603eedd8a34d5ba77337fbf6c0af18f664f2b2d4a564f4092db53"

  url "https://github.com/babaktaremi/proxydog/releases/download/v#{version}/ProxyDog-#{version}-macos-#{arch}.zip"
  name "ProxyDog"
  desc "Route any application through a SOCKS5 or HTTP proxy"
  homepage "https://github.com/babaktaremi/proxydog"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :monterey"

  app "ProxyDog.app"

  # The app is ad-hoc signed, not notarized (no paid Apple Developer ID), so macOS would otherwise block the first launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/ProxyDog.app"],
                   must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/ProxyDog",
    "~/Library/Preferences/dev.babaktaremi.proxydog.plist",
  ]
end
