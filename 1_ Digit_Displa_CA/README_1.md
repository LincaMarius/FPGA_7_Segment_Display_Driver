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

## Display BCD encoded binary number on a 7 Segment Common Anode LED display
BCD stands for Binary-Coded Decimal and is used In computing and electronic systems is a class of Binary Encodings of decimal numbers where each digit is represented by a fixed number of bits, usually four.

BCD encoding is not unique, there are many variations. I will use simple BCD encoding, also called 8421 encoding.

Connecting the 7 Segment Common Anode LED display to the FPGA chip is done as in figures 1B, 1C and 1D. For other development boards, the number for each connected pin is changed accordingly.

Seg0 to Seg6 represent the Segment command, which corresponds to segments a to g of the 7-segment display. BP is the Decimal Point command. SEL5 is the Select Digit 5 ​​command, and SEL7 is the Select Digit 7 command.

The Module implemented in the FPGA is shown in Figure 2 and consists of a BCD to 7 Segment decoder.

![ Figure 2 ](/Pictures/Figure2.png)

The module has:
- 4 input pins for data where the BCD code is presented = BCD_in;
- 1 input pin for control of the Decimal Point = DP_in;
- 7 output pins for controlling segments a to g of the 7 Segment display = Segments;
- 1 output pin for controlling the Decimal Point of the 7 Segment display = dp;
- 1 output pin for controlling SEL5 or SEL7 in the case of embedded displays = SEL7.

The source code for the FPGA program written in VHDL is as follows:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CA/BCD_to_1_Digit_CA.vhd

The source code for the FPGA program written in Verilog is as follows:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CA/BCD_to_1_Digit_CA.v

To test the correctness of the code, I created a test bench whose structure can be seen in figure 3.

![ Figure 3 ](/Pictures/Figure3.png)

I started from the 50 MHz clock frequency of the main oscillator present on the Piswords PIAX301V2 development board, identical to that on the ALINX AX301 board.

This clock signal is applied to a counter with 25000000 which at the output on bit 24 will present a signal with a frequency of 2 Hz.

The 2 Hz signal is applied to a 16-bit counter. Its outputs are applied directly as the “BCD_in” input signal for the module under test. Bit 0 is applied as the “bp_in” input signal. Thus, the BP segment will light up every second indicating that the test is running.

The source code for the test bench program written in VHDL is as follows:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CA/BCD_to_1_Digit_CA_tb.vhd

The source code for the test bench program written in the Verilog language is as follows:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CA/BCD_to_1_Digit_CA_tb.v

After testing the code through simulation using the test bench, the practical use of the driver implemented in a practical application follows. For this purpose, I created an application that counts from 0 to 9 and then displays only the decimal point. The application is created starting from the test bench previously used for testing.

A representation of the modules used and the connection signals between them is shown in figure 4.

![ Figure 4 ](/Pictures/Figure4.png)

The source code for the test application written in VHDL is here:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CA/Aplication_1.vhd 

The source code for the test application written in the Verilog language is here:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CA/Aplication_1.v 

To test the code of the test application titled "Application 1" I created a Test Bench that can be represented as in the following figure:

![ Figure 5 ](/Pictures/Figure5.png)

The source code for the Test Bench of the application "Application 1" written in the VHDL language is here:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CA/Aplication_1_tb.vhd

The source code for the Test Bench of the application "Application 1" written in the Verilog language is here:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CA/Aplication_1_tb.v 

## Display BCD encoded binary number on a 7 Segment Common Cathode LED display
Connecting the Common Cathode 7 Segment LED display to the FPGA chip is done as in Figure 1A. For other development boards, the number for each connected pin is changed accordingly.

Seg0 to Seg6 represent the Segment command, which corresponds to segments a to g of the 7-segment display. BP is the Decimal Point command.

The Module implemented in the FPGA is shown in Figure 6 and consists of a BCD to 7 Segment decoder.

![ Figure 6 ](/Pictures/Figure6.png)

