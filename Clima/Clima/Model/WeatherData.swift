//
//  WeatherData.swift
//  Clima
//
//  Created by omer faruk bozbulut on 21.03.2022.
//

import Foundation

// Decodable -> kendisini harici bir temsilden çözebilen bir türe dönüştürebilir.
// Codable -> Decodable + Decodable birleşimi bir protokol
struct WeatherData : Codable{
    let name : String
    let main : Main
    let weather : [Weather]
}

struct Main : Codable{
    let temp: Double
}

struct Weather : Codable{
    let id : Int
}

