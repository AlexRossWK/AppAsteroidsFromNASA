//
//  FormationOfEarthAndAsteroids.swift
//  Asteroids From NASA
//
//  Created by Алексей Россошанский on 10.11.17.
//  Copyright © 2017 Alexey Rossoshasky. All rights reserved.
//

import Foundation
import UIKit

//Class helps us to add earth and asteroids on Main View
class FormationOfEarthAndAsteroids {
    
    var viewСont: EarthAndAsteroidsVC
    var view: UIView
    var asteroidsArray = [AsteroidModel]()
    var newView = InfoView()
    
    init(byVC viewCon: EarthAndAsteroidsVC, andView view: UIView, array asterArray: [AsteroidModel], newView nV: InfoView) {
        self.viewСont = viewCon
        self.view = view
        self.asteroidsArray = asterArray
        self.newView = nV
    }
  
    
 //Func to add Earth
    func addEarthOnView(view: UIView, imageOfEarth: UIImageView) {
        
        imageOfEarth.translatesAutoresizingMaskIntoConstraints = false
        imageOfEarth.image = #imageLiteral(resourceName: "earth")
        //Add tag to exclude removing earthImage
        imageOfEarth.tag = 72
        
        //For animation (size = 0 at first)
        imageOfEarth.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        view.addSubview(imageOfEarth)
        
        UIView.animate(withDuration: 2.6, delay: 0.5, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            imageOfEarth.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)
        
        //Constraints
        let heightConstraint = imageOfEarth.heightAnchor.constraint(equalToConstant: view.frame.height)
        let widthConstraint = imageOfEarth.widthAnchor.constraint(equalToConstant: view.frame.height)
        let xPlacement = imageOfEarth.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (-(view.frame.height/2)))
        let yPlacement = imageOfEarth.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let constraints = [heightConstraint, widthConstraint, xPlacement, yPlacement]
        NSLayoutConstraint.activate(constraints)
    }
    
    func addAsteroidsOnView(asteroidsArray: [AsteroidModel], earthImage: UIImageView, view: UIView) {
        
        var asteroidSize = CGFloat(0)
        
        //Count size of the biggest asteroid (using average estimated diameter)
        let maxSize = asteroidsArray.map{ $0.averageOfestimatedDiametr }.max()!
        
        //Count distance from max X of earthImage to right border if view (- 50 for indent from border)
        let distanceBetweenMaxXofEarthAndRightBorder = view.frame.width - earthImage.frame.maxX - 50
        
        //Accumulating var, to move asteroids in proportion
        var cosmos = CGFloat(0)
        
        //Give tag for each imageView
        var tag = 0
        
        for asteroid in asteroidsArray {
            
            let imageOfAsteroid = UIImageView()
            imageOfAsteroid.translatesAutoresizingMaskIntoConstraints = false
            
            //Image for each Asteroid (3 types of images (little, medium and large) koeff 1/3)
            switch asteroid.averageOfestimatedDiametr {
            case 0...(maxSize*1/3): imageOfAsteroid.image = #imageLiteral(resourceName: "asteroid1")
            case (maxSize*1/3)...(maxSize*2/3): imageOfAsteroid.image = #imageLiteral(resourceName: "asteroid2")
            default: imageOfAsteroid.image = #imageLiteral(resourceName: "asteroid3")
            }
            
            // Set asteroids size (easiest proportion) in proportion to the Earth (Diameter of Earth = 12742000 meters, but asteroids diameter much less, so we should a thousand times(for example) reduce Earth's diameter FOR A GOOD VIEW and find proportional sizes dependings on this number)
            asteroidSize = CGFloat(asteroid.averageOfestimatedDiametr * Double(earthImage.frame.width) / Constant.App_const.diameterOfEatrhInMeters)
            
            imageOfAsteroid.transform = CGAffineTransform(scaleX: 0, y: 0)
            
            view.addSubview(imageOfAsteroid)
            
            //Constreints
            //Base
            let heightConstraint = imageOfAsteroid.heightAnchor.constraint(equalToConstant: asteroidSize)
            let widthConstraint = imageOfAsteroid.widthAnchor.constraint(equalToConstant: asteroidSize)
            let yPlacement = imageOfAsteroid.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            
            //Accumulating var + size of asteroid
            cosmos = cosmos + asteroidSize
            
            //Move asteroid as far as we need in X
            let collocation = distanceBetweenMaxXofEarthAndRightBorder - cosmos
            
            let xPlacement = imageOfAsteroid.leadingAnchor.constraint(equalTo: earthImage.trailingAnchor, constant: collocation)
            
            let constraints = [heightConstraint, widthConstraint,xPlacement, yPlacement]
            NSLayoutConstraint.activate(constraints)
            
            //Accumulating var + (distance(from earth) / 3000000 for a GOOD VIEW)
            cosmos = cosmos + CGFloat(asteroid.missDistanceKM/3000000)
            
            //Animation for Asteroids
            UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                imageOfAsteroid.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: nil)
            
            
            //Give tag for asteroids
            imageOfAsteroid.tag = tag
            
            //For info View appearance
            let tapGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            imageOfAsteroid.isUserInteractionEnabled = true
            imageOfAsteroid.addGestureRecognizer(tapGestureRecognizer)
            
            tag = tag + 1
        }
        view.layoutIfNeeded()
    }
    
    
    
    
    
    
    //MARK: Tap
    @objc  func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
        let tappedImage = tapGestureRecognizer.view!
        
        //Hold and release tap
        if tapGestureRecognizer.state == .ended {
            
            FormationOfEarthAndAsteroids.removeSubviews(subviews: [newView])
            tappedImage.layer.borderWidth = 0
            
        } else if tapGestureRecognizer.state == .began {
            
            //Highlight asteroid when tap
            tappedImage.layer.masksToBounds = false
            tappedImage.clipsToBounds = true
            tappedImage.layer.cornerRadius = tappedImage.frame.height/2
            tappedImage.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            tappedImage.layer.borderWidth = 1
            
            //Fill infoView
            
            let yCoord = tappedImage.frame.midY + tappedImage.frame.height/2 + 15
            let width = UIScreen.main.bounds.width/3
            let height = UIScreen.main.bounds.height/4
            
            //If infoView near border, lean against it
            var xCoord = CGFloat()
            let distanceToBorder = UIScreen.main.bounds.width - tappedImage.frame.midX
            switch distanceToBorder{
            case 0 ... width/2: xCoord = UIScreen.main.bounds.width - width
            default: xCoord = tappedImage.frame.midX - UIScreen.main.bounds.width/6
            }
            
            newView = InfoView(frame: CGRect(x: xCoord , y: yCoord, width: width, height: height))
            
            newView.nameLabel.text = "Name: \(asteroidsArray[tappedImage.tag].name)"
            newView.minDiamLabel.text = "Min. Size: \(Int(asteroidsArray[tappedImage.tag].minEstimatedDiameterMeters)) М."
            newView.maxDiamLabel.text = "Max. Size: \(Int(asteroidsArray[tappedImage.tag].maxEstimatedDiameterMeters)) М."
            newView.distanceLabel.text = "Distance: \(Int(asteroidsArray[tappedImage.tag].missDistanceKM)) КМ."
            
            newView.transform = CGAffineTransform(scaleX: 0, y: 0)
            
            view.addSubview(newView)
            
            UIView.animate(withDuration: 0.15, delay: 0, options: [.curveEaseOut], animations: {
                self.newView.transform = CGAffineTransform(scaleX: 1, y: 1)
                
            })
        }
    }
    
    
    
    
    //Remove subviews func
  static func removeSubviews(subviews: [UIView] ){
        for subUIView in subviews {
            if subUIView.tag != 70 && subUIView.tag != 71 && subUIView.tag != 72 {
                subUIView.removeFromSuperview()
            }
        }
        
    }
    
    
    
}
