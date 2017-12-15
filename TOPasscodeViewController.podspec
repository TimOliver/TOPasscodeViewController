Pod::Spec.new do |s|
  s.name     = 'TOPasscodeViewController'
  s.version  = '0.0.2'
  s.license  =  { :type => 'MIT', :file => 'LICENSE' }
  s.summary  = 'A view controller that prompts users to enter a passcode.'
  s.homepage = 'https://github.com/TimOliver/TOPasscodeViewController'
  s.author   = 'Tim Oliver'
  s.source   = { :git => 'https://github.com/TimOliver/TOPasscodeViewController.git', :tag => s.version }
  s.platform = :ios, '8.3'

  s.source_files = 'TOPasscodeViewController/**/*.{h,m}'
  s.requires_arc = true
end
