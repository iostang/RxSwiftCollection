//
//  RxModel.swift
//  RxSwiftCollection
//
//  Created by 🥄💻 on 2019/9/3.
//  Copyright © 2019 TangChi. All rights reserved.
//

import RxDataSources
import RxCocoa

struct RxItemData {
    var node: Node?
}

struct RxSectionData {
    var items: [Item]
    var node: RxCollectionSectionViewModel?
}

extension RxSectionData: SectionModelType {
    init(original: RxSectionData, items: [RxItemData]) {
        self = original
        self.items = items
    }
    
    typealias Item = RxItemData
}

protocol Node : class {
    var items: BehaviorRelay<[Node]> { get }
}
