//
//  PaginationModel.swift
//  PATHAssignmentApp
//
//  Created by Saffet Emin Reisoğlu on 1.01.2022.
//

import Foundation

struct PaginationModel<T: Decodable> {
    private(set) var itemCount: Int = 0
    private(set) var items = [T]()
    
    private(set) var page: Int = 1
    var pageCount: Int {
        get {
            return Int(ceil(Double(itemCount) / Double(MarvelAPI.shared.PAGE_LIMIT)))
        }
    }
    
    private(set) var isPaginating = false
    private(set) var isDonePaginating = false
    
    init(
        itemCount: Int,
        items: [T]
    ) {
        self.itemCount = itemCount
        self.items = items
        
        if pageCount <= 1,
           items.count == itemCount {
            isDonePaginating = true
        }
    }
    
    mutating func increasePage() {
        page += 1
    }
    
    mutating func setIsPaginating(isPaginating: Bool) {
        self.isPaginating = isPaginating
    }
    
    mutating func appendItems(items: [T]?) {
        guard let items = items,
              !items.isEmpty else {
            isDonePaginating = true
            
            return
        }
        
        if pageCount == page {
            isDonePaginating = true
        }
        
        self.items.append(contentsOf: items)
    }
}
