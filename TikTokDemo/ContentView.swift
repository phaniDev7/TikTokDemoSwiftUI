//
//  ContentView.swift
//  TikTokDemo
//
//  Created by apple on 5/29/20.
//  Copyright © 2020 Phani. All rights reserved.
//

import SwiftUI
import AVKit
struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    @State var index = 0
    @State var top = 0
    
    @State var data = [
        Video(id: 0, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "video1", ofType: "mp4")!)), replay: false),
        Video(id: 1, player: AVPlayer(url: URL(string: "https://www.radiantmediaplayer.com/media/bbb-360p.mp4")!), replay: false),
        Video(id: 2, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "video3", ofType: "mp4")!)), replay: false),
        Video(id: 3, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "video4", ofType: "mp4")!)), replay: false),
        Video(id: 4, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "video5", ofType: "mp4")!)), replay: false),
        Video(id: 5, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "video6", ofType: "mp4")!)), replay: false)
        
    ]
    var body: some View{
        ZStack{
            PlayerScrollView(data: self.$data)
            VStack{
                
                HStack(spacing: 15){
                    Button(action: {
                        self.top = 0
                    }) {
                        Text("Following")
                            .foregroundColor(self.top == 0 ? .white : Color.white.opacity(0.45))
                            .fontWeight(self.top == 0 ? .bold : .none)
                            .padding(.vertical)
                    }
                    
                    Button(action: {
                        self.top = 1
                    }) {
                        Text("For You")
                            .foregroundColor(self.top == 1 ? .white : Color.white.opacity(0.45))
                            .fontWeight(self.top == 1 ? .bold : .none)
                            .padding(.vertical)
                    }
                }
                
                Spacer()
                HStack{
                    Spacer()
                    VStack(spacing: 35){
                        Button(action: {
                            
                        }) {
                            Image("pic")
                                .renderingMode(.original)
                                .resizable()
                                .frame(width: 45, height: 45)
                                .clipShape(Circle())
                        }
                        
                        Button(action: {
                            
                        }) {
                            VStack(spacing: 8){
                                Image(systemName: "suit.heart.fill")
                                    .font(.title)
                                    .foregroundColor(.white)
                                Text("22K")
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Button(action: {
                            
                        }) {
                            VStack(spacing: 8){
                                Image(systemName: "message.fill")
                                    .font(.title)
                                    .foregroundColor(.white)
                                Text("1021")
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Button(action: {
                            
                        }) {
                            VStack(spacing: 8){
                                Image(systemName: "arrowshape.turn.up.right.fill")
                                    .font(.title)
                                    .foregroundColor(.white)
                                Text("share")
                                    .foregroundColor(.white)
                            }
                        }
                        
                    }
                    .padding(.bottom, 55)
                    .padding(.trailing)
                }
                
                HStack(spacing: 0){
                    Button(action: {
                        self.index = 0
                    }) {
                        Image("home")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(self.index == 0 ? .white : Color.white.opacity(0.35))
                            .padding(.horizontal)
                    }
                    Spacer(minLength: 0)
                    Button(action: {
                        self.index = 1
                    }) {
                        Image("search")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(self.index == 1 ? .white : Color.white.opacity(0.35))
                            .padding(.horizontal)
                    }
                    Spacer(minLength: 0)
                    Button(action: {
                        
                    }) {
                        Image("upload")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 50, height: 35)
                            .padding(.horizontal)
                    }
                    Spacer(minLength: 0)
                    Button(action: {
                        self.index = 2
                    }) {
                        Image("comment")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(self.index == 2 ? .white : Color.white.opacity(0.35))
                            .padding(.horizontal)
                    }
                    Spacer(minLength: 0)
                    Button(action: {
                        self.index = 3
                    }) {
                        Image("profile")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(self.index == 3 ? .white : Color.white.opacity(0.35))
                            .padding(.horizontal)
                    }
                }
                .padding(.horizontal)
                
            }
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
            .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom)
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.all)
    }
}


struct PlayerView: View{
    @Binding var data: [Video]
    var body: some View{
        VStack(spacing: 0){
            ForEach(self.data) {i in
                Player(player: i.player)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .offset(y: -5)
            }
        }
        .onAppear {
           self.data[0].player.play()
            self.data[0].player.actionAtItemEnd = .none
            NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.data[0], queue: .main) { (_) in
                self.data[0].replay = true
            }
        }
    }
}

struct Player: UIViewControllerRepresentable {
    var player: AVPlayer
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let view = AVPlayerViewController()
        view.player = player
        view.showsPlaybackControls = false
        view.videoGravity = .resizeAspectFill
        return view
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
       
    }
    
}

struct PlayerScrollView: UIViewRepresentable{
    func makeCoordinator() -> Coordinator {
        return PlayerScrollView.Coordinator(parent1: self)
    }
    
    @Binding var data: [Video]
    func makeUIView(context: Context) -> UIScrollView {
        let view = UIScrollView()
        
        let childView = UIHostingController(rootView: PlayerView(data: self.$data))
        
        childView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat(self.data.count))
        
        view.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat(self.data.count))
        
        view.addSubview(childView.view)
        
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        
        view.contentInsetAdjustmentBehavior = .never
        
        view.isPagingEnabled = true
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        uiView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat(self.data.count))
        for i in 0..<uiView.subviews.count{
            uiView.subviews[i].frame = CGRect(x: 0, y: 0,width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat(self.data.count))
        }
    }
}


class Coordinator: NSObject, UIScrollViewDelegate{
    
    var parent: PlayerScrollView
    var index = 0
    init(parent1: PlayerScrollView){
        parent = parent1
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentIndex = Int(scrollView.contentOffset.y/UIScreen.main.bounds.height)
        if index != currentIndex{
            index = currentIndex
            
            for i in 0..<parent.data.count{
                parent.data[i].player.seek(to: .zero)
                parent.data[i].player.pause()
            }
        }
        
        parent.data[index].player.play()
        parent.data[index].player.actionAtItemEnd = .none
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.parent.data[self.index], queue: .main) { (_) in
            self.parent.data[self.index].replay = true
        }
        
    }
    
}


class Host: UIHostingController<ContentView>{
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}


// sample video for playing


struct Video: Identifiable{
    var id: Int
    var player: AVPlayer
    var replay: Bool
}



