//
//  VideoCell.swift
//  Nike
//
//  Created by Александр Милейчик on 10/8/24.
//

import UIKit

import AVKit

import DesignSystem
import AppCore
import AppDomain

// MARK: - Public

/// UITableViewCell responsible for playing a looping video with controls.
final class VideoCell: UITableViewCell {
    
    // MARK: - Player
    
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    private var playerItem: AVPlayerItem?
    
    // MARK: - UI Components
    
    private var gradientView: GradientView?
    private let muteButton = UIButton(type: .system)
    private let bottomButton = HeaderButton()
    
    // MARK: - Callbacks
    
    var onBottomButtonTapped: (() -> Void)?
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        configureLayout()
        configureMuteButton()
        configureBottomButton()
        configureActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stopVideo()
        removePlayer()
        removeGradient()
        resetMuteButton()
    }
}

// MARK: - Public Methods

extension VideoCell {
    
    /// Updates cell with video props
    func update(
        props: NewFromNikeRowProps.VideoProps,
        addGradient: Bool,
        isMuted: Bool
    ) {
        guard let url = Bundle.main.url(
            forResource: props.videoURL,
            withExtension: "mp4"
        ) else {
            return
        }
        
        configurePlayer(
            with: url,
            addGradient: addGradient,
            isMuted: isMuted
        )
    }
    
    func playVideo() {
        player?.play()
    }
    
    func stopVideo() {
        player?.pause()
        player?.seek(to: .zero)
    }
}

// MARK: - Actions

private extension VideoCell {
    
    func configureActions() {
        bottomButton.onButtonTapped = { [weak self] in
            self?.onBottomButtonTapped?()
        }
        
        muteButton.addTarget(
            self,
            action: #selector(muteButtonTapped),
            for: .touchUpInside
        )
    }
    
    @objc func muteButtonTapped() {
        guard let player else { return }
        player.isMuted.toggle()
        updateMuteIcon(isMuted: player.isMuted)
    }
}

// MARK: - Configuration

private extension VideoCell {
    
    func configureView() {
        contentView.addSubview(muteButton)
        contentView.addSubview(bottomButton)
    }
    
    func configureMuteButton() {
        muteButton.tintColor = .white
        updateMuteIcon(isMuted: true)
    }
    
    func configureBottomButton() {
        let button = bottomButton.customButton
        button.setTitle(Text.Video.viewAll, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.black.adjustBrightness(by: 0.1)
        button.layer.cornerRadius = Constants.bottomButtonCornerRadius
        button.layer.borderWidth = Constants.bottomButtonBorderWidth
        button.layer.borderColor = UIColor.gray.cgColor
    }
}

// MARK: - Player Configuration

private extension VideoCell {
    
    func configurePlayer(
        with url: URL,
        addGradient: Bool,
        isMuted: Bool
    ) {
        if player == nil {
            playerItem = AVPlayerItem(url: url)
            player = AVPlayer(playerItem: playerItem)
            
            let layer = AVPlayerLayer(player: player)
            layer.videoGravity = .resizeAspectFill
            contentView.layer.insertSublayer(layer, at: 0)
            playerLayer = layer
        }
        
        player?.isMuted = isMuted
        updateMuteIcon(isMuted: isMuted)
        
        if addGradient {
            addGradientIfNeeded()
        }
        
        contentView.bringSubviewToFront(muteButton)
        contentView.bringSubviewToFront(bottomButton)
    }
    
    func removePlayer() {
        playerLayer?.removeFromSuperlayer()
        playerLayer = nil
        playerItem = nil
        player = nil
    }
}

// MARK: - Gradient Handling

private extension VideoCell {
    
    func addGradientIfNeeded() {
        guard gradientView == nil else { return }
        
        let gradient = GradientView()
        gradient.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(gradient)
        
        NSLayoutConstraint.activate([
            gradient.topAnchor.constraint(equalTo: contentView.topAnchor),
            gradient.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            gradient.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            gradient.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        gradientView = gradient
    }
    
    func removeGradient() {
        gradientView?.removeFromSuperview()
        gradientView = nil
    }
}

// MARK: - Mute Button State

private extension VideoCell {
    
    func resetMuteButton() {
        updateMuteIcon(isMuted: true)
        player?.isMuted = true
    }
    
    func updateMuteIcon(isMuted: Bool) {
        let imageName = isMuted
            ? Constants.mutedIconName
            : Constants.unmutedIconName
        
        muteButton.setImage(
            UIImage(systemName: imageName),
            for: .normal
        )
    }
}

// MARK: - Layout Setup

private extension VideoCell {
    
    func configureLayout() {
        [muteButton, bottomButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            // Mute button
            muteButton.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constants.muteButtonLeading
            ),
            muteButton.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -Constants.muteButtonBottom
            ),
            muteButton.widthAnchor.constraint(
                equalToConstant: Constants.muteButtonSize
            ),
            muteButton.heightAnchor.constraint(
                equalToConstant: Constants.muteButtonSize
            ),
            
            // Bottom button
            bottomButton.centerXAnchor.constraint(
                equalTo: contentView.centerXAnchor
            ),
            bottomButton.widthAnchor.constraint(
                equalToConstant: Constants.bottomButtonWidth
            ),
            bottomButton.heightAnchor.constraint(
                equalToConstant: Constants.bottomButtonHeight
            ),
            bottomButton.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -Constants.bottomButtonBottom
            )
        ])
    }
}

// MARK: - Layout Constants

private enum Constants {
    
    // Icons
    static let mutedIconName = "speaker.slash.fill"
    static let unmutedIconName = "speaker.3.fill"
    
    // Mute button
    static let muteButtonSize: CGFloat = 40
    static let muteButtonLeading: CGFloat = 16
    static let muteButtonBottom: CGFloat = 16
    
