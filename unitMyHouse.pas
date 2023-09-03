unit unitMyHouse;

interface
  uses classes, 
  forms ,
  graphics; 

  // wird nicht gebraucht im Momentsystem.types ;    // TPoint, TPoint.Add, TPoint.Subtract, TPoint Distance

type
 // als Komponente ist es nicht TObject sondern (TComponent);
 THaus = class( TObject )  // THaus ist ein Child vonm TObject und hat alles was tObject kann

   private               // Variablen die nur hier in dieser Klasse sichtbar sind von Aussen nicht zugänglich oder veränderbar
    fLinks          : integer;
    fOben           : integer; // ganzzahlige Zahl
    fBreite         : integer;
    fDachUeberstand : integer;
    Raster          : integer; // sollte eigentlich nR sein zum Zeichen dass das numerisch ist,kleines n=numerisch
    fHausFarbe      : TColor;  // Object, hier ein Record der alles zu einer Farbe enthält
    fDachFarbe      : TColor;
    fLichtFarbe     : TColor;
    fFensterfarbe   : TColor;
    fBesitzer       : TForm;
    fLichtAn        : boolean; // logische Variable Werts true oder false
    
    procedure pZeichneWand( );    // eine Prozedure die etwas macht
    procedure pZeichneDach( );    // eine Prozedure die etwas macht
    procedure pZeichneFenster( ); // eine Prozedure die etwas macht
    procedure pZeichneTuere( );
    procedure setDachfarbe(const Value: TColor);   // eine Prozedure die etwas macht

    
  public      // das ist der Bereich der öffentlich sichtbar ist, also von aussen abgefragt werden kann oder gesetzt werden kann
    constructor create (  xPos            : integer;
                          yPos            : integer; 
                          nBreite         : integer;  // die Masse des Hauses
                          nDachUeberstand : integer;  // soviel soll das Dach über das Haus stehen link und rechts
                          colHausFarbe    : TColor ;  // die Farben etc.
                          colDachFarbe    : TColor ;  // die Farben etc.
                          colLichtFarbe   : TColor ;  // die Farben etc.
                          colFensterFarbe : TColor ;
                          Besitzer        : TForm );  // wer wird Besitzer von diesem Haus, also dieser Klasse
                                                  // da wir das Haus ja irgendwo anzeigen wollen ist das Formular in welchem0
                                                  // das angezeigt wird dann auch der Besitzer dieses Hauses, also wird
                                                  // beim Create bestimmt wem das Haus dann später nach dem Erzeugen gehört
       
    procedure zeichnen;
    procedure LichtEinschalten;
    procedure LichtAusschalten;
    Function  fIsLichtAn    :boolean; // Funktionen geben immer einen Wert zurück, also das Ergebnis, in diesem Fall eben Ja oder Nein = true oder false;
                                      // , in diesem Fall eben Ja oder Nein = true oder false;
    //----------------------------------------------------------------------------------------------
    // Mit dieser Form wird die Eigenschaft Dachfarbe öffntlich zugänglich gemacht und zwar zum 
    // lesen oder zum Schreiben oder für beides
    // ( fortgeschrittene profesionelle Variante )
    // als visuelle Komponente muss das Property in den Bereich published;
    //----------------------------------------------------------------------------------------------
    Property  Dachfarbe : TColor read fDachFarbe write setDachfarbe;
    
 end;

implementation
//--------------------------------------------------------------------------------------------------
// um das Haus im Programm zu konstrieren müssen wir das Haus über CREATE erzeugen
// Create ist eine Grundfunktion aller Objekte, die Objekte schon in der untersten Ebene besitzen 
// ohne Create existiert ja auch nix. Usner Haus ist als TObjekt definiert, mit dieser Definition
// erbt das Haus praktisch schon alles was ein normales Objekt immer hat. Wir brauchen dann beim
// erzeugen nur noch die Masse oder andere Eigenschaften zu setzen und das Objekt Haus wird
// dann autoamtisch erzeigt mit den eigenen Properties und mit allen von TObject vererbten 
// Propertis und events
//--------------------------------------------------------------------------------------------------
constructor THaus.create (  xPos              : integer;
                            yPos              : integer; 
                            nBreite           : integer;  
                            nDachUeberstand   : integer;
                            colHausFarbe      : TColor ;  
                            colDachFarbe      : TColor ;
                            colLichtFarbe     : TColor ;
                            colFensterFarbe   : TColor ;
                            Besitzer          : TForm 
                         );  
