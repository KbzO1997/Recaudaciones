VERSION 5.00
Object = "{0F1F1508-C40A-101B-AD04-00AA00575482}#1.0#0"; "mhrinp32.ocx"
Object = "{DECFDD03-1E4B-11D1-B65E-0000C039C248}#5.0#0"; "mskedit.ocx"
Object = "{00025600-0000-0000-C000-000000000046}#5.2#0"; "crystl32.ocx"
Begin VB.Form FCC135 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "SRI - Impuesto Fiscal RISE"
   ClientHeight    =   5265
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4575
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   5265
   ScaleWidth      =   4575
   Begin VB.Frame frmFrame 
      Height          =   2895
      Index           =   2
      Left            =   0
      TabIndex        =   16
      Top             =   2280
      Width           =   4575
      Begin VB.TextBox NomCta 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Enabled         =   0   'False
         Height          =   285
         Left            =   1410
         TabIndex        =   18
         Top             =   1215
         Width           =   3090
      End
      Begin VB.ComboBox CboTipCta 
         Height          =   315
         ItemData        =   "FCC135.frx":0000
         Left            =   1410
         List            =   "FCC135.frx":000A
         Style           =   2  'Dropdown List
         TabIndex        =   4
         Tag             =   "CboProd"
         Top             =   855
         Width           =   1305
      End
      Begin VB.TextBox txtTemp 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   1080
         TabIndex        =   17
         Top             =   240
         Visible         =   0   'False
         Width           =   255
      End
      Begin VB.TextBox CantChq 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   1410
         MaxLength       =   3
         TabIndex        =   2
         Top             =   555
         Width           =   525
      End
      Begin MhinrelLib.MhRealInput Efe 
         Height          =   285
         Left            =   1410
         TabIndex        =   1
         ToolTipText     =   "Valor en Efectivo"
         Top             =   240
         Width           =   3090
         _Version        =   65536
         _ExtentX        =   5450
         _ExtentY        =   503
         _StockProps     =   77
         BackColor       =   12632256
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
      Begin MhinrelLib.MhRealInput Debito 
         Height          =   285
         Left            =   1410
         TabIndex        =   6
         Top             =   1530
         Width           =   3090
         _Version        =   65536
         _ExtentX        =   5450
         _ExtentY        =   503
         _StockProps     =   77
         BackColor       =   12632256
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
      Begin MskeditLib.MaskInBox Cta 
         Height          =   285
         Left            =   2775
         TabIndex        =   5
         Tag             =   "Cta"
         ToolTipText     =   "Número de la Cuenta"
         Top             =   870
         Width           =   1725
         _Version        =   262144
         _ExtentX        =   3043
         _ExtentY        =   503
         _StockProps     =   253
         Text            =   "___-______-_"
         BackColor       =   12632256
         BorderStyle     =   1
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
      Begin MhinrelLib.MhRealInput TotalPagar 
         Height          =   285
         Left            =   1410
         TabIndex        =   19
         Top             =   1845
         Width           =   3090
         _Version        =   65536
         _ExtentX        =   5450
         _ExtentY        =   503
         _StockProps     =   77
         BackColor       =   12632256
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
      Begin MhinrelLib.MhRealInput Comision 
         Height          =   285
         Left            =   1410
         TabIndex        =   7
         ToolTipText     =   "Valor Total de la Transacción"
         Top             =   2160
         Width           =   3090
         _Version        =   65536
         _ExtentX        =   5450
         _ExtentY        =   503
         _StockProps     =   77
         BackColor       =   12632256
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
         ReadOnly        =   -1  'True
         SpinChangeReal  =   0
         AutoHScroll     =   -1  'True
         CaretColor      =   -2147483642
         DecimalPlaces   =   2
         Separator       =   -1  'True
      End
      Begin MhinrelLib.MhRealInput Total 
         Height          =   285
         Left            =   1410
         TabIndex        =   20
         ToolTipText     =   "Valor Total de la Transacción"
         Top             =   2475
         Width           =   3090
         _Version        =   65536
         _ExtentX        =   5450
         _ExtentY        =   503
         _StockProps     =   77
         BackColor       =   12632256
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
      Begin MhinrelLib.MhRealInput Loc 
         Height          =   285
         Left            =   2760
         TabIndex        =   3
         Top             =   555
         Width           =   1725
         _Version        =   65536
         _ExtentX        =   3043
         _ExtentY        =   503
         _StockProps     =   77
         BackColor       =   12632256
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
      Begin VB.Label LblNomCta 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Nombre Cta:"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   120
         TabIndex        =   29
         Top             =   1260
         Width           =   1065
      End
      Begin VB.Label lblCantchq 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Cant.Cheques:"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   120
         TabIndex        =   28
         Top             =   600
         Width           =   1260
      End
      Begin VB.Label lblEfe 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Efectivo:"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   120
         TabIndex        =   27
         Top             =   285
         Width           =   900
      End
      Begin VB.Label lblLoc 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Cheques:"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   1965
         TabIndex        =   26
         Top             =   600
         Width           =   810
      End
      Begin VB.Label LblCuenta 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "ND a cta:"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   120
         TabIndex        =   25
         Top             =   915
         Width           =   840
      End
      Begin VB.Label LblDebito 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Débito:"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   120
         TabIndex        =   24
         Top             =   1575
         Width           =   630
      End
      Begin VB.Label ValPago 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Valor Pagar SRI:"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   120
         TabIndex        =   23
         Top             =   1845
         Width           =   1185
      End
      Begin VB.Label lblValor 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Comisión:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   6
         Left            =   120
         TabIndex        =   22
         Top             =   2160
         Width           =   825
      End
      Begin VB.Label lblValor 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Total:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   7
         Left            =   120
         TabIndex        =   21
         Top             =   2475
         Width           =   510
      End
   End
   Begin VB.Frame frmFrame 
      Height          =   1695
      Index           =   1
      Left            =   0
      TabIndex        =   10
      Top             =   600
      Width           =   4575
      Begin VB.TextBox txthorario 
         Height          =   285
         Left            =   1440
         TabIndex        =   33
         Text            =   "Text1"
         Top             =   120
         Visible         =   0   'False
         Width           =   1215
      End
      Begin VB.PictureBox bitmap 
         Appearance      =   0  'Flat
         BackColor       =   &H80000004&
         BorderStyle     =   0  'None
         Enabled         =   0   'False
         ForeColor       =   &H80000008&
         Height          =   550
         Left            =   150
         ScaleHeight     =   555
         ScaleWidth      =   885
         TabIndex        =   11
         TabStop         =   0   'False
         Top             =   120
         Visible         =   0   'False
         Width           =   885
      End
      Begin MhinrelLib.MhRealInput txtCuotaFecha 
         Height          =   285
         Left            =   1680
         TabIndex        =   30
         Top             =   720
         Width           =   2820
         _Version        =   65536
         _ExtentX        =   4974
         _ExtentY        =   503
         _StockProps     =   77
         BackColor       =   12632256
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
      Begin MhinrelLib.MhRealInput txtCuotaGlobal 
         Height          =   285
         Left            =   1680
         TabIndex        =   31
         Top             =   1040
         Width           =   2820
         _Version        =   65536
         _ExtentX        =   4974
         _ExtentY        =   503
         _StockProps     =   77
         BackColor       =   12632256
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
      Begin Crystal.CrystalReport rptBAD 
         Left            =   3150
         Top             =   180
         _ExtentX        =   741
         _ExtentY        =   741
         _Version        =   348160
         DiscardSavedData=   -1  'True
         PrintFileLinesPerPage=   60
      End
      Begin VB.Label lbl_paramrev 
         AutoSize        =   -1  'True
         Caption         =   "lbl_paramrev"
         Height          =   195
         Left            =   3735
         TabIndex        =   32
         Top             =   270
         Visible         =   0   'False
         Width           =   900
      End
      Begin VB.Label lblNombre 
         Appearance      =   0  'Flat
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   285
         Left            =   1680
         TabIndex        =   15
         Top             =   1360
         Width           =   2820
      End
      Begin VB.Label Label3 
         Caption         =   "Contribuyente:"
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
         Height          =   255
         Left            =   120
         TabIndex        =   14
         Top             =   1360
         Width           =   1575
      End
      Begin VB.Label Label2 
         Caption         =   "Cuota Global:"
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
         Height          =   255
         Left            =   120
         TabIndex        =   13
         Top             =   1040
         Width           =   1575
      End
      Begin VB.Label Label1 
         Caption         =   "Cuota a la Fecha:"
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
         Height          =   255
         Left            =   120
         TabIndex        =   12
         Top             =   720
         Width           =   1575
      End
   End
   Begin VB.Frame frmFrame 
      Height          =   615
      Index           =   0
      Left            =   0
      TabIndex        =   8
      Top             =   0
      Width           =   4575
      Begin VB.TextBox txtRuc 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   840
         MaxLength       =   13
         TabIndex        =   0
         Top             =   200
         Width           =   1935
      End
      Begin VB.Label lblCedula 
         Caption         =   "R.U.C.:"
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
         Height          =   255
         Left            =   120
         TabIndex        =   9
         Top             =   240
         Width           =   975
      End
   End
End
Attribute VB_Name = "FCC135"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'--=========================================================================--'
'--                        Recaudaciones de SRI - RISE
'--=========================================================================--'
'-- DISEÑADO POR:       GERMAN MEDINA C.
'-- FECHA ESCRITURA:    15/SEP/2008
'-- PROPOSITO:          Recaudaciones de SRI - RISE
'--=========================================================================--'
'********************************************************************************'
'*              MODIFICACIONES                                                  *'
'* REF  FECHA       AUTOR          DESCRIPCION                                  *'
'*  02  19/Sep/2017 Vanessa Miranda FACOFF-AP-SGC00029747-SGC00029748 Agregar   *'
'*      Clave de Acceso Facturación Electrónica Offline                         *'
'*  03  28/Feb/2018 Danny Olaya     SGC00030409                                 *'
'*      Cobro de Comisión Déb. Cuenta Facturación Offline                       *'
'********************************************************************************'

'Option Explicit
Dim VLfirma As Boolean
Dim VLCambio As Integer
Dim VLHorarioEmp As String
Dim VLEfe_com As Currency
Dim VLChq_com As Currency
Dim VLDeb_com As Currency
Dim VLTotCom As Currency
Dim psRetorno() As String
Dim MatrizPago() As String
Dim VLFechaProceso As String
Dim VLFechaContable As String
Dim VLHoraProceso As String
Dim VLTrn As String
Dim VLNombreTramite As String
Dim VLMensaje As String
Dim VLHorario As String
Dim VLHorarioDifTemporal As Boolean
Dim VLautoriSri As String
Dim VLautoSRI As String
Dim VLFecvenSRI As String
Dim VLTSN As Integer
Dim VLSerie_Secuencia As String
Dim VLProvincia As String
Dim VLSecRise As String
Public VLDetalleGlobal As String
Public VLDetalleFecha As String
Public VLSecTransac As String

Dim VLNombre As String  'TC 19/02/2010
Dim VLTipo_imp As String        'ame 08/04/2010
Dim VLfact_elect As String      'ame 08/04/2010
Dim VLFecinivig As String       'sme 06/08/2011
Dim VLFecfinvig As String       'sme 06/08/2011
Dim VGFechaProceso2 As String     'sme 09/20/2011
Dim VLiva As Currency 'smerino iva
Dim VlbaseImp As Currency 'smerino iva
Dim VLclave_acceso As String 'ref02 vmirandt

Dim VLTipCta_com As String
Dim VLCta_com As String
Dim vl_servidor_BUS As String
Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    If Shift = CGTeclaCTRL% + CGTeclaALT% And KeyCode% = CGTeclaF9% Then
        PMObtenerMonedaForma "135"
    Exit Sub
    End If
    
    If Shift = CGTeclaCTRL% And KeyCode% = CGTeclaI% Then
        PMRimpPapeleta 'Llamada a la funcion de Reimpresion de Papeletas
        PMReimpresion
        Exit Sub
    End If

    Select Case KeyCode%
        Case CGTeclaSUPR%
            If VGTipoEjecucion% = CGReverso% Then
                VGReversoLoger = "S"
                PLTransmitir
                VGReversoLoger = "N"
                Unload Me
            End If
        Case CGTeclaF1%
            If VGTipoEjecucion% <> CGReverso% Then
                SGUsar = efe.ValueReal + VLEfe_com
                If TotalPagar.Text <> "0.00" Then
                    Call PLTransmitir
                Else
                    MsgBox "Error: El monto a pagar no puede ser cero", vbCritical, App.Title
                End If
            End If
        Case CGTeclaESC%
            Unload Me
        Case CGTeclaF2%
            VLfirma = False
            Call PLLimpiar
            SGUsar = 0
            VGUsar15 = 0
            If Shift = 0 And VGTipoConsAutom% = 0 And VGTipoEjecucion% <> CGReverso% Then  'TPEAdiciono Validacion Por Consulta Automatica y Reverso
                SGActual = 1
                FSumIng.Hide
                FSumIng.Form_KeyDown CGTeclaF2%, 0
                Unload FSumIng
            ElseIf VGTipoEjecucion% = CGReverso% Then    'TPE Para el Caso Reversos
                SGPrimeraVezRev = 0
                SGAcumRev = 0
                FSumRev.Hide
                FSumRev.Form_KeyDown CGTeclaF2%, 0
                Unload FSumRev
            End If
            SGActivaSum = False
            '<------
            If VGTipoEjecucion% <> CGReverso% Then
                Me.txtRuc.SetFocus
            End If
            lectoraBill.Limpiar             'JPM lectora de billetes
        Case CGTeclaF3%
            If VGTipoEjecucion% <> CGReverso% Then
                If (VGTipoConsAutom% = 1 And VGStatusCon = "A") Or VGTipoConsAutom% = 0 Then
                    FSumIng.abrirAltaDenominacion = True
                    PMIngresoEfectivo
                    SGActual = 0
                    efe.Text = SGUsar
                    If efe.Enabled Then
                        efe.SetFocus
                    End If
                End If
            End If
        Case CGTeclaF9%
            If VGTipoEjecucion% = CGNormal% Then
                If FMSupervisor("135") = True Then
                    VGAutoriza = "S"
                End If
            End If
    End Select
    
    Exit Sub
