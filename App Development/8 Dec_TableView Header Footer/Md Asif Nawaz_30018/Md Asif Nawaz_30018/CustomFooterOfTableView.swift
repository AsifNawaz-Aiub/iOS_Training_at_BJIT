//
//  CustomFooterOfTableView.swift
//  Md Asif Nawaz_30018
//
//  Created by BJIT on 8/12/22.
//

import UIKit

class CustomFooterOfTableView: UITableViewHeaderFooterView {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var footerView: UIView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBAction func sliderAction(_ sender: Any) {
       // slider.didChangeValue(forKey: <#T##String#>)
       
        if (round(slider.value) == 1 ) {
            footerView.backgroundColor = .yellow
        }
        if (round(slider.value) == 2 ) {
            footerView.backgroundColor = .red
        }
        if (round(slider.value) == 3 ) {
            footerView.backgroundColor = .green
        }
        if (round(slider.value) == 4 ) {
            footerView.backgroundColor = .orange
        }
        if (round(slider.value) == 5 ) {
            footerView.backgroundColor = .white
        }
        //slider.value
    }
}
