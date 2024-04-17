//
//  ViewController.swift
//  ImageListAssignment
//
//  Created by Manoj Shivhare on 16/04/24.
//

import UIKit

class ViewController: UIViewController {
    //MARK: ----------IBoutlet----------
    @IBOutlet weak var imageCollectionView: UICollectionView!

    //MARK: ----------Variable----------
    private var viewModel: ImageViewModel?
    private var imageArr: [ImageModel]?
    private var activityIndicator: UIActivityIndicatorView?
    
    //MARK: ----------Life Cycle----------
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupViewModel()
    }
    
    //MARK: ----------Private method----------
    private func setupCollectionView(){
        imageCollectionView.register(UINib(nibName: "ImagesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImagesCollectionViewCell")

        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
    }
    
    private func setupViewModel(){
        showProgressView(in: self.view)
        viewModel = ImageViewModel(delegate: self)
        viewModel?.getAllImagesFromAPI()
    }
    
    private func reloadCollectionView(){
        DispatchQueue.main.async {
            self.imageCollectionView.reloadData()
        }
    }
}

//MARK: ----------Extension UICollectionViewProtocol----------
extension ViewController:UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImagesCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesCollectionViewCell", for: indexPath) as! ImagesCollectionViewCell
        if let photoModel = imageArr?[indexPath.item] {
            let fullUrl = photoModel.thumbnail.domain + "/" + photoModel.thumbnail.basePath + "/0/" + photoModel.thumbnail.key
            cell.cellViewModel = ImageCollectionViewCellVM(imageUrl: fullUrl)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let yourWidth = (collectionView.bounds.width/3.0) - 5
        return CGSize(width: yourWidth, height: yourWidth)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
//MARK: ----------Extension ImageVMProtocol----------
extension ViewController: ImageVMProtocol{
    func recieveApiResponse(responseArr: [ImageModel]?, error: Error?) {
        hideProgressView()
        if error != nil {
            showAlertWith(message: error?.localizedDescription)
        }else{
            imageArr = responseArr
            reloadCollectionView()
        }
    }
}

extension ViewController{
    
    private func showAlertWith(message: String?){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(OKAction)
                self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: ----------Show Progress View---------------
    private func showProgressView(in view:UIView) {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator?.frame = view.bounds
        if let progressBar = activityIndicator{
            view.addSubview(progressBar)
        }
        activityIndicator?.startAnimating()
    }
    
    //MARK: ------------Hide Progress View-----------------
    private func hideProgressView() {
        DispatchQueue.main.async {
            self.activityIndicator?.stopAnimating()
            self.activityIndicator?.removeFromSuperview()
        }
    }
    
}