Error:
    MsgBox Err.Description, vbExclamation, App.Title
End Sub

Private Sub Form_Load()
    CGLongTramaBill = CadenaCorta   'JPM lectora de billetes
    lectoraBill.Limpiar             'JPM lectora de billetes
    Me.Width = 4665
    Me.Height = 5640
    Me.Top = 15
    Me.Left = 15
    '----->Sumadora
    SGUsar = 0
    SGActivaSum = False
    SGActual = 1
    '<-----Sumadora
    Call PLLimpiar
    If VGTipoEjecucion% = CGReverso% Then
    
        '<-- Switch Ini
        Consulta_parametro_OSB
        'If SwitchCSP_BUS() Then
            If (vl_servidor_BUS = "BBTSSRV") Then
                Call PLReversoBUS
            Else
                Call PLReverso
            End If
        '--> Switch Fin

    End If
    
    If FMFileExist(VGDirBitmaps$ & "\sri.bmp") Then
        bitmap.Picture = LoadPicture(VGDirBitmaps$ & "\sri.bmp")
    Else
        bitmap.Picture = LoadPicture()
    End If
        bitmap.Visible = True
End Sub

Private Sub Form_Activate()
    If SGMonedaTran <> VGmoneda% And VGmoneda% <> 0 Then
        SGMonedaTran = VGmoneda%
        PMCargaIniSumadora VGmoneda%
        PMIniciaIngreso 1
    End If
        
    If VGTipoEjecucion% <> CGReverso% And CCur(efe.Text) <> 0 And VGTran = "03" Then
        SGUsar = efe.Text
    End If
    VGTran = "0"
    
    'LBP Inicio RECA-CC-SGC00025869 30/07/2016
    VGFormaPago = ""
    VGCom_aux = 0
    VGComision_original = 0
    VGCompensacion = 0
    VGPorcentajeComp = "0"
    VGPorcentajeIVA = "0"
    'LBP Fin 30/07/2016'Fin LBP
       
End Sub

Private Sub Form_Unload(Cancel As Integer)
    VGUsar15 = 0
    Call PMCerrarForma("135")
    lectoraBill.Limpiar   'JPM lectora de billetes
End Sub

Public Sub PLReversoBUS()
   
    'Sumadora ----->
    SGPrimeraVezRev = 0
    '<----------
    PMSetValorReverso Me.txtRuc, "@i_identificacion"
    
    txtTemp = ""
    PMSetValorReverso Me.efe, "@i_efectivo"
    PMSetValorReverso Me.CantChq, "@i_cant_cheques"
    PMSetValorReverso Me.Loc, "@i_cheque"
    PMSetValorReverso Me.CboTipCta, "@i_tipo_cta"
    PMSetValorReverso Me.Cta, "@i_cuenta"
    PMSetValorReverso Me.NomCta, "@i_nombre_cta"
    PMSetValorReverso Me.Debito, "@i_debito"
    PMSetValorReverso Me.Comision, "@i_comision_tot"
    'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
    VLDeb_com = Me.Comision
    'VLTotCom = Me.Comision
    'msilvag Fin
    PMSetValorReverso Me.Total, "@i_total"
    PMSetValorReverso Me.TotalPagar, "@i_subtotal"
    PMSetValorReverso Me.lblNombre, "@i_razon_soc"
    PMSetValorReverso Me.txtCuotaFecha, "@i_cuotafecha"
    Me.txtCuotaFecha = Me.txtCuotaFecha / 100
    PMSetValorReverso Me.txtCuotaGlobal, "@i_cuotaglobal"
    Me.txtCuotaGlobal = Me.txtCuotaGlobal / 100
    
    
    PMSetValorReverso txtTemp, "@i_comision_efe"
    VLEfe_com = txtTemp
    txtTemp = ""
    PMSetValorReverso txtTemp, "@i_comision_chq"
    VLChq_com = txtTemp
    txtTemp = ""
    VLTotCom = VLEfe_com + VLChq_com + VLDeb_com 'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
    Me.Comision = VLTotCom
    PMSetValorReverso txtTemp, "@o_ssn"
    VLSecTransac = CLng(txtTemp)
    txtTemp = ""
    SGUsar = (CDbl(efe.Text) + VLEfe_com)
    PMSetValorReverso txtTemp, "@o_fecha_contable"
    VLFechaContable = txtTemp
    txtTemp = ""
    VLFechaProceso = VLFechaContable
    PMSetValorReverso txtTemp, "@o_autorisri"
    VLautoriSri = txtTemp
    txtTemp = ""
    PMSetValorReverso txtTemp, "@o_fecvensri"
    VLFecvenSRI = txtTemp
    txtTemp = ""
    PMSetValorReverso txtTemp, "@o_nota_venta"
    VLSerie_Secuencia = txtTemp
    txtTemp = ""
    PMSetValorReverso txtTemp, "@i_detalle"
    'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
    PMSetValorReverso txtTemp, "@o_ssn" '"@o_sec_rise" KBastidz
    VLautoSRI = txtTemp
    txtTemp = ""
    'msilvag Fin
End Sub

Public Sub PLReverso()
   
    'Sumadora ----->
    SGPrimeraVezRev = 0
    '<----------
    PMSetValorReverso Me.txtRuc, "@i_identificacion"
    
    txtTemp = ""
    PMSetValorReverso Me.efe, "@i_efectivo"
    PMSetValorReverso Me.CantChq, "@i_cant_cheques"
    PMSetValorReverso Me.Loc, "@i_cheque"
    PMSetValorReverso Me.CboTipCta, "@i_tipo_cta"
    PMSetValorReverso Me.Cta, "@i_cuenta"
    PMSetValorReverso Me.NomCta, "@i_nombre_cta"
    PMSetValorReverso Me.Debito, "@i_debito"
    PMSetValorReverso Me.Comision, "@i_comision_tot"
    'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
    VLDeb_com = Me.Comision
    'VLTotCom = Me.Comision
    'msilvag Fin
    PMSetValorReverso Me.Total, "@i_total"
    PMSetValorReverso Me.TotalPagar, "@i_subtotal"
    PMSetValorReverso Me.lblNombre, "@i_razon_soc"
    PMSetValorReverso Me.txtCuotaFecha, "@i_cuotafecha"
    Me.txtCuotaFecha = Me.txtCuotaFecha / 100
    PMSetValorReverso Me.txtCuotaGlobal, "@i_cuotaglobal"
    Me.txtCuotaGlobal = Me.txtCuotaGlobal / 100
    
    
    PMSetValorReverso txtTemp, "@i_comision_efe"
    VLEfe_com = txtTemp
    txtTemp = ""
    PMSetValorReverso txtTemp, "@i_comision_chq"
    VLChq_com = txtTemp
    txtTemp = ""
    VLTotCom = VLEfe_com + VLChq_com + VLDeb_com 'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
    PMSetValorReverso txtTemp, "@o_ssn"
    VLSecTransac = CLng(txtTemp)
    txtTemp = ""
    SGUsar = (CDbl(efe.Text) + VLEfe_com)
    PMSetValorReverso txtTemp, "@o_fecha_contable"
    VLFechaContable = txtTemp
    txtTemp = ""
    VLFechaProceso = VLFechaContable
    PMSetValorReverso txtTemp, "@o_autorisri"
    VLautoriSri = txtTemp
    txtTemp = ""
    PMSetValorReverso txtTemp, "@o_fecvensri"
    VLFecvenSRI = txtTemp
    txtTemp = ""
    PMSetValorReverso txtTemp, "@o_nota_venta"
    VLSerie_Secuencia = txtTemp
    txtTemp = ""
    PMSetValorReverso txtTemp, "@i_detalle"
    'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
    PMSetValorReverso txtTemp, "@o_sec_rise"
    VLautoSRI = txtTemp
    txtTemp = ""
    'msilvag Fin
End Sub
Function FLChequeos() As Integer
    Dim i As Integer
    FLChequeos = True
    
    If Me.Cta.ClipText <> "" And Debito.ValueReal = 0 Then
        MsgBox "El campo Debito: es Mandatorio"
        FLChequeos = False
        Debito.SetFocus
        Exit Function
    End If
    
    'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
    If FCC135.Cta.ClipText <> "" Then
        If VLDeb_com > 0 And FCC135.Cta.ClipText <> VLCta_com Then
            MsgBox "La cuenta de la comision debe ser la misma con la que realiza el pago del servicio."
            FLChequeos = False
            Comision.SetFocus
            Exit Function
        End If
    End If
    'msilvag Fin
    
    If CantChq.Text <> "0" And CantChq.Text <> "" And Loc.ValueReal = 0 Then
        MsgBox "Verifique el Campo Valor en Cheque"
        FLChequeos = False
        Loc.SetFocus
        Exit Function
    End If

    If VLTotCom <> FMCCurATX((Comision.Text)) Then
        MsgBox "Verifique el Campo Valor de Comision"
        FLChequeos = False
        Comision.SetFocus
        Exit Function
    End If

    If VGTotalizar$ = "N" Then
        If Format(TotalPagar.Text, "###,###,###,##0.00") <> Format(FMCCurATX((Debito.Text)) + FMCCurATX((efe.Text)) + FMCCurATX((Loc.Text)), "###,###,###,##0.00") Then
            MsgBox " El campo Total Pagar no cuadra con las formas de pago"
            FLChequeos = False
            Exit Function
        End If
    End If

    If FMCCurATX((efe.Text)) > 0 And CCur(VLEfe_com) > 0 And VGTipoEjecucion = CGNormal% Then
        VTTotalDesglose = 0
        For i = 1 To SGNumDen
            If SGIngreso(i - 1).cant_ingr > 0 Then
                VTTotalDesglose = VTTotalDesglose + SGIngreso(i% - 1).mont_ingr
            End If
        Next i%
        If CCur(VTTotalDesglose + SGAcumulado) < (FMCCurATX((efe.Text)) + CCur(VLEfe_com)) Then
            MsgBox "Desglose menor a efectivo ingresado. Verifique...", vbCritical, "Mensaje del Servidor"
            FLChequeos = False
            Exit Function
        End If
    End If
End Function

Public Sub PLLimpiar()
    VLTSN = 0
    Me.txtRuc.Text = ""
    Me.VLDetalleFecha = ""
    Me.VLDetalleGlobal = ""
    Me.frmFrame(0).Enabled = True
    Me.frmFrame(1).Enabled = False
    Me.frmFrame(2).Enabled = False
    txtTemp = ""
    VGAutoriza = "N"
    efe.Text = "0.00"
    CantChq.Text = ""
    Loc.Text = "0.00"
    CboTipCta.ListIndex = 0
    Cta.Text = ""
    Debito.Text = "0.00"
    TotalPagar.Text = "0.00"
    Comision.Text = "0.00"
    Total.Text = "0.00"
    NomCta.Text = ""
    VLHorarioEmp = ""
    VLEfe_com = 0
    VLChq_com = 0
    VLDeb_com = 0
    VLTotCom = 0
    VLFechaProceso = ""
    VLFechaContable = ""
    VLHoraProceso = ""
    VLTrn = ""
    VLMensaje = ""
    VLHorario = ""
    VLHorarioDifTemporal = False
    VLautoriSri = ""
    VLFecvenSRI = ""
    Me.txtCuotaFecha.Text = ""
    Me.txtCuotaGlobal.Text = ""
    Me.lblNombre.Caption = ""
    
    'LBP Inicio RECA-CC-SGC00025869 30/07/2016
    VGFormaPago = ""
    VGCom_aux = 0
    VGComision_original = 0
    VGCompensacion = 0
    VGPorcentajeComp = "0"
    VGPorcentajeIVA = "0"
    'LBP Fin 30/07/2016'Fin LBP
    
    'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
    SGNumCuenta = ""
    SGEmpresa = ""
    'msilvag Fin
    
End Sub
Public Function Cambio(ByVal parOpcion As Variant, parcontrol As Control) As Boolean
    On Error GoTo Error
    Select Case parOpcion
        Case CGTeclaSUPR%
            parcontrol.Text = ""
        Case CGTeclaENTER%
            SendKeys "{TAB}"
        Case CGTeclaHOME%
            PMCambiarForma Me
        Case CGTeclaUP%, CGTeclaREPAG%
            SendKeys "+{TAB}"
        Case CGTeclaDOWN%, CGTeclaAVPAG%, CGTeclaENTER%
            SendKeys "{TAB}"
    End Select
    
    Exit Function
Error:
        
End Function

Private Sub txtCuotaFecha_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Cuota a la Fecha"
End Sub

Private Sub txtCuotaGlobal_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Cuota Global"
End Sub

Private Sub txtRuc_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Digite Número de RUC"
End Sub

