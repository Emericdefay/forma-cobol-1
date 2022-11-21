      *****************************************************************
      * Program name:    PGM014
      *
      * Original author: DEFAY E.           
      *
      * Using :
      *    - Copybooks PGM014FC & PGM014FS                    
      *    - Files (examples) FILE0141 & FILES0142                  
      *
      * Maintenance Log                                              
      * Date      Author   Maintenance Requirement               
      * --------- -------- --------------------------------------- 
      * 21/11/22  IBMUSER  Create for practice  
      *                                                               
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.    PGM014.
       AUTHOR.        DEFAY E. 
       INSTALLATION.  COBOL DEVELOPMENT CENTER. 
       DATE-WRITTEN.  21/11/22. 
       DATE-COMPILED. 21/11/22. 
       SECURITY.      NON-CONFIDENTIAL.
      *****************************************************************
       ENVIRONMENT DIVISION. 
       CONFIGURATION SECTION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL. 
      **COPYBOOK : PGM014FC
      *    SELECT file-name ()
      *    ASSIGN to ()
      *    FILE STATUS is FS-().
      * FILEIN1
       COPY PGM014FC REPLACING ==()== BY ==FILEIN1==.
      / FILEIN2
       COPY PGM014FC REPLACING ==()== BY ==FILEIN2==.
      / FILEOUT1
       COPY PGM014FC REPLACING ==()== BY ==FILEOUT1==.
      / FILEOUT2
       COPY PGM014FC REPLACING ==()== BY ==FILEOUT2==.
      / FILEOUT3
       COPY PGM014FC REPLACING ==()== BY ==FILEOUT3==.
      *****************************************************************
       DATA DIVISION. 
      *****************************************************************
       FILE SECTION.
      **COPYBOOK : PGM014FS
      *FD ()  
      *    RECORD CONTAINS 80 CHARACTERS.
      *01 ()-ENREG.
      *    02 ()-COMPTE  PIC 9(6).
      *    02 ()-NOM     PIC X(20).
      *    02 ()-DATE    PIC X(10).
      *    02 FILLER      PIC X(44).
      / FILEIN1
       COPY PGM014FS REPLACING ==()== BY ==FILEIN1==.
      / FILEIN2
       COPY PGM014FS REPLACING ==()== BY ==FILEIN2==.
      / FILEOUT1
       COPY PGM014FS REPLACING ==()== BY ==FILEOUT1==.
      / FILEOUT2
       COPY PGM014FS REPLACING ==()== BY ==FILEOUT2==.
      / FILEOUT3
       COPY PGM014FS REPLACING ==()== BY ==FILEOUT3==.
      *****************************************************************
       WORKING-STORAGE SECTION.
      / FILES STATUS
       01 FS-FILEIN1     PIC X(2).
           88 FS-FC-F1    VALUE '10'.
       01 FS-FILEIN2     PIC X(2).
           88 FS-FC-F2    VALUE '10'.
       01 FS-FILEOUT1    PIC X(2).
       01 FS-FILEOUT2    PIC X(2).
       01 FS-FILEOUT3    PIC X(2).
      *****************************************************************
      *  Program : Setup, run main routine and exit.
      *****************************************************************
       PROCEDURE DIVISION.
           PERFORM 000-PARAM THRU 000-EXIT.
      /    PERFORM : 
      /            001-IOPEN.
      /            002-OOPEN.
           PERFORM 100-FILES THRU 100-EXIT.
           PERFORM 999-FCLOS THRU 999-EXIT.
           GOBACK.
      /                                                               /
      /////////////////////////////////////////////////////////////////
      *****************************************************************
      *  Routine 0 : Setting up the program with Params & Files.
      *****************************************************************
      *****************************************************************
      *  This routine should setup params (if any)
       000-PARAM.
           CONTINUE.
      *****************************************************************
      *  Those routines should manage file opening (if any)
       001-IOPEN.
           OPEN INPUT  FILEIN1,
                       FILEIN2.
       002-OOPEN.
           OPEN OUTPUT FILEOUT1,
                       FILEOUT2,
                       FILEOUT3.
       000-EXIT.
           EXIT.
      *
      *****************************************************************
      *  This routine should manage file reading
       010-READ.
           READ FILEIN1.
           READ FILEIN2.
      *                                                               *
      *****************************************************************
      *****************************************************************
      *  Routine 1 : Read, compare 2 files and write in 3 other files.
      *****************************************************************
      *****************************************************************
      *  This routine should read files 1 & 2 until one is finish (LbL)
       100-FILES.
           PERFORM UNTIL (FS-FC-F1 OR FS-FC-F2)
                PERFORM 010-READ
                PERFORM 101-COMPARE
           END-PERFORM.

       100-EXIT.
           EXIT.
      *                                                               *
      *****************************************************************
      *****************************************************************
      *                                                               *
       101-COMPARE.
           EVALUATE TRUE
               WHEN NOT (FS-FC-F1 OR FS-FC-F2)
                  PERFORM 102-COMPARE1TO2
               WHEN NOT FS-FC-F1 AND     FS-FC-F2
                  PERFORM 111-MOVE1OUT2-AFTER
               WHEN     FS-FC-F1 OR  NOT FS-FC-F2
                  PERFORM 112-MOVE2OUT3-AFTER
           END-EVALUATE.
      *****************************************************************
      *  This routine should compare if line from f1 & f2 are the same
       102-COMPARE1TO2.
           EVALUATE FILEIN1-ENREG
              WHEN  FILEIN2-ENREG
                 PERFORM 122-MOVE12OUT1
              WHEN OTHER
                 PERFORM 123-MOVE1OUT2
                 PERFORM 124-MOVE2OUT3
           END-EVALUATE.
      *****************************************************************
      *  This routine should finish read FILEIN1 until its end.
       111-MOVE1OUT2-AFTER.
           PERFORM UNTIL FS-FC-F1
              PERFORM 123-MOVE1OUT2
              PERFORM 010-READ
           END-PERFORM.
      *****************************************************************
      *  This routine should finish read FILEIN2 until its end.
       112-MOVE2OUT3-AFTER.
           PERFORM UNTIL FS-FC-F2
              PERFORM 124-MOVE2OUT3
              PERFORM 010-READ
           END-PERFORM.
      *****************************************************************
      *  This routine should write data from FILEIN1 to file FILEOUT1
       122-MOVE12OUT1.
           WRITE FILEOUT1-ENREG FROM FILEIN1-ENREG.
      *****************************************************************
      *  This routine should write data from FILEIN1 to file FILEOUT2
       123-MOVE1OUT2.
           WRITE FILEOUT2-ENREG FROM FILEIN1-ENREG.
      *****************************************************************
      *  This routine should write data from FILEIN2 to file FILEOUT3
       124-MOVE2OUT3.
           WRITE FILEOUT3-ENREG FROM FILEIN2-ENREG.
      *                                                               *
      *****************************************************************
      *****************************************************************
      *  Routine 2 : Close files before closing the program.
      *****************************************************************
       999-FCLOS.
           CLOSE FILEIN1,
                 FILEIN2,
                 FILEOUT1,
                 FILEOUT2,
                 FILEOUT3.
       999-EXIT.
           EXIT.
