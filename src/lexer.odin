package monkey

Lexer :: struct {
	input:        string,
	position:     int,
	readPosition: int,
	ch:           u8,
}

new_lexer :: proc(input: string) -> ^Lexer {
	l := new(Lexer)
	l.input = input
	read_char(l)
	return l
}

read_char :: proc(l: ^Lexer) {
	if l.readPosition >= len(l.input) {
		l.ch = 0
	} else {
		l.ch = l.input[l.readPosition]
	}
	l.position = l.readPosition
	l.readPosition += 1
}

peek_char :: proc(l: ^Lexer) -> u8 {
	if l.readPosition >= len(l.input) do return 0
	return l.input[l.readPosition]
}

is_letter :: proc(char: u8) -> bool {
    return 'a' <= char && char <= 'z' || 'A' <= char && char <= 'Z' || char == '_';
}

is_digit :: proc(char: u8) -> bool {
    return '0' <= char && char <= '9';
}


read_ident_or_num :: proc(l: ^Lexer, decider: proc(u8) -> bool) -> string {
    position := l.position;
    for decider(l.ch) {
        read_char(l);
    }
    return l.input[position:l.position]
}

skip_whitespace :: proc(l: ^Lexer) {
	for l.ch == ' ' || l.ch == '\t' || l.ch == '\n' || l.ch == '\r' {
		read_char(l)
	}
}

next_token :: proc(l: ^Lexer) -> Token {
	skip_whitespace(l)
	tok: Token

	switch l.ch {
	case '=':
		if peek_char(l) == '=' {
			read_char(l)
			tok.literal = "=="
			tok.type = .EQ
		} else {
			tok = Token{.ASSIGN, "="}
		}
	case '!':
		if peek_char(l) == '=' {
			read_char(l)
			tok.literal = "!="
			tok.type = .NOT_EQ
		} else {
			tok = Token{.BANG, "!"}
		}
	case '+':
		tok = Token{.PLUS, "+"}
	case '-':
		tok = Token{.MINUS, "-"}
	case '/':
		tok = Token{.SLASH, "/"}
	case '*':
		tok = Token{.ASTERISK, "*"}
	case '<':
		tok = Token{.LT, "<"}
	case '>':
		tok = Token{.GT, ">"}
	case ';':
		tok = Token{.SEMICOLON, ";"}
	case '(':
		tok = Token{.LPAREN, "("}
	case ')':
		tok = Token{.RPAREN, ")"}
	case ',':
		tok = Token{.COMMA, ","}
	case '{':
		tok = Token{.LBRACE, "{"}
	case '}':
		tok = Token{.RBRACE, "}"}
	case 0:
		tok = Token{.EOF, ""}
	case:
		if is_letter(l.ch) {
			tok.literal = read_ident_or_num(l, is_letter)
			tok.type = lookup_identifier(tok.literal)
			return tok
		} else if is_digit(l.ch) {
			tok.literal = read_ident_or_num(l, is_digit)
			tok.type = .INT
			return tok
		}
	}

	read_char(l)
	return tok
}
