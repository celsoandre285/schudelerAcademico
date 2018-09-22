//
//  ViewController.swift
//  Scheduler
//
//  Created by Swift on 22/09/2018.
//  Copyright © 2018 quaddro. All rights reserved.
//

//importar lib userNotification

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createNotification(on date:Date){
        
        //passos necessarios a criacao da notificacao
        
        //precisamos antes de tudo de utilizar uma UNUserNotificationCenter.
        //Ele é responsavel por gerenciar as notificacoes da aplicacao
        
        let nc = UNUserNotificationCenter.current()
        
        // passo 1 criacao do gatilho
        let trigger = UNCalendarNotificationTrigger(dateMatching: <#T##DateComponents#>, repeats: false)
        // passo 2 criacao  notificacao
        // passo 3 criacao da requisicao da notificacao
        // passo 4 adicao da requisicao de notificacao a fila de notificacao
        
        
        
    }


    @IBAction func changeDate(_ sender: UIDatePicker) {
        let date = sender.date
        createNotification(on: date)
    }
}

