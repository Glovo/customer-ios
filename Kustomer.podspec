Pod::Spec.new do |s|
  s.name = 'Kustomer'
  s.authors = 'Kustomer.com'
  s.summary = 'The iOS SDK for the Kustomer.com mobile client'
  s.version = '0.3.1'
  s.ios.deployment_target = '9.0'

  s.homepage = 'https://github.com/diegoRodriguezAguila/customer-ios.git'
  s.source = {
    :git => 'https://github.com/diegoRodriguezAguila/customer-ios.git',
    :tag => s.version.to_s
  }

  s.dependency 'libPusher', '>= 1.6.2', '< 2.0.0'
  s.dependency 'TSMarkdownParser', '>= 2.0.0', '< 3.0.0'
  s.dependency 'SDWebImage', '>= 5.0.0', '< 6.0.0'
  s.dependency 'TTTAttributedLabel', '>= 2.0.0', '< 3.0.0'
  s.dependency 'NYTPhotoViewer', '~> 2.0.0'

  s.resources = ['Source/**/*.{png,m4a}', 'Source/Strings.bundle']
  s.source_files = 'Source/**/*.{h,m}'
  s.requires_arc = true
  s.framework = 'UIKit'
end
