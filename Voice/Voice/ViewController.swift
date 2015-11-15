//
//  ViewController.swift
//  Voice
//
//  Created by Kay Lab on 11/14/15.
//  Copyright © 2015 Team12. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var recordTime: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var current: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    //declare instance variable
    var audioRecorder:AVAudioRecorder!
    var audioPlayer:AVAudioPlayer!
    
    // MARK: Settup
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initializeRecorder()
        NSTimer.scheduledTimerWithTimeInterval(0.0001, target: self, selector: "display", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Helpers
    func initializeRecorder(){
        //init
        let audioSession:AVAudioSession = AVAudioSession.sharedInstance()
        
        //ask for permission
        if (audioSession.respondsToSelector("requestRecordPermission:")) {
            AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
                
                if granted {
                    print("granted")
                    
                    //set category and activate recorder session
                    try! audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
                    try! audioSession.setActive(true)
                    
                    
                    //get documents directory
                    let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory,inDomains: .UserDomainMask)[0]
                    let url = documentsURL.URLByAppendingPathComponent("voiceRecording.caf")
                    
                    //create AnyObject of settings
                    let settings: [String : AnyObject] = [
                        AVFormatIDKey:Int(kAudioFormatAppleIMA4),
                        AVSampleRateKey:44100.0,
                        AVNumberOfChannelsKey:2,
                        AVEncoderBitRateKey:12800,
                        AVLinearPCMBitDepthKey:16,
                        AVEncoderAudioQualityKey:AVAudioQuality.Max.rawValue
                    ]
                    
                    //record
                    try! self.audioRecorder = AVAudioRecorder(URL: url, settings: settings)
                } else{
                    print("not granted")
                }
            })
        }
    }
    
    func initializePlayer(){
        //init
        let audioSession:AVAudioSession = AVAudioSession.sharedInstance()
        
        //set category and activate recorder session
        try! audioSession.setCategory(AVAudioSessionCategoryPlayback)
        try! audioSession.setActive(true)
                    
        //get documents directory
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory,inDomains: .UserDomainMask)[0]
        let url = documentsURL.URLByAppendingPathComponent("voiceRecording.caf")
                    
        //link player to track
        try! self.audioPlayer = AVAudioPlayer(contentsOfURL: url)
    }
    
    func timeToString(time: Int) -> String{
        let seconds = ((time%60 < 10) ? "0" : "") + String(time%60)
        let minutes = String(time / 60)
        return minutes + ":" + seconds
    }
    
    func display(){
        if (audioRecorder.recording){
            self.recordTime.text = timeToString(Int(self.audioRecorder.currentTime))
        } else if (audioPlayer != nil){
            current.text = timeToString(Int(audioPlayer.currentTime))
            duration.text = timeToString(Int(audioPlayer.duration))
            slider.value = Float(audioPlayer.currentTime / audioPlayer.duration)
            if (!audioPlayer.playing){
                playButton.setImage(UIImage(named:"play.png"), forState: UIControlState.Normal)
            }
        }
    }
    
    // MARK Actions
    @IBAction func recordButtonPush(sender: UIButton) {
        if (self.audioRecorder.recording){
            sender.setImage(UIImage(named:"recordOff.png"), forState: UIControlState.Normal)
            audioRecorder.stop()
            
            //hide old buttons, show new ones should maybe use another view?
            sender.hidden = true
            recordTime.hidden = true
            playButton.hidden = false
            slider.hidden = false
            current.hidden = false
            duration.hidden = false
            
            initializePlayer()
        } else {
            sender.setImage(UIImage(named:"recordOn.png"), forState: UIControlState.Normal)
            audioRecorder.record()
        }
    }
    
    @IBAction func playButtonPush(sender: AnyObject) {
        if (audioPlayer.playing) {
            sender.setImage(UIImage(named:"play.png"), forState: UIControlState.Normal)
            audioPlayer.pause()
        } else {
            sender.setImage(UIImage(named:"pause.png"), forState: UIControlState.Normal)
            audioPlayer.play()
        }
    }

}

