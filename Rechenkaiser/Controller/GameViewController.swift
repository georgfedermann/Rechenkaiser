//
//  GameViewController.swift
//  Rechenkaiser
//
//  Created by Georg Federmann on 19.01.19.
//  Copyright © 2019 Poorman's Castle. All rights reserved.
//

import UIKit

class GameViewController: UIViewController, ConfigurationViewDelegate {
    
    // MARK: view elements
    @IBOutlet weak var operandImageLeft: UIImageView!
    @IBOutlet weak var operandImageRight: UIImageView!
    @IBOutlet weak var operatorLabel: UILabel!
    @IBOutlet weak var progressBar: UILabel!
    
    // MARK: game logic state
    var gameModel:GameModel = GameModel()
    // a collection of strategies that can create challenges.
    // the content of the collection gets updated when the user configures the game
    var challengeGenerators:[ChallengeGenerator] = [ChallengeGenerator]()
    
    var currentScore:Int = 0
    
    // MARK: game logic
    func updateView() {
        progressBar.frame.size.width = view.frame.size.width / CGFloat(gameModel.winningScore) * CGFloat(currentScore)
    }
    
    // callback method for configuration view controller
    func updateGameConfiguration() {
        // how to respond to game config changes?
    }
    
    // MARK: event handling
    @IBAction func configButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier:"configSegue", sender:self);
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "configSegue" {
            let configViewController:ConfigurationViewController = segue.destination as! ConfigurationViewController;
            configViewController.delegate = self;
        }
    }
    
    // MARK: view controller - overriding methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateGameConfiguration()
        // Do any additional setup after loading the view.
    }
    
    
}
