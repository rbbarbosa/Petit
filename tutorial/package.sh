# package exercises I in a zip file
sed 's+``<code>&#124;</code>``+|+g' < ex1_lexical_analysis.md > tmp.md
pandoc tmp.md -o ex1_lexical_analysis.pdf
rm tmp.md
zip ex1_lexical_analysis.zip ex1_lexical_analysis.pdf lexer.l

# package exercises III in a zip file
pandoc ex3_syntactic_analysis.md -o ex3_syntactic_analysis.pdf
zip ex3_syntactic_analysis.zip ex3_syntactic_analysis.pdf calc.l calc.y

# package exercises IV in a zip file
pandoc ex4_abstract_syntax.md -o ex4_abstract_syntax.pdf
zip ex4_abstract_syntax.zip ex4_abstract_syntax.pdf tree.c tree.h
