//
//  QuarterViewController.swift
//  Scoreboard
//
//  Created by Preston Higginbotham on 3/30/23.
//

import UIKit

class QuarterViewController: UIViewController {

    
    var timer = Timer()
    var model: ScoreModel!
    @IBOutlet weak var qtr1Home: UILabel!
    @IBOutlet weak var qtr2Home: UILabel!
    @IBOutlet weak var qtr3Home: UILabel!
    @IBOutlet weak var qtr4Home: UILabel!
    @IBOutlet weak var qtr1Guest: UILabel!
    @IBOutlet weak var qtr2Guest: UILabel!
    @IBOutlet weak var qtr3Guest: UILabel!
    @IBOutlet weak var qtr4Guest: UILabel!
    @IBOutlet weak var totalHome: UILabel!
    @IBOutlet weak var totalGuest: UILabel!
    
    @IBAction func setQuarter(_ sender: UIButton) {
        model.currentQuarter = sender.tag
    }
    
    func updateLabels () {
        qtr1Home.text = String(model.hQtrScores[0])
        qtr2Home.text = String(model.hQtrScores[1])
        qtr3Home.text = String(model.hQtrScores[2])
        qtr4Home.text = String(model.hQtrScores[3])
        totalHome.text = String(model.hTotalScore)
        qtr1Guest.text = String(model.vQtrScores[0])
        qtr2Guest.text = String(model.vQtrScores[1])
        qtr3Guest.text = String(model.vQtrScores[2])
        qtr4Guest.text = String(model.vQtrScores[3])
        totalGuest.text = String(model.vTotalScore)
    }
    
    
    @IBAction func resetButton(_ sender: Any) {
        model.hQtrScores[0] = 0
        model.hQtrScores[1] = 0
        model.hQtrScores[2] = 0
        model.hQtrScores[3] = 0
        model.vQtrScores[0] = 0
        model.vQtrScores[1] = 0
        model.vQtrScores[2] = 0
        model.vQtrScores[3] = 0
        model.hFouls = 0
        model.vFouls = 0
        model.hTOL = 4
        model.vTOL = 4
        model.currentQuarter = 4
        updateLabels()
        model.seconds = 600
    }
    
    
    @IBAction func clearFouls(_ sender: Any) {
        model.hFouls = 0
        model.vFouls = 0
    }
    
    @IBAction func resetTOLs(_ sender: Any) {
        model.hTOL = 4
        model.vTOL = 4
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let d = UIApplication.shared.delegate as! AppDelegate
        model = d.model
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateLabels()
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
