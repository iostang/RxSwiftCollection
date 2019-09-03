//
//  RxCollectionSectionViewModel.swift
//  RxSwiftCollection
//
//  Created by 🥄💻 on 2019/9/3.
//  Copyright © 2019 TangChi. All rights reserved.
//

import UIKit
import RxCocoa

class RxCollectionSectionViewModel: RxBaseViewModel {
    public var editingSelected: BehaviorRelay<Any?> = BehaviorRelay<Any?>(value: nil)
    public var headerTitle: BehaviorRelay<Any?> = BehaviorRelay<Any?>(value: nil)
    public var footerTitle: BehaviorRelay<Any?> = BehaviorRelay<Any?>(value: nil)
}
