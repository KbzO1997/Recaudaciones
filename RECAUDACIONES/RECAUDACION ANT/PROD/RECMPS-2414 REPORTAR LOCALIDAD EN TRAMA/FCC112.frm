VERSION 5.00
Object = "{0F1F1508-C40A-101B-AD04-00AA00575482}#1.0#0"; "mhrinp32.ocx"
Object = "{9AED8C43-3F39-11D1-8BB4-0000C039C248}#2.0#0"; "txtin.ocx"
Object = "{DECFDD03-1E4B-11D1-B65E-0000C039C248}#5.0#0"; "mskedit.ocx"
Begin VB.Form FCC112 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "COBRO DE COMISION"
   ClientHeight    =   3195
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5745
   KeyPreview      =   -1  'True
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3195
   ScaleWidth      =   5745
   Begin VB.TextBox txtIndicador 
      Height          =   285
      Left            =   2520
      TabIndex        =   20
      Text            =   "Text1"
      Top             =   120
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.PictureBox bitmap 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   0  'None
      Enabled         =   0   'False
      ForeColor       =   &H80000008&
      Height          =   615
      Left            =   240
      ScaleHeight     =   615
      ScaleWidth      =   855
      TabIndex        =   13
      Top             =   120
      Visible         =   0   'False
      Width           =   855
   End
   Begin VB.Frame Frame 
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
      Height          =   2745
      Left            =   120
      TabIndex        =   11
      Top             =   360
      Width           =   5550
      Begin TxtinLib.TextValid Cedula 
         Height          =   285
         Left            =   2000
         TabIndex        =   5
         Top             =   1745
         Width           =   1680
         _Version        =   65536
         _ExtentX        =   2963
         _ExtentY        =   503
         _StockProps     =   253
         Appearance      =   1
         Range           =   ""
         MaxLength       =   13
         Character       =   0
         Type            =   4
         HelpLine        =   ""
         Pendiente       =   ""
         Connection      =   0
         AsociatedLabelIndex=   0
         TableName       =   ""
         MinChar         =   0
         Error           =   0
      End
      Begin VB.CheckBox chk_con_final 
         Caption         =   "Check1"
         Height          =   195
         Left            =   3840
         TabIndex        =   6
         Top             =   1800
         Width           =   135
      End
      Begin VB.CommandButton CmdNC 
         Caption         =   "&Aceptar"
         Height          =   375
         Index           =   0
         Left            =   4400
         TabIndex        =   9
         ToolTipText     =   "Aceptar los valores ingresados"
         Top             =   750
         Width           =   975
      End
      Begin VB.CommandButton CmdNC 
         Caption         =   "&Cancelar"
         Height          =   375
         Index           =   1
         Left            =   4400
         TabIndex        =   10
         ToolTipText     =   "Cancelar el ingreso de notas de crédito"
         Top             =   1150
         Width           =   975
      End
      Begin VB.ComboBox CboTipCta 
         Enabled         =   0   'False
         Height          =   315
         Left            =   2000
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Tag             =   "CboProd"
         Top             =   1100
         Width           =   855
      End
      Begin MhinrelLib.MhRealInput Efectivo 
         Height          =   285
         Left            =   2000
         TabIndex        =   0
         Top             =   500
         Width           =   2295
         _Version        =   65536
         _ExtentX        =   4048
         _ExtentY        =   503
         _StockProps     =   77
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
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
      Begin MhinrelLib.MhRealInput Cheques 
         Height          =   285
         Left            =   2000
         TabIndex        =   1
         ToolTipText     =   "Valor en Cheques"
         Top             =   800
         Width           =   2295
         _Version        =   65536
         _ExtentX        =   4048
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
         SpinChangeReal  =   0
         AutoHScroll     =   -1  'True
         CaretColor      =   -2147483642
         DecimalPlaces   =   2
         Separator       =   -1  'True
      End
      Begin MskeditLib.MaskInBox Cta 
         Height          =   285
         Left            =   2900
         TabIndex        =   3
         Tag             =   "Cta"
         Top             =   1120
         Width           =   1385
         _Version        =   262144
         _ExtentX        =   2443
         _ExtentY        =   503
         _StockProps     =   253
         Text            =   "___-______-_"
         BorderStyle     =   1
         Enabled         =   0   'False
         Decimals        =   0
         Separator       =   -1  'True
         MaskType        =   1
         HideSelection   =   0   'False
         MaxLength       =   0
         AutoTab         =   -1  'True
         DateString      =   "___-______-_"
         FormattedText   =   ""
         Mask            =   "###-######-#"
         HelpLine        =   "Ingrese el numero de cuenta."
         ClipText        =   ""
         ClipMode        =   0
         StringIndex     =   0
         DateType        =   0
         DateSybase      =   "09/08/1997"
         AutoDecimal     =   -1  'True
         MinReal         =   -1.1e38
         MaxReal         =   3.4e38
         Units           =   0
         Errores         =   0
      End
      Begin MhinrelLib.MhRealInput Debito 
         Height          =   285
         Left            =   2000
         TabIndex        =   4
         Top             =   1450
         Width           =   2295
         _Version        =   65536
         _ExtentX        =   4048
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
         Enabled         =   0   'False
         TintColor       =   16711935
         FillColor       =   16777215
         MaxReal         =   3.4E+38
         MinReal         =   0
         SpinChangeReal  =   0
         AutoHScroll     =   -1  'True
         CaretColor      =   -2147483642
         DecimalPlaces   =   2
         Separator       =   -1  'True
      End
      Begin MhinrelLib.MhRealInput valor 
         Height          =   285
         Left            =   1995
         TabIndex        =   8
         Top             =   2375
         Width           =   2295
         _Version        =   65536
         _ExtentX        =   4048
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
         TintColor       =   16711935
         FillColor       =   16777215
         MaxReal         =   3.4E+38
         MinReal         =   0
         SpinChangeReal  =   0
         AutoHScroll     =   -1  'True
         CaretColor      =   -2147483642
         DecimalPlaces   =   2
         Separator       =   -1  'True
      End
      Begin TxtinLib.TextValid Nombre 
         Height          =   285
         Left            =   2000
         TabIndex        =   7
         ToolTipText     =   "Código de empresa (Oprima F5 Ayuda)"
         Top             =   2065
         Width           =   3465
         _Version        =   65536
         _ExtentX        =   6112
         _ExtentY        =   503
         _StockProps     =   253
         BorderStyle     =   1
         Range           =   ""
         MaxLength       =   35
         Character       =   0
         Type            =   4
         HelpLine        =   "Ingrese el tipo de causa. F5 Ayuda"
         Pendiente       =   ""
         Connection      =   0
         AsociatedLabelIndex=   0
         TableName       =   ""
         MinChar         =   0
         Error           =   0
      End
      Begin VB.Label lbl_con_final 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Consumidor Final"
         ForeColor       =   &H00800000&
         Height          =   255
         Left            =   4080
         TabIndex        =   21
         Top             =   1800
         Width           =   1215
      End
      Begin VB.Label Label2 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Nombre:"
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
         Left            =   600
         TabIndex        =   19
         Top             =   2055
         Width           =   1455
      End
      Begin VB.Label lblCedula 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Ced / R.U.C.:"
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
         Left            =   610
         TabIndex        =   18
         Top             =   1750
         Width           =   1455
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Total :"
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
         Left            =   600
         TabIndex        =   17
         Top             =   2375
         Width           =   570
      End
      Begin VB.Label lblChq 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Cheque"
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
         Left            =   600
         TabIndex        =   16
         Top             =   800
         Width           =   1300
      End
      Begin VB.Label LblCuenta 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "ND a cta:"
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
         Left            =   600
         TabIndex        =   15
         Top             =   1100
         Width           =   840
      End
      Begin VB.Label LblDebito 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Debito :"
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
         Left            =   600
         TabIndex        =   14
         Top             =   1450
         Width           =   690
      End
      Begin VB.Label lblCantidad 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Efectivo:"
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
         Left            =   600
         TabIndex        =   12
         Top             =   500
         Width           =   780
      End
   End
