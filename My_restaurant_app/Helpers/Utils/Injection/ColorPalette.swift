//
//  ColorPalette.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 03/09/2024.
//
import SwiftUI
import UIKit
class ColorPalette {
    
    init(){}
    
    var tintColor:Color = .accentColor
    
    //Mark: - text
    
    //General textColor, should be something that constrast greate with your `background` color
    var text: UIColor = .streamBlack
    var textInverted:UIColor = .streamWhite
    var textLowEmphasis:UIColor = .streamGrayDisabledText
    
    ///Static color which should stay the same in dark and light mode, because it's only used as text on small UI elements
    ///such as `ChatUnreadCountView`,`GiphyBadge` or Commands icon.
    var staticColorText:UIColor = .streamWhiteStatic
    var subtitleText:UIColor = .streamGray
    
    // MARK: - Text interactions
    public var disabledColorForColor: (UIColor) -> UIColor = { _ in .streamDisabled }
    // MARK: - Background
    public var background: UIColor = .streamWhiteSnow
    public var background1: UIColor = .streamWhiteSmoke
    public var background6: UIColor = .streamGrayWhisper
    public var background8: UIColor = .streamWhite
    
    /// General background of the application. Should be something that is in constrast with `text` color.
    
    // MARK: - Borders and shadows
    
    public var innerBorder: UIColor = .streamInnerBorder
    
    // MARK: - Tint and alert
    public var alert: UIColor = .streamAccentRed
    public var alternativeActiveTint: UIColor = .streamAccentGreen
    
    // MARK: - Messages
    
    public var black = Color(.black)
    
    
    public var blackTransparent = Color(UIColor.black.withAlphaComponent(0.7))
     
    
    public var white = Color(.white)
    
    //Hệ màu xanh
    public var green_000 = Color(UIColor.hexStringToUIColor(hex: "#DFEEE2"))
     
    public var green_200 = Color(UIColor.hexStringToUIColor(hex: "#95D9A1"))
    
    public var green_600 = Color(UIColor.hexStringToUIColor(hex: "#00A534"))
 
    public var green_400 = Color(UIColor.hexStringToUIColor(hex: "#38C05D"))
    
    public var green = Color(UIColor.hexStringToUIColor(hex: "#34A853"))
    
    public var green_online = Color(UIColor.hexStringToUIColor(hex: "#02bf54"))
    
    public var green_transparent = Color(UIColor.hexStringToUIColor(hex: "#d3f0db"))
    
    public var green_matcha = Color(UIColor.hexStringToUIColor(hex: "#2F9672"))
    
    //Hệ màu xanh
    public var blue_brand_200 = Color(UIColor.hexStringToUIColor(hex: "#CCE3F1"))
     
    public var blue_brand_400 = Color(UIColor.hexStringToUIColor(hex: "#99C6E4"))
    
    public var blue_brand_700 = Color(UIColor.hexStringToUIColor(hex: "#0071BB"))
 
    
    //hệ màu cam
    
    public var orange_brand_200 = Color(UIColor.hexStringToUIColor(hex: "#FFF1E0"))
    
    public var orange_brand_700 = Color(UIColor.hexStringToUIColor(hex: "#FFA233"))
    
    public var orange_brand_900 = Color(UIColor.hexStringToUIColor(hex: "#FF8B00"))
    
    // hệ màu đỏ
    public var red_000 = Color(UIColor.hexStringToUIColor(hex: "#FFE8EC"))
    
    public var red_400 = Color(UIColor.hexStringToUIColor(hex: "#F2244A"))
    
    public var red_500 = Color(UIColor.hexStringToUIColor(hex: "#F7002E"))
    
    public var red_600 = Color(UIColor.hexStringToUIColor(hex: "#E8002E"))
    
    // hệ xám
    public var gray_200 = Color(UIColor.hexStringToUIColor(hex: "#F1F2F5"))
    
    public var gray_300 = Color(UIColor.hexStringToUIColor(hex: "#E7E8EB"))
    
    public var gray_400 = Color(UIColor.hexStringToUIColor(hex: "#C5C6C9"))
    
    public var gray_500 = Color(UIColor.hexStringToUIColor(hex: "#E8002E"))
    
    public var gray_600 = Color(UIColor.hexStringToUIColor(hex: "#7D7E81"))
    
    // MARK: - Composer
    
}

//those color are default defined stream constants, which are fallback values if you don't implement your color theme.
//there is this static method `mode(_ light:, lightAlpha:, _ dark:, darkAlpha:)` which can help you in a greate way with implementing dark mode support
private extension UIColor{
    /// This is color palette used by design team.
    /// If you see any color not from this list in figma, point it out to anyone in design team.
    static let streamBlue = UIColor(red: 0, green: 108.0 / 255.0, blue: 255.0 / 255.0, alpha: 1)
    static let streamBlack = mode(0x000000, 0xffffff)
    static let streamWhite = mode(0xffffff, 0x101418)
    static let streamGrayWhisper = mode(0xecebeb, 0x1c1e22)
    static let streamWhiteSmoke = mode(0xf2f2f2, 0x13151b)
    static let streamWhiteSnow = mode(0xfcfcfc, 0x070a0d)
    static let streamWhiteStatic = mode(0xffffff, 0xffffff)
    static let streamGrayDisabledText = mode(0x72767e, 0x72767e)
    
    static let streamGray = mode(0x7a7a7a, 0x7a7a7a)
    static let streamAccentGreen = mode(0x20e070, 0x20e070)
    static let streamAccentRed = mode(0xff3742, 0xff3742)
    static let streamInnerBorder = mode(0xdbdde1, 0x272a30)
    static let streamDisabled = mode(0xb4b7bb, 0x4c525c)
    
    
    static func mode(_ light: Int, lightAlpha: CGFloat = 1.0, _ dark: Int, darkAlpha: CGFloat = 1.0) -> UIColor {
        UIColor { traitCollection in
           traitCollection.userInterfaceStyle == .dark
               ? UIColor(rgb: dark).withAlphaComponent(darkAlpha)
               : UIColor(rgb: light).withAlphaComponent(lightAlpha)
        }
    }
    
    
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}
