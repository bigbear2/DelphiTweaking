unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, Registry, Vcl.ComCtrls, JvExComCtrls, JvComCtrls, shellapi, Vcl.Menus, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.ValEdit, System.ImageList, Vcl.ImgList, Vcl.ToolWin, FileCtrl;

type
  TfrmMain = class(TForm)
    pgcMain: TPageControl;
    tsPaths: TTabSheet;
    mmMain: TMainMenu;
    mniFile: TMenuItem;
    mniBackup: TMenuItem;
    mmoLog: TMemo;
    pnlTop: TPanel;
    cbbVersion: TComboBox;
    Splitter1: TSplitter;
    lstPaths: TValueListEditor;
    cbbTargets: TComboBox;
    btnView: TButton;
    pnlBottom: TPanel;
    tsExperts: TTabSheet;
    lstExperts: TValueListEditor;
    tlbExperts: TToolBar;
    il16: TImageList;
    btnAddExpert: TToolButton;
    btnEditExpert: TToolButton;
    btnDelExpert: TToolButton;
    tlbPath: TToolBar;
    btnAddPath: TToolButton;
    btnEditPath: TToolButton;
    btnDelPath: TToolButton;
    mmoLibrary: TMemo;
    btnScanSubDir: TButton;
    edtLibrary: TEdit;
    btnAdd: TButton;
    il16Bis: TImageList;
    btnLibraryDir: TButton;
    ToolButton1: TToolButton;
    btnSaveLibrary: TToolButton;
    btnImportLibrary: TToolButton;
    ToolButton2: TToolButton;
    btnExportLibrary: TToolButton;
    tsPackages: TTabSheet;
    lstPackages: TValueListEditor;
    tlbPackages: TToolBar;
    btnAddPackages: TToolButton;
    btnEdit: TToolButton;
    btnDelPackages: TToolButton;
    tsInstall: TTabSheet;
    edtSearchPackages: TEdit;
    ToolButton3: TToolButton;
    btnSavePackages: TToolButton;
    btn1: TToolButton;
    btnImportPackages: TToolButton;
    btnExportPackages: TToolButton;
    edtSearchLibrary: TEdit;
    edtSearchExperts: TEdit;
    btnSaveExperts: TToolButton;
    btnImportExperts: TToolButton;
    btnExportExperts: TToolButton;
    edtBuildPath: TEdit;
    tsInfo: TTabSheet;
    lstInfo: TValueListEditor;
    edtProject: TEdit;
    btnBuild: TButton;
    mmoBuild: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure mniBackupClick(Sender: TObject);
    procedure btnViewClick(Sender: TObject);
    procedure lstPathsDblClick(Sender: TObject);
    procedure cbbVersionSelect(Sender: TObject);
    procedure cbbTargetsSelect(Sender: TObject);
    procedure btnScanSubDirClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnLibraryDirClick(Sender: TObject);
    procedure btnSaveLibraryClick(Sender: TObject);
    procedure edtSearchPackagesKeyPress(Sender: TObject; var Key: Char);
    procedure FormDestroy(Sender: TObject);
    procedure btnExportLibraryClick(Sender: TObject);
    procedure btnImportLibraryClick(Sender: TObject);
    procedure btnBuildClick(Sender: TObject);
  private
    { Private declarations }
    FVersion: string;
    FVersionName: string;
    FTarget: string;
    FTargetName: string;
    FInfo, FLibrary, FExperts, FPackages: TStringList;
    procedure ReadKeys(KeyPath: string; ValueListEditor: TValueListEditor; BKList: TStringList; const Inverted: Boolean = False);
    procedure WriteKeys(KeyPath: string; ValueListEditor: TValueListEditor; const Inverted: Boolean = False);
    procedure SearchListEditor(Words: string; ValueListEditor: TValueListEditor; BKList: TStringList);
  public
    { Public declarations }
    function GetSelectedVersion(): Boolean;
    function GetSelectedTarget(): Boolean;
    procedure ListDelphiVersions();
    procedure ListDelphiTargets();
    procedure ViewInformations();
    procedure BackupDelphiSettings();
    procedure ImportSetting(ValueListEditor: TValueListEditor; FileName: string);
    procedure ExportSetting(ValueListEditor: TValueListEditor; FileName: string);
  end;

