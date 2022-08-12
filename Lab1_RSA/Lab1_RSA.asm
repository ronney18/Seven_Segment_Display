/*
	Name: Ronney Sanchez
	Date: 11/15/16
	Course: CTE210 Microcomputers
	Program: Lab 1 Functions and 7 Segment Display
	Description: This program store a ten element array of 8 bit instructions of how to display a number to a 7 segment display and calls the display
	function with a parameter to load one of the instruction from the array and display it on the seven segment.
*/
.device ATmega328P ;The device that we are using is the ATmega328P
.equ size = 10 ;Equate the size to 10
.dseg ;Data segment to allocate array memory
myArray: .byte size ;Allocate 10 bytes for the array

.cseg ;Current segment as code
.org 0 ;Starting at address 0

.def limit = r19 ;Define the limit as register 19
.def temp = r16 ;Define temp as register 16
.def number = r25 ;Define the number register as register 25

ldi YL, low(myArray) ;Load the low byte of the array to the low Y register
ldi YH, high(myArray) ;Load the high byte of the array to the high Y register
ldi limit, size ;Load the size of the array to the limit register

ldi temp, 0b01111110 ;Load the seven segment display instruction for 0 to temp
st Y, temp ;Store the instruction to the Y register

adiw Y, 1 ;Move the Y pointer by 1 unit

ldi temp, 0b00001100 ;Load the seven segment display instruction for 1 to temp
st Y+, temp ;Store the instruction to the Y register and post increment pointer

ldi temp, 0b10110110 ;Load the seven segment display instruction for 2 to temp
st Y+, temp ;Store the instruction to the Y register and post increment pointer

ldi temp, 0b10011110 ;Load the seven segment display instruction for 3 to temp
st Y+, temp ;Store the instruction to the Y register and post increment pointer

ldi temp, 0b11001100 ;Load the seven segment display instruction for 4 to temp
st Y+, temp ;Store the instruction to the Y register and post increment pointer

ldi temp, 0b11011010 ;Load the seven segment display instruction for 5 to temp
st Y+, temp ;Store the instruction to the Y register and post increment pointer

ldi temp, 0b11111010 ;Load the seven segment display instruction for 6 to temp
st Y+, temp ;Store the instruction to the Y register and post increment pointer

ldi temp, 0b00001110 ;Load the seven segment display instruction for 7 to temp
st Y+, temp ;Store the instruction to the Y register and post increment pointer

ldi temp, 0b11111110 ;Load the seven segment display instruction for 8 to temp
st Y+, temp ;Store the instruction to the Y register and post increment pointer

ldi temp, 0b11001110 ;Load the seven segment display instruction for 9 to temp
st Y, temp ;Store the instruction to the Y register

sbiw Y, (size - 1) ;Move the Y pointer back to element 0
ldi temp, 0xFF ;Load all 1s to temp
out DDRD, temp ;Output all the 1s to the Data Direction Register in Port D
ldi number, 5 ;Load 5 to the number register

call display ;Call the display function

finish:
	jmp finish ;Program ended

display:
	ldi YL, low(myArray) ;Move the Y pointer to the start of the array
	ldi YH, high(myArray)
	add YL, number ;Move the Y pointer the number units to the right 
	ldi temp, 0 ;Load 0 to temp
	adc YH, temp ;Add the value with the carry to the high byte of Y
	ld temp, Y ;Y now points to the segment
	out PORTD, temp ;Output the instuction from temp to PORT D
	ret ;Return to the caller
	
	
