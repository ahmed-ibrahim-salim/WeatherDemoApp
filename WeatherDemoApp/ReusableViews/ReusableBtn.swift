//
//  ReusableBtn.swift
//  WeatherDemoApp
//
//  Created by ahmed on 03/04/2024.
//

import UIKit

class ReusableButton: UIButton {
    
    var btnTappedAction: VoidCallback?
    var btnImage: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        backgroundColor = Colors.mainBtnBackgroundColor
        tintColor = Colors.mainBtnTintColor
        
        setImage(UIImage(systemName: "plus"), for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 8)
        layer.shadowRadius = 20
        addTarget(
            self,
            action: #selector(btnPressed),
            for: .touchUpInside
        )
        
    }
    
    @objc
    private func btnPressed() {
        btnTappedAction?()
    }
    
    func configureBtnWith(_ model: ReusableBtnModel) {
        btnImage = model.btnImage
        btnTappedAction = model.btnTappedAction
    }
}

// MARK: Model
struct ReusableBtnModel {
    var btnTappedAction: VoidCallback
    var btnImage: UIImage?
}
