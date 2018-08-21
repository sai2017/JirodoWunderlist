//
//  NextViewController.swift
//  JirodoWunderlist
//
//  Created by 佐々木皓晃 on 2018/08/20.
//  Copyright © 2018年 free. All rights reserved.
//

import UIKit

class NextViewController: UIViewController,UITextViewDelegate,UIDocumentInteractionControllerDelegate {
    
    lazy private var documentInteractionController = UIDocumentInteractionController()
    
    var selectedNumber:Int = 0
    
    var screenShotImage:UIImage = UIImage()
    
    var titleArray:Array = [String]()

    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        //titleArrayをアプリ内から取り出す
        if UserDefaults.standard.object(forKey: "array") != nil {
            
            titleArray = UserDefaults.standard.object(forKey: "array") as! [String]
            
            textView.text = titleArray[selectedNumber]
        }
    }
    
    //タッチしてキーボードを閉じる
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //キーボードが出た状態であれば
        if textView.isFirstResponder {
            //閉じる
            textView.resignFirstResponder()
        }
    }
    
    //スクリーンショット
    func takeScreenshot() {
        
        //キャプチャしたい枠を決める
        let rect = CGRect(x: textView.frame.origin.x, y: textView.frame.origin.y, width: textView.frame.width, height: textView.frame.height)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        textView.drawHierarchy(in: rect, afterScreenUpdates: true)
        screenShotImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
    }

    @IBAction func shareLINE(_ sender: Any) {
        
        takeScreenshot()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0 ) {
            
            let pastBoard: UIPasteboard = UIPasteboard.general
            pastBoard.setData(UIImageJPEGRepresentation(self.screenShotImage, 0.75)!, forPasteboardType: "public.png")
            
            let lineUrlString: String = String(format: "line://msg/image/%@", pastBoard.name as CVarArg)
            
            UIApplication.shared.open(NSURL(string: lineUrlString)! as URL)
            
            
        }
        
        let pastBoard: UIPasteboard = UIPasteboard.general
        pastBoard.setData(UIImageJPEGRepresentation(screenShotImage, 0.75)!, forPasteboardType: "public.png")
        
        let lineUrlString: String = String(format: "line://msg/image/%@", pastBoard.name as CVarArg)
        
        UIApplication.shared.open(NSURL(string: lineUrlString)! as URL)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
   
    }
    

}
