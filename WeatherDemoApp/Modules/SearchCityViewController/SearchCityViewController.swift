//
//  SearchCityViewController.swift
//  WeatherDemoApp
//
//  Created by ahmed on 03/04/2024.
//

import UIKit

class SearchCityViewController: UIViewController {
    
    private var viewModel: SearchCityViewModel!
    private var gradientView: CAGradientLayer?

    init(viewModel: SearchCityViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradient()
        setupPageTitleLbl()
        
        addPageTitleLabelConstaints()
        addSearchStackConstaints()
        addSearchBarConstaints()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // to activate gradient
        gradientView?.frame = view.bounds
    }
    
    // MARK: View Configurators
    private func addGradient() {
        let pageGradient = Colors.pageGradient
        
        gradientView = view.setGradient(colors: pageGradient.colors,
                                        locations: pageGradient.locations,
                                        startPoint: pageGradient.startPoint,
                                        endPoint: pageGradient.endPoint)
    }
    
    private func setupPageTitleLbl() {
        pageTitleLbl.setTitle("Enter city, postcode or airoport location")
        pageTitleLbl.changeFont(AppFonts.regular.size(13))
        pageTitleLbl.changeTextColor(.label)
    }
    
    // MARK: Subviews
    private lazy var pageTitleLbl = ReusableBoldLabel()
    private lazy var searchStack = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false

        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    private lazy var cancelBtn = {
        let button = UIButton(type: .system)
        button.setTitle("Cancel", for: .normal)
        button.tintColor = Colors.cancelBtnTint
        return button
    }()

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
//        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = " Search..."
        searchBar.backgroundImage = UIImage()
        return searchBar
        
    }()
}


// MARK: Constraints

extension SearchCityViewController {
    private func addPageTitleLabelConstaints() {
        
        view.addSubview(pageTitleLbl)
        NSLayoutConstraint.activate([
            pageTitleLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            pageTitleLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
    }
    
    private func addSearchStackConstaints() {
        
        view.addSubview(searchStack)
        NSLayoutConstraint.activate([
            searchStack.topAnchor.constraint(equalTo: pageTitleLbl.bottomAnchor, constant: 20),
            searchStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)

        ])
        
    }
    
    private func addSearchBarConstaints() {
        searchStack.addArrangedSubview(searchBar)
        searchStack.addArrangedSubview(cancelBtn)
        
        NSLayoutConstraint.activate([
            searchBar.heightAnchor.constraint(equalToConstant: 36)
        ])
        
    }
}
