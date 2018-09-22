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
        
        let nc = UNUserNotificationCenter.current()
        
        nc.requestAuthorization(options: [.alert, .sound]) { (accept, error) in
            if(accept){
                print("temos permissao para enviar notificacao")
                return
            }
            print("usuario nao nos deu permissao para enviar a notificacao")
        }
        
        nc.delegate = self
        
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
        let trigger = UNCalendarNotificationTrigger(dateMatching: date.compoments, repeats: false)
        
        //passo 1-2 criando e registrando uma categoria para a nossa notificacao
        // criaremos um botao e o associamos a uma categoria
        
        let rememberAction = UNNotificationAction(identifier: "action_remember", title: "lembrar mais tarde", options: [.foreground])
        
        let category = UNNotificationCategory(identifier: "categoria_remember", actions: [rememberAction], intentIdentifiers: [], options: [])

        nc.setNotificationCategories([category])
        
        // passo 2 criacao  notificacao
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Notificacao Calendario"
        notificationContent.body = "Notificacao local teste de hora marcada"
        notificationContent.sound = UNNotificationSound.default()
        
        //passo 02-2: Atribuindo uma categoria a notificacao
        notificationContent.categoryIdentifier =  "categoria_remember"
        
        // passo 3 criacao da requisicao da notificacao
        let notificationRequest = UNNotificationRequest(identifier: "nHorario", content: notificationContent, trigger: trigger)
        
        // passo 4 adicao da requisicao de notificacao a fila de notificacao
        nc.removeAllPendingNotificationRequests()
        
        //add a nova notificacao na fila
        nc.add(notificationRequest, withCompletionHandler: nil)
        
        NSLog("Adicionei uma nova requisicao a fila")
        
        
        
    }


    @IBAction func changeDate(_ sender: UIDatePicker) {
        let date = sender.date
        createNotification(on: date)
    }
}

extension ViewController : UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == "action_remember"{
            let newDate = Date(timeInterval: 61.0, since: Date())
            print("Agendando uma nova data")
            createNotification(on: newDate)
        }
        completionHandler()
    }
}


//criando um extensio para converter Date em DateComponents
extension Date{
    var compoments : DateComponents{
        let calendar = Calendar(identifier: .gregorian)
        let dateComponents = calendar.dateComponents(in: .current, from: self)
        
        let finalCompoments = DateComponents(calendar: calendar, timeZone: .current ,month: dateComponents.month, day: dateComponents.day, hour: dateComponents.hour, minute: dateComponents.minute)
        
        return finalCompoments
    }
    
}


