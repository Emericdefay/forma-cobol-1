//JCLCOMP JOB NOTIFY=&SYSUID,
//            MSGLEVEL=(1,1),
//            MSGCLASS=A,
//            CLASS=A
// SET PGMCBL=PGM003
//CALLIGY      EXEC IGYWCL
//STEPLIB      DD DSN=IGY410.SIGYCOMP,DISP=SHR
//COBOL.SYSIN  DD DSN=IBMUSER.PROG.CBL(&PGMCBL),DISP=SHR
//LKED.SYSLIB  DD DSN=IBMUSER.PROG.LOAD,DISP=SHR
//             DD DSN=CEE.SCEELKED,DISP=SHR
//LKED.SYSLMOD DD DSN=IBMUSER.PROG.LOAD(&PGMCBL),DISP=OLD
//