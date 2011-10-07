PRCHG1 ;SF-ISC/TKW-PROCESS ALL ISSUE BOOK ORDERS PENDING PPM ACCOUNTABLE OFFICERS PROC/SIG--CALLED FROM PRCHG ;1/25/93  13:16
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN W ! S %A="PROCESS ISSUE BOOK ORDERS",%B="If you answer 'YES', this function will loop all through all Issue Book Requests",%B(1)="that are pending PPM processing, and will automatically set them to the status"
 S %B(2)="'Assigned to PPM Clerk', so that LOG code sheets can be generated by the",%B(3)="Requirements Analyst (R/A).",%=2 D YN^PRCFYN Q:%'=1
 W !!,$C(7),"Processing Issue Book Orders--Please Wait!",!!
 F DA=0:0 S DA=$O(^PRC(443,"AC",60,DA)) Q:'DA  I $D(^PRCS(410,DA,0)),$P(^(0),U,4)=5,+^(0)=PRC("SITE") D PROISS
 G Q
 ;
QQ S:'$D(ROUTINE) ROUTINE=$T(+0) W !!,$$ERR^PRCHQQ(ROUTINE,PRCSIG) W:PRCSIG=0!(PRCSIG=-3) !,"Notify Application Coordinator!",$C(7) S DIR(0)="EAO",DIR("A")="Press <return> to continue" D ^DIR
 ;
Q K PRCHES,DA,DIE,DR,ROUTINE
 Q
 ;
PROISS ;W "Transaction No.: "_$S($D(^PRCS(410,DA,0)):$P(^(0),U,1),1:""),!
 W "Transaction No.: "_$P($G(^PRCS(410,DA,0)),U,1),!
 S DIE="^PRC(443,",DR="1.5////65;9///2;10///1;13///E" D ^DIE
 S PRCSIG="" D ENCODE^PRCHES11(DA,DUZ,.PRCSIG) S ROUTINE=$T(+0) G:PRCSIG<1 QQ
 Q