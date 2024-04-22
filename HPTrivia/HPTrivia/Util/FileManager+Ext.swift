//
//  FileManager+Ext.swift
//  HPTrivia
//
//  Created by Sunggon Park on 2024/04/11.
//

import Foundation

extension FileManager {
    static var documentDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
}
