unit GlobalUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Imaging.jpeg, Vcl.StdCtrls,
  Vcl.ComCtrls, ShellApi, Vcl.Forms, FileCtrl;

type
  TString = class
    Value: string;
  end;

const
  ACAPO = #13#10;

function GetLocalComputerName: string;

function RoundEx(Value: Double): Double;

function StringToRoundEx(Value: string): Double;

procedure WriteDebug(Value: Integer); overload;

procedure WriteDebug(Value: string); overload;

function GetStringValue(Value: TObject): string;

function SetStringValue(Value: string): TString;

procedure ListBoxAddItem(ListBox: TCustomListBox; Value1, Value2: string);

function LoadImage(Filename: string): TBitmap;

function ProportionalPictureResizing(Filename: string): TBitmap; overload;

function ProportionalPictureResizing(Image: TBitmap): TBitmap; overload;

function ThumbNail(Filename: string): TBitmap; overload;

function ThumbNail(Image: TBitmap): TBitmap; overload;

procedure SaveStringToFile(Filename: string; Value: string; const AppendString: Boolean = False);

function LoadStringToFile(Filename: string): string;

procedure ToolBarButtonFitWidht(ToolBar: TToolBar);

function ResourceToString(Name: string): string;

function IIF(Condition: Boolean; IFTrue: string; IFFalse: string): string;

function GetPlatform: string;

procedure WindowsVirtualKeyboard();

procedure Execute(Filename: string; const Params: string = ''; const DirPath: string = ''; const Visibility: Integer = SW_NORMAL);

procedure Explode(Delimiter: Char; Str: string; ListOfStrings: TStrings);

function Implode(Delimiter: Char; ListOfStrings: TStrings): string;

function GetSubDirectories(const Directory: string): TStringList;

function Wow64DisableWow64FsRedirection(var Wow64FsEnableRedirection: LongBool): LongBool; stdcall; external 'Kernel32.dll' name
  'Wow64DisableWow64FsRedirection';

procedure RunDosInMemo(DosApp: string; AMemo: TMemo);

