package monkey

// We're keeping the hiearchy flat this time. Just Nodes, with a type.
NodeType :: enum {
	LET_STATEMENT,
	IDENTIFIER,
}

Node :: struct {
	type:  NodeType,
	token: Token,
}

Program :: struct {
	statements: [dynamic]^Node,
}

token_literal :: proc(n: ^Node) -> string {
	switch n.type {
	case .LET_STATEMENT:
		return let_token_literal(cast(^LetStatement)n)
	case .IDENTIFIER:
		return ident_token_literal(cast(^Identifier)n)
	case:
		return "node type NOT FOUND"
	}
}

program_token_literal :: proc(p: ^Program) -> string {
	if len(p.statements) > 0 {
		return token_literal(p.statements[0])
	}
	return ""
}

LetStatement :: struct {
	using node: Node,
	name:       ^Identifier,
	value:      ^Node,
}
new_let_statement :: proc(t: Token) -> ^LetStatement {
	n := new(LetStatement)
	n.type = .LET_STATEMENT
	n.token = t
	return n
}
let_token_literal :: proc(l: ^LetStatement) -> string {
	return l.token.literal
}

Identifier :: struct {
	using node: Node,
	value:      string,
}
new_identifier :: proc(t: Token, v: string) -> ^Identifier {
	n := new(Identifier)
	n.type = .IDENTIFIER
	n.token = t
	n.value = v
	return n
}
ident_token_literal :: proc(i: ^Identifier) -> string {
	return i.token.literal
}
