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

import Foundation

class Debugger {
    // MARK: - Debugger Work
    /**
     Call this func for print some in log.
     You can turn off all debugger log messages in SettingGlobal.swift folder.
     Just change debugMode value.
     */
    static func printNow(textToPrint value: String, withCallingFile callingFile: String = #file, andCallingFunction callingFunction: String = #function, andCallingLine callingLine: Int = #line) {
        if SettingsGlobal.debugMode {
            let reversedFileName = callingFile.reversed()
            var indexOfSeparator: Int = 0
            for i in 0..<Array(reversedFileName).count {
                if Array(reversedFileName)[i] == "/" {
                    indexOfSeparator = i
                    break
                }
            }
            let className = reversedFileName.prefix(indexOfSeparator).reversed()
            print("🟢 " + className + " - " + callingFunction + " at " + String(callingLine) + ": " + value)
        }
    }
}
