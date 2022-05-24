//
//  APIColor.swift
//  Pagination
//
//  Created by Ramy Atalla on 2022-05-24.
//

import Foundation

class APICaller {
    //Moking data
    
    typealias completionHandler = (Result<[String], Error>) -> Void
    var isPaginating = false
    
    
    func fetchData(pagination: Bool = false, completion: @escaping completionHandler) {
        isPaginating = true
        DispatchQueue.global().asyncAfter(deadline: .now() + (pagination ? 3 : 2)) {
            let originalData = ["Apple", "Google", "Facebook", "Amazon", "Apple", "Google", "Apple", "Google", "Facebook", "Amazon", "Apple", "Google", "Apple", "Google", "Facebook", "Amazon", "Apple", "Google", "Apple", "Google", "Facebook", "Amazon", "Apple", "Google", "Apple", "Google", "Apple", "Google", "Facebook", "Amazon", "Apple", "Google", "Apple", "Google", "Facebook", "Amazon", "Apple", "Google", "Apple", "Google", "Facebook"]
            let newData = ["Apple", "Orange", "banana"]
            
            completion(.success(pagination ? newData : originalData))
            if pagination {
            self.isPaginating = false
            }
        }
    }
}
