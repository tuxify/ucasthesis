%%================================================
%% Filename: ucasthesis.cls
%% Encoding: UTF-8
%% Author: Yuan Xiaoshuai - yxshuai@gmail.com
%% Created: 2017-05-25 10:18
%% Last modified: 2020-11-26 01:41
%%================================================
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{ucasthesis}
[2019/11/21 1.0.0 University of Chinese Academy of Sciences Thesis Template]
\RequirePackage{ifxetex}
\ifxetex\else
  \ClassError{ucasthesis}{You should use XeLaTeX}{}
  \end{document}
\fi
\hyphenation{Ucas-Thesis}
\def\ucasthesis{UcasThesis}
\def\version{1.0.0}
\RequirePackage{kvoptions}
\SetupKeyvalOptions{
  family=ucas,
  prefix=ucas@,
  setkeys=\kvsetkeys}
\DeclareStringOption[doctor]{degree}[doctor]
\DeclareStringOption[bibtex]{bibbackend}[bibtex]
\DeclareStringOption[numbers]{bibstyle}[numbers]
\DeclareBoolOption{secret}
\DeclareBoolOption{mkshuji}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessKeyvalOptions*
\newcommand\ucas@validate@key[1]{%
  \@ifundefined{ucas@\csname ucas@#1\endcsname true}{%
    \ClassError{ucasthesis}{Invalid value '\csname ucas@#1\endcsname'}{}%
  }{%
    \csname ucas@\csname ucas@#1\endcsname true\endcsname
  }%
}
\newif\ifucas@master
\newif\ifucas@doctor
\ucas@validate@key{degree}
\newif\ifucas@bibtex
\newif\ifucas@biber
\ucas@validate@key{bibbackend}
\newif\ifucas@authoryear
\newif\ifucas@numbers
\ucas@validate@key{bibstyle}
\PassOptionsToPackage{quiet}{xeCJK}
\LoadClass[a4paper,openany,UTF8,zihao=-4,scheme=plain,sub4section]{ctexbook}
\RequirePackage{etoolbox}
\RequirePackage{xparse}
\RequirePackage{amsmath}
\RequirePackage{unicode-math}
\RequirePackage{graphicx}
\RequirePackage[list=off]{bicaption}
\RequirePackage[labelformat=simple]{subcaption}
\RequirePackage{pdfpages}
\includepdfset{fitpaper=true}
\RequirePackage[shortlabels]{enumitem}
\RequirePackage{titletoc}
\RequirePackage{environ}
\RequirePackage[perpage,hang]{footmisc}
\RequirePackage{CJKfntef}
\RequirePackage[amsmath,thmmarks,hyperref]{ntheorem}
\RequirePackage{array}
\RequirePackage{longtable}
\RequirePackage{booktabs}
\ifucas@biber% Biber processor + biblatex package
  \ifucas@numbers% numbered citation style
    \RequirePackage[natbib,style=gb7714-2015,gbctexset=true,%
      sortcites]{biblatex}%
  \fi
  \ifucas@authoryear% author year citation style
    \RequirePackage[natbib,style=gb7714-2015ay,gbctexset=true,%
      % sorting=ydnt,%
      maxcitenames=2,mincitenames=1,%
      sortlocale=zh__pinyin]{biblatex}%
    \DefineBibliographyStrings{english}{
      andincite = {和},
      andincitecn = {和},
      andothersincitecn = {等},
      andothersincite = {等{\adddot}},%adddot才能避开标点追踪
    }
    % superscript page number
    \DeclareFieldFormat{postnote}{#1}
    \DeclareCiteCommand{\parencite}
      {\usebibmacro{cite:init}%
      \renewbibmacro*{postnote}{%
      \iffieldundef{postnote}
        {}
        {\nopunct%
         \printfield{postnote}}}%
        (\usebibmacro{prenote}}%)
      {\usebibmacro{citeindex}%
       \usebibmacro{cite}}
      {}
      {%(
      )\mkbibsuperscript{\usebibmacro{postnote}}}
  \fi
  \let\inlinecite\parencite
  \defbibheading{bibliography}[\bibname]{%
    \ucas@chapter*{\bibname}
  }
  \renewcommand\bibfont{\wuhao[1.5]}
  \setlength{\biblabelsep}{0.4em}
  \setlength{\bibitemsep}{0bp}
\fi
\ifucas@bibtex
  \ifucas@numbers% numbered citation style
    \RequirePackage[sort&compress]{natbib}%
    \bibliographystyle{ucasthesis-numeric}%
  \fi
  \ifucas@authoryear% author year citation style
    \RequirePackage{natbib}%
    \bibliographystyle{ucasthesis-author-year}%
  \fi
  % Set punctuation and mode of citation style
  \expandafter\newcommand\csname bibstyle@ucasthesis-numeric\endcsname{%
    \bibpunct{[}{]}{,}{s}{,}{\textsuperscript{,}}}
  \expandafter\newcommand\csname bibstyle@ucasthesis-author-year\endcsname{%
    \bibpunct{(}{)}{;}{a}{,}{,}}
  \newcommand\bibstyle@inline{\bibpunct{[}{]}{,}{n}{,}{,}}
  \DeclareRobustCommand\inlinecite{\@inlinecite}
  \def\@inlinecite#1{\begingroup\let\@cite\NAT@citenum\citep{#1}\endgroup}
  \def\ucas@bibetal{等{.}}%
  \def\ucas@biband{和}%
  \def\bibetal{\ucas@bibetal}%
  \def\biband{\ucas@biband}%
  \renewcommand\bibsection{\ucas@chapter*{\bibname}}
  \renewcommand\bibfont{\wuhao[1.5]}
  \setlength\bibhang{2\ccwd}
  \setlength{\labelsep}{0.4em}
  \addtolength{\bibsep}{-0.7em}
  \def\@biblabel#1{[#1]\hfill}
  % numberic mode: superscript page number
  \patchcmd\NAT@citexnum{% \citet
    \@ifnum{\NAT@ctype=\z@}{%
      \if*#2*\else\NAT@cmt#2\fi
    }{}%
    \NAT@mbox{\NAT@@close}%
  }{%
    \NAT@mbox{\NAT@@close}%
    \@ifnum{\NAT@ctype=\z@}{%
      \if*#2*\else\textsuperscript{#2}\fi
    }{}%
  }{}{}
  \patchcmd{\NAT@citesuper}{%
    \textsuperscript{\NAT@@open#1\NAT@@close}%
      \if*#3*\else\NAT@spacechar#3\fi
  }{%
    \textsuperscript{\NAT@@open#1\NAT@@close\if*#3*\else#3\fi}
  }{}{}
  % numberical mode: 2 or more consecutive bibliographies connected by -
  \patchcmd{\NAT@citexnum}{%
    \ifx\NAT@last@yr\relax
      \def@NAT@last@yr{\@citea}%
    \else
      \def@NAT@last@yr{--\NAT@penalty}%
    \fi
  }{%
    \def@NAT@last@yr{-\NAT@penalty}%
  }{}{}
  % authoryear mode: superscript page number
  \patchcmd{\NAT@citex}{% \citet
    \if*#2*\else\NAT@cmt#2\fi
    \if\relax\NAT@date\relax\else\NAT@@close\fi
  }{%
    \if\relax\NAT@date\relax\else\NAT@@close\fi
    \if*#2*\else\textsuperscript{#2}\fi
  }{}{}
  \patchcmd{\NAT@cite}{%
    \if*#3*\else\NAT@cmt#3\fi\NAT@@close
  }{%
    \NAT@@close\if*#3*\else\textsuperscript{#3}\fi
  }{}{}
\fi
\RequirePackage{hyperref}
\hypersetup{%
  linktoc            = all,
  bookmarksnumbered  = true,
  bookmarksopen      = true,
  bookmarksopenlevel = 1,
  unicode            = true,
  psdextra           = true,
  breaklinks         = true,
  plainpages         = false,
  hidelinks
}
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
\RequirePackage{notoccite}
\let\ucas@cleardoublepage\cleardoublepage
\newcommand{\ucas@clearemptydoublepage}{%
  \clearpage{\pagestyle{ucas@empty}\ucas@cleardoublepage}}
\let\cleardoublepage\ucas@clearemptydoublepage
\renewcommand\frontmatter{%
  \cleardoublepage
  \@mainmatterfalse
  \pagenumbering{Roman}
  \pagestyle{ucas@headings}}
\renewcommand\mainmatter{%
  \cleardoublepage
  \@mainmattertrue
  \pagenumbering{arabic}
  \pagestyle{ucas@headings}}
\renewcommand\backmatter{%
  \cleardoublepage
  \@mainmattertrue}
\newcommand\ucas@fontset{\csname g__ctex_fontset_tl\endcsname}
\ifthenelse{\equal{\ucas@fontset}{fandol}}{
  \setmainfont[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
  ]{texgyretermes}
  \setsansfont[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
  ]{texgyreheros}
  \setmonofont[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
    Scale          = MatchLowercase,
  ]{texgyrecursor}
}{
  \setmainfont{Times New Roman}
  \setsansfont{Arial}
  \ifthenelse{\equal{\ucas@fontset}{mac}}{
    \setmonofont[Scale=MatchLowercase]{Menlo}
  }{
    \setmonofont[Scale=MatchLowercase]{Courier New}
  }
}
\unimathsetup{
  math-style = ISO,
  bold-style = ISO,
  nabla      = upright,
  partial    = upright,
}
\IfFontExistsTF{XITSMath-Regular.otf}{
  \setmathfont[
    Extension    = .otf,
    BoldFont     = XITSMath-Bold,
    StylisticSet = 8,
  ]{XITSMath-Regular}
  \setmathfont[range={cal,bfcal},StylisticSet=1]{XITSMath-Regular.otf}
}{
  \setmathfont[
    Extension    = .otf,
    BoldFont     = *bold,
    StylisticSet = 8,
  ]{xits-math}
  \setmathfont[range={cal,bfcal},StylisticSet=1]{xits-math.otf}
}
\ifthenelse{\equal{\ucas@fontset}{windows}}{
  \xeCJKsetup{EmboldenFactor=2}
  \IfFileExists{C:/bootfont.bin}{
    \setCJKmainfont[AutoFakeBold,ItalicFont=KaiTi_GB2312]{SimSun}
    \setCJKfamilyfont{zhkai}[AutoFakeBold]{KaiTi_GB2312}
  }{
    \setCJKmainfont[AutoFakeBold,ItalicFont=KaiTi]{SimSun}
    \setCJKfamilyfont{zhkai}[AutoFakeBold]{KaiTi}
  }
  \setCJKsansfont[AutoFakeBold]{SimHei}
  \setCJKfamilyfont{zhsong}[AutoFakeBold]{SimSun}
  \setCJKfamilyfont{zhhei}[AutoFakeBold]{SimHei}
}{}
\ifthenelse{\equal{\ucas@fontset}{mac}}{
  \setCJKmainfont[
         UprightFont = * Light,
            BoldFont = * Bold,
          ItalicFont = Kaiti SC,
      BoldItalicFont = Kaiti SC Bold,
    ]{Songti SC}
  \setCJKsansfont[BoldFont=* Medium]{Heiti SC}
  \setCJKfamilyfont{zhsong}[
         UprightFont = * Light,
            BoldFont = * Bold,
    ]{Songti SC}
  \setCJKfamilyfont{zhhei}[BoldFont=* Medium]{Heiti SC}
  \setCJKfamilyfont{zhkai}[BoldFont=* Bold]{Kaiti SC}
  \xeCJKsetwidth{‘’“”}{1em}
}{}
\renewcommand\normalsize{%
  \@setfontsize\normalsize{12bp}{23.4bp}%根据Word微调
  \abovedisplayskip=6bp \@plus 1bp \@minus 1bp%space above equations
  \abovedisplayshortskip=6bp \@plus 1bp \@minus 1bp%space above short equations
  \belowdisplayskip=6bp \@plus 1bp \@minus 1bp%space below equations
  \belowdisplayshortskip=6bp \@plus 1bp \@minus 1bp}%space below short equations
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
\ctexset{
  chapter/name   = {第,章},
  appendixname   = {附录},
  contentsname   = {目\hspace{\ccwd}录},
  listfigurename = 插图目录,
  listtablename  = 表格目录,
  figurename     = 图,
  tablename      = 表,
  bibname        = 参考文献,
}
\newcommand\ucas@cfigurename{图}
\newcommand\ucas@efigurename{Figure}
\newcommand\ucas@ctablename{表}
\newcommand\ucas@etablename{Table}
\newcommand\ucas@cappendix{附\hspace{\ccwd}录}
\newcommand\ucas@denotation@name{主要符号对照表}
\newcommand\ucas@assumption@name{假设}
\newcommand\ucas@definition@name{定义}
\newcommand\ucas@proposition@name{命题}
\newcommand\ucas@lemma@name{引理}
\newcommand\ucas@theorem@name{定理}
\newcommand\ucas@axiom@name{公理}
\newcommand\ucas@corollary@name{推论}
\newcommand\ucas@exercise@name{练习}
\newcommand\ucas@example@name{例}
\newcommand\ucas@remark@name{注释}
\newcommand\ucas@problem@name{问题}
\newcommand\ucas@conjecture@name{猜想}
\newcommand\ucas@proof@name{证明}
\newcommand\ucas@theorem@separator{：}
\newcommand\ucas@ack@name{致\hspace{\ccwd}谢}
\newcommand\ucas@resume@title{作者简历及攻读学位期间发表的学术论文与研究成果}
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
  \fancyhead[CO]{\xiaowu\leftmark}
  \fancyhead[CE]{\xiaowu\ucas@ctitlemark}
  \fancyfoot{}
  % 根据在论文中的位置设置页脚
  \if@mainmatter% 正文部分及之后
    \fancyfoot[RO]{\xiaowu\thepage}
    \fancyfoot[LE]{\xiaowu\thepage}  
  \else% 摘要至正文部分之前
    \fancyfoot[C]{\xiaowu\thepage}
  \fi
  \renewcommand{\headrulewidth}{0.4pt}
  \renewcommand{\footrulewidth}{0pt}}
\ctexset{%
  punct=quanjiao,
  space=auto,
  autoindent=true}
\setlist{leftmargin=*, nosep}
\setlist[1]{labelindent=\parindent} % Only the level 1
\ifthenelse{\equal{\ucas@fontset}{mac}}{
  \newfontfamily\ucas@circlefont{Songti SC Light}
}{
  \ifthenelse{\equal{\ucas@fontset}{windows}}{
    \newfontfamily\ucas@circlefont{SimSun}
  }{
    \IfFontExistsTF{XITS-Regular.otf}{
      \newfontfamily\ucas@circlefont{XITS-Regular.otf}
    }{
      \newfontfamily\ucas@circlefont{xits-regular.otf}
    }
  }
}
\def\ucas@textcircled#1{%
  \ifnum\value{#1} >9%
    \ClassError{ucasthesis}%
      {Too many footnotes in this page.}{Keep footnote less than 10.}%
  \fi%
  {\ucas@circlefont\symbol{\the\numexpr\value{#1}+"245F\relax}}%
}
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
\def\mathellipsis{\cdots}
\protected\def\le{\leqslant}
\protected\def\ge{\geqslant}
\AtBeginDocument{%
  \renewcommand\leq{\leqslant}%
  \renewcommand\geq{\geqslant}%
}
\removenolimits{%
  \int\iint\iiint\iiiint\oint\oiint\oiiint
  \intclockwise\varointclockwise\ointctrclockwise\sumint
  \intbar\intBar\fint\cirfnint\awint\rppolint
  \scpolint\npolint\pointint\sqint\intlarhk\intx
  \intcap\intcup\upint\lowint
}
\AtBeginDocument{%
  \renewcommand{\Re}{\operatorname{Re}}%
  \renewcommand{\Im}{\operatorname{Im}}%
}
\AtBeginDocument{%
  \renewcommand\nabla{\mbfnabla}%
}
\newcommand\bm{\symbf}
\renewcommand\boldsymbol{\symbf}
\newcommand\square{\mdlgwhtsquare}
\allowdisplaybreaks[4]
\renewcommand\theequation{\ifnum \c@chapter>\z@ \thechapter-\fi\@arabic\c@equation}
\renewcommand{\eqref}[1]{\textup{(\ref{#1})}}
\theorembodyfont{\normalfont}
\theoremheaderfont{\normalfont\sffamily}
\theoremsymbol{\ensuremath{\square}}
\newtheorem*{proof}{\ucas@proof@name}
\theoremstyle{plain}
\theoremsymbol{}
\theoremseparator{\ucas@theorem@separator}
\newtheorem{assumption}{\ucas@assumption@name}[chapter]
\newtheorem{definition}{\ucas@definition@name}[chapter]
\newtheorem{proposition}{\ucas@proposition@name}[chapter]
\newtheorem{lemma}{\ucas@lemma@name}[chapter]
\newtheorem{theorem}{\ucas@theorem@name}[chapter]
\newtheorem{axiom}{\ucas@axiom@name}[chapter]
\newtheorem{corollary}{\ucas@corollary@name}[chapter]
\newtheorem{exercise}{\ucas@exercise@name}[chapter]
\newtheorem{example}{\ucas@example@name}[chapter]
\newtheorem{remark}{\ucas@remark@name}[chapter]
\newtheorem{problem}{\ucas@problem@name}[chapter]
\newtheorem{conjecture}{\ucas@conjecture@name}[chapter]
\setlength{\floatsep}{12bp \@plus2bp \@minus4bp}
\setlength{\intextsep}{12bp}
\setlength{\textfloatsep}{12bp}
\setlength{\@fptop}{0bp \@plus1.0fil}
\setlength{\@fpsep}{12bp \@plus2.0fil}
\setlength{\@fpbot}{0bp \@plus1.0fil}
\renewcommand{\textfraction}{0.15}
\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{0.65}
\renewcommand{\floatpagefraction}{0.60}
\let\old@tabular\@tabular
\def\ucas@tabular{\wuhao[1.5]\old@tabular}
\DeclareCaptionLabelFormat{ucas}{{\bfseries #1~#2}}
\DeclareCaptionLabelSeparator{ucas}{\hspace{\ccwd}}
\DeclareCaptionFormat{ucas}{{\wuhao[1.5]\centering #1#2#3}\par}
\DeclareCaptionOption{bi-first}[]{%
    \def\tablename{\ucas@ctablename}
    \def\figurename{\ucas@cfigurename}
}%bi-first
\DeclareCaptionOption{bi-second}[]{%
    \def\tablename{\ucas@etablename}
    \def\figurename{\ucas@efigurename}
}%bi-second
\captionsetup{labelformat=ucas,labelsep=ucas,format=ucas}
\captionsetup[table]{position=top,belowskip=6bp,aboveskip=6bp}
\captionsetup[figure]{position=bottom,belowskip=12bp,aboveskip=6bp}
\captionsetup{bi-slc=off}
\captionsetup[bi-first]{bi-first}
\captionsetup[bi-second]{bi-second}
\renewcommand{\thesubfigure}{(\alph{subfigure})}
\renewcommand{\thesubtable}{(\alph{subtable})}
\let\ucas@LT@array\LT@array
\def\LT@array{\wuhao[1.5]\ucas@LT@array} % set default font size
\newcommand{\cabstractname}{摘\hspace{\ccwd}要}
\newcommand{\eabstractname}{Abstract}
\let\CJK@todaysave=\today
\def\CJK@todaysmall@short{\the\year 年 \the\month 月}
\def\CJK@todaysmall{\the\year 年 \the\month 月 \the\day 日}
\def\CJK@todaybig@short{\zhdigits{\the\year}年\zhnumber{\the\month}月}
\def\CJK@todaybig{\zhdigits{\the\year}年\zhnumber{\the\month}月\zhnumber{\the\day}日}
\def\CJK@today{\CJK@todaysmall}
\renewcommand\today{\CJK@today}
\newcommand\CJKtoday[1][1]{%
  \ifcase#1\def\CJK@today{\CJK@todaysave}
    \or\def\CJK@today{\CJK@todaysmall}
    \or\def\CJK@today{\CJK@todaybig}
  \fi}
\AtBeginDocument{%
  \pagestyle{ucas@empty}
  \renewcommand{\chaptermark}[1]{\@mkboth{\CTEXthechapter\hskip\ccwd#1}{}}}
\ctexset{%
  chapter={
    afterindent=true,
    pagestyle={ucas@headings},
    beforeskip={9bp},
    aftername=\hskip\ccwd,
    afterskip={18bp},
    format={\centering\bfseries\sffamily\sihao},
    nameformat=\relax,
    numberformat=\relax,
    titleformat=\relax,
  },
  section={
    afterindent=true,
    beforeskip={24bp\@plus 1ex \@minus .2ex},
    afterskip={6bp\@plus .2ex},
    format={\sffamily\xiaosi},
  },
  subsection={
    afterindent=true,
    beforeskip={12bp\@plus 1ex \@minus .2ex},
    afterskip={6bp \@plus .2ex},
    format={\sffamily\xiaosi},
  },
  subsubsection={
    afterindent=true,
    beforeskip={12bp\@plus 1ex \@minus .2ex},
    afterskip={6bp \@plus .2ex},
    format={\sffamily\xiaosi},
  },
  paragraph={
    afterindent=true,
    indent=\parindent,
    beforeskip={6bp\@plus 1ex \@minus .2ex},
    afterskip={6bp \@plus .2ex},
    format={\sffamily\xiaosi},
  },
  subparagraph={
    afterindent=true,
    beforeskip={6bp\@plus 1ex \@minus .2ex},
    afterskip={6bp \@plus .2ex},
    format={\sffamily\xiaosi},
  }}
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
  \@starttoc{toc}\normalsize}
\renewcommand\listoffigures{%
  \cleardoublepage
  \@ifstar
  {\ucas@chapter*[]{\listfigurename}
  \@starttoc{lof}\normalsize}
  {\ucas@chapter*{\listfigurename}\@starttoc{lof}}}
\renewcommand\listoftables{%
  \cleardoublepage
  \@ifstar
  {\ucas@chapter*[]{\listtablename}
  \@starttoc{lot}\normalsize}
  {\ucas@chapter*{\listtablename}\@starttoc{lot}}}
\titlecontents{chapter}[\z@]{\vspace{6bp}\sffamily\sihao[1.25]}
  {{\thecontentslabel}\quad}{}
  {\hspace{.5em}\titlerule*{.}\rmfamily\sihao[1.25]\contentspage}
\titlecontents{section}[\ccwd]{\vspace{6bp}\sffamily\xiaosi[1.25]}
  {\thecontentslabel\quad}{}
  {\hspace{.5em}\titlerule*{.}\rmfamily\xiaosi[1.25]\contentspage}
\titlecontents{subsection}[2\ccwd]{\vspace{6bp}\sffamily\xiaosi[1.25]}
  {\thecontentslabel\quad}{}
  {\hspace{.5em}\titlerule*{.}\rmfamily\xiaosi[1.25]\contentspage}
\titlecontents{figure}[\z@]{\vspace{6bp}\sffamily\xiaosi[1.25]}
  {\makebox[3.5em][l]{\figurename~\thecontentslabel\quad}}{}
  {\hspace{.5em}\titlerule*{.}\rmfamily\xiaosi[1.25]\contentspage}
\titlecontents{table}[\z@]{\vspace{6bp}\sffamily\xiaosi[1.25]}
  {\makebox[3.5em][l]{\tablename~\thecontentslabel\quad}}{}
  {\hspace{.5em}\titlerule*{.}\rmfamily\xiaosi[1.25]\contentspage}
\def\ucas@def@term#1{%
  \define@key{ucas}{#1}{\csname #1\endcsname{##1}}
  \expandafter\gdef\csname #1\endcsname##1{%
    \expandafter\gdef\csname ucas@#1\endcsname{##1}}
  \csname #1\endcsname{}}
\ucas@def@term{secretlevel}
\ucas@def@term{secretyear}
\ucas@def@term{ctitle}
\ucas@def@term{ctitlemark}
\ucas@def@term{etitle}
\ucas@def@term{etitlemark}
\ucas@def@term{cauthor}
\ucas@def@term{csupervisor}
\ucas@def@term{csupervisorplace}
\ucas@def@term{ccosupervisor}
\ucas@def@term{ccosupervisorplace}
\ucas@def@term{eauthor}
\ucas@def@term{esupervisor}
\ucas@def@term{ecosupervisor}
\ucas@def@term{cdegree}
\ucas@def@term{edegree}
\ucas@def@term{cdepartment}
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
\def\ucas@ckeywords@separator{，}
\def\ucas@ekeywords@separator{,}
\def\ucas@title@sep{：}
\def\ucas@secret@title{密级}
\def\ucas@secret@content{\ucas@secretlevel%
          \ $\bigstar$\ \ucas@secretyear 年}
\def\ucas@schoolname{中国科学院大学}
\def\ucas@author@title{作者姓名}
\ifucas@doctor
  \def\ucas@apply{博士学位论文}
\else
  \def\ucas@apply{硕士学位论文}
\fi
\def\ucas@department@title{培养单位}
\def\ucas@major@title{学科专业}
\def\ucas@degree@title{学位类别}
\def\ucas@supervisor@title{指导教师}
\def\ucas@cosuper@title{辅助导师}
% \cdate{\CJK@todaybig@short}
\cdate{\the\year 年 \the\month 月}
\edate{\ifcase \month \or January\or February\or March\or April\or May%
       \or June\or July \or August\or September\or October\or November
       \or December\fi\unskip,\ \ \the\year}
\ackdate{\the\year 年\the\month 月于大连}
\newcommand{\ucas@ckeywords@title}{关键词：}
\newcommand{\ucas@ekeywords@title}{Key words:}
\newcommand{\ucas@declarename}{研究生学位论文原创性声明}
\newcommand{\ucas@declaretext}{本人郑重声明：所呈交的学位论文是本人在导师的指导下独立进行研究工作所取得的成果。尽我所知，除文中已经注明引用的内容外，本论文不包含任何其他个人或集体已经发表或撰写过的研究成果。对论文所涉及的研究工作做出贡献的其他个人和集体，均已在文中以明确方式标明或致谢。}
\newcommand{\ucas@authtitle}{学位论文授权使用声明}
\newcommand{\ucas@authorization}{本人完全了解并同意遵守中国科学院有关保存和使用学位论文的规定，即中国科学院有权保留送交学位论文的副本，允许该论文被查阅，可以按照学术研究公开原则和保护知识产权的原则公布该论文的全部或部分内容，可以采用影印、缩印或其他复制手段保存、汇编本学位论文。}
\newcommand{\ucas@authorizationaddon}{涉密及延迟公开的学位论文在解密或延迟期后适用本声明。}
\newcommand{\ucas@authorsig}{作者签名：}
\newcommand{\ucas@teachersig}{导师签名：}
\newcommand{\ucas@frontdate}{日\hspace{2em}期：}
\newcommand{\ucas@backdate}{日\hspace{2em}期：}
\newcommand{\ucas@signature}{作者签名：}
\newcommand\ucas@underline[2][6em]{\hskip1pt\underline{\hb@xt@ #1{\hss#2\hss}}\hskip3pt}
\newlength{\ucas@title@width}
\newcommand{\ucas@put@title}[2][\ucas@title@width]{%
  \begin{CJKfilltwosides}{#1}#2\end{CJKfilltwosides}}
\newcommand{\ucas@first@titlepage}{
  \begin{center}
    \vspace*{.2cm}
    \parbox[t][1.2cm][t]{\textwidth}{%
      \ifucas@secret\hfill{\sanhao[1]\sffamily
        \textbf{\ucas@secret@title\ucas@title@sep}
        \underline{\makebox[6em]{\ucas@secret@content}}}\fi}
    \begin{center}
      \includegraphics[height=21.59mm]{UCAS}
    \end{center}
    \parbox[t][6cm][t]{\paperwidth-8cm}{\sffamily\bfseries
      \renewcommand{\baselinestretch}{1.5}
      \begin{center}
        \yihao\ucas@apply
        \par\vskip 50bp
        \xiaosan\CJKunderline{\ucas@ctitle}
      \end{center}}
    \parbox[t][10cm][t]{\textwidth}{\sihao\bfseries
      \begin{center}
        \setlength{\ucas@title@width}{4em}
        \setlength{\extrarowheight}{2.5ex}
        \begin{tabular}{ll}
          \ucas@author@title\ucas@title@sep     
            & \underline{\makebox[24em]{\ucas@cauthor}}\\
          \ucas@supervisor@title\ucas@title@sep%
            & \underline{\makebox[24em]{\ucas@csupervisor}}\\
          \ifthenelse{\equal{\ucas@ccosupervisor}{}}{%if-then #1
            & \underline{\makebox[24em]{\ucas@csupervisorplace}}\\}{%if-else #1
            \ifthenelse{\equal{\ucas@ccosupervisorplace}{\ucas@csupervisorplace}
              \or\equal{\ucas@ccosupervisorplace}{}}{%if-then #2
              & \underline{\makebox[24em]{\ucas@ccosupervisor}}\\
              & \underline{\makebox[24em]{\ucas@csupervisorplace}}\\
              }{%if-else #2
              & \underline{\makebox[24em]{\ucas@csupervisorplace}}\\
              & \underline{\makebox[24em]{\ucas@ccosupervisor}}\\
              & \underline{\makebox[24em]{\ucas@ccosupervisorplace}}\\
            }%end if #2
          }%end if #1
          \ucas@degree@title\ucas@title@sep
            & \underline{\makebox[24em]{\ucas@cdegree}}\\
          \ucas@major@title\ucas@title@sep
            & \underline{\makebox[24em]{\ucas@cmajor}}\\
          \ucas@put@title{\ucas@department@title}\ucas@title@sep
            & \underline{\makebox[24em]{\ucas@cdepartment}}\\
        \end{tabular}
      \end{center}}
    \begin{center}
      {\vfill \sihao\bfseries\ucas@cdate}
    \end{center}
  \end{center}} % end of titlepage
\newcommand{\ucas@engcover}{%
  \cleardoublepage
  \thispagestyle{ucas@empty}
  \begin{center}
    \vspace*{1cm}
    \renewcommand{\baselinestretch}{1.5}
    \parbox[t][4.8cm][t]{\textwidth}{\xiaosan\bfseries
      \begin{center}
          \uline{\ucas@etitle}
      \end{center}}
    \vspace{24bp}
    \parbox[t][10.8cm][c]{\textwidth}{\sihao\bfseries
      \begin{center}
        {A \ifucas@master thesis \else dissertation \fi submitted to}\\
        {University of Chinese Academy of Sciences} \\
        {in partial fulfillment of the requirement}\\
        {for the degree of}\\
        {\ucas@edegree}\\
        {\sanhao{in}} {\ucas@emajor}\\
        \par\vskip 12bp
        {\sanhao{By}}\\
        {\ucas@eauthor}\\
        \par\vskip 20bp
        \begin{tabular}{ll}
          {Supervisor: }
            & {\ucas@esupervisor} \\
            \ifthenelse{\equal{\ucas@ecosupervisor}{}}{\relax}{
              & {\ucas@ecosupervisor} \\
            }
        \end{tabular}
      \end{center}}
    \vspace{12bp}
    \parbox[t][3.6cm][b]{\textwidth}{\sihao\bfseries
    \begin{center}
      {\ucas@edepartment}
      \par\vskip 12bp
      {\ucas@edate}
    \end{center}}
  \end{center}}
\newcommand{\ucas@authorization@mk}{%
  \thispagestyle{ucas@empty}
  \vspace*{0.42cm}
  \begin{center}
      \sihao[2.0]\sffamily\bfseries
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
      \sihao[2.0]\sffamily\bfseries
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
    \ifucas@mkshuji\ucas@shuji\fi
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
  \ucas@put@keywords{\bfseries\ucas@ckeywords@title}{\ucas@ckeywords}
  \cleardoublepage
  \fancyhead[CE]{\xiaowu\ucas@etitlemark}
  \ucas@chapter*[]{\eabstractname} % no tocline
  \ucas@eabstract
  \vskip12bp
  \ucas@put@keywords{%
    \textbf{\ucas@ekeywords@title\enskip}}{\ucas@ekeywords}
  \pagestyle{ucas@headings}}
% use nomenclature instead
\newenvironment{denotation}[1][2.5cm]{%
  \cleardoublepage
  \ucas@chapter*[1]{\ucas@denotation@name} % with tocline
  \vskip-30bp\begin{ucas@denotation}[labelwidth=#1]
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
\newenvironment{nomenclature}[1][\ucas@denotation@name]{%
  \cleardoublepage
  \ucas@chapter*[]{#1}}{}
\newcommand{\nomenclaturesection}[1]{%
  \vspace{24bp}{\xiaosi\bfseries\flushleft{#1}}\par\vspace{6bp}}
\providecommand{\nomenclatureitem}[3][ ]{%
    \noindent\makebox[0.15\textwidth][l]{#2}{{#3}\hfill{#1}}\par
}
\NewDocumentEnvironment{acknowledgement}{o}{%
    \cleardoublepage
    \ucas@chapter*{\ucas@ack@name}
  }{\vskip 48bp\hfill\ucas@ackdate}
\let\ack\acknowledgement
\let\endack\endacknowledgement
\let\ucas@appendix\appendix
\renewenvironment{appendix}{%
  \cleardoublepage
  \ucas@appendix}{}
\newcommand{\setleftmark}[1]{\@mkboth{#1}{}}
\newenvironment{resume}[1][\ucas@resume@title]{%
  \cleardoublepage
  \ucas@chapter*{#1}}{}
\newcommand{\resumeitem}[1]{%
  \vspace{24bp}{\xiaosi\bfseries\flushleft{#1}}\par\vspace{6bp}}
\newcommand{\researchitem}[1]{%
  \vspace{24bp}{\xiaosi\bfseries\flushleft{#1}}\par\vspace{6bp}}
\newlist{publications}{enumerate}{1}
\setlist[publications]{label=[\arabic*],align=left,nosep,itemsep=8bp,
  labelindent=0pt,leftmargin=10mm,labelsep=!,before=\xiaosi[1.26],resume}
\newlist{achievements}{enumerate}{1}
\setlist[achievements]{label=[\arabic*],align=left,nosep,itemsep=8bp,
  labelindent=0pt,leftmargin=10mm,labelsep=!,before=\xiaosi[1.26]}
\def\publicationskip{\bigskip\bigskip}
% TODO: not tested
% \newcommand\ucas@atendpackage{\csname ctex_at_end_package:nn\endcsname}
% \ucas@atendpackage{nomencl}{
%   \let\nomname\ucas@denotation@name
%   \def\thenomenclature{\begin{denotation}[\nom@tempdim]}
%   \def\endthenomenclature{\end{denotation}}
% }
\ifucas@mkshuji
  \newCJKfontfamily[notosf]\notosf{Noto Sans CJK SC}
  \NewDocumentCommand{\ucas@shuji}%
    {O{\ucas@ctitle} O{\ucas@cauthor} O{\ucas@schoolname}}{%
    \cleardoublepage\thispagestyle{empty}{%
      \notosf\addCJKfontfeatures*{RawFeature={vertical:}}%
      \xiaosi\bfseries\ziju{0.2}%
      \noindent\hfill\rotatebox[origin=lt]{-90}{%
        \makebox[\textheight]{%
          \hspace*{.5cm}#1\hfill#2\hfill#3\hspace*{.5cm}}
      }\hfill}
  }
\fi
\AtEndOfClass{\sloppy}
\endinput
%%
%% End of file `ucasthesis.cls'.
