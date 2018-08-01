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
    var firstFlippedCardIndex:IndexPath?
    
    
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
        
        if card.isFlipped == false && card.isMatched == false {
            
            //flip the card
            cell.flip()
            
            card.isFlipped = true
            
            //Determine if its first card or 2nd card that is flipped over
            
            if firstFlippedCardIndex == nil {
                
                //this is the first card being flipped
                firstFlippedCardIndex = indexPath
            }
            else {
                
                //this is the 2nd card being flipped
                
                //TOD: perform the matching logic
                checkForMatches(indexPath)
                
            }
        }
       
    } // end of did select method at

    // MARK: - game logic methods
    
    func checkForMatches(_ secondFlippedCardIndex:IndexPath) {
        
        //get the cell for the two cards that were revealed
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        //get cards for the two cards that were revealed
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        //compare the two cards
        if cardOne.imageName == cardTwo.imageName {
            
            //its a match
            
            //set the status's of the cards
            cardOne.isMatched = true
            cardTwo.isMatched = true
            //remove cards from grid
            cardOneCell?.remove()
            cardTwoCell?.remove()
        }
        else {
            // its not a match
            
            //set the statuses of the cards
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            // flip both cards
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
            
        }
        
        // tell collectionview to reload the cell of the first card if it is nil
        if cardOneCell == nil {
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
        }
        //reset the property that tracks the first card flipped.
        firstFlippedCardIndex = nil
    }
    
   
} // end of controller class

