//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/3/25.
//

import AppDomain

public final class ViewBinder: ViewBinderProtocol {
    
    private let input: DetailViewModelInput
    
    public init(input: DetailViewModelInput) {
        self.input = input
    }
    
    public func update(with data: DetailData) {
        input.loadData(data)
    }
}
