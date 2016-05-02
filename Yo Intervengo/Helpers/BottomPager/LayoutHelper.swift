//
//  LayoutHelper.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 1/19/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class LayoutHelper: UICollectionViewFlowLayout {
    
    
    override func collectionViewContentSize() -> CGSize {
        let count = self.collectionView?.dataSource?.collectionView(self.collectionView!, numberOfItemsInSection: 0)
        let canvasSize = self.collectionView?.frame.size
        var contentSize = canvasSize
        let canW = canvasSize?.width
        let canH = canvasSize?.height
        
        if self.scrollDirection == UICollectionViewScrollDirection.Horizontal
        {
            let rowCount = (canH! - self.itemSize.height) / (self.itemSize.height + self.minimumInteritemSpacing) + 1
            let columnCount = (canW! - self.itemSize.width) / (self.itemSize.width + self.minimumLineSpacing) + 1
            
            let t = Float(count!) / (Float(rowCount) * Float(columnCount))
            let page = ceilf(t)
            contentSize?.height = CGFloat(page) * canW!;
        }
        
        return contentSize!
    }
    
    
    func frameForItemAtIndexPath(indexPath:NSIndexPath)->CGRect{
        let canvasSize = self.collectionView?.frame
        let rowCount = (canvasSize!.height - self.itemSize.height) / (self.itemSize.height + self.minimumInteritemSpacing) + 1
        let columnCount = (canvasSize!.width - self.itemSize.width) / (self.itemSize.width + self.minimumLineSpacing) + 1
        let pageMarginX = (canvasSize!.width - columnCount * self.itemSize.width - (columnCount > 1 ? (columnCount - 1) * self.minimumLineSpacing : 0)) / 2.0
        let pageMarginY = (canvasSize!.height - rowCount * self.itemSize.height - (rowCount > 1 ? (rowCount - 1) * self.minimumInteritemSpacing : 0)) / 2.0
        
        let page = Float(indexPath.row) / Float(rowCount * columnCount);
        let remainder = Float(indexPath.row) - Float(page) * Float(rowCount * columnCount);
        let row = Float(remainder) / Float(columnCount);
        let column = Float(remainder) - Float(row) * Float(columnCount);
        
        var cellFrame = CGRectZero
        cellFrame.origin.x = pageMarginX + CGFloat(column) * (self.itemSize.width + self.minimumLineSpacing);
        cellFrame.origin.y = pageMarginY + CGFloat(row) * (self.itemSize.height + self.minimumInteritemSpacing);
        cellFrame.size.width = self.itemSize.width;
        cellFrame.size.height = self.itemSize.height;
        
        if (self.scrollDirection == UICollectionViewScrollDirection.Horizontal)
        {
            cellFrame.origin.x += CGFloat(Int(page) * Int(canvasSize!.width));
        }
        
        return cellFrame
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attr =  super.layoutAttributesForItemAtIndexPath(indexPath)
        attr!.frame = self.frameForItemAtIndexPath(indexPath)
        return attr
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let originAttrs = super.layoutAttributesForElementsInRect(rect)
        let attrs = NSMutableArray()
        
        for (_, attr) in (originAttrs!).enumerate() {
            let idxPath = attr.indexPath
            let itemFrame = self.frameForItemAtIndexPath(idxPath)
            if (CGRectIntersectsRect(itemFrame, rect))
            {
                let attr2 = self.layoutAttributesForItemAtIndexPath(idxPath)
                attrs.addObject(attr2!)
            }
        }
        return attrs as? [UICollectionViewLayoutAttributes]
    }
}
