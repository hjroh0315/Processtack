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
			//print(typeOf(_token));
			if (typeOf(_token).equals("Operator")) {
				switch (((Operator)_token).getValue()) {
					case "+":
						a = pop();
						b = pop();

						if (typeOf(a).equals("Float") && typeOf(b).equals("Float")) {
							push(parseFloat(a.toString()) + parseFloat(b.toString()));
						} else {
							push(a.toString() + b.toString());
						}
						break;
					case "-":
						a = pop();
						b = pop();

						if (typeOf(a).equals("Float") && typeOf(b).equals("Float")) {
							push(parseFloat(a.toString()) - parseFloat(b.toString()));
						} else {
							//add(a.toString() + b.toString());
						}
						break;
					case "*":
						a = pop();
						b = pop();

						if (typeOf(a).equals("Float") && typeOf(b).equals("Float")) {
							push(parseFloat(a.toString()) * parseFloat(b.toString()));
						} else {
							//add(a.toString() + b.toString());
						}
						break;
					case "/":
						a = pop();
						b = pop();

						if (typeOf(a).equals("Float") && typeOf(b).equals("Float")) {
							push(parseFloat(a.toString()) / parseFloat(b.toString()));
						} else {
							//add(a.toString() + b.toString());
						}
						break;
					case "d":
						//duplicate
						a = pop();
						push(a);
						push(a);
						break;
					case "s":
						//swap
						a = pop();
						b = pop();
						push(a);
						push(b);
						break;
					case "g":
						//get
						a = pop();
						Object element = get((int) parseFloat(a.toString()));
						remove((int) parseFloat(a.toString()));
						push(element);
						break;
					case "r":
						//remove top element
						a = pop();
						break;
				}
			} else {
				push(_token);
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
			push(inputToken);
		}
	}

	String typeOf(Object object) {
		return object.getClass().getName().replaceAll("java.lang.|Processtack\\$","");
	}

	Object pop() {
		Object lastElement = stack.get(stack.size()-1);
		stack.remove(stack.get(stack.size()-1));
		return lastElement;
	}

	void push(Object object) {
		stack.add(object);
	}

	Object get(int i) {
		return stack.get(i);
	}

	void remove(int i) {
		stack.remove(i);
	}
}
