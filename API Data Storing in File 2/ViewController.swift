//
//  ViewController.swift
//  API Data Storing in File 2
//
//  Created by Yogesh on 6/5/23.
//

import UIKit

class ViewController: UIViewController {

    let tableView = UITableView()
    var alldata : [String: [Details]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Inside ViewDidLoad")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.frame = self.view.bounds
        self.view.addSubview(tableView)
        
        storeAPIData(api: "https://pomber.github.io/covid19/timeseries.json", completionHandler: { ans in
            if ans{
                readFromFile(completionHandler: { data in
                    print(data?.count)
                    self.alldata = data!
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                })
            }
        })
    }

}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        print(type(of: alldata))
    }
}


extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alldata.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") else {
            return UITableViewCell()
        }

        let arrData = Array(alldata.keys.sorted())
            cell.textLabel?.text = arrData[indexPath.row]
//        }
        //cell.textLabel?.text = ""  //"\(self.alldata?.count ?? 0)"
        return cell
        
    }
    
    
}

