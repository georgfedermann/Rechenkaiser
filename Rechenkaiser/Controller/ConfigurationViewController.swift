//
//  ConfigurationViewController.swift
//  Rechenkaiser
//
//  Created by Georg Federmann on 19.01.19.
//  Copyright © 2019 Poorman's Castle. All rights reserved.
//

import UIKit

protocol ConfigurationViewDelegate {
    func playerConfiguredGame()
}

class ConfigurationViewController: UIViewController {
    
    var delegate:ConfigurationViewDelegate?
    
    // MARK: ui elements
    @IBOutlet weak var numberRangeUpperLimitTextfield: UITextField!
    @IBOutlet weak var winningScoreTextfield: UITextField!
    @IBOutlet weak var penaltyTextfield: UITextField!
    @IBOutlet weak var negativeNumbersAllowedSwitch: UISwitch!
    @IBOutlet weak var createDiceChallengesSwitch: UISwitch!
    @IBOutlet weak var createNumberChallengesSwitch: UISwitch!
    @IBOutlet weak var allowAdditionsSwitch: UISwitch!
    @IBOutlet weak var allowSubtractionsSwitch: UISwitch!
    @IBOutlet weak var allowMultiplicationsSwitch: UISwitch!
    @IBOutlet weak var allowDivisionsSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let gameController:GameViewController = delegate as! GameViewController
        let gameModel:GameModel = gameController.gameModel
        
        numberRangeUpperLimitTextfield.text = String(gameModel.numberRangeUpperLimit)
        winningScoreTextfield.text = String(gameModel.winningScore)
        penaltyTextfield.text = String(gameModel.penalty)
        negativeNumbersAllowedSwitch.isOn = gameModel.negativeNumbersAllowed
        createDiceChallengesSwitch.isOn = gameModel.createDiceChallenges
        createNumberChallengesSwitch.isOn = gameModel.createNumberChallenges
        allowAdditionsSwitch.isOn = gameModel.createAdditionChallenges
        allowSubtractionsSwitch.isOn = gameModel.createSubtractionChallenges
        allowMultiplicationsSwitch.isOn = gameModel.createMultiplicationChallenges
        allowDivisionsSwitch.isOn = gameModel.createDivisionChallenges
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        guard let delegate = delegate,
            let numberRangeUpperLimitString:String = numberRangeUpperLimitTextfield.text,
            let numberRangeUpperLimit:Int = Int(numberRangeUpperLimitString),
            let winningScoreString:String = winningScoreTextfield.text,
            let winningScore:Int = Int(winningScoreString),
            let penaltyString:String = penaltyTextfield.text,
            let penalty:Int = Int(penaltyString) else {
                print("Missing delegate or number range configuration, ignoring configuration!")
                return
        }
        let gameController:GameViewController = delegate as! GameViewController
        let gameModel:GameModel = gameController.gameModel
        gameModel.numberRangeUpperLimit = numberRangeUpperLimit
        gameModel.winningScore = winningScore
        gameModel.penalty = penalty
        gameModel.negativeNumbersAllowed = negativeNumbersAllowedSwitch.isOn
        gameModel.createDiceChallenges = createDiceChallengesSwitch.isOn
        gameModel.createNumberChallenges = createNumberChallengesSwitch.isOn
        gameModel.createAdditionChallenges = allowAdditionsSwitch.isOn
        gameModel.createSubtractionChallenges = allowSubtractionsSwitch.isOn
        gameModel.createMultiplicationChallenges = allowMultiplicationsSwitch.isOn
        gameModel.createDivisionChallenges = allowDivisionsSwitch.isOn
        // debug log config model
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(gameModel)
        let debugTxt = String(data:jsonData, encoding:.utf8)!
        print("Received gameModel \(debugTxt).")
        // inform delegate that game configuration might have changed
        delegate.playerConfiguredGame();
        // close configuration dialog
        self.dismiss(animated:true, completion:nil);
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
