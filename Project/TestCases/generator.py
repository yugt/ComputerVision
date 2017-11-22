import os
import random
from math import log10, ceil
random.seed(9001)


header="\documentclass[letterpaper,12pt]{article}\n";
header+="\usepackage[margin=1in]{geometry}\n";
header+="\usepackage{amsmath}\n";
header+="\usepackage{multicol}\n";
header+="\pagenumbering{gobble}\n";
header+="\pagestyle{empty}";

operatorslatex=("+","-","\\times","\div");
operatorsplain=("+","-","*","/");

# TODO: integer answer selector 
def column_generator(row):
    c="\\begin{align*}\n";
    for i in range(0,row):
        a=random.randint(1,999);
        b=random.randint(1,999);
        o=random.randint(0,3);
        l=str(a)+operatorslatex[o]+str(b)+"&=\\\\[1em]\n";
        log.write(str(a)+operatorsplain[o]+str(b)+"\n");
        c+=l;
    return c+"\end{align*}";

def page_generator(row,col):
    p="\\begin{multicols}{"+str(col)+"}\n";
    p+="\\noindent";
    for i in range(0,col):
        p+=column_generator(row)+"\n";
    return p+"\end{multicols}";

def files_generator(row, col, pages):
    for i in range(0,pages):
        fname="tc"+str(i).zfill(int(ceil(log10(pages))))+".tex";
        f=open(fname,'w');
        f.write(page_generator(row,col));
        f.close()


def main(row,col,pages):
    files_generator(row,col,pages);

    m=open('main.tex','w');
    m.write(header);

    m.write("\\begin{document}\n");
    for i in range(0,pages):
        m.write("\include{tc"+str(i).zfill(int(ceil(log10(pages))))+"}\n")
    m.write("\end{document}");
    m.close();

log=open('check.txt','w');
main(20,5,20);
log.close();
os.system("pdflatex main.tex");
os.system("rm -f *.aux *.log ../.DS_Store ../../.DS_Store tc*");