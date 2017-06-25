//
//  RandomViewController.swift
//  IOS_FinalProject
//
//  Created by user_23 on 2017/6/25.
//  Copyright © 2017年 user_23. All rights reserved.
//

import UIKit

class RandomViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {

    var records:[[String:String]] = []
    
    /*重讀檔案*/
    func getMoneyNoti(noti:Notification) {
        /*讀黨*/
        let url = Setfile()
        let array = NSArray(contentsOf: url!)
        if array != nil {
            records = array as! [[String:String]]
        }
        
        print("reload")
        print(records)
    }
    
    func Setfile()->URL? {
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory,in: .userDomainMask)
        let docUrl = docUrls.first
        
        let url = docUrl?.appendingPathComponent("records.txt")
        return url
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*讀黨*/
        let url = Setfile()
        let array = NSArray(contentsOf: url!)
        if array != nil {
            records = array as! [[String:String]]
        }
        
        print("firstReload")
        print(records)
        
        /*新增通知*/
        let notiNameNew = Notification.Name("NewRecord")
        NotificationCenter.default.addObserver(self, selector: #selector(RandomViewController.getMoneyNoti(noti:)), name: notiNameNew, object: nil)
        
        /*刪除通知*/
        let notiNameDelete = Notification.Name("DeleteRecord")
        NotificationCenter.default.addObserver(self, selector: #selector(RandomViewController.getMoneyNoti(noti:)), name: notiNameDelete, object: nil)
        
        print(records.count)
        
        /*UIpicker設定*/
        // 新增另一個 UIViewController
        // 用來實作委任模式的方法
        let myViewController = RandomViewController()
        
        // 必須將這個 UIViewController 加入
        self.addChildViewController(myViewController)
        
        // 設定 UIPickerView 的 delegate 及 dataSource
        colorpicker.delegate = myViewController
        colorpicker.dataSource = myViewController
        
        // 加入到畫面
        self.view.addSubview(colorpicker)
        
        /*背景顏色*/
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"background2.png")!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var myTextField: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UILabel!
    
    @IBAction func randomButton(_ sender: Any) {
        /*randomTest*/
        print("records.count")
        print(records.count)
        
        /*0~records.count(不包括records.count)*/
        let temp:Int = Int(arc4random_uniform(UInt32(records.count)))
        
        
        print("temp = \(temp)")
        
        nameTextField.text = records[temp]["name"] as? String
        
        
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent((records[temp]["photo"] as? String)!)
        imageView?.image = UIImage(contentsOfFile: url!.path)
    }
    
    
    @IBOutlet weak var colorpicker: UIPickerView!
    
    // MARK: - UIPickerDataSource
    
    // UIPickerViewDataSource 必須實作的方法：
    // UIPickerView 有幾列可以選擇
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerViewDataSource 必須實作的方法：
    // UIPickerView 各列有多少行資料
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        /*讀黨*/
        let url = Setfile()
        let array = NSArray(contentsOf: url!)
        if array != nil {
            records = array as! [[String:String]]
        }

        return records.count
    }
    
    // Mark: - UIPicker
    // UIPickerView 每個選項顯示的資料
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return records[row]["name"]
    }
    
    // UIPickerView 改變選擇後執行的動作
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
