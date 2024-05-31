VERSION 5.00
Object = "{0F1F1508-C40A-101B-AD04-00AA00575482}#1.0#0"; "mhrinp32.ocx"
Begin VB.Form FVISA 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "DATOS DE TARJETA DE CREDITO"
   ClientHeight    =   3615
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6585
   Icon            =   "FVISA.frx":0000
   KeyPreview      =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3615
   ScaleWidth      =   6585
   Tag             =   "2"
   Begin VB.Frame FVISA 
      BackColor       =   &H00C0C0C0&
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000D&
      Height          =   3405
      Left            =   120
      TabIndex        =   10
      Top             =   120
      Width           =   6375
      Begin VB.OptionButton optTipoIdentifica 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Pasaporte"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   2
         Left            =   4920
         TabIndex        =   21
         Top             =   500
         Width           =   1215
      End
      Begin VB.OptionButton optTipoIdentifica 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "RUC"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   1
         Left            =   3600
         TabIndex        =   1
         Top             =   500
         Width           =   735
      End
      Begin VB.OptionButton optTipoIdentifica 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Cédula"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   0
         Left            =   2160
         TabIndex        =   0
         Top             =   500
         Width           =   915
      End
      Begin VB.ComboBox cmbTipoConsumo 
         Appearance      =   0  'Flat
         Height          =   315
         ItemData        =   "FVISA.frx":000C
         Left            =   2040
         List            =   "FVISA.frx":0016
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Top             =   2350
         Width           =   1335
      End
      Begin VB.TextBox txtMeses 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   2040
         MaxLength       =   2
         TabIndex        =   5
         Top             =   2720
         Width           =   1335
      End
      Begin VB.TextBox txtFechaVen 
         Enabled         =   0   'False
         Height          =   285
         Left            =   3840
         MaxLength       =   4
         TabIndex        =   9
         Top             =   3060
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.TextBox txtCVV2 
         Enabled         =   0   'False
         Height          =   285
         Left            =   600
         MaxLength       =   3
         TabIndex        =   8
         Top             =   3120
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.TextBox txtCedula 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   2040
         MaxLength       =   16
         TabIndex        =   2
         Top             =   820
         Width           =   2175
      End
      Begin VB.CommandButton CmdNC 
         Caption         =   "&Aceptar"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   0
         Left            =   5220
         TabIndex        =   6
         ToolTipText     =   "Aceptar los valores ingresados"
         Top             =   2340
         Width           =   975
      End
      Begin VB.CommandButton CmdNC 
         Caption         =   "&Cancelar"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Index           =   1
         Left            =   5220
         TabIndex        =   7
         ToolTipText     =   "Cancelar el ingreso de notas de crédito"
         Top             =   2775
         Width           =   975
      End
      Begin MhinrelLib.MhRealInput Monto 
         Height          =   285
         Left            =   2040
         TabIndex        =   3
         Top             =   2040
         Width           =   1335
         _Version        =   65536
         _ExtentX        =   2355
         _ExtentY        =   503
         _StockProps     =   77
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Enabled         =   -1  'True
         TintColor       =   16711935
         FillColor       =   16777215
         MaxReal         =   3.4E+38
         MinReal         =   0
         CaretColor      =   -2147483642
         DecimalPlaces   =   2
         Separator       =   -1  'True
      End
      Begin VB.Label lblTipTarjeta 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   285
         Left            =   2040
         TabIndex        =   24
         Top             =   1740
         Width           =   4200
      End
      Begin VB.Label lblNumTarjeta 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   285
         Left            =   2040
         TabIndex        =   23
         Top             =   1440
         Width           =   4200
      End
      Begin VB.Label lblNomTarjeta 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   285
         Left            =   2040
         TabIndex        =   22
         Top             =   1140
         Width           =   4200
      End
      Begin VB.Label LblEtiquetas 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Tipo de Identicación:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   0
         Left            =   200
         TabIndex        =   20
         Top             =   500
         Width           =   1815
      End
      Begin VB.Label LblEtiquetas 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Identicación:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   2
         Left            =   200
         TabIndex        =   19
         Top             =   820
         Width           =   1110
      End
      Begin VB.Label EtqTipTarjeta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Tipo de Tarjeta:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   200
         TabIndex        =   18
         Top             =   1740
         Width           =   1380
      End
      Begin VB.Label EtqNomTarjeta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Nombre de Tarjeta:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   200
         TabIndex        =   17
         Top             =   1140
         Width           =   1650
      End
      Begin VB.Label lblCedula 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Tipo de consumo"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   200
         TabIndex        =   16
         Top             =   2400
         Width           =   1470
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Meses a diferir"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   200
         TabIndex        =   15
         Top             =   2760
         Width           =   1260
      End
      Begin VB.Label lblChq 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "CVV2"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   180
         TabIndex        =   14
         Top             =   3120
         Visible         =   0   'False
         Width           =   480
      End
      Begin VB.Label LblCuenta 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Fecha vencimiento"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   2160
         TabIndex        =   13
         Top             =   3120
         Visible         =   0   'False
         Width           =   1620
      End
      Begin VB.Label LblDebito 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Valor del consumo"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   200
         TabIndex        =   12
         Top             =   2090
         Width           =   1575
      End
      Begin VB.Label EtqNumTarjeta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Número de tarjeta"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   200
         TabIndex        =   11
         Top             =   1440
         Width           =   1530
      End
   End
