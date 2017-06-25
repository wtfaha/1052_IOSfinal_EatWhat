//
//  PickerViewController.swift
//  IOS_FinalProject
//
//  Created by user_23 on 2017/6/25.
//  Copyright © 2017年 user_23. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*UIpicker設定*/
        // 新增另一個 UIViewController
        // 用來實作委任模式的方法
        let myViewController = PickerViewController()
        
        // 必須將這個 UIViewController 加入
        self.addChildViewController(myViewController)
        
        // 設定 UIPickerView 的 delegate 及 dataSource
        colorpicker.delegate = myViewController
        colorpicker.dataSource = myViewController
        
        // 加入到畫面
        self.view.addSubview(colorpicker)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBOutlet weak var colorpicker: UIPickerView!
    var colors = ["Red","Yellow","Green","Blue"]
    
    // MARK: - UIPickerDataSource
    
    // UIPickerViewDataSource 必須實作的方法：
    // UIPickerView 有幾列可以選擇
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerViewDataSource 必須實作的方法：
    // UIPickerView 各列有多少行資料
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //print("records.count")
        //print(records.count)
        return colors.count
    }
    
    // Mark: - UIPicker
    // UIPickerView 每個選項顯示的資料
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //print("records[row]")
        //print(records[row])
        return colors[row]
    }
    // UIPickerView 改變選擇後執行的動作
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("row")
        print(row)

        
        if(colors[row] == "Red"){
            print("red")
        }
        else if(colors[row] == "Yellow"){
            print("UIColor.red")
        }
        else if(colors[row] == "Green"){
            print("UIColor.red")
        }
        else if(colors[row] == "Blue"){
            print("UIColor.red")
        }
        
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
