//
//  TableViewCell.swift
//  vkTest
//
//  Created by Владислав Гайденко on 13.07.2022.
//

import UIKit
import SDWebImage

class CustomTableViewCell: UITableViewCell {
    
    static var id = "CustomTableViewCell"
    
    enum sizeRows {
        static let midlePlus: CGFloat = 16
        static let midleMinus: CGFloat = -16
        static let iconSize: CGFloat = 50
        static let light: CGFloat = 8
    }
    
    private let previeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let previeDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let previeImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.accessoryType = .disclosureIndicator
        contentView.addSubview(previeImage)
        contentView.addSubview(previeLabel)
        contentView.addSubview(previeDescription)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Service) {
        guard let url = URL(string: model.icon_url ?? "https://publicstorage.hb.bizmrg.com/sirius/vk.png") else {return}
        previeImage.sd_setImage(with: url, completed: nil)
        previeLabel.text = model.name
        previeDescription.text = model.description
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            previeImage.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: sizeRows.midlePlus),
            previeImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: sizeRows.midlePlus),
            previeImage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: sizeRows.midleMinus),
            previeImage.widthAnchor.constraint(equalToConstant: sizeRows.iconSize),
            previeImage.heightAnchor.constraint(equalToConstant: sizeRows.iconSize),
            
            previeLabel.leadingAnchor.constraint(equalTo: previeImage.trailingAnchor, constant: sizeRows.midlePlus),
            previeLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: sizeRows.midlePlus),
            previeLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: sizeRows.midleMinus),
            
            previeDescription.leadingAnchor.constraint(equalTo: previeImage.trailingAnchor, constant: sizeRows.midlePlus),
            previeDescription.topAnchor.constraint(equalTo: previeLabel.bottomAnchor, constant: sizeRows.light),
            previeDescription.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -sizeRows.midlePlus),
        ])
    }
}
