object frmMain: TfrmMain
  Left = 190
  Top = 105
  ActiveControl = btnClose
  BorderStyle = bsDialog
  Caption = 'Run Manager'
  ClientHeight = 347
  ClientWidth = 525
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  PixelsPerInch = 96
  TextHeight = 13
  object btnClose: TButton
    Left = 444
    Top = 316
    Width = 75
    Height = 25
    Caption = 'Close'
    Default = True
    TabOrder = 0
    OnClick = btnCloseClick
  end
  object btnHelp: TButton
    Left = 366
    Top = 316
    Width = 75
    Height = 25
    Caption = 'Help'
    TabOrder = 1
    OnClick = btnHelpClick
  end
  object lvwItems: TListView
    Left = 4
    Top = 4
    Width = 515
    Height = 308
    Checkboxes = True
    Columns = <
      item
        Width = 25
      end
      item
        AutoSize = True
        Caption = 'Name'
      end
      item
        AutoSize = True
        Caption = 'Command'
      end
      item
        Caption = 'Location'
        Width = 75
      end>
    ColumnClick = False
    MultiSelect = True
    ReadOnly = True
    TabOrder = 2
    ViewStyle = vsReport
  end
  object btnDelete: TButton
    Left = 82
    Top = 316
    Width = 75
    Height = 25
    Caption = 'Delete'
    TabOrder = 3
    OnClick = btnDeleteClick
  end
  object btnRefresh: TButton
    Left = 4
    Top = 316
    Width = 75
    Height = 25
    Caption = 'Refresh'
    TabOrder = 4
    OnClick = btnRefreshClick
  end
end
