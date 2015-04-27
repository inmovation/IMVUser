Pod::Spec.new do |s|
  s.name         = "IMVTheme"
  s.version      = "0.0.1"
  s.summary      = "theme of the project."

  s.description  = <<-DESC
                   you can switch the theme of your project
                   DESC

  s.homepage     = "https://github.com/inmovation/IMVTheme"
  
  s.license      = "MIT"
  
  s.author             = { "shaohua" => "shaohua.chen@inmovation.com" }

  s.platform     = :ios
  s.platform     = :ios, "5.0"

  s.source       = { :git => "https://github.com/inmovation/IMVTheme.git", :tag => "0.0.1" }

  s.source_files  = "IMVTheme/lib/*.{h,m}"
  #  s.exclude_files = "Classes/Exclude"
  # s.public_header_files = "Classes/**/*.h"

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"
 
  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
