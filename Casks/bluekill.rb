cask "bluekill" do
  arch arm: "arm64", intel: "x64"

  version "1.0.0"
  sha256 arm:   "2b1dae38266dc80eb7f79686ab5b1537cee03e2d02957a8884c491cbb4d6c311",
         intel: "b7de55a2a7317f8c294a4b496026a00fc0e8d24cde3b33e9e62da2fd4f4a1ffc"

  url "https://github.com/babaktaremi/BlueKill/releases/download/v#{version}/BlueKill-#{version}-#{arch}.zip"
  name "BlueKill"
  desc "Stop your Mac from auto-connecting to Bluetooth devices"
  homepage "https://github.com/babaktaremi/BlueKill"

  depends_on macos: ">= :monterey"

  app "BlueKill.app"

  # BlueKill is not notarized; clear the quarantine flag so it opens without a Gatekeeper block.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/BlueKill.app"]
  end

  zap trash: "~/Library/Application Support/BlueKill"
end
