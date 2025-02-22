# FPGA driver for 7-segment 1-digit LED display
In this project I designed a driver in FPGA to control a single digit of a 7-Segment LED display. The Display is controlled directly without the help of an external chip.

I will cover three practical situations:
- Controlling an external common cathode display – figure 1A
- Controlling an external common anode display – figure 1B
- Controlling an internal common cathode display – figures 1C and 1D

The diagram for connecting a common cathode 7-Segment LED display to the Piswords FPGA or ALINX AX301 FPGA board via the J2 connector is shown in figure 1A.

The diagram for connecting a common anode 7-Segment LED display to the Piswords FPGA or ALINX AX301 FPGA board via the J2 connector is shown in figure 1B.

The diagram for connecting the 7-Segment LED display digit 7 (the rightmost one) of the common cathode type on the Piswords PIAX301 board to the FPGA pins is shown in Figure 1C.

The diagram for connecting the 7-Segment LED display digit 5 ​​(the rightmost digit) of the common cathode type on the ALINX AX301 board to the FPGA pins is shown in Figure 1D.

![ Figure 1 ](/Pictures/Figure1.png)

A single digit can display:
- A decimal number with values ​​from 0 to 9
- A hexadecimal number with values ​​from 0 to F
- An alphanumeric character from the Lain alphabet and the numbers from 0 to 9.

In binary, a number from 0 to 9 can be represented in 4 bits. This representation is called BCD encoding. There are several types of BCD encodings, the most famous is the 8421 encoding that we will use in our implementation.

If we use all possible combinations for 4 bits, the result is the hexadecimal representation, which we can implement in the project.

There are several encoding systems for encoding alphanumeric information. The most well-known are ASCII and UNICODE.

ASCII is a 7-bit code that encodes 128 unique symbols, illustrating basic English characters and control codes. 

UNICODE is 8-bit UTF-8, 16-bit UTF-16, and 32-bit UTF-32 which supports over a million unique characters.

Due to the practical limitations of displaying a 7-Segment display, I decided that implementing the display of ASCII-specific characters was sufficient.

I will implement Standard ASCII in this project. There is also Extended ASCII but displaying these characters on a 7 Segment display is impractical and can lead to confusion and I will not implement it.

7 bits are required to transmit Standard ASCII code.

So to transmit the information we will need 4 bits for the first two cases and 7 bits for the last case.

We still need one more bit to encode the decimal point if we want to use it.

## Display BCD encoded binary number on a 7 Segment Common Carod type LED display
BCD stands for Binary-Coded Decimal and is used In computing and electronic systems is a class of Binary Encodings of decimal numbers where each digit is represented by a fixed number of bits, usually four.

BCD encoding is not unique, there are many variations. I will use simple BCD encoding, also called 8421 encoding.

Connecting the 7 Segment Common Cathode LED display to the FPGA chip is done as in figures 1A, 1C and 1D. For other boards, the connected pin number is indicated.

Seg0 to Seg6 represent the Segment command, which corresponds to segments a to g of the 7-segment display. BP is the Decimal Point command. SEL5 is the Select Digit 5 ​​command, and SEL7 is the Select Digit 7 command.

The Module implemented in the FPGA is shown in Figure 2 and consists of a BCD to 7 Segment decoder.

![ Figure 2 ](/Pictures/Figure2.png)

The module has:
- 4 input pins for data where the BCD code is presented;
- 1 input pin for control of the Decimal Point;
- 7 output pins for controlling segments a to g of the 7 Segment display;
- 1 output pin for controlling the Decimal Point of the 7 Segment display;
- 1 output pin for controlling SEL5 or SEL7 in the case of embedded displays.


