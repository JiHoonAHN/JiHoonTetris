import SwiftUI

public struct TetrisGameView: View {
    @ObservedObject var tetrisGame = TetrisGameViewModel()
    public init() {}
    public var body: some View {
        GeometryReader { (geometry: GeometryProxy) in
            self.drawBoard(boundingRect: geometry.size)
        }
        .frame(maxWidth : .infinity, maxHeight: .infinity)
        .gesture(tetrisGame.getMoveGesture())
        .gesture(tetrisGame.getRotateGesture())
    }
    
    private func drawBoard(boundingRect: CGSize) -> some View {
        let columns = self.tetrisGame.numColumns
        let rows = self.tetrisGame.numRows
        let blocksize = min(boundingRect.width/CGFloat(columns), boundingRect.height/CGFloat(rows))
        let xoffset = (boundingRect.width - blocksize*CGFloat(columns))/2
        let yoffset = (boundingRect.height - blocksize*CGFloat(rows))/2
        let gameBoard = self.tetrisGame.gameBoard
        
        return ForEach(0...columns-1, id:\.self) { (column:Int) in
            ForEach(0...rows-1, id:\.self) { (row:Int) in
                Path { path in
                    let x = xoffset + blocksize * CGFloat(column)
                    let y = boundingRect.height - yoffset - blocksize*CGFloat(row+1)
                    
                    let rect = CGRect(x: x, y: y, width: blocksize, height: blocksize)
                    path.addRect(rect)
                }
                .fill(gameBoard[column][row].color)
            }
        }
    }
}
