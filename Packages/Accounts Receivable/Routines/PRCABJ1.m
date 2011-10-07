PRCABJ1 ;WASH-ISC@ALTOONA,PA/LDB-NIGHTLY PROCESS FOR OPEN BILL UPDATE ;4/18/95  2:06 PM
V ;;4.5;Accounts Receivable;**7**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;Update Open status PREPAYMENT bills to REFUND REVIEW
 ;Update Open status bills to Active or Cancellation status
OPEN N DAY,BN,DEBTOR,DA,DIE,DR,P,AMT
 S DAY=+$E(DT,6,7),DEBTOR=0 F  S DEBTOR=$O(^RCD(340,"AC",DAY,DEBTOR)) Q:'DEBTOR  D
 .S BN=0 F  S BN=$O(^PRCA(430,"AS",DEBTOR,$O(^PRCA(430.3,"AC",112,0)),BN)) Q:'BN  D
 ..S AMT=0 F P=1:1:5 S AMT=$P($G(^PRCA(430,+BN,7)),"^",P)+AMT
 ..I $P($G(^PRCA(430,+BN,0)),"^",2)=$O(^PRCA(430.2,"AC",33,0)),AMT Q
 ..S DIE="^PRCA(430,",DA=+BN,DR="8////^S X="_$S(AMT:$O(^PRCA(430.3,"AC",102,0)),1:$O(^PRCA(430.3,"AC",111,0))) D ^DIE K DA,DIE,DR
 ..Q
 .Q
 Q
REFUND NEW DEBTOR,DAY,BN
 S DEBTOR=0,DAY=+$E(DT,6,7)+3#28 S:'DAY DAY=28
 F  S DEBTOR=$O(^RCD(340,"AC",DAY,DEBTOR)) Q:'DEBTOR  D
 .S BN=0 F  S BN=$O(^PRCA(430,"AS",DEBTOR,$O(^PRCA(430.3,"AC",112,0)),BN)) Q:'BN  D
 ..I $P($G(^PRCA(430,+BN,0)),"^",2)=$O(^PRCA(430.2,"AC",33,0)) S X=$$EN^PRCARFU(+BN)
 ..Q
 .Q
 Q
STM ;RESET STATEMENT DATES
 NEW DEB,DIE,DA,DR,TYPE,STAT,BILL,ACT
 S STAT=+$O(^PRCA(430.3,"AC",102,0))
 I 'STAT Q
 F TYPE="VA(200,","DIC(4,","PRC(440," S DEB=0 F  S DEB=$O(^RCD(340,"AB",TYPE,DEB)) Q:'DEB  S X=$G(^RCD(340,DEB,0)) D:X]""
 .I $P(X,"^",3),'$O(^PRCA(430,"AS",DEB,STAT,0)) S DIE="^RCD(340,",DR=".03////@",DA=DEB D ^DIE Q
 .I '$P(X,"^",3),$O(^PRCA(430,"AS",DEB,STAT,0)) S DIE="^RCD(340,",DR=".03////^S X=+$E(DT,6,7) S:X>28 X=1",DA=DEB D ^DIE
 .Q
 S TYPE="DIC(36," S DEB=0 F  S DEB=$O(^RCD(340,"AB",TYPE,DEB)) Q:'DEB  D
 .S ACT=0,BILL=0 F  S BILL=$O(^PRCA(430,"AS",DEB,STAT,BILL)) Q:'BILL  I $P($G(^PRCA(430,BILL,0)),"^",2)'=9 S ACT=1 Q
 .S X=$G(^RCD(340,DEB,0))
 .I $P(X,"^",3),'ACT S DIE="^RCD(340,",DR=".03////@",DA=DEB D ^DIE Q
 .I '$P(X,"^",3),ACT S DIE="^RCD(340,",DR=".03////^S X=+$E(DT,6,7) S:X>28 X=1",DA=DEB D ^DIE
 .Q
 Q
UDLIST ;Print Unprocessed Document List
 N IOP,ZTIO,ZTSAVE,ZTRTN,ZTDESC,ZTASK,%ZIS,ZTDTH,RCFMDEV
 S IOP=$P($G(^RC(342,1,0)),"^",8) I IOP]"" D
 .S %ZIS="N0" D ^%ZIS Q:POP
 .S ZTRTN="EN^RCFMUDL",ZTDTH=$H,RCFMDEV=ION_";"_IOST_";"_IOM_";"_IOSL_";"_$G(IO("DOC"))
 .S ZTSAVE("RCFMDEV")="",ZTDESC="Unprocessed Document List"
 .D ^%ZTLOAD,^%ZISC
 Q