End
Attribute VB_Name = "FCC112"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'********************************************************************************'
'*              MODIFICACIONES                                                  *'
'* REF  FECHA       AUTOR           DESCRIPCION                                  *'
'*  5  19/Sep/2017 Vanessa Miranda  FACOFF-AP-SGC00029747-SGC00029748 Habilitar *'
'*      nombre y cedula, buscar datos del cliente en MIS-Reg Civil              *'
'*  6  18/Ene/2018 Vanessa Miranda *******************  Validar persona jurídica *'
'*     para presentación de Nombre del cliente                                  *'
'*  7  17/Dic/2017 Danny Olaya S.   RECA-CC-SGC00030521 Habilitar cobro de comision *'
'*     por débito a cuenta para las empresas MEER                               *'
'*  8  01/Mar/2018 Danny Olaya SGC00030409 Facturacion OFFLINE - Cobro de Comision Deb Cta *'
'*  9  17/Oct/2018 Danny Olaya SGC00033000 UEES *'
'*  10 11/Ago/2021 Mirelly G. - Iroute  SGC00042528: Caja Verde 2.0             *'
'********************************************************************************'

Dim VLForma As Object
Dim VLCambio As Integer
Dim VLCta As String
Dim VLTrn As String
Dim VLfirma As Boolean
Public VLUsar_ant As Currency
Public VLAcumulado_ant As Currency
Public VLTotCom As Currency
Public VLEfe_com  As Currency
Public VLChq_com As Currency
Public VLDeb_com As Currency
Public VLCta_com  As String
Public VLTipCta_com As String
Dim VLParametro As String
Dim VLMoneda As Integer 'smerino
Dim VLDescMonCta As String 'smerino
Dim VLComaux As Currency 'LBP Inicio RECA-CC-SGC00025869
Dim VlTipoCtaNem As String 'dpereirv
Dim vlCtaNem As String 'dpereirv
Dim VLCobroComDeb As String 'msilvag RECA-CC-SGC00027715
'--ref5 vmirandt inicio
Dim VLPaso1 As Boolean
Dim VLPaso2 As Boolean
Dim vtmatrizcps(2, 60) As String
'--ref5 vmirandt fin
'<Ref 10
Dim VLVerde As String
Dim VLVerif  As Double
Dim VLComauxCV As String
'Ref 10>



Private Sub CboTipCta_KeyDown(KeyCode As Integer, Shift As Integer)
    Select Case KeyCode%
    Case CGTeclaENTER%
        SendKeys "{TAB}"
    Case CGTeclaUP%, CGTeclaREPAG%
        SendKeys "+{TAB}"
    Case CGTeclaDOWN%, CGTeclaAVPAG%
        'SendKeys "{TAB}"
        Cta.SetFocus
    End Select
End Sub

Private Sub Cheques_Change()
  VLCambio% = True
End Sub

Private Sub Cheques_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Ingrese Valor en Cheque"
End Sub

Private Sub Cheques_KeyDown(KeyCode As Integer, Shift As Integer)
  Select Case KeyCode%
    Case CGTeclaSUPR%
      Cheques.Text = ""
    Case CGTeclaENTER%
      SendKeys "{TAB}"
    Case CGTeclaHOME%
      PMCambiarForma Me
    Case CGTeclaUP%, CGTeclaREPAG%
      CantChq.SetFocus
    Case CGTeclaDOWN%, CGTeclaAVPAG%
      SendKeys "{TAB}"
    End Select

End Sub

Private Sub Cheques_KeyPress(KeyAscii As Integer)
  KeyAscii = FMValidarNumero((Cheques.Text), VGLongitudMoney, KeyAscii, "15")
End Sub

