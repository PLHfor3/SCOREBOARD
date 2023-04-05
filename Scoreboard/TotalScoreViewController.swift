//
//  TotalScoreViewController.swift
//  Scoreboard
//
//  Created by Preston Higginbotham on 3/30/23.
//

import UIKit

class TotalScoreViewController: UIViewController {
    
    var model: ScoreModel!
    
    var timer = Timer()
    var tenthSeconds = 600.1
    var isTimerRunning = false
    
    
    @IBOutlet weak var homeScore: UILabel!
    @IBOutlet weak var guestScore: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var gameClock: UILabel!
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: (#selector(TotalScoreViewController.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    @objc func updateTimer() {
        if tenthSeconds < 0.1 {
            timer.invalidate()
            //Send alert to indicate time's up.
        } else {
            tenthSeconds -= 0.1
            gameClock.text = timeString(time: TimeInterval(tenthSeconds))
        }
        
    }
        
        func timeString(time:TimeInterval) -> String {
            let hours = Int(time) / 3600
            let minutes = Int(time) / 60 % 60
            let seconds = Int(time) % 60
            if self.tenthSeconds > 59.9 {
                if minutes < 10 {
                    return String(format:"%01i:%02i", minutes, seconds)
                }
                return String(format:"%02i:%02i", minutes, seconds)
            }
            if self.tenthSeconds >= 10.0{
                return String(format:"%02.1f", self.tenthSeconds)
            }
            return "0" + String(format:"%02.1f", self.tenthSeconds)
        }
        
        @IBAction func clockStartStop(_ sender: Any) {
            if isTimerRunning == false {
                runTimer()
                
            } else {
                timer.invalidate()
                isTimerRunning = false
            }
        }
        
        
        
        
        @IBAction func addHomeScore(_ sender: Any) {
            model.modifyHScore(by: 1)
            updateScores()
        }
        
        @IBAction func subtractHomeScore(_ sender: Any) {
            model.modifyHScore(by: -1)
            updateScores()
        }
        
        @IBAction func addGuestScore(_ sender: Any) {
            model.modifyVScore(by: 1)
            updateScores()
        }
        
        @IBAction func subtractGuestScore(_ sender: Any) {
            model.modifyVScore(by: -1)
            updateScores()
        }
        
        @IBAction func toggleGameClock(_ sender: Any) {
            
        }
    
    @IBAction func setClock(_ sender: Any) {
        let alert = UIAlertController(title: "Scoreboard", message: "Please set the clock in seconds", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "600.0"
        }
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak alert] (_) in
            guard let textField = alert?.textFields?[0], let userText = textField.text else { return }
            if let theUserText = Double(userText) {
                self.tenthSeconds = Double(theUserText) + 0.1
                self.updateTimer()
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
        
        func updateScores () {
            homeScore.text = String(model.hTotalScore)
            guestScore.text = String(model.vTotalScore)
            let period = model.currentQuarter
            switch period {
            case 0:
                periodLabel.text = "1st"
            case 1:
                periodLabel.text = "2nd"
            case 2:
                periodLabel.text = "3rd"
            case 3:
                periodLabel.text = "4th"
            default:
                periodLabel.text = "Err"
            }
        }
        
        override func viewWillAppear(_ animated: Bool) {
            updateScores()
            updateTimer()
        }
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            let d = UIApplication.shared.delegate as! AppDelegate
            model = d.model
            
            let period = model.currentQuarter
            switch period {
            case 0:
                periodLabel.text = "1st"
            case 1:
                periodLabel.text = "2nd"
            case 2:
                periodLabel.text = "3rd"
            case 3:
                periodLabel.text = "4th"
            default:
                periodLabel.text = "Err"
            }
            
            // Do any additional setup after loading the view.
        }
        
        
        /*
         // MARK: - Navigation
         
         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */
        
    }
