//
//  Colors.swift
//  WeatherDemoApp
//
//  Created by ahmed on 03/04/2024.
//

import UIKit

struct Colors {
    
    static private var currentTheme: UIUserInterfaceStyle {
        UITraitCollection.current.userInterfaceStyle
    }
    
    static var mainBtnBackgroundColor: UIColor? = {
        currentTheme == .light ? UIColor(hex: "2388C7") : UIColor(hex: "C53249")
    }()
    
    static var mainBtnTintColor: UIColor? = {
        currentTheme == .light ? UIColor.white : UIColor(hex: "252526")
    }()
    
    static var labelColor: UIColor? = {
        currentTheme == .light ? UIColor(hex: "3D4548") : UIColor(hex: "797F88")
    }()
    
    static var pageGradient = {
        return GradientItem(
            colors: [
                UIColor.white.cgColor,
                UIColor(hex: "D6D3DE")?.cgColor]
                .compactMap {
                    $0
                },
            locations: [0, 1, 1],
            startPoint: CAGradientPoint.topCenter.point,
            endPoint: CAGradientPoint.bottomCenter.point
        )
    }()
}
