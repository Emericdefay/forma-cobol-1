      *****************************************************************
      * Program name:    PGM008

      * Original author: DEFAY E.                                
      *
      * Maintenance Log                                              
      * Date      Author   Maintenance Requirement               
      * --------- -------- --------------------------------------- 
      * 15/11/22  IBMUSER  Created for practice       
      *                                                               
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.    PGM008.
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
           ASSIGN TO FILEIN
           ORGANIZATION is SEQUENTIAL.
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
      *01 WS-FS-STATUS   PIC x(01).
      *01 WS-FS-KEY      PIC x(01).
       01 WS-EOL         PIC A(01).
       01 WS-FS-RL       PIC 9(05) VALUE 0.
       01 WS-FS-TL       PIC 9(05) VALUE 0.
       01 WS-FS-FL       PIC 9(05) VALUE 0.
      *****************************************************************
       PROCEDURE DIVISION.
           PERFORM 000-OFILE.
           PERFORM 000-RFILE.
           PERFORM 100-STEP1 THRU 100-EXIT.
           PERFORM 200-STEP2 THRU 100-EXIT.
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
      *  This routine should accept the values WS-* from RUN
      *****************************************************************
       100-STEP1.
           DISPLAY "000-STEP1 : ACCEPT VARS".
           PERFORM UNTIL WS-EOL = 'Y'
              READ NOMFIC INTO STRUCT-FICHIER
              AT END MOVE 'Y' TO WS-EOL
              NOT AT END
                 COMPUTE WS-FS-RL = WS-FS-RL + 1
                 EVALUATE F-ETAT
                     WHEN '@' 
                        COMPUTE WS-FS-TL = WS-FS-TL + 1
                        PERFORM 101-DSPL THRU 101-EXIT
                     WHEN OTHER
                        COMPUTE WS-FS-FL = WS-FS-FL + 1
                        CONTINUE
                 END-EVALUATE
              END-READ
           END-PERFORM.
       100-EXIT.
           EXIT.
      *****************************************************************
      *  This routine should display a line
      *****************************************************************
       101-DSPL.
           DISPLAY STRUCT-FICHIER .
       101-EXIT.
           EXIT.
      *****************************************************************
      *  This routine should display variables before program end
      *****************************************************************
       200-STEP2.
           DISPLAY "200-STEP3 : EXIT".
           DISPLAY 'WS-FS-RL : ' WS-FS-RL.
           DISPLAY 'WS-FS-TL : ' WS-FS-TL.
           DISPLAY 'WS-FS-FL : ' WS-FS-FL.
           DISPLAY "Everything is OK.".
       200-EXIT.
           EXIT.
