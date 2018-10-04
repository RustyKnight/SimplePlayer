//
//  RestService.swift
//  Player
//
//  Created by Shane Whitehead on 4/10/18.
//  Copyright © 2018 Shane Whitehead. All rights reserved.
//

import Foundation
import Hydra
import LogWrapperKit
import SwiftyXMLParser

enum RestServiceError: Error {
  case noData
  case invalidData
}

class RestService {
  
  static let baseURL = URL(string: "http://wowzastg.camera.swann.com:8087/v2/servers/_defaultServer_/vhosts/_defaultVHost_/applications/live/instances")!
  
  func avaliableCameras() -> Promise<[Camera]> {
    return Promise<Data>(in: .userInitiated, { (fulfill, fail, _) in
      self.makeRequest(then: fulfill, fail: fail)
    }).then(in: .userInitiated, { (data) -> [Camera] in
      return try CameraParser.parse(from: data)
    })
  }
  
  // This would probably be a "generalised" request, taking in parameters to
  // customise the query
  fileprivate func makeRequest(then: @escaping (Data) -> Void, fail: @escaping (Error) -> Void) {
    let request = URLRequest(url: RestService.baseURL)
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      if let error = error {
        fail(error)
        return
      }
      if let response = response as? HTTPURLResponse {
        log(debug: "Response from service is \(response.statusCode): \(HTTPURLResponse.localizedString(forStatusCode: response.statusCode))")
      }
      guard let data = data else {
        fail(RestServiceError.noData)
        return
      }
      then(data)
    }
    task.resume()
  }
  
}
