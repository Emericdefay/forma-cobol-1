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
       SOURCE-COMPUTER. IBM-3081. 
       OBJECT-COMPUTER. IBM-3081. 
       INPUT-OUTPUT SECTION.
       FILE-CONTROL. 
      **COPYBOOK : PGM014FC
      *    SELECT file-name FILE()
      *    ASSIGN to FILE()
      *    FILE STATUS is FS-FILE().
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
      / COUNTERS
       01 WS-COUNTER     PIC 9(10).
       01 COUNTER-2      PIC 9(10).
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
      /    ALSO PERFORM : 
      /    PERFORM 001-FOPEN.
           PERFORM 100-FILES THRU 100-EXIT.
           PERFORM 999-FCLOS THRU 999-EXIT.
           GOBACK.

      *****************************************************************
      *  Routine 0 : Setting up the program with Params & Files.
      *****************************************************************
      *****************************************************************
      *  This routine should setup params (if any)
       000-PARAM.
           CONTINUE.
      *****************************************************************
      *  This routine should manage file opening (if any)
       001-FOPEN.
           OPEN INPUT  FILEIN1,
                       FILEIN2.
           OPEN OUTPUT FILEOUT1,
                       FILEOUT2,
                       FILEOUT3.
       000-EXIT.
           EXIT.

      *****************************************************************
      *  Routine 1 : Read, compare 2 files and write in 3 other files.
      *****************************************************************
      *****************************************************************
      *  This routine should read files 1 & 2 until one is finish (LbL)
       100-FILES.
           PERFORM 
              VARYING WS-COUNTER FROM 1 BY 1
              UNTIL (FS-FC-F1 OR FS-FC-F2)
                 READ FILEIN1 
                 READ FILEIN2
                 AT END     PERFORM 110-WHICH-END
                 NOT AT END PERFORM 101-COMPARE1TO2
              END-READ
           END-PERFORM.

       100-EXIT.
           EXIT.
      *****************************************************************
      *  This routine should compare if line from f1 & f2 are the same
       101-COMPARE1TO2.
           EVALUATE FILEIN1-ENREG
              WHEN FILEIN2-ENREG
                 PERFORM 102-MOVE12OUT1
              WHEN OTHER
                 PERFORM 103-MOVE1OUT2
                 PERFORM 104-MOVE2OUT3
           END-EVALUATE.
      *****************************************************************
      *  This routine should write data from FILEIN1 to file FILEOUT1
       102-MOVE12OUT1.
           WRITE FILEOUT1-ENREG FROM FILEIN1-ENREG.
      *****************************************************************
      *  This routine should write data from FILEIN1 to file FILEOUT2
       103-MOVE1OUT2.
           WRITE FILEOUT2-ENREG FROM FILEIN1-ENREG.
      *****************************************************************
      *  This routine should write data from FILEIN2 to file FILEOUT3
       104-MOVE2OUT3.
           WRITE FILEOUT3-ENREG FROM FILEIN2-ENREG.
      *****************************************************************
      *  This routine should check which file is not finished.
       110-WHICH-END.
           IF NOT (FS-FC-F1 AND FS-FC-F2)
              IF FS-FC-F1
                 PERFORM 111-MOVE2OUT3-AFTER
              ELSE
                 PERFORM 112-MOVE1OUT2-AFTER
              END-IF
           END-IF.
      *****************************************************************
      *  This routine should finish read FILEIN1 until its end.
       112-MOVE1OUT2-AFTER.
           PERFORM VARYING COUNTER-2 FROM 1 BY 1
              UNTIL FS-FC-F1
                 READ FILEIN1
                 NOT AT END
                    IF COUNTER-2 > WS-COUNTER
                       PERFORM 103-MOVE1OUT2
                    END-IF
              END-READ
           END-PERFORM.
      *****************************************************************
      *  This routine should finish read FILEIN2 until its end.
       111-MOVE2OUT3-AFTER.
           PERFORM VARYING COUNTER-2 FROM 1 BY 1
              UNTIL FS-FC-F2
                 READ FILEIN2
                 NOT AT END
                    IF COUNTER-2 > WS-COUNTER
                       PERFORM 104-MOVE2OUT3
                    END-IF
              END-READ
           END-PERFORM.

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
