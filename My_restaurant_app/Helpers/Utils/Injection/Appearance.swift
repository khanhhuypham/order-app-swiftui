//
//  Appearance.swift
//  DAIHY-ORDER
//
//  Created by Pham Khanh Huy on 03/09/2024.
//

import Foundation
import SwiftUI
class Appearance {
    public var colors:ColorPalette
    public var fonts:Fonts
    /// Provides the default value of the `Appearance` class.
    static var `default`: Appearance = .init()
    
    public init(colors:ColorPalette = ColorPalette(),fonts: Fonts = Fonts()) {
        self.colors = colors
        self.fonts = fonts
    }
    ///Provider for custom localization which is dependent on App Bundle.
    public static var localizationProvider:(_ key: String, _ table: String) -> String = {key, table in
        Bundle.DAIHYORDER.localizedString(forKey: key, value: nil, table: table)
    }
}

/// Provides the default value of the `Appearance` class.
struct AppearanceKey: EnvironmentKey {
     static let defaultValue: Appearance = Appearance()
}


extension EnvironmentValues {
    /// Provides access to the `Appearance` class to the views and view models.
     var appearance: Appearance {
        get {
            self[AppearanceKey.self]
        }
        set {
            self[AppearanceKey.self] = newValue
        }
    }
}
