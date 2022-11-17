      *****************************************************************
      * Program name:    PGM003                               
      * Original author: DEFAY E.                                
      *
      * Maintenance Log                                              
      * Date      Author   Maintenance Requirement               
      * --------- -------- --------------------------------------- 
      * 15/11/22  IBMUSER  Created for practice       
      *                                                               
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.    PGM003.
       AUTHOR.        DEFAY E. 
       INSTALLATION.  COBOL DEVELOPMENT CENTER. 
       DATE-WRITTEN.  15/11/22. 
       DATE-COMPILED. 15/11/22. 
       SECURITY.      NON-CONFIDENTIAL.
      *****************************************************************
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-VAR1.
           05  WD-11     PIC X(05).
           05  WD-12     PIC 9(02).
           05  WD-13     PIC 9(02).

       01  WS-VAR2       REDEFINES WS-VAR1 .
           05  WD-21     PIC X(06).
           05  WD-22     PIC 9(03).

       01  WS-TABLEAU.
           02  WS-ELEMENT   OCCURS 3.
               04  WS-POSTE    PIC X(4).
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
           MOVE 'ABC'     TO WD-11.
           MOVE 23        TO WD-12.
           MOVE 99        TO WD-13.
           MOVE 'ABCDEFGHIJKL'
                          TO WS-TABLEAU.
       000-EXIT.
           EXIT.
      *****************************************************************
      *  This routine should display variables
      *****************************************************************
       100-STEP2.
           DISPLAY "100-STEP2".
           DISPLAY '     WD-11          : ' WD-11.
           DISPLAY '     WD-12          : ' WD-12.
           DISPLAY '     WD-13          : ' WD-13.
           DISPLAY '     WD-21          : ' WD-21.
           DISPLAY '     WD-22          : ' WD-22.
           DISPLAY '     WS-TABLEAU     : ' WS-TABLEAU.
           DISPLAY '     WD-ELEMENT (2) : ' WS-ELEMENT (2).
           DISPLAY '     WD-POSTE (3)   : ' WS-POSTE (3).
       100-EXIT.
           EXIT.
      *****************************************************************
      *  This routine should close the program 
      *****************************************************************
       200-STEP3.
           DISPLAY "200-STEP3".
           DISPLAY "Everything is OK.".
       200-EXIT.
           EXIT.