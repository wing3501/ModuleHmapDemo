#
# Be sure to run `pod lib lint MyPodA.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MyPodA'
  s.version          = '0.1.0'
  s.summary          = 'A short description of MyPodA.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://gitlab.styf.com/iOS-Group/MyPodA'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '174481103@qq.com' => 'shentyf@styf.com' }
  s.source           = { :git => 'https://gitlab.styf.com/iOS-Group/MyPodA.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'MyPodA/Classes/**/*'
  # s.static_framework = true
  # s.resource_bundles = {
  #   'MyPodA' => ['MyPodA/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SDWebImage'
  s.dependency 'OCSwift'
  s.dependency 'OnlySwift'
end
