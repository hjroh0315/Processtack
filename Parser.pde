class Parser {
	private String program;
	private ArrayList parsed;

	Parser (String _program) {
		program = _program;
		parsed = new ArrayList();
	}

	ArrayList parse() {
		parsed.add(program);
		return parsed;
	}
}
