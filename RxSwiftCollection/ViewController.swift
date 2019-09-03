//
//  ViewController.swift
//  RxSwiftCollection
//
//  Created by 🥄💻 on 2019/9/3.
//  Copyright © 2019 TangChi. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit


class ViewController: UIViewController {

    let collectionView = RxCollectionView()
    let collectionViewModel = RxCollectionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
      
        collectionViewModel.registry(view: collectionView)
        collectionViewModel.items = createRxData()
        collectionViewModel.bindItems(view: collectionView)
    }


    func createRxData() -> BehaviorRelay<[Node]> {
        
        let model1 = RxCollectionSectionViewModel()
        model1.headerTitle = BehaviorRelay<Any?>(value: "Header1_s1")
        model1.footerTitle = BehaviorRelay<Any?>(value: "Footer1_s1")
        model1.editingSelected = BehaviorRelay<Any?>(value: true)
        
        let model2 = RxCollectionSectionViewModel()
        model2.headerTitle = BehaviorRelay<Any?>(value: "Header2_s2")
        model2.footerTitle = BehaviorRelay<Any?>(value: "Footer2_s2")
        model2.editingSelected = BehaviorRelay<Any?>(value: false)
        
        let item1_s1 = RxCollectionItemViewModel()
        let edges:[String:CGFloat] = ["top":5,"left":10,"bottom":15,"right":20]
        item1_s1.edges = BehaviorRelay<Any?>(value: edges)
        item1_s1.title = BehaviorRelay<Any?>(value: "item1_s1")
        item1_s1.color = BehaviorRelay<Any?>(value: UIColor.random)
        let item2_s1 = RxCollectionItemViewModel()
        item2_s1.title = BehaviorRelay<Any?>(value: "item2_s1")
        item2_s1.color = BehaviorRelay<Any?>(value: UIColor.random)
        
        let item1_s2 = RxCollectionItemViewModel()
        item1_s2.title = BehaviorRelay<Any?>(value: "item1_s2")
        item1_s2.color = BehaviorRelay<Any?>(value: UIColor.random)
        let item2_s2 = RxCollectionItemViewModel()
        item2_s2.title = BehaviorRelay<Any?>(value: "item2_s2")
        item2_s2.color = BehaviorRelay<Any?>(value: UIColor.random)
        
        model1.items = BehaviorRelay<[Node]>(value: [item1_s1,item2_s1])
        model2.items = BehaviorRelay<[Node]>(value: [item1_s2,item2_s2])
        
        return BehaviorRelay<[Node]>(value: [model1,model2])
    }
}

