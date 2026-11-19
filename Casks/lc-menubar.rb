cask "lc-menubar" do
  version "0.1.12"
  sha256 "0adf8ee4a8be4130da9b6046543febc56c24dd314484266261d1aab2d32f4165"

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
