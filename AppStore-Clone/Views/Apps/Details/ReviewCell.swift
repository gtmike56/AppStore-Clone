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
        label.setContentCompressionResistancePriority(.init(rawValue: 0), for: .horizontal)
        return label
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.text = "Author"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        label.textAlignment = .right
        return label
    }()
    
    let reviewBodyLabel: UILabel = {
        let label = UILabel()
        label.text = "Review Body"
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 5
        return label
    }()
    
    let starsStackView: UIStackView = {
        var subViews = [UIView]()
        (0..<5).forEach { _ in
            let iV = UIImageView(image: UIImage(systemName: "star.fill"))
            iV.tintColor = .systemOrange
            iV.widthAnchor.constraint(equalToConstant: 20).isActive = true
            iV.heightAnchor.constraint(equalToConstant: 20).isActive = true
            iV.contentMode = .scaleAspectFit
            subViews.append(iV)
        }
        subViews.append(UIView())
        let stackView = UIStackView(arrangedSubviews: subViews)
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        layer.cornerRadius = 16
        clipsToBounds = true
        
    
        let stackView = UIStackView(arrangedSubviews: [UIStackView(arrangedSubviews: [titleLabel, authorLabel]), starsStackView, reviewBodyLabel, UIView()])
        stackView.axis = .vertical
        stackView.spacing = 10
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
