//
//  WeatherModle.swift
//  Clima
//
//  Created by Andrew Indayang on 24/03/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
struct WeatherModel{
    let conditionId:Int
    let cityName: String
    let temprature:Double
 
    var tempratureString: String{
        return String(format: "%.1f", temprature)
    }
    
    
    var conditionName : String{
        switch conditionId{
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
//    func getCOnditionName(weatherId: Int) -> String{
//        switch weatherId{
//        case 200...232:
//            return "cloud.bolt"
//        case 300...321:
//            return "cloud.drizzle"
//        case 500...531:
//            return "cloud.rain"
//        case 600...622:
//            return "cloud.snow"
//        case 701...781:
//            return "cloud.fog"
//        case 800:
//            return "sun.max"
//        case 801...804:
//            return "cloud.bolt"
//        default:
//            return "cloud"
//        }
//
//    }
    
}
