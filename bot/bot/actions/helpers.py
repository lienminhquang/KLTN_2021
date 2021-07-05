from termcolor import colored


def logInfo(message):
    print(colored("INFO: ", 'blue'), colored(message, 'white'))

def logError(message):
    print(colored("ERROR: ", 'red'), colored(message, 'red'))

def logWarning(message):
    print(colored("WARNING: ", 'yellow'), colored(message, 'yellow'))
