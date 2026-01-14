//
//  Extensions.swift
//  Netflix-Clone
//
//  Created by Tarun Sharma on 14/01/26.
//

import Foundation


extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
