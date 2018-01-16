//
//  ViewController.swift
//  Three_meditation_a_day
//
//  Created by Park GilNam on 2018. 1. 6..
//  Copyright © 2018년 ParkGilNam. All rights reserved.
//

import UIKit

protocol SelectDateSendDelegate {
    func selectDateSend(selectDate:Date)
}

class ViewController: UIViewController, SelectDateSendDelegate {
    
    @IBOutlet weak var navigationTitleButton: UIButton!
    
    //1주차
    @IBOutlet weak var sunday1Weeks: UIButton!
    @IBOutlet weak var monday1Weeks: UIButton!
    @IBOutlet weak var tuesday1Weeks: UIButton!
    @IBOutlet weak var wednesday1Weeks: UIButton!
    @IBOutlet weak var thursday1Weeks: UIButton!
    @IBOutlet weak var firday1Weeks: UIButton!
    @IBOutlet weak var saturday1Weeks: UIButton!
    
    //2주차
    @IBOutlet weak var sunday2Weeks: UIButton!
    @IBOutlet weak var monday2Weeks: UIButton!
    @IBOutlet weak var tuesday2Weeks: UIButton!
    @IBOutlet weak var wednesday2Weeks: UIButton!
    @IBOutlet weak var thursday2Weeks: UIButton!
    @IBOutlet weak var firday2Weeks: UIButton!
    @IBOutlet weak var saturday2Weeks: UIButton!
    
    //3주차
    @IBOutlet weak var sunday3Weeks: UIButton!
    @IBOutlet weak var monday3Weeks: UIButton!
    @IBOutlet weak var tuesday3Weeks: UIButton!
    @IBOutlet weak var wednesday3Weeks: UIButton!
    @IBOutlet weak var thursday3Weeks: UIButton!
    @IBOutlet weak var firday3Weeks: UIButton!
    @IBOutlet weak var saturday3Weeks: UIButton!
    
    //4주차
    @IBOutlet weak var sunday4Weeks: UIButton!
    @IBOutlet weak var monday4Weeks: UIButton!
    @IBOutlet weak var tuesday4Weeks: UIButton!
    @IBOutlet weak var wednesday4Weeks: UIButton!
    @IBOutlet weak var thursday4Weeks: UIButton!
    @IBOutlet weak var firday4Weeks: UIButton!
    @IBOutlet weak var saturday4Weeks: UIButton!
    
    //5주차
    @IBOutlet weak var sunday5Weeks: UIButton!
    @IBOutlet weak var monday5Weeks: UIButton!
    @IBOutlet weak var tuesday5Weeks: UIButton!
    @IBOutlet weak var wednesday5Weeks: UIButton!
    @IBOutlet weak var thursday5Weeks: UIButton!
    @IBOutlet weak var firday5Weeks: UIButton!
    @IBOutlet weak var saturday5Weeks: UIButton!
    
    //6주차
    @IBOutlet weak var sunday6Weeks: UIButton!
    @IBOutlet weak var monday6Weeks: UIButton!
    @IBOutlet weak var tuesday6Weeks: UIButton!
    @IBOutlet weak var wednesday6Weeks: UIButton!
    @IBOutlet weak var thursday6Weeks: UIButton!
    @IBOutlet weak var firday6Weeks: UIButton!
    @IBOutlet weak var saturday6Weeks: UIButton!
    
    var daysButtons:[[UIButton]] = [[UIButton]]()
    var selectDate:Date = Date.init()
    
    fileprivate var user:KOUser? = nil
    fileprivate var doneSignup:Bool = false
    fileprivate var singleTapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        daysButtons = [[sunday1Weeks, monday1Weeks, tuesday1Weeks, wednesday1Weeks, thursday1Weeks, firday1Weeks, saturday1Weeks],
        [sunday2Weeks, monday2Weeks, tuesday2Weeks, wednesday2Weeks, thursday2Weeks, firday2Weeks, saturday2Weeks],
        [sunday3Weeks, monday3Weeks, tuesday3Weeks, wednesday3Weeks, thursday3Weeks, firday3Weeks, saturday3Weeks],
        [sunday4Weeks, monday4Weeks, tuesday4Weeks, wednesday4Weeks, thursday4Weeks, firday4Weeks, saturday4Weeks],
        [sunday5Weeks, monday5Weeks, tuesday5Weeks, wednesday5Weeks, thursday5Weeks, firday5Weeks, saturday5Weeks],
        [sunday6Weeks, monday6Weeks, tuesday6Weeks, wednesday6Weeks, thursday6Weeks, firday6Weeks, saturday6Weeks]]
         
