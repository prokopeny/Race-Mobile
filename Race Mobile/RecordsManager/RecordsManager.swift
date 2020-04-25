
import Foundation
import UIKit
class RecordsManager{
    static let shared = RecordsManager()
    init() {}
    var encodedData = Data()
    var resultArray = [Records]()
    
    func addItem(name: String?, count: Int?, UIImage: Data?){
        
        let result = Records(nameItem: name, countItem: count, imageItem: UIImage)
        resultArray.append(result)
        resultArray.sort(by: {$0.countItem! > $1.countItem!})
        guard let firstEncodedData = try? JSONEncoder().encode(resultArray) else { return }
        encodedData = firstEncodedData
        saveData()
    }
    
    func saveData(){
        UserDefaults.standard.set(encodedData, forKey: "encodedData")
        UserDefaults.standard.synchronize()
    }
    
    func loadData(){
        
        if let secondEncodedData = UserDefaults.standard.value(forKey: "encodedData") as? Data {
            encodedData = secondEncodedData
        }
        guard let decodeArray = try? JSONDecoder().decode([Records].self, from: encodedData) else { return }
        resultArray = decodeArray
        
    }
}
