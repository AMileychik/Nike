//
//  DetailViewModelTypes.swift
//  Nike
//
//  Created by Александр Милейчик on 6/5/25.
//

// MARK: - DetailViewModelState

public enum DetailViewModelState {
    case initial
    case loading
    case loaded(DetailUIModel)
    case error(String)
}

// MARK: - DetailViewModelEvent

public enum DetailViewModelEvent {
    case completeTheLookDidTap
}

// MARK: - DetailEffect

public enum DetailEffect {
    case comingSoon
}

