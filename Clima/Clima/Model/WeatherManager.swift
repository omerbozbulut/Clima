//
//  WeatherManager.swift
//  Clima
//
//  Created by omer faruk bozbulut on 19.03.2022.
//

import Foundation
import UIKit
import CoreLocation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(_ error : Error)
}



struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=0c2db400fb4930f433cc5d26163c5542&units=metric"
    // app transport security policy requires the use of a secure connection.
    // Hatası alırsak http -> https yapmamız yeterli
    
    var delegate : WeatherManagerDelegate?
    
    func fetchWeather(cityName : String){
        let URLString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: URLString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude : CLLocationDegrees){
        let URLString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: URLString)
    }
    
    func performRequest(with urlString:String){
        // 1. Create a URL
        if let url = URL(string: urlString){
            
            // 2. Create a URLSession
            let urlSession = URLSession(configuration: .default)
            
            
            // 3. Give the session a task
            let task = urlSession.dataTask(with: url) { (data, responce, error) in
                if error != nil {
                    delegate?.didFailWithError(error!) // İnternet bağlantısı kesilmesi durumlarda error alabilirz
                    return
                }
                 
                if let safeData = data {
                    if let weather = parseJSON(safeData){
                        delegate?.didUpdateWeather(self,weather: weather)
                    }
                }
            }
            
            
            // 4. Start the task
            task.resume() // Task'lar yaratıldığında askıya alınmış bir şekilde oluşur. Resumes the task, if it is suspended. ->  Askıya alınmışsa görevi sürdürür.
        }
        
    }
    
    func parseJSON(_ weatherData : Data)->WeatherModel? //isteğe bağlı return
    {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let cityName = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(conditionId: id, cityName: cityName, temperature: temp)
            
            return weather
        } catch{
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
    
    
     
}
