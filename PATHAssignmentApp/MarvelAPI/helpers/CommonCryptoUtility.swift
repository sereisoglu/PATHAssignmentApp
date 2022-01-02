//
//  CommonCryptoUtility.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 31.12.2021.
//

import Foundation
import CommonCrypto

final class CommonCryptoUtility {
    static func MD5(text: String) -> String? {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        
        var digest = [UInt8](repeating: 0, count: length)
        
        if let d = text.data(using: .utf8) {
            _ = d.withUnsafeBytes { body -> String in
                CC_MD5(body.baseAddress, CC_LONG(d.count), &digest)
                return ""
            }
        }
        
        return (0 ..< length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
}
