Pod::Spec.new do |s|
  s.name         = "TextFieldView"
  s.version      = "0.0.1"
  s.summary      = " Customized UITextField with Validator to design beautiful Form for iPhone & iPad Application."
  s.description  = <<-DESC
                  To design a form view like login, sign up, profile update, we need to use UItextField and validator. This project will give you a quick development of your fancy form.
                  
                  Features:
                   - variation of Text field like round, box, line
                   - Variation color
                   - Add icon
                   - Validation for password, email. phone, zipcode etc.
                   DESC

  s.homepage     = "https://github.com/RazibUSA/TextFieldView"
  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Razib Mollick" => "razib.mollick@gmail.com" }
  s.platform     = :ios
  s.platform     = :ios, "11.0"
  s.source       = { :git => "https://github.com/RazibUSA/TextFieldView.git", :tag => "#{s.version}" }
  s.source_files  = "TextFieldView", "TextFieldView/*.{h,m, swift}"
  s.resources = "TextFieldView/*.{xib,xcassets}"
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.1' }

end