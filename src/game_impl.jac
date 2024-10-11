

:obj:Game:can:init(stockfish_path:str) {
    self.running = True;
    self.board = Board();
    self.engine = Engine(stockfish_path, self.board);
    self.white_to_move = True;
    self.dragged_square = (-1, -1);
    self.legal_target_squares = [];

    pygame.<>init();
    self.screen = pygame.display.set_mode(self.get_board_size());
}


:obj:Game:can:handle_events() {
    for event in pygame.event.get() {
        if event.type == pygame.QUIT {
            self.running = False;
        }

        if self.white_to_move {
            if event.type == pygame.MOUSEBUTTONDOWN {
                board_pos = self.board.get_square_at(event.pos);

                # Check if the piece at the board_pos is white and has legal moves.
                piece = self.board.position.piece_at(chess.square(*board_pos));
                if piece is not None and piece.color == chess.WHITE {
                    if self.engine.does_piece_at_pos_has_legal_move(board_pos) {
                        self.dragged_square = board_pos;
                        self.legal_target_squares = self.engine.get_legal_target_squares(board_pos);
                    }
                }

            } elif event.type == pygame.MOUSEBUTTONUP {
                board_pos = self.board.get_square_at(event.pos);
                if self.engine.is_move_legal(self.dragged_square, board_pos) {
                    move = chess.Move(chess.square(*self.dragged_square), chess.square(*board_pos));
                    self.engine.move_move(move);
                    self.white_to_move = False;
                }
                self.dragged_square = (-1, -1);
                self.legal_target_squares = [];
            }

        } else { # Black to move.
            move = self.engine.get_best_move();
            self.engine.move_uci(move);
            self.white_to_move = True;
        }

    }
}


:obj:Game:can:end_frame() {
    self.board.draw(self.screen, (0, 0), self.dragged_square, self.legal_target_squares);
    pygame.display.flip();
}


:obj:Game:can:cleanup() {
    pygame.quit();
}


:obj:Game:can:get_board_size() -> tuple {
    return (self.board.square_size * 8, self.board.square_size * 8);
}
