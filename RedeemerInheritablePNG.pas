unit RedeemerInheritablePNG;

interface

uses pngimage;

type TChunkIHDR2 = class(TChunkIHDR); // hole protected-Methode PrepareImageData
type PChunkIHDR2 = ^TChunkIHDR2;

type TRedeemerInheritablePNG = class(TPNGImage)
  public
    procedure InitBlankNonPaletteImage(const ColorType, BitDepth: Cardinal; const cx, cy: Integer);
end;

implementation

{ TRedeemerInheritablePNG }

procedure TRedeemerInheritablePNG.InitBlankNonPaletteImage(const ColorType,
  BitDepth: Cardinal; const cx, cy: Integer);
var
  PHDR: PChunkIHDR2;
  NewIHDR: TChunk;
begin
  // CreateBlank-Methode ohne Create, Überprüfung auf Richtigkeit der Parameter
  // und ohne Unterstützung für Paletten
  InitializeGamma;
  BeingCreated := True;
  Chunks.Add(TChunkIEND);
  NewIHDR := Chunks.Add(TChunkIHDR);
  PHDR := @NewIHDR; // fick dich, RTTI
  PHDR^.ColorType := ColorType;
  PHDR^.BitDepth := BitDepth;
  PHDR^.Width := cx;
  PHDR^.Height := cy;
  PHDR^.PrepareImageData;

  Chunks.Add(TChunkIDAT);
  BeingCreated := False;
end;

end.
