

:obj:Board:can:init() {
    self.flipped = False;
    self.white = (240, 217, 181);
    self.black = (181, 135, 99);
    self.square_size = 70;
    self.piece_scale = .9;
    self.position = chess.Board();

    self.img = pygame.image.load("res/pieces.png");
    self.img  = pygame.transform.scale(self.img, (
        self.square_size * self.piece_scale * 6,
        self.square_size * self.piece_scale * 2)
    );
}


:obj:Board:can:draw(screen:pygame.Surface, pos:tuple, dragged_square:tuple, legal_target_suqares:List[tuple]) {

    # Draw the board.
    for i in range(8) {
        for j in range(8) {
            color = self.white if (i + j) % 2 == 0 else self.black;
            pygame.draw.rect(screen, color, (pos[0] + i * self.square_size, pos[1] + j * self.square_size, self.square_size, self.square_size));
        }
    }

    # Draw the pieces.
    dragged_piece = None;
    for y in range(8) {
        for x in range(8) {
            piece = self.position.piece_at(chess.square(x, 7-y));

            if (x, 7-y) == dragged_square {
                dragged_piece = piece;
                continue;
            }
            if piece is not None {
                rect = self.get_piece_rect(piece);
                piece_pos = (pos[0] + (x * self.square_size), pos[1] + (y * self.square_size));
                screen.blit(self.img, piece_pos, rect);
            }
        }
    }

    # Draw the legal target squares.
    for square in legal_target_suqares {
        (x, y) = square;
        x = x * self.square_size + self.square_size // 2;
        y = y * self.square_size + self.square_size // 2;
        pygame.draw.circle(screen, (0, 100, 60, 100), (x, y), 10);
    }

    if dragged_piece is not None {
        rect = self.get_piece_rect(dragged_piece);
        piece_pos = (pygame.mouse.get_pos()[0] - self.square_size // 2, pygame.mouse.get_pos()[1] - self.square_size // 2);
        screen.blit(self.img, piece_pos, rect);
    }
}


:obj:Board:can:get_piece_rect(piece:str) -> tuple {
    piece_size = (self.square_size * self.piece_scale);
    x = 'kqbnrp'.find(piece.symbol().lower()) * piece_size;
    y = int(piece.symbol().upper() != piece.symbol()) * piece_size;
    return (x, y, piece_size, piece_size);
}


:obj:Board:can:get_square_at(pos:tuple) -> tuple {
    x = pos[0] // self.square_size;
    y = pos[1] // self.square_size;
    return (x, 7-y);
}
