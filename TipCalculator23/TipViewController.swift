//
//  TipViewController.swift
//  TipCalculator23
//

import UIKit

class TipViewController: UIViewController {
    
    var tipPercentage = 15
    var numOfPeople   =  1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadValues();
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        storeValues();
    }
    
    func loadValues() {
        let defaults = NSUserDefaults.standardUserDefaults()
        tipPercentage = defaults.integerForKey("DEFAULT_TIP_PERCENTAGE")
        if (tipPercentage == 0) {
            tipPercentage = 15
        }
        numOfPeople = defaults.integerForKey("DEFAULT_NUM_OF_PEOPLE")
        if (numOfPeople == 0) {
            numOfPeople = 1
        }
        updateUI();
    }
    
    func storeValues() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(tipPercentage, forKey: "DEFAULT_TIP_PERCENTAGE")
        defaults.setInteger(numOfPeople, forKey: "DEFAULT_NUM_OF_PEOPLE")
        defaults.synchronize()
    }
    
    func updateUI() {
        tipAmountStepper.value = Double(tipPercentage)
        tipPercentageLabel.text = String(tipPercentage) + "%"
        numOfPeopleTextField.text = String(numOfPeople)
    }

    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var numOfPeopleTextField: UITextField!
    @IBOutlet weak var tipAmountStepper: UIStepper!
   
    @IBAction func stepperValueChanged(sender: AnyObject) {
        let stepper = sender as! UIStepper
        
        if (stepper.value >= 0 && stepper.value < 50) {
            tipPercentage = Int(stepper.value)
            updateUI()
        }
    }
    
    @IBAction func numOfPeopleChanged(sender: AnyObject) {
        let textField = sender as! UITextField
        
        if textField.text != nil {
            let input = Int(textField.text!) ?? 0
            if (input > 0 && input < 11) {
                numOfPeople = input
                updateUI()
            }
        }
    }
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
