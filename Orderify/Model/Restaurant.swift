// To parse the JSON, add this file to your project and do:
//
//   let restaurant = try? JSONDecoder().decode(Restaurant.self, from: jsonData)
//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseRestaurant { response in
//     if let restaurant = response.result.value {
//       ...
//     }
//   }

import Foundation
import Alamofire

struct Restaurant: Codable {
    let errorCode: Int?
    let restaurants: [RestaurantElement]?
}

struct RestaurantElement: Codable {
    let id: Int?
    let title, description, address: String?
    let lat, lng, deliveryFee: Double?
    let deliveryTimeMins: Int?
    let image: String?
    let items: [Meal]?
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, address, lat, lng
        case deliveryFee = "delivery_fee"
        case deliveryTimeMins = "delivery_time_mins"
        case image, items
    }
}

struct Meal: Codable
{
    let id: Int?
    let title, description: String?
    let price: Double?
    let image: String?
}

struct Order: Codable {
    let id: Int?
    let timestamp: String?
    let active: Bool?
    let orderBy: User?
    let items: [Meal]?
    
    enum CodingKeys: String, CodingKey {
        case id, timestamp, active
        case orderBy = "order_by"
        case items
    }
}

//struct OrderBy: Codable {
//    let id: Int?
//    let username, email, phone, address: String?
//}

// MARK: - Alamofire response handlers

extension DataRequest
{
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }
            
            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }
            
            return Result { try JSONDecoder().decode(T.self, from: data) }
        }
    }
    
    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }
    
    @discardableResult
    func responseRestaurant(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<Restaurant>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}


