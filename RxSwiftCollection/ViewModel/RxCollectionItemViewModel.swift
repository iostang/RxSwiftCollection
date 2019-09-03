//
//  RxCollectionItemViewModel.swift
//  RxSwiftCollection
//
//  Created by 🥄💻 on 2019/9/3.
//  Copyright © 2019 TangChi. All rights reserved.
//

import UIKit
import RxCocoa

class RxCollectionItemViewModel: RxBaseViewModel {
    public var title: BehaviorRelay<Any?> = BehaviorRelay<Any?>(value: nil)
    public var color: BehaviorRelay<Any?> = BehaviorRelay<Any?>(value: nil)
    public var edges: BehaviorRelay<Any?> = BehaviorRelay<Any?>(value: nil)
}
