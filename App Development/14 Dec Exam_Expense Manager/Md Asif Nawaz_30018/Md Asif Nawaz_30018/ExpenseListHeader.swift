//
//  ExpenseListHeader.swift
//  Md Asif Nawaz_30018
//
//  Created by BJIT on 14/12/22.
//

import UIKit

class ExpenseListHeader: UITableViewHeaderFooterView {

    @IBOutlet weak var expenseAmountLabel: UILabel!
    var delegate : ViewController!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
   
  
    @IBAction func addButtonAction(_ sender: Any) {
        delegate.performSegue(withIdentifier: "toExpenseModal", sender: nil)
    }
}
