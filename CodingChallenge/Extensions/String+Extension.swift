//
//  String+Extension.swift
//  CodingChallenge
//
//  Created by Armaghan  on 5/30/21.
//

import Foundation

extension String
{
    // MARK: - Filter Digits
    var digits: String
    {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
}