End
Attribute VB_Name = "FVISA"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public VLFVISA_numtar As String
''''Public VLFVISA_cvv2 As String
Public VLFVISA_fechaven As String
Public VLFVISA_meses As String
Public VLFVISA_monto As Currency
Public VLFVISA_tipoconsumo As String
Public VLFVISA_banda_sn  As String
Public VLFVISA_track1 As String
Public VLFVISA_track2 As String
Public VLFVISA_nombre As String
Public VLFVISA_ClaveUnicaTC As String     'PHOYOSV REF_02 20170714
Public VLFlagAutorizacion As Boolean
'*  02  29/JUN/2018 Paul Hoyos V.   CTE-CC-SGC00031990 Consumo TC con cedula    *'
Dim VLClaveUnicaTC   As String            'PHOYOSV REF_02 20170714
Dim VLTarjetaVendi   As String            'PHOYOSV REF_02 20170714
Dim VLFechaExpirac   As String            'PHOYOSV REF_02 20170714
Dim VLNombreClient   As String            'PHOYOSV REF_02 20170714
Private VLCambio As Boolean
Public VLnemonico As String 'KBastida Fcc134 - Fcc78

Private Sub cmbTipoConsumo_Click()
    If cmbTipoConsumo.ListIndex = 0 Then
        txtMeses.Text = "0"
        txtMeses.Enabled = False
    Else
        txtMeses.Enabled = True
    End If
End Sub

Private Sub CmdNC_Click(Index As Integer)
    If Index = 0 Then
      If Not FLChequeos() Then
        Exit Sub
      End If
      VLFVISA_ClaveUnicaTC = VLClaveUnicaTC   'PHOYOSV REF_02 20170714
      VLFVISA_fechaven = Mid(VLFechaExpirac, 9, 2) + Mid(VLFechaExpirac, 1, 2)    'YYMM PHOYOSV REF_02 20170714
      VLFVISA_nombre = VLNombreClient                                             'PHOYOSV REF_02 20170714
    Else
      VLFVISA_ClaveUnicaTC = ""               'PHOYOSV REF_02 20170714
      VLFVISA_fechaven = ""
      VLFVISA_nombre = ""
    End If
''''VLFVISA_numtar = txtNumTar.Text
    VLFVISA_numtar = lblNumTarjeta            'PHOYOSV REF_02 20170714
''''VLFVISA_cvv2 = txtCVV2.Text
''''VLFVISA_fechaven = txtFechaVen.Text
    VLFVISA_meses = txtMeses.Text
    VLFVISA_meses = String(2 - Len(Trim$(VLFVISA_meses)), "0") + Trim$(VLFVISA_meses)
    VLFVISA_monto = Monto.Text
    If cmbTipoConsumo.ListIndex = 0 Then
        VLFVISA_tipoconsumo = "R"
    Else
        VLFVISA_tipoconsumo = "D"
    End If
    Unload Me
End Sub

