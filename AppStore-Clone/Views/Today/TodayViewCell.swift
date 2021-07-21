//
//  TodayViewCell.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-06-30.
//

import UIKit

class TodayViewCell: UICollectionViewCell {
    
    var mainImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "garden")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    var categotyLabel: UILabel = {
        let label = UILabel()
        label.text = "Card Caregory"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Card Title"
        label.font = .boldSystemFont(ofSize: 28)
        label.numberOfLines = 2
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Card Description"
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 3
        return label
    }()
    
    var todayItem: TodayCellModel? {
        didSet {
            mainImageView.image = todayItem?.image
            titleLabel.text = todayItem?.title
            categotyLabel.text = todayItem?.categoty
            descriptionLabel.text = todayItem?.description
        }
    }
    
    var stackViewTopConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 15
        
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 10
        layer.shadowOffset = .init(width: 0, height: 15)
        
        addSubview(mainImageView)
        backgroundColor = .white
        
        let imageContainerView = UIView()
        imageContainerView.addSubview(mainImageView)
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        mainImageView.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor).isActive = true
        mainImageView.centerYAnchor.constraint(equalTo: imageContainerView.centerYAnchor).isActive = true
        mainImageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        mainImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [categotyLabel, titleLabel, imageContainerView, descriptionLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        
        self.stackViewTopConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20)
        self.stackViewTopConstraint?.isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
