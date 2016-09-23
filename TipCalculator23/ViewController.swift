//
//  ViewController.swift
//  TipCalculator23
//

import UIKit

class ViewController: UIViewController, AKPickerViewDelegate, AKPickerViewDataSource, UITextFieldDelegate {
    
    var numberOfPeoplePicker : AKPickerView?
    var tipPercentagePicker : AKPickerView?
    
    let TAG_FOR_TIP_PERCENTAGE = 0
    let TAG_FOR_NUM_OF_PEOPLE = 1
    
    var defaultTipPercentage = -1
    var defaultNumOfPeople   = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.billField.becomeFirstResponder() // start editing
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if (!(self.tipPercentagePicker != nil)) {
            setupPickerViews()
        }
        self.billField.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        checkDefaultsForPickers()
        self.billField.becomeFirstResponder() // start editing
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalAmount: UILabel!
    @IBOutlet weak var tipPercentageView: UIView!
    @IBOutlet weak var numberOfPeopleView: UIView!
    @IBOutlet weak var totalPerPersonLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    
    func updateUI() {
        let bill = Double(billField.text!) ?? 0
        let tip = bill * Double((tipPercentagePicker?.selectedItem)!) / 100
        let total = tip + bill
        let totalPP = total / Double((numberOfPeoplePicker?.selectedItem)! + 1)
        
        tipLabel.text = String(format:"+ %.2f", tip)
        totalAmount.text = String(format:"%.2f", total)
        totalPerPersonLabel.text = String(format:"%.2f", totalPP)
    }
 
    func setupPickerViews() {
        
        self.tipPercentagePicker = AKPickerView(frame: tipPercentageView.frame)
        self.tipPercentagePicker?.delegate = self
        self.tipPercentagePicker?.dataSource = self
        self.tipPercentagePicker?.font = UIFont(name: "HelveticaNeue-Light", size: 40)!
        self.tipPercentagePicker?.highlightedFont = UIFont(name: "HelveticaNeue", size: 40)!
        self.tipPercentagePicker?.textColor = UIColor.whiteColor()
        self.tipPercentagePicker?.highlightedTextColor = UIColor.whiteColor()
        self.tipPercentagePicker?.pickerViewStyle = .Wheel
        self.tipPercentagePicker?.maskDisabled = false
        self.tipPercentagePicker?.interitemSpacing = 25.0
        self.tipPercentagePicker?.tag = TAG_FOR_TIP_PERCENTAGE
        self.tipPercentagePicker?.reloadData()
        
        self.numberOfPeoplePicker = AKPickerView(frame: numberOfPeopleView.frame)
        self.numberOfPeoplePicker?.delegate = self
        self.numberOfPeoplePicker?.dataSource = self
        self.numberOfPeoplePicker?.font = UIFont(name: "HelveticaNeue-Light", size: 40)!
        self.numberOfPeoplePicker?.highlightedFont = UIFont(name: "HelveticaNeue", size: 40)!
        self.numberOfPeoplePicker?.textColor = UIColor.whiteColor()
        self.numberOfPeoplePicker?.highlightedTextColor = UIColor.whiteColor()
        self.numberOfPeoplePicker?.pickerViewStyle = .Wheel
        self.numberOfPeoplePicker?.maskDisabled = false
        self.numberOfPeoplePicker?.interitemSpacing = 25.0
        self.numberOfPeoplePicker?.tag = TAG_FOR_NUM_OF_PEOPLE
        self.numberOfPeoplePicker?.reloadData()
    
        self.view.addSubview(self.numberOfPeoplePicker!)
        self.view.addSubview(self.tipPercentagePicker!)
    }
    
    func checkDefaultsForPickers() {
        let defaults = NSUserDefaults.standardUserDefaults()
        var tipPercentage = defaults.integerForKey("DEFAULT_TIP_PERCENTAGE")
        if (tipPercentage == 0) {
            tipPercentage = 15
        }
        var numOfPeople = defaults.integerForKey("DEFAULT_NUM_OF_PEOPLE")
        if (numOfPeople == 0) {
            numOfPeople = 1
        }
        if (defaultTipPercentage != tipPercentage) {
            defaultTipPercentage = tipPercentage
            self.tipPercentagePicker?.selectItem(tipPercentage)
        }
        if (defaultNumOfPeople != numOfPeople) {
            defaultNumOfPeople = numOfPeople
            self.numberOfPeoplePicker?.selectItem(numOfPeople - 1)
        }
    }
    
    // MARK: - AKPickerViewDataSource
    
    func numberOfItemsInPickerView(pickerView: AKPickerView) -> Int {
        if (pickerView.tag == self.TAG_FOR_TIP_PERCENTAGE) {
            return 50;
        } else {
            return 10
        }
    }
    
    func pickerView(pickerView: AKPickerView, imageForItem item: Int) -> UIImage {
        return UIImage(named: "")!
    }
    
    func pickerView(pickerView: AKPickerView, titleForItem item: Int) -> String {
        if (pickerView.tag == self.TAG_FOR_TIP_PERCENTAGE) {
            return String(item) + "%"
        } else {
            return String(item + 1);
        }
    }
    
    // MARK: - AKPickerViewDelegate
    
    func pickerView(pickerView: AKPickerView, didSelectItem item: Int) {
        self.updateUI()
    }
    
    @IBAction func onEditChanged(sender: AnyObject) {
        self.updateUI()
    }
    
    // TextField delegate
    // Somehow this didn't work as a subclass
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}

