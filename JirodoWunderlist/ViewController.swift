//
//  ViewController.swift
//  JirodoWunderlist
//
//  Created by 佐々木皓晃 on 2018/08/20.
//  Copyright © 2018年 free. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {

    @IBOutlet var backImageView: UIImageView!
    
    @IBOutlet var backView: UIView!
    
    @IBOutlet var textField: UITextField!
    
    @IBOutlet var tableView: UITableView!
    
    //ToDoのテキストが入る配列
    var titleArray = [String]()
    
    var label:UILabel = UILabel()
    
    //選択されたセルの番号を入れる
    var count:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self

        //角丸にする
        backView.layer.cornerRadius = 2.0
        
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //アプリ内に保存されているデータを取ってくる
        //タイトル
        if UserDefaults.standard.object(forKey: "array") != nil {
            
            titleArray = UserDefaults.standard.object(forKey: "array") as! [String]
        }
        
        //画像を取り出す
        if UserDefaults.standard.object(forKey: "image") != nil {
            
            //スクロールビューでクリックされた画像の番号を入れる
            let numberString = UserDefaults.standard.string(forKey: "image")
            
            //backImageViewに画像の名前を反映
            backImageView.image = UIImage(named: numberString! + ".jpg")
        }
        
        tableView.reloadData()
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //配列の中に文字を入れる
        titleArray.append(textField.text!)
        
        //配列をアプリ内へ保存
        UserDefaults.standard.set(titleArray, forKey: "array")
        //アプリ内に保存されているものがから出ない場合
        if UserDefaults.standard.object(forKey: "array") != nil {
            //タイトルを入れ替える
            titleArray = UserDefaults.standard.object(forKey: "array") as! [String]
            //テキストフィールドを空にする
            textField.text = ""
            
            tableView.reloadData()
        
        }
        
        //キーボードを閉じる
        textField.resignFirstResponder()
        
        return true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 110
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.layer.cornerRadius = 10.0
        label = cell.contentView.viewWithTag(1) as! UILabel
        label.text = titleArray[indexPath.row]
        
        return cell
    }
    
    //セルの中のセクションの数を返す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titleArray.count
        
    }
    
    //セルがタップされたとき画面遷移する
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //値を渡しながら（タップされたときの番号を渡す）
        count = Int(indexPath.row)
        //画面遷移
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "next" {
            
            let nextVC:NextViewController = segue.destination as! NextViewController
            
            nextVC.selectedNumber = count
        }
    }
    
    //セルの編集
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            //titleArrayが選択された際の番号の配列に入っている文字を削除
            titleArray.remove(at: indexPath.row)
            
            //削除された状態の配列をアプリ内に保存
            UserDefaults.standard.set(titleArray, forKey: "array")
            
            tableView.reloadData()
        } else if editingStyle == .insert {
            
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
 
    }


}

