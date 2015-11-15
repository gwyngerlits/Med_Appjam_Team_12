//
//  ViewController.swift
//  Voice
//
//  Created by Gwyn Gerlits on 11/14/15.
//  Copyright © 2015 Team12. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordTime: UILabel!
  
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

    func timeToString(time: Int) -> String{
        let seconds = ((time%60 < 10) ? "0" : "") + String(time%60)
        let minutes = String(time / 60)
        return minutes + ":" + seconds
    }
    
    func display(){
        if (audioRecorder.recording){
            self.recordTime.text = timeToString(Int(self.audioRecorder.currentTime))
        }
    }
    
    // MARK: Actions
    @IBAction func recordButtonPush(sender: UIButton) {
        if (self.audioRecorder.recording){
            sender.setImage(UIImage(named:"recordOff.png"), forState: UIControlState.Normal)
            audioRecorder.stop()
            
            let secondViewController = self.storyboard!.instantiateViewControllerWithIdentifier("Play")
            self.presentViewController(secondViewController, animated:true, completion: nil)
            
        } else {
            sender.setImage(UIImage(named:"recordOn.png"), forState: UIControlState.Normal)
            audioRecorder.record()
        }
    }

}

