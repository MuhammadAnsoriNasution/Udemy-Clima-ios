//
//  WeatherManager.swift
//  Clima
//
//  Created by Andrew Indayang on 21/03/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation
protocol WeatherManagerDelegate{
    func didUpdateWeather(weather: WeatherModel)
    func didFailWithError(error: Error)
}
struct WeatherManager{
    let weatherURL="https://api.openweathermap.org/data/2.5/weather?appid=bb76185af6e708786b6418062922a29d&units=metric"
    var delegate:WeatherManagerDelegate?
    func fetchWeather(cityName:String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }

    func fetchWeather(langitude:CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(langitude)&lon=\(longitude)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString:String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            
            //            let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
            let task = session.dataTask(with: url) {data, response, error in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let SafeData = data{
                    if let weather = self.parseJson(SafeData){
//                        With Call controller
//                       let weatherVC = WeatherViewController()
//                        weatherVC.didUpdateWeather(weather: weather)
                        
//                        with delegate update data controller
                        self.delegate?.didUpdateWeather(weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
//    external dan internal parameter, jika underscore berarti tidak ada penamaan pada pemanggilan parameter
    func parseJson(_ weatherData:Data) -> WeatherModel?{
        
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData )
            let id = decodeData.weather[0].id
            let temp = decodeData.main.temp
            let name = decodeData.name

            let weather = WeatherModel(conditionId: id, cityName: name, temprature: temp)
            return weather
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    

    func handle(data:Data?, response: URLResponse?, error: Error?){
        if error != nil{
            print(error!)
            return
        }
        if let SafeData = data{
            let dataString = String(data:SafeData, encoding: .utf8)
            //            print(dataString)
        }
    }
}
