import:py from stockfish { Stockfish }

obj Engine {

    has stockfish: Stockfish;

    can init(stockfish_path:str) {
        self.stockfish = Stockfish(path=stockfish_path);
    }

    can get_best_move() -> str {
        return self.stockfish.get_best_move();
    }

}
