//
//  ViewController.swift
//  btr-label
//
//  Created by  on 2018/02/25.
//  Copyright © 2018年 . All rights reserved.
//

// アラートタイプ
enum AlertType {
    /// タイトル追加
    case titleNew
    /// タイトル編集
    case titleEdit
    /// 詳細追加
    case detailNew
    /// 詳細編集
    case detailAdd
}

import UIKit

class ViewController: UIViewController, DetailCellDelegate {
    
    var cellData: [CellData] = []
    @IBOutlet weak var mytableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addcellbtr(_ sender: Any) {
        showTextFieldAlert(.titleNew)
    }
    
    func showTextFieldAlert(_ alertType: AlertType,
                            title: String = "タイトル",
                            message: String = "メッセージ",
                            button1Title: String = "Cancel",
                            button2Title: String = "OK",
                            textFieldPlaceholder: String = "テキスト",
                            index: Int = 999,
                            detailIndex: Int = 999) {
        
        // テキストフィールド付きアラート表示
        let alert = UIAlertController.textFieldAlert(title: title,
                                                     message: message,
                                                     button1Title: button1Title,
                                                     button2Title: button2Title,
                                                     textFieldPlaceholder: textFieldPlaceholder,
                                                     handler1: {
                                                        
        }, handler2: { textFields in
            
            if let textFields = textFields {
                for textField in textFields {
                    if let text = textField.text {
                        
                        switch alertType {
                        case .titleNew:
                            // Title New
                            self.cellData.append(CellData(text))
                        case .titleEdit:
                            // Title Edit
                            self.cellData[index].title = text
                        case .detailNew:
                            // Detail Add
                            self.cellData[index].append(detailText: text)
                        case .detailAdd:
                            // Detail Edit
                            self.cellData[index].details[detailIndex] = text
                        }
                    }
                }
                self.mytableView.reloadData()
            }
        })
        // アラートを画面に表示
        self.present(alert, animated: true, completion: nil)
    }
    
    func deleteRow(at indexPath: IndexPath) {
        
        let alert = UIAlertController.twoButtonAlert(title: "you realy want to delete?",
                                                     message: "メッセージ",
                                                     button1Title: "YES",
                                                     button2Title: "Cancel", handler1: {
                                                        
                                                        self.cellData.remove(at: indexPath.section)
                                                        self.mytableView.reloadData()
        }, handler2: {
            self.mytableView.reloadData()
        })
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - DetailCellDelegate
    
    func tableReloadData() {
        mytableView.reloadData()
    }
    
    func editDetailText(index: Int, detailIndex: Int) {
        showTextFieldAlert(.detailAdd, index: index, detailIndex: detailIndex)
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row % 2 == 0 ? 25 : 40
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cellData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row % 2 == 0 {
            // title行
            if let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell",
                                                        for: indexPath) as? TitleCell {
                cell.cellData = cellData[indexPath.section]
                return cell
            }
        } else {
            // detail行
            if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell",
                                                        for: indexPath) as? DetailCell {
                cell.cellData = cellData[indexPath.section]
                cell.delegate = self
                cell.index = indexPath.section
                return cell
            }
        }
        return UITableViewCell()
    }
    
    // 右スワイプ
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard indexPath.row % 2 == 1 else { return UISwipeActionsConfiguration(actions: []) }
        
        let edit = UIContextualAction(style: .normal,title: "追加", handler:
        { (action: UIContextualAction, view: UIView, success :(Bool) -> Void) in
            self.showTextFieldAlert(.detailNew, index: indexPath.section)
            success(true)
        })
        
        edit.backgroundColor = .blue
        return UISwipeActionsConfiguration(actions: [edit])
    }
    
    // 左から右へスワイプ
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard indexPath.row % 2 == 0 else { return UISwipeActionsConfiguration(actions: []) }
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete")
        { action, view, completionHandler in
            self.deleteRow(at: indexPath)
            completionHandler(true)
        }
        
        let edit = UIContextualAction(style: .normal,title: "edit", handler:
        { (action: UIContextualAction, view: UIView, success :(Bool) -> Void) in
            self.showTextFieldAlert(.titleEdit, index: indexPath.section)
            success(true)
        })
        
        edit.backgroundColor = .blue
        let config = UISwipeActionsConfiguration(actions: [deleteAction,edit])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
}
