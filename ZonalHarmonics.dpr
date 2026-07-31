program ZonalHarmonics;

uses
  System.StartUpCopy,
  FMX.Forms,
  LUX in '_LIBRARY\LUXOPHIA\LUX\LUX.pas',
  LUX.D1 in '_LIBRARY\LUXOPHIA\LUX\LUX.D1.pas',
  LUX.D2 in '_LIBRARY\LUXOPHIA\LUX\LUX.D2.pas',
  LUX.D2x2 in '_LIBRARY\LUXOPHIA\LUX\LUX.D2x2.pas',
  LUX.D3 in '_LIBRARY\LUXOPHIA\LUX\LUX.D3.pas',
  LUX.D3x3 in '_LIBRARY\LUXOPHIA\LUX\LUX.D3x3.pas',
  LUX.D4 in '_LIBRARY\LUXOPHIA\LUX\LUX.D4.pas',
  LUX.D4x4 in '_LIBRARY\LUXOPHIA\LUX\LUX.D4x4.pas',
  LUX.S2 in '_LIBRARY\LUXOPHIA\LUX.Sphere\S2\LUX.S2.pas',
  LUX.FMX.Graphics.D3 in '_LIBRARY\LUXOPHIA\LUX.FMX.Graphics.D3\LUX.FMX.Graphics.D3.pas',
  LUX.FMX.Graphics.D3.Shaper in '_LIBRARY\LUXOPHIA\LUX.FMX.Graphics.D3\LUX.FMX.Graphics.D3.Shaper.pas',
  Main in 'Main.pas' {Form1},
  Core in 'Core.pas',
  Viewer in 'Viewer.pas' {ViewerFrame: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
