//
//  OptionViewController.swift
//  Langman
//
//  Created by Patrick Chaca on 5/20/20.
//  Copyright © 2020 Patrick Chaca. All rights reserved.
//

import UIKit
import Foundation
//OPTION VIEW CONTROLLER

class OptionViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        hangman_counter = 0
        SelectScene = "0"
        definition_button = true
        
    }
    //Reads the File and gets the word from text file
    func ReadFile(type: Int) -> Void {
        var file = ""
        var randomInt = 0
        switch type {
        case 3:
            file = "3lettertext"
            randomInt = Int.random(in: 0..<2050)
        case 4:
            file = "4lettertext"
            randomInt = Int.random(in: 0..<7000)
        case 5:
            file = "5letter"
            randomInt = Int.random(in: 0..<15550)
        case 6:
            file = "6lettertext"
            randomInt = Int.random(in: 0..<29800)
        case 7:
            file = "7lettertext"
            randomInt = Int.random(in: 0..<41500)
        default:
            return
        }
        var fileURLproject = ""
        if let text = String(data:NSDataAsset(name: file)!.data, encoding: String.Encoding.utf8){
               fileURLproject = text
                let lines: [String] = text.components(separatedBy: "\n")
                word = lines[randomInt]
           }
        //testing
        print(word)
    }
    
    //All Number Button here
    @IBOutlet var Number: [UIButton]!
    enum Numbers: String{
        case three = "3"
        case four = "4"
        case five = "5"
        case six = "6"
        case seven = "7"
        
    }
    //The first button to pick your numbers
    @IBAction func PickNumber(_ sender: UIButton) {
        Number.forEach { (Button) in
            UIView.animate(withDuration: 0.3) {
                Button.isHidden = !Button.isHidden
                self.view.layoutIfNeeded()
            }
            
        }
    }

    func SetScene(Scene: String) {
        SelectScene = Scene
    }
    
    @IBOutlet weak var DisplayInLetrasMenu: UIButton!
    //All Number Button here
    @IBAction func NumberSelected(_ sender: UIButton) {
         guard let Num_selected = sender.currentTitle, let num = Numbers(rawValue: Num_selected)else{
             return
         }
        Number.forEach { (Button) in
            UIView.animate(withDuration: 0.3) {
                Button.isHidden = !Button.isHidden
                self.view.layoutIfNeeded()
            }
            
        }
        
        SetScene(Scene: num.rawValue)
        DisplayInLetrasMenu.setTitle(num.rawValue, for: .normal)
        //DisplayinVidasMenu.titleLabel!.textAlignment = .center
        switch SelectScene{
        case "3":
            compare = 3
        case "4":
            compare = 4
        case "5":
            compare = 5
        case "6":
            compare = 6
        case "7":
            compare = 7
        default: break
        }
        ReadFile(type: compare)

     }
    
    @IBOutlet weak var DefinitionButton: UISwitch!
    @IBAction func DefinitionButtonStatus(_ sender: Any) {
        if(DefinitionButton.isOn == false){
            definition_button = false
            print( "FALSE ")
        }else{
            definition_button = true
            print("TRUE")
        }
    }
    

    @IBAction func PlayButton(_ sender: Any) {

            self.performSegue(withIdentifier: "ThreeLetterScene", sender: self)
    }

    @IBOutlet var OtherLife: [UIButton]!
    enum Lives: String{
        case Normal = "Normal"
        case Difícil = "Difícil"
    }
    @IBAction func HandleLife(_ sender: UIButton) {
        OtherLife.forEach { (Button) in
            UIView.animate(withDuration: 0.3) {
                Button.isHidden = !Button.isHidden
                self.view.layoutIfNeeded()
            }
            
        }
    }


    @IBOutlet weak var DisplayinVidasMenu: UIButton!
    @IBAction func LifeTapped(_ sender: UIButton) {
        guard let Life_selected = sender.currentTitle, let Life =  Lives(rawValue: Life_selected)else{
             return
         }
        DisplayinVidasMenu.setTitle(Life.rawValue, for: .normal)
        if Life.rawValue == "Normal"{
            num = 1
        }
        else if Life.rawValue == "Difícil"{
            num = 2
        }
        OtherLife.forEach { (Button) in
            UIView.animate(withDuration: 0.3) {
                Button.isHidden = !Button.isHidden
                self.view.layoutIfNeeded()
            }
            
        }
    }
    
    
    @IBAction func BackHome(_ sender: Any) {

        self.performSegue(withIdentifier: "HomeSegue", sender: self)
    }

}


