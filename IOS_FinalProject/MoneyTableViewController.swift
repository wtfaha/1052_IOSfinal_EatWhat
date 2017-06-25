//
//  MoneyTableViewController.swift
//  IOS_FinalProject
//
//  Created by user_23 on 2017/6/23.
//  Copyright © 2017年 user_23. All rights reserved.
//

import UIKit

class MoneyTableViewController: UITableViewController {
    
    var records:[[String:String]] = []
    
    /*新增*/
    func getAddMoneyNoti(noti:Notification) {
        let record = noti.userInfo as? [String:String]
        
        records.insert(record!, at: 0)
       
        /*存擋*/
        let url = Setfile()
        (records as NSArray).write(to: url!, atomically: true)
        
        /*新增通知*/
        let notiName = Notification.Name("NewRecord")
        NotificationCenter.default.post(name: notiName, object: nil, userInfo: nil)
        
        /*更新表格*/
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*讀黨*/
        let url = Setfile()
        let array = NSArray(contentsOf: url!)
        if array != nil {
            records = array as! [[String:String]]
        }
        
        /*新增通知*/
        let notiName = Notification.Name("AddRecord")
        NotificationCenter.default.addObserver(self, selector: #selector(MoneyTableViewController.getAddMoneyNoti(noti:)), name: notiName, object: nil)
        
        /*擁有delete功能的神奇edit button*/
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return records.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath)

        // Configure the cell...

        let dic = records[indexPath.row]
        
        cell.textLabel?.text = dic["name"]
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent(dic["photo"]!)
        cell.imageView?.image = UIImage(contentsOfFile: url!.path)
        
        return cell
    }
    
    func Setfile()->URL? {
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory,in: .userDomainMask)
        let docUrl = docUrls.first
        
        let url = docUrl?.appendingPathComponent("records.txt")
        return url
    }
    
    /*刪除*/
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        self.records.remove(at: indexPath.row)
        
        //較耗資源較，重新整理頁面
        //tableView.reloadData()
        //較不耗資源，單純刪掉一列
        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        
        /*刪掉檔案的資料*/
        let url = Setfile()
        (self.records as NSArray).write(to: url!, atomically:true)
        
        /*刪除通知*/
        let notiName = Notification.Name("DeleteRecord")
        NotificationCenter.default.post(name: notiName, object: nil, userInfo: nil)

    }
    
    /*傳送給下一個頁面顯示值*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = tableView.indexPathForSelectedRow
        let controller = segue.destination as? EditMoneyTableViewController
        controller?.recordDic = records[indexPath!.row]
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
