//
//  CityTableCell.swift
//  WeatherDemoApp
//
//  Created by ahmed on 04/04/2024.
//

import UIKit

class CityTableCell: UITableViewCell {
    
    var pageTitleLbl = ReusableBoldLabel()
    static let identifier = "CityTableCell"
    
    // MARK: initialiser
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setViewSpecs()
        setConstaints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Set view props
    private func setViewSpecs() {
        pageTitleLbl.setAlignment(.natural)
        accessoryType = .disclosureIndicator
        accessoryView = UIImageView(
            image: UIImage(systemName: "chevron.right")
        )
        tintColor = Colors.mainBtnBackgroundColor
        backgroundColor = .clear
        selectionStyle = .none
    }
    
    private func setConstaints() {
        contentView.addSubview(pageTitleLbl)
        
        NSLayoutConstraint.activate([
            pageTitleLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            pageTitleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            pageTitleLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
}
