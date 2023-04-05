//
//  ScoreModel.swift
//  Scoreboard
//
//  Created by Ryan Stejskal on 3/5/20.
//

import Foundation

class ScoreModel {
    // Arrays to keep track of the scores for the four quarters for each team
    var hQtrScores = [ 0, 0, 0, 0 ]
    var vQtrScores = [ 0, 0, 0, 0 ]
    // The current quarter (note: although the user sees the quarters as being
    // numbered 1, 2, 3, and 4, the program numbers them 0 through 3)
    var currentQuarter = 0

    // Computed property to get the total score for the home team
    var hTotalScore: Int {
        // Add up the scores for each of the four quarters
        var total = 0
        for score in hQtrScores {
            total += score
        }
        return total
    }

    // Computed property to get the total score for the visiting team
    var vTotalScore: Int {
        // Add up the scores for each of the four quarters
        var total = 0
        for score in vQtrScores {
            total += score
        }
        return total
    }

    // Method to modify home's score (the "by" parameter should be
    // either 1 or -1, to increase or decrease the team's score)
    func modifyHScore(by: Int) {
        if hTotalScore > 0 || by > 0 {
            if hTotalScore < 199 {
                hQtrScores[currentQuarter] += by
                return
            }
        }
        if by == -1 && hTotalScore != 0 {
            hQtrScores[currentQuarter] += by
        }
    }

    // Method to modify visitor's score
    func modifyVScore(by: Int) {
        if vTotalScore > 0 || by > 0 {
            if hTotalScore < 199 {
                vQtrScores[currentQuarter] += by
                return
            }
        }
        if by == -1 && vTotalScore != 0{
            vQtrScores[currentQuarter] += by
        }
        
    }
}
