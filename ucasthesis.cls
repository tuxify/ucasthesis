%%================================================
%% File: ucasthesis.cls
%% Encoding: UTF-8
%% Author: Yuan Xiaoshuai - yxshuai@gmail.com
%% Created: 2017-05-25 10:18
%% Last modified: 2019-11-10 21:11
%%================================================
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{ucasthesis}
[2016/03/20 5.3.1 University of Chinese Academy of Sciences Thesis Template]
\hyphenation{Ucas-Thesis}
\def\ucasthesis{\textsc{UcasThesis}}
\def\version{5.3.1}

\RequirePackage{kvoptions}
\SetupKeyvalOptions{
  family=ucas,
  prefix=ucas@,
  setkeys=\kvsetkeys}
\newif\ifucas@master
\newif\ifucas@doctor
\define@key{ucas}{type}{%
  \ucas@masterfalse
  \ucas@doctorfalse
  \expandafter\csname ucas@#1true\endcsname}
\def\ucas@deprecated@type@option{%
  \kvsetkeys{ucas}{type=\CurrentOption} % for compatability.
  \ClassError{ucasthesis}{Option '\CurrentOption' is deprecated, \MessageBreak
                         please use 'type=\CurrentOption' instead}{}}
\DeclareVoidOption{master}{\ucas@deprecated@type@option}
\DeclareVoidOption{doctor}{\ucas@deprecated@type@option}
\DeclareBoolOption{secret}
\DeclareBoolOption{arialtoc}
\DeclareBoolOption{arialtitle}
\DeclareBoolOption{raggedbottom}
\DeclareBoolOption{pifootnote}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\kvsetkeys{ucas}{%
  raggedbottom,
  arialtitle}
\ProcessKeyvalOptions*
\PassOptionsToPackage{no-math}{fontspec}
\LoadClass[a4paper,openany,UTF8,zihao=-4,scheme=plain]{ctexbook}
\ifucas@master\relax\else
  \ifucas@doctor\relax\else
      \ClassError{ucasthesis}%
                 {Please specify thesis type in option: \MessageBreak
                  type=[ master | doctor ]}{}
  \fi
\fi
\RequirePackage{etoolbox}
\RequirePackage{ifxetex}
\RequirePackage{xparse}
\RequirePackage{amsmath}
\RequirePackage[defaultsups]{newtxtext}
\RequirePackage{newtxmath}
\RequirePackage{courier}
\RequirePackage{graphicx}
\RequirePackage[list=off]{bicaption}
\RequirePackage[labelformat=simple]{subcaption}
\RequirePackage{pdfpages}
% \includepdfset{fitpaper=true}
\RequirePackage[shortlabels]{enumitem}
\RequirePackage{environ}
\ifucas@raggedbottom
  \RequirePackage[bottom,perpage,hang]{footmisc}
  \raggedbottom
\else
  \RequirePackage[perpage,hang]{footmisc}
\fi
\ifucas@pifootnote
  \RequirePackage{pifont}
\fi
\RequirePackage{CJKfntef}
\ifxetex
  \def\CJK@null{\kern\CJKnullspace\Unicode{48}{7}\kern\CJKnullspace}
  \defaultfontfeatures{Mapping=tex-text}
\fi
\RequirePackage[amsmath,thmmarks,hyperref]{ntheorem}
\RequirePackage{array}
\RequirePackage{longtable}
\RequirePackage{booktabs}
\RequirePackage[sort&compress]{natbib}
\RequirePackage{hyperref}
\ifxetex
  \hypersetup{%
    CJKbookmarks=true}
\else
  \hypersetup{%
    unicode=true,
    CJKbookmarks=false}
\fi
\hypersetup{%
  linktoc=all,
  bookmarksnumbered=true,
  bookmarksopen=true,
  bookmarksopenlevel=1,
  breaklinks=true,
  colorlinks=false,
  plainpages=false,
  pdfborder=0 0 0}
\urlstyle{same}
\RequirePackage{geometry}
\geometry{
  a4paper, % 210 * 297mm
  hcentering,
  ignoreall,
  nomarginpar}
\geometry{
  left=30mm,
  right=30mm,
  top=25.4mm,
  bottom=25.4mm,
  headheight=5.4mm,
  headsep=5mm,
  % textheight=237mm,
  footskip=10.4mm}
\RequirePackage{fancyhdr}
\let\ucas@cleardoublepage\cleardoublepage
\newcommand{\ucas@clearemptydoublepage}{%
  \clearpage{\pagestyle{ucas@empty}\ucas@cleardoublepage}}
\let\cleardoublepage\ucas@clearemptydoublepage
\renewcommand\frontmatter{%
  % \if@openright\cleardoublepage\else\clearpage\fi
  \cleardoublepage
  \@mainmatterfalse
  \pagenumbering{Roman}
  % \pagestyle{ucas@empty}
  \pagestyle{ucas@frontheadings}
  \ctexset{chapter/format={\centering\ucas@title@font\heiti\sihao[1.5]},
           chapter/pagestyle={ucas@frontheadings}}}
\renewcommand\mainmatter{%
  % \if@openright\cleardoublepage\else\clearpage\fi
  \cleardoublepage
  \@mainmattertrue
  \pagestyle{ucas@headings}
  \pagenumbering{arabic}
  \ctexset{chapter/format={\centering\ucas@title@font\heiti\sihao[1.5]},
           chapter/pagestyle={ucas@headings}}}
\renewcommand\backmatter{%
  % \if@openright\cleardoublepage\else\clearpage\fi
  \cleardoublepage
  \@mainmattertrue
  \ctexset{chapter/format={\centering\ucas@title@font\heiti\sihao[1.5]},
           chapter/pagestyle={ucas@headings}}}
\renewcommand\normalsize{%
  \@setfontsize\normalsize{12bp}{23.4bp}%
  \abovedisplayskip=12bp \@plus 2bp \@minus 2bp
  \abovedisplayshortskip=12bp \@plus 1bp \@minus 1bp
  \belowdisplayskip=12bp \@plus 2bp \@minus 2bp
  \belowdisplayshortskip=12bp \@plus 1bp \@minus 1bp}
\def\ucas@def@fontsize#1#2{%
  \expandafter\newcommand\csname #1\endcsname[1][1.3]{%
    \fontsize{#2}{##1\dimexpr #2}\selectfont}}
\ucas@def@fontsize{chuhao}{42bp}
\ucas@def@fontsize{xiaochu}{36bp}
\ucas@def@fontsize{yihao}{26bp}
\ucas@def@fontsize{xiaoyi}{24bp}
\ucas@def@fontsize{erhao}{22bp}
\ucas@def@fontsize{xiaoer}{18bp}
\ucas@def@fontsize{sanhao}{16bp}
\ucas@def@fontsize{xiaosan}{15bp}
\ucas@def@fontsize{sihao}{14bp}
\ucas@def@fontsize{banxiaosi}{13bp}
\ucas@def@fontsize{xiaosi}{12bp}
\ucas@def@fontsize{dawu}{11bp}
\ucas@def@fontsize{wuhao}{10.5bp}
\ucas@def@fontsize{xiaowu}{9bp}
\ucas@def@fontsize{liuhao}{7.5bp}
\ucas@def@fontsize{xiaoliu}{6.5bp}
\ucas@def@fontsize{qihao}{5.5bp}
\ucas@def@fontsize{bahao}{5bp}
\newCJKfontfamily[scsong]\scsong{Source Han Serif SC}
\fancypagestyle{ucas@empty}{%
  \fancyhf{}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}}
\fancypagestyle{ucas@plain}{%
  \fancyhead{}
  \fancyfoot[RO]{\xiaowu\thepage}
  \fancyfoot[LE]{\xiaowu\thepage}
  \renewcommand{\headrulewidth}{0pt}
  \renewcommand{\footrulewidth}{0pt}}
\fancypagestyle{ucas@headings}{%
  \fancyhead{}
  \fancyhead[CO]{\wuhao\songti\leftmark}
  \fancyhead[CE]{\wuhao\songti\ucas@ctitlemark}
  \fancyfoot{}
  % \fancyfoot[C]{\wuhao\thepage}
  \fancyfoot[RO]{\xiaowu\thepage}
  \fancyfoot[LE]{\xiaowu\thepage}
  \renewcommand{\headrulewidth}{0.4pt}
  \renewcommand{\footrulewidth}{0pt}}
\fancypagestyle{ucas@frontheadings}{%
  \fancyhead{}
  \fancyhead[CO]{\wuhao\songti\leftmark}
  \fancyhead[CE]{\wuhao\songti\ucas@ctitlemark}
  \fancyfoot{}
  \fancyfoot[C]{\xiaowu\thepage}
  \renewcommand{\headrulewidth}{0.4pt}
  \renewcommand{\footrulewidth}{0pt}}
\fancypagestyle{ucas@eabstractheadings}{%
  \fancyhead{}
  \fancyhead[CO]{\wuhao\songti\leftmark}
  \fancyhead[CE]{\wuhao\songti\ucas@etitlemark}
  \fancyfoot{}
  \fancyfoot[C]{\xiaowu\thepage}
  \renewcommand{\headrulewidth}{0.4pt}
  \renewcommand{\footrulewidth}{0pt}}
\ctexset{%
  punct=quanjiao,
  space=auto,
  autoindent=true}
\setlist{nosep}
\def\ucas@textcircled#1{%
  \ifnum\value{#1} >9
    \ClassError{ucasthesis}%
      {Too many footnotes in this page.}{Keep footnote less than 10.}
  \fi
  \ifucas@pifootnote%
    \ding{\numexpr171+\value{#1}}%
  \else%
    \textcircled{\xiaoliu\arabic{#1}}%
  \fi}
\renewcommand{\thefootnote}{\ucas@textcircled{footnote}}
\renewcommand{\thempfootnote}{\ucas@textcircled{mpfootnote}}
\def\footnoterule{\vskip-3\p@\hrule\@width0.3\textwidth\@height0.4\p@\vskip2.6\p@}
\let\ucas@footnotesize\footnotesize
\renewcommand\footnotesize{\ucas@footnotesize\xiaowu[1.5]}
\footnotemargin1.5em\relax
\let\ucas@makefnmark\@makefnmark
\def\ucas@@makefnmark{\hbox{{\normalfont\@thefnmark}}}
\pretocmd{\@makefntext}{\let\@makefnmark\ucas@@makefnmark}{}{}
\apptocmd{\@makefntext}{\let\@makefnmark\ucas@makefnmark}{}{}
\allowdisplaybreaks[4]
\renewcommand\theequation{\ifnum \c@chapter>\z@ \thechapter-\fi\@arabic\c@equation}
\theorembodyfont{\rmfamily\songti}
\theoremheaderfont{\rmfamily\heiti}
% \setlength{\floatsep}{20bp \@plus4pt \@minus1pt}
\setlength{\intextsep}{20bp \@plus4pt \@minus2pt}
% \setlength{\textfloatsep}{20bp \@plus4pt \@minus2pt}
\setlength{\@fptop}{0bp \@plus1.0fil}
\setlength{\@fpsep}{12bp \@plus2.0fil}
\setlength{\@fpbot}{0bp \@plus1.0fil}
\renewcommand{\textfraction}{0.15}
\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{0.65}
\renewcommand{\floatpagefraction}{0.60}
\let\old@tabular\@tabular
\def\ucas@tabular{\wuhao[1.5]\old@tabular}
\DeclareCaptionLabelFormat{ucas}{{\wuhao[1.5]\bfseries\scsong #1~\rmfamily #2}}%songti
\DeclareCaptionLabelSeparator{ucas}{\hspace{1em}}
\DeclareCaptionFont{ucas}{\wuhao[1.5]}
\DeclareCaptionFormat{ucas}{{\centering #1#2#3}\par}
% \captionsetup{labelformat=ucas,labelsep=ucas,font=ucas,format=hang}
\captionsetup{labelformat=ucas,labelsep=ucas,font=ucas,format=ucas}
% \captionsetup[table]{position=top,belowskip={12bp-\intextsep},aboveskip=6bp}
% \captionsetup[figure]{position=bottom,belowskip={12bp-\intextsep},aboveskip=6bp}
\captionsetup[table]{position=top,belowskip={12bp-\intextsep},aboveskip=6bp}
\captionsetup[figure]{position=bottom,belowskip={12bp-\intextsep},aboveskip=6bp}
\captionsetup[sub]{font=ucas,skip=6bp}
\renewcommand{\thesubfigure}{(\alph{subfigure})}
\renewcommand{\thesubtable}{(\alph{subtable})}
\DeclareCaptionOption{bi-first}[]{%
    \def\tablename{\ucas@ctablename}
    \def\figurename{\ucas@cfigurename}
}%bi-first
\DeclareCaptionOption{bi-second}[]{%
    \def\tablename{\ucas@etablename}
    \def\figurename{\ucas@efigurename}
}%bi-second
\captionsetup{bi-slc=off}
\captionsetup[bi-first]{bi-first}
\captionsetup[bi-second]{bi-second}
\let\ucas@LT@array\LT@array
\def\LT@array{\wuhao[1.5]\ucas@LT@array} % set default font size
\def\hlinewd#1{%
  \noalign{\ifnum0=`}\fi\hrule \@height #1 \futurelet
    \reserved@a\@xhline}
\def\ucas@title@font{%
  \ifucas@arialtitle\sffamily\else\relax\fi}
\AtBeginDocument{%
  \pagestyle{ucas@empty}
  \renewcommand{\chaptermark}[1]{\@mkboth{\CTEXthechapter\hskip\ccwd#1}{}}}
\newcommand\ucas@chapter@titleformat[1]{%
  \ifthenelse{\equal{#1}{\eabstractname}}{\bfseries #1}{#1}}
\ctexset{%
  chapter={
    afterindent=true,
    % pagestyle={ucas@headings},
    beforeskip={9bp},
    aftername=\hskip\ccwd,
    afterskip={18bp},
    format={\centering\ucas@title@font\sihao[1.5]},
    nameformat=\relax,
    numberformat=\relax,
    titleformat=\ucas@chapter@titleformat,
  },
  section={
    afterindent=true,
    beforeskip={24bp\@plus 1ex \@minus .2ex},
    afterskip={6bp\@plus .2ex},
    format={\ucas@title@font\heiti\xiaosi[1.429]},
  },
  subsection={
    afterindent=true,
    beforeskip={12bp\@plus 1ex \@minus .2ex},
    afterskip={6bp \@plus .2ex},
    format={\ucas@title@font\heiti\xiaosi[1.538]},
  },
  subsubsection={
    afterindent=true,
    beforeskip={16bp\@plus 1ex \@minus .2ex},
    afterskip={6bp \@plus .2ex},
    format={\csname ucas@title@font\endcsname\heiti\xiaosi[1.667]},
  },
  paragraph/afterindent=true,
  subparagraph/afterindent=true}
\newcounter{ucas@bookmark}
\NewDocumentCommand\ucas@chapter{s o m o}{
  \IfBooleanF{#1}{%
    \ClassError{ucasthesis}{You have to use the star form: \string\ucas@chapter*}{}
  }%
  % \if@openright\cleardoublepage\else\clearpage\fi\phantomsection%
  \clearpage\phantomsection
  \IfValueTF{#2}{%
    \ifthenelse{\equal{#2}{}}{%
      \addtocounter{ucas@bookmark}\@ne
      \pdfbookmark[0]{#3}{ucaschapter.\theucas@bookmark}
    }{%
      \addcontentsline{toc}{chapter}{#3}
    }
  }{%
    \addcontentsline{toc}{chapter}{#3}
  }%
  \chapter*{#3}%
  \IfValueTF{#4}{%
    \ifthenelse{\equal{#4}{}}
    {\@mkboth{}{}}
    {\@mkboth{#4}{#4}}
  }{%
    \@mkboth{#3}{#3}
  }
}
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{2}
\renewcommand\tableofcontents{%
  \cleardoublepage
  \ucas@chapter*[]{\contentsname}
  \xiaosi[1.65]\@starttoc{toc}\normalsize}
\ifucas@arialtoc
  \def\ucas@toc@font{\sffamily}
\fi
\def\@pnumwidth{2em}
\def\@tocrmarg{\@pnumwidth}
\def\@dotsep{1}
\patchcmd{\@dottedtocline}{#4}{\csname ucas@toc@font\endcsname #4}{}{}
\patchcmd{\@dottedtocline}{\hb@xt@\@pnumwidth}{\hbox}{}{}
\renewcommand*\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 6bp \@plus\p@
    \setlength\@tempdima{1em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      % numberline is called here, and it uses \@tempdima
      {\csname ucas@toc@font\endcsname\heiti #1}
      \leaders\hbox{$\m@th\mkern \@dotsep mu\hbox{.}\mkern \@dotsep mu$}\hfill
      \nobreak{\normalfont\normalcolor #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}
\renewcommand*\l@section{%
  \@dottedtocline{1}{\ccwd}{2.1em}}
\renewcommand*\l@subsection{%
  \@dottedtocline{2}{2\ccwd}{3em}}
\renewcommand*\l@subsubsection{%
  \@dottedtocline{3}{3.5em}{3.8em}}
\def\ucas@def@term#1{%
  \define@key{ucas}{#1}{\csname #1\endcsname{##1}}
  \expandafter\gdef\csname #1\endcsname##1{%
    \expandafter\gdef\csname ucas@#1\endcsname{##1}}
  \csname #1\endcsname{}}
\ucas@def@term{secretlevel}
\ucas@def@term{ctitle}
\ucas@def@term{ctitlemark}
\ucas@def@term{etitle}
\ucas@def@term{etitlemark}
\ucas@def@term{cauthor}
\ucas@def@term{csupervisor}
\ucas@def@term{csupervisorplace}
\ucas@def@term{ccosupervisor}
\ucas@def@term{eauthor}
\ucas@def@term{esupervisor}
\ucas@def@term{eassosupervisor}
\ucas@def@term{ecosupervisor}
\ucas@def@term{cdegree}
\ucas@def@term{edegree}
\ucas@def@term{cdepartment}
\ucas@def@term{cfigurename}
\ucas@def@term{efigurename}
\ucas@def@term{ctablename}
\ucas@def@term{etablename}
\ucas@def@term{edepartment}
\ucas@def@term{cmajor}
\ucas@def@term{emajor}
\ucas@def@term{cdate}
\ucas@def@term{edate}
\ucas@def@term{ackdate}
\newcommand{\ucas@@cabstract}[1]{\long\gdef\ucas@cabstract{#1}}
\newenvironment{cabstract}{\Collect@Body\ucas@@cabstract}{}
\newcommand{\ucas@@eabstract}[1]{\long\gdef\ucas@eabstract{#1}}
\newenvironment{eabstract}{\Collect@Body\ucas@@eabstract}{}
\def\ucas@parse@keywords#1{
  \define@key{ucas}{#1}{\csname #1\endcsname{##1}}
  \expandafter\gdef\csname ucas@#1\endcsname{}
  \expandafter\gdef\csname #1\endcsname##1{
    \@for\reserved@a:=##1\do{
      \expandafter\ifx\csname ucas@#1\endcsname\@empty\else
        \expandafter\g@addto@macro\csname ucas@#1\endcsname{%
          \ignorespaces\csname ucas@#1@separator\endcsname}
      \fi
      \expandafter\expandafter\expandafter\g@addto@macro%
        \expandafter\csname ucas@#1\expandafter\endcsname\expandafter{\reserved@a}}}}
\ucas@parse@keywords{ckeywords}
\ucas@parse@keywords{ekeywords}
\def\ucassetup{\kvsetkeys{ucas}}
\newcommand\ucas@underline[2][6em]{\hskip1pt\underline{\hb@xt@ #1{\hss#2\hss}}\hskip3pt}
\newlength{\ucas@title@width}
\newcommand{\ucas@put@title}[2][\ucas@title@width]{%
  \begin{CJKfilltwosides}{#1}#2\end{CJKfilltwosides}}
\newcommand{\ucas@first@titlepage}{
  \begin{center}
    \vspace*{-2cm}
    \parbox[t][1cm][t]{\textwidth}{%
      \ifucas@secret\hfill{\sihao[1]\songti
        \textbf{\ucas@secretlevel\ucas@title@sep}
        \underline{\makebox[6em]{\ucas@secret@content}}}\fi}
    \begin{figure}[H]
      \centering
      % \includegraphics[width=128mm,height=21.7mm]{UCAS}
      \includegraphics[height=21.59mm]{UCAS}
    \end{figure}
    \parbox[t][6cm][t]{\paperwidth-8cm}{
      \renewcommand{\baselinestretch}{1.5}
      \begin{center}
        \yihao\heiti\ucas@apply
        \par\vskip 50bp
        \xiaosan\heiti \CJKunderline{\ucas@ctitle}
      \end{center}}
    \parbox[t][10cm][t]{\textwidth}{\sihao\bfseries\scsong%\songti
      \begin{center}
        \setlength{\ucas@title@width}{4em}
        \setlength{\extrarowheight}{2.5ex}
        \begin{tabular}{ll}
          \ucas@author@title\ucas@title@sep     
            & \underline{\makebox[25em]{\ucas@cauthor}}\\
          \ucas@supervisor@title\ucas@title@sep
            & \underline{\makebox[25em]{\ucas@csupervisor}}\\
            & \underline{\makebox[25em]{\ucas@ccosupervisor}}\\
            & \underline{\makebox[25em]{\ucas@csupervisorplace}}\\
          \ucas@degree@title\ucas@title@sep
            & \underline{\makebox[25em]{\ucas@cdegree}}\\
          \ucas@major@title\ucas@title@sep
            & \underline{\makebox[25em]{\ucas@cmajor}}\\
          \ucas@put@title{\ucas@department@title}\ucas@title@sep
            & \underline{\makebox[25em]{\ucas@cdepartment}}\\
        \end{tabular}
      \end{center}}
    \begin{center}
      {\vfill \sihao\bfseries\scsong\ucas@cdate}%\songti
    \end{center}
  \end{center}} % end of titlepage
\newcommand{\ucas@engcover}{%
  \cleardoublepage
  \thispagestyle{ucas@empty}
  \begin{center}
    \vspace*{1cm}
    \parbox[t][3.6cm][t]{\textwidth}{
      \renewcommand{\baselinestretch}{1.5}
      \begin{center}
          \xiaosan\rmfamily\textbf{\uline{\ucas@etitle}}
      \end{center}}
    \parbox[t][10.8cm][c]{\textwidth}{
      \renewcommand{\baselinestretch}{1.5}
      \begin{center}
        \sihao
        \rmfamily \textbf{A \ifucas@master Thesis \else Dissertation \fi
        Submitted to}\\
        \rmfamily \textbf{University of Chinese Academy of Sciences} \\
        \rmfamily \textbf{in partial fulfillment of the requirement}\\
        \rmfamily \textbf{for the degree of}\\
        \rmfamily \textbf{\ucas@edegree}\\
        \rmfamily \textbf{in} \textbf{\ucas@emajor}\\
        \par\vskip 12bp
        \sihao\rmfamily \textbf{By}\\% sihao or sanhao?
        \sihao\rmfamily \textbf{\ucas@eauthor}\\
        \par\vskip 20bp
        \begin{tabular}{ll}
          \sihao\rmfamily \textbf{Supervisor: }
            & \textbf{\ucas@esupervisor} \\
            & \textbf{\ucas@ecosupervisor} \\
        \end{tabular}
        % \sihao\rmfamily \textbf{Supervisor: }
        % \textbf{\ucas@esupervisor}\\
        % \hspace*{11em}\textbf{\ucas@ecosupervisor}\\
      \end{center}}
    \parbox[t][3.6cm][b]{\textwidth}{
    \renewcommand{\baselinestretch}{1.5}
    \begin{center}
      \sihao\rmfamily\textbf{\ucas@edepartment}
      \par\vskip 12bp
      \sihao\rmfamily\textbf{\ucas@edate}
    \end{center}}
  \end{center}}
\newcommand{\ucas@authorization@mk}{%
  \thispagestyle{ucas@empty}
  \vspace*{0.42cm}
  \begin{center}
      \sihao[2.0]\heiti
      \ucas@schoolname\\
      \ucas@declarename
  \end{center}
  \par{\xiaosi[2.0]\ucas@declaretext}
  \vskip1.0cm
  \begingroup
    \parindent0pt\xiaosi
    \hfill\ucas@authorsig\hspace*{3.5cm}\par\vskip6.0pt
    \hfill\ucas@frontdate\hspace*{3.5cm}
  \endgroup
  \vskip2.0cm
  \begin{center}
      \sihao[2.0]\heiti
      \ucas@schoolname\\
      \ucas@authtitle
  \end{center}
  \par{\xiaosi[2.0]\ucas@authorization}
  \par{\xiaosi[2.0]\ucas@authorizationaddon}
  \vskip1.0cm
  \begingroup
    \parindent0pt\xiaosi
    \hspace*{1.5cm}\ucas@authorsig\hspace*{2.5cm}\hfill%
                   \ucas@teachersig\hspace*{3.5cm}\par\vskip6.0pt
    \hspace*{1.5cm}\ucas@frontdate\hspace*{2.5cm}\hfill%
                   \ucas@frontdate\hspace*{3.5cm}
  \endgroup}
\def\makecover{%
  \ucas@setup@pdfinfo\ucas@makecover}
\def\ucas@setup@pdfinfo{%
  \hypersetup{%
    pdftitle={\ucas@ctitlemark},
    pdfauthor={\ucas@cauthor},
    pdfsubject={\ucas@cdegree},
    pdfkeywords={\ucas@ckeywords},
    pdfcreator={\ucasthesis-v\version}}}
\NewDocumentCommand{\ucas@makecover}{}{
  \phantomsection
  \pdfbookmark[-1]{\ucas@ctitlemark}{ctitle}
  \normalsize%
  \begin{titlepage}
    \ucas@first@titlepage
    \ucas@engcover
    \cleardoublepage
    \ucas@authorization@mk
  \end{titlepage}
  \normalsize
  \ucas@makeabstract
  \let\@tabular\ucas@tabular}
\newbox\ucas@kw
\newcommand\ucas@put@keywords[2]{%
  \begingroup
    \setbox\ucas@kw=\hbox{#1}
    \noindent\hangindent\wd\ucas@kw\hangafter1
    \box\ucas@kw#2\par
  \endgroup}
\newcommand{\ucas@makeabstract}{%
  \cleardoublepage
  \ucas@chapter*[]{\cabstractname} % no tocline
  \pagenumbering{Roman}
  \ucas@cabstract
  \vskip12bp
  \ucas@put@keywords{\bfseries\scsong\ucas@ckeywords@title}{\ucas@ckeywords}%\heiti
  \cleardoublepage
  \ucas@chapter*[]{\eabstractname} % no tocline
  \ucas@eabstract
  \thispagestyle{ucas@eabstractheadings}
  \vskip12bp
  \ucas@put@keywords{%
    \textbf{\ucas@ekeywords@title\enskip}}{\ucas@ekeywords}}
\newenvironment{denotation}[1][2.5cm]{%
  \cleardoublepage
  \ucas@chapter*[1]{\ucas@denotation@name} % with tocline
  \vskip-30bp\xiaosi[1.6]\begin{ucas@denotation}[labelwidth=#1]
}{\end{ucas@denotation}}
\newlist{ucas@denotation}{description}{1}
\setlist[ucas@denotation]{%
  nosep,
  font=\normalfont,
  align=left,
  leftmargin=!, % sum of the following 3 lengths
  labelindent=0pt,
  labelwidth=2.5cm,
  labelsep*=0.5cm,
  itemindent=0pt,
}
\NewDocumentEnvironment{acknowledgement}{o}{%
    \cleardoublepage
    \ucas@chapter*{\ucas@ackname}
  }{\vskip 48bp\hfill\ucas@ackdate}
\let\ack\acknowledgement
\let\endack\endacknowledgement
\def\ucas@starttoc#1{% #1: float type, prepend type name in \listof*** entry.
  \let\oldnumberline\numberline
  \def\numberline##1{\oldnumberline{\csname #1name\endcsname\hskip.4em ##1}}
  \@starttoc{\csname ext@#1\endcsname}
  \let\numberline\oldnumberline}
\def\ucas@listof#1{% #1: float type
  \cleardoublepage
  \@ifstar
    {\ucas@chapter*[]{\csname list#1name\endcsname}\ucas@starttoc{#1}}
    {\ucas@chapter*{\csname list#1name\endcsname}\ucas@starttoc{#1}}}
\renewcommand\listoffigures{\ucas@listof{figure}}
\renewcommand*\l@figure{\addvspace{6bp}\@dottedtocline{1}{0em}{4em}}
\renewcommand\listoftables{\ucas@listof{table}}
\let\l@table\l@figure
\def\ext@equation{loe}
\def\equcaption#1{%
  \addcontentsline{\ext@equation}{equation}%
                  {\protect\numberline{#1}}}
\newcommand\listofequations{\ucas@listof{equation}}
\let\l@equation\l@figure
\bibpunct{[}{]}{,}{s}{}{,}
\renewcommand\NAT@citesuper[3]{\ifNAT@swa%
  \unskip\kern\p@\textsuperscript{\NAT@@open #1\NAT@@close}%
  \if*#3*\else\ (#3)\fi\else #1\fi\endgroup}
\DeclareRobustCommand\inlinecite{\@inlinecite}
\def\@inlinecite#1{\begingroup\let\@cite\NAT@citenum\citep{#1}\endgroup}
\let\onlinecite\inlinecite
\renewenvironment{thebibliography}[1]{%
  % \cleardoublepage
  \ucas@chapter*{\bibname}%
  \wuhao[1.5]
  \list{\@biblabel{\@arabic\c@enumiv}}%
       {\renewcommand{\makelabel}[1]{##1\hfill}
        \settowidth\labelwidth{1.1cm}
        \setlength{\labelsep}{0.4em}
        \setlength{\itemindent}{0pt}
        \setlength{\leftmargin}{\labelwidth+\labelsep}
        \addtolength{\itemsep}{-0.7em}
        \usecounter{enumiv}%
        \let\p@enumiv\@empty
        \renewcommand\theenumiv{\@arabic\c@enumiv}}%
   \sloppy\frenchspacing
   \clubpenalty4000
   \@clubpenalty \clubpenalty
   \widowpenalty4000%
   \interlinepenalty4000%
   \sfcode`\.\@m}
  {\def\@noitemerr
    {\@latex@warning{Empty `thebibliography' environment}}%
   \endlist\frenchspacing}
\let\ucas@appendix\appendix
\renewenvironment{appendix}{%
  \let\title\ucas@appendix@title
  \ucas@appendix}{%
  \let\title\@gobble}
\let\title\@gobble
\newcommand{\ucas@appendix@title}[1]{%
  \begin{center}
    \bfseries\xiaosi #1
  \end{center}}
\newlist{translationbib}{enumerate}{1}
\setlist[translationbib]{label=[\arabic*],align=left,nosep,itemsep=6bp,
  leftmargin=10mm,labelsep=!,before=\vspace{0.5\baselineskip}\wuhao[1.3]}
\newenvironment{resume}[1][\ucas@resume@title]{%
  \cleardoublepage
  \ucas@chapter*{#1}}{}
\newcommand{\resumeitem}[1]{%
  \vspace{24bp}{\xiaosi\heiti\flushleft{#1}}\par\vspace{6bp}}
\newcommand{\researchitem}[1]{%
  \vspace{32bp}{\xiaosi\heiti\flushleft{#1}}\par\vspace{14bp}}
\newlist{publications}{enumerate}{1}
\setlist[publications]{label=[\arabic*],align=left,nosep,itemsep=8bp,
  leftmargin=10mm,labelsep=!,before=\xiaosi[1.26],resume}
\newlist{achievements}{enumerate}{1}
\setlist[achievements]{label=[\arabic*],align=left,nosep,itemsep=8bp,
  leftmargin=10mm,labelsep=!,before=\xiaosi[1.26]}
\def\publicationskip{\bigskip\bigskip}
\AtEndOfClass{\input{ucasthesis.cfg}}
\AtEndOfClass{\sloppy}
\endinput
%%
%% End of file `ucasthesis.cls'.