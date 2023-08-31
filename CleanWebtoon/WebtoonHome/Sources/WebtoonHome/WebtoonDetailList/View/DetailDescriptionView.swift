import UIKit

class DetailDescriptionView: UIView {
    private let entireStackView: UIStackView
    private let detailDescription: UILabel
    private let ageDescription: UILabel
    private let hashTagStack: UIStackView
    private let stateButton: UIButton
    
    override init(frame: CGRect) {
        entireStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.spacing = 5
            stackView.alignment = .top
            stackView.distribution = .equalSpacing
            return stackView
        }()
        detailDescription = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 14)
            label.text = ""
            label.numberOfLines = 0
            label.textColor = .systemGray4
            return label
        }()
        ageDescription = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .systemFont(ofSize: 14)
            label.text = ""
            label.textColor = .systemGray4
            return label
        }()
        hashTagStack = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.distribution = .equalSpacing
            stackView.spacing = 5
            return stackView
        }()
        stateButton = {
            let button = UIButton()
            button.setImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
            button.setImage(UIImage(systemName: "chevron.compact.up"), for: .selected)
            return button
        }()
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(entireStackView)
        entireStackView.addArrangedSubview(detailDescription)
        entireStackView.addArrangedSubview(ageDescription)
        
        NSLayoutConstraint.activate([
            entireStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            entireStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            entireStackView.topAnchor.constraint(equalTo: self.topAnchor),
        ])
    }
    
    func configureView(viewModel: WebtoonDetailList.DetailTitlePart.ViewModel) {
        detailDescription.text = viewModel.detailDescription
        ageDescription.text = viewModel.age
    }
    
    func changeCurrentViewState() {
        self.stateButton.isSelected = !self.stateButton.isSelected
    }
}
