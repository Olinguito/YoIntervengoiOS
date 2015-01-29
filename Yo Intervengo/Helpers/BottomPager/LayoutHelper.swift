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
        var canvasSize = self.collectionView?.frame.size
        var contentSize = canvasSize
        var canW = canvasSize?.width
        var canH = canvasSize?.height
        
        if self.scrollDirection == UICollectionViewScrollDirection.Horizontal
        {
            var rowCount = (canH! - self.itemSize.height) / (self.itemSize.height + self.minimumInteritemSpacing) + 1
            var columnCount = (canW! - self.itemSize.width) / (self.itemSize.width + self.minimumLineSpacing) + 1
            
            var t = Float(count!) / (Float(rowCount) * Float(columnCount))
            var page = ceilf(t)
            contentSize?.height = CGFloat(page) * canW!;
        }

        return contentSize!
    }
    
    
    func frameForItemAtIndexPath(indexPath:NSIndexPath)->CGRect{
        var canvasSize = self.collectionView?.frame
        var rowCount = (canvasSize!.height - self.itemSize.height) / (self.itemSize.height + self.minimumInteritemSpacing) + 1
        var columnCount = (canvasSize!.width - self.itemSize.width) / (self.itemSize.width + self.minimumLineSpacing) + 1
        var pageMarginX = (canvasSize!.width - columnCount * self.itemSize.width - (columnCount > 1 ? (columnCount - 1) * self.minimumLineSpacing : 0)) / 2.0
        var pageMarginY = (canvasSize!.height - rowCount * self.itemSize.height - (rowCount > 1 ? (rowCount - 1) * self.minimumInteritemSpacing : 0)) / 2.0
        
        var page = Float(indexPath.row) / Float(rowCount * columnCount);
        var remainder = Float(indexPath.row) - Float(page) * Float(rowCount * columnCount);
        var row = Float(remainder) / Float(columnCount);
        var column = Float(remainder) - Float(row) * Float(columnCount);
        
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

    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes! {
        var attr =  super.layoutAttributesForItemAtIndexPath(indexPath)
        attr.frame = self.frameForItemAtIndexPath(indexPath)
        return attr
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        var originAttrs = super.layoutAttributesForElementsInRect(rect)
        var attrs = NSMutableArray()
        
        for (index, attr) in enumerate(originAttrs!) {
            var idxPath = attr.indexPath
            var itemFrame = self.frameForItemAtIndexPath(idxPath)
            if (CGRectIntersectsRect(itemFrame, rect))
            {
                var attr2 = self.layoutAttributesForItemAtIndexPath(idxPath)
                attrs.addObject(attr2)
            }
        }
        return attrs
    }
    
}
