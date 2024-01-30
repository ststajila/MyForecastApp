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
                                
                                print("List: \(days.list.count)")
                                
                                var date =  "\(Calendar.current.component(.month, from: Date()))/\(Calendar.current.component(.day, from: Date()))/\(Calendar.current.component(.year, from: Date()))"
                                
                                var date1 =  "\(Calendar.current.date(byAdding: .day, value: 1, to: Date())!.formatted(date: .numeric, time: .omitted))"
                                
                                var date2 =  "\(Calendar.current.date(byAdding: .day, value: 2, to: Date())!.formatted(date: .numeric, time: .omitted))"

                                
                                var date3 =  "\(Calendar.current.date(byAdding: .day, value: 3, to: Date())!.formatted(date: .numeric, time: .omitted))"

                                
                                var date4 =  "\(Calendar.current.date(byAdding: .day, value: 4, to: Date())!.formatted(date: .numeric, time: .omitted))"

                                
                                for i in days.list{
                                    
                                    if Calendar.current.component(.month, from: Date()) == Calendar.current.component(.month, from: Date(timeIntervalSince1970: i.dt)){
                                        
                                        if "\(Date(timeIntervalSince1970: i.dt).formatted(date: .numeric, time: .omitted))" == date {
                                            self.today.append(i)
                                        } else if "\(Date(timeIntervalSince1970: i.dt).formatted(date: .numeric, time: .omitted))" == date1{
                                            self.tommorow.append(i)
                                        }else if "\(Date(timeIntervalSince1970: i.dt).formatted(date: .numeric, time: .omitted))" == date2{
                                            self.tommorow1.append(i)
                                        }else if "\(Date(timeIntervalSince1970: i.dt).formatted(date: .numeric, time: .omitted))" == date3{
                                            self.tommorow2.append(i)
                                            print("3rd")
                                        }else if "\(Date(timeIntervalSince1970: i.dt).formatted(date: .numeric, time: .omitted))" == date4{
                                            self.tommorow3.append(i)
                                        }
                                    } else{
                                        if "\(Date(timeIntervalSince1970: i.dt).formatted(date: .numeric, time: .omitted))" == date {
                                            self.today.append(i)
                                        } else if "\(Date(timeIntervalSince1970: i.dt).formatted(date: .numeric, time: .omitted))" == date1{
                                            self.tommorow.append(i)
                                        }else if "\(Date(timeIntervalSince1970: i.dt).formatted(date: .numeric, time: .omitted))" == date2{
                                            self.tommorow1.append(i)
                                        }else if "\(Date(timeIntervalSince1970: i.dt).formatted(date: .numeric, time: .omitted))" == date3{
                                            self.tommorow2.append(i)
                                            print("3rd")
                                        }else if "\(Date(timeIntervalSince1970: i.dt).formatted(date: .numeric, time: .omitted))" == date4{
                                            self.tommorow3.append(i)
                                        }
                                    }
                                }
                                
                                DispatchQueue.main.async{
                                    self.fiveDayForecast.append(self.today)
                                    self.fiveDayForecast.append(self.tommorow)
                                    self.fiveDayForecast.append(self.tommorow1)
                                    self.fiveDayForecast.append(self.tommorow2)
                                    self.fiveDayForecast.append(self.tommorow3)
                                    self.tableView.reloadData()
                                    print("tommorow2: \(self.tommorow2.count)")
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

        let r1 = fiveDayForecast[indexPath.row]
        print("\(r1.count)")
        
        if r1.count >= 1{
            cell.date.text  = Date(timeIntervalSince1970: r1[0].dt).formatted(date: .long, time: .omitted)
            cell.d1.text = Date(timeIntervalSince1970: r1[0].dt).formatted(date: .omitted, time: .shortened)
            cell.t1.text = "\(r1[0].main.temp)°F"
        }
        if r1.count >= 2{
            cell.d2.text = Date(timeIntervalSince1970: r1[1].dt).formatted(date: .omitted, time: .shortened)
            cell.t2.text = "\(r1[1].main.temp)°F"
        }
        if r1.count >= 3{
            cell.d3.text = Date(timeIntervalSince1970: r1[2].dt).formatted(date: .omitted, time: .shortened)
            cell.t3.text = "\(r1[2].main.temp)°F"
        }
        if r1.count >= 4{
            cell.d4.text = Date(timeIntervalSince1970: r1[3].dt).formatted(date: .omitted, time: .shortened)
            cell.t4.text = "\(r1[3].main.temp)°F"
        }
        if r1.count >= 5{
            cell.d5.text = Date(timeIntervalSince1970: r1[4].dt).formatted(date: .omitted, time: .shortened)
            cell.t5.text = "\(r1[4].main.temp)°F"
        }
        if r1.count >= 6{
            cell.d6.text = Date(timeIntervalSince1970: r1[5].dt).formatted(date: .omitted, time: .shortened)
            cell.t6.text = "\(r1[5].main.temp)°F"
        }
        if r1.count >= 7{
            cell.d7.text = Date(timeIntervalSince1970: r1[6].dt).formatted(date: .omitted, time: .shortened)
            cell.t7.text = "\(r1[6].main.temp)°F"
        }
        if r1.count >= 8{
            cell.d8.text = Date(timeIntervalSince1970: r1[7].dt).formatted(date: .omitted, time: .shortened)
            cell.t8.text = "\(r1[7].main.temp)°F"
        }
        return cell
    }


}

