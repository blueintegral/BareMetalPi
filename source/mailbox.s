.globl GetMailboxBase
GetMailboxBase: 
	ldr r0,=0x2000B880
	mov pc,lr

.globl MailboxRead
MailboxRead: 
	and r3,r0,#0xf
	mov r2,lr
	bl GetMailboxBase
	mov lr,r2
	
	rightmail$:
		wait1$: 
			ldr r2,[r0,#24]
			tst r2,#0x40000000
			bne wait1$
			
		ldr r1,[r0,#0]
		and r2,r1,#0xf
		teq r2,r3
		bne rightmail$

	and r0,r1,#0xfffffff0
	mov pc,lr

.globl MailboxWrite
MailboxWrite: 
	and r2,r1,#0xf
	and r1,r0,#0xfffffff0
	orr r1,r2
	mov r2,lr
	bl GetMailboxBase
	mov lr,r2

	wait2$: 
		ldr r2,[r0,#24]
		tst r2,#0x80000000
		bne wait2$

	str r1,[r0,#32]
	mov pc,lr
