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
    private var gradientView: CAGradientLayer?

    init(viewModel: CitiesViewModel) {
        super.init(style: .plain)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = UIColor(hex: "D6D3DE")
        
        setupRightBtn()
        setupPageTitleLbl()
        addGradient()
        
        addPageTitleLabelConstaints()
        addBtnViewConstaints()
        addBottomImageConstaints()
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
        pageTitleLbl.setTitle("Cities")
    }
    
    private func setupRightBtn() {
        let callback: VoidCallback = { print("callback from controller") }
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
                rightBtn.widthAnchor.constraint(equalToConstant: 110)
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
