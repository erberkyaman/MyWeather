//
//  WeatherTableViewCell.swift
//  MyWeather
//
//  Created by Erberk Yaman on 15.10.2023.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var highTempLabel: UILabel!
    @IBOutlet var lowTempLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    static let identifier = "WeatherTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "WeatherTableViewCell", bundle: nil)
    }
    
    func configure(with model: CurrentConditions) {
        self.highTempLabel.textAlignment = .center
        self.lowTempLabel.textAlignment = .center
        self.lowTempLabel.text = "\(Int(convertFahrenheitToCelsius(fahrenheit: Double(model.tempmin ?? 0.0))))°"
        self.highTempLabel.text = "\(Int(convertFahrenheitToCelsius(fahrenheit: Double(model.tempmax ?? 0.0))))°"
        self.dayLabel.text = getDayForDate(Date(timeIntervalSince1970: Double(model.datetimeEpoch ?? 0)))
        
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
    
    func getDayForDate(_ date: Date?) -> String {
        guard let inputDate = date else {
            return ""
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: inputDate)
    }
    
    func convertFahrenheitToCelsius(fahrenheit: Double) -> Double {
        return (fahrenheit - 32) * 5/9
    }
}
