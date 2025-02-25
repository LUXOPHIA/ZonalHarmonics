﻿unit LUX.SH.FMX.Graphics.D3;

interface //#################################################################### ■

uses System.SysUtils, System.RTLConsts, System.Classes,
     System.Types, System.UITypes, System.Math.Vectors,
     FMX.Types3D, FMX.Controls3D, FMX.MaterialSources,
     LUX,
     LUX.D1.Diff,
     LUX.D2, LUX.D2.Diff,
     LUX.D3, LUX.D3.Diff,
     LUX.D4x4, LUX.D4x4.Diff,
     LUX.FMX.Graphics.D3, LUX.FMX.Graphics.D3.Shaper,
     LUX.SH.Diff;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 T Y P E 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

     //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

     //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TSPHarmonics3D

     TSPHarmonics3D = class( TF3DShaper )
     private
       ///// M E T H O D
       function XYtoI( const X_,Y_:Integer ) :Integer; inline;
     protected
       _Polygons :TMeshData;
       _Material :TLightMaterialSource;
       _DivX     :Integer;
       _DivY     :Integer;
       _SPHarm   :TdSPHarmonics;
       _N        :Integer;
       _M        :Integer;
       _Radius   :Single;
       ///// A C C E S S O R
       procedure SetDivX( const DivX_:Integer );
       procedure SetDivY( const DivY_:Integer );
       function GetSPHarm :TdSPHarmonics;
       procedure SetSPHarm( const SPHarm_:TdSPHarmonics );
       function GetN :Integer;
       procedure SetN( const N_:Integer );
       function GetM :Integer;
       procedure SetM( const M_:Integer );
       function GetRadius :Single;
       procedure SetRadius( const Radius_:Single );
       ///// M E T H O D
       procedure Render; override;
       function AngToPos( const T_:TdDouble2D ) :TdDouble3D;
       procedure MakeGeometry; override;
       procedure MakeTopology; override;
     public
       constructor Create( Owner_:TComponent ); override;
       destructor Destroy; override;
       ///// P R O P E R T Y
       property Material :TLightMaterialSource read   _Material write   _Material;
       property DivX     :Integer              read   _DivX     write SetDivX    ;
       property DivY     :Integer              read   _DivY     write SetDivY    ;
       property SPHarm   :TdSPHarmonics        read GetSPHarm   write SetSPHarm  ;
       property N        :Integer              read GetN        write SetN       ;
       property M        :Integer              read GetM        write SetM       ;
       property Radius   :Single               read GetRadius   write SetRadius  ;
     end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

implementation //############################################################### ■

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R E C O R D 】

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 C L A S S 】

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TSPHarmonics3D

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& private

function TSPHarmonics3D.XYtoI( const X_,Y_:Integer ) :Integer;
begin
     Result := ( _DivX + 1 ) * Y_ + X_;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& protected

//////////////////////////////////////////////////////////////// A C C E S S O R

procedure TSPHarmonics3D.SetDivX( const DivX_:Integer );
begin
     _DivX := DivX_;

     upGeometry := True;
     upTopology := True;

     Repaint;
end;

procedure TSPHarmonics3D.SetDivY( const DivY_:Integer );
begin
     _DivY := DivY_;

     upGeometry := True;
     upTopology := True;

     Repaint;
end;

//------------------------------------------------------------------------------

function TSPHarmonics3D.GetSPHarm :TdSPHarmonics;
begin
     Result := _SPHarm;
end;

procedure TSPHarmonics3D.SetSPHarm( const SPHarm_:TdSPHarmonics );
begin
     _SPHarm := SPHarm_;

     upGeometry := True;

     Repaint;
end;

//------------------------------------------------------------------------------

function TSPHarmonics3D.GetN :Integer;
begin
     Result := _N;
end;

procedure TSPHarmonics3D.SetN( const N_:Integer );
begin
     _N := N_;

     upGeometry := True;

     Repaint;
end;

function TSPHarmonics3D.GetM :Integer;
begin
     Result := _M;
end;

