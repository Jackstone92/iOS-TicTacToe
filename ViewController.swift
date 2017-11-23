//
//  ViewController.swift
//  19 Tic Tac Toe
//
//  Created by Jack Stone on 23/11/2017.
//  Copyright © 2017 Jack Stone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var boardImage: UIImageView!
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    
    @IBAction func playAgainAction(_ sender: Any) {
        // reset //
        activeGame = true
        activePlayer = 1
        gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]

        UIView.animate(withDuration: 1, animations: {
            // reset board alpha //
            self.boardImage.alpha = 1
            // loop through all buttons and remove images and reset alpha //
            for i in 1..<10 {
                if let button = self.view.viewWithTag(i) as? UIButton {
                    // set all images to nil //
                    button.setImage(nil, for: [])
                    button.alpha = 1
                }
            }
        })
        
        // get rid of winning labels and buttons when app starts //
        // make sure they are hidden //
        winnerLabel.isHidden = true
        playAgainButton.isHidden = true
        // and set positions off-screen //
        winnerLabel.center = CGPoint(x: winnerLabel.center.x, y: winnerLabel.center.y + 500)
        playAgainButton.center = CGPoint(x: playAgainButton.center.x, y: playAgainButton.center.y + 500)
    }
    
    // if game is being played //
    var activeGame = true
    
    // keep track of who's go it is //
    // 1 is noughts, 2 is crosses //
    var activePlayer = 1
    
    // keep track of game state using an array //
    // 0 represents empty, 1 represents noughts, 2 represents crosses //
    var gameState = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    // store winning combinations //
    let winningCombinations = [
        // horizontals //
        [0, 1, 2], [3, 4, 5], [6, 7, 8],
        // verticals //
        [0, 3, 6], [1, 4, 7], [2, 5, 8],
        // diagonals //
        [0, 4, 8], [2, 4, 6]
        ]
    

    @IBAction func buttonPressed(_ sender: Any) {
        // create 1 IBAction, and then ctrl drag each other button to same IBAction to add same functionality //
        // use sender to identify tags 1-9 (set in main.storyboard) //
//        print("ButtonPressed " + String(sender.tag))
        
        // get array index //
        let activePosition = (sender as AnyObject).tag - 1
        
        // if current position is empty //
        if gameState[activePosition] == 0 && activeGame {
            // update array with player //
            gameState[activePosition] = activePlayer

            // when button is pressed //
            // change image of button //
            if activePlayer == 1 {
                (sender as AnyObject).setImage(UIImage(named: "nought.png"), for: [])
                activePlayer = 2
            } else {
                (sender as AnyObject).setImage(UIImage(named: "cross.png"), for: [])
                activePlayer = 1
            }
            
            // check if winning position //
            for combination in winningCombinations {
                // if position is not empty //
                if gameState[combination[0]] != 0 &&
                    // check same player has all 3 //
                    gameState[combination[0]] == gameState[combination[1]] &&
                    gameState[combination[1]] == gameState[combination[2]] {
                    // we have a winner //
                    // stop game //
                    activeGame = false
                    
                    // make sure winning label and button aren't hidden //
                    winnerLabel.isHidden = false
                    playAgainButton.isHidden = false
                    
                    // notify user of outcome //
                    print(gameState[combination[0]])
                    if(gameState[combination[0]] == 1) {
                        winnerLabel.text = "Noughts have won!"
                    } else {
                        winnerLabel.text = "Crosses have won!"
                    }
                    
                    // animate out game board and buttons //
                    UIView.animate(withDuration: 0.5, animations: {
                        // board //
                        self.boardImage.alpha = 0
                        
                        // buttons //
                        for i in 1..<10 {
                            if let button = self.view.viewWithTag(i) as? UIButton {
                                // set all images to nil //
                                button.alpha = 0
                            }
                        }
                    })
                    
                    // animate in winning label and button //
                    UIView.animate(withDuration: 1.2, animations: {
                        // animate in winning //
                        self.winnerLabel.center = CGPoint(x: self.winnerLabel.center.x, y: self.winnerLabel.center.y - 500)
                        self.playAgainButton.center = CGPoint(x: self.playAgainButton.center.x, y: self.playAgainButton.center.y - 500)
                    })
                }
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // get rid of winning labels and buttons when app starts //
        // make sure they are hidden //
        winnerLabel.isHidden = true
        playAgainButton.isHidden = true
        // and set positions off-screen //
        winnerLabel.center = CGPoint(x: winnerLabel.center.x, y: winnerLabel.center.y + 500)
        playAgainButton.center = CGPoint(x: playAgainButton.center.x, y: playAgainButton.center.y + 500)
        
        // set board alpha //
        boardImage.alpha = 1
        // set button alpha //
        for i in 1..<10 {
            if let button = view.viewWithTag(i) as? UIButton {
                // set all images to nil //
                button.alpha = 1
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

