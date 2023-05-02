all:
	flex ./plain.lex
	gcc -o lexer lex.yy.c -lfl
	bison -v -d --file-prefix=p src/plain.y

clean:
	rm -f lex.yy.c lexer
