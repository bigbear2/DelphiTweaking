object frmLibrary: TfrmLibrary
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'frmLibrary'
  ClientHeight = 382
  ClientWidth = 392
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  DesignSize = (
    392
    382)
  PixelsPerInch = 96
  TextHeight = 13
  object lstLibrary: TListBox
    Left = 8
    Top = 8
    Width = 376
    Height = 249
    Anchors = [akLeft, akTop, akRight]
    ItemHeight = 13
    TabOrder = 0
    OnClick = lstLibraryClick
  end
  object edtPath: TEdit
    Left = 8
    Top = 263
    Width = 337
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
  end
  object btnOK: TButton
    Left = 309
    Top = 349
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 228
    Top = 349
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object btnAdd: TButton
    Left = 89
    Top = 290
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Add'
    TabOrder = 4
    OnClick = btnAddClick
  end
  object btnReplace: TButton
    Left = 8
    Top = 290
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Replace'
    TabOrder = 5
    OnClick = btnReplaceClick
  end
  object btnDelete: TButton
    Left = 170
    Top = 290
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Delete'
    TabOrder = 6
    OnClick = btnDeleteClick
  end
  object btnInvalid: TButton
    Left = 251
    Top = 290
    Width = 133
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Delete Invalid Path'
    TabOrder = 7
    OnClick = btnInvalidClick
  end
  object btnLibraryDir: TButton
    Left = 351
    Top = 262
    Width = 33
    Height = 23
    Anchors = [akTop, akRight]
    ImageAlignment = iaCenter
    ImageIndex = 0
    Images = il16Bis
    TabOrder = 8
  end
  object il16Bis: TImageList
    ColorDepth = cd32Bit
    Left = 224
    Top = 176
    Bitmap = {
      494C010101000C00040010001000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000003000000033000000330000
      0033000000330000003300000033000000330000003300000033000000330000
      0033000000330000002F00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004090C6F24298D2FF3F94D0FF3D92
      CFFF3D92CEFF3E92CEFF3E92CEFF3E92CEFF3E92CEFF3E92CEFF3E92CEFF3E92
      CEFF3E93CFFF3C8BC2F00000000E000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004399D2FF3E94D0FFABFBFFFF9BF3
      FFFF92F1FFFF93F1FFFF93F1FFFF93F1FFFF93F1FFFF93F1FFFF93F1FFFF93F1
      FFFFA6F8FFFF64B8E3FF11293A5F000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004298D2FF4EA6D9FF8EDAF5FFA2EE
      FFFF82E5FEFF84E5FEFF84E5FEFF85E6FEFF85E6FEFF85E6FEFF85E6FEFF84E6
      FEFF96EBFFFF8CD8F5FF286087B8000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004196D1FF6ABEE8FF6CBDE6FFBBF2
      FFFF74DEFDFF76DEFCFF77DEFCFF7ADFFCFF7CDFFCFF7CDFFCFF7CDFFCFF7BDF
      FCFF80E0FDFFADF0FFFF4C9DD3FF0000000E0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003F95D0FF8AD7F5FF43A1D8FFDDFD
      FFFFDAFAFFFFDBFAFFFFDEFAFFFF73DCFCFF75DBFAFF74DAFAFF73DAFAFF73DA
      FAFF71D9FAFFA1E8FFFF7BBFE6FF11283A5E0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003D94D0FFABF0FFFF439DD6FF358C
      CBFF358CCBFF358CCBFF368BCBFF5BBEEAFF6ED9FBFF69D6FAFF67D5F9FF66D4
      F9FF65D4F9FF82DEFCFFAAE0F6FF296087B90000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003C92CFFFB9F4FFFF72DBFBFF6ACC
      F2FF6BCDF3FF6BCEF3FF6CCEF3FF469CD4FF55BAE9FFDAF8FFFFD7F6FFFFD6F6
      FFFFD5F6FFFFD5F7FFFFDBFCFFFF3D94D0FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003B92CFFFC0F3FFFF70DAFBFF73DB
      FBFF74DBFCFF74DBFCFF75DCFCFF72DAFAFF439CD4FF368CCBFF358CCBFF348C
      CCFF338DCCFF3790CEFF3C94D0FF3D8CC2EB0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003A92CFFFCAF6FFFF68D5F9FF6BD5
      F9FF6AD5F9FF68D5F9FF68D5FAFF69D7FBFF67D4FAFF5DC7F1FF5DC7F2FF5CC8
      F2FFB4E3F8FF3C94D0FF193B5269000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003A92CFFFD5F7FFFF5FD1F9FF60D0
      F8FFB4EBFDFFD9F6FFFFDAF8FFFFDAF8FFFFDBF9FFFFDCFAFFFFDCFAFFFFDCFB
      FFFFE0FFFFFF3D95D0FF0D1F2A33000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003C94D0FFDCFCFFFFD8F7FFFFD8F7
      FFFFDBFAFFFF348ECDFF3891CEFF3992CFFF3992CFFF3992CFFF3992CFFF3A92
      CFFF3C94D0FF3780B1D700000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000002E6991B03C94D0FF3992CFFF3992
      CFFF3C94D0FF367CACD200000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFF0000000000000003000000000000
      0001000000000000000100000000000000010000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00010000000000000001000000000000000300000000000003FF000000000000
      FFFF000000000000FFFF00000000000000000000000000000000000000000000
      000000000000}
  end
end
