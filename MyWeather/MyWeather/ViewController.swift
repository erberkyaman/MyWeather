//
//  ViewController.swift
//  MyWeather
//
//  Created by Erberk Yaman on 15.10.2023.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var tableView: UITableView!
    
    var models = [CurrentConditions]()
    var hourlyModels = [HourlyConditions]()
    
    let locationManager = CLLocationManager()
    var current: CurrentConditions?
    var currentLocation: CLLocation?
    
    var asa = "123123123"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Register 2 cells
        tableView.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        tableView.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
//        UserDefaults.standard.set("Ekrem", forKey: "name")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
    }
    //Location
    
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
    
    func requestWeatherForLocation() {
        guard let currentLocation = currentLocation else {
            return
        }
        let long = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude
        
        let url = "https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/\(lat),\(long)?key=489ACHTRD3P9T27B9R63GGDN9"
        print(url)
        
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            //Validation
            guard let data = data, error == nil else {
                print("Something went wrong!")
                return
            }
            //Convert data to models/some object
            
            var json: WeatherResponse?
            do {
                json = try JSONDecoder().decode(WeatherResponse.self, from: data)
                print(json?.days.first?.hours)
            }
            catch {
                print("error: \(error)")
            }
            
            guard let result = json else {
                return
            }
            
            
            self.models.append(contentsOf: result.days)
            self.current = result.currentConditions
            self.hourlyModels = result.days.first?.hours ?? []
            
            //Update user interface
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.tableHeaderView = self.createTableHeader()
            }
            
        }.resume()
    }
    
    func createTableHeader() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 300))
        let locationLabel = UILabel(frame: CGRect(x: 10, y: 10, width: view.frame.size.width - 20, height: headerView.frame.size.height / 5))
        let summaryLabel = UILabel(frame: CGRect(x: 10, y: 20+locationLabel.frame.size.height, width: view.frame.size.width - 20, height: headerView.frame.size.height / 5))
        let tempLabel = UILabel(frame: CGRect(x: 10, y: 20 + locationLabel.frame.size.height + summaryLabel.frame.size.height, width: view.frame.size.width - 20, height: headerView.frame.size.height / 2))
        
        headerView.addSubview(locationLabel)
        headerView.addSubview(tempLabel)
        headerView.addSubview(summaryLabel)
        
        tempLabel.textAlignment = .center
        locationLabel.textAlignment = .center
        summaryLabel.textAlignment = .center
        
        guard let currentWeather = self.current else {
            return UIView()
        }
        
        tempLabel.text = currentWeather.temp?.fahrenheitToCelsius.firstThreeDigits
        tempLabel.font = UIFont(name: "Helvetica-Bold", size: 32)
        locationLabel.text = "Current Location"
        summaryLabel.text = self.current?.conditions?.rawValue
        
        return headerView
    }
    

    

}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    //Table
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            // 1 cell that is collectiontableviewcell
//            return 2
//        }
//        return models.count
        
        switch section {
        case 0:
            return 1
        case 1:
            return models.count
        default:
            return 0
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: HourlyTableViewCell.identifier, for: indexPath) as! HourlyTableViewCell
            cell.backgroundColor = .red
            cell.configure(with: hourlyModels)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
            cell.configure(with: models[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
}



