      *****************************************************************
      * Program name:    PGM012M
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
       PROGRAM-ID.    PGM012M.
       AUTHOR.        DEFAY E. 
       INSTALLATION.  COBOL DEVELOPMENT CENTER. 
       DATE-WRITTEN.  16/11/22. 
       DATE-COMPILED. 16/11/22. 
       SECURITY.      NON-CONFIDENTIAL.
      *****************************************************************
       DATA DIVISION. 
       WORKING-STORAGE SECTION.
       01 ZONE-A.
           02 MNT-A  PIC 9(5)  BINARY.
       01 ZONE-B.
           02 MNT-B  PIC 9(7)  COMP.
       01 ZONE-C.
           02 MNT-C  PIC 9(5)  COMP-4.
       01 ZONE-D.
           02 MNT-D  PIC 9(3)  BINARY.
       01 ZONE-E.
           02 MNT-E  PIC 9(7)  COMP-3.
       01 ZONE-F.
           02 MNT-F  PIC S9(4) COMP-3.
       LINKAGE SECTION.
       01 CAS     PIC X(01).
          88      IS-A VALUE 'A'.
          88      IS-B VALUE 'B'.
          88      IS-C VALUE 'C'.
          88      IS-D VALUE 'D'.
          88      IS-E VALUE 'E'.
          88      IS-F VALUE 'F'.
       01 MNT-X   PIC 9(6).
       01 COUNTER PIC 9(2).
      *****************************************************************
       PROCEDURE DIVISION USING CAS,
                                MNT-X,
                                COUNTER.
           DISPLAY '*========' COUNTER '========*'.
           PERFORM 100-CALL  THRU 100-EXIT.
           DISPLAY '*========='       '=========*'.
           EXIT PROGRAM.
      *****************************************************************
      *  This routine should 
      *****************************************************************
       100-CALL.
           DISPLAY '  MNT-X : ' MNT-X.
           EVALUATE TRUE 
              WHEN IS-A PERFORM 101-MVTOA
              WHEN IS-B PERFORM 102-MVTOB
              WHEN IS-C PERFORM 103-MVTOC
              WHEN IS-D PERFORM 104-MVTOD
              WHEN IS-E PERFORM 105-MVTOE
              WHEN IS-F PERFORM 106-MVTOF
           END-EVALUATE.
       100-EXIT. 
           EXIT.
      *****************************************************************
      *  Those routines MOVE MNT-X to MNT-*
      *****************************************************************
       101-MVTOA.
           MOVE MNT-X TO MNT-A.
           DISPLAY 'PIC 9(5)  BINARY'.
           DISPLAY '  MNT-A : ' MNT-A.
       102-MVTOB.
           MOVE MNT-X TO MNT-B.
           DISPLAY 'PIC 9(7)  COMP.'.
           DISPLAY '  MNT-B : ' MNT-B.
       103-MVTOC.
           MOVE MNT-X TO MNT-C.
           DISPLAY 'PIC 9(5)  COMP-4.'.
           DISPLAY '  MNT-C : ' MNT-C.
       104-MVTOD.
           MOVE MNT-X TO MNT-D.
           DISPLAY 'PIC 9(3)  BINARY.'.
           DISPLAY '  MNT-D : ' MNT-D.
       105-MVTOE.
           MOVE MNT-X TO MNT-E.
           DISPLAY 'PIC 9(7)  COMP-3.'.
           DISPLAY '  MNT-E : ' MNT-E.
       106-MVTOF.
           MOVE MNT-X TO MNT-F.
           DISPLAY 'PIC S9(4) COMP-3.'.
           DISPLAY '  MNT-F : ' MNT-F.