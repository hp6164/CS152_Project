# CS152_Project

## Language name: Plain


- Plain is case sensitive
- White Spaces are ignored in our language
- Variable names have the following rules:
- Should not be a Token name or syntax keyword
- Should not start with a number or be a number or a “ : ” or whitespace or uppercase letter
- Should not contain a “$” or “#”
- Should not end in or contain “.” 


|    Symbol in language     | TOKEN for lexical analyzer |
|          :---:            |          :---:             |
|integer number|NUMBER XXXX|
|variable names|IDENTIFIER|
|+|PLUS|
|-|MINUS|
|/|DIVIDE|
|*|MULTIPLY|
|[|L_SQR|
|]|R_SQR|
|{|L_CUR|
|}|R_CUR|
|&#124;|CONTAIN|
|lt (<)|L_T|
|gt (>)|G_T|
|leq (<=)|L_EQ|
|geq (>=)|G_EQ|
|=|EQ|
|AND|AND|
|NOT|NOT|
|OR|OR|
|same (==)|EQUALS|
|diff (!=)|NOT_EQ|
|(|L_PAR|
|)|R_PAR|
|break|BREAK|
|contn|CONT|
|.|PERIOD|
|loop|LOOP|
|IF|IF|
|ELSE IF|ELSE IF|
|ELSE|ELSE|
|scan|INPUT|
|print|OUTPUT|
|ret|RETURN|
|,|COMMA|
|~~B~~ (whitespace)|#|
