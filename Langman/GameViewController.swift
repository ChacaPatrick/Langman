//
//  GameViewController.swift
//  Langman
//
//  Created by Patrick Chaca on 5/20/20.
//  Copyright © 2020 Patrick Chaca. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

// THIRD CONTROL

extension UIColor{
    //custom color
    class func MakeDisappear() -> UIColor {
        return UIColor(red: 0.545, green:0.00 ,blue:0.00 , alpha:0.00)
    }

}

class GameViewController: UIViewController {
    //Lets you return back to the options
    @IBAction func BackToSettings(_ sender: Any) {
        self.performSegue(withIdentifier: "BackToOption", sender: self)
    }
    
    //The image
    @IBOutlet weak var HangManImage: UIImageView!

    //The Question Labels before changing them
    @IBOutlet var ThreeLetterWord: [UILabel]!
    @IBOutlet weak var WordLetters: UIStackView!
    
    
    //The Keyboard
    @IBOutlet var Letters: [UIButton]!
    
    //Checks if the Letter is Correct
    @IBAction func GuessingLetter(_ sender: UIButton) {
        var check:Bool = false
        var char: String
        var counter = 0;
        while(counter < word.count-1){
            char = String(word[word.index(word.startIndex, offsetBy: counter)])
            if sender.titleLabel?.text == char {
                sender.backgroundColor = UIColor.green
                check = true
                var cout = 0
                for i in WordLetters.arrangedSubviews {
                    let j = i as! UILabel
                    if(cout == counter){
                        j.text = char
                    }
                    cout += 1
                }
            }else{
                if check == false {
                    sender.backgroundColor = UIColor.MakeDisappear()
                    sender.isEnabled = false
                }
            }
            counter += 1
        }
        if check == false{
            hangman_counter += num
            HangManImage.image = UIImage(named: "hangman_\(hangman_counter)")
        }
        if CheckGame(){
            YouWon()
            print(Return_Definition)
            if(definition_button == true){
                SendAlertOfDef()
            }
            Vibrate()
        }else{
            if hangman_counter >= 6{
                YouLose()
                print(Return_Definition)
                if(definition_button == true){
                    SendAlertOfDef()
                }
                Vibrate()
            }
        }
        
    }
    //Tells the player they won
    func YouWon() -> Void {
        HangManImage.image = UIImage(named: "win_\(hangman_counter)")
        for i in Letters{
            i.isEnabled = false
        }
    }
    
    //Tells the player they lost
    func YouLose() -> Void{
        var char: String
        var counter = 0;
        HangManImage.image = UIImage(named: "YouLose")
        for i in Letters{
            i.isEnabled = false
        }
        for i in WordLetters.arrangedSubviews{
             let j = i as! UILabel
            char = String(word[word.index(word.startIndex, offsetBy: counter)])
            if( j.text == "?")
            {
                j.text = char
                
            }
            counter += 1
        }
    }
    
    //Checks if you finished the game
    func CheckGame() -> Bool {
        var num1 = 0
        for i in WordLetters.arrangedSubviews{
             let j = i as! UILabel
            if j.text != "?"{
                num1 += 1
            }
            if num1 == word.count-1{
                return true
            }
        }
        return false
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        API.shared.ParseJson()
        //ParseJson()
        for letter in WordLetters.arrangedSubviews{
            letter.removeFromSuperview()
        }
        for char in word{
            if(char.isLetter == true){
                let letter = UILabel()
                letter.text = String("?")
                letter.font = UIFont.systemFont(ofSize: 32)
                letter.textAlignment = .center
                print(letter.text!)
                WordLetters.addArrangedSubview(letter)
                letter.widthAnchor.constraint(equalToConstant: 24).isActive = true
                letter.layoutIfNeeded()
            }
        }
        
           }
    func Vibrate() -> Void {
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
    }
    func SendAlertOfDef() -> Void {
        let alert = UIAlertController(title: word.uppercased(), message: translated_Definition, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
        present(alert, animated: true, completion: nil)
    }


}

//end of controller view
