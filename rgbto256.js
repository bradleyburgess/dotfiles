// Convert RGB24 to xterm-256 8-bit value
// For simplicity, assume RGB space is perceptually uniform.
// There are 5 places where one of two outputs needs to be chosen when the
// input is the exact middle:
// - The r/g/b channels and the gray value: the higher value output is chosen.
// - If the gray and color have same distance from the input - color is chosen.
function RgbToX256(r, g, b) {
  // Calculate the nearest 0-based color index at 16 .. 231
  const v2ci = (v) => {
    if (v < 48) {
      return 0;
    } else if (v < 115) {
      return 1;
    } else {
      return Math.trunc((v - 35) / 40);
    }
  };

  const ir = v2ci(r);
  const ig = v2ci(g);
  const ib = v2ci(b);
  const colorIndex = (36 * ir + 6 * ig + ib);

  // Calculate the nearest 0-based gray index at 232 .. 255
  const average = Math.trunc((r + g + b) / 3);
  const grayIndex = average > 238 ? 23 : Math.trunc((average - 3) / 10);

  // Calculate the represented colors back from the index
  const i2cv = [0, 0x5F, 0x87, 0xAF, 0xD7, 0xFF];
  const cr = i2cv[ir];
  const cg = i2cv[ig];
  const cb = i2cv[ib];
  const gv = 8 + 10 * grayIndex;

  // Return the one which is nearer to the original input rgb value
  const distSquare = (A, B, C, a, b, c) => {
    return ((A - a) * (A - a) + (B - b) * (B - b) + (C - c) * (C - c));
  }
  const colorErr = distSquare(cr, cg, cb, r, g, b);
  const grayErr = distSquare(gv, gv, gv, r, g, b);

  return colorErr <= grayErr ? 16 + colorIndex : 232 + grayIndex;
}

const assertEq = (result, expect) => {
  if (result !== expect) {
    return console.log("[FAIL]", `expected: ${expect}, got ${result}`);
  }

  return console.log("[PASS]", `expected: ${expect}, got ${result}`);
}

