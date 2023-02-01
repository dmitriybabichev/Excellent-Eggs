//
//  ViewController.swift
//  Excellent Eggs
//
//  Created by Dmitriy Babichev on 30.01.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var timerTitle: UILabel!
    @IBOutlet weak var timerProgressView: UIProgressView!

    private var timer = Timer()
    private var totalTime = 0
    private var secondsPassed = 0

    private var player: AVAudioPlayer!

    enum HardnessTime: Int {
        case soft = 3
        case medium = 4
    }

    enum HardnessTitles: String {
        case soft = "Soft"
        case medium = "Medium"
    }

    @IBAction func hardnessSelected(_ sender: UIButton) {
        guard let currentTitle = sender.currentTitle else { return }

        switch currentTitle {
        case HardnessTitles.soft.rawValue:
            totalTime = HardnessTime.soft.rawValue
            startTimer()
        case HardnessTitles.medium.rawValue:
            totalTime = HardnessTime.medium.rawValue
            startTimer()
        default:
            return
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func startTimer() {
        timer.invalidate()
        timerProgressView.progress = 0
        secondsPassed = 0

        timerTitle.text = "Wait for your eggs!"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }

    @objc func timerAction() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            timerProgressView.progress = Float(secondsPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            playSound(sound: "ding")
            timerTitle.text = "Done!"
        }
    }

    func playSound(sound: String) {
        guard let url = Bundle.main.url(forResource: sound, withExtension: "mp3") else { return }
        player = try! AVAudioPlayer(contentsOf: url)
        player.play()
    }
}

