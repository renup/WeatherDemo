//
//  ViewController.swift
//  WeatherApp
//
//  Created by renupunjabi on 5/19/23.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createWeatherView()
    }
    
    func createWeatherView() {
       let weatherList = WeatherList()
        let hostingVC = UIHostingController(rootView: weatherList)
        addChild(hostingVC)
        view.addSubview(hostingVC.view)
        hostingVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hostingVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingVC.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            hostingVC.view.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        hostingVC.didMove(toParent: self)
    }


}

