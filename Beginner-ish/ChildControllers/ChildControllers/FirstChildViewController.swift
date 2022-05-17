//
//  FirstChildViewController.swift
//  ChildControllers
//
//  Created by Ramy Atalla on 2022-05-17.
//

import UIKit

class FirstChildViewController: UIViewController {

    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
// To be debuged later, the view.bounds.height shows
// the height of original view, not the childview.
//        let itemHeight = view.bounds.height * 0.1
//        print("DEBUG: \(itemHeight)")
//        let viewbounds = view.bounds
//        print("DEBUG: \(viewbounds)")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150,
                                 height: 150)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(collectionView!)
        view.backgroundColor = .yellow
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
}

extension FirstChildViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
    
}
