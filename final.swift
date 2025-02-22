import SwiftUI
import SpriteKit

class final: SKScene {
    var box: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red: 249/255, green: 239/255, blue: 223/255, alpha: 1)
        run(SKAction.playSoundFileNamed("clap.mp3", waitForCompletion: false))
        
        let background = SKSpriteNode(imageNamed: "ground")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.size = CGSize(width: frame.width, height: frame.height)
        background.zPosition = -1
        addChild(background)
        
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
    
    private func setupBox() {
        box = SKSpriteNode(imageNamed: "box")
        box.size = CGSize(width: 400, height: 300)
        box.position = CGPoint(x: frame.midX, y: frame.midY + 50)
        box.zPosition = 10
        addChild(box)
        
        let titleLabel = SKLabelNode(fontNamed: "SFProDisplay-Bold")
        titleLabel.text = "You did it"
        titleLabel.fontSize = 24
        titleLabel.fontColor = .black
        titleLabel.position = CGPoint(x: 0, y: box.size.height / 4 - 80)
        titleLabel.horizontalAlignmentMode = .center
        titleLabel.verticalAlignmentMode = .center
        box.addChild(titleLabel)
        
        let additionalImage = SKSpriteNode(imageNamed: "starts") 
        additionalImage.size = CGSize(width: 150, height: 150)
        
        let labelBottomY = titleLabel.position.y - (titleLabel.frame.height / 2)
        additionalImage.position = CGPoint(x: 0, y: labelBottomY - additionalImage.size.height / 2 + 120)
        additionalImage.zPosition = 11
        box.addChild(additionalImage)
        
        let butbox = SKSpriteNode(imageNamed: "butunclk")
        butbox.size = CGSize(width: 170, height: 170)
        butbox.position = CGPoint(x: 0, y: box.size.height / 4 - 120)
        butbox.zPosition = 11
        butbox.name = "mainMenuButton"
        box.addChild(butbox)
        
        let buttonLabel = SKLabelNode(fontNamed: "SFProDisplay-Bold")
        buttonLabel.text = "Main menu"
        buttonLabel.fontSize = 20
        buttonLabel.fontColor = .black
        buttonLabel.position = .zero
        buttonLabel.horizontalAlignmentMode = .center
        buttonLabel.verticalAlignmentMode = .center
        butbox.addChild(buttonLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tappedNodes = nodes(at: location)
        
        for node in tappedNodes {
            if node.name == "mainMenuButton" {
                print("Button tapped!")
                
                let buttonPositionInBox = box.convert(node.position, from: node.parent!)
                node.removeFromParent()
                
                let newImageNode = SKSpriteNode(imageNamed: "butclick")
                newImageNode.size = CGSize(width: 170, height: 170)
                newImageNode.position = CGPoint(x: buttonPositionInBox.x, y: buttonPositionInBox.y + 10)
                newImageNode.zPosition = 11
                box.addChild(newImageNode)
                
                let buttonLabel = SKLabelNode(fontNamed: "SFProDisplay-Bold")
                buttonLabel.text = "Main menu"
                buttonLabel.fontSize = 20
                buttonLabel.fontColor = .black
                buttonLabel.position = .zero
                buttonLabel.horizontalAlignmentMode = .center
                buttonLabel.verticalAlignmentMode = .center
                newImageNode.addChild(buttonLabel)
                
                let nextScene = GameScene(size: self.size) 
                nextScene.scaleMode = .aspectFill
                
                let transition = SKTransition.fade(withDuration: 1.0)
                self.view?.presentScene(nextScene, transition: transition)
            }
        }
    }
}
