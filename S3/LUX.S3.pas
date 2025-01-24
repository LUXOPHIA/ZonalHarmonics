﻿unit LUX.S3;

interface //#################################################################### ■

uses LUX.Quaternion,
     LIB;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 T Y P E 】

     TSingle3S = TSingleQ;
     TDouble3S = TDoubleQ;

     TSingleWector3S = TWector<TSingle3S>;
     TDoubleWector3S = TWector<TDouble3S>;

     TSingleBary3S = TBarycenter<TSingle3S>;
     TDoubleBary3S = TBarycenter<TDouble3S>;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TSingle3Sw

     TSingle3Sw = record
     private
     public
       v :TSingle3S;
       w :Single;
       /////
       constructor Create( const V_:TSingle3S; const W_:Single );
       ///// O P E R A T O R
       class operator Positive( const P_:TSingle3Sw ) :TSingle3Sw;
       class operator Negative( const P_:TSingle3Sw ) :TSingle3Sw;
       class operator Add( const A_,B_:TSingle3Sw ) :TSingle3Sw;
       class operator Subtract( const A_,B_:TSingle3Sw ) :TSingle3Sw;
       class operator Multiply( const A_:Single; const B_:TSingle3Sw ) :TSingle3Sw;
       class operator Multiply( const A_:TSingle3Sw; const B_:Single ) :TSingle3Sw;
       class operator Divide( const A_:TSingle3Sw; const B_:Single ) :TSingle3Sw;
       ///// C A S T
       class operator Implicit( const S_:TSingleWector3S ) :TSingle3Sw;
       class operator Explicit( const S_:TSingle3Sw ) :TSingleWector3S;
       class operator Implicit( const V_:TSingle3S ) :TSingle3Sw;
       class operator Explicit( const S_:TSingle3Sw ) :TSingle3S;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TDouble3Sw

     TDouble3Sw = record
     private
     public
       v :TDouble3S;
       w :Double;
       /////
       constructor Create( const V_:TDouble3S; const W_:Double );
       ///// O P E R A T O R
       class operator Positive( const P_:TDouble3Sw ) :TDouble3Sw;
       class operator Negative( const P_:TDouble3Sw ) :TDouble3Sw;
       class operator Add( const A_,B_:TDouble3Sw ) :TDouble3Sw;
       class operator Subtract( const A_,B_:TDouble3Sw ) :TDouble3Sw;
       class operator Multiply( const A_:Double; const B_:TDouble3Sw ) :TDouble3Sw;
       class operator Multiply( const A_:TDouble3Sw; const B_:Double ) :TDouble3Sw;
       class operator Divide( const A_:TDouble3Sw; const B_:Double ) :TDouble3Sw;
       ///// C A S T
       class operator Implicit( const S_:TDoubleWector3S ) :TDouble3Sw;
       class operator Explicit( const S_:TDouble3Sw ) :TDoubleWector3S;
       class operator Implicit( const V_:TDouble3S ) :TDouble3Sw;
       class operator Explicit( const S_:TDouble3Sw ) :TDouble3S;
     end;

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TBaryGLerp3S

     TBaryGLerp3S = class( TDoubleBary3S )
     private
     protected
     public
       ///// M E T H O D
       function Lerp( const Ps_:TArray<TDoubleWector3S> ) :TDouble3S; override;
     end;

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TBaryPolySlerp3S

     TBaryPolySlerp3S = class( TDoubleBary3S )
     private
     protected
     public
       ///// M E T H O D
       function Lerp( const Ps_:TArray<TDoubleWector3S> ) :TDouble3S; override;
     end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Glerp :Gnomonic Linear Interpolation

function Glerp( const P1_,P2_:TSingle3S ) :TSingle3S; overload;
function Glerp( const P1_,P2_:TDouble3S ) :TDouble3S; overload;

function Glerp( const P1_,P2_:TSingle3S; const T_:Single ) :TSingle3S; overload;
function Glerp( const P1_,P2_:TDouble3S; const T_:Double ) :TDouble3S; overload;

function Glerp( const P1_,P2_:TSingle3S; const W1_,W2_:Single ) :TSingle3S; overload;
function Glerp( const P1_,P2_:TDouble3S; const W1_,W2_:Double ) :TDouble3S; overload;

function Glerp( const P1_,P2_:TSingle3Sw ) :TSingle3Sw; overload;
function Glerp( const P1_,P2_:TDouble3Sw ) :TDouble3Sw; overload;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Slerp :Sherical Linear Interpolation

function Slerp( const P1_,P2_:TSingle3S; const T_:Single ) :TSingle3S; overload;
function Slerp( const P1_,P2_:TDouble3S; const T_:Double ) :TDouble3S; overload;

