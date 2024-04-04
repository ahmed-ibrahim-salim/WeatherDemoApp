//
//  SearchCityViewController.swift
//  WeatherDemoApp
//
//  Created by ahmed on 03/04/2024.
//

import UIKit
import Combine

//MARK: Use cases
/// 1- new city, click search to call api, save result to realm, then dismiss and refresh home to get from realm
/// 2- old city, show results, choose one, push weather history screen


class SearchCityViewController: UIViewController {
    
    private var viewModel: SearchCityViewModel!
    private var gradientView: CAGradientLayer?
    var disposables = Set<AnyCancellable>()

    init(viewModel: SearchCityViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradient()
        setupPageTitleLbl()
        addCancelAction()
        
        
        addPageTitleLabelConstaints()
        addSearchStackConstaints()
        addSearchBarConstaints()
        addSearchResultsTableConstaints()
        
        
        assignViewModelClosures()
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
    
    // MARK: Actions
    private func addCancelAction() {
        let action = UIAction { [unowned self] _ in
            self.dismiss(animated: true)
        }
        cancelBtn.addAction(action, for: .touchUpInside)
    }
    
    // MARK: startSendingText
    @objc
    func startSendingText() {
        guard let searchText = searchBar.text, 
            !searchText.isEmpty else {return}
        self.viewModel.fetchWeatherInfo(searchText)
        
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
        searchBar.placeholder = " Search..."
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        return searchBar
        
    }()
    
    private lazy var searchResultsTable: UITableView! = {
        let myTableView = UITableView()
        myTableView.backgroundColor = .clear
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.rowHeight = 60
        myTableView.register(
            CityTableCell.self,
            forCellReuseIdentifier: CityTableCell.identifier
        )
       
        return myTableView
    }()
    
}

// MARK: assignVMClosures
extension SearchCityViewController {
    
    func assignViewModelClosures() {
        
        /// listeners
        viewModel.city.sink { value in
            print(value)
        }
        .store(in: &disposables)
        
        viewModel.error.sink { [unowned self] error in
            showAlert(error.message)
        }
        .store(in: &disposables)
        

        /// indicators
        viewModel.showIndicator = { [unowned self] in
            showProgress()
        }
        viewModel.hideIndicator = { [unowned self] in
            hideProgress()
        }
    }
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
    
    private func addSearchResultsTableConstaints() {
        view.addSubview(searchResultsTable)

        NSLayoutConstraint.activate([
            searchResultsTable.topAnchor.constraint(equalTo: searchStack.bottomAnchor, constant: 20),
            searchResultsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            searchResultsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchResultsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
        
    }

}

// MARK: Search Results Table
extension SearchCityViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableCell.identifier, for: indexPath) as? CityTableCell else {
            return UITableViewCell()
        }
        
        cell.pageTitleLbl.text = "London"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
