//
//  ViewController.swift
//  Langman
//
//  Created by Patrick Chaca on 5/15/20.
//  Copyright © 2020 Patrick Chaca. All rights reserved.
//
import UIKit
import Foundation
import AVFoundation

//global variables
var word = ""
var Return_Definition = "Doesn't Have an Official Definition"
var translated_Definition = "No tiene una definición oficial"
var SelectScene = "0"
var compare = 0
var hangman_counter = 0
var num = 0
var definition_button = true;



//HOME VIEW CONTROLLER
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func ToOptionScreen(_ sender: Any) {
        self.performSegue(withIdentifier: "OptionViewSegue", sender: self)
    }
    
}


