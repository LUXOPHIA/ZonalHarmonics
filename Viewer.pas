unit Viewer;

interface //#################################################################### ■

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  LUX, FMX.Viewport3D;

type //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$【 T Y P E 】

     TViewerFrame = class( TFrame )
    Viewport3D1: TViewport3D;
     private
     protected
     public
       constructor Create( Owner_:TComponent ); override;
       destructor Destroy; override;
     end;

implementation //############################################################### ■

{$R *.fmx}

//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TViewerFrame

//&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& public

constructor TViewerFrame.Create( Owner_:TComponent );
begin
     inherited;

end;

destructor TViewerFrame.Destroy;
begin

     inherited;
end;

end. //######################################################################### ■