The module has:
- 4 input pins for data where the BCD code is presented = BCD_in;
- 1 input pin for control of the Decimal Point = DP_in;
- 7 output pins for controlling the segments from a to g of the 7 Segment display = Segments;
- 1 output pin for controlling the Decimal Point of the 7 Segment display = dp;

The source code for the FPGA program of this module written in the VHDL language is as follows:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CC/BCD_to_1_Digit_CC.vhd

The source code for the FPGA program written in Verilog is as follows:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CC/BCD_to_1_Digit_CC.v

To test the correctness of the code, I created a test bench whose structure can be seen in figure 7.

![ Figure 7 ](/Pictures/Figure7.png)

The source code for the test bench program written in VHDL is as follows:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CC/BCD_to_1_Digit_CC_tb.vhd

The source code for the test bench program written in the Verilog language is as follows:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CC/BCD_to_1_Digit_CC_tb.v

A test application that counts from 0 to 9 and then displays only the decimal point. The application is built from the test bench previously used for testing.

A representation of the modules used and the connection signals between them is shown in figure 8.

![ Figure 8 ](/Pictures/Figure8.png)

The source code for the test application written in VHDL is here:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CC/Aplication_2.vhd

The source code for the test application written in the Verilog language is here:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CC/Aplication_2.v

To test the code of the test application titled "Application 2" I created a Test Bench that can be represented as in the following figure:

![ Figure 9 ](/Pictures/Figure9.png)

The source code for the Test Bench of the application "Application 2" written in the VHDL language is here:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CC/Aplication_2_tb.vhd

The source code for the Test Bench of the application "Application 2" written in the Verilog language is here:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CC/Aplication_2_tb.v

## Display binary number in hexadecimal on a 7 Segment Common Anode LED display
Connecting the 7 Segment Common Anode LED display to the FPGA chip is done as in figures 1B, 1C and 1D. For other development boards, the number for each connected pin is changed accordingly.

Seg0 to Seg6 represent the Segment command, which corresponds to segments a to g of the 7-segment display. BP is the Decimal Point command. SEL5 is the Select Digit 5 command, and SEL7 is the Select Digit 7 command.

The module implemented in the FPGA is shown in Figure 10 and consists of a 7-Segment hexadecimal decoder.

![ Figure 10 ](/Pictures/Figure10.png)

The module has:
- 4 input pins for data where the BCD code is presented = HEX_in;
- 1 input pin for control of the Decimal Point = DP_in;
- 7 output pins for controlling segments a to g of the 7 Segment display = Segments;
- 1 output pin for controlling the Decimal Point of the 7 Segment display = dp;
- 1 output pin for controlling SEL5 or SEL7 in the case of embedded displays = SEL7.

The source code for the FPGA program written in VHDL is as follows:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CA/HEX_to_1_Digit_CA.vhd

The source code for the FPGA program written in Verilog is as follows:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CA/HEX_to_1_Digit_CA.v

To test the correctness of the code, I created a test bench whose structure can be seen in figure 11.

![ Figure 11 ](/Pictures/Figure11.png)

The 2 Hz signal is applied to a 16-bit counter. Its outputs are applied directly as the “HEX_in” input signal for the module under test. Bit 0 is applied as the “dp_in” input signal. Thus, the DP segment will light up every second indicating that the test is running.

The source code for the test bench program written in VHDL is as follows:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CA/HEX_to_1_Digit_CA_tb.vhd

The source code for the test bench program written in the Verilog language is as follows:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CA/HEX_to_1_Digit_CA_tb.v

After testing the code through simulation using the test bench, the practical use of the driver implemented in a practical application follows. For this purpose, I created an application that counts from 0 to F and flashes the decimal point. The application is made starting from the test bench previously used for tests.

A representation of the modules used to create the application and the connection signals between them is shown in figure 12.

![ Figure 12 ](/Pictures/Figure12.png)

