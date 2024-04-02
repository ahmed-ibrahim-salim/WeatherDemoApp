//
//  ReusableLabel.swift
//  WeatherDemoApp
//
//  Created by ahmed on 03/04/2024.
//

import UIKit

class ReusableBoldLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false
        font = AppFonts.bold.size(20)
        textColor = Colors.labelColor
        numberOfLines = 0
        textAlignment = .center
    }
    
    func changeAlignment(_ alignment: NSTextAlignment) {
        textAlignment = alignment
    }
    
    func setTitle(_ title: String) {
        text = title
    }
}
