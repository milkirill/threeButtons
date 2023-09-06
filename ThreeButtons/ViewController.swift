//
//  ViewController.swift
//  ThreeButtons
//
//  Created by Kirill Milekhin on 05/09/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let btn1 = MyButton(with: "First Button")
    let btn2 = MyButton(with: "Second Medium Button")
    let btn3 = MyButton(with: "Third")
    
    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(btn1)
        view.addSubview(btn2)
        view.addSubview(btn3)
        addAction()
        makeConstraints()
    }
    
    func addAction() {
        btn3.addAction(
            UIAction { [weak self] _ in
                let vc = UIViewController()
                vc.view.backgroundColor = .white
                self?.present(vc, animated: true)
            },
            for: .touchUpInside
        )
    }
    
    func makeConstraints() {
        btn1.translatesAutoresizingMaskIntoConstraints = false
        btn2.translatesAutoresizingMaskIntoConstraints = false
        btn3.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            btn1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            btn2.topAnchor.constraint(equalTo: btn1.bottomAnchor, constant: 10),
            btn3.topAnchor.constraint(equalTo: btn2.bottomAnchor, constant: 10),
            btn1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btn2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            btn3.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
}
