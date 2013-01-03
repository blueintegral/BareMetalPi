.section .data

.align 12 
.globl FrameBufferInfo 
FrameBufferInfo:
	.int 1024	
	.int 768	
	.int 1024	
	.int 768	
	.int 0		
	.int 24		
	.int 0		
	.int 0		
	.int 0		
	.int 0	


.section .text
.globl InitialiseFrameBuffer
InitialiseFrameBuffer:
	width .req r0
	height .req r1
	bitDepth .req r2
	cmp width,#4096
	cmpls height,#4096
	cmpls bitDepth,#32
	result .req r0
	movhi result,#0
	movhi pc,lr

	push {r4,lr}			
	fbInfoAddr .req r4
	ldr fbInfoAddr,=FrameBufferInfo
	str width,[r4,#0]
	str height,[r4,#4]
	str width,[r4,#8]
	str height,[r4,#12]
	str bitDepth,[r4,#20]
	.unreq width
	.unreq height
	.unreq bitDepth

	mov r0,fbInfoAddr
	mov r1,#1
	bl MailboxWrite
	
	mov r0,#1
	bl MailboxRead
		
	teq result,#0
	movne result,#0
	popne {r4,pc}

	pointerWait$:
		ldr result,[fbInfoAddr,#32]
		
		teq result,#0
		beq pointerWait$
				
	mov result,fbInfoAddr
	pop {r4,pc}
	.unreq result
	.unreq fbInfoAddr
