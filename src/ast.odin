package monkey

// We're keeping the hiearchy flat this time. Just Nodes, with a type.
Node :: union {
	Let_Statement,
	Identifier,
}

Program :: struct {
	statements: [dynamic]^Node,
}

node_token_literal :: proc(n: ^Node) -> string {
	switch v in n {
	case Let_Statement:
		return let_token_literal(v)
	case Identifier:
		return ident_token_literal(v)
	case:
		return "node type NOT FOUND"
	}
}

token_literal :: proc {
	node_token_literal,
	let_token_literal,
	ident_token_literal,
}

program_token_literal :: proc(p: ^Program) -> string {
	if len(p.statements) > 0 {
		return token_literal(p.statements[0])
	}
	return ""
}

Let_Statement :: struct {
	token: Token,
	name:  Identifier,
	value: ^Node,
}
new_let_statement :: proc(t: Token) -> ^Node {
	n := new(Node)
	n^ = Let_Statement {
		token = t,
	}
	return n
}
let_token_literal :: proc(l: Let_Statement) -> string {
	return l.token.literal
}

Identifier :: struct {
	token: Token,
	value: string,
}
new_identifier :: proc(t: Token, v: string) -> Identifier {
	return Identifier{t, v}
}
ident_token_literal :: proc(i: Identifier) -> string {
	return i.token.literal
}
