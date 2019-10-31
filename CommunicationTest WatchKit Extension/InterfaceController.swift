//
//  InterfaceController.swift
//  CommunicationTest WatchKit Extension
//
//  Created by Parrot on 2019-10-26.
//  Copyright © 2019 Parrot. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {

    
    // MARK: Outlets
    // ---------------------
    @IBOutlet var messageLabel: WKInterfaceLabel!
   
    // Imageview for the pokemon
    @IBOutlet var pokemonImageView: WKInterfaceImage!
    // Label for Pokemon name (Albert is hungry)
    @IBOutlet var nameLabel: WKInterfaceLabel!
    // Label for other messages (HP:100, Hunger:0)
    @IBOutlet var outputLabel: WKInterfaceLabel!
    
    
    @IBOutlet var hungerLabel: WKInterfaceLabel!
    
    // MARK: Delegate functions
    // ---------------------

    // Default function, required by the WCSessionDelegate on the Watch side
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //@TODO
    }
    
    // 3. Get messages from PHONE
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("WATCH: Got message from Phone")
        // Message from phone comes in this format: ["course":"MADT"]
       let name = message["name"] as! String
        messageLabel.setText(name)
        nameLabel.setText(name)
    }
    


    
    // MARK: WatchKit Interface Controller Functions
    // ----------------------------------
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        
        // 1. Check if teh watch supports sessions
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
        
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        super.willActivate()
        print("---WATCH APP LOADED---")
             
             if (WCSession.isSupported() == true) {
                 messageLabel.setText("WC is supported!")
                 
                 // create a communication session with the phone
                 let session = WCSession.default
                 session.delegate = self
                 session.activate()
             }
             else {
                 messageLabel.setText("WC NOT supported!")
             }
             
        
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    
    var mesageCounter = 0
    
    // MARK: Actions
    // ---------------------
    @IBAction func messageToPhone() {
        
        if (WCSession.default.isReachable == true) {
                  
                  print("---sendind message to phone---")
                         // Here is the message you want to send to the watch
                         // All messages get sent as dictionaries
                         let message = ["name":"Pikachu",
                                       ] as [String : Any]
                         
                         // Send the message
                         WCSession.default.sendMessage(message, replyHandler:nil)
                         mesageCounter = mesageCounter + 1
                          nameLabel.setText("Message Sent \(mesageCounter)")
          }
    }
    
    // 2. When person presses button on watch, send a message to the phone
    @IBAction func buttonPressed() {
        
       
    }
    
    @IBAction func pushNameButton() {
        
        
        
    }
    
    // MARK: Functions for Pokemon Parenting
    @IBAction func nameButtonPressed() {
        print("name button pressed")
        
        nameLabel.setText("look Above PokeBall!!")
    }

    var health:Int = 100
    
    var hunger:Int = 0
    
    @IBAction func startButtonPressed() {
        print("Start button pressed")
        print("Baby is awake and Active.....")
        // It will reduce the health of the pokemon and will Increase the Hunger
        if(health >= 10)
        {
        health = health - 10;
          outputLabel.setText("Health: \(health)")
        if(health <= 80)
        {
            hunger = hunger + 10
            hungerLabel.setText("Hunger:\(hunger)")
        }
        }
        else
        {
            outputLabel.setText(" Dead Bad Parent!!")
        }
        
    }
    
    @IBAction func feedButtonPressed() {
        print("Feed button pressed")
        
        if(health < 100 && hunger > 0)
        {
            health = health + 10
            hunger = hunger - 10
            
            outputLabel.setText("Health:\(health)")
            hungerLabel.setText("Hunger:\(hunger)")
        }
        else
        {
            outputLabel.setText("Fully Active!!")
            hungerLabel.setText("Boom Boom !!")
        }
    }
    
    @IBAction func hibernateButtonPressed() {
        
        // in this pokemon will recover and health will set to 100
        print("Hibernate button pressed")
        
        health = 100
        
        hungerLabel.setText("LAMO! in recovery Mode")
    }
    
}