Private Sub txtRuc_KeyDown(KeyCode As Integer, Shift As Integer)
    If Len(txtRuc.Text) = "13" And KeyCode = CGTeclaF5% Then
        If frmFrame(0).Enabled = True Then
            Consulta_parametro_OSB
            'If Consulta_parametro_OSB() Then
                If (vl_servidor_BUS = "BBTSSRV") Then
                '<-- BUS
                    If PLConsultarBUS("1") Then
                        If PLConsultarBUS("0") Then
                            frmFrame(1).Enabled = True
                            frmFrame(2).Enabled = True
                            frmFrame(0).Enabled = False
                            If Comision.Text <> "0.00" Then
                                Comision.Enabled = True
                            End If
                            efe.SetFocus
                            Exit Sub
                        End If
                    End If
                '-->
                Else
                '<-- CSP
                    If PLConsultar("1") Then
                        If PLConsultar("0") Then
                            frmFrame(1).Enabled = True
                            frmFrame(2).Enabled = True
                            frmFrame(0).Enabled = False
                            If Comision.Text <> "0.00" Then
                                Comision.Enabled = True
                            End If
                            efe.SetFocus
                            Exit Sub
                        End If
                    End If
                '-->
                End If
                
            'End If
        
            
        End If
    End If
    Call Cambio(KeyCode, txtRuc)
End Sub

Public Function PLConsultarBUS(parOpcion As String) As Boolean
On Error GoTo Error
    'Consulta 0 - Consulta Cliente
    If parOpcion = "0" Then
        If txtRuc.Text <> "" Then
            PMInicioTransaccion
            'PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, "62156", "Trn", ""
            PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, "62159", "Trn", "" '3934
            PMPasoValoresATX VGSqlConn, "@i_ruc", 0, SQLVARCHAR, LTrim(RTrim(Me.txtRuc.Text)), "Ruc", ""
            PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Canal", ""
            PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLCHAR, str(FMObtenerMonedaForma("135")), "Moneda", ""
            PMPasoValoresATX VGSqlConn, "@i_ssn_corr", 0, SQLINT4, "0", "Sec. Correccion", ""
            'PMPasoValoresATX VGSqlConn, "@i_pdate_bco", 0, SQLVARCHAR, VGFechaProceso, "F. Transaccion", ""
            PMPasoValoresATX VGSqlConn, "@i_pdate_bco", 0, SQLVARCHAR, VLFechaContable, "F. Contable", ""
            PMPasoValoresATX VGSqlConn, "@i_plogin_bco", 0, SQLVARCHAR, VGLogin, "Login", ""
            PMPasoValoresATX VGSqlConn, "@i_poficina_bco", 0, SQLINT2, str(VGOficina), "Oficina", ""
            PMPasoValoresATX VGSqlConn, "@i_provincia_bco", 0, SQLVARCHAR, VLProvincia, "Provincia", ""
            PMPasoValoresATX VGSqlConn, "@i_pusuario", 0, SQLVARCHAR, VGLogin, "Usuario", ""
            PMPasoValoresATX VGSqlConn, "@i_pvalor", 0, SQLINT4, "0", "Valor", ""
            PMPasoValoresATX VGSqlConn, "@i_tipocanal", 0, SQLVARCHAR, "VENTANILLA", "Canal", ""
            If FMTransmitirRPCATX(VGSqlConn, "BBTSSRV", "cob_procesador", "fp_consulta_rise", True, "Transaccion Ok", "S", "N", "S", "135", "S", "S") = True Then
            
                ReDim Preserve psRetorno(1, 40)
                FMMapeaMatriz VGSqlConn, psRetorno
                PMFinTransaccion
                FCC135_Cons.grdDetalle.Rows = 3
                FCC135_Cons.grdDetalle.Cols = 4
                FCC135_Cons.grdDetalle.Row = 0
                FCC135_Cons.grdDetalle.Col = 0
                FCC135_Cons.grdDetalle.Text = "No."
                FCC135_Cons.grdDetalle.Col = 1
                FCC135_Cons.grdDetalle.Text = "Cuota"
                FCC135_Cons.grdDetalle.Col = 2
                FCC135_Cons.grdDetalle.Text = "Valor"
                FCC135_Cons.grdDetalle.Col = 3
                FCC135_Cons.grdDetalle.Text = "Detalle"
                FCC135_Cons.grdDetalle.Row = 1
                FCC135_Cons.grdDetalle.Col = 0
                FCC135_Cons.grdDetalle.Text = "1"
                FCC135_Cons.grdDetalle.Row = 2
                FCC135_Cons.grdDetalle.Col = 0
                FCC135_Cons.grdDetalle.Text = "2"
                FCC135_Cons.grdDetalle.Row = 1
                FCC135_Cons.grdDetalle.Col = 1
                FCC135_Cons.grdDetalle.Text = "A LA FECHA"
                FCC135_Cons.grdDetalle.Col = 2
                FCC135_Cons.grdDetalle.Text = val(psRetorno(1, 4))
                FCC135_Cons.grdDetalle.Col = 3
                FCC135_Cons.grdDetalle.Text = psRetorno(1, 5)
                FCC135_Cons.grdDetalle.Row = 2
                FCC135_Cons.grdDetalle.Col = 1
                FCC135_Cons.grdDetalle.Text = "GLOBAL"
                FCC135_Cons.grdDetalle.Col = 2
                FCC135_Cons.grdDetalle.Text = val(psRetorno(1, 2))
                FCC135_Cons.grdDetalle.Col = 3
                FCC135_Cons.grdDetalle.Text = psRetorno(1, 3)
                
                FCC135_Cons.grdDetalle.ColWidth(0) = 300
                FCC135_Cons.grdDetalle.ColWidth(1) = 1300
                FCC135_Cons.grdDetalle.ColWidth(2) = 1000
                FCC135_Cons.grdDetalle.ColWidth(3) = 3500
                
                FCC135_Cons.txtContribuyente.Text = psRetorno(1, 1)
                FCC135_Cons.Show 1
                
                If Me.txtCuotaFecha.Text <> "0.00" Or Me.txtCuotaGlobal.Text <> "0.00" Then
                    PLConsultarBUS = True
                Else
                    PLConsultarBUS = False
                End If
            Else
                PMFinTransaccion
                PLConsultarBUS = False
            End If
        End If

    End If
    
    'Opcion "1" - consulta en base local
    If parOpcion = "1" Then
        PMInicioTransaccion
        VLFechaContable = ""
        PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT2, "3934", "Trn", "" '3934
        PMPasoValoresATX VGSqlConn, "@i_operacion", 0, SQLCHAR, "C", "Operacion", ""
        PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Canal", ""
        PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(VGmoneda%), "Moneda", ""
        PMPasoValoresATX VGSqlConn, "@o_fecha_contable", 1, SQLDATETIME, "01/01/1900 00:00:00", "Fecha Con.", ""
        PMPasoValoresATX VGSqlConn, "@o_comision", 1, SQLMONEY, (Comision.Text), "Comision", ""
        PMPasoValoresATX VGSqlConn, "@o_provincia", 1, SQLCHAR, Space(3), "Provincia", ""
        'smerino
        PMPasoValoresATX VGSqlConn, "@o_tasa", 1, SQLMONEY, "0", "tasa", ""
        PMPasoValoresATX VGSqlConn, "@o_base_imp", 1, SQLMONEY, "0", "base_imp", ""
        PMPasoValoresATX VGSqlConn, "@o_impuesto", 1, SQLMONEY, "0", "impuesto", ""
        'smerino
                
        If FMTransmitirRPCATX(VGSqlConn, "", "cob_cuentas", "sp_procesa_rise", True, "Consulta Ok...", "N", "N", "N", "135", "N", "N") Then
            VLFechaContable = (Format(FMRetParamATX(VGSqlConn, 1), "mm/dd/yyyy"))
            Comision.Text = FMRetParamATX(VGSqlConn, 2)
            VLProvincia = Trim(FMRetParamATX(VGSqlConn, 3))
            VlbaseImp = FMRetParamATX(VGSqlConn, 5) 'smerino
            VLiva = FMRetParamATX(VGSqlConn, 6) 'smerino
            PMChequeaATX VGSqlConn
            PLConsultarBUS = True
            
            CantChq.Enabled = False
            Loc.Enabled = False
            
             'LBP Inicio RECA-CC-SGC00025869
             If Comision.Text > 0 Then
                VGCom_aux = FMDevuelveComisionReal(Comision, False, 135)
                If VGCom_aux <> CDbl(Comision.Text) Then
                    VGComision_original = Comision.Text
                    Comision.Text = VGCom_aux
                Else
                    VGComision_original = Comision.Text
                End If
             End If
            'LBP Fin RECA-CC-SGC00025869
            
        Else
            Comision.Text = ""
            PMChequeaATX VGSqlConn
            PLConsultarBUS = False
        End If
        PMFinTransaccion
        Exit Function
        
    End If
    
    Exit Function
Error:
    MsgBox Err.Description
    PLConsultarBUS = False
    PMChequea VGSqlConn
    PMFinTransaccion


End Function

Public Function PLConsultar(parOpcion As String) As Boolean
On Error GoTo Error
    'Consulta 0 - Consulta Cliente
    If parOpcion = "0" Then
        If txtRuc.Text <> "" Then
            PMInicioTransaccion
            PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, "62156", "Trn", ""
            PMPasoValoresATX VGSqlConn, "@i_ruc", 0, SQLVARCHAR, LTrim(RTrim(Me.txtRuc.Text)), "Ruc", ""
            PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VENTANILLA", "Canal", ""
            PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLCHAR, str(FMObtenerMonedaForma("135")), "Moneda", ""
            PMPasoValoresATX VGSqlConn, "@i_ssn_corr", 0, SQLINT4, "0", "Sec. Correccion", ""
            'PMPasoValoresATX VGSqlConn, "@i_pdate_bco", 0, SQLVARCHAR, VGFechaProceso, "F. Transaccion", ""
            PMPasoValoresATX VGSqlConn, "@i_pdate_bco", 0, SQLVARCHAR, VLFechaContable, "F. Contable", ""
            PMPasoValoresATX VGSqlConn, "@i_plogin_bco", 0, SQLVARCHAR, VGLogin, "Login", ""
            PMPasoValoresATX VGSqlConn, "@i_poficina_bco", 0, SQLINT2, str(VGOficina), "Oficina", ""
            PMPasoValoresATX VGSqlConn, "@i_provincia_bco", 0, SQLVARCHAR, VLProvincia, "Provincia", ""
            PMPasoValoresATX VGSqlConn, "@i_pusuario", 0, SQLVARCHAR, VGLogin, "Usuario", ""
            PMPasoValoresATX VGSqlConn, "@i_pvalor", 0, SQLINT4, "0", "Valor", ""
            
            If FMTransmitirRPCATX(VGSqlConn, "PSSRV1", "cob_procesador", "fp_consulta_rise", True, "Transaccion Ok", "S", "N", "S", "135", "S", "S") = True Then
                ReDim Preserve psRetorno(1, 40)
                FMMapeaMatriz VGSqlConn, psRetorno
                PMFinTransaccion
                FCC135_Cons.grdDetalle.Rows = 3
                FCC135_Cons.grdDetalle.Cols = 4
                FCC135_Cons.grdDetalle.Row = 0
                FCC135_Cons.grdDetalle.Col = 0
                FCC135_Cons.grdDetalle.Text = "No."
                FCC135_Cons.grdDetalle.Col = 1
                FCC135_Cons.grdDetalle.Text = "Cuota"
                FCC135_Cons.grdDetalle.Col = 2
                FCC135_Cons.grdDetalle.Text = "Valor"
                FCC135_Cons.grdDetalle.Col = 3
                FCC135_Cons.grdDetalle.Text = "Detalle"
                FCC135_Cons.grdDetalle.Row = 1
                FCC135_Cons.grdDetalle.Col = 0
                FCC135_Cons.grdDetalle.Text = "1"
                FCC135_Cons.grdDetalle.Row = 2
                FCC135_Cons.grdDetalle.Col = 0
                FCC135_Cons.grdDetalle.Text = "2"
                FCC135_Cons.grdDetalle.Row = 1
                FCC135_Cons.grdDetalle.Col = 1
                FCC135_Cons.grdDetalle.Text = "A LA FECHA"
                FCC135_Cons.grdDetalle.Col = 2
                FCC135_Cons.grdDetalle.Text = val(psRetorno(1, 4)) / 100
                FCC135_Cons.grdDetalle.Col = 3
                FCC135_Cons.grdDetalle.Text = psRetorno(1, 5)
                FCC135_Cons.grdDetalle.Row = 2
                FCC135_Cons.grdDetalle.Col = 1
                FCC135_Cons.grdDetalle.Text = "GLOBAL"
                FCC135_Cons.grdDetalle.Col = 2
                FCC135_Cons.grdDetalle.Text = val(psRetorno(1, 2)) / 100
                FCC135_Cons.grdDetalle.Col = 3
                FCC135_Cons.grdDetalle.Text = psRetorno(1, 3)
                
                FCC135_Cons.grdDetalle.ColWidth(0) = 300
                FCC135_Cons.grdDetalle.ColWidth(1) = 1300
                FCC135_Cons.grdDetalle.ColWidth(2) = 1000
                FCC135_Cons.grdDetalle.ColWidth(3) = 3500
                
                FCC135_Cons.txtContribuyente.Text = psRetorno(1, 1)
                FCC135_Cons.Show 1
                
                If Me.txtCuotaFecha.Text <> "0.00" Or Me.txtCuotaGlobal.Text <> "0.00" Then
                    PLConsultar = True
                Else
                    PLConsultar = False
                End If
            Else
                PMFinTransaccion
                PLConsultar = False
            End If
        End If

    End If
    
    'Opcion "1" - consulta en base local
    If parOpcion = "1" Then
        PMInicioTransaccion
        VLFechaContable = ""
        PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT2, "3934", "Trn", ""
        PMPasoValoresATX VGSqlConn, "@i_operacion", 0, SQLCHAR, "C", "Operacion", ""
        PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Canal", ""
        PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(VGmoneda%), "Moneda", ""
        PMPasoValoresATX VGSqlConn, "@o_fecha_contable", 1, SQLDATETIME, "01/01/1900 00:00:00", "Fecha Con.", ""
        PMPasoValoresATX VGSqlConn, "@o_comision", 1, SQLMONEY, (Comision.Text), "Comision", ""
        PMPasoValoresATX VGSqlConn, "@o_provincia", 1, SQLCHAR, Space(3), "Provincia", ""
        'smerino
        PMPasoValoresATX VGSqlConn, "@o_tasa", 1, SQLMONEY, "0", "tasa", ""
        PMPasoValoresATX VGSqlConn, "@o_base_imp", 1, SQLMONEY, "0", "base_imp", ""
        PMPasoValoresATX VGSqlConn, "@o_impuesto", 1, SQLMONEY, "0", "impuesto", ""
        'smerino
                
        If FMTransmitirRPCATX(VGSqlConn, "", "cob_cuentas", "sp_procesa_rise", True, "Consulta Ok...", "N", "N", "N", "135", "N", "N") Then
            VLFechaContable = (Format(FMRetParamATX(VGSqlConn, 1), "mm/dd/yyyy"))
            Comision.Text = FMRetParamATX(VGSqlConn, 2)
            VLProvincia = Trim(FMRetParamATX(VGSqlConn, 3))
            VlbaseImp = FMRetParamATX(VGSqlConn, 5) 'smerino
            VLiva = FMRetParamATX(VGSqlConn, 6) 'smerino
            PMChequeaATX VGSqlConn
            PLConsultar = True
            
             'LBP Inicio RECA-CC-SGC00025869
             If Comision.Text > 0 Then
                VGCom_aux = FMDevuelveComisionReal(Comision, False, 135)
                If VGCom_aux <> CDbl(Comision.Text) Then
                    VGComision_original = Comision.Text
                    Comision.Text = VGCom_aux
                Else
                    VGComision_original = Comision.Text
                End If
             End If
            'LBP Fin RECA-CC-SGC00025869
            
        Else
            Comision.Text = ""
            PMChequeaATX VGSqlConn
            PLConsultar = False
        End If
        PMFinTransaccion
        Exit Function
        
    End If
    
    Exit Function
