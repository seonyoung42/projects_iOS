//
//  AlartListCell.swift
//  Drink
//
//  Created by 장선영 on 2022/01/13.
//

import UIKit

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
        switches.translatesAutoresizingMaskIntoConstraints = false
        switches.addTarget(self, action: #selector(alartSwitchValueChanged(_:)), for: .touchUpInside)
        return switches
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        addSubview(meridiumLabel)
        addSubview(timeLabel)
        addSubview(alartSwitch)
        meridiumLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        meridiumLabel.bottomAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 8).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: meridiumLabel.trailingAnchor, constant: 0).isActive = true
//        label2.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        timeLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        label2.bottomAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        alartSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        alartSwitch.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        self.heightAnchor.constraint(equalToConstant: 80).isActive = true
        self.widthAnchor.constraint(equalToConstant: 375).isActive = true
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
    }

}
