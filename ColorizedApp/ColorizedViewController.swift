//
//  ColorizedViewController.swift
//  ColorizedApp
//
//  Created by Анна Белова on 18.06.2024.
//

import UIKit

protocol SetColorViewControllerDelegate: AnyObject {
    func setColor(from color: UIColor)
}

class ColorizedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let setColorVC = segue.destination as? SetColorViewController
        setColorVC?.viewColor = view.backgroundColor
        setColorVC?.delegate = self

    }

}

extension ColorizedViewController: SetColorViewControllerDelegate {
    func setColor(from color: UIColor) {
        view.backgroundColor = color
    }
    
}



