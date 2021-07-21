//
//  TodayMultipleAppsController.swift
//  AppStore-Clone
//
//  Created by Mikhail Udotov on 2021-07-14.
//

import UIKit

class TodayMultipleAppsController: BaseCollectionViewController {
    
    fileprivate let todayAppCellId = "todayAppCell"
    
    var apps: [FeedResult]?
    
    let closeBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(TodayAppCell.self, forCellWithReuseIdentifier: todayAppCellId)
        
        if mode == .fullscreen {
            setUpCloseBtn()
            collectionView.isScrollEnabled = true
            navigationController?.isNavigationBarHidden = true
        } else {
            collectionView.isScrollEnabled = false
        }
        
    }
    
    func setUpCloseBtn() {
        view.addSubview(closeBtn)
        closeBtn.translatesAutoresizingMaskIntoConstraints = false
        closeBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        closeBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true)
    }
    
    override var prefersStatusBarHidden: Bool { return true }
    
    fileprivate let mode: Mode
    
    enum Mode {
        case small, fullscreen
    }
    
    init(mode: Mode){
        self.mode = mode
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate let spacing: CGFloat = 20
    
}

extension TodayMultipleAppsController: UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mode == .small {
            return 4
        } else {
            return apps?.count ?? 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: todayAppCellId, for: indexPath) as? TodayAppCell else {return UICollectionViewCell()}
        guard let app = apps?[indexPath.item] else { return cell }
        cell.appCompanyLabel.text = app.artistName
        cell.appNameLabel.text = app.name
        ImageCacheService.shared.loadAppImage(imageURL: app.artworkUrl100) { appIcon in
            cell.appImageView.image = appIcon
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let appId = apps?[indexPath.item].id else { return }
        let appDetailController = AppDetailsViewController(appId: appId)
        navigationController?.pushViewController(appDetailController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 0
        var width: CGFloat = 0
        
        if mode == .fullscreen {
            height = 70
            width = view.frame.width - 50
        } else {
            height = (view.frame.height - 3 * spacing) / 4
            width = view.frame.width
        }
        
        return .init(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if mode == .fullscreen {
            return .init(top: 50, left: 25, bottom: 10, right: 25)
        } else {
            return .zero
        }
    }
}
