//
//  File.swift
//  
//
//  Created by Александр Милейчик on 10/8/25.
//

public enum BagButtonType {
    case pay
    case checkout

    public var config: ButtonStyleConfig {
        switch self {
        case .pay:
            return ButtonStyleType.payButton.config
        case .checkout:
            return ButtonStyleType.checkoutButton.config
        }
    }
}
