Pod::Spec.new do |s|
  s.name     = 'ByvLocationPicker'
  s.version  = '1.0.4'
  s.author   = { 'Adrian Apodaca' => 'adrian@byvapps.com' }
  s.homepage = 'https://github.com/adrianByv/ByvLocationPicker.git'
  s.description = "LocationPickerViewController is a UIViewController subclass to let users choose locations by searching or selecting on map. It's designed to work as UIImagePickerController. (forked from almassapargali/LocationPicker)"
  s.summary  = "UIViewController subclass for searching or selecting locations on map."
  s.license  = 'MIT'
  s.source   = { :git => 'https://github.com/adrianByv/ByvLocationPicker.git', :tag => s.version.to_s }
  s.source_files = 'LocationPicker'
  s.resource = 'LocationPicker/Images.xcassets'
  s.platform = :ios
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
end
