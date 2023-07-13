//
//  CustomTextPicker.swift
//  InnovaCaseStudy
//
//  Created by Mert Çetin on 13.07.2023.
//

import Foundation
import UIKit

class CustomTextPicker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    public var pickerData = ["EUR","USD","AUD","CAD"]

    public var completion: ((String) -> Void)?
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }

    private func setup() {
        self.delegate = self
        self.dataSource = self
        self.tintColor = .clear
    }

    // UIPickerViewDataSource methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerData.count
    }

    // UIPickerViewDelegate methods
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(self.pickerData[row])"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        completion?(self.pickerData[row])
    }
}
