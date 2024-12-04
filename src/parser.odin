package monkey

import "core:fmt"

Parser :: struct {
	l:          ^Lexer,
	cur_token:  Token,
	peek_token: Token,
}

new_parser :: proc(l: ^Lexer) -> ^Parser {
	p := new(Parser)
	p.l = l

	// Read two tokens, so curToken and peekToken are both set
	next_token(p)
	next_token(p)

	return p
}

next_token :: proc {
	parser_next_token,
	lexer_next_token,
}

parser_next_token :: proc(p: ^Parser) {
	p.cur_token = peek_token(p)
	p.peek_token = next_token(p.l)
}

parse_program :: proc(p: ^Parser) -> ^Program {
	program := new(Program)
	program.statements = make([dynamic]^Node) // TODO: needed?

	for p.cur_token.type != .EOF {
		stmt := parse_statement(p)
		if stmt != nil {
			append(&program.statements, stmt)
		}
		next_token(p)
	}

	return program
}

parse_statement :: proc(p: ^Parser) -> ^Node {
	#partial switch p.cur_token.type {
	case .LET:
		return parse_let_statement(p)
	case:
		return nil
	}
}

parse_let_statement :: proc(p: ^Parser) -> ^Node {
	stmt := new_let_statement(p.cur_token)

	if !expect_peek(p, .IDENT) do return nil

	(&stmt.(Let_Statement)).name = new_identifier(p.cur_token, p.cur_token.literal)

	if !expect_peek(p, .ASSIGN) do return nil

	// TODO: We're skipping the expressions until we encounter a semicolon
	for !cur_token_is(p, .SEMICOLON) {
		next_token(p)
	}

	return stmt
}

// Helpers
cur_token_is :: proc(p: ^Parser, t: TokenType) -> bool {
	return p.cur_token.type == t
}

peek_token_is :: proc(p: ^Parser, t: TokenType) -> bool {
	return p.peek_token.type == t
}

expect_peek :: proc(p: ^Parser, t: TokenType) -> bool {
	if peek_token_is(p, t) {
		next_token(p)
		return true
	}
	return false
}

peek_token :: proc(p: ^Parser) -> Token {
	return p.peek_token
}
