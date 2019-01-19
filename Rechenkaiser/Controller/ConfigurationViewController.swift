//
//  ConfigurationViewController.swift
//  Rechenkaiser
//
//  Created by Georg Federmann on 19.01.19.
//  Copyright © 2019 Poorman's Castle. All rights reserved.
//

import UIKit

protocol ConfigurationViewDelegate {
    func playerConfiguredGame(gameModel:GameModel)
}

class ConfigurationViewController: UIViewController {
    
    var delegate:ConfigurationViewDelegate?
    
    // MARK: ui elements
    @IBOutlet weak var numberRangeUpperLimitTextfield: UITextField!
    @IBOutlet weak var negativeNumbersAllowedSwitch: UISwitch!
    @IBOutlet weak var createDiceChallengesSwitch: UISwitch!
    @IBOutlet weak var createNumberChallengesSwitch: UISwitch!
    @IBOutlet weak var allowAdditionsSwitch: UISwitch!
    @IBOutlet weak var allowSubtractionsSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        guard let delegate = delegate,
            let numberRangeUpperLimitString:String = numberRangeUpperLimitTextfield.text,
            let numberRangeUpperLimit:Int = Int(numberRangeUpperLimitString) else {
                print("Missing delegate or number range configuration, ignoring configuration!")
                return;
        }
        let gameController:GameViewController = delegate as! GameViewController;
        let gameModel:GameModel = gameController.gameModel;
        gameModel.numberRangeUpperLimit = numberRangeUpperLimit;
        gameModel.negativeNumbersAllowed = negativeNumbersAllowedSwitch.isOn
        gameModel.createDiceChallenges = createDiceChallengesSwitch.isOn
        gameModel.createNumberChallenges = createNumberChallengesSwitch.isOn
        gameModel.createAdditionChallenges = allowAdditionsSwitch.isOn
        gameModel.createSubtractionChallenges = allowSubtractionsSwitch.isOn
        delegate.playerConfiguredGame(gameModel: GameModel())
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
