//
//  ViewController.swift
//  AVAudioPlayerDelegate
//
//  Created by Mark Meretzky on 1/25/19.
//  Copyright © 2019 New York University School of Professional Studies. All rights reserved.
//

import UIKit;
import AVFoundation;   //for AVAudioPlayer and AVAudioPlayerDelegate

class ViewController: UIViewController, AVAudioPlayerDelegate {
    var audioPlayer: AVAudioPlayer? = nil;
    @IBOutlet weak var mySwitch: UISwitch!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        // Do any additional setup after loading the view, typically from a nib.

        guard let url: URL = Bundle.main.url(forResource: "musette", withExtension: "mp3") else {
            fatalError("could not find file musette.mp3");
            return;
        }
        print("url = \(url)");
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url);
        } catch {
            print("could not create AVAudioPlayer: \(error)");
            return;
        }
        
        audioPlayer!.delegate = self;
        audioPlayer!.numberOfLoops = 0;   //No infinite loop.
        print("audioPlayer!.duration = \(audioPlayer!.duration) seconds");
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        audioPlayer?.prepareToPlay();   //question mark is optional chaining
    }
    
    //Called when switch is turned on or off.
    
    @IBAction func valueChanged(_ sender: UISwitch) {
        if sender.isOn {
            audioPlayer?.play();
        } else {
            audioPlayer?.pause();
        }
    }
    
    //MARK: AVAudioPlayerDelegate
    
    //Called when the AVAudioPlayer has finished playing the file.
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        mySwitch.setOn(false, animated: true);
    }
    
    //Called when the AVAudioPlayer has encountered an error in the file.

    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        if let error: Error = error {
            print("audioPlayerDecodeErrorDidOccur: \(error)");
        } else {
            print("audioPlayerDecodeErrorDidOccur");
        }
    }
}

