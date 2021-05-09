//
//  ArtObjectSectionHeaderView.swift
//  Presentation
//
//  Created by Jesse Klijn on 09/05/2021.
//

import UIKit
import EasyPeasy

final class ArtObjectSectionHeaderView: UICollectionReusableView {
    private let titleLabel: UILabel = .init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Reusable
extension ArtObjectSectionHeaderView: Reusable {
    
}
// MARK: - Update
extension ArtObjectSectionHeaderView {
    
    func update(viewModel: ViewModel) {
        
        titleLabel.text = viewModel.title
    }
}

// MARK: - Setup
private extension ArtObjectSectionHeaderView {
    
    func setup() {
        
        addSubview(titleLabel)
        
        setupTitleLabel()
    }
    
    func setupTitleLabel() {
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.easy.layout(
            Left(16),
            Right(16),
            Bottom(<=0),
            CenterY()
        )
    }
}
