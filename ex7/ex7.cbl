      *****************************************************************
      * Program name:    PGM007

      * Original author: DEFAY E.                                
      *
      * Maintenance Log                                              
      * Date      Author   Maintenance Requirement               
      * --------- -------- --------------------------------------- 
      * 15/11/22  IBMUSER  Created for practice       
      *                                                               
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.    PGM007.
       AUTHOR.        DEFAY E. 
       INSTALLATION.  COBOL DEVELOPMENT CENTER. 
       DATE-WRITTEN.  15/11/22. 
       DATE-COMPILED. 15/11/22. 
       SECURITY.      NON-CONFIDENTIAL.
      *****************************************************************
       ENVIRONMENT DIVISION. 
       INPUT-OUTPUT SECTION. 
       FILE-CONTROL.
           SELECT NOMFIC
           ASSIGN TO FILEIN.
       DATA DIVISION.
       FILE SECTION. 
       FD NOMFIC.
       01  STRUCT-FICHIER.
           02 F-COMPTE   PIC 9(06).
           02 F-NOM      PIC X(15).
           02 F-SOLDER   PIC 9(07).
           02 F-DT-MVT   PIC X(10).
           02 F-ETAT     PIC X(01).
           02 F-DEPT     PIC 9(02).
           02 F-LIBRE    PIC X(39).
      *****************************************************************
       WORKING-STORAGE SECTION.
      *****************************************************************
       PROCEDURE DIVISION.
           PERFORM 000-OFILE.
           PERFORM 000-RFILE.
           PERFORM 000-STEP1 THRU 000-EXIT.
           PERFORM 100-STEP2 THRU 100-EXIT.
           PERFORM 200-STEP3 THRU 200-EXIT.
           PERFORM 300-STEP4 THRU 300-EXIT.
           PERFORM 000-CFILE.
           GOBACK.
      *****************************************************************
      *  Those routines handle files I/O
      *****************************************************************
       000-OFILE.
           OPEN INPUT NOMFIC.
       000-RFILE.
           READ NOMFIC.
       000-CFILE.
           CLOSE NOMFIC.
      *****************************************************************
      *  This routine should read file on the first line, detect if @
      *****************************************************************
       000-STEP1.
           DISPLAY "000-STEP1 : ACCEPT VARS".
           EVALUATE F-ETAT
               WHEN '@' 
                  PERFORM 400-ACT THRU 400-EXIT
               WHEN OTHER
                  CONTINUE
           END-EVALUATE.
       000-EXIT.
           EXIT.
      *****************************************************************
      *  This routine should display variables
      *****************************************************************
       100-STEP2.
           DISPLAY "100-STEP2 : DISPLAY VARS".
       100-EXIT.
           EXIT.
      *****************************************************************
      *  This routine should check (WS-O)peration and choose subroutine
      *****************************************************************
       200-STEP3.
           DISPLAY "100-STEP2 : CONDITIONS".
       200-EXIT.
           EXIT.
      *****************************************************************
      *  This routine should close the program 
      *****************************************************************
       300-STEP4.
           DISPLAY "200-STEP3 : EXIT".
           DISPLAY "Everything is OK.".
       300-EXIT.
           EXIT.
      *****************************************************************
      *  This routine should display a line of a file.
      *****************************************************************
       400-ACT.
           DISPLAY STRUCT-FICHIER .
       400-EXIT.
           EXIT.
