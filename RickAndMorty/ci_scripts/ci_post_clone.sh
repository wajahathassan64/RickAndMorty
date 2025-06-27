#!/usr/bin/env bash
# install SwiftLint
brew install swiftlint
# allow the SPM plugin to run without failing fingerprint checks
defaults write com.apple.dt.Xcode IDESkipPackagePluginFingerprintValidatation -bool YES
defaults write com.apple.dt.Xcode IDESkipMacroFingerprintValidation -bool YES

