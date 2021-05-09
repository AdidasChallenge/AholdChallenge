//
//  ArtObjectTile.swift
//  AholdChallenge
//
//  Created by Jesse Klijn on 04/05/2021.
//

import UIKit
import EasyPeasy
import Kingfisher

final class ArtObjectTile: UIView {
    
    private var viewModel: ViewModel?
    
    private let thumbnailContainer = UIView()
    private let thumbnailImageView = UIImageView()
    
    private let verticalStackView: UIStackView = .init()
    private let titleLabel = UILabel()
    private let makerLabel = UILabel()
    private let priceLabel = UILabel()
    
    init() {
        
        super.init(frame: .zero)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Updatable
extension ArtObjectTile {
    
    func update(model: ArtObjectTile.ViewModel?) {
        self.viewModel = model
        
        updateThumbnail()
        updateTitleLabel()
        updateMakerLabel()
    }
    
    private func updateThumbnail() {
        guard let viewModel = viewModel else {
            thumbnailImageView.image = UIImage(named: "no-image-found-test")
            return
        }
        
        thumbnailImageView.downloadedAsync(from: viewModel.thumbnail ?? "")
        
    }
    
    private func updateTitleLabel() {
        titleLabel.isHidden = viewModel == nil
        titleLabel.text = viewModel?.title
    }
    
    private func updateMakerLabel() {
        makerLabel.isHidden = viewModel == nil
        makerLabel.text = viewModel?.maker
    }
    
}

// MARK: Setup
private extension ArtObjectTile {
    private var itemSpacing: CGFloat { 8 }
    
    func setup() {
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        addSubviews(thumbnailContainer, verticalStackView)
        verticalStackView.addArrangedSubviews(titleLabel, makerLabel, priceLabel)
        setupThumbnail()
        setupVerticalStackView()
        setupTitleLabel()
        setupMakerLabel()
    }
    
    func setupThumbnail() {
        thumbnailContainer.layer.cornerRadius = 4
        thumbnailContainer.layer.masksToBounds = true
        
        thumbnailContainer.easy.layout(
            Left(itemSpacing),
            Top(itemSpacing),
            Bottom(itemSpacing),
            Width(*1).like(thumbnailContainer, .height)
        )
        
        thumbnailContainer.addSubview(thumbnailImageView)
        thumbnailImageView.easy.layout(
            Edges()
        )
        thumbnailImageView.contentMode = .scaleAspectFill
    }
    
    func setupVerticalStackView() {
        verticalStackView.easy.layout(
            Left(16).to(thumbnailContainer, .right),
            Right(16),
            Top(>=0).to(thumbnailContainer, .top),
            CenterY()
        )
        
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .equalCentering
        verticalStackView.alignment = .center
        verticalStackView.spacing = 24
    }
    
    func setupTitleLabel() {
        titleLabel.textColor = .black
    }
    
    func setupMakerLabel() {
        makerLabel.textColor = .black
        makerLabel.numberOfLines = 3
    }
}
