# CS152_Project

## Language name: Plain


- Plain is case sensitive
- White Spaces are ignored in our language
- Variable names have the following rules:
  - Should not be a Token name or syntax keyword
  - Should not start with a number or be a number or a “ : ” or whitespace or uppercase letter
  - Should not contain a “$” or “#”
  - Should not end in or contain “.” 



|    C++ syntax     | Plain syntax |
|          :---:            |          :---:             |
|int| num |
|array| list |
|=|=|
|+, -, *, /| +, -, *, / |
|<|lt|
|>|gt|
|<=|leq|
|>=|geq|
|==|same|
|!|NOT|
| &#124; | OR |
|&&| AND |
|!=|diff|
|while|loop|
|break|break|
|continue|contn|
|if/else if/else|IF/ELSE IF/ELSE|
|cin|scan|
|cout|print|
| // | $ |
|/\*...\*/| &#36; '...' &#36; |
|Func_type func_name(parameter)|:func_name (parameter)func_type|
|return|ret|
|;|.|








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
