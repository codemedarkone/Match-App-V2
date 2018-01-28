//
//  ViewController.swift
//  Match App V2
//
//  Created by chris  on 1/19/18.
//  Copyright © 2018 kuronuma studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var model = CardModel()
    var cardArray = [Card]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Call the getCards method of the card model
        cardArray = model.getCards()
        
        collectionView.delegate = self
        collectionView.dataSource = self

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - UICollectionView Protocol Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //get a CardCollectionViewCell Object
        let cell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell",
                                               for: indexPath) as! CardCollectionViewCell
        
        //Get the card that the collection view is trying to display
        let card = cardArray[indexPath.row]
        
        //set that card for cell
        cell.setCard(card)
        
         return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // get the cell that the user selected
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        //card that the user selected
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false {
            //flip the card
            cell.flip()
            
            card.isFlipped = true
        }
        else {
            cell.flipBack()
            
            card.isFlipped = false
            
        }
    }

    
   
}

