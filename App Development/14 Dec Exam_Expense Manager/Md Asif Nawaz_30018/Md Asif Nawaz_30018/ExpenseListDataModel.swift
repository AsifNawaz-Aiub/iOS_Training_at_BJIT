//
//  ExpenseListDataModel.swift
//  Md Asif Nawaz_30018
//
//  Created by BJIT on 14/12/22.
//

import Foundation

struct Expense {
    
    var expensType : String = ""
    var expenseDescription : String = ""
    var expenseDate : Date = Date.now
    var expenseAmount : Double = 0.00
    static var expenseList : [Expense] = [Expense(expensType: "Transportation", expenseDescription: "Ricksha Rent", expenseDate: Date.now, expenseAmount: 50.00),
        Expense(expensType: "Transportation", expenseDescription: "Ricksha Rent", expenseDate: Date.now, expenseAmount: 50.00)]
}