Private Sub Form_Activate()
    If SGMonedaTran <> VGmoneda% And VGmoneda% <> 0 Then
        SGMonedaTran = VGmoneda%
    End If
    VGTran = 0
    If txtCedula.Enabled Then txtCedula.SetFocus
''''    If txtNumTar.Enabled Then
''''        txtNumTar.SetFocus
''''    End If
End Sub

Sub Form_Load()
    Me.Tag = "2" 'Indicador para que la lectora en fprincipal dirija sus datos
    'Sumadora  ----->
    SGActivaSum = False
    SGActual = 0
    '<-----
    Me.Move 1000, 1800
    optTipoIdentifica(0).Value = True  'PHOYOSV REF_02 20180702
    VLFVISA_VLClaveUnicaTC = ""        'PHOYOSV REF_02 20180702
''''SubClassForm Me
''''  If VGLectora$ = "S" Then
''''  txtNumTar.Locked = True    'PHOYOSV REF_02 20180702
''''  txtFechaVen.Locked = True  'PHOYOSV REF_02 20180702
''''  VLFVISA_banda_sn = "S"
''''  Else
''''  txtNumTar.Locked = False   'PHOYOSV REF_02 20180702
''''  txtFechaVen.Locked = False 'PHOYOSV REF_02 20180702
    VLFVISA_banda_sn = "N"
''''  End If
    cmbTipoConsumo.ListIndex = 1 'PHOYOSV REF_02 20180702
End Sub

Sub Form_Unload(Cancel As Integer)
''''UnSubClassForm Me
''''Unload Me
  PMCerrarForma ""
End Sub

Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    Select Case KeyCode%
    Case CGTeclaESC%
        Unload Me
    Case CGTeclaF2%
        Monto.Text = "0.00"
        If Monto.Enabled Then
            Monto.SetFocus
        End If
    Case CGTeclaF11%
        If VGTipoEjecucion% = CGNormal% And VGLectora$ = "S" Then
            If VLFlagAutorizacion Then
                If FMSupervisor("43") = True Then
''''                    txtNumTar.Locked = False
''''                    txtFechaVen.Locked = False
                    VLFVISA_banda_sn = "N"
                    VLFlagAutorizacion = False
                End If
''''                txtNumTar.SetFocus
            End If
        End If
    End Select
End Sub

Sub Monto_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Valor a cobrar"
End Sub

Sub Monto_KeyDown(KeyCode As Integer, Shift As Integer)
    Select Case KeyCode%
    Case CGTeclaSUPR%
        Monto.Text = ""
    Case CGTeclaENTER%
        SendKeys "{TAB}"
    Case CGTeclaDOWN%, CGTeclaAVPAG%
        SendKeys "{TAB}"
    End Select
End Sub
 
Sub Monto_KeyPress(KeyAscii As Integer)
    KeyAscii = FMValidarNumero((Monto.Text), VGLongitudMoney, KeyAscii, "11")
End Sub

Function FLChequeos() As Boolean
    FLChequeos = False
    
    If FMCCurATX((Monto.Text)) <= 0 Then
      MsgBox "Es necesario un valor"
      Monto.SetFocus
      Exit Function
    End If
    
    If cmbTipoConsumo.ListIndex < 0 Or cmbTipoConsumo.ListIndex > 1 Then
        MsgBox "Seleccione el tipo de consumo"
        cmbTipoConsumo.SetFocus
        Exit Function
    End If
    
    If cmbTipoConsumo.ListIndex = 1 Then
        If val(txtMeses.Text) <= 0 Then
            MsgBox "Para tipo de consumo es necesario especificar el numero de cuotas"
            Exit Function
        End If
    End If
    
''''    If Trim$(txtCVV2.Text) = "" Then
''''        MsgBox "Campo requerido"
''''        txtCVV2.SetFocus
''''        Exit Function
''''    End If
    
    'Chequear que pertenezca al bin autorizado
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "sv_binpagser", "", ""
    PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR&, "V", "", ""
    PMPasoValoresATX VGSqlConn&, "@i_codigo", 0, SQLCHAR&, Mid$(lblNumTarjeta, 1, 6), "", ""
    If FMTransmitirRPCATX(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "", "N", "S", "I", "0", "N", "N") Then
        PMChequeaATX VGSqlConn&
        PMFinTransaccion
    Else
        PMChequeaATX VGSqlConn&
        PMFinTransaccion
        MsgBox "El bin de esta tarjeta no esta autorizado para esta transacción", vbInformation, "Error"
        Exit Function
    End If
    
    FLChequeos = True
