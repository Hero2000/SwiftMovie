//
//  homepageViewController.swift
//  SwiftMovie
//
//  Created by 尹一博 on 17/4/17.
//  Copyright © 2017年 test.com. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyJSON
import Alamofire
class homepageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    var baby = ["宝宝0","宝宝1","宝宝2","宝宝3","宝宝4","宝宝5","宝宝6","宝宝7","宝宝8","宝宝9","宝宝10","宝宝11"]
    lazy var box = UIView()
    var scacle = 1.0
    //保存约束的引用
    var topConstraint:Constraint?
    var dataInfo:JsonModel?
    
    var txtUser: UITextField! //用户名输入框
    var txtPwd: UITextField! //密码输入款
    var formView: UIView! //登陆框视图
    var horizontalLine: UIView! //分隔线
    var confirmButton:UIButton! //登录按钮
    var titleLabel: UILabel! //标题标签
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.red;
        self.title = "首页";
        
//
//        var str1:String?  // str1值可能是传过来的值或者从服务器获取的值
//        let msg = "Hi"
//        let txt = msg + str1! // runtime error
//        print(" txt == \(txt)")
        
        var tableView = UITableView()
        self.changeWidth(width:100)
//        //创建一个ContactAdd类型的按钮
//        let button:UIButton = UIButton(type:UIButtonType.custom)
//        //设置按钮位置和大小
////        button.frame = CGRect(x:10, y:150, width:100, height:30)
//        //设置按钮文字
//        button.setTitle("按钮", for:.normal)
//        self.view.addSubview(button)
//
//        button.snp.makeConstraints { (make) in
//            make.width.equalTo(200)
//            make.height.equalTo(40)
//            make.top.equalTo(200)
//            make.left.equalTo(30)
//        }
//        
//        button.addTarget(self, action:#selector(tapped), for:.touchUpInside)

        
//        testSnap()
        
          testLogin()
          testJson()
