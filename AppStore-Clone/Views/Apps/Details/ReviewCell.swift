//
//  ReviewCell.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-06-28.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Review Title"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.text = "Author"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    let starsLabel: UILabel = {
        let label = UILabel()
        label.text = "Stars"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    let reviewBodyLabel: UILabel = {
        let label = UILabel()
        label.text = "Review Body"
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        layer.cornerRadius = 16
        clipsToBounds = true
        
    
        let stackView = UIStackView(arrangedSubviews: [UIStackView(arrangedSubviews: [titleLabel, UIView(), authorLabel]), starsLabel, reviewBodyLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
