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

import UIKit
import SpriteKit
import GameKit
import iAd
import MessageUI
import StoreKit

class GameViewController: UIViewController {
    // MARK: - Values
    var tableViewGameScore = UITableView()
    // MARK: - Work with view
    /** Default func when created first game scene.*/
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Get info for creating scene
        UserDefaults.standard.set(Float(view.frame.size.width), forKey: "SizeWidth")
        UserDefaults.standard.set(Float(view.frame.size.height), forKey: "SizeHeight")
        /// Load project settings
        firstLaunchSettings()
        everyLaunchSettings()

        /// Create view 
        guard let view = view as? SKView else {return}
        /// Create first scene
        let scene = MenuScene(size: view.frame.size)
        scene.scaleMode = .aspectFill
        scene.size = view.frame.size
        view.presentScene(scene)
        /// Load sound component
        Sound.preload.initMusic()
        Sound.preload.targetScene = scene

    }
    // MARK: - Some system settings
    override var prefersStatusBarHidden: Bool { return true}
}
