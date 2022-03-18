//
//  ViewController.swift
//  Clima
//
//  Created by omer faruk bozbulut on 16.03.2022.
//

import UIKit

// UITextFieldDelegate metnin düzenlenmesi ve doğrulanmasını yönetmemizi sağlar.
class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TextField'dan düzenlemeyle ilgili mesajlara yanıt verir. Kullanıcı tarafından girilen metne ve kullanıcının return'e dokunması gibi bazı özel komutlara yanıt vermek için delegate kullanılır
        searchTextField.delegate = self
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        // klavyeyi kapatır
        searchTextField.endEditing(true)
        
    }
    
    
    // Metin alanı, kullanıcı return düğmesine dokunduğunda bu yöntemi çağırır.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        
        
        // burada true dersem üstte yazdıklarımı uygular. false dersem uygulamaz.
        return true
    }
    
    // Delegate'e belirtilen metin alanında düzenlemeyi durdurup durdurmayacağını sorar.
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        // Burada textField kullanmamızın sebebi birden fazla textFieldımızın olma olasılığıdır.
        // Eğer searchTextField kullansaydık sadece o textField için çalışırdı.
        if textField.text != "" {
            return true  // endEditing işlemini yap.
        }else{
            textField.placeholder = "Type something"
            return false // endEditing işlemini yapma. Yapamadığı için bu durumda klavye kapatılmaz.
        }
        
        
    }
    
    
    // kullanıcı düzenlemeyi durdurduğunda çalıştırılır.
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextField.text = ""
    }
    
    
}

