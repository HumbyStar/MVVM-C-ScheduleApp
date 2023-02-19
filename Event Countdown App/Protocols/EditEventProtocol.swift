//
//  EditEventProtocol.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 19/02/23.
//

import Foundation

protocol EventUpdatingCoordinator {
    var onUpdateEvent: () -> Void {get}
}
