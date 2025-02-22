import SwiftUI
import SpriteKit

class myGa: SKScene {
    var box: SKSpriteNode!
    var ingredientsBox: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red: 249/255, green: 239/255, blue: 223/255, alpha: 1)
        
        setupIngredientsWithCheckbox()
        
        let background = SKSpriteNode(imageNamed: "ground")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.size = CGSize(width: frame.width, height: frame.height)
        background.zPosition = -1
        addChild(background)
        
        let picfire1 = SKSpriteNode(imageNamed: "fire1")
        picfire1.size = CGSize(width: 100, height: 100)
        picfire1.position = CGPoint(x: frame.midX - 80, y: frame.midY - 140)
        picfire1.zPosition = 3
        addChild(picfire1)
        
        let picbut = SKSpriteNode(imageNamed: "but")
        picbut.size = CGSize(width: 70, height: 70)
        picbut.position = CGPoint(x: frame.midX - 90, y: frame.midY - 100)
        picbut.zPosition = 3
        picbut.name = "picBut"
        addChild(picbut)
        
        let pictolcoffe = SKSpriteNode(imageNamed: "tolcoffe")
        pictolcoffe.size = CGSize(width: 40, height: 40)
        pictolcoffe.position = CGPoint(x: frame.midX - 20, y: frame.midY - 125)
        pictolcoffe.zPosition = 3
        pictolcoffe.name = "picTolCoffe"
        addChild(pictolcoffe)
        
        setupClouds()
        setupEnvironment()
    }
    
    private func setupClouds() {
        setupCloud(position: CGPoint(x: 300, y: 350), name: "cloud1")
        setupCloud(position: CGPoint(x: 100, y: 350), name: "cloud2")
        setupCloud(position: CGPoint(x: 500, y: 350), name: "cloud3")
    }
    
    private func setupCloud(position: CGPoint, name: String) {
        let cloud = SKSpriteNode(imageNamed: "cloud")
        cloud.size = CGSize(width: 200, height: 300)
        cloud.position = position
        cloud.zPosition = 2
        cloud.name = name
        addChild(cloud)
        
        let moveRight = SKAction.moveBy(x: 20, y: 0, duration: 5)
        let moveLeft = SKAction.moveBy(x: -20, y: 0, duration: 5)
        let sequence = SKAction.sequence([moveRight, moveLeft])
        let repeatAction = SKAction.repeatForever(sequence)
        cloud.run(repeatAction)
    }
    
    private func setupEnvironment() {
        let tree = SKSpriteNode(imageNamed: "tree_5")
        tree.position = CGPoint(x: 450, y: 140)
        tree.size = CGSize(width: 100, height: 150)
        tree.zPosition = 1
        addChild(tree)
        
        let home1 = SKSpriteNode(imageNamed: "home1")
        home1.size = CGSize(width: 150, height: 120)
        home1.position = CGPoint(x: (512 - home1.size.width/2) - 80, y: 100)
        home1.zPosition = 1
        addChild(home1)
        
        let home2 = SKSpriteNode(imageNamed: "home2")
        home2.size = CGSize(width: 90, height: 90)
        home2.position = CGPoint(x: (512 - home2.size.width/2) - 250, y: 100)
        home2.zPosition = 1
        addChild(home2)
        
        let stones = SKSpriteNode(imageNamed: "stones_9")
        stones.size = CGSize(width: 50, height: 40)
        stones.position = CGPoint(x: frame.maxX - 60, y: 80)
        stones.zPosition = 1
        addChild(stones)
        
        setupBox()
    }
    
    private func setupIngredientsWithCheckbox() {
        let texts = [
            "1 liter of water",
            "saffron",
            "coffee",
            "cardamom",
            "Dates"
        ]
        
        let serverNames = [
            "coffeeServer",
            "saffronServer",
            "waterServer",
            "cardamomServer",
            "datesServer"
        ]
        
        let verticalSpacing: CGFloat = 25
        
        let startY = frame.maxY - 30
        let checkboxXPosition = frame.maxX - 140
        let labelXPosition = checkboxXPosition + 18
        
        for i in 0..<texts.count {
            let text = texts[i]
            let serverName = serverNames[i]
            let yPosition = startY - CGFloat(i) * verticalSpacing
            
            let checkbox = SKShapeNode(rectOf: CGSize(width: 10, height: 10))
            checkbox.fillColor = .clear
            checkbox.strokeColor = .black
            checkbox.lineWidth = 0.8
            checkbox.name = "checkbox_\(serverName)"
            checkbox.position = CGPoint(x: checkboxXPosition, y: yPosition)
            checkbox.zPosition = 15
            addChild(checkbox)
            
            let label = SKLabelNode(fontNamed: "SFProDisplay-Bold")
            label.text = text
            label.fontSize = 12
            label.fontColor = SKColor(red: 38/255, green: 54/255, blue: 54/255, alpha: 1.0)
            label.horizontalAlignmentMode = .left
            label.verticalAlignmentMode = .center
            label.position = CGPoint(x: labelXPosition, y: yPosition)
            label.zPosition = 15
            label.name = "label_\(serverName)"
            addChild(label)
        }
    }
    
    private func setupBox() {
        box = SKSpriteNode(imageNamed: "box")
        box.size = CGSize(width: 400, height: 300)
        box.position = CGPoint(x: frame.midX - 100, y: frame.maxY + box.size.height)
        box.zPosition = 10
        addChild(box)
        
        let dropSeq = SKAction.sequence([
            .wait(forDuration: 2.0),
            .moveTo(y: frame.midY + 50, duration: 1.0),
            .wait(forDuration: 1.0)
        ])
        
        box.run(dropSeq) {
            self.setupServers()
        }
    }
    
    private func setupServers() {
        let waterServer = SKSpriteNode(imageNamed: "coffeeT")
        waterServer.size = CGSize(width: 50, height: 50)
        waterServer.position = CGPoint(x: -100, y: 0)
        waterServer.name = "waterServer"
        box.addChild(waterServer)
        
        let saffronServer = SKSpriteNode(imageNamed: "saffronT")
        saffronServer.size = CGSize(width: 50, height: 50)
        saffronServer.position = CGPoint(x: 0, y: 0)
        saffronServer.name = "saffronServer"
        box.addChild(saffronServer)
        
        let cardamomServer = SKSpriteNode(imageNamed: "cardmomT")
        cardamomServer.size = CGSize(width: 50, height: 50)
        cardamomServer.position = CGPoint(x: 100, y: 0)
        cardamomServer.name = "cardamomServer"
        box.addChild(cardamomServer)
        
        let coffeeServer = SKSpriteNode(imageNamed: "waterT")
        coffeeServer.size = CGSize(width: 50, height: 50)
        coffeeServer.position = CGPoint(x: -100, y: -40)
        coffeeServer.name = "coffeeServer"
        box.addChild(coffeeServer)
        
        let datetServer = SKSpriteNode(imageNamed: "datesT")
        datetServer.size = CGSize(width: 50, height: 50)
        datetServer.position = CGPoint(x: 0, y: -45)
        datetServer.name = "datesServer"
        box.addChild(datetServer)
        
        let titleLabel = SKLabelNode(fontNamed: "SFProDisplay-Bold")
        titleLabel.text = "Choose the ingredients for making coffee"
        titleLabel.fontSize = 15
        titleLabel.fontColor = .black
        titleLabel.position = CGPoint(x: 0, y: 30)
        titleLabel.zPosition = 1
        box.addChild(titleLabel)
        
        run(SKAction.sequence([
            SKAction.wait(forDuration: 1.0),
            SKAction.run { [weak self] in
                guard let self = self else { return }
                let newchr1 = SKSpriteNode(imageNamed: "chr1")
                newchr1.size = CGSize(width: 250, height: 250)
                newchr1.position = CGPoint(x: self.frame.midX + 50, y: self.frame.midY - 70)
                newchr1.zPosition = 11
                self.addChild(newchr1)
                
                self.run(SKAction.sequence([
                    SKAction.wait(forDuration: 1.0),
                    SKAction.run { [weak self] in
                        guard let self = self else { return }
                        let newchr2 = SKSpriteNode(imageNamed: "order")
                        newchr2.size = CGSize(width: 70, height: 70)
                        newchr2.position = CGPoint(x: self.frame.midX + 100, y: self.frame.midY + 10)
                        newchr2.zPosition = 12
                        newchr2.name = "orderButton"
                        self.addChild(newchr2)
                    }
                ]))
            }
        ]))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tappedNodes = nodes(at: location)
        
        for node in tappedNodes {
            if let name = node.name, name.hasPrefix("checkbox_") || name.hasPrefix("label_") {
                let serverName: String
                if name.hasPrefix("checkbox_") {
                    serverName = name.replacingOccurrences(of: "checkbox_", with: "")
                } else {
                    serverName = name.replacingOccurrences(of: "label_", with: "")
                }
                
                let checkboxName = "checkbox_\(serverName)"
                if let checkbox = childNode(withName: checkboxName) as? SKShapeNode {
                    checkbox.fillColor = checkbox.fillColor == .clear ? .black : .clear
                    
                    switch serverName {
                    case "coffeeServer", "datesServer":
                        run(SKAction.playSoundFileNamed("WaterS.mp3", waitForCompletion: false))
                    default:
                        run(SKAction.playSoundFileNamed("coffeS.mp3", waitForCompletion: false))
                    }
                    
                    if let serverNode = box.childNode(withName: serverName) {
                        let highlight = SKAction.sequence([
                            SKAction.scale(to: 1.2, duration: 0.2),
                            SKAction.scale(to: 1.0, duration: 0.2)
                        ])
                        serverNode.run(highlight)
                    }
                }
                
                return
            }
            
            if node.name == "picBut" || node.name == "picTolCoffe" {
                print("Transition to final scene!")
                let finalScene = final(size: self.size)
                finalScene.scaleMode = self.scaleMode
                let transition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(finalScene, transition: transition)
                return
            }
            
            guard let nodeName = node.name else { continue }
            
            switch nodeName {
            case "waterServer":
                run(SKAction.playSoundFileNamed("coffeS.mp3", waitForCompletion: false))
                if let checkbox = childNode(withName: "checkbox_waterServer") as? SKShapeNode {
                    checkbox.fillColor = .black
                }
            case "saffronServer":
                run(SKAction.playSoundFileNamed("coffeS.mp3", waitForCompletion: false))
                if let checkbox = childNode(withName: "checkbox_saffronServer") as? SKShapeNode {
                    checkbox.fillColor = .black
                }
            case "cardamomServer":
                run(SKAction.playSoundFileNamed("coffeS.mp3", waitForCompletion: false))
                if let checkbox = childNode(withName: "checkbox_cardamomServer") as? SKShapeNode {
                    checkbox.fillColor = .black
                }
            case "coffeeServer":
                run(SKAction.playSoundFileNamed("WaterS.mp3", waitForCompletion: false))
                if let checkbox = childNode(withName: "checkbox_coffeeServer") as? SKShapeNode {
                    checkbox.fillColor = .black
                }
            case "datesServer":
                run(SKAction.playSoundFileNamed("coffeS.mp3", waitForCompletion: false))
                if let checkbox = childNode(withName: "checkbox_datesServer") as? SKShapeNode {
                    checkbox.fillColor = .black
                }
            case "orderButton":
                print("Order tapped!")
                let finalScene = final(size: self.size)
                finalScene.scaleMode = self.scaleMode
                let transition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(finalScene, transition: transition)
            default:
                break
            }
        }
    }
}
