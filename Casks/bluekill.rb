cask "bluekill" do
  arch arm: "arm64", intel: "x64"

  version "1.0.2"
  sha256 arm:   "b4b50ca031c24aaba203fa5ff44593ef6277e2a6fad8fe73a7e5a0c84f14f149",
         intel: "efdd9b6b57caa059312c8da960989e1efc4ca39e58b0f135e73d6d3719685d61"

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
