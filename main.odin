package main

import "core:fmt"
import "core:os"
import "src"

main :: proc() {
	// TODO: posix
	user := os.get_env("USERNAME")
	fmt.printfln("Hello %s! Welcome to the Monkey programming language!", user)
	fmt.println("Feel free to type in commands")
	src.start_repl(os.stdin, os.stdout)
}