const tests = [{
    expect: 16,
    rgb: [0, 0, 0]
  },
  {
    expect: 17,
    rgb: [0, 0, 95]
  },
  {
    expect: 18,
    rgb: [0, 0, 135]
  },
  {
    expect: 19,
    rgb: [0, 0, 175]
  },
  {
    expect: 20,
    rgb: [0, 0, 215]
  },
  {
    expect: 21,
    rgb: [0, 0, 255]
  },
  {
    expect: 22,
    rgb: [0, 95, 0]
  },
  {
    expect: 23,
    rgb: [0, 95, 95]
  },
  {
    expect: 24,
    rgb: [0, 95, 135]
  },
  {
    expect: 25,
    rgb: [0, 95, 175]
  },
  {
    expect: 26,
    rgb: [0, 95, 215]
  },
  {
    expect: 27,
    rgb: [0, 95, 255]
  },
  {
    expect: 28,
    rgb: [0, 135, 0]
  },
  {
    expect: 29,
    rgb: [0, 135, 95]
  },
  {
    expect: 30,
    rgb: [0, 135, 135]
  },
  {
    expect: 31,
    rgb: [0, 135, 175]
  },
  {
    expect: 32,
    rgb: [0, 135, 215]
  },
  {
    expect: 33,
    rgb: [0, 135, 255]
  },
  {
    expect: 34,
    rgb: [0, 175, 0]
  },
  {
    expect: 35,
    rgb: [0, 175, 95]
  },
  {
    expect: 36,
    rgb: [0, 175, 135]
  },
  {
    expect: 37,
    rgb: [0, 175, 175]
  },
  {
    expect: 38,
    rgb: [0, 175, 215]
  },
  {
    expect: 39,
    rgb: [0, 175, 255]
  },
  {
    expect: 40,
    rgb: [0, 215, 0]
  },
  {
    expect: 41,
    rgb: [0, 215, 95]
  },
  {
    expect: 42,
    rgb: [0, 215, 135]
  },
  {
    expect: 43,
    rgb: [0, 215, 175]
  },
  {
    expect: 44,
    rgb: [0, 215, 215]
  },
  {
    expect: 45,
    rgb: [0, 215, 255]
  },
  {
    expect: 46,
    rgb: [0, 255, 0]
  },
  {
    expect: 47,
    rgb: [0, 255, 95]
  },
  {
    expect: 48,
    rgb: [0, 255, 135]
  },
  {
    expect: 49,
    rgb: [0, 255, 175]
  },
  {
    expect: 50,
    rgb: [0, 255, 215]
  },
  {
    expect: 51,
    rgb: [0, 255, 255]
  },
  {
    expect: 52,
    rgb: [95, 0, 0]
  },
  {
    expect: 53,
    rgb: [95, 0, 95]
  },
  {
    expect: 54,
    rgb: [95, 0, 135]
  },
  {
    expect: 55,
    rgb: [95, 0, 175]
  },
  {
    expect: 56,
    rgb: [95, 0, 215]
  },
  {
    expect: 57,
    rgb: [95, 0, 255]
  },
  {
    expect: 58,
    rgb: [95, 95, 0]
  },
  {
    expect: 59,
    rgb: [95, 95, 95]
  },
  {
    expect: 60,
    rgb: [95, 95, 135]
  },
  {
    expect: 61,
    rgb: [95, 95, 175]
  },
  {
    expect: 62,
    rgb: [95, 95, 215]
  },
  {
    expect: 63,
    rgb: [95, 95, 255]
  },
  {
    expect: 64,
    rgb: [95, 135, 0]
  },
  {
    expect: 65,
    rgb: [95, 135, 95]
  },
  {
    expect: 66,
    rgb: [95, 135, 135]
  },
  {
    expect: 67,
    rgb: [95, 135, 175]
  },
  {
    expect: 68,
    rgb: [95, 135, 215]
  },
  {
    expect: 69,
    rgb: [95, 135, 255]
  },
  {
    expect: 70,
    rgb: [95, 175, 0]
  },
  {
    expect: 71,
    rgb: [95, 175, 95]
  },
  {
    expect: 72,
    rgb: [95, 175, 135]
  },
  {
    expect: 73,
    rgb: [95, 175, 175]
  },
  {
    expect: 74,
    rgb: [95, 175, 215]
  },
  {
    expect: 75,
    rgb: [95, 175, 255]
  },
  {
    expect: 76,
    rgb: [95, 215, 0]
  },
  {
    expect: 77,
    rgb: [95, 215, 95]
  },
  {
    expect: 78,
    rgb: [95, 215, 135]
  },
  {
    expect: 79,
    rgb: [95, 215, 175]
  },
  {
    expect: 80,
    rgb: [95, 215, 215]
  },
  {
    expect: 81,
    rgb: [95, 215, 255]
  },
  {
    expect: 82,
    rgb: [95, 255, 0]
  },
  {
    expect: 83,
    rgb: [95, 255, 95]
  },
  {
    expect: 84,
    rgb: [95, 255, 135]
  },
  {
    expect: 85,
    rgb: [95, 255, 175]
  },
  {
    expect: 86,
    rgb: [95, 255, 215]
  },
  {
    expect: 87,
    rgb: [95, 255, 255]
  },
  {
    expect: 88,
    rgb: [135, 0, 0]
  },
  {
    expect: 89,
    rgb: [135, 0, 95]
  },
  {
    expect: 90,
    rgb: [135, 0, 135]
  },
  {
    expect: 91,
    rgb: [135, 0, 175]
  },
  {
    expect: 92,
    rgb: [135, 0, 215]
  },
  {
    expect: 93,
    rgb: [135, 0, 255]
  },
  {
    expect: 94,
    rgb: [135, 95, 0]
  },
  {
    expect: 95,
    rgb: [135, 95, 95]
  },
  {
    expect: 96,
    rgb: [135, 95, 135]
  },
  {
    expect: 97,
    rgb: [135, 95, 175]
  },
  {
    expect: 98,
    rgb: [135, 95, 215]
  },
  {
    expect: 99,
    rgb: [135, 95, 255]
  },
  {
    expect: 100,
    rgb: [135, 135, 0]
  },
  {
    expect: 101,
    rgb: [135, 135, 95]
  },
  {
    expect: 102,
    rgb: [135, 135, 135]
  },
  {
    expect: 103,
    rgb: [135, 135, 175]
  },
  {
    expect: 104,
    rgb: [135, 135, 215]
  },
  {
    expect: 105,
    rgb: [135, 135, 255]
  },
  {
    expect: 106,
    rgb: [135, 175, 0]
  },
  {
    expect: 107,
    rgb: [135, 175, 95]
  },
  {
    expect: 108,
    rgb: [135, 175, 135]
  },
  {
    expect: 109,
    rgb: [135, 175, 175]
  },
  {
    expect: 110,
    rgb: [135, 175, 215]
  },
  {
    expect: 111,
    rgb: [135, 175, 255]
  },
  {
    expect: 112,
    rgb: [135, 215, 0]
  },
  {
    expect: 113,
    rgb: [135, 215, 95]
  },
  {
    expect: 114,
    rgb: [135, 215, 135]
  },
  {
    expect: 115,
    rgb: [135, 215, 175]
  },
  {
    expect: 116,
    rgb: [135, 215, 215]
  },
  {
    expect: 117,
    rgb: [135, 215, 255]
  },
  {
    expect: 118,
    rgb: [135, 255, 0]
  },
  {
    expect: 119,
    rgb: [135, 255, 95]
  },
  {
    expect: 120,
    rgb: [135, 255, 135]
  },
  {
    expect: 121,
    rgb: [135, 255, 175]
  },
  {
    expect: 122,
    rgb: [135, 255, 215]
  },
  {
    expect: 123,
    rgb: [135, 255, 255]
  },
  {
    expect: 124,
    rgb: [175, 0, 0]
  },
  {
    expect: 125,
    rgb: [175, 0, 95]
  },
  {
    expect: 126,
    rgb: [175, 0, 135]
  },
  {
    expect: 127,
    rgb: [175, 0, 175]
  },
  {
    expect: 128,
    rgb: [175, 0, 215]
  },
  {
    expect: 129,
    rgb: [175, 0, 255]
  },
  {
    expect: 130,
    rgb: [175, 95, 0]
  },
  {
    expect: 131,
    rgb: [175, 95, 95]
  },
  {
    expect: 132,
    rgb: [175, 95, 135]
  },
  {
    expect: 133,
    rgb: [175, 95, 175]
  },
  {
    expect: 134,
    rgb: [175, 95, 215]
  },
  {
    expect: 135,
    rgb: [175, 95, 255]
  },
  {
    expect: 136,
    rgb: [175, 135, 0]
  },
  {
    expect: 137,
    rgb: [175, 135, 95]
  },
  {
    expect: 138,
    rgb: [175, 135, 135]
  },
  {
    expect: 139,
    rgb: [175, 135, 175]
  },
  {
    expect: 140,
    rgb: [175, 135, 215]
  },
  {
    expect: 141,
    rgb: [175, 135, 255]
  },
  {
    expect: 142,
    rgb: [175, 175, 0]
  },
  {
    expect: 143,
    rgb: [175, 175, 95]
  },
  {
    expect: 144,
    rgb: [175, 175, 135]
  },
  {
    expect: 145,
    rgb: [175, 175, 175]
  },
  {
    expect: 146,
    rgb: [175, 175, 215]
  },
  {
    expect: 147,
    rgb: [175, 175, 255]
  },
  {
    expect: 148,
    rgb: [175, 215, 0]
  },
  {
    expect: 149,
    rgb: [175, 215, 95]
  },
  {
    expect: 150,
    rgb: [175, 215, 135]
  },
  {
    expect: 151,
    rgb: [175, 215, 175]
  },
  {
    expect: 152,
    rgb: [175, 215, 215]
  },
  {
    expect: 153,
    rgb: [175, 215, 255]
  },
  {
    expect: 154,
    rgb: [175, 255, 0]
  },
  {
    expect: 155,
    rgb: [175, 255, 95]
  },
  {
    expect: 156,
    rgb: [175, 255, 135]
  },
  {
    expect: 157,
    rgb: [175, 255, 175]
  },
  {
    expect: 158,
    rgb: [175, 255, 215]
  },
  {
    expect: 159,
    rgb: [175, 255, 255]
  },
  {
    expect: 160,
    rgb: [215, 0, 0]
  },
  {
    expect: 161,
    rgb: [215, 0, 95]
  },
  {
    expect: 162,
    rgb: [215, 0, 135]
  },
  {
    expect: 163,
    rgb: [215, 0, 175]
  },
  {
    expect: 164,
    rgb: [215, 0, 215]
  },
  {
    expect: 165,
    rgb: [215, 0, 255]
  },
  {
    expect: 166,
    rgb: [215, 95, 0]
  },
  {
    expect: 167,
    rgb: [215, 95, 95]
  },
  {
    expect: 168,
    rgb: [215, 95, 135]
  },
  {
    expect: 169,
    rgb: [215, 95, 175]
  },
  {
    expect: 170,
    rgb: [215, 95, 215]
  },
  {
    expect: 171,
    rgb: [215, 95, 255]
  },
  {
    expect: 172,
    rgb: [215, 135, 0]
  },
  {
    expect: 173,
    rgb: [215, 135, 95]
  },
  {
    expect: 174,
    rgb: [215, 135, 135]
  },
  {
    expect: 175,
    rgb: [215, 135, 175]
  },
  {
    expect: 176,
    rgb: [215, 135, 215]
  },
  {
    expect: 177,
    rgb: [215, 135, 255]
  },
  {
    expect: 178,
    rgb: [215, 175, 0]
  },
  {
    expect: 179,
    rgb: [215, 175, 95]
  },
  {
    expect: 180,
    rgb: [215, 175, 135]
  },
  {
    expect: 181,
    rgb: [215, 175, 175]
  },
  {
    expect: 182,
    rgb: [215, 175, 215]
  },
  {
    expect: 183,
    rgb: [215, 175, 255]
  },
  {
    expect: 184,
    rgb: [215, 215, 0]
  },
  {
    expect: 185,
    rgb: [215, 215, 95]
  },
  {
    expect: 186,
    rgb: [215, 215, 135]
  },
  {
    expect: 187,
    rgb: [215, 215, 175]
  },
  {
    expect: 188,
    rgb: [215, 215, 215]
  },
  {
    expect: 189,
    rgb: [215, 215, 255]
  },
  {
    expect: 190,
    rgb: [215, 255, 0]
  },
  {
    expect: 191,
    rgb: [215, 255, 95]
  },
  {
    expect: 192,
    rgb: [215, 255, 135]
  },
  {
    expect: 193,
    rgb: [215, 255, 175]
  },
  {
    expect: 194,
    rgb: [215, 255, 215]
  },
  {
    expect: 195,
    rgb: [215, 255, 255]
  },
  {
    expect: 196,
    rgb: [255, 0, 0]
  },
  {
    expect: 197,
    rgb: [255, 0, 95]
  },
  {
    expect: 198,
    rgb: [255, 0, 135]
  },
  {
    expect: 199,
    rgb: [255, 0, 175]
  },
  {
    expect: 200,
    rgb: [255, 0, 215]
  },
  {
    expect: 201,
    rgb: [255, 0, 255]
  },
  {
    expect: 202,
    rgb: [255, 95, 0]
  },
  {
    expect: 203,
    rgb: [255, 95, 95]
  },
  {
    expect: 204,
    rgb: [255, 95, 135]
  },
  {
    expect: 205,
    rgb: [255, 95, 175]
  },
  {
    expect: 206,
    rgb: [255, 95, 215]
  },
  {
    expect: 207,
    rgb: [255, 95, 255]
  },
  {
    expect: 208,
    rgb: [255, 135, 0]
  },
  {
    expect: 209,
    rgb: [255, 135, 95]
  },
  {
    expect: 210,
    rgb: [255, 135, 135]
  },
  {
    expect: 211,
    rgb: [255, 135, 175]
  },
  {
    expect: 212,
    rgb: [255, 135, 215]
  },
  {
    expect: 213,
    rgb: [255, 135, 255]
  },
  {
    expect: 214,
    rgb: [255, 175, 0]
  },
  {
    expect: 215,
    rgb: [255, 175, 95]
  },
  {
    expect: 216,
    rgb: [255, 175, 135]
  },
  {
    expect: 217,
    rgb: [255, 175, 175]
  },
  {
    expect: 218,
    rgb: [255, 175, 215]
  },
  {
    expect: 219,
    rgb: [255, 175, 255]
  },
  {
    expect: 220,
    rgb: [255, 215, 0]
  },
  {
    expect: 221,
    rgb: [255, 215, 95]
  },
  {
    expect: 222,
    rgb: [255, 215, 135]
  },
  {
    expect: 223,
    rgb: [255, 215, 175]
  },
  {
    expect: 224,
    rgb: [255, 215, 215]
  },
  {
    expect: 225,
    rgb: [255, 215, 255]
  },
  {
    expect: 226,
    rgb: [255, 255, 0]
  },
  {
    expect: 227,
    rgb: [255, 255, 95]
  },
  {
    expect: 228,
    rgb: [255, 255, 135]
  },
  {
    expect: 229,
    rgb: [255, 255, 175]
  },
  {
    expect: 230,
    rgb: [255, 255, 215]
  },
  {
    expect: 231,
    rgb: [255, 255, 255]
  },
  {
    expect: 232,
    rgb: [8, 8, 8]
  },
  {
    expect: 233,
    rgb: [18, 18, 18]
  },
  {
    expect: 234,
    rgb: [28, 28, 28]
  },
  {
    expect: 235,
    rgb: [38, 38, 38]
  },
  {
    expect: 236,
    rgb: [48, 48, 48]
  },
  {
    expect: 237,
    rgb: [58, 58, 58]
  },
  {
    expect: 238,
    rgb: [68, 68, 68]
  },
  {
    expect: 239,
    rgb: [78, 78, 78]
  },
  {
    expect: 240,
    rgb: [88, 88, 88]
  },
  {
    expect: 241,
    rgb: [98, 98, 98]
  },
  {
    expect: 242,
    rgb: [108, 108, 108]
  },
  {
    expect: 243,
    rgb: [118, 118, 118]
  },
  {
    expect: 244,
    rgb: [128, 128, 128]
  },
  {
    expect: 245,
    rgb: [138, 138, 138]
  },
  {
    expect: 246,
    rgb: [148, 148, 148]
  },
  {
    expect: 247,
    rgb: [158, 158, 158]
  },
  {
    expect: 248,
    rgb: [168, 168, 168]
  },
  {
    expect: 249,
    rgb: [178, 178, 178]
  },
  {
    expect: 250,
    rgb: [188, 188, 188]
  },
  {
    expect: 251,
    rgb: [198, 198, 198]
  },
  {
    expect: 252,
    rgb: [208, 208, 208]
  },
  {
    expect: 253,
    rgb: [218, 218, 218]
  },
  {
    expect: 254,
    rgb: [228, 228, 228]
  },
  {
    expect: 255,
    rgb: [238, 238, 238]
  }
];


for (const {
    expect,
    rgb: [r, g, b]
  } of tests) {
  assertEq(expect, RgbToX256(r, g, b));
}