End Function

Public Sub plmostrar(VLTracks As String)
On Error GoTo Etiqueta
    Dim VlCaracter_Enter As Integer
    Dim VlCaracter_Caret1 As Integer
    Dim VlCaracter_Caret2 As Integer
    If VLFVISA_banda_sn = "N" Then
        Exit Sub
    End If
    VlCaracter_Enter = InStr(VLTracks, Chr(13))
    VLFVISA_track1 = Mid$(VLTracks, 2, VlCaracter_Enter - 4)
    VLFVISA_track2 = Mid$(VLTracks, VlCaracter_Enter + 2, Len(VLTracks) - VlCaracter_Enter - 4)
    VlCaracter_Enter = InStr(VLFVISA_track2, "=")
    If VlCaracter_Enter > 0 Then
        VLFVISA_track2 = Mid$(VLFVISA_track2, 1, VlCaracter_Enter - 1) + "D" + Mid$(VLFVISA_track2, VlCaracter_Enter + 1, Len(VLFVISA_track2) - VlCaracter_Enter)
    End If
''''    txtNumTar.Text = Mid$(VLFVISA_track1, 2, 16)
    VlCaracter_Caret1 = InStr(VLFVISA_track1, "^")
    VlCaracter_Caret2 = InStr(VlCaracter_Caret1 + 1, VLFVISA_track1, "^")
    VLFVISA_nombre = Mid$(VLFVISA_track1, VlCaracter_Caret1 + 1, VlCaracter_Caret2 - VlCaracter_Caret1 - 1)
''''txtFechaVen.Text = Mid$(VLFVISA_track1, VlCaracter_Caret2 + 1, 4)
    VLFlagAutorizacion = False
    txtCVV2.SetFocus
    Exit Sub
Etiqueta:
    MsgBox "Error en la lectura de la tarjeta", vbInformation, "Error"
End Sub

'PHOYOSV REF_02 INI 02-JUL-2018
Private Sub optTipoIdentifica_GotFocus(Index As Integer)
FPrincipal!pnlHelpLine.Caption = "Elija el tipo de identificación"
End Sub

Private Sub optTipoIdentifica_Click(Index As Integer)
Select Case Index
  Case 0
     txtCedula.MaxLength = 10
     txtCedula = Trim(Mid(txtCedula, 1, 10))
  Case 1
     txtCedula.MaxLength = 13
     txtCedula = Trim(Mid(txtCedula, 1, 13))
  Case 2
     txtCedula.MaxLength = 20
     txtCedula = Trim(Mid(txtCedula, 1, 20))
End Select
txtCedula = ""
lblNomTarjeta = ""
lblNumTarjeta = ""
lblTipTarjeta = ""
Monto = 0
cmbTipoConsumo.ListIndex = 1
txtMeses = 0
VLClaveUnicaTC = ""
VLTarjetaVendi = ""
VLFechaExpirac = ""
VLNombreClient = ""
End Sub

Private Sub optTipoIdentifica_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
Select Case KeyCode%
  Case CGTeclaUP%, CGTeclaREPAG%
    Select Case Index
      Case 0
        If txtMeses.Enabled Then txtMeses.SetFocus
      Case 1
        If optTipoIdentifica(0).Enabled Then optTipoIdentifica(0).SetFocus
      Case 2
        If optTipoIdentifica(1).Enabled Then optTipoIdentifica(1).SetFocus
    End Select
  Case CGTeclaDOWN%, CGTeclaAVPAG%, CGTeclaENTER
    SendKeys "{TAB}"
End Select
End Sub

Private Sub TxtCedula_Change()
 VLCambio = False
End Sub

Private Sub TxtCedula_GotFocus()
 FPrincipal!pnlHelpLine.Caption = "Ingrese la identificación"
End Sub