procedure TSPHarmonics3D.SetM( const M_:Integer );
begin
     _M := M_;

     upGeometry := True;

     Repaint;
end;

//------------------------------------------------------------------------------

function TSPHarmonics3D.GetRadius :Single;
begin
     Result := _Radius;
end;

procedure TSPHarmonics3D.SetRadius( const Radius_:Single );
begin
     _Radius := Radius_;

     upGeometry := True;

     Repaint;
end;

//////////////////////////////////////////////////////////////////// M E T H O D

procedure TSPHarmonics3D.Render;
begin
     inherited;

     _Polygons.Render( Context, TMaterialSource.ValidMaterial( _Material ), AbsoluteOpacity );
end;

function TSPHarmonics3D.AngToPos( const T_:TdDouble2D ) :TdDouble3D;
var
   A :TdDouble2D;
   L, R :TdDouble;
begin
     A.X := Pi2 * T_.X;
     A.Y := Pi  * T_.Y;

     SPHarm.AngleY := A.Y;
     SPHarm.AngleX := A.X;

     L := Abso( SPHarm.RSHs[ N, M ] * Sqrt(Pi4) ) * Radius;

     Result.Y := L * Cos( A.Y );
            R := L * Sin( A.Y );
     Result.X := R * Cos( A.X );
     Result.Z := R * Sin( A.X );
end;

procedure TSPHarmonics3D.MakeGeometry;
const
     DOUBLE_EPS8 = DOUBLE_EPS * 1E8;
var
   X, Y, I :Integer;
   T :TDouble2D;
   M :TDoubleM4;
begin
     SPHarm.DegN := N;

     with _Polygons.VertexBuffer do
     begin
          if not Assigned( SPHarm ) then
          begin
               Length := 0;  Exit;
          end;

          Length := ( _DivX + 1 ) * ( _DivY + 1 );

          for Y := 0 to _DivY do
          begin
               T.Y := ( 1-DOUBLE_EPS8 - DOUBLE_EPS8 ) * Y / _DivY + DOUBLE_EPS8;

               for X := 0 to _DivX do
               begin
                    T.X := X / _DivX;

                    M := TexToMatrix( T, AngToPos );

                    I := XYtoI( X, Y );

                    Vertices [ I ] := M.AxisP;
                    Normals  [ I ] := M.AxisZ;
                    TexCoord0[ I ] := TPointF( T );
               end;
          end;
     end;
end;

procedure TSPHarmonics3D.MakeTopology;
var
   X, Y, I :Integer;
begin
     with _Polygons.IndexBuffer do
     begin
          if not Assigned( SPHarm ) then
          begin
               Length := 0;  Exit;
          end;

          Length := 3{Poin} * 2{Face} * _DivX * _DivY;

          I := 0;
          for Y := 0 to _DivY-1 do
          begin
               for X := 0 to _DivX-1 do
               begin
                    //     X0     X1
                    //  Y0 +------+
                    //     |＼    |
                    //     |  ＼  |
                    //     |    ＼|
                    //  Y1 +------+

                    Indices[ I ] := XYtoI( X  , Y   );  Inc( I );
                    Indices[ I ] := XYtoI( X  , Y+1 );  Inc( I );
                    Indices[ I ] := XYtoI( X+1, Y+1 );  Inc( I );

                    Indices[ I ] := XYtoI( X+1, Y+1 );  Inc( I );
                    Indices[ I ] := XYtoI( X+1, Y   );  Inc( I );
                    Indices[ I ] := XYtoI( X  , Y   );  Inc( I );
               end;
          end;
     end;
end;

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TSPHarmonics3D.Create( Owner_:TComponent );
begin
     inherited;

     _Polygons := TMeshData.Create;

     _Material := TLightMaterialSource.Create( Self );
     _Material.Specular := TAlphaColors.Null;

     DivX   := 360;
     DivY   := 180;
     N      := 0;
     M      := 0;
     Radius := 3;
end;

destructor TSPHarmonics3D.Destroy;
begin
     _Polygons.Free;

     inherited;
end;

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 R O U T I N E 】

end. //######################################################################### ■