//
//  ViewController.swift
//  Asteroids From NASA
//
//  Created by Алексей Россошанский on 03.11.17.
//  Copyright © 2017 Alexey Rossoshasky. All rights reserved.
//

import UIKit



class EarthAndAsteroidsVC: UIViewController {
    
    //MARK: VC VARs
    var asteroidsArray = [AsteroidModel]()
    var earthImage = UIImageView()
    //var for appearing infoView
    var newView = InfoView()
    
    //Exemp of class where object creation realize (for transfering some logic to another class)
    var formationOfEarthAndAteroidsExemp: FormationOfEarthAndAsteroids!
    
    
    //MARK: Outlets
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    //MARK: Vars for Gradient and Stars (CALayer)
    var gradientLayer = CAGradientLayer()
    var starLayer = CAShapeLayer()
    
}


//MARK:  View Loads
extension EarthAndAsteroidsVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        datePicker.setValue(#colorLiteral(red: 0.7763333211, green: 0.9975497208, blue: 1, alpha: 1), forKeyPath: "textColor")

        
        view.layer.addSublayer(starLayer)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        formationOfEarthAndAteroidsExemp = FormationOfEarthAndAsteroids(byVC: self, andView: self.view, array: asteroidsArray, newView: newView)
        //Add earth on View
        formationOfEarthAndAteroidsExemp.addEarthOnView(view: self.view, imageOfEarth: self.earthImage)
        
        CurrentDate.today()
        getAsteroidsRequest()
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        GradientAndStars.configGradientLayer(gradientLayer)
        gradientLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        GradientAndStars.configStarLayer(starLayer, view: self.view)
    }
    
}


//MARK: Date picker
extension EarthAndAsteroidsVC {
    @IBAction func chooseDate(_ sender: UIButton) {
        
        let date = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        DateSingleton.shared.chosenDate = dateFormatter.string(from: date)
        
        getAsteroidsRequest()
        
    }
    
}


//MARK: Request
extension EarthAndAsteroidsVC {
    
    func getAsteroidsRequest() {
        
        
        GetAsteroidsManager.getList(success: { (asteroids) in
            
            DispatchQueue.main.async { [weak self] in
                
                FormationOfEarthAndAsteroids.removeSubviews(subviews: (self?.view.subviews)!)
                self?.asteroidsArray.removeAll()
                self?.asteroidsArray.append(contentsOf: asteroids)
                
                //Сheck for emptiness array of asteroids
                if !(self?.asteroidsArray.isEmpty)! {
                    //Refilling because asteroids array is not empty already
                    self?.formationOfEarthAndAteroidsExemp = FormationOfEarthAndAsteroids(byVC: self!, andView: (self?.view)!, array: (self?.asteroidsArray)!, newView: (self?.newView)!)
                    //Add asterids on View
                    self?.formationOfEarthAndAteroidsExemp.addAsteroidsOnView(asteroidsArray: (self?.asteroidsArray)!, earthImage: (self?.earthImage)!, view: (self?.view)!)
                }
            }
            
        }) { (requestError) in
            print(requestError)
        }
        
    }
}



