import:py pygame;
import:py chess;

import from .engine { Engine }
import from .board { Board }

include game_impl;

# This class contains the state of the game.
obj Game {

    has running: bool; # False if we're done with the application.
    has engine: Engine;
    has board: Board;
    has screen: pygame.Surface;

    # Game state.
    has white_to_move: bool;
    has dragged_square: tuple;
    has legal_target_squares: List[tuple];

    can init(stockfish_path:str);
    can handle_events();
    can end_frame();
    can cleanup();

    # Private things.
    can :priv get_board_size() -> tuple;
}
