import:py pygame, chess;

# The chess board ui element.
obj Board {

    has flipped: bool; # Whether the board is flipped or not.
    has white: tuple;
    has black: tuple;
    has square_size: int; # Size of a square in pixels.
    has piece_scale: float; # Scale of the pieces inside the square.
    has position: chess.Board; # The current position of the board.
    has img: pygame.Surface;

    can init() {
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


    can draw(screen:pygame.Surface, pos:tuple) {
        # Draw the board.
        for i in range(8) {
            for j in range(8) {
                color = self.white if (i + j) % 2 == 0 else self.black;
                pygame.draw.rect(screen, color, (pos[0] + i * self.square_size, pos[1] + j * self.square_size, self.square_size, self.square_size));
            }
        }

        # Draw the pieces.
        for y in range(8) {
            for x in range(8) {
                piece = self.position.piece_at(chess.square(x, 7-y));
                if piece is not None {
                    rect = self.get_piece_rect(piece);
                    piece_pos = (pos[0] + (x * self.square_size), pos[1] + (y * self.square_size));
                    screen.blit(self.img, piece_pos, rect);
                }
            }
        }
    }

    can get_piece_rect(piece:str) -> tuple {
        piece_size = (self.square_size * self.piece_scale);
        x = 'kqbnrp'.find(piece.symbol().lower()) * piece_size;
        y = int(piece.symbol().upper() != piece.symbol()) * piece_size;
        return (x, y, piece_size, piece_size);
    }
}
