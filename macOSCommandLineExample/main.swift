//
//  main.swift
//  macOSCommandLineExample
//
//  Created by Daisuke T on 2019/04/28.
//  Copyright © 2019 DaisukeT. All rights reserved.
//

import Foundation

class HandleWriter {
  static func write(_ handle: FileHandle, message: String) {
    let data = "\(message)\n".data(using: .utf8) ?? Data()
    handle.write(data)
  }
  
  static func writeStandardOutput(_ message: String) {
    write(FileHandle.standardOutput, message: message)
  }
  
  static func writeStandardError(_ message: String) {
    write(FileHandle.standardError, message: message)
  }
}


while true {
  
  autoreleasepool {
    HandleWriter.writeStandardOutput("Please input command")
    let data = FileHandle.standardInput.availableData
    
    var str = String(data: data, encoding: .utf8) ?? ""
    str = str.trimmingCharacters(in: NSCharacterSet.newlines)
    let array = str.components(separatedBy: " ")
    guard array.count > 0 else {
      return
    }
    guard array[0].count > 0 else {
      return
    }
    
    
    let command = array[0].lowercased()
    var option: String?
    if array.count > 1 {
      option = array[1]
    }
    
    switch command {
    case "date":
      HandleWriter.writeStandardOutput("\(Date())")
      
    case "count":
      guard let option = option else {
        HandleWriter.writeStandardError("Command needs option")
        break
      }
      
      HandleWriter.writeStandardOutput("\(String(describing: option.count))")
      
    case "exit":
      exit(0)
      
    default:
      HandleWriter.writeStandardError("Unknown command")
    }
    
  }
  
}