Error:
    MsgBox Err.Description
    PLConsultar = False
    PMChequea VGSqlConn
    PMFinTransaccion


End Function


Public Sub PLTransmitir()
     VLclave_acceso = "" '--ref02 vmirandt
    'Validacion necesaria para No permitir Transacciones en caso de Valor Acumulado negativo
    If SGAcumulado < 0 And VGTipoEjecucion = CGNormal% Then
        MsgBox "Valor acumulado < 0 por Reverso. Transaccion No Permitida", vbInformation, "Mensaje del Sistema"
        Exit Sub
    End If

    If VGTipoEjecucion = CGRedigitacion% Then
        If FMSecuencialReverso() = False Then
            Exit Sub
        End If
    End If
    
    If VGTipoEjecucion = CGNormal% Then 'ref03
      If FLChequeos() = False Then
          Exit Sub
      End If
    End If
    
    If VLCambio = False And VGTipoEjecucion = CGNormal% Then
        MsgBox " Transaccion Repetida"
        Exit Sub
    End If
    '------> Sumadora
    'Validacion de Monto Efectivo
    If (CDbl(efe.Text) + VLEfe_com) <> SGUsar Then
        MsgBox "El Monto Efetivo No Coincide con el Monto Desglosado para el Deposito. Verificar", vbCritical, "Mensaje del Sistema"
        efe.Text = Format$(SGUsar, "####,###,##0.00")
        Exit Sub
    End If
    '<--------
    'JPM ContadorBillete -->
    If lectoraBill.HayAltaDenom And VGTipoEjecucion = CGNormal% Then
      If Not VGDatPersBillAltDen.dataOK Then
        MsgBox "Existen Billetes de Alta Denominación cuyos Número de Serie no se han confirmado", vbCritical, "Mensaje del Sistema"
        Exit Sub
      End If
    End If
    '<-- Switch Ini
    Consulta_parametro_OSB
    'If SwitchCSP_BUS() Then
        If (vl_servidor_BUS = "BBTSSRV") Then
            '<-- JPM ContadorBillete Ini
            If FLTransmitirBUS() = False Then
                'Sumadora ------->
                If (SGAcumulado + SGAcumuladoAdi) = 0 Then
                    If Comision.Enabled = True Then
                        Comision.SetFocus
                    End If
                End If
                '<---------
                Exit Sub
            End If
            '<-- Fin
        Else
            '<-- JPM ContadorBillete Ini
            If FLTransmitir() = False Then
                'Sumadora ------->
                If (SGAcumulado + SGAcumuladoAdi) = 0 Then
                    If Comision.Enabled = True Then
                        Comision.SetFocus
                    End If
                End If
                '<---------
                Exit Sub
            End If
            '<-- Fin
        End If
    'End If
    '--> Switch Fin
    
    
    
    If VGTipoEjecucion = CGReverso And VGReversoLoger = "S" Then
        PMMsgError "Reverso OK", "", CGErrorInformativo
        FReverso!grdValores(0).Col = 4
        FReverso!grdValores(0).Text = "R"
    End If
        
    Call PLImprimirComprobantePago
    
    ' comenta ame 08/04/2010 cambio por facturas cobro comision
    'Call PLImprimirComprobante
      
    If VGTipoEjecucion% <> CGReverso% And VLTotCom > 0 Then
        If VLfact_elect = "N" Then
            VLTipo_imp = "O"
            PLImprimirComprobante
            If MsgBox("Desea imprimir copia de la factura por la comision?", vbYesNo, "Mensaje") = vbYes Then
               VLTipo_imp = "C"
               PLImprimirComprobante
            End If
            VLTipo_imp = "O"
'        Else
'           MsgBox "Cliente tiene facturación electrónica imprimir comprobante por 24Online", vbInformation, "Sistema"
        End If
    End If
      
      
    VLTSN = 0
      
    If SGAcumulado = 0 Then
        Form_KeyDown CGTeclaF2%, 0
    Else
        Form_KeyDown CGTeclaF2%, -1
    End If
End Sub
Sub PLFactura()
    'ame 08/03/2010
    
        '**************************************
    'GAMC - 02AGO10 - GUARDAR FACTURA - INI
    '**************************************
    If Comision.Text > 0 And VLDeb_com = 0# Then
    Dim fr_secuencia As Long, fr_ssn As Long
    Dim fr_ced_ruc As String, fr_nombre As String, fr_fact_elect As String, fr_pto_estab As String, fr_pto_emis As String, _
        fr_fecha_validez As String, fr_nautorizacion As String, fr_valor As String, fr_iva As String, _
        fr_referencia As String, fr_servicio As String, nro_factura As String, fr_baseImp As String, fr_impresa As String, fr_fecha_ini_vig As String, fr_fecha_fin_vig As String 'SMERINO
    Dim fr_descuento As String, fr_forma_pag As String, fr_porc_compensa As String, fr_porc_iva As String 'LBP RECA-CC-SGC00025869 30/07/2016
    
    fr_ced_ruc = Replace(SGCedula, "_", "")     'Se obtiene de la pantalla de Comision
    fr_nombre = Trim(SGNombre)                  'Se obtiene de la pantalla de Comision
    fr_fact_elect = "S"

    'LBP Inicio RECA-CC-SGC00025869 30/07/2016
    fr_descuento = VGCompensacion
    If fr_descuento > "0" Then
        fr_valor = VGComision_original
        If fr_valor = "0.00" Then
            fr_valor = Comision.Text
        End If
    Else
        fr_valor = Comision.Text 'LBP
    End If
    fr_porc_iva = VGPorcentajeIVA
    fr_forma_pag = VGFormaPago
    fr_porc_compensa = VGPorcentajeComp
    'LBP Fin 30/07/2016'Fin LBP

    'fr_iva = "0"
    fr_iva = VLiva    'smerino"0" cambios iva
    fr_baseImp = VlbaseImp 'smerino iva
    fr_impresa = "S" 'smerino
    fr_referencia = (Trim(txtRuc))
    fr_servicio = "Impuesto Fiscal RISE"
    If VGTipoEjecucion% <> CGReverso% Then
       fr_ssn = CLng(SGSecTrn$)
            If FMFacturaRecaudacion("1", fr_secuencia, fr_ssn, fr_ced_ruc, fr_nombre, fr_fact_elect, _
                fr_pto_estab, fr_pto_emis, fr_fecha_validez, fr_nautorizacion, fr_valor, fr_iva, _
                fr_baseImp, fr_impresa, fr_referencia, fr_servicio, nro_factura, fr_fecha_ini_vig, fr_fecha_fin_vig, _
                fr_descuento, fr_forma_pag, fr_porc_compensa, fr_porc_iva) Then    'LBP RECA-CC-SGC00025869 30/07/2016
                'VLautoriSri = fr_nautorizacion
                VLclave_acceso = fr_nautorizacion '--ref02 vmirandt
                VLFecvenSRI = fr_fecha_validez
                VLSerie_Secuencia = nro_factura
                VLfact_elect = fr_fact_elect
                  VLFecinivig = fr_fecha_ini_vig  'SMERINO
                VLFecfinvig = fr_fecha_fin_vig  'SMERINO
                
            End If
    Else
       fr_ssn = CLng(VGSSNCorr)
        VGTipoEjecucion% = CGNormal
        If Not FMFacturaRecaudacion("2", fr_secuencia, fr_ssn, fr_ced_ruc, fr_nombre, fr_fact_elect, _
            fr_pto_estab, fr_pto_emis, fr_fecha_validez, fr_nautorizacion, fr_valor, fr_iva, _
            fr_baseImp, fr_impresa, fr_referencia, fr_servicio, nro_factura, fr_fecha_ini_vig, fr_fecha_fin_vig) Then 'SMERINO
            MsgBox "ERROR: En reverso de factura: " & CStr(fr_ssn)
        Else
             VLclave_acceso = fr_nautorizacion '--ref02 vmirandt
        End If
        VGTipoEjecucion% = CGReverso
    End If
    End If
    '**************************************
    'GAMC - 02AGO10 - GUARDAR FACTURA - FIN
    '**************************************
End Sub

Function FLTransmitir() As Integer
'FLTransmitir = True
    Dim VTIndicadorSum As Integer
    SGUsar = Me.efe.Text + VLEfe_com
    VTIndicadorSum = 0
    FLTransmitir = True
    
    If VGHorarioDif Then
       VLTrn = "3935"      'Transaccion de Horario Diferido
    Else
       VLTrn = "3934"      'Transaccion de Horario Normal
    End If
    VGTrn = IIf(VLTrn = "", 0, VLTrn)
   
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 62159, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(FMObtenerMonedaForma("135")), "Moneda", ""
    PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VENTANILLA", "Canal", ""
    PMPasoValoresATX VGSqlConn, "@i_operacion", 0, SQLVARCHAR, "P", "Canal", ""
    'PMPasoValoresATX VGSqlConn, "@i_operacion", 0, SQLCHAR, "P", "Operacion", ""
    PMPasoValoresATX VGSqlConn, "@i_identificacion", 0, SQLVARCHAR, Me.txtRuc.Text, "Identificacion", ""
    PMPasoValoresATX VGSqlConn, "@i_razon_soc", 0, SQLVARCHAR, Me.lblNombre.Caption, "Razon Social", ""
    'Formas de Pago(Efectivo  - Cheque - Debito - Subtotal - Comision - Total)
    PMPasoValoresATX VGSqlConn, "@i_efectivo", 0, SQLMONEY, (CCur(Me.efe.Text)), "Efectivo", ""
    PMPasoValoresATX VGSqlConn, "@i_valor", 0, SQLMONEY, (CCur(Me.efe.Text)), "Efectivo", ""
    PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, (CCur(Me.Loc.Text)), "Cheque", ""
    PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, (CCur(Me.Debito.Text)), "Debito", ""
    PMPasoValoresATX VGSqlConn, "@i_subtotal", 0, SQLMONEY, (CCur(Me.TotalPagar.Text)), "SubTotal", ""
    'PMPasoValoresATX VGSqlConn, "@i_comision_tot", 0, SQLMONEY, (CCur(Me.Comision.Text)), "ComisionTotal", ""
    PMPasoValoresATX VGSqlConn, "@i_comision_tot", 0, SQLMONEY, (CCur(VLDeb_com)), "ComisionDebito", ""
    PMPasoValoresATX VGSqlConn, "@i_comision_efe", 0, SQLMONEY, (CCur(VLEfe_com)), "ComisionEfectivo", ""
    PMPasoValoresATX VGSqlConn, "@i_comision_chq", 0, SQLMONEY, (CCur(VLChq_com)), "ComisionCheque", ""
    PMPasoValoresATX VGSqlConn, "@i_total", 0, SQLMONEY, (CCur(Me.Total.Text) - CCur(Me.Comision.Text)), "Total", ""
    
    'LBP Inicio RECA-CC-SGC00025869
    If VLEfe_com > 0 And VLChq_com > 0 And VLDeb_com > 0 Then
        VGFormaPago = "EFE;" & Format(VLEfe_com, "#0.00") & "_" & "CHE;" & Format(VLChq_com, "#0.00") & "_" & "DEB;" & Format(VLDeb_com, "#0.00")
    ElseIf VLEfe_com > 0 And VLChq_com > 0 Then
        VGFormaPago = "EFE;" & Format(VLEfe_com, "#0.00") & "_" & "CHE;" & Format(VLChq_com, "#0.00")
    ElseIf VLEfe_com > 0 And VLDeb_com > 0 Then
        VGFormaPago = "EFE;" & Format(VLEfe_com, "#0.00") & "_" & "DEB;" & Format(VLDeb_com, "#0.00")
    ElseIf VLDeb_com > 0 And VLChq_com > 0 Then
        VGFormaPago = "DEB;" & Format(VLDeb_com, "#0.00") & "_" & "CHE;" & Format(VLChq_com, "#0.00")
    ElseIf VLEfe_com > 0 Then
        VGFormaPago = "EFE;" & Format(VLEfe_com, "#0.00")
    ElseIf VLChq_com > 0 Then
        VGFormaPago = "CHE;" & Format(VLChq_com, "#0.00")
    ElseIf VLDeb_com > 0 Then
        VGFormaPago = "DEB;" & Format(VLDeb_com, "#0.00")
    End If
    'LBP Fin RECA-CC-SGC00025869
    
    'CantCheques - TipoCta - Cta - NombreCta - Autorizacion - Secuencial Rise
    PMPasoValoresATX VGSqlConn, "@i_cant_cheques", 0, SQLVARCHAR, Me.CantChq.Text, "CantCheques", ""
    'msilvag: Inicio RECA-CC-SGC00030409 - Facturacion OffLine Debitos
    If Me.Debito.Text > 0 Then
        PMPasoValoresATX VGSqlConn, "@i_tipo_cta", 0, SQLVARCHAR, (CboTipCta.Text), "TipoCta", ""
        PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
    Else
        PMPasoValoresATX VGSqlConn, "@i_tipo_cta", 0, SQLVARCHAR, (VLTipCta_com), "TipoCta", ""
        PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (VLCta_com), "Cta", ""
    End If
    'PMPasoValoresATX VGSqlConn, "@i_tipo_cta", 0, SQLVARCHAR, (Me.CboTipCta.Text), "TipoCta", ""
    'PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Me.Cta.ClipText), "Cta", ""
    'msilvag Fin
    PMPasoValoresATX VGSqlConn, "@i_nombre_cta", 0, SQLVARCHAR, (Me.NomCta.Text), "NombreCta", ""
    PMPasoValoresATX VGSqlConn, "@i_autoriza", 0, SQLVARCHAR, VGAutoriza, "Autorizacion", ""