The source code for the test application written in VHDL is here:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CA/Aplication_3.vhd

The source code for the test application written in the Verilog language is here:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CA/Aplication_3.v

To test the code of the test application titled "Application 3" I created a Test Bench that can be represented as in the following figure:

![ Figure 13 ](/Pictures/Figure13.png)

The source code for the Test Bench of the application "Application 3" written in the VHDL language is here:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CA/Aplication_3_tb.vhd

The source code for the Test Bench of the application "Application 3" written in the Verilog language is here:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CA/Aplication_3_tb.v

## Display binary number in hexadecimal on a 7 Segment Common Cathode LED display
Connecting the Common Cathode 7 Segment LED display to the FPGA chip is done as in Figure 1A. For other development boards, the number for each connected pin is changed accordingly.

Seg0 to Seg6 represent the Segment command, which corresponds to segments a to g of the 7-segment display. DP is the Decimal Point command.

The module implemented in the FPGA is shown in Figure 14 and consists of a Hexadecimal to 7 Segment encoder.

![ Figure 14 ](/Pictures/Figure14.png)

The module has:
- 4 input pins for data where the binary code is presented = HEX_in;
- 1 input pin for control of the Decimal Point = DP_in;
- 7 output pins for controlling the segments from a to g of the 7 Segment display = Segments;
- 1 output pin for controlling the Decimal Point of the 7 Segment display = dp;

The source code for the FPGA program of this module written in the VHDL language is as follows:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CC/HEX_to_1_Digit_CC.vhd

The source code for the FPGA program written in Verilog is as follows:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CC/HEX_to_1_Digit_CC.v

To test the correctness of the code, I created a test bench whose structure can be seen in figure 15.

![ Figure 15 ](/Pictures/Figure15.png)

The source code for the test bench program written in VHDL is as follows:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CC/HEX_to_1_Digit_CC_tb.vhd

The source code for the test bench program written in the Verilog language is as follows:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CC/HEX_to_1_Digit_CC_tb.v

A test application that counts from 0 to F while the decimal point flashes every second. The application is built from the test bench previously used for testing.

A representation of the modules used and the connection signals between them is shown in figure 16.

![ Figure 16 ](/Pictures/Figure16.png)

The source code for the test application written in VHDL is here:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CC/Aplication_4.vhd

The source code for the test application written in the Verilog language is here:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CC/Aplication_4.v

To test the code of the test application titled "Application 4" I created a Test Bench that can be represented as in the following figure:

![ Figure 17 ](/Pictures/Figure17.png)

The source code for the Test Bench of the application "Application 4" written in the VHDL language is here:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CC/Aplication_4_tb.vhd

The source code for the Test Bench of the application "Application 4" written in the Verilog language is here:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CC/Aplication_4_tb.v

## Display ASCII alphanumeric character on a 7 Segment Common Anode LED display
Connecting the 7 Segment Common Anode LED display to the FPGA chip is done as in figures 1B, 1C and 1D. For other development boards, the number for each connected pin is changed accordingly.

Seg0 to Seg6 represent the Segment command, which corresponds to segments a to g of the 7-segment display. BP is the Decimal Point command. SEL5 is the Select Digit 5 command, and SEL7 is the Select Digit 7 command.

The module implemented in the FPGA is shown in Figure 18 and consists of a decoder from ASCII code to 7 Segments.

![ Figure 18 ](/Pictures/Figure18.png)

The module has:
- 7 input pins for data where the ASCII code is presented = ASCII_in;
- 1 input pin for control of the Decimal Point = dp_in;
- 7 output pins for controlling segments a to g of the 7 Segment display = Segments;
- 1 output pin for controlling the Decimal Point of the 7 Segment display = dp;
- 1 output pin for controlling SEL5 or SEL7 in the case of embedded displays = SEL7.

The source code for the FPGA program written in VHDL is as follows:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CA/ASCII_to_1_Digit_CA.vhd

