//
//  WeatherInfoDetailVC.swift
//  WeatherDemoApp
//
//  Created by ahmed on 05/04/2024.
//

import UIKit

class WeatherInfoDetailVC: UIViewController {
    
    let cityWeatherInfo: FormattedCityWeatherModel
    
    private var gradientView: CAGradientLayer?
    
    init(cityWeatherInfo: FormattedCityWeatherModel) {
        self.cityWeatherInfo = cityWeatherInfo
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradient()
        addBottomImageConstaints()
        addPageTitleLabelConstaints()
        addBtnViewConstaints()
        addbottomTimeLblConstaints()
        
        setupBottomTimeLbl()
        setupPageTitleLbl()
        setupLeftBtn()
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
    
    private func setupLeftBtn() {
        leftBtn.setCornerRadius(14)
        
        /// Action
        let addBtnAction: VoidCallback = { [unowned self] in
            dismiss(animated: true)
        }
        
        let model = ReusableBtnModel(btnTappedAction: addBtnAction,
                                     btnImage: UIImage(systemName: "arrow.left"))
        leftBtn.configureBtnWith(model)
    }
    
    private func setupBottomTimeLbl() {
        let timeText = "Weather information for London received on \n \(cityWeatherInfo.getDateTimeFormatted())"
        bottomTimeLbl.setTitle(timeText)
        bottomTimeLbl.changeFont(AppFonts.regular.size(12))
    }
    private func setupPageTitleLbl() {
        pageTitleLbl.setTitle(cityWeatherInfo.cityName)
    }
    
    // MARK: SubViews
    private lazy var pageTitleLbl = ReusableBoldLabel()
    private lazy var bottomTimeLbl = ReusableBoldLabel()
    private lazy var leftBtn = ReusableButton()
    private lazy var bottomImage = ReusableBottomImage(
        frame: CGRect(
            x: 0,
            y: 0,
            width: 0,
            height: 0
        )
    )
}

// MARK: Constraints

extension WeatherInfoDetailVC {
    
    private func addBtnViewConstaints() {
        
        view.addSubview(leftBtn)
        NSLayoutConstraint.activate(
            [
                leftBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: -10),
                leftBtn.leadingAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                    constant: -10
                ),
                leftBtn.heightAnchor.constraint(equalToConstant: 60),
                leftBtn.widthAnchor.constraint(equalToConstant: 80)
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
    
    private func addbottomTimeLblConstaints() {
        
        view.addSubview(bottomTimeLbl)
        NSLayoutConstraint.activate([
            bottomTimeLbl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            bottomTimeLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
    }
    
    private func addBottomImageConstaints() {
        
        view.addSubview(bottomImage)
        NSLayoutConstraint.activate([
            bottomImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomImage.heightAnchor.constraint(equalToConstant: 200)
            
        ])
    }
}
