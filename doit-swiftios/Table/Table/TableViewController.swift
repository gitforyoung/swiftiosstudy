//
//  TableViewController.swift
//  Table
//
//  Created by Wooyoung on 2022/11/14.
//

import UIKit

// 외부 변수로 선언하여 다른 모든 클래스에서 사용할 수 있도록 한다.
var items = ["책 구매", "철수와 약속", "스터디 준비하기", "책 구매", "철수와 약속", "스터디 준비하기","책 구매", "철수와 약속", "스터디 준비하기","책 구매", "철수와 약속", "스터디 준비하기","책 구매", "철수와 약속", "스터디 준비하기"]
var itemImageFiles = ["cart.png", "clock.png", "pencil.png","cart.png", "clock.png", "pencil.png","cart.png", "clock.png", "pencil.png","cart.png", "clock.png", "pencil.png","cart.png", "clock.png", "pencil.png"]

class TableViewController: UITableViewController {

    @IBOutlet var tvListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // edit 버튼을 추가하기 위해 주석 해제. 위치를 왼쪽으로 옮기기 위해 leftBarButtonItem으로 수정
         self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    // 뷰가 전환될 때 호출되는 함수로, 추가뷰에서 돌아올 때 호출될 것임.
    override func viewWillAppear(_ animated: Bool) {
        tvListView.reloadData() // 테이블뷰를 다시 불러옴
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    // 주석 처리되었던 것 해제. 앞에서 선언한 변수의 내용을 셀에 적용하는 함수
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // withIdentifier를 스토리보드에서 셀에 부여한 indentifier로 수정
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        // 셀의 행 번호 정보를 이용해 그에 맞는 아이템과 이미지를 대입한다.
        cell.textLabel?.text = items[(indexPath as NSIndexPath).row]
        cell.imageView?.image = UIImage(named: itemImageFiles[(indexPath as NSIndexPath).row])
        
        if indexPath.row == 1 {
            cell.backgroundColor = .red
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 아이템과 이미지 변수에서도 정보 지워주는 코드 추가
            items.remove(at: (indexPath as NSIndexPath).row)
            itemImageFiles.remove(at: (indexPath as NSIndexPath).row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // 셀 삭제 시 나오는 버튼의 문구를 수정
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "삭제"
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        // 셀 이동 시 아이템과 이미지 변수에서도 순서를 바꿔주는 코드 추가
        let itemToMove = items[(fromIndexPath as NSIndexPath).row]
        let itemImageToMove = itemImageFiles[(fromIndexPath as NSIndexPath).row]
        
        items.remove(at: (fromIndexPath as NSIndexPath).row)
        itemImageFiles.remove(at: (fromIndexPath as NSIndexPath).row)
        items.insert(itemToMove, at: (to as NSIndexPath).row)
        itemImageFiles.insert(itemImageToMove, at: (to as NSIndexPath).row)
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        // 셀을 선택하면 해당 셀의 위치를 받고, 뷰 전환 목적지는 디테일뷰로 설정, 디테일뷰에 셀 번호로 변수 내용 저장
        if segue.identifier == "sgDetail" {
            let cell = sender as! UITableViewCell
            let indexPath = self.tvListView.indexPath(for: cell)
            let detailView = segue.destination as! DetailViewController
            detailView.receiveItem(items[(indexPath! as NSIndexPath).row])
        }
    }
    

}
