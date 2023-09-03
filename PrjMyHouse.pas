unit PrjMyHouse;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  system.Generics.Collections,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  unitMyHouse, AdvGlowButton, Vcl.ExtCtrls, AdvPanel, Vcl.StdCtrls, AdvGroupBox, AdvOfficeButtons ;

    
type
  TfrmWirBauenEineSiedlung = class(TForm)
    AdvPanel2: TAdvPanel;
    AdvOfficeCheckGroup1: TAdvOfficeCheckGroup;
    btnHausBauen: TAdvGlowButton;
    btrnSiedlungBauen: TAdvGlowButton;
    btnDachFarbeAendern: TAdvGlowButton;
    procedure btnHausBauenClick(Sender: TObject);
    procedure btnDachFarbeAendernClick(Sender: TObject);
    procedure AdvGlowButton4Click(Sender: TObject);
    procedure btnLichtSchalterMeinHausClick(Sender: TObject);
    procedure AdvOfficeCheckGroup1CheckBoxClick(Sender: TObject; CheckBoxIndex: Integer;
      Value: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btnSiedlungBauenClick(Sender: TObject);
  private
    { Private-Deklarationen }

    myHausListe : TObjectList<THaus>;
    
    oMeinHaus         : THaus;
    oDeinHaus         : THaus;
    oJeffsHaus        : THaus;
    oNachbarHaus1     : THaus;
    oNachbarHaus2     : THaus;
    oSiedlungHaus01   : THaus;
    oSiedlungHaus02   : THaus;
    oSiedlungHaus03   : THaus;
    oSiedlungHaus04   : THaus;
    oSiedlungHaus05   : THaus;
    
    
    aSevilla      : array[1..5] of THaus;
        
  public
    { Public-Deklarationen }
  end;

var
  frmWirBauenEineSiedlung: TfrmWirBauenEineSiedlung;

implementation

{$R *.dfm}
//--------------------------------------------------------------------------------------------------
// genericst für die Objektliste veerwendenhttps://www.youtube.com/watch?v=8RV_9VsaKwk
//--------------------------------------------------------------------------------------------------
procedure TfrmWirBauenEineSiedlung.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  MyHausListe.Free;
  MyHausListe := nil;
end;
//--------------------------------------------------------------------------------------------------
procedure TfrmWirBauenEineSiedlung.FormCreate(Sender: TObject);
begin
  MyHausListe  := TObjectList<THaus>.create;
  
end;
//--------------------------------------------------------------------------------------------------
procedure TfrmWirBauenEineSiedlung.AdvOfficeCheckGroup1CheckBoxClick(Sender: TObject;
  CheckBoxIndex: Integer; Value: Boolean);
var
  nI : integer;  
begin
  
  //------------------------------------------------------------------------------------------------    
  if ( CheckBoxIndex <= 1 ) then
    if ( myHausListe[CheckBoxIndex].fIsLichtAn )  then
      myHausListe[CheckBoxIndex].LichtAusschalten
    else
      myHausListe[CheckBoxIndex].LichtEinschalten;
  //------------------------------------------------------------------------------------------------    
  // Siedlung einschalten 1 + 2 sind die Privathäuser, an 3 = Siedlung 1
  //------------------------------------------------------------------------------------------------    

  if ( CheckBoxIndex = 3 ) then
  begin
    for nI := 2 to myHausliste.count -1 do
    begin  

      if ( myHausListe[nI].fIsLichtAn )  then
        myHausListe[nI].LichtAusschalten
      else
        myHausListe[nI].LichtEinschalten;
    end;
  end;
  //------------------------------------------------------------------------------------------------    
  if ( CheckBoxIndex = 4 ) then
  begin
    for nI := 0 to myHausliste.count -1 do
    begin  

      if ( myHausListe[nI].fIsLichtAn )  then
        myHausListe[nI].LichtAusschalten
      else
        myHausListe[nI].LichtEinschalten;
    end;
  //------------------------------------------------------------------------------------------------    

  
  end;
      
          
end;

//--------------------------------------------------------------------------------------------------
procedure TfrmWirBauenEineSiedlung.btnDachFarbeAendernClick(Sender: TObject);
var
  nI : integer;
begin

  for nI := 0 to myHausliste.Count -1 do
  begin
    if myHausliste[nI].Dachfarbe = clSilver then
      myHausliste[nI].Dachfarbe := clMaroon
    else
      myHausliste[nI].Dachfarbe := clSilver;

  end;
end;
//--------------------------------------------------------------------------------------------------
procedure TfrmWirBauenEineSiedlung.AdvGlowButton4Click(Sender: TObject);
begin
    
end;
//--------------------------------------------------------------------------------------------------
procedure TfrmWirBauenEineSiedlung.btnHausBauenClick(Sender: TObject);
begin

  oMeinHaus       := THaus.create(   60  ,          // left
                                    100  ,          // top
                                    160  ,          // Breite
                                     10  ,          // Dachüberstand     
                                    clCream,        // Hausfarbe
                                    clMaroon,       // Dachfarbe
                                    clYellow,       // Lichtfarebe
                                    clWhite,        // Fensterfarbe
                                    self            // auf mir selbst, also auf diesem Formular 
                                  ) ;

  oDeinHaus       := THaus.create(  300,            // left
                                    140,            // Top
                                     60,             // Breite
                                     10  ,           // Dachüberstand     
                                    clMoneygreen,   // Farbe
                                    clMaroon,       // Dachfarbe $D13438,
                                    clYellow,       // Lichtfarbe
                                    clSilver,
                                    self            // auf mir selbst, also auf diesem Formular 
                                  ) ;
  // oMeinHaus.zeichnen;
  // oDeinHaus.zeichnen;
  myHausliste.Clear;
  myHausListe.Add(oMeinHaus);
  myHausListe.Add(oDeinHaus);
  myHausListe[0].zeichnen;
  myHausListe[1].zeichnen;
  
  
  {
  myHausListe.Add(oJeffsHaus);
  myHausListe.Add(oNachbarHaus1);
  myHausListe.Add(oNachbarHaus2);
  myHausListe.Add(oSiedlungHaus01);
  myHausListe.Add(oSiedlungHaus02);
  myHausListe.Add(oSiedlungHaus03);
  myHausListe.Add(oSiedlungHaus04);
  myHausListe.Add(oSiedlungHaus05);
  }
                                
end;
//--------------------------------------------------------------------------------------------------
procedure TfrmWirBauenEineSiedlung.btnLichtSchalterMeinHausClick(Sender: TObject);
begin

  if ( oMeinHaus.fIsLichtAn )  then
    oMeinHaus.LichtAusschalten
  else
    oMeinHaus.LichtEinschalten;

end;
//--------------------------------------------------------------------------------------------------
procedure TfrmWirBauenEineSiedlung.btnSiedlungBauenClick(Sender: TObject);
var
  nI                : integer;
  nANzahlVorhandene : integer;
begin
  nAnzahlVorhandene := MyHausliste.count;

  oSiedlungHaus01   := THaus.create(  660,              // left
                                       40,            // Top
                                       45,               // Breite
                                       10  ,             // Dachüberstand     
                                      clMoneygreen,     // Farbe
                                      clMaroon,         // Dachfarbe $D13438,
                                      clYellow,         // Lichtfarbe
                                      clSilver,
                                      self              // auf mir selbst, also auf diesem Formular 
                                    ) ;

                                    
  oSiedlungHaus02   := THaus.create(  660,              // left
                                      130,              // Top
                                       45,              // Breite
                                       10  ,            // Dachüberstand     
                                      clMoneygreen,     // Farbe
                                      clMaroon,         // Dachfarbe $D13438,
                                      clYellow,         // Lichtfarbe
                                      clSilver,
                                      self              // auf mir selbst, also auf diesem Formular 
                                    ) ;

  oSiedlungHaus03   := THaus.create(  660,              // left
                                      220,              // Top
                                       45,              // Breite
                                       10  ,            // Dachüberstand     
                                      clMoneygreen,     // Farbe
                                      clMaroon,         // Dachfarbe $D13438,
                                      clYellow,         // Lichtfarbe
                                      clSilver,
                                      self              // auf mir selbst, also auf diesem Formular 
                                    ) ;

  oSiedlungHaus04   := THaus.create(  660,              // left
                                      310,              // Top
                                       45,              // Breite
                                       10  ,            // Dachüberstand     
                                      clMoneygreen,     // Farbe
                                      clMaroon,         // Dachfarbe $D13438,
                                      clYellow,         // Lichtfarbe
                                      clSilver,
                                      self              // auf mir selbst, also auf diesem Formular 
                                    ) ;
                                    
  oSiedlungHaus05   := THaus.create(  660,              // left
                                      400,              // Top
                                       50,              // Breite
                                       10  ,            // Dachüberstand     
                                      clMoneygreen,     // Farbe
                                      clMaroon,         // Dachfarbe $D13438,
                                      clYellow,         // Lichtfarbe
                                      clSilver,
                                      self              // auf mir selbst, also auf diesem Formular 
                                    ) ;


                                    
  myHausListe.Add(oSiedlungHaus01);
  myHausListe.Add(oSiedlungHaus02);
  myHausListe.Add(oSiedlungHaus03);
  myHausListe.Add(oSiedlungHaus04);
  myHausListe.Add(oSiedlungHaus05);
  
  nAnzahlVorhandene := MyHausliste.count-1;
  for nI := 0 to nAnzahlVorhandene do
    myHausListe[nI].zeichnen;
    
end;
//--------------------------------------------------------------------------------------------------
end.
