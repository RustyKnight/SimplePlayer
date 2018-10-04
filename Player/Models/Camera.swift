//
//  Camera.swift
//  Player
//
//  Created by Shane Whitehead on 4/10/18.
//  Copyright © 2018 Shane Whitehead. All rights reserved.
//

import Foundation
import SwiftyXMLParser
import LogWrapperKit

// Prefer interface over implementation
protocol Camera {
  var url: URL { get }
}

struct DefaultCamera: Camera {
  var url: URL
}

struct CameraParser {
  
  struct Keys {
    struct Instances {
      static let key = "Instances"
      static let name = "name"
    }
    struct InstanceList {
      static let key = "InstanceList"
      static let name = "name"
    }
    struct IncomingStreams {
      static let key = "IncomingStreams"
    }
    struct IncomingStream {
      static let key = "IncomingStream"
      static let applicationInstance = "ApplicationInstance"
      static let name = "name"
      static let sourceIp = "SourceIp"
      static let isRecordingSet = "IsRecordingSet"
      static let isStreamManagerStream = "IsStreamManagerStream"
      static let isPublishedToVOD = "IsPublishedToVOD"
      static let isConnected = "IsConnected"
      static let isPTZEnabled = "IsPTZEnabled"
      static let ptzPollingInterval = "PtzPollingInterval"
      static let ptzPollingIntervalMinimum = "PtzPollingIntervalMinimum"
    }
  }
  
  // Breaking this out into its own function reduces the noise
  // And yes, it could be a promise
  static func parse(from data: Data) throws -> [Camera] {
    let xml = XML.parse(data)
    
    var cameras: [Camera] = []
    
//    let serverName = xml[Keys.Instances.key].attributes[Keys.Instances.name]
//    let instanceListName = xml[Keys.Instances.key, Keys.InstanceList.key, Keys.InstanceList.name].text
    
    let streams = xml[Keys.Instances.key, Keys.InstanceList.key, Keys.IncomingStreams.key, Keys.IncomingStream.key]
    for stream in streams {
      // I'd use the keys above to parse the properties of the stream, but since, right now,
      // I'm only interested in the source IP, I'm just going to grab that
      guard let sourceIP = stream[Keys.IncomingStream.sourceIp].text else {
        log(warning: "Stream does not contain sourceIP!")
        continue
      }
      log(debug: "sourceIP = \(sourceIP)")
      guard let url = URL(string: sourceIP) else {
        log(warning: "\(sourceIP) is not a valid URL")
        continue
      }
      cameras.append(DefaultCamera(url: url))
    }
    
    return cameras
  }

}
