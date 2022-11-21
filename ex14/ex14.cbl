      *****************************************************************
      * Program name:    PGM014
      *
      * Original author: DEFAY E.                                
      *
      * Maintenance Log                                              
      * Date      Author   Maintenance Requirement               
      * --------- -------- --------------------------------------- 
      * 21/11/22  IBMUSER  Using SYSIN parameters :  CAS & MNT-X   
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
      /    SELECT file-name FILE()
      /    ASSIGN to FILE()
      /    FILE STATUS is FS-FILE().
       COPY PGM014C2 REPLACING ==()== BY ==IN1==.
       COPY PGM014C2 REPLACING ==()== BY ==IN2==.
       COPY PGM014C2 REPLACING ==()== BY ==OUT1==.
       COPY PGM014C2 REPLACING ==()== BY ==OUT2==.
       COPY PGM014C2 REPLACING ==()== BY ==OUT3==.
      *****************************************************************
       DATA DIVISION. 
      *****************************************************************
       FILE SECTION.
      /FD ()  
      /    RECORD CONTAINS 80 CHARACTERS.
      /01 ()-ENREG.
      /    02 ()-COMPTE  PIC 9(6).
      /    02 ()-NOM     PIC X(20).
      /    02 ()-DATE    PIC X(10).
      /    02 FILLER      PIC X(44).
      / FILEIN1
       COPY PGM014C1 REPLACING ==()== BY ==FILEIN1==.
      / FILEIN2
       COPY PGM014C1 REPLACING ==()== BY ==FILEIN2==.
      / FILEOUT1
       COPY PGM014C1 REPLACING ==()== BY ==FILEOUT1==.
      / FILEOUT2
       COPY PGM014C1 REPLACING ==()== BY ==FILEOUT2==.
      / FILEOUT3
       COPY PGM014C1 REPLACING ==()== BY ==FILEOUT3==.
      *****************************************************************
       WORKING-STORAGE SECTION.
      / COUNTER
       01 WS-COUNTER     PIC 9(10).
       01 COUNTER-2      PIC 9(10).
       01 FS-FILEIN1     PIC X(2).
           88 FS-FC-F1   VALUE '10'.
       01 FS-FILEIN2     PIC X(2).
           88 FS-FC-F2   VALUE '10'.
       01 FS-FILEOUT1    PIC X(2).
       01 FS-FILEOUT2    PIC X(2).
       01 FS-FILEOUT3    PIC X(2).
      *****************************************************************
       PROCEDURE DIVISION.
           PERFORM 000-PARAM THRU 000-EXIT.
      /    ALSO PERFORM : 
      /    PERFORM 001-FOPEN.
           PERFORM 100-FILES THRU 100-EXIT.
           PERFORM 999-FCLOS THRU 999-EXIT.
           GOBACK.
      *****************************************************************
      *  This routine should setup params (if any)
      *****************************************************************
       000-PARAM.
           CONTINUE.
      *****************************************************************
      *  This routine should manage file opening (if any)
      *****************************************************************
       001-FOPEN.
           OPEN INPUT FILEIN1.
           OPEN INPUT FILEIN2.
           OPEN OUTPUT FILEOUT1.
           OPEN OUTPUT FILEOUT2.
           OPEN OUTPUT FILEOUT3.
       000-EXIT.
           EXIT.
      *****************************************************************
      *  This routine should go line by line from file 1
      *****************************************************************
       100-FILES.
           PERFORM 
              VARYING WS-COUNTER FROM 1 BY 1
              UNTIL (FS-FC-F1 OR FS-FC-F2)
              READ FILEIN1 
              READ FILEIN2
                 AT END PERFORM 110-WHICH-END
                 NOT AT END PERFORM 101-COMPARE1TO2
              END-READ
           END-PERFORM.

       100-EXIT.
           EXIT.
      *****************************************************************
      *  This routine should ccompare if line from f1 & f2 are the same
      *****************************************************************
       101-COMPARE1TO2.
           IF FILEIN1-ENREG = FILEIN2-ENREG
              PERFORM 102-MOVE12OUT1
           ELSE
              PERFORM 103-MOVE1OUT2
              PERFORM 104-MOVE2OUT3
           END-IF.
      *****************************************************************
       102-MOVE12OUT1.
           MOVE FILEIN1-ENREG TO FILEOUT1-ENREG.
           WRITE FILEOUT1-ENREG.

       103-MOVE1OUT2.
           MOVE FILEIN1-ENREG TO FILEOUT2-ENREG.
           WRITE FILEOUT2-ENREG.

       104-MOVE2OUT3.
           MOVE FILEIN2-ENREG TO FILEOUT3-ENREG.
           WRITE FILEOUT3-ENREG.
      *****************************************************************
       110-WHICH-END.
           IF NOT (FS-FC-F1 AND FS-FC-F2)
              IF FS-FC-F1
                 PERFORM 114-MOVE2OUT3-AFTER
              ELSE
                 PERFORM 113-MOVE1OUT2-AFTER
              END-IF
           END-IF.

       113-MOVE1OUT2-AFTER.
           PERFORM VARYING COUNTER-2 FROM 1 BY 1
              UNTIL FS-FC-F1
              READ FILEIN1
                 NOT AT END
                    IF COUNTER-2 > WS-COUNTER
                       PERFORM 103-MOVE1OUT2
                    END-IF
              END-READ
           END-PERFORM.

       114-MOVE2OUT3-AFTER.
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
      *  This routine should manage files closing
      *****************************************************************
       999-FCLOS.
           CLOSE FILEIN1.
           CLOSE FILEIN2.
           CLOSE FILEOUT1.
           CLOSE FILEOUT2.
           CLOSE FILEOUT3.
       999-EXIT.
           EXIT.