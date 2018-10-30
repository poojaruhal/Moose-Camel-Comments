I represent a class with comment. I contain methods that also have comments that reference other classes, variables or methods.

Users can reference other classes directly, for example:
 - MccClassWithoutComment is a direct and precise reference to a class that does not have a comment
 - ClassWithoutComment is a direct but partial reference to a class that omits package prefix
 - "class without comment" is a class referene given in natural language. Our aim is to detect such references and show them to user