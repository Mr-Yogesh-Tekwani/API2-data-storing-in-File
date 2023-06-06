//
//  NetworkLayer.swift
//  API Data Storing in File 2
//
//  Created by Yogesh on 6/5/23.
//

import Foundation

// S1 - Import API Data and store in txt file

func storeAPIData(api:String, completionHandler: @escaping (Bool) -> ()){
    
    guard let apiURL = URL(string: api) else {
        print("Invalid API URL")
        completionHandler(false)
        return
    }
    
    let task = URLSession.shared.dataTask(with: apiURL) { (data, response, error) in
        
        if error != nil {
            print(error)
            completionHandler(false)
            
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            print(error)
            completionHandler(false)
            return
        }
        
        
        
        if let data = data {
            // Store data in Str format
            print("Inside Data")
            guard let strData = String(data: data, encoding: .utf8) else {return}
            
            // Desktop URL
            
            let manager = FileManager.default
           
            let desktopUrl = try! manager.url(for: .desktopDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
          //  let desktopUrl2 = try! manager.urls(for: .desktopDirectory, in: .userDomainMask).first
            let fileUrl = desktopUrl.appendingPathComponent("ApiData2.txt")
            
            // Write data in the file:
            
            do{
                try data.write(to: fileUrl)
                print("Data Successfully Stored in \(fileUrl.path)")
                completionHandler(true)
            }catch{
                print("Data not stored error !!! ", error)
                completionHandler(false)
            }
        }
    }

    task.resume()
    print("Task Completed!")
}

func readFromFile(completionHandler: @escaping ([String: [Details]]?) -> ()) {
    
    let manager = FileManager.default
    let desktopUrl = try! manager.urls(for: .desktopDirectory, in: .userDomainMask).first
    let fileUrl = desktopUrl?.appendingPathComponent("ApiData2.txt")
    
    if let fileUrl = fileUrl {
        do{
           // string -> data -> json
            
            let strData = try String(contentsOf: fileUrl, encoding: .utf8)
            let data = strData.data(using: .utf8)
            let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: [])
            
            // Decode json data as usual
                let decoder = JSONDecoder()
            let allData = try? decoder.decode([String:[Details]].self, from: data!)
            completionHandler(allData)
            
            
        }catch{
            print(error.localizedDescription)
            completionHandler(nil)
        }
    }
    
}
