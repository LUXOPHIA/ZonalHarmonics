﻿unit LUX.S3.Curve.Glerp;

// Glerp :Gnomonic Linear Interpolation

interface //#################################################################### ■

uses LUX,
     LUX.S3,
     LUX.S3.Curve;

//type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 T Y P E 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Glerp

function Glerp( const P1_,P2_:TSingle3S ) :TSingle3S; overload;
function Glerp( const P1_,P2_:TDouble3S ) :TDouble3S; overload;

function Glerp( const P1_,P2_:TSingle3S; const T_:Single ) :TSingle3S; overload;
function Glerp( const P1_,P2_:TDouble3S; const T_:Double ) :TDouble3S; overload;

function Glerp( const P1_,P2_:TSingle3S; const W1_,W2_:Single ) :TSingle3S; overload;
function Glerp( const P1_,P2_:TDouble3S; const W1_,W2_:Double ) :TDouble3S; overload;

function Glerp( const P1_,P2_:TSingleW3S ) :TSingleW3S; overload;
function Glerp( const P1_,P2_:TDoubleW3S ) :TDoubleW3S; overload;

function Glerp( const P1_,P2_:TSingle3Sw ) :TSingle3Sw; overload;
function Glerp( const P1_,P2_:TDouble3Sw ) :TDouble3Sw; overload;

function Glerp( const Ps_:TArray<TSingle3S> ) :TSingle3S; overload;
function Glerp( const Ps_:TArray<TDouble3S> ) :TDouble3S; overload;

function Glerp( const Ps_:TArray<TSingleW3S> ) :TSingleW3S; overload;
function Glerp( const Ps_:TArray<TDoubleW3S> ) :TDoubleW3S; overload;

function Glerp( const Ps_:TArray<TSingle3Sw> ) :TSingle3Sw; overload;
function Glerp( const Ps_:TArray<TDouble3Sw> ) :TDouble3Sw; overload;

implementation //############################################################### ■

uses LUX.Curve.Q4.Linear;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Glerp

function Glerp( const P1_,P2_:TSingle3S ) :TSingle3S;
begin
     Result := Lerp( P1_, P2_ ).Unitor;
end;

function Glerp( const P1_,P2_:TDouble3S ) :TDouble3S;
begin
     Result := Lerp( P1_, P2_ ).Unitor;
end;

//------------------------------------------------------------------------------

function Glerp( const P1_,P2_:TSingle3S; const T_:Single ) :TSingle3S;
begin
     Result := Lerp( P1_, P2_, T_ ).Unitor;
end;

function Glerp( const P1_,P2_:TDouble3S; const T_:Double ) :TDouble3S;
begin
     Result := Lerp( P1_, P2_, T_ ).Unitor;
end;

//------------------------------------------------------------------------------

function Glerp( const P1_,P2_:TSingle3S; const W1_,W2_:Single ) :TSingle3S;
begin
     Result := Lerp( P1_, P2_, W1_, W2_ ).Unitor;
end;

function Glerp( const P1_,P2_:TDouble3S; const W1_,W2_:Double ) :TDouble3S;
begin
     Result := Lerp( P1_, P2_, W1_, W2_ ).Unitor;
end;

//------------------------------------------------------------------------------

function Glerp( const P1_,P2_:TSingleW3S ) :TSingleW3S;
begin
     Result.v := Glerp( P1_.v, P2_.v, P1_.w, P2_.w );
     Result.w := P1_.w + P2_.w;
end;

function Glerp( const P1_,P2_:TDoubleW3S ) :TDoubleW3S;
begin
     Result.v := Glerp( P1_.v, P2_.v, P1_.w, P2_.w );
     Result.w := P1_.w + P2_.w;
end;

//------------------------------------------------------------------------------

function Glerp( const P1_,P2_:TSingle3Sw ) :TSingle3Sw;
begin
     Result.v := Glerp( P1_.v, P2_.v, P1_.w, P2_.w );
     Result.w := P1_.w + P2_.w;
end;

function Glerp( const P1_,P2_:TDouble3Sw ) :TDouble3Sw;
begin
     Result.v := Glerp( P1_.v, P2_.v, P1_.w, P2_.w );
     Result.w := P1_.w + P2_.w;
end;

//------------------------------------------------------------------------------

function Glerp( const Ps_:TArray<TSingle3S> ) :TSingle3S;
var
   P :TSingle3S;
begin
     Result := 0;

     for P in Ps_ do Result := Result + P;

     Result := Result.Unitor;
end;

function Glerp( const Ps_:TArray<TDouble3S> ) :TDouble3S;
var
   P :TDouble3S;
begin
     Result := 0;

     for P in Ps_ do Result := Result + P;

     Result := Result.Unitor;
end;

//------------------------------------------------------------------------------

function Glerp( const Ps_:TArray<TSingleW3S> ) :TSingleW3S;
var
   P :TSingleW3S;
begin
     Result := TSingleW3S.Create( 0, 0 );

     for P in Ps_ do Result.w := Result.w + P.w;

     if Abs( Result.w ) < SINGLE_EPS3 then
     begin
          for P in Ps_ do Result.v := Result.v + P.v;
     end
     else
     begin
          for P in Ps_ do Result.v := Result.v + P.w * P.v;

          Result.v := Result.v / Result.w;
     end;

     Result := Result.Unitor;
end;

function Glerp( const Ps_:TArray<TDoubleW3S> ) :TDoubleW3S;
var
   P :TDoubleW3S;
begin
     Result := TDoubleW3S.Create( 0, 0 );

     for P in Ps_ do Result.w := Result.w + P.w;

     if Abs( Result.w ) < DOUBLE_EPS3 then
     begin
          for P in Ps_ do Result.v := Result.v + P.v;
     end
     else
     begin
          for P in Ps_ do Result.v := Result.v + P.w * P.v;

          Result.v := Result.v / Result.w;
     end;

     Result := Result.Unitor;
end;

//------------------------------------------------------------------------------

function Glerp( const Ps_:TArray<TSingle3Sw> ) :TSingle3Sw;
var
   P :TSingle3Sw;
begin
     Result := TSingleW3S.Create( 0, 0 );

     for P in Ps_ do Result.w := Result.w + P.w;

     if Abs( Result.w ) < SINGLE_EPS3 then
     begin
          for P in Ps_ do Result.v := Result.v + P.v;
     end
     else
     begin
          for P in Ps_ do Result.v := Result.v + P.w * P.v;

          Result.v := Result.v / Result.w;
     end;

     Result.v := Result.v.Unitor;
end;

function Glerp( const Ps_:TArray<TDouble3Sw> ) :TDouble3Sw;
var
   P :TDouble3Sw;
begin
     Result := TDoubleW3S.Create( 0, 0 );

     for P in Ps_ do Result.w := Result.w + P.w;

     if Abs( Result.w ) < DOUBLE_EPS3 then
     begin
          for P in Ps_ do Result.v := Result.v + P.v;
     end
     else
     begin
          for P in Ps_ do Result.v := Result.v + P.w * P.v;

          Result.v := Result.v / Result.w;
     end;

     Result.v := Result.v.Unitor;
end;

end. //######################################################################### ■