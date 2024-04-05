//
//  ViewController.swift
//  WeatherDemoApp
//
//  Created by ahmed on 01/04/2024.
//

import UIKit
import Combine

final class CitiesViewController: UITableViewController {
    
    private let viewModel: CitiesViewModel!
    private var gradientView: CAGradientLayer?
    private var disposables = Set<AnyCancellable>()

    init(viewModel: CitiesViewModel) {
        self.viewModel = viewModel
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
//        view.backgroundColor = UIColor(hex: "D6D3DE")
        
        setupRightBtn()
        setupPageTitleLbl()
        addGradient()
        
        addPageTitleLabelConstaints()
        addBtnViewConstaints()
        addBottomImageConstaints()
        
        setupTableView()
        
        assignViewModelClosures()
        
        /// watch RealmDB on Simulator
        /// print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path())
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // to activate gradient
        gradientView?.frame = view.bounds
    }
    
    // MARK: View Configurators
    private func setupTableView() {
        tableView.rowHeight = 60
        tableView.register(
            CityTableCell.self,
            forCellReuseIdentifier: CityTableCell.identifier
        )
        tableView.bounces = false
    }
    private func addGradient() {
        let pageGradient = Colors.pageGradient
        
        gradientView = view.setGradient(colors: pageGradient.colors,
                                        locations: pageGradient.locations,
                                        startPoint: pageGradient.startPoint,
                                        endPoint: pageGradient.endPoint)
    }
    
    private func setupPageTitleLbl() {
        pageTitleLbl.setTitle("Cities")
    }
    
    // MARK: Navigation Methods
    private func presentWeatherDetailScreen(_ cityWeatherInfo: CityRealmObject) {
        let detailVC = CityWeatherEntriesVC(cityWeatherInfo: cityWeatherInfo)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    private func setupRightBtn() {
        /// Action
        let addBtnAction: VoidCallback = { [unowned self] in
            
            let viewModel = SearchCityViewModel(weatherFetcher: WeatherFetcher(),
                                                localStorageHelper: LocalStorageHelper.getInstance())

            let didSelectCityCompletion: ((CityRealmObject) -> Void) = { [unowned self] cityWeatherInfo in
                
                /// selected city ? dismiss search screen then present weather details screen
                dismiss(animated: true)
                
                presentWeatherDetailScreen(cityWeatherInfo)
                
            }
            
            /// present search screen
            let viewC = SearchCityViewController(viewModel: viewModel,
                                                 openCityWeatherInfo: didSelectCityCompletion)
            present(viewC, animated: true, completion: nil)
        }
        
        let model = ReusableBtnModel(btnTappedAction: addBtnAction,
                                     btnImage: UIImage(systemName: "plus"))
        rightBtn.configureBtnWith(model)
    }
    
    // MARK: SubViews
    private lazy var rightBtn = ReusableButton()
    private lazy var pageTitleLbl = ReusableBoldLabel()
    private lazy var bottomImage = ReusableBottomImage(
        frame: CGRect(
            x: 0,
            y: 0,
            width: 0,
            height: 0
        )
    )
}


// MARK: Constaints
extension CitiesViewController {
    
    private func addBtnViewConstaints() {
        
        view.addSubview(rightBtn)
        NSLayoutConstraint.activate(
            [
                rightBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
                rightBtn.trailingAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                    constant: 20
                ),
                rightBtn.heightAnchor.constraint(equalToConstant: 53),
                rightBtn.widthAnchor.constraint(equalToConstant: 90)
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
    
    private func addBottomImageConstaints() {
        
        view.addSubview(bottomImage)
        NSLayoutConstraint.activate([
            bottomImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomImage.heightAnchor.constraint(equalToConstant: 200)
            
        ])
    }
}

// MARK: AssignViewModelClosures
extension CitiesViewController {
    func assignViewModelClosures() {
        viewModel.reloadTableView = { [unowned self] in
            tableView.reloadData()
        }
        
        /// listeners
        viewModel.error.sink { [unowned self] error in
            showAlert(error.message)
        }
        .store(in: &disposables)
    }
}

// MARK: Table
extension CitiesViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getCitiesCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableCell.identifier, for: indexPath) as? CityTableCell else {
            return UITableViewCell()
        }
        
        cell.pageTitleLbl.text = viewModel.getCityNameFor(indexPath)

        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let cityWeatherInfo = viewModel.getCityFor(indexPath)
        presentWeatherDetailScreen(cityWeatherInfo)
    }
    
    // to make spacing on top of each section
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 0,
                height: 100
            )
        )
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

}
