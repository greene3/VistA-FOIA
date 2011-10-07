TIUFD4 ; SLC/MAM - LM Template D Actions Edit Technical Fields, Edit Upload. LM Subtemplate DJ Action DELOBJ ;4/17/97  11:02
 ;;1.0;TEXT INTEGRATION UTILITIES;**14**;Jun 20, 1997
 ;
DELOBJ ; Template DJ Action Delete (Object).
 N FILEDA,MSG,USED,ASKOK,DA,DIK,LINENO
 S FILEDA=TIUFINFO("FILEDA"),VALMBCK="R"
 I ($L($P(TIUFNOD0,U,5))!$L($P(TIUFNOD0,U,6))),'$$PERSOWNS^TIUFLF2(FILEDA,DUZ) S MSG=" Only an Owner can delete a file entry" W MSG,! D PAUSE^TIUFXHLX  G DELOX
 L +^TIU(8925.1,FILEDA):1 I '$T W !!," Another user is editing this entry; Please try later" H 2 G DELOX
 S USED=$$OBJUSED^TIUFLJ(FILEDA)
 Q:$$CANTDEL^TIUFHA1(FILEDA,USED)
 H 1 S ASKOK=$$ASKOK^TIUFHA1(0,0,USED) I 'ASKOK  S MSG=" ... Object not deleted!" W !,MSG,! D PAUSE^TIUFXHLX G DELOX
 ; Delete FILEDA as Docmt Def entry in file 8925.1:
 S DA=FILEDA,DIK="^TIU(8925.1," D ^DIK
 S LINENO=$O(^TMP("TIUF1IDX",$J,"DAF",FILEDA,0))
 D UPDATE^TIUFLLM1(TIUFTMPL,-1,LINENO-1) S TIUFVCN1=TIUFVCN1-1
 S MSG=" ... Object Deleted!" W !,MSG,! H 1 S VALMBCK="Q"
DELOX L -^TIU(8925.1,FILEDA)
 I $D(DTOUT) S VALMBCK="Q"
 Q
 ;
EDTECH ;LM Template D Action Edit Technical Fields.
 ; Requires CURRENT arrays TIUFINFO, TIUFNOD0.
 ; Requires TIUFTLIN as set in DSTECH^TIUFD.
 N FILEDA,DA,DIE,DR,LINENO,PFILEDA,PNODE61,PCUSTOM,TYPE,STATUS
 N DIR,X,Y,TIUFY,TIUFXNOD,TIUFFULL,ICUSTOM,DTOUT,DIRUT,DIROUT
 S FILEDA=TIUFINFO("FILEDA"),VALMBCK="",TYPE=$P(TIUFNOD0,U,4),TIUFXNOD=$G(XQORNOD(0))
 I '$D(^TIU(8925.1,FILEDA,0)) W !!," Can't Edit Technical Fields; File Entry "_FILEDA_" does not exist; See IRM",! D PAUSE^TIUFXHLX S VALMBCK="Q" G EDTEX
 S STATUS=$$STATWORD^TIUFLF5($P(TIUFNOD0,U,7)) ;e.g. INACTIVE
 I STATUS="NO/BAD" W !!," Can't Edit Technical Fields; No Status/Bad Status",! D PAUSE^TIUFXHLX G EDTEX
 I TYPE="O",'$$PERSOWNS^TIUFLF2(FILEDA,DUZ) W !!," Can't edit Technical Fields: Only an Owner can edit Objects",! D PAUSE^TIUFXHLX G EDTEX
 I STATUS'="INACTIVE",TYPE'="O",TIUFWHO="N" K DIRUT D  G:$D(DIRUT)!(TIUFY'=1) EDTEX
 . S DIR(0)="Y",DIR("A",1)=" Entry is not Inactive.  Do you want to bypass safety measures and edit"
 . S DIR("A",2)="Technical Fields even though this may cause errors if e.g. a document is being"
 . S DIR("A")="entered on this entry"
 . S DIR("B")="NO" D ^DIR S TIUFY=Y K DIR,X,Y
 I STATUS'="INACTIVE",TIUFWHO'="N" W !!," Can't edit Technical Fields; Entry is not Inactive",! D PAUSE^TIUFXHLX G EDTEX
 L +^TIU(8925.1,FILEDA):1 I '$T W !!," Another user is editing this entry.",! H 2 G EDTEX
 S DA=FILEDA,DIE=8925.1
 S PFILEDA=+$O(^TIU(8925.1,"AD",FILEDA,0)) I 'PFILEDA S PCUSTOM=0,ICUSTOM="" G DR
 ;If FILEDA is Clinical Documents, want to edit 6.14 but not 6.1, 6.12, 6.13:Type=CL so will edit 6.14; PCUSTOM undefined, so skip others:
 D INHERIT^TIUFLD(PFILEDA,0,6.14,"","","",.ICUSTOM)
 I TYPE="CL"!(TYPE="DC")!(TYPE="DOC") S PNODE61=$G(^TIU(8925.1,PFILEDA,6.1)),PCUSTOM=$P(PNODE61,U,4) I PCUSTOM="" S PCUSTOM=ICUSTOM
DR S DR=$S(TYPE="O":9,1:"4.1:4.45;4.6;4.7;4.9;5;6;I '$G(PCUSTOM) S Y=7;6.1;6.12;6.13;7;8;S:TYPE=""DOC"" Y=0 I ICUSTOM=0 S Y=0;6.14") D ^DIE
 G:$D(DTOUT) EDTEX
 S LINENO=TIUFTLIN
 D DSTECH^TIUFD(.LINENO) S VALMCNT=LINENO
 G:$D(DTOUT) EDTEX
 S VALMBCK="R"
EDTEX ;
 L -^TIU(8925.1,+$G(FILEDA))
 I $D(DTOUT) S VALMBCK="Q" Q
 I $G(TIUFFULL) S VALMBCK="R" D RESET^TIUFXHLX
 Q
 ;
EDUPLOAD ;LM Template D Action Edit Upload.
 ; Requires CURRENT arrays TIUFINFO, TIUFNOD0.
 ; Requires TIUFULIN as set in DSUPLOAD^TIUFD2.
 N FILEDA,DA,DIE,DR,LINENO,TIUFXNOD,STATUS,TYPE,DTOUT,DIRUT,DIROUT
 S FILEDA=TIUFINFO("FILEDA"),VALMBCK="",TIUFXNOD=$G(XQORNOD(0))
 I '$D(^TIU(8925.1,FILEDA,0)) W !!," Can't Edit Upload; File Entry "_FILEDA_" does not exist in the file; See IRM",! D PAUSE^TIUFXHLX S VALMBCK="Q" G EDUPX
 S STATUS=$$STATWORD^TIUFLF5($P(TIUFNOD0,U,7)),TYPE=$P(TIUFNOD0,U,4)
 L +^TIU(8925.1,FILEDA):1 I '$T W !," Another user is editing this entry." H 2 G EDUPX
 D FULL^VALM1
 N TIUX
 S DA=FILEDA,DIE=8925.1
 S DR="[TIUF UPLOAD FIELD EDIT]" D ^DIE G:$D(DTOUT) EDUPX
 S LINENO=TIUFULIN
 D DSUPLOAD^TIUFD1(.LINENO) S VALMCNT=LINENO G:$D(DTOUT) EDUPX
 S VALMSG=$$VMSG^TIUFL D RE^VALM4,RESET^TIUFXHLX
EDUPX ;
 L -^TIU(8925.1,+$G(FILEDA))
 I $D(DTOUT) S VALMBCK="Q"
 Q
 ;