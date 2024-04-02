//
//  ReusableBottomImage.swift
//  WeatherDemoApp
//
//  Created by ahmed on 03/04/2024.
//

import UIKit

class ReusableBottomImage: UIImageView {
    
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
        let currentTheme = UITraitCollection.current.userInterfaceStyle
        image = currentTheme == .light ? UIImage(named: "Background_light") : UIImage(named: "Background_Dark")
    }
    
    
}