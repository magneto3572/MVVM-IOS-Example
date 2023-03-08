//
//  ProductCell.swift
//  TestApp
//
//  Created by Bishal EUR0409 on 07/03/23.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var ProductBackgroundView: UIView!
    @IBOutlet weak var ProductTitle: UILabel!
    @IBOutlet weak var ProductCategory: UILabel!
    @IBOutlet weak var RateButton: UIButton!
    @IBOutlet weak var ProductDescription: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var ProductImageView: UIImageView!
    
    
    var product : Product? {
        didSet { // Property Observer
            productDetailConfiguration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ProductBackgroundView.clipsToBounds = false
        ProductBackgroundView.layer.cornerRadius = 15
        ProductImageView.layer.cornerRadius = 10
        ProductBackgroundView.backgroundColor = .systemGray6
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func productDetailConfiguration(){
        guard let product else {return}
        ProductTitle.text = product.title
        ProductCategory.text = product.category
        ProductDescription.text = product.description
        PriceLabel.text = "$\(product.price)"
        RateButton.setTitle("\(product.rating.rate)", for: .normal)
        ProductImageView.setImage(with: product.image)
        
    }
    
}
