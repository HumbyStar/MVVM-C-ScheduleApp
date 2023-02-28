//
//  CellBuilder.swift
//  Event Countdown App
//
//  Created by Humberto Rodrigues on 02/02/23.
//

import Foundation

struct CellBuilder {
    func makeTitleSubtitleCellViewModel(type: TitleSubtitleCellViewMode.CellType, onCellUpdate: (() -> Void)? = nil) -> TitleSubtitleCellViewMode {
        switch type {
        case .text:
            return TitleSubtitleCellViewMode(
                title: "Name",
                subtitle: "",
                placeholder: "Add a Name",
                type: .text,
                onCellUpdate: onCellUpdate
            )
        case .date:
            return TitleSubtitleCellViewMode(
                title: "Date",
                subtitle: "",
                placeholder: "Select a Date",
                type: .date,
                onCellUpdate: onCellUpdate
                )
        case .image:
            return TitleSubtitleCellViewMode(
                title: "Background",
                subtitle: "",
                placeholder: "",
                type: .image,
                onCellUpdate: onCellUpdate
            )
        }
    }
}
