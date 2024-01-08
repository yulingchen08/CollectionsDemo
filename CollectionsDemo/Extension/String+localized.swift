//
//  String+localized.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/9.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
