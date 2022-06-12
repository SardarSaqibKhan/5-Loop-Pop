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

// MARK: - Object extentions
extension SKTexture {
    /**
     Create texture object considerate filtration settigns.
     Use for considerate filtration setting in game. You can change it settings in SettingsGlobal.swift. Find filteredImagesInGame value in WorkWithScenes struct.
     - parameter imageName: You image name in String format.
     */
    convenience init(сonsideringFiltrationSettingsInProject imageName: String) {
        self.init(imageNamed: imageName)
        if !SettingsGlobal.WorkWithScenes.filteredImagesInGame {
            filteringMode = .nearest
        }
    }
}
extension UIColor {
    /**
     Create UIColor object from hex value.
     - parameter hexString: It string with you color name in hex. It been look like it "#ffffff".
     */
    convenience init(hexString: String) {
        if #available(iOS 13.0, *) {
            var hexFormatted: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
            
            if hexFormatted.hasPrefix("#") {
                hexFormatted = String(hexFormatted.dropFirst())
            }
            
            assert(hexFormatted.count == 6, "Invalid hex code used.")
            
            var rgbValue: UInt64 = 0
            Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
            
            self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                      green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                      blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                      alpha: 1.0)
        }
        else {
            let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            var int = UInt32()
            Scanner(string: hex).scanHexInt32(&int)
            
            ///Decode hex
            let a, r, g, b: UInt32
            switch hex.count {
            case 3: (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default: (a, r, g, b) = (1, 1, 1, 0)
            }
            
            ///Create UIColoe
            self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
        }
    }
}
// MARK: Animation
extension SKAction {
    /** Same function like standart SKAction, but here we can use degrees for setup rotate destination.*/
    static func rotateByDegree(_ degree: CGFloat, duration: TimeInterval) -> SKAction {
        return SKAction.rotate(byAngle: CGFloat(degreeToRadian: degree), duration: duration)
    }
    /** Same function like standart SKAction, but here we can use degrees for setup rotate destination. */
    static func rotateToDegree(_ degree: CGFloat, duration: TimeInterval) -> SKAction {
        return SKAction.rotate(toAngle: CGFloat(degreeToRadian: degree), duration: duration)
    }
    /** Same function like standart SKAction, but here we can use degrees for setup rotate destination. */
    static func rotateToDegree(_ degree: CGFloat, duration: TimeInterval, shortestUnitArc: Bool) -> SKAction {
        return SKAction.rotate(toAngle: CGFloat(degreeToRadian: degree), duration: duration, shortestUnitArc: shortestUnitArc)
    }
}
// MARK: Sizes and positions
extension CGSize {
    /** Init size form percent size of scene. */
    static func withPercent(_ width: CGFloat, height: CGFloat) -> CGSize {
        return CGSize(width: CGFloat(SettingsGlobal.width) / 100 * width, height: CGFloat(SettingsGlobal.height) / 100 * height)
    }
    