    // Bottom button
    static let bottomButtonWidth: CGFloat = 90
    static let bottomButtonHeight: CGFloat = 35
    static let bottomButtonBottom: CGFloat = 24
    static let bottomButtonCornerRadius: CGFloat = 16
    static let bottomButtonBorderWidth: CGFloat = 1
}

// MARK: - LifecycleAwareCell

extension VideoCell: LifecycleAwareCell {
    
    func willDisplay() {
        playVideo()
    }
    
    func didEndDisplaying() {
        stopVideo()
    }
}


//  print("Video stopped")
//it stopped only when i scroll on top







//import UIKit
//
//import AVKit
//
//import DesignSystem
//import AppCore
//import AppDomain
//
//class VideoCell: UITableViewCell {
//    
//    private var player: AVPlayer?
//    private var playerLayer: AVPlayerLayer?
//    private var playerItem: AVPlayerItem?
//    private var gradientView: GradientView?
//    private lazy var muteButton = UIButton()
//    private lazy var bottomButton = HeaderButton()
//    
//    var onBottomButtonTapped: (() -> Void)?
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupViews()
//        setupConstraints()
//        configureMuteButton()
//        configureBottomButton()
//        setupButtonActions()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        playerLayer?.frame = contentView.bounds
//    }
//    
//    func configureMuteButton() {
//        muteButton.setImage(UIImage(systemName: "speaker.slash.fill"), for: .normal)
//        muteButton.tintColor = .white
//        muteButton.addTarget(self, action: #selector(muteButtonTapped), for: .touchUpInside)
//    }
//    
//    func configureBottomButton() {
//        bottomButton.customButton.setTitle(Text.Video.viewAll, for: .normal)
//        bottomButton.customButton.setTitleColor(.white, for: .normal)
//        bottomButton.customButton.layer.cornerRadius = 24
//        bottomButton.customButton.layer.borderColor = UIColor.gray.cgColor
//        bottomButton.customButton.layer.borderWidth = 1.0
//        bottomButton.customButton.backgroundColor = UIColor.black.adjustBrightness(by: 0.1)
//        bottomButton.customButton.layer.cornerRadius = 16
//    }
//    
//    @objc private func muteButtonTapped() {
//        player?.isMuted.toggle()
//        
//        let imageName = player?.isMuted == true ? "speaker.slash.fill" : "speaker.3.fill"
//        muteButton.setImage(UIImage(systemName: imageName), for: .normal)
//    }
//    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        player?.pause()
//        playerLayer?.removeFromSuperlayer()
//        player = nil
//        playerLayer = nil
//        gradientView?.removeFromSuperview()
//        gradientView = nil
//        resetMuteButton()
//    }
//    
//    func resetMuteButton() {
//        muteButton.setImage(UIImage(systemName: "speaker.slash.fill"), for: .normal)
//        player?.isMuted = true
//    }
//
//    
//    func update(props: NewFromNikeRowProps.VideoProps,
//                addGradient: Bool,
//                isMuted: Bool) {
//
//        guard let url = Bundle.main.url(
//            forResource: props.videoURL,
//            withExtension: "mp4"
//        ) else {
//            return
//        }
//
//        configurePlayer(
//            url: url,
//            addGradient: addGradient,
//            isMuted: isMuted
//        )
//    }
//    
//    private func configurePlayer(url: URL,
//                                 addGradient: Bool,
//                                 isMuted: Bool) {
//
//        if player == nil {
//            playerItem = AVPlayerItem(url: url)
//            player = AVPlayer(playerItem: playerItem)
//            playerLayer = AVPlayerLayer(player: player)
//            playerLayer?.videoGravity = .resizeAspectFill
//            contentView.layer.insertSublayer(playerLayer!, at: 0)
//        }
//
//        player?.isMuted = isMuted
//
//        if addGradient, gradientView == nil {
//            let gradient = GradientView()
//            gradient.translatesAutoresizingMaskIntoConstraints = false
//            contentView.addSubview(gradient)
//            NSLayoutConstraint.activate([
//                gradient.topAnchor.constraint(equalTo: contentView.topAnchor),
//                gradient.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//                gradient.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//                gradient.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
//            ])
//            self.gradientView = gradient
//        }
//
//        contentView.bringSubviewToFront(muteButton)
//        contentView.bringSubviewToFront(bottomButton)
//    }
//    
//    func playVideo() {
//        player?.play()
//    }
//    
//    func stopVideo() {
//        player?.pause()
//        player?.seek(to: .zero)
//    }
//}
//
//
////MARK: - Event Handler
//
//extension VideoCell {
//    func setupButtonActions() {
//        bottomButton.onButtonTapped = { [weak self] in
//            self?.onBottomButtonTapped?()
//        }
//    }
//}
//
//
////MARK: - Layout
//
//extension VideoCell {
//    
//    func setupViews() {
//        contentView.addSubview(muteButton)
//        contentView.addSubview(bottomButton)
//    }
//    
//    private func setupConstraints() {
//        muteButton.translatesAutoresizingMaskIntoConstraints = false
//        bottomButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            muteButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
//            muteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
//            muteButton.widthAnchor.constraint(equalToConstant: 40),
//            muteButton.heightAnchor.constraint(equalToConstant: 40),
//            
//            bottomButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            bottomButton.widthAnchor.constraint(equalToConstant: 90),
//            bottomButton.heightAnchor.constraint(equalToConstant: 35),
//            bottomButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
//        ])
//    }
//}
//
//extension VideoCell: LifecycleAwareCell {
//    func willDisplay() {
//        playVideo()
//    }
//
//    func didEndDisplaying() {
//        stopVideo()
//    }
//}







//  print("Video stopped")
//it stopped only when i scroll on top


