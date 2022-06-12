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

class LogoNode: SimpleSprite, Logo {
    
    /** This enum store possible type of logo*/
    enum Types {
        case menu
        case end
    }
    
    var currentType = Types.menu
    
    // MARK: - Initialistions
    /**
     Initialisation of logo node
     - parameter textureSimpleState: SKTexture object of texture button in up state.
     */
    init(withType type: Types) {
        currentType = type
        super.init(texture: GraphicPreloadsInterface.preload.logo, size: SettingsScenes.Menu.Size.logo, position: SettingsScenes.Menu.Position.logo, zPosition: SettingsScenes.Menu.ZPosition.logo)
        
        loadStatsByCurrentType()
        runAnimation()
    }
    /** If your custom init function not can run compiler call this function.*/
    required init?(coder aDecoder: NSCoder) { fatalError("LogoNode init(coder:) has not been implemented")}
    
    // MARK: - Work with logo
    func loadStatsByCurrentType() {
        switch currentType {
        case .menu:
            texture = GraphicPreloadsInterface.preload.logo
            size = SettingsScenes.Menu.Size.logo
            position = SettingsScenes.Menu.Position.logo
            zPosition = SettingsScenes.Menu.ZPosition.logo
        case .end:
            texture = GraphicPreloadsInterface.preload.logo
            size = SettingsScenes.End.Size.logo
            position = SettingsScenes.End.Position.logo
            zPosition = SettingsScenes.End.ZPosition.logo
        }
    }
    func runAnimation() {
        repeatActionPulse(toSize: SettingsGameProcess.Interface.LogoPulse.scaleTo, time: SettingsGameProcess.Interface.LogoPulse.speed)
    }
}
