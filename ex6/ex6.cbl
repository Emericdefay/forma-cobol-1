      *****************************************************************
      * Program name:    PGM006

      * Original author: DEFAY E.                                
      *
      * Maintenance Log                                              
      * Date      Author   Maintenance Requirement               
      * --------- -------- --------------------------------------- 
      * 15/11/22  IBMUSER  Created for practice       
      *                                                               
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.    PGM006.
       AUTHOR.        DEFAY E. 
       INSTALLATION.  COBOL DEVELOPMENT CENTER. 
       DATE-WRITTEN.  15/11/22. 
       DATE-COMPILED. 15/11/22. 
       SECURITY.      NON-CONFIDENTIAL.
      *****************************************************************
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-O     PIC X.
           88 SOMME    VALUE 'S'.
           88 PRODUIT  VALUE 'P'.
           88 DIVISE   VALUE 'D'.
       01  WS-VAR1  PIC 9(5).
           88 IS-ZERO  VALUE 00000.
       01  WS-VAR2  PIC 9(5).
       01  WS-VAR3  PIC 9(5).
      *****************************************************************
       PROCEDURE DIVISION.
           PERFORM 000-STEP1 THRU 000-EXIT.
           PERFORM 100-STEP2 THRU 100-EXIT.
           PERFORM 200-STEP3 THRU 200-EXIT.
           PERFORM 300-STEP4 THRU 300-EXIT.
           GOBACK.
      *****************************************************************
      *  This routine should accept the values WS-* from JCL EXE SYSIN
      *****************************************************************
       000-STEP1.
           DISPLAY "000-STEP1 : ACCEPT VARS".
           ACCEPT WS-O.
           ACCEPT WS-VAR1.
           ACCEPT WS-VAR2.
           ACCEPT WS-VAR3.
       000-EXIT.
           EXIT.
      *****************************************************************
      *  This routine should display variables
      *****************************************************************
       100-STEP2.
           DISPLAY "100-STEP2 : DISPLAY VARS".
           DISPLAY 'WS-O    : ' WS-O.
           DISPLAY 'WS-VAR1 : ' WS-VAR1.
           DISPLAY 'WS-VAR2 : ' WS-VAR2.
           DISPLAY 'WS-VAR3 : ' WS-VAR3.
       100-EXIT.
           EXIT.
      *****************************************************************
      *  This routine should check (WS-O)peration and choose subroutine
      *****************************************************************
       200-STEP3.
           DISPLAY "100-STEP2 : CONDITIONS".
           EVALUATE TRUE 
              WHEN SOMME
                 PERFORM 400-SOMME   THRU 400-EXIT
              WHEN PRODUIT 
                 PERFORM 400-PRODUIT THRU 401-EXIT
              WHEN DIVISE 
                 PERFORM 400-DIVISE  THRU 402-EXIT
           END-EVALUATE.
       200-EXIT.
           EXIT.
      *****************************************************************
      *  This routine should close the program 
      *****************************************************************
       300-STEP4.
           DISPLAY "200-STEP3 : EXIT".
           DISPLAY "RESULT : " WS-VAR3.
           DISPLAY "Everything is OK.".
       300-EXIT.
           EXIT.
      *****************************************************************
      *  Those routines are about operations.
      *****************************************************************
       400-SOMME.
           DISPLAY 'WS-VAR3 : ' WS-VAR3.
           DISPLAY 'SOMME...'.
           COMPUTE WS-VAR3 = WS-VAR2 + WS-VAR1.
           DISPLAY 'WS-VAR3 : ' WS-VAR3.
       400-EXIT.
           EXIT.

       400-PRODUIT.
           DISPLAY 'WS-VAR3 : ' WS-VAR3.
           DISPLAY 'PRODUIT...'.
           COMPUTE WS-VAR3 = WS-VAR2 * WS-VAR1.
           DISPLAY 'WS-VAR3 : ' WS-VAR3.
       401-EXIT.
           EXIT.
           
       400-DIVISE.
           IF NOT IS-ZERO
              DISPLAY 'WS-VAR3 : ' WS-VAR3
              DISPLAY 'DIVISION...'
              COMPUTE WS-VAR3 = WS-VAR2 / WS-VAR1 
              DISPLAY 'WS-VAR3 : ' WS-VAR3
           ELSE 
              DISPLAY 'ERROR : DIVISION BY 0.'
           END-IF.
       402-EXIT.
           EXIT.