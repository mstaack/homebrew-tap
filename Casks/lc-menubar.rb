cask "lc-menubar" do
  version "0.1.4"
  sha256 "90268ff175bfb79abf455b4dc140bfbd038a512062606dcee874967e8a499990"

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
