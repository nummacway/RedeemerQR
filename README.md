# RedeemerQR
Minimalist QR code generator for Delphi

Also includes a class to draw a two-dimensional bit field (a `type TBoolean2D = array of array of Boolean;`)

## Limitations
There are no severe limitations, as only the following features are missing:
* Supports only numeric, alphanumeric and Latin1 encodings
* ECI (Extended Channel Interpretation) support is not included in this unit; however, it is rarely supported by decoders and is basically just a way to encode input that the current class would already encode
* Doesn't yet support compression by splitting input into multiple input parts

Unicode, which is not officially supported by QR codes, may still be used, as this class supports a RawByteString input.

I found inconsistent information on the third step of determining the mask (`RateMask3()` - currently counts `1+:1:3:1:1:4+` color change pattern), so this unit may choose a different mask than other encoders that count differently. In that case, it will result in different output images, which are still valid, as choosing the optimal mask is not strictly required.

## Usage
When running LoadFromString, the class produces a `TGraphic` descendant.
```pascal
QR := TRedeemerQR.Create();
try
  QR.LoadFromString('my text', ecLow); // available error correction levels: ecLow, ecMedium, ecQuarter, ecHigh
  // do something with QR, e.g. Image1.Picture.Assign(QR);
finally
  QR.Free();
end; 
```
This is a `TPNGImage` descendant, so you can save the resulting `TGraphic` as a 24-bits `.png` file for further processing.

## Requirements
This is supposed to compile with Delphi 2009 and up. It does not require any units that do not come with Delphi's default installation.

All classes in these units are inherited by TPNGImage.

## Acknowledgements
This unit was created using information from the following sources:
* [Swetake](https://www.swetake.com/qrcode/qr1_en.html) (understanding the process in general)
* [Thonky](https://www.thonky.com/qr-code-tutorial/introduction) (mask rating and most constants)
* [Wikiversity](https://en.wikiversity.org/wiki/Reed%E2%80%93Solomon_codes_for_coders/Additional_information) (further constants and interleaving of Reed-Solomon blocks, especially those of inconsistent length)

## Other notes
Code may contain traces of German, swears and irony.

## Copyright
Copyright © 2017, 2020 Janni "Redeemer" K.