'    PMPasoValoresATX VGSqlConn, "@i_sec_rise", 0, SQLINT4, "0", "SecRise", ""
    PMPasoValoresATX VGSqlConn, "@i_sec_rise", 0, SQLVARCHAR, "0", "SecRise", ""
    'Parametros no necesarios
    'TipoId - Sucursal - Rubro - Comprobante
    PMPasoValoresATX VGSqlConn, "@i_tipoid", 0, SQLVARCHAR, "R", "TipoId", ""
    PMPasoValoresATX VGSqlConn, "@i_sucursal", 0, SQLVARCHAR, " ", "Sucursal", ""
    PMPasoValoresATX VGSqlConn, "@i_comprobante", 0, SQLVARCHAR, " ", "Comprobante", ""
    'Parametros del Proveedor
    'OfiBanco - ProBco - Usuario - Ruc - TPago - VPagado
    PMPasoValoresATX VGSqlConn, "@i_poficina_bco", 0, SQLINT2, str(VGOficina), "Oficina", ""
    PMPasoValoresATX VGSqlConn, "@i_provincia_bco", 0, SQLVARCHAR, VLProvincia, "Provincia", ""
    PMPasoValoresATX VGSqlConn, "@i_pusuario", 0, SQLVARCHAR, VGLogin, "Usuario", ""
    PMPasoValoresATX VGSqlConn, "@i_ruc", 0, SQLVARCHAR, Me.txtRuc.Text, "Ruc", ""
    If CCur(Me.TotalPagar.Text) = CCur(Me.txtCuotaFecha.Text) Then
        PMPasoValoresATX VGSqlConn, "@i_tipopago", 0, SQLVARCHAR, "A_LA_FECHA", "TPago", ""
        PMPasoValoresATX VGSqlConn, "@i_rubro", 0, SQLVARCHAR, "A_LA_FECHA", "Rubro", ""
        If VGTipoEjecucion% = CGReverso% Then
            VLDetalleFecha = txtTemp
        End If
        PMPasoValoresATX VGSqlConn, "@i_detalle", 0, SQLVARCHAR, VLDetalleFecha, "Detalle", ""
    Else
        PMPasoValoresATX VGSqlConn, "@i_rubro", 0, SQLVARCHAR, "GLOBAL", "Rubro", ""
        PMPasoValoresATX VGSqlConn, "@i_tipopago", 0, SQLVARCHAR, "GLOBAL", "TPago", ""
        If VGTipoEjecucion% = CGReverso% Then
            VLDetalleGlobal = txtTemp
        End If
        PMPasoValoresATX VGSqlConn, "@i_detalle", 0, SQLVARCHAR, VLDetalleGlobal, "Detalle", ""
    End If
    PMPasoValoresATX VGSqlConn, "@i_pvalorpago", 0, SQLINT4, str((Me.TotalPagar * 100)), "ValPag", ""
    PMPasoValoresATX VGSqlConn, "@i_cuotafecha", 0, SQLMONEY, str((Me.txtCuotaFecha * 100)), "CuotaFecha", ""
    PMPasoValoresATX VGSqlConn, "@i_cuotaglobal", 0, SQLMONEY, str((Me.txtCuotaGlobal * 100)), "CuotaFecha", ""
    PMPasoValoresATX VGSqlConn, "@i_pmcn", 0, SQLINT4, "0", "SecOss", ""
    
    'Parametros de salida
    'Fecha Contable - Fecha Efectiva - Secuencial - Autorizacion - FechaSRI - Nota Venta - SecRise
     If VGTipoEjecucion% = CGReverso% Then
        VLSecTrnCorr1 = DatoSwitch("@o_pmcn")
        VLSecTrnCorr2 = DatoSwitch("@o_ssn")
        PMPasoValoresATX VGSqlConn, "@t_ssn_corr1", 0, SQLINT4, str(VLSecTrnCorr1), "", "", True 'Reverso proveedor
        PMPasoValoresATX VGSqlConn, "@t_ssn_corr2", 0, SQLINT4, str(VLSecTrnCorr2), "", "", True 'Reverso base local
    Else
        VLSecTrnCorr1 = "0"
    End If
    
    'PMPasoValoresATX VGSqlConn, "@o_sec_rise", 1, SQLINT4, "0", "OSecRise", ""
    PMPasoValoresATX VGSqlConn, "@o_sec_rise", 1, SQLVARCHAR, "0", "OSecRise", ""
    PMPasoValoresATX VGSqlConn, "@o_pmcn", 1, SQLINT4, str(VLSecTrnCorr1), "SecOssn", ""
    PMPasoValoresATX VGSqlConn, "@o_fecha_contable", 1, SQLVARCHAR, ("01/01/1900 00:00:00"), "Fecha Contable", ""
    PMPasoValoresATX VGSqlConn, "@o_autorisri", 1, SQLVARCHAR, Space(30), "AutorizacionSRI", ""
    PMPasoValoresATX VGSqlConn, "@o_fecvensri", 1, SQLVARCHAR, Space(30), "fevensri", ""
    PMPasoValoresATX VGSqlConn, "@o_nota_venta", 1, SQLVARCHAR, Space(15), "Nota_venta", ""
    PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, "0", "SecTrn", ""
    PMPasoValoresATX VGSqlConn, "@o_sec_reverso", 1, SQLINT4, "0", "SecOssnTS", ""

    If FMTransmitirRPCATX(VGSqlConn, "PSSRV1", "cob_procesador", "mp_pago_rise", True, "Transaccion Ok", "S", "N", "S", "135", "S", "S") = True Then
        PMChequeaATX VGSqlConn
        FMMapeaMatriz VGSqlConn, psRetorno
        
        PMTotalesBranch "135"
        FLTransmitir = True
        VLCambio% = False
        '----->Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 7)
        VTIndicadorSum = 1
        PMIniciaRegSum
        '<-----Sumadora
        
        'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
        If VGTipoEjecucion% <> CGReverso% Then
            VLFechaContable = Format(FMRetParamATX(VGSqlConn, 3), "mm/dd/yyyy")
            VLFechaProceso = Format(FMRetParamATX(VGSqlConn, 3)) ', "mm/dd/yyyy")
            VLautoSRI = FMRetParamATX(VGSqlConn, 1) 'psRetorno(1, 4)
            VLautoriSri = FMRetParamATX(VGSqlConn, 4)
            VLFecvenSRI = FMRetParamATX(VGSqlConn, 5)
            VLSerie_Secuencia = FMRetParamATX(VGSqlConn, 6)
        End If
        
        
    
    Else
        VLCambio% = True
        FLTransmitir = False
        '----->Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 3)
        VTIndicadorSum = 0
        PMChequeaATX VGSqlConn
        PMFinTransaccion
        Exit Function
        'PMChequeaATX VGSqlConn
        '<-----Sumadora
    End If
    'PMChequeaATX VGSqlConn
   
    If FMRetStatusATX(VGSqlConn) <> 0 Then
       VTIndicadorSum = 1
       FLTransmitir = False
    End If
    PMChequeaATX VGSqlConn
    PMFinTransaccion
    
    'ame 08/04/2010
    If FLTransmitir = True Then
        'Ref03 Ini
        If VLDeb_com = 0 Then
          Call PLFactura
        End If
        'Ref03 Fin
    End If
    
    '----->Sumadora
    If VGTipoEjecucion% <> CGReverso% Then   'Validacion por REVERSO
        If (VTIndicadorSum = 1 _
        And (Trim$(VGStatusCon) = "A" _
        Or Trim$(VGStatusCon) = "")) Then
           SGPrimeraVez = 0     ' ya no es primera vez
           PMGrabaDesglose str(VLTrn), CStr(SGUsar), VLCambio%
           If VLCambio% = True Then
              MsgBox "Error en la Grabacion del Desglose. Favor comuniquese con su Supervisor.", vbCritical, "Error de Sistema"
           End If
           SGActual = 1  'seteo Variable para borrar desglose
        ElseIf VTIndicadorSum = 0 Then
           SGActual = 0  'no borrar desglose en caso de Error en Transaccion
        End If
    ElseIf VTIndicadorSum = 1 Then                'Por REVERSO
        PMEgresoEfectivo SGUsar, VLTrn, val(VLSecTrnCorr2)   'VGSSNCorr&
    End If
    '<-----Sumadora
End Function
Private Sub Consulta_parametro_OSB()
    
    If VGTipoEjecucion% = CGReverso% Then
        VGTipoEjecucion% = CGNormal%
        PMChequeaATX VGSqlConn&
        PMInicioTransaccion
        PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "sv_servidor_servicios_soa", "", ""
        PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR, "V", "", ""
        PMPasoValoresATX VGSqlConn&, "@i_codigo", 0, SQLVARCHAR, "8369", "", ""
        If FMTransmitirRPCATX(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "", "N", "S", "I", "0", "N", "N") Then
            PMMapeaObjetoATX VGSqlConn&, txthorario
            vl_servidor_BUS = txthorario
        End If
        PMChequeaATX VGSqlConn&
        PMFinTransaccion
        VGTipoEjecucion% = CGReverso%
    Else
        PMInicioTransaccion
        PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "sv_servidor_servicios_soa", "", ""
        PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR, "V", "", ""
        PMPasoValoresATX VGSqlConn&, "@i_codigo", 0, SQLVARCHAR, "8369", "", ""
        If FMTransmitirRPCATX(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "", "N", "S", "I", "0", "N", "N") Then
            PMMapeaObjetoATX VGSqlConn&, txthorario
            vl_servidor_BUS = txthorario
        End If
        PMChequeaATX VGSqlConn&
        PMFinTransaccion
    End If
    
