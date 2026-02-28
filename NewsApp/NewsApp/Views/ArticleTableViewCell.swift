//
//  ArticleTableViewCell.swift
//  NewsApp
//
//  Created by Abdulkarim Mziya on 2026-02-27.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    static let cellIdentifier = "ArticleCell"
    
    // MARK: UI Components
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let articleImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 8
        iv.clipsToBounds = true
        iv.backgroundColor = .systemGray6
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("")
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(authorLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(articleImageView)
        
        NSLayoutConstraint.activate([
            // Image
            articleImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -16),
            articleImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            articleImageView.widthAnchor.constraint(equalToConstant: 130),
            articleImageView.heightAnchor.constraint(equalToConstant: 130),
            
            // Title
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: articleImageView.leadingAnchor, constant:-12),
            
            // Author
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            authorLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            // Date
            dateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 4),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant:-8)
        ])
    }
    
    func configure(with article: Article) {
        titleLabel.text = article.title
        authorLabel.text = article.author ?? article.source.name
        dateLabel.text = article.publishedAt
        
        
        articleImageView.contentMode = .center
        articleImageView.image = UIImage(systemName: "newspaper")
            
        Task {
            if let image = try? await NewsService.fetchImage(from:article.urlToImage) {
                DispatchQueue.main.async {
                    self.articleImageView.contentMode = .scaleAspectFill
                    self.articleImageView.image = image
                }
            }
        }
    }

}
