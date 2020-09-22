//
//  ViewController.swift
//  Randog
//
//  Created by Binyamin Alfassi on 09/09/2020.
//  Copyright © 2020 Binyamin Alfassi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var breeds: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Setting Picker View's data source and delegate to be viewController
        pickerView.dataSource = self
        pickerView.delegate = self
        
        DogAPI.requestListAllDogs(completionHandler: handleBreedsListResponse(breeds:error:))
    
            // implementing with serialization
            //            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
//                let url = json["message"] as! String
//            } catch {
//                print(error)
//            }
    }
    
    func handleBreedsListResponse(breeds: [String]?, error: Error?) {
        if let breeds = breeds {
            self.breeds = breeds
        }
    }
    
    func handleRandomImageResponse(dogImage: DogImage?, error: Error?) {
        guard let dogImage = dogImage else { return }
        guard let url = URL(string: dogImage.message) else {return}
        DogAPI.requestImageFile(url: url, completionHandler: handleImageFileResponse(image:error:))
    }
    
    func handleImageFileResponse(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.imageView.image = image
            DispatchQueue.main.async {
                self.pickerView.reloadAllComponents()
            }
     }
    }
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DogAPI.requestRandomImage(breed: breeds[row], completionHandler: handleRandomImageResponse(dogImage:error:))
    }
}

