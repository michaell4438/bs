#! /usr/bin/python3
import argparse
import os

language_choices = ["python"]

class BSConfigData():
    name: str
    lang: str
    lang_specific: dict = {}

    def __init__(self, name, lang):
        self.name = name
        self.lang = lang

    @staticmethod
    def create_from_string(target: str):
        props = eval(target)
        return BSConfigData(props["name"], props["lang"])
    
    def getTemplate(self):
        template = os.path.realpath(__file__ + "/../templates/" + self.lang + "/Makefile")
        
        with open(template) as t:
            toPlace = os.path.realpath(os.getcwd())
            toPlace = toPlace + os.path.sep + "bs_template"
            with open(toPlace, "w") as thisFile:
                thisFile.write(t.read())
    
    def readMakefileAttributes(self):
        f_path = os.getcwd() + os.path.sep + "bs_template"
        with open(f_path) as readable:
            text = readable.readlines()
            attributes = eval(text[1][1:])
            return attributes
    
    def askTemplateQuestions(self):
        attr = self.readMakefileAttributes()
        vars = attr['vars']
        for i in range(0, len(vars)):
            vars[i] = vars[i].lower()

        print("Template-specific questions")
        for v in vars:
            self.lang_specific[v.upper()] = input(f"--- {v}: ")

        f_path = os.getcwd() + os.path.sep + "bs_template"
        dest_path = os.getcwd() + os.path.sep + "Makefile"
        with open(f_path, "rt") as makefile_read:
            with open(dest_path, "wt") as makefile:
                for i in makefile_read:
                    for k in self.lang_specific.keys():
                        i = i.replace("$$"+k, self.lang_specific[k])
                    makefile.write(i)
            

    def __str__(self):
        return self.__dict__.__str__()

def generate():
    print("Creating bs project in this directory")
    print("General Information")
    name = input("--- Project name: ")
    lang = ""
    while lang not in language_choices:
        print("Language choices: " + str(language_choices))
        lang = input("--- Language Template: ")
    config = BSConfigData(name, lang)
    config.getTemplate()
    config.askTemplateQuestions()

commands = {"create": generate}

if __name__ == "__main__":
    str_commands = commands.keys().__str__().split("(")[1].split(")")[0]
    parser = argparse.ArgumentParser(prog="bs", description="A wrapper for make", usage="bs (command) [flags]", add_help=True)
    parser.add_argument("command", type=str, nargs=1, help="The command to execute. Possible commands are " + str_commands, choices=commands.keys(), metavar="command")
    args = parser.parse_args()

    chosen_command = args.command[0]
    commands[chosen_command]()
