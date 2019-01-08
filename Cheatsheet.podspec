#
# Be sure to run `pod lib lint Cheatsheet.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Cheatsheet'
  s.version          = '1.0.0'
  s.summary          = 'Pod with useful utilities, extensions and code snippets.'
  s.description      = <<-DESC
This repo is a place where I put all useful utilities and extension that I use in my projects.
                       DESC

  s.homepage         = 'https://github.com/wowbroforce/Cheatsheet'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Prokhor Kharchenko' => 'wowbroforce@gmail.com' }
  s.source           = { :git => 'https://github.com/wowbroforce/Cheatsheet.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.swift_version = '4.2'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'Foundation', 'UIKit'

  s.source_files = 'Cheatsheet/**/*'

  s.dependency 'RxSwift', '~> 4.4'
  s.dependency 'RxCocoa', '~> 4.4'
  s.dependency 'RxDataSources', '~> 3.1'
end
