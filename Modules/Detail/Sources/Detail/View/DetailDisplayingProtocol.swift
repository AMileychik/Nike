//
//  File.swift
//  
//
//  Created by Александр Милейчик on 11/4/25.
//

public protocol DetailDisplayingProtocol: AnyObject {
//    func scrollToTop()
    func reloadTable()
    func updateSections(_ sections: [DetailSection])
}
