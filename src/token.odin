package main

TokenType :: enum {
    ILLEGAL,
    EOF,

    // Identifiers and literals
    IDENT,
    INT,

    // Operators
    ASSIGN,
    PLUS,
    MINUS,
    BANG,
    ASTERISK,
    SLASH,
    LT,
    GT,
    EQ,
    NOT_EQ,

    // Delimiters
    COMMA,
    SEMICOLON,

    LPAREN,
    RPAREN,
    LBRACE,
    RBRACE,

    // Keywords
    FUNCTION,
    LET,
	TRUE,
	FALSE,
	IF,
	ELSE,
	RETURN,

    // how many types?  might not be needed in Odin
    TYPE_COUNT,
}

Token :: struct {
    type    : TokenType,
    literal : string,
}

lookup_identifier :: proc(ident: string) -> TokenType {
    switch ident {
        case "fn":
            return .FUNCTION
        case "let":
            return .LET
        case "true":
            return .TRUE
        case "false":
            return .FALSE
        case "if":
            return .IF
        case "else":
            return .ELSE
        case "return":
            return .RETURN
        case:
            return .IDENT
    }
}
