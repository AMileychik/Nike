//
//  VideoCell.swift
//  LagomStore
//
//  Created by Александр Милейчик on 10/8/24.
//

import UIKit
import AVKit

class VideoCell: UITableViewCell {
    
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    private var playerItem: AVPlayerItem?
    
    private var gradientView: GradientView?
    private lazy var muteButton = UIButton()
    
    private lazy var bottomButton = HeaderButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        configureMuteButton()
        configureBottomButton()
        setupButtonActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var onBottomButtonTapped: (() -> Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = contentView.bounds
    }
    
    func configureMuteButton() {
        muteButton.setImage(UIImage(systemName: "speaker.slash.fill"), for: .normal)
        muteButton.tintColor = .white
        muteButton.addTarget(self, action: #selector(muteButtonTapped), for: .touchUpInside)
    }
    
    func configureBottomButton() {
        bottomButton.customButton.setTitle(Text.Video.viewAll, for: .normal)
        bottomButton.customButton.setTitleColor(.white, for: .normal)
        bottomButton.customButton.layer.cornerRadius = 24
        bottomButton.customButton.layer.borderColor = UIColor.gray.cgColor
        bottomButton.customButton.layer.borderWidth = 1.0
        bottomButton.customButton.backgroundColor = UIColor.black.adjustBrightness(by: 0.1)
        bottomButton.customButton.layer.cornerRadius = 16
    }
    
    @objc private func muteButtonTapped() {
        player?.isMuted.toggle()
        
        let imageName = player?.isMuted == true ? "speaker.slash.fill" : "speaker.3.fill"
        muteButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        player?.pause()
        playerLayer?.removeFromSuperlayer()
        player = nil
        playerLayer = nil
        
        gradientView?.removeFromSuperview()
        gradientView = nil
        
        resetMuteButton()
    }
    
    func resetMuteButton() {
        muteButton.setImage(UIImage(systemName: "speaker.slash.fill"), for: .normal)
        player?.isMuted = true
    }
    
    func update(url: URL, addGradient: Bool, isMuted: Bool) {
        if player == nil {
            playerItem = AVPlayerItem(url: url)
            player = AVPlayer(playerItem: playerItem)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.videoGravity = .resizeAspectFill
            contentView.layer.addSublayer(playerLayer!)
        }
        
        player?.isMuted = isMuted
        if addGradient, gradientView == nil {
            let gradient = GradientView()
            gradient.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(gradient)
            NSLayoutConstraint.activate([
                gradient.topAnchor.constraint(equalTo: contentView.topAnchor),
                gradient.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                gradient.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                gradient.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
            self.gradientView = gradient
        }
    }
    
    func playVideo() {
        player?.play()
    }
}


//MARK: - Layout
extension VideoCell {

    func setupViews() {
        contentView.addSubview(muteButton)
        contentView.addSubview(bottomButton)
    }

    private func setupConstraints() {
        muteButton.translatesAutoresizingMaskIntoConstraints = false
        bottomButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            muteButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            muteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            muteButton.widthAnchor.constraint(equalToConstant: 40),
            muteButton.heightAnchor.constraint(equalToConstant: 40),
            
            bottomButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            bottomButton.widthAnchor.constraint(equalToConstant: 90),
            bottomButton.heightAnchor.constraint(equalToConstant: 35),
            bottomButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
}

//MARK: - Event Handler
extension VideoCell {
    
    func setupButtonActions() {
        bottomButton.onButtonTapped = { [weak self] in
            self?.onBottomButtonTapped?()
        }
    }
}
