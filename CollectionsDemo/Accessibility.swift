//
//  Accessibility.swift
//  CollectionsDemo
//
//  Created by 陳鈺翎 on 2024/1/8.
//

final class Accessibility {
    private static func identifier(from propertyName: String) -> String {
      ["Accessibility", propertyName].joined(separator: ".")
    }
}

extension Accessibility {
    static var listCollection: String { identifier(from: #function) }
    static var balanceButton: String {
        identifier(from: #function)
    }
    static var galleryImageView: String {
        identifier(from: #function)
    }
    static var galleryNameLabel: String {
        identifier(from: #function)
    }
    static var detailImageView: String {
        identifier(from: #function)
    }
    static var detailNameLabel: String {
        identifier(from: #function)
    }
    static var detailDescriptionLabel: String {
        identifier(from: #function)
    }
    static var detailOpenseaButton: String {
        identifier(from: #function)
    }
}