Private Sub TxtCedula_KeyDown(KeyCode As Integer, Shift As Integer)
Select Case KeyCode%
 Case CGTeclaUP%, CGTeclaREPAG%
  If optTipoIdentifica(2).Enabled Then optTipoIdentifica(2).SetFocus
 Case CGTeclaSUPR%
  If txtCedula.Enabled Then txtCedula = ""
 Case CGTeclaDOWN%, CGTeclaAVPAG%, CGTeclaENTER
  SendKeys "{TAB}"
End Select
End Sub

Private Sub Txtcedula_KeyPress(KeyAscii As Integer)
Dim TPCaracter As String
If optTipoIdentifica(0).Value Or optTipoIdentifica(1).Value Then
  Select Case KeyAscii
   Case 48 To 57, 65 To 90, 8  '--32 caracter espacio no permitido--
   Case 97 To 122
    TPCaracter = Chr(KeyAscii)
    KeyAscii = Asc(UCase(TPCaracter))
   Case Else
    KeyAscii = 0
  End Select
End If
End Sub

Private Sub Txtcedula_LostFocus()
'CARGAR FORMA DE CONSULTA DE TARJETAS SI LA CONSULTA RETORNA
'MAS DE UNA TARJETA ASOCIADA A LA IDENTIFICACION INGRESADA
Dim VTCantRegistros As String
Dim VTMatrizTarjetas(7, 20) As String
Dim VTFila, VTColumna As Integer

If VLnemonico = "" Then
    VLnemonico = "78"
End If

If Trim(txtCedula) <> "" And VLCambio = False Then
  If optTipoIdentifica(0) Or optTipoIdentifica(1) Then
     If Not FMValidaCedulaRuc(Trim(txtCedula)) Then
        Exit Sub
     End If
  End If
  VLClaveUnicaTC = ""
  VLPaso = True
  PMInicioTransaccion
  PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, "43140", "CodigoTransaccion", ""            '0
''PMPasoValoresATX VGSqlConn, "@i_operacion", 0, SQLCHAR, "A", "OperacionConsulta", ""          '1
  PMPasoValoresATX VGSqlConn, "@i_modo", 0, SQLINT1, "0", "ModoConsulta", ""                    '2
  PMPasoValoresATX VGSqlConn, "@i_cliente", 0, SQLINT4, "0", "CodigoCliente", ""                '3
