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

class BackgroundNode: SimpleSprite {
    
    // MARK: - Initialisations
    /** Initialisation of node.*/
    init() {
        super.init(texture: GraphicPreloadsInterface.preload.background, size: SettingsScenes.Menu.Size.background, position: SettingsScenes.Menu.Position.background, zPosition: SettingsScenes.Menu.ZPosition.background)
        loadDefaultStats()
    }
    
    /** If your custom init function not can run compiler call this function.*/
    required init?(coder aDecoder: NSCoder) { fatalError("PlayerNode init(coder:) has not been implemented")}
    
    // MARK: - Loading settings for current background
    /** Load default values for node at different scenes*/
    func loadDefaultStats() {
        switch GlobalScene.getCurrentLoadedScene() {
        case .menu:
            texture = GraphicPreloadsInterface.preload.background
            size = SettingsScenes.Menu.Size.background
            position = SettingsScenes.Menu.Position.background
            zPosition = SettingsScenes.Menu.ZPosition.background
        case .game:
            texture = GraphicPreloadsGame.preload.background
            size = SettingsScenes.Game.Size.background
            position = SettingsScenes.Game.Position.background
            zPosition = SettingsScenes.Game.ZPosition.background
        case .end:
            texture = GraphicPreloadsInterface.preload.background
            size = SettingsScenes.End.Size.background
            position = SettingsScenes.End.Position.background
            zPosition = SettingsScenes.End.ZPosition.background
        case .settings:
            texture = GraphicPreloadsInterface.preload.background
            size = SettingsScenes.Settings.Size.background
            position = SettingsScenes.Settings.Position.background
            zPosition = SettingsScenes.Settings.ZPosition.background
       
        }
    }
}
