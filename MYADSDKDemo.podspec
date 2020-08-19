#
# Be sure to run `pod lib lint MYADSDKDemo.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MYADSDKDemo'
  s.version          = '0.0.1'
  s.summary          = 'Short description of MYADSDKDemo.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'MYADSDKDemo for MYADSDK'

  s.homepage         = 'https://github.com/Liumao/MYADSDKDemo'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Liumao' => '12-wangwei@users.noreply.git.adxdata.com' }
  s.source           = { :git => 'https://github.com/Liumao/MYADSDKDemo.git', :tag => s.version.to_s }
  s.static_framework     = true
  s.ios.deployment_target = '9.0'

  s.source_files = 'MYADSDKDemo/Classes/**/*'
  s.prefix_header_file = 'MYADSDKDemo/Classes/Header/PrefixHeader.pch'

   s.dependency 'MYAdSDK'
   s.dependency 'Masonry'
   
end
