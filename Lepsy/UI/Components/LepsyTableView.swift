import Cocoa

protocol LepsyTableViewDelegate: NSObject {
    func tableView(_ tableView: NSTableView, didSelectRowAt row: Int, column: Int)
}

class LepsyTableView: NSTableView {
    weak var lepsyDelegate: LepsyTableViewDelegate?
    
    override func mouseDown(with event: NSEvent) {
        let localLocation = convert(event.locationInWindow, to: nil)
        let clickedRow = row(at: localLocation)
        let clickedColumn = column(at: localLocation)
        super.mouseDown(with: event)
        
        guard clickedRow >= 0, clickedColumn >= 0 else {
            return
        }
        lepsyDelegate?.tableView(self, didSelectRowAt: clickedRow, column: clickedColumn)
    }
}
