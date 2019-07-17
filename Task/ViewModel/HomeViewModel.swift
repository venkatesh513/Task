//
//  HomeViewModel.swift
//  Task
//
//  Created by Venkatesh Bathina on 16/07/19.
//  Copyright © 2019 Venkatesh Bathina. All rights reserved.
//

import Foundation
import UIKit
protocol FirebaseHomeViewModelDelegate: AnyObject {
    func reloadCollectionView()
    func error(error: String)
    func show()
    func dismiss()
}
class HomeViewModel: NSObject {
    var namesData = [Names]()
    var homeViewModelDelegate: FirebaseHomeViewModelDelegate?
    
    func setupCollectionView(_ collectionView:UICollectionView) {
        collectionView.transform = CGAffineTransform.init(rotationAngle: (-(CGFloat)(Double.pi)))
    }
    func pagination(key:String) {
        self.homeViewModelDelegate?.show()
        FirebaseDataManager.shared.getNames(key: key, data: self.namesData, { (names) in
            self.namesData += names
            if self.namesData.count > 0 {
                self.homeViewModelDelegate?.reloadCollectionView()
            }
             self.homeViewModelDelegate?.dismiss()
        }) { (errorStr) in
            self.homeViewModelDelegate?.dismiss()
        }
    }
}
extension HomeViewModel: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.namesData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! namesCell
        
        cell.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        cell.countLbl.text = self.namesData[indexPath.item].name
        let lastindex = self.namesData.last?.name ?? "0"
        if lastindex == self.namesData[indexPath.item].name && indexPath.item == self.namesData.count - 1 {
           self.pagination(key: self.namesData.last!.refKey)
        }
        
        return cell
    }
}
