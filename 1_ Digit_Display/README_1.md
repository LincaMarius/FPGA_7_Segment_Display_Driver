# FPGA driver for 7-segment 1-digit LED display
In this project I designed a driver in FPGA to control a single digit of a 7-Segment LED display. The Display is controlled directly without the help of an external chip.

I will cover three practical situations:
- Controlling an external common cathode display
- Controlling an external common anode display
- Controlling an internal common cathode display

The electrical diagram for connecting a common cathode 7-Segment LED display to the Piswords FPGA or ALINX AX301 FPGA board via the J2 connector is shown in figure 1.A.

The electrical diagram for connecting a common anode 7-Segment LED display to the Piswords FPGA or ALINX AX301 FPGA board via the J2 connector is shown in figure 1.B.

The electrical diagram for connecting the 7 Segment LED display, digit 7 (the one positioned on the right) of the common cathode type on the Piswords FPGA board to the FPGA pins, or digit 5 ​​(the one positioned on the right) of the common cathode type on the ALINX AX301 FPGA board to the FPGA pins is shown in figure 1.C.

