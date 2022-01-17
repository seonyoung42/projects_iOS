//
//  AlartListCell.swift
//  Drink
//
//  Created by 장선영 on 2022/01/13.
//

import UIKit
import UserNotifications

class AlartListCell: UITableViewCell {
    
    let meridiumLabel : UILabel = {
        let label = UILabel()
        label.text = "오전"
        label.font = UIFont.systemFont(ofSize: 28, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeLabel : UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = UIFont.systemFont(ofSize: 50, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let alartSwitch: UISwitch = {
        let switches = UISwitch()
        switches.addTarget(self, action: #selector(alartSwitchValueChanged(_:)), for: .touchUpInside)
        switches.translatesAutoresizingMaskIntoConstraints = false
        return switches
    }()
    
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        addSubview(meridiumLabel)
        addSubview(timeLabel)
        addSubview(alartSwitch)
        
        meridiumLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        meridiumLabel.bottomAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: -8).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: meridiumLabel.trailingAnchor, constant: 0).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        alartSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        alartSwitch.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
                
        self.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func alartSwitchValueChanged(_ sender: UISwitch) {
        guard let data = UserDefaults.standard.value(forKey: "alerts") as? Data,
              var alerts = try? PropertyListDecoder().decode([Alert].self, from: data) else { return }
        
        alerts[sender.tag].isOn = sender.isOn
        UserDefaults.standard.set(try? PropertyListEncoder().encode(alerts), forKey: "alerts")
        
        if sender.isOn {
            userNotificationCenter.addNotificationRequest(by: alerts[sender.tag])
        } else {
            userNotificationCenter.removePendingNotificationRequests(withIdentifiers: [alerts[sender.tag].id])
        }
    }
}