    /** Init size form percent size of scene. In this init height scaled by widht. Use this for make size with an equal aspect ratio on different screen sizes. */
    static func withPercentScaled(_ width: CGFloat, height: CGFloat) -> CGSize {
        return CGSize(width: CGFloat(SettingsGlobal.width) / 100 * width, height: CGFloat(SettingsGlobal.width) / 100 * height)
    }
    /** Init size form percent size of scene. In this init height scaled by widht. Use this for calling simmilar height and width size.*/
    static func withPercentScaled(roundByWidth width: CGFloat) -> CGSize {
        return CGSize(width: CGFloat(SettingsGlobal.width) / 100 * width, height: CGFloat(SettingsGlobal.width) / 100 * width)
    }
    /** Init size form percent size of scene. In this init height scaled by height. Use this for calling simmilar height and width size.*/
    static func withPercentScaled(roundByHeight height: CGFloat) -> CGSize {
        return CGSize(width: CGFloat(SettingsGlobal.height) / 100 * height, height: CGFloat(SettingsGlobal.height) / 100 * height)
    }
}
extension CGPoint {
    /** Init position from percent of screen size*/
    static func withPercent(_ x: CGFloat, y: CGFloat) -> CGPoint {
        return CGPoint(x: CGFloat(SettingsGlobal.width) / 100 * x, y: CGFloat(SettingsGlobal.height) / 100 * y)
    }
    /** Init position from percent of screen size*/
    static func withPercentScaledByWidth(_ x: CGFloat, y: CGFloat) -> CGPoint {
        return CGPoint(x: CGFloat(SettingsGlobal.width) / 100 * x, y: CGFloat(SettingsGlobal.width) / 100 * y)
    }
    /** Init position from percent of screen size*/
    static func withPercentScaledByHeight(_ x: CGFloat, y: CGFloat) -> CGPoint {
        return CGPoint(x: CGFloat(SettingsGlobal.height) / 100 * x, y: CGFloat(SettingsGlobal.height) / 100 * y)
    }
    /** You can use this method for making easy shifting position from cenrral point if your game worl stay in one point all time*/
    static func withShiftFromCentrerOfOriginallyGameField(_ x: CGFloat, y: CGFloat) -> CGPoint {
        return CGPoint(x: (SettingsGlobal.width / 2) + x, y: (SettingsGlobal.height / 2) + y)
    }
    /** You can use this method for getting central point in game if your game worl stay in one point all time*/
    static func getOriginallyGameFieldCenter() -> CGPoint {
        return CGPoint(x: SettingsGlobal.width / 2, y: SettingsGlobal.height / 2)
    }
}
// MARK: - SKSpriteNode
extension SKSpriteNode {
    func new(positionByX x: CGFloat) { self.position = CGPoint(x: x, y: position.y)}
    func new(positionByY y: CGFloat) { self.position = CGPoint(x: position.x, y: y)}
}
// MARK: - Value extentions
//Shuffle array
extension Array {
    /** Use this for shuffle arrays */
    mutating func shuffle() {
        for _ in 0..<10 { sort { (_, _) in arc4random() < arc4random() }}
    }
}
//Randoms
public extension Bool {
    /** Get random bool value */
    static func random() -> Bool { return Int(from: 1, to: 2) == 1 ? true : false}
    /** Change value to another if now value is*/
    mutating func toggle(if ifNow: Bool) {
        if self == ifNow {
            self = !self
        }
    }
}
protocol Values {
    //Randoms
    /** Get random value */
    init<T: BinaryFloatingPoint>(from: T, to: T)
    /** Random from zero to value */
    init<T: BinaryFloatingPoint>(fromZeroTo value: T)
    //Degrees and radians
    /** Convert degrees to radian */
    init<T: BinaryFloatingPoint>(degreeToRadian degree: T)
    /** Convert radian to degrees */
    init<T: BinaryFloatingPoint>(radianToDegrees radian: T)
    //Percentage changes
    /** Increase value by percent. Currect value is 100 percent*/
    mutating func increase <T: BinaryFloatingPoint>(percentage percent: T)
    /** Decrease value by percent. Currect value is 100 percent*/
    mutating func decrease <T: BinaryFloatingPoint>(percentage percent: T)
}
extension Int: Values {
    //Randoms
    /** Get random integer value */
    init<T: BinaryInteger>(from: T, to: T) {
        self = from < to ?
            Int(arc4random_uniform(UInt32(Int(to) - Int(from) + 1))) + Int(from) :
            Int(arc4random_uniform(UInt32(Int(from) - Int(to) + 1))) + Int(to)
    }
    init<T: BinaryFloatingPoint>(from: T, to: T) {
        self = from < to ?
            Int(arc4random_uniform(UInt32(Int(to) - Int(from) + 1))) + Int(from) :
            Int(arc4random_uniform(UInt32(Int(from) - Int(to) + 1))) + Int(to)
    }
    init<T: BinaryFloatingPoint>(fromZeroTo value: T) { self = Int(from: 0, to: Double(value))}
    //Degrees and radians
    init<T: BinaryFloatingPoint>(degreeToRadian degree: T) { self = Int(Double(degree) * Double.pi / 180.0)}
    init<T: BinaryFloatingPoint>(radianToDegrees radian: T) { self = Int(Double(radian) * 180.0 / Double.pi)}
    //Percentage changes
    mutating func increase <T: BinaryFloatingPoint>(percentage percent: T) { self = Int(Double(self) + (Double(self) / 100.0) * Double(percent))}
    mutating func decrease <T: BinaryFloatingPoint>(percentage percent: T) { self = Int(Double(self) - (Double(self) / 100.0) * Double(percent))}
}

