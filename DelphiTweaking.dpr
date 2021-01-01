program DelphiTweaking;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {frmMain},
  GlobalUnit in 'GlobalUnit.pas',
  LibraryForm in 'LibraryForm.pas' {frmLibrary};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
