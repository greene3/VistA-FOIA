GMRCYP27 ;SLC/JFR - Post-Install GMRC*3*27 ; 6/21/02 10:19
 ;;3.0;CONSULT/REQUEST TRACKING;**27**;DEC 27, 1997
POST ;post intstall entry point
 N GMRCXDT
 S GMRCXDT=" "
 F  S GMRCXDT=$O(^GMR(123,"E",GMRCXDT)) Q:'+GMRCXDT  D
 . N GMRCIEN
 . S GMRCIEN=0
 . F  S GMRCIEN=$O(^GMR(123,"E",GMRCXDT,GMRCIEN)) Q:'GMRCIEN  D
 .. N DIE,DA,DR,GMRCRDT
 .. S GMRCRDT=$P(^GMR(123,GMRCIEN,0),U,7)
 .. S DIE="^GMR(123,",DA=GMRCIEN,DR="3///^S X=GMRCRDT"
 .. D ^DIE
 .. Q
 Q