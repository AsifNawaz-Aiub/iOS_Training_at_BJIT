//
//  ViewController.swift
//  Md Asif Nawaz_30018
//
//  Created by BJIT on 14/12/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var editModeFlag = false
    var editModeIndexPath: IndexPath!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
      
        // Do any additional setup after loading the view.
        let headerNib = UINib(nibName: "ExpenseListHeaderNib", bundle: nil)
        tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "ExpenseListHeader")
        print(Expense.expenseList)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination  as? ExpenseModalViewController {
            if editModeFlag == true {
                let amount = String(Expense.expenseList[editModeIndexPath.row].expenseAmount)
                destination.delegate = self
                destination.loadViewIfNeeded()
                destination.expenseDescpTF.text = Expense.expenseList[editModeIndexPath.row].expenseDescription
                destination.expenseAmount.text = amount
                destination.expenseDate.date = Expense.expenseList[editModeIndexPath.row].expenseDate
                destination.expenseTypeTF.text = Expense.expenseList[editModeIndexPath.row].expensType
                destination.headLine.text = "Edit An Expense"
                
            }else{
                destination.loadViewIfNeeded()
                destination.headLine.text = "Create A New Expense"
                destination.delegate = self
            }
          
        }
    }
    
}
extension ViewController : UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Expense.expenseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eachExpenseCell", for: indexPath)  as! EachExpenseTableViewCell
       
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateToStr = dateFormatter.string(from: Expense.expenseList[indexPath.row].expenseDate)
        let amount = String(Expense.expenseList[indexPath.row].expenseAmount)
        
        cell.expenseTypeLabel.text = Expense.expenseList[indexPath.row].expensType
        cell.descriptionLabel.text = Expense.expenseList[indexPath.row].expenseDescription
        cell.amountLabel.text = amount + " BDT"
        cell.dateLabel.text = dateToStr
       
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ExpenseListHeader") as! ExpenseListHeader
        header.delegate = self
        header.expenseAmountLabel.text = calculateTotalExpense()
        header.backgroundColor = .yellow
        return header
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: nil){ [weak self] _,_, completion in
            
            guard let self = self else{return}
            completion(true)
            self.handleDeleteAction(indexPath : [indexPath])
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor =  .systemRed
        
        let swipeAction =  UISwipeActionsConfiguration (actions: [deleteAction])
        
        return swipeAction
        
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: nil) { [weak self] _,_, completion in
            guard let self =  self else {return}
            completion(true)
            self.handleEditAction(indexPath : [indexPath])
        }
        editAction.image = UIImage(systemName: "pencil")
        editAction.backgroundColor = .gray
        let leadingSwipeAction = UISwipeActionsConfiguration(actions: [editAction])
        return leadingSwipeAction
    }
    func handleDeleteAction (indexPath : [IndexPath]) {
        tableView.beginUpdates()
        tableView.deleteRows(at: indexPath , with: .bottom)
        Expense.expenseList.remove(at: indexPath[0].row)
        tableView.endUpdates()
        tableView.reloadData()
        
    }
    func handleEditAction (indexPath : [IndexPath]) {
        editModeFlag =  true
        editModeIndexPath = indexPath[0]
        performSegue(withIdentifier: "toExpenseModal", sender: nil)
    }
    func calculateTotalExpense() -> String{
        var sum = 0.00
        for eachVal in Expense.expenseList {
            sum =  sum + eachVal.expenseAmount
        }
        
        return String(sum) + " BDT"
    }
    
}
