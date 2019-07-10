//
//  ViewController.swift
//  JCLandingView
//
//  Created by jasonchan91 on 12/11/2018.
//  Copyright (c) 2018 jasonchan91. All rights reserved.
//

import UIKit
import JCLandingView

class HeaderView: UIView {
    lazy var firstHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Basic"
        label.textColor = UIColor.textColor
        label.font = UIFont.demiBoldDefaultFont(ofSize: 13)
        label.landingViewContentSize = JCSize(width: .auto, height: .auto)
        label.landingViewContentHorizontalAlignment = .left
        label.textAlignment = .left
        label.landingViewContentInset = UIEdgeInsets(top: 14, left: 15, bottom: 14, right: 15)
        label.backgroundColor = UIColor.clear
        return label
    }()
    
    
    init(title: String) {
        super.init(frame: .zero)
        addSubview(firstHeaderLabel)
        firstHeaderLabel.text = title
        firstHeaderLabel.translatesAutoresizingMaskIntoConstraints = false
        firstHeaderLabel.topAnchor.constraint(equalTo: topAnchor, constant: 14).isActive = true
        firstHeaderLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14).isActive = true
        firstHeaderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        firstHeaderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ViewController: UIViewController {
    
    fileprivate lazy var landingView: JCLandingView = {
        let view = JCLandingView()
        view.autoHideKeyboardWhenScroll = true
        view.isScrollEnabled = true
        view.landingViewSeparatorIsHidden = true
        view.autoHideLastSeparator = false
        view.landingViewSeparatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        view.shouldObserveKeyboard = true
        view.landingViewContentInset = UIEdgeInsets(top: 100, left: 0, bottom: 100, right: 0)
        return view
    }()
    
    
    fileprivate lazy var firstHeaderView: HeaderView = {
        let view = HeaderView(title: "Basic")
        view.landingViewContentSize = JCSize(width: .auto, height: .auto)
        view.landingViewContentHorizontalAlignment = .left
        view.landingViewBackgroundColor = UIColor.groupTableViewBackground
        return view
    }()
    
    fileprivate lazy var firstNameIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.landingViewContentSize = JCSize(width: .value(10), height: .value(10))
        return view
    }()
    
    fileprivate lazy var firstNameLabel: UILabel = {
        let label = UILabel()
        label.text = "First Name"
        label.textColor = UIColor.textColor
        label.font = UIFont.mediumDefaultFont(ofSize: 16)
        label.landingViewContentSize = JCSize(width: .auto, height: .value(50))
        label.landingViewContentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return label
    }()
    
    fileprivate lazy var firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor.textColor
        textField.font = UIFont.mediumDefaultFont(ofSize: 14)
        textField.text = ""
        textField.landingViewContentSize = JCSize(width: .ratio(0.5), height: .value(50))
        textField.textAlignment = .right
        textField.landingViewContentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
        return textField
    }()
    
    fileprivate lazy var lastNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Last Name"
        label.textColor = UIColor.textColor
        label.font = UIFont.mediumDefaultFont(ofSize: 16)
        label.landingViewContentSize = JCSize(width: .auto, height: .value(50))
        label.landingViewContentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return label
    }()
    
    fileprivate lazy var lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor.textColor
        textField.font = UIFont.mediumDefaultFont(ofSize: 14)
        textField.text = ""
        textField.landingViewContentSize = JCSize(width: .ratio(0.5), height: .value(50))
        textField.textAlignment = .right
        textField.landingViewContentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
        return textField
    }()
    
    fileprivate lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.text = "Age"
        label.textColor = UIColor.textColor
        label.font = UIFont.mediumDefaultFont(ofSize: 16)
        label.landingViewContentSize = JCSize(width: .auto, height: .value(50))
        label.landingViewContentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return label
    }()
    
    fileprivate lazy var ageTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor.textColor
        textField.font = UIFont.mediumDefaultFont(ofSize: 14)
        textField.text = ""
        textField.landingViewContentSize = JCSize(width: .ratio(0.5), height: .value(50))
        textField.textAlignment = .right
        textField.landingViewContentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
        textField.keyboardType = .numberPad
        return textField
    }()
    
    fileprivate lazy var genderLabel: UILabel = {
        let label = UILabel()
        label.text = "Gender"
        label.textColor = UIColor.textColor
        label.font = UIFont.mediumDefaultFont(ofSize: 16)
        label.landingViewContentSize = JCSize(width: .auto, height: .auto)
        label.landingViewContentInset = UIEdgeInsets(top: 14, left: 15, bottom: 5, right: 15)
        label.landingViewSeparatorIsHidden = true
        return label
    }()
    
    fileprivate lazy var maleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Male", for: .normal)
        button.titleLabel?.font = UIFont.mediumDefaultFont(ofSize: 16)
        button.isSelected = false
        button.setTitleColor(UIColor.tintColor, for: .normal)
        button.setTitleColor(UIColor.white, for: .selected)
        button.landingViewContentSize = JCSize(width: .ratio(0.5), height: .value(35))
        button.landingViewContentInset = UIEdgeInsets(top: 0, left: 15, bottom: 14, right: 7.5)
        button.backgroundColor = button.isSelected ? UIColor.tintColor : UIColor.white
        button.layer.cornerRadius = 4
        button.layer.borderColor = button.isSelected ? UIColor.white.cgColor : UIColor.tintColor.cgColor
        button.layer.borderWidth = 1
        
        return button
    }()
    
    fileprivate lazy var femaleButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Female", for: .normal)
        button.titleLabel?.font = UIFont.mediumDefaultFont(ofSize: 16)
        button.isSelected = false
        button.setTitleColor(UIColor.tintColor, for: .normal)
        button.setTitleColor(UIColor.white, for: .selected)
        button.landingViewContentSize = JCSize(width: .ratio(0.5), height: .value(35))
        button.landingViewContentInset = UIEdgeInsets(top: 0, left: 7.5, bottom: 14, right: 15)
        button.backgroundColor = button.isSelected ? UIColor.tintColor : UIColor.white
        button.layer.cornerRadius = 4
        button.layer.borderColor = button.isSelected ? UIColor.white.cgColor : UIColor.tintColor.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    fileprivate lazy var buyHeaderView: HeaderView = {
        let view = HeaderView(title: "Buyer Info")
        view.landingViewContentSize = JCSize(width: .auto, height: .auto)
        view.landingViewBackgroundColor = UIColor.groupTableViewBackground
        return view
    }()
    
    fileprivate lazy var buyLabel: UILabel = {
        let label = UILabel()
        label.text = "I want to buy"
        label.textColor = UIColor.textColor
        label.font = UIFont.mediumDefaultFont(ofSize: 16)
        label.landingViewContentSize = JCSize(width: .auto, height: .value(50))
        label.landingViewContentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return label
    }()
    
    fileprivate lazy var buyToggle: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = false
        switcher.landingViewContentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        switcher.addTarget(self, action: #selector(buyToggleChanged(_:)), for: .valueChanged)
        return switcher
    }()
    
    fileprivate lazy var rentToggle: UISwitch = {
        let switcher = UISwitch()
        switcher.isOn = false
        switcher.landingViewContentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        switcher.addTarget(self, action: #selector(rentToggleChanged(_:)), for: .valueChanged)
        return switcher
    }()
    
    fileprivate lazy var immigrationStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Immigration Status"
        label.textColor = UIColor.textColor
        label.font = UIFont.mediumDefaultFont(ofSize: 16)
        label.landingViewContentSize = JCSize(width: .auto, height: .auto)
        label.landingViewContentInset = UIEdgeInsets(top: 14, left: 15, bottom: 5, right: 15)
        label.landingViewSeparatorIsHidden = true
        return label
    }()
    
    fileprivate lazy var citizenButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Singapore Citizen", for: .normal)
        button.titleLabel?.font = UIFont.mediumDefaultFont(ofSize: 16)
        button.isSelected = false
        button.setTitleColor(UIColor.tintColor, for: .normal)
        button.setTitleColor(UIColor.white, for: .selected)
        button.landingViewContentSize = JCSize(width: .ratio(0.5), height: .value(35))
        button.landingViewContentInset = UIEdgeInsets(top: 0,  left: 15, bottom: 0, right: 7.5)
        button.backgroundColor = button.isSelected ? UIColor.tintColor : UIColor.white
        button.layer.cornerRadius = 4
        button.layer.borderColor = button.isSelected ? UIColor.white.cgColor : UIColor.tintColor.cgColor
        button.layer.borderWidth = 1
        
        return button
    }()
    
    fileprivate lazy var PRButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Singapore PR", for: .normal)
        button.titleLabel?.font = UIFont.mediumDefaultFont(ofSize: 16)
        button.isSelected = false
        button.setTitleColor(UIColor.tintColor, for: .normal)
        button.setTitleColor(UIColor.white, for: .selected)
        button.landingViewContentSize = JCSize(width: .ratio(0.5), height: .value(35))
        button.landingViewContentInset = UIEdgeInsets(top: 0, left: 7.5, bottom: 0, right: 15)
        button.backgroundColor = button.isSelected ? UIColor.tintColor : UIColor.white
        button.layer.cornerRadius = 4
        button.layer.borderColor = button.isSelected ? UIColor.white.cgColor : UIColor.tintColor.cgColor
        button.layer.borderWidth = 1
        button.landingViewSeparatorIsHidden = true
        return button
    }()
    
    fileprivate lazy var foreignerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Foreigner", for: .normal)
        button.titleLabel?.font = UIFont.mediumDefaultFont(ofSize: 16)
        button.isSelected = false
        button.setTitleColor(UIColor.tintColor, for: .normal)
        button.setTitleColor(UIColor.white, for: .selected)
        button.landingViewContentSize = JCSize(width: .ratio(0.5), height: .value(35))
        button.landingViewContentHorizontalAlignment = .left
        button.landingViewContentInset = UIEdgeInsets(top: 5, left: 15, bottom: 14, right: 7.5)
        button.backgroundColor = button.isSelected ? UIColor.tintColor : UIColor.white
        button.layer.cornerRadius = 4
        button.layer.borderColor = button.isSelected ? UIColor.white.cgColor : UIColor.tintColor.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    fileprivate lazy var hiddenButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("", for: .normal)
        button.isHidden = true
        button.titleLabel?.font = UIFont.mediumDefaultFont(ofSize: 16)
        button.isSelected = false
        button.setTitleColor(UIColor.tintColor, for: .normal)
        button.setTitleColor(UIColor.white, for: .selected)
        button.landingViewContentInset = UIEdgeInsets(top: 0, left: 7.5, bottom: 14, right: 15)
        button.backgroundColor = button.isSelected ? UIColor.tintColor : UIColor.white
        button.layer.cornerRadius = 4
        button.layer.borderColor = button.isSelected ? UIColor.white.cgColor : UIColor.tintColor.cgColor
        button.layer.borderWidth = 1
        button.landingViewSeparatorIsHidden = false
        return button
    }()
    
    
    private let mainPurpose = ["None", "Own Stay", "Investment", "Others"]
    
    fileprivate lazy var mainPurposeLabel: UILabel = {
        let label = UILabel()
        label.text = "Main Purpose"
        label.textColor = UIColor.textColor
        label.font = UIFont.mediumDefaultFont(ofSize: 16)
        label.landingViewContentSize = JCSize(width: .auto, height: .value(50))
        label.landingViewContentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return label
    }()
    
    fileprivate lazy var mainPurposeEnteredLabel: UILabel = {
        let label = UILabel()
        label.text = "None"
        label.textColor = UIColor.textColor
        label.font = UIFont.mediumDefaultFont(ofSize: 14)
        label.landingViewContentSize = JCSize(width: .ratio(0.5), height: .auto)
        label.landingViewContentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(mainPurposeEnteredLabelDidTap(_:))))
        label.textAlignment = .right
        label.isUserInteractionEnabled = true
        return label
    }()
    
    fileprivate lazy var maximumBudgetLabel: UILabel = {
        let label = UILabel()
        label.text = "Maximum Budget"
        label.textColor = UIColor.textColor
        label.font = UIFont.mediumDefaultFont(ofSize: 16)
        label.landingViewContentSize = JCSize(width: .auto, height: .value(50))
        label.landingViewContentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return label
    }()
    
    fileprivate lazy var maximumBudgetTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor.textColor
        textField.font = UIFont.mediumDefaultFont(ofSize: 14)
        textField.text = ""
        textField.landingViewContentSize = JCSize(width: .ratio(0.5), height: .auto)
        textField.textAlignment = .right
        textField.landingViewContentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    fileprivate lazy var amenitiesLabel: UILabel = {
        let label = UILabel()
        label.text = "Amenities"
        label.textColor = UIColor.textColor
        label.font = UIFont.mediumDefaultFont(ofSize: 16)
        label.landingViewContentSize = JCSize(width: .auto, height: .value(50))
        label.landingViewContentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return label
    }()
    
    fileprivate lazy var amenitiesEnteredLabel: UILabel = {
        let label = UILabel()
        label.text = "None"
        label.textColor = UIColor.textColor
        label.font = UIFont.mediumDefaultFont(ofSize: 14)
        label.landingViewContentSize = JCSize(width: .ratio(0.5), height: .auto)
        label.landingViewContentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(amenitiesEnteredLabelDidTap(_:))))
        label.textAlignment = .right
        label.isUserInteractionEnabled = true
        return label
    }()
    
    fileprivate lazy var minimumSizeLabel: UILabel = {
        let label = UILabel()
        label.text = "Minimum sqft"
        label.textColor = UIColor.textColor
        label.font = UIFont.mediumDefaultFont(ofSize: 16)
        label.landingViewContentSize = JCSize(width: .auto, height: .value(50))
        label.landingViewContentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return label
    }()
    
    fileprivate lazy var minumumSizeTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor.textColor
        textField.font = UIFont.mediumDefaultFont(ofSize: 14)
        textField.text = "1256.3 sqft"
        textField.landingViewContentSize = JCSize(width: .ratio(0.5), height: .auto)
        textField.textAlignment = .right
        textField.landingViewContentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    fileprivate lazy var othersRequirementLabel: UILabel = {
        let label = UILabel()
        label.text = "Others requirement"
        label.textColor = UIColor.textColor
        label.font = UIFont.mediumDefaultFont(ofSize: 16)
        label.landingViewContentSize = JCSize(width: .auto, height: .value(50))
        label.landingViewContentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        label.landingViewSeparatorIsHidden = true
        return label
    }()
    
    
    fileprivate lazy var otherRequirementTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.textColor
        textView.font = UIFont.mediumDefaultFont(ofSize: 16)
        textView.landingViewContentSize = JCSize(width: .auto, height: .value(100))
        textView.landingViewContentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return textView
    }()
    
    
    fileprivate lazy var accessoryImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "Disclosure Indicator"))
        imageView.contentMode = .scaleAspectFill
        imageView.landingViewContentSize = JCSize(width: .value(8), height: .value(13))
        imageView.landingViewContentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
        return imageView
    }()
    
    
    fileprivate lazy var mainPurposePickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.tag = 1
        pickerView.dataSource = self
        pickerView.delegate = self
        return pickerView
    }()
    
    
    fileprivate lazy var rentHeaderView: HeaderView = {
        let view = HeaderView(title: "Tenant Info")
        view.landingViewContentSize = JCSize(width: .auto, height: .auto)
        view.landingViewBackgroundColor = UIColor.groupTableViewBackground
        return view
    }()
    
    fileprivate lazy var rentLabel: UILabel = {
        let label = UILabel()
        label.text = "I want to rent"
        label.textColor = UIColor.textColor
        label.font = UIFont.mediumDefaultFont(ofSize: 16)
        label.landingViewContentSize = JCSize(width: .auto, height: .value(50))
        label.landingViewContentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return label
    }()
    
    fileprivate lazy var moveInDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Move in date"
        label.textColor = UIColor.textColor
        label.font = UIFont.mediumDefaultFont(ofSize: 16)
        label.landingViewContentSize = JCSize(width: .auto, height: .value(50))
        label.landingViewContentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return label
    }()
    
    fileprivate lazy var moveInDateTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor.textColor
        textField.font = UIFont.mediumDefaultFont(ofSize: 14)
        textField.text = ""
        textField.landingViewContentSize = JCSize(width: .ratio(0.5), height: .auto)
        textField.textAlignment = .right
        textField.landingViewContentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
        return textField
    }()
    
    fileprivate lazy var nationalityLabel: UILabel = {
        let label = UILabel()
        label.text = "Nationality"
        label.textColor = UIColor.textColor
        label.font = UIFont.mediumDefaultFont(ofSize: 16)
        label.landingViewContentSize = JCSize(width: .auto, height: .value(50))
        label.landingViewContentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return label
    }()
    
    fileprivate lazy var nationalityEnteredLabel: UILabel = {
        let label = UILabel()
        label.text = "Singaporean"
        label.textColor = UIColor.textColor
        label.font = UIFont.mediumDefaultFont(ofSize: 14)
        label.landingViewContentSize = JCSize(width: .ratio(0.5), height: .auto)
        label.landingViewContentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(nationalityEnteredLabelDidTap(_:))))
        label.textAlignment = .right
        label.isUserInteractionEnabled = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    
    private func setupView() {
        edgesForExtendedLayout = []
        view.backgroundColor = UIColor.white
        [landingView].forEach{ view.addSubview($0) }
        landingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        landingView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        landingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        landingView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        [
            [firstHeaderView],
            [firstNameLabel, firstNameTextField],
            [lastNameLabel, lastNameTextField],
            [ageLabel, ageTextField],
            [genderLabel],
            [maleButton, femaleButton],
            [buyHeaderView],
            [buyLabel, buyToggle],
            [rentHeaderView],
            [rentLabel, rentToggle]
            ].forEach{ landingView.appendViews($0) }
    }
    
}

