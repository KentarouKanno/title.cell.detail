//
//  ViewController.swift
//  btr-label
//
//  Created by --- on 2018/02/25.
//  Copyright © 2018年 ----. All rights reserved.
//
//Users/nishikawakeien/Desktop/btr-labelのコピー2/btr-label/ViewController.swift
struct Cell {
  var detail: [String]
  var lightswipe: Bool//detail
  var tag: Int

}

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
  
  @IBOutlet weak var mytableView: UITableView!
  
  //構造体
  var titles: [String] = [] // title用
  var products: [Cell] = []//detail
  
  
  class  namelabel {
    var labels: [UILabel] = []
  }
  
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // 全データの合計
    return titles.count + products.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    let index = Int(floor(Double(indexPath.row / 2)))
    //セルタップ時のハイライトについて
    cell.selectionStyle = .none
    
    // title行
    if indexPath.row % 2 == 0 {
      
      //ここ再確認
      //破線について
      let path = UIBezierPath()
      path.setLineDash([6.0, 2.0], count: 2, phase: 0.0)
      
      guard titles.count > 0 else {
        return cell
      }
      
      
      let title = titles[index]
      cell.textLabel?.text = title
      //センター寄せ
      cell.textLabel!.textAlignment = NSTextAlignment.center
      cell.backgroundColor = UIColor(red: 0.0, green: 0.8, blue: 1.0, alpha: 0.3)
      
    // detail行
    } else {
      cell.backgroundColor = UIColor.lightGray
      let item = products[index]
      
      guard item.detail.count > 0 else {
        return cell
      }
      let hoge = namelabel()
      //labelについて
      for i in item.detail {
        let label = UILabel()
        label.backgroundColor = UIColor(red: 0.0, green: 0.8, blue: 0.9, alpha: 0.2)
        label.text = i
        
        
        // textLabel という名前の変数に格納された UILabel にフォントサイズの自動調整を設定します。
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 10.0
        //丸みに対して
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        cell.contentView.addSubview(label)
        hoge.labels.append(label)
      }
      
      var preLabel: UILabel? = nil
      for l in hoge.labels {
        
        l.translatesAutoresizingMaskIntoConstraints = false
        if (preLabel == nil) {
          l.leftAnchor.constraint(equalTo: cell.contentView.leftAnchor, constant: 12).isActive = true
        } else {
          l.leftAnchor.constraint(equalTo: preLabel!.rightAnchor, constant: 20).isActive = true
        }
        cell.contentView.heightAnchor.constraint(equalTo: l.heightAnchor, multiplier: 1).isActive = true
        preLabel = l
      }
      
    }
    
    return cell
  }
  
  @IBAction func addcellbtr(_ sender: Any) {
    
    alertnormal()
  }
  
  func alertnormal(){
    // テキストフィールド付きアラート表示
    
    let alert = UIAlertController(title: "タイトル", message: "メッセージ", preferredStyle: .alert)
    
    // OKボタンの設定
    let okAction = UIAlertAction(title: "OK", style: .default, handler: {
      (action:UIAlertAction!) -> Void in
      
      // OKを押した時入力されていたテキストを表示
      if let textFields = alert.textFields {
        
        // アラートに含まれるすべてのテキストフィールドを調べる
        for textField in textFields {
          let name = textField.text!
          self.titles.append(name)
        }
        self.products.insert(Cell(detail: [], lightswipe: false, tag: 0), at: 0)
        self.Gesture()
        self.doubleclic()
        self.mytableView.reloadData()
      }
    })
    alert.addAction(okAction)
    
    // キャンセルボタンの設定
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    alert.addAction(cancelAction)
    
    // テキストフィールドを追加
    alert.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
      textField.placeholder = "テキスト"
    })
    
    alert.view.setNeedsLayout() // シミュレータの種類によっては、これがないと警告が発生
    
    // アラートを画面に表示
    self.present(alert, animated: true, completion: nil)

  }
  
 //右スワイプ
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
    //スワイプ出来るセルを限定する
    if  indexPath.row % 2 == 1{ //除算で判定する
      //detailに関する処理を書く
    }else{
      return UISwipeActionsConfiguration(actions: [])
    }
    
    let edit = UIContextualAction(style: .normal,title: "追加", handler: { (action: UIContextualAction, view: UIView, success :(Bool) -> Void) in
      let alert = UIAlertController(title: "タイトル", message: "メッセージ", preferredStyle: .alert)
      
      // OKボタンの設定
      let okAction = UIAlertAction(title: "OK", style: .default, handler: {
        (action:UIAlertAction!) -> Void in
        
        // OKを押した時入力されていたテキストを表示
        if let textFields = alert.textFields {
          
          // アラートに含まれるすべてのテキストフィールドを調べる
          for textField in textFields {
            let name = textField.text!
            let index = Int(floor(Double(indexPath.row / 2)))
            
            self.products[index].detail.append(name)
            self.mytableView.reloadData()
          }
        }
      })
      alert.addAction(okAction)
      
      // キャンセルボタンの設定
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      alert.addAction(cancelAction)
      
      // テキストフィールドを追加
      alert.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
        textField.placeholder = "テキスト"
      })
      
      
      alert.view.setNeedsLayout() // シミュレータの種類によっては、これがないと警告が発生
      
      // アラートを画面に表示
      self.present(alert, animated: true, completion: nil)
      print("edit")
      
      success(true)
    })
    
    edit.backgroundColor = .blue
    
    return UISwipeActionsConfiguration(actions: [edit])
  }
  
  
  
  // trueを返すことでCellのアクションを許可しています
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    // detail行の場合は許可
    //return indexPath.row % 2 == 1
    if products.count > (indexPath.row + 1) {
      return true
    }else{
      return true
    }
  }

  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row % 2 == 0 {
      
      guard titles.count > 0 else {
        return 25//必要なのか？
      }
      return 25
    }
    return 40 //自動設定
  }
  
  //左から右へスワイプ
  func tableView(_ tableView: UITableView,
                 leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
    //スワイプ出来るセルを限定する
    if  indexPath.row % 2 == 0{ //除算で判定する
      //detailに関する処理を書く
    }else{
       return UISwipeActionsConfiguration(actions: [])
    }
    
    let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in
      self.deleteRow(at: indexPath)
      completionHandler(true)
      
    }
    
    let edit = UIContextualAction(style: .normal,title: "edit", handler: { (action: UIContextualAction, view: UIView, success :(Bool) -> Void) in
      
      let alert = UIAlertController(title: "タイトル", message: "メッセージ", preferredStyle: .alert)
      
      // OKボタンの設定
      let okAction = UIAlertAction(title: "OK", style: .default, handler: {
        (action:UIAlertAction!) -> Void in
        
        // OKを押した時入力されていたテキストを表示
        if let textFields = alert.textFields {
          
          // アラートに含まれるすべてのテキストフィールドを調べる
          for textField in textFields {
            let name = textField.text!
            self.titles.insert(name, at: 0)
          }
          self.products.append(Cell(detail: [], lightswipe: false, tag: 0))
          self.mytableView.reloadData()
          
        }
      })
      alert.addAction(okAction)
      
      // キャンセルボタンの設定
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
      alert.addAction(cancelAction)
      
      // テキストフィールドを追加
      alert.addTextField(configurationHandler: {(textField: UITextField!) -> Void in
        textField.placeholder = "テキスト"
      })
      
      
      alert.view.setNeedsLayout() // シミュレータの種類によっては、これがないと警告が発生
      
      // アラートを画面に表示
      self.present(alert, animated: true, completion: nil)
      print("edit")
      
      success(true)
    })
    
    //deleteAction.backgroundColor = .orange
    edit.backgroundColor = .blue
    
    //return UISwipeActionsConfiguration(actions: [edit])
    //return UISwipeActionsConfiguration(actions: [deleteAction,edit])
    let config = UISwipeActionsConfiguration(actions: [deleteAction,edit])
    config.performsFirstActionWithFullSwipe = false
    return config
    
  }
  
  func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    return indexPath
  }
  //cellの削除について
  func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
    //return products[indexPath.row].detail ? .delete : .none
    if mytableView.isEditing {
      return .delete
    }
    return .none
  }
  //cellの削除について
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      self.deleteRow(at: indexPath)
    }
  }
  
  func deleteRow(at indexPath: IndexPath) {
    
    self.titles.remove(at: indexPath.row)
    self.products.remove(at: indexPath.row)
    mytableView.reloadData()
    //下の行のデリートすると落ちる!なんで？？？？
  }
  
  /*func deletealert() {
    let hoge = namelabel()
    let alert = UIAlertController(title:"you realy want to delete?", message: "メッセージ", preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "YES", style: .default, handler: {
      (action:UIAlertAction!) -> Void in
      
      //labelの削除について
      hoge.labels.tag = 1
      
      self.view.subviews.forEach {
        if $0.tag == 1{
          $0.removeFromSuperview()
          
        }
      }
    })
    alert.addAction(okAction)
    
    // キャンセルボタンの設定
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    alert.addAction(cancelAction)
    
    alert.view.setNeedsLayout() // シミュレータの種類によっては、これがないと警告が発生
    // アラートを画面に表示
    self.present(alert, animated: true, completion: nil)
    
  }*/
  
  //長押しやダブルクリックについて
  @objc func longpress(sender: UILongPressGestureRecognizer){
    //let hoge = namelabel()
    // 長押し開始〜
    if(sender.state == UIGestureRecognizerState.began)
    {
      
    } else if (sender.state == UIGestureRecognizerState.ended)
    {
      print("ロングタップされたよ。")
      //labelの削除について
      /*hoge.labels.tag = 1
      
      self.view.subviews.forEach {
        if $0.tag == 1{
          $0.removeFromSuperview()
          
        }
      }
      //alert()
      print("ロングタップされたよ。")*/
    }
    
  }
  
  @objc func doubletap(sender: UITapGestureRecognizer){
    if(sender.state == UIGestureRecognizerState.began)
    {
    }else if(sender.state == UIGestureRecognizerState.ended)
    {
      //deletealert()
      print("tapされたよ")
    }
    
  }
  
  func Gesture() {
    
     let hoge = namelabel()
    // UILongPressGestureRecognizerインスタンス作成
    let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longpress(sender:)))
    
    // 時間（デフォルト0.5秒）
    longPressGesture.minimumPressDuration = 0.5
    hoge.labels[0].isUserInteractionEnabled = true
    hoge.labels[0].addGestureRecognizer(longPressGesture)
    
    
    
  }
  
  func doubleclic(){
    let hoge = namelabel()
    // ダブルタップ
    let doubeltapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.doubletap(sender:)))
    doubeltapGesture.numberOfTapsRequired = 2
    hoge.labels[0].isUserInteractionEnabled = true
    hoge.labels[0].addGestureRecognizer(doubeltapGesture)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    mytableView.delegate = self
    mytableView.dataSource = self
    mytableView.backgroundColor = UIColor(red: 0.0, green: 0.8, blue: 1.0, alpha: 0.1)
    mytableView.separatorColor = UIColor.clear
    
    mytableView.reloadData()
  }
  

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

