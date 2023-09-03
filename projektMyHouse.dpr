program projektMyHouse;

uses
  Vcl.Forms,
  PrjMyHouse in 'PrjMyHouse.pas' {frmWirBauenEineSiedlung},
  unitMyHouse in 'unitMyHouse.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmWirBauenEineSiedlung, frmWirBauenEineSiedlung);
  Application.Run;
end.
