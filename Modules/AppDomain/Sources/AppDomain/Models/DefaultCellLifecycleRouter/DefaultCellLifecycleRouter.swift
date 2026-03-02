//
//  File.swift
//  
//
//  Created by Александр Милейчик on 12/30/25.
//

import UIKit

public protocol VisibilityTrackable {
    func handleVisibility()
}

public enum CellLifecycleEvent {
    case willDisplay
    case didEndDisplaying
}

public protocol LifecycleAwareCell {
    func willDisplay()
    func didEndDisplaying()
}

public protocol CellLifecycleRouting {
    func route(event: CellLifecycleEvent, for cell: UITableViewCell)
}

public final class DefaultCellLifecycleRouter: CellLifecycleRouting {
    
    public init() {}
    
    public  func route(event: CellLifecycleEvent, for cell: UITableViewCell) {
        guard let cell = cell as? LifecycleAwareCell else { return }

        switch event {
        case .willDisplay:
            cell.willDisplay()
        case .didEndDisplaying:
            cell.didEndDisplaying()
        }
    }
}
