all:
	flex ./plain.lex
	bison -v -d --file-prefix=p plain.y
	gcc -o lexer lex.yy.c -lfl
	g++ -o parser p.tab.c lex.yy.c -lfl -std=c++11

clean:
	rm -f lex.yy.c lexer p.output p.tab.h p.tab.c