extension Double: Values {
    //Randoms
    init<T: BinaryFloatingPoint>(from: T, to: T) {
        self = from < to ?
            (Double(arc4random()) / Double(UInt32.max)) * (Double(to) - Double(from)) + Double(from) :
            (Double(arc4random()) / Double(UInt32.max)) * (Double(from) - Double(to)) + Double(to)
    }
    init<T: BinaryFloatingPoint>(fromZeroTo value: T) { self = Double(from: 0, to: Double(value))}
    //Degrees and radians
    init<T: BinaryFloatingPoint>(degreeToRadian degree: T) { self = Double(degree) * Double.pi / 180.0}
    init<T: BinaryFloatingPoint>(radianToDegrees radian: T) { self = Double(radian) * 180.0 / Double.pi}
    //Percentage changes
    mutating func increase <T: BinaryFloatingPoint>(percentage percent: T) { self = self + (self / 100.0) * Double(percent)}
    mutating func decrease <T: BinaryFloatingPoint>(percentage percent: T) { self = self - (self / 100.0) * Double(percent)}
}

extension Float: Values {
    //Randoms
    init<T: BinaryFloatingPoint>(from: T, to: T) {
        self = from < to ?
            (Float(arc4random()) / Float(UInt32.max)) * (Float(to) - Float(from)) + Float(from) :
            (Float(arc4random()) / Float(UInt32.max)) * (Float(from) - Float(to)) + Float(to)
    }
    init<T: BinaryFloatingPoint>(fromZeroTo value: T) { self = Float(from: 0, to: Float(value))}
    //Degrees and radians
    init<T: BinaryFloatingPoint>(degreeToRadian degree: T) { self = Float(degree) * Float.pi / 180.0}
    init<T: BinaryFloatingPoint>(radianToDegrees radian: T) { self = Float(radian) * 180.0 / Float.pi}
    
    //Percentage changes
    mutating func increase <T: BinaryFloatingPoint>(percentage percent: T) { self = self + (self / 100.0) * Float(percent)}
    mutating func decrease <T: BinaryFloatingPoint>(percentage percent: T) { self = self - (self / 100.0) * Float(percent)}
}

extension CGFloat: Values {
    //Randoms
    init<T: BinaryFloatingPoint>(from: T, to: T) {
        self = from < to ? (CGFloat(arc4random()) / CGFloat(UInt32.max)) * (CGFloat(to) - CGFloat(from)) + CGFloat(from) : (CGFloat(arc4random()) / CGFloat(UInt32.max)) * (CGFloat(from) - CGFloat(to)) + CGFloat(to)
    }
    init<T: BinaryFloatingPoint>(fromZeroTo value: T) { self = CGFloat(from: 0, to: CGFloat(value))}
    
    //Degrees and radians
    init<T: BinaryFloatingPoint>(degreeToRadian degree: T) { self = CGFloat(degree) * CGFloat.pi / 180.0}
    init<T: BinaryFloatingPoint>(radianToDegrees radian: T) { self = CGFloat(radian) * 180.0 / CGFloat.pi}
    //Percentage changes
    mutating func increase <T: BinaryFloatingPoint>(percentage percent: T) { self = self + (self / 100.0) * CGFloat(percent)}
    mutating func decrease <T: BinaryFloatingPoint>(percentage percent: T) { self = self - (self / 100.0) * CGFloat(percent)}
}
