
Pod::Spec.new do |s|

  s.name         = "IMVCommon"
  s.version      = "0.0.1"
  s.summary      = "common classes for all projects."

  s.description  = <<-DESC
                   common classes for all projects.
                   DESC

  s.homepage     = "https://github.com/inmovation/IMVCommon"
  
  s.license      = "MIT"

  s.author             = { "shaohua" => "shaohua.chen@inmovation.com" }

  s.platform     = :ios
  s.platform     = :ios, "5.0"

  s.source       = { :git => "https://github.com/inmovation/IMVCommon.git", :tag => "0.0.1" }

  s.source_files  = "IMVCommon/lib/*.h", "IMVCommon/lib/**/*.{h,m}"
  # s.exclude_files = "Classes/Exclude"
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
  s.dependency "CocoaLumberjack"

end
