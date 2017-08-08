//
//  CreateRecipeVC.swift
//  TestingRecipeApp
//
//  Created by Andrew Lim on 03/08/2017.
//  Copyright © 2017 Andrew Lim. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateRecipeVC: UIViewController {


    @IBOutlet weak var cancelButton: UIBarButtonItem!{
        didSet{
            cancelButton.target = self
            cancelButton.action = #selector(didTapCancelButton(_:))
        }
    }
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var stepsTextView: UITextView!
    
    @IBOutlet weak var doneButton: UIButton!{
        didSet{
            doneButton.addTarget(self, action: #selector(didTapDoneButton(_:)), for: .touchUpInside)
        }
    }
    
    var receiveCategory: [String]?
    var selectedRow = 0
    let picker = UIPickerView() //programmatically program pickerview
    let pickerArray = ["Vegetarian","Fast food","Healthy","No-cook","Make ahead"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        picker.dataSource = self
        
        displayPickerView()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func didTapCancelButton(_ sender: Any){
        dismiss(animated: true, completion: nil)
    }
    
    func displayPickerView(){
        let pickerView = picker
        pickerView.backgroundColor = .white
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePickerView))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(cancelPickerView))
        
        toolBar.setItems([doneButton, spaceButton, cancelButton], animated: false)
        
        categoryTextField.inputView = pickerView
        categoryTextField.inputAccessoryView = toolBar
    }
    
    func donePickerView(){
        categoryTextField.text = pickerArray[selectedRow]
        categoryTextField.resignFirstResponder()
    }
    
    func cancelPickerView(){
        categoryTextField.resignFirstResponder()
    }
    
    func didTapDoneButton(_ sender: Any){
        guard
            let title = titleTextField.text,
            let ingredients = textView.text,
            let steps = stepsTextView.text,
            let category = categoryTextField.text
            else { return }
        
        if title == ""{
        
        } else if ingredients == ""{
        
        } else if steps == "" {
            
        } else if category == "" {
            
        } else {
            
            let param : [String:Any] = ["title" : title,
                                        "ingredients" : ingredients,
                                        "steps" : steps,
                                        "category" : category]
            
            let ref = Database.database().reference().child("recipes").child(category).childByAutoId()
            ref.setValue(param)
            
            let recipeID = ref.key
            print(recipeID)
            
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension CreateRecipeVC : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row //for done button to get current row
    }
}
