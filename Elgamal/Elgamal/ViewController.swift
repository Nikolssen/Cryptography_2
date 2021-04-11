//
//  ViewController.swift
//  Elgamal
//
//  Created by Admin on 11.04.2021.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var scrollViewBottomAnchor: NSLayoutConstraint!
    
    @IBOutlet weak var pField: UITextField!
    @IBOutlet weak var gField: UITextField!
    @IBOutlet weak var xField: UITextField!
    @IBOutlet weak var yField: UITextField!
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var encodedField: UITextField!
    @IBOutlet weak var decodedField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        messageField.delegate = self
        pField.delegate = self
    }

    @IBAction func encodeAction(_ sender: Any) {
        
        guard let p = Int(pField.text ?? "X") else {return}
        if !Elgamal.isPrime(p) {return}
        let g = Elgamal.primaryRoot(p: p)
        let x = Elgamal.getX(p: p)
        let y = Elgamal.getY(p: p, g: g, x: x)
        gField.text = String(g)
        xField.text = String(x)
        yField.text = String(y)
        
        guard let message = Int(messageField.text ?? "X") else {return}
        let k = Elgamal.getK(p: p)
        let (a,b) = Elgamal.encrypt(y: y, k: k, p: p, g: g, m: message)
        encodedField.text = "\(a) \(b)"
        let decoded = Elgamal.decrypt(a: a, b: b, x: x, p: p)
        decodedField.text = String(decoded)
    }
//
//    @objc func keyboardWillShow(notification: Notification){
//        let rect = notification.userInfo?["UIKeyboardFrameEndUserInfoKey"] as! CGRect
//        let scrollViewCS = scrollView.frame.size
//        scrollViewBottomAnchor.constant = rect.size.height + 10
//        scrollView.isScrollEnabled = true
//        scrollView.contentSize = scrollViewCS
//
//        let inset = UIEdgeInsets(top: 0, left: 0, bottom: rect.size.height, right: 0)
//        scrollView.contentInset = inset
//        scrollView.scrollIndicatorInsets = inset
//        scrollView.scrollRectToVisible(messageField.frame, animated: true)
//    }
//    @objc func keyboardWillHide(notification: Notification){
//
//    }
    
    override func viewDidAppear(_ animated: Bool) {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIWindow.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
       textField.resignFirstResponder()
        return true
    }
}

