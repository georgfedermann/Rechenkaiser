//
//  SoundManager.swift
//  Rechenkaiser
//
//  Created by Georg Federmann on 06.01.19.
//  Copyright © 2019 Poorman's Castle. All rights reserved.
//

import AVFoundation;
import Foundation

class SoundManager {
    
    static var audioPlayer:AVAudioPlayer?;
    
    // sound effect enumeration for this app bundle.
    enum SoundEffect {
        case correct;
        case wrong;
    }
    
    static func playSound(_ effect:SoundEffect){
        var soundFilename = "";
        
        // determine which sound effect needs to be played and resolve
        // respective sound file name
        switch effect {
        case .correct:
            soundFilename = "dingcorrect";
        case .wrong:
            soundFilename = "dingwrong";
        }
        // Bundle could only be unable to resolve the file name in case of build errors
        let bundlePath = Bundle.main.path(forResource:soundFilename, ofType:"wav");
        guard bundlePath != nil else {
            print("Couldn't resolve audio file \(soundFilename) in the bundle.");
            return;
        }
        
        // Create a URL object from the path string
        let soundUrl = URL(fileURLWithPath: bundlePath!);
        // Create audio player object
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundUrl);
            audioPlayer?.play();
        } catch {
            print("Could not create AVAudioPlayer object for \(bundlePath!).");
        }
    }
    
}
