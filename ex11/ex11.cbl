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
       PROGRAM-ID. PGM011.
       AUTHOR.        DEFAY E. 
       INSTALLATION.  COBOL DEVELOPMENT CENTER. 
       DATE-WRITTEN.  16/11/22. 
       DATE-COMPILED. 16/11/22. 
       SECURITY.      NON-CONFIDENTIAL.
      *****************************************************************
       DATA DIVISION. 
       WORKING-STORAGE SECTION.
       01 WS-SALARY       PIC 9(07) VALUE 0010000.
       01 WS-NOTE         PIC X(01) VALUE 'A'.
       01 WS-SENIORITY    PIC 9(07) VALUE 0000002.
       01 WS-AUGMENTATION PIC 9(07).
       01 WS-CALL-PGM     PIC X(08) VALUE "PGM011M1".
      *****************************************************************
       PROCEDURE DIVISION.
           PERFORM 100-CALL  THRU 100-EXIT.
           PERFORM 200-DISPV THRU 200-EXIT.
           PERFORM 300-EXITP THRU 300-EXIT.
           STOP RUN.
      *****************************************************************
      *  This routine should check if the seniority's of user is > 4 y
      *****************************************************************
       100-CALL.
           CALL WS-CALL-PGM USING WS-SALARY,
                                  WS-NOTE,
                                  WS-SENIORITY,
                                  WS-AUGMENTATION. 
       100-EXIT. 
           EXIT.
      *****************************************************************
      *  This routine should display variables (if any)
      *****************************************************************
       200-DISPV.
           DISPLAY "200-DISPV".
           DISPLAY "    WS-SALARY       : " WS-SALARY.
           DISPLAY "    WS-NOTE         : " WS-NOTE.
           DISPLAY "    WS-SENIORITY    : " WS-SENIORITY.
           DISPLAY "    WS-AUGMENTATION : " WS-AUGMENTATION.
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
