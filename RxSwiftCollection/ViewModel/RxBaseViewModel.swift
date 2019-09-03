//
//  RxBaseViewModel.swift
//  RxSwiftCollection
//
//  Created by 🥄💻 on 2019/9/3.
//  Copyright © 2019 TangChi. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RxBaseViewModel: NSObject, Node {
    var style: String = ""
    var name: String = ""
    var items: BehaviorRelay<[Node]> = BehaviorRelay<[Node]>(value: [Node]())
}
