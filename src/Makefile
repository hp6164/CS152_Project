all:
	flex ./plain.lex
	#gcc -o lexer lex.yy.c -lfl
	bison -v -d --file-prefix=p plain.y
	gcc -o parser p.tab.c lex.yy.c -lfl

clean:
	rm -f lex.yy.c lexer plain.y p.output
