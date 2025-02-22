import SwiftUI
import SpriteKit

struct ContentView: View {
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 512, height: 384)
        scene.scaleMode = .aspectFit
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
}
