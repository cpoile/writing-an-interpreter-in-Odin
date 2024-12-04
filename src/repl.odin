package monkey

import "core:fmt"
import "core:os"

PROMPT :: ">> "

start_repl :: proc(input: os.Handle, output: os.Handle) {
	buf: [1024]byte

	for {
		fmt.fprintf(output, "%s", PROMPT)
		n, err := os.read(input, buf[:])

		l := new_lexer(string(buf[:n]))

		for tok := lexer_next_token(l); tok.type != .EOF; tok = lexer_next_token(l) {
			fmt.fprintf(output, "%v\n", tok)
		}
	}
}
