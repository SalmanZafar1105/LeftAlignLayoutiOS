//
//  ViewController.swift
//  FirstApp
//
//  Created by SALMAN ZAFAR on 06/01/20.
//  Copyright © 2020 SALMAN ZAFAR. All rights reserved.
//

import UIKit

class ViewController: UIViewController, LeftAlignLayoutDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let testLayout = LeftAlignLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        testLayout.delegate = self
        
        let testNib = UINib(nibName: "TestCollectionViewCell", bundle: nil)
        collectionView.register(testNib, forCellWithReuseIdentifier: "TestCell")
        collectionView.dataSource = self
        collectionView.collectionViewLayout = testLayout
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: "TestCell", for: indexPath)
    }
    
    //MARK: - LeftAlignLayoutDelegate
    func collectionView(collectionView: UICollectionView?, interItemSpacingForSectionAt section: Int) -> CGFloat? {
        
        // Using default values. For more info see 'defaultInterItemSpace' in LeftAlignLayout.
        return nil
    }
    
    func collectionView(collectionView: UICollectionView?, insetForSectionAt section: Int) -> UIEdgeInsets? {
        
        // Using default values. For more info see 'defaultEdgeInsets' in LeftAlignLayout.
        return nil
    }
    
    func collectionView(collectionView: UICollectionView?, lineSpacingForSectionAt section: Int) -> CGFloat? {
        
        // Using default values. For more info see 'defaultLineSpace' in LeftAlignLayout.
        return nil
    }
    
    func collectionView(collectionView: UICollectionView?, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize {
        
        let width = ceil(CGFloat.random(in: 10.0...50.0))
        return CGSize(width: width, height: 15.0)
    }
}