var
  frmMain: TfrmMain;
  AppDir: string;
  BackupDir: string;

const
  BDSKEY = 'SOFTWARE\Embarcadero\BDS';
  AVersion: array[0..2] of string = ('19.0', '20.0', '21.0');
  AVersionName: array[0..2] of string = ('Delphi 10.2 Tokyo', 'Delphi 10.3 Rio', 'Delphi 10.4 Sydney');
  ATarget: array[0..9] of string = ('Android32', 'Android64', 'iOSDevice32', 'iOSDevice64', 'iOSSimulator', 'Linux64', 'OSX32',
    'OSX64', 'Win32', 'Win64');
  ATargetName: array[0..9] of string = ('Android x32', 'Android x64', 'iOS x32', 'iOS x64', 'iOSSimulator', 'Linux 64', 'OSX x32',
    'OSX x64', 'Win x32', 'Win x64');

implementation

uses
  GlobalUnit, LibraryForm;

{$R *.dfm}

procedure Log(Value: string);
begin
  frmMain.mmoLog.Lines.Add(Value);
  SendMessage(frmMain.mmoLog.Handle, EM_LINESCROLL, 0, frmMain.mmoLog.Lines.Count);
end;

procedure TfrmMain.ImportSetting(ValueListEditor: TValueListEditor; Filename: string);
begin
  ValueListEditor.Strings.LoadFromFile(Filename);
end;

procedure TfrmMain.ExportSetting(ValueListEditor: TValueListEditor; Filename: string);
begin
  ValueListEditor.Strings.SaveToFile(Filename);
end;

procedure TfrmMain.SearchListEditor(Words: string; ValueListEditor: TValueListEditor; BKList: TStringList);
var
  I: Integer;
  Text: string;
begin

  for I := 1 to ValueListEditor.RowCount - 1 do
    ValueListEditor.RowHeights[I] := 20;

  if Words = '' then
  begin
    //ValueListEditor.Strings.Assign(BKList);
    Exit;
  end;

  //ValueListEditor.Strings.Clear;
  for I := 1 to ValueListEditor.RowCount - 1 do
  begin
    Text := LowerCase(ValueListEditor.Strings[I - 1]);
    if Pos(LowerCase(Words), Text) > 0 then
      ValueListEditor.RowHeights[I] := 20
    else
      ValueListEditor.RowHeights[I] := 0;


      //ValueListEditor.Strings.Add(Text);


  end;

end;

procedure TfrmMain.btnAddClick(Sender: TObject);
var
  Directory, LibraryText: string;
  ListLibraryPath: TStringList;
  Row: Integer;
  I: Integer;
begin
  lstPaths.Strings.SaveToFile(BackupDir + 'Library_' + FVersion + '.txt');

  Directory := IncludeTrailingPathDelimiter(edtLibrary.Text);

  if not DirectoryExists(Directory) then
  begin
    MessageDlg('Directory not exist', mtError, [mbOK], 0);
    Exit;
  end;

  if mmoLibrary.Lines.Count = 0 then
    mmoLibrary.Lines.Add(IncludeTrailingPathDelimiter(Directory));

  lstPaths.FindRow('Search Path', Row);
  if Row > -1 then
  begin
    ListLibraryPath := TStringList.Create;
    LibraryText := lstPaths.Cells[1, Row];
    Explode(';', LibraryText, ListLibraryPath);

    for I := 0 to mmoLibrary.Lines.Count - 1 do
    begin
      Directory := mmoLibrary.Lines[I];
      if ListLibraryPath.IndexOf(Directory) = -1 then
        ListLibraryPath.Add(Directory);
    end;
    LibraryText := Implode(';', ListLibraryPath);
    lstPaths.Cells[1, Row] := LibraryText;
    ListLibraryPath.Free;

    btnSaveLibrary.Click;
  end
  else
    MessageDlg('Search Path not found!', mtError, [mbOK], 0);

end;

procedure TfrmMain.btnBuildClick(Sender: TObject);
var
  I: Integer;
  Bat: TStringList;
begin
  Bat := TStringList.Create;
  with Bat do
  begin
    LoadFromFile(edtBuildPath.Text);

    I := IndexOf('@SET PLATFORM=');
    if I > -1 then
      Bat[I] := '@SET PLATFORM=Win32';

    Add('msbuild ' + AnsiQuotedStr(edtProject.Text, '"'));

    SaveToFile(BackupDir + 'BUILD.bat');
  end;

  mmoBuild.Text := GetDosOutput(BackupDir + 'BUILD.bat', BackupDir);