function Slerp( const P1_,P2_:TSingle3S; const W1_,W2_:Single ) :TSingle3S; overload;
function Slerp( const P1_,P2_:TDouble3S; const W1_,W2_:Double ) :TDouble3S; overload;

function Slerp( const P1_,P2_:TSingle3Sw ) :TSingle3Sw; overload;
function Slerp( const P1_,P2_:TDouble3Sw ) :TDouble3Sw; overload;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PowSlerp

function PowSlerp( const Q0_,Q1_:TSingle3S; const T_:Single ) :TSingle3S; overload;
function PowSlerp( const Q0_,Q1_:TDouble3S; const T_:Double ) :TDouble3S; overload;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Sum1D

function Sum1D( Ps_:TArray<TSingle3Sw> ) :TSingle3Sw; overload;
function Sum1D( Ps_:TArray<TDouble3Sw> ) :TDouble3Sw; overload;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PowSum1D

function PowSum1D( const Qs_:TArray<TSingle3Sw> ) :TSingle3Sw; overload;
function PowSum1D( const Qs_:TArray<TDouble3Sw> ) :TDouble3Sw; overload;

implementation //############################################################### ■

uses System.Math,
     LUX,
     LIB.D4;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TSingle3Sw

constructor TSingle3Sw.Create( const V_:TSingle3S; const W_:Single );
begin
     v := V_;
     w := W_;
end;

//////////////////////////////////////////////////////////////// O P E R A T O R

class operator TSingle3Sw.Positive( const P_:TSingle3Sw ) :TSingle3Sw;
begin
     Result.v :=  P_.v;
     Result.w := +P_.w;
end;

class operator TSingle3Sw.Negative( const P_:TSingle3Sw ) :TSingle3Sw;
begin
     Result.v :=  P_.v;
     Result.w := -P_.w;
end;

class operator TSingle3Sw.Add( const A_,B_:TSingle3Sw ) :TSingle3Sw;
begin
     Result := Slerp( A_, +B_ );
end;

class operator TSingle3Sw.Subtract( const A_,B_:TSingle3Sw ) :TSingle3Sw;
begin
     Result := Slerp( A_, -B_ );
end;

class operator TSingle3Sw.Multiply( const A_:Single; const B_:TSingle3Sw ) :TSingle3Sw;
begin
     Result.v :=      B_.v;
     Result.w := A_ * B_.w;
end;

class operator TSingle3Sw.Multiply( const A_:TSingle3Sw; const B_:Single ) :TSingle3Sw;
begin
     Result.v := A_.v     ;
     Result.w := A_.w * B_;
end;

class operator TSingle3Sw.Divide( const A_:TSingle3Sw; const B_:Single ) :TSingle3Sw;
begin
     Result.v := A_.v     ;
     Result.w := A_.w / B_;
end;

//////////////////////////////////////////////////////////////////////// C A S T

class operator TSingle3Sw.Implicit( const S_:TSingleWector3S ) :TSingle3Sw;
begin
     Result.v := S_.v;
     Result.w := S_.w;
end;

class operator TSingle3Sw.Explicit( const S_:TSingle3Sw ) :TSingleWector3S;
begin
     Result.v := S_.v;
     Result.w := S_.w;
end;

//------------------------------------------------------------------------------

class operator TSingle3Sw.Implicit( const V_:TSingle3S ) :TSingle3Sw;
begin
     Result.v := V_;
     Result.w := 1 ;
end;

class operator TSingle3Sw.Explicit( const S_:TSingle3Sw ) :TSingle3S;
begin
     Result := S_.v;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TDouble3Sw

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TDouble3Sw.Create( const V_:TDouble3S; const W_:Double );
begin
     v := V_;
     w := W_;
end;

//////////////////////////////////////////////////////////////// O P E R A T O R

class operator TDouble3Sw.Positive( const P_:TDouble3Sw ) :TDouble3Sw;
begin
     Result.v :=  P_.v;
     Result.w := +P_.w;
end;

class operator TDouble3Sw.Negative( const P_:TDouble3Sw ) :TDouble3Sw;
begin
     Result.v :=  P_.v;
     Result.w := -P_.w;
end;

class operator TDouble3Sw.Add( const A_,B_:TDouble3Sw ) :TDouble3Sw;
begin
     Result := Slerp( A_, +B_ );
end;

class operator TDouble3Sw.Subtract( const A_,B_:TDouble3Sw ) :TDouble3Sw;
begin
     Result := Slerp( A_, -B_ );
end;

class operator TDouble3Sw.Multiply( const A_:Double; const B_:TDouble3Sw ) :TDouble3Sw;
begin
     Result.v :=      B_.v;
     Result.w := A_ * B_.w;
