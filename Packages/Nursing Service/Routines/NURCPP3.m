NURCPP3 ;HIRMFO/JH/RM-NURSING CARE PLAN DATA OUTPUT  part 3 ;1/11/92
 ;;4.0;NURSING SERVICE;;Apr 25, 1997
 ; This is the Patient Problem Listing,Data Processor,Output Routine
 ;
GETOUPT ;Print Patient Care Plan Data and Affiliated Dates.
 S NURSISW=0,ANS="" D HEADER,PRINT Q:NURSOUT  S NURSISW=2 D HEADER
 Q
PRINT W ! F NURSO=0:0 S NURSO=$O(^TMP($J,"NURSDATA",NURSO)) Q:NURSO'>0  S NURSA=$S($D(^TMP($J,"NURSDATA",NURSO)):^TMP($J,"NURSDATA",NURSO),1:"") D:NURSISW CHKLINE Q:NURSOUT  W !,NURSA S NURSLCNT=NURSLCNT+1,NURSSP=1,NURSISW=1
 Q
CHKLINE D HEADER:NURSLCNT>NURSIOSL Q
 ;
HEADER I NURSISW=2 S NURSEND=IOSL-9 F X=NURSLCNT:1:NURSEND W !
 I NURSISW W !!,$E(NURSLIN("-"),1,80),!,NURSMED F I=0:0 S I=$O(NURSALGR(I)) Q:I'>0  W !,NURSALGR(I)
 I NURSISW F K=0:0 S K=$O(NURCLEG(K)) Q:K'>0  W !,NURCLEG(K)
 I NURSISW W !,NURSHED,?65,"["_NURSPLN_"]",?69,"VAF 10-0043",! Q:NURSISW=2
 Q:NURSISW=2  I NURSISW,$E(IOST)="C" R !,"Press return to continue or ""^"" to exit: ",ANS:DTIME I ANS="^"!(ANS="^^")!'$T S NURSOUT=1 S:ANS="^^" GMRGOUT=1 Q
 I NURSISW'=2 W @IOF,!,NURSDAT,?(IOM/2-($L(NURSTITL)/2+($L(NURSTITL)#2)\1)),NURSTITL,?71,"PAGE ",NURSPAG
 I  W:NURSPAG=1&NURSERR !,NURSERR(1),!,NURSERR(2),!,NURSERR(1) W !,$E(NURSLIN("-"),1,80),!,NURSH4,"Date       R.N." S NURSPAG=NURSPAG+1,NURSLCNT=5+$S(NURSERR:3,1:0)
 Q
SPACES S NURSP3=" "
 S NURSP1=" ",NURSP2=" ",NURSP3=" ",NURSH1=" ",NURSH2=" ",NURSH3=" ",NURSH4=$E(NURSSS,1,60),NURSH5=$E(NURSSS,1,10),NURSH6="",NURSH7=$E(NURSSS,1,28) Q