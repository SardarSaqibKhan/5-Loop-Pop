/*
 
 Created by TapTapStudio (Alice Vinnik).
 Copyright ©2020 TapTapStudio. All rights reserved.

 ▀▀█▀▀ ░█▀▀█ ▒█▀▀█ ▀▀█▀▀ ░█▀▀█ ▒█▀▀█
 ░▒█░░ ▒█▄▄█ ▒█▄▄█ ░▒█░░ ▒█▄▄█ ▒█▄▄█
 ░▒█░░ ▒█░▒█ ▒█░░░ ░▒█░░ ▒█░▒█ ▒█░░░

 ▒█▀▀▀█ ▀▀█▀▀ ▒█░▒█ ▒█▀▀▄ ▀█▀ ▒█▀▀▀█
 ░▀▀▀▄▄ ░▒█░░ ▒█░▒█ ▒█░▒█ ▒█░ ▒█░░▒█
 ▒█▄▄▄█ ░▒█░░ ░▀▄▄▀ ▒█▄▄▀ ▄█▄ ▒█▄▄▄█
 
 If you want reskin write me.
 Here you can see reskin examples 🌅: https://alicevinnik.wixsite.com/taptapstudio
 Subscribe to my instagram 📷: https://www.instagram.com/taptap_studio/
 Write to my mail 💌: taptap.main@gmail.com
 
*/

import SpriteKit

class SkinValues {
    // MARK: - Values
    static let textures = [GraphicPreloadsInterface.preload.skin1,
                           GraphicPreloadsInterface.preload.skin2,
                           GraphicPreloadsInterface.preload.skin3,
                           GraphicPreloadsInterface.preload.skin4]
    static let size = [CGSize.withPercentScaled(20, height: 20),
                       CGSize.withPercentScaled(20, height: 20),
                       CGSize.withPercentScaled(20, height: 20),
                       CGSize.withPercentScaled(20, height: 20)]
    static let prices = [0,
                         50,
                         50,
                         50]
    // MARK: - Methods
    /** Function for loading skin stats to user defaults*/
    static func loadValues() {
        UserDefaults.standard.set(true, forKey: "Skin1IsUnlock")
        for skinStats in 2...1000 {
            UserDefaults.standard.set(false, forKey: "Skin" + String(skinStats) + "IsUnlock")
        }
    }
    /**
     Use this function for get answer for question of some skin is availble or not
     - parameter name: Int value with id of current skin.
     - returns: Value with current state of skin is alailable or not.
     */
    static func getIsAvailable(forSkinNumber number: Int) -> Bool {
        return UserDefaults.standard.bool(forKey: "Skin" + String(number) + "IsUnlock")
    }
    /**
     Use this function for make some skin available.
     - parameter name: Int value with id of current skin.
     */
    static func makeAvailableSkin(byNumber number: Int) {
        UserDefaults.standard.set(true, forKey: "Skin" + String(number) + "IsUnlock")
    }
    /**
    Use this function if you need minimal price for skin.
    - returns: Value with minimal price for a skin
    */
    static func getMinimalPrice() -> Int {
        var minimalPrice = SkinValues.prices[SkinValues.prices.count - 1]
        for price in SkinValues.prices {
            if price != 0 && price < minimalPrice {
                minimalPrice = price
            }
        }
        return minimalPrice
    }
}
