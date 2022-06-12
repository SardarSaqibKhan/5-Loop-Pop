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

class LogoSmallNode: SimpleSprite, Logo {
    
    /** This enum store possible type of logo*/
    enum Types {
        case settings
        case pause
    }
    
    var currentType = Types.settings
    var label = SimpleLabel(text: "", fontSize: 0, fontColorHex: "#ffffff", position: .zero, zPosition: 0.1)
    
    // MARK: - Initialistions
    /**
     Initialisation of logo node
     - parameter textureSimpleState: SKTexture object of texture button in up state.
     */
    init(withType type: Types) {
        currentType = type
        super.init(texture: GraphicPreloadsInterface.preload.transparent, size: .zero, position: CGPoint(x: SettingsGlobal.width * 3, y: SettingsGlobal.height * 3), zPosition: SettingsScenes.Settings.ZPosition.textSettings)
        
        label.horizontalAlignmentMode = .center
        addChild(label)
        
        loadStatsByCurrentType()
        if currentType != .pause {
            runAnimation()
        }
    }
    /** If your custom init function not can run compiler call this function.*/
    required init?(coder aDecoder: NSCoder) { fatalError("LogoNode init(coder:) has not been implemented")}
    
    // MARK: - Work with logo
    func loadStatsByCurrentType() {
        switch currentType {
        case .settings:
            position = SettingsScenes.Settings.Position.textSettings
            zPosition = SettingsScenes.Settings.ZPosition.textSettings
            
            label.text = NSLocalizedString("settingsScene_Title", comment: "")
            label.fontSize = SettingsScenes.Settings.FontSize.title
            label.fontColor = UIColor(hexString: SettingsScenes.Settings.FontColor.title)
            label.setShadowDefault()
        case .pause:
            position = SettingsScenes.Game.Position.textPause
            zPosition = SettingsScenes.Game.ZPosition.textPause
            
            label.text = NSLocalizedString("gameScene_PauseTitle", comment: "")
            label.fontSize = SettingsScenes.Game.FontSize.pauseTitle
            label.fontColor = UIColor(hexString: SettingsScenes.Game.FontColor.pauseTitle)
            label.setShadowDefault()
        }
    }
    func runAnimation() {
        let positionYDefault = position.y
        position = CGPoint(x: position.x, y: SettingsGlobal.height * 1.3)
        run(SKAction.moveTo(y: positionYDefault, duration: SettingsGameProcess.Interface.LogoSmall.animationShowSpeed))
    }
}
