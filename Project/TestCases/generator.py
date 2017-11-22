import os
import random
from math import log10, floor
random.seed(9001)


header="\documentclass[letterpaper,12pt]{article}\n";
header+="\usepackage[margin=1in]{geometry}\n";
header+="\usepackage{amsmath}\n";
header+="\usepackage{multicol}\n";
header+="\pagenumbering{gobble}\n";

operators=("+","-","\\times","\div");

def column_generator(row):
    c="\\begin{align*}\n";
    for i in range(0,row):
        l=str(random.randint(1,999));
        l+=operators[random.randint(0,3)];
        l+=str(random.randint(1,999));
        l+="&=\\\\[1em]\n";
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
        fname="tc"+str(i).zfill(int(floor(log10(pages)))+1)+".tex";
        f=open(fname,'w');
        f.write(page_generator(row,col));
        f.close()


def main(row,col,pages):
    files_generator(row,col,pages);

    m=open('main.tex','w');
    m.write(header);

    m.write("\\begin{document}\n");
    for i in range(0,pages):
        m.write("\include{tc"+str(i).zfill(int(floor(log10(pages)))+1)+"}\n")
    m.write("\end{document}");
    m.close();

main(20,5,100);
os.system("pdflatex main.tex");
os.system("rm -f !(main.pdf) main.* tc*");