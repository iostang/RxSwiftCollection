//
//  RxCollectionViewModel.swift
//  RxSwiftCollection
//
//  Created by 🥄💻 on 2019/9/3.
//  Copyright © 2019 TangChi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Action
import RxDataSources
import NSObject_Rx

class RxCollectionViewModel: RxBaseViewModel {

    private lazy var dataSource: RxCollectionViewSectionedReloadDataSource<RxSectionData> = {
        return self.createDataSources()
    }()
    
    private func createDataSources() -> RxCollectionViewSectionedReloadDataSource<RxSectionData> {
        let dataSource = RxCollectionViewSectionedReloadDataSource<RxSectionData>(
            configureCell: { (ds, cv, ip, item) -> UICollectionViewCell in
                
            guard let itemNode = ds.sectionModels[ip.section].node?.items.value[ip.item] as? RxCollectionItemViewModel else {
                return RxCollectionViewCell()
            }
            let cell = cv.dequeueReusableCell(withReuseIdentifier: "\(RxCollectionViewCell.self)", for: ip) as! RxCollectionViewCell
            cell.contentView.backgroundColor = UIColor.black
            itemNode.title
                    .map { $0 as? String}
                    .asDriver(onErrorJustReturn: nil)
                    .drive(cell.titleLabel.rx.text)
                    .disposed(by: cell.rx.disposeBag)
            itemNode.color
                    .map { $0 as? UIColor}
                    .asDriver(onErrorJustReturn: nil)
                    .drive(cell.titleLabel.rx.backgroundColor)
                    .disposed(by: cell.rx.disposeBag)
            itemNode.edges
                .map{ $0 as? [String:CGFloat] }
                    .asDriver(onErrorJustReturn: [String:CGFloat]())
                    .drive(cell.rx.edges)
                    .disposed(by: cell.rx.disposeBag)
                
            return cell
        }, configureSupplementaryView: { (ds, cv, kind, ip) -> UICollectionReusableView in
            
            guard let sectionNode = ds.sectionModels[ip.section].node else { return RxCollectionReusableView() }
            
            let section = cv.dequeueReusableSupplementaryView(ofKind: kind,
                                                              withReuseIdentifier: kind,
                                                              for: ip) as! RxCollectionReusableView

            switch kind {
            case UICollectionView.elementKindSectionHeader:
                sectionNode.headerTitle
                    .map { $0 as? String}
                    .asDriver(onErrorJustReturn: nil)
                    .drive(section.titleLabel.rx.text)
                    .disposed(by: section.rx.disposeBag)
            case UICollectionView.elementKindSectionFooter:
                sectionNode.footerTitle
                    .map { $0 as? String}
                    .asDriver(onErrorJustReturn: nil)
                    .drive(section.titleLabel.rx.text)
                    .disposed(by: section.rx.disposeBag)
            default:
                section.titleLabel.text = ""
            }
            
            return section
            
        }, moveItem: { (ds, sourceIndexPath, destinationIndexPath) in
            
        }, canMoveItemAtIndexPath: { (ds, ip) -> Bool in
            return true
        })
        
        return dataSource
    }
    
    func registry(view: RxCollectionView) {
    
        view.collectionView.register(RxCollectionViewCell.self,
                                     forCellWithReuseIdentifier: "\(RxCollectionViewCell.self)")
        
        view.collectionView.register(RxCollectionReusableView.self,
                                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                     withReuseIdentifier: UICollectionView.elementKindSectionHeader)
        
        view.collectionView.register(RxCollectionReusableView.self,
                                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                     withReuseIdentifier: UICollectionView.elementKindSectionFooter)
    }
    
    
    // MARK: 绑定items
    func bindItems(view: RxCollectionView) {

        items
            .map {$0.map {$0 as! RxCollectionSectionViewModel}}
            .flatMapLatest { sections in
                return Observable<[[Node]]>.combineLatest(sections.map {$0.items}) {$0}
            }
            .map { nodess in
                
                return nodess.enumerated().map { index, nodes -> RxSectionData in
                
                    let items: [RxItemData] = nodes.map { node in
                        return RxItemData(node: node)
                    }

                    let section = self.items.value[index] as! RxCollectionSectionViewModel

                    let data = RxSectionData(items: items,
                                             node: section)
                    return data
                }
            }
            .bind(to: view.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: view.rx.disposeBag)
        
        view.collectionView
            .rx
            .itemSelected
            .do (onNext: { [weak self] indexPath in
                self?.dataSource[indexPath.section].node?.headerTitle.accept("header\(indexPath.section)\(arc4random() % 1000)")
                let a = self?.dataSource[indexPath.section].node?.items.value[indexPath.row] as? RxCollectionItemViewModel
                a?.title.accept("item \n\(arc4random() % 1000)")
                a?.color.accept(UIColor.random)
            })
            .subscribe()
            .disposed(by: view.rx.disposeBag)
        
    }
    
}
