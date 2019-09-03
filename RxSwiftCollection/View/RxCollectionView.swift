//
//  RxCollectionView.swift
//  RxSwiftCollection
//
//  Created by 🥄💻 on 2019/9/3.
//  Copyright © 2019 TangChi. All rights reserved.
//

import UIKit
import SnapKit

class RxCollectionView: UIView {

    lazy var collectionView: UICollectionView = {
        let bounds = UIScreen.main.bounds
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.headerReferenceSize = CGSize(width: bounds.size.width, height: 60)
        flowLayout.footerReferenceSize = CGSize(width: bounds.size.width, height: 60)
        flowLayout.itemSize = CGSize(width:  bounds.size.width/2, height: 100)
        let collection = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: flowLayout)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.alwaysBounceVertical = true
        collection.backgroundColor = UIColor.clear
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}