End Sub
Function FLTransmitirBUS() As Integer
    'FLTransmitirBUS = True
    Dim VTIndicadorSum As Integer
    SGUsar = Me.efe.Text + VLEfe_com
    VTIndicadorSum = 0
    FLTransmitirBUS = True
    
    If VGHorarioDif Then
       VLTrn = "3935"      'Transaccion de Horario Diferido
    Else
       VLTrn = "3934"      'Transaccion de Horario Normal
    End If
    VGTrn = IIf(VLTrn = "", 0, VLTrn)
    
    
    If VGTipoEjecucion% <> CGReverso% Then
        'VERIFICA MONTO MAXIMO
        PMInicioTransaccion
        PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 4050, "Trn", ""
        PMPasoValoresATX VGSqlConn, "@i_empresa", 0, SQLVARCHAR, "8369", "Empresa", ""
        PMPasoValoresATX VGSqlConn, "@i_codigo", 0, SQLVARCHAR, Me.txtRuc.Text, "Suministro", ""
        PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "CSP", "Canal", ""
        PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLVARCHAR, "T", "Opcion", ""
        PMPasoValoresATX VGSqlConn, "@i_aplcobis", 0, SQLVARCHAR, "S", "Aplicacion Cobis", ""
        PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLVARCHAR, "C", "Aplicacion Cobis", ""
        PMPasoValoresATX VGSqlConn, "@i_efectivo", 0, SQLMONEY, (CCur(Me.efe.Text)), "efectivo", ""
        PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, (CCur(Me.Loc.Text)), "cheque", ""
        PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, (CCur(Me.Debito.Text)), "debito", ""
        PMPasoValoresATX VGSqlConn, "@i_comision_efe", 0, SQLMONEY, (CCur(VLEfe_com)), "comision_efe", ""
        PMPasoValoresATX VGSqlConn, "@i_comision_chq", 0, SQLMONEY, (CCur(VLChq_com)), "comision_chq", ""
        PMPasoValoresATX VGSqlConn, "@i_comision_db", 0, SQLMONEY, (CCur(VLDeb_com)), "comision_deb", ""
          
        If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_val_servicios_varios", True, "Transaccion Ok", "S", "N", "N", "135", "S", "S") = True Then
            PMChequeaATX VGSqlConn&
            PMFinTransaccion
        Else
            VLCambio% = True
            FLTransmitirBUS = False
            VTIndicadorSum = 0
            PMChequeaATX VGSqlConn
            PMFinTransaccion
            Exit Function
        End If
    End If
   
    PMInicioTransaccion
    If VGTipoEjecucion% <> CGReverso% Then
        PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLVARCHAR, "N", "TCORR", ""
    End If
    'PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 62159, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, str(VLTrn), "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(FMObtenerMonedaForma("135")), "Moneda", ""
    PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Canal", ""
    PMPasoValoresATX VGSqlConn, "@i_operacion", 0, SQLVARCHAR, "P", "Canal", ""
    'PMPasoValoresATX VGSqlConn, "@i_operacion", 0, SQLCHAR, "P", "Operacion", ""
    PMPasoValoresATX VGSqlConn, "@i_identificacion", 0, SQLVARCHAR, Me.txtRuc.Text, "Identificacion", ""
    PMPasoValoresATX VGSqlConn, "@i_razon_soc", 0, SQLVARCHAR, Me.lblNombre.Caption, "Razon Social", ""
    'Formas de Pago(Efectivo  - Cheque - Debito - Subtotal - Comision - Total)
    PMPasoValoresATX VGSqlConn, "@i_efectivo", 0, SQLMONEY, (CCur(Me.efe.Text)), "Efectivo", ""
    PMPasoValoresATX VGSqlConn, "@i_valor", 0, SQLMONEY, (CCur(Me.efe.Text)), "Efectivo", ""
    PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, (CCur(Me.Loc.Text)), "Cheque", ""
    PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, (CCur(Me.Debito.Text)), "Debito", ""
    PMPasoValoresATX VGSqlConn, "@i_comision_db", 0, SQLMONEY, (CCur(VLDeb_com)), "comision_deb", ""
    PMPasoValoresATX VGSqlConn, "@i_subtotal", 0, SQLMONEY, (CCur(Me.TotalPagar.Text)), "SubTotal", ""
    'PMPasoValoresATX VGSqlConn, "@i_comision_tot", 0, SQLMONEY, (CCur(Me.Comision.Text)), "ComisionTotal", ""
    PMPasoValoresATX VGSqlConn, "@i_comision_tot", 0, SQLMONEY, (CCur(VLDeb_com)), "ComisionDebito", ""
    PMPasoValoresATX VGSqlConn, "@i_comision_efe", 0, SQLMONEY, (CCur(VLEfe_com)), "ComisionEfectivo", ""
    PMPasoValoresATX VGSqlConn, "@i_comision_chq", 0, SQLMONEY, (CCur(VLChq_com)), "ComisionCheque", ""
    PMPasoValoresATX VGSqlConn, "@i_total", 0, SQLMONEY, (CCur(Me.Total.Text) - CCur(Me.Comision.Text)), "Total", ""
    
    'LBP Inicio RECA-CC-SGC00025869
    If VLEfe_com > 0 And VLChq_com > 0 And VLDeb_com > 0 Then
        VGFormaPago = "EFE;" & Format(VLEfe_com, "#0.00") & "_" & "CHE;" & Format(VLChq_com, "#0.00") & "_" & "DEB;" & Format(VLDeb_com, "#0.00")
    ElseIf VLEfe_com > 0 And VLChq_com > 0 Then
        VGFormaPago = "EFE;" & Format(VLEfe_com, "#0.00") & "_" & "CHE;" & Format(VLChq_com, "#0.00")
    ElseIf VLEfe_com > 0 And VLDeb_com > 0 Then
        VGFormaPago = "EFE;" & Format(VLEfe_com, "#0.00") & "_" & "DEB;" & Format(VLDeb_com, "#0.00")
    ElseIf VLDeb_com > 0 And VLChq_com > 0 Then
        VGFormaPago = "DEB;" & Format(VLDeb_com, "#0.00") & "_" & "CHE;" & Format(VLChq_com, "#0.00")
    ElseIf VLEfe_com > 0 Then
        VGFormaPago = "EFE;" & Format(VLEfe_com, "#0.00")
    ElseIf VLChq_com > 0 Then
        VGFormaPago = "CHE;" & Format(VLChq_com, "#0.00")
    ElseIf VLDeb_com > 0 Then
        VGFormaPago = "DEB;" & Format(VLDeb_com, "#0.00")
    End If
    'LBP Fin RECA-CC-SGC00025869
    
    'CantCheques - TipoCta - Cta - NombreCta - Autorizacion - Secuencial Rise
    PMPasoValoresATX VGSqlConn, "@i_cant_cheques", 0, SQLVARCHAR, Me.CantChq.Text, "CantCheques", ""
    'msilvag: Inicio RECA-CC-SGC00030409 - Facturacion OffLine Debitos
    If Me.Debito.Text > 0 Then
        PMPasoValoresATX VGSqlConn, "@i_tipo_cta", 0, SQLVARCHAR, (CboTipCta.Text), "TipoCta", ""
        PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
    Else
        PMPasoValoresATX VGSqlConn, "@i_tipo_cta", 0, SQLVARCHAR, (VLTipCta_com), "TipoCta", ""
        PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (VLCta_com), "Cta", ""
    End If
    'PMPasoValoresATX VGSqlConn, "@i_tipo_cta", 0, SQLVARCHAR, (Me.CboTipCta.Text), "TipoCta", ""
    'PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Me.Cta.ClipText), "Cta", ""
    'msilvag Fin
    PMPasoValoresATX VGSqlConn, "@i_nombre_cta", 0, SQLVARCHAR, (Me.NomCta.Text), "NombreCta", ""
    PMPasoValoresATX VGSqlConn, "@i_autoriza", 0, SQLVARCHAR, VGAutoriza, "Autorizacion", ""
'    PMPasoValoresATX VGSqlConn, "@i_sec_rise", 0, SQLINT4, "0", "SecRise", ""
    PMPasoValoresATX VGSqlConn, "@i_sec_rise", 0, SQLVARCHAR, "0", "SecRise", ""
    'Parametros no necesarios
    'TipoId - Sucursal - Rubro - Comprobante
    PMPasoValoresATX VGSqlConn, "@i_tipoid", 0, SQLVARCHAR, "R", "TipoId", ""
    PMPasoValoresATX VGSqlConn, "@i_sucursal", 0, SQLVARCHAR, " ", "Sucursal", ""
    PMPasoValoresATX VGSqlConn, "@i_comprobante", 0, SQLVARCHAR, " ", "Comprobante", ""
    'Parametros del Proveedor
    'OfiBanco - ProBco - Usuario - Ruc - TPago - VPagado
    PMPasoValoresATX VGSqlConn, "@i_poficina_bco", 0, SQLINT2, str(VGOficina), "Oficina", ""
    PMPasoValoresATX VGSqlConn, "@i_provincia_bco", 0, SQLVARCHAR, VLProvincia, "Provincia", ""
    PMPasoValoresATX VGSqlConn, "@i_pusuario", 0, SQLVARCHAR, VGLogin, "Usuario", ""
    PMPasoValoresATX VGSqlConn, "@i_ruc", 0, SQLVARCHAR, Me.txtRuc.Text, "Ruc", ""
    If CCur(Me.TotalPagar.Text) = CCur(Me.txtCuotaFecha.Text) Then
        PMPasoValoresATX VGSqlConn, "@i_tipopago", 0, SQLVARCHAR, "A_LA_FECHA", "TPago", ""
        PMPasoValoresATX VGSqlConn, "@i_rubro", 0, SQLVARCHAR, "A_LA_FECHA", "Rubro", ""
        If VGTipoEjecucion% = CGReverso% Then
            VLDetalleFecha = txtTemp
        End If
        PMPasoValoresATX VGSqlConn, "@i_detalle", 0, SQLVARCHAR, VLDetalleFecha, "Detalle", ""
    Else
        PMPasoValoresATX VGSqlConn, "@i_rubro", 0, SQLVARCHAR, "GLOBAL", "Rubro", ""
        PMPasoValoresATX VGSqlConn, "@i_tipopago", 0, SQLVARCHAR, "GLOBAL", "TPago", ""
        If VGTipoEjecucion% = CGReverso% Then
            VLDetalleGlobal = txtTemp
        End If
        PMPasoValoresATX VGSqlConn, "@i_detalle", 0, SQLVARCHAR, VLDetalleGlobal, "Detalle", ""
    End If
    PMPasoValoresATX VGSqlConn, "@i_pvalorpago", 0, SQLINT4, str((Me.TotalPagar * 100)), "ValPag", ""
    PMPasoValoresATX VGSqlConn, "@i_cuotafecha", 0, SQLMONEY, str((Me.txtCuotaFecha * 100)), "CuotaFecha", ""
    PMPasoValoresATX VGSqlConn, "@i_cuotaglobal", 0, SQLMONEY, str((Me.txtCuotaGlobal * 100)), "CuotaFecha", ""
    PMPasoValoresATX VGSqlConn, "@i_pmcn", 0, SQLINT4, "0", "SecOss", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "P", "Opcion", ""
    PMPasoValoresATX VGSqlConn, "@i_tipocanal", 0, SQLVARCHAR, "VENTANILLA", "Canal", ""
    'Parametros de salida
    'Fecha Contable - Fecha Efectiva - Secuencial - Autorizacion - FechaSRI - Nota Venta - SecRise
     If VGTipoEjecucion% = CGReverso% Then
        VLSecTrnCorr1 = DatoSwitch("@o_ssn") '@o_pmcn
        VLSecTrnCorr2 = DatoSwitch("@o_ssn")
        PMPasoValoresATX VGSqlConn, "@t_ssn_corr1", 0, SQLINT4, str(VLSecTrnCorr1), "", "", True 'Reverso proveedor
        PMPasoValoresATX VGSqlConn, "@t_ssn_corr2", 0, SQLINT4, str(VLSecTrnCorr2), "", "", True 'Reverso base local
    Else
        VLSecTrnCorr1 = "0"
    End If
    
    'PMPasoValoresATX VGSqlConn, "@o_sec_rise", 1, SQLINT4, "0", "OSecRise", ""
    'PMPasoValoresATX VGSqlConn, "@o_sec_rise", 1, SQLVARCHAR, "0", "OSecRise", ""
    'PMPasoValoresATX VGSqlConn, "@o_pmcn", 1, SQLINT4, str(VLSecTrnCorr1), "SecOssn", ""
    'PMPasoValoresATX VGSqlConn, "@o_fecha_contable", 1, SQLVARCHAR, ("01/01/1900 00:00:00"), "Fecha Contable", ""
    'PMPasoValoresATX VGSqlConn, "@o_autorisri", 1, SQLVARCHAR, Space(30), "AutorizacionSRI", ""
    'PMPasoValoresATX VGSqlConn, "@o_fecvensri", 1, SQLVARCHAR, Space(30), "fevensri", ""
    'PMPasoValoresATX VGSqlConn, "@o_nota_venta", 1, SQLVARCHAR, Space(15), "Nota_venta", ""
    'PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, "0", "SecTrn", ""
    'PMPasoValoresATX VGSqlConn, "@o_sec_reverso", 1, SQLINT4, "0", "SecOssnTS", ""

    PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, "0", "OSecRise", ""
    PMPasoValoresATX VGSqlConn, "@o_autorisri", 1, SQLVARCHAR, "0", "AutorizacionSRI", ""
    PMPasoValoresATX VGSqlConn, "@o_fecvensri", 1, SQLVARCHAR, "0", "fevensri", ""
    PMPasoValoresATX VGSqlConn, "@o_nota_venta", 1, SQLVARCHAR, "0", "Nota_venta", ""
    PMPasoValoresATX VGSqlConn, "@o_fecha_contable", 1, SQLVARCHAR, "0", "Fecha_Contable", ""
    
    PMAParamBillAltaDenom  '<-- JPM lectora de billetes
    
    If FMTransmitirRPCATX(VGSqlConn, "BBTSSRV", "cob_procesador", "mp_pago_rise", True, "Transaccion Ok", "S", "N", "S", "135", "S", "S") = True Then
    'If FMTransmitirRPCATX(VGSqlConn, "PSSRV1", "cob_procesador", "mp_pago_rise", True, "Transaccion Ok", "S", "N", "S", "135", "S", "S") = True Then
        PMChequeaATX VGSqlConn
        FMMapeaMatriz VGSqlConn, psRetorno
        
        PMTotalesBranch "135"
        FLTransmitirBUS = True
        VLCambio% = False
        '----->Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 1) '7
        VTIndicadorSum = 1
        PMIniciaRegSum
        '<-----Sumadora
        
        'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
        If VGTipoEjecucion% <> CGReverso% Then
            VLFechaContable = Format(FMRetParamATX(VGSqlConn, 5), "mm/dd/yyyy") '5
            VLFechaProceso = Format(FMRetParamATX(VGSqlConn, 5)) ', "mm/dd/yyyy") '5
            VLautoSRI = FMRetParamATX(VGSqlConn, 2) '1
            VLautoriSri = FMRetParamATX(VGSqlConn, 2) '4
            VLFecvenSRI = FMRetParamATX(VGSqlConn, 3) '5
            VLSerie_Secuencia = FMRetParamATX(VGSqlConn, 1) '6
        End If
        
        
    
    Else
        VLCambio% = True
        FLTransmitirBUS = False
        '----->Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 1) '3
        VTIndicadorSum = 0
        PMChequeaATX VGSqlConn
        PMFinTransaccion
        Exit Function
        'PMChequeaATX VGSqlConn
        '<-----Sumadora
    End If
    'PMChequeaATX VGSqlConn
   
    If FMRetStatusATX(VGSqlConn) <> 0 Then
       VTIndicadorSum = 1
       FLTransmitirBUS = False
    End If
    PMChequeaATX VGSqlConn
    PMFinTransaccion
    
    'ame 08/04/2010
    If FLTransmitirBUS = True Then
        'JPM Lectora de Billetes -->
        If CCur(efe.Text) > 0 And ((VGDatPersBillAltDen.dataOK And VGTipoEjecucion = CGNormal%) Or VGTipoEjecucion = CGReverso%) Then
          'Call PMGuardarDsglsBillete("135", SGSecTrn$, VLTrn, rptBAD, CboTipCta.Text, Cta.ClipText)
          Call PMGuardarDsglsBillete("135", SGSecTrn$, VLTrn, rptBAD, "REC", "")
          lectoraBill.Limpiar
        End If
        'Ref03 Ini
        If VLDeb_com = 0 Then
          Call PLFactura
        End If
        'Ref03 Fin
    End If
    
    '----->Sumadora
    If VGTipoEjecucion% <> CGReverso% Then   'Validacion por REVERSO
        If (VTIndicadorSum = 1 _
        And (Trim$(VGStatusCon) = "A" _
        Or Trim$(VGStatusCon) = "")) Then
           SGPrimeraVez = 0     ' ya no es primera vez
           PMGrabaDesglose str(VLTrn), CStr(SGUsar), VLCambio%
           If VLCambio% = True Then
              MsgBox "Error en la Grabacion del Desglose. Favor comuniquese con su Supervisor.", vbCritical, "Error de Sistema"
           End If
           SGActual = 1  'seteo Variable para borrar desglose
        ElseIf VTIndicadorSum = 0 Then
           SGActual = 0  'no borrar desglose en caso de Error en Transaccion
        End If
    ElseIf VTIndicadorSum = 1 Then                'Por REVERSO
        PMEgresoEfectivo SGUsar, VLTrn, val(VLSecTrnCorr2)   'VGSSNCorr&
    End If
    '<-----Sumadora
    