function GetDosOutput(CommandLine: string; Work: string = 'C:\'): string;

function SelectFolder(const InitialPath: string = ''): string;

implementation

procedure WriteDebug(Value: Integer); overload;
begin
  OutputDebugString(PChar(Value.ToString));
end;

procedure WriteDebug(Value: string); overload;
begin
  OutputDebugString(PChar(Value));
end;

//------------------------------------------------------------------------------///

function GetSubDirectories(const directory: string): TStringList;
var
  sr: TSearchRec;
begin
  Result := TStringList.Create;
  try
    if FindFirst(IncludeTrailingPathDelimiter(directory) + '*.*', faDirectory, sr) < 0 then
      Exit
    else
      repeat
        if ((sr.Attr and faDirectory <> 0) and (sr.Name <> '.') and (sr.Name <> '..')) then
          Result.Add(IncludeTrailingPathDelimiter(directory) + sr.Name);
      until FindNext(sr) <> 0;
  finally
    FindClose(sr);
  end;
end;

procedure Explode(Delimiter: Char; Str: string; ListOfStrings: TStrings);
begin

  ListOfStrings.Clear;
  ListOfStrings.Delimiter := Delimiter;
  ListOfStrings.StrictDelimiter := True; // Requires D2006 or newer.
  ListOfStrings.DelimitedText := Str;
end;

function Implode(Delimiter: Char; ListOfStrings: TStrings): string;
begin

  ListOfStrings.Delimiter := Delimiter;
  ListOfStrings.QuoteChar := #0; // for higher delphi versions
  Result := ListOfStrings.DelimitedText;
end;

procedure Execute(Filename: string; const Params: string = ''; const DirPath: string = ''; const Visibility: Integer = SW_NORMAL);
begin
  ShellExecute(GetForegroundWindow, 'open', PChar(Filename), PChar(Params), PChar(DirPath), Visibility);
end;

function GetPlatform: string;
begin
  //Result := SizeOf(Pointer) * 8; //PER VEDERE LA TUA ARCHITETTURA
  Result := GetEnvironmentVariable('ProgramW6432');
  if Result <> '' then
    Result := 'x64'
  else
    Result := 'x86';
  WriteDebug(Result);
 // Result := GetEnvironmentVariable('PROCESSOR_ARCHITECTURE');
end;

procedure WindowsVirtualKeyboard();
var
  Wow64FsEnableRedirection: LongBool;
begin
  if Wow64DisableWow64FsRedirection(Wow64FsEnableRedirection) then
    ShellExecute(0, nil, 'osk.exe', nil, nil, SW_SHOW);
end;

function IIF(Condition: Boolean; IFTrue: string; IFFalse: string): string;
begin
  if Condition then
    Result := IFTrue
  else
    Result := IFFalse;
end;

function ResourceToString(Name: string): string;
var
  ResStream: TResourceStream;
begin
  Result := '';
  ResStream := TResourceStream.Create(HInstance, Name, RT_RCDATA);
  if ResStream.Size = 0 then
  begin
    ResStream.Free;
    Exit;
  end;

  with TStringList.Create do
  begin
    LoadFromStream(ResStream);
    Result := Text;
    Free
  end;
  ResStream.Free;

end;

procedure ToolBarButtonFitWidht(ToolBar: TToolBar);
var
  I: SmallInt;
  W, Width: Integer;
  Button: TToolButton;
begin
  I := 0;
  Width := ToolBar.Width;
  Button := TToolButton(ToolBar.Controls[ToolBar.ControlCount - 1]);
  W := Button.Width;
  while W < Width do
  begin
    Button.Caption := ' ' + Button.Caption + ' ';
    W := Button.Width;
    Inc(I);
    if I > 100 then //PER PRECAUZIONE
      Break;
  end;

end;

function GetLocalComputerName: string;
var
  c1: DWORD;
  arrCh: array[0..MAX_PATH] of Char;
begin
  c1 := MAX_PATH;
  GetComputerName(arrCh, c1);
  if c1 > 0 then
    Result := arrCh
  else
    Result := '';
end;

function RoundEx(Value: Double): Double;
begin
  Result := Round(Value * 100) / 100
end;

function StringToRoundEx(Value: string): Double;
begin
  Result := Round(StrToFloat(Value) * 100) / 100
end;

function GetStringValue(Value: TObject): string;
begin
  Result := TString(Value).Value;
end;

function SetStringValue(Value: string): TString;
begin
  Result := TString.Create;
  Result.Value := Value;
end;

procedure ListBoxAddItem(ListBox: TCustomListBox; Value1, Value2: string);
begin
  ListBox.AddItem(Value1, SetStringValue(Value2));
end;

function LoadImage(Filename: string): TBitmap;
var
  Picture: TPicture;
begin
  Picture := TPicture.Create;
  try
    Picture.LoadFromFile(Filename);
    Result := TBitmap.Create;
    try
      Result.Width := Picture.Width;
      Result.Height := Picture.Height;
      Result.Canvas.Draw(0, 0, Picture.Graphic);

    finally

    end;
  finally
    Picture.Free;
  end;
end;

function ProportionalPictureResizing(Filename: string): TBitmap;
var
  Image: TBitmap;
begin
  Image := LoadImage(Filename);
  Result := TBitmap.Create;
  Result := ProportionalPictureResizing(Image);
  Image.Free;
end;

function ProportionalPictureResizing(Image: TBitmap): TBitmap;
const
  maxWidth = 125;
  maxHeight = 125;
var
  thumbRect: TRect;
begin

  try
    thumbRect.Left := 0;
    thumbRect.Top := 0;

    if Image.Width > Image.Height then
    begin
      thumbRect.Right := maxWidth;
      thumbRect.Bottom := (maxWidth * Image.Height) div Image.Width;
    end
    else
    begin
      thumbRect.Bottom := maxHeight;
      thumbRect.Right := (maxHeight * Image.Width) div Image.Height;
    end;
    Image.Canvas.StretchDraw(thumbRect, Image);
    Image.Width := thumbRect.Right;
    Image.Height := thumbRect.Bottom;

    //Image.SaveToFile('ThumbNailProportional.bmp');
    Result := TBitmap.Create;
    Result.SetSize(maxWidth, maxHeight);
    Result.Canvas.Brush.Color := clWhite;
    Result.Canvas.FillRect(Result.Canvas.ClipRect);
    Result.Canvas.Draw((maxWidth div 2) - (Image.Width div 2), (maxHeight div 2) - (Image.Height div 2), Image);
    //Result.SaveToFile('ThumbNailProportional2.bmp');
  finally

  end;
end;

function ThumbNail(Image: TBitmap): TBitmap; overload;
var
  Pic: TPicture;
begin
  Pic := TPicture.Create;
  try
    Pic.Assign(Image);
    Result := TBitmap.Create;
    try
      if Pic.Graphic is TBitmap then
        Result.PixelFormat := TBitmap(Pic.Graphic).PixelFormat
      else
        Result.PixelFormat := pf32bit;
      Result.Width := 125;
      Result.Height := 125;
      Result.Canvas.StretchDraw(Rect(0, 0, Result.Width, Result.Height), Pic.Graphic);
      //Result.SaveToFile('thumb.bmp');
    except
      Result.Free;
      raise;
    end;
  finally
    Pic.Free;
  end;

end;

function ThumbNail(Filename: string): TBitmap; overload;
var
  Image: TPicture;
begin
  Image := TPicture.Create;
  Image.LoadFromFile(Filename);
  Result := ThumbNail(Image.Bitmap);
  Image.Free;
end;

procedure SaveStringToFile(Filename: string; Value: string; const AppendString: Boolean = False);
begin
  with TStringList.Create do
  begin
    if AppendString then
      if FileExists(Filename) then
        LoadFromFile(Filename);
    Add(Value);

    if AppendString then
      Add('');
    SaveToFile(Filename);
    Free;
  end;
end;

function LoadStringToFile(Filename: string): string;
begin
  with TStringList.Create do
  begin
    if FileExists(Filename) then
      LoadFromFile(Filename);
    Result := Text;
    Free;
  end;
end;

procedure RunDosInMemo(DosApp: string; AMemo: TMemo);
const
  READ_BUFFER_SIZE = 2400;
var
  Security: TSecurityAttributes;
  readableEndOfPipe, writeableEndOfPipe: THandle;
  start: TStartupInfo;
  ProcessInfo: TProcessInformation;
  Buffer: PAnsiChar;
  BytesRead: DWORD;
  AppRunning: DWORD;
begin
  Security.nLength := SizeOf(TSecurityAttributes);
  Security.bInheritHandle := True;
  Security.lpSecurityDescriptor := nil;

  if CreatePipe(readableEndOfPipe, writeableEndOfPipe, @Security, 0) then
  begin
    Buffer := AllocMem(READ_BUFFER_SIZE + 1);
    FillChar(start, SizeOf(start), #0);
    start.cb := SizeOf(start);

    start.dwFlags := start.dwFlags or STARTF_USESTDHANDLES;
    start.hStdInput := GetStdHandle(STD_INPUT_HANDLE);
    start.hStdOutput := writeableEndOfPipe;
    start.hStdError := writeableEndOfPipe;

    start.dwFlags := start.dwFlags + STARTF_USESHOWWINDOW;
    start.wShowWindow := SW_HIDE;

    ProcessInfo := Default(TProcessInformation);

    UniqueString(DosApp);

    if CreateProcess(nil, PChar(DosApp), nil, nil, True, NORMAL_PRIORITY_CLASS, nil, nil, start, ProcessInfo) then
    begin

      repeat
        AppRunning := WaitForSingleObject(ProcessInfo.hProcess, 100);
        Application.ProcessMessages;
      until (AppRunning <> WAIT_TIMEOUT);

      repeat
        BytesRead := 0;
        ReadFile(readableEndOfPipe, Buffer[0], READ_BUFFER_SIZE, BytesRead, nil);
        Buffer[BytesRead] := #0;
        OemToAnsi(Buffer, Buffer);
        AMemo.Text := AMemo.text + string(Buffer);
      until (BytesRead < READ_BUFFER_SIZE);
    end;
    FreeMem(Buffer);
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
    CloseHandle(readableEndOfPipe);
    CloseHandle(writeableEndOfPipe);
  end;
end;

function GetDosOutput(CommandLine: string; Work: string = 'C:\'): string;
var
  SA: TSecurityAttributes;
  SI: TStartupInfo;
  PI: TProcessInformation;
  StdOutPipeRead, StdOutPipeWrite: THandle;
  WasOK: Boolean;
  Buffer: array[0..255] of AnsiChar;
  BytesRead: Cardinal;
  WorkDir: string;
  Handle: Boolean;
begin
  Result := '';
  with SA do
  begin
    nLength := SizeOf(SA);
    bInheritHandle := True;
    lpSecurityDescriptor := nil;
  end;
  CreatePipe(StdOutPipeRead, StdOutPipeWrite, @SA, 0);
  try
    with SI do
    begin
      FillChar(SI, SizeOf(SI), 0);
      cb := SizeOf(SI);
      dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      wShowWindow := SW_HIDE;
      hStdInput := GetStdHandle(STD_INPUT_HANDLE); // don't redirect stdin
      hStdOutput := StdOutPipeWrite;
      hStdError := StdOutPipeWrite;
    end;
    WorkDir := Work;
    Handle := CreateProcess(nil, PChar('cmd.exe /C ' + CommandLine), nil, nil, True, 0, nil, PChar(WorkDir), SI, PI);
    CloseHandle(StdOutPipeWrite);
    if Handle then
    try
      repeat
        WasOK := ReadFile(StdOutPipeRead, Buffer, 255, BytesRead, nil);
        if BytesRead > 0 then
        begin
          Buffer[BytesRead] := #0;
          Result := Result + Buffer;
        end;
      until not WasOK or (BytesRead = 0);
      WaitForSingleObject(PI.hProcess, INFINITE);
    finally
      CloseHandle(PI.hThread);
      CloseHandle(PI.hProcess);
    end;
  finally
    CloseHandle(StdOutPipeRead);
  end;
end;

function SelectFolder(const InitialPath: string = ''): string;
var
  Directory: string;
const
  SELDIRHELP = 1000;
begin
  Result := '';
  if InitialPath <> '' then
    Directory := IncludeTrailingPathDelimiter(InitialPath);

  if FileCtrl.SelectDirectory(Directory, [sdAllowCreate, sdPerformCreate, sdPrompt], SELDIRHELP) then
    Result := Directory;
end;

end.

