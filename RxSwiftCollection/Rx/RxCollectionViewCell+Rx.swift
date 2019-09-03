//
//  RxCollectionViewCellViewModel.swift
//  RxSwiftCollection
//
//  Created by 🥄💻 on 2019/9/3.
//  Copyright © 2019 TangChi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

extension Reactive where Base: RxCollectionViewCell {
    
    var edges: Binder<[String: CGFloat]?> {
        return Binder(self.base) {view, prop in
            view.titleLabel.snp.updateConstraints({ (make) in
                let top = prop?["top"] ?? 0
                let left = prop?["left"] ?? 0
                let bottom = prop?["bottom"] ?? 0
                let right = prop?["right"] ?? 0
                make.edges.equalToSuperview().inset(UIEdgeInsets(top: top, left: left, bottom: bottom, right: right))
            })
        }
    }
    
}
