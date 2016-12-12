use_frameworks!
inhibit_all_warnings!

target 'ProductHunt' do
pod 'Kingfisher', '~> 3.0'
pod 'AFNetworking', '~> 3.0'
pod 'ISO8601', '~> 0.5'
pod 'DateTools'
pod 'SwiftyTimer'
pod 'Sparkle'
pod 'ReSwift'

    target 'ProductHuntTests' do
	
    end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
            config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
            config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
