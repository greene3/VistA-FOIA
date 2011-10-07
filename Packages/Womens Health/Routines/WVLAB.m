WVLAB ;HCIOFO/FT IHS/ANMC/MWR - ADD/EDIT PROCEDURE BY LAB STAFF; ;12/15/98  11:23
 ;;1.0;WOMEN'S HEALTH;**3**;Sep 30, 1998
 ;;* MICHAEL REMILLARD, DDS * ALASKA NATIVE MEDICAL CENTER *
 ;;  CALLED BY OPTION: "WV LAB ADD A NEW PROCEDURE" TO ACCESSION
 ;;  PROCEDURES.
 ;
 D SETVARS^WVUTL5
 F  D  Q:WVPOP
 .D TITLE^WVUTL5("LAB: ENTER NEW PROCEDURES")
 .D NEW
 D EXIT
 Q
 ;
NEW ;EP
 ;---> SELECT PATIENT.
 S WVPOP=0 N WVDFN,DIR,DR
 ; Quit if no default case manager
 I '$$DCM^WVUTL9(DUZ(2)) D NODCM^WVUTL9 S WVPOP=1 Q
 D PATLKUP^WVUTL8(.Y,"ADD")
 I Y<0 S WVPOP=1 Q
 S WVDFN=+Y
 ;---> SELECT PROCEDURE.
 D NEW1^WVPROC I WVPOP S WVPOP=0 Q
 I '$G(DA) D  Q
 .W !?5,"* FAILURE TO ADD NEW PROCEDURE.  "
 .W "PLEASE CONTACT YOUR SITE MANAGER" D DIRZ^WVUTL3
 D EDIT2(DA)
 Q
 ;
EDIT ;EP
 ;---> CALLED BY OPTION: "WV LAB EDIT ACCESSION".
 ;---> EDIT JUST THE ACCESSION FIELDS OF AN EXISTING PROCEDURE.
 D SETVARS^WVUTL5
 D TITLE^WVUTL5("EDIT AN ACCESSIONED PROCEDURE")
 D LKUPPCD^WVPROC(.Y)
 Q:Y<0!($D(DIROUT))
 ;---> DA=IEN OF PROCEDURE IN PROCEDURE FILE 790.1.
 S DA=+Y
 D EDIT2(DA)
 D EXIT
 Q
 ;
 ;
EDIT2(DA) ;EP
 ;---> REQUIRED VARIABLES: DA=IEN IN ^WV(790.1,.
 Q:'$G(DA)
 S WVDFN=$P(^WV(790.1,DA,0),U,2)
 D DDS^WVFMAN(790.1,"[WV PROC-FORM-LAB]",DA,"C",.WVCHG,.WVPOP)
 Q
 ;
EXIT ;EP
 D KILLALL^WVUTL8
 Q