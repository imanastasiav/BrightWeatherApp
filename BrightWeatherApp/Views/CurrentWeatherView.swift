//
//  CurrentWeatherView.swift
//  BrightWeatherApp
//
//  Created by Анастасия on 03.06.2025.
//

import UIKit

class CurrentWeatherView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
