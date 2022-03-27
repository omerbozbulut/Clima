//
//  ViewController.swift
//  Clima
//
//  Created by omer faruk bozbulut on 16.03.2022.
//

import UIKit
import CoreLocation

// UITextFieldDelegate metnin düzenlenmesi ve doğrulanmasını yönetmemizi sağlar.
class WeatherViewController: UIViewController {
    

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        // TextField'dan düzenlemeyle ilgili mesajlara yanıt verir. Kullanıcı tarafından girilen metne ve kullanıcının return'e dokunması gibi bazı özel komutlara yanıt vermek için delegate kullanılır
        searchTextField.delegate = self
        weatherManager.delegate = self
        
        
        //conditionImageView.image = conditionName
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        // klavyeyi kapatır
        searchTextField.endEditing(true)
        
    }
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    
    
}


//MARK: - CLLocationManagerDelegate

extension WeatherViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}




//MARK: - UITextFieldDelegate



extension WeatherViewController : UITextFieldDelegate{
    // Metin alanı, kullanıcı return düğmesine dokunduğunda bu yöntemi çağırır.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        
        
        // burada true dersem üstte yazdıklarımı uygular. false dersem uygulamaz.
        return true
    }
    
    // Delegate'e belirtilen metin alanında düzenlemeyi durdurup durdurmayacağını sorar.
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // Burada textField kullanmamızın sebebi birden fazla textFieldımızın olma olasılığıdır.
        // Eğer searchTextField kullansaydık sadece o textField için çalışırdı.
        if textField.text != "" {
            return true  // endEditing işlemini yap.
        }else{
            textField.placeholder = "Type something"
            return false // endEditing işlemini yapma. Yapamadığı için bu durumda klavye kapatılmaz.
        }
        
        
    }
    
    
    // kullanıcı düzenlemeyi durdurduğunda çalıştırılır.
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchTextField.text{
            weatherManager.fetchWeather(cityName: city)
        }
        
        
        searchTextField.text = ""
    }
}


//MARK: - WeatherManagerDelegate


extension WeatherViewController : WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel){
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.cityName
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
    }
    
    func didFailWithError(_ error : Error){
        
    }
}
