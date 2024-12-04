package monkey

import "core:testing"
import "../vendor/back"

@(test)
test_let_statements :: proc(t: ^testing.T) {
	back.register_segfault_handler()

	input := `
let x = 5;
let y = 10;
let foobar = 838383;
`

	l := new_lexer(input)
	p := new_parser(l)

	program := parse_program(p)
	if program == nil {
		testing.expect(t, program != nil)
	}

	tests := []struct{
		expected_ident: string
	}{
		{"x"},
		{"y"},
		{"foobar"}
	}

	for tt, i in tests {
		stmt := program.statements[i]
		test_let_statement(t, stmt, tt.expected_ident)
	}
}

test_let_statement :: proc(t: ^testing.T, stmt: ^Node, expected_ident: string) {
	testing.expect_value(t, token_literal(stmt), "let")
	let_stmt, ok := stmt.(Let_Statement)
	testing.expect(t, ok)
	testing.expect_value(t, let_stmt.name.value, expected_ident)
	testing.expect_value(t, token_literal(let_stmt.name), expected_ident)
}
