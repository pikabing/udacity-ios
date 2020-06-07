//
//  TrendingTagCollectionView.swift
//  Runner
//
//  Created by Pratik on 21/05/20.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

import Foundation
import UIKit

protocol TrendingTagSelectionDelegate: class {
    func tagSelected()
}

class TrendingTagCollectionView : UIView {
        
    private let collectionViewFlowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView: UICollectionView = {
        collectionViewFlowLayout.itemSize = CGSize(width: Constants.collectionViewWidth, height: Constants.collectionViewHeight)
        collectionViewFlowLayout.scrollDirection = .vertical
        collectionViewFlowLayout.minimumLineSpacing = Constants.lineSpacing
        collectionViewFlowLayout.minimumInteritemSpacing = Constants.interimSpacing
        return UICollectionView(frame:.zero,collectionViewLayout:collectionViewFlowLayout)
    }()
    var trendingTagList: [TrendingTag] = []
    
    var testList = [
        TrendingTag(tagId: 0, tagName: "🤪 This is test tag"),
        TrendingTag(tagId: 1, tagName: "😚 This is second tag"),
        TrendingTag(tagId: 2, tagName: "😉 This is third tag"),
        TrendingTag(tagId: 3, tagName: "🤓 This is fourth tag"),
        TrendingTag(tagId: 4, tagName: "🍟 This is fifth tag"),
        TrendingTag(tagId: 5, tagName: "🥜 This is sixth tag")
    ]
    
    public var delegate: TrendingTagSelectionDelegate?
   
    public init(trendingTagList: [TrendingTag]) {
        self.trendingTagList = testList
        super.init(frame:.zero)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        self.trendingTagList = testList
        super.init(coder:coder)
        commonInit()
    }
    
    private func commonInit() {
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            collectionView.heightAnchor.constraint(equalToConstant: Constants.heightAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            collectionView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1)
        ])
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib(nibName: Constants.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: Constants.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clear
        
    }

    
}

extension TrendingTagCollectionView : UICollectionViewDataSource, UICollectionViewDelegate {
   
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
           return 1
       }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingTagList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseIdentifier, for: indexPath)
        if let cell = cell as? TrendingTagCell {
            let tag = trendingTagList[indexPath.row]
            
            // set image
            cell.imageView.image = String(tag.tagName.prefix(1)).image()
            
            // set label
            cell.textLabel.text = tag.tagName
        }
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.tagSelected()
    }
    
}

extension TrendingTagCollectionView {
    
    struct Constants {
        static let reuseIdentifier = "TrendingTagCell"
        static let collectionViewWidth = 300
        static let collectionViewHeight = 100
        static let lineSpacing: CGFloat = 0
        static let interimSpacing: CGFloat = 0
        static let heightAnchor: CGFloat = 300
    }
}

extension String {
    func image() -> UIImage? {
        let size = CGSize(width: 40, height: 40)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.clear.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(in: rect, withAttributes: [.font: UIFont.systemFont(ofSize: 25)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

