//
//  ViewController.swift
//  Task
//
//  Created by Venkatesh Bathina on 16/07/19.
//  Copyright © 2019 Venkatesh Bathina. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var homeViewModel = HomeViewModel()
    let active: UIActivityIndicatorView = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeViewModel.setupCollectionView(self.collectionView)
        self.collectionView.delegate = self.homeViewModel
        self.collectionView.dataSource = self.homeViewModel
        self.homeViewModel.homeViewModelDelegate = self
        self.homeViewModel.pagination(key: "")
    }
}
extension ViewController: FirebaseHomeViewModelDelegate {

    func reloadCollectionView() {
        self.UI {
            self.collectionView.reloadData()
        }
    }
    func error(error: String) {
        self.dismiss()
    }
    func show() {
        self.startLoading()
    }
    func dismiss() {
        self.stopLoading()
    }
    
}

extension ViewController {
    
    func startLoading(){
        active.center = self.view.center
        active.tintColor = UIColor.orange
        active.style = .gray
        active.startAnimating()
        active.isUserInteractionEnabled = false
        self.view.isUserInteractionEnabled = false
        active.hidesWhenStopped = true
        self.view.addSubview(active)
    }
    func stopLoading(){
        active.isUserInteractionEnabled = true
        self.view.isUserInteractionEnabled = true
        active.stopAnimating()
        // UIApplication.shared.endIgnoringInteractionEvents()
    }
    func UI(_ block: @escaping ()->Void) {
        DispatchQueue.main.async(execute: block)
    }
}
