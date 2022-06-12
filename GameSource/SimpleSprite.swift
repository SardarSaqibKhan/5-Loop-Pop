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

class SimpleSprite: SKSpriteNode {
    // Shadow values
    private var shadow: SKSpriteNode?
    private var effectNode: SKEffectNode?
    public enum CornersType {
        case topLeft
        case topCentral
        case topRight
        case middleLeft
        case middleCentral
        case middleRight
        case bottomLeft
        case bottomCentral
        case bottomRight
    }
    // MARK: - Initialisation
    /**
     Initialise node
     - parameter imageName: String value with name of image for node.
     - parameter size: CGSize object for set size of node.
     - parameter position: CGPoint object for set position node on scene.
     - parameter zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    init(imageName: String, size: CGSize, position: CGPoint, zPosition: CGFloat) {
        super.init(texture: SKTexture(сonsideringFiltrationSettingsInProject: imageName), color: .clear, size: size)
        self.position = position
        self.zPosition = zPosition
    }
    /**
     Initialise node
     - parameter texture: SKTexture object with texture for node.
     - parameter size: CGSize object for set size of node.
     - parameter position: CGPoint object for set position node on scene.
     - parameter zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    init(texture: SKTexture, size: CGSize, position: CGPoint, zPosition: CGFloat) {
        super.init(texture: texture, color: UIColor.clear, size: size)
        self.position = position
        self.zPosition = zPosition
    }
    /**
     Initialise node
     - parameter texture: SKTexture object with texture for node.
     - parameter size: CGSize object for set size of node.
     - parameter position: CGPoint object for set position node on scene.
     - parameter zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    init(texture: SKTexture, position: CGPoint, zPosition: CGFloat) {
        super.init(texture: texture, color: UIColor.clear, size: CGSize.zero)
        self.position = position
        self.zPosition = zPosition
    }
    /**
     Initialise node
     - parameter texture: SKTexture object with texture for node.
     - parameter size: CGSize object for set size of node.
     - parameter zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    init(texture: SKTexture, size: CGSize, zPosition: CGFloat) {
        super.init(texture: texture, color: UIColor.clear, size: size)
        self.position = CGPoint.zero
        self.zPosition = zPosition
    }
    /**
     Initialise node
     - parameter texture: SKTexture object with texture for node.
     - parameter zPosition: CGFloat value for set position node by z coordinate on scene.
     */
    init(texture: SKTexture, zPosition: CGFloat) {
        super.init(texture: texture, color: UIColor.clear, size: CGSize.zero)
        self.position = CGPoint.zero
        self.zPosition = zPosition
    }
    /** If your custom init function not can run compiler call this function*/
    required init?(coder aDecoder: NSCoder) { fatalError("SimpleSprite init(coder:) has not been implemented")}
    // MARK: - Repeat actions
    func repeatActionPulse(toSize size: CGFloat, time: Double) {
        run(SKAction.repeatForever(SKAction.sequence([
            SKAction.scale(to: size, duration: time),
            SKAction.scale(to: 1.0, duration: time)])))
    }
    // MARK: - Setters
    // Some position setters
    func set(positionX value: CGFloat) { position = CGPoint(x: value, y: position.y)}
    func set(positionY value: CGFloat) { position = CGPoint(x: position.x, y: value)}
    func set(randomPositionXFrom from: CGFloat, to: CGFloat) { position = CGPoint(x: CGFloat(from: from, to: to), y: position.y)}
    func set(randomPositionYFrom from: CGFloat, to: CGFloat) { position = CGPoint(x: position.x, y: CGFloat(from: from, to: to))}
    func setRandomPositionXWithSceneSize() { position = CGPoint(x: 0, y: SettingsGlobal.width)}
    func setRandomPositionYWithSceneSize() { position = CGPoint(x: 0, y: SettingsGlobal.height)}
    func setRandomPositionXWithSceneSizeIncludeObjectSize() { position = CGPoint(x: size.width / 2, y: SettingsGlobal.width - (size.width / 2))}
    func setRandomPositionYWithSceneSizeIncludeObjectSize() { position = CGPoint(x: size.height / 2, y: SettingsGlobal.height - (size.height / 2))}
    // Changer position from currentPoint
    func change(positionX value: CGFloat) { position = CGPoint(x: position.x + value, y: position.y)}
    func change(positionY value: CGFloat) { position = CGPoint(x: position.x, y: position.y + value)}
    // Set position at border
    func setToBorderOfScreenTop() { position = CGPoint(x: position.x, y: SettingsGlobal.height)}
    func setToBorderOfScreenDown() { position = CGPoint(x: position.x, y: 0)}
    func setToBorderOfScreenLeft() { position = CGPoint(x: 0, y: position.y)}
    func setToBorderOfScreenRight() { position = CGPoint(x: SettingsGlobal.width, y: position.y)}
    func setToBorderOfScreenTopIncludeObjectSize() { position = CGPoint(x: position.x, y: SettingsGlobal.height - size.height / 2)}
    func setToBorderOfScreenDownIncludeObjectSize() { position = CGPoint(x: position.x, y: 0 + size.height / 2)}
    func setToBorderOfScreenLeftIncludeObjectSize() { position = CGPoint(x: 0 + size.width / 2, y: position.y)}
    func setToBorderOfScreenRightIncludeObjectSize() { position = CGPoint(x: SettingsGlobal.width - size.width / 2, y: position.y)}
    // Set position to center
    func setToCenterByX() { position = CGPoint(x: SettingsGlobal.width / 2, y: position.y)}
    func setToCenterByY() { position = CGPoint(x: position.x, y: SettingsGlobal.height / 2)}
    // Scale interface nodes to iPad screen sizes
    func setInterfaceSize() {
        if SettingsGlobal.isIPad {
            self.size = CGSize(width: self.size.width * SettingsGameProcess.Interface.InterfaceScalesAtIPad.object,
                               height: self.size.height * SettingsGameProcess.Interface.InterfaceScalesAtIPad.object)
        }
    }
    // MARK: - Getters
    func get(globalCornerPoint cornerType: CornersType) -> CGPoint {
        return get(cornerPoint: cornerType, itsLocal: false)
    }
    func get(localCornerPoint cornerType: CornersType) -> CGPoint {
        return get(cornerPoint: cornerType, itsLocal: true)
    }
    private func get(cornerPoint cornerType: CornersType, itsLocal local: Bool) -> CGPoint {
        var positionX: CGFloat = local ? 0 : position.x
        var positionY: CGFloat = local ? 0 : position.y
        if cornerType == .topLeft || cornerType == .middleLeft || cornerType == .bottomLeft {
            positionX -= size.width / 2
        }
        if cornerType == .topRight || cornerType == .middleRight || cornerType == .bottomRight {
            positionX += size.width / 2
        }
        if cornerType == .topLeft || cornerType == .topCentral || cornerType == .topRight {
            positionY += size.height / 2
        }
        if cornerType == .bottomLeft || cornerType == .bottomCentral || cornerType == .bottomRight {
            positionY -= size.height / 2
        }
        return CGPoint(x: positionX, y: positionY)
    }
    // MARK: - Custom Add Child
    /** Current function helped with adding new nodes to scene.*/
    func addChild(_ nodes: [SKNode]) {
        for value in nodes { addChild(value)}
    }
    func addChild(_ labels: [SKLabelNode]) {
        for value in labels { addChild(value)}
    }
    // MARK: - Shadow
    func setShadowDefault() {
        setShadow(withBlur: 5.0, andAlpha: 0.30, andShift: SettingsGlobal.width / 100 * 1)
    }
    func setShadow(withBlur blur: CGFloat, andAlpha alpha: CGFloat, andShift shift: CGFloat) {
        // Remove old
        if shadow != nil {
            shadow!.removeFromParent()
            effectNode = nil
        }
        if effectNode != nil {
            effectNode!.removeAllChildren()
            effectNode!.removeFromParent()
            effectNode = nil
        }
        // Create effect
        let filter = CIFilter(name: "CIGaussianBlur")!
        filter.setDefaults()
        filter.setValue(blur, forKey: "inputRadius")
        effectNode = SKEffectNode()
        effectNode!.name = "SKEffectShadow"
        effectNode!.shouldEnableEffects = true
        effectNode!.zPosition = -1
        effectNode!.filter = filter
        // Create shadow
        shadow = SKSpriteNode(texture: texture, color: .clear, size: size)
        shadow!.colorBlendFactor = 1
        shadow!.color = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: alpha)
        shadow!.position = CGPoint(x: 0.0, y: -shift)
        shadow!.zPosition = -2
        effectNode!.addChild(shadow!)
        self.insertChild(effectNode!, at: 0)
    }
    // MARK: - Your features
}
