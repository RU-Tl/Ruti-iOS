//
//  Const.swift
//  Ruti
//
//  Created by leeyeon2 on 5/22/24.
//

import UIKit

struct CustomColor {
    // Basic Color
    static let clear_white = "#FFFFFF"
    static let white = "#FAFAFA"
    static let white_gray = "#BDBDBD"
    static let light_gray = "#9E9E9E"
    static let dark_gray = "#757575"
    static let deep_dark_gray = "#3E3E3E"
    static let black_gray = "#333333"
    static let background_black = "#232323"
    static let black = "#111111"
    
    static let light_blue = "#B5DCFF"
    
    // Main Color
    struct Category{
        static let EXERCISE = "#54ADFF" //blue
        static let READING = "#CF80FF" //pink
        static let DEVELOPMENT = "#FFBA58" //yellow
    }
    
    // Specific Color
    static let kakao = "#FEE500"
}

extension UIFont {
    enum wantedFontName: String {
        case Bold = "WantedSans-Bold"
        case SemiBold = "WantedSans-SemiBold"
        case Black = "WantedSans-Black"
        case ExtraBlack = "WantedSans-ExtraBlack"
        case ExtraBold = "WantedSans-ExtraBold"
        case Medium = "WantedSans-Medium"
        case Regular = "WantedSans-Regular"
    }
    
    class func h1() -> UIFont {
        return UIFont(name: wantedFontName.Bold.rawValue, size: 28)!
    }
    
    class func h2() -> UIFont {
        return UIFont(name: wantedFontName.SemiBold.rawValue, size: 24)!
    }
    
    class func h3() -> UIFont {
        return UIFont(name: wantedFontName.Bold.rawValue, size: 20)!
    }
    
    class func h4() -> UIFont {
        return UIFont(name: wantedFontName.SemiBold.rawValue, size: 20)!
    }
    
    class func subTitle() -> UIFont {
        return UIFont(name: wantedFontName.Regular.rawValue, size: 20)!
    }
    
    class func body1() -> UIFont {
        return UIFont(name: wantedFontName.SemiBold.rawValue, size: 18)!
    }
    
    class func body2() -> UIFont {
        return UIFont(name: wantedFontName.Regular.rawValue, size: 18)!
    }
    
    class func body3() -> UIFont {
        return UIFont(name: wantedFontName.Regular.rawValue, size: 16)!
    }
    
    class func body4() -> UIFont {
        return UIFont(name: wantedFontName.SemiBold.rawValue, size: 14)!
    }
    
    class func caption1() -> UIFont {
        return UIFont(name: wantedFontName.Regular.rawValue, size: 14)!
    }
    
    class func weekly() -> UIFont {
        return UIFont(name: wantedFontName.SemiBold.rawValue, size: 18)!
    }
}
