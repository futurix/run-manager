program runm;



{$R 'resources.res' 'resources.rc'}

uses
  Forms,
  main in 'main.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Run Manager';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
