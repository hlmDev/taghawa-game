import SwiftUI
import SpriteKit

class HowPlayScene: SKScene {
    var box: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red: 249/255, green: 239/255, blue: 223/255, alpha: 1)
        
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
        box.position = CGPoint(x: frame.midX - 100, y: frame.maxY + box.size.height)
        box.zPosition = 10
        addChild(box)
        
        let dropSeq = SKAction.sequence([
            .wait(forDuration: 2.0),
            .moveTo(y: frame.midY + 50, duration: 1.0),
            .wait(forDuration: 1.0)
        ])
        
        box.run(dropSeq) {
            let contentLabel = SKLabelNode(fontNamed: "SFProDisplay-Regular")
            contentLabel.name = "contentLabel"
            contentLabel.fontSize = 15
            contentLabel.fontColor = .black
            contentLabel.position = .zero
            contentLabel.horizontalAlignmentMode = .center
            contentLabel.verticalAlignmentMode = .center
            contentLabel.preferredMaxLayoutWidth = self.box.size.width - 20
            contentLabel.numberOfLines = 0
            contentLabel.text = """
Ingredients for making Saudi coffee
1 liter of water
saffron
coffee
and cardamom
"""
            self.box.addChild(contentLabel)
            
            let button = SKSpriteNode(color: UIColor(red: 245/255, green: 184/255, blue: 20/255, alpha: 1.0),
                                      size: CGSize(width: 80, height: 40))
            button.name = "nextButton"
            button.position = CGPoint(
                x: self.box.size.width/2 - button.size.width/2 - 90,
                y: -self.box.size.height/2 + button.size.height/2 + 80
            )
            
            let buttonLabel = SKLabelNode(fontNamed: "SFProDisplay-Bold")
            buttonLabel.text = "next"
            buttonLabel.fontSize = 15
            buttonLabel.fontColor = .black
            buttonLabel.verticalAlignmentMode = .center
            buttonLabel.horizontalAlignmentMode = .center
            buttonLabel.position = .zero
            button.addChild(buttonLabel)
            
            self.box.addChild(button)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tappedNodes = nodes(at: location)
        
        for node in tappedNodes {
            if node.name == "nextButton" {
                if let contentLabel = box.childNode(withName: "contentLabel") as? SKLabelNode {
                    contentLabel.text = """
                   Boil water, add coffee, 
                    brew for 10 min. Add saffron, 
                   then cardamom 
                    after turning off 
                 the heat. 
                 Wait 2 min, then enjoy
"""
                }
                node.removeFromParent()
                let waitAction = SKAction.wait(forDuration: 2.0)
                self.run(waitAction) {
                    let nextScene = myGa(size: self.size)
                    nextScene.scaleMode = self.scaleMode
                    self.view?.presentScene(nextScene, transition: SKTransition.fade(withDuration: 1.0))
                }
            }
        }
    }
}
