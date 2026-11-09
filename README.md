# WebSwitch

WebSwitch is a macOS browser picker. Set it as the app that opens web links, and each link shows the browsers installed on your Mac. Pick one, and WebSwitch opens the link there, then quits.

It handles `http`, `https`, and `ftp` links, plus `.html`, `.htm`, `.xhtml`, `.shtml`, and `.xht` files.

## Download

Grab `WebSwitch-1.0.zip` from [Releases](https://github.com/RajSolai/WebSwitch/releases). Unzip it, move `WebSwitch.app` to Applications, then right-click the app and choose **Open**.

The current build is ad-hoc signed, so Gatekeeper will warn the first time. After that, set WebSwitch as the default browser in **System Settings → Desktop & Dock**.

## Requirements

- macOS 15.5 or later
- Xcode with the macOS 15.5 SDK

## Build

1. Clone the repo and open `WebSwitch.xcodeproj`.
2. Select the **WebSwitch** target, then **Signing & Capabilities**.
3. Set **Team** to your own Apple Developer team. The project file currently lists team `Q7WJUFA629`, which will not sign on another Mac.
4. Run the **WebSwitch** scheme.

## Use

1. Open **System Settings → Desktop & Dock**.
2. Set **Default web browser** to WebSwitch.
3. Open a link. Choose a browser from the bar that appears.

WebSwitch is an agent app (`LSUIElement`), so it does not show a Dock icon.

## License

[MIT](LICENSE)
