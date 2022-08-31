board <- pins::board_folder(path = "data-pins/", versioned = FALSE)

pins::pin_write(board = board, x = brpop::mun_pop, name = "mun_pop")



#board2 <- pins::board_url(urls = c(mun_pop = "data-pins/mun_pop/20220831T174619Z-19e43/data.txt"))

#pins::pin_list(board2)

#teste <- pins::pin_read(board2, "mun_pop")
