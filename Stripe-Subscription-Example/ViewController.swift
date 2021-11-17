//
//  ViewController.swift
//  Stripe-Subscription-Example
//
//  Created by Dinesh Vijaykumar on 17/11/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private var createCustomerButton: UIButton!
    @IBOutlet private var subscribeButton: UIButton!
    @IBOutlet private var statusTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createCustomerButton.isHidden = false
        subscribeButton.isHidden = true
    }
    
    @IBAction private func createCustomer(_ sender: Any) {
        guard let url = URL(string: Constants.backendUrl)?.appendingPathComponent("/createCustomer") else { return }
        
        let body: [String: Any] = [
            "email": "testUser@example.com"
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
            guard
                let response = response as? HTTPURLResponse,
                response.statusCode == 200,
                let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any],
                let customer = json["customer"] as? String
            else {
                let message = error?.localizedDescription ?? "Failed to decode response from server."
                self?.statusTextView.text.append(contentsOf: "Error loading page - message: \(message)")
                return
            }
            
            DispatchQueue.main.async {
                self?.createCustomerButton.isHidden = true
                self?.subscribeButton.isHidden = false
                
                let message = "Customer \(customer) has been created"
                self?.statusTextView.text.append(contentsOf: "\n\(message)")
            }
        })
        
        task.resume()
    }
    
    @IBAction private func subscribe(_ sender: Any) {
        
    }
    
    
}

