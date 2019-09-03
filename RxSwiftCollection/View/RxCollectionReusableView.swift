//
//  RxCollectionReusableView.swift
//  RxSwiftCollection
//
//  Created by 🥄💻 on 2019/9/3.
//  Copyright © 2019 TangChi. All rights reserved.
//

import UIKit

class RxCollectionReusableView: UICollectionReusableView {
    
    let backgroundView = UIView()
    
    let titleLabel = UILabel()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backgroundView)
        backgroundView.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
        
        backgroundView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
