                       MSP430 C/C++ CODE GENERATION TOOLS
                            15.12.1.LTS Release Notes
                                    January 2016

================================================================================
Contents
================================================================================
1) Support Information

2) DWARF 4

3) Aggregate data in subsections

4) Intrinsics for saturated addition/subtraction

* Features Included from 15.9.0.STS:

5) STLport C++ RTS

6) COFF ABI no longer supported

7) RAM function support

8) Performance improvements

9) Module summary in linker map file

10) New compiler versioning


-------------------------------------------------------------------------------
1) Support Information
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
1.1) List of Fixed and Known Defects
-------------------------------------------------------------------------------

The list of defects fixed in this release as well as known issues can
be found in the file DefectHistory.txt.

-------------------------------------------------------------------------------
1.2) Compiler Wiki
-------------------------------------------------------------------------------

A Wiki has been established to assist developers in using TI Embedded
Processor Software and Tools.  Developers are encouraged to read and
contribute to the articles.  Registered users can update missing or
incorrect information.  There is a large section of compiler-related
material.  Please visit:

http://processors.wiki.ti.com/index.php?title=Category:Compiler

-------------------------------------------------------------------------------
1.3) Compiler Documentation Errata
-------------------------------------------------------------------------------

Errata for the "MSP430 Optimizing Compiler User's Guide" and the
"MSP430 Assembly Language User's Guide" is available online at the
Texas Instruments Embedded Processors CG Wiki:

http://processors.wiki.ti.com/index.php?title=Category:Compiler

under the 'Compiler Documentation Errata' link.

-------------------------------------------------------------------------------
1.4) TI E2E Community
-------------------------------------------------------------------------------

Questions concerning TI Code Generation Tools can be posted to the TI E2E
Community forums.  The "Development Tools" forum can be found at:

http://e2e.ti.com/support/development_tools/f/default.aspx

-------------------------------------------------------------------------------
1.5) Defect Tracking Database
-------------------------------------------------------------------------------

Compiler defect reports can be tracked at the Development Tools bug
database, SDOWP. The log in page for SDOWP, as well as a link to create
an account with the defect tracking database is found at:

https://cqweb.ext.ti.com/pages/SDO-Web.html

A my.ti.com account is required to access this page.  To find an issue
in SDOWP, enter your bug id in the "Find Record ID" box once logged in.
To find tables of all compiler issues click the queries under the folder:

"Public Queries" -> "Development Tools" -> "TI C-C++ Compiler"

With your SDOWP account you can save your own queries in your
"Personal Queries" folder.


-------------------------------------------------------------------------------
2) DWARF 4
-------------------------------------------------------------------------------
This release introduces the option to use the DWARF 4 Debugging Format.
DWARF 3 is still enabled by default, but DWARF 4 may be enabled by using
--symdebug:dwarf_version=4.  The RTS still uses DWARF 3.  DWARF versions 2, 3,
and 4 may be intermixed safely.

When DWARF 4 is enabled, type information will be placed in the new
.debug_types section.  At link time, duplicate type information will be
removed.  This method of type merging is superior to those used in DWARF 2 or 3
and will result in a smaller executable.  In addition, the size of intermediate
object files will be reduced in comparison to DWARF 3.

For more information, see:
http://processors.wiki.ti.com/index.php/DWARF_4


--------------------------------------------------------------------------------
3) Aggregate data in subsections
--------------------------------------------------------------------------------
The compiler will now place all aggregate data (arrays, structs, and unions)
into subsections. This gives the linker more granularity for removing unused
data during the final link step. The behavior can be controlled using the
--gen_data_subsections=on,off option. The default is on.


--------------------------------------------------------------------------------
4) Intrinsics for saturated addition/subtraction of signed short/long types.
--------------------------------------------------------------------------------
New intrinsics have been added for performing saturated addition and 
subtraction that use fewer instructions and cycles.  When the result of the
mathematical operation is smaller or larger than the return type, these 
intrinsics return the minimum or maximum value for the return type. 
	short       __saturated_add_signed_short(short, short);
  	long        __saturated_add_signed_long (long,  long);
	short       __saturated_sub_signed_short(short, short);
  	long        __saturated_sub_signed_long (long,  long);


