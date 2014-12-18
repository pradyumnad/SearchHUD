#
# Be sure to run `pod lib lint SearchHUD.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SearchHUD"
  s.version          = "0.2.1"
  s.summary          = "SearchHUD is a control used to show a HUD which contains UISearchBar and UITableView."
  s.description      = <<-DESC
  						SearchHUD
  						=========
                       Allows to filter items by typing on the search bar.
                       There is a delegate to know the item selected and works for any orientation thanks to masonry.
                       DESC
  s.homepage         = "https://github.com/pradyumnad/SearchHUD"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = { :type => "CCPL", :file => "LICENSE.txt" }
  s.author           = { "Pradyumna" => "pradyumnadoddala@gmail.com" }
  s.source           = { :git => "https://github.com/pradyumnad/SearchHUD.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/pradyumna_d'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'SearchHUD' => ['Pod/Assets/*.{xib}']
  }

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency "Masonry", "~> 0.5.3"
end
