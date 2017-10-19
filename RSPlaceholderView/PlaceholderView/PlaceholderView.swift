//
//  PlaceholderView.swift
//  SquirrelPay
//
//  Created by WhatsXie on 2017/10/19.
//  Copyright © 2017年 StevenXie. All rights reserved.
//

import UIKit

public struct ErrorType {
    static let NoData = 1
    static let NoNetWork = 2
}

class PlaceholderView: UIView {
    var contentView:UIView!
    
    typealias swiftBlock = (_ str: String) -> Void
    var callBack : swiftBlock?


    var errorType = ErrorType.NoData {
        didSet{
            initialSetup()
        }
    }
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var reloadButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView = loadViewFromNib()
        addSubview(contentView)
        addConstraints()
        
        initialSetup()
        setupStyle()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        contentView = loadViewFromNib()
        addSubview(contentView)
        addConstraints()
        
        initialSetup()
        setupStyle()
    }
    
    public func initialSetup() {
        switch self.errorType {
        case ErrorType.NoData:
            return noData()
        case ErrorType.NoNetWork:
            return noNetWork()
        default:
            return otherPlaceholderView()
        }
    }
    func noData() {
        iconImageView.image = UIImage(named:"NoData")
        textLabel.text = "暂无数据"
        reloadButton.isHidden = true
    }
    func noNetWork() {
        iconImageView.image = UIImage(named:"NoNetWork")
        textLabel.text = "页面加载失败，请稍后再试"
        reloadButton.isHidden = false
    }
    func otherPlaceholderView() {
        print("其他占位情况")
    }
    @IBAction func reloadButtonAction(_ sender: Any) {
        if callBack != nil {
            callBack!("ReloadAction")
        }
    }
    func callBackBlock(_ block: @escaping (_ str: String) -> Void) {
        callBack = block
    }

    func setupStyle() {
        textLabel.textColor = UIColor.gray
        
        reloadButton.layer.cornerRadius = 10
        reloadButton.layer.borderWidth = 0.5
        reloadButton.layer.borderColor = UIColor.blue.cgColor
    }
    func loadViewFromNib() -> UIView {
        let className = type(of: self)
        let bundle = Bundle(for: className)
        let name = NSStringFromClass(className).components(separatedBy: ".").last
        let nib = UINib(nibName: name!, bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return view
    }
    
    func addConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        var constraint = NSLayoutConstraint(item: contentView, attribute: .leading,
                                            relatedBy: .equal, toItem: self, attribute: .leading,
                                            multiplier: 1, constant: 0)
        addConstraint(constraint)
        constraint = NSLayoutConstraint(item: contentView, attribute: .trailing,
                                        relatedBy: .equal, toItem: self, attribute: .trailing,
                                        multiplier: 1, constant: 0)
        addConstraint(constraint)
        constraint = NSLayoutConstraint(item: contentView, attribute: .top, relatedBy: .equal,
                                        toItem: self, attribute: .top, multiplier: 1, constant: 0)
        addConstraint(constraint)
        constraint = NSLayoutConstraint(item: contentView, attribute: .bottom,
                                        relatedBy: .equal, toItem: self, attribute: .bottom,
                                        multiplier: 1, constant: 0)
        addConstraint(constraint)
    }

}
