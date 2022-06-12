/*
 
 Created by TapTapStudio (Alice Vinnik).
 Copyright ©2021 TapTapStudio. All rights reserved.

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

class TextField: TransparentSprite {
    
    enum SortingSide {
        case up
        case down
    }
    fileprivate var sortingSide = SortingSide.up
    fileprivate var horizontalAligmentType = SKLabelHorizontalAlignmentMode.center
    
    fileprivate var text: String = ""
    fileprivate var widthSize: CGFloat = 0.0
    fileprivate var spaceBetweenLabels: CGFloat = 0.0
    fileprivate var fontSize: CGFloat = 0.0
    fileprivate var fontColor: String = ""
    
    var labels = [SimpleLabel]()
    
    // MARK: - Initialisations
    
    /**
     Initialise text field
     */
    init(withText text: String, widthSize: CGFloat, spaceBetweenLabels: CGFloat, fontSize: CGFloat, fontColor: String, position: CGPoint, zPosition: CGFloat) {
        super.init(position: position, zPosition: zPosition)
        
        self.text = text
        self.widthSize = widthSize
        self.spaceBetweenLabels = spaceBetweenLabels
        self.fontSize = fontSize
        self.fontColor = fontColor
        
        refreshLines()
    }
    
    /**
     If your custom init function not can run compiler call this function
     */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Work with labels
    func refreshLines() {
        //Clear old
        if !labels.isEmpty {
            for label in labels {
                label.removeFromParent()
            }
            labels = [SimpleLabel]()
        }
        
        //Generate text lines
        if !text.isEmpty {
            let cacheLabel = SimpleLabel(text: "", fontSize: fontSize, fontColorHex: fontColor, position: .zero, zPosition: 0)
            var words = text.components(separatedBy: " ")
            
            var textLines = [String]()
            var textLine = ""
            while !words.isEmpty {
                let textLineFuture = textLine + words.first! + " "
                cacheLabel.text = textLineFuture
                
                if cacheLabel.frame.width >= widthSize {
                    var textFinal = textLine
                    textFinal.removeLast()
                    textLines.append(textFinal)
                    textLine = ""
                }
                else {
                    textLine += words.first! + " "
                    words.removeFirst()
                    if words.isEmpty {
                        textLine.removeLast()
                        textLines.append(textLine)
                    }
                }
            }
            
            //Create positionLabelHeight
            for textLine in textLines {
                let label = SimpleLabel(text: textLine, fontSize: fontSize, fontColorHex: fontColor, position: .zero, zPosition: 0.1)
                addChild(label)
                labels.append(label)
            }
            applyAligments()
            refreshLabelsPositions()
        }
    }
    func applyAligments() {
        for label in labels {
            label.horizontalAlignmentMode = horizontalAligmentType
            switch sortingSide {
            case .up:
                label.verticalAlignmentMode = .top
            case .down:
                label.verticalAlignmentMode = .bottom
            }
        }
    }
    
    func refreshLabelsPositions() {
        //Find start point
        var positionY: CGFloat
        switch sortingSide {
        case .up:
            positionY = 0
        case .down:
            positionY = CGFloat(labels.count - 1) * spaceBetweenLabels
        }
        //Set labels to positions
        for label in labels {
            label.position = CGPoint(x: 0, y: positionY)
            
            positionY -= spaceBetweenLabels
        }
    }
    // MARK: - Setters
    func setText(_ new: String) {
        text = new
        refreshLines()
    }
    func setHorizontalAligment(to new: SKLabelHorizontalAlignmentMode) {
        horizontalAligmentType = new
        applyAligments()
    }
    func setSortingSide(_ new: SortingSide) {
        sortingSide = new
        
        applyAligments()
        refreshLabelsPositions()
    }
    
    func setPosition(_ new: CGPoint) {
        position = new
    }
    
    // MARK: - Shadow
    func setShadowDefault() {
        for label in labels {
            label.setShadowDefault()
        }
    }
    func setShadow(withBlur blur: CGFloat, andAlpha alpha: CGFloat, andShift shift: CGFloat) {
        for label in labels {
            label.setShadow(withBlur: blur, andAlpha: alpha, andShift: shift)
        }
    }
}
