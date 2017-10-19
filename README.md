# RSPlaceholderView
使用 Swift 封装实现 TableView 占位视图

![](https://img.shields.io/badge/platform-iOS-red.svg) 
![](https://img.shields.io/badge/language-Swift-orange.svg) 
![](https://img.shields.io/badge/download-2.2MB-brightgreen.svg)
![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg) 

表格在没有数据和断网的情况下需要一个占位的空白视图，以提醒用户我们的 APP 为什么这么白...，这时聪明的程序🐒当然会选择搞个封装了。

| 名称 |1.列表页 |2.展示页 |3.展示页 |
| ------------- | ------------- | ------------- | ------------- |
| 截图 | ![](http://og1yl0w9z.bkt.clouddn.com/17-10-19/90729382.jpg) | ![](http://og1yl0w9z.bkt.clouddn.com/17-10-19/60745998.jpg) | ![](http://og1yl0w9z.bkt.clouddn.com/17-10-19/51197335.jpg) |
| 描述 | 通过 storyboard 搭建基本框架 | 空数据情况下 | 网络错误情况下 |


## Advantage 框架的优势
* 1.文件少，代码简洁
* 2.不依赖任何其他第三方库
* 3.样式视图和功能模块分离解耦实现
* 4.具备较高自定义性


## Requirements 要求
* iOS 7+
* Xcode 8+
* Swift 3+


## Usage 使用方法
### 定义枚举 列举需要显示的多种情况
可以在基类中声明
```
public var errorType = ErrorType.NoData

public struct ErrorType {
    static let NoData = 1
    static let NoNetWork = 2
}
```
### 延展使用占位视图
```
let placeholderView = PlaceholderView()

// MARK:- PlaceholderView
extension ViewController {
    /*
     * 显示占位视图主要功能实现部分
     * 注意：基类中设置通用声明
     */
    func createPlaceholderView() {
        tableView.placeholder = {[weak self] _ in
            if let _self = self {
                switch _self.errorType {
                case ErrorType.NoData:
                    self?.placeholderView.errorType = ErrorType.NoData
                    return self!.placeholderView
                case ErrorType.NoNetWork:
                    self?.placeholderView.errorType = ErrorType.NoNetWork
                    return self!.placeholderView
                default:
                    return UIView()
                }
            }
            return UIView()
        }
        tableView.placeholder_reloadData()
    }
}
```
### 重新加载事件处理
```
placeholderView.callBackBlock { (ClickString) in
      print(ClickString)
      self.placeholderView.errorType = ErrorType.NoData
      self.testTimerAction()
}
```

使用简单、效率高效、进程安全~~~如果你有更好的建议,希望不吝赐教!


## License 许可证
RSPlaceholderView 使用 MIT 许可证，详情见 LICENSE 文件。


## Contact 联系方式:
* WeChat : WhatsXie
* Email : ReverseScale@iCloud.com
* Blog : https://reversescale.github.io