end;

class operator TDouble3Sw.Multiply( const A_:TDouble3Sw; const B_:Double ) :TDouble3Sw;
begin
     Result.v := A_.v     ;
     Result.w := A_.w * B_;
end;

class operator TDouble3Sw.Divide( const A_:TDouble3Sw; const B_:Double ) :TDouble3Sw;
begin
     Result.v := A_.v     ;
     Result.w := A_.w / B_;
end;

//////////////////////////////////////////////////////////////////////// C A S T

class operator TDouble3Sw.Implicit( const S_:TDoubleWector3S ) :TDouble3Sw;
begin
     Result.v := S_.v;
     Result.w := S_.w;
end;

class operator TDouble3Sw.Explicit( const S_:TDouble3Sw ) :TDoubleWector3S;
begin
     Result.v := S_.v;
     Result.w := S_.w;
end;

//------------------------------------------------------------------------------

class operator TDouble3Sw.Implicit( const V_:TDouble3S ) :TDouble3Sw;
begin
     Result.v := V_;
     Result.w := 1 ;
end;

class operator TDouble3Sw.Explicit( const S_:TDouble3Sw ) :TDouble3S;
begin
     Result := S_.v;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TBaryGLerp3S

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//////////////////////////////////////////////////////////////////// M E T H O D

function TBaryGLerp3S.Lerp( const Ps_:TArray<TDoubleWector3S> ) :TDouble3S;
var
   P :TDoubleWector3S;
begin
     Result := 0;

     for P in Ps_ do Result := Result + P.w * P.v;

     Result := Result.Unitor;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TBaryPolySlerp3S

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//////////////////////////////////////////////////////////////////// M E T H O D

function TBaryPolySlerp3S.Lerp( const Ps_:TArray<TDoubleWector3S> ) :TDouble3S;
var
   PsN, I :Integer;
   Ps :TArray<TDouble3Sw>;
begin
     PsN := Length( Ps_ );

     SetLength( Ps, PsN );

     for I := 0 to PsN-1 do Ps[ I ] := Ps_[ I ];

     Result := TDouble3S( Sum1D( Ps ) );
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SlerpG

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

function Glerp( const P1_,P2_:TSingle3Sw ) :TSingle3Sw;
begin
     Result.v := Lerp( P1_.v, P2_.v, P1_.w, P2_.w ).Unitor;
     Result.w := P1_.w + P2_.w;
end;

function Glerp( const P1_,P2_:TDouble3Sw ) :TDouble3Sw;
begin
     Result.v := Lerp( P1_.v, P2_.v, P1_.w, P2_.w ).Unitor;
     Result.w := P1_.w + P2_.w;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Slerp

function Slerp( const P1_,P2_:TSingle3S; const T_:Single ) :TSingle3S;
var
   C, A, S :Single;
begin
     C := DotProduct( P1_, P2_ );

     if 1-SINGLE_EPS3 < C then Result := GLerp( P1_, P2_, T_ )
     else
     begin
          A := ArcCos( C );
          S := Sqrt( 1 - Sqr( C ) );  //= Sin( A )

          Result := ( Sin( ( 1 - T_ ) * A ) * P1_
                    + Sin( (     T_ ) * A ) * P2_ ) / S;
     end;
end;

function Slerp( const P1_,P2_:TDouble3S; const T_:Double ) :TDouble3S;
var
   C, A, S :Double;
begin
     C := DotProduct( P1_, P2_ );

     if 1-DOUBLE_EPS3 < C then Result := GLerp( P1_, P2_, T_ )
     else
     begin
          A := ArcCos( C );
          S := Sqrt( 1 - Sqr( C ) );  //= Sin( A )

          Result := ( Sin( ( 1 - T_ ) * A ) * P1_
                    + Sin( (     T_ ) * A ) * P2_ ) / S;
     end;
end;

//------------------------------------------------------------------------------

function Slerp( const P1_,P2_:TSingle3S; const W1_,W2_:Single ) :TSingle3S;
var
   W, C, A, S :Single;
begin
     W := W1_ + W2_;

     if Abs( W ) < SINGLE_EPS3 then Result := GLerp( P1_, P2_ )
     else
     begin
          C := DotProduct( P1_, P2_ );

          if 1-SINGLE_EPS3 < C then Result := GLerp( P1_, P2_, W1_, W2_ )
          else
          begin
               A := ArcCos( C ) / W;
               S := Sqrt( 1 - Sqr( C ) );  //= Sin( A )

               Result := ( Sin( A * W1_ ) * P1_
                         + Sin( A * W2_ ) * P2_ ) / S;
          end;
     end;
end;