end;

procedure TfrmMain.btnExportLibraryClick(Sender: TObject);
var
  Filename: string;
begin
  if TButton(Sender).Name = 'btnExportLibrary' then
  begin
    Filename := BackupDir + 'Library_' + FormatDateTime('yyyymmdd_hhnn', Now) + '_V' + FVersion + '.txt';
    ExportSetting(lstPaths, Filename);
  end;

  if TButton(Sender).Name = 'btnExportPackages' then
  begin
    Filename := BackupDir + 'Packages_' + FormatDateTime('yyyymmdd_hhnn', Now) + '_V' + FVersion + '.txt';
    ExportSetting(lstPackages, Filename);
  end;

  if TButton(Sender).Name = 'btnExportExperts' then
  begin
    Filename := BackupDir + 'Experts_' + FormatDateTime('yyyymmdd_hhnn', Now) + '_V' + FVersion + '.txt';
    ExportSetting(lstExperts, Filename);
  end;
end;

procedure TfrmMain.btnImportLibraryClick(Sender: TObject);
begin
  with TOpenDialog.Create(Self) do
  begin
    Filter := 'File Text|*.txt';
    if Execute then
    begin
      if TButton(Sender).Name = 'btnImportLibrary' then
        ImportSetting(lstPaths, Filename);
      if TButton(Sender).Name = 'btnImportPackages' then
        ImportSetting(lstPackages, Filename);
      if TButton(Sender).Name = 'btnImportExperts' then
        ImportSetting(lstExperts, Filename);

    end;
    Free;
  end;

end;

procedure TfrmMain.btnLibraryDirClick(Sender: TObject);
var
  Directory: string;
const
  SELDIRHELP = 1000;
begin
  Directory := IncludeTrailingPathDelimiter(edtLibrary.Text);
  if FileCtrl.SelectDirectory(Directory, [sdAllowCreate, sdPerformCreate, sdPrompt], SELDIRHELP) then
    edtLibrary.Text := IncludeTrailingPathDelimiter(Directory);

end;

