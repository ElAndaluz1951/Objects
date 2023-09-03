program Project2;

uses
  Vcl.Forms,
  PrjMyHouse in 'PrjMyHouse.pas' {Form2},
  unitMyHouse in 'unitMyHouse.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
