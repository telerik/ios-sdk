Pod::Spec.new do |s|
  s.name                = 'TelerikUI'
  s.version             = '0.0.2'
  s.license             =  { :type => 'BSD' }
  s.homepage            = 'http://www.telerik.com/ios-ui'
  s.authors             = { 'John Smith' => 'john.smith@telerik.com' }
  s.summary             = 'A cocoa pod containing the TelerikUI framework.'
  s.source              = { :http => 'http://127.0.0.1:3003/TelerikUIpod.zip' }
  s.source_files        = 'Classes/*.{h,m}'

  s.vendored_frameworks = 'TelerikUI.framework'
end
