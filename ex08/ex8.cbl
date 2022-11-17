      *****************************************************************
      * Program name:    PGM008
      *
      * Original author: DEFAY E.                                
      *
      * Maintenance Log                                              
      * Date      Author   Maintenance Requirement               
      * --------- -------- --------------------------------------- 
      * 15/11/22  IBMUSER  Using file FILEIN : i.e. ibmuser.files(set1)      
      * 15/11/22  IBMUSER  Using parm SYSIN  : i.e. f      
      * 16/11/22  IBMUSER  Adding FILEOUTs   : To write data inside      
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
      /    FILEIN
           SELECT FILEIN
           ASSIGN TO FILEIN
           FILE STATUS is WS-FS-STATUS.
      /    FILEOUT1
           SELECT FILEOUT1
           ASSIGN TO FILEOUT1.
      /    FILEOUT2
           SELECT FILEOUT2
           ASSIGN TO FILEOUT2.
       DATA DIVISION.
       FILE SECTION. 
       FD FILEIN.
       01  STRUCT-FILEIN.
           02 F-COMPTE   PIC 9(06).
           02 F-NOM      PIC X(15).
           02 F-SOLDER   PIC 9(07).
           02 F-DT-MVT   PIC X(10).
           02 F-ETAT     PIC X(01).
           02 F-DEPT     PIC 9(02).
           02 F-LIBRE    PIC X(39).
       FD FILEOUT1.
       01  STRUCT-FILEOUT1.
           02 F-COMPTE   PIC 9(06).
           02 F-NOM      PIC X(15).
           02 F-SOLDER   PIC 9(07).
           02 F-DT-MVT   PIC X(10).
           02 F-ETAT     PIC X(01).
           02 F-DEPT     PIC 9(02).
           02 F-LIBRE    PIC X(39).
       FD FILEOUT2.
       01  STRUCT-FILEOUT2.
           02 F-COMPTE   PIC 9(06).
           02 F-NOM      PIC X(15).
           02 F-SOLDER   PIC 9(07).
           02 F-DT-MVT   PIC X(10).
           02 F-ETAT     PIC X(01).
           02 F-DEPT     PIC 9(02).
           02 F-LIBRE    PIC X(39).
      *****************************************************************
       WORKING-STORAGE SECTION.
       01 WS-FS-STATUS   PIC X(02).
           88 F-END-READ VALUE '10'.
       01 WS-FS-RL       PIC 9(05) VALUE 0.
       01 WS-FS-TL       PIC 9(05) VALUE 0.
       01 WS-FS-FL       PIC 9(05) VALUE 0.
       01 PJ-CHR-DEFAULT PIC X     VALUE 'f'.
      / Parameter from JCL run 
       01 PJ-CHR         PIC X.
      *****************************************************************
       PROCEDURE DIVISION.
           PERFORM 000-PARMS.
           PERFORM 000-OFILE.
           PERFORM 200-DISPV THRU 200-EXIT.
           PERFORM 100-FILER THRU 100-EXIT.
           PERFORM 300-EXITP THRU 300-EXIT.
           PERFORM 000-CFILE.
           STOP RUN.
      *****************************************************************
      *  This routine handle parameters
      *****************************************************************
       000-PARMS.
           ACCEPT PJ-CHR.
           IF PJ-CHR = SPACE OR LOW-VALUE THEN
              PERFORM 001-DEFVA
           END-IF.
       001-DEFVA.
           MOVE PJ-CHR-DEFAULT TO PJ-CHR.
      *****************************************************************
      *  Those routines handle files I/O
      *****************************************************************
       000-OFILE.
           OPEN INPUT FILEIN.
           OPEN OUTPUT FILEOUT1.
           OPEN OUTPUT FILEOUT2.
       000-CFILE.
           CLOSE FILEIN.
           CLOSE FILEOUT1.
           CLOSE FILEOUT2.
      *****************************************************************
      *  This routine should iterate over the file, line by line
      *****************************************************************
       100-FILER.
           PERFORM UNTIL F-END-READ
              READ FILEIN
                 NOT AT END
                    PERFORM 110-CHECK
              END-READ
           END-PERFORM.
       100-EXIT. 
           EXIT.
      *****************************************************************
      *  Check condition for each line and apply incrementations.
      *****************************************************************
       110-CHECK.
           PERFORM 111-INCRR
           EVALUATE F-ETAT OF FILEIN 
               WHEN PJ-CHR 
                  PERFORM 112-INCRT
                  PERFORM 114-OUTPUT1
                  PERFORM 120-DISPL THRU 120-EXIT
               WHEN OTHER
                  PERFORM 113-INCRF
                  PERFORM 115-OUTPUT2
                  CONTINUE
           END-EVALUATE.
      *****************************************************************
      *  Incrementation methods
      *****************************************************************
       111-INCRR.
           COMPUTE WS-FS-RL = WS-FS-RL + 1.
       112-INCRT.
           COMPUTE WS-FS-TL = WS-FS-TL + 1.
       113-INCRF.
           COMPUTE WS-FS-FL = WS-FS-FL + 1.
      *****************************************************************
      *  Output methods
      *****************************************************************
       114-OUTPUT1.
           MOVE STRUCT-FILEIN TO STRUCT-FILEOUT1.
           WRITE STRUCT-FILEOUT1.
       115-OUTPUT2.
           MOVE STRUCT-FILEIN TO STRUCT-FILEOUT2.
           WRITE STRUCT-FILEOUT2.
      *****************************************************************
      *  This routine should display a line of the file.
      *****************************************************************
       120-DISPL.
           DISPLAY STRUCT-FILEIN OF FILEIN.
       120-EXIT.
           EXIT.
      *****************************************************************
      *  This routine should display variables (if any)
      *****************************************************************
       200-DISPV.
           DISPLAY "200-DISPV".
           DISPLAY "    PJ-CHR : " PJ-CHR.
       200-EXIT.
           EXIT.
      *****************************************************************
      *  This routine should close the program (after some displays)
      *****************************************************************
       300-EXITP.
           DISPLAY "300-EXITP".
           DISPLAY "    PJ-CHR   : " PJ-CHR.
           DISPLAY '    WS-FS-RL : ' WS-FS-RL.
           DISPLAY '    WS-FS-TL : ' WS-FS-TL.
           DISPLAY '    WS-FS-FL : ' WS-FS-FL.
       300-EXIT.
           EXIT.