package main

import "core:fmt"
import "core:os"

import "vendor/back"
import "src"

main :: proc() {
	back.register_segfault_handler()

	// TODO: posix
	user := os.get_env("USERNAME")
	fmt.printfln("Hello %s! Welcome to the Monkey programming language!", user)
	fmt.println("Feel free to type in commands")
	src.start_repl(os.stdin, os.stdout)
}
