cask "lc-menubar" do
  version "0.1.1"
  sha256 "2e8f941bf9b0e570634ca25d92ee135e1a1bfeee81424c5d14a1052aac479a5b"

  url "https://github.com/mstaack/lc-menubar/releases/download/v#{version}/lc-menubar-#{version}-macos-universal.zip"
  name "LC Menubar"
  desc "Menu bar companion for Laravel Cloud deployments, metrics and spend"
  homepage "https://github.com/mstaack/lc-menubar"

  # LC Menubar updates itself; brew should not fight it.
  auto_updates true
  depends_on macos: :ventura

  app "LC Menubar.app"

  # Releases are not notarized yet: without this, macOS refuses to open the app.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/LC Menubar.app"]
  end

  uninstall launchctl: "io.github.mstaack.lc-menubar",
            quit:      "io.github.mstaack.lc-menubar"

  zap trash: [
    "~/Library/Application Support/lc-menubar",
    "~/Library/LaunchAgents/io.github.mstaack.lc-menubar.plist",
  ]
end
