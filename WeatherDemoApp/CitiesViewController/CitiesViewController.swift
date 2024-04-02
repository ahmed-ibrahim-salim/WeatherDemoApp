//
//  ViewController.swift
//  WeatherDemoApp
//
//  Created by ahmed on 01/04/2024.
//

import UIKit

typealias VoidCallback = (() -> Void)

class CitiesViewModel: BaseViewModel {
    
}

class CitiesViewController: UITableViewController {
    
    private var viewModel: CitiesViewModel!

    init(viewModel: CitiesViewModel) {
        super.init(style: .plain)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)

        addPageTitleLabelConstaints()
        addBtnViewConstaints()
    }
    
    // MARK: SubViews
    private lazy var addBtnView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "2388C7")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
//        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 8)
        view.layer.shadowRadius = 10
        return view
    }()
    
    // MARK: Page Title
    private lazy var pageTitleLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cities"
        label.font = AppFonts.bold.size(20)
        label.numberOfLines = 0
        label.textAlignment = .center
  
        return label
    }()
    

}

// MARK: Constaints
extension CitiesViewController {
    
    private func addBtnViewConstaints() {
        
        view.addSubview(addBtnView)
        NSLayoutConstraint.activate(
            [
                addBtnView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
                addBtnView.trailingAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                    constant: 15
                ),
                addBtnView.heightAnchor.constraint(equalToConstant: 53),
                addBtnView.widthAnchor.constraint(equalToConstant: 110)
                
            ]
        )
    }
    
    private func addPageTitleLabelConstaints() {
        
        view.addSubview(pageTitleLbl)
        NSLayoutConstraint.activate([
            pageTitleLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            pageTitleLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
    }
}
