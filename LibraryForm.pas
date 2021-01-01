unit LibraryForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls, System.ImageList, Vcl.ImgList;

type
  TMultiResult = record
    OK: Boolean;
    Value: string;
  end;

  TfrmLibrary = class(TForm)
    lstLibrary: TListBox;
    edtPath: TEdit;
    btnOK: TButton;
    btnCancel: TButton;
    btnAdd: TButton;
    btnReplace: TButton;
    btnDelete: TButton;
    btnInvalid: TButton;
    btnLibraryDir: TButton;
    il16Bis: TImageList;
    procedure lstLibraryClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnReplaceClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnInvalidClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLibrary: TfrmLibrary;

function EditLibrary(NameValue: string; Values: string): TMultiResult;

implementation

uses
  GlobalUnit;

{$R *.dfm}

function EditLibrary(NameValue: string; Values: string): TMultiResult;
var
  ListValues: TStringList;
begin
  Result.OK := False;
  frmLibrary := TfrmLibrary.Create(Application.MainForm);
  with frmLibrary do
  begin
    ListValues := TStringList.Create;
    Caption := NameValue;
    Explode(';', Values, ListValues);
    lstLibrary.Items.Assign(ListValues);

    if ShowModal = mrOk then
    begin
      ListValues.Assign(lstLibrary.Items);
      Result.Value := Implode(';', ListValues);
      Result.OK := True;
    end;

    ListValues.Free;

  end;
  frmLibrary.Free;
end;

procedure TfrmLibrary.btnAddClick(Sender: TObject);
begin
  if DirectoryExists(edtPath.Text) then
    lstLibrary.Items.Add(edtPath.Text);
end;

procedure TfrmLibrary.btnDeleteClick(Sender: TObject);
begin
  if lstLibrary.ItemIndex > -1 then
    lstLibrary.Items.Delete(lstLibrary.ItemIndex);
end;

procedure TfrmLibrary.btnInvalidClick(Sender: TObject);
var
  I: Integer;
  Path: string;
begin
  I := 0;
  while I < lstLibrary.Items.Count do
  begin
    Path := lstLibrary.Items[I];
    if not DirectoryExists(edtPath.Text) then
      lstLibrary.Items.Delete(lstLibrary.ItemIndex)
    else
      Inc(I);
  end;

end;

procedure TfrmLibrary.btnReplaceClick(Sender: TObject);
begin
  if lstLibrary.ItemIndex > -1 then
    if DirectoryExists(edtPath.Text) then
      lstLibrary.Items[lstLibrary.ItemIndex] := edtPath.Text;
end;

procedure TfrmLibrary.lstLibraryClick(Sender: TObject);
begin
  if lstLibrary.ItemIndex > -1 then
    edtPath.Text := lstLibrary.Items[lstLibrary.ItemIndex];
end;

end.

