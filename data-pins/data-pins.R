board <- pins::board_folder(path = "data-pins/")

pins::pin_write(board = board, x = brpop::mun_pop, name = "mun_pop")

