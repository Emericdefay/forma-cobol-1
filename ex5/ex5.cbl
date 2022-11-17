      *****************************************************************
      * Program name:    PGM005                               
      * Original author: DEFAY E.                                
      *
      * Maintenance Log                                              
      * Date      Author   Maintenance Requirement               
      * --------- -------- --------------------------------------- 
      * 15/11/22  IBMUSER  Created for practice       
      *                                                               
      *****************************************************************
       IDENTIFICATION DIVISION.
       PROGRAM-ID.    PGM005.
       AUTHOR.        DEFAY E. 
       INSTALLATION.  COBOL DEVELOPMENT CENTER. 
       DATE-WRITTEN.  15/11/22. 
       DATE-COMPILED. 15/11/22. 
       SECURITY.      NON-CONFIDENTIAL.
      *****************************************************************
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-NOTE     PIC 99.
           88 NUL         VALUE 00.
           88 MEDIOCRE    VALUE 01 THRU 08.
           88 MOYEN       VALUE 09 THRU 12.
           88 ASSEZ-BIEN  VALUE 13 THRU 14.
           88 BIEN        VALUE 13 THRU 16.
           88 TRES-BIEN   VALUE 17 THRU 18.
           88 EXCELLENT   VALUE 19 THRU 20.
      *****************************************************************
       PROCEDURE DIVISION.
           PERFORM 000-STEP1 THRU 000-EXIT.
           PERFORM 100-STEP2 THRU 100-EXIT.
           PERFORM 200-STEP3 THRU 200-EXIT.
           PERFORM 300-STEP4 THRU 300-EXIT.
           GOBACK.
      *****************************************************************
      *  This routine should accept WS-NOTE from JCL EXE SYSIN
      *****************************************************************
       000-STEP1.
           DISPLAY "000-STEP1".
           ACCEPT WS-NOTE.
       000-EXIT.
           EXIT.
      *****************************************************************
      *  This routine should display variables
      *****************************************************************
       100-STEP2.
           DISPLAY "100-STEP2".
           DISPLAY 'WS-NOTE : ' WS-NOTE.
       100-EXIT.
           EXIT.
      *****************************************************************
      *  This routine should check note and make answers
      *****************************************************************
       200-STEP3.
           DISPLAY "100-STEP2".
           EVALUATE TRUE
              WHEN NUL
                 PERFORM 400-SAY-0     THRU 400-EXIT
              WHEN MEDIOCRE
                 PERFORM 400-SAY-8     THRU 401-EXIT
              WHEN MOYEN
                 PERFORM 400-SAY-8-12  THRU 402-EXIT
              WHEN ASSEZ-BIEN
                 PERFORM 400-SAY-12-14 THRU 403-EXIT
              WHEN BIEN
                 PERFORM 400-SAY-14-16 THRU 404-EXIT
              WHEN TRES-BIEN
                 PERFORM 400-SAY-16-18 THRU 405-EXIT
              WHEN EXCELLENT
                 PERFORM 400-SAY-18    THRU 406-EXIT
           END-EVALUATE.
       200-EXIT.
           EXIT.
      *****************************************************************
      *  This routine should close the program 
      *****************************************************************
       300-STEP4.
           DISPLAY "200-STEP3".
           DISPLAY "Everything is OK.".
       300-EXIT.
           EXIT.
      *****************************************************************
      *  This part is about texts to display
      *****************************************************************
       400-SAY-0.
           DISPLAY "It's a disappointment.".
       400-EXIT.
           EXIT. 

       400-SAY-8.
           DISPLAY 'You could do better.'.
       401-EXIT.
           EXIT. 

       400-SAY-8-12.
           DISPLAY 'Quite ok.'.
       402-EXIT.
           EXIT. 

       400-SAY-12-14.
           DISPLAY 'Cool, nice.'.
       403-EXIT.
           EXIT. 

       400-SAY-14-16.
           DISPLAY 'Well done.'.
       404-EXIT.
           EXIT. 

       400-SAY-16-18.
           DISPLAY 'Awesome.'.
       405-EXIT.
           EXIT. 

       400-SAY-18.
           DISPLAY 'Wow!'.
       406-EXIT.
           EXIT. 