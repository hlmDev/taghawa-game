import SpriteKit
import AVFoundation

class GameScene: SKScene {
    static var backgroundMusicPlayer: AVAudioPlayer?
    
    private var saudiMan: SKSpriteNode?
    private var playButton: SKSpriteNode?
    private var titleLabel: SKLabelNode?
    
    override func didMove(to view: SKView) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            print("Audio session configured successfully")
        } catch {
            print("Failed to configure audio session: \(error)")
        }
        
        if GameScene.backgroundMusicPlayer == nil {
            setupAudio()
        }
        setupGame()
    }
    
    private func setupAudio() {
        if let musicURL = Bundle.main.url(forResource: "Song", withExtension: "mp3") {
            print("Found Song file at: \(musicURL.path)")
            
            do {
                let musicPlayer = try AVAudioPlayer(contentsOf: musicURL)
                musicPlayer.numberOfLoops = -1
                musicPlayer.volume = 0.15
                musicPlayer.play()
                GameScene.backgroundMusicPlayer = musicPlayer
                print("Successfully started background music")
            } catch {
                print("Error loading background music: \(error)")
            }
        } else {
            print("Could not find music file 'Song.mp3' in Resources folder")
        }
    }
    
    private func setupGame() {
        backgroundColor = UIColor(red: 249/255, green: 239/255, blue: 223/255, alpha: 1)
        
        let background = SKSpriteNode(imageNamed: "ground")
        background.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        background.size = CGSize(width: frame.width, height: frame.height)
        background.zPosition = -1
        addChild(background)
        
        let man = SKSpriteNode(imageNamed: "main-chr")
        man.position = CGPoint(x: frame.midX + 100, y: frame.midY)
        man.size = CGSize(width: 200, height: 300)
        man.zPosition = 1
        saudiMan = man
        addChild(man)
        
        setupPlayButton()
        setupEnvironment()
        setupClouds()
    }
    
    private func setupPlayButton() {
        let button = SKSpriteNode(imageNamed: "butunclk")
        button.position = CGPoint(x: 256 - 20, y: 192 - 10)
        button.size = CGSize(width: 200, height: 200)
        button.name = "playButton"
        playButton = button
        addChild(button)
        
        let label = SKLabelNode(text: "Play")
        label.fontName = "Helvetica-Bold"
        label.fontSize = 30
        label.fontColor = UIColor.black
        label.verticalAlignmentMode = .center
        label.horizontalAlignmentMode = .center
        label.position = CGPoint(x: 0, y: 0)
        button.addChild(label)
    }
    
    private func setupEnvironment() {
        let tree = SKSpriteNode(imageNamed: "tree_5")
        tree.position = CGPoint(x: 450, y: 140)
        tree.size = CGSize(width: 100, height: 150)
        tree.zPosition = 1
        addChild(tree)
        
        let greenery = SKSpriteNode(imageNamed: "greenery_6")
        greenery.position = CGPoint(x: 430, y: 100)
        greenery.size = CGSize(width: 60, height: 40)
        greenery.zPosition = 1
        addChild(greenery)
        
        let greenery2 = SKSpriteNode(imageNamed: "greenery_6")
        greenery2.size = CGSize(width: 50, height: 40)
        greenery2.position = CGPoint(x: 512 - greenery2.size.width/2, y: 100)
        greenery2.zPosition = 1
        addChild(greenery2)
        
        let stones = SKSpriteNode(imageNamed: "stones_9")
        stones.size = CGSize(width: 50, height: 40)
        stones.position = CGPoint(x: 440, y: 80)
        stones.zPosition = 1
        addChild(stones)
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
    
    var audioPlayer: AVAudioPlayer?
    
    private func playClickSound() {
        if let clickURL = Bundle.main.url(forResource: "click", withExtension: "mp3") {
            print("Found clk sound at: \(clickURL.path)")
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: clickURL)
                audioPlayer?.play()
            } catch {
                print("Error loading clk sound: \(error)")
            }
        } else {
            print("Could not find clk.mp3 in Resources folder")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNodes = nodes(at: location)
        
        for node in touchedNodes {
            if node.name == "playButton" {
                let pressedTexture = SKTexture(imageNamed: "butclick")
                playClickSound()
                
                node.run(SKAction.group([
                    SKAction.setTexture(pressedTexture),
                    SKAction.scale(to: 0.95, duration: 0.1)
                ]))
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNodes = nodes(at: location)
        
        for node in touchedNodes {
            if node.name == "playButton" {
                let normalTexture = SKTexture(imageNamed: "butunclk")
                node.run(SKAction.group([
                    SKAction.setTexture(normalTexture),
                    SKAction.scale(to: 1.0, duration: 0.1)
                ])) {
                    let HowPlayScene = HowPlayScene(size: self.size)
                    HowPlayScene.scaleMode = self.scaleMode
                    let transition = SKTransition.fade(withDuration: 0.5)
                    self.view?.presentScene(HowPlayScene, transition: transition)
                }
            }
        }
    }
}
