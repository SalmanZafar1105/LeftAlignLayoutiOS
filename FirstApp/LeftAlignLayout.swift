//
//  LeftAlignLayout.swift
//  FirstApp
//
//  Created by SALMAN ZAFAR on 10/01/20.
//  Copyright © 2020 SALMAN ZAFAR. All rights reserved.
//

import UIKit

protocol LeftAlignLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView?, interItemSpacingForSectionAt section: Int) -> CGFloat?
    func collectionView(collectionView: UICollectionView?, insetForSectionAt section: Int) -> UIEdgeInsets?
    func collectionView(collectionView: UICollectionView?, lineSpacingForSectionAt section: Int) -> CGFloat?
    func collectionView(collectionView: UICollectionView?, sizeForItemAtIndexPath indexPath: IndexPath) -> CGSize
}

class LeftAlignLayout: UICollectionViewLayout {
    
    var contentBounds: CGRect = CGRect.zero
    var cachedAttributes: [Int: [UICollectionViewLayoutAttributes]] = [:]
    
    let defaultInterItemSpace: CGFloat = 5.0
    let defaultEdgeInsets: UIEdgeInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    let defaultLineSpace: CGFloat = 5.0
    
    var delegate: LeftAlignLayoutDelegate?
    
    override func prepare() {
        
        super.prepare()
        
        guard let collectionView = collectionView else {
            NSLog("LeftAlignLayout: collectionView is nil.")
            return
        }
        guard let delegate = delegate else {
            NSLog("LeftAlignLayout: LeftAlignLayoutDelegate is nil.")
            return
        }
        
        let numSections = collectionView.numberOfSections
        
        var contentHeight: CGFloat = 0.0
        
        for i in 0..<numSections {
            
            let numItems = collectionView.numberOfItems(inSection: i)
            var attributes: [UICollectionViewLayoutAttributes] = []
            
            var interItemSpace = defaultInterItemSpace
            if let newInterItemSpace = delegate.collectionView(collectionView: collectionView, interItemSpacingForSectionAt: i) {
                
                interItemSpace = newInterItemSpace
            }
            var edgeInsets = defaultEdgeInsets
            if let newEdgeInsets = delegate.collectionView(collectionView: collectionView, insetForSectionAt: i) {
                
                edgeInsets = newEdgeInsets
            }
            var lineSpace = defaultLineSpace
            if let newLineSpace = delegate.collectionView(collectionView: collectionView, lineSpacingForSectionAt: i) {
                
                lineSpace = newLineSpace
            }
            
            var x_offset = edgeInsets.left
            var y_offset = contentHeight + edgeInsets.top
            let contentWidth = collectionView.bounds.size.width - (edgeInsets.right + edgeInsets.left)
            var maxHeightInPreviousRow: CGFloat = 0.0
            
            for j in 0..<numItems {
                
                let indexPath = IndexPath(item: j, section: i)
                let size = delegate.collectionView(collectionView: collectionView, sizeForItemAtIndexPath: indexPath)
                
                if(x_offset + interItemSpace + size.width > contentWidth) {
                    
                    // Line change
                    x_offset = edgeInsets.left
                    y_offset = y_offset + maxHeightInPreviousRow + lineSpace
                }
                
                let x = x_offset
                let y = y_offset
                
                let frame = CGRect(x: x, y: y, width: size.width, height: size.height)
                
                let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attribute.frame = frame
                
                attributes.append(attribute)
                
                if(size.height > maxHeightInPreviousRow) {
                    
                    maxHeightInPreviousRow = size.height
                }
                
                x_offset = x_offset + interItemSpace + size.width
            }
            
            cachedAttributes[i] = attributes
            
            attributes = []
            contentHeight = contentHeight + y_offset + maxHeightInPreviousRow + edgeInsets.bottom
        }
        
        contentBounds = CGRect(x: 0.0, y: 0.0, width: collectionView.bounds.size.width, height: contentHeight)
    }
    
    override var collectionViewContentSize: CGSize {
        
        return contentBounds.size
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var requiredAttributes: [UICollectionViewLayoutAttributes] = []
        
        for (_,attributes) in cachedAttributes {
            
            for attribute in attributes {
                
                if(attribute.frame.intersects(rect)) {
                    
                    requiredAttributes.append(attribute)
                }
            }
        }
        
        return requiredAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        if let attributes = cachedAttributes[indexPath.section] {
            
            return attributes[indexPath.item]
        }
        
        return nil
    }
}
