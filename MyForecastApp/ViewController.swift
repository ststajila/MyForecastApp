//
//  ViewController.swift
//  MyForecastApp
//
//  Created by STANISLAV STAJILA on 1/25/24.
//

struct OneDayForcast: Codable{
   // var city: [CityInfo]
    var list: [Info]
}

struct CityInfo: Codable{
    var country: String
    var name: String
    var sunrise: Int
    var sunset: Int
}

struct Info: Codable{
    var dt: Double
    var dt_txt: String
    var main: WeatherInfo
}

struct WeatherInfo: Codable{
//    var feels_like: String
//    var grnd_level: Int
//    var humidity: Int
//    var pressure: Int
//    var sea_level: Int
 var temp: Double
//    var temp_kf: Double
//    var temp_max: Double
//    var temp_min: Double
}

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var today: [Info] = [Info]()
    var tommorow: [Info] = [Info]()
    var tommorow1: [Info] = [Info]()
    var tommorow2: [Info] = [Info]()
    var tommorow3: [Info] = [Info]()
    var fiveDayForecast: [[Info]] = [[Info]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forecast()
        tableView.delegate  = self
        tableView.dataSource = self
        fiveDayForecast.append(today)
        fiveDayForecast.append(tommorow)
        fiveDayForecast.append(tommorow1)
        fiveDayForecast.append(tommorow2)
        fiveDayForecast.append(tommorow3)
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
                        
                            if let days = try? JSONDecoder().decode(OneDayForcast.self, from: d){
                                
                                var date =  "\(Calendar.current.component(.month, from: Date()))/\(Calendar.current.component(.day, from: Date()))/\(Calendar.current.component(.year, from: Date()))"
                                
                                var date1 =  "\(Calendar.current.component(.month, from: Date()))/\((Calendar.current.component(.day, from: Date()))+1)/\(Calendar.current.component(.year, from: Date()))"
                                
                                var date2 =  "\(Calendar.current.component(.month, from: Date()))/\((Calendar.current.component(.day, from: Date()))+2)/\(Calendar.current.component(.year, from: Date()))"
                                
                                var date3 =  "\(Calendar.current.component(.month, from: Date()))/\((Calendar.current.component(.day, from: Date()))+3)/\(Calendar.current.component(.year, from: Date()))"
                                
                                var date4 =  "\(Calendar.current.component(.month, from: Date()))/\((Calendar.current.component(.day, from: Date()))+4)/\(Calendar.current.component(.year, from: Date()))"
                                
                                for i in days.list{
                                    if "\(Date(timeIntervalSince1970: i.dt).formatted(date: .numeric, time: .omitted))" == date {
                                        self.today.append(i)
                                    } else if "\(Date(timeIntervalSince1970: i.dt).formatted(date: .numeric, time: .omitted))" == date1{
                                        self.tommorow.append(i)
                                    }else if "\(Date(timeIntervalSince1970: i.dt).formatted(date: .numeric, time: .omitted))" == date2{
                                        self.tommorow1.append(i)
                                    }else if "\(Date(timeIntervalSince1970: i.dt).formatted(date: .numeric, time: .omitted))" == date3{
                                        self.tommorow2.append(i)
                                    }else if "\(Date(timeIntervalSince1970: i.dt).formatted(date: .numeric, time: .omitted))" == date4{
                                        self.tommorow3.append(i)
                                    }
                                }
                                
                                DispatchQueue.main.async{
                                    self.tableView.reloadData()
                                }
                            }
                        }
                    }
                }
            }
        
        dataTask.resume()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fiveDayForecast.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! WeatherCell
        
//        DispatchQueue.main.async{
//            print("\(self.fiveDayForecast.count)")
//            
//            for r in self.fiveDayForecast[indexPath.row]{
//                print(r.dt_txt)
//            }
//        }
        
        
        return cell
    }


}

