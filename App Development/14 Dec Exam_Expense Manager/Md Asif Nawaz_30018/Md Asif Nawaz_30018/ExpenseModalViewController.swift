//
//  ExpenseModalViewController.swift
//  Md Asif Nawaz_30018
//
//  Created by BJIT on 14/12/22.
//

import UIKit

class ExpenseModalViewController: UIViewController {

    @IBOutlet weak var expenseTypeTF: UITextField!
    @IBOutlet weak var expenseDescpTF: UITextField!
    @IBOutlet weak var expenseAmount: UITextField!
    @IBOutlet weak var expenseDate: UIDatePicker!
    
    @IBOutlet weak var headLine: UILabel!
    var delegate : ViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        //expenseDate.date = Date.now
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveExpenseAction(_ sender: Any) {
        
        let expAmount: Double! = Double(expenseAmount.text!) // will unwrap later
        if(expenseTypeTF.text != "" && expenseDescpTF.text != "" && expenseAmount.text != "" ){
            
            if delegate.editModeFlag == false {
                if let _ = expAmount {
                    let  anExpense = Expense(expensType: expenseTypeTF.text!, expenseDescription: expenseDescpTF.text!, expenseDate: expenseDate.date, expenseAmount: expAmount)
                    Expense.expenseList.append(anExpense)
                    delegate.tableView.reloadData()
                    //let _ = delegate.calculateTotalExpense()
                    self.dismiss(animated: true)
                }
             
            }else {
              
                let  anExpense = Expense(expensType: expenseTypeTF.text!, expenseDescription: expenseDescpTF.text!, expenseDate: expenseDate.date, expenseAmount: expAmount)
                Expense.expenseList[delegate.editModeIndexPath.row] = anExpense
                delegate.tableView.reloadData()
                //let _ = delegate.calculateTotalExpense()
                self.dismiss(animated: true)
                delegate.editModeFlag = false
            }
        }
        //
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
