      *****************************************************************
      * Program name:    PGM011
      *
      * Original author: DEFAY E.                                
      *
      * Maintenance Log                                              
      * Date      Author   Maintenance Requirement               
      * --------- -------- --------------------------------------- 
      * 16/11/22  IBMUSER  Using SYSIN parameter : i.e. 1000    
      *                                                               
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.    PGM011.
       AUTHOR.        DEFAY E. 
       INSTALLATION.  COBOL DEVELOPMENT CENTER. 
       DATE-WRITTEN.  16/11/22. 
       DATE-COMPILED. 16/11/22. 
       SECURITY.      NON-CONFIDENTIAL.
      *****************************************************************
       ENVIRONMENT DIVISION. 
       INPUT-OUTPUT SECTION. 
       FILE-CONTROL. 
           SELECT SALARIES
           ASSIGN to FILEIN
      *    ORGANIZATION is INDEXED
      *    ACCESS MODE is SEQUENTIAL
      *    RECORD KEY is data-name-1
           FILE STATUS is FC-FS-FILEIN.
       DATA DIVISION. 
       FILE SECTION.
       FD SALARIES
           RECORD CONTAINS 80 CHARACTERS.
       01 SALARY.
             05 FD-SALARY       PIC 9(07).
             05 FILLER          PIC X(01).
             05 FD-NOTE         PIC X(01).
             05 FILLER          PIC X(01).
             05 FD-SENIORITY    PIC 9(07).
             05 FILLER          PIC X(63).
       WORKING-STORAGE SECTION.
       01 FD-AUGMENTATION PIC 9(07).
       01 WS-COUNTER      PIC 9(02).
       01 FC-FS-FILEIN    PIC X(02).
           88 FS-FILEIN-END VALUE '10'.
       01 WS-CALL-PGM     PIC X(08) VALUE "PGM011M1".
      *****************************************************************
       PROCEDURE DIVISION.
           PERFORM 000-PARAM THRU 000-EXIT.
           PERFORM 001-FOPEN THRU 001-EXIT.
           PERFORM 100-FILE  THRU 100-EXIT.
           PERFORM 200-DISPV THRU 200-EXIT.
           PERFORM 300-EXITP THRU 300-EXIT.
           PERFORM 999-FREAD THRU 999-EXIT.
           STOP RUN.
      *****************************************************************
      *  This routine should check if the seniority's of user is > 4 y
      *****************************************************************
       000-PARAM.
           CONTINUE.
       000-EXIT.
           EXIT.
      *****************************************************************
      *  This routine should check if the seniority's of user is > 4 y
      *****************************************************************
       001-FOPEN.
           OPEN INPUT SALARIES.
       001-EXIT.
           EXIT.
       999-FREAD.
           CLOSE SALARIES.
       999-EXIT.
           EXIT.
      *****************************************************************
      *  This routine should check if the seniority's of user is > 4 y
      *****************************************************************
       100-FILE.
           PERFORM VARYING WS-COUNTER FROM 1 BY 1
              UNTIL FS-FILEIN-END
              READ SALARIES 
                 NOT AT END
                    PERFORM 101-CALL
              END-READ
           END-PERFORM.
       100-EXIT. 
           EXIT.
      *****************************************************************
      *  This routine should check if the seniority's of user is > 4 y
      *****************************************************************
       101-CALL.
           CALL WS-CALL-PGM USING WS-COUNTER, 
                                  FD-SALARY,
                                  FD-NOTE,
                                  FD-SENIORITY,
                                  FD-AUGMENTATION. 
      *****************************************************************
      *  This routine should display variables (if any)
      *****************************************************************
       200-DISPV.
           DISPLAY "200-DISPV".
           DISPLAY "    FD-SALARY       : " FD-SALARY.
           DISPLAY "    FD-NOTE         : " FD-NOTE.
           DISPLAY "    FD-SENIORITY    : " FD-SENIORITY.
           DISPLAY "    FD-AUGMENTATION : " FD-AUGMENTATION.
           DISPLAY "    WS-CALL-PGM     : " WS-CALL-PGM.
       200-EXIT.
           EXIT.
      *****************************************************************
      *  This routine should close the program (after some displays)
      *****************************************************************
       300-EXITP.
           DISPLAY "300-EXITP".
       300-EXIT.
           EXIT.
