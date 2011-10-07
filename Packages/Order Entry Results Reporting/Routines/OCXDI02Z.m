OCXDI02Z ;SLC/RJS,CLA - OCX PACKAGE DIAGNOSTIC ROUTINES ;SEP 7,1999 at 10:30
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
S ;
 ;
 D DOT^OCXDIAG
 ;
 ;
 K REMOTE,LOCAL,OPCODE,REF
 F LINE=1:1:500 S TEXT=$P($T(DATA+LINE),";",2,999) Q:TEXT  I $L(TEXT) D  Q:QUIT
 .S ^TMP("OCXDIAG",$J,$O(^TMP("OCXDIAG",$J,"A"),-1)+1)=TEXT
 ;
 G ^OCXDI030
 ;
 Q
 ;
DATA ;
 ;
 ;;D^2
 ;;R^"860.3:","860.31:2",1,"E"
 ;;D^CONTROL CODE
 ;;R^"860.3:","860.31:2",2,"E"
 ;;D^EQ FREE TEXT
 ;;R^"860.3:","860.31:2",3,"E"
 ;;D^DC
 ;;EOR^
 ;;KEY^860.3:^CONSULT PUT ON-HOLD
 ;;R^"860.3:",.01,"E"
 ;;D^CONSULT PUT ON-HOLD
 ;;R^"860.3:",.02,"E"
 ;;D^GENERIC HL7 MESSAGE ARRAY
 ;;R^"860.3:","860.31:1",.01,"E"
 ;;D^1
 ;;R^"860.3:","860.31:1",1,"E"
 ;;D^FILLER
 ;;R^"860.3:","860.31:1",2,"E"
 ;;D^EQ FREE TEXT
 ;;R^"860.3:","860.31:1",3,"E"
 ;;D^GMRC
 ;;R^"860.3:","860.31:2",.01,"E"
 ;;D^2
 ;;R^"860.3:","860.31:2",1,"E"
 ;;D^CONTROL CODE
 ;;R^"860.3:","860.31:2",2,"E"
 ;;D^EQ FREE TEXT
 ;;R^"860.3:","860.31:2",3,"E"
 ;;D^HD
 ;;EOR^
 ;;KEY^860.3:^CONSULT FINAL RESULTS
 ;;R^"860.3:",.01,"E"
 ;;D^CONSULT FINAL RESULTS
 ;;R^"860.3:",.02,"E"
 ;;D^GENERIC HL7 MESSAGE ARRAY
 ;;R^"860.3:","860.31:1",.01,"E"
 ;;D^1
 ;;R^"860.3:","860.31:1",1,"E"
 ;;D^FILLER
 ;;R^"860.3:","860.31:1",2,"E"
 ;;D^EQ FREE TEXT
 ;;R^"860.3:","860.31:1",3,"E"
 ;;D^GMRC
 ;;R^"860.3:","860.31:2",.01,"E"
 ;;D^2
 ;;R^"860.3:","860.31:2",1,"E"
 ;;D^REQUEST STATUS (OBR)
 ;;R^"860.3:","860.31:2",2,"E"
 ;;D^EQ FREE TEXT
 ;;R^"860.3:","860.31:2",3,"E"
 ;;D^F
 ;;R^"860.3:","860.31:3",.01,"E"
 ;;D^3
 ;;R^"860.3:","860.31:3",1,"E"
 ;;D^CONTROL CODE
 ;;R^"860.3:","860.31:3",2,"E"
 ;;D^EQUALS ELEMENT IN SET
 ;;R^"860.3:","860.31:3",3,"E"
 ;;D^RE
 ;;EOR^
 ;;KEY^860.3:^PATIENT DISCHARGE
 ;;R^"860.3:",.01,"E"
 ;;D^PATIENT DISCHARGE
 ;;R^"860.3:",.02,"E"
 ;;D^DGPM PATIENT MOVEMENT PROTOCOL
 ;;R^"860.3:","860.31:1",.01,"E"
 ;;D^1
 ;;R^"860.3:","860.31:1",1,"E"
 ;;D^PATIENT MOVEMENT TYPE CURRENT
 ;;R^"860.3:","860.31:1",2,"E"
 ;;D^EQ FREE TEXT
 ;;R^"860.3:","860.31:1",3,"E"
 ;;D^DISCHARGE
 ;;EOR^
 ;;KEY^860.3:^PATIENT DECEASED
 ;;R^"860.3:",.01,"E"
 ;;D^PATIENT DECEASED
 ;;R^"860.3:",.02,"E"
 ;;D^DGPM PATIENT MOVEMENT PROTOCOL
 ;;R^"860.3:","860.31:1",.01,"E"
 ;;D^1
 ;;R^"860.3:","860.31:1",1,"E"
 ;;D^PATIENT TRANSACTION TYPE CURRENT
 ;;R^"860.3:","860.31:1",2,"E"
 ;;D^CONTAINS
 ;;R^"860.3:","860.31:1",3,"E"
 ;;D^DEATH
 ;;EOR^
 ;;KEY^860.3:^NEW SITE FLAGGED ORDER
 ;;R^"860.3:",.01,"E"
 ;;D^NEW SITE FLAGGED ORDER
 ;;R^"860.3:",.02,"E"
 ;;D^GENERIC HL7 MESSAGE ARRAY
 ;;R^"860.3:","860.31:1",.01,"E"
 ;;D^1
 ;;R^"860.3:","860.31:1",1,"E"
 ;;D^SITE FLAGGED ORDER
 ;;R^"860.3:","860.31:1",2,"E"
 ;;D^LOGICAL TRUE
 ;;R^"860.3:","860.31:2",.01,"E"
 ;;D^2
 ;;R^"860.3:","860.31:2",1,"E"
 ;;D^CONTROL CODE
 ;;R^"860.3:","860.31:2",2,"E"
 ;;D^EQUALS ELEMENT IN SET
 ;;R^"860.3:","860.31:2",3,"E"
 ;;D^NW,SN
 ;;EOR^
 ;;KEY^860.3:^SITE FLAGGED FINAL LAB RESULT
 ;;R^"860.3:",.01,"E"
 ;;D^SITE FLAGGED FINAL LAB RESULT
 ;;R^"860.3:",.02,"E"
 ;;D^GENERIC HL7 MESSAGE ARRAY
 ;;R^"860.3:","860.31:1",.01,"E"
 ;;D^1
 ;;R^"860.3:","860.31:1",1,"E"
 ;;D^RESULT STATUS (OBX)
 ;;R^"860.3:","860.31:1",2,"E"
 ;;D^EQ FREE TEXT
 ;;R^"860.3:","860.31:1",3,"E"
 ;;D^F
 ;;R^"860.3:","860.31:3",.01,"E"
 ;;D^3
 ;;R^"860.3:","860.31:3",1,"E"
 ;;D^SITE FLAGGED RESULT
 ;;R^"860.3:","860.31:3",2,"E"
 ;;D^LOGICAL TRUE
 ;;R^"860.3:","860.31:4",.01,"E"
 ;;D^4
 ;;R^"860.3:","860.31:4",1,"E"
 ;;D^CONTROL CODE
 ;;R^"860.3:","860.31:4",2,"E"
 ;;D^EQUALS ELEMENT IN SET
 ;;R^"860.3:","860.31:4",3,"E"
 ;;D^RE
 ;;R^"860.3:","860.31:5",.01,"E"
 ;;D^5
 ;;R^"860.3:","860.31:5",1,"E"
 ;;D^FILLER
 ;;R^"860.3:","860.31:5",2,"E"
 ;;D^STARTS WITH
 ;;R^"860.3:","860.31:5",3,"E"
 ;;D^LR
 ;;EOR^
 ;;KEY^860.3:^NEW OBR STAT ORDER
 ;;R^"860.3:",.01,"E"
 ;;D^NEW OBR STAT ORDER
 ;;R^"860.3:",.02,"E"
 ;;D^GENERIC HL7 MESSAGE ARRAY
 ;;R^"860.3:","860.31:1",.01,"E"
 ;;D^1
 ;;R^"860.3:","860.31:1",1,"E"
 ;;D^CONTROL CODE
 ;;R^"860.3:","860.31:1",2,"E"
 ;;D^EQUALS ELEMENT IN SET
 ;;R^"860.3:","860.31:1",3,"E"
 ;;D^NW,SN
 ;;R^"860.3:","860.31:2",.01,"E"
 ;;D^2
 ;;R^"860.3:","860.31:2",1,"E"
 ;;D^ORDER PRIORITY (OBR)
 ;;R^"860.3:","860.31:2",2,"E"
 ;;D^EQ FREE TEXT
 ;;R^"860.3:","860.31:2",3,"E"
 ;;D^S
 ;;EOR^
 ;;KEY^860.3:^NEW ORC STAT ORDER
 ;;R^"860.3:",.01,"E"
 ;;D^NEW ORC STAT ORDER
 ;;R^"860.3:",.02,"E"
 ;;D^GENERIC HL7 MESSAGE ARRAY
 ;;R^"860.3:","860.31:1",.01,"E"
 ;;D^1
 ;;R^"860.3:","860.31:1",1,"E"
 ;;D^CONTROL CODE
 ;;R^"860.3:","860.31:1",2,"E"
 ;;D^EQUALS ELEMENT IN SET
 ;;R^"860.3:","860.31:1",3,"E"
 ;;D^NW,SN
 ;;R^"860.3:","860.31:2",.01,"E"
 ;;D^2
 ;;R^"860.3:","860.31:2",1,"E"
 ;;D^ORDER PRIORITY (ORC)
 ;;R^"860.3:","860.31:2",2,"E"
 ;;D^EQ FREE TEXT
 ;;R^"860.3:","860.31:2",3,"E"
 ;;D^S
 ;;EOR^
 ;;KEY^860.3:^RENAL/CONTRAST MEDIA COMPLICATIONS
 ;;R^"860.3:",.01,"E"
 ;;D^RENAL/CONTRAST MEDIA COMPLICATIONS
 ;;R^"860.3:",.02,"E"
 ;;D^CPRS ORDER PRESCAN
 ;;R^"860.3:","860.31:1",.01,"E"
 ;;D^1
 ;;R^"860.3:","860.31:1",1,"E"
 ;;D^ORDER MODE
 ;;R^"860.3:","860.31:1",2,"E"
 ;;D^EQ FREE TEXT
 ;;R^"860.3:","860.31:1",3,"E"
 ;;D^SELECT
 ;;R^"860.3:","860.31:3",.01,"E"
 ;;D^3
 ;;R^"860.3:","860.31:3",1,"E"
 ;;D^MOST RECENT RENAL TEST ABNORMAL FLAG
 ;;R^"860.3:","860.31:3",2,"E"
 ;1;
 ;