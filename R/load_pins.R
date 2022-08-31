# load data from pins

board <- pins::board_url(urls = c(mun_pop = "https://raw.githubusercontent.com/rfsaldanha/brpop/popsvs/data-pins/mun_pop/20220831T181252Z-19e43/"))

mun_pop <- pins::pin_read(board = board, name = "mun_pop")
