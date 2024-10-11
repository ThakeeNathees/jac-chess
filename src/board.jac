import:py pygame, chess;

include board_impl;

# The chess board ui element.
obj Board {

    has flipped: bool; # Whether the board is flipped or not.
    has white: tuple;
    has black: tuple;
    has square_size: int; # Size of a square in pixels.
    has piece_scale: float; # Scale of the pieces inside the square.
    has position: chess.Board; # The current position of the board.
    has img: pygame.Surface;

    can init();
    can draw(screen:pygame.Surface, pos:tuple, dragged_square:tuple, legal_target_suqares:List[tuple]);
    can get_piece_rect(piece:str) -> tuple;

    # Get the square at a given position. Bottom left is (0, 0).
    can get_square_at(pos:tuple) -> tuple;
}