Private Sub Cheques_LostFocus()
  If VGDecimales$ = "S" And (FMObtenerDecimales(FMObtenerMonedaForma("112")) > 0) Then
    Cheques.Text = str(FMCCurATX((Cheques.Text)) / FMObtenerFactorDecimal(FMObtenerMonedaForma("112")))
  End If
  valor.Text = Format(FMCCurATX((Efectivo.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((Debito.Text)), "###,###,###,##0.00")
  
'      If Me.Cheques <> 0# Then
'         Me.Cedula.Enabled = True 'smerino belcorp
'         Me.Nombre.Enabled = True 'smerino belcorp
'      End If
'If VLCambio% = True Then VLCambio% = False
'<Ref 10
If VLVerde <> "S" Then
    Call FLValidarSoloDebito '--ref5 vmirandt
End If
'Ref 10>
End Sub

Private Sub chk_con_final_Click()
    '<Ref 10
    If VLVerde <> "S" Then
        If chk_con_final.Value = 1 Then
            cedula.Text = "9999999999999"
            Nombre.Text = "CONSUMIDOR FINAL"
            Nombre.Enabled = False
        Else
            cedula.Text = ""
            Nombre.Text = ""
        End If
        VLPaso1 = False
        VLPaso2 = False
    End If
    'Ref 10>
End Sub

Private Sub CmdNC_Click(Index As Integer)
   If Cta.Text = "___-______-_" And Debito > 0 Then
    MsgBox "Ingrese el número de cuenta."
     Exit Sub
   End If
    'msilvag Inicio RECA-CC-SGC00027715
    If FCC112.Debito > 0 And FCC112.Efectivo > 0 And FCC112.Cheques > 0 Then
        MsgBox "El valor de la comisión se debe cancelar en Efectivo, cheque o con Débito a cuenta, no se permite combinar estas formas de pago."
        Exit Sub
    ElseIf FCC112.Debito > 0 And FCC112.Efectivo > 0 Then
        MsgBox "El valor de la comisión se debe cancelar en Efectivo, cheque o con Débito a cuenta, no se permite combinar estas formas de pago."
        Exit Sub
        ElseIf FCC112.Debito > 0 And FCC112.Cheques > 0 Then
            MsgBox "El valor de la comisión se debe cancelar en Efectivo, cheque o con Débito a cuenta, no se permite combinar estas formas de pago."
            Exit Sub
            ElseIf FCC112.Efectivo > 0 And FCC112.Cheques > 0 Then
                MsgBox "El valor de la comisión se debe cancelar en Efectivo, cheque o con Débito a cuenta, no se permite combinar estas formas de pago."
                Exit Sub
    End If
    
    If SGEmpresa = "118" Or SGEmpresa = "8521" Or SGEmpresa = "5994" Or SGEmpresa = "115" Then
        Consulta_parametro_comision  'validar que la cuentas debito recaudo y comision sean las mismas
        If VLCobroComDeb = "S" Then
            If FCC112.Debito > 0 And FCC51.Debito > 0 And SGNumCuenta <> FCC112.Cta.Text Then
                MsgBox "La cuenta debe ser la misma con la que realiza el pago del servicio."
                Exit Sub
            End If
        End If
    End If
    
    'msilvag Inicio RECA-CC-SGC00027895
    If SGEmpresa = "334" Then
        If FCC112.Debito > 0 And FCC51.Debito > 0 And SGNumCuenta <> FCC112.Cta.Text Then
            MsgBox "La cuenta debe ser la misma con la que realiza el pago del servicio."
            Exit Sub
        End If
    End If
    'msilvag Fin
    
    If SGEmpresa = "120" Then 'msilvag: Directv RECA-CC-SGC00027998
        If FCC112.Debito > 0 And FCC143.Debito > 0 And SGNumCuenta <> FCC112.Cta.Text Then
            MsgBox "La cuenta debe ser la misma con la que realiza el pago del servicio."
            Exit Sub
        End If
    End If
    
    'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos3
    '5479 Empresa general de CNT (Fijo y Movil)
    If SGEmpresa = "1372" Or SGEmpresa = "1373" Or SGEmpresa = "1707" Or SGEmpresa = "1708" Or SGEmpresa = "6951" _
        Or SGEmpresa = "6952" Or SGEmpresa = "5479" Or SGEmpresa = "8090" Or SGEmpresa = "5488" Or SGEmpresa = "361" _
        Or SGEmpresa = "1089" Then 'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
        
        If FCC51.Cta.ClipText <> "" Then 'SGNumCuenta <> "" Then
            If FCC112.Debito > 0 And SGNumCuenta <> FCC112.Cta.Text Then  'And FCC51.Debito > 0
                MsgBox "La cuenta debe ser la misma con la que realiza el pago del servicio."
                Exit Sub
            End If
        End If
        
    End If
    
    'EMPRESA MARGLOBAL
    If SGEmpresa = "451" Then
        If FCC51.Cta.ClipText <> "" Then 'SGNumCuenta <> "" Then
            If FCC112.Debito > 0 And SGNumCuenta <> FCC112.Cta.Text Then  'And FCC131.Debito > 0
                MsgBox "La cuenta debe ser la misma con la que realiza el pago del servicio."
                Exit Sub
            End If
        End If
    End If
    
    'EMPRESA DEPOSITOS EN LINEA
    If SGEmpresa = "DEPLINE" Then
        If FCC144.Cta.ClipText <> "" Then 'SGNumCuenta <> "" Then
            If FCC112.Debito > 0 And SGNumCuenta <> FCC112.Cta.Text Then  'And FCC131.Debito > 0
                MsgBox "La cuenta debe ser la misma con la que realiza el pago del servicio."
                Exit Sub
            End If
        End If
    End If
    
    If SGEmpresa = "2494" Then
        If FCC131.Cta.ClipText <> "" Then 'SGNumCuenta <> "" Then
            If FCC112.Debito > 0 And SGNumCuenta <> FCC112.Cta.Text Then  'And FCC131.Debito > 0
                MsgBox "La cuenta debe ser la misma con la que realiza el pago del servicio."
                Exit Sub
            End If
        End If
    End If
    
    If SGEmpresa = "6388" Or SGEmpresa = "2572" Or SGEmpresa = "18786" Then 'KBastida:Add ANT Via Rapida
        If FCC134.Cta.ClipText <> "" Then
            If FCC112.Debito > 0 And SGNumCuenta <> FCC112.Cta.Text Then 'And FCC134.Debito > 0
                MsgBox "La cuenta debe ser la misma con la que realiza el pago del servicio."
                Exit Sub
            End If
        End If
    End If
    
    'SRI Ajustes
    'SRI Matriculacion Vehicular
    If SGEmpresa = "SRIAJU" Or SGEmpresa = "SRIMATRI" Then
        If FCC78.Cta.ClipText <> "" Then
            If FCC112.Debito > 0 And SGNumCuenta <> FCC112.Cta.Text Then 'And FCC78.Debito > 0
                MsgBox "La cuenta debe ser la misma con la que realiza el pago del servicio."
                Exit Sub
            End If
        End If
    End If
    
    'SRI RISE
    If SGEmpresa = "RISE" Then
      'ref8 Ini
        If FCC135.Cta.ClipText <> "" Then
          If FCC112.Debito > 0 And SGNumCuenta <> FCC112.Cta.Text Then
            MsgBox "La cuenta debe ser la misma con la que realiza el pago del servicio."
            Exit Sub
        End If
    End If
      'ref8 Fin
    End If
    
    'SRI TRANSFERENCIA DE DOMINIO
    If SGEmpresa = "SRIDOMI" Then
        'ref8 Ini
        If FCC35.Cta.ClipText <> "" Then
          If FCC112.Debito > 0 And SGNumCuenta <> FCC112.Cta.Text Then
                MsgBox "La cuenta debe ser la misma con la que realiza el pago del servicio."
                Exit Sub
            End If
        End If
      'ref8 Fin
    End If
    'msilvag Fin
    
    If SGEmpresa = "6087" Or SGEmpresa = "1125" Then 'ref9
    'ref8 Ini
      If FCC51.Cta.ClipText <> "" Then
        If FCC112.Debito > 0 And SGNumCuenta <> FCC112.Cta.Text Then
        MsgBox "La cuenta debe ser la misma con la que realiza el pago del servicio."
        Exit Sub
      End If
    End If
      'ref8 Fin
    End If
        'DOLAYA - AMAGUA-AP-SGC00028642 INI
    If SGEmpresa = "6" Or SGEmpresa = "4" Or SGEmpresa = "360" Or SGEmpresa = "8269" Or SGEmpresa = "4994" Then 'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
        If FCC51.Cta.ClipText <> "" Then 'SGNumCuenta <> "" Then
            If FCC112.Debito > 0 And SGNumCuenta <> FCC112.Cta.Text Then  'And FCC51.Debito > 0
        MsgBox "La cuenta debe ser la misma con la que realiza el pago del servicio."
        Exit Sub
'        Else
'          SGNumCuenta = FCC112.Cta.Text
            End If
      End If
    End If
    'DOLAYA - AMAGUA-AP-SGC00028642 FIN

    'ref7 Ini
    
    If SGEmpresa = "144" Or SGEmpresa = "8453" Or SGEmpresa = "8454" Or SGEmpresa = "8462" Then
    'ref8 Ini
      If FCC51.Cta.ClipText <> "" Then
        If FCC112.Debito > 0 And SGNumCuenta <> FCC112.Cta.Text Then
        MsgBox "La cuenta debe ser la misma con la que realiza el pago del servicio."
        Exit Sub
      End If
    End If
    'ref8 Fin
    End If
    
    'ref7 Fin

        If SGEmpresa = "940" Then
        Consulta_parametro_comision  'validar que la cuentas debito recaudo y comision sean las mismas
        If VLCobroComDeb = "S" Then
            If FCC112.Debito > 0 And FCC84.Debito > 0 And SGNumCuenta <> FCC112.Cta.Text Then
                MsgBox "La cuenta debe ser la misma con la que realiza el pago del servicio."
                Exit Sub
            End If
        End If
    End If
    
    If SGEmpresa = "2234" Or SGEmpresa = "2235" Or SGEmpresa = "2236" Or SGEmpresa = "2237" Or SGEmpresa = "2319" Or SGEmpresa = "1430" Then
    'ref8 Ini
      If FCC19.Cta.ClipText <> "" Then
        If FCC112.Debito > 0 And SGNumCuenta <> FCC112.Cta.Text Then
          MsgBox "La cuenta debe ser la misma con la que realiza el pago del servicio."
          Exit Sub
        End If
      End If
      'ref8 Fin
    End If
    
    If SGEmpresa = "7749" Then
    'ref8 Ini
      If FCC19.Cta.ClipText <> "" Then
        If FCC112.Debito > 0 And SGNumCuenta <> FCC112.Cta.Text Then
          MsgBox "La cuenta debe ser la misma con la que realiza el pago del servicio."
          Exit Sub
        End If
      End If
      'ref8 Fin
    End If
    
    'validar que si la cuenta este ingresada debe tener un valor para pagar con debito a cuenta la comisión
'    If FCC112.Cta.ClipText <> "" And FCC112.Debito = 0 Then
'        MsgBox "El debito comision no puede ser cero (0)."
'        Exit Sub
'    End If
    'msilvag Fin

    Select Case Index
        Case 0
            'LBP Inicio RECA-CC-SGC00025869
            If FCC112.Debito > 0 And VGComision_original > 0 Then
                VLTotCom = VGComision_original
            Else
                If SGEmpresa = "1928" Then 'Cod. empresa de Contecon
                    VLTotCom = FCC84.Comision.Text
                Else
                    VLTotCom = valor
                End If
            End If
            'LBP Fin RECA-CC-SGC00025869
            If FLChequeos() = False Then
                Exit Sub
            End If
            FCC112.VLEfe_com = FCC112.Efectivo.Text
            FCC112.VLChq_com = FCC112.Cheques
            FCC112.VLDeb_com = FCC112.Debito
            FCC112.VLTipCta_com = FCC112.CboTipCta
            FCC112.VLCta_com = FCC112.Cta.ClipText
            If SGEmpresa = "1928" Then 'Cod. empresa de Contecon
                FCC84.Comision.Text = VLTotCom
            End If
    End Select
    SGCedula = cedula
    SGNombre = Nombre
    VGNumCuenta = ""
    Unload FCC112
    
End Sub

Private Sub Cta_Change()
 VLCambio% = True
   
  VLCta = Cta.Text
  VLfirma = False
  VLCambio% = True
   
End Sub

Private Sub Cta_GotFocus()
  FPrincipal!pnlHelpLine.Caption = Cta.HelpLine
End Sub

Private Sub Cta_KeyDown(KeyCode As Integer, Shift As Integer)
  Select Case KeyCode%
    Case CGTeclaSUPR%
      If Cta.Enabled Then
         Cta.Clear
      End If
'    Case CGTeclaENTER%
'      SendKeys "{TAB}"
    Case CGTeclaUP%, CGTeclaREPAG%
      SendKeys "+{TAB}"
      CboTipCta.SetFocus
    Case CGTeclaDOWN%, CGTeclaAVPAG%
      SendKeys "{TAB}"
  End Select

End Sub

Private Sub Cta_LostFocus()
Dim VTipoDatoCta As StructDatoCta



'    VLfirma = FMValidaFirma(VLfirma, CboTipCta.Text, Cta, "112")
'    If VLfirma = True Then
'        Debito.Enabled = True
'        Debito.SetFocus
'    End If
 'Se agrega esta condición para que si no ha ingresado
    'la cuenta este no la consulte
                    If Cta.ClipText <> "" Then
       'VLfirma = FMValidaFirma(VLfirma, CboTipCta.Text, Cta, "51", Nombre, VLMoneda, VLDescMonCta)
       VLfirma = FMValidaFirma(VLfirma, CboTipCta.Text, Cta, "112", Nombre, VLMoneda, VLDescMonCta)
       VTipoDatoCta = LoNombreCta(CboTipCta.Text, Cta.ClipText, "112")
       'Nombre.Text = "CONSUMIDOR FINAL" 'SMERINO  '--ref5  vmirandt comentado
        'Nombre.Text = VTipoDatoCta.NombreCta
       If VLfirma = False Then
          Debito.Text = ""
          Debito.Enabled = False
       Else
          Debito.Enabled = True
          Debito.SetFocus
          'Me.cedula.Text = ""
'ref5 vmirandt inicio
'        If Efectivo = 0# Then
'          Me.Cedula.Enabled = False
'          Me.Nombre.Enabled = False
'          End If
'ref5 vmirandt fin
       End If
    End If
End Sub

Private Sub Debito_Change()
  VLCambio% = True
End Sub

Private Sub Debito_GotFocus()
  FPrincipal!pnlHelpLine.Caption = "Ingrese el Valor del Debito"
End Sub

Private Sub Debito_KeyDown(KeyCode As Integer, Shift As Integer)
  Select Case KeyCode%
    Case CGTeclaSUPR%
      Debito.Text = ""
    Case CGTeclaENTER%
      SendKeys "{TAB}"
    Case CGTeclaHOME%
      PMCambiarForma Me
    Case CGTeclaUP%, CGTeclaREPAG%
         Cta.SetFocus
    Case CGTeclaDOWN%, CGTeclaAVPAG%
      SendKeys "{TAB}"
    End Select
    'TPE Activo bandera para mostrar Sumadora
    SGActivaSum = False

End Sub

Private Sub Debito_KeyPress(KeyAscii As Integer)
KeyAscii = FMValidarNumero((Debito.Text), VGLongitudMoney, KeyAscii, "104")
End Sub

Private Sub Debito_LostFocus()
  If VGDecimales$ = "S" And (FMObtenerDecimales(FMObtenerMonedaForma("112")) > 0) Then
    Debito.Text = str(FMCCurATX((Debito.Text)) / FMObtenerFactorDecimal(FMObtenerMonedaForma("112")))
  End If

valor.Text = Format(FMCCurATX((Efectivo.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((Debito.Text)), "###,###,###,##0.00")
Call FLValidarSoloDebito '--ref5 vmirandt
End Sub

Private Sub Efectivo_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "efectivo a cobrar"
        'Sumadora ----->
    If SGActivaSum = False Then
        PMIngresoEfectivo
        '<Ref 10
        If VLVerde <> "S" Then
            Efectivo.Text = Format$(SGUsar, "####,###,##0.00")
        Else
            While CCur(VLVerif) <> SGUsar
                MsgBox "El Monto Efetivo No Coincide con el Monto Desglosado para el Deposito. Verificar", vbCritical, "Mensaje del Sistema"
                PMIngresoEfectivo
                Efectivo.Text = Format$(CCur(VLVerif), "####,###,##0.00")
                SGActual = 0
           Wend
           Efectivo.Enabled = False
            If SGActivaSum = True Then
                Exit Sub
            End If
           SGActivaSum = False
        End If
        'Ref 10>
        SGActual = 0
    Else
        SGActivaSum = False
    End If
    '<-------
End Sub

Private Sub Form_Activate()
    'TPE05/16/2006 Al Activar la forma debe colocar sumadora en Moneda de la forma
    If SGMonedaTran <> VGmoneda% _
    And VGmoneda% <> 0 Then
        SGMonedaTran = VGmoneda%
        PMCargaIniSumadora VGmoneda%
        PMIniciaIngreso 1
    End If
    
    If VGTipoEjecucion% <> CGReverso% _
    And CCur(Efectivo.Text) <> 0 _
    And VGTran = "03" Then
        SGUsar = Efectivo.Text
    End If
    VGTran = 0
    
End Sub



Sub Form_Load()

    'Sumadora  ----->
'    SGUsar = 0
    SGActivaSum = False
    SGActual = 0
    '<-----

    VLEfe_com = 0
    VLChq_com = 0
    VLDeb_com = 0
    VLTipCta_com = ""
    VLCta_com = ""
              
    '-- PS 23/01/2004
    VLTotCom = SGComision ' antes FCC15.Comision, se cambio porque tambien es usada por otras formas
    'LBP Inicio RECA-CC-SGC00025869
    If VGComision_original <> SGComision Then
        VLComaux = SGComision
    End If
    'LBP Fin RECA-CC-SGC00025869
    valor = SGComision ' antes FCC15.Comision, se cambio porque tambien es usada por otras formas
       
    '-- PS 29/01/2004
    cedula = SGCedula
    'ref5 vmirandt inicio
    cedula.Text = "" ' "9999999999999" 'smerino
    Nombre.Text = "" ' "CONSUMIDOR FINAL" 'SMERINO
    'ref5 vmirandt fin
    Cta.Clear
    If Trim(VGNumCuenta) = "" Then
        VGNumCuenta = "___-______-_"
    End If
    If Trim(SGEmpresa) = 1928 And Trim(VGNumCuenta) <> "___-______-_" Then
        Cta.Text = VGNumCuenta
        Debito.Enabled = True

    Else
        Cta.Text = Format(VLCta_com, "000-000000-0")
    End If

    'jrocafuf
    If Trim(SGEmpresa) = 8461 Then
        Cta.Text = SGNumCuenta
        Debito.Enabled = True
    End If
    'jrocafuf
    
    VLCambio% = False
    'Me.Move VGLeft%, VGTop%, 6105, 2670
    Me.Move 100, 1000
    Efectivo.DecimalPlaces = FMObtenerDecimales(VGmoneda%)
    CboTipCta.AddItem "CTE"
    CboTipCta.AddItem "AHO"
    CboTipCta.ListIndex = SGTipoCta 'caso anterior FCC15.CboTipCta.ListIndex
    
    'msilvag Inicio RECA-CC-SGC00027715
    If SGEmpresa = "118" Or SGEmpresa = "8521" Or SGEmpresa = "5994" Or SGEmpresa = "115" Or SGEmpresa = "940" Or SGEmpresa = "361" Then 'msilvag Recaudacion
        Consulta_parametro_comision
        If VLCobroComDeb = "S" Then
        'If SGEmpresa = "118" Or SGEmpresa = "5994" Or SGEmpresa = "8521" Then
            Me.Cta.Text = SGNumCuenta
            Me.Cta.Enabled = True
            Me.Debito.Enabled = True
            Me.CboTipCta.Enabled = True
            
              
            If VLComaux <> VGComision_original And VGCompensacion > 0 Then
                MsgBox "Recordar que Valor de la Comision en Ofi. Damnificada en Efectivo/Cheque sera de " & VLComaux & " y en Debito sera de " & VGComision_original, vbInformation
                VLTotCom = VGComision_original
            End If
            'Cheques.Enabled = False
        End If
    End If
    'msilvag Fin
    
    
    'msilvag Fin RECA-CC-SGC00027895
    If SGEmpresa = "334" Or SGEmpresa = "120" Or SGEmpresa = "2494" Or SGEmpresa = "1372" Or SGEmpresa = "1373" Or SGEmpresa = "1707" Or SGEmpresa = "1708" Or SGEmpresa = "6951" _
        Or SGEmpresa = "6952" Or SGEmpresa = "5479" Or SGEmpresa = "8090" Or SGEmpresa = "2572" Or SGEmpresa = "6388" Or SGEmpresa = "8090" Or SGEmpresa = "5488" Or SGEmpresa = "361" _
        Or SGEmpresa = "1089" _
        Or SGEmpresa = "18786" _
        Or SGEmpresa = "21980" Then 'msilvag:Inicio Directv RECA-CC-SGC00027998 KBastida:Add ANT Ecuanet Via Rapida
        Me.Cta.Text = SGNumCuenta
        Me.Cta.Enabled = True
        Me.Debito.Enabled = True
        Me.CboTipCta.Enabled = True
    
        If VLComaux <> VGComision_original And VGCompensacion > 0 Then
            MsgBox "Recordar que Valor de la Comision en Ofi. Damnificada en Efectivo/Cheque sera de " & VLComaux & " y en Debito sera de " & VGComision_original, vbInformation
            VLTotCom = VGComision_original
        End If
    End If
    'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos

    'EMPRESA MARGLOBAL
    If SGEmpresa = "451" Or SGEmpresa = "DEPLINE" Then
        Me.Cta.Text = SGNumCuenta
        Me.Cta.Enabled = True
        Me.Debito.Enabled = True
        Me.CboTipCta.Enabled = True
    
        If VLComaux <> VGComision_original And VGCompensacion > 0 Then
            MsgBox "Recordar que Valor de la Comision en Ofi. Damnificada en Efectivo/Cheque sera de " & VLComaux & " y en Debito sera de " & VGComision_original, vbInformation
            VLTotCom = VGComision_original
        End If
    End If
    
    If SGEmpresa = "2494" Then
        Me.Cta.Text = SGNumCuenta
        Me.Cta.Enabled = True
        Me.Debito.Enabled = True
        Me.CboTipCta.Enabled = True
    
        If VLComaux <> VGComision_original And VGCompensacion > 0 Then
            MsgBox "Recordar que Valor de la Comision en Ofi. Damnificada en Efectivo/Cheque sera de " & VLComaux & " y en Debito sera de " & VGComision_original, vbInformation
            VLTotCom = VGComision_original
        End If
    End If
    
    'SRI AJUSTES
    'SRI MATRICULACION VEHICULAR
    If SGEmpresa = "SRIAJU" Or SGEmpresa = "SRIMATRI" Or SGEmpresa = "RISE" Or SGEmpresa = "SRIDOMI" Then
        Me.Cta.Text = SGNumCuenta
        Me.Cta.Enabled = True
        Me.Debito.Enabled = True
        Me.CboTipCta.Enabled = True
    
        If VLComaux <> VGComision_original And VGCompensacion > 0 Then
            MsgBox "Recordar que Valor de la Comision en Ofi. Damnificada en Efectivo/Cheque sera de " & VLComaux & " y en Debito sera de " & VGComision_original, vbInformation
            VLTotCom = VGComision_original
        End If
    End If
    
    'msilvag Fin
    
        'smerino belcorp
            If SGEmpresa = "7256" Then  'smerino belcorp
                'LBP Inicio RECA-CC-SGC00025869
                If VLComaux <> VGComision_original And VGCompensacion > 0 Then
                    MsgBox "Recordar que Valor de la Comision en Ofi. Damnificada en Efectivo/Cheque sera de " & VLComaux & " y en Debito sera de " & VGComision_original, vbInformation
                    VLTotCom = VGComision_original
    '                valor.Text = VGComision_original
                End If
                'LBP Fin RECA-CC-SGC00025869
              Cta.Enabled = True
              CboTipCta.Enabled = True
              Cheques.Enabled = False
              
            End If
         'fin smerino belcorp
    
    'msilvag Inicio DEPTEM-AP-SGC00025705-SGC00025710
    If SGEmpresa = "1928" Then 'Cod. empresa de Contecon
        If VLComaux <> VGComision_original And VGCompensacion > 0 Then
            MsgBox "Recordar que Valor de la Comision en Ofi. Damnificada en Efectivo/Cheque sera de " & VLComaux & " y en Debito sera de " & VGComision_original, vbInformation
            VLTotCom = VGComision_original
        End If
        Me.Cta.Enabled = True
        Me.CboTipCta.Enabled = True
        'Me.Cheques.Enabled = False
    End If
    'msilvag Fin
    
    'dolayas Inicio RECA-CC-SGC00029665 ref9
    If SGEmpresa = "6087" Or SGEmpresa = "1125" Then
        If VLComaux <> VGComision_original And VGCompensacion > 0 Then
            MsgBox "Recordar que Valor de la Comision en Ofi. Damnificada en Efectivo/Cheque sera de " & VLComaux & " y en Debito sera de " & VGComision_original, vbInformation
            VLTotCom = VGComision_original
        End If
        Me.Cta.Text = SGNumCuenta
        Me.Cta.Enabled = True
        Me.Debito.Enabled = True
        Me.CboTipCta.Enabled = True
    End If
    'dolayas Fin

        'ref6 Ini
    If SGEmpresa = "144" Or SGEmpresa = "8453" Or SGEmpresa = "8454" Or SGEmpresa = "8462" Then
        If VLComaux <> VGComision_original And VGCompensacion > 0 Then
            MsgBox "Recordar que Valor de la Comision en Ofi. Damnificada en Efectivo/Cheque sera de " & VLComaux & " y en Debito sera de " & VGComision_original, vbInformation
            VLTotCom = VGComision_original
        End If
        Me.Cta.Text = SGNumCuenta
        Me.Cta.Enabled = True
        Me.Debito.Enabled = True
        Me.CboTipCta.Enabled = True
    End If
    'ref6 Fin
    
    'dolayas - AMAGUA-AP-SGC00028642 INI
    If SGEmpresa = "6" Or SGEmpresa = "4" Or SGEmpresa = "360" Or SGEmpresa = "8269" Or SGEmpresa = "4994" Then 'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
        If VLComaux <> VGComision_original And VGCompensacion > 0 Then
            MsgBox "Recordar que Valor de la Comision en Ofi. Damnificada en Efectivo/Cheque sera de " & VLComaux & " y en Debito sera de " & VGComision_original, vbInformation
            VLTotCom = VGComision_original
        End If
        Me.Cta.Text = SGNumCuenta
        Me.Cta.Enabled = True
        Me.Debito.Enabled = True
        Me.CboTipCta.Enabled = True
    End If
    'dolayas - AMAGUA-AP-SGC00028642 FIN
    
    'ref8 Ini
    If SGEmpresa = "2234" Or SGEmpresa = "2235" Or SGEmpresa = "2236" Or SGEmpresa = "2237" Or SGEmpresa = "2319" Or SGEmpresa = "1430" Then
        If VLComaux <> VGComision_original And VGCompensacion > 0 Then
            MsgBox "Recordar que Valor de la Comision en Ofi. Damnificada en Efectivo/Cheque sera de " & VLComaux & " y en Debito sera de " & VGComision_original, vbInformation
            VLTotCom = VGComision_original
        End If
        Me.Cta.Text = SGNumCuenta
        Me.Cta.Enabled = True
        Me.Debito.Enabled = True
        Me.CboTipCta.Enabled = True
    End If
    'ref8 Fin
    
    'ref8 Ini
    If SGEmpresa = "7749" Then
        If VLComaux <> VGComision_original And VGCompensacion > 0 Then
            MsgBox "Recordar que Valor de la Comision en Ofi. Damnificada en Efectivo/Cheque sera de " & VLComaux & " y en Debito sera de " & VGComision_original, vbInformation
            VLTotCom = VGComision_original
        End If
        Me.Cta.Text = SGNumCuenta
        Me.Cta.Enabled = True
        Me.Debito.Enabled = True
        Me.CboTipCta.Enabled = True
    End If
    'ref8 Fin
    
    'ref8 Ini
    If SGEmpresa = "1417" Then
        If VLComaux <> VGComision_original And VGCompensacion > 0 Then
            MsgBox "Recordar que Valor de la Comision en Ofi. Damnificada en Efectivo/Cheque sera de " & VLComaux & " y en Debito sera de " & VGComision_original, vbInformation
            VLTotCom = VGComision_original
        End If
        Me.Cta.Text = SGNumCuenta
        Me.Cta.Enabled = True
        Me.Debito.Enabled = True
        Me.CboTipCta.Enabled = True
    End If
    'ref8 Fin
    

    'ref8 Ini
    If SGEmpresa = "EDU" Then
        If VLComaux <> VGComision_original And VGCompensacion > 0 Then
            MsgBox "Recordar que Valor de la Comision en Ofi. Damnificada en Efectivo/Cheque sera de " & VLComaux & " y en Debito sera de " & VGComision_original, vbInformation
            VLTotCom = VGComision_original
        End If
        Me.Cta.Text = SGNumCuenta
        Me.Cta.Enabled = True
        Me.Debito.Enabled = True
        Me.CboTipCta.Enabled = True
    End If
    'ref8 Fin
    
    'ref8 Ini
    If SGEmpresa = "SRICEP" Then
        If VLComaux <> VGComision_original And VGCompensacion > 0 Then
            MsgBox "Recordar que Valor de la Comision en Ofi. Damnificada en Efectivo/Cheque sera de " & VLComaux & " y en Debito sera de " & VGComision_original, vbInformation
            VLTotCom = VGComision_original
        End If
        Me.Cta.Text = SGNumCuenta
        Me.Cta.Enabled = True
        Me.Debito.Enabled = True
        Me.CboTipCta.Enabled = True
    End If
    'ref8 Fin
    
    If VGmoneda% = 0 Then
       bitmap.Picture = LoadPicture(VGDirBitmaps$ & "\sucres.bmp")
       Frame = Space(20) & "COMISION SUCRES"
    Else
       bitmap.Picture = LoadPicture(VGDirBitmaps$ & "\dolares.bmp")
       Frame = Space(20) & "COMISION DOLARES"
    End If
    bitmap.Visible = True
    'Adiconado por Reverso
    If VGTipoEjecucion% = CGReverso% Or VGTipoEjecucion% = CGAutoriza% Then
        If VGTipoEjecucion% = CGReverso% Then
            PMSetValorReverso Efectivo, "@i_efe"
        End If
    End If
    'JPM efectuar subclass a la forma (no es llamada desde PMShowForma)
    SubClassForm Me 'RCA 02/10/2005

'ref5 vmirandt comentado inicio debe estar habilitado el ingreso de la cedula
'    PLObtenerParametro
'    If VLParametro = "S" Then
'        Cedula.Enabled = False
'        Nombre.Enabled = False
'    End If
'ref5 vmirandt comentado fin
    VLPaso1 = True
    Nombre.Enabled = False
    
    '<Ref 10
    VLVerde = ""
    VLVerif = 0
    VLComauxCV = "0.00"
    'Ref 10>
End Sub

'msilvag Inicio RECA-CC-SGC00027715
Private Sub Consulta_parametro_comision()
    
    If VGTipoEjecucion% = CGReverso% Then
        VGTipoEjecucion% = CGNormal%
        PMChequeaATX VGSqlConn&
        PMInicioTransaccion
        PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "cl_comision_empresa", "", ""
        PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR, "V", "", ""
        PMPasoValoresATX VGSqlConn&, "@i_codigo", 0, SQLVARCHAR, (SGEmpresa), "", ""
        If FMTransmitirRPCATX(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "", "N", "S", "I", "0", "N", "N") Then
            PMMapeaObjetoATX VGSqlConn&, txtIndicador
            VLCobroComDeb = txtIndicador
        End If
        PMChequeaATX VGSqlConn&
        PMFinTransaccion
        VGTipoEjecucion% = CGReverso%
    Else
        PMInicioTransaccion
        PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "cl_comision_empresa", "", ""
        PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR, "V", "", ""
        PMPasoValoresATX VGSqlConn&, "@i_codigo", 0, SQLVARCHAR, (SGEmpresa), "", ""
        If FMTransmitirRPCATX(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "", "N", "S", "I", "0", "N", "N") Then
            PMMapeaObjetoATX VGSqlConn&, txtIndicador
            VLCobroComDeb = txtIndicador
        End If
        PMChequeaATX VGSqlConn&
        PMFinTransaccion
    End If
    
End Sub
'msilvag Fin

Sub Form_Unload(Cancel As Integer)
'    VGUsar15 = VGUsar15 + Efectivo.ValueReal
    'JPM eliminar subclass a la forma (no es llamada desde PMShowForma)
    UnSubClassForm Me 'RCA 02/10/2005
End Sub
 
Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    If Shift = CGTeclaCTRL% And KeyCode% = CGTeclaI% Then
        PMReimpresion
        Exit Sub
    End If
    Select Case KeyCode%
    Case CGTeclaSUPR%
        If VGTipoEjecucion% = CGReverso% Then
            VGReversoLoger = "S"
          '  PLTransmitir
            VGReversoLoger = "N"
            SGAcumRev = 0
            Unload Me
        End If
    Case CGTeclaESC%
        'TPE variable para validacion de Cod Cuenta
        VLCta = ""
        Unload Me
'    Case CGTeclaHOME%
'        PMCambiarForma Me
        
    Case CGTeclaF2%
        If Efectivo.Enabled Then
            Efectivo.SetFocus
        End If
        Efectivo.Text = "0.00"
        Cheques.Text = "0.00"
        Cta.Clear
        Cta.Text = Format(VLCta_com, "000-000000-0")
        Debito.Text = "0.00"
        cedula.Text = ""
'        '------> Sumadora
'        If Shift = 0 _
'        And VGTipoConsAutom% = 0 _
'        And VGTipoEjecucion% <> CGReverso% Then 'Adiciono Validacion Por Consulta Automatica y Reverso
'            SGActual = 1
'            SGUsar = 0
''            FSumIng.Hide
'            FSumIng.Form_KeyDown CGTeclaF2%, 0
'            Efectivo.SetFocus
'            Unload FSumIng
'        End If
'        SGActivaSum = False
'        SGActual = 0
        '<------
    Case CGTeclaF3%
        'Sumadora ------>
        If VGTipoEjecucion% <> CGReverso% Then
            PMIngresoEfectivo
            If val(Efectivo.Text) <> val(SGUsar) Then
               Efectivo.Text = Format$(SGUsar, "####,###,##0.00")
               SendKeys "{TAB}"
            End If
            SGActivaSum = True
        End If
        '<------
    End Select
End Sub
 
Sub Efectivo_KeyPress(KeyAscii As Integer)
  KeyAscii = FMValidarNumero((Efectivo.Text), VGLongitudMoney, KeyAscii, "11")   'RCO 04/99
End Sub
Sub Efectivo_KeyDown(KeyCode As Integer, Shift As Integer)
  Select Case KeyCode%
    Case CGTeclaSUPR%
      Efectivo.Text = ""
    Case CGTeclaENTER%
      SendKeys "{TAB}"
    Case CGTeclaHOME%
      PMCambiarForma Me
    Case CGTeclaDOWN%, CGTeclaAVPAG%
      SendKeys "{TAB}"
    End Select
End Sub
Sub Efectivo_LostFocus()
'ref5 vmirandt comentado inicio
'       If Efectivo = 0# Then
'          Me.Cedula.Enabled = False
'          Me.Nombre.Enabled = False
'         Else
'         Me.Cedula.Enabled = True 'smerino belcorp
'         Me.Nombre.Enabled = True 'smerino belcorp
'      End If
'If VLCambio% = True Then VLCambio% = False
'ref5 vmirandt comentado fin
Call FLValidarSoloDebito '--ref5 vmirandt
'ref vmirandt fin

    'EAS
    If SGActivaSum = True Then
        Exit Sub
    End If
    'Sumadora ------>
    
    If CDbl(Efectivo.Text) <> SGUsar Then
        MsgBox "El Monto Efetivo No Coincide con el Monto Desglosado para el Deposito. Verificar", vbCritical, "Mensaje del Sistema"
        PMIngresoEfectivo
        Efectivo.Text = Format$(SGUsar, "####,###,##0.00")
        SGActual = 0
    End If
        
    '<------

    If VGDecimales$ = "S" And (FMObtenerDecimales(FMObtenerMonedaForma("112")) > 0) Then
        Efectivo.Text = str(FMCCurATX((Efectivo.Text)) / FMObtenerFactorDecimal(FMObtenerMonedaForma("112")))
    End If
End Sub
Function FLChequeos() As Integer
    FLChequeos = True
    
    If valor <> 0# Then
        If Trim(cedula) = "" Then
        'If Trim(Cedula) = "" Or Trim(Cedula) = "_____________" Then
            MsgBox "El campo de Cédula/RUC es mandatorio"
            If cedula.Enabled Then
               cedula.SetFocus
            End If
            FLChequeos = False
            Exit Function
        End If
 
 'ref5 vmirandt comentado inicio
'        If Trim(Cedula) <> "9999999999999" Then   'smerino
'          If FMValidaCedulaRuc(Cedula) = False Then
'             FLChequeos = False
'             Exit Function
'          End If
'        End If 'smerino
'ref5 vmirandt comentado fin

'   If SGValida = "S" Then '--ref5 vmirandt se comenta
        If Trim(Nombre) = "" Then
                MsgBox "El campo Nombre es mandatorio"
                If Nombre.Enabled Then
                   Nombre.SetFocus
                End If
                FLChequeos = False
                Exit Function
        End If
  '  End If

    End If
    '<Ref 10
    If VLVerde <> "S" Then
        valor.Text = Format(FMCCurATX((Efectivo.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((Debito.Text)), "###,###,###,##0.00")
    Else
        valor.Text = Format(FMCCurATX((VLComauxCV)) + FMCCurATX((Cheques.Text)) + FMCCurATX((Debito.Text)), "###,###,###,##0.00")
    End If
    'Ref 10>
    
    
     
    If FMCCurATX((Debito.Text)) <> 0# And FMCCurATX((Efectivo.Text)) <> 0# Then 'smerino belcorp
      MsgBox " El valor de la Comisión se debe cancelar en efectivo o Débito a Cuenta, no se permite forma de pago combinada"
      'valor.Text = 0
      Efectivo.SetFocus
      FLChequeos = False
      Exit Function
     End If
     
     If FMCCurATX((Debito.Text)) <> 0# And FMCCurATX((Me.Cheques.Text)) <> 0# Then 'dpereirv Deposito Temporal
      MsgBox " El valor de la Comisión se debe cancelar en cheque o Débito a Cuenta, no se permite forma de pago combinada"
      'valor.Text = 0
      Cheques.SetFocus
      FLChequeos = False
      Exit Function
     End If
     
     If FMCCurATX((Efectivo.Text)) <> 0# And FMCCurATX((Cheques.Text)) <> 0# Then 'dpereirv
      MsgBox " El valor de la Comisión se debe cancelar en efectivo o cheque, no se permite forma de pago combinada"
      'valor.Text = 0
      Efectivo.SetFocus
      FLChequeos = False
      Exit Function
     End If
     
    If Format(VLTotCom, "###,###,###,##0.00") <> Format(FMCCurATX((Debito.Text)) + FMCCurATX((Efectivo.Text)) + FMCCurATX((Cheques.Text)), "###,###,###,##0.00") Then
      MsgBox " El valor de la Comision no cuadra con el campo Total"
      'valor.Text = 0
      '<Ref 10
      If VLVerde <> "S" Then
        Efectivo.SetFocus
      End If
      'Ref 10>
      FLChequeos = False
      Exit Function
    End If
    
    
    If SGEmpresa = "1928" Then   'Deposito Temporal
        VlTipoCtaNem = ""
        vlCtaNem = ""
        If FCC84.Cta.Text <> "___-______-_" And Cta.Text <> "___-______-_" Then
            VlTipoCtaNem = FCC84.CboTipCta.Text
            vlCtaNem = FCC84.Cta.Text
            If Trim(vlCtaNem) <> Trim(Cta.Text) Then
                MsgBox "La cuenta debe ser la misma con la que realiza el pago del servicio"
                FLChequeos = False
                Exit Function
            End If
        End If
    End If
    If SGEmpresa = "361" Then  'Interagua
        If SGNumCuenta <> "___-______-_" And Cta.Text <> "___-______-_" Then
            If Trim(SGNumCuenta) <> Trim(Cta.Text) Then
                MsgBox "La cuenta debe ser la misma con la que realiza el pago del servicio"
                FLChequeos = False
                Exit Function
            End If
        End If
        
        If Cta.Text = "___-______-_" And Debito.Text > 0 Then
            MsgBox "Debe ingresar número de cuenta"
            FLChequeos = False
            Exit Function
        End If
    End If
  
End Function

Sub Efectivo_Change()
  VLCambio% = True
End Sub

Private Sub nombre_Change()
VLPaso2 = True
End Sub

Private Sub nombre_GotFocus()
FPrincipal!pnlHelpLine.Caption = "Ingrese Nombre"
End Sub
Private Sub nombre_KeyPress(KeyAscii As Integer)
    '<Ref 10
    If VLVerde <> "S" Then
        If Me.chk_con_final = 1 Then
            Me.chk_con_final = 0
        End If
    End If
    'Ref 10>
End Sub
Private Sub cedula_Change()
  VLPaso1 = True
End Sub

Private Sub Cedula_GotFocus()
FPrincipal!pnlHelpLine.Caption = "Ingrese Cèdula/R.U.C."
End Sub

Private Sub cedula_KeyPress(KeyAscii As Integer)
    '<Ref 10
    If VLVerde <> "S" Then
        If (KeyAscii >= 48 And KeyAscii <= 57) Or KeyAscii = 13 Or KeyAscii = 8 Or _
            (KeyAscii >= 65 And KeyAscii <= 90) Then
            ' numeros-letras y suprimir
        Else
            KeyAscii = 0
        End If
        chk_con_final = 0
    End If
    'Ref 10>
End Sub

Private Sub Cedula_LostFocus()
    '<Ref 10
    If VLVerde <> "S" Then
        Call PLBucarCliente
    End If
    'Ref 10>
End Sub

Private Sub Nombre_LostFocus()
    '<Ref 10
    If VLVerde <> "S" Then
        If cedula.Text = "" Then
            Nombre.Text = ""
            Nombre.Enabled = False
        End If
    End If
    'Ref 10>
End Sub

Private Sub Valor_GotFocus()
  FPrincipal!pnlHelpLine.Caption = "Ingrese el Valor Total de la Comision"
End Sub

Private Sub valor_KeyDown(KeyCode As Integer, Shift As Integer)
  Select Case KeyCode%
    Case CGTeclaSUPR%
      valor.Text = ""
    Case CGTeclaENTER%
      SendKeys "{TAB}"
    Case CGTeclaHOME%
      PMCambiarForma Me
    Case CGTeclaDOWN%, CGTeclaAVPAG%
      SendKeys "{TAB}"
    End Select
End Sub

Private Sub valor_KeyPress(KeyAscii As Integer)
KeyAscii = 0
End Sub

Private Sub PLObtenerParametro()
    'Consulta parametro para utilizar habilitar los campos de cedula y nombre
   
    ReDim VTArreglo(30) As String
    VLParametro = ""
    PMChequea VGSqlConn&
    PMPasoValores VGSqlConn, "@t_trn", 0, SQLINT2, 1579
    PMPasoValores VGSqlConn&, "@i_operacion", 0, SQLVARCHAR, "Q"
    PMPasoValores VGSqlConn&, "@i_nemonico", 0, SQLVARCHAR, "BQPCOM"
    PMPasoValores VGSqlConn&, "@i_producto", 0, SQLVARCHAR, "CTE"
    If FMTransmitirRPC(VGSqlConn, "", "cobis", "sp_parametro", True, "Transaccion Ok") = True Then
        VTR1% = FMMapeaArreglo(VGSqlConn&, VTArreglo())
        VLParametro = LTrim(RTrim(Trim(VTArreglo(4))))
    End If
    PMChequea VGSqlConn&

End Sub

Private Sub PLBucarCliente()
Dim vl_subtipo As String
vl_subtipo = "P"
   Dim vtr As Integer
   Dim vtrNombre As Integer
   '<Ref 10
   If VLVerde <> "S" Then
        If cedula.Text = "9999999999999" Or cedula.Text = "9999999999" Then
            cedula.Text = "9999999999999"
            Me.chk_con_final = 1
            Exit Sub
        End If
  End If
  'Ref 10>
If Trim$(cedula.Text) <> "" Then
   If FPrincipal!pnlStatusLine.Caption <> "OFF LINE" And VGOnLine% = True Then
      If VLPaso1 = True Then
            VLPaso1 = False
            Nombre.Text = ""
            ReDim VTArreglo(15) As String
            If Len(cedula.Text) > 10 Then vl_subtipo = "C"
            '*************Cedula/RUC inicio
            PMInicioTransaccion
            PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, "1182", "trn", ""
            PMPasoValoresATX VGSqlConn, "@i_subtipo", 0, SQLCHAR, vl_subtipo, "subtipo", ""
            PMPasoValoresATX VGSqlConn, "@i_tipo", 0, SQLINT1, "2", "tipo", ""
            PMPasoValoresATX VGSqlConn, "@i_modo", 0, SQLINT1, "0", "modo", ""
            PMPasoValoresATX VGSqlConn, "@i_valor", 0, SQLVARCHAR, Trim$(cedula.Text), "valor", ""
            If FMTransmitirRPCATX(VGSqlConn, "", "cobis", "sp_se_ente", True, "Búsqueda de Clientes", "N", "N", "N", "0", "S", "N") = True Then
               vtr = FMMapeaArreglo(VGSqlConn, VTArreglo())
               If vtr% > 0 Then
                   '***ref6 inicio
                   If vl_subtipo = "P" Then
                      Nombre.Text = VTArreglo(2) + " " + VTArreglo(3) + " " + VTArreglo(4)
                   Else
                      Nombre.Text = VTArreglo(2)
                   End If
                   '***ref6 fin
                   Nombre.Enabled = True
               Else
                   Nombre.Text = ""
               End If
              
               PMChequeaATX VGSqlConn
            Else
               PMChequeaATX VGSqlConn
            End If
            PMFinTransaccion
           '*************Cedula/RUC fin
           '*************Pasaporte inicio
           If Nombre.Text = "" Then
               PMInicioTransaccion
               PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, "1182", "trn", ""
               PMPasoValoresATX VGSqlConn, "@i_subtipo", 0, SQLCHAR, "P", "subtipo", ""
               PMPasoValoresATX VGSqlConn, "@i_tipo", 0, SQLINT1, "3", "tipo", ""
               PMPasoValoresATX VGSqlConn, "@i_modo", 0, SQLINT1, "0", "modo", ""
               PMPasoValoresATX VGSqlConn, "@i_valor", 0, SQLVARCHAR, Trim$(cedula.Text), "valor", ""
               If FMTransmitirRPCATX(VGSqlConn, "", "cobis", "sp_se_ente", True, "Búsqueda de Clientes", "N", "N", "N", "0", "S", "N") = True Then
                  vtr = FMMapeaArreglo(VGSqlConn, VTArreglo())
                  If vtr% > 0 Then
                     Nombre.Text = VTArreglo(2) + " " + VTArreglo(3) + " " + VTArreglo(4)
                     Nombre.Enabled = True
                  Else
                     Nombre.Text = ""
                  End If
                     PMChequeaATX VGSqlConn
                    
               Else
                  PMChequeaATX VGSqlConn
               End If
               PMFinTransaccion
           End If
           '*************Pasaporte fin
           '*************Obtener nombre de base de personas inicio
              If Nombre.Text = "" Then
                 Dim VLarreglo(30) As String
                 Dim VLarregloNombre(30) As String
                 Dim VLIndicador As String
                 PMInicioTransaccion
                 PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, "1579", "", ""
                 PMPasoValoresATX VGSqlConn, "@i_operacion", 0, SQLVARCHAR, "Q", "", ""
                 PMPasoValoresATX VGSqlConn, "@i_nemonico", 0, SQLVARCHAR, "IDCSP", "", ""
                 PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLVARCHAR, "CTE", "", ""
                 If FMTransmitirRPCATX(VGSqlConn&, ServerName$, "cobis", "sp_parametro", True, " Consulta parametro", "N", "N", "N", "0", "N", "N") Then
                    vtr = FMMapeaArregloATX(VGSqlConn, VLarreglo())
                    VLIndicador = LTrim(RTrim(Trim(VLarreglo(4))))
                 Else
                    VLIndicador = ""
                 End If
                 PMChequeaATX VGSqlConn
                 PMFinTransaccion
                 '--FPrincipal.Map.PMMapConfig "SHOWMESSAGE"
                 If VLIndicador = "S" And Nombre.Text = "" Then
'-- GYC 2019/Ene/07     Ya no utilizar servicio de BUS sino llamar a sp de Sybase
'                   PMInicioTransaccion
'                   PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, "62667", "Trn", ""
'                   PMPasoValoresATX VGSqlConn, "@i_cedula", 0, SQLVARCHAR, Trim$(cedula.Text), "Cedula", ""
'                   PMPasoValoresATX VGSqlConn, "@o_nombre", 1, SQLVARCHAR, "", "nombre", ""
'                   If FMTransmitirRPCATX(VGSqlConn, "BBTSSRV", "cob_procesador", "fp_consulta_persona", True, "Transaccion Ok", "N", "N", "N", "0", "S", "N") = True Then
'                     VTResult% = FMMapeaMatrizATX(VGSqlConn&, vtmatrizcps())
'                     Nombre.Text = FLBuscarItem("@o_nombre")
'-- GYC 2019/Ene/07     Ya no utilizar servicio de BUS sino llamar a sp de Sybase

                   PMInicioTransaccion
                   PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, "43161", "Trn", ""
                   PMPasoValoresATX VGSqlConn, "@e_identificacion", 0, SQLVARCHAR, Trim$(cedula.Text), "Cedula", ""
                   PMPasoValoresATX VGSqlConn, "@s_nombre", 1, SQLVARCHAR, "", "nombre", ""
                   PMPasoValoresATX VGSqlConn, "@s_codigo_error", 1, SQLINT4, "", "", ""
                   PMPasoValoresATX VGSqlConn, "@s_mensaje_error", 1, SQLVARCHAR, "", "", ""
                      
                   If FMTransmitirRPCATX(VGSqlConn, "", "cob_cuentas", "pa_cte_cregistro_civil", True, "Transaccion Ok", "N", "N", "N", "0", "S", "N") = True Then
                     vtrNombre = FMMapeaArreglo(VGSqlConn, VLarregloNombre())
                     Nombre = LTrim(RTrim(Trim(VLarregloNombre(1))))
                     Nombre.Enabled = True
                     PMChequeaATX VGSqlConn
                   Else
                     PMChequeaATX VGSqlConn
                   End If
                     PMFinTransaccion
                 End If
                 FMInitMap FPrincipal!pnlHelpLine, FPrincipal!pnlTransaccionLine, FPrincipal!Focos(0), FPrincipal!Focos(1), FPrincipal!Focos(2), FPrincipal!Focos(3), VGLogTransacciones$
              End If
             '*********Obtener nombre de base de personas fin
         
         If Nombre.Text = "" Then
           MsgBox ("Cliente no encontrado, digite su nombre manualmente")
           Nombre.Enabled = True
           Nombre.SetFocus
           Exit Sub
         End If
      End If '--VLPaso1
   End If
End If
End Sub
'--ref5 vmirandt inicio
Function FLBuscarItem(VLELemento As String) As String
Dim i As Integer
Dim hallado As Boolean
i = 1
hallado = False
Do While i < 33 And Not hallado
    If vtmatrizcps(0, i) = Trim$(VLELemento) Then
        hallado = True
    Else
        i = i + 1
    End If
Loop
If hallado Then
    FLBuscarItem = vtmatrizcps(1, i)
Else
    FLBuscarItem = ""
End If
End Function
'--ref5 vmirandt fin

'--ref5 vmirandt inicio
Sub FLValidarSoloDebito()
  If VLCambio% = True Then
    If Debito.Text > 0 And Cheques.Text = 0 And Efectivo.Text = 0 Then
        '<Ref 10
        If VLVerde <> "S" Then
            cedula.Text = "9999999999999"
            Nombre.Text = "CONSUMIDOR FINAL"
            chk_con_final.Value = 1
            Me.cedula.Enabled = False
            Me.Nombre.Enabled = False
            chk_con_final.Enabled = False
       End If
       'Ref 10>
    Else
        '<Ref 10
        If VLVerde <> "S" Then
            chk_con_final.Enabled = True
            chk_con_final.Value = 0
            Me.cedula.Enabled = True
        End If
       'Ref 10>
    End If
    VLCambio% = False
  End If
  End Sub
'--ref5 vmirandt fin

'<Ref 10
Sub CargaInfoCV()
    VLVerde = "S"
    If (VGCVValParmsCV(1) <> "") Then
        'se busca el campo de factura
        Select Case VGCVValParmsCV(14)
            Case "0"
                chk_con_final.Value = 1
                chk_con_final.Enabled = False
                cedula.Text = "9999999999999"
                cedula.Enabled = False
                Nombre.Text = "CONSUMIDOR FINAL"
                Nombre.Enabled = False
            Case "1"
                chk_con_final.Value = 0
                chk_con_final.Enabled = False
                cedula.Text = VGCVValParmsCV(17)
                cedula.Enabled = False
                Nombre.Text = VGCVValParmsCV(18)
                Nombre.Enabled = False
            Case Else
                chk_con_final.Value = 1
                chk_con_final.Enabled = False
                cedula.Text = "9999999999999"
                cedula.Enabled = False
                Nombre.Text = "CONSUMIDOR FINAL"
                Nombre.Enabled = False
            'Cta.SetFocus
        End Select
    End If
    VLVerif = CDbl(VGCVValParmsCV(20))
    Efectivo.Text = Format$(CCur(VLVerif), "####,###,##0.00")
    Cheques.Enabled = False
    CboTipCta.Enabled = False
    Cta.Enabled = False
    Debito.Enabled = False
    VLComauxCV = valor.Text
End Sub
'Ref 10>


