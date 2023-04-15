import sys
import time

import numpy

from dwfconstants import *


class ROMProgrammer:
    dwf = None
    hdwf = None

    @staticmethod
    def get_dwf():
        if sys.platform.startswith("win"):
            dwf = cdll.dwf
        elif sys.platform.startswith("darwin"):
            dwf = cdll.LoadLibrary("/Library/Frameworks/dwf.framework/dwf")
        else:
            dwf = cdll.LoadLibrary("libdwf.so")
        return dwf

    @staticmethod
    def get_hdwf(dwf):
        version = create_string_buffer(16)
        dwf.FDwfGetVersion(version)
        print("DWF Version: " + str(version.value))

        print("Opening first device")
        hdwf = c_int()
        dwf.FDwfDeviceOpen(c_int(-1), byref(hdwf))

        if hdwf.value == 0:
            print("failed to open device")
            szerr = create_string_buffer(512)
            dwf.FDwfGetLastErrorMsg(szerr)
            print(str(szerr.value))
            quit()
        return hdwf

    def __init__(self):
        self.dwf = self.get_dwf()
        self.hdwf = self.get_hdwf(self.dwf)

        # set up analog IO channel nodes
        self.dwf.FDwfAnalogIOChannelNodeSet(self.hdwf, c_int(0), c_int(0), c_double(True))  # enable positive supply
        self.dwf.FDwfAnalogIOChannelNodeSet(self.hdwf, c_int(0), c_int(1), c_double(5.0))  # set voltage to 5 V
        self.dwf.FDwfAnalogIOEnableSet(self.hdwf, c_int(True))  # master enable

    def get_internal_clk_freq(self):
        freq = c_double()
        self.dwf.FDwfDigitalOutInternalClockInfo(self.hdwf, byref(freq))
        return freq.value

    def setup_simple_clock(self, pin: int, freq: int):
        """
        :param freq: int Frequency in Hz
        :type pin: int
        """
        self.dwf.FDwfDigitalOutEnableSet(self.hdwf, c_int(pin), c_int(1))
        self.dwf.FDwfDigitalOutDividerSet(self.hdwf, c_int(pin), c_int(int(self.get_internal_clk_freq() / freq)))
        self.dwf.FDwfDigitalOutCounterSet(self.hdwf, c_int(pin), c_int(1), c_int(1))

    """
    Currently prints ROM to terminal
    Emulate the ROM by putting DATA pins on LSB8 of ADDR16
    """

    def rom_verify(self):
        CLKPIN = 0
        # Setup shift clk
        shift_clk_freq = 10000
        self.setup_simple_clock(CLKPIN, shift_clk_freq)

        # Setup Shift Data
        # rgdSamples = (c_byte * 6)(*[0xFF, 0x80, 0xC0, 0xE0, 0xF0, 0x00])
        # 10kHz sample rate custom on IO pin 3
        # self.dwf.FDwfDigitalOutEnableSet(self.hdwf, c_int(3), 1)
        # self.dwf.FDwfDigitalOutTypeSet(self.hdwf, c_int(3), DwfDigitalOutTypeCustom)
        # self.dwf.FDwfDigitalOutDividerSet(self.hdwf, c_int(3), c_int(int(clk_freq / 1e4)))
        # self.dwf.FDwfDigitalOutDataSet(self.hdwf, c_int(3), byref(rgdSamples), c_int(6 * 8))
        # self.dwf.FDwfDigitalOutConfigure(self.hdwf, c_int(1))

        # Read Data
        print("Base freq: " + str(self.get_internal_clk_freq() / 1e6) + "Mhz")
        print("Sampling freq: " + str(self.get_internal_clk_freq() / shift_clk_freq / 1e6) + "MHz")

        self.dwf.FDwfDigitalInAcquisitionModeSet(self.hdwf, acqmodeRecord)
        self.dwf.FDwfDigitalInDividerSet(self.hdwf, c_int(int(self.get_internal_clk_freq() / shift_clk_freq)))

        self.dwf.FDwfDigitalInSampleFormatSet(self.hdwf, c_int(32))  # 8bit per sample format
        self.dwf.FDwfDigitalInTriggerPositionSet(self.hdwf, c_int(0))  # number of samples after trigger
        self.dwf.FDwfDigitalInTriggerSourceSet(self.hdwf, trigsrcNone)  # Always Trigger?
        # with order 0: DIN0:7;   with 32 bit sampling [DIN0:23  + DIO24:31]
        self.dwf.FDwfDigitalInConfigure(self.hdwf, c_bool(0), c_bool(1))

        nRecord = int(10000)
        cAvailable = c_int()
        cLost = c_int()
        cCorrupted = c_int()
        iRecord = int(0)
        sts = c_ubyte()

        while True:
            if self.dwf.FDwfDigitalInStatus(self.hdwf, c_int(1), byref(sts)) == 0:
                print("Error")
                break

            self.dwf.FDwfDigitalInStatusRecord(self.hdwf, byref(cAvailable), byref(cLost), byref(cCorrupted))

            if cAvailable.value == 0:
                print("Wait for samples")
                continue
            if cLost.value:
                print("corrupted :(")
                break
            if cCorrupted.value:
                print("corrupted :(")
                break

            cChunk = min(cAvailable.value, nRecord - iRecord)

            rgbBuffer = (c_uint32 * cChunk)()

            self.dwf.FDwfDigitalInStatusData(self.hdwf, byref(rgbBuffer), c_int(cChunk))

            i = 0
            for b in rgbBuffer:
                if b != 0:
                    print(f"{i + iRecord} - {b}")
                i = i + 1
            iRecord += cChunk

            print(iRecord)
            if iRecord >= nRecord:
                print("Done")
                break

    def __del__(self):
        self.dwf.FDwfDigitalOutReset(self.hdwf)
        self.dwf.FDwfDeviceCloseAll()


if __name__ == "__main__":
    rp = ROMProgrammer()
    rp.rom_verify()
