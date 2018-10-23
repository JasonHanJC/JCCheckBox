Pod::Spec.new do |s|
  s.name             = 'JCCheckBox'
  s.version          = '0.1.1'
  s.summary          = 'JCCheckBox is a custom UIControl for iOS apps.'
  s.description      = <<-DESC
JCCheckbox is a beautful and simple checkbox for iOS apps. It is a subclass of UIControl. It is easy to use.
                       DESC

  s.homepage         = 'https://github.com/JasonHan1990/JCCheckBox'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'JasonHan1990' => 'namrie1990@gmail.com' }
  s.source           = { :git => 'https://github.com/JasonHan1990/JCCheckBox.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'JCCheckBox/*.{m,h}'
end
