import UIKit
import SnapKit
import SimpleDataSource

class MovieTableViewCell: UITableViewCell {
    lazy var nameLabel = UILabel(frame: .zero)

    lazy var releaseYearLabel: UILabel = {
        let label = UILabel(frame: .zero)

        label.font = .systemFont(ofSize: 14)

        return label
    }()

    func setupCell() {
        addSubview(nameLabel)
        addSubview(releaseYearLabel)

        nameLabel.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
        }

        releaseYearLabel.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
            make.top.equalTo(nameLabel.snp.bottom)
        }
    }
}

extension MovieTableViewCell: PresentingTableViewCell {
    func present(viewModel: MovieViewModel) {
        if nameLabel.superview == nil {
            setupCell()
        }

        nameLabel.text = viewModel.name
        releaseYearLabel.text = String(viewModel.releaseYear)
    }
}
