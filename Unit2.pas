unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Ani,
  FMX.Objects, FMX.Layouts, FMX.StdCtrls, FMX.Controls.Presentation,
  System.Sensors, System.Sensors.Components;

type
  TForm2 = class(TForm)
    Layout1: TLayout;
    Circle1: TCircle;
    FloatAnimation1: TFloatAnimation;
    RoundRect2: TRoundRect;
    RoundRect3: TRoundRect;
    RoundRect4: TRoundRect;
    RoundRect5: TRoundRect;
    RoundRect6: TRoundRect;
    RoundRect8: TRoundRect;
    RoundRect9: TRoundRect;
    RoundRect11: TRoundRect;
    RoundRect14: TRoundRect;
    RoundRect15: TRoundRect;
    RoundRect16: TRoundRect;
    RoundRect17: TRoundRect;
    RoundRect18: TRoundRect;
    Label1: TLabel;
    Button1: TButton;
    StyleBook1: TStyleBook;
    MotionSensor1: TMotionSensor;
    Timer1: TTimer;
    procedure FloatAnimation1Process(Sender: TObject);
    procedure Layout1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Single);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}
{$R *.XLgXhdpiTb.fmx ANDROID}

procedure TForm2.Button1Click(Sender: TObject);
Var k:TFmxObject;
begin
        RandSeed:=2837;
        Button1.Visible:=False;
        Circle1.TagFloat:=0;
         for k in Layout1.Children
    do if k is TShape then With TShape(k).Position do DefaultValue:= Point;// Reset fase
        FloatAnimation1.Start;

end;

procedure TForm2.FloatAnimation1Process(Sender: TObject);
  Var k:TFmxObject;
      t: TRectF;
begin
  if FloatAnimation1.Inverse then
  begin  // bola caindo
     With Circle1 do t:=TRectF.Create(Position.Point, Width, Height);
     if not Layout1.BoundsRect.Contains(t.CenterPoint) then
     begin
        FloatAnimation1.StopAtCurrent;
        Button1.Text:='Tentar novamente'+
                        LineFeed+
                        LineFeed+
                        'Pontua��o'+IntToStr(Trunc(Circle1.TagFloat))+
                        LineFeed+
                        'Record'+ IntToStr(Trunc(Layout1.TagFloat));
     if Layout1.TagFloat < Circle1.TagFloat then
          Layout1.TagFloat:=Circle1.TagFloat;// novo recorde
     Button1.Visible:=True;// mostrar bot�o com resultados
     Label1.Text:='Tremendous Ball';

     end
    else for k in Layout1.Children
      do if k is TRoundRect
        then With TRoundRect(k)
              do if PtInRect (TRectf.Create(Position.Point, Width, Height),t.CenterPoint )
                  then
                  begin
                    FloatAnimation1.Inverse:=  False;
                    if Fill.Color= TAlphaColorRec.Red
                      then Circle1.Tag:=1
                        else Circle1.Tag:=0;
                         Fill.Color:= TAlphaColorRec.Red;
                         Break;
                  end;
  end;
                    if Not FloatAnimation1.Inverse and (Circle1.Tag<1) then begin // condi��o para pular
                      With Circle1 Do TagFloat:=TagFloat+5*0.5;// pontua��o
                     if TagFloat=1000 then
                     begin
                       FloatAnimation1.Duration:=1;
                     end;


                      Label1.Text:='Pontua��o'+IntToStr(Trunc(Circle1.TagFloat));
                        for k in Layout1.Children
                          do if k is TRoundRect
                                    then With TRoundRect(k)
                                          do begin
                                              Position.Y:=Position.Y+Height* 0.5;
                                              if Position.Y > Layout1.Height
                                             then begin
                                                  Position.Y := Height;
                                                  Position.X:=(Layout1.Width -Width )* Random;
                                                  Fill.Color:=$FFE0E0E0;
                                                  end;
                                              end;

                    end;
        Layout1.Repaint;
end;

procedure TForm2.FormCreate(Sender: TObject);
var k:TFmxObject;
begin
  for k in Layout1.Children
    do if k is TShape then With TShape(k).Position do DefaultValue:= Point;


end;

procedure TForm2.Layout1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Single);
begin
if FloatAnimation1.Running then Circle1.Position.X:= X;  // fazer a bola se movimentar



end;

procedure TForm2.Timer1Timer(Sender: TObject);
begin
if FloatAnimation1.Running then Circle1.Position.X:= 500*MotionSensor1.Sensor.AccelerationX;  // fazer a bola se movimentar
end;

end.
