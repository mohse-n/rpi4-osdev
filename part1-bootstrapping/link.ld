/* m: "Every meaningful command script must have a SECTIONS command: it specifies a "picture" of the output file's layout." */

SECTIONS 
{
    /* m: "The special linker variable dot `.' always contains the current output location counter." Code below 
    tells that the output file will start at address 0x80000 in memory. */
    . = 0x80000;     /* Kernel load address for AArch64 */
    /* text section of the file. */
    .text : { KEEP(*(.text.boot)) *(.text .text.* .gnu.linkonce.t*) } /* What is KEEP used for? */
    .rodata : { *(.rodata .rodata.* .gnu.linkonce.r*) }
    PROVIDE(_data = .);
    .data : { *(.data .data.* .gnu.linkonce.d*) }
    .bss (NOLOAD) : { /* m: Typically bss (variables initialized with zero) sections are marked NOLOAD. Because it takes space in memory but to save time, don't have to be loaded. */
        . = ALIGN(16); /* m: set the output location to be 16-bytes-aligned. */
        __bss_start = .; /* m: bss starts from that address. */
        *(.bss .bss.*) /* m: content of bss. */
        *(COMMON) /*m: "*(COMMON) by itself refers to all uninitialized data from all input files." So this is also content of bss. */
        __bss_end = .;
    }
    _end = .;

   /DISCARD/ : { *(.comment) *(.gnu*) *(.note*) *(.eh_frame*) }
}
__bss_size = (__bss_end - __bss_start)>>3;
