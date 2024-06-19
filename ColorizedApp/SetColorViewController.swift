//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Анна Белова on 13.05.2024.
//

import UIKit

final class SetColorViewController: UIViewController {

    @IBOutlet var colorizedView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    var viewColor: UIColor!
    
    weak var delegate: SetColorViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem?.isHidden = true
        
        colorizedView.layer.cornerRadius = 10
        
        colorizedView.backgroundColor = viewColor
        
        redLabel.text = string(from: redSlider)
        greenLabel.text = string(from: greenSlider)
        blueLabel.text = string(from: blueSlider)
        
        setUpSlidersValue()
        
        setValueforTextFields()
        
        setUpToolbar()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func colorizeView(_ sender: UISlider) {
        setUpViewColor()
        
        setValueforTextFields()
        
        switch sender {
        case redSlider:
            redLabel.text = string(from: redSlider)
        case greenSlider:
            greenLabel.text = string(from: greenSlider)
        default:
            blueLabel.text = string(from: blueSlider)
        }
    
    }
    
    @IBAction func changeViewColorButtonPressed() {
        delegate?.setColor(from: colorizedView.backgroundColor ?? .white)
        dismiss(animated: true)
    }

}

extension Float {
    func cgFloat() -> CGFloat {
    CGFloat(self)
    }
}


//MARK: private methods
extension SetColorViewController {
    
   private func setUpViewColor() {
        let viewColor = UIColor(
            red: redSlider.value.cgFloat(),
            green: greenSlider.value.cgFloat(),
            blue: blueSlider.value.cgFloat(),
            alpha: 1.0
        )

        colorizedView.backgroundColor = viewColor
    }
    
    private func setUpSlidersValue() {
        let color = CIColor(color: viewColor)
        
        redSlider.value = Float(color.red)
        greenSlider.value = Float(color.green)
        blueSlider.value = Float(color.blue)
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func showAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}


//MARK: UITextFieldDelegate
extension SetColorViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == redTextField {
            let redSliderValue = Float(textField.text ?? "") ?? 0
            redSlider.setValue(redSliderValue, animated: true)
            redLabel.text = textField.text
        } else if textField == greenTextField {
            let greenSliderValue = Float(textField.text ?? "") ?? 0
            greenSlider.setValue(greenSliderValue, animated: true)
            greenLabel.text = textField.text
        } else {
            let blueSliderValue = Float(textField.text ?? "") ?? 0
            blueSlider.setValue(blueSliderValue, animated: true)
            blueLabel.text = textField.text
        }
        
        let textFields: [UITextField] = [redTextField, greenTextField, blueTextField]
        
        for textField in textFields {
            guard let value = Float(textField.text ?? "") else {return}
            if value < 0.0 || value > 1.0 {
                showAlert(withTitle: "Wrong format", andMessage: "use numbers from 0 to 1")
            }
        }
        setUpViewColor()
        
        setValueforTextFields()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    private func setValueforTextFields() {
        redTextField.text = string(from: redSlider)
        greenTextField.text = string(from: greenSlider)
        blueTextField.text = string(from: blueSlider)
    }
    
    private func setUpToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        
        toolbar.items = [flexibleSpace, doneButton]
        
        redTextField.inputAccessoryView = toolbar
        redTextField.delegate = self
        greenTextField.inputAccessoryView = toolbar
        greenTextField.delegate = self
        blueTextField.inputAccessoryView = toolbar
        blueTextField.delegate = self
    }
    
    @objc func doneButtonTapped() {
        redTextField.resignFirstResponder()
        greenTextField.resignFirstResponder()
        blueTextField.resignFirstResponder()
        }

   
}