//        //之前这个地方定义的是var tableView局部变量，导致点了delete没反应
//        tableView = UITableView(frame: CGRect(x:0,y:0,width:0,height:0), style: UITableViewStyle.plain)
//        tableView.dataSource = self
//        tableView.delegate = self
//        self.view.addSubview(tableView)
//        
//        tableView.snp.makeConstraints { (make) in
//            //距self.view的上边0
//            make.top.equalTo(self.view).offset(0)
//            //距self.view的左边0
//            make.left.equalTo(self.view).offset(0)
//            //距self.view的右边0（右边数字前要加减号,不然会变成超出右边30）
//            make.right.equalTo(self.view).offset(0)
//            //距self.view的下边0（下边数字前要加减号,不然会变成超出下边50）
//            make.bottom.equalTo(self.view).offset(0)
//        
//        }
        // Do any additional setup after loading the view.
    }
    
    func testJson()  {
        
        Alamofire.request("https://httpbin.org/get", method: .get, parameters: nil).responseJSON { (returnResult) in
            print("GET_Request --> GET 请求 --> returnResult = \(returnResult)")
                        if let data = returnResult.data , let utf8string = String(data: data , encoding:.utf8) {
                            print("utf8string = \(utf8string)")
                            
                            
                            
                                    if let object = JsonModel.deserialize(from: String(describing: utf8string)) {
                                        print("origin ==  \(String(describing:  object.origin!))")
                                        print("url ==  \(String(describing:  object.url!))")
                                        print("headers == \( object.headers)")
                                        self.dataInfo = object;
                                        self.testLog()
                                        
                                    }
                        }
//            if let json = returnResult.result.value {
//                print("firstMethod --> responseJSON --> \(json)")
//                /*  返回请求地址、数据、和状态结果等信息
//                 print("firstMethod --> responseJSON() --> \(returnResult.request!)")
//                 print("firstMethod --> responseJSON() --> \(returnResult.data!)")
//                 print("firstMethod --> responseJSON() --> \(returnResult.result)")
//                 */
////                JsonModel.deserialize(from: json)
////                if let object = JsonModel.deserialize(from: json) {
////                    print("name ==  \(String(describing:  object.doubleOptional!))")
////                }
//               
//                
//                if let object = JsonModel.deserialize(from: String(describing: json)) {
//                    print("origin ==  \(String(describing:  object.origin!))")
//                    print("url ==  \(String(describing:  object.url!))")
//                    print("headers == \( object.headers)")
//                    
//                }
//            }
            
        }
        
        
        
        return
        
        let jsonString = "{\"doubleOptional\":1.1,\"stringImplicitlyUnwrapped\":\"hello\",\"int\":1,\"arr\":[12,13,34],\"dic\":{\"yyy\":34}}"
        if let object = BasicTypes.deserialize(from: jsonString) {
             print("name ==  \(String(describing:  object.doubleOptional!))")
        }
//        JsonModel.deserialize(from: jsonString)
        
        
        var jsonStr = "[{\"name\": \"hangge\", \"age\": 100, \"phones\": [{\"name\": \"公司\",\"number\": \"123456\"}, {\"name\": \"家庭\",\"number\": \"001\"}]}, {\"name\": \"big boss\",\"age\": 1,\"phones\": [{ \"name\": \"公司\",\"number\": \"111111\"}]}]"
        
        
         let jsonStr1 = "[{\"name\": \"hangge\", \"age\": 100, \"phones\": 123456788}]"
        
        
        if let person = Cook.deserialize(from: jsonStr1) {
            print("name == " + person.name!)
        }
        
        
        
        jsonStr = "dd"
        let jsonData = jsonStr.data(using: String.Encoding.utf8, allowLossyConversion: false);
//        var ffdata :Data;
//        
//        
//        if jsonStr.data(using: String.Encoding.utf8, allowLossyConversion: false) != nil {
//            //.........
//            ffdata = jsonStr.data(using: String.Encoding.utf8, allowLossyConversion: false)!;
//            
//        }
        
        let json = JSON(data: jsonData!)
        var result : String = ""
        if let number = json[0]["phones"][0]["number"].string {
            // 找到电话号码
            result = number
            print("第一个联系人的第一个电话号码：",number)
        }
        
         print("第一个联系人的第一个电话号码：",result)
         
    }
    func testLog(){
        print("---------------------------------- ------")
        print("origin ==  \(String(describing:  self.dataInfo?.origin!))")
        print("url ==  \(String(describing:  self.dataInfo?.url!))")
        print("headers == \( self.dataInfo?.headers)")
        
    }
    func testLogin(){
       
        //视图背景色
        self.view.backgroundColor = UIColor(red: 1/255, green: 170/255, blue: 235/255,
                                            alpha: 1)
        
        //登录框高度
        let formViewHeight = 90
        //登录框背景
        self.formView = UIView()
        self.formView.layer.borderWidth = 0.5
        self.formView.layer.borderColor = UIColor.lightGray.cgColor
        self.formView.backgroundColor = UIColor.white
        self.formView.layer.cornerRadius = 5
        self.view.addSubview(self.formView)
        //最常规的设置模式
        self.formView.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            //存储top属性
            self.topConstraint = make.centerY.equalTo(self.view).constraint
            make.height.equalTo(formViewHeight)
        }
        
        //分隔线
        self.horizontalLine =  UIView()
        self.horizontalLine.backgroundColor = UIColor.lightGray
        self.formView.addSubview(self.horizontalLine)
        self.horizontalLine.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(0.5)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.centerY.equalTo(self.formView)
        }
        
        //用户名图标
        let imgLock1 =  UIImageView(frame:CGRect(x: 11, y: 11, width: 22, height: 22))
        imgLock1.image = UIImage(named:"iconfont-user")
        
        //密码图标
        let imgLock2 =  UIImageView(frame:CGRect(x: 11, y: 11, width: 22, height: 22))
        imgLock2.image = UIImage(named:"iconfont-password")
        
        //用户名输入框
        self.txtUser = UITextField()
        self.txtUser.delegate = self
        self.txtUser.placeholder = "用户名"
        self.txtUser.tag = 100
        self.txtUser.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 44, height: 44))
        self.txtUser.leftViewMode = UITextFieldViewMode.always
        self.txtUser.returnKeyType = UIReturnKeyType.next
        
        //用户名输入框左侧图标
        self.txtUser.leftView!.addSubview(imgLock1)
        self.formView.addSubview(self.txtUser)
        
        //布局
        self.txtUser.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(44)
            make.centerY.equalTo(self.formView).offset(-formViewHeight/4)
        }
        
        //密码输入框
        self.txtPwd = UITextField()
        self.txtPwd.delegate = self
        self.txtPwd.placeholder = "密码"
        self.txtPwd.tag = 101
        self.txtPwd.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 44, height: 44))
        self.txtPwd.leftViewMode = UITextFieldViewMode.always
        self.txtPwd.returnKeyType = UIReturnKeyType.next
        
        //密码输入框左侧图标
        self.txtPwd.leftView!.addSubview(imgLock2)
        self.formView.addSubview(self.txtPwd)
        
        //布局
        self.txtPwd.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(44)
            make.centerY.equalTo(self.formView).offset(formViewHeight/4)
        }
        
        //登录按钮
        self.confirmButton = UIButton()
        self.confirmButton.setTitle("登录", for: UIControlState())
        self.confirmButton.setTitleColor(UIColor.black,
                                         for: UIControlState())
        self.confirmButton.layer.cornerRadius = 5
        self.confirmButton.backgroundColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1,
                                                     alpha: 0.5)
        self.confirmButton.addTarget(self, action: #selector(loginConfrim),
                                     for: .touchUpInside)
        self.view.addSubview(self.confirmButton)
        self.confirmButton.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(15)
            make.top.equalTo(self.formView.snp.bottom).offset(20)
            make.right.equalTo(-15)
            make.height.equalTo(44)
        }
        
        //标题label
        self.titleLabel = UILabel()
        self.titleLabel.text = "hangge.com"
        self.titleLabel.textColor = UIColor.white
        self.titleLabel.font = UIFont.systemFont(ofSize: 36)
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.formView.snp.top).offset(-20)
            make.centerX.equalTo(self.view)
            make.height.equalTo(44)
        }
        
        
    }
    
    //输入框获取焦点开始编辑
    func textFieldDidBeginEditing(_ textField:UITextField)
    {
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.topConstraint?.update(offset: -125)
            self.view.layoutIfNeeded()
        })
    }
    
    //输入框返回时操作
    func textFieldShouldReturn(_ textField:UITextField) -> Bool
    {
        let tag = textField.tag
        switch tag {
        case 100:
            self.txtPwd.becomeFirstResponder()
        case 101:
            loginConfrim()
        default:
            print(textField.text!)
        }
        return true
    }
    
    //登录按钮点击
    func loginConfrim(){
        //收起键盘
        self.view.endEditing(true)
        //视图约束恢复初始设置
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            self.topConstraint?.update(offset: 0)
            self.view.layoutIfNeeded()
        })
    }
    
    
    
    func tapped(){
        print("tapped")
//        self.scacle += 0.5
////        self.topConstraint?.update(offset: 60)
////        self.topConstraint?.deactivate()
//        self.box.snp.updateConstraints{ (make) -> Void in
//          make.width.height.equalTo(100 * self.scacle).priority(250)
//        }
        self.scacle += 0.5
        //告诉self.view约束需要更新
        self.view.setNeedsUpdateConstraints()
        //动画
        UIView.animate(withDuration: 3.0) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    
    
    func testSnap() -> Void {
        self.box.backgroundColor = UIColor.orange
        self.view.addSubview(self.box)
        
        self.box.snp.makeConstraints { (make) -> Void in
            make.center.equalTo(self.view)
            //初始宽、高为100（优先级低）
            make.width.height.equalTo(100 * self.scacle).priority(250)
            //最大尺寸不能超过屏幕
            make.width.height.lessThanOrEqualTo(self.view.snp.width)
            make.width.height.lessThanOrEqualTo(self.view.snp.height)
        }
        
    }
    //视图约束更新
    override func updateViewConstraints() {
        self.box.snp.updateConstraints{ (make) -> Void in
            //放大尺寸（优先级低）
            make.width.height.equalTo(100 * self.scacle).priority(250)
        }
        
        super.updateViewConstraints()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    //每一块有多少行
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return baby.count
    }
    
    //每个cell的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let initIdentifier = "Cell"
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: initIdentifier)
        //下面两个属性对应subtitle
        cell.textLabel?.text = baby[indexPath.row]
        cell.detailTextLabel?.text = "baby\(indexPath.row)"
        
        //添加照片
//        cell.imageView?.image = UIImage(named: babyImage[indexPath.row])
//        cell.imageView!.layer.cornerRadius = 40
//        cell.imageView!.layer.masksToBounds = true
        
        //添加附件
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
//        if isFlag[indexPath.row] {
//            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
//        }else{
//            cell.accessoryType = UITableViewCellAccessoryType.None
//        }
        return cell
        
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


extension homepageViewController {
    func changeWidth(width:Int){
        NSLog(" int \(width)")
    }
}