End Function


Public Function DatoSwitch(tParametro) As String
    DatoSwitch = ""
    For i% = 1 To FReverso!grdValores(1).Rows - 1
        FReverso!grdValores(1).Row = i%
        FReverso!grdValores(1).Col = 6
        If FReverso!grdValores(1).Text = tParametro Then
            FReverso!grdValores(1).Row = i%
            FReverso!grdValores(1).Col = 2
            DatoSwitch = FReverso!grdValores(1).Text
            Exit For
        End If
    Next i%
End Function

Public Sub PLImprimirComprobante()

    If VLTotCom > 0 And VGTipoEjecucion = CGNormal% Then
    
        VGparlong$ = "66"  'smerino
        VGpartop$ = "00"
        VGparleft$ = "07" '05
        VGparrig$ = "00"
    
    
    
         'smerino cambia formato de fecha de emision
        Dim Mes As String
        Dim dia As String
        Dim Anio As String
        Dim mes2 As String
        
        Mes = Mid(Format(VGFechaProceso, VGFormatoFecha$), 1, 2)
        dia = Mid(Format(VGFechaProceso, VGFormatoFecha$), 4, 2)
        Anio = Mid(Format(VGFechaProceso, VGFormatoFecha$), 7, 4)
        
        Select Case Mes
        Case Is = "01"
        mes2 = "Enero"
        Case Is = "02"
        mes2 = "Febrero"
        Case Is = "03"
           mes2 = "Marzo"
        Case Is = "04"
           mes2 = "Abril"
        Case Is = "05"
           mes2 = "Mayo"
        Case Is = "06"
           mes2 = "Junio"
        Case Is = "07"
           mes2 = "Julio"
        Case Is = "08"
           mes2 = "Agosto"
        Case Is = "09"
           mes2 = "Septiembre"
        Case Is = "10"
           mes2 = "Octubre"
        Case Is = "11"
           mes2 = "Noviembre"
        Case Is = "12"
           mes2 = "Diciembre"
       End Select
        
       VGFechaProceso2 = dia + "/" + mes2 + "/" + Anio
    
    
        PMSetDetalle "v" + "BANCO BOLIVARIANO C.A.     FACTURA"
        PMSetDetalle "v" + "RUC: " + " 0990379017001        " + "No. " + VLSerie_Secuencia
        PMSetDetalle "v" + "Junin 200 y Panama         " + "Aut. SRI :" + VLautoriSri
        PMSetDetalle "v" + "CONTRIBUYENTE ESPECIAL     " + "Fecha aut. :" + VLFecinivig
        PMSetDetalle "v" + "NOTIFICACION No. 39 de Julio 18 de 1995 " + "Valido hasta :" + VLFecfinvig
        PMSetDetalle "v" + "RESOLUCION No. 6925 de Julio 4 de 1995"
        PMSetDetalle "v" + "Sr.(es): " + (SGNombre)
        PMSetDetalle "v" + "CI/RUC: " + Replace(SGCedula, "_", "") + "   " + "Ofic.: " + VGDes_Oficina$
        'PMSetLineaImpresion "v" + "Costo Serv. Recaudacion  " + "Fecha: " + Format(VGFechaProceso, VGFormatoFecha$) + " " + Format(Now, VGFormatoHora$) + " " + IIf(VGHorarioDif, "H:D", "H:N")
        PMSetDetalle "v" + "Costo Serv. Recaudacion  " + "Fecha: " + VGFechaProceso2 + " " + IIf(VGHorarioDif, "H:D", "H:N")
        PMSetDetalle "v" + "Impuesto Fiscal RISE" + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 8, CGJustificacionDerecha)
        PMSetDetalle "v" + "Subtotal:    " + FMEspaciosATX(Format(VlbaseImp, VGFormatoMoney), 8, CGJustificacionDerecha) + " " + "Iva 12%: " + FMEspaciosATX(Format(VLiva, VGFormatoMoney), 8, CGJustificacionDerecha)
        PMSetDetalle "v" + "VALOR TOTAL: " + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 8, CGJustificacionDerecha) + " " + "Referencia: " + (Trim(txtRuc))
     If VLTipo_imp = "O" Then
        PMSetDetalle "v" + "Caj: " + VGLogin$ + "         " + "Original: Adquiriente"
     Else
        PMSetDetalle "v" + "Caj: " + VGLogin$ + "         " + "Copia: Emisor"
     End If
        

'        PMInicioImpresion "IMPRESORA_1"
'        PMBorrarDatosImpresion
'
'        VGparlong$ = "66"
'        VGpartop$ = "00"
'        VGparleft$ = "10"
'        VGparrig$ = "00"
'
'        PMSetLineaImpresion "x" + "Inserte COMPROBANTE Cobro Comision"
'        PMSetLineaImpresion "<"
'
'        PMSetLineaImpresion "!" & VGpartop$
'        PMSetLineaImpresion "%N" & VGparleft$
'
'
'        PMSetLineaImpresion "v" + "BANCO BOLIVARIANO S.A.     FACTURA"
'        PMSetLineaImpresion "v" + "RUC: " + " 0990379017001        " + "No. " + VLSerie_Secuencia
'        PMSetLineaImpresion "v" + "Junin 200 y Panama         " + "No.Autoriz.:" + VLautoriSri
'        PMSetLineaImpresion "v" + "CONTRIBUYENTE ESPECIAL     " + "Validez :" + VLFecvenSRI
'        PMSetLineaImpresion "v" + "NOTIFICACION No. 39 de Julio 18 de 1995"
'        PMSetLineaImpresion "v" + "RESOLUCION No. 6925 de Julio 4 de 1995"
'        PMSetLineaImpresion "v" + "Sr.(es): " + (SGNombre)
'        PMSetLineaImpresion "v" + "CI/RUC: " + Replace(SGCedula, "_", "") + "   " + "Ofic.: " + VGDes_Oficina$
'        'PMSetLineaImpresion "v" + "Costo Serv. Recaudacion  " + "Fecha: " + Format(VGFechaProceso, VGFormatoFecha$) + " " + Format(Now, VGFormatoHora$) + " " + IIf(VGHorarioDif, "H:D", "H:N")
'        PMSetLineaImpresion "v" + "Costo Serv. Recaudacion  " + "Fecha: " + Format(VGFechaProceso, VGFormatoFecha$) + " " + IIf(VGHorarioDif, "H:D", "H:N")
'        PMSetLineaImpresion "v" + "Impuesto Fiscal RISE" + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 8, CGJustificacionDerecha)
'        PMSetLineaImpresion "v" + "Subtotal:    " + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 8, CGJustificacionDerecha) + " " + "Iva 12%: " + FMEspaciosATX(Format(0, VGFormatoMoney), 8, CGJustificacionDerecha)
'        PMSetLineaImpresion "v" + "VALOR TOTAL: " + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 8, CGJustificacionDerecha) + " " + "Referencia: " + (Trim(txtRuc))
'     If VLTipo_imp = "O" Then
'        PMSetLineaImpresion "v" + "Caj: " + VGLogin$ + "         " + "Original: Adquiriente"
'     Else
'        PMSetLineaImpresion "v" + "Caj: " + VGLogin$ + "         " + "Copia: Emisor"
'     End If
'
'        PMSetLineaImpresion "v" + " "

        ' comenta ame 08/04/2010 cambio por facturas cobro comision
        
'        PMSetLineaImpresion "v" + "NOTA DE VENTA               ORIGINAL"
'        PMSetLineaImpresion "v" + "BCO.BOLIVARIANO " + "RUC.: " + " 0990379017001"
'
'        PMSetLineaImpresion "v" + "CONTRIBUYENTE ESPECIAL"
'        PMSetLineaImpresion "v" + "NOTIFICACION No. 39 de Julio 18 de 1995"
'        PMSetLineaImpresion "v" + "RESOLUCION No. 6925 de Julio 4 de 1995"
'
'        PMSetLineaImpresion "v" + "Autoriz.:" + Trim(VLautoriSri) + " Doc.: " + VLSerie_Secuencia
'
'        PMSetLineaImpresion "v" + "Valido Hasta :" + VLFecvenSRI
'
''        PMSetLineaImpresion "v" + "Direccion Matriz : " + "Junin 200 y Panama "
''        PMSetLineaImpresion "v" + "Oficina : " + VGDes_Oficina$ + " " + IIf(VGHorarioDif, "H:D", "H:N") + " " + IIf(VGTipoEjecucion = CGReverso, "REVERSO", "")
''        PMSetLineaImpresion "v" + "Caj: " + VGLogin$ + " " + "Fecha: " + Format(VGFechaProceso, VGFormatoFecha$) + " " + Format(Now, VGFormatoHora$)
''
''        PMSetLineaImpresion "v" + "Cliente Final: " + (SGCedula) + " " + FMEspaciosATX(Format(TotalPagar.Text, VGFormatoMoney), 18, CGJustificacionDerecha)
'
'        PMSetLineaImpresion "v" + "Oficina: " + VGDes_Oficina$ + " " + "Dir.Matriz : " + "Junin 200 y Panama"
'        PMSetLineaImpresion "v" + "Caj: " + VGLogin$ + " " + "Fecha: " + Format(VGFechaProceso, VGFormatoFecha$) + " " + Format(Now, VGFormatoHora$) + "  " + IIf(VGHorarioDif, "H:D", "H:N")
'        PMSetLineaImpresion "v" + "Nombre: " + (VLNombre)
'        PMSetLineaImpresion "v" + "C.I/RUC: " + (SGCedula)
'
'        PMSetLineaImpresion "v" + "Servicio Recaudacion Imptos. Fiscales: " + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 8, CGJustificacionDerecha)
'        VTEf$ = ""
'        VTCh$ = ""
'        TotalImp = ""
'        If FMCCurATX((VLEfe_com)) > 0 Then
'            VTEf$ = "EFE.: " + FMEspaciosATX(Format(VLEfe_com, VGFormatoMoney), 5, CGJustificacionDerecha) + " "
'        End If
'        If FMCCurATX((VLChq_com)) > 0 Then
'            VTCh$ = "CHQ.: " + FMEspaciosATX(Format(VLChq_com, VGFormatoMoney), 5, CGJustificacionDerecha)
'        End If
''        TotalImp = "     TOTAL: " + FMEspaciosATX(Format(Me.Total, VGFormatoMoney), 5, CGJustificacionDerecha)
''        If VTEf$ <> "" Or VTCh$ <> "" Then
''           PMSetLineaImpresion "v" + VTEf$ + VTCh$ + "     TOTAL: " + FMEspaciosATX(Format(Total.Text, VGFormatoMoney), 12, CGJustificacionDerecha)
''        End If
'
'        If VTEf$ <> "" Or VTCh$ <> "" Then
'           PMSetLineaImpresion "v" + VTEf$ + VTCh$
'        End If
'
'
'        PMSetLineaImpresion "v" + "PAGO TOTAL: " + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 8, CGJustificacionDerecha)
'        'PMSetLineaImpresion "v" + "PAGO TOTAL: " + FMEspaciosATX(FMObtenerSimbolo("135") + Format(FMCCurATX(Total), VGFormatoMoney), 35, CGJustificacionDerecha)
'        PMSetLineaImpresion "v" + " "
        VLEfe_com = "0"
        If VGModeloImp$ = "590" Then
            PMSetDetalle "%R" & 2
        End If
