import SwiftUI
import SpriteKit

struct SplashView: View {
    let frames = ["cof1", "cof2", "cof3", "cof4", "cof5"]
    
    @State private var currentFrameIndex = 0
    
    let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    @State private var showMainGame = false
    
    @State private var showText = false
    
    var body: some View {
        if showMainGame {
            ContentView()
        } else {
            GeometryReader { geometry in
                ZStack {
                    Color(red: 249/255, green: 239/255, blue: 223/255)
                        .edgesIgnoringSafeArea(.all)
                    
                    Image(frames[currentFrameIndex])
                        .resizable()
                        .scaledToFit()
                        .onReceive(timer) { _ in
                            if currentFrameIndex < frames.count - 1 {
                                currentFrameIndex += 1
                            } else {
                                if !showText {
                                    timer.upstream.connect().cancel()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                        showText = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                            showMainGame = true
                                        }
                                    }
                                }
                            }
                        }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}
