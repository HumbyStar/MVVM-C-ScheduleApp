//
//  Validate + CheckTimes.swift
//  StudyPlan
//
//  Created by Humberto Rodrigues on 27/02/23.
//

import Foundation

extension CheckTimes {
    var validate: TimeInterval {
        get {
            switch self {
            case .zero:
                return 0.0
            case .first:
                return 60.0//(24.0 * 60.0 * 60.0)
            case .second:
                return 120.0//(168.0 * 60.0 * 60.0)
            case .third:
                return 240.0//(720.0 * 60.0 * 60.0)
            }
        }
    }
}
