//
//  WeatherManager.swift
//  Clima
//
//  Created by omer faruk bozbulut on 19.03.2022.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&appid=0c2db400fb4930f433cc5d26163c5542&units=metric"
    
    // app transport security policy requires the use of a secure connection.
    // Hatası alırsak http -> https yapmamız yeterli
    
    func fetchWeather(cityName : String){
        let URLString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: URLString)
    }
    
    func performRequest(urlString:String){
        // 1. Create a URL
        if let url = URL(string: urlString){
            
            // 2. Create a URLSession
            let urlSession = URLSession(configuration: .default)
            
            
            // 3. Give the session a task
            let task = urlSession.dataTask(with: url, completionHandler: handle(data:response:error:))// Belirtilen URL'nin içeriğini alan ve ardından bir işleyiciyi veya yöntemi çağıran bir görev oluşturur.
            
            
            
            // 4. Start the task
            task.resume() // Task'lar yaratıldığında askıya alınmış bir şekilde oluşur. Resumes the task, if it is suspended. ->  Askıya alınmışsa görevi sürdürür.
        }
        
    }
    
    func handle(data : Data? , response : URLResponse? , error : Error?){
        if error != nil {
            print(error!)
            return
        }
        
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8)
            print(dataString)
        }
    }
}
