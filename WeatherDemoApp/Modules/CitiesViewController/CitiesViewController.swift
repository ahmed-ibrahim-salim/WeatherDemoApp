//
//  ViewController.swift
//  WeatherDemoApp
//
//  Created by ahmed on 01/04/2024.
//

import UIKit

class CitiesViewController: UITableViewController {
    
    private var viewModel: CitiesViewModel!
    private var gradientView: CAGradientLayer?
    
    init(viewModel: CitiesViewModel) {
        super.init(style: .insetGrouped)
        self.viewModel = viewModel
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
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path())
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // to activate gradient
        gradientView?.frame = view.bounds
    }
    
    // MARK: View Configurators
    private func setupTableView() {
        tableView.rowHeight = 60
//        tableView.estimatedRowHeight = 44
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
    
    private func setupRightBtn() {
        let callback: VoidCallback = { [unowned self] in
            let viewModel = SearchCityViewModel(weatherFetcher: WeatherFetcher(),
                                                localStorageHelper: LocalStorageHelper.getInstance())
            let viewC = SearchCityViewController(viewModel: viewModel)
            present(viewC, animated: true, completion: nil)
        }
        
        let model = ReusableBtnModel(btnTappedAction: callback,
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

// MARK: Table
extension CitiesViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableCell.identifier, for: indexPath) as? CityTableCell else {
            return UITableViewCell()
        }
        
        cell.pageTitleLbl.text = "London"

        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {

    }
    
    // to make spacing on top of each section
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: 0,
                height: 50
            )
        )
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }

}
