      *****************************************************************
      * Program name:    PGM014
      *
      * Original author: DEFAY E.           
      *
      * Purpose : Comparing 2 files (A & B)
      *          If 2 lines are equal -> print   on file 1
      *          If 2 lines are diff  -> print A on file 2
      *                               && print B on file 3
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
       01 FILEIN-STATUS.
           05 FS-FILEIN1     PIC X(2).
               88 FS-FC-F1     VALUE '10'.
           05 FS-FILEIN2     PIC X(2).
               88 FS-FC-F2     VALUE '10'.
       01 FILEOUT-UNUSED-STATUS.
           05 FS-FILEOUT1    PIC X(2).
           05 FS-FILEOUT2    PIC X(2).
           05 FS-FILEOUT3    PIC X(2).

      *****************************************************************
      *  Program : Setup, run main routine and exit.
      *    
      *    Main purpose
      *    - 0xx : Input/Output section
      *    - 1xx : Compare files
      *    - 9xx : Close files
      *
      *    Input/Output managment
      *    - x1x : Perform a READ
      *    - x2x : Perform a WRITE
      *
      *    Specials
      *    - xxx : OTHERS
      *****************************************************************
       PROCEDURE DIVISION.
           PERFORM 000-PARAM
           PERFORM 001-IOPEN
           PERFORM 002-OOPEN
           PERFORM 100-FILES
           PERFORM 999-FCLOS
           GOBACK
           .
      *                                                               *
      *****************************************************************

      *****************************************************************
      *  Routine 0 : Setting up the program with Params & Files.
      *****************************************************************

       000-PARAM.
      *****************************************************************
      *  This routine should setup params (if any)
           CONTINUE
           .

      *****************************************************************
      *  Those routines should manage file opening (if any)
       001-IOPEN.
           OPEN INPUT  FILEIN1,
                       FILEIN2
           .
       002-OOPEN.
           OPEN OUTPUT FILEOUT1,
                       FILEOUT2,
                       FILEOUT3
           .

       010-READ.
      *****************************************************************
      *  This routine should manage file reading
           READ FILEIN1
           READ FILEIN2
           .
      *****************************************************************

      *****************************************************************
      *  Routine 1 : Read, compare 2 files and write in 3 other files.
      *****************************************************************
       100-FILES.
      *****************************************************************
      *  This routine should read files 1 & 2 until one is finish (LbL)
           PERFORM UNTIL (FS-FC-F1 OR FS-FC-F2)
                PERFORM 010-READ
                PERFORM 101-COMPARE
           END-PERFORM
           .

       101-COMPARE.
      *****************************************************************
      *  This routine should check files-status                                                             
           EVALUATE TRUE
               WHEN NOT (FS-FC-F1 OR FS-FC-F2)
                  PERFORM 102-COMPARE1TO2
               WHEN NOT FS-FC-F1 AND     FS-FC-F2
                  PERFORM 111-MOVE1OUT2-AFTER
               WHEN     FS-FC-F1 OR  NOT FS-FC-F2
                  PERFORM 112-MOVE2OUT3-AFTER
           END-EVALUATE
           .

       102-COMPARE1TO2.
      *****************************************************************
      *  This routine should compare if line from f1 & f2 are the same
           EVALUATE FILEIN1-ENREG
              WHEN  FILEIN2-ENREG
                 PERFORM 122-MOVE12OUT1
              WHEN OTHER
                 PERFORM 123-MOVE1OUT2
                 PERFORM 124-MOVE2OUT3
           END-EVALUATE
           .

       111-MOVE1OUT2-AFTER.
      *****************************************************************
      *  This routine should finish read FILEIN1 until its end.
           PERFORM UNTIL FS-FC-F1
              PERFORM 123-MOVE1OUT2
              PERFORM 010-READ
           END-PERFORM
           .

       112-MOVE2OUT3-AFTER.
      *****************************************************************
      *  This routine should finish read FILEIN2 until its end.
           PERFORM UNTIL FS-FC-F2
              PERFORM 124-MOVE2OUT3
              PERFORM 010-READ
           END-PERFORM
           .

       122-MOVE12OUT1.
      *****************************************************************
      *  This routine should write data from FILEIN1 to file FILEOUT1
           WRITE FILEOUT1-ENREG FROM FILEIN1-ENREG
           .

       123-MOVE1OUT2.
      *****************************************************************
      *  This routine should write data from FILEIN1 to file FILEOUT2
           WRITE FILEOUT2-ENREG FROM FILEIN1-ENREG
           .

       124-MOVE2OUT3.
      *****************************************************************
      *  This routine should write data from FILEIN2 to file FILEOUT3
           WRITE FILEOUT3-ENREG FROM FILEIN2-ENREG
           .

      *****************************************************************
      *  Routine 2 : Close files before closing the program.
      *****************************************************************
       999-FCLOS.
           CLOSE FILEIN1,
                 FILEIN2,
                 FILEOUT1,
                 FILEOUT2,
                 FILEOUT3
           .
