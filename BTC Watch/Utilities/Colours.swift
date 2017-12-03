//
//  Colours.swift
//  BTC Watch
//
//  Created by Jasjeet Suri on 18/11/2017.
//  Copyright © 2017 Jastech Ltd. All rights reserved.
//

import UIKit

public enum Colours: String {
  
  // UIB Colours
  
  case facebookBlue = "#3B5998"
  case green = "#7CB433"
  case amber = "#E3A814"
  case darkGrey = "#333333"
  case lightGrey = "#777777"
  case indicatorLightGrey = "#D4D4D4"
  case veryLightGrey = "#F6F6F6"
  case bottomNavigationDisabled = "#90949C"
  case white = "#FFFFFF"
  case black = "#000000"

  case errorRed = "#E24048"
  case defaultTextPlaceHolder = "C7C7CD"

  /** Red for warning pages */
  case carminePink = "#E34048"
  
  public var colour: UIColor {
    return ColourCache.instance[self]
  }
  
  public var cgColour: CGColor {
    return ColourCache.instance[self].cgColor
  }
  
  public static var allValues: [Colours] {
    
    let values:[Colours] = [.white, .black]
    return values
  }
}

/** a little cache of colours */
private class ColourCache {
  static let instance = ColourCache()
  private var colours = [String: UIColor]()
  
  
  subscript(index: Colours) -> UIColor {
    get {
      if let match = colours[index.rawValue] {
        return match
      } else {
        
        let colour =  colourFromHexString(index.rawValue)
        colours[index.rawValue] = colour
        return colour
      }
    }
  }
  
  private func colourFromHexString(_ hexString: String) -> UIColor {
    // Convert hex string to an integer
    let hexint = Int(self.intFromHexString(hexString))
    let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
    let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
    let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
    
    // Create color object, specifying alpha as well
    let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
    return color
  }
  
  private func intFromHexString(_ hexStr: String) -> UInt32 {
    var hexInt: UInt32 = 0
    // Create scanner
    let scanner: Scanner = Scanner(string: hexStr)
    // Tell scanner to skip the # character
    scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
    // Scan hex value
    scanner.scanHexInt32(&hexInt)
    return hexInt
  }
}

