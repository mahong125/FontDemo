//
//  ViewController.swift
//  YBFont
//
//  Created by mahong on 2017/9/5.
//  Copyright © 2017年 Runbey. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    // MARK: - 定义常量
    let cellId = "FontIdentifier"
    
    // MARK: - 懒加载
    lazy var mainTable: UITableView = {
        let table = UITableView.init(frame: self.view.bounds, style: UITableViewStyle.plain)
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    var sections: [String] = [String]()
    
    // MARK: - 定义字典
    var dict : [String : Array<String>] = [String : Array<String>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "元贝字体"
        self.view.backgroundColor = UIColor.white
        
        let fonts = UIFont.familyNames
        
        sections = fonts.sorted(by: { (s1, s2) -> Bool in
            return s1 < s2
        })
        
        for font in fonts {
            var arr: [String] = [String]()
            let fontName = UIFont.fontNames(forFamilyName: font)
            for name in fontName {
                arr.append(name)
            }
            dict[font] = arr
        }

//        for (key,value) in dict {
//            print("key is \(key) - value is \(value) \n")
//            
//        }
        
        
        print(dict)
        
        mainTable.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellId)
        self.view.addSubview(mainTable)
        
        
    }
    
    /** UITableView DataSource */
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = sections[section]
        let values = dict[key]
        
        if (values?.count == 0) {
            return 1
        }
        else{
            return (values?.count)!
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        
        let key = sections[indexPath.section]
        let values = dict[key]
        let fontSize: CGFloat = 16.0
        var fontName : String?
        if (values?.count == 0){
            fontName = key
        }
        else{
            fontName = values?[indexPath.row]
        }
        
        cell?.textLabel?.text = "字体名称:\(fontName!)) 字号:\(fontSize)"
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.font = UIFont.init(name: fontName!, size: fontSize)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    /** UITableView Delegate */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

