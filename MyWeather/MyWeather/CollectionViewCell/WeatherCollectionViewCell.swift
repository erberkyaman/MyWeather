//
//  WeatherCollectionViewCell.swift
//  MyWeather
//
//  Created by Erberk Yaman on 19.10.2023.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "WeatherCollectionViewCell"
    
    @IBOutlet var iconImageView: UIImageView!
    @IBOutlet var tempLabel: UILabel!
    
    func configure(with model: HourlyConditions) {
        guard let hoursTemp = model.temp else {
            return
        }
    
        self.tempLabel.text = "\(hoursTemp)"
        self.iconImageView.contentMode = .scaleAspectFit
        let icon = model.icon?.rawValue.lowercased()
        if ((icon?.contains("clear")) != nil) {
            self.iconImageView.image = UIImage(named: "sunny")
        }
        else if ((icon?.contains("rain")) != nil) {
            self.iconImageView.image = UIImage(named: "rainy")
        }
        else if ((icon?.contains("cloudy")) != nil) {
            self.iconImageView.image = UIImage(named: "cloudy")
        }
        else {
            self.iconImageView.image = UIImage(named: "snowy")
        }
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherCollectionViewCell", bundle: nil)
    }


}
