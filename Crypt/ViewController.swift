//
//  ViewController.swift
//  Crypt
//
//  Created by Ricardo Isidro on 11/9/18.
//  Copyright © 2018 Expression B. All rights reserved.
//

import UIKit
import CryptoSwift
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var txtCadenaOriginal: UITextField!
    @IBOutlet weak var txtKey: UITextField!
    @IBOutlet weak var txtIV: UITextField!
    
    @IBOutlet weak var btnOK: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblResultado: UILabel!
    @IBOutlet weak var lblDecrypt: UILabel!
    
    /*let llave: Array<UInt8> = "Expr3s10nB1n4r14"
    let cadena = "ricardo"
    let iv: Array<UInt8> = [0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00]*/
    
    let key = "Expr3s10nB1n4r14"
    let iv  = "Expr3s10nB1n4r14"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func btnEncrypt(_ sender: UIButton) {
        
        /*let key = "bbC2H19lkVbQDfakxcrtNMQdd0FloLyw" // length == 32
        let iv = "gqLOHUioQ0QjhuvI" // length == 16
        let s = "string to encrypt"
        let enc = try! s.aesEncrypt(key: key, iv: iv)
        let dec = try! enc.aesDecrypt(key: key, iv: iv)
        print(s) // string to encrypt
        print("enc:\(enc)") // 2r0+KirTTegQfF4wI8rws0LuV8h82rHyyYz7xBpXIpM=
        print("dec:\(dec)") // string to encrypt
        print("\(s == dec)") // true*/
        let origin:String = txtCadenaOriginal.text ?? "\n"
        let key = txtKey.text ?? "Expr3s10nB1n4r14"
        let iv = txtIV.text ?? "Expr3s10nB1n4r14"
        do {
            let aes = try AES(key: Array(key.utf8), blockMode: CBC(iv: Array(iv.utf8)), padding: .pkcs7)
            let ciphertext = try aes.encrypt(Array(origin.utf8))
            lblResultado.text = ciphertext.toBase64()
            
            //let decrypted = try aes.decrypt(ciphertext)
            
            //let resultado = String(data: decrypted, encoding: .utf8)
            //let res = String(bytes: decrypted, encoding: .utf8)
            //print(res!)
            
        }
        catch {
            
        }
        
        
    }
    
    @IBAction func btnDecrypt(_ sender: UIButton) {
        let origin:String = lblResultado.text ?? "\n"
        let key = txtKey.text ?? "Expr3s10nB1n4r14"
        let iv = txtIV.text ?? "Expr3s10nB1n4r14"
        do {
            let aes = try AES(key: Array(key.utf8), blockMode: CBC(iv: Array(iv.utf8)), padding: .pkcs7)
            let decrypted = try aes.decrypt(origin)
            let res = String(bytes: decrypted, encoding: .utf8)
            lblDecrypt.text = res
            print(res!)
        }
        catch {
            
        }
    }
    

}

/*extension String {
    func aesEncrypt(key: String, iv: String) throws -> String{
        let data = self.data(using: .utf8)
        //let enc = try AES(key: key, iv: iv, blockMode:.CBC).encrypt(data!.arrayOfBytes(), padding: PKCS7())
        let enc = try AES(key: key, iv: iv, padding: .pkcs7)
        let encData = NSData(bytes: enc, length: Int(enc.count))
        //let encData = NSData(bytes: enc, length: Int(enc.count))
        let base64String: String = encData!.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0));
        let result = String(base64String)
        return result
    }
    
    func aesDecrypt(key: String, iv: String) throws -> String {
        let data = NSData(base64EncodedString: self, options: NSData.Base64DecodingOptions(rawValue: 0))
        let dec = try AES(key: key, iv: iv, blockMode:.CBC).decrypt(data!.arrayOfBytes(), padding: PKCS7())
        let decData = NSData(bytes: dec, length: Int(dec.count))
        let result = NSString(data: decData, encoding: NSUTF8StringEncoding)
        return String(result!)
    }
}*/

