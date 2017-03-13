class Interpreter {
	private String program;
	private String input;
	private ArrayList parsed;
	private ArrayList stack;

	Interpreter (String _program, String _input) {
		program = _program;
		input = _input;
		stack = new ArrayList();
	}

	void run() {
		parse();
		//println(parsed);
		for (Object _token: parsed) {
			String token = _token.toString();
			Object a,b;
			//print(_token);
			switch (token) {
				case "+":
					a = pop();
					b = pop();

					if (typeOf(a).equals("Float") && typeOf(b).equals("Float")) {
						add(parseFloat(a.toString()) + parseFloat(b.toString()));
					} else {
						add(a.toString() + b.toString());
					}
					break;
				case "-":
					a = pop();
					b = pop();

					if (typeOf(a).equals("Float") && typeOf(b).equals("Float")) {
						add(parseFloat(a.toString()) - parseFloat(b.toString()));
					} else {
						//add(a.toString() + b.toString());
					}
					break;
				case "*":
					a = pop();
					b = pop();

					if (typeOf(a).equals("Float") && typeOf(b).equals("Float")) {
						add(parseFloat(a.toString()) * parseFloat(b.toString()));
					} else {
						//add(a.toString() + b.toString());
					}
					break;
				case "/":
					a = pop();
					b = pop();

					if (typeOf(a).equals("Float") && typeOf(b).equals("Float")) {
						add(parseFloat(a.toString()) / parseFloat(b.toString()));
					} else {
						//add(a.toString() + b.toString());
					}
					break;
				default:
					add(_token);
			}
		}
		background(0);
		print(stack);
	}

	void parse() {
		Parser programParser = new Parser(program);
		parsed = programParser.parse();

		Parser inputParser = new Parser(input);
		for (Object inputToken: inputParser.parse()) {
			add(inputToken);
		}
	}

	String typeOf(Object object) {
		return object.getClass().getName().replace("java.lang.","");
	}

	Object pop() {
		Object lastElement = stack.get(stack.size()-1);
		stack.remove(stack.get(stack.size()-1));
		return lastElement;
	}

	void add(Object object) {
		stack.add(object);
	}
}
