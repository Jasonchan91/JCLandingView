#
# Be sure to run `pod lib lint JCLandingView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JCLandingView'
  s.version          = '0.1.1'
  s.summary          = 'JCLandingView create landing view with ease.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Idea is come from AloeStackView create by Airbnb. JCLandingView is using UITableView instead of UIStackView. You can easily add views in JCLandingView without having trouble with constraint to layout it properly. Define some property for view before append to landing view, magic will happen.'

  s.homepage         = 'https://github.com/jasonchan91/JCLandingView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'jasonchan91' => 'j.ianchan.j@gmail.com' }
  s.source           = { :git => 'https://github.com/jasonchan91/JCLandingView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'Classes/*.{h,m,swift}'
  s.swift_version = '4.2'
  # s.resource_bundles = {
  #   'JCLandingView' => ['JCLandingView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
