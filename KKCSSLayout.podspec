#
# Be sure to run `pod lib lint KKCSSLayout.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "KKCSSLayout"
  s.version          = "0.1.0"
  s.summary          = "A short description of KKCSSLayout."
  s.description      = <<-DESC
                       An optional longer description of KKCSSLayout

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/<GITHUB_USERNAME>/KKCSSLayout"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Peter Mackay" => "peter.mackay@kotikan.com" }
  s.source           = { :git => "https://github.com/<GITHUB_USERNAME>/KKCSSLayout.git", :tag => s.version.to_s, :submodules => true }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Headers/**/*.h', 'Pod/Classes/*', 'Pod/Classes/css-layout/src/Layout.{c,h}'
  s.resource_bundles = {
    'KKCSSLayout' => ['Pod/Assets/*.png']
  }

  s.public_header_files = 'Pod/Headers/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'

  s.library = 'c++'
end
