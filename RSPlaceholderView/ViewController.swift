//
//  ViewController.swift
//  RSPlaceholderView
//
//  Created by WhatsXie on 2017/10/19.
//  Copyright © 2017年 WhatsXie. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    let placeholderView = PlaceholderView()

    lazy var tableView :UITableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height), style: UITableView.Style.grouped)

    var arrayList = NSArray()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        createData()
        
        setupUI()
        createPlaceholderView()
        
        
        testTimerAction()

        placeholderView.callBackBlock { (ClickString) in
            print(ClickString)
            self.placeholderView.errorType = ErrorType.NoData
            self.testTimerAction()
        }
    }
    // 测试用例
    func testTimerAction() {
        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.removeLoader), userInfo: nil, repeats: false)
    }
    @objc func removeLoader(){
        placeholderView.errorType = ErrorType.NoNetWork
    }
    // 模拟空数据
    func createData() {
        arrayList = [
            []
        ]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK:- 设置UI
extension ViewController {
    func setupUI() {
        self.view.addSubview(tableView)
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(TableViewCell.self , forCellReuseIdentifier: "cell")
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
    }
}
// MARK:- UITableView的代理方法
//extension：类扩展只能扩充方法，不能扩充属性
extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return arrayList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (arrayList[section] as AnyObject).count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell") as! TableViewCell
        cell.selectionStyle = .none
        
        return cell
    }
}
// MARK:- PlaceholderView
extension ViewController {
    /*
     * 显示占位视图主要功能实现部分
     * 注意：基类中设置通用声明
     */
    func createPlaceholderView() {
        tableView.placeholder = {
            switch self.errorType {
                case ErrorType.NoData:
                    self.placeholderView.errorType = ErrorType.NoData
                    return self.placeholderView
                case ErrorType.NoNetWork:
                    self.placeholderView.errorType = ErrorType.NoNetWork
                    return self.placeholderView
                default:
                    return UIView()
                }
        }
        tableView.placeholder_reloadData()
    }
}
