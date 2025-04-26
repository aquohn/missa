% missa.cls
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{missa}

% Load article class
\LoadClass[11pt]{article}

% Packages
\RequirePackage{xkeyval}
\RequirePackage[a5paper]{geometry}[2010-02-12] % I have to declare a page format: why?
\RequirePackage{color}
\RequirePackage{pict2e}[2009/06/01] % for response sign
\RequirePackage{bbding} % for cross
\RequirePackage[jerusalem]{bibleref}
\RequirePackage{verse}
% \RequirePackage[staffsize=15.87,between-system-space=16]{lilypond}
\RequirePackage{fixltx2e} % for \MakeRobust
\RequirePackage{bbding} % for cross
\RequirePackage{adforn} % for ornament break
\RequirePackage{iflang} % for checking language
\RequirePackage{parskip} % for setting space between paragraphs
\RequirePackage{array} % for better tables

% New colours
\definecolor{DartmouthGreen}{rgb}{0,0.4392,0.2353} % RGB (0, 112, 60)
\definecolor{Violet}{rgb}{0.498,0,1} % RGB (127, 0, 255)
\definecolor{ClassicRose}{rgb}{0.9843,0.8,0.9059} % RGB (251, 204, 231)

% Internal commands
\newcommand{\missa@style}{leaflet} % default style
\newcommand{\missa@litcolor}{DartmouthGreen} % liturgical colour
\newcommand{\missa@titlecolor}{white} % title colour
\newcommand{\missa@rite}{roman} % rite

% Response sign
\newcommand{\Response}{{%
\setbox0\hbox{R}
\unitlength\ht0
\picture(0,0)\linethickness{.075\unitlength}
\polyline(0.2,-0.3)(.7,1.2)(0.2,1.35)
\endpicture\box0}}

% Ornament break
\newcommand{\ornamentbreak}{%
    \begin{center}
    \textcolor{\missa@litcolor}{\adforn{21}\adforn{10}\adforn{49}}
    \end{center}%
}

