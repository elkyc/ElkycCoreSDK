Pod::Spec.new do |s|
    s.name         = "ElkycCoreSDK"
    s.version      = "1.0.8"
    s.summary      = "A brief description of  project."
    s.description  = <<-DESC
    An extended description of  project.
    DESC
    s.homepage     = "http://www.google.com"
    s.license = { :type => 'Copyright', :text => <<-LICENSE
                   Copyright 2020
                   LICENSE
                }
    s.author             = { "Elkyc" => "support@elkyc.com" }
    s.source       = { :git => "git@github.com:elkyc/ElkycCoreSDK.git", :tag => "#{s.version}" }
    s.vendored_frameworks = "ElkycCoreSDK.xcframework"
    s.platform = :ios
    s.swift_version = "5.0"
    s.ios.deployment_target  = '11.0'
end