extension ViewController {
    @objc private func buyToggleChanged(_ switcher: UISwitch) {
        switch switcher.isOn {
        case true:
            landingView.appendViews([mainPurposeLabel, mainPurposeEnteredLabel], aboveView: rentHeaderView)
            landingView.appendView(immigrationStatusLabel, belowView: mainPurposeLabel)
            landingView.appendViews([citizenButton, PRButton], belowView: immigrationStatusLabel)
            landingView.appendViews([foreignerButton], belowView: citizenButton)
            landingView.appendViews([maximumBudgetLabel, maximumBudgetTextField], belowView: foreignerButton)
            landingView.appendViews([amenitiesLabel, amenitiesEnteredLabel, accessoryImageView], belowView: maximumBudgetLabel)
            landingView.appendViews([minimumSizeLabel, minumumSizeTextField], belowView: amenitiesLabel)
            landingView.appendViews([othersRequirementLabel], belowView: minimumSizeLabel)
            landingView.appendViews([otherRequirementTextView], belowView: othersRequirementLabel)
            landingView.appendView(firstNameIndicatorView, beforeView: firstNameLabel)
        case false:
            landingView.removeViews([citizenButton, PRButton, foreignerButton, immigrationStatusLabel, otherRequirementTextView, othersRequirementLabel, minumumSizeTextField, minimumSizeLabel, accessoryImageView, amenitiesEnteredLabel, amenitiesLabel, maximumBudgetTextField, maximumBudgetLabel, mainPurposeEnteredLabel, mainPurposeLabel])
        }
    }
    
    @objc private func rentToggleChanged(_ switcher: UISwitch) {
        switch switcher.isOn {
        case true:
            landingView.appendViews([moveInDateLabel, moveInDateTextField], belowView: rentLabel)
            landingView.appendViews([nationalityLabel, nationalityEnteredLabel], belowView: moveInDateLabel)
        case false:
            landingView.removeViews([nationalityEnteredLabel, nationalityLabel, moveInDateTextField, moveInDateLabel])
        }
        
    }
    
    @objc private func mainPurposeEnteredLabelDidTap(_ label: UILabel) {
        if landingView.contains(mainPurposePickerView) {
            landingView.removeView(mainPurposePickerView)
        } else {
            landingView.appendView(mainPurposePickerView, belowView: mainPurposeLabel)
        }
        
    }
    
    @objc private func amenitiesEnteredLabelDidTap(_ label: UILabel) {
    }
    
    
    @objc private func nationalityEnteredLabelDidTap(_ label: UILabel) {
    }
}


extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return mainPurpose.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return mainPurpose[row]
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            mainPurposeEnteredLabel.text = mainPurpose[row]
        default:
            return
        }
    }
    
}

