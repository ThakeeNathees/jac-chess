

:obj:Game:can:init(stockfish_path:str) {
    self.running = True;
    self.engine = Engine(stockfish_path);
    self.board = Board();

    pygame.<>init();
    self.screen = pygame.display.set_mode(self.get_board_size());
}


:obj:Game:can:handle_events() {
    for event in pygame.event.get() {
        if event.type == pygame.QUIT {
            self.running = False;
        }
    }
}


:obj:Game:can:end_frame() {
    self.board.draw(self.screen, (0, 0));
    pygame.display.flip();
}


:obj:Game:can:cleanup() {
    pygame.quit();
}


:obj:Game:can:get_board_size() -> tuple {
    return (self.board.square_size * 8, self.board.square_size * 8);
}