begin
  inherited create;    // Aufruf des, vom Construtor geerbten Objektes (TObject)
  fLinks        := xPos;
  fOben         := yPos;
  fBreite       := nBreite;
  Raster        := nBreite div 5; // ein Raster in der Zeichnung für die Fenster etc 1/5 der Hausbreite
  fHausFarbe    := colHausFarbe;  // Object, hier ein Record der alles zu einer Farbe enthält
  fDachFarbe    := colDachFarbe;  // Object, hier ein Record der alles zu einer Farbe enthält
  fLichtFarbe   := colLichtFarbe;  // Object, hier ein Record der alles zu einer Farbe enthält
  fFensterFarbe := colFensterFarbe;
  fBesitzer     := Besitzer;
  fLichtAn      := false; // logische Variable Werts true oder false
end;
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
Procedure THaus.Zeichnen;
begin

  fBesitzer.canvas.pen.color := clgray;
  
  pZeichneWand;
  pZeichneDach;
  pZeichneFenster;
  pZeichneTuere;
end;
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
procedure THaus.pZeichneWand( ); // eine Prozedure die etwas macht
begin
  //------------------------------------------------------------------------------------------------
  // Es gibt zwei verschiedene Formen wie man jetzt das Haus konstruiert (von der Syntax her) also
  // wie man es schreiben kann, die Methode mit "with"  ist eigentlich Mist, weil bei längeren
  // Programmsequenzen also mit vielen Zeilen nicht immer klas ist, ob das jetzt ein Wert ist der 
  // zum Haus gehört oder einfach ein Wert der zum Rechnen verwendet wird
  //------------------------------------------------------------------------------------------------
  // viel bessere und klarere, eindeutige Schreibweise ( mehr zu schreiben, besser zu lesen )
  //------------------------------------------------------------------------------------------------
  fLichtAn := false; // wenn das Haus begonnen wird, dann soll das Licht immer aus sein
  //------------------------------------------------------------------------------------------------
  
  
  fbesitzer.canvas.Brush.Color  := fHausFarbe;

  fbesitzer.canvas.rectangle    ( fLinks  ,               
                                  fOben   ,
                                  fLinks  + fBreite, 
                                  fOben   + fBreite );
  
  //------------------------------------------------------------------------------------------------
end;
//--------------------------------------------------------------------------------------------------
procedure THaus.setDachfarbe(const Value: TColor);
begin
  fDachFarbe := Value;
  pZeichneDach;
end;
//--------------------------------------------------------------------------------------------------
procedure THaus.pZeichneDach( ); // eine Prozedure die etwas macht
var
  // myPoints  : array of TPoint; // braucht System
  x,y,s     : integer;
  oColor    : TColor;
begin
  {
  setlength   ( myPoints,3);

  x := fx + ( fx div 2 ) ;
  y := fy + ( fy div 2 ) ;
  s := fx+fBreite div 2 ;

  
  
  myPoints[0] := Point( 20,20 );       //  
  myPoints[1] := Point( fx, 100+30 );   // 
  myPoints[2] := Point( 30,30 );
  }

  // fbesitzer.canvas.polygon ( myPoints )   ;
  fbesitzer.canvas.pen.Width    := 2;       // Stiftbreite
  fbesitzer.canvas.pen.Color    := clnavy;  // Farbe des Stiftes

  fbesitzer.canvas.MoveTo ( fLinks-2, fOben-2 )  ;
  fbesitzer.canvas.LineTo ( fLinks-2  + ( fBreite div 2 ) , foben-32 )  ;
  fbesitzer.canvas.LineTo ( fLinks    + fBreite, foben-2 )  ;
  fbesitzer.canvas.LineTo ( fLinks  , foben-2 )  ;


  x := fLinks-2  + ( fBreite div 2 );
  y := fOben-32 +3 ; 
  
  // canvas.FloodFill( x,y+2, canvasPixel (x,y ), fsSurface );

  fbesitzer.canvas.Brush.Color  := fDachFarbe;    
  fbesitzer.canvas.Brush.Style  := bsSolid;       // wie soll die Fläche gefüllt werden = ganzflächig ohne Muster
  //------------------------------------------------------------------------------------------------
  // Holt die aktuelle Farbe vom einem Pixel innerhalb der Zeichenfläche des auszufüllenden Bereichs.
  // Coord sind Dachspitze + 3
  //
  //------------------------------------------------------------------------------------------------
  oColor := fBesitzer.Canvas.Pixels[ x, y ];  // Canvas ist die Zeichenfläche
  //------------------------------------------------------------------------------------------------
  // Gefüllt wird die Flache vom einem beliebigen Punkt aus innerhalb eines Rechtecks oder
  // Polygons, verändert wird die originalfarbe der geometrischen Form mit der Farbe des
  // und dem Stil (solid) des Pinsels der für den Canvas gesetzt wurde
  //------------------------------------------------------------------------------------------------
  fbesitzer.canvas.FloodFill(x,y,oColor, fsSurface)
  
