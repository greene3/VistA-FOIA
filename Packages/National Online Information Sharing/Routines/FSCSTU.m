FSCSTU ;SLC/STAFF-NOIS Site Tracking Update ;1/17/98  16:51
 ;;1.1;NOIS;;Sep 06, 1998
 ;
UPDATE(MSG,PACKAGE,SITE,DATE) ; from A5CSTS
 N VAR,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE K ZTSAVE
 S ZTIO=$$RESOURCE^FSCTASK($$DOW^XLFDT(DT,1)+1),ZTRTN="SETUP^FSCSTU",ZTDTH=$H,ZTDESC="NOIS Site Tracking Updates"
 F VAR="MSG(","PACKAGE","SITE","DATE" S ZTSAVE(VAR)=""
 D ^%ZTLOAD
 Q
 ;
SETUP ; dequeued
 I $D(ZTQUEUED) S ZTREQ="@"
 Q:'$G(DATE)  Q:'$L($G(PACKAGE))  Q:'$L($G(SITE))  Q:'$O(MSG(0))
 N DA,DIK,MSGNUM,NUM,PACKNUM,SITENUM
 ; convert date, official package name, and domain for NOIS
 S DATE=DATE\1
 S PACKNUM=+$O(^DIC(9.4,"B",PACKAGE,0)),PACKAGE=+$O(^FSC("PACK","AC",PACKNUM,0))
 S SITENUM=+$O(^DIC(4.2,"B",SITE,0)),SITE=+$O(^FSC("SITE","AE",SITENUM,0))
 S MSGNUM=+$O(MSG(""),-1)
 Q:'DATE  Q:'PACKAGE  Q:'SITE  Q:'MSGNUM
 ;
 ; setup msg
 S NUM=1+$P(^FSCD("STU MSG",0),U,3)
 L +^FSCD("STU MSG",0):30 I '$T Q  ; *** skip
 F  Q:'$D(^FSCD("STU MSG",NUM,0))  S NUM=NUM+1
 S ^FSCD("STU MSG",NUM,0)=DATE_U_PACKAGE_U_SITE
 S $P(^FSCD("STU MSG",0),U,3)=NUM,$P(^(0),U,4)=$P(^(0),U,4)+1
 L -^FSCD("STU MSG",0)
 S DIK="^FSCD(""STU MSG"",",DA=NUM D IX1^DIK
 S ^FSCD("STU MSG",NUM,1,0)="^^"_MSGNUM_U_MSGNUM_U_DT_U
 M ^FSCD("STU MSG",NUM,1)=MSG
 ;
 D CHECK(PACKAGE,SITE,NUM)
 Q
 ;
CHECK(PACKAGE,SITE,MSGNUM) ;
 N PACKGRP,SITETYPE,USER
 S PACKGRP=+$P(^FSC("PACK",PACKAGE,0),U,2)
 S SITETYPE=+$P(^FSC("SITE",SITE,0),U,13)
 ; go thru users that have alerts setup, update criteria if needed, alert
 S USER=0 F  S USER=$O(^FSC("SPEC","AX",USER)) Q:USER'>0  D
 .I $D(^FSC("SPEC","AU",USER)) D
 ..I '$D(^XTMP("FSC STU",USER)) D BUILD(USER)
 ..D ALERT(USER,MSGNUM,PACKAGE,PACKGRP,SITE,SITETYPE)
 .E  D
 ..D BUILD(USER)
 ..I $D(^FSC("SPEC","AU",USER)) D ALERT(USER,MSGNUM,PACKAGE,PACKGRP,SITE,SITETYPE)
 Q
 ;