        let currentDate = Date.init()
        
        UserDefaults.standard.set(currentDate, forKey: Define.forKeyStruct.selectDate)
        
        navigationTitleSetting(currentDate: currentDate)
        currentDateSetting(currentDate: currentDate)
        
        let logoutButton = UIBarButtonItem(title: "로그아웃", style: UIBarButtonItemStyle.plain, target: self, action: #selector(logoutAction(sender:)))
        self.navigationItem.leftBarButtonItem = logoutButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        requestMe()
    }
    
    fileprivate func requestMe(_ displayResult: Bool = false) {
        KOSessionTask.meTask { [weak self] (user, error) -> Void in
            if let error = error as NSError? {
                print(error)
                self?.doneSignup = false
            } else {
                if displayResult {
                    print((user as! KOUser).description)

                }
                
                self?.doneSignup = true
                self?.user = (user as! KOUser)
                
                print(self?.user?.email ?? "--")
            }
        }
    }
    
    @objc func logoutAction(sender:UIBarButtonItem) {
        KOSession.shared().logoutAndClose { [weak self] (success, error) -> Void in
            _ = self?.navigationController?.popViewController(animated: true)
        }
    }
    
    //navigation title 세팅
    func navigationTitleSetting(currentDate:Date) {
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: Define.dateFormat.localeIdentifier) as Locale!
        formatter.dateFormat = Define.dateFormat.yearMonth
        
        let dateString = formatter.string(from: currentDate)
        
        navigationTitleButton.setTitle("\(dateString)", for: UIControlState.normal)
        
        selectDate = currentDate
    }
    
    //현재 날짜를 강조
    func currentDateSetting(currentDate:Date) {
        let calendar = Calendar(identifier: .gregorian)
        
        let weekDay = calendar.dateComponents([.weekday], from: currentDate)
        let weekOfMonth = calendar.dateComponents([.weekOfMonth], from: currentDate)
        
        let weekOfMonthButtons = daysButtons[weekOfMonth.weekOfMonth! - 1]
        let button = weekOfMonthButtons[weekDay.weekday! - 1]
    
        button.backgroundColor = UIColor(red: 0.53, green: 0.035, blue: 0.035, alpha: 1)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.layer.cornerRadius = 10
        
        let formatter = DateFormatter()
        formatter.locale = NSLocale(localeIdentifier: Define.dateFormat.localeIdentifier) as Locale!
        formatter.dateFormat = Define.dateFormat.day
        
        let dayString = formatter.string(from: currentDate)
        
        button.setTitle(dayString, for: UIControlState.normal)
    }

    //날짜를 선택하면 Detail page로 이동
    @IBAction func goDetailPage(_ sender: UIButton) {
        
        if sender.currentTitle != nil {
            let storyboard  = UIStoryboard(name: "Main", bundle: nil)
            
            let vc = storyboard.instantiateViewController(withIdentifier: "Detail")
            vc.navigationItem.title = "\(navigationTitleButton.title(for: UIControlState.normal)!). \(sender.currentTitle!)"
            
            self.navigationController!.pushViewController(vc, animated: true)
        }
    }
    
    //월 선택 창에서 선택된 데이터로 타이틀 세팅
    func selectDateSend(selectDate: Date) {
        navigationTitleSetting(currentDate:selectDate)
    }
    
    //월 선택창 열기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectDatePopup" {
            
            let viewController : SelectDatePopupViewController = segue.destination as! SelectDatePopupViewController
            
            viewController.delegate = self
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

