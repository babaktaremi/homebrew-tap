cask "proxydog" do
  arch arm: "arm64", intel: "x64"

  version "1.0.0"
  sha256 arm:   "7b55a6c5b33f06bc430d03073a861fddd6020c55984de058e62c3fce8db64b92",
         intel: "d26c3fb144e9cbdb9aa486df39245d96a8d5c37648d966033e4c4882bc19050a"

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
