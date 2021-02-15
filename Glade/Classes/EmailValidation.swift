//
//  EmailValidation.swift
//  Glade
//
//  Created by Allen Gu on 1/29/21.
//

import Foundation

public class EmailValidation {
    static var schoolEmailEndings: [String: String] = ["UC Berkeley": "berkeley.edu"]
    
    static func validateEmail(school: String, email: String) -> Bool {
        let range = NSRange(location: 0, length: email.utf16.count)
        let regex = try! NSRegularExpression(pattern: "([A-Za-z0-9.(),:;<>@!#$%&'*+-/=?^_`{|}~])+@\(schoolEmailEndings[school]!)")
        return regex.firstMatch(in: email, options: [], range: range) != nil
    }
}
