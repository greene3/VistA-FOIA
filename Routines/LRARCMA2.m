LRARCMA2 ;DALISC/CKA - ARCHIVED WKLD REPORT BY MAJOR SECTION; 6/1/95
 ;;5.2;LAB SERVICE;**59**;Aug 31, 1995
 ;same as LRCAPMA2 except archived wkld file
EN ;
TOP ;
 N LRCCNT,LRICNT,LROCNT,LRNCNT,LRACNT,LRCST,LRIST,LROST,LRNST,LRAST
 S LRHDR="ARCHIVED WORKLOAD STATISTICS BY MAJOR SECTION"
 S LRHDR2="REPORT DATE RANGE:  "_LRDT1_" - "_LRDT2
 D PRTINIT^LRARCU
 S LRAGT=0
 S LRGTREC=$G(^TMP("LRAR-WL",$J,0))
 I $L(LRGTREC) D
 . S LRAGT=+$P(LRGTREC,U)
 I $E(IOST,1,2)="C-" W @IOF
 D:'LRSUMM DET
 D:'LREND SUM^LRARCMA3
 D:'LREND PRNTMAN^LRARCMR1
 D:'LREND COMM^LRARCMR2
 Q
DET ;Detailed section
 F LRLDIV="AP","CP" D  Q:LREND
 . S LRHDR3=$S(LRLDIV="AP":"ANATOMIC PATHOLOGY",1:"CLINICAL PATHOLOGY")
 . S LRIN=0
 . F  S LRIN=$O(^TMP("LRAR-WL",$J,"DIV",LRLDIV,LRIN)) Q:('LRIN)!(LREND)  D
 . . S LRINN=$S($L($G(^LAR(64.19999,LRIN,0))):$P(^(0),U),1:LRIN)
 . . S LRIAGT=0
 . . S LRGTREC=$G(^TMP("LRAR-WL",$J,"DIV",LRLDIV,LRIN,0))
 . . I $L(LRGTREC) D
 . . . S LRIAGT=+$P(LRGTREC,U)
 . . D PRTDET
 . . D:('LREND)&(LRIAGT) INSTSUM
 Q
PRTDET ;Print details
 D HDR^LRARCU
 W !,?(80-$L(LRINN)\2),LRINN,!
 S LRMAA=0
 F  S LRMAA=$O(^TMP("LRAR-WL",$J,"DIV",LRLDIV,LRIN,LRMAA)) Q:(LRMAA="")!($G(LREND))  D
 . S LRLSSA=""
 . F  S LRLSSA=$O(^TMP("LRAR-WL",$J,"DIV",LRLDIV,LRIN,LRMAA,LRLSSA)) Q:(LRLSSA="")!($G(LREND))  D LSS
 Q:LREND
 I $Y>(IOSL-5) D NPG^LRARCU Q:LREND  W !,?(80-$L(LRINN)\2),LRINN,!!
 I 'LRIAGT D
 . W !!!,"NO DATA FOR THIS INSTITUTION AND DATE RANGE",!
 E  D
 . W !!!,"GRAND TOTAL",?43,$J(LRIAGT,7)
 D:($E(IOST,1,2)="C-")&('LREND) PAUSE^LRARCU W @IOF
 Q
INSTSUM ;
 S LRLAB="!!,?(80-7\2),""SUMMARY"",!,?(80-$L(LRINN)\2),LRINN,!!,""MAJOR SECTION"",?15,""LAB SUBSECTION"",?43,""  TOTAL"",!"
 D HDR^LRARCU W @LRLAB
 S LRMAA=""
 F  S LRMAA=$O(^TMP("LRAR-WL",$J,"DIV",LRLDIV,LRIN,LRMAA)) Q:(LRMAA="")!(LREND)  D
 . S LRLSSA=""
 . F  S LRLSSA=$O(^TMP("LRAR-WL",$J,"DIV",LRLDIV,LRIN,LRMAA,LRLSSA)) Q:(LRLSSA="")!(LREND)  D PSUM
 I $Y>(IOSL-4) D NPG^LRARCU Q:LREND  W @LRLAB
 W !!,"GRAND TOTAL",?43,$J(LRIAGT,7)
 D:($E(IOST,1,2)="C-")&('LREND) PAUSE^LRARCU W @IOF
 Q
PSUM ;
 Q:LREND
 Q:'$D(^TMP("LRAR-WL",$J,"DIV",LRLDIV,LRIN,LRMAA,LRLSSA,0))#2  S LRX=^(0)
 I $Y>(IOSL-3) D NPG^LRARCU Q:LREND  W @LRLAB
 S LRACNT=$P(LRX,U)
 W !,$E(LRMAN(LRMAA),1,14),?15,$E(LRLSSN(LRLSSA),1,14),?31,"NUMBER  :"
 W ?43,$J(LRACNT,7)
 W !,?31,"PERCENT :"
 W ?43,$J($S(LRIAGT:LRACNT/LRIAGT,1:0)*100,7,1)
 W !
 Q
LSS ;
 S LRLAB="!!,""MAJOR SECTION:  "",LRMAN(LRMAA),!,""LAB SUBSECTION:  "",LRLSSN(LRLSSA),!!,""CODE"",?11,""PROCEDURE"",?43,""  TOTAL"",!"
 I $Y>(IOSL-7) D NPG^LRARCU Q:LREND  W !,?(80-$L(LRINN)\2),LRINN,!
 W @LRLAB
 S (LRAST,LRCC)=0
 F  S LRCC=$O(^TMP("LRAR-WL",$J,"DIV",LRLDIV,LRIN,LRMAA,LRLSSA,LRCC)) Q:(LRCC="")!(LREND)  D PCC
 Q:LREND
 S LRX=$G(^TMP("LRAR-WL",$J,"DIV",LRLDIV,LRIN,LRMAA,LRLSSA,0))
 S LRAST=+$P(LRX,U)
 I $Y+4>IOSL D NPG^LRARCU Q:LREND  W !,?(80-$L(LRINN)\2),LRINN,!,@LRLAB
 W !,?11,"SUB TOTAL",?43,$J(LRAST,7),!
 Q
PCC ;
 S LRX=$G(^TMP("LRAR-WL",$J,"DIV",LRLDIV,LRIN,LRMAA,LRLSSA,LRCC))
 I $Y+3>IOSL D NPG^LRARCU Q:LREND  W !,?(80-$L(LRINN)\2),LRINN,!,@LRLAB
 S LRACNT=+$P(LRX,U)
 W $P(LRX,U,2),?11,$E(LRCC,1,30),?43,$J(LRACNT,7),!
 Q