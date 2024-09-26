package main

import (
	_ "net/http/pprof"
	"project/food-delivery/config"
	"project/food-delivery/server"

	_ "github.com/lib/pq"
)

func main() {
	cfg := config.NewConfig()
	server.Start(cfg)

}
