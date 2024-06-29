import SwiftUI

fileprivate enum LayoutConstants {
    static let mainHSpacing: CGFloat = 12
    static let deadlineLabelSpacing: CGFloat = 2
    static let lineLimit: Int = 3
    static let innerHSpacing: CGFloat = 2
    static let vSpacing: CGFloat = 2
    static let circleSide: CGFloat = 8
}

struct ItemCell: View {
    
    // MARK: - Public Properties
    
    var todoItem: TodoItem
    var onButtonTap: () -> Void
    
    // MARK: - Body
    
    var body: some View {
        HStack(spacing: LayoutConstants.mainHSpacing) {
            isDoneButton
            HStack(spacing: LayoutConstants.innerHSpacing) {
                if todoItem.importance != .normal && !todoItem.isDone {
                    todoItem.importance.image
                }
                VStack(alignment: .leading, spacing: LayoutConstants.vSpacing) {
                    itemText
                    if let _ = todoItem.deadline, !todoItem.isDone {
                        deadlineLabel
                    }
                }
            }
            Spacer()
            colorCircle
            chevroneImage
        }
    }
    
    // MARK: - Private Views
    
    private var isDoneButton: some View {
        Button {
            DispatchQueue.main.async {
                onButtonTap()
            }
        } label: {
            if todoItem.isDone {
                R.Images.success.image
                    .foregroundColor(R.Theme.MainColor.green.color)
            } else if todoItem.importance == .high {
                R.Images.priorityHigh.image
                    .foregroundColor(R.Theme.MainColor.red.color)
            } else {
                R.Images.priorityRegular.image
                    .foregroundColor(R.Theme.Label.labelSecondary.color)
            }
        }
        .buttonStyle(.plain)
    }
    
    private var itemText: some View {
        Text(todoItem.text)
            .foregroundColor(
                todoItem.isDone ?
                R.Theme.Label.tertiary.color :
                    R.Theme.Label.labelPrimary.color
            )
            .font(R.AppFont.body.font)
            .lineLimit(LayoutConstants.lineLimit)
            .strikethrough(
                todoItem.isDone,
                color: R.Theme.Label.tertiary.color
            )
    }
    
    private var deadlineLabel: some View {
        HStack(spacing: LayoutConstants.deadlineLabelSpacing) {
            R.SFSymbols.calendar.image
            if let deadline = todoItem.deadline {
                Text((deadline.toString(withFormat: "dd MMMM")))
            }
        }
        .font(R.AppFont.subhead.font)
        .foregroundColor(R.Theme.Label.tertiary.color)
    }
    
    private var colorCircle: some View {
        Circle()
            .fill(Color(hex: todoItem.hexColor) ?? R.Theme.Back.backSecondary.color)
            .frame(
                width: LayoutConstants.circleSide,
                height: LayoutConstants.circleSide
            )
    }
    
    private var chevroneImage: some View {
        R.Images.chevron.image
            .foregroundColor(R.Theme.MainColor.gray.color)
    }
}

struct ItemCell_Previews: PreviewProvider {
    static var previews: some View {
        ItemCell(todoItem: TodoItem(
            text: "Hello, world",
            isDone: false,
            createdAt: Date(),
            importance: .high
        ),
                 onButtonTap: {
        })
        
    }
}