'
'        PMSetLineaImpresion ">"
'
'        PMImprimir "IMPRESORA_1", False
'        PMFinImpresion "IMPRESORA_1"
        ' VGHorarioDif = VLHorarioDifTemporal 'comenta ame 08/17/2010
FMPRN_StdImpresion "IMPRESORA_1", False, "", "135", SGDatosDetalle, "Inserte COMPROBANTE Cobro Comision", CStr(VGpartop$), 1, CStr(VGparleft$), , , , , False, , VLTrn
End If
End Sub


Public Sub PLImprimirComprobantePago()

    PMInicioImpresion "IMPRESORA_1"
    PMBorrarDatosImpresion

    VGparlong$ = "66"
    VGpartop$ = "00"
    VGparleft$ = "10"
    VGparrig$ = "02"

    PMSetLineaImpresion "x" + "Inserte COMPROBANTE de pago"
    PMSetLineaImpresion "<"

    PMSetLineaImpresion "!" & VGpartop$
    PMSetLineaImpresion "%N" & VGparleft$
    
    PMSetLineaImpresion "v" + CStr(VGTSN%) + " " + Format(VGFechaProceso, VGFormatoFecha$) + " " + Format(Now, VGFormatoHora$) + " " + CStr(VGOficina%) + " " + CStr(FMObtenerNombreMoneda(1)) + " USD " + VGLogin$
    'Poner en fecha contable la fecha y la hora
    PMSetLineaImpresion "v" + "BCO. BOLIVARIANO " + "SEC.: " + Format(VLFechaProceso, "MMDDYYYYHHMMSS", vbUseSystemDayOfWeek, vbUseSystem) '" 0990379017001"
    If VGHorarioDif = True Then
        If VGTipoEjecucion% = CGReverso% Then
            PMSetLineaImpresion "v" + "REVERSO ON " + str(VGTrn) + " SRI IMPUESTO RISE  H:D"
        Else
            PMSetLineaImpresion "v" + "ON " + str(VGTrn) + " SRI IMPUESTO RISE  H:D"
        End If
    Else
        If VGTipoEjecucion% = CGReverso% Then
            PMSetLineaImpresion "v" + "REVERSO ON " + str(VGTrn) + " SRI IMPUESTO RISE  H:N"
        Else
            PMSetLineaImpresion "v" + "ON " + str(VGTrn) + " SRI IMPUESTO RISE  H:N"
        End If
    End If
    PMSetLineaImpresion "v" + "Este pago sera procesado el " + VGFechaProceso
        
    PMSetLineaImpresion "v" + "RUC: " + txtRuc.Text + "      AUT: " + Trim(VLautoSRI)
    PMSetLineaImpresion "v" + "CONTRIBUYENTE: " + Mid(UCase(Me.lblNombre.Caption), 1, 25)
    'PMSetLineaImpresion "v" + "C.GLOBAL: U$ " + txtCuotaGlobal.Text + "      C.A LA FECHA: U$ " + Me.txtCuotaFecha.Text
    If CCur(Me.TotalPagar.Text) = CCur(txtCuotaFecha.Text) Then
        PMSetLineaImpresion "v" + "V.PAGADO (C.A LA FECHA): U$ " + Me.txtCuotaFecha.Text
        PMSetLineaImpresion "v" + "DETALLE: " + VLDetalleFecha
    Else
        PMSetLineaImpresion "v" + "V.PAGADO (C.GLOBAL): U$ " + Me.txtCuotaGlobal.Text
        PMSetLineaImpresion "v" + "DETALLE: " + VLDetalleGlobal
    End If
    
    If FMCCurATX((efe.Text)) > 0 And FMCCurATX((Loc.Text)) > 0 Then
        PMSetLineaImpresion "v" + "EFE.:       " + FMEspaciosATX(Format(efe.Text, VGFormatoMoney), 8, CGJustificacionIzquierda) + _
        "    " + " CHQ(" + Me.CantChq.Text + ").:       " + FMEspaciosATX(Format(Loc.Text, VGFormatoMoney), 8, CGJustificacionIzquierda) + " "
    ElseIf FMCCurATX((efe.Text)) = 0 Then
        PMSetLineaImpresion "v" + "CHQ(" + Me.CantChq.Text + ").:       " + FMEspaciosATX(Format(Loc.Text, VGFormatoMoney), 8, CGJustificacionIzquierda) + " "
    ElseIf FMCCurATX((Loc.Text)) = 0 Then
        PMSetLineaImpresion "v" + "EFE.:       " + FMEspaciosATX(Format(efe.Text, VGFormatoMoney), 8, CGJustificacionIzquierda)
    End If
    If FMCCurATX((Debito.Text)) > 0 Then
        PMSetLineaImpresion "v" + "DEB.:       " + FMEspaciosATX(Format(Debito.Text, VGFormatoMoney), 8, CGJustificacionIzquierda) + " " + "    " _
        + "CTA.:     " + FMEspaciosATX(Format(Cta.ClipText, "0000000000"), 8, CGJustificacionIzquierda) + " "
    End If
    
    PMSetLineaImpresion "v" + "TOTAL: U$   " + Me.TotalPagar.Text + "               " _
    + "IP " + FMEspaciosATX(Format(str$(VGTSN), "000"), 8, CGJustificacionIzquierda)
    
'***ref02 vmirandt inicio, se imprime al final del documento
    If VLclave_acceso <> "" Then
       PMSetLineaImpresion "v" + "Clave de Acceso/Autorizacion: "
       PMSetLineaImpresion "v" + VLclave_acceso
    End If
    'ref02 vmirandt
    
    PMSetLineaImpresion "v"
    If VGModeloImp$ = "590" Then
        PMSetLineaImpresion "%R" & 4
    End If

    PMSetLineaImpresion ">"
    
    PMImprimir "IMPRESORA_1", False
    
    PMFinImpresion "IMPRESORA_1"
    'VGHorarioDif = VLHorarioDifTemporal

    
End Sub

Private Sub Efe_Change()
    VLCambio% = True
End Sub

Private Sub Efe_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Valor en Efectivo"
   
    If SGActivaSum = False Then
        FSumIng.abrirAltaDenominacion = True
        PMIngresoEfectivo
        efe.Text = Format$(SGUsar, "####,###,##0.00")
        SGActual = 0
    Else
        SGActivaSum = False
    End If
    
End Sub

Private Sub Efe_KeyDown(KeyCode As Integer, Shift As Integer)
    Call Cambio(KeyCode, efe)
End Sub

Private Sub Efe_LostFocus()
    If SGActivaSum = True Then
        Exit Sub
    End If
    
    If VGDecimales$ = "S" And (FMObtenerDecimales(FMObtenerMonedaForma("134")) > 0) Then
        efe.Text = str(FMCCurATX((efe.Text)) / FMObtenerFactorDecimal(FMObtenerMonedaForma("134")))
    End If

    If efe.Text <> "" Or efe.Text <> "0.00" Then
        Total.Text = str(FMCCurATX((efe.Text)) + FMCCurATX((Me.Loc.Text)) + FMCCurATX((Debito.Text)) + FMCCurATX((Comision.Text)))
    End If
    
    'Sumadora ------>
    If CDbl(efe.Text) <> SGUsar Then
        MsgBox "El Monto Efetivo No Coincide con el Monto Desglosado para el Deposito. Verificar", vbCritical, "Mensaje del Sistema"
        efe.SetFocus
        efe.Text = Format$(SGUsar, "####,###,##0.00")
        SGActual = 0
    End If
    SGActivaSum = False
    '<------
End Sub

Private Sub CantChq_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Ingrese cantidad de Cheques"
End Sub

Private Sub CantChq_KeyDown(KeyCode As Integer, Shift As Integer)
    
    Select Case KeyCode%
        Case CGTeclaSUPR%
          CantChq.Text = ""
        Case CGTeclaENTER%
          SendKeys "{TAB}"
        Case CGTeclaHOME%
          PMCambiarForma Me
        Case CGTeclaUP%, CGTeclaREPAG%
          efe.SetFocus
        Case CGTeclaDOWN%, CGTeclaAVPAG%
          SendKeys "{TAB}"
    End Select
    
End Sub

Private Sub CantChq_LostFocus()
    If CantChq.Text >= "1" Then
        Loc.Enabled = True
        Loc.Text = "0.00"
        Loc.SetFocus
    Else
        CantChq.Text = ""
        Loc.Enabled = False
        Loc.Text = "0.00"
    End If
End Sub

Private Sub CboTipCta_Click()
    VLfirma = False
End Sub

Private Sub CboTipCta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Tipo de Cuenta"
End Sub

Private Sub CboTipCta_KeyDown(KeyCode As Integer, Shift As Integer)
    Call Cambio(KeyCode, CboTipCta)
End Sub

Private Sub Comision_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "F5 Detalle Comisión"
    SendKeys ("{HOME}+{END}")
End Sub


Private Sub Comision_KeyDown(KeyCode As Integer, Shift As Integer)
    Dim VLAcumulado As Currency
    If KeyCode% = CGTeclaF5% Then
         If Comision <> 0# Then
            SGComision = 0#
            SGTipoCta = ""
            SGCedula = ""
            
            'msilvag:Inicio RECA-CC-SGC00030409 - Facturacion OffLine Debitos
            SGNumCuenta = ""
            SGEmpresa = ""
            SGNumCuenta = Me.Cta.Text
            SGEmpresa = "RISE"
            'msilvag Fin
       
            VLAcumulado = SGAcumulado
            VGUsar15 = efe.ValueReal
            SGUsar = VLEfe_com
            SGComision = Comision
            SGTipoCta = FCC135.CboTipCta.ListIndex
            SGCedula = cedula
            SGValida = "S"
            
            FCC112.Show 1
           
            VLEfe_com = FCC112.VLEfe_com
            VLChq_com = FCC112.VLChq_com
            VLDeb_com = FCC112.VLDeb_com
            VLTipCta_com = FCC112.VLTipCta_com
            VLCta_com = FCC112.VLCta_com
            VLTotCom = VLEfe_com + VLChq_com + VLDeb_com
            SGUsar = VGUsar15
            
            VLNombre = SGNombre
            
            efe.ValueReal = SGUsar
            SGAcumulado = VLAcumulado
            VGUsar15 = VLEfe_com
        
         End If
    ElseIf KeyCode = CGTeclaSUPR% Then
        Exit Sub
    Else
        Call Cambio(KeyCode, Comision)
    End If
    
End Sub

Private Sub Comision_KeyPress(KeyAscii As Integer)
    KeyAscii% = 0
End Sub

Private Sub Cta_Change()
    VLCambio% = True
    VLfirma = False
End Sub

Private Sub Cta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Ingrese el Número de la Cuenta"
End Sub


Private Sub Cta_KeyDown(KeyCode As Integer, Shift As Integer)
    Select Case KeyCode%
        Case CGTeclaSUPR%
            If Cta.Enabled Then
                Cta.Clear
            End If
        Case CGTeclaUP%, CGTeclaREPAG%
            SendKeys "+{TAB}"
        Case CGTeclaDOWN%, CGTeclaAVPAG%
            SendKeys "{TAB}"
    End Select
End Sub

Private Sub Cta_LostFocus()
    On Error GoTo Error
    Dim VTTipoDatoCta As StructDatoCta
    If Cta.ClipText <> "" Then ' And VLfirma = False Then
        If VGTipoEjecucion% <> CGReverso% Then
            VLfirma = FMValidaFirma(VLfirma, Me.CboTipCta.Text, Cta, "134", Me.NomCta)
        End If
        VTTipoDatoCta = LoNombreCta(Me.CboTipCta.Text, Cta.ClipText, "134")
        Me.NomCta.Text = VTTipoDatoCta.NombreCta
        
        If VLfirma = False Then
              Debito.Text = ""
              Debito.Enabled = False
        Else
            Debito.Enabled = True
            Debito.SetFocus
        End If
    Else 'If VLfirma = False Then
        Debito.Text = ""
        Debito.Enabled = False
        Me.NomCta.Text = ""
    End If
    Exit Sub
Error:
    PMFinTransaccion
    MsgBox Err.Description, vbExclamation, App.Title
End Sub

Private Sub Debito_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Valor del Debito a Cuenta"
    SendKeys ("{HOME}+{END}")
End Sub

Private Sub Debito_KeyDown(KeyCode As Integer, Shift As Integer)
    Call Cambio(KeyCode, Debito)
End Sub

Private Sub Debito_LostFocus()
    If Debito.Text <> "" Or Debito.Text <> "0.00" Then
        Total.Text = str(FMCCurATX((efe.Text)) + FMCCurATX((Me.Loc.Text)) + FMCCurATX((Debito.Text)) + FMCCurATX((Comision.Text)))
    End If
End Sub

Private Sub Loc_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Ingrese el valor en cheques"
    SendKeys ("{HOME}+{END}")
End Sub

Private Sub Loc_KeyDown(KeyCode As Integer, Shift As Integer)
    Call Cambio(KeyCode, Loc)
End Sub

Private Sub Loc_LostFocus()
    'If VGTotalizar$ = "S" Then
        If Loc.Text <> "" Or Loc.Text <> "0.00" Then
            Total.Text = str(FMCCurATX((efe.Text)) + FMCCurATX((Me.Loc.Text)) + FMCCurATX((Debito.Text)) + FMCCurATX((Comision.Text)))
        End If
    'End If
End Sub

Private Sub txtRuc_KeyPress(KeyAscii As Integer)
    If ((KeyAscii% < 48) Or (KeyAscii% > 57)) And (KeyAscii%) <> 8 Then
        KeyAscii% = 0
    End If
End Sub


