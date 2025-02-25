﻿unit LUX.ALFs.Term3.Diff;

interface //#################################################################### ■

uses LUX,
     LUX.D1.Diff,
     LUX.ALFs.Diff;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 T Y P E 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TdALFsTerm3

     TdALFsTerm3 = class( TdCacheALFs )
     private
     protected
       _S     :TdDouble;
       _MaxM  :Integer;
       _MaxNs :TArray<Integer>;
       ///// A C C E S S O R
       procedure SetDegN( const DegN_:Integer ); override;
       procedure SetX( const X_:TdDouble ); override;
       function GetPs( const N_,M_:Integer ) :TdDouble; override;
       ///// M E T H O D
       function P01( const M_:Integer; const P0_:TdDouble ) :TdDouble;
       function PN01( const M_:Integer; const PN0_:TdDouble ) :TdDouble;
       function PN10( const M_:Integer; const PN1_:TdDouble ) :TdDouble;
       function PM012( const N_,M_:Integer; const PM0_,PM1_:TdDouble ) :TdDouble;
       function PM201( const N_,M_:Integer; const PM2_,PM0_:TdDouble ) :TdDouble;
       function PM120( const N_,M_:Integer; const PM1_,PM2_:TdDouble ) :TdDouble;
       function PN012( const N_,M_:Integer; const PN0_,PN1_:TdDouble ) :TdDouble;
       function PN201( const N_,M_:Integer; const PN2_,PN0_:TdDouble ) :TdDouble;
       function PN120( const N_,M_:Integer; const PN1_,PN2_:TdDouble ) :TdDouble;
     public
     end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

implementation //############################################################### ■

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TdALFsTerm3

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//////////////////////////////////////////////////////////////// A C C E S S O R

procedure TdALFsTerm3.SetDegN( const DegN_:Integer );
var
   M :Integer;
begin
     inherited;

     if DegN < _MaxM then _MaxM := DegN;

     SetLength( _MaxNs, DegN+1 );
     for M := 0 to _MaxM do
     begin
          if DegN < _MaxNs[ M ] then _MaxNs[ M ] := DegN;
     end;
     for M := _MaxM+1 to DegN do _MaxNs[ M ] := M;
end;

//------------------------------------------------------------------------------

procedure TdALFsTerm3.SetX( const X_:TdDouble );
var
   M :Integer;
begin
     inherited;

     _MaxM := 0;

     for M := 0 to _DegN do _MaxNs[ M ] := M;

     _S := Roo2( 1 - Pow2( X ) );
end;

//------------------------------------------------------------------------------

function TdALFsTerm3.GetPs( const N_,M_:Integer ) :TdDouble;
var
   M, N :Integer;
begin
     if _MaxM < M_ then
     begin
          ///// N = M
          for M := _MaxM+1 to M_ do _Ps[ M, M ] := P01( M, _Ps[ M-1, M-1 ] );

          _MaxM := M_;
     end;

     if _MaxNs[ M_ ] < N_ then
     begin
          ///// N = M+1
          if _MaxNs[ M_ ] = M_ then
          begin
               _Ps[ M_+1, M_ ] := PN01( M_, _Ps[ M_, M_ ] );

               _MaxNs[ M_ ] := M_+1;
          end;

          ///// M+2 <= N
          for N := _MaxNs[ M_ ]+1 to N_ do _Ps[ N, M_ ] := PN012( N, M_, _Ps[ N-2, M_ ], _Ps[ N-1, M_ ] );

          _MaxNs[ M_ ] := N_;
     end;

     Result := _Ps[ N_, M_ ];
end;

//////////////////////////////////////////////////////////////////// M E T H O D

function TdALFsTerm3.P01( const M_:Integer; const P0_:TdDouble ) :TdDouble;
begin
     Result := ( 1 - 2 * M_ ) * _S * P0_;
end;

//------------------------------------------------------------------------------

function TdALFsTerm3.PN01( const M_:Integer; const PN0_:TdDouble ) :TdDouble;
begin
     Result := ( 2 * M_ + 1 ) * X * PN0_;
end;

function TdALFsTerm3.PN10( const M_:Integer; const PN1_:TdDouble ) :TdDouble;
begin
     Result := PN1_ / ( ( 2 * M_ + 1 ) * X );
end;

//------------------------------------------------------------------------------

function TdALFsTerm3.PM012( const N_,M_:Integer; const PM0_,PM1_:TdDouble ) :TdDouble;
begin
     Result := ( ( 2 * M_ - 1 ) * X / M_ ) * PM1_ - ( ( N_ + M_ - 1 ) / M_ ) * PM0_;
end;

function TdALFsTerm3.PM201( const N_,M_:Integer; const PM2_,PM0_:TdDouble ) :TdDouble;
begin
     Result := ( ( M_ + 1 ) * PM2_ + ( N_ + M_ ) * PM0_ ) / ( ( 2 * M_ + 1 ) * X );
end;

function TdALFsTerm3.PM120( const N_,M_:Integer; const PM1_,PM2_:TdDouble ) :TdDouble;
begin
     Result := ( ( 2 * M_ + 3 ) * X * PM1_ - ( M_ + 2 ) * PM2_ ) / ( N_ + M_ + 1 );
end;

//------------------------------------------------------------------------------

function TdALFsTerm3.PN012( const N_,M_:Integer; const PN0_,PN1_:TdDouble ) :TdDouble;
begin
     Result := ( ( 2 * N_ - 1 ) * X * PN1_ - ( N_ + M_ - 1 ) * PN0_ ) / ( N_ - M_ );
end;

function TdALFsTerm3.PN201( const N_,M_:Integer; const PN2_,PN0_:TdDouble ) :TdDouble;
begin
     Result := ( ( N_ + M_ ) * PN0_ + ( N_ - M_ + 1 ) * PN2_ ) / ( ( 2 * N_ + 1 ) * X );
end;

function TdALFsTerm3.PN120( const N_,M_:Integer; const PN1_,PN2_:TdDouble ) :TdDouble;
begin
     Result := ( ( 2 * N_ + 3 ) * X * PN1_ - ( N_ - M_ + 2 ) * PN2_ ) / ( N_ + M_ + 1 );
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

end. //######################################################################### ■