BUILD(USER) ;
 N MATCH,NUM,NUM1,VALUE,VALUE1
 I '$D(^XTMP("FSC STU",0)) K ^XTMP("FSC STU") S ^XTMP("FSC STU",0)=$$FMADD^XLFDT(DT,7)_U_DT
 K ^XTMP("FSC STU",USER)
 I '$$VALID(USER) D
 .; if invalid criteria cleanup files
 .K ^FSC("SPEC","AX",USER)
 .K ^FSC("SPEC","AU",USER)
 E  D
 .; if criteria is valid, update criteria
 .S MATCH=+$G(^FSC("SPEC",USER,40))
 .I 'MATCH D
 ..S NUM=0 F  S NUM=$O(^FSC("SPEC",USER,41,NUM))  Q:NUM<1  S VALUE=+$G(^(NUM,0)) I VALUE S ^XTMP("FSC STU",USER,"P",VALUE)=""
 ..S NUM=0 F  S NUM=$O(^FSC("SPEC",USER,42,NUM))  Q:NUM<1  S VALUE=+$G(^(NUM,0)) I VALUE S ^XTMP("FSC STU",USER,"PG",VALUE)=""
 ..S NUM=0 F  S NUM=$O(^FSC("SPEC",USER,43,NUM))  Q:NUM<1  S VALUE=+$G(^(NUM,0)) I VALUE S ^XTMP("FSC STU",USER,"S",VALUE)=""
 ..S NUM=0 F  S NUM=$O(^FSC("SPEC",USER,44,NUM))  Q:NUM<1  S VALUE=+$G(^(NUM,0)) I VALUE S ^XTMP("FSC STU",USER,"ST",VALUE)=""
 .E  D
 ..S NUM=0 F  S NUM=$O(^FSC("SPEC",USER,41,NUM))  Q:NUM<1  S VALUE=+$G(^(NUM,0)) I VALUE D
 ...S NUM1=0 F  S NUM1=$O(^FSC("SPEC",USER,43,NUM1)) Q:NUM1<1  S VALUE1=+$G(^(NUM1,0)) I VALUE1 S ^XTMP("FSC STU",USER,"PS",VALUE,VALUE1)=""
 ...S NUM1=0 F  S NUM1=$O(^FSC("SPEC",USER,44,NUM1)) Q:NUM1<1  S VALUE1=+$G(^(NUM1,0)) I VALUE1 S ^XTMP("FSC STU",USER,"PST",VALUE,VALUE1)=""
 ..S NUM=0 F  S NUM=$O(^FSC("SPEC",USER,42,NUM))  Q:NUM<1  S VALUE=+$G(^(NUM,0)) I VALUE D
 ...S NUM1=0 F  S NUM1=$O(^FSC("SPEC",USER,43,NUM1)) Q:NUM1<1  S VALUE1=+$G(^(NUM1,0)) I VALUE1 S ^XTMP("FSC STU",USER,"PGS",VALUE,VALUE1)=""
 ...S NUM1=0 F  S NUM1=$O(^FSC("SPEC",USER,44,NUM1)) Q:NUM1<1  S VALUE1=+$G(^(NUM1,0)) I VALUE1 S ^XTMP("FSC STU",USER,"PGST",VALUE,VALUE1)=""
 .S ^FSC("SPEC","AU",USER)=""
 Q
 ;
ALERT(USER,MSGNUM,PACKAGE,PACKGRP,SITE,SITETYPE) ;
 N DA,DIK,NUM,OK,XQA,XQADATA,XQAID,XQAMSG,XQAROU K XQA
 ; if criteria matches site tracking info, add to alert file, alert if new
 S OK=0 D
 .I $D(^XTMP("FSC STU",USER,"P",PACKAGE)) S OK=1 Q
 .I $D(^XTMP("FSC STU",USER,"PG",PACKGRP)) S OK=1 Q
 .I $D(^XTMP("FSC STU",USER,"S",SITE)) S OK=1 Q
 .I $D(^XTMP("FSC STU",USER,"ST",SITETYPE)) S OK=1 Q
 .I $D(^XTMP("FSC STU",USER,"PS",PACKAGE,SITE)) S OK=1 Q
 .I $D(^XTMP("FSC STU",USER,"PST",PACKAGE,SITETYPE)) S OK=1 Q
 .I $D(^XTMP("FSC STU",USER,"PGS",PACKGRP,SITE)) S OK=1 Q
 .I $D(^XTMP("FSC STU",USER,"PGST",PACKGRP,SITETYPE)) S OK=1 Q
 I 'OK Q
 I $O(^FSCD("STU ALERT","B",USER,0)) S OK=0
 ;
 S NUM=1+$P(^FSCD("STU ALERT",0),U,3)
 L +^FSCD("STU ALERT",0):30 I '$T Q  ; *** skip
 F  Q:'$D(^FSCD("STU ALERT",NUM,0))  S NUM=NUM+1
 S ^FSCD("STU ALERT",NUM,0)=USER_U_MSGNUM
 S $P(^FSCD("STU ALERT",0),U,3)=NUM,$P(^(0),U,4)=$P(^(0),U,4)+1
 L -^FSCD("STU ALERT",0)
 S DIK="^FSCD(""STU ALERT"",",DA=NUM D IX1^DIK
 ;
 I OK D
 .S XQA(USER)="",XQADATA="",XQAMSG="Site Tracking Update",XQAROU="ALERT^FSCSTUR",XQAID="FSC/ST"
 .D SETUP^XQALERT
 Q
 ;
VALID(USER) ; $$(user) -> 0 or 1 if set up for site tracking alerts
 I $O(^FSC("SPEC",USER,41,0)) Q 1
 I $O(^FSC("SPEC",USER,42,0)) Q 1
 I $O(^FSC("SPEC",USER,43,0)) Q 1
 I $O(^FSC("SPEC",USER,44,0)) Q 1
 Q 0