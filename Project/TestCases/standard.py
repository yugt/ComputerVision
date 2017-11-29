import os

header="\documentclass[a4paper,12pt]{article}\n";
header+="\usepackage[margin=1in]{geometry}\n";
header+="\usepackage{amsmath}\n";
header+="\usepackage{multicol}\n";
header+="\usepackage{fontspec}\n";
header+="\pagenumbering{gobble}\n";
header+="\pagestyle{empty}\n";
header+="\input{fonts.tex}\n";

fonts=["opensans","quicksand","roboto","robotoc"];
fonts_italic=["robotol","robotocl","robotot"];


def parse(num,prefix,suffix):
    padding="&=\\\\[0.6em]\n";
    r=prefix+str(num)+suffix+"+";
    r+=prefix+str(num+1)+suffix+padding;
    return r;

def font_all(num,font):
    line=parse(num,"\\textrm{\\"+font+"{","}}");
    line+=parse(num,"\\textbf{\\"+font+"{","}}");
    line+=parse(num,"\\textit{\\"+font+"{","}}");
    line+=parse(num,"\\textbf{\\textit{\\"+font+"{","}}}");
    return line;

def font_half(num,font):
    line=parse(num,"\\textrm{\\"+font+"{","}}");
    line+=parse(num,"\\textit{\\"+font+"{","}}");
    return line;

def column_generator(num):
    c="\\begin{align*}\n";
    c+=parse(num,"\mathrm{","}");
    c+=parse(num,"\mathit{","}");
    c+=parse(num,"\mathtt{","}");
    c+=parse(num,"\mathbf{","}");
    c+=parse(num,"\\textbf{\\textit{","}}");
    for font in fonts:
        c+=font_all(num,font);
    for font in fonts_italic:
        c+=font_half(num,font);
    return c+"\end{align*}";

def page_generator(col):
    p="\\begin{multicols}{"+str(col)+"}\n";
    p+="\\noindent\n";
    for i in range(0,2*col-1,2):
        p+=column_generator(i)+"\n";
    return p+"\end{multicols}\n";

def main():
    m=open('standard.tex','w');
    m.write(header);
    m.write("\\begin{document}\n");
    m.write(page_generator(5))
    m.write("\end{document}");
    m.close();

main();
os.system("xelatex standard.tex");
os.system("rm -f *.aux *.log *.fls *.fdb_latexmk  *.gz ../.DS_Store ../../.DS_Store tc*");