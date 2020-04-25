import Foundation
import UIKit
class Records: Codable {
    var nameItem: String?
    var countItem: Int?
    var imageItem: Data?
    
    private enum CodingKeys: String, CodingKey {
        case nameItem
        case countItem
        case imageItem
    }
    
    init(nameItem: String?, countItem: Int?, imageItem: Data?) {
        self.nameItem = nameItem
        self.countItem = countItem
        self.imageItem = imageItem
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        nameItem = try container.decode(String.self, forKey: .nameItem)
        countItem = try container.decode(Int.self, forKey: .countItem)
        imageItem = try container.decode(Data.self, forKey: .imageItem)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.nameItem, forKey: .nameItem)
        try container.encode(self.countItem, forKey: .countItem)
        try container.encode(self.imageItem, forKey: .imageItem)
    }
    
}
