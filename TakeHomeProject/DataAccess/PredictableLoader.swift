//
//  PredictableLoader.swift
//  TakeHomeProject
//
//  Created by Holly on 10/16/24.
//

import Foundation

struct PredictableLoader: UrlLoader {
    var result: Result<Data, any Error>
    var delay: DispatchTimeInterval
    
    init(result: Result<Data, any Error>, delay: DispatchTimeInterval = .milliseconds(100)) {
        self.result = result
        self.delay = delay
    }
    
    func fetch(url: URL, completionHandler: @escaping (Result<Data, any Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now().advanced(by: delay)) {
            completionHandler(self.result)
        }
    }
}
