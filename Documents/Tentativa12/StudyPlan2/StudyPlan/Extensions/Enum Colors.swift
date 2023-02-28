//
//  Enum Colors.swift
//  StudyPlan
//
//  Created by Humberto Rodrigues on 17/02/23.
//

import UIKit

extension Colors {
    var value: UIColor {
        get {
            switch self {
            case .black:
                return .black
            case .green:
                return UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.2)
            case .red:
                return UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 0.5)
            case .yellow:
                return .yellow
            case .purple:
                return .purple
            case .orange:
                return UIColor(red: 255.0/255.0, green: 218.0/255.0, blue: 185.0/255.0, alpha: 1.0)
            }
        }
    }
}
