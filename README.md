<p align="center">
  <a href="" rel="noopener">
 <img width=200px height=200px src="https://www.krescentglobal.com/images/iphone/cobol-1.png" alt="COBOL LOGO"></a>
</p>

<h3 align="center">COBOL POE - Part 1</h3>

<div align="center">

[![Status](https://img.shields.io/badge/status-active-success.svg)]()
[![GitHub Issues](https://img.shields.io/github/issues/emericdefay/forma-cobol-1.svg)](https://github.com/emericdefay/forma-cobol-1/issues)
[![GitHub Pull Requests](https://img.shields.io/github/issues-pr/emericdefay/forma-cobol-1.svg)](https://github.com/emericdefay/forma-cobol-1/pulls)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](/LICENSE)

</div>

---

<p align="center"> Exercices 1-12 POE cobol
    <br> 
</p>

## 📝 Table of Contents

- [About](#about)
- [Getting Started](#getting_started)
- [Built Using](#built_using)
- [Authors](#authors)
- [Acknowledgments](#acknowledgement)

## 🧐 About <a name = "about"></a>

This repository is here to help you understand the basics of cobol with some exercices.  
Those exercices are made by Global Knowledge, here stand modests corrections. 

## 🏁 Getting Started <a name = "getting_started"></a>


### Prerequisites

- Z/OS
  - A program section
  - A Loadlib 
  - A Compiler

Your program section should be a standard PDS.  

Your Loadlib section shoul be a specific PDS.

``` jcl
//* You can create the loadlib, with this kind of JCL script.
//SYSUT2 DD DSN=IBMUSER.PROG.LOAD,DISP=(NEW,CATLG,CATLG),
// UNIT=SYSDA,SPACE=(CYL,(60,20),RLSE),          
// DCB=(RECFM=U,LRECL=0,BLKSIZE=32760,DSORG=PO), 
// DSNTYPE=LIBRARY                               
```

### Installing

You can transfer, copy/paste the files but it's recommanded to just check them.


## ⛏️ Built Using <a name = "built_using"></a>

- [Z/OS](https://expressjs.com/) - Server Framework
- [JCL](https://vuejs.org/) - Web Framework
- [Cobol](https://nodejs.org/en/) - Server Environment

## ✍️ Authors <a name = "authors"></a>

- [@emericdefay](https://github.com/emericdefay) - Corrections propositions


## 🎉 Acknowledgements <a name = "acknowledgement"></a>

- Alteca
- Global Knowledge
- Pole Emploie
