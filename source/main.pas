unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Registry,
  ComCtrls, StdCtrls, ShellAPI;

type
  TfrmMain = class(TForm)
    btnClose: TButton;
    btnHelp: TButton;
    lvwItems: TListView;
    btnDelete: TButton;
    btnRefresh: TButton;
    procedure ReadItems();
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.ReadItems();
var
	reg: TRegistry;
    values: TStringList;
    i: integer;
    item: TListItem;
begin
	// cleaning the list
	lvwItems.Clear();

	// initializing reader
    reg:=TRegistry.Create();
    values:=TStringList.Create();

	// reading the HKCU
	reg.RootKey:=HKEY_CURRENT_USER;
	if reg.OpenKeyReadOnly('\Software\Microsoft\Windows\CurrentVersion\Run') then
    	begin
        reg.GetValueNames(values);

        if (values.Count>0) then
        	begin
            for i:=0 to (values.Count-1) do
            	begin
                if ((reg.GetDataType(values[i])=rdString) or (reg.GetDataType(values[i])=rdExpandString)) then
                	begin
                	item:=lvwItems.Items.AddItem(nil);
                	item.SubItems.Add(values[i]);
                	item.SubItems.Add(reg.ReadString(values[i]));
                	item.SubItems.Add('HKCU');
                    end;
                end;
            end;

        reg.CloseKey();
        end;

    // reading the HKLM
    reg.RootKey:=HKEY_LOCAL_MACHINE;
    if reg.OpenKeyReadOnly('\Software\Microsoft\Windows\CurrentVersion\Run') then
    	begin
        reg.GetValueNames(values);

        if (values.Count>0) then
        	begin
            for i:=0 to (values.Count-1) do
            	begin
                if ((reg.GetDataType(values[i])=rdString) or (reg.GetDataType(values[i])=rdExpandString)) then
                	begin
                	item:=lvwItems.Items.AddItem(nil);
                	item.SubItems.Add(values[i]);
                	item.SubItems.Add(reg.ReadString(values[i]));
                	item.SubItems.Add('HKLM');
                    end;
                end;
            end;

        reg.CloseKey();
        end;

    // the end
    FreeAndNil(reg);
    FreeAndNil(values);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
	// reading the data
	ReadItems();
end;

procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
	Close();
end;

procedure TfrmMain.btnRefreshClick(Sender: TObject);
begin
	ReadItems();
end;

procedure TfrmMain.btnDeleteClick(Sender: TObject);
var
	reg: TRegistry;
    i: integer;
begin
    // confirmation
	if (Application.MessageBox('Are you sure you want to delete selected items?'#10#13'WARNING: Deletion of unknown entries can cause your computer to fail! If you are not sure - click "No"!','Futuris Run Manager',MB_YESNO + MB_ICONQUESTION)=IDYES) then
    	begin
        reg:=TRegistry.Create();
        for i:=0 to (lvwItems.Items.Count-1) do
			begin
            if lvwItems.Items[i].Checked then
            	begin
                if (lvwItems.Items[i].SubItems[2]='HKCU') then reg.RootKey:=HKEY_CURRENT_USER
                	else reg.RootKey:=HKEY_LOCAL_MACHINE;
				if reg.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run',false) then
                	begin
                    reg.DeleteValue(lvwItems.Items[i].SubItems[0]);
                    reg.CloseKey();
                    end;
                end;
    		end;
		FreeAndNil(reg);

		// rereading the data
		ReadItems();
        end;
end;

procedure TfrmMain.btnHelpClick(Sender: TObject);
begin
ShellExecute(frmMain.Handle,'open',PChar(ExtractFilePath(Application.ExeName) + 'runm.chm'),nil,nil,SW_SHOWNORMAL);
end;

procedure TfrmMain.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if Key=VK_ESCAPE then Close();
end;

end.
