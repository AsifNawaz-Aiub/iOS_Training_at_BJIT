import UIKit
import Foundation
//class ProgrammingLanguages {
//
//    private var programmingLanguage =  ["C","C++","Swift","C#"]
//
//    subscript(index: Int)->String{
//        get{
//            return programmingLanguage[index]
//        }
//        set(newValue){
//            programmingLanguage[index] = newValue
//        }
//    }
//
//}
//
//var programmingLanguage = ProgrammingLanguages()
//
//print(programmingLanguage[0])
//print(programmingLanguage[2])
//
//enum errors :Error, Equatable {
//    case error1
//    case error2
//    case error3
//}
//do{
//    throw errors.error1
//}
//catch {
//    if errors === errors.error1{
//        print("Error 1")
//    }
//}


enum BankTransactionErrors : Error {
    case invalidWithdraw
    case invalidTimesOfWithdraw
    case invalidAmaountOfLoan
    
}

class BankAccount {
    
    var myAccountBalance:Double
    var totalWithdrawn = 0
    
    let maxTimesOfWithdrawInADay: Int = 3
    let maxLoanCanBeTaken: Double = 100.00
    
    
    
    func checkMaxWithdrawTimeAndAmountValidation (withdrawAmount: Double) throws {
        
            if((myAccountBalance - withdrawAmount) < 0){
                throw BankTransactionErrors.invalidWithdraw
            }
            else {
                totalWithdrawn += 1
                if(maxTimesOfWithdrawInADay<totalWithdrawn){
                    throw BankTransactionErrors.invalidTimesOfWithdraw
                }
                myAccountBalance = myAccountBalance - withdrawAmount
                print("Successfully Withdrawn \(withdrawAmount) BDT -- Your Account Balance = \(myAccountBalance)\n")
            }
        
    }
    
    
    func checkTakingLoanValidation (loanAmount: Double ) throws {
        if (loanAmount > maxLoanCanBeTaken ){
            throw BankTransactionErrors.invalidAmaountOfLoan
        }
        else {
            myAccountBalance = myAccountBalance + loanAmount
            print("\(loanAmount) BDT Loan Granted -- Your Account Balance = \(myAccountBalance)\n")
           
        }
    }
    
    
    
    func doTransaction(choice: Int, withdrawAmount: Double = 0.00, loanAmount : Double = 0.00) throws{
        
        do{
            
            if(choice == 1){
                try checkMaxWithdrawTimeAndAmountValidation(withdrawAmount: withdrawAmount)
            } else if (choice == 2 ){
                try checkTakingLoanValidation(loanAmount: loanAmount)
            }
            
        }
        catch BankTransactionErrors.invalidWithdraw {
            print("Withdraw amount can not be higher than Balance, [Requested Withdraw -  \(withdrawAmount)]\n")
        }
        catch BankTransactionErrors.invalidTimesOfWithdraw {
            print("Can not withdraw more than \(maxTimesOfWithdrawInADay) times a day\n")
        }
        catch BankTransactionErrors.invalidAmaountOfLoan {
            print("Loan can not be taken more than \(maxLoanCanBeTaken) [Requested Loan -  \(loanAmount)]\n")
        }
    }
    
    init(myAccountBalance:Double, totalWithdrawn:Int ){
        self.myAccountBalance = myAccountBalance
        self.totalWithdrawn = totalWithdrawn
    }
    
}

print("-- 1 --")

var a = BankAccount(myAccountBalance: 5000.00, totalWithdrawn: 0)
print("Current Account Balance - \(a.myAccountBalance) \n")

try a.doTransaction(choice: 1, withdrawAmount: 6000.00)
try a.doTransaction(choice: 2, loanAmount: 200.00)

try a.doTransaction(choice: 1, withdrawAmount: 1000.00)
try a.doTransaction(choice: 1, withdrawAmount: 1000.00)
try a.doTransaction(choice: 1, withdrawAmount: 1000.00)
try a.doTransaction(choice: 1, withdrawAmount: 1000.00)
try a.doTransaction(choice: 2, loanAmount: 100.00)



// --  2  --

enum FormValidatorErrors : Error {
    case invalidUsername
    case invalidPassword
    case passwordMismatch
}

class FormValidator {
    
    var errorMsgOfUsername = ""
    var errorMsgOfPassword = ""
    
    func validateUsername (userName:String) throws {
        let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9]*$")
        let range = NSRange(location: 0, length: userName.utf16.count)
        let res = regex.firstMatch(in: userName, options: [], range: range)
        guard res != nil else {
            errorMsgOfUsername = "Username cannot contain any special characters"
            throw FormValidatorErrors.invalidUsername
        }
        if(userName.count < 6){
            errorMsgOfUsername = "Username must be at least 6 characters long."
            throw FormValidatorErrors.invalidUsername
        }
        if(userName.count > 12){
            errorMsgOfUsername = "Username cannot have more than 12 characters."
            throw FormValidatorErrors.invalidUsername
        }
    }
    
    func validatePassword (password:String, confirmPassword:String="") throws {
       
        if(password.count < 10){
            errorMsgOfPassword = "The password must be at least 10 characters long"
            throw FormValidatorErrors.invalidPassword
        }
        if(password.count > 25){
            errorMsgOfPassword = "The password cannot be longer than 25 characters"
            throw FormValidatorErrors.invalidPassword
        }
        
        let regex = try NSRegularExpression(pattern: "^(?=.*?[A-Z])(?=.*?[a-z])")
        let range = NSRange(location: 0, length: password.utf16.count)
        var res = regex.firstMatch(in: password, options: [], range: range)
        guard res != nil else {
            errorMsgOfPassword = "Password must contain both capital and small letters"
            throw FormValidatorErrors.invalidPassword
        }
        
        let regexForAtLeastOneSpecialChar = try NSRegularExpression(pattern: "(?=.*?[#?!@$%^&*-])")
        res = regexForAtLeastOneSpecialChar.firstMatch(in: password, options: [], range: range)
        guard res != nil else {
            errorMsgOfPassword = "The password must contain at least one special character"
            throw FormValidatorErrors.invalidPassword
        }
        
        
        let regexForAtForWhiteSpace = try NSRegularExpression(pattern: "^[\\S]*$")
        res = regexForAtForWhiteSpace.firstMatch(in: password, options: [], range: range)
        guard res != nil else {
            errorMsgOfPassword = "The password cannot contain any whitespaces."
            throw FormValidatorErrors.invalidPassword
        }
        if(password != confirmPassword){
            errorMsgOfPassword = "The values from “Password” and “Confirm Password” fields must match."
            throw FormValidatorErrors.invalidPassword
        }
        
    }
    
    func validateFrom (userName:String, password:String, confirmPassword :String) throws{

        do{
           try validateUsername(userName: userName)
        }
        catch FormValidatorErrors.invalidUsername{
            print(errorMsgOfUsername)
        }
        do{
            try validatePassword(password: password,  confirmPassword: confirmPassword)
        }
        catch FormValidatorErrors.invalidPassword{
            print(errorMsgOfPassword)
        }
    }
}

print("-- 2 --")
var post = FormValidator()
try post.validateFrom(userName: "ABAB0#ab", password: "ABABABABAb", confirmPassword: "aaaa@aaaaAaa")