procedure TfrmMain.btnSaveLibraryClick(Sender: TObject);
begin
  if FVersion = '' then
  begin
    MessageDlg('Select a Delphi IDE Version!', mtError, [mbOK], 0);
    Exit;
  end;

  if FTarget = '' then
  begin
    MessageDlg('Select a Delphi IDE Target!', mtError, [mbOK], 0);
    Exit;
  end;

  WriteKeys(BDSKEY + '\' + FVersion + '\Library\' + FTarget, lstPaths);

end;

procedure TfrmMain.btnScanSubDirClick(Sender: TObject);
var
  DirFound: TStringList;
  Directory: string;
begin
  Directory := IncludeTrailingPathDelimiter(edtLibrary.Text);
  if not DirectoryExists(Directory) then
  begin
    MessageDlg('Directory not exist', mtError, [mbOK], 0);
    Exit;
  end;

  mmoLibrary.Clear;
  DirFound := GetSubDirectories(Directory);
  mmoLibrary.Lines.Add(Directory);
  mmoLibrary.Lines.AddStrings(DirFound);
  DirFound.Free;
end;

procedure TfrmMain.btnViewClick(Sender: TObject);
begin
  ViewInformations;
end;

procedure TfrmMain.cbbTargetsSelect(Sender: TObject);
begin
  GetSelectedTarget;
  ViewInformations;
end;

procedure TfrmMain.cbbVersionSelect(Sender: TObject);
begin
  GetSelectedVersion;
  ListDelphiTargets;
end;

procedure TfrmMain.edtSearchPackagesKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if TEdit(Sender).Name = 'edtSearchLibrary' then
      SearchListEditor(edtSearchLibrary.Text, lstPaths, FLibrary);
    if TEdit(Sender).Name = 'edtSearchExperts' then
      SearchListEditor(edtSearchExperts.Text, lstExperts, FExperts);
    if TEdit(Sender).Name = 'edtSearchPackages' then
      SearchListEditor(edtSearchPackages.Text, lstPackages, FPackages);
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  AppDir := ExtractFilePath(Application.ExeName);
  BackupDir := AppDir + 'Backup\';
  ForceDirectories(BackupDir);

  FTarget := '';
  FTargetName := '';
  FVersion := '';
  FVersionName := '';

  FInfo := TStringList.Create();
  FLibrary := TStringList.Create();
  FExperts := TStringList.Create();
  FPackages := TStringList.Create();
  ListDelphiVersions;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FInfo.Free;
  FLibrary.Free;
  FPackages.Free;
  FExperts.Free;
end;

function TfrmMain.GetSelectedVersion(): Boolean;
begin
  FVersion := '';
  FVersionName := '';

  Result := False;
  if cbbVersion.ItemIndex = -1 then
    Exit;

  FVersion := GetStringValue(cbbVersion.Items.Objects[cbbVersion.ItemIndex]);
  FVersionName := cbbVersion.Items[cbbVersion.ItemIndex];

  Log(Format('SELECTED VERSION %s NAME %s', [FVersion, FVersionName]));

  Result := True;
end;

function TfrmMain.GetSelectedTarget(): Boolean;
begin
  FTarget := '';
  FTargetName := '';

  Result := False;
  if cbbTargets.ItemIndex = -1 then
    Exit;

  FTarget := GetStringValue(cbbTargets.Items.Objects[cbbTargets.ItemIndex]);
  FTargetName := cbbTargets.Items[cbbTargets.ItemIndex];

  Log(Format('SELECTED TARGET %s NAME %s', [FTarget, FTargetName]));

  Result := True;
end;

procedure TfrmMain.WriteKeys(KeyPath: string; ValueListEditor: TValueListEditor; const Inverted: Boolean = False);
var
  Reg: TRegistry;
  OpenResult: Boolean;
  I: Integer;
  ValuesList: TStringList;
  Row: Integer;
  Name, Text: string;
begin

  Log('HKEY_CURRENT_USER\' + KeyPath);

  Reg := TRegistry.Create(KEY_READ or KEY_WRITE);
  Reg.RootKey := HKEY_CURRENT_USER;

  if not Reg.KeyExists(KeyPath) then
    Exit;

  Reg.Access := KEY_WRITE;

  OpenResult := Reg.OpenKey(KeyPath, True);
  if not OpenResult = True then
    Exit();

  ValuesList := TStringList.Create;
  try
    Reg.GetValueNames(ValuesList);

    for I := 1 to ValueListEditor.RowCount - 1 do
    begin
      Name := ValueListEditor.Cells[0, I];
      Text := ValueListEditor.Cells[1, I];

      if ValuesList.IndexOf(Name) > -1 then
        Reg.DeleteValue(Name);

      Reg.WriteString(Name, Text);

      Log(Name);
    end;

  finally
    ValuesList.Free;
  end;

  Reg.Free;

end;

procedure TfrmMain.ReadKeys(KeyPath: string; ValueListEditor: TValueListEditor; BKList: TStringList; const Inverted: Boolean = False);
var
  Reg: TRegistry;
  OpenResult: Boolean;
  I: Integer;
  ValuesList: TStringList;
  ValueName, Value: string;
begin

  Log('HKEY_CURRENT_USER\' + KeyPath);

  ValueListEditor.Strings.Clear;

  Reg := TRegistry.Create(KEY_READ);
  Reg.RootKey := HKEY_CURRENT_USER;

  if not Reg.KeyExists(KeyPath) then
    Exit;

  Reg.Access := KEY_READ;
  Reg.OpenKeyReadOnly(KeyPath);

  ValuesList := TStringList.Create;
  try
    Reg.GetValueNames(ValuesList);
    for ValueName in ValuesList do
    begin
      try
        Value := Reg.ReadString(ValueName);
        if Inverted then
          ValueListEditor.InsertRow(Value, ValueName, True)
        else
          ValueListEditor.InsertRow(ValueName, Value, True);
      except

      end;
    end;
  finally
    ValuesList.Free;
  end;

  Reg.Free;

  BKList.AddStrings(ValueListEditor.Strings);
end;

procedure TfrmMain.ViewInformations();
var
  Row: Integer;
begin
  if FVersion = '' then
  begin
    MessageDlg('Select a Delphi IDE Version!', mtError, [mbOK], 0);
    Exit;
  end;

  if FTarget = '' then
  begin
    MessageDlg('Select a Delphi IDE Target!', mtError, [mbOK], 0);
    Exit;
  end;

  ReadKeys(BDSKEY + '\' + FVersion, lstInfo, FInfo);
  ReadKeys(BDSKEY + '\' + FVersion + '\Library\' + FTarget, lstPaths, FLibrary);
  ReadKeys(BDSKEY + '\' + FVersion + '\Experts', lstExperts, FExperts);
  ReadKeys(BDSKEY + '\' + FVersion + '\Known Packages', lstPackages, FPackages, True);

  lstInfo.FindRow('RootDir', Row);
  if Row > 0 then
    edtBuildPath.Text := lstInfo.Cells[1, Row] + 'bin\rsvars.bat'
end;

procedure TfrmMain.ListDelphiTargets();
var
  Reg: TRegistry;
  OpenResult: Boolean;
  I: Integer;
  KeyPath: string;
begin
  if FVersion = '' then
    Exit;

  KeyPath := BDSKEY + '\' + FVersion + '\Library';
  cbbTargets.Clear;

  Reg := TRegistry.Create(KEY_READ);
  Reg.RootKey := HKEY_CURRENT_USER;

  if not Reg.KeyExists(KeyPath) then
    Exit;

  Reg.Access := KEY_READ;
  OpenResult := Reg.OpenKeyReadOnly(KeyPath);
  if not OpenResult = True then
    Exit();

  for I := 0 to Length(ATarget) - 1 do
  begin
    if Reg.KeyExists(AVersion[I]) then
      ListBoxAddItem(TCustomListBox(cbbTargets), ATargetName[I], ATarget[I]);
  end;

  Reg.Free;

  cbbTargets.ItemIndex := cbbTargets.Items.IndexOf('Win x32');
  GetSelectedTarget;
end;

procedure TfrmMain.ListDelphiVersions();
var
  Reg: TRegistry;
  OpenResult: Boolean;
  I: Integer;
begin
  cbbVersion.Clear;

      //HKEY_CURRENT_USER\SOFTWARE\Embarcadero\BDS
  Reg := TRegistry.Create(KEY_READ);
  Reg.RootKey := HKEY_CURRENT_USER;

  if not Reg.KeyExists('SOFTWARE\Embarcadero\BDS') then
    Exit;

  Reg.Access := KEY_READ;
  OpenResult := Reg.OpenKey('SOFTWARE\Embarcadero\BDS', False);
  if not OpenResult = True then
    Exit();

  for I := 0 to 2 do
  begin
    if Reg.KeyExists(AVersion[I]) then
      ListBoxAddItem(TCustomListBox(cbbVersion), AVersionName[I], AVersion[I]);
  end;

  Reg.Free;

  if cbbVersion.Items.Count > 0 then
  begin
    cbbVersion.ItemIndex := cbbVersion.Items.IndexOf('Delphi 10.3 Rio');
    ;
    GetSelectedVersion;
    ListDelphiTargets;
  end;
end;

procedure TfrmMain.lstPathsDblClick(Sender: TObject);
var
  Result: TMultiResult;
  LibraryText: string;
begin
  if lstPaths.RowCount = 0 then
    Exit;

  LibraryText := lstPaths.Cells[1, lstPaths.Row];
  Log(LibraryText);
  Log(lstPaths.Cells[0, lstPaths.Row]);

  Result := EditLibrary(lstPaths.Cells[0, lstPaths.Row], lstPaths.Cells[1, lstPaths.Row]);
  Log(Result.Value);

end;

procedure TfrmMain.mniBackupClick(Sender: TObject);
begin
  BackupDelphiSettings;
end;

procedure TfrmMain.BackupDelphiSettings();
const
  REGPATH = 'export HKEY_CURRENT_USER\SOFTWARE\Embarcadero\BDS\%s "%s"';
var
  RegPathStr: string;
  Filename: string;
begin
  if not GetSelectedVersion then
  begin
    MessageDlg('Select a Delphi IDE Version!', mtError, [mbOK], 0);
    Exit;
  end;

  Filename := BackupDir + FVersionName + '.reg';
  if FileExists(Filename) then
    DeleteFile(Filename);
  RegPathStr := Format(REGPATH, [FVersion, Filename]);

  Log(RegPathStr);
  Execute('reg', RegPathStr);
end;

end.

