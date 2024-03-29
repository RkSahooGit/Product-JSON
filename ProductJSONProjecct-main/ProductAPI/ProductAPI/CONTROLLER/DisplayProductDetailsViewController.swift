//
//  DisplayProductDetailsViewController.swift
//  ProductAPI
//
//  Created by Rakesh Kumar Sahoo on 04/03/24.
//

import UIKit
import Kingfisher



class DisplayProductDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
    
    
    private var resultPosts: [UserPost] = []
    
    
    @IBOutlet weak var collectiontable: UICollectionView!
    @IBOutlet weak var idOfProduct: UILabel!
    @IBOutlet weak var titleOfProduct: UILabel!
    @IBOutlet weak var imageOfProduct: UIImageView!
    @IBOutlet weak var descriptionOfProduct: UILabel!
    @IBOutlet weak var brandOfProduct: UILabel!
    @IBOutlet weak var categoryOfProduct: UILabel!
    @IBOutlet weak var priceOfProduct: UILabel!
    @IBOutlet weak var ratingOfProduct: UILabel!
    @IBOutlet weak var discountOfProduct: UILabel!
    @IBOutlet weak var stockOfProduct: UILabel!
    
    var imageUrlString = ""
    var id  = ""
    var titles  = ""
    var descriptions  = ""
    var brand  = ""
    var category  = ""
    var price  = ""
    var rating  = ""
    var discounts  = ""
    var stocks  = ""
    var arrayOfImages : [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectiontable.delegate = self
        collectiontable.dataSource = self
        collectiontable.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: "collectionCell1")

        navigationItem.title = "Device Details"
        idOfProduct.text = id
        titleOfProduct.text = titles
        descriptionOfProduct.text = descriptions
        brandOfProduct.text = brand
        categoryOfProduct.text = category
        priceOfProduct.text = price
        ratingOfProduct.text = rating
        discountOfProduct.text = discounts
        stockOfProduct.text = stocks
        imageOfProduct.setImage(with: imageUrlString)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrayOfImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectiontable.dequeueReusableCell(withReuseIdentifier: "collectionCell1", for: indexPath) as! ProductCollectionViewCell
        cell.collectionImagesCells.setImage(with: arrayOfImages[indexPath.row])
        return cell
    }
}


