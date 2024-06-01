

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer?
    
    var eggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    
    var totalTime = 0
    var timer = Timer()
    var secondsPassed = 0
    
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - Title
    
    lazy var titleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "How do you like your eggs?"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 25)
        label.textColor = .darkGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Egg Stack View
    
    lazy var eggStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var softEggView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var softEggButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        button.tintColor = .white
        button.setTitle("Soft", for: .normal)
        button.addTarget(self, action: #selector(hardnessSelected), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var softEggImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "soft_egg")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var mediumEggView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var mediumEggButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Medium", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        button.tintColor = .white
        button.addTarget(self, action: #selector(hardnessSelected), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var mediumEggImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "medium_egg")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var hardEggView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var hardEggButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .bold)
        button.setTitle("Hard", for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(hardnessSelected), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var hardEggImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hard_egg")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - Timer
    
    lazy var timerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = .systemYellow
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
    }
    
    @objc func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        
        progressView.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)

    }
    
    @objc func updateCounter() {
        
        if secondsPassed < totalTime  {
            secondsPassed += 1
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            progressView.progress = percentageProgress
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            playSound()
        }
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }
        player = try! AVAudioPlayer(contentsOf: url)
        player?.play()
    }
    
    
}

extension ViewController {
    func setupViews() {
        view.backgroundColor = UIColor(red: 203/255, green: 242/255, blue: 253/255, alpha: 1)
        view.addSubview(verticalStackView)

        verticalStackView.addArrangedSubview(titleView)
        titleView.addSubview(titleLabel)
        verticalStackView.addArrangedSubview(eggStackView)
        
        eggStackView.addArrangedSubview(softEggView)
        softEggView.addSubview(softEggImageView)
        softEggView.addSubview(softEggButton)
        
        eggStackView.addArrangedSubview(mediumEggView)
        mediumEggView.addSubview(mediumEggImageView)
        mediumEggView.addSubview(mediumEggButton)
        
        eggStackView.addArrangedSubview(hardEggView)
        hardEggView.addSubview(hardEggImageView)
        hardEggView.addSubview(hardEggButton)
        
        verticalStackView.addArrangedSubview(timerView)
        timerView.addSubview(progressView)
    }
    
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            verticalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            verticalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: titleView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor),
            
            softEggImageView.topAnchor.constraint(equalTo: softEggView.topAnchor, constant: 5),
            softEggImageView.leadingAnchor.constraint(equalTo: softEggView.leadingAnchor, constant: 5),
            softEggImageView.trailingAnchor.constraint(equalTo: softEggView.trailingAnchor, constant: -5),
            softEggImageView.bottomAnchor.constraint(equalTo: softEggView.bottomAnchor, constant: -5),
            
            softEggButton.topAnchor.constraint(equalTo: softEggView.topAnchor),
            softEggButton.leadingAnchor.constraint(equalTo: softEggView.leadingAnchor),
            softEggButton.trailingAnchor.constraint(equalTo: softEggView.trailingAnchor),
            softEggButton.bottomAnchor.constraint(equalTo: softEggView.bottomAnchor),
            softEggButton.widthAnchor.constraint(equalTo: softEggView.widthAnchor),
            
            mediumEggImageView.topAnchor.constraint(equalTo: mediumEggView.topAnchor, constant: 5),
            mediumEggImageView.leadingAnchor.constraint(equalTo: mediumEggView.leadingAnchor, constant: 5),
            mediumEggImageView.trailingAnchor.constraint(equalTo: mediumEggView.trailingAnchor, constant: -5),
            mediumEggImageView.bottomAnchor.constraint(equalTo: mediumEggView.bottomAnchor, constant: -5),
            
            mediumEggButton.topAnchor.constraint(equalTo: mediumEggView.topAnchor),
            mediumEggButton.leadingAnchor.constraint(equalTo: mediumEggView.leadingAnchor),
            mediumEggButton.trailingAnchor.constraint(equalTo: mediumEggView.trailingAnchor),
            mediumEggButton.bottomAnchor.constraint(equalTo: mediumEggView.bottomAnchor),
            
            hardEggImageView.topAnchor.constraint(equalTo: hardEggView.topAnchor, constant: 5),
            hardEggImageView.leadingAnchor.constraint(equalTo: hardEggView.leadingAnchor, constant: 5),
            hardEggImageView.trailingAnchor.constraint(equalTo: hardEggView.trailingAnchor, constant: -5),
            hardEggImageView.bottomAnchor.constraint(equalTo: hardEggView.bottomAnchor, constant: -5),
            
            hardEggButton.topAnchor.constraint(equalTo: hardEggView.topAnchor),
            hardEggButton.leadingAnchor.constraint(equalTo: hardEggView.leadingAnchor),
            hardEggButton.trailingAnchor.constraint(equalTo: hardEggView.trailingAnchor),
            hardEggButton.bottomAnchor.constraint(equalTo: hardEggView.bottomAnchor),
            
            progressView.centerYAnchor.constraint(equalTo: timerView.centerYAnchor),
            progressView.trailingAnchor.constraint(equalTo: timerView.trailingAnchor),
            progressView.leadingAnchor.constraint(equalTo: timerView.leadingAnchor),
        ])
    }
}
