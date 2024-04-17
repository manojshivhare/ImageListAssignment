//
//  ImagesCollectionViewCell.swift
//  ImageListAssignment
//
//  Created by Manoj Shivhare on 16/04/24.
//

import UIKit

class ImagesCollectionViewCell: UICollectionViewCell {
    
    //MARK: ----------IBOutlet----------
    @IBOutlet weak var cellImageView: LazyImageView!
    
    //MARK: ----------variable----------
    var cellViewModel: ImageCollectionViewCellVM?{
        didSet{
            updateCellData()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        cellImageView.clipsToBounds = true
    }
    
    private func updateCellData(){
        //Fetching image from url
        if let imageUrl = URL(string: cellViewModel?.imageUrl ?? ""){
            cellImageView.loadImageView(imageUrl: imageUrl)
        }
    }

}
