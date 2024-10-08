# pip install pygame
# pip install chess
# pip install stockfish

import from src.game { Game }

with entry {
    stockfish_path = "./stockfish/stockfish-windows-x86-64-avx2.exe";
    game = Game(stockfish_path);

    while game.running {
        game.handle_events();
        game.end_frame();
    }

    game.cleanup();
}
