import:py from stockfish { Stockfish }
import:py chess;

import from .board { Board }


obj Engine {

    has stockfish: Stockfish;
    has board: Board;

    can init(stockfish_path:str, board:Board) {
        self.stockfish = Stockfish(path=stockfish_path);
        self.board = board;
    }

    can move_uci(move:str) {
        self.board.position.push_uci(move);
    }

    can move_move(move:chess.Move) {
        self.move_uci(move.uci());
    }

    can get_best_move() -> str {
        self.stockfish.set_fen_position(self.board.position.fen());
        time_ms = 2000;
        return self.stockfish.get_best_move(time_ms);
    }

    can does_piece_at_pos_has_legal_move(pos:tuple) -> bool {
        moves = self.board.position.legal_moves;
        if any([move.from_square == chess.square(*pos) for move in moves]) {
            return True;
        }
        return False;
    }

    can get_legal_target_squares(pos:tuple) -> List[tuple] {
        # Return the square as a tuple.
        return [
            self.convert_square_name_to_tuple(chess.square_name(move.to_square))
            for move in self.board.position.legal_moves if move.from_square == chess.square(*pos)
        ];
    }


    can convert_square_name_to_tuple(square:str) -> tuple {
        return (ord(square[0]) - ord('a'), 8 - int(square[1]));
    }

    can is_move_legal(pos_start:tuple, pos_end:tuple) -> bool {
        move = chess.Move(chess.square(*pos_start), chess.square(*pos_end));
        return move in self.board.position.legal_moves;
    }

}
