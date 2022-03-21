//
//  WeatherData.swift
//  Clima
//
//  Created by omer faruk bozbulut on 21.03.2022.
//

import Foundation

// Decodable -> kendisini harici bir temsilden çözebilen bir türe dönüştürebilir.
struct WeatherData : Decodable{
    let name : String
    let main : Main
    let weather : [Weather]
}

struct Main : Decodable{
    let temp: Double
}

struct Weather : Decodable{
    let id : Int
}

