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
    var isTimerRunning = false
    
    
    @IBOutlet weak var homeScore: UILabel!
    @IBOutlet weak var guestScore: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var gameClock: UILabel!
    @IBOutlet weak var homeTimouts: UILabel!
    @IBOutlet weak var homeFouls: UILabel!
    @IBOutlet weak var guestFouls: UILabel!
    @IBOutlet weak var guestTimeouts: UILabel!
    @IBOutlet weak var homePossArrow: UILabel!
    @IBOutlet weak var guestPossArrow: UILabel!
    
    
    @IBAction func togglePossArrow(_ sender: Any) {
        if model.possArrow == false {
            homePossArrow.isHidden = true
            guestPossArrow.isHidden = false
            model.possArrow = true
        }
        else {
            homePossArrow.isHidden = false
            guestPossArrow.isHidden = true
            model.possArrow = false
        }
    }
    
    
    
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: (#selector(TotalScoreViewController.updateTimer)), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    @objc func updateTimer() {
        if model.seconds < 0.1 {
            timer.invalidate()
            //Send alert to indicate time's up.
        } else {
            model.seconds -= 0.1
            gameClock.text = timeString(time: TimeInterval(model.seconds))
        }
        
    }
        
        func timeString(time:TimeInterval) -> String {
            let hours = Int(time) / 3600
            let minutes = Int(time) / 60 % 60
            let seconds = Int(time) % 60
            if model.seconds > 59.9 {
                if minutes < 10 {
                    return String(format:"%01i:%02i", minutes, seconds)
                }
                return String(format:"%02i:%02i", minutes, seconds)
            }
            if model.seconds >= 10.0{
                return String(format:"%02.1f", model.seconds)
            }
            return "0" + String(format:"%02.1f", model.seconds)
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
    
    
    @IBAction func addHomeFoul(_ sender: Any) {
        model.modifyHFoul(by: 1)
        updateScores()
    }
    
    
    @IBAction func subtractHomeFoul(_ sender: Any) {
        model.modifyHFoul(by: -1)
        updateScores()
    }
    
    
    @IBAction func subtractHomeTImeout(_ sender: Any) {
        model.modifyHTimeouts(by: -1)
        updateScores()
    }
    
    
    @IBAction func addHomeTOL(_ sender: Any) {
        model.modifyHTimeouts(by: 1)
        updateScores()
    }
    
    @IBAction func addGuestFoul(_ sender: Any) {
        model.modifyVFoul(by: 1)
        updateScores()
    }
    
    
    @IBAction func subtractGuestFoul(_ sender: Any) {
        model.modifyVFoul(by: -1)
        updateScores()
    }
    
    
    @IBAction func subtractGuestTImeout(_ sender: Any) {
        model.modifyVTimeouts(by: -1)
        updateScores()
    }
    
    
    @IBAction func addHGuestTOL(_ sender: Any) {
        model.modifyVTimeouts(by: 1)
        updateScores()
    }
    
    
    
    
    
    
    
    @IBAction func setClock(_ sender: Any) {
        let alert = UIAlertController(title: "Scoreboard", message: "Please set the clock in seconds", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "600.0"
        }
        alert.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak alert] (_) in
            guard let textField = alert?.textFields?[0], let userText = textField.text else { return }
            if let theUserText = Double(userText) {
                self.model.seconds = Double(theUserText) + 0.1
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
            case 4:
                periodLabel.text = "PreG"
                homePossArrow.isHidden = true
                guestPossArrow.isHidden = true
            case 5:
                periodLabel.text = "Half"
            case 6:
                periodLabel.text = "Break"
            case 7:
                periodLabel.text = "Final"
                homePossArrow.isHidden = true
                guestPossArrow.isHidden = true
            default:
                periodLabel.text = "Err"
            }
            homeFouls.text = "FOULS\n" + String(model.hFouls)
            homeTimouts.text = "TOL\n" + String(model.hTOL)
            guestFouls.text = "FOULS\n" + String(model.vFouls)
            guestTimeouts.text = "TOL\n" + String(model.vTOL)
        }
        
        override func viewWillAppear(_ animated: Bool) {
            updateScores()
            gameClock.text = timeString(time: TimeInterval(model.seconds))
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
