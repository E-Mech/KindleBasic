//
//  BookPagerController.swift
//  KindleBasic
//
//  Created by Hoe Zhan Hui on 4/29/17.
//  Copyright © 2017 VMax. All rights reserved.
//

import UIKit

class BookPagerController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        
        navigationItem.title = self.book?.title
        
        
        //.self returns the class type which is needed as parameter for register
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        
        
        //downcast to UICollectionViewFlowLayout from collectionViewLayout to access the scroll direction properties
        let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        
        
        layout?.scrollDirection = .horizontal
        
        //to remove the side spacing
        layout?.minimumLineSpacing = 0
        
        collectionView?.isPagingEnabled = true
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(handleCloseBook))
        
    }
    
    func handleCloseBook() {
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 44 - 20)
        //44 --> navbar, 20 --> status bar
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return book?.pages.count ?? 0 //Another safe way to unwrap!! if nil, default value 0 is used
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let pageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        
        let page = book?.pages[indexPath.item]
        
        pageCell.textLabel.text = page?.text
       // cell.backgroundColor = .red
        
        
        //indexPath.item for collectionView
        //indexPath.row for TableView
        return pageCell
    }
}
