//
//  ViewController.swift
//  lab4
//
//  Created by Vivek on 02/06/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var DateOfBirth: UITextField!
    @IBOutlet weak var City: UITextField!
    @IBOutlet weak var Address: UITextField!
    @IBOutlet weak var Surname: UITextField!
    @IBOutlet weak var FirstName: UITextField!
    @IBOutlet weak var Display: UITextView!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePicker()
        // Do any additional setup after loading the view.
    }
    
    func setupDatePicker() {
            
            datePicker.datePickerMode = .date
        
            datePicker.preferredDatePickerStyle = .wheels

            // Create a toolbar and give it a Done button
            let toolbar = UIToolbar()
            toolbar.sizeToFit()

            let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
            toolbar.setItems([doneBtn], animated: true)

            // Assign toolbar to the text field
            DateOfBirth.inputAccessoryView = toolbar

            // Assign date picker to the text field
            DateOfBirth.inputView = datePicker

            // DatePicker change action
            datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        }
    @objc func dateChanged() {
        let formatter = DateFormatter()
               formatter.dateStyle = .medium
               formatter.timeStyle = .none
               DateOfBirth.text = formatter.string(from: datePicker.date)
       }
    
        func calculateAge(from birthDate: Date) -> Int {
            let calendar = Calendar.current
            let now = Date()
            let ageComponents = calendar.dateComponents([.year], from: birthDate, to: now)
            return ageComponents.year ?? 0 // Returns 0 if something goes wrong
        }
    
    @objc func donePressed() {
            self.view.endEditing(true)
        }
    
    
    @IBAction func Reset(_ sender: Any) {
        FirstName.text = ""
        City.text = ""
        DateOfBirth.text = ""
        Address.text = ""
        Surname.text = ""
        Display.text = ""
    }
    
    @IBAction func Decline(_ sender: Any) {
        FirstName.text = ""
        City.text = ""
        DateOfBirth.text = ""
        Address.text = ""
        Surname.text = ""
        Display.text="The user has declined."
    }
    
    @IBAction func Accept(_ sender: Any) {
        let firstname = FirstName.text ?? ""
        let surname = Surname.text ?? ""
        let address = Address.text ?? ""
        let city = City.text ?? ""
        let DateofBirth = DateOfBirth.text ?? ""
        let age = calculateAge(from: datePicker.date)
        if !firstname.isEmpty &&
            !surname.isEmpty &&
            !city.isEmpty &&
            !address.isEmpty &&
            !DateofBirth.isEmpty {
            if(age>18){
                
                Display.text = "I, \(firstname), \(surname), currently living at \(address) in the city of \(city) do hereby accept the terms and conditions assignment.\n\nI am \(age) and therefore am able to accept the conditions of this assignment.";
            }else{
                Display.text="Your age should be over 18 to accept this condition."
            }
        }else{
            Display.text="Fill the missing info"
        }
        
    }
}

