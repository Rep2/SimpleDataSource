import UIKit
import SnapKit
import SimpleDataSource

class ActorTableViewCell: UITableViewCell {
    lazy var nameLabel = UILabel(frame: .zero)

    func setupCell() {
        addSubview(nameLabel)

        nameLabel.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
        }
    }
}

extension ActorTableViewCell: PresentingTableViewCell {
    func present(viewModel: ActorViewModel) {
        if nameLabel.superview == nil {
            setupCell()
        }

        nameLabel.text = viewModel.name
    }
}
