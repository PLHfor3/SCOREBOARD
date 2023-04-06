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
    var currentQuarter = 4
    
    var seconds = 600.0
    
    var possArrow = false
    
    var hFouls = 0
    var vFouls = 0
    var hTOL = 4
    var vTOL = 4

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
        if currentQuarter >= 0 && currentQuarter <= 3 {
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
        
        
        
    }

    // Method to modify visitor's score
    func modifyVScore(by: Int) {
        if currentQuarter >= 0 && currentQuarter <= 3 {
            if vTotalScore > 0 || by > 0 {
                if vTotalScore < 199 {
                    vQtrScores[currentQuarter] += by
                    return
                }
            }
            if by == -1 && vTotalScore != 0{
                vQtrScores[currentQuarter] += by
            }
        }
        
    }
    
    func modifyHFoul(by: Int) {
        if hFouls > 0 || by > 0 {
            if hFouls < 10 {
                hFouls += by
                return
            }
        }
        if by == -1 && hFouls != 0{
            hFouls += by
        }
        
    }
    
    func modifyVFoul(by: Int) {
        if vFouls > 0 || by > 0 {
            if vFouls < 10 {
                vFouls += by
                return
            }
        }
        if by == -1 && hFouls != 0{
            vFouls += by
        }
        
    }
    
    func modifyHTimeouts(by: Int) {
        if hTOL > 0 || by > 0 {
            if hTOL < 10 {
                hTOL += by
                return
            }
        }
        if by == -1 && hTOL != 0{
            hTOL += by
        }
        
    }
    
    func modifyVTimeouts(by: Int) {
        if vTOL > 0 || by > 0 {
            if vTOL < 10 {
                vTOL += by
                return
            }
        }
        if by == -1 && vTOL != 0{
            vTOL += by
        }
        
    }
    
    
    
}
