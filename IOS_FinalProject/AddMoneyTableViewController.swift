//
//  AddMoneyTableViewController.swift
//  IOS_FinalProject
//
//  Created by user_23 on 2017/6/23.
//  Copyright © 2017年 user_23. All rights reserved.
//

import UIKit

class AddMoneyTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    
    /*完成*/
    @IBAction func done(_ sender: Any) {
        /*alert*/
        if(nameTextField.text?.characters.count == 0){
            let controller = UIAlertController(title: "提醒", message: "你是不會打字膩", preferredStyle: UIAlertControllerStyle.alert)
            
            /*close*/
            let action = UIAlertAction(title: "ok", style: UIAlertActionStyle.default, handler:  {(action) in})
            controller.addAction(action)
            present(controller, animated: true, completion: nil)
        
            return
        }
        
        let number = Date().timeIntervalSinceReferenceDate
        let record = ["name":nameTextField.text!, "photo":"\(number)"]
        let data = UIImageJPEGRepresentation(imageView.image!, 0.8)
        print(number)
        
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        /*存擋*/
        let url = docUrl?.appendingPathComponent("\(number)")
        try? data?.write(to: url!)
        
        /*通知*/
        let notiName = Notification.Name("AddRecord")
        NotificationCenter.default.post(name: notiName, object: nil, userInfo: record)
        
        /*弄掉最上面那一頁，也就是弄掉本頁*/
        navigationController?.popViewController(animated: true)
    }
    
    /*顯示選擇的圖片*/
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("info")
        print(info) //位置
        
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage    //顯示選擇的圖片
        dismiss(animated: true, completion: nil)    //選完關掉視窗
    }
    
    /*選擇圖片*/
    @IBAction func selectPhoto(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary   //從相簿選擇(較多)
        //controller.sourceType = .savedPhotosAlbum//從相簿選擇(較少)

        show(controller, sender: nil)   //顯示
        //self.present(controller, animated: true, completion: nil)//顯示
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    
    
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
