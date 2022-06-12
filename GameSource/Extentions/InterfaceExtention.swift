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

class InterfaceExtention {
    
    // MARK: - Put
    /**
     Call this func for sort nodes by frames.
     - parameter nodes: Array with nodes to sorting ant scene.
     - parameter positionToSet: Central position for setting frame.
     - parameter space: Space between objects at frame.
     - parameter horizontalSorting: Type of sorting betwen horizontal or vertical.
     */
    static func put(nodesWithArray nodes: [SimpleSprite], atPosition positionToSet: CGPoint, withSpaceBetween space: CGFloat, andSortHorizontal horizontalSorting: Bool) {
        ///Get all object size
        var currentSizeOfThisFrame: CGFloat = 0
        for node in nodes {
            currentSizeOfThisFrame += horizontalSorting ? node.size.width : node.size.height
            currentSizeOfThisFrame += space
        }
        currentSizeOfThisFrame -= space
        
        ///Get positions to set
        var positionX = horizontalSorting ? positionToSet.x - (currentSizeOfThisFrame / 2) : positionToSet.x
        var positionY = horizontalSorting ? positionToSet.y : positionToSet.y - (currentSizeOfThisFrame / 2)
        
        ///Set nodes to position
        for node in nodes {
            ///Update positions to set current ndoe
            positionX += horizontalSorting ? node.size.width / 2 : 0
            positionY += horizontalSorting ? 0 : node.size.height / 2
            
            ///Set node to position
            node.position = CGPoint(x: positionX, y: positionY)
            
            ///Update positions to set next node
            positionX += horizontalSorting ? (node.size.width / 2) + space : 0
            positionY += horizontalSorting ? 0 : (node.size.height / 2) + space
        }
    }
    
    /**
     Call this func for sort labels by frames.
     - parameter nodes: Array with nodes to sorting ant scene.
     - parameter positionToSet: Central position for setting frame.
     - parameter space: Space between objects at frame.
     - parameter horizontalSorting: Type of sorting betwen horizontal or vertical.
     */
    static func put(nodesWithArray nodes: [SimpleLabel], atPosition positionToSet: CGPoint, withSpaceBetween space: CGFloat, andSortHorizontal horizontalSorting: Bool) {
        ///Get all object size
        var currentSizeOfThisFrame: CGFloat = 0
        for node in nodes {
            currentSizeOfThisFrame += horizontalSorting ? node.frame.width : node.frame.height
            currentSizeOfThisFrame += space
        }
        currentSizeOfThisFrame -= space
        
        ///Get positions to set
        var positionX = horizontalSorting ? positionToSet.x - (currentSizeOfThisFrame / 2) : positionToSet.x
        var positionY = horizontalSorting ? positionToSet.y : positionToSet.y - (currentSizeOfThisFrame / 2)
        
        ///Set nodes to position
        for node in nodes {
            ///Update positions to set current ndoe
            positionX += horizontalSorting ? node.frame.width / 2 : 0
            positionY += horizontalSorting ? 0 : node.frame.height / 2
            
            ///Set node to position
            node.position = CGPoint(x: positionX, y: positionY)
            
            ///Update positions to set next node
            positionX += horizontalSorting ? (node.frame.width / 2) + space : 0
            positionY += horizontalSorting ? 0 : (node.frame.height / 2) + space
        }
    }
    
    // MARK: - Mirrored
    /**
     Mirror position from one nodes to another
     - parameter toMirror: Nodes who get positions.
     - parameter fromMirror: Nodes with position to set.
     - parameter mirrorByX: Mirror X or Y positions.
     */
    static func mirrored(nodesToMirror toMirror: [SKNode], fromNodes fromMirror: [SKNode], byX mirrorByX: Bool) {
        if toMirror.count == fromMirror.count {
            for i in 0..<toMirror.count {
                let positionStartX = toMirror[i].position.x
                let positionStartY = toMirror[i].position.y
                let positionMirroredX = fromMirror[i].position.x
                let positionMirroredY = fromMirror[i].position.y
                
                toMirror[i].position = CGPoint(x: mirrorByX ? positionMirroredX : positionStartX, y: mirrorByX ? positionStartY : positionMirroredY)
            }
        }
    }
}
