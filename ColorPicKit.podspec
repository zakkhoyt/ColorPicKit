
Pod::Spec.new do |s|
  s.name         = "ColorPicKit"
  s.version      = "1.1"
  s.summary      = "Various UIControls for selecting colors along with some useful categories on UIColor"
  s.author        = { "Zakk Hoyt" => "vaporwarewolf@gmail.com" }
  s.homepage      = "http://github.com/zakkhoyt/ColorPicKit"
  s.platforms = { :ios => 10.0
                }
  s.license = { :type => 'MIT',
                :text =>  <<-LICENSE
                  Copyright 2016. Zakk hoyt.
                          LICENSE
              }
  s.source       = { :git => 'https://github.com/zakkhoyt/ColorPicKit.git',
                    :tag =>  "#{s.version}" }
  s.source_files  = 'ColorPicKit/**/*.{swift}'
  s.requires_arc = true
  s.ios.deployment_target = '10.0'
end