end;
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
procedure THaus.pZeichneFenster( ); // eine Prozedure die etwas macht
var
  nFensterBreite  : integer;
  nI              : integer;
begin

  nFensterBreite := Raster;

  if ( fIsLichtAn )  then
    fbesitzer.canvas.Brush.Color  := fLichtFarbe
  else
    fbesitzer.canvas.Brush.Color  := fFensterFarbe;
  //------------------------------------------------------------------------------------------------
  // 1. Fenster links oben
  //------------------------------------------------------------------------------------------------
  fbesitzer.canvas.rectangle    ( fLinks  + Raster  ,               
                                  fOben   + Raster  ,
                                  fLinks  + Raster + nFensterBreite, 
                                  fOben   + Raster + nFensterBreite );

  //------------------------------------------------------------------------------------------------
  // 2. Fenster rechts oben
  //------------------------------------------------------------------------------------------------
  fbesitzer.canvas.rectangle    ( fLinks  + Raster + nFensterBreite + Raster ,               
                                  fOben   + Raster  ,     
                                  fLinks  + Raster + nFensterBreite + Raster + nFensterBreite, 
                                  fOben   + Raster + nFensterBreite  );
                                  
  //------------------------------------------------------------------------------------------------
  // 3. Fenster rechts unten
  //------------------------------------------------------------------------------------------------
  //                                60    +   32   +       32           32          32
  fbesitzer.canvas.rectangle    ( fLinks  + Raster + nFensterBreite + Raster ,               
                                  fOben   + Raster + nFensterBreite + Raster ,     
                                  fLinks  + Raster + nFensterBreite + Raster + nFensterBreite, 
                                  fOben   + Raster + nFensterBreite + Raster + nFensterbreite );

  nI := 0;                                
                                  
end;
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
procedure THaus.pZeichneTuere( ); // eine Prozedure die etwas macht
var
  nTuerBreite  : integer;
begin

  nTuerBreite := Raster;
  
  if ( fIsLichtAn )  then
    fbesitzer.canvas.Brush.Color  := fLichtFarbe
  else
    fbesitzer.canvas.Brush.Color  := fFensterFarbe;
  //------------------------------------------------------------------------------------------------
  // Türe Zeichnen, die Türe ist doppelt so Hoch wie ein Fenster aber gleich Breit
  //------------------------------------------------------------------------------------------------
  fbesitzer.canvas.rectangle    ( fLinks  + Raster  ,               
                                  fOben   + Raster + Raster + Raster,     
                                  fLinks  + Raster + nTuerBreite , 
                                  fOben   + Raster + nTuerBreite + Raster + nTuerBreite*2 );

end;
//--------------------------------------------------------------------------------------------------
procedure THaus.LichtEinschalten;
begin
  fLichtAn := true;
  pZeichneFenster;
  pZeichneTuere();
end;
//--------------------------------------------------------------------------------------------------
procedure THaus.LichtAusSchalten;
begin
  fLichtAn := false;
  pZeichneFenster;
  pZeichneTuere();
end;
//--------------------------------------------------------------------------------------------------
function THaus.fIsLichtAn : boolean;
begin
  result := fLichtAn;
end;
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------

end.
