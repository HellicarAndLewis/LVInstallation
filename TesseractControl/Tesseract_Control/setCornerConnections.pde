void setCornerConnections()
{
  int[] cornerLEDIndices = new int[64];
  cornerLEDIndices[0] = 0;
  cornerLEDIndices[1] = 48;
  cornerLEDIndices[2] = 302;
  cornerLEDIndices[3] = 386;
  cornerLEDIndices[4] = 23;
  cornerLEDIndices[5] = 24;
  cornerLEDIndices[6] = 96;
  cornerLEDIndices[7] = 277;
  cornerLEDIndices[8] = 47;
  cornerLEDIndices[9] = 144;
  cornerLEDIndices[10] = 145;
  cornerLEDIndices[11] = 169;
  cornerLEDIndices[12] = 121;
  cornerLEDIndices[13] = 362;
  cornerLEDIndices[14] = 363;
  cornerLEDIndices[15] = 459;
  cornerLEDIndices[16] = 71;
  cornerLEDIndices[17] = 72;
  cornerLEDIndices[18] = 230;
  cornerLEDIndices[19] = 278;
  cornerLEDIndices[20] = 120;
  cornerLEDIndices[21] = 253;
  cornerLEDIndices[22] = 254;
  cornerLEDIndices[23] = 434;
  cornerLEDIndices[24] = 168;
  cornerLEDIndices[25] = 193;
  cornerLEDIndices[26] = 410;
  cornerLEDIndices[27] = 411;
  cornerLEDIndices[28] = 95;
  cornerLEDIndices[29] = 339;
  cornerLEDIndices[30] = 387;
  cornerLEDIndices[31] = 435;
  cornerLEDIndices[32] = 220;
  cornerLEDIndices[33] = 221;
  cornerLEDIndices[34] = 294;
  cornerLEDIndices[35] = 295;
  cornerLEDIndices[36] = 103;
  cornerLEDIndices[37] = 104;
  cornerLEDIndices[38] = 211;
  cornerLEDIndices[39] = 212;
  cornerLEDIndices[40] = 176;
  cornerLEDIndices[41] = 177;
  cornerLEDIndices[42] = 202;
  cornerLEDIndices[43] = 203;
  cornerLEDIndices[44] = 194;
  cornerLEDIndices[45] = 229;
  cornerLEDIndices[46] = 451;
  cornerLEDIndices[47] = 452;
  cornerLEDIndices[48] = 285;
  cornerLEDIndices[49] = 286;
  cornerLEDIndices[50] = 303;
  cornerLEDIndices[51] = 338;
  cornerLEDIndices[52] = 112;
  cornerLEDIndices[53] = 113;
  cornerLEDIndices[54] = 311;
  cornerLEDIndices[55] = 312;
  cornerLEDIndices[56] = 185;
  cornerLEDIndices[57] = 186;
  cornerLEDIndices[58] = 320;
  cornerLEDIndices[59] = 321;
  cornerLEDIndices[60] = 329;
  cornerLEDIndices[61] = 330;
  cornerLEDIndices[62] = 442;
  cornerLEDIndices[63] = 443;
  
  for(int i = 0; i < 64; i++)
  {
    int LEDIndex = cornerLEDIndices[i];
    int check = i % 4;
    if(check == 0)
    {
      LEDs[LEDIndex].cornerIndices[0] = cornerLEDIndices[i+1];
      LEDs[LEDIndex].cornerIndices[1] = cornerLEDIndices[i+2];
      LEDs[LEDIndex].cornerIndices[2] = cornerLEDIndices[i+3];
    }
    else if(check == 1)
    {
      LEDs[LEDIndex].cornerIndices[0] = cornerLEDIndices[i-1];
      LEDs[LEDIndex].cornerIndices[1] = cornerLEDIndices[i+1];
      LEDs[LEDIndex].cornerIndices[2] = cornerLEDIndices[i+2];
    }
    else if(check == 2)
    {
      LEDs[LEDIndex].cornerIndices[0] = cornerLEDIndices[i-2];
      LEDs[LEDIndex].cornerIndices[1] = cornerLEDIndices[i-1];
      LEDs[LEDIndex].cornerIndices[2] = cornerLEDIndices[i+1];
    }
    else if(check == 3)
    {
      LEDs[LEDIndex].cornerIndices[0] = cornerLEDIndices[i-3];
      LEDs[LEDIndex].cornerIndices[1] = cornerLEDIndices[i-2];
      LEDs[LEDIndex].cornerIndices[2] = cornerLEDIndices[i-1];
    }
  }
}
