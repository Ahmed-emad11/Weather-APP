//
//  ViewController.swift
//  WeatherAPP
//
//  Created by Ahmed Emad on 11/07/2024.
//

import UIKit
import Alamofire

class MainVC: UIViewController {
    
    @IBOutlet weak var tempLable: UILabel!
    @IBOutlet weak var pressureLable: UILabel!
    @IBOutlet weak var humidityLable: UILabel!
    @IBOutlet weak var cityNameLable: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    var cityId = "108410"
    
    /*
     this is id for city
     Reyaid =>108410
     Damam => 110336
     Jeddah => 105343
     Apha => 110690
     */
    

    func getCityWeatherInfo(){
        
        let url = "https://api.openweathermap.org/data/2.5/weather"
        let parameters = [ "id": cityId ,
                           "appid": "9158b4ed62180ba6cf29ccf6ac6e2440" ]
        loader.isHidden = false
        loader.startAnimating()
        
        Alamofire.request(url , parameters: parameters,
                          encoding: URLEncoding.default).responseJSON { response in
            if let result = response.value {
                let JSONDictionary = result as! NSDictionary
                let main = JSONDictionary["main"] as! NSDictionary
                var temp = main["temp"] as! Double
                var pressure = main["pressure"] as! Double
                var humidity = main["humidity"] as! Double

                
            
                
                print(temp)
                temp = temp - 272.15
                temp = Double((round(Double(1000 * temp)) / 1000))
                
                self.loader.stopAnimating()
                
                self.tempLable.text = "\(temp)°"
                self.pressureLable.text = "\(pressure)"
                self.humidityLable.text = "\(humidity)"

                
                
                
            }
        }
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editButton.layer.cornerRadius = 18
        
        NotificationCenter.default.addObserver(self, selector: #selector(cityChanged), name: NSNotification.Name("cityValueChanged"), object: nil)
        
        // this fun we use in it API
        getCityWeatherInfo()
        
        
    }
    
   
    
    
@objc func cityChanged(notification: Notification){
        if let city = notification.userInfo?["city"] as? City{
            cityNameLable.text = city.name
            cityId = city.id
            // call this fun
            getCityWeatherInfo()
          
            
            
        }
        
    }
}
