      *****************************************************************
      * Program name:    PGM002                               
      * Original author: DEFAY E.                                
      *
      * Maintenance Log                                              
      * Date      Author   Maintenance Requirement               
      * --------- -------- --------------------------------------- 
      * 15/11/22  IBMUSER  Created for practice       
      *                                                               
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.    PGM002.
       AUTHOR.        DEFAY E. 
       INSTALLATION.  COBOL DEVELOPMENT CENTER. 
       DATE-WRITTEN.  15/11/22. 
       DATE-COMPILED. 15/11/22. 
       SECURITY.      NON-CONFIDENTIAL.
      *****************************************************************
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WD-1     PIC X(10).
       01  WD-2     PIC X(05).
       01  WD-3     PIC 9(02).
       01  WD-4     PIC 9(02).
      *****************************************************************
       PROCEDURE DIVISION.
           PERFORM 000-STEP1 THRU 000-EXIT.
           PERFORM 100-STEP2 THRU 100-EXIT.
           PERFORM 200-STEP3 THRU 200-EXIT.
           GOBACK.
      *****************************************************************
      *  This routine should provide values to variables 
      *****************************************************************
       000-STEP1.
           DISPLAY "000-STEP1".
           MOVE 'NOM'     TO WD-1.
           MOVE 'ADRESSE' TO WD-2.
           MOVE 15        TO WD-3.
           MOVE 375       TO WD-4.
       000-EXIT.
           EXIT.
      *****************************************************************
      *  This routine should display variables
      *****************************************************************
       100-STEP2.
           DISPLAY "100-STEP2".
           DISPLAY 'WD-1 : ' WD-1.
           DISPLAY 'WD-2 : ' WD-2.
           DISPLAY 'WD-3 : ' WD-3.
           DISPLAY 'WD-4 : ' WD-4.
       100-EXIT.
           EXIT.
      *****************************************************************
      *  This routine should close the program 
      *****************************************************************
       200-STEP3.
           DISPLAY "200-STEP3".
           DISPLAY "wd-2 CUT RIGHT".
           DISPLAY "WD-4 CUT LEFT".
           DISPLAY "Everything is OK.".
       200-EXIT.
           EXIT.