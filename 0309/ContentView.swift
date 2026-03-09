//
//  ContentView.swift
//  0309
//
//  Created by 訪客使用者 on 2026/3/9.
//

import SwiftUI
import AVFoundation
struct ContentView: View {
    var body: some View {
        VStack (spacing: 20){
//            Spacer()
            Text("我的朋友")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 30)
            HStack (spacing: 20){
                FriendCard(name: "Joe", imageName: "Friend1") {
                    speak(text: "I am Joe")
                }
                FriendCard(name: "Amy", imageName: "Friend2") {
                    speak(text: "I am Amy")
                }
                FriendCard(name: "Tom", imageName: "Friend3") {
                    speak(text: "I am Tom")
                }
            }
        }
        .padding()
    }
    @State private var synthesizer = AVSpeechSynthesizer()
    func speak(text: String){
        let utterance = AVSpeechUtterance(string:text)
        utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.speech.synthesis.voice.Fred")
        synthesizer.speak(utterance)
        print(text)
    }
}

struct FriendCard: View {
    let name: String
    let imageName: String
    let action: () -> Void

    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 120)
            Text(name).font(.title)
            Button(action: action) {
                Text(name)
                    .fontWeight(.bold)
                    .font(.system(.title, design: .rounded))
                    .padding()
                    .foregroundStyle(.white)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
    }
}

#Preview {
    ContentView()
}