The source code for the FPGA program written in Verilog is as follows:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CA/ASCII_to_1_Digit_CA.v

To test the correctness of the code, I created a test bench whose structure can be seen in figure 19.

![ Figure 19 ](/Pictures/Figure19.png)

The 2 Hz signal is applied to a 128-count counter. Its outputs are applied directly as the “ASCII_in” input signal for the module under test. Bit 0 is applied as the “dp_in” input signal. Thus, the DP segment will light up every second indicating that the test is running.

The source code for the test bench program written in VHDL is as follows:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CA/ASCII_to_1_Digit_CA_tb.vhd

The source code for the test bench program written in the Verilog language is as follows:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CA/ASCII_to_1_Digit_CA_tb.v

After testing the code through simulation using the test bench, the driver implemented in a practical application follows. For this purpose, I created an application that counts from 0 to 128 to display all the characters implemented in the decoder and flashes the decimal point. The application is made starting from the test bench previously used for tests.

A representation of the modules used to create the application and the connection signals between them is shown in figure 20.

![ Figure 20 ](/Pictures/Figure20.png)

The source code for the test application written in VHDL is here:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CA/Aplication_5.vhd

Codul sursă pentru aplicația de test scrisă în limbajul Verilog este aici:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CA/Aplication_5.v

To test the code of the test application titled "Application 5" I created a Test Bench that can be represented as in the following figure:

![ Figure 21 ](/Pictures/Figure21.png)

The source code for the Test Bench of the application "Application 5" written in the VHDL language is here:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CA/Aplication_5_tb.vhd

The source code for the Test Bench of the application "Application 5" written in the Verilog language is here:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CA/Aplication_5_tb.v

## Display ASCII alphanumeric character on a 7 Segment Common Cathode LED display
Connecting the Common Cathode 7 Segment LED display to the FPGA chip is done as in Figure 1A. For other development boards, the number for each connected pin is changed accordingly.

Seg0 to Seg6 represent the Segment command, which corresponds to segments a to g of the 7-segment display. DP is the Decimal Point command.

The module implemented in the FPGA is shown in figure 22 and consists of an ASCII to 7 Segment decoder.

![ Figure 22 ](/Pictures/Figure22.png)

The module has:
- 7 input pins for data where the binary code is presented = ASCII_in;
- 1 input pin for control of the Decimal Point = dp_in;
- 7 output pins for controlling the segments from a to g of the 7 Segment display = Segments;
- 1 output pin for controlling the Decimal Point of the 7 Segment display = dp;

The source code for the FPGA program of this module written in the VHDL language is as follows:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CC/ASCII_to_1_Digit_CC.vhd

The source code for the FPGA program written in Verilog is as follows:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CC/ASCII_to_1_Digit_CC.v

To test the correctness of the code, I created a test bench whose structure can be seen in figure 23.

![ Figure 23 ](/Pictures/Figure23.png)

The source code for the test bench program written in VHDL is as follows:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CC/ASCII_to_1_Digit_CC_tb.vhd

The source code for the test bench program written in the Verilog language is as follows:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CC/ASCII_to_1_Digit_CC_tb.v

I have made a test application that counts from 0 to 128 to display all the characters implemented in this decoder and at the same time the decimal point flashes every second to indicate that the program is running. The application is made starting from the test bench used previously for tests.

A representation of the modules used and the connection signals between them is shown in figure 24.

![ Figure 24 ](/Pictures/Figure24.png)

The source code for the test application written in VHDL is here:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CC/Aplication_6.vhd

The source code for the test application written in the Verilog language is here:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CC/Aplication_6.v

To test the code of the test application titled "Application 6" I created a Test Bench that can be represented as in the following figure:

![ Figure 25 ](/Pictures/Figure25.png)

The source code for the Test Bench of the application "Application 6" written in the VHDL language is here:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CC/Aplication_6_tb.vhd

The source code for the Test Bench of the application "Application 6" written in the Verilog language is here:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CC/Aplication_6_tb.v
