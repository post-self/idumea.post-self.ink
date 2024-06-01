\version "2.24.1"

% The Sacred Harp book uses an older British/French bass clef.
% Source: https://lilypond.miraheze.org/wiki/Alten_Bassschl%C3%BCssel_erstellen
alt-clef =
#(ly:make-stencil
  '(path 0.001
     (moveto   -0.10  -0.35
       curveto  -0.10  -1.11   0.48  -1.80   1.25  -1.80
       curveto   1.75  -1.80   2.20  -1.60   2.50  -1.05
       curveto   2.55  -0.95   2.50  -0.90   2.43  -0.95
       curveto   2.20  -1.17   1.90  -1.48   1.45  -1.48
       curveto   0.70  -1.48   0.15  -0.85   0.15  -0.15
       curveto   0.15   0.45   0.62   0.83   1.05   0.83
       curveto   1.55   0.83   1.90   0.50   1.90   0.05
       curveto   1.90  -0.35   1.55  -0.71   1.20  -0.71
       curveto   0.80  -0.71   0.60  -0.40   0.63  -0.17
       curveto   0.75  -0.30   0.90  -0.31   1.00  -0.31
       curveto   1.20  -0.31   1.38  -0.10   1.38   0.15
       curveto   1.38   0.35   1.20   0.55   0.95   0.55
       curveto   0.60   0.52   0.39   0.25   0.39  -0.05
       curveto   0.39  -0.52   0.62  -0.89   1.20  -0.89
       curveto   1.65  -0.89   2.07  -0.50   2.07   0.10
       curveto   2.07   0.66   1.56   1.01   1.05   1.01
       curveto   0.28   1.01  -0.10   0.35  -0.10  -0.35
       moveto    2.42   0.20
       curveto   2.54   0.20   2.64   0.30   2.64   0.42
       curveto   2.64   0.54   2.54   0.64   2.42   0.64
       curveto   2.30   0.64   2.20   0.54   2.20   0.42
       curveto   2.20   0.30   2.30   0.20   2.42   0.20
       moveto    2.42  -0.20
       curveto   2.54  -0.20   2.64  -0.30   2.64  -0.42
       curveto   2.64  -0.54   2.54  -0.64   2.42  -0.64
       curveto   2.30  -0.64   2.20  -0.54   2.20  -0.42
       curveto   2.20  -0.30   2.30  -0.20   2.42  -0.20
       closepath)
     round round #t)
  (cons -0.1 2.65)
  (cons -1.3 1))

\header {
  subtitle = \markup {
    \column {
      \fill-line {
        \line { \null }
        \center-column { \huge \sans  "IDUMEA.   C.M."}
        \line { \huge \sans "77" }
      }
      \fill-line {
        \line \raise #1 { \teeny \normal-text "“A time to be born and a time to die.” — " \teeny \normal-text \smallCaps "Eccl. 3:2" }
      }
    }
  }
  tagline = ##f
  composer = \markup { \small "A. Davidson, 1817." }
  poet = \markup { \small "Chas. Wesley, 1753.    Key of A Minor." }
}

#(set! paper-alist (cons '("trade" . (cons (* 5.5 in) (* 8.5 in))) paper-alist))
\paper  {
  #(define fonts
    (make-pango-font-tree "Gentium Book Plus"
                          "Gotu"
                          "Ubuntu Mono"
                          (/ staff-height pt 20)))
  #(set-paper-size "trade")
  
  indent = 0.0
    
  % Print
  left-margin = 0.75\in
  right-margin = 0.5\in
  top-margin = 1.1\in

  
  % Web
  %top-margin = 0\in
  %left-margin = 0\in
  %right-margin = 0\in
  %bottom-margin = 0\in
}

\layout {
  #(layout-set-staff-size 13.5)
  \context {
    \Score
    \override Clef.stencil =
    #(lambda (grob)
       (let* ((sz (ly:grob-property grob 'font-size 0))
              (mlt (magstep sz))
              (glyph (ly:grob-property grob 'glyph-name)))
         (cond
          ((equal? glyph "clefs.F")
           (ly:stencil-scale alt-clef (* .63 mlt) (* .63 mlt)))
          ((equal? glyph "clefs.F_change")
           (ly:stencil-scale alt-clef (* .8 mlt) (* .8 mlt)))
          (else (ly:clef::print grob)))))
    \omit BarNumber
  }
  \context {
    \Lyrics
    \override LyricText.font-name = #"Gentium Book Plus"
  }
}

% Global settings
global = {
  \key c \major
  \time 3/2
  \sacredHarpHeads
}

% Music
sopranonotes = \relative c'' {
  r1 c2 e1 d2 c1 d2 e1 e2 d1 e4( d) e1 d4( c) a1 % \bar ".|:" % Simplifying...
  a2 c1  c4(b) a1 c4( d) e1 b4( a) g1 g'2 e1 e4( d)  c1 d2 e1. \bar "|."
} 


altonotes = \relative c'' {
  r1 a2 c1 b4( a) g1 g2 a1 c2 b1 a4( b) c1 b4( g) c1 
  c2 g1 a4( b) c1 g2 c1 e,2 g1 c2 c1 g4( f) e1 g2 e1.
}

tenornotes = \relative c'' {
  r1 a2 a1 g4( a) c1 d4( c) a1 e'2 g1 e4( b) c1 d2 e1 
  e2 g1 e4( d) e1 d4( c) a1 g4( e) g1 g2 a1 g4( a) c1 d4( c) a1.
} 

bassnotes = {
  \clef bass
  r1 a2 a1 d2 e1 e2 a,1 a2 g1 c'4( b) a1 g2 c1
  a2 g1 a4( b) a1 e2 a,1 c2 g1 c2 a,1 c4(d) e1 e2 a1.
}

% Lyrics
lyricsone = {
  \lyricmode {
    \set stanza = "1." And am I born to die? To lay this bod -- y __ down!
    And must my __ trem -- bling spir -- it __ fly  in -- to a  __ world un -- known?
  }
}
lyricstwo = {
  \lyricmode {
    \set stanza = "2." A land of deep -- est shade; Un -- pierced by __ hu -- man __ thought.
    The drear -- y __ re -- gions __ of the __ dead, Where all things __ are for -- got.
    
  }
}
lyricsthree = {
  \lyricmode {
    \set stanza = "3." Soon as from __ earth I __ go, What will be -- come of __ me?
    E -- ter -- nal  __ hap -- pi -- ness or __ woe Must then my __ por -- tion __ be.
    
  }
} 
lyricsfour = {
  \lyricmode {
    \set stanza = "4." Waked by the __ trum -- pet __ sound, I from my -- grave will rise
    And see the __ judge with __ glo -- ry __ crowned, and see the __ flam -- ing __ skies.
  }
}


% Put it all together
\score {
  <<
    \new Staff <<
      \new Voice = "soprano" <<
        \global
        \sopranonotes 
      >>
      \new Lyrics \lyricsto "soprano" \lyricsone
    >>
    
    \new Staff = "altostaff" <<
      \new Voice = "alto" <<
        \global
        \altonotes
      >>
      \new Lyrics \with { alignAboveContext = "altostaff" } \lyricsto "alto" \lyricstwo
    >>
    
    \new Staff <<
      \new Voice = "tenor" <<
        \global
        \tenornotes
      >>
      \new Lyrics \lyricsto "tenor" \lyricsthree
    >>
    
    \new Staff = "bassstaff" <<
      \new Voice = "bass" <<
        \global
        \bassnotes
      >>
      \new Lyrics \with { alignAboveContext = "bassstaff" }  \lyricsto "bass" \lyricsfour
    >>
  >>
}