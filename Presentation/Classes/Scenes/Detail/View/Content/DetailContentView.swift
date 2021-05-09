//
//  DetailContentView.swift
//  AholdChallenge
//
//  Created by Jesse Klijn on 04/05/2021.
//

import UIKit
import EasyPeasy

final class DetailContentView: UIView {
    
    private weak var delegate: DetailContentViewDelegate?
    private var viewModel: ViewModel?
    
    // MARK: - Navigation bar
    private(set) lazy var navigationBar: NavigationBarView = .init(delegate: self)
    
    // MARK: - UIElements
    private let scrollView: UIScrollView = .init(frame: .zero)
    private let contentView: UIView = .init()
    
    private let imageView: UIImageView = .init()
    private let nameLabel: UILabel = .init()
    private let makerLabel: UILabel = .init()
    
    init(delegate: DetailContentViewDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("xibs not supported")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        navigationBar.easy.layout(Height(safeAreaInsets.top + navigationBar.navigationBarHeight))
        scrollView.contentInset = UIEdgeInsets(top: navigationBar.frame.maxY, left: 0, bottom: 16, right: 0)
        scrollView.contentOffset = CGPoint(x: 0, y: -navigationBar.frame.maxY)
    }
}

// MARK: - Setup
private extension DetailContentView {
    func setup() {
        backgroundColor = .init(hex: "F1F1F1")
        
        addSubviews(scrollView, navigationBar)
        scrollView.addSubview(contentView)
        setupScrollView()
        
        contentView.addSubviews(
            imageView,
            nameLabel,
            makerLabel
        )
        
        setupNavigationBar()
        setupImageView()
        setupNameLabel()
        setupMakerLabel()
    }
    
    func setupScrollView() {
        scrollView.easy.layout(
            Edges(16)
        )
        
        contentView.easy.layout(
            Edges(),
            Width().like(scrollView)
        )
        
        scrollView.panGestureRecognizer.cancelsTouchesInView = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        
    }
    
    func setupNavigationBar() {
        navigationBar.easy.layout(
            Top(),
            Left(),
            Right(),
            Height(navigationBar.navigationBarHeight)
        )
    }
    
    func setupImageView() {
        imageView.easy.layout(
            Top(),
            Left(),
            Right(),
            Height().like(imageView, .width)
        )
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
    }
    
    func setupNameLabel() {
        nameLabel.textColor = .black
        nameLabel.numberOfLines = 2
        
        nameLabel.easy.layout(
            Left(16),
            Top(16).to(imageView, .bottom),
            Right()
        )
    }
    
    func setupMakerLabel() {
        makerLabel.textColor = .black
        makerLabel.numberOfLines = 3
        
        makerLabel.easy.layout(
            Left().to(nameLabel, .left),
            Top(16).to(nameLabel, .bottom),
            Right(),
            Bottom()
        )
    }
}

// MARK: Updatable
extension DetailContentView {
    
    func update(model: DetailContentView.ViewModel?) {
        self.viewModel = model
        
        updateImageView()
        updateNameLabel()
        updateMakerLabel()
    }
    
    private func updateImageView() {
        imageView.downloadedAsync(from: viewModel?.thumbnail ?? "")
    }
    
    private func updateNameLabel() {
        nameLabel.text = viewModel?.title
    }
    
    private func updateMakerLabel() {
        makerLabel.text = viewModel?.maker
    }
}

// MARK: NavigationBarDelegate
extension DetailContentView: NavigationBarDelegate {
    func didTapBack() {
        delegate?.didTapBack()
    }
}

