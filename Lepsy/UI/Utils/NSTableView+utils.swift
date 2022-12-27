import Cocoa

extension NSTableView {
    func dequeue<CellType: NSTableCellView>(cell: () -> CellType, identifier: String) -> CellType {
        guard let dequeuedCell = makeView(withIdentifier: .init(identifier), owner: self) as? CellType else {
            let concreteCell = cell()
            concreteCell.identifier = .init(identifier)
            return concreteCell
        }
        return dequeuedCell
    }
}