--------------------------------------------------------------------------------
5) STLport C++ RTS
--------------------------------------------------------------------------------
v15.3.0 introduces the STLport C++03 RTS. The move to STLport will break ABI
compatibility with previous C++ RTS releases. Attempting to link old C++
object code with the new RTS will result in a link-time error. Suppressing
this error will likely result in undefined symbols or undefined behavior during
execution. Breakages are known to occur in particular for object code using
locale, iostream, and string.

In most cases, recompiling old source code with the new RTS should be safe.
However, for non-standard API extensions to the C++ library, compatibility is
not guaranteed. This includes usage of hash_map, slist, and rope.

Dependence between locale and iostream is increased in STLport. Usage of one
will likely cause the other to be linked as well. This may cause an additive
increase in both code size and initialization time.

C ABI compatibility will not be affected by this change.


--------------------------------------------------------------------------------
6) COFF ABI no longer supported
--------------------------------------------------------------------------------
As of version 15.6.0.STS of the MSP430 CGT, COFF ABI support is discontinued.
If COFF ABI support is needed for your application, please use MSP430 CGT
version 4.4.x.


--------------------------------------------------------------------------------
7) RAM function support
--------------------------------------------------------------------------------
The ramfunc attribute can be used to specify that a function will be placed in
and executed out of RAM. This allows the compiler to optimize functions for
RAM execution, as well as to automatically copy functions to RAM on flash-based
devices.

The attribute is applied to a function with GCC attribute syntax, as follows:
   __attribute__((ramfunc))
   void f(void) { ... }

The --ramfunc=on option can be used to indicate that the attribute should be
applied to all functions in a translations unit, eliminating the need for
source code modification.

For more information, see:
http://processors.wiki.ti.com/index.php/Ramfunc_Attribute


--------------------------------------------------------------------------------
8) Performance improvements
--------------------------------------------------------------------------------
v15.9.0 introduces two performance improvements.

With --opt_level=3 or 4, and --opt_for_speed=5, the compiler will attempt to 
unroll loops for performance improvement.

With --opt_level=3 or 4, and --opt_for_speed=4 or 5, the compiler will use a 
slightly more aggressive function inliner algorithm.  At other optimization 
settings the previous inlining behavior has not been changed.

Function inlining can additionally be controlled with existing PRAGMAs for
FUNC_ALWAYS_INLINE and FUNC_CANNOT_INLINE as well as options --auto_inline
--no_inlining, and --single_inline.  See the MSP430 Optimizing C/C++ COmpiler 
User's Guide for more details.


--------------------------------------------------------------------------------
9) Module summary in linker map file
--------------------------------------------------------------------------------
The linker map file now contains a module summary view. This view organizes
the object files by directory or library and displays the code, read-write, and
read-only size that the file contributed to the resulting executable.

Sample output:

MODULE SUMMARY

       Module                     code    ro data   rw data
       ------                     ----    -------   -------
    .\Application\
       file1.obj                  1146    0         920    
       file2.obj                  316     0         0      
    +--+--------------------------+-------+---------+---------+
       Total:                     1462    0         920 

 mylib.lib
       libfile1.obj               500     0         0      
       libfile2.obj               156     4         0      
       libfile3.obj               122     0         20      
    +--+--------------------------+-------+---------+---------+
       Total:                     778     4         20

       Heap:                      0       0         0      
       Stack:                     0       0         1024   
       Linker Generated:          424     200       0      
    +--+--------------------------+-------+---------+---------+
       Grand Total:               2664    204       1964


--------------------------------------------------------------------------------
10) New compiler versioning
--------------------------------------------------------------------------------
Compiler versioning will now include both long term and short term releases.
  year.month.patch.[LTS|STS]

Long term releases:  This is the release same model currently supported today 
with periodic patch releases for approximately 2 years.

Short term releases:  Between LTS releases there will be additional short 
term releases that will be supported only until the next STS or LTS release.
These releases will be available through the Code Composer Studio Apps Center
in future CCS releases.
