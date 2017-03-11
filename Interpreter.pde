class Interpreter {
	private String program;
	private String[] input;
	private ArrayList parsed;

	Interpreter (String _program, String[]_input) {
		program = _program;
		input = _input;
	}

	void run() {
		parse();
		for (Object token: parsed) {
			print(token.toString());
		}
		background(0);
	}

	void parse() {
		Parser parser = new Parser(program);
		parsed = parser.parse();
	}
}
