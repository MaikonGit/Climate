//
//  ViewController.swift
//  Climate
//
//  Created by Maikon Ferreira on 08/12/21.
//

import UIKit

class ClimateViewController: UIViewController {
   
    
    //OUTLETS
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var condicaoClimaticaIMG: UIImageView!
    @IBOutlet weak var temperaturaLabel: UILabel!
    @IBOutlet weak var cidadeLabel: UILabel!
    
    //VARS
    var weatherManager = WeatherManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        searchTextField.delegate = self
        weatherManager.delegate = self
        
    }

    
}

//MARK: - UITextFildDelegate

extension ClimateViewController: UITextFieldDelegate {
    
    //SEARCH BUTTOM
    @IBAction func searchButtom(_ sender: UIButton) {
        searchTextField.text = searchTextField.text?.replacingOccurrences(of: " ", with: "+")
        searchTextField.endEditing(true)
    }
    
    //RETURN BUTTOM
    @nonobjc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.text = searchTextField.text?.replacingOccurrences(of: " ", with: "+")
        searchTextField.endEditing(true)
            return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            if textField.text != "" {
                return true
            } else {
                textField.placeholder = "Pesquise por uma cidade."
                return false
            }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchTextField.text = ""
    }
}

//MARK: - WeatherManagerDelegate

extension ClimateViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperaturaLabel.text = weather.temperatureString
            self.condicaoClimaticaIMG.image = UIImage(systemName: weather.conditionName)
            self.cidadeLabel.text = weather.cityName
        }
        
    }
    
}

