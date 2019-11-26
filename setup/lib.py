def ask(prompt, options='yNq', yes_answers='y'):
    answer = input("{} [{}]: ".format(prompt, options)).strip().lower()
    if answer == 'q':
        exit()
    return answer and answer in yes_answers