function Slerp( const P1_,P2_:TDouble3S; const W1_,W2_:Double ) :TDouble3S;
var
   W, C, A, S :Double;
begin
     W := W1_ + W2_;

     if Abs( W ) < DOUBLE_EPS3 then Result := GLerp( P1_, P2_ )
     else
     begin
          C := DotProduct( P1_, P2_ );

          if 1-DOUBLE_EPS3 < C then Result := GLerp( P1_, P2_, W1_, W2_ )
          else
          begin
               A := ArcCos( C ) / W;
               S := Sqrt( 1 - Sqr( C ) );  //= Sin( A )

               Result := ( Sin( A * W1_ ) * P1_
                         + Sin( A * W2_ ) * P2_ ) / S;
          end;
     end;
end;

//------------------------------------------------------------------------------

function Slerp( const P1_,P2_:TSingle3Sw ) :TSingle3Sw;
var
   C, A, S :Single;
begin
     Result.w := P1_.w + P2_.w;

     if Abs( Result.w ) < SINGLE_EPS3 then Result.v := GLerp( P1_.v, P2_.v )
     else
     begin
          C := DotProduct( P1_.v, P2_.v );

          if 1-SINGLE_EPS3 < C then Result.v := GLerp( P1_.v, P2_.v, P1_.w, P2_.w )
          else
          begin
               A := ArcCos( C ) / Result.w;
               S := Sqrt( 1 - Sqr( C ) );  //= Sin( A )

               Result.v := ( Sin( A * P1_.w ) * P1_.v
                           + Sin( A * P2_.w ) * P2_.v ) / S;
          end;
     end;
end;

function Slerp( const P1_,P2_:TDouble3Sw ) :TDouble3Sw;
var
   C, A, S :Double;
begin
     Result.w := P1_.w + P2_.w;

     if Abs( Result.w ) < DOUBLE_EPS3 then Result.v := GLerp( P1_.v, P2_.v )
     else
     begin
          C := DotProduct( P1_.v, P2_.v );

          if 1-DOUBLE_EPS3 < C then Result.v := GLerp( P1_.v, P2_.v, P1_.w, P2_.w )
          else
          begin
               A := ArcCos( C ) / Result.w;
               S := Sqrt( 1 - Sqr( C ) );  //= Sin( A )

               Result.v := ( Sin( A * P1_.w ) * P1_.v
                           + Sin( A * P2_.w ) * P2_.v ) / S;
          end;
     end;
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PowSlerp

function PowSlerp( const Q0_,Q1_:TSingle3S; const T_:Single ) :TSingle3S;
begin
     Result := Q0_ * Pow( Q0_.Inv * Q1_, T_ );
end;

function PowSlerp( const Q0_,Q1_:TDouble3S; const T_:Double ) :TDouble3S;
begin
     Result := Q0_ * Pow( Q0_.Inv * Q1_, T_ );
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Sum1D

function Sum1D( Ps_:TArray<TSingle3Sw> ) :TSingle3Sw;
var
   N, I, L :Integer;
begin
     N := High( Ps_ );

     for I := 0 to N do Ps_[ I ] := Ps_[ I ] / Binomial( N, I );

     for L := N-1 downto 0 do
     for I := 0 to L do Ps_[ I ] := Ps_[ I ] + Ps_[ I+1 ];

     Result := Ps_[ 0 ];
end;

function Sum1D( Ps_:TArray<TDouble3Sw> ) :TDouble3Sw;
var
   N, I, L :Integer;
begin
     N := High( Ps_ );

     for I := 0 to N do Ps_[ I ] := Ps_[ I ] / Binomial( N, I );

     for L := N-1 downto 0 do
     for I := 0 to L do Ps_[ I ] := Ps_[ I ] + Ps_[ I+1 ];

     Result := Ps_[ 0 ];
end;

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PowSum1D

function PowSum1D( const Qs_:TArray<TSingle3Sw> ) :TSingle3Sw;
var
   Q :TSingle3Sw;
begin
     Result.v := 0;
     Result.w := 0;
     for Q in Qs_ do
     begin
          Result.v := Result.v + Q.w * Ln( Q.v );
          Result.w := Result.w + Q.w;
     end;
     Result.v := Exp( Result.v / Result.w );
end;

function PowSum1D( const Qs_:TArray<TDouble3Sw> ) :TDouble3Sw;
var
   Q :TDouble3Sw;
begin
     Result.v := 0;
     Result.w := 0;
     for Q in Qs_ do
     begin
          Result.v := Result.v + Q.w * Ln( Q.v );
          Result.w := Result.w + Q.w;
     end;
     Result.v := Exp( Result.v / Result.w );
end;

end. //######################################################################### ■