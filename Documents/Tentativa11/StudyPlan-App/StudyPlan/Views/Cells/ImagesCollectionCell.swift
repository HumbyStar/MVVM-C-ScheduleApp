//
//  ImagesCell.swift
//  StudyPlan
//
//  Created by Humberto Rodrigues on 17/02/23.
//

import UIKit

final class ImagesCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewCode()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? .systemPurple : .clear
        }
    }
    
    func setupCell(with image: ImagesLG) {
        self.bannerImage.image = UIImage(named: image.rawValue)
    }
    
    lazy var bannerImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()

}

extension ImagesCollectionCell: ViewCode {
    func buildHierarchy() {
        addSubview(bannerImage)
    }
    func setupConstrains() {
        NSLayoutConstraint.activate([
            self.bannerImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.bannerImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.bannerImage.widthAnchor.constraint(equalToConstant: 50),
            self.bannerImage.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
}
