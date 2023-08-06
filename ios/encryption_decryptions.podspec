#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint encryption_decryptions.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'encryption_decryptions'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin to enctypt and decrypt api responses and requests
                       DESC
  s.homepage         = 'https://github.com/Dev-Devarsh/flutter_encryption_decryptions'
  s.license          = { :type => 'BSD', :file => '../LICENSE' }
  s.author           = { 'Dev Development' => 'dev.devarsh@gmail.com' }
  s.source           = { :http => "https://github.com/Dev-Devarsh/flutter_encryption_decryptions" }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'RNCryptor', '~> 5.0'
  s.platform = :ios, '11.0'
  s.swift_version = '5.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
