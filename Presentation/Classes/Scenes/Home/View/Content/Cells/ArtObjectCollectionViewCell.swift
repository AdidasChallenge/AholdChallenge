//
//  ProductCollectionViewCell.swift
//  AholdChallenge
//
//  Created by Jesse Klijn on 04/05/2021.
//

import UIKit
import EasyPeasy

final class ArtObjectCollectionViewCell: UICollectionViewCell, Reusable {

    private let tileView = ArtObjectTile()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(tileView)
        tileView.easy.layout(
            Edges()
        )
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        update(model: nil)
    }
}

// MARK: Updatable
extension ArtObjectCollectionViewCell {
    func update(model: ArtObjectTile.ViewModel?) {
        tileView.update(model: model)
    }
}
