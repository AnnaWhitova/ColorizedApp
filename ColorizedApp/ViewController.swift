//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Анна Белова on 13.05.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var colorizedView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @IBAction func colorizeViewWithSlider() {
        let sliderValue = (redSlider.value * 100).rounded()/100
        redLabel.text = sliderValue.formatted()
        
        let greenSliderValue = (greenSlider.value * 100).rounded()/100
        greenLabel.text = greenSliderValue.formatted()
        
        let blueSliderValue = (blueSlider.value * 100).rounded()/100
        blueLabel.text = blueSliderValue.formatted()
        
        let viewColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1.0
        )
        
        colorizedView.backgroundColor = viewColor
    }

}

