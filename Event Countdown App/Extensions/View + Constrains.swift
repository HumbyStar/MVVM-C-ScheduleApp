//
//  View + Constrains.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 04/02/23.
//

import UIKit

enum Edges{
    case top
    case leading
    case trailing
    case bottom
}

extension UIView {
    func pinEdgesToConstrains(edges: [Edges] = [.top,.leading,.trailing,.bottom], constant: CGFloat = 0) {
        guard let superview = superview else {return}
        edges.forEach{
            switch $0 {
            case .top:
                topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
            case .leading:
                leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: constant).isActive = true
            case .trailing:
                trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -constant).isActive = true
            case .bottom:
                bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant).isActive = true
            }
        }
    }
}
