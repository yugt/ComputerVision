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


def equation_generator():
    o=random.randint(0,3);
    if o == 0:
        while True:
            a = random.randint(0,999);
            b = random.randint(0,999);
            if a + b <= 999:
                return (a,b,o,a+b);
    elif o == 1:
        while True:
            a = random.randint(0,999);
            b = random.randint(0,999);
            if a - b >= 0 and a - b <= 999:
                return (a,b,o,a-b);
    elif o == 2:
        while True:
            a = random.randint(1,99);
            b = random.randint(1,99);
            if a * b <= 999:
                return (a,b,o,a*b);
    else:
        while True:
            a = random.randint(1,999);
            b = random.randint(1,999);
            if a % b == 0 and a / b >= 0 and a / b <= 999:
                return (a,b,o,a/b);

def column_generator(row):
    c="\\begin{align*}\n";
    for i in range(0,row):
        (a,b,o,r) = equation_generator();
        l=str(a)+operatorslatex[o]+str(b)+"&="+str(r)+"\\\\[1em]\n";
        log.write(str(a)+operatorsplain[o]+str(b)+"="+str(r)+"\n");
        c+=l;
    return c+"\end{align*}";

def page_generator(row,col):
    p="\\begin{multicols}{"+str(col)+"}\n";
    p+="\\noindent";
    for i in range(0,col):
        p+=column_generator(row)+"\n";
    return p+"\end{multicols}";

def files_generator(page_format, total_pages):
    cur_page = 0;
    for (row,col,pages) in page_format:
        for i in range(0,pages):
            fname="tc"+str(cur_page).zfill(int(ceil(log10(total_pages))))+".tex";
            cur_page += 1;
            f=open(fname,'w');
            f.write(page_generator(row,col));
            f.close()


def main(page_format):
    total_pages = 0;
    for page_tuple in page_format:
        total_pages += page_tuple[2];
    files_generator(page_format, total_pages);

    m=open('main.tex','w');
    m.write(header);

    m.write("\\begin{document}\n");
    for i in range(0,total_pages):
        m.write("\include{tc"+str(i).zfill(int(ceil(log10(total_pages))))+"}\n")
    m.write("\end{document}");
    m.close();

log=open('check.txt','w');
page_format = [(10,3,10),
        (15,2,10),
        (10,4,10),
        (10,5,10),
        (15,4,10),
        (20,3,10),
        (16,5,10),
        (20,4,10),
        (18,5,10),
        (20,5,10)];
main(page_format);
log.close();
os.system("pdflatex main.tex");
os.system("rm -f *.aux *.log ../.DS_Store ../../.DS_Store tc*");
