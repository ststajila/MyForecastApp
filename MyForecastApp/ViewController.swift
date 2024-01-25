//
//  ViewController.swift
//  MyForecastApp
//
//  Created by STANISLAV STAJILA on 1/25/24.
//

struct Info: Codable{
    var feels_like: String
    var grnd_level: Int
    var humidity: Int
    var pressure: Int
    var sea_level: Int
    var temp: Double
    var temp_kf: Double
    var temp_max: Double
    var temp_min: Double
}

struct oneDayForcast: Codable{
    var dt: String
    var dt_txt: String
    var main: [Info]
}

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var locationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        forecast()
    }
    
    func forecast(){
        let session = URLSession.shared
        let weatherURL = URL(string: "http://api.openweathermap.org/data/2.5/forecast?lat=42.243420&lon=-88.316978&units=imperial&appid=1942debaa31f5e108a4255b2488e7584")
        let dataTask = session.dataTask(with: weatherURL!){
            (data: Data?, response: URLResponse?, error: Error?) in
            if let e = error{
                print("Error: \(e)")
            } else{
                if let d = data{
                    if let jsonObj = try? JSONSerialization.jsonObject(with: d, options: .allowFragments) as? NSDictionary{
                        print(jsonObj)
                        
                        if let list = try? JSONDecoder.decode(<#T##self: JSONDecoder##JSONDecoder#>)
                            
                        }
                    }
                }
            }
        
        dataTask.resume()
    }


}

