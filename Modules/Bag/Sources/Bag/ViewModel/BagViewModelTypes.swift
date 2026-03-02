//
//  File.swift
//  
//
//  Created by Александр Милейчик on 10/13/25.
//

public enum BagViewModelState {
    case initial
    case loading
    case loaded
    case error(Error)
}

public enum BagViewModelEvent {
    case bagDidTap
    case quantityPickerDidTap(BagProductUIModel)
}

public enum BagEffect {
    case presentComingSoon
    case showQuantityPicker(BagProductUIModel)
}
