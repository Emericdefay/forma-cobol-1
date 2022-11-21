      *****************************************************************
      * Program name:    PGM013
      *
      * Original author: DEFAY E.                                
      *
      * Maintenance Log                                              
      * Date      Author   Maintenance Requirement               
      * --------- -------- --------------------------------------- 
      * 16/11/22  IBMUSER  Using SYSIN parameters :  CAS & MNT-X   
      *                                                               
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.    PGM013.
       AUTHOR.        DEFAY E. 
       INSTALLATION.  COBOL DEVELOPMENT CENTER. 
       DATE-WRITTEN.  17/11/22. 
       DATE-COMPILED. 17/11/22. 
       SECURITY.      NON-CONFIDENTIAL.
      *****************************************************************
       DATA DIVISION. 
       WORKING-STORAGE SECTION.
       01 ZONE-A.
           02 VALUE-A PIC  9(5).
           02 FILLER PIC X.
           02 VALUE-B PIC S9(5).
           02 FILLER PIC X.
           02 VALUE-C PIC S9(5) COMP.
           02 FILLER PIC X.
           02 VALUE-D PIC S9(5) BINARY.
           02 FILLER PIC X.
           02 VALUE-E PIC S9(5) COMP-4.
           02 FILLER PIC X.
           02 VALUE-F PIC S9(5) COMP-5.
           02 FILLER PIC X.
           02 VALUE-G PIC S9(5) COMP-3.
      *****************************************************************
       PROCEDURE DIVISION.
           DISPLAY '*==================*'.
           PERFORM 100-CALL THRU 100-EXIT.
           DISPLAY '*==================*'.
           GOBACK.
      *****************************************************************
      *  This routine select the routine to launch according to MNT-X
      *****************************************************************
       100-CALL.
           MOVE  123 TO VALUE-A.
           MOVE +123 TO VALUE-B.
           MOVE +123 TO VALUE-C.
           MOVE +123 TO VALUE-D.
           MOVE +123 TO VALUE-E.
           MOVE +123 TO VALUE-F.
           MOVE +123 TO VALUE-G.
           DISPLAY 'Value-A: ' VALUE-A.
           DISPLAY 'Value-B: ' VALUE-B.
           DISPLAY 'Value-C: ' VALUE-C.
           DISPLAY 'Value-D: ' VALUE-D.
           DISPLAY 'Value-E: ' VALUE-E.
           DISPLAY 'Value-F: ' VALUE-F.
           DISPLAY 'Value-G: ' VALUE-G.
       100-EXIT. 
           EXIT.