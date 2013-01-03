
.section .data
tag_core: .int 0 
tag_mem: .int 0 
tag_videotext: .int 0 
tag_ramdisk: .int 0 
tag_initrd2: .int 0 
tag_serial: .int 0 
tag_revision: .int 0 
tag_videolfb: .int 0 
tag_cmdline: .int 0 

.section .text
.globl FindTag
FindTag:
	tag .req r0
	tagList .req r1
	tagAddr .req r2
	push {lr}
	sub tag,#1
	cmp tag,#8
	movhi tag,#0
	pophi {pc}

	ldr tagList,=tag_core
tagReturn$:
	add tagAddr,tagList, tag,lsl #2
	ldr tagAddr,[tagAddr]

	teq tagAddr,#0
	movne r0,tagAddr
	popne {pc}

	ldr tagAddr,[tagList]
	teq tagAddr,#0
	movne r0,#0
	popne {pc}

	mov tagAddr,#0x100
	push {r4}
	tagIndex .req r3
	oldAddr .req r4
tagLoop$:
	ldrh tagIndex,[tagAddr,#4]
	subs tagIndex,#1
	poplt {r4}
	blt tagReturn$

	add tagIndex,tagList, tagIndex,lsl #2
	ldr oldAddr,[tagIndex]
	teq oldAddr,#0
	.unreq oldAddr
	streq tagAddr,[tagIndex]

	ldr tagIndex,[tagAddr]
	add tagAddr, tagIndex,lsl #2
	b tagLoop$
                    
    .unreq tag
    .unreq tagList
    .unreq tagAddr
    .unreq tagIndex

