//
//  PokemonTypeEfficacyCollectionViewLayout.swift
//  Pkmn
//
//  Created by Jerome Ceccato on 23/07/2019.
//  Copyright © 2019 IATGOF. All rights reserved.
//

import UIKit

class PokemonTypeEfficacyCollectionViewLayout: UICollectionViewLayout {
    private var computedContentSize: CGSize = .zero
    private var cellAttributes = [IndexPath: UICollectionViewLayoutAttributes]()
    private var sectionHeaderAttributes = [Int: UICollectionViewLayoutAttributes]()
    private var footerAttributes: UICollectionViewLayoutAttributes?

    private let contentInset = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
    private let sectionSize = CGSize(width: 50, height: 30)
    private let sectionOffsetY: CGFloat = 8
    private let sectionSpacingX: CGFloat = 6
    private let itemsPerRow = 4
    private let itemSpacing: CGFloat = 6
    private let lineSpacing: CGFloat = 0
    private let footerSpacing: CGFloat = 8
    private let footerHeight: CGFloat = 50

    override func prepare() {
        guard let collectionView = collectionView else {
            return
        }

        computedContentSize = .zero
        cellAttributes.removeAll()
        sectionHeaderAttributes.removeAll()
        footerAttributes = nil
        
        var currentOffset = CGPoint(x: contentInset.left, y: contentInset.top)
        let itemSize = computedCellSize()

        for section in 0 ..< collectionView.numberOfSections {
            currentOffset.y += sectionOffsetY
            
            let sectionAttributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, with: IndexPath(item: 0, section: section))
            
            sectionAttributes.frame = CGRect(origin: currentOffset, size: sectionSize)

            currentOffset.x += sectionSize.width + sectionSpacingX
            let indentedOffset = currentOffset.x

            for item in 0 ..< collectionView.numberOfItems(inSection: section) {
                let indexPath = IndexPath(item: item, section: section)
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                if (item > 0 && (item % itemsPerRow) == 0) {
                    currentOffset.x = indentedOffset
                    currentOffset.y += itemSize.height + lineSpacing
                }
                
                attributes.frame = CGRect(origin: currentOffset, size: itemSize)

                currentOffset.x += itemSize.width + itemSpacing
                
                cellAttributes[indexPath] = attributes
            }
            
            currentOffset.x = contentInset.left
            currentOffset.y += itemSize.height

            sectionHeaderAttributes[section] = sectionAttributes
        }

        currentOffset.y += itemSpacing // + footerSpacing
        
        /*
        if collectionView.numberOfSections > 0 {
            let offsetY = max(currentOffset.y, collectionView.bounds.height - footerHeight)
            footerAttributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, with: IndexPath(index: 0))
            footerAttributes?.frame = CGRect(x: 0, y: offsetY, width: collectionView.bounds.width, height: footerHeight)
        }
        */
        currentOffset.y += /*footerHeight +*/ contentInset.bottom
        computedContentSize = CGSize(width: collectionView.bounds.width, height: currentOffset.y)
    }
    
    private func computedCellSize() -> CGSize {
        let totalSize = collectionView!.bounds.width
        let sectionTotalSize = contentInset.left + contentInset.right + sectionSpacingX + sectionSize.width
        let totalItemSpacing = CGFloat(itemsPerRow - 1) * itemSpacing
        let availableSize = totalSize - (sectionTotalSize + totalItemSpacing)
        let width = floor(availableSize / CGFloat(itemsPerRow))

        return CGSize(width: width, height: sectionSize.height)
    }
    
    override var collectionViewContentSize: CGSize {
        return computedContentSize
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributeList = [UICollectionViewLayoutAttributes]()
        
        for (_, attributes) in cellAttributes {
            if attributes.frame.intersects(rect) {
                attributeList.append(attributes)
            }
        }
        
        for (_, attributes) in sectionHeaderAttributes {
            if attributes.frame.intersects(rect) {
                attributeList.append(attributes)
            }
        }
        
        if let footerAttributes = footerAttributes, footerAttributes.frame.intersects(rect) {
            attributeList.append(footerAttributes)
        }

        return attributeList
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cellAttributes[indexPath]
    }
    
    override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        if elementKind == UICollectionView.elementKindSectionHeader {
            return sectionHeaderAttributes[indexPath.section]
        } else if elementKind == UICollectionView.elementKindSectionFooter {
            return footerAttributes
        }
        return nil
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