% \makecolorbox and \framecolorbox
\RequirePackage{calc}
\DeclareDocumentCommand\makecolorbox{o m O{\width} O{c} m}{%
  \IfNoValueTF{#1}{\colorbox{#2}}{\colorbox[#1]{#2}}%
    {\makebox[#3][#4]{#5}}}
\DeclareDocumentCommand\framecolorbox{o m m O{\width} O{c} m}{%
  \IfNoValueTF{#1}{\fcolorbox{#2}{#3}}{\fcolorbox[#1]{#2}{#3}}%
    {\makebox[#4][#5]{#6}}}

% Options
\DeclareOptionX{leaflet}{}
\DeclareOptionX{booklet}{\renewcommand{\missa@style}{booklet}}
\DeclareOptionX{biblerefstyle}[jerusalem]{\biblerefstyle{#1}}

\define@choicekey+{missa.cls}{litcolor}[\val\nr]{%
green,violet,white,red,rose,black}[green]{%
  \ifcase\nr\relax
    \renewcommand{\missa@litcolor}{DartmouthGreen}
  \or
    \renewcommand{\missa@litcolor}{Violet}
  \or
    \renewcommand{\missa@litcolor}{#1}
    \renewcommand{\missa@titlecolor}{black}
  \or
    \renewcommand{\missa@litcolor}{#1}
  \or
    \renewcommand{\missa@litcolor}{ClassicRose}
    \renewcommand{\missa@titlecolor}{black}
  \or
    \renewcommand{\missa@litcolor}{#1}
  \fi
}{%
  \ClassWarning{missa}{erroneous input ignored}%
}

\define@choicekey+{missa.cls}{rite}{roman,ambrosian}[roman]{%
  \renewcommand{\missa@rite}{#1}
}{%
  \ClassWarning{missa}{erroneous input ignored}%
}

\ProcessOptionsX

\newcommand{\lit}[3]{\IfLanguageName{italian}{#1}{\IfLanguageName{english}{#2}{#3}}}
% TODO fix this
\newcommand{\nlvcmd}[2]{%
  \makeatletter
  \expandafter\newcommand{\csname #1 \endcsname}{\@ifstar{\csname #1@star \endcsname}{\csname #1@nostar \endcsname}}
  \expandafter\newcommand{\csname #1@nostar \endcsname}{#2\\}
  \expandafter\newcommand{\csname #1@star \endcsname}{#2}
  \makeatother
}

% Commands
\MakeRobust{\bibleverse}
\MakeRobust{\footnote}
\MakeRobust{\linebreak}

\DeclareRobustCommand\put@reference[1]{%
  {\unskip\nobreak\hfil\penalty50 \hspace{2em}\null\nobreak\hfil
   \mbox{\color{black}\normalfont\reference{#1}}%
   \parfillskip=0pt \par}}
\newcommand{\moment}[2][]{\subsection{#2\put@reference{#1}}}

\newcommand{\rmpart}[2]{
  \setlength{\tabcolsep}{0em}
  \begin{tabular}{p{0.2\linewidth}@{\hspace{0.05\linewidth}}p{0.75\linewidth}}
    {\color{\missa@litcolor} #1} & #2
  \end{tabular}
}
\newcommand{\bfpart}[2]{\rmpart{#1}{{\bfseries#2}}}

\newcommand{\priest}[2][\lit{S}{P}{S}:]{\rmpart{#1}{#2}}
\newcommand{\all}[2][\lit{T}{A}{O}:]{\bfpart{#1}{#2}}
\newcommand{\lector}[2][\lit{L}{L}{L}:]{\rmpart{#1}{#2}}
\newcommand{\response}[1]{\bfpart{\R}{#1}}

% Long form
\newcommand{\Priest}[2][\lit{Sacerdote}{Priest}{Sacerdos}:]{\rmpart{#1}{#2}}
\newcommand{\All}[2][\lit{Tutti}{All}{Omnes}:]{\bfpart{#1}{#2}}
\newcommand{\Commentator}[2][\lit{Commentatore}{Commentator}{Commentator}:]{\rmpart{#1}{#2}}
\newcommand{\Lector}[2][\lit{L}{Lector}{L}:]{\rmpart{#1}{#2}} % TODO
\newcommand{\Cantor}[2][\lit{C}{Cantor}{C}:]{\rmpart{#1}{#2}} % TODO

% Matrimony
\newcommand{\bride}[2][\lit{Sposa}{Bride}{Sponsa}:]{\bfpart{#1}{#2}}
\newcommand{\groom}[2][\lit{Sposo}{Groom}{Sponso}:]{\bfpart{#1}{#2}}
\newcommand{\spouses}[2][\lit{Sposi}{Spouses}{Sponsi}:]{\bfpart{#1}{#2}}

% Baptism
\newcommand{\parents}[2][\lit{Genitori}{Parents}{Parentes}:]{\bfpart{#1}{#2}}
\newcommand{\godparents}[2][\lit{Padrini}{Godparents}{Patrini}:]{\bfpart{#1}{#2}}
\newcommand{\pandg}[2][\lit{Genitori e padrini}{Parents and godparents}{Parentes et patrini}:]{\bfpart{#1}{#2}}

\newcommand{\infshs}{\lit{Nel nome del Padre, del Figlio e dello Spirito~Santo.}{In the name of the Father, and of the Son, and of the Holy Spirit.}{In nomine Patris et Filii et Spiritus Sancti.}}
\newcommand{\tlbwy}{\lit{Il Signore sia con voi.}{The Lord be with you.}{Dominus vobiscum.}}
\newcommand{\aawy}{\lit{E con il tuo spirito.}{And with your spirit.}{Et cum spirito tuo.}}
\newcommand{\luyh}{\lit{In alto i nostri cuori.}{Lift up your hearts.}{Sursum corda.}}
\newcommand{\wltuthl}{\lit{Sono rivolti al Signore.}{We lift them up to the Lord.}{Habemus ad Dominum.}}
\newcommand{\lugtttlog}{\lit{Rendiamo grazie al Signore nostro Dio.}{Let us give thanks to the Lord, our God.}{Gratias agamus Domino Deo nostro.}}
\newcommand{\iiraj}{\lit{\`{E} cosa buona giusta.}{It is right and just.}{Dignum et justum est.}}
\newcommand{\amen}{Amen.}
\newcommand{\kyrie}{Kyrie, el\'eison.}
\newcommand{\threekyrie}{Kyrie el\'eison, Kyrie el\'eison, Kyrie el\'eison.}
\newcommand{\christe}{Christe, el\'eison.}
\newcommand{\alleluia}{Alleluia.}
\newcommand{\lup}{\lit{Preghiamo.}{Let us pray.}{Oremus.}}
\newcommand{\twotl}{\lit{Parola di Dio.}{The Word of the Lord.}{Verbum Domini.}}
\newcommand{\tbtg}[1][.]{\lit{Rendiamo grazie a Dio#1}{Thanks be to God#1}{Deo gratias#1}}
\newcommand{\gtyl}{\lit{Gloria a te, o Signore.}{Glory to you, O Lord.}{Gloria tibi Domine.}}
\newcommand{\tgotl}{\lit{Parola del Signore.}{The Gospel of the Lord.}{Verbum Domini.}}
\newcommand{\ptyljc}{\lit{Lode a te, o Cristo.}{Praise to you, Lord Jesus Christ.}{Laus tibi, Christe.}}
\newcommand{\tcol}{\lit{Per Cristo nostro Signore.}{Through Christ our Lord.}{Per Christum Dominum nostrum.}}

\newcommand{\intercession}[2][\lit{prega per noi}{pray for us}{ora pro nobis}.]{{#2, \hfill \textbf{#1}}\\}
\newcommand{\antiphon}[1]{{\color{\missa@litcolor}\textbf{\lit{Ant.}{Ant.}{Ant.}}} \textbf{#1}}
\newcommand{\blessing}{\lit{Vi benedica Dio onnipotente, Padre e Figlio \cross{} e Spirito~Santo.}{May almighty God bless you, the Father, and the Son, \cross{} and the Holy~Spirit.}{Benedicat vos omnipotens Deus, Pater, et Filius, \cross{} et Spritus~Sanctus.}}

\newcommand{\gloria}{\input{prayers/gloria.tex}}
\newcommand{\creed}[1][1]{\input{prayers/creed#1.tex}}
\newcommand{\sanctus}{\input{prayers/sanctus.tex}}
\newcommand{\sanctusla}{\input{prayers/sanctus-la.tex}}
\newcommand{\ourfather}{\input{prayers/ourfather.tex}}

\newcommand{\reading}[1][]{\input{readings/reading#1.tex}}
\newcommand{\gospel}[1][]{\input{readings/gospel#1.tex}}

\newcommand{\summary}[1]{{\color{\missa@litcolor}\footnotesize#1}}
\newcommand{\commentary}[1]{{\footnotesize\itshape#1}}

\newcommand{\silence}{{\color{\missa@litcolor}\footnotesize(\textit{\lit{Pausa~di~silenzio}{A~pause~of~silence}{Pausa~silentii}})}}
\newcommand{\otherwise}{{\color{\missa@litcolor}\footnotesize\itshape \lit{Oppure}{Otherwise}{Alioquin}:}}
\newcommand{\afterwards}{{\color{\missa@litcolor}\footnotesize\itshape \lit{A seguire}{Afterwards}{Postea}:}}
\newcommand{\petitions}{{\color{\missa@litcolor}\footnotesize(\textit{\lit{Altre~intenzioni}{Other~intentions}{Aliae~intentiones}})}}

\newcommand{\R}{{\bfseries\Response}}
\newcommand{\cross}{{\color{\missa@litcolor}\CrossMaltese}}

\newcommand{\reference}[1]{{\normalfont\footnotesize#1}}

\renewcommand{\thefootnote}{\fnsymbol{footnote}}

% Environments
\setlength{\leftmargini}{0pt}
\newenvironment{lyrics}
  {\setlength{\vindent}{2em}
    \begin{verse}
  }
  {\end{verse}}

\newenvironment{singing}
  {\setlength{\vindent}{2em}\bfseries
    \begin{verse}
  }
  {\end{verse}}


\newenvironment{refrain}
  {\setlength{\leftmargini}{2em}
    \setlength{\vleftskip}{1em}
    \itshape
    \begin{verse}
    \flagverse{\R}
  }
  {\end{verse}
    \setlength{\leftmargini}{0pt}
  }

\newenvironment{dedication}
  {\null\vspace{\stretch{1}}
    \begin{flushright}
    \itshape
  }
  {\end{flushright}
    \vspace{\stretch{2}}\null
  }

% Input style
\RequirePackage{missa\missa@style}

% Paragraphs: no indent
\setlength{\parindent}{0pt}
\addtolength{\parskip}{0.4ex plus 0.1ex minus 0.1ex}
