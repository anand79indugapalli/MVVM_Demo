//
//  Converstions.swift
//  MVVM_Demo
//
//  Created by sai anand on 20/02/18.
//  Copyright © 2018 sai anand. All rights reserved.
//

import Foundation

extension String {
    func dateConverstion() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss" //Your date format
        let newDate = dateFormatter.date(from: self) //according to date format your date string
        dateFormatter.dateFormat = "MMM d, yyyy" //Your New Date format as per requirement change it own
        return dateFormatter.string(from: newDate ?? Date())
    }
}
