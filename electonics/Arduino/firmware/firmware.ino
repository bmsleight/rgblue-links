
// https://github.com/SpenceKonde/ATTinyCore
#include <tinyNeoPixel_Static.h>

// https://github.com/sleemanj/SimpleSleep
#include <SimpleSleep.h>

// Store setting in EEPROM
#include <avr/eeprom.h>
#include <EEPROM.h>


#define PIXELPIN    3
#define PIXELPWR    4

#define MAXBRIGHT 2
#define MINBRIGHT 1
#define NUMPIXELS   1
byte pixels[NUMPIXELS * 3];
tinyNeoPixel leds=tinyNeoPixel(NUMPIXELS, PIXELPIN, NEO_GRB, pixels);

SimpleSleep Sleep; 

#define EEPROM_START_OFFSET 0


struct settings_in_eeprom
{
  byte found_stored_settings; // Must store as byte as defualt value 0xFF, not 0x00 or 0x01
  uint32_t colour;
  int setting_menu;
} settings_in_eeprom;


void setup() {
  // Set modes for pins
  pinMode(PIXELPWR,OUTPUT);
  digitalWrite(PIXELPWR, HIGH);
  pinMode(PIXELPIN,OUTPUT);

  // Load the setting from EEPROM
  eeprom_read_block((void*)&settings_in_eeprom, (void*)EEPROM_START_OFFSET, sizeof(settings_in_eeprom));
  if (settings_in_eeprom.found_stored_settings==255) {
      default_setting_in_eeprom();
  }
  menuEntry();
}


void showStoredColour() {
  uint32_t currentColour;
  colourTime(settings_in_eeprom.colour, 3000);
  colourTime(0,1000);

/*
  // 
  // Rainbow if powered removed colour is stored
  currentColour = settings_in_eeprom.colour;
  simpleRainbow(1000, true);
  settings_in_eeprom.colour = currentColour;
  write_setting_in_eeprom();
  colourTime(settings_in_eeprom.colour, 3000);
  colourTime(0,1000);
*/
}

void menuEntry() {
  uint32_t currentColour;
  switch(settings_in_eeprom.setting_menu) {
    case 1:
      // If powered off during this menu will go to menu 2 next time
      menuColour(1,2);
      settings_in_eeprom.setting_menu = 1;
      write_setting_in_eeprom();
      break;
    case 2:
      // Display menu 2, but ff powered off during this menu will go to menu 1 next time
      menuColour(2,1);
      currentColour = settings_in_eeprom.colour;
      simpleRainbow(1000, true);
      // Restore colour if no power failure
      settings_in_eeprom.colour = currentColour;
      write_setting_in_eeprom();
      // Still Powered Do We want menu 3?
      menuColour(3,3);
      settings_in_eeprom.setting_menu = 1;
      write_setting_in_eeprom();
      break;
    case 3:
      // Basically Keep three or goto menu 2
      menuColour(1,2);
      settings_in_eeprom.setting_menu = 3;
      write_setting_in_eeprom();   
    default:
      break;   
  }
}

void menuColour(int menu, int newMenu) {
  settings_in_eeprom.setting_menu = newMenu;
  write_setting_in_eeprom();
  
  switch(menu) {
    case 1:
      colourTime(255, 0, 0, 4000);
      break;
    case 2:
      colourTime(255, 0, 0, 2000);
      colourTime(255, 127, 0, 2000);
      break;
    default:
      colourTime(255, 0, 0, 2000);
      colourTime(255, 127, 0, 2000);
      colourTime(0, 255, 00, 2000);
      break;
  }
  colourTime(0,1000);
}


void loop() {
  switch(settings_in_eeprom.setting_menu) {
    case 1:
      colourTime(settings_in_eeprom.colour, 1000);
      break;
    case 3:
      simpleRainbow(80, true);
      break;
  }
//  colourTime(settings_in_eeprom.colour, 1000);
  digitalWrite(PIXELPWR, LOW);
  Sleep.deeplyFor(1000);
  digitalWrite(PIXELPWR, HIGH); // Back on but LEDs off
}


void simpleRainbow(int wait, bool save) {
  uint16_t j;
  for(j=0; j<12; j++) {
    settings_in_eeprom.colour = hue(j);
    if (save) {
      write_setting_in_eeprom();
      }
    colourTime(settings_in_eeprom.colour, wait);
  }
}

uint32_t hue(byte huePos) {
  uint16_t hueArray[] = { 0,0,0,0,0,127,255,255,255,255,255,127 };
//  uint16_t hueArray[] = { 0,0,0,255,255,255 };

  uint16_t hueArrayLen = (sizeof(hueArray) / sizeof(hueArray[0])); // 12
  uint16_t r,g,b;
  r = hueArray[huePos];
  g = hueArray[(huePos+4) % hueArrayLen];
  b = hueArray[(huePos+8) % hueArrayLen];
  return leds.Color(r,g,b);
}

void colourTime(uint32_t colour, int wait) {
  leds.setPixelColor(0, colour);
  leds.setBrightness(MAXBRIGHT);
  leds.show();
  delay(wait);
}

void colourTime(byte r, byte g, byte b, int wait) {
  leds.setPixelColor(0, r,g,b);
  leds.setBrightness(MAXBRIGHT);
  leds.show();
  delay(wait);
}

void breathTime(uint32_t colour, int wait) {
  // Wait Needs to be more then 255

  
  if(wait>MAXBRIGHT) {
    for (int i=MINBRIGHT; i<MAXBRIGHT; i++) {
      leds.setPixelColor(0, colour);
      leds.setBrightness(i);
      leds.show();
      delay(wait/((MAXBRIGHT-MINBRIGHT)*2));
    }
    for (int i=MAXBRIGHT-1; i>MINBRIGHT; i--) {
      leds.setPixelColor(0, colour);
      leds.setBrightness(i);
      leds.show();
      delay(wait/((MAXBRIGHT-MINBRIGHT)*2));
    }
  }
}

void default_setting_in_eeprom() {
  settings_in_eeprom.found_stored_settings = 0;
  settings_in_eeprom.colour = leds.Color(255,255,255);
  settings_in_eeprom.setting_menu = 3;
  write_setting_in_eeprom();
}

void write_setting_in_eeprom() {
  eeprom_write_block((const void*)&settings_in_eeprom, (void*)EEPROM_START_OFFSET, sizeof(settings_in_eeprom));
}

//  uint8_t
//      r = (uint8_t)(c >> 16),
//      g = (uint8_t)(c >>  8),
//      b = (uint8_t)c;
