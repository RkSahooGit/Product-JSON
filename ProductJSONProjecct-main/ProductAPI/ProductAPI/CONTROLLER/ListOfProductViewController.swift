//
//  ViewController.swift
//  ProductAPI
//
//  Created by Rakesh Kumar Sahoo on 04/03/24.
//

import UIKit
import Kingfisher

class ListOfProductViewController: UIViewController {
    
    @IBOutlet weak var productListTable: UITableView!
    
    var getProductApi = GetProductApi()
    var resultPosts: [UserPost] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productListTable.delegate = self
        productListTable.dataSource = self
        productListTable.register(UINib(nibName: "productListTableViewCell", bundle: nil), forCellReuseIdentifier:"ListCellXib")
        hitGetAllPosts()
    }
    func hitGetAllPosts() {
        getProductApi.getAllPosts {[weak self] result in
            switch result {
            case .success(let success):
                self?.resultPosts =  success.products
                DispatchQueue.main.async {
                    self?.productListTable.reloadData()
                }
            case .failure(let error):
                switch error {
                case .invalidUrl:
                    print("Invalid URL Error")
                case .noData:
                    print("No data found")
                case .decodingError:
                    print("Decoding Error")
                }
            }
        }
    }
    
}
extension ListOfProductViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultPosts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCellXib", for: indexPath) as! productListTableViewCell
        cell.productListImage.setImage(with: resultPosts[indexPath.row].thumbnail)
        cell.productListLabel.text = resultPosts[indexPath.row].title
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "IndividualProductID") as? DisplayProductDetailsViewController
        
        vc?.id = String(resultPosts[indexPath.row].id)
        vc?.titles = resultPosts[indexPath.row].title
        vc?.descriptions = resultPosts[indexPath.row].description
        vc?.brand = resultPosts[indexPath.row].brand
        vc?.category = resultPosts[indexPath.row].category
        vc?.price = String(resultPosts[indexPath.row].price)
        vc?.rating = String(resultPosts[indexPath.row].rating)
        vc?.discounts = String(resultPosts[indexPath.row].discountPercentage)
        vc?.stocks = String(resultPosts[indexPath.row].stock)
        vc?.imageUrlString = String(resultPosts[indexPath.row].thumbnail)
        vc?.arrayOfImages = resultPosts[indexPath.row].images
        
        
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

extension UIImageView{
    func setImage(with urlstring : String){
        guard let url = URL.init(string: urlstring) else {
            return
        }
        let resources = KF.ImageResource(downloadURL: url, cacheKey: urlstring)
        kf.indicatorType = .activity
        kf.setImage(with: resources)
    }
}
