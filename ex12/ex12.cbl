      *****************************************************************
      * Program name:    PGM012
      *
      * Original author: DEFAY E.                                
      *
      * Maintenance Log                                              
      * Date      Author   Maintenance Requirement               
      * --------- -------- --------------------------------------- 
      * 16/11/22  IBMUSER  Using SYSIN parameters :  CAS & MNT-X   
      *                                                               
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.    PGM012.
       AUTHOR.        DEFAY E. 
       INSTALLATION.  COBOL DEVELOPMENT CENTER. 
       DATE-WRITTEN.  16/11/22. 
       DATE-COMPILED. 16/11/22. 
       SECURITY.      NON-CONFIDENTIAL.
      *****************************************************************
       ENVIRONMENT DIVISION. 
       INPUT-OUTPUT SECTION. 
       FILE-CONTROL. 
           SELECT COMBINATIONS
           ASSIGN TO FILEIN
      *    ORGANIZATION IS INDEXED
      *    ACCESS MODE IS SEQUENTIAL
      *    RECORD KEY IS data-name-1
           FILE STATUS IS FC-FS-COM.
      *****************************************************************
       DATA DIVISION. 
       FILE SECTION. 
       FD COMBINATIONS
           RECORD CONTAINS 80 CHARACTERS.
       01 ZONE-ACCEPT.
           02 CAS     PIC X(01).
           02 FILLER  PIC X.
           02 MNT-X   PIC 9(6).
           02 FILLER  PIC X(72).
       WORKING-STORAGE SECTION.
       01 WS-COUNTER  PIC 9(02).
       01 FC-FS-COM   PIC X(02).
           88 FS-COM-END VALUE '10'.
       01 WS-CALL-PGM PIC X(08) VALUE "PGM012M1".
      *****************************************************************
       PROCEDURE DIVISION.
           PERFORM 000-RFILE THRU 000-EXIT.
           PERFORM 100-READF THRU 100-EXIT.
           PERFORM 999-CFILE THRU 999-EXIT.
           STOP RUN.
      *****************************************************************
      *  This routine should 
      *****************************************************************
       000-RFILE.
           OPEN INPUT COMBINATIONS.
       000-EXIT. 
           EXIT.

       999-CFILE.
           CLOSE COMBINATIONS.
       999-EXIT. 
           EXIT.
      *****************************************************************
      *  This routine should 
      *****************************************************************
       100-READF.
           PERFORM VARYING WS-COUNTER FROM 1 BY 1
              UNTIL FS-COM-END
              READ COMBINATIONS  
                 NOT AT END
                    PERFORM 101-CALL
              END-READ
           END-PERFORM.
       100-EXIT. 
           EXIT.
      *****************************************************************
      *  Those routines MOVE MNT-X to MNT-*
      *****************************************************************
       101-CALL.
           CALL WS-CALL-PGM USING BY CONTENT CAS,
                                  BY CONTENT MNT-X,
                                  BY CONTENT WS-COUNTER.