''PMPasoValoresATX VGSqlConn, "@o_num_filas", 1, SQLINT2, "0", "NumeroFilas", ""                '4
  PMPasoValoresATX VGSqlConn, "@i_cedruc", 0, SQLVARCHAR, Trim(txtCedula), "Identificacion", "" '5
  If FMTransmitirRPCATX(VGSqlConn, "", "cob_cuentas", "pa_cte_ctarjeta_credito", True, "Búsqueda de Tarjetas Credito", "N", "N", "N", VLnemonico, "S", "N") = True Then
    ReDim TemporalesTC(20)
    VTCantRegistros = "0"
    FMMapeaMatrizATX VGSqlConn, VTMatrizTarjetas
    PMMapeaVariable VGSqlConn, VTCantRegistros
    PMChequeaATX VGSqlConn&
    PMFinTransaccion
    VLClaveUnicaTC = ""
    If IsNumeric(VTCantRegistros) Then
      VLConsultaCedula = "SI"
      If CInt(VTCantRegistros) = 1 Then
       lblTipTarjeta = VTMatrizTarjetas(0, 1)
       VLClaveUnicaTC = VTMatrizTarjetas(3, 1)
       lblNomTarjeta = VTMatrizTarjetas(4, 1)
       VLNombreClient = VTMatrizTarjetas(4, 1)
       VLTarjetaVendi = VTMatrizTarjetas(5, 1)
       VLFechaExpirac = VTMatrizTarjetas(6, 1)
       txtCedula.Enabled = False
       lblNumTarjeta = VTMatrizTarjetas(2, 1)
       VLPaso = True
       VLCambio = False
       VLSum = True
       If FMRetStatusATX(VGSqlConn) <> 0 Then
         VLCambio = True
       End If
       If VLTarjetaVendi = "S" Then
         MsgBox "VENTA DE CARTERA", vbCritical + vbExclamation, "ATX - AVISO"
         Call Form_KeyDown(CGTeclaF2%, 1)
       End If
      Else
        If CInt(VTCantRegistros) > 1 Then
         grid_tarjetas.gr_TABLA.Rows = CInt(VTCantRegistros) + 1
         grid_tarjetas.gr_TABLA.Cols = 9
         For VTColumna = -1 To 7 Step 1
           grid_tarjetas.gr_TABLA.Col = VTColumna + 1
           For VTFila = 0 To CInt(VTCantRegistros) Step 1
             grid_tarjetas.gr_TABLA.Row = VTFila
             If VTColumna = -1 Then
               If VTFila = 0 Then
                 grid_tarjetas.gr_TABLA.Text = "ITEM"
               Else
                 grid_tarjetas.gr_TABLA.Text = CStr(VTFila)
               End If
             Else
               grid_tarjetas.gr_TABLA.Text = VTMatrizTarjetas(VTColumna, VTFila)
             End If
           Next VTFila
         Next VTColumna
         grid_tarjetas.gr_TABLA.Col = 0
         grid_tarjetas.gr_TABLA.Row = 1
         grid_tarjetas.gr_TABLA.SelStartCol = 1
         grid_tarjetas.gr_TABLA.SelEndCol = grid_tarjetas.gr_TABLA.Cols - 1
         grid_tarjetas.gr_TABLA.SelStartRow = 1
         grid_tarjetas.gr_TABLA.SelEndRow = 1
         grid_tarjetas.gr_TABLA.ColWidth(0) = 600
         grid_tarjetas.gr_TABLA.ColWidth(1) = 2000
         grid_tarjetas.gr_TABLA.ColWidth(2) = 1300
         grid_tarjetas.gr_TABLA.ColWidth(3) = 1800
         grid_tarjetas.gr_TABLA.ColWidth(4) = 1
         grid_tarjetas.gr_TABLA.ColWidth(5) = 2400
         grid_tarjetas.gr_TABLA.ColWidth(6) = 1
         grid_tarjetas.gr_TABLA.ColWidth(7) = 1
         grid_tarjetas.Show 1
         If TemporalesTC(1) <> "" Then
          lblTipTarjeta = TemporalesTC(1)
          VLClaveUnicaTC = TemporalesTC(4)
          lblNomTarjeta = TemporalesTC(5)
          VLNombreClient = TemporalesTC(5)
          VLTarjetaVendi = TemporalesTC(6)
          VLFechaExpirac = TemporalesTC(7)
          txtCedula.Enabled = False
          lblNumTarjeta = Trim(TemporalesTC(3))
          VLPaso = True
          VLCambio = False
          VLSum = True
          If VLTarjetaVendi = "S" Then
            MsgBox "VENTA DE CARTERA", vbCritical + vbExclamation, "ATX - AVISO"
            Call Form_KeyDown(CGTeclaF2%, 1)
          End If
         Else
          If lblNomTarjeta = "" Then
            lblTipTarjeta = ""
          Else
            VLPaso = False
          End If
         End If
         If FMRetStatusATX(VGSqlConn) <> 0 Then
           VLCambio = True
         End If
        Else
          If CInt(VTCantRegistros) = 0 Then
            VLConsultaCedula = "NO"
            MsgBox "TARJETA DE CREDITO NO EXISTE", vbCritical + vbExclamation, "MENSAJE DE SEGURIDAD"
            txtCedula = ""
            If txtCedula.Enabled Then txtCedula.SetFocus
          End If
          If CInt(VTCantRegistros) < 0 Then
            VLConsultaCedula = "NO"
            MsgBox "ESTADO DE TARJETA NO PERMITIDO. " + vbCrLf + "CONSULTAR CON SERVICIO AL CLIENTE", vbCritical + vbExclamation, "MENSAJE DE SEGURIDAD"
            txtCedula = ""
            If txtCedula.Enabled Then txtCedula.SetFocus
          End If
        End If  'fin de If CInt(VTCantRegistros) > 1 Then
      End If  'fin de If CInt(VTCantRegistros) = 1 Then
    Else
      VLConsultaCedula = "NO"
    End If
  Else
    PMChequeaATX VGSqlConn&
    PMFinTransaccion
  End If
End If  '--fin If Trim(txtCedula) <> "" Then
PMChequeaATX VGSqlConn&
PMFinTransaccion
End Sub
'PHOYOSV REF_02 FIN 02-JUL-2018

