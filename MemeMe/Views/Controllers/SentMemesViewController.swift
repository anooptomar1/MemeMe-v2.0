//
//  SentMemesViewController.swift
//  MemeMe
//
//  Created by Leonardo Vinicius Kaminski Ferreira on 25/09/17.
//  Copyright © 2017 Leonardo Ferreira. All rights reserved.
//

import UIKit

class SentMemesViewController: UIViewController {
    
    enum MemesCollectionCell: String {
        case collectionMeme
    }

    @IBOutlet weak var sentMemesCollectionView: UICollectionView!
    @IBOutlet weak var sentMemesCollectionFlowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureCollectionViewFlowLayout()
        sentMemesCollectionView.reloadData()
    }
    
    // MARK: - Prepare for segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? MemeDetailViewController {
            if let meme = sender as? Meme {
                controller.meme = meme
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

// MARK: - Collection view data source and delegate

extension SentMemesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Memes.shared.memesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MemesCollectionCell.collectionMeme.rawValue, for: indexPath) as? SentMemeCollectionViewCell {
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? SentMemeCollectionViewCell {
            cell.confugureCell(with: Memes.shared.memesArray[indexPath.item])
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showMemeDetail", sender: Memes.shared.memesArray[indexPath.item])
    }
    
}

// MARK: - Flow layout

extension SentMemesViewController {
    func configureCollectionViewFlowLayout() {
        
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.height - (2 * space)) / 3.0
        
        sentMemesCollectionFlowLayout.minimumInteritemSpacing = space
        sentMemesCollectionFlowLayout.minimumLineSpacing = space
        sentMemesCollectionFlowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
}
