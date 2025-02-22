# FPGA driver for 7-segment LED display from 1 digit to 8 digits
In this project I designed a driver in FPGA to control a single digit of a 7-Segment LED display. The Display is controlled directly without the help of an external chip.

I have a development board purchased from the Chinese company Piswords which is a cheaper clone of the AX301 product from the Chinese company ALINX.

Both boards are almost identical in PCB Layout and schematic. The Difference is that the one produced by Piswords has a 7-Segment LED display with 8 digits, while the original one has only 6 digits.

Both boards are based on the Altera Cyclone IV EP4CE6F17C8N FPGA chip.

I will cover three practical situations:
- Controlling an external common cathode display
- Controlling an external common anode display
- Controlling an internal common cathode display

## Electrical constraints
In the case of the EP4CE6F17C8N chip, the nominal operating current for an input-output pin is 8 mA, and the nominal voltage accepted by the pins is 3.3 Volts. The maximum allowed current for an input-output pin is between -25 mA for sourcing current and +40 mA for sinking current, and the maximum voltage is between -0.5V and 4.2V.

To limit the control current to the nominal value when controlling a display segment, for a red display, we must use a resistor with the value:

*R = (Vcc – VLed) / ILed = (3.3V – 1.8V) / 8 mA = 1.5V / 8 mA = 1.5V / 0,008A = 188 Ohms*

Resistors with a value of 188 Ohms are not manufactured and we will choose a value immediately higher than this value from the E series of stansars: 220 Ohms from the E3 series, 220 Ohms from the E6 series, 220 Ohms from the E12 series, 200 Ohms from the E24 series, 196 Ohms from the E48 series, 191 Ohms from the E96 series or 189 Ohms from the E192 series. For homogeneity in the electrical diagrams, we used the value of 220 Ohms.

The developers of the Piswords PIAX301V2 board used 220 Ohm limiting resistors, as can be seen in Figure 1C, and the developers of the ALINX AX301 board used 470 Ohm limiting resistors, as can be seen in Figure 1D.

![ Figure 1 ](/Pictures/Figure1.png)

For a resistance of 220 Ohms, a current of:

*ILed = (Vcc – VLed) / R = (3.3V – 1.8V) / 220 = 1.5V / 220 = 6.8 mA*

The power dissipated by these resistors can be a maximum of:

*P = R*I*I = 220 * 0,0068 * 0,0068 = 0,01W*

The standard values ​​for powers are 0.125W, 0.25W, 0.5W, 1W for through-hole resistors and 0.05W for SMD 0201, 0.062W for SMD 0402, 0.10W for SMD 0603, 0.125W for SMD 0805, 0.25W for SMD 1206, 0.5W for SMD 1210, 0.75W for SMD 1210, 1W for SMD 1218, 1W for SMD 2512.

So for our application we will use 0.125W resistors for the through-hole version or any size for the SMD version.

## Multiplexing
To control a digit of the display we need 8 pins, this implies for 8 digits the need for 8 * 8 = 64 pins. Plus the presence of 64 current limiting resistors. This implies a waste of resources and components. To eliminate these disadvantages the multiplexed display system is used.

Multiplexing consists of displaying information on a single digit while the other digits are inactive. The activation of the digits is done one by one at a speed greater than 50 times per second. At lower speeds, the disturbing effect of flickering of the display occurs.

## Current amplifiers
Since each digit is composed of 8 LEDs that have a common electrode connected to a pin of the display, the current through that pin is the sum of all the currents through the LEDs.

The maximum total current required for a digit in our case is 6.8 mA * 8 = 54.4 mA, this value exceeds the maximum allowed values of -25 mA sourcing current for controlling a common anode display but also +40mA sinking current for controlling a common cathode display, so it is too high to be able to control a digit directly with a pin of the FPGA chip.

That is why we must use a current amplifier, in the sense that with a maximum control current of 8 mA we control a working current of 55 mA. The current amplifier is a bipolar transistor. For a common anode display, the transistor is a PNP of the S8550 type, or any PNP transistor that can support a collector-emitter current of at least 100mA. For a common cathode display, the NPN transistor can be a 2N3903 type or any NPN transistor that can support a collector-emitter current of at least 100mA.

To limit the control current when controlling a control transistor of a display digit, we must use a resistor with the value:

*R = (Vcc – Vbe) / Ibe = (3.3V – 0.7V) / 8 mA = 2.6V / 8 mA = 2.6V / 0,008A = 325 Ohms*

Resistors with a value of 325 Ohms are not manufactured and we will choose a value immediately higher than this value from the E series of stansars: 470 Ohms from the E3 series, 330 Ohms from the E6 series, 330 Ohms from the E12 series, 330 Ohms from the E24 series, 332 Ohms from the E48 series, 332 Ohms from the E96 series or 324 Ohms from the E192 series. For homogeneity in the electrical diagrams, we used the value of 330 Ohms.

We will see in Figure 1C that the designers of the Piswords PIAX301V2 board used resistors with a value of 220 Ohms. This will result in a pin current of:

*Ipin = (Vcc – Vbe) / R = (3.3V – 0.7V) / 220 = 2.6V / 220 = 11.8 mA*

This value is greater than the nominal value of 8 mA but is less than the maximum sinking current limit of 40 mA.

## Single digit display
The design of a driver in FPGA for a single-digit 7-Segment LED Display is presented here:

https://github.com/LincaMarius/FPGA_7_Segment_Display_Driver/blob/main/1_%20Digit_Displa_CA/README_1.md
