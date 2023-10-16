rm *.zip
rm *.pdf

# package exercises I in a zip file
sed 's+``<code>&#124;</code>``+|+g' < p1_lexical_analysis.md > tmp.md
pandoc tmp.md -o p1_lexical_analysis.pdf
rm tmp.md
zip p1_lexical_analysis.zip p1_lexical_analysis.pdf lexer.l

# package exercises II in a zip file
pandoc p2_advanced_lex.md -o p2_advanced_lex.pdf
zip p2_advanced_lex.zip p2_advanced_lex.pdf lexer.l

# package exercises III in a zip file
pandoc p3_syntactic_analysis.md -o p3_syntactic_analysis.pdf
zip p3_syntactic_analysis.zip p3_syntactic_analysis.pdf calc.l calc.y

# package exercises IV in a zip file
#pandoc p4_abstract_syntax.md -o p4_abstract_syntax.pdf
#zip p4_abstract_syntax.zip p4_abstract_syntax.pdf tree.c tree.h

# package exercises VI in a zip file
pandoc p6_code_generation.md -o p6_code_generation.pdf
zip p6_code_generation.zip p6_code_generation.pdf calc.l calc.y

