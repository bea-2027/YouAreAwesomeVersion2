//
//  ContentView.swift
//  YouAreAwesomeVersion2
//
//  Created by TOVAR, BEATRIZ on 12/4/25.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    @State private var message = ""
    @State private var ImageName = ""
    @State private var lastMessageNumber = -1 // lastMessage Number will never be -1
    @State private var audioPLayer: AVAudioPlayer!
    @State private var lastImageNumber = -1
    @State private var LastSoundNumber = -1
    let numberOfImages = 10 //images labeled image0 to image9
    let numberOfSounds = 6 // sounds labeled Sound) - Sound5
    
    var body: some View {
    
        VStack {
            Text(message)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundStyle(.red)
                .multilineTextAlignment(.center)
                .frame(height: 100)
                .minimumScaleFactor(0.5)
                .animation(.easeInOut(duration: 0.15), value: message)
                
            Spacer()
            
            Image(ImageName)
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 30))
                .shadow(radius: 30)
                .animation(.default, value: ImageName)
              
            
            Spacer()
            
            Button("Show Message") {
              let messages = [ "You are Awesome!","When the Genius Bar Need Help, They Call You!" ,"You Are Great", "You Are Fantastic!","Fabulous? That's You!","You Make Me Smile!"]
                
                lastMessageNumber = nonRepeatingRandom(lastNumber: lastMessageNumber, upperBound: message.count-1)
                message = messages[lastMessageNumber]
                
                lastImageNumber = nonRepeatingRandom(lastNumber: lastImageNumber, upperBound: numberOfImages-1)
                ImageName = "image \(lastImageNumber)"
                
                LastSoundNumber = nonRepeatingRandom(lastNumber: LastSoundNumber, upperBound: numberOfSounds-1)
                playSound(soundName: "sound\(LastSoundNumber)")
        }
            .buttonStyle(.borderedProminent)
            .font(.title2)
            
        }
        .padding()
    }
    func nonRepeatingRandom(lastNumber:Int, upperBound:Int)-> Int{
        var newNumber: Int
        repeat {
            newNumber = Int.random(in: 0...upperBound)
        } while newNumber == lastNumber
        return newNumber
    }
    
    func playSound(soundName: String){
        guard let soundFile = NSDataAsset(name: soundName) else {
            print("😡 Could not read file name \(soundName)")
            return
        }
        do{
            audioPLayer = try AVAudioPlayer(data: soundFile.data)
            audioPLayer.play()
        } catch {
            print("😡 ERROR: \(error.localizedDescription) creating audioPlayer")
        }
    }
}

#Preview {
    ContentView()
}

