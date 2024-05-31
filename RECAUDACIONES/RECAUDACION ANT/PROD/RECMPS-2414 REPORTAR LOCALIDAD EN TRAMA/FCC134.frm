VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "GRID32.OCX"
Object = "{0F1F1508-C40A-101B-AD04-00AA00575482}#1.0#0"; "mhrinp32.ocx"
Object = "{DECFDD03-1E4B-11D1-B65E-0000C039C248}#5.0#0"; "mskedit.ocx"
Object = "{00025600-0000-0000-C000-000000000046}#5.2#0"; "crystl32.ocx"
Begin VB.Form FCC134 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Recaudación de Citaciones y Trámites 134CTG - 134"
   ClientHeight    =   6465
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4980
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   6465
   ScaleWidth      =   4980
   Begin VB.Frame frmFrame 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   4455
      Index           =   1
      Left            =   0
      TabIndex        =   15
      Top             =   1680
      Width           =   4935
      Begin MSGrid.Grid grdDetalle 
         Height          =   375
         Left            =   2760
         TabIndex        =   46
         Top             =   4080
         Visible         =   0   'False
         Width           =   1935
         _Version        =   65536
         _ExtentX        =   3413
         _ExtentY        =   661
         _StockProps     =   77
         BackColor       =   16777215
      End
      Begin VB.TextBox CantChq 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   1530
         MaxLength       =   3
         TabIndex        =   5
         Top             =   555
         Width           =   525
      End
      Begin VB.ComboBox CboTipCta 
         Height          =   315
         ItemData        =   "FCC134.frx":0000
         Left            =   1530
         List            =   "FCC134.frx":000A
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Tag             =   "CboProd"
         Top             =   855
         Width           =   1305
      End
      Begin VB.TextBox NomCta 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Enabled         =   0   'False
         Height          =   285
         Left            =   1530
         TabIndex        =   19
         Top             =   1215
         Width           =   3090
      End
      Begin MhinrelLib.MhRealInput Efe 
         Height          =   285
         Left            =   1560
         TabIndex        =   4
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
         Left            =   1560
         TabIndex        =   9
         Top             =   1560
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
         Left            =   2895
         TabIndex        =   8
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
      Begin MhinrelLib.MhRealInput Credito 
         Height          =   285
         Left            =   1560
         TabIndex        =   10
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
      Begin MhinrelLib.MhRealInput TotalPagar 
         Height          =   285
         Left            =   1530
         TabIndex        =   11
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
         SpinChangeReal  =   0
         AutoHScroll     =   -1  'True
         CaretColor      =   -2147483642
         DecimalPlaces   =   2
         Separator       =   -1  'True
      End
      Begin MhinrelLib.MhRealInput Comision 
         Height          =   285
         Left            =   1320
         TabIndex        =   12
         ToolTipText     =   "Valor Total de la Transacción"
         Top             =   2880
         Width           =   1110
         _Version        =   65536
         _ExtentX        =   1958
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
         Left            =   3240
         TabIndex        =   13
         ToolTipText     =   "Valor Total de la Transacción"
         Top             =   2880
         Width           =   1380
         _Version        =   65536
         _ExtentX        =   2434
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
         Left            =   2880
         TabIndex        =   6
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
      Begin VB.TextBox txtTemp 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   120
         MaxLength       =   13
         TabIndex        =   34
         Top             =   4200
         Visible         =   0   'False
         Width           =   255
      End
      Begin Crystal.CrystalReport rptBAD 
         Left            =   1395
         Top             =   2520
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
         Left            =   225
         TabIndex        =   45
         Top             =   2610
         Visible         =   0   'False
         Width           =   900
      End
      Begin VB.Label lbl_pagosri 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Pago SRI :"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   120
         TabIndex        =   44
         Top             =   4010
         Visible         =   0   'False
         Width           =   945
      End
      Begin VB.Label txt_pagosri 
         Appearance      =   0  'Flat
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   285
         Left            =   1320
         TabIndex        =   43
         Top             =   3960
         Visible         =   0   'False
         Width           =   1260
      End
      Begin VB.Label txt_atm 
         Appearance      =   0  'Flat
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   285
         Left            =   3720
         TabIndex        =   42
         Top             =   3600
         Visible         =   0   'False
         Width           =   900
      End
      Begin VB.Label txt_reg_nacional 
         Appearance      =   0  'Flat
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   285
         Left            =   1320
         TabIndex        =   41
         Top             =   3600
         Visible         =   0   'False
         Width           =   1260
      End
      Begin VB.Label lbl_reg_nacional 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Reg Nacional:"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   0
         TabIndex        =   40
         Top             =   3720
         Visible         =   0   'False
         Width           =   1230
      End
      Begin VB.Label lbl_atm 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "ATM:"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   3000
         TabIndex        =   39
         Top             =   3720
         Visible         =   0   'False
         Width           =   465
      End
      Begin VB.Label lbl_citaciones2 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Citaciones:"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   2760
         TabIndex        =   38
         Top             =   3510
         Visible         =   0   'False
         Width           =   960
      End
      Begin VB.Label txtNombre 
         Appearance      =   0  'Flat
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   285
         Left            =   1320
         TabIndex        =   33
         Top             =   3195
         Width           =   3300
      End
      Begin VB.Label lblNombre 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Nombre:"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   240
         TabIndex        =   32
         Top             =   3195
         Width           =   720
      End
      Begin VB.Label lblValor 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Total:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   7
         Left            =   2640
         TabIndex        =   31
         Top             =   2925
         Width           =   510
      End
      Begin VB.Label txtCitaciones 
         Appearance      =   0  'Flat
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   285
         Left            =   1320
         TabIndex        =   30
         Top             =   3510
         Width           =   3300
      End
      Begin VB.Label lblCitaciones 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Citaciones:"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   240
         TabIndex        =   29
         Top             =   3510
         Width           =   960
      End
      Begin VB.Label lblValor 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Comisión:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   6
         Left            =   240
         TabIndex        =   28
         Top             =   2925
         Width           =   825
      End
      Begin VB.Label ValPago 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Total a Pagar:"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   240
         TabIndex        =   27
         Top             =   2205
         Width           =   1230
      End
      Begin VB.Label lblCredito 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Tarj. Credito:"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   240
         TabIndex        =   26
         Top             =   1920
         Width           =   1125
      End
      Begin VB.Label LblDebito 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Débito:"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   240
         TabIndex        =   25
         Top             =   1575
         Width           =   630
      End
      Begin VB.Label LblCuenta 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "ND a cta:"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   240
         TabIndex        =   24
         Top             =   915
         Width           =   840
      End
      Begin VB.Label lblLoc 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Cheques:"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   2085
         TabIndex        =   23
         Top             =   600
         Width           =   810
      End
      Begin VB.Label lblEfe 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Efectivo:"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   240
         TabIndex        =   22
         Top             =   285
         Width           =   900
      End
      Begin VB.Label lblCantchq 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Cant.Cheques:"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   240
         TabIndex        =   21
         Top             =   600
         Width           =   1260
      End
      Begin VB.Label LblNomCta 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Nombre Cta:"
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   240
         TabIndex        =   20
         Top             =   1260
         Width           =   1065
      End
   End
   Begin VB.Frame frmFrame 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1695
      Index           =   0
      Left            =   0
      TabIndex        =   14
      Top             =   0
      Width           =   4935
      Begin VB.ComboBox CboTipo 
         Height          =   315
         ItemData        =   "FCC134.frx":0018
         Left            =   2560
         List            =   "FCC134.frx":001A
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Tag             =   "CboProd"
         Top             =   1200
         Visible         =   0   'False
         Width           =   2280
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   1
         Left            =   2565
         MaxLength       =   5
         TabIndex        =   0
         Top             =   240
         Width           =   555
      End
      Begin VB.TextBox txtIngreso 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   0
         Left            =   2570
         MaxLength       =   13
         TabIndex        =   3
         Top             =   840
         Width           =   2280
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   0
         Left            =   2570
         MaxLength       =   8
         TabIndex        =   1
         Top             =   550
         Width           =   555
      End
      Begin VB.Image Image3 
         Height          =   960
         Left            =   240
         Picture         =   "FCC134.frx":001C
         Top             =   120
         Visible         =   0   'False
         Width           =   870
      End
      Begin VB.Label lblTipoID 
         Caption         =   "Identificacion:"
         ForeColor       =   &H00800000&
         Height          =   255
         Left            =   1320
         TabIndex        =   37
         Top             =   1200
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.Image Image2 
         Height          =   765
         Left            =   120
         Picture         =   "FCC134.frx":2C5E
         Stretch         =   -1  'True
         Top             =   240
         Visible         =   0   'False
         Width           =   1155
      End
      Begin VB.Image Image1 
         Height          =   825
         Left            =   240
         Picture         =   "FCC134.frx":71C4
         Stretch         =   -1  'True
         Top             =   120
         Width           =   900
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   1
         Left            =   3150
         TabIndex        =   36
         Top             =   240
         Width           =   1695
      End
      Begin VB.Label Label 
         Caption         =   "Institucion:"
         ForeColor       =   &H00800000&
         Height          =   255
         Index           =   1
         Left            =   1320
         TabIndex        =   35
         Top             =   240
         Width           =   1095
      End
      Begin VB.Label lblCedula 
         Caption         =   "Ced/Ruc/Pas:"
         ForeColor       =   &H00800000&
         Height          =   255
         Left            =   1320
         TabIndex        =   18
         Top             =   915
         Width           =   1335
      End
      Begin VB.Label Label 
         Caption         =   "Tipo:"
         ForeColor       =   &H00800000&
         Height          =   255
         Index           =   0
         Left            =   1320
         TabIndex        =   17
         Top             =   590
         Width           =   855
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   0
         Left            =   3120
         TabIndex        =   16
         Top             =   555
         Width           =   1695
      End
   End
End
Attribute VB_Name = "FCC134"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'<-- JPM lectora de billetes (deshabilitar)'--=========================================================================--'
'--                                             Recaudaciones de la CTG
'--=========================================================================--'
'-- DISEÑADO POR:       GERMAN MEDINA C.
'-- FECHA ESCRITURA:    11/JUL/2008
'-- PROPOSITO:          Recaudaciones de la CTG
'--=========================================================================--'
'********************************************************************************'
'*              MODIFICACIONES                                                  *'
'* REF  FECHA       AUTOR          DESCRIPCION                                  *'
'*  02  19/Sep/2017 Vanessa Miranda FACOFF-AP-SGC00029747-SGC00029748 Agregar   *'
'*      Clave de Acceso Facturación Electrónica Offline                         *'
'********************************************************************************'

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
Dim VLCEP As String
Dim VLced As String
Dim VLCodCTG As String
Dim VLautoriSri As String
Dim VLFecvenSRI As String
Dim VLSerie_Secuencia As String
Dim VLSecTransac As Long
Dim VLTSN As Integer
Dim VLMsg As String
Dim VLTipo_imp As String        'ame 08/04/2010
Dim VLfact_elect As String      'ame 08/04/2010
Dim VLFecinivig As String       'sme 06/08/2011
Dim VLFecfinvig As String       'sme 06/08/2011
Dim VGFechaProceso2 As String   'sme 09/20/2011
Dim VLiva As Currency 'smerino iva
Dim VlbaseImp As Currency 'smerino iva
Dim VLTipoID As String 'dpereirv EPMTG
Dim VLCodBanco As String 'dpereirv EPMTG
Dim VLProvincia As String 'dpereirv EPMTG
Dim VLNombre_tramite As String 'dpereirv EPMTG
Dim VLNumCitaciones As String 'dpereirv EPMTG
Dim VLpcit_regional As String 'dpereirv EPMTG
Dim VLpcit_atm As String 'dpereirv EPMTG
Dim VLppago_sri As String 'dpereirv EPMTG
Dim VLSolicitud As String 'dpereirv EPMTG
Dim VLSsn As String
Dim VLSucursal As String
Dim VLFechaCorte As String
Dim VLCodAutorizacion As String
Dim VLTipoID_Placa As String
Dim VLIdentf_Placa As String
Dim VlRucEmp As String

Dim vl_servidor_BUS As String  'Migracion SOA msilvag
Dim vtmatrizcps(2, 60) As String
Dim VLclave_acceso As String 'ref02 vmirandt
'msilvag Inicio RECA-CC-SGC00030409 - Facturacion OffLine Debitos
Dim VLtipo_cta_com As String
Dim VLcuenta_com As String
Dim VLTipCta_com As String
Dim VLConvenio As String
Dim VLCta_com As String
Dim VLVISA_meses As String
Dim VLVISA_numtar As String
Dim VLVISA_ClaveUnicaTC As String
Dim VLVISA_nombre As String
Dim VLNumTranAutorizaVisa As String
Dim VLNumAutorizaVisa As String
Dim VLInteres As Currency
Dim VLDireccionOficina As String
Dim VLTelefonoOficina As String
Dim VLCiudadOficina As String
Dim vllocalidad As String
Dim vlnomprov As String

        
'VLTipCta_com = FCC112.VLTipCta_com
'VLCta_com = FCC112.VLCta_com
'msilvag Fin




Function FLTransmitirDatos() As Integer
    VLTrn = "3925"
    If VGHorarioDif = True Then
        If VLHorarioEmp = "N" Then
            If CCur(Loc) > 0 Then
                VLTrn = "3926"
            Else
                VLTrn = "3925"
            End If
        Else
            VLTrn = "3927"
        End If
    End If
    
    VGTrn = IIf(VLTrn = "", 0, VLTrn)
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "B", "", ""
    PMPasoValoresATX VGSqlConn, "@o_direccion_of", 1, SQLVARCHAR, "", "", ""
    PMPasoValoresATX VGSqlConn, "@o_telefono_of", 1, SQLVARCHAR, "", "", ""
    PMPasoValoresATX VGSqlConn, "@o_ciudad_of", 1, SQLVARCHAR, "", "", ""
    If FMTransmitirRPCATX(VGSqlConn, "", "cob_servicios", "sp_tr_pago_matrvehi_rc", True, "Transaccion Ok", "S", "N", "N", "134", "S", "S") = True Then
        VLDireccionOficina = FMRetParamATX(VGSqlConn, 1)  'dirección
        VLTelefonoOficina = FMRetParamATX(VGSqlConn, 2)   'teléfono
        VLCiudadOficina = FMRetParamATX(VGSqlConn, 3)     'ciudad
        '<-----
        PMChequeaATX VGSqlConn
        FLTransmitirDatos = True
    Else
        PMChequeaATX VGSqlConn
        FLTransmitirDatos = False
    End If
    PMChequeaATX VGSqlConn
    If FMRetStatusATX(VGSqlConn) <> 0 Then
        FLTransmitirDatos = False
    End If
    PMFinTransaccion
End Function

Public Sub PLCatalogo(ParOpcion1 As String, ParOpcion2 As String, ParOpcion3 As String, ParOpcion4 As String)
    On Error GoTo Error
    VGOperacion$ = ParOpcion1
    ReDim VTArreglo(10) As String
    Select Case ParOpcion3
    Case "0"
        PMInicioTransaccion
        txtCampo(val(ParOpcion2)).Text = ""
        lblDescripcion(val(ParOpcion2)).Caption = ""
        
        PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, ParOpcion1, "tabla", ""
        PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR, "A", "tipo", ""
        
        PMHelpG "cobis", "sp_hp_catalogo", 3, 1
        PMBuscarG 1, "@i_tabla", ParOpcion1, SQLVARCHAR
        PMBuscarG 2, "@i_tipo", "A", SQLCHAR
        PMBuscarG 3, "@i_modo", "1", SQLINT1
        PMSigteG 1, "@i_codigo", 1, SQLVARCHAR
        If FMTransmitirRPCATX(VGSqlConn, "", "cobis", "sp_hp_catalogo", True, "Consulta Ok...", "N", "N", "S", "0", "N", "N") Then
            PMMapeaGridATX VGSqlConn&, grid_valores.gr_SQL, False
            PMChequeaATX VGSqlConn&
            PMProcesG
            PMFinTransaccion
            grid_valores.bb_siguiente.Enabled = False
            grid_valores.Show 1
            txtCampo(val(ParOpcion2)).Text = Temporales(1)
            lblDescripcion(val(ParOpcion2)).Caption = Temporales(2)
            
            
            If Trim(txtCampo(1).Text) = "6388" Then 'dpereirv EPMTG
                Me.Image2.Visible = True
                Me.Image1.Visible = False
'                txtCampo(1).Enabled = False
                If txtCampo(0).Text = "1" Then 'dpereirv EPMTG
                    lblCitaciones.Visible = False
                    txtCitaciones.Visible = False
                    txtCitaciones.Caption = ""
                    Me.lblCedula.Caption = "No.Solicitud:"
                    txtIngreso(0).MaxLength = 20
                ElseIf txtCampo(Index).Text = "2" Then
                    lblCitaciones.Visible = True
                    txtCitaciones.Visible = True
                    txtCitaciones.Caption = ""
                    frmFrame(0).Height = 1695
                    frmFrame(1).Top = 1680
                    Me.lblCedula.Caption = "Codigo:"
                    lblCedula.Top = 1320
                    txtIngreso(0).Top = 1200
                    lblTipoID.Top = 915
                    CboTipo.Top = 875
                    lblTipoID.Visible = True
                    CboTipo.Visible = True
                End If
            Else
                Me.Image2.Visible = False
                Me.Image1.Visible = True
            End If
        
            
        End If
        
        PMFinTransaccion
        
    Case "1"
        If txtCampo(val(ParOpcion2)) <> "" Then
            PMInicioTransaccion
            PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, ParOpcion1, "tabla", ""
            PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR, "V", "tipo", ""
            PMPasoValoresATX VGSqlConn&, "@i_codigo", 0, SQLVARCHAR, ParOpcion4, "codigo", ""
            If FMTransmitirRPCATX(VGSqlConn, "", "cobis", "sp_hp_catalogo", True, "Consulta Ok...", "N", "N", "S", "0", "N", "N") Then
                PMMapeaObjetoATX VGSqlConn&, lblDescripcion(val(ParOpcion2))
                PMChequeaATX VGSqlConn&
            Else
                txtCampo(val(ParOpcion2)).Text = ""
                lblDescripcion(val(ParOpcion2)).Caption = ""
                txtCampo(val(ParOpcion2)).SetFocus
            End If
            PMFinTransaccion
        Else
            lblDescripcion(val(ParOpcion2)).Caption = ""
        End If
    End Select
    Exit Sub
Error:
    PMFinTransaccion
    MsgBox "Error: " & Err.Description, vbExclamation, App.Title
End Sub



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
        PMSetDetalle "v" + "CI/RUC: " + (Replace(SGCedula, "_", "")) + "   " + "Ofic.: " + VGDes_Oficina$
        'PMSetLineaImpresion "v" + "Costo Serv. Recaudacion  " + "Fecha: " + Format(VGFechaProceso, VGFormatoFecha$) + " " + Format(Now, VGFormatoHora$) + " " + IIf(VGHorarioDif, "H:D", "H:N")
        PMSetDetalle "v" + "Costo Serv. Recaudacion  " + "Fecha: " + VGFechaProceso2 + " " + IIf(VGHorarioDif, "H:D", "H:N")
        PMSetDetalle "v" + lblDescripcion(1).Caption + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 8, CGJustificacionDerecha)
        PMSetDetalle "v" + "Subtotal:      " + FMEspaciosATX(Format(VlbaseImp, VGFormatoMoney), 8, CGJustificacionDerecha) + "    " + "Iva 12%: " + FMEspaciosATX(Format(VLiva, VGFormatoMoney), 8, CGJustificacionDerecha) 'SMERINO IVA
        PMSetDetalle "v" + "VALOR TOTAL:   " + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 8, CGJustificacionDerecha) + "    " + "Referencia: " + (VLced) 'SMERINO IVA
     If VLTipo_imp = "O" Then
        PMSetDetalle "v" + "Caj: " + VGLogin$ + "              " + "Original: Adquiriente"
     Else
        PMSetDetalle "v" + "Caj: " + VGLogin$ + "              " + "Copia: Emisor"
     End If

    
'    'If VLTotCom > 0 Then
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
'        PMSetLineaImpresion "v" + "BANCO BOLIVARIANO S.A.     FACTURA"
'        PMSetLineaImpresion "v" + "RUC: " + " 0990379017001        " + "No. " + VLSerie_Secuencia
'        PMSetLineaImpresion "v" + "Junin 200 y Panama         " + "No.Autoriz.:" + VLautoriSri
'        PMSetLineaImpresion "v" + "CONTRIBUYENTE ESPECIAL     " + "Validez :" + VLFecvenSRI
'        PMSetLineaImpresion "v" + "NOTIFICACION No. 39 de Julio 18 de 1995"
'        PMSetLineaImpresion "v" + "RESOLUCION No. 6925 de Julio 4 de 1995"
'        PMSetLineaImpresion "v" + "Sr.(es): " + (SGNombre)
'        PMSetLineaImpresion "v" + "CI/RUC: " + (Replace(SGCedula, "_", "")) + "   " + "Ofic.: " + VGDes_Oficina$
'        'PMSetLineaImpresion "v" + "Costo Serv. Recaudacion  " + "Fecha: " + Format(VGFechaProceso, VGFormatoFecha$) + " " + Format(Now, VGFormatoHora$) + " " + IIf(VGHorarioDif, "H:D", "H:N")
'        PMSetLineaImpresion "v" + "Costo Serv. Recaudacion  " + "Fecha: " + Format(VGFechaProceso, VGFormatoFecha$) + " " + IIf(VGHorarioDif, "H:D", "H:N")
'        PMSetLineaImpresion "v" + lblDescripcion(1).Caption + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 8, CGJustificacionDerecha)
'        PMSetLineaImpresion "v" + "Subtotal:      " + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 8, CGJustificacionDerecha) + "    " + "Iva 12%: " + FMEspaciosATX(Format(0, VGFormatoMoney), 8, CGJustificacionDerecha)
'        PMSetLineaImpresion "v" + "VALOR TOTAL:   " + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 8, CGJustificacionDerecha) + "    " + "Referencia: " + (VLced)
'     If VLTipo_imp = "O" Then
'        PMSetLineaImpresion "v" + "Caj: " + VGLogin$ + "              " + "Original: Adquiriente"
'     Else
'        PMSetLineaImpresion "v" + "Caj: " + VGLogin$ + "              " + "Copia: Emisor"
'     End If
'
'        PMSetLineaImpresion "v" + " "

        
        
'        PMSetLineaImpresion "v" + "NOTA DE VENTA               ORIGINAL"
'        PMSetLineaImpresion "v" + "BCO.BOLIVARIANO " + "RUC.: " + " 0990379017001"
'
'        PMSetLineaImpresion "v" + "CONTRIBUYENTE ESPECIAL"
'        PMSetLineaImpresion "v" + "NOTIFICACION No. 39 de Julio 18 de 1995"
'        PMSetLineaImpresion "v" + "RESOLUCION No. 6925 de Julio 4 de 1995"
'
'        PMSetLineaImpresion "v" + "Autoriz.:" + VLautoriSri + " Doc.: " + VLSerie_Secuencia
'
'        PMSetLineaImpresion "v" + "Valido Hasta :" + VLFecvenSRI
'        PMSetLineaImpresion "v" + "Direccion Matriz : " + "Junin 200 y Panama "
'        PMSetLineaImpresion "v" + "Oficina : " + VGDes_Oficina$ + " " + IIf(VGHorarioDif, "H:D", "H:N") + " " + IIf(VGTipoEjecucion = CGReverso, "REVERSO", "")
'        PMSetLineaImpresion "v" + "Caj: " + VGLogin$ + " " + "Fecha: " + Format(VGFechaProceso, VGFormatoFecha$) + " " + Format(Now, VGFormatoHora$)
'
'        PMSetLineaImpresion "v" + "Cliente Final: " + (SGCedula) + " " + FMEspaciosATX(Format(TotalPagar.Text, VGFormatoMoney), 8, CGJustificacionDerecha)
'        If txtCampo(1).Text = "1" Then
'            PMSetLineaImpresion "v" + "Servicio Recaudacion CTG:    " + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 8, CGJustificacionDerecha)
'        Else
'            PMSetLineaImpresion "v" + "Servicio Recaudacion CNTTTSV:    " + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 8, CGJustificacionDerecha)
'        End If
'        VTEf$ = ""
'        VTCh$ = ""
'        If FMCCurATX((VLEfe_com)) > 0 Then
'            VTEf$ = "EFE.: " + FMEspaciosATX(Format(VLEfe_com, VGFormatoMoney), 12, CGJustificacionDerecha) + " "
'        End If
'        If FMCCurATX((VLChq_com)) > 0 Then
'            VTCh$ = "CHQ.: " + FMEspaciosATX(Format(VLChq_com, VGFormatoMoney), 12, CGJustificacionDerecha)
'        End If
'        If VTEf$ <> "" Or VTCh$ <> "" Then
'           PMSetLineaImpresion "v" + VTEf$ + VTCh$
'        End If
'        PMSetLineaImpresion "v" + "PAGO TOTAL: " + FMEspaciosATX(FMObtenerSimbolo("134") + Format(FMCCurATX(Total), VGFormatoMoney), 25, CGJustificacionDerecha)
'        PMSetLineaImpresion "v" + " "
'
        If VGModeloImp$ = "590" Then
            PMSetDetalle "%R" & 2
        End If
 
 FMPRN_StdImpresion "IMPRESORA_1", False, "", "134", SGDatosDetalle, "Inserte COMPROBANTE Cobro Comision", CStr(VGpartop$), 1, CStr(VGparleft$), , , , , False, , VLTrn

'        PMSetLineaImpresion ">"
'
'        PMImprimir "IMPRESORA_1", False
'        PMFinImpresion "IMPRESORA_1"
        ' VGHorarioDif = VLHorarioDifTemporal 'comenta ame 08/17/2010
End If
End Sub

Public Sub PLImprimirPapeleta()
    
    If VGTipoEjecucion% = CGReverso% Then
        Call PLConsultar("2")
    End If
        
    VGparlong$ = "61"
    VGpartop$ = "10"
    VGparleft$ = "10"
    VGparrig$ = "00"

    If VGTipoEjecucion% = CGReverso% Then
        PMSetDetalle "v" + "Este pago sera procesado el " + Mid(VLFechaProceso, 4, 2) & "/" & Mid(VLFechaProceso, 1, 2) & "/" & Mid(VLFechaProceso, 7, 4)
    Else
        PMSetDetalle "v" + "Este pago sera procesado el " + VLFechaProceso
    End If
    PMSetDetalle "v" + " "
    If txtCampo(1).Text = "1" Then
        PMSetDetalle "v" + "EMPRESA         : " + Trim$("2572 CTE")
    ElseIf txtCampo(1).Text = "18786" Then
        PMSetDetalle "v" + "EMPRESA         : " + Trim$("18786 ANT")
    Else
        PMSetDetalle "v" + "EMPRESA         : " + Trim$("2575 CNTTTSV")
    End If
    PMSetDetalle "v" + "TIPO SERVICIO   : " + Trim$(lblDescripcion(0).Caption)
    PMSetDetalle "v" + " "

    'Impresion de la Papeleta para Tramites - ini
    If txtCampo(1).Text = "1" Then
        If txtCampo(0).Text = 1 Then
            If Len(VLNombreTramite) > 60 Then
                PMSetDetalle "v" + "" + Space(Int(val(VGparlong) - Len(Mid(VLNombreTramite, 1, 60))) / 2) + Trim$(VLNombreTramite)
                PMSetDetalle "v" + "" + Space(Int(val(VGparlong) - Len(Mid(VLNombreTramite, 61, 60))) / 2) + Trim$(VLNombreTramite)
            Else
                PMSetDetalle "v" + "" + Space(Int(val(VGparlong) - Len(VLNombreTramite)) / 2) + Trim$(VLNombreTramite)
            End If
            PMSetDetalle "v" + "-------------------------------------------------------------"
    
            PMSetDetalle "v" + "COD. CEP CTE       : " + Trim$(Me.txtIngreso(0).Text)
            PMSetDetalle "v" + "CEDULA/RUC/PAS     : " + Trim$(VLced)
            PMSetDetalle "v" + "NOMBRE             : " + Trim$(Me.txtNombre.Caption)
            PMSetDetalle "v" + "CODIGO AUTORIZ CTE : " + Trim$(VLCodCTE)
            PMSetDetalle "v" + " "
            PMSetDetalle "v" + "VALOR TOTAL        : " + FMEspaciosATX("USD      " + Format(TotalPagar, VGFormatoMoney), 13, CGJustificacionDerecha)
            PMSetDetalle "v" + " "
            PMSetDetalle "v" + "FORMAS DE PAGO:"
            PMSetDetalle "v" + "-------------------------------------------------------------"
    
            If val(Efe.Text) > 0 Then
                PMSetDetalle "v" + "EFECTIVO           : " + FMEspaciosATX("USD      " + Format(Efe, VGFormatoMoney), 13, CGJustificacionDerecha)
            End If
            If val(Loc.Text) > 0 Then
                PMSetDetalle "v" + "CHEQUE(" + Trim$(CantChq.Text) + ")          : " + FMEspaciosATX("USD      " + Format(Loc, VGFormatoMoney), 13, CGJustificacionDerecha)
            End If
            If val(Debito.Text) > 0 Then
                PMSetDetalle "v" + "DEBITO             : " + FMEspaciosATX("USD      " + Format(Debito, VGFormatoMoney), 13, CGJustificacionDerecha) + " CTA DEBITO: " + Format(Cta.ClipText, "000-000000-0")
            End If
            If val(Credito.Text) > 0 Then
                PMSetDetalle "v" + "TARJETA CREDITO    : " + FMEspaciosATX("USD      " + Format(Credito, VGFormatoMoney), 13, CGJustificacionDerecha)
            End If
            PMSetDetalle "v" + "TOTAL              : " + FMEspaciosATX("USD      " + Format(Trim$(TotalPagar.Text), VGFormatoMoney), 13, CGJustificacionDerecha)
            PMSetDetalle "v" + "-------------------------------------------------------------"
            '***ref02 vmirandt inicio, se imprime al final del documento
            If VLclave_acceso <> "" Then
                PMSetDetalle "v" + "Clave de Acceso/Autorizacion: "
                PMSetDetalle "v" + VLclave_acceso
                PMSetDetalle "v" + "-------------------------------------------------------------"
            End If
            'ref02 vmirandt
    
            'Revisar respuesta de Ivan para el mensaje que es enviado de CTG
            PMSetDetalle "v" + "     AVISO: INGRESE comisiontransito.gob.ec PARA CONSULTAR EL"
            PMSetDetalle "v" + "                     ESTADO DE SU TRAMITE                    "
            'Ingrese a www.ctg.gov.ec para consultar el estado de su trámite
            PMSetDetalle "v" + "      " + VLMsg
            
        End If
        'Impresion de la Papeleta para Tramites - fin
    
        'Impresion de la Papeleta para Citaciones - ini
        If txtCampo(0).Text = 2 Then
            
            PMSetDetalle "v" + "" + Space(Int(val(VGparlong) - Len(VLNombreTramite)) / 2) + Trim$(VLNombreTramite)
            PMSetDetalle "v" + "-------------------------------------------------------------"
            PMSetDetalle "v" + "COD. CEP CTE       : " + Trim$(VLCEP)
            PMSetDetalle "v" + "CEDULA/RUC/PAS     : " + Trim$(VLced)
            PMSetDetalle "v" + "NOMBRE             : " + Trim$(Me.txtNombre.Caption)
            PMSetDetalle "v" + "CODIGO AUTORIZ CTE : " + Trim$(VLCodCTG)
            PMSetDetalle "v" + "CANT. CITACIONES   : " + Trim$(Me.txtCitaciones.Caption)
            PMSetDetalle "v" + " "
            PMSetDetalle "v" + "VALOR TOTAL        : " + FMEspaciosATX("USD      " + Format(TotalPagar, VGFormatoMoney), 13, CGJustificacionDerecha)
            PMSetDetalle "v" + " "
            PMSetDetalle "v" + "FORMAS DE PAGO:"
            PMSetDetalle "v" + "-------------------------------------------------------------"
    
            If val(Efe.Text) > 0 Then
                PMSetDetalle "v" + "EFECTIVO           : " + FMEspaciosATX("USD      " + Format(Efe, VGFormatoMoney), 13, CGJustificacionDerecha)
            End If
            If val(Loc.Text) > 0 Then
                PMSetDetalle "v" + "CHEQUE(" + Trim$(CantChq.Text) + ")          : " + FMEspaciosATX("USD      " + Format(Loc, VGFormatoMoney), 13, CGJustificacionDerecha)
            End If
            If val(Debito.Text) > 0 Then
                PMSetDetalle "v" + "DEBITO             : " + FMEspaciosATX("USD      " + Format(Debito, VGFormatoMoney), 13, CGJustificacionDerecha) + " CTA DEBITO: " + Format(Cta.ClipText, "000-000000-0")
            End If
            If val(Credito.Text) > 0 Then
                PMSetDetalle "v" + "TARJETA CREDITO    : " + FMEspaciosATX("USD      " + Format(Credito, VGFormatoMoney), 13, CGJustificacionDerecha)
            End If
            PMSetDetalle "v" + "TOTAL              : " + FMEspaciosATX("USD      " + Format(Trim$(TotalPagar.Text), VGFormatoMoney), 13, CGJustificacionDerecha)
    
            PMSetDetalle "v" + "      " + VLMsg
            PMSetDetalle "v" + "-------------------------------------------------------------"
            '***ref02 vmirandt inicio, se imprime al final del documento
            If VLclave_acceso <> "" Then
                PMSetDetalle "v" + "Clave de Acceso/Autorizacion: "
                PMSetDetalle "v" + VLclave_acceso
                PMSetDetalle "v" + "-------------------------------------------------------------"
            End If
            'ref02 vmirandt
        End If
    End If
    If txtCampo(1).Text = "2" Then
        'Impresion de la Papeleta para Citaciones - ini
        If txtCampo(0).Text = 1 Then
            PMSetDetalle "v" + "" + Space(Int(val(VGparlong) - Len(VLNombreTramite)) / 2) + Trim$(VLNombreTramite)
            PMSetDetalle "v" + "-------------------------------------------------------------"
            PMSetDetalle "v" + "COD. CEP CNTTTSV       : " + Trim$(VLCEP)
            PMSetDetalle "v" + "CEDULA/RUC/PAS     : " + Trim$(VLced)
            PMSetDetalle "v" + "NOMBRE             : " + Trim$(Me.txtNombre.Caption)
            PMSetDetalle "v" + "CODIGO AUTORIZ CNTTTSV : " + Trim$(VLCodCTG)
            PMSetDetalle "v" + "CANT. CITACIONES   : " + Trim$(Me.txtCitaciones.Caption)
            PMSetDetalle "v" + " "
            PMSetDetalle "v" + "VALOR TOTAL        : " + FMEspaciosATX("USD      " + Format(TotalPagar, VGFormatoMoney), 13, CGJustificacionDerecha)
            PMSetDetalle "v" + " "
            PMSetDetalle "v" + "FORMAS DE PAGO:"
            PMSetDetalle "v" + "-------------------------------------------------------------"
    
            If val(Efe.Text) > 0 Then
                PMSetDetalle "v" + "EFECTIVO           : " + FMEspaciosATX("USD      " + Format(Efe, VGFormatoMoney), 13, CGJustificacionDerecha)
            End If
            If val(Loc.Text) > 0 Then
                PMSetDetalle "v" + "CHEQUE(" + Trim$(CantChq.Text) + ")          : " + FMEspaciosATX("USD      " + Format(Loc, VGFormatoMoney), 13, CGJustificacionDerecha)
            End If
            If val(Debito.Text) > 0 Then
                PMSetDetalle "v" + "DEBITO             : " + FMEspaciosATX("USD      " + Format(Debito, VGFormatoMoney), 13, CGJustificacionDerecha) + " CTA DEBITO: " + Format(Cta.ClipText, "000-000000-0")
            End If
            If val(Credito.Text) > 0 Then
                PMSetDetalle "v" + "TARJETA CREDITO    : " + FMEspaciosATX("USD      " + Format(Credito, VGFormatoMoney), 13, CGJustificacionDerecha)
            End If
            PMSetDetalle "v" + "TOTAL              : " + FMEspaciosATX("USD      " + Format(Trim$(TotalPagar.Text), VGFormatoMoney), 13, CGJustificacionDerecha)
            
            PMSetDetalle "v" + "      " + VLMsg
            '***ref02 vmirandt inicio, se imprime al final del documento
            If VLclave_acceso <> "" Then
                PMSetDetalle "v" + "-------------------------------------------------------------"
                PMSetDetalle "v" + "Clave de Acceso/Autorizacion: "
                PMSetDetalle "v" + VLclave_acceso
            End If
            'ref02 vmirandt
            
        End If
    End If
    
    'KBastida Impresion Papeleta para ANT
    If txtCampo(1).Text = "18786" Then
        VLNombreTramite = Trim$(Me.txtNombre.Caption)
            PMSetDetalle "v" + "-------------------------------------------------------------"
    
            If txtCampo(0).Text = 3 Then
                PMSetDetalle "v" + "Orden Pago     : " + Trim$(Me.txtIngreso(0).Text)
            End If
            PMSetDetalle "v" + "CEDULA/RUC/PAS     : " + Trim$(Me.txtIngreso(0).Text)
            PMSetDetalle "v" + "NOMBRE             : " + Trim$(Me.txtNombre.Caption)
            'PMSetDetalle "v" + "CODIGO AUTORIZ     : " + Trim$(VLCodCTE)
            PMSetDetalle "v" + " "
            PMSetDetalle "v" + "VALOR TOTAL        : " + FMEspaciosATX("USD      " + Format(TotalPagar, VGFormatoMoney), 13, CGJustificacionDerecha)
            PMSetDetalle "v" + " "
            PMSetDetalle "v" + "FORMAS DE PAGO:"
            PMSetDetalle "v" + "-------------------------------------------------------------"
        
            If val(Loc.Text) > 0 Then
                PMSetDetalle "v" + "CHEQUE(" + Trim$(CantChq.Text) + ")          : " + FMEspaciosATX("USD      " + Format(Loc, VGFormatoMoney), 13, CGJustificacionDerecha)
            End If
            If val(Efe.Text) > 0 Then
                PMSetDetalle "v" + "EFECTIVO           : " + FMEspaciosATX("USD      " + Format(Efe, VGFormatoMoney), 13, CGJustificacionDerecha)
            End If
            If val(Debito.Text) > 0 Then
                PMSetDetalle "v" + "DEBITO             : " + FMEspaciosATX("USD      " + Format(Debito, VGFormatoMoney), 13, CGJustificacionDerecha) + " CTA DEBITO: " + Format(Cta.ClipText, "000-000000-0")
            End If
            If val(Credito.Text) > 0 Then
                PMSetDetalle "v" + "TARJETA CREDITO    : " + FMEspaciosATX("USD      " + Format(Credito, VGFormatoMoney), 13, CGJustificacionDerecha)
            End If
            PMSetDetalle "v" + "TOTAL              : " + FMEspaciosATX("USD      " + Format(Trim$(TotalPagar.Text), VGFormatoMoney), 13, CGJustificacionDerecha)
            PMSetDetalle "v" + "-------------------------------------------------------------"
            '***ref02 vmirandt inicio, se imprime al final del documento
            If VLclave_acceso <> "" Then
                PMSetDetalle "v" + "Clave de Acceso/Autorizacion: "
                PMSetDetalle "v" + VLclave_acceso
                PMSetDetalle "v" + "-------------------------------------------------------------"
            End If
    End If
    'KBastida
        
    'Impresion de la Papeleta para Citaciones - fin
    PMSetDetalle "v" + ""


    VLHorarioDifTemporal = VGHorarioDif
    If VGTipoEjecucion% <> CGReverso% Then
        If VGHorarioDif = False Then
            VLTrn = "3925"
            VLHorario = "N"
        End If
        If VGHorarioDif = True Then
            If VLHorarioEmp = "N" Then
                If CCur(Loc) > 0 Then
                    VLTrn = "3926"
                    VLHorar = "D"
                Else
                    VLTrn = "3925"
                    VLHorario = "N"
                End If
            Else
                VLTrn = "3927"
                VLHorario = "D"
            End If
        End If
    End If
    If VGTipoEjecucion% = CGReverso% Then
        If VGHorarioDif = False Then
            VLTrn = "3925"
            VLHorario = "N"
        Else
            VLTrn = "3927"
            VLHorario = "D"
        End If
    End If
    VLEtiqTrn = "RECAUDACIONES AUTOMOTRICES"
    FMPRN_StdImpresion "IMPRESORA_1", False, Trim$(str$(VLTSN)), "134", SGDatosDetalle, "Inserte papeleta", CStr(VGpartop$), 1, CStr(VGparleft$), , VLEtiqTrn, VLHorario, VLTrn, , FMObtenerMonedaForma("134"), VLTrn
    VGHorarioDif = VLHorarioDifTemporal
    
End Sub

Public Sub PLImprimirVoucher()
    Dim VlRelleno As Integer
    Dim VLNombreComercio As String
    Dim VLCodigoComercio As String
    Dim VLTotalPago As Currency
    VLNombreComercio = "PAGO SERV " + Trim$(lblDescripcion(0).Caption)
    VLCodigoComercio = "906785"
    VLTotalPago = VLInteres + Me.Credito.Text
    

    If VGModeloImp$ = "5021" Or VGModeloImp$ = "590" Then
        VGpartop$ = "7"  ' Ubica la impresion con margen superior de n. Contando de abajo hacia arriba
        VGparleft$ = "0"
    End If
    PMSetDetalle "v" + Space(16) + "        BANCO BOLIVARIANO C.A"
    PMSetDetalle "v" + Space(16) + "        ANT BANCO BOLIVARIANO"
    PMSetDetalle "v" + Space(16) + "         RUC 0990379017001"
    PMSetDetalle "v" + " "
    VlRelleno = 24 - Len(VGDes_Oficina$ + "(" + Trim$(str$(VGOficina)) + ")")
    
    'VlRelleno = 0
    VlRelleno = 24 - Len(VLCiudadOficina)
    PMSetDetalle "v" + "OFICINA        :" + VGDes_Oficina$ + "(" + Trim$(str$(VGOficina)) + ")" + String(VlRelleno, " ") + "FECHA EMISION   :" + Format(VGFechaProceso, VGFormatoFecha$)
    VlRelleno = 24 - Len(VLCiudadOficina)
    
    PMSetDetalle "v" + "LOCALIDAD      :" + VLCiudadOficina + String(VlRelleno, " ") + "HORA EMISION    :" + Format(Now, VGFormatoHora$)
    VlRelleno = 24 - Len(VLDireccionOficina)
    
    PMSetDetalle "v" + "DIREC/UBICACION:" + VLDireccionOficina + String(VlRelleno, " ") + "CODIGO COMERCIO : " + VLCodigoComercio
    VlRelleno = 24 - Len(VLTelefonoOficina)
    
    PMSetDetalle "v" + "TELEFONO       :" + VLTelefonoOficina + String(VlRelleno, " ")
    VlRelleno = 24 - Len(VGLogin)
    
    PMSetDetalle "v" + "OPERADOR       :" + VGLogin + String(VlRelleno, " ") + "SERVICIO PAGAR  : ANT VENTANILLA"
    PMSetDetalle "v" + " "
    
    PMSetDetalle "v" + "NUM.LOTE       :" + Format(VGFechaProceso, "yyyymmdd") + String(16, " ") + "NUM.AUTORIZACION: " + VLNumAutorizaVisa
    'VlRelleno = 23 - Len(VLVISA_fechaven)
    VlRelleno = 19 - Len(VLVISA_fechaven)
    If VlRelleno < 0 Then VlRelleno = 0
        PMSetDetalle "v" + "FEC.VENCIMIENTO:" + "XX/XX" + String(VlRelleno, " ") + "NUM.TARJETA:" + Mid$(VLVISA_numtar, 1, 6) + "XXXXXX" + Mid$(VLVISA_numtar, 13, 4)
        VlRelleno = 24 - Len(VLVISA_nombre)
    If VlRelleno < 0 Then VlRelleno = 0
        PMSetDetalle "v" + "NOMBRE CLIENTE :" + VLVISA_nombre + String(VlRelleno, " ")
    If VLVISA_tipoconsumo = "R" Then
        PMSetDetalle "v" + "TIPO CONSUMO   :ROTATIVO                MESES DIFERIR   : 0"
    Else
        PMSetDetalle "v" + "TIPO CONSUMO   :DIFERIDO CON INTERESES  MESES DIFERIR   : " + Trim$(str$(VLVISA_meses))
    End If
    PMSetDetalle "v" + "NUM.TRANSAC.   :" + VLNumTranAutorizaVisa
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + "BASE CONSUMO TARIFA 12%:" + FMEspaciosATX("us$" + Format("0", "##,###,##0.00"), 18, CGJustificacionDerecha)
    PMSetDetalle "v" + "BASE CONSUMO TARIFA 0%: " + FMEspaciosATX("us$" + Format((Me.Credito.Text), "##,###,##0.00"), 18, CGJustificacionDerecha)
    PMSetDetalle "v" + "SUBTOTAL DE CONSUMOS:   " + FMEspaciosATX("us$" + Format((Me.Credito.Text), "##,###,##0.00"), 18, CGJustificacionDerecha)
    
    PMSetDetalle "v" + "IVA 12%  :" + FMEspaciosATX("us$" + Format("0", "##,###,##0.00"), 32, CGJustificacionDerecha)
    PMSetDetalle "v" + "SUBTOTAL :" + FMEspaciosATX("us$" + Format((Me.Credito.Text), "##,###,##0.00"), 32, CGJustificacionDerecha)
    PMSetDetalle "v" + "INTERES  :" + FMEspaciosATX(Format(VLInteres, "##,###,##0.00"), 32, CGJustificacionDerecha) '
    PMSetDetalle "v" + "TOTAL    :" + FMEspaciosATX("us$" + Format((VLTotalPago), "##,###,##0.00"), 32, CGJustificacionDerecha)
    
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + "Debo y pagare al emisor incondicionalmente, y sin protesto el total de este"
    PMSetDetalle "v" + "pagare mas los intereses y cargos por servicio, en caso de mora pagare la tasa"
    PMSetDetalle "v" + "maxima autorizada para el emisor. Declaro que el producto de esta transaccion"
    PMSetDetalle "v" + "no sera utilizado en actividades de lavado de dinero y activo (ley 108)"
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + " "
    
    PMSetDetalle "v" + "Firma:___________________     Teléfono:_____________"
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + "Cédula:__________________"
    PMSetDetalle "v" + " "
    FMPRN_StdImpresion "IMPRESORA_1", False, "", "134", SGDatosDetalle, "Inserte comprobante voucher adquiriente", CStr(VGpartop$), 1, CStr(VGparleft$), , , , , False
    PMFinImpresion "IMPRESORA_1"
    
    Call PLImprimirVoucherCliente
    
End Sub
Sub PLFactura()
    'ame 08/03/2010
    
        '**************************************
    'GAMC - 02AGO10 - GUARDAR FACTURA - INI
    '**************************************
    If Comision.Text > 0 And VLDeb_com = 0# Then 'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
    Dim fr_secuencia As Long, fr_ssn As Long
    Dim fr_ced_ruc As String, fr_nombre As String, fr_fact_elect As String, fr_pto_estab As String, fr_pto_emis As String, _
        fr_fecha_validez As String, fr_nautorizacion As String, fr_valor As String, fr_iva As String, _
        fr_referencia As String, fr_servicio As String, nro_factura As String, fr_baseImp As String, fr_impresa As String, fr_fecha_ini_vig As String, fr_fecha_fin_vig As String 'SMERINO
    Dim fr_descuento As String, fr_forma_pag As String, fr_porc_compensa As String, fr_porc_iva As String 'LBP RECA-CC-SGC00025869 30/07/2016
    
    fr_ced_ruc = Replace(SGCedula, "_", "")     'Se obtiene de la pantalla de Comision
    fr_nombre = Trim(SGNombre)                  'Se obtiene de la pantalla de Comision
    fr_fact_elect = "S"
    fr_impresa = "S" 'smerino

    'LBP Inicio RECA-CC-SGC00025869 30/07/2016
    fr_descuento = VGCompensacion
    If fr_descuento > 0 Then
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

    fr_iva = VLiva    'smerino"0" cambios iva
    fr_baseImp = VlbaseImp 'smerino iva
    fr_referencia = (Me.txtIngreso(0).Text)
    fr_servicio = lblDescripcion(1).Caption
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
Public Sub PLImprimirVoucherCliente()
    '************* COPIA *************
     Dim VlRelleno As Integer
    Dim VLNombreComercio As String
    Dim VLCodigoComercio As String
    Dim VLTotalPago As Currency
    VLNombreComercio = "PAGO SERV " + Trim$(lblDescripcion(0).Caption)
    VLCodigoComercio = "906785"
    'VLInteres = 0.31
    'Me.Credito.Text = "11.90"
    VLTotalPago = VLInteres + Me.Credito.Text
    'VLVISA_meses = "3"
    
    If VGModeloImp$ = "5021" Or VGModeloImp$ = "590" Then
        VGpartop$ = "7"  ' Ubica la impresion con margen superior de n. Contando de abajo hacia arriba
        VGparleft$ = "0"
    End If
    PMSetDetalle "v" + Space(16) + "        BANCO BOLIVARIANO C.A"
    PMSetDetalle "v" + Space(16) + "        ANT BANCO BOLIVARIANO"
    PMSetDetalle "v" + Space(16) + "         RUC 0990379017001"
    PMSetDetalle "v" + Space(16) + "         COPIA - CLIENTE"
    PMSetDetalle "v" + " "
    VlRelleno = 24 - Len(VGDes_Oficina$ + "(" + Trim$(str$(VGOficina)) + ")")
    
    'VlRelleno = 0
    VlRelleno = 24 - Len(VLCiudadOficina)
    PMSetDetalle "v" + "OFICINA        :" + VGDes_Oficina$ + "(" + Trim$(str$(VGOficina)) + ")" + String(VlRelleno, " ") + "FECHA EMISION   :" + Format(VGFechaProceso, VGFormatoFecha$)
    VlRelleno = 24 - Len(VLCiudadOficina)
    
    PMSetDetalle "v" + "LOCALIDAD      :" + VLCiudadOficina + String(VlRelleno, " ") + "HORA EMISION    :" + Format(Now, VGFormatoHora$)
    VlRelleno = 24 - Len(VLDireccionOficina)
    
    PMSetDetalle "v" + "DIREC/UBICACION:" + VLDireccionOficina + String(VlRelleno, " ")
    VlRelleno = 24 - Len(VLTelefonoOficina)
    
    PMSetDetalle "v" + "TELEFONO       :" + VLTelefonoOficina + String(VlRelleno, " ")
    VlRelleno = 24 - Len(VGLogin)
    
    PMSetDetalle "v" + "OPERADOR       :" + VGLogin + String(VlRelleno, " ") + "SERVICIO PAGAR  : ANT VENTANILLA"
    PMSetDetalle "v" + " "
    
    PMSetDetalle "v" + "NUM.LOTE       :" + Format(VGFechaProceso, "yyyymmdd") + String(16, " ") + "NUM.AUTORIZACION: " + VLNumAutorizaVisa
    VlRelleno = 19 - Len(VLVISA_fechaven)
    If VlRelleno < 0 Then VlRelleno = 0
        PMSetDetalle "v" + "FEC.VENCIMIENTO:" + "XX/XX" + String(VlRelleno, " ") + "NUM.TARJETA:" + Mid$(VLVISA_numtar, 1, 6) + "XXXXXX" + Mid$(VLVISA_numtar, 13, 4)
        VlRelleno = 24 - Len(VLVISA_nombre)
    If VlRelleno < 0 Then VlRelleno = 0
        PMSetDetalle "v" + "NOMBRE CLIENTE :" + VLVISA_nombre + String(VlRelleno, " ")
    If VLVISA_tipoconsumo = "R" Then
        PMSetDetalle "v" + "TIPO CONSUMO   :ROTATIVO                MESES DIFERIR   : 0"
    Else
        PMSetDetalle "v" + "TIPO CONSUMO   :DIFERIDO CON INTERESES  MESES DIFERIR   : " + Trim$(str$(VLVISA_meses))
    End If
    PMSetDetalle "v" + "NUM.TRANSAC.   :" + VLNumTranAutorizaVisa
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + "TOTAL    :" + FMEspaciosATX("us$" + Format((VLTotalPago), "##,###,##0.00"), 18, CGJustificacionDerecha)
    
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + " "
    FMPRN_StdImpresion "IMPRESORA_1", False, "", "134", SGDatosDetalle, "Inserte comprobante voucher adquiriente", CStr(VGpartop$), 1, CStr(VGparleft$), , , , , False
    PMFinImpresion "IMPRESORA_1"
End Sub

Public Sub PLReverso()
   
    'Sumadora ----->
    SGPrimeraVezRev = 0
    '<----------
    PMSetValorReverso Me.txtCampo(1), "@i_emp"
    
    Call txtCampo_LostFocus(1)
    
    If Trim(txtCampo(1).Text) = 6388 Then
        PMSetValorReverso Me.txtCampo(0), "@i_servicio"
        Call txtCampo_LostFocus(0)
        
        PMSetValorReverso lblDescripcion(0), "@i_servname"
        PMSetValorReverso lblDescripcion(1), "@i_empname"
        PMSetValorReverso txtTemp, "@i_nomb_tramite"
        VLNombre_tramite = txtTemp
        txtTemp = ""
        PMSetValorReverso txtTemp, "@i_cantcit"
        VLNumCitaciones = txtTemp
        txtTemp = ""
        If Trim(txtCampo(0).Text) = "1" Then
            txtCitaciones = VLNombre_tramite
        Else
            txtCitaciones = VLNumCitaciones
        End If
        PMSetValorReverso Efe, "@i_efectivo"
        PMSetValorReverso Loc, "@i_cheque"
        PMSetValorReverso Debito, "@i_debito"
        PMSetValorReverso TotalPagar, "@i_subtotal"
        PMSetValorReverso Comision, "@i_comision_tot"
        PMSetValorReverso txtTemp, "@i_comision_efe"
        VLEfe_com = txtTemp
        txtTemp = ""
        PMSetValorReverso txtTemp, "@i_comision_chq"
        VLChq_com = txtTemp
        txtTemp = ""
        'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
        PMSetValorReverso txtTemp, "@i_comision_db"
        VLDeb_com = txtTemp
        txtTemp = ""
        'msilvag Fin
        PMSetValorReverso Total, "@i_total"
        PMSetValorReverso CantChq, "@i_cant_cheques"
        PMSetValorReverso CboTipCta, "@i_tipo_cta"
        PMSetValorReverso Cta, "@i_cuenta"
        PMSetValorReverso NomCta, "@i_nombre_cta"
        PMSetValorReverso txtIngreso(0), "@i_cod_cliente"
        PMSetValorReverso txtNombre, "@i_nombre_cliente"
        PMSetValorReverso txtTemp, "@i_ptipoId"
        VLTipoID = txtTemp
        txtTemp = ""
         Select Case VLTipoID
            Case "CED"
                CboTipo.ListIndex = 0
            Case "RUC"
                CboTipo.ListIndex = 1
            Case "PAS"
                CboTipo.ListIndex = 2
            Case ""
                CboTipo.ListIndex = 3
        End Select
        CboTipo.Enabled = False
        
        PMSetValorReverso txtTemp, "@o_pcodtrx"
        VLSsn = txtTemp
        txtTemp = ""
        PMSetValorReverso txtTemp, "@o_ssn"
        VLSecTransac = CLng(txtTemp)
        txtTemp = ""
        SGUsar = (CDbl(Efe.Text) + VLEfe_com)
        
        PMSetValorReverso txtTemp, "@o_fecha_contable"
        VLFechaContable = txtTemp
        txtTemp = ""
        VLTotCom = Me.Comision
 
        PMSetValorReverso txtTemp, "@i_psec_banco"
        VLSsn = txtTemp.Text
        txtTemp.Text = ""
        
        PMSetValorReverso txtTemp, "@o_ssn_recibo"
        VLCodAutorizacion = txtTemp.Text
        txtTemp.Text = ""
        
        PMSetValorReverso txtTemp, "@i_ptipoId"
        VLTipoID_Placa = txtTemp.Text
        txtTemp.Text = ""
        
        PMSetValorReverso txtTemp, "@i_pcodigo"
        VLIdentf_Placa = txtTemp.Text
        txtTemp.Text = ""
        
        PMSetValorReverso txt_reg_nacional, "@i_reg_nac"

        PMSetValorReverso txt_atm, "@i_atm"
        
        PMSetValorReverso txt_pagosri, "@i_pago_sri"
  
        
    ElseIf Trim(txtCampo(1).Text) = 18786 Then 'KBastida
    
        PMSetValorReverso Me.txtCampo(0), "@e_convenio" 
        If (Me.txtCampo(0) = "ANT-CIT") Then
            Me.txtCampo(0) = 1
        ElseIf (Me.txtCampo(0) = "ANT-CDP") Then 
            Me.txtCampo(0) = 2
        Else
            Me.txtCampo(0) = 3
        End If
        
        Call txtCampo_LostFocus(0)
        
        PMSetValorReverso txtTemp, "@e_nombre"
        VLNombre_tramite = txtTemp
        txtTemp = ""
        PMSetValorReverso txtTemp, "@e_concepto"
        VLNumCitaciones = txtTemp
        txtTemp = ""
        If Trim(txtCampo(0).Text) = "1" Then
            txtCitaciones = VLNombre_tramite
        Else
            txtCitaciones = VLNumCitaciones
        End If
        PMSetValorReverso Efe, "@e_efectivo"
        PMSetValorReverso Debito, "@e_debito"
        PMSetValorReverso Comision, "@e_comision_tot"
        PMSetValorReverso txtTemp, "@e_comision_efe"
        VLEfe_com = txtTemp
        txtTemp = ""
        PMSetValorReverso txtTemp, "@e_comision_chq"
        VLChq_com = txtTemp
        txtTemp = ""
        PMSetValorReverso txtTemp, "@e_comision_db"
        VLDeb_com = txtTemp
        txtTemp = ""
        PMSetValorReverso Total, "@e_total"
        
        PMSetValorReverso txtTemp, "@e_tipocta"
        
        If txtTemp = "CTE" Or txtTemp = "AHO" Then
            PMSetValorReverso CboTipCta, "@e_tipocta"
        End If

        PMSetValorReverso Me.Credito, "@e_tarjeta" '"@e_total" 'TC
        
        PMSetValorReverso TotalPagar, "@e_total"
 
        txtTemp = ""
        PMSetValorReverso Cta, "@e_cuenta"
        PMSetValorReverso NomCta, "@e_nombre_cta"
        PMSetValorReverso txtIngreso(0), "@e_cod_cliente"
        PMSetValorReverso txtNombre, "@e_nombre"
        PMSetValorReverso txtTemp, "@e_tipo_id"
        VLTipoID = txtTemp
        txtTemp = ""
          If Me.txtCampo(0) = "1" Then
         Select Case VLTipoID
            Case "CED"
                Me.CboTipo.ListIndex = 0
            Case "PLACA"
                Me.CboTipo.ListIndex = 2
            Case "RUC"
                Me.CboTipo.ListIndex = 3
            Case "CARNET"
                Me.CboTipo.ListIndex = 4
            Case "PASS"
                Me.CboTipo.ListIndex = 1
            Case "PAS"
                Me.CboTipo.ListIndex = 1
        End Select
        Else
        Select Case VLTipoID
            Case "CED"
                Me.CboTipo.ListIndex = 0
            Case "RUC"
                Me.CboTipo.ListIndex = 1
            Case "PASS"
                Me.CboTipo.ListIndex = 2
            Case "PAS"
                Me.CboTipo.ListIndex = 2
        End Select
        End If
        CboTipo.Enabled = False
        
        PMSetValorReverso txtTemp, "@referencia"
        VLSsn = txtTemp
        txtTemp = ""
        PMSetValorReverso txtTemp, "@referencia"
        VLSecTransac = CLng(txtTemp)
        txtTemp = ""
        SGUsar = (CDbl(Efe.Text) + VLEfe_com)
        
        txtTemp = ""
        VLTotCom = Me.Comision
 
        PMSetValorReverso txtTemp, "@referencia"
        VLSsn = txtTemp.Text
        txtTemp.Text = ""
        
        PMSetValorReverso txtTemp, "@referencia"
        VLCodAutorizacion = txtTemp.Text
        txtTemp.Text = ""
        
        PMSetValorReverso txtTemp, "@e_tipo_id"
        VLTipoID_Placa = txtTemp.Text
        txtTemp.Text = ""
        
        PMSetValorReverso txtTemp, "@e_cod_cliente"
        VLIdentf_Placa = txtTemp.Text
        txtTemp.Text = ""
        
        PMSetValorReverso CantChq, "@e_cant_cheques"
        PMSetValorReverso Loc, "@e_cheque"
        
        
        
    Else
    
        PMSetValorReverso Me.txtCampo(0), "@i_rubro"
        Call txtCampo_LostFocus(0)
        PMSetValorReverso Me.txtCitaciones, "@i_citaciones"
        If Me.txtCampo(1).Text = "1" Then
            If Me.txtCampo(0).Text = "1" Then
                PMSetValorReverso Me.txtIngreso(0), "@i_comprobante"
                PMSetValorReverso txtTemp, "@i_identificacion"
                VLced = txtTemp
            Else
                PMSetValorReverso Me.txtIngreso(0), "@i_identificacion"
                PMSetValorReverso txtTemp, "@i_comprobante"
                VLCEP = txtTemp
            End If
        Else
            If Me.txtCampo(0).Text = "1" Then
                PMSetValorReverso Me.txtIngreso(0), "@i_identificacion"
                PMSetValorReverso txtTemp, "@i_identificacion"
                VLced = txtTemp
            End If
        End If
        txtTemp = ""
        PMSetValorReverso Me.Efe, "@i_efectivo"
        PMSetValorReverso Me.CantChq, "@i_cant_cheques"
        PMSetValorReverso Me.Loc, "@i_cheque"
        PMSetValorReverso Me.CboTipCta, "@i_tipo_cta"
        PMSetValorReverso Me.Cta, "@i_cuenta"
        PMSetValorReverso Me.NomCta, "@i_nombre_cta"
        PMSetValorReverso Me.Debito, "@i_debito"
        PMSetValorReverso Me.Credito, "@i_subtotal"
        PMSetValorReverso Me.Comision, "@i_comision_tot"
        VLTotCom = Me.Comision
        PMSetValorReverso Me.Total, "@i_total"
        PMSetValorReverso Me.TotalPagar, "@i_valor_pagado"
        PMSetValorReverso Me.txtNombre, "@i_nom_benefi"
        PMSetValorReverso Me.txtCitaciones, "@i_citaciones"
        
        PMSetValorReverso txtTemp, "@i_comision_efe"
        VLEfe_com = txtTemp
        txtTemp = ""
        PMSetValorReverso txtTemp, "@i_comision_chq"
        VLChq_com = txtTemp
        'VLDeb_com = txtTemp
        txtTemp = ""
        'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
        PMSetValorReverso txtTemp, "@i_comision_deb"
        VLDeb_com = txtTemp
        txtTemp = ""
        'msilvag Fin
        PMSetValorReverso txtTemp, "@o_ssn"
        VLSecTransac = CLng(txtTemp)
        txtTemp = ""
        SGUsar = (CDbl(Efe.Text) + VLEfe_com)
        
        PMSetValorReverso txtTemp, "@o_fecha_contable"
        VLFechaContable = txtTemp
        txtTemp = ""
        PMSetValorReverso txtTemp, "@o_fecha_efectiva"
        VLFechaProceso = txtTemp
        txtTemp = ""
        PMSetValorReverso txtTemp, "@o_autorisri"
        VLautoriSri = txtTemp
        txtTemp = ""
        PMSetValorReverso txtTemp, "@o_fecvensri"
        VLFecvenSRI = txtTemp
        txtTemp = ""
        PMSetValorReverso txtTemp, "@o_nota_venta"
        VLSerie_Secuencia = txtTemp
        txtTemp = ""
 
    End If
End Sub

Private Sub CantChq_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Cantidad de Cheques"
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
          Efe.SetFocus
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

Private Sub cboTipo_Click() 'Dpereirv EPMTG
    If VGTipoEjecucion% <> CGReverso% Then
    
        If Trim(txtCampo(1).Text) = "18786" Then
            txtIngreso(0).Text = ""
            If txtCampo(0).Text <> "" Then
            If txtCampo(0).Text = 1 Then
                Select Case Mid(Trim(CboTipo), 1, 1)
                    Case "1"
                        txtIngreso(0).MaxLength = 10
                        VLTipoID = "CED"
                    Case "2"
                        txtIngreso(0).MaxLength = 20
                        VLTipoID = "PAS"
                    Case "3"
                        txtIngreso(0).MaxLength = 7
                        VLTipoID = "PLACA"
                    Case "4"
                        txtIngreso(0).MaxLength = 13
                        VLTipoID = "RUC"
                    Case "5"
                        txtIngreso(0).MaxLength = 20
                        VLTipoID = "CARNET"
                End Select
            
            ElseIf txtCampo(0).Text = 2 Then
                'txtIngreso(0).Text = ""
                Select Case Mid(Trim(CboTipo), 1, 1)
                    Case "1"
                        txtIngreso(0).MaxLength = 10
                        VLTipoID = "CED"
                    Case "2"
                        txtIngreso(0).MaxLength = 13
                        VLTipoID = "RUC"
                   Case "3"
                        txtIngreso(0).MaxLength = 20
                        VLTipoID = "PAS"
                End Select
            Else
                txtIngreso(0).MaxLength = 12
            End If
            End If
        Else
            txtIngreso(0).Text = ""
            Select Case Mid(Trim(CboTipo), 1, 1)
                Case "1"
                    txtIngreso(0).MaxLength = 10
                    VLTipoID = "CED"
                Case "2"
                    txtIngreso(0).MaxLength = 13
                    VLTipoID = "RUC"
                Case "3"
                    txtIngreso(0).MaxLength = 20
                    VLTipoID = "PAS"
                Case "4"
                    txtIngreso(0).MaxLength = 7
                    VLTipoID = ""
            End Select
        End If
    End If
End Sub

Private Sub CboTipo_KeyDown(KeyCode As Integer, Shift As Integer)  'Dpereirv EPMTG
    Select Case KeyCode%
    Case CGTeclaENTER%
        txtIngreso(0).SetFocus
    Case CGTeclaUP%, CGTeclaREPAG%
        txtCampo(0).SetFocus
    Case CGTeclaDOWN%, CGTeclaAVPAG%
        txtIngreso(0).SetFocus
    End Select
End Sub

Private Sub Comision_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Valor de la Comision"
    'SendKeys ("{HOME}+{END}")
End Sub


Private Sub Comision_KeyDown(KeyCode As Integer, Shift As Integer)
    Dim VLAcumulado As Currency
    If KeyCode% = CGTeclaF5% Then
         If Comision <> 0# Then
            
            'msilvag:Inicio RECA-CC-SGC00030409 - Facturacion OffLine Debitos
            SGNumCuenta = ""
            VLtipo_cta_com = ""
            VLcuenta_com = ""
            If Me.txtCampo(1).Text = "1" Then
                SGEmpresa = "2572"
            Else
                SGEmpresa = Me.txtCampo(1).Text
            End If
            SGNumCuenta = FCC134.Cta.Text
            'msilvag:Fin RECA-CC-SGC00030409 - Facturacion OffLine Debitos
            
            SGComision = 0#
            SGTipoCta = ""
            SGCedula = ""
            VLAcumulado = SGAcumulado
            VGUsar15 = Efe.ValueReal
            SGUsar = VLEfe_com
            SGComision = Comision
            SGTipoCta = FCC134.CboTipCta.ListIndex
            SGCedula = Cedula
           
            FCC112.Show 1
           
            VLEfe_com = FCC112.VLEfe_com
            VLChq_com = FCC112.VLChq_com
            VLDeb_com = FCC112.VLDeb_com
            VLTipCta_com = FCC112.VLTipCta_com
            VLCta_com = FCC112.VLCta_com
            'msilvag Inicio
            'VLtipo_cta_com = VLTipCta_com
            'VLcuenta_com = VLCta_com
            'msilvag Fin
            VLTotCom = VLEfe_com + VLChq_com + VLDeb_com
            SGUsar = VGUsar15
            Efe.ValueReal = SGUsar
            SGAcumulado = VLAcumulado
            VGUsar15 = VLEfe_com
            SGNumCuenta = ""
        
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

Private Sub Credito_Change()
VLCambio% = True
End Sub

Private Sub Credito_KeyDown(KeyCode As Integer, Shift As Integer)
    'Call Cambio(KeyCode, Credito)
    Select Case KeyCode%
    Case CGTeclaF5%
            FVISA.VLFlagAutorizacion = True
            FVISA.VLnemonico = "134"
            FVISA.Show 1
            VLVISA_numtar = FVISA.VLFVISA_numtar
            VLVISA_numtar_mask = Mid(VLVISA_numtar, 1, 6) + "XXXXXX" + Mid(VLVISA_numtar, 13, 4)    'JPM 14/09/21012
            VLVISA_ClaveUnicaTC = FVISA.VLFVISA_ClaveUnicaTC
           
            VLVISA_fechaven = FVISA.VLFVISA_fechaven
            VLVISA_meses = FVISA.VLFVISA_meses
            VLVISA_monto = FVISA.VLFVISA_monto
            VLVISA_tipoconsumo = FVISA.VLFVISA_tipoconsumo
            VLVISA_banda_sn = FVISA.VLFVISA_banda_sn
            VLVISA_nombre = FVISA.VLFVISA_nombre
            VLVISA_track1 = FVISA.VLFVISA_track1
            VLVISA_track2 = FVISA.VLFVISA_track2
            Credito = VLVISA_monto
                        
            If VLVISA_monto > 0 And VLVISA_tipoconsumo = "D" And consultarParametroANT("FCCTC") = "S" Then
                Comision.Text = 0
            Else
                Comision.Text = VGComision_original
            End If
                        
            If VLVISA_monto > 0 Then
                'efe.Text = "0.00"
                'Debito.Text = "0.00"
                Total.Text = CDbl(TotalPagar.Text)
            End If
            If Trim(VLVISA_nombre) = "" And Trim(VLVISA_ClaveUnicaTC) <> "" Then
               PLTraeNombreTarjeta
            End If
  End Select
End Sub

Public Sub PLTraeNombreTarjeta()

PMInicioTransaccion
PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, "3232", "Trn", ""
PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "S", "", ""
PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(FMObtenerMonedaForma("134")), "Moneda", ""
PMPasoValoresATX VGSqlConn, "@i_empresa", 0, SQLINT2, 0, "Empresa", ""
PMPasoValoresATX VGSqlConn, "@i_codigo", 0, SQLVARCHAR, "0", "Codigo", ""
PMPasoValoresATX VGSqlConn, "@i_nro_tarjeta", 0, SQLVARCHAR, VLVISA_numtar, "", ""    'JPM 14/09/2012: para que no se registra en la tira

If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_tr_pago_colegio_rc", True, "Transaccion Ok", "S", "N", "N", "134", "S", "S") = True Then
    PMMapeaVariableATX VGSqlConn&, VLVISA_nombre
    PMChequea VGSqlConn&
'Else
'    VLVISA_nombre = VLVISA_nombre
End If
PMFinTransaccion

End Sub
Private Function consultarParametroANT(Nemonico As String) As String
Dim VLarregloParametro(30) As String
PMInicioTransaccion
PMPasoValoresATX VGSqlConn&, "@t_trn", 0, SQLINT2, 1579, "", ""
PMPasoValoresATX VGSqlConn&, "@i_operacion", 0, SQLVARCHAR, "Q", "", ""
PMPasoValoresATX VGSqlConn&, "@i_nemonico", 0, SQLVARCHAR, Nemonico, "", ""
PMPasoValoresATX VGSqlConn&, "@i_producto", 0, SQLVARCHAR, "CTE", "", ""
If FMTransmitirRPCATX(VGSqlConn&, "", "cobis", "sp_parametro", True, " Consulta de motivos ", "N", "N", "S", "134", "N", "N") Then
   VTR1% = FMMapeaArregloATX(VGSqlConn, VLarregloParametro())
   consultarParametroANT = LTrim(RTrim(Trim(VLarregloParametro(4))))
Else
   consultarParametroANT = ""
End If
PMChequeaATX VGSqlConn&
PMFinTransaccion
End Function
Private Sub Credito_LostFocus()
    If Credito.Text <> "" Or Credito.Text <> "0.00" Then
        Total.Text = str(FMCCurATX((Efe.Text)) + FMCCurATX((Me.Loc.Text)) + FMCCurATX((Debito.Text)) + FMCCurATX((Credito.Text)) + FMCCurATX((Comision.Text)))
    End If
    
End Sub

Private Sub Debito_KeyDown(KeyCode As Integer, Shift As Integer)
    Call Cambio(KeyCode, Debito)
End Sub

Private Sub Debito_KeyPress(KeyAscii As Integer)
    'KB
    KeyAscii = FMValidarNumero((Debito.Text), VGLongitudMoney, KeyAscii, "78")
End Sub

Private Sub Debito_LostFocus()

    If Debito.Text <> "" Or Debito.Text <> "0.00" Then
        Total.Text = str(FMCCurATX((Efe.Text)) + FMCCurATX((Me.Loc.Text)) + FMCCurATX((Debito.Text)) + FMCCurATX((Credito.Text)) + FMCCurATX((Comision.Text)))
    End If
    
End Sub

Private Sub Efe_KeyDown(KeyCode As Integer, Shift As Integer)
    Call Cambio(KeyCode, Efe)
End Sub

Private Sub Efe_LostFocus()
    If SGActivaSum = True Then
        Exit Sub
    End If
    
    If VGDecimales$ = "S" And (FMObtenerDecimales(FMObtenerMonedaForma("134")) > 0) Then
        Efe.Text = str(FMCCurATX((Efe.Text)) / FMObtenerFactorDecimal(FMObtenerMonedaForma("134")))
    End If

    If Efe.Text <> "" Or Efe.Text <> "0.00" Then
        Total.Text = str(FMCCurATX((Efe.Text)) + FMCCurATX((Me.Loc.Text)) + FMCCurATX((Debito.Text)) + FMCCurATX((Credito.Text)) + FMCCurATX((Comision.Text)))
    End If
    
    'Sumadora ------>
    If CDbl(Efe.Text) <> SGUsar Then
        MsgBox "El Monto Efetivo No Coincide con el Monto Desglosado para el Deposito. Verificar", vbCritical, "Mensaje del Sistema"
        Efe.SetFocus
        Efe.Text = Format$(SGUsar, "####,###,##0.00")
        SGActual = 0
    End If
    SGActivaSum = False
    '<------
End Sub

Private Sub Form_Activate()
    If SGMonedaTran <> VGmoneda% And VGmoneda% <> 0 Then
        SGMonedaTran = VGmoneda%
        PMCargaIniSumadora VGmoneda%
        PMIniciaIngreso 1
    End If
        
    If VGTipoEjecucion% <> CGReverso% And CCur(Efe.Text) <> 0 And VGTran = "03" Then
        SGUsar = Efe.Text
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

Private Sub Credito_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Ingrese Valor en Tarjeta de Crédito"
    'SendKeys ("{HOME}+{END}")
End Sub

Private Sub Cta_Change()
    VLCambio% = True
    VLfirma = False
End Sub

Private Sub Cta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Numero de Cuenta"
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
    'SendKeys ("{HOME}+{END}")
End Sub


Private Sub Efe_Change()
    VLCambio% = True
End Sub


Private Sub Efe_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Valor en Efectivo"
   
    If SGActivaSum = False Then
        FSumIng.abrirAltaDenominacion = True
        PMIngresoEfectivo
        Efe.Text = Format$(SGUsar, "####,###,##0.00")
        SGActual = 0
    Else
        SGActivaSum = False
    End If
    
End Sub


Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    If Shift = CGTeclaCTRL% + CGTeclaALT% And KeyCode% = CGTeclaF9% Then
        PMObtenerMonedaForma "134"
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
                SGUsar = Efe.ValueReal + VLEfe_com
                If TotalPagar.Text <> "0.00" Then
                    Call PLTransmitir
                Else
                    MsgBox "Error: El monto a pagar no puede ser cero", vbCritical, App.Title
                End If
            End If
        Case CGTeclaESC%
            Unload Me
        Case CGTeclaF2%
            txt_pagosri.Caption = ""
            txt_reg_nacional.Caption = ""
            txt_atm.Caption = ""
            txtCampo(1).Enabled = True
            Me.Image2.Visible = False 'dpereirv EPMTG
            Me.Image1.Visible = True 'dpereirv EPMTG
            frmFrame(1).Top = 1320
            frmFrame(0).Height = 1335
            lblTipoID.Top = 1320
            CboTipo.Top = 1200
            lblCedula.Top = 915
            txtIngreso(0).Top = 875
            lblTipoID.Visible = False
            CboTipo.Visible = False
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
                Me.txtCampo(1).SetFocus
            End If
            lectoraBill.Limpiar         'Lectora de Billetes
        Case CGTeclaF3%
            If VGTipoEjecucion% <> CGReverso% Then
                If (VGTipoConsAutom% = 1 And VGStatusCon = "A") Or VGTipoConsAutom% = 0 Then
                    FSumIng.abrirAltaDenominacion = True
                    PMIngresoEfectivo
                    SGActual = 0
                    Efe.Text = SGUsar
                    If Efe.Enabled Then
                        Efe.SetFocus
                    End If
                End If
            End If
        Case CGTeclaF9%
            If VGTipoEjecucion% = CGNormal% Then
                If FMSupervisor("134") = True Then
                    VGAutoriza = "S"
                End If
            End If
            If Credito.Enabled Then
                Credito.SetFocus
            End If
         
    End Select
    
    Exit Sub
Error:
    MsgBox Err.Description, vbExclamation, App.Title
End Sub


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
    If VGTipoEjecucion = CGNormal% Then
        If FLChequeos() = False Then
            Exit Sub
        End If
        'JPM ContadorBillete -->
        If lectoraBill.HayAltaDenom Then
          If Not VGDatPersBillAltDen.dataOK Then
            MsgBox "Existen Billetes de Alta Denominación cuyos Número de Serie no se han confirmado", vbCritical, "Mensaje del Sistema"
            Exit Sub
          End If
        End If
        '<-- JPM ContadorBillete
    End If
    If VLCambio = False And VGTipoEjecucion = CGNormal% Then
        MsgBox " Transaccion Repetida"
        Exit Sub
    End If
    '------> Sumadora
    'Validacion de Monto Efectivo
    If (CDbl(Efe.Text) + VLEfe_com) <> SGUsar Then
        MsgBox "El Monto Efetivo No Coincide con el Monto Desglosado para el Deposito. Verificar", vbCritical, "Mensaje del Sistema"
        Efe.Text = Format$(SGUsar, "####,###,##0.00")
        Exit Sub
    End If
    '<--------

    
    If Trim(txtCampo(1).Text) = "18786" Then 'KBastida ANT Ini
        If Not FLTransmitir_ANT_pago() Then
         'Sumadora ------->
         If (SGAcumulado + SGAcumuladoAdi) = 0 Then
             If txtIngreso(0).Enabled = True Then
                 txtIngreso(0).SetFocus
             End If
         End If
         Exit Sub
        End If 'KBastida ANT Fin
        
    ElseIf Trim(txtCampo(1).Text) = "6388" Then 'dpereiv EPMTG
        If Not FLTransmitir_EPMTG_pago() Then
         'Sumadora ------->
         If (SGAcumulado + SGAcumuladoAdi) = 0 Then
             If txtIngreso(0).Enabled = True Then
                 txtIngreso(0).SetFocus
             End If
         End If
         Exit Sub
        End If
    Else
        If FLTransmitirCPS() = False Then
            'Sumadora ------->
            If (SGAcumulado + SGAcumuladoAdi) = 0 Then
                If Credito.Enabled = True Then
                    Credito.SetFocus
                End If
            End If
        '<---------
            Exit Sub
        End If
    End If
        
    If VGTipoEjecucion = CGReverso And VGReversoLoger = "S" Then
        PMMsgError "Reverso OK", "", CGErrorInformativo
        FReverso!grdValores(0).Col = 4
        FReverso!grdValores(0).Text = "R"
    End If
    
    If VGTipoEjecucion <> CGReverso And (txtCampo(1).Text <> "6388") Then
        Call FLTransmitirLocalActualizar
    End If
    
    If (txtCampo(1).Text = "6388") Then
        Call PLImprimeComprobanteEPMTG
        If VGTipoEjecucion% <> CGReverso% And VLTotCom > 0 Then
            If VLfact_elect = "N" Then
                VLTipo_imp = "O"
                PLImprimirNotaEPMTG                                              'SMERINO PORTA
                If MsgBox("Desea imprimir copia de la factura por la comision?", vbYesNo, "Mensaje") = vbYes Then
                    VLTipo_imp = "C"
                    PLImprimirNotaEPMTG
                End If
                VLTipo_imp = "O"
'            Else
'                MsgBox "Cliente tiene facturación electrónica imprimir comprobante por 24Online", vbInformation, "Sistema"
            End If
        End If
    Else
        
        Call PLImprimirPapeleta
        If (txtCampo(1).Text = "18786") Then
            If Me.Credito > 0 Then
                Call PLImprimirVoucher
                If VGTipoEjecucion = CGNormal% Then
                    While MsgBox("Desea Reimprimir la papeleta para certificacion?", vbYesNo, "Mensaje") = vbYes
                           Call PLImprimirPapeleta
                    Wend
                End If
   
            End If
        End If
    End If
 
     ' ame 08/04/2010 cambio por facturas cobro comision
    'Call PLImprimirComprobante
      
    
    VLTSN = 0
      
    If SGAcumulado = 0 Then
        Form_KeyDown CGTeclaF2%, 0
    Else
        Form_KeyDown CGTeclaF2%, -1
    End If
End Sub

Public Function FLTransmitirLocalActualizar() As Integer
        
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, "3925", "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_operacion", 0, SQLCHAR, "U", "Operacion", ""
    PMPasoValoresATX VGSqlConn, "@i_comprobante", 0, SQLVARCHAR, VLCodCTG, "Sec_CTG", ""
    PMPasoValoresATX VGSqlConn, "@i_secuencial", 0, SQLINT4, SGSecTrn$, "Secuencial", ""
    PMPasoValoresATX VGSqlConn, "@i_nom_benefi", 0, SQLVARCHAR, Mid(VLNombreTramite, 1, 100), "Nom_Tram", ""
        If txtCampo(1).Text = "1" Then
            PMPasoValoresATX VGSqlConn&, "@i_empresa", 0, SQLINT2, "2572", "Emp", ""
        Else
            PMPasoValoresATX VGSqlConn&, "@i_empresa", 0, SQLINT2, "2575", "Emp", ""
        End If

    If FMTransmitirRPCATX(VGSqlConn, "", "cob_cuentas", "sp_procesa_ctg", True, "Transaccion Ok", "S", "N", "S", "134", "S", "S") = True Then
        PMChequeaATX VGSqlConn
        FLTransmitirLocalActualizar = True
    Else
        PMChequeaATX VGSqlConn
        FLTransmitirLocalActualizar = False
    End If
    
    PMFinTransaccion
End Function


Public Function FLTransmitirCPS() As Integer
       
    Dim VTIndicadorSum As Integer
    Dim vlprocedimiento As String
    Dim vlnumtrn As String
    Dim VLEmp As String
    
    Dim codigoErr As Integer
    Dim codigoErr1 As Integer
    
    VTIndicadorSum = 0
    
    If VGHorarioDif Then
        VLTrn = "3926"
    Else
        VLTrn = "3925"
    End If
    VGTrn = IIf(VLTrn = "", 0, VLTrn)
    VGTrn = IIf(VLTrn = "", 0, VLTrn)
    
    If txtCampo(1).Text = "1" Then
        vlprocedimiento = "fp_pago_ctg"
        vlnumtrn = "62154"
        VLEmp = "2572"
    Else
        vlprocedimiento = "fp_pago_cntttsv"
        vlnumtrn = "62536"
        VLEmp = "2575"
    End If
    
    If VGTipoEjecucion% <> CGReverso% Then

    'VERIFICA MONTO MAXIMO
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 4050, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_empresa", 0, SQLVARCHAR, "2572", "Empresa", ""
    PMPasoValoresATX VGSqlConn, "@i_codigo", 0, SQLVARCHAR, txtIngreso(0).Text, "Suministro", ""
    PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "CSP", "Canal", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLVARCHAR, "T", "Opcion", ""
    PMPasoValoresATX VGSqlConn, "@i_aplcobis", 0, SQLVARCHAR, "S", "Aplicacion Cobis", ""
    PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLVARCHAR, "C", "Aplicacion Cobis", ""
    PMPasoValoresATX VGSqlConn, "@i_efectivo", 0, SQLMONEY, Efe.Text, "efectivo", ""
    PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, Loc.Text, "cheque", ""
    PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, Debito.Text, "debito", ""
    PMPasoValoresATX VGSqlConn, "@i_comision_efe", 0, SQLMONEY, CCur(VLEfe_com), "comision_efe", ""
    PMPasoValoresATX VGSqlConn, "@i_comision_chq", 0, SQLMONEY, CCur(VLChq_com), "comision_chq", ""
    PMPasoValoresATX VGSqlConn, "@i_comision_db", 0, SQLMONEY, CCur(VLDeb_com), "comision_deb", ""
      
    If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_val_servicios_varios", True, "Transaccion Ok", "S", "N", "N", "134", "S", "S") = True Then
        PMChequeaATX VGSqlConn&
        PMFinTransaccion
    Else
        VLCambio% = True
        VLCambioCedruc% = True
        FLTransmitirCPS = False
        VTIndicadorSum = 0
        PMChequeaATX VGSqlConn&
        PMFinTransaccion
        Exit Function
    End If

    End If
    
    FLTransmitirCPS = True
        
    PMInicioTransaccion
    
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, vlnumtrn, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(FMObtenerMonedaForma("134")), "Moneda", ""
    PMPasoValoresATX VGSqlConn, "@i_operacion", 0, SQLCHAR, "T", "Operacion", ""
    PMPasoValoresATX VGSqlConn, "@i_rubro", 0, SQLVARCHAR, txtCampo(0).Text, "Proceso", ""
    PMPasoValoresATX VGSqlConn, "@i_emp", 0, SQLVARCHAR, txtCampo(1).Text, "empresa", ""
    If VGTipoEjecucion% <> CGReverso% Then
         PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLVARCHAR, "N", "TCORR", ""
    End If
    If txtCampo(1).Text = "1" Then
        If txtCampo(0).Text = "1" Then
            PMPasoValoresATX VGSqlConn, "@i_comprobante", 0, SQLVARCHAR, txtIngreso(0).Text, "CEP/CED", ""
            PMPasoValoresATX VGSqlConn, "@i_identificacion", 0, SQLVARCHAR, Mid(VLced, 1, 15), "Ident", ""
            PMPasoValoresATX VGSqlConn, "@i_sucursal", 0, SQLVARCHAR, "XXX", "Cita", ""
            PMPasoValoresATX VGSqlConn, "@i_cep_cedula", 0, SQLVARCHAR, txtIngreso(0).Text, "CepCedula", ""
            PMPasoValoresATX VGSqlConn, "@i_nom_benefi", 0, SQLVARCHAR, Trim(Mid(txtNombre.Caption, 1, 80)), "Nombre", ""
        ElseIf txtCampo(0).Text = "2" Then
            PMPasoValoresATX VGSqlConn, "@i_comprobante", 0, SQLVARCHAR, VLCEP, "CEP/CED", ""
            PMPasoValoresATX VGSqlConn, "@i_identificacion", 0, SQLVARCHAR, Mid(txtIngreso(0).Text, 1, 15), "Ident", ""
            PMPasoValoresATX VGSqlConn, "@i_sucursal", 0, SQLVARCHAR, Me.txtCitaciones.Caption, "Cita", ""
            PMPasoValoresATX VGSqlConn, "@i_cep_cedula", 0, SQLVARCHAR, VLCEP, "CepCedula", ""
            PMPasoValoresATX VGSqlConn, "@i_nom_benefi", 0, SQLVARCHAR, Trim(Mid(txtNombre.Caption, 1, 80)), "Nombre", ""
        End If
    Else
        If txtCampo(0).Text = "1" Then
            PMPasoValoresATX VGSqlConn, "@i_comprobante", 0, SQLVARCHAR, VLCEP, "CEP/CED", ""
            PMPasoValoresATX VGSqlConn, "@i_identificacion", 0, SQLVARCHAR, Mid(txtIngreso(0).Text, 1, 15), "Ident", ""
            PMPasoValoresATX VGSqlConn, "@i_sucursal", 0, SQLVARCHAR, Me.txtCitaciones.Caption, "Cita", ""
            PMPasoValoresATX VGSqlConn, "@i_cep_cedula", 0, SQLVARCHAR, VLCEP, "CepCedula", ""
            PMPasoValoresATX VGSqlConn, "@i_nom_benefi", 0, SQLVARCHAR, Trim(Mid(txtNombre.Caption, 1, 80)), "Nombre", ""
        End If
    End If
    PMPasoValoresATX VGSqlConn, "@i_efectivo", 0, SQLMONEY, CCur(Efe.Text), "Efectivo", ""
    PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, CCur(Loc.Text), "Cheque", ""
    PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, CCur(Debito.Text), "Debito", ""
    PMPasoValoresATX VGSqlConn, "@i_subtotal", 0, SQLMONEY, CCur(Credito.Text), "SubTotal", ""
        
    PMPasoValoresATX VGSqlConn, "@i_comision_tot", 0, SQLMONEY, CCur(Comision.Text), "Comision", ""
    PMPasoValoresATX VGSqlConn, "@i_comision_efe", 0, SQLMONEY, CCur(VLEfe_com), "Com. Efectivo", ""
    PMPasoValoresATX VGSqlConn, "@i_comision_chq", 0, SQLMONEY, CCur(VLChq_com), "Com. Cheque", ""
    'PMPasoValoresATX VGSqlConn, "@i_comision_chq", 0, SQLMONEY, CCur(VLDeb_com), "Com. Cheque", "" 'temporal
    PMPasoValoresATX VGSqlConn, "@i_comision_deb", 0, SQLMONEY, CCur(VLDeb_com), "Com. Debito", "" 'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
    
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
    
    PMPasoValoresATX VGSqlConn, "@i_total", 0, SQLMONEY, CCur(Total.Text), "Total", ""
    PMPasoValoresATX VGSqlConn, "@i_cant_cheques", 0, SQLVARCHAR, CantChq.Text, "CantChq", ""
    If Me.Cta.ClipText <> "" Then
        PMPasoValoresATX VGSqlConn, "@i_tipo_cta", 0, SQLVARCHAR, Me.CboTipCta.Text, "T. Cta", ""
        PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cuenta", ""
    Else
        PMPasoValoresATX VGSqlConn, "@i_tipo_cta", 0, SQLVARCHAR, (VLTipCta_com), "T. Cta", ""
        PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (VLCta_com), "Cuenta", ""
    End If
    
    PMPasoValoresATX VGSqlConn, "@i_nombre_cta", 0, SQLVARCHAR, Me.NomCta.Text, "NomCta", ""
    PMPasoValoresATX VGSqlConn, "@i_autoriza", 0, SQLVARCHAR, VGAutoriza, "Autoriza", ""
        
    PMPasoValoresATX VGSqlConn, "@o_fecha_contable", 1, SQLVARCHAR, Space(20), "Fecha Contable", ""
    PMPasoValoresATX VGSqlConn, "@o_fecha_efectiva", 1, SQLVARCHAR, Space(20), "Fecha Efectiva", ""
    PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, "0", "SecTrn", ""
    PMPasoValoresATX VGSqlConn, "@o_autorisri", 1, SQLVARCHAR, Space(30), "AutorizacionSRI", ""
    PMPasoValoresATX VGSqlConn, "@o_fecvensri", 1, SQLVARCHAR, Space(30), "FecSri", ""
    PMPasoValoresATX VGSqlConn, "@o_nota_venta", 1, SQLVARCHAR, Space(15), "Nota_venta", ""
    
    PMPasoValoresATX VGSqlConn&, "@i_canal", 0, SQLVARCHAR, "VEN", "Canal", ""
    PMPasoValoresATX VGSqlConn, "@i_codigo_bco", 0, SQLINT2, "7", "CobBanco", ""
    PMPasoValoresATX VGSqlConn, "@i_valor_pagado", 0, SQLMONEY, TotalPagar.Text, "TotalPagar", ""
            
    VLHoraProceso = Format(Now, "hh:mm:ss")
    VLFechaProceso = Mid(VGFechaProceso, 4, 2) & "-" & Mid(VGFechaProceso, 1, 2) & "-" & Mid(VGFechaProceso, 7, 4) & " " & VLHoraProceso
    PMPasoValoresATX VGSqlConn, "@i_fecha_hora_pago", 0, SQLVARCHAR, VLFechaProceso, "FecHorPag", ""
    
    PMPasoValoresATX VGSqlConn, "@i_fecha_hora_reverso", 0, SQLVARCHAR, VLFechaProceso, "FecHorRev", ""
    
    VLFechaContable = Mid(VGFechaProceso, 4, 2) & "-" & Mid(VGFechaProceso, 1, 2) & "-" & Mid(VGFechaProceso, 7, 4)
    
    PMPasoValoresATX VGSqlConn, "@i_fecha_contable", 0, SQLVARCHAR, VLFechaContable, "FecConta", ""
    PMPasoValoresATX VGSqlConn, "@i_cod_transaccion", 0, SQLINT4, "62154", "CodTrn", ""
    PMPasoValoresATX VGSqlConn, "@i_cod_banco", 0, SQLINT2, "7", "Cob-Banco", ""
    PMPasoValoresATX VGSqlConn, "@i_citaciones", 0, SQLVARCHAR, txtCitaciones.Caption, "Citaciones", ""
    
    If VGHorarioDif = True Then
        PMPasoValoresATX VGSqlConn, "@i_tipoid", 0, SQLVARCHAR, "D", "Horario", ""
    Else
        PMPasoValoresATX VGSqlConn, "@i_tipoid", 0, SQLVARCHAR, "N", "Horario", ""
    End If

    PMPasoValoresATX VGSqlConn, "@i_empresa", 0, SQLINT2, VLEmp, "empresa", ""
    
    'If FMTransmitirRPCATX(VGSqlConn, "PSSRV1", "cob_procesador", vlprocedimiento, True, "Transaccion Ok", "S", "N", "S", "134", "S", "S") = True Then 'LCepeda - 30/06/2022
    
    If FMTransmitirRPCATX(VGSqlConn, "BBTSSRV", "cob_procesador", vlprocedimiento, True, "Transaccion Ok", "S", "N", "S", "134", "S", "S") = True Then 'LCepeda - 30/06/2022
    
        ReDim Preserve MatrizPago(1, 40)
        
        FMMapeaMatriz VGSqlConn, MatrizPago
        If VGTipoEjecucion% <> CGReverso% Then
            VLFechaContable = (Format(FMRetParamATX(VGSqlConn, 1), "mm/dd/yyyy"))
            VLFechaProceso = (Format(FMRetParamATX(VGSqlConn, 2), "mm/dd/yyyy"))
            SGSecTrn$ = FMRetParamATX(VGSqlConn, 3)  'Ojo con la transaccion que esta se envia al CPS
            VLautoriSri = FMRetParamATX(VGSqlConn, 4)
            VLFecvenSRI = FMRetParamATX(VGSqlConn, 5)
            VLSerie_Secuencia = FMRetParamATX(VGSqlConn, 6)
            VLNombreTramite = MatrizPago(1, 3)
            VLCodCTG = MatrizPago(1, 2)
            VLced = MatrizPago(1, 5)
        Else
            VLced = Me.txtIngreso(0).Text
            'VLced = MatrizPago(1, 5)
            VLCEP = MatrizPago(1, 1)
        End If
        
        PMChequeaATX VGSqlConn
                
        PMTotalesBranch "134"
        FLTransmitirCPS = True
        VLCambio% = False
        '------> Sumadora
        VTIndicadorSum = 1
        PMIniciaRegSum
        '<-----
    Else
        VLCambio% = True
        VLCambioCedruc% = True
        FLTransmitirCPS = False
        '------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 3)
        VTIndicadorSum = 0
        PMChequeaATX VGSqlConn
        '<------
    End If
    
    VGAutoriza = "N"
    PMFinTransaccion
    VLTSN = VGTSN
    If FMRetStatusATX(VGSqlConn) <> 0 Then
        VTIndicadorSum = 0
        FLTransmitirCPS = False
    End If
    
    'ame 08/04/2010
    If FLTransmitirCPS = True Then
        'JPM Lectora de Billetes -->
        If CCur(Efe.Text) > 0 And ((VGDatPersBillAltDen.dataOK And VGTipoEjecucion = CGNormal%) Or VGTipoEjecucion = CGReverso%) Then
          'Call PMGuardarDsglsBillete("134", SGSecTrn$, VLTrn, rptBAD, CboTipCta.Text, Cta.ClipText)
          Call PMGuardarDsglsBillete("134", SGSecTrn$, VLTrn, rptBAD, "REC", "")
        End If
        '<-- JPM Lectora de Billetes
       Call PLFactura
    End If
    
    '------> Sumadora
    If VGTipoEjecucion% <> CGReverso% Then   'Validacion por REVERSO
        If (VTIndicadorSum = 1 _
        And (Trim$(VGStatusCon) = "A" _
        Or Trim$(VGStatusCon) = "")) Then
            SGPrimeraVez = 0     ' ya no es primera vez
            PMGrabaDesglose VLTrn, CStr(SGUsar), VLCambio%
            If VLCambio% = True Then
                MsgBox "Error en la Grabacion del Desglose. Favor comuniquese con su Supervisor.", vbCritical, "Error de Sistema"
                FLTransmitirCPS = False
            End If
            SGActual = 1  'seteo Variable para borrar desglose
        ElseIf VTIndicadorSum = 0 Then
            SGActual = 0  'no borrar desglose en caso de Error en Transaccion
        End If
    ElseIf VTIndicadorSum = 1 Then                'Por REVERSO
        PMEgresoEfectivo SGUsar, VLTrn, VGSSNCorr&
    End If
    '<-----
End Function

Function FLChequeos() As Integer
    Dim I As Integer
    FLChequeos = True
    
    If Me.Cta.ClipText <> "" And Debito.ValueReal = 0 Then
        MsgBox "El campo Debito: es Mandatorio"
        FLChequeos = False
        Debito.SetFocus
        Exit Function
    End If
    
    If CantChq.Text <> "0" And CantChq.Text <> "" And Loc.ValueReal = 0 Then
        MsgBox "Verifique el Campo Valor en Cheque"
        FLChequeos = False
        Loc.SetFocus
        Exit Function
    End If

    'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
    If FCC134.Cta.ClipText <> "" Then
        If VLDeb_com > 0 And FCC134.Cta.ClipText <> VLCta_com Then
            MsgBox "La cuenta de la comision debe ser la misma con la que realiza el pago del servicio."
            FLChequeos = False
            Comision.SetFocus
            Exit Function
        End If
    End If
    'msilvag Fin
    
    If VLTotCom <> FMCCurATX((Comision.Text)) Then
        MsgBox "Verifique el Campo Valor de Comision"
        FLChequeos = False
        Comision.SetFocus
        Exit Function
    End If

    If VGTotalizar$ = "N" Then
        If Format(TotalPagar.Text, "###,###,###,##0.00") <> Format(FMCCurATX((Debito.Text)) + FMCCurATX((Efe.Text)) + FMCCurATX((Loc.Text)) + FMCCurATX((Credito.Text)), "###,###,###,##0.00") Then
            MsgBox " El campo Total Pagar no cuadra con las formas de pago"
            FLChequeos = False
            Exit Function
        End If
    End If

    If FMCCurATX((Efe.Text)) > 0 And CCur(VLEfe_com) > 0 And VGTipoEjecucion = CGNormal% Then
        VTTotalDesglose = 0
        For I = 1 To SGNumDen
            If SGIngreso(I - 1).cant_ingr > 0 Then
                VTTotalDesglose = VTTotalDesglose + SGIngreso(I% - 1).mont_ingr
            End If
        Next I%
        If CCur(VTTotalDesglose + SGAcumulado) < (FMCCurATX((Efe.Text)) + CCur(VLEfe_com)) Then
            MsgBox "Desglose menor a efectivo ingresado. Verifique...", vbCritical, "Mensaje del Servidor"
            FLChequeos = False
            Exit Function
        End If
    End If
End Function

Private Sub Form_Load()
     CGLongTramaBill = CadenaCorta   'JPM lectora de billetes
     lectoraBill.Limpiar             'JPM lectora de billetes
     Me.Top = 15
     Me.Left = 15
     frmFrame(1).Top = 1320
     frmFrame(1).Height = 4095
     frmFrame(0).Height = 1335
     FCC134.Height = 6420
     VLFlagMultiFlujo = "N" 'KBastida TC ANT
     'freme1 1680
'     frame 0 1695
     
     PMMapeaCombo "sv_tiposid_epmtg", CboTipo
     CboTipo.RemoveItem 0
     CboTipo.ListIndex = 0
     '----->Sumadora
     SGUsar = 0
     SGActivaSum = False
     SGActual = 1
    '<-----Sumadora
    Call PLLimpiar
    If VGTipoEjecucion% = CGReverso% Then
        VLMsg = ""
        Call PLReverso
    End If
End Sub

Private Sub Form_Unload(Cancel As Integer)
    VGUsar15 = 0
    VGUsar = 0
    SGEmpresa = ""  'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
    Call PMCerrarForma("134")
    lectoraBill.Limpiar   'JPM lectora de billetes
End Sub








Private Sub Loc_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Valor en Cheques"
    'SendKeys ("{HOME}+{END}")
End Sub

Private Sub Loc_KeyDown(KeyCode As Integer, Shift As Integer)
    Call Cambio(KeyCode, Loc)
End Sub

Private Sub Loc_LostFocus()
    'If VGTotalizar$ = "S" Then
        If Loc.Text <> "" Or Loc.Text <> "0.00" Then
            Total.Text = str(FMCCurATX((Efe.Text)) + FMCCurATX((Me.Loc.Text)) + FMCCurATX((Debito.Text)) + FMCCurATX((Credito.Text)) + FMCCurATX((Comision.Text)))
        End If
    'End If
End Sub


Private Sub txtCampo_Change(Index As Integer)
If Index = 1 Then
        txtCampo(0).Text = ""
        lblDescripcion(0).Caption = ""
        lblDescripcion(1).Caption = ""
End If
If Index = 0 Then   'dpereirv EPMTG
    Me.txtIngreso(0).Text = ""
    Me.CboTipo.ListIndex = 0
    VLTipoID = ""
End If
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
Select Case Index
Case 0
    FPrincipal!pnlHelpLine.Caption = "Tipo de Servicio"

Case 1
    FPrincipal!pnlHelpLine.Caption = "Institución"

End Select

End Sub

Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
    If KeyCode = 116 Then
        Select Case Index
            Case 0
                If txtCampo(1).Text = "1" Then
                    Call PLCatalogo("cl_servicios_ctg", str(Index), "0", "")
                ElseIf txtCampo(1).Text = "18786" Then 'KBastida ANT Ini
                    Call PLCatalogo("cl_servicios_ant", str(Index), "0", "")
                Else 'KBastida ANT Fin
                    Call PLCatalogo("cl_servicios_epmtg", str(Index), "0", "")
                End If
            Case 1
                Call PLCatalogo("cl_empresas_ctg", str(Index), "0", "")
        End Select
    Else
        Call Cambio(KeyCode, txtCampo(0))
    End If
    
End Sub

Public Sub txtCampo_LostFocus(Index As Integer)
    Select Case Index
        Case 0
                If txtCampo(1).Text = "1" Then
                    Call PLCatalogo("cl_servicios_ctg", str(Index), "1", txtCampo(Index).Text)
                ElseIf txtCampo(1).Text = "18786" Then 'KBastida ANT Ini
                    Call PLCatalogo("cl_servicios_ant", str(Index), "1", txtCampo(Index).Text)
                Else 'KBastida ANT Fin
                    Call PLCatalogo("cl_servicios_epmtg", str(Index), "1", txtCampo(Index).Text)
                End If
                
                'KBastida ANT
                If Trim(txtCampo(1).Text) = "18786" Then
                    If txtCampo(Index).Text = "1" Then 'CITACIONES
                        PMMapeaCombo "sv_tiposid_cit_ant", CboTipo
                        CboTipo.RemoveItem 0
                        CboTipo.ListIndex = 0
                        lbl_reg_nacional.Visible = False
                        txt_reg_nacional.Visible = False
                        lbl_citaciones2.Visible = False
                        lbl_atm.Visible = False
                        txt_atm.Visible = False
                        lbl_pagosri.Visible = False
                        txt_pagosri.Visible = False
                        lblCitaciones.Caption = "Citaciones:"
                        VLConvenio = "ANT-CIT"
                        lblTipoID.Visible = True
                        CboTipo.Visible = True
                        lblTipoID.Top = 915
                        CboTipo.Top = 875
                        lblCitaciones.Visible = True
                        txtCitaciones.Visible = True
                        txtCitaciones.Caption = ""
                        frmFrame(0).Height = 1695
                        frmFrame(1).Top = 1680
                        frmFrame(1).Height = 4095
                        FCC134.Height = 6420
                        Me.lblCedula.Caption = "Codigo:"
                        lblCedula.Top = 1320
                        txtIngreso(0).Top = 1230
                        If VGTipoEjecucion% <> CGReverso% Then
                            CboTipo.SetFocus
                        End If
                    End If
                    
                    If txtCampo(Index).Text = "2" Then 'CONVENIO DE PAGO
                        PMMapeaCombo "sv_tiposid_cnv_ant", CboTipo
                        CboTipo.RemoveItem 0
                        CboTipo.ListIndex = 0
                        lbl_reg_nacional.Visible = False
                        txt_reg_nacional.Visible = False
                        lbl_citaciones2.Visible = False
                        lbl_atm.Visible = False
                        txt_atm.Visible = False
                        lbl_pagosri.Visible = False
                        txt_pagosri.Visible = False
                        lblCitaciones.Caption = "Convenio de pago:"
                        VLConvenio = "ANT-CDP"
                        lblTipoID.Visible = True
                        CboTipo.Visible = True
                        lblTipoID.Top = 915
                        CboTipo.Top = 875
                        lblCitaciones.Visible = True
                        txtCitaciones.Visible = True
                        txtCitaciones.Caption = ""
                        frmFrame(0).Height = 1695
                        frmFrame(1).Top = 1680
                        frmFrame(1).Height = 4095
                        FCC134.Height = 6420
                        Me.lblCedula.Caption = "Codigo:"
                        lblCedula.Top = 1320
                        txtIngreso(0).Top = 1230
                        If VGTipoEjecucion% <> CGReverso% Then
                            CboTipo.SetFocus
                        End If
                    End If
                    If txtCampo(Index).Text = "3" Then 'SOLICITUDES
                        lbl_reg_nacional.Visible = False
                        txt_reg_nacional.Visible = False
                        lbl_citaciones2.Visible = False
                        lbl_atm.Visible = False
                        txt_atm.Visible = False
                        lbl_pagosri.Visible = False
                        txt_pagosri.Visible = False
                        lblCitaciones.Caption = "Solicitudes:"
                        Me.lblCedula.Caption = "Ord. Pago:"
                        VLConvenio = "ANT-SOL"
                        txtIngreso(0).MaxLength = 30
                        frmFrame(1).Top = 1320
                        frmFrame(0).Height = 1335
                        frmFrame(1).Height = 4095
                        FCC134.Height = 6420
                        lblTipoID.Top = 1320
                        CboTipo.Top = 1200
                        lblCedula.Top = 915
                        txtIngreso(0).Top = 875
                        lblTipoID.Visible = False
                        CboTipo.Visible = False
                        txtCitaciones.Visible = True
                    End If
                End If
                'KBastida ANT
                
                
                If Trim(txtCampo(1).Text) = "6388" Then 'dpereirv EPMTG
                   PMMapeaCombo "sv_tiposid_epmtg", CboTipo
                   CboTipo.RemoveItem 0
                   CboTipo.ListIndex = 0
     
                    If txtCampo(Index).Text = "1" Then
                                                If vl_servidor_BUS <> "PSSRV1" Then
                                                        VLTipoID = "TRA"    'pricaura SOA2
                                                End If
'                        lblCitaciones.Visible = False
'                        txtCitaciones.Visible = False
                        'txtCitaciones.Caption = ""
                        lbl_reg_nacional.Visible = False
                        txt_reg_nacional.Visible = False
                        lbl_citaciones2.Visible = False
                        lbl_atm.Visible = False
                        txt_atm.Visible = False
                        lbl_pagosri.Visible = False
                        txt_pagosri.Visible = False
                        lblCitaciones.Caption = "Tramite:"
                        Me.lblCedula.Caption = "No.Solicitud:"
                        txtIngreso(0).MaxLength = 30
                        frmFrame(1).Top = 1320
                        frmFrame(0).Height = 1335
                        frmFrame(1).Height = 4095
                        FCC134.Height = 6420
                        lblTipoID.Top = 1320
                        CboTipo.Top = 1200
                        lblCedula.Top = 915
                        txtIngreso(0).Top = 875
                        lblTipoID.Visible = False
                        CboTipo.Visible = False
                        txtCitaciones.Visible = True
                    ElseIf txtCampo(Index).Text = "2" Then
                        lbl_reg_nacional.Visible = False
                        txt_reg_nacional.Visible = False
                        lbl_citaciones2.Visible = False
                        lbl_atm.Visible = False
                        txt_atm.Visible = False
                        lbl_pagosri.Visible = False
                        txt_pagosri.Visible = False
                        lblCitaciones.Caption = "Citaciones:"
                        VLTipoID = "CED"
                        lblTipoID.Visible = True
                        CboTipo.Visible = True
                        lblTipoID.Top = 915
                        CboTipo.Top = 875
                        lblCitaciones.Visible = True
                        txtCitaciones.Visible = True
                        txtCitaciones.Caption = ""
                        frmFrame(0).Height = 1695
                        frmFrame(1).Top = 1680
                        frmFrame(1).Height = 4095
                        FCC134.Height = 6420
                        Me.lblCedula.Caption = "Codigo:"
                        lblCedula.Top = 1320
                        txtIngreso(0).Top = 1230
                        If VGTipoEjecucion% <> CGReverso% Then
                            CboTipo.SetFocus
                        End If
                    ElseIf txtCampo(Index).Text = "3" Then
                        lbl_reg_nacional.Visible = True
                        txt_reg_nacional.Visible = True
                        lbl_citaciones2.Visible = True
                        lbl_atm.Visible = True
                        txt_atm.Visible = True
                        lbl_pagosri.Visible = True
                        txt_pagosri.Visible = True
                        VLTipoID = ""
                        frmFrame(1).Height = "4455"
                        FCC134.Height = "6735"
                        lblCitaciones.Caption = "Citaciones:"
                        txtCitaciones.Visible = False
                        Me.lblCedula.Caption = "Placa:"
                        txtIngreso(0).MaxLength = 30
                        frmFrame(1).Top = 1320
                        frmFrame(0).Height = 1335
                        lblTipoID.Top = 1320
                        CboTipo.Top = 1200
                        lblCedula.Top = 915
                        txtIngreso(0).Top = 875
                        lblTipoID.Visible = False
                        CboTipo.Visible = False
                    End If
                
                Else
                    If txtCampo(Index).Text = "1" And Trim(txtCampo(1).Text) <> "18786" Then
                        lblCitaciones.Visible = False
                        txtCitaciones.Visible = False
                        txtCitaciones.Caption = ""
                        Me.lblCedula.Caption = "Cod CEP:"
                        txtIngreso(0).MaxLength = 12
                    ElseIf txtCampo(Index).Text = "2" And Trim(txtCampo(1).Text) <> "18786" Then
                        lblCitaciones.Visible = True
                        txtCitaciones.Visible = True
                        txtCitaciones.Caption = ""
                        Me.lblCedula.Caption = "Ced/Ruc/Pas:"
                        txtIngreso(0).MaxLength = 13
                    End If
                End If
'            Else
'                Call PLCatalogo("cl_servicios_cntttsv", Str(Index), "1", txtCampo(Index).Text)
'                    lblCitaciones.Visible = True
'                    txtCitaciones.Visible = True
'                    txtCitaciones.Caption = ""
'                    Me.lblCedula.Caption = "Ced/Ruc/Pas:"
'                    txtIngreso(0).MaxLength = 13
'            End If
                
        Case 1
            Call PLCatalogo("cl_empresas_ctg", str(Index), "1", txtCampo(Index).Text)
            If txtCampo(Index).Text = "1" Then
                lblCitaciones.Visible = False
                txtCitaciones.Visible = False
                txtCitaciones.Caption = ""
                Me.lblCedula.Caption = "Cod CEP:"
                txtIngreso(0).MaxLength = 12
                frmFrame(1).Top = 1320
                frmFrame(0).Height = 1335
                lblTipoID.Top = 1320
                CboTipo.Top = 1200
                lblCedula.Top = 915
                txtIngreso(0).Top = 875
                lblTipoID.Visible = False
                CboTipo.Visible = False
            ElseIf txtCampo(Index).Text = "2" Then
                lblCitaciones.Visible = True
                txtCitaciones.Visible = True
                txtCitaciones.Caption = ""
                Me.lblCedula.Caption = "Ced/Ruc/Pas:"
                txtIngreso(0).MaxLength = 13
            End If
            
            If Trim(txtCampo(1).Text) = "6388" Then 'dpereirv EPMTG
                txtCampo(1).Enabled = False
                Me.Image2.Visible = True
                Me.Image1.Visible = False
                Me.Image3.Visible = False
            ElseIf Trim(txtCampo(1).Text) = "18786" Then 'KBastida ANT
                Me.Image3.Visible = True
                Me.Image1.Visible = False
                Me.Image2.Visible = False
            Else
                Me.Image2.Visible = False
                Me.Image1.Visible = True
                Me.Image3.Visible = False
            End If
            
    End Select
End Sub

Public Sub PLLimpiar()
    Me.Image3.Visible = False
    
    VLTSN = 0
    Me.frmFrame(0).Enabled = True
    Me.frmFrame(1).Enabled = False
    txtTemp = ""
    VGAutoriza = "N"
    VLMsg = ""
    txtCampo(0).Text = ""
    txtCampo(1).Text = ""
    txtIngreso(0).Text = ""
    lblDescripcion(0).Caption = ""
    Efe.Text = "0.00"
    CantChq.Text = ""
    Loc.Text = "0.00"
    CboTipCta.ListIndex = 0
    Cta.Text = ""
    Debito.Text = "0.00"
    Credito.Text = "0.00"
    TotalPagar.Text = "0.00"
    Comision.Text = "0.00"
    Total.Text = "0.00"
    NomCta.Text = ""
    txtNombre.Caption = ""
    txtCitaciones.Caption = ""
    VLHorarioEmp = ""
    VLEfe_com = 0
    VLChq_com = 0
    VLDeb_com = 0
    VLTotCom = 0
    VLFechaProceso = ""
    VLFechaContable = ""
    VLHoraProceso = ""
    VLTrn = ""
    VLNombreTramite = ""
    VLMensaje = ""
    VLHorario = ""
    VLHorarioDifTemporal = False
    VLCEP = ""
    VLced = ""
    VLCodCTG = ""
    VLautoriSri = ""
    VLFecvenSRI = ""
    VLSerie_Secuencia = ""
    
    'LBP Inicio RECA-CC-SGC00025869 30/07/2016
    VGFormaPago = ""
    VGCom_aux = 0
    VGComision_original = 0
    VGCompensacion = 0
    VGPorcentajeComp = "0"
    VGPorcentajeIVA = "0"
    'LBP Fin 30/07/2016'Fin LBP
    
    SGEmpresa = ""   'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
    SGNumCuenta = "" 'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
    VLtipo_cta_com = ""
    VLcuenta_com = ""
    VLTipCta_com = ""
    VLCta_com = ""
    
End Sub

Public Function PLConsultar(parOpcion As String) As Boolean
On Error GoTo Error
    PLConsultar = True
    
    'Opcion "0" - consulta en base local
    If parOpcion = "0" Then
        PMInicioTransaccion
        VLFechaContable = ""
        PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, "3925", "Trn", ""
        PMPasoValoresATX VGSqlConn&, "@i_operacion", 0, SQLCHAR, "Q", "Opcion", ""
        PMPasoValoresATX VGSqlConn&, "@i_canal", 0, SQLVARCHAR, "VEN", "Canal", ""
        PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(VGmoneda%), "Moneda", ""
        PMPasoValoresATX VGSqlConn, "@o_fecha_efe", 1, SQLVARCHAR, Space(10), "Fecha", ""
        PMPasoValoresATX VGSqlConn, "@o_comision", 1, SQLMONEY, (Comision.Text), "Comision", ""
        PMPasoValoresATX VGSqlConn&, "@o_horario", 1, SQLCHAR, "X", "HorEmp", ""
        'smerino
        PMPasoValoresATX VGSqlConn, "@o_tasa", 1, SQLMONEY, "0", "tasa", ""
        PMPasoValoresATX VGSqlConn, "@o_base_imp", 1, SQLMONEY, "0", "base_imp", ""
        PMPasoValoresATX VGSqlConn, "@o_impuesto", 1, SQLMONEY, "0", "impuesto", ""
        'smerino
        
        If txtCampo(1).Text = "1" Then
            PMPasoValoresATX VGSqlConn&, "@i_empresa", 0, SQLINT2, "2572", "Emp", ""
        ElseIf txtCampo(1).Text = "18786" Then
            PMPasoValoresATX VGSqlConn&, "@i_empresa", 0, SQLINT2, "18786", "Emp", ""
        Else
            PMPasoValoresATX VGSqlConn&, "@i_empresa", 0, SQLINT2, "2575", "Emp", ""
        End If
        
        If FMTransmitirRPCATX(VGSqlConn, "", "cob_cuentas", "sp_procesa_ctg", True, "Consulta Ok...", "N", "N", "N", "134", "N", "N") Then
            Comision.Text = FMRetParamATX(VGSqlConn, 2)
            VLHorarioEmp = FMRetParamATX(VGSqlConn, 3)
            VLHorario = FMRetParamATX(VGSqlConn, 3)
            VLFechaContable = (Format(FMRetParamATX(VGSqlConn, 1), "mm/dd/yyyy"))
            VlbaseImp = FMRetParamATX(VGSqlConn, 5) 'smerino
            VLiva = FMRetParamATX(VGSqlConn, 6) 'smerino
            PMChequeaATX VGSqlConn
            
            'LBP Inicio RECA-CC-SGC00025869
            If Comision.Text > 0 Then
                VGCom_aux = FMDevuelveComisionReal(Comision, False, 134)
                If VGCom_aux <> CDbl(Comision.Text) Then
                    VGComision_original = Comision.Text
                    Comision.Text = VGCom_aux
                Else
                    VGComision_original = Comision.Text
                End If
            End If
            'LBP Fin RECA-CC-SGC00025869
            
        Else
            VLHorarioEmp = ""
            Comision.Text = ""
            PMChequeaATX VGSqlConn
            PLConsultar = False
        End If
        PMFinTransaccion
        Exit Function
    End If
    
    'Opcion "1" - consulta en base de la CTG por medio de CPS
    If parOpcion = "1" Then
        PMInicioTransaccion
        'Consulta 1 - Tramites - CTG CEP
        If txtCampo(1).Text = "1" Then
            If txtCampo(0).Text = "1" Then
                PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, "62152", "Trn", ""
                PMPasoValoresATX VGSqlConn, "@i_cep", 0, SQLVARCHAR, LTrim(RTrim(Me.txtIngreso(0).Text)), "Codigo CEP", ""
                PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Canal", ""
                PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLCHAR, str(FMObtenerMonedaForma("134")), "Moneda", ""
                PMPasoValoresATX VGSqlConn, "@i_codigo_bco", 0, SQLINT2, "7", "Cod. Banco", ""
                
                'If FMTransmitirRPCATX(VGSqlConn, "PSSRV1", "cob_procesador", "fp_cons_ctg_cep", True, "Transaccion Ok", "S", "N", "S", "134", "S", "S") = True Then 'LCepeda - 30/06/2022
                If FMTransmitirRPCATX(VGSqlConn, "BBTSSRV", "cob_procesador", "fp_cons_ctg_cep", True, "Transaccion Ok", "S", "N", "S", "134", "S", "S") = True Then  'LCepeda - 30/06/2022
                    ReDim Preserve psRetorno(1, 40)
                    FMMapeaMatriz VGSqlConn, psRetorno
                    
                    txtNombre.Caption = psRetorno(1, 3)
                    TotalPagar.Text = Format(CCur(psRetorno(1, 2)), "###.###.##0,00")
                    VLced = psRetorno(1, 4)
                    VLMsg = psRetorno(1, 8)
                    VLMsg = "Ud. tiene valores pendientes en CNTTTSV"
                    PMFinTransaccion
                Else
                    PMFinTransaccion
                    PLConsultar = False
                End If
            End If
            If txtCampo(0).Text = "2" Then
                PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, "62153", "Trn", ""
                PMPasoValoresATX VGSqlConn, "@i_identificacion", 0, SQLVARCHAR, LTrim(RTrim(Me.txtIngreso(0).Text)), "Ced/Ruc", ""
                PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Canal", ""
                PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLCHAR, str(FMObtenerMonedaForma("134")), "Moneda", ""
                PMPasoValoresATX VGSqlConn, "@i_codigo_bco", 0, SQLINT2, "7", "Cod. Banco", ""
                VLHoraProceso = Format(Now, "hh:mm:ss")
                VLFechaProceso = Mid(VGFechaProceso, 4, 2) & "-" & Mid(VGFechaProceso, 1, 2) & "-" & Mid(VGFechaProceso, 7, 4) & " " & VLHoraProceso
                PMPasoValoresATX VGSqlConn, "@i_fecha", 0, SQLVARCHAR, VLFechaProceso, "Fecha", ""
                
                'If FMTransmitirRPCATX(VGSqlConn, "PSSRV1", "cob_procesador", "fp_cons_ctg_citaciones", True, "Transaccion Ok", "S", "N", "S", "134", "S", "S") = True Then 'LCepeda - 30/06/2022
                If FMTransmitirRPCATX(VGSqlConn, "BBTSSRV", "cob_procesador", "fp_cons_ctg_citaciones", True, "Transaccion Ok", "S", "N", "S", "134", "S", "S") = True Then 'LCepeda - 30/06/2022
                    ReDim Preserve psRetorno(1, 40)
                    FMMapeaMatriz VGSqlConn, psRetorno
                    If psRetorno(1, 2) = "" Or psRetorno(1, 5) = "0" Then
                        MsgBox "El cliente no tiene citaciones pendientes", vbInformation, App.Title
                    Else
                        VLCEP = psRetorno(1, 1)
                        txtCitaciones.Caption = psRetorno(1, 2)
                        TotalPagar.Text = psRetorno(1, 5)
                        txtNombre.Caption = psRetorno(1, 6)
                        VLMsg = psRetorno(1, 8)
                        If VLMsg <> "" Then
                            VLMsg = "Ud. tiene valores pendientes en CNTTTSV"
                        End If
                        
                    End If
                    PMFinTransaccion
                Else
                    PMFinTransaccion
                    PLConsultar = False
                End If
            End If
        Else
            If txtCampo(0).Text = "1" Then
                PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, "62535", "Trn", ""
                PMPasoValoresATX VGSqlConn, "@i_identificacion", 0, SQLVARCHAR, LTrim(RTrim(Me.txtIngreso(0).Text)), "Ced/Ruc", ""
                PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Canal", ""
                PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLCHAR, str(FMObtenerMonedaForma("134")), "Moneda", ""
                PMPasoValoresATX VGSqlConn, "@i_codigo_bco", 0, SQLINT2, "7", "Cod. Banco", ""
                VLHoraProceso = Format(Now, "hh:mm:ss")
                VLFechaProceso = Mid(VGFechaProceso, 4, 2) & "-" & Mid(VGFechaProceso, 1, 2) & "-" & Mid(VGFechaProceso, 7, 4) & " " & VLHoraProceso
                PMPasoValoresATX VGSqlConn, "@i_fecha", 0, SQLVARCHAR, VLFechaProceso, "Fecha", ""
                
                'If FMTransmitirRPCATX(VGSqlConn, "PSSRV1", "cob_procesador", "fp_cons_cntttsv_citaciones", True, "Transaccion Ok", "S", "N", "S", "134", "S", "S") = True Then 'LCepeda - 30/06/2022
                If FMTransmitirRPCATX(VGSqlConn, "BBTSSRV", "cob_procesador", "fp_cons_cntttsv_citaciones", True, "Transaccion Ok", "S", "N", "S", "134", "S", "S") = True Then 'LCepeda-30/06/2022
                    ReDim Preserve psRetorno(1, 40)
                    FMMapeaMatriz VGSqlConn, psRetorno
                    If psRetorno(1, 2) = "" Or psRetorno(1, 5) = "0" Then
                        MsgBox "El cliente no tiene citaciones pendientes", vbInformation, App.Title
                    Else
                        VLCEP = psRetorno(1, 1)
                        txtCitaciones.Caption = psRetorno(1, 2)
                        TotalPagar.Text = psRetorno(1, 5)
                        txtNombre.Caption = psRetorno(1, 6)
                        VLMsg = psRetorno(1, 8)
                        If VLMsg <> "" Then
                            VLMsg = "Ud. tiene valores pendientes en CTG"
                        End If
                        
                    End If
                    PMFinTransaccion
                Else
                    PMFinTransaccion
                    PLConsultar = False
                End If
            End If
    End If
End If
    'Opcion "2" - consulta en base local para el reverso
    If parOpcion = "2" Then
        PLConsultar = True
        PMPasoValores VGSqlConn, "@t_trn", 0, SQLINT4, "3925"
        PMPasoValores VGSqlConn, "@i_operacion", 0, SQLCHAR, "C"
        PMPasoValores VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN"
        PMPasoValores VGSqlConn, "@i_mon", 0, SQLINT1, str(VGmoneda%)
        PMPasoValores VGSqlConn, "@i_secuencial", 0, SQLINT4, str(VLSecTransac) 'SGSecTrn$
        If txtCampo(1).Text = "1" Then
            PMPasoValores VGSqlConn, "@i_empresa", 0, SQLINT2, "2572"
        Else
            PMPasoValores VGSqlConn, "@i_empresa", 0, SQLINT2, "2575"
        End If
        PMPasoValores VGSqlConn, "@o_nombre_tramite", 1, SQLVARCHAR, Space(120)  'SGSecTrn$
        PMPasoValores VGSqlConn, "@o_secuencial_ctg", 1, SQLVARCHAR, Space(30) 'SGSecTrn$
       
        If FMTransmitirRPC(VGSqlConn, "", "cob_cuentas", "sp_procesa_ctg", True, "Transaccion Ok") Then
            VLCodCTG = FMRetParam(VGSqlConn, 2)
            VLNombreTramite = FMRetParam(VGSqlConn, 1)
        End If
        
        PMChequea VGSqlConn
        Exit Function
    End If
    
    
    Exit Function
Error:
    PLConsultar = False
    PMChequea VGSqlConn
    PMFinTransaccion
    
End Function

Private Sub txtIngreso_GotFocus(Index As Integer)
    FPrincipal!pnlHelpLine.Caption = "Codigo de Usuario"
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

Private Sub txtIngreso_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
    If txtIngreso(0).Text <> "" And KeyCode = CGTeclaF5% Then
        If frmFrame(0).Enabled = True Then
            
            If Trim(txtCampo(1).Text) = "18786" Then  'KBastida ANT Ini
                PLConsultar ("0")
                If Not FLTransmitir_ANT_consulta() Then
                    Exit Sub
                Else
                    Credito.Enabled = True
                    frmFrame(1).Enabled = True
                    frmFrame(0).Enabled = False
                    Efe.SetFocus
                    Exit Sub
                End If 'KBastida ANT Fin
            ElseIf Trim(txtCampo(1).Text) = "6388" Then  'dpereirv EPMTG
                If Not FLTransmitir_EPMTG_consulta() Then
                    Exit Sub
                Else
                    frmFrame(1).Enabled = True
                    frmFrame(0).Enabled = False
                    Efe.SetFocus
                    Exit Sub
                End If
            Else
                If PLConsultar("1") Then
                    If PLConsultar("0") Then
                        frmFrame(1).Enabled = True
                        frmFrame(0).Enabled = False
                        If Comision.Text <> "0.00" Then
                            Comision.Enabled = True
                        End If
                        Efe.SetFocus
                        Exit Sub
                   End If
                End If
            End If ' If Trim(txtCampo(1).Text) = "6388" Then
        End If
    End If

    Call Cambio(KeyCode, txtIngreso(0))
End Sub

Private Sub txtIngreso_KeyPress(Index As Integer, KeyAscii As Integer)
If (Trim(VLTipoID) = "" Or Trim(VLTipoID) = "PAS" Or Trim(VLTipoID) = "PLACA") Then
    KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
Else
    If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
        KeyAscii% = 0
    End If
 End If


End Sub
Function FLTransmitir_EPMTG_consulta() As Boolean 'dpereirv EMPTG
On Error GoTo Error
    
    Consulta_parametro_OSB
    
    Dim VLCodigoRespuesta As String
    VLInstAdq = ""
    
    
    Dim VLarreglo(30) As String
    PMChequea VGSqlConn&
    PMInicioTransaccion
    PMPasoValores VGSqlConn, "@t_trn", 0, SQLINT2, 1579
    PMPasoValores VGSqlConn&, "@i_operacion", 0, SQLVARCHAR, "Q"
    PMPasoValores VGSqlConn&, "@i_nemonico", 0, SQLVARCHAR, "REMPTG"
    PMPasoValores VGSqlConn&, "@i_producto", 0, SQLVARCHAR, "CTE"
    If FMTransmitirRPC(VGSqlConn, VGServerNameRec$, "cobis", "sp_parametro", True, "Transaccion Ok") = True Then
      VTR1% = FMMapeaArreglo(VGSqlConn&, VLarreglo())
      VlRucEmp = LTrim(RTrim(Trim(VLarreglo(4))))
    Else
      VlRucEmp = ""
    End If
    PMChequea VGSqlConn&
    PMFinTransaccion
    
    'CODIGO DEL BANCO PARA CONSULTA DE EPMTG
    PMChequea VGSqlConn&
    PMInicioTransaccion
    PMPasoValores VGSqlConn, "@t_trn", 0, SQLINT2, 1579
    PMPasoValores VGSqlConn&, "@i_operacion", 0, SQLVARCHAR, "Q"
    PMPasoValores VGSqlConn&, "@i_nemonico", 0, SQLVARCHAR, "CEPMTG"
    PMPasoValores VGSqlConn&, "@i_producto", 0, SQLVARCHAR, "CTE"
    If FMTransmitirRPC(VGSqlConn, VGServerNameRec$, "cobis", "sp_parametro", True, "Transaccion Ok") = True Then
      VTR1% = FMMapeaArreglo(VGSqlConn&, VLarreglo())
      VLCodBanco = LTrim(RTrim(Trim(VLarreglo(4))))
    Else
      VLCodBanco = ""
    End If
    PMChequea VGSqlConn&
    PMFinTransaccion
    
    'CODIGO DE SUCURSAL EPMTG

    PMChequea VGSqlConn&
    PMInicioTransaccion
    PMPasoValores VGSqlConn, "@t_trn", 0, SQLINT2, 1579
    PMPasoValores VGSqlConn&, "@i_operacion", 0, SQLVARCHAR, "Q"
    PMPasoValores VGSqlConn&, "@i_nemonico", 0, SQLVARCHAR, "SUCMTG"
    PMPasoValores VGSqlConn&, "@i_producto", 0, SQLVARCHAR, "CTE"
    If FMTransmitirRPC(VGSqlConn, VGServerNameRec$, "cobis", "sp_parametro", True, "Transaccion Ok") = True Then
      VTR1% = FMMapeaArreglo(VGSqlConn&, VLarreglo())
      VLSucursal = LTrim(RTrim(Trim(VLarreglo(4))))
    Else
      VLSucursal = ""
    End If
    PMChequea VGSqlConn&
    PMFinTransaccion
      
    
    'CONSULTA DE PROVINCIA
    PMChequeaATX VGSqlConn&
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 43099, "trn", ""
    PMPasoValoresATX VGSqlConn&, "@i_oficina", 0, SQLINT4, str(VGOficina%), "VGOficina%", ""
    PMPasoValoresATX VGSqlConn&, "@o_ciudad", 1, SQLINT4, 0, "ciudad", ""
    PMPasoValoresATX VGSqlConn&, "@o_provincia", 1, SQLVARCHAR, "", "provincia", ""
    PMPasoValoresATX VGSqlConn&, "@o_letras", 1, SQLVARCHAR, "", "letras", ""
    If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_consulta_provincia", True, "Transaccion Ok", "S", "N", "N", "134", "S", "S") = True Then
      VLProvincia = Trim(FMRetParamATX(VGSqlConn, 3))
    Else
      VLProvincia = ""
    End If
    PMChequeaATX VGSqlConn&
    PMFinTransaccion
    
    
    
    If Trim(VlRucEmp) = "" Then
        MsgBox "No existe Ruc parametrizado", vbCritical + vbOKOnly, "Atx"
        FLTransmitir_EPMTG_consulta = False
        Me.txtIngreso(0).SetFocus
       Exit Function
    End If
    
    If Trim(VLCodBanco) = "" Then
        MsgBox "No existe Codigo de Banco para la Consulta", vbCritical + vbOKOnly, "Atx"
        FLTransmitir_EPMTG_consulta = False
        Me.txtIngreso(0).SetFocus
       Exit Function
    End If
    
    If Trim(VLSucursal) = "" Then
        MsgBox "No existe Codigo de Sucursal para la Consulta", vbCritical + vbOKOnly, "Atx"
        FLTransmitir_EPMTG_consulta = False
        Me.txtIngreso(0).SetFocus
       Exit Function
    End If
    
    
    If Trim(VLProvincia) = "" Then
        MsgBox "No existe Provincia para la Consulta", vbCritical + vbOKOnly, "Atx"
        FLTransmitir_EPMTG_consulta = False
        Me.txtIngreso(0).SetFocus
       Exit Function
    End If
    
    'Llamar a la consulta Proveedor
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 62332, "Trn", ""
    If Trim(txtCampo(0).Text) = "2" And Trim(VLTipoID) <> "" Then
        PMPasoValoresATX VGSqlConn, "@i_ptipoId", 0, SQLVARCHAR, Trim$(VLTipoID), "TipoId", ""
        PMPasoValoresATX VGSqlConn, "@i_pcodigo", 0, SQLVARCHAR, Trim$(txtIngreso(0).Text), "CodigoId", ""
    Else
        PMPasoValoresATX VGSqlConn, "@i_ptipoId", 0, SQLVARCHAR, "", "TipoId", ""
        PMPasoValoresATX VGSqlConn, "@i_pcodigo", 0, SQLVARCHAR, "", "CodigoId", ""
    End If
    If (Trim(txtCampo(0).Text) = "3" Or Trim(txtCampo(0).Text) = "2") And Trim(VLTipoID) = "" Then
        PMPasoValoresATX VGSqlConn, "@i_pplaca", 0, SQLVARCHAR, Trim$(txtIngreso(0).Text), "placa", ""
    Else
        PMPasoValoresATX VGSqlConn, "@i_pplaca", 0, SQLVARCHAR, "", "placa", ""
    End If
    If Trim(txtCampo(0).Text) = "2" Then
        PMPasoValoresATX VGSqlConn, "@i_pservicio", 0, SQLVARCHAR, "CIT", "Tsolicitud", ""
    Else
        If Trim(txtCampo(0).Text) = "1" Then
        PMPasoValoresATX VGSqlConn, "@i_pservicio", 0, SQLVARCHAR, "SOL", "Tsolicitud", ""
        Else
        PMPasoValoresATX VGSqlConn, "@i_pservicio", 0, SQLVARCHAR, "REN", "Tsolicitud", ""
        End If
    End If
    PMPasoValoresATX VGSqlConn, "@i_pbanco", 0, SQLVARCHAR, VLCodBanco, "IdBanco", ""
    PMPasoValoresATX VGSqlConn, "@i_psucursal", 0, SQLVARCHAR, VLSucursal, "oficina", ""
    PMPasoValoresATX VGSqlConn, "@i_pcanal", 0, SQLVARCHAR, "VEN", "canal", ""
    PMPasoValoresATX VGSqlConn, "@i_pprovincia", 0, SQLVARCHAR, VLProvincia, "", ""
    If Trim(txtCampo(0).Text) = "2" Or Trim(txtCampo(0).Text) = "3" Then
        PMPasoValoresATX VGSqlConn, "@i_psolicitud", 0, SQLVARCHAR, "0", "CodSolicitud", ""
    Else
        PMPasoValoresATX VGSqlConn, "@i_psolicitud", 0, SQLVARCHAR, Trim$(txtIngreso(0).Text), "CodSolicitud", ""
    End If
    
    
    PMPasoValoresATX VGSqlConn, "@o_ptipoId", 1, SQLVARCHAR, Trim$(""), "", ""
    PMPasoValoresATX VGSqlConn, "@o_pcodigo", 1, SQLVARCHAR, Trim$(""), "", ""
    PMPasoValoresATX VGSqlConn, "@o_pnombre", 1, SQLVARCHAR, Trim$(""), "", """"
    PMPasoValoresATX VGSqlConn, "@o_pcantidad", 1, SQLVARCHAR, Trim$(""), "", ""
    PMPasoValoresATX VGSqlConn, "@o_pvalor", 1, SQLVARCHAR, Trim$(""), "", ""
    PMPasoValoresATX VGSqlConn, "@o_pnombre_tramite", 1, SQLVARCHAR, Trim$(""), "", ""
    PMPasoValoresATX VGSqlConn, "@o_pcod_respuesta", 1, SQLVARCHAR, Trim$(""), "", ""
    PMPasoValoresATX VGSqlConn, "@o_pmensaje", 1, SQLVARCHAR, Trim$(""), "", ""
    PMPasoValoresATX VGSqlConn, "@o_cit_regnacional", 1, SQLVARCHAR, Trim$(""), "", ""
    PMPasoValoresATX VGSqlConn, "@o_cit_atm", 1, SQLVARCHAR, Trim$(""), "", ""
    PMPasoValoresATX VGSqlConn, "@o_pago_SRI", 1, SQLVARCHAR, Trim$(""), "", ""
    PMPasoValoresATX VGSqlConn, "@o_solicitud", 1, SQLVARCHAR, Trim$(""), "", ""
    
    
    If FMTransmitirRPCATX(VGSqlConn, vl_servidor_BUS, "cob_procesador", "fp_consulta_epmtg", True, "Transaccion Ok", "S", "N", "N", "134", "S", "S") = True Then
    'If FMTransmitirRPCATX(VGSqlConn, "PSSRV1", "cob_procesador", "fp_consulta_epmtg", True, "Transaccion Ok", "S", "N", "N", "134", "S", "S") = True Then
        FLTransmitir_EPMTG_consulta = True
        
        VLTipoID_Placa = Mid(Trim(FMRetParamATX(VGSqlConn, 1)), 1, 60)
        VLIdentf_Placa = Mid(Trim(FMRetParamATX(VGSqlConn, 2)), 1, 60)
        Me.txtNombre = Mid(Trim(FMRetParamATX(VGSqlConn, 3)), 1, 35)
        VLNumCitaciones = Trim(FMRetParamATX(VGSqlConn, 4))
        TotalPagar.Text = CCur(Trim(FMRetParamATX(VGSqlConn, 5)) / 100)
        VLNombre_tramite = Trim(FMRetParamATX(VGSqlConn, 6))
        VLpcodresp = Trim(FMRetParamATX(VGSqlConn, 7))
        VLpmensaje = Trim(FMRetParamATX(VGSqlConn, 8))
        VLpcit_regional = Trim(FMRetParamATX(VGSqlConn, 9))
        VLpcit_atm = Trim(FMRetParamATX(VGSqlConn, 10))
        VLppago_sri = Trim(FMRetParamATX(VGSqlConn, 11))
        VLSolicitud = Trim(FMRetParamATX(VGSqlConn, 12))
        txt_reg_nacional.Caption = VLpcit_regional
        txt_atm.Caption = VLpcit_atm
        txt_pagosri.Caption = VLppago_sri
        
        
        If Trim(txtCampo(0).Text) = "2" Then
            txtCitaciones = VLNumCitaciones
        Else
            txtCitaciones = Mid(VLNombre_tramite, 1, 35)
        End If

        'Valor viene en cero
        If TotalPagar.Text <= 0 Then
            MsgBox "NO TIENE DEUDA PENDIENTE", vbExclamation, App.Title
            FLTransmitir_EPMTG_consulta = False
            PMFinTransaccion
            PMChequeaATX VGSqlConn
            Exit Function
        End If
    Else
        FLTransmitir_EPMTG_consulta = False
        PMFinTransaccion
        PMChequeaATX VGSqlConn
        Exit Function
    End If
    PMChequeaATX VGSqlConn
    PMFinTransaccion
    
    
    'CONSULTA DE COMISION
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 4050, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_empresa", 0, SQLVARCHAR, txtCampo(1).Text, "Codigo de empresa", ""
    PMPasoValoresATX VGSqlConn, "@i_cons_comision", 0, SQLINT1, "1", "Indica Comision", ""
    PMPasoValoresATX VGSqlConn, "@i_servi_person", 0, SQLVARCHAR, "CSPB", "Servicio Person", ""
    PMPasoValoresATX VGSqlConn, "@i_rubro_person", 0, SQLVARCHAR, "EMTG", "Rubro Person", ""
    PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Canal Person", ""
    PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, 0, "ssn", ""
    PMPasoValoresATX VGSqlConn, "@o_comision", 1, SQLMONEY, 0, "Comision", ""
    PMPasoValoresATX VGSqlConn, "@o_tasa", 1, SQLMONEY, "0", "tasa", ""
    PMPasoValoresATX VGSqlConn, "@o_base_imp", 1, SQLMONEY, "0", "base_imp", ""
    PMPasoValoresATX VGSqlConn, "@o_impuesto", 1, SQLMONEY, "0", "impuesto", ""
    If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_val_servicios_varios", True, "Transaccion Ok", "S", "N", "N", "134", "S", "S") = True Then
        Comision = FMRetParamATX(VGSqlConn, 2)
        VlbaseImp = FMRetParamATX(VGSqlConn, 4)
        VLiva = FMRetParamATX(VGSqlConn, 5)
        VLSsn = FMRetParamATX(VGSqlConn, 1)
        If Len(Trim$(VLSsn)) > 12 Then
            VLSsn = Right$(Trim$(VLSsn), 12)
        Else
            VLSsn = String(12 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
        End If
        
        If CCur(Comision.Text) > 0 Then
            Comision.Enabled = True
        End If
        PMChequeaATX VGSqlConn&
        PMFinTransaccion
        
        'LBP Inicio RECA-CC-SGC00025869
        If Comision > 0 Then
            VGCom_aux = FMDevuelveComisionReal(Comision, False, 134)
            If VGCom_aux <> CDbl(Comision.Text) Then
                VGComision_original = Comision.Text
                Comision.Text = VGCom_aux
            Else
                VGComision_original = Comision.Text
            End If
        End If
       'LBP Fin RECA-CC-SGC00025869
        
    Else
        FLTransmitir_EPMTG_consulta = False
        Comision = 0
        PMChequeaATX VGSqlConn&
        PMFinTransaccion
        Exit Function
    End If
'
'    Efe.Enabled = True
'    Loc.Enabled = True
'    CantChq.Enabled = True
'    CboTipCta.Enabled = True
'    Cta.Enabled = True
'    Empresa.Enabled = False
'    Servicio.Enabled = False
'    Ref.Enabled = False
'    Efe.SetFocus
'    DoEvents

    Exit Function
Error:

    MsgBox "Error al transmitir la transaccion " & Chr(13) & "Error:" & Err.Description, vbCritical
    PMChequeaATX VGSqlConn&
    PMFinTransaccion
    FLTransmitir_EPMTG_consulta = False
End Function

Function FLTransmitir_ANT_consulta() As Boolean 'KBastida ANT
On Error GoTo Error
    
    Dim VLCodigoRespuesta As String
    Dim VLTrn As String
    Dim VLTrnF As String
    Dim flujo As String
    Dim VLHorar As String
    Dim VLautprov As String
    Dim Prueba As Double
    
    VLInstAdq = ""
    VLTrnF = "62684"
    flujo = "fp_consulta_reca_ms"
    VLTrn = "3925"
    VLHorario = "N"
    
    If VGHorarioDif = True Then
            If VLHorarioEmp = "N" Then
                If CCur(Loc) > 0 Then
                    VLTrn = "3926"
                    VLHorar = "D"
                Else
                    VLTrn = "3925"
                    VLHorario = "N"
                End If
            Else
                VLTrn = "3927"
                VLHorario = "D"
            End If
    End If
    
    
    'CONSULTA DE LOCALIDAD
    PMChequeaATX VGSqlConn&
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 43099, "trn", ""
    PMPasoValoresATX VGSqlConn&, "@i_oficina", 0, SQLINT4, str(VGOficina%), "VGOficina%", ""
    PMPasoValoresATX VGSqlConn&, "@i_empresa", 0, SQLINT4, CInt(Trim(txtCampo(1).Text)), "Empresa", ""
    PMPasoValoresATX VGSqlConn&, "@o_ciudad", 1, SQLINT4, 0, "ciudad", ""
    PMPasoValoresATX VGSqlConn&, "@o_provincia", 1, SQLVARCHAR, "", "provincia", ""
    PMPasoValoresATX VGSqlConn&, "@o_letras", 1, SQLVARCHAR, "", "letras", ""
    PMPasoValoresATX VGSqlConn&, "@o_localidad", 1, SQLVARCHAR, "", "localidad", ""
    PMPasoValoresATX VGSqlConn&, "@o_nom_prov", 1, SQLVARCHAR, "", "nom_provincia", ""
    If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_consulta_provincia", True, "Transaccion Ok", "S", "N", "N", "134", "S", "S") = True Then
      vllocalidad = Trim(FMRetParamATX(VGSqlConn, 4))
      vlnomprov = Trim(FMRetParamATX(VGSqlConn, 5))
    Else
      vllocalidad = ""
      vlnomprov = ""
    End If
    PMChequeaATX VGSqlConn&
    PMFinTransaccion
    
    'Llamar a la consulta Proveedor
    PMInicioTransaccion
    If VLTipoID = "PASS" Then
        VLTipoID = "PAS"
    End If
    
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrnF, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_trn", 0, SQLINT4, VLTrn, "Itrn", ""
    PMPasoValoresATX VGSqlConn, "@e_canal", 0, SQLVARCHAR, "VEN", "canal", ""
    PMPasoValoresATX VGSqlConn, "@e_tipo_banca", 0, SQLVARCHAR, "BP", "BP", ""
    PMPasoValoresATX VGSqlConn, "@s_date", 0, SQLVARCHAR, Format$(VGFechaProceso, "yyyy-mm-dd") + "T" + Format$(Time(), "hh:mm:ss"), "FechaLocal", ""
    PMPasoValoresATX VGSqlConn&, "@s_ofi", 0, SQLINT4, str(VGOficina%), "VGOficina%", ""
    PMPasoValoresATX VGSqlConn, "@e_empresa", 0, SQLINT4, CInt(Trim(txtCampo(1).Text)), "Empresa", ""
    PMPasoValoresATX VGSqlConn, "@e_convenio", 0, SQLVARCHAR, VLConvenio, "Convenio", ""
    PMPasoValoresATX VGSqlConn, "@e_tipo_servicio", 0, SQLVARCHAR, "AUTOMOTORES_PEATONES", "Tipo Servicio", ""
    PMPasoValoresATX VGSqlConn, "@e_servicio", 0, SQLVARCHAR, VLConvenio, "Rubro", ""
    PMPasoValoresATX VGSqlConn, "@e_identificacion", 0, SQLVARCHAR, Trim$(txtIngreso(0).Text), "Identificador", ""  'CED PASS -> codigoTipoIdentificador
    PMPasoValoresATX VGSqlConn, "@e_localidad", 0, SQLVARCHAR, vllocalidad, "Localidad", ""
    PMPasoValoresATX VGSqlConn, "@e_provincia", 0, SQLVARCHAR, vlnomprov, "Provincia", ""
    
    If VLTipoID = "" Then
        'PMPasoValoresATX VGSqlConn, "@e_tipo_identificador", 0, SQLVARCHAR, VLConvenio, "Tipo Identificador", ""
        PMPasoValoresATX VGSqlConn, "@e_tipo_identificador", 0, SQLVARCHAR, "SOL", "Tipo Identificador", ""
    Else
        PMPasoValoresATX VGSqlConn, "@e_tipo_identificador", 0, SQLVARCHAR, VLTipoID, "Tipo Identificador", ""
    End If
    
    PMPasoValoresATX VGSqlConn, "@codigoRespuesta", 1, SQLINT4, 0, "cod", ""
    PMPasoValoresATX VGSqlConn, "@nombreCliente", 1, SQLVARCHAR, "XXXXXXXXXXXXXXXXXXXXXXX", "nombreCliente", ""
    PMPasoValoresATX VGSqlConn, "@formaPago", 1, SQLVARCHAR, "XXXXXXXXXXXXXXXXXXXXXXX", "formapago", ""
    PMPasoValoresATX VGSqlConn, "@montoTotal", 1, SQLVARCHAR, 0, "formapago", ""
    
    
    If FMTransmitirRPCATX(VGSqlConn, "RECSRV", "cob_procesador", flujo, True, "Transaccion Ok", "S", "N", "N", "134", "S", "S") = True Then
       FLTransmitir_ANT_consulta = True
       PMMapeaGridATX VGSqlConn, grdDetalle, False
       VTResult% = FMMapeaMatrizATX(VGSqlConn&, vtmatrizcps())
       
       'BLoqueo Cheque
       CantChq.Enabled = True
       Loc.Enabled = True
       'LLenar el grid con la info del micro Ini
       grdDetalle.Rows = grdDetalle.Rows
            grdDetalle.Cols = grdDetalle.Cols
            For I = 1 To grdDetalle.Rows - 1
                 grdDetalle.Row = I
                 grdDetalle.Col = 0
                 grdDetalle.Row = I
                 grdDetalle.Col = 0
                 grdDetalle.Text = Trim$(str$(I))
                 For j = 1 To grdDetalle.Cols - 1
                     grdDetalle.Col = j
                     grdDetalle.Row = I
                     grdDetalle.Col = j
                     grdDetalle.Text = grdDetalle.Text
                 Next
            Next
        'LLenar el grid con la info del micro Ini
        
        grdDetalle.Row = 1
        grdDetalle.Col = 2
        VLNumCitaciones = grdDetalle.Text
        Me.txtNombre = Mid(Trim(FMRetParamATX(VGSqlConn, 2)), 1, 35)
        grdDetalle.Row = 1
        grdDetalle.Col = 12
        
        TotalPagar.Text = grdDetalle.Text 'FMRetParamATX(VGSqlConn, 4)
        'Total.Text = FMRetParamATX(VGSqlConn, 4)
        VLpcodresp = FMRetParamATX(VGSqlConn, 1)
        VLpmensaje = FMRetParamATX(VGSqlConn, 5)
        
        If VLNumCitaciones <> "" Then
            'txtCitaciones = VLNumCitaciones
            txtCitaciones = txtIngreso(0).Text
        Else
            txtCitaciones = txtIngreso(0).Text
        End If

        'Valor viene en cero
        If TotalPagar.Text <= 0 Then
        'If Total.Text <= 0 Then
            MsgBox "NO TIENE DEUDA PENDIENTE", vbExclamation, App.Title
            FLTransmitir_ANT_consulta = False
            PMFinTransaccion
            PMChequeaATX VGSqlConn
            Exit Function
        End If
    
    
    Else
        FLTransmitir_ANT_consulta = False
        PMFinTransaccion
        PMChequeaATX VGSqlConn
        Exit Function
    End If
    PMChequeaATX VGSqlConn
    PMFinTransaccion
    
    
    'CONSULTA DE COMISION
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 4050, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_empresa", 0, SQLVARCHAR, txtCampo(1).Text, "Codigo de empresa", ""
    PMPasoValoresATX VGSqlConn, "@i_cons_comision", 0, SQLINT1, "1", "Indica Comision", ""
    PMPasoValoresATX VGSqlConn, "@i_servi_person", 0, SQLVARCHAR, "CSPB", "Servicio Person", ""
    PMPasoValoresATX VGSqlConn, "@i_rubro_person", 0, SQLVARCHAR, "ANT", "Rubro Person", ""
    PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Canal Person", ""
    PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, 0, "ssn", ""
    PMPasoValoresATX VGSqlConn, "@o_comision", 1, SQLMONEY, 0, "Comision", ""
    PMPasoValoresATX VGSqlConn, "@o_tasa", 1, SQLMONEY, "0", "tasa", ""
    PMPasoValoresATX VGSqlConn, "@o_base_imp", 1, SQLMONEY, "0", "base_imp", ""
    PMPasoValoresATX VGSqlConn, "@o_impuesto", 1, SQLMONEY, "0", "impuesto", ""
    If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_val_servicios_varios", True, "Transaccion Ok", "S", "N", "N", "134", "S", "S") = True Then
        Comision = FMRetParamATX(VGSqlConn, 2)
        VlbaseImp = FMRetParamATX(VGSqlConn, 4)
        VLiva = FMRetParamATX(VGSqlConn, 5)
        VLSsn = FMRetParamATX(VGSqlConn, 1)
        If Len(Trim$(VLSsn)) > 12 Then
            VLSsn = Right$(Trim$(VLSsn), 12)
        Else
            VLSsn = String(12 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
        End If
        
        If CCur(Comision.Text) > 0 Then
            Comision.Enabled = True
        End If
        PMChequeaATX VGSqlConn&
        PMFinTransaccion
        
        'LBP Inicio RECA-CC-SGC00025869
        If Comision > 0 Then
            VGCom_aux = FMDevuelveComisionReal(Comision, False, 134)
            If VGCom_aux <> CDbl(Comision.Text) Then
                VGComision_original = Comision.Text
                Comision.Text = VGCom_aux
            Else
                VGComision_original = Comision.Text
            End If
        End If
       'LBP Fin RECA-CC-SGC00025869
    Else
        FLTransmitir_ANT_consulta = False
        Comision = 0
        PMChequeaATX VGSqlConn&
        PMFinTransaccion
        Exit Function
    End If

    Exit Function
Error:

    MsgBox "Error al transmitir la transaccion " & Chr(13) & "Error:" & Err.Description, vbCritical
    PMChequeaATX VGSqlConn&
    PMFinTransaccion
    FLTransmitir_ANT_consulta = False
End Function

Function FLBuscarItem(VLELemento As String) As String
    Dim I As Integer
    Dim hallado As Boolean
    I = 1
    hallado = False
    Do While I < 53 And Not hallado
        
        If vtmatrizcps(0, I) = Trim$(VLELemento) Then
            hallado = True
        Else
            I = I + 1
        End If
    Loop
    If hallado Then
        FLBuscarItem = vtmatrizcps(1, I)
    Else
        FLBuscarItem = ""
    End If
End Function
        Function FLTransmitir_EPMTG_pago() As Boolean 'dpereirv
On Error GoTo Error
    Consulta_parametro_OSB

    Dim fr_ced_ruc As String
    fr_ced_ruc = Replace(SGCedula, "_", "")
    
    VLServicio = "Recaudacion"
    
    If VGHorarioDif Then
        VLTrn = "3926"
        VLHorario = "D"
    Else
        VLTrn = "3925"
        VLHorario = "N"
    End If
    
    VGTrn = IIf(VLTrn = "", 0, VLTrn)
    
    VLIndReverso = False
    
    If VGTipoEjecucion% = CGReverso% Then
        VLIndReverso = True
    End If

    PMChequeaATX VGSqlConn
    PMFinTransaccion
    PMInicioTransaccion
    If VGTipoEjecucion% <> CGReverso% Then
        PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLVARCHAR, "N", "TCORR", ""
    End If
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 62334, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(FMObtenerMonedaForma("134")), "Moneda", ""
    PMPasoValoresATX VGSqlConn, "@i_servicio", 0, SQLVARCHAR, txtCampo(0).Text, "Rubro", ""
    PMPasoValoresATX VGSqlConn, "@i_empresa", 0, SQLVARCHAR, Trim(Me.txtCampo(1).Text), "Empresa", ""
    PMPasoValoresATX VGSqlConn, "@i_emp", 0, SQLVARCHAR, Trim(Me.txtCampo(1).Text), "Empresa2", "" ' Para recuperar en reverso
    PMPasoValoresATX VGSqlConn, "@i_servname", 0, SQLVARCHAR, (lblDescripcion(0).Caption), "NomServ", ""      ' Para recuperar en reverso
    PMPasoValoresATX VGSqlConn, "@i_empname", 0, SQLVARCHAR, (lblDescripcion(1).Caption), "NomEmp", ""    ' Para recuperar en reverso
    PMPasoValoresATX VGSqlConn, "@i_nomb_tramite", 0, SQLVARCHAR, VLNombre_tramite, "NomEmp", "" ' Para recuperar en reverso
    PMPasoValoresATX VGSqlConn, "@i_cantcit", 0, SQLVARCHAR, VLNumCitaciones, "Numcit", "" ' Para recuperar en reverso
    PMPasoValoresATX VGSqlConn, "@i_reg_nac", 0, SQLVARCHAR, txt_reg_nacional.Caption, "Reg_nac", "" ' Para recuperar en reverso
    PMPasoValoresATX VGSqlConn, "@i_atm", 0, SQLVARCHAR, txt_atm.Caption, "atm", "" ' Para recuperar en reverso
    PMPasoValoresATX VGSqlConn, "@i_pago_sri", 0, SQLVARCHAR, txt_pagosri.Caption, "pago_sri", "" ' Para recuperar en reverso

        
    PMPasoValoresATX VGSqlConn, "@i_efectivo", 0, SQLMONEY, (Efe.Text), "efe", ""
    PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, (Loc.Text), "Cheques", ""
    PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, (Debito.Text), "Debito", ""
    PMPasoValoresATX VGSqlConn, "@i_subtotal", 0, SQLMONEY, (TotalPagar.Text), "Subtotal", ""
    PMPasoValoresATX VGSqlConn, "@i_comision_tot", 0, SQLMONEY, (Comision.Text), "valor de la comision", ""
    PMPasoValoresATX VGSqlConn, "@i_comision_efe", 0, SQLMONEY, (VLEfe_com), "Com. efectivo", ""
    PMPasoValoresATX VGSqlConn, "@i_comision_chq", 0, SQLMONEY, (VLChq_com), "Com. Cheques", ""
    PMPasoValoresATX VGSqlConn, "@i_comision_db", 0, SQLMONEY, (VLDeb_com), "Com. debito", "" 'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
    
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
    
    PMPasoValoresATX VGSqlConn, "@i_total", 0, SQLMONEY, (Total.Text), "Total pagado", ""
'    PMPasoValoresATX VGSqlConn, "@i_totval", 0, SQLMONEY, (Pago_Val.Text), "Total a pagar", ""
'    PMPasoValoresATX VGSqlConn, "@i_totapag", 0, SQLMONEY, (Total.Text), "Total", ""
    If CantChq.Text = "" Then
        PMPasoValoresATX VGSqlConn, "@i_cant_cheques", 0, SQLINT4, "0", "Cantidad de cheques", ""
    Else
        PMPasoValoresATX VGSqlConn, "@i_cant_cheques", 0, SQLINT4, (CantChq.Text), "Cantidad de cheques", ""
    End If
    'msilvag Inicio RECA-CC-SGC00030409 - Facturacion OffLine Debitos
    If Me.Cta.ClipText <> "" Then
        PMPasoValoresATX VGSqlConn, "@i_tipo_cta", 0, SQLCHAR, (CboTipCta.Text), "TipoCta", ""
        PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
    Else
        PMPasoValoresATX VGSqlConn, "@i_tipo_cta", 0, SQLVARCHAR, (VLTipCta_com), "TipoCta", ""
        PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (VLCta_com), "Cuenta", ""
    End If
    'msilvag Fin
    PMPasoValoresATX VGSqlConn, "@i_nombre_cta", 0, SQLVARCHAR, NomCta.Text, "Nombre cuenta", ""
    PMPasoValoresATX VGSqlConn, "@i_autoriza", 0, SQLCHAR, VGAutoriza, "Autorizacion", ""
    PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Ventanilla", ""
    PMPasoValoresATX VGSqlConn, "@i_cod_cliente", 0, SQLVARCHAR, (Me.txtIngreso(0).Text), "Cod. Cliente", ""
    PMPasoValoresATX VGSqlConn, "@i_cod_referencia", 0, SQLVARCHAR, (txtIngreso(0).Text), "Cod. Cliente", ""
    'PMPasoValoresATX VGSqlConn, "@i_ruc_cliente", 0, SQLVARCHAR, VLCedula, "Ruc Cliente", ""
    PMPasoValoresATX VGSqlConn, "@i_nombre_cliente", 0, SQLVARCHAR, txtNombre, "Nom. Cliente", ""

    'Parametros del proveedor
    If Trim(txtCampo(0).Text) = "2" And Trim(VLTipoID) <> "" Then
        PMPasoValoresATX VGSqlConn, "@i_ptipoId", 0, SQLVARCHAR, Trim$(VLTipoID), "TipoId", ""
        PMPasoValoresATX VGSqlConn, "@i_pcodigo", 0, SQLVARCHAR, Trim$(txtIngreso(0).Text), "CodigoId", ""
    ElseIf (Trim(txtCampo(0).Text) = "3" Or Trim(txtCampo(0).Text) = "2") And Trim(VLTipoID) = "" Then
        PMPasoValoresATX VGSqlConn, "@i_ptipoId", 0, SQLVARCHAR, VLTipoID_Placa, "TipoId", ""
        PMPasoValoresATX VGSqlConn, "@i_pcodigo", 0, SQLVARCHAR, VLIdentf_Placa, "CodigoId", ""
    Else
        PMPasoValoresATX VGSqlConn, "@i_ptipoId", 0, SQLVARCHAR, "", "TipoId", ""
        PMPasoValoresATX VGSqlConn, "@i_pcodigo", 0, SQLVARCHAR, "", "CodigoId", ""
    End If
    If (Trim(txtCampo(0).Text) = "3" Or Trim(txtCampo(0).Text) = "2") And Trim(VLTipoID) = "" Then
        PMPasoValoresATX VGSqlConn, "@i_pplaca", 0, SQLVARCHAR, Trim$(txtIngreso(0).Text), "placa", ""
    Else
        PMPasoValoresATX VGSqlConn, "@i_pplaca", 0, SQLVARCHAR, "", "placa", ""
    End If
    If Trim(txtCampo(0).Text) = "2" Then
        PMPasoValoresATX VGSqlConn, "@i_pservicio", 0, SQLVARCHAR, "CIT", "Tsolicitud", ""
    Else
      If Trim(txtCampo(0).Text) = "1" Then
        PMPasoValoresATX VGSqlConn, "@i_pservicio", 0, SQLVARCHAR, "SOL", "Tsolicitud", ""
      Else
        PMPasoValoresATX VGSqlConn, "@i_pservicio", 0, SQLVARCHAR, "REN", "Tsolicitud", ""
      End If
    End If
    PMPasoValoresATX VGSqlConn, "@i_pvalor", 0, SQLVARCHAR, (TotalPagar * 100), "valor", ""
    
    PMPasoValoresATX VGSqlConn, "@i_pcanal", 0, SQLVARCHAR, "VEN", "canal", ""
    
    If VGTipoEjecucion% = CGReverso% Then   'Validacion por REVERSO
        VGTipoEjecucion% = CGNormal%
                If vl_servidor_BUS <> "PSSRV1" Then
                        VLSsn = String(12 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)  'pricaura   al flujo se debe enviar formateado con 0 a la izq tal como el pago,
                End If
        PMPasoValoresATX VGSqlConn, "@i_pcodtrx", 0, SQLVARCHAR, VLSsn, "codtrx", ""
        PMPasoValoresATX VGSqlConn, "@i_psec_banco", 0, SQLINT4, VLSsn, "SecBanco", ""
        VGTipoEjecucion% = CGReverso%
    Else
        PMPasoValoresATX VGSqlConn, "@i_pcodtrx", 0, SQLVARCHAR, VLSsn, "codtrx", ""
        PMPasoValoresATX VGSqlConn, "@i_psec_banco", 0, SQLINT4, VLSsn, "SecBanco", ""
    End If
    PMPasoValoresATX VGSqlConn, "@i_pbanco", 0, SQLVARCHAR, VLCodBanco, "codbanco", ""
    PMPasoValoresATX VGSqlConn, "@i_psucursal", 0, SQLVARCHAR, VLSucursal, "oficina", ""
    PMPasoValoresATX VGSqlConn, "@i_pprovincia", 0, SQLVARCHAR, VLProvincia, "canal", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_trx", 0, SQLVARCHAR, Format$(Date, "DD-MM-YYYY") + " " + Format$(Time(), "hh:mm:ss"), "fechatrx", ""
'    PMPasoValoresATX VGSqlConn, "@i_pfecha_cont", 0, SQLVARCHAR, Format$(Date, "yyyymmdd"), "fechacont", ""
    If Trim(txtCampo(0).Text) = "2" Then
        PMPasoValoresATX VGSqlConn, "@i_psolicitud", 0, SQLVARCHAR, "0", "CodSolicitud", ""
    Else
        If Trim(txtCampo(0).Text) = "3" Then
            PMPasoValoresATX VGSqlConn, "@i_psolicitud", 0, SQLVARCHAR, Trim$(VLSolicitud), "CodSolicitud", ""
        Else
            PMPasoValoresATX VGSqlConn, "@i_psolicitud", 0, SQLVARCHAR, Trim$(txtIngreso(0).Text), "CodSolicitud", ""
        End If
    End If
   
    'Valores de salida
    PMPasoValoresATX VGSqlConn, "@o_fecha_contable", 1, SQLVARCHAR, "XXXXXXXXXX", "Feccontable", ""
    PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, "0", "0", "sec"
    PMPasoValoresATX VGSqlConn, "@o_autorisri", 1, SQLVARCHAR, "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", "", ""
    PMPasoValoresATX VGSqlConn, "@o_fecvensri", 1, SQLVARCHAR, "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", "", ""
    PMPasoValoresATX VGSqlConn, "@o_nota_venta", 1, SQLVARCHAR, "xxxxxxxxxxxxxxxxxxxx", "", ""
    PMPasoValoresATX VGSqlConn, "@o_fact_elect", 1, SQLVARCHAR, "x", "", ""
    PMPasoValoresATX VGSqlConn, "@o_cod_respuesta", 1, SQLVARCHAR, "xxxx", "", ""
    PMPasoValoresATX VGSqlConn, "@o_mensaje_respuesta", 1, SQLVARCHAR, "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", "", ""
    PMPasoValoresATX VGSqlConn, "@o_fec_ini_vig_aut", 1, SQLVARCHAR, "x", "", ""
    PMPasoValoresATX VGSqlConn, "@o_fec_fin_vig_aut", 1, SQLVARCHAR, "x", "", ""
    PMPasoValoresATX VGSqlConn, "@o_fecdessri", 1, SQLVARCHAR, "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", "", ""
    PMPasoValoresATX VGSqlConn, "@o_horario", 1, SQLCHAR, "x", "", ""
    PMPasoValoresATX VGSqlConn, "@o_pcodtrx", 1, SQLVARCHAR, Trim$(""), "", ""
    PMPasoValoresATX VGSqlConn, "@o_pcod_respuesta", 1, SQLVARCHAR, Trim$(""), "", """"
    PMPasoValoresATX VGSqlConn, "@o_pmensaje", 1, SQLVARCHAR, Trim$(""), "", ""
    PMPasoValoresATX VGSqlConn, "@o_ssn_recibo", 1, SQLVARCHAR, Trim$(""), "", ""
    
    If FMTransmitirRPCATX(VGSqlConn, vl_servidor_BUS, "cob_procesador", "fp_pago_epmtg", True, "Transaccion Ok", "S", "N", "S", "134", "S", "S") = True Then
    'If FMTransmitirRPCATX(VGSqlConn, "PSSRV1", "cob_procesador", "fp_pago_epmtg", True, "Transaccion Ok", "S", "N", "S", "134", "S", "S") = True Then
        Dim vtma(2, 50) As String
        VTResult% = FMMapeaMatrizATX(VGSqlConn, vtma())
        VLTsnTemporal = VGTSN%
        PMChequeaATX VGSqlConn
        PMTotalesBranch "51"
        VLCambio% = False
        '------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 2)
        VLSSnCorreccion = FMRetParamATX(VGSqlConn, 2)
        
        VLMG_ossn = FMRetParamATX(VGSqlConn, 2)
        VLSsn = FMRetParamATX(VGSqlConn, 2)
        VLMG_autorisri = Trim(FMRetParamATX(VGSqlConn, 3))
        VLautoriSri = Trim(VLMG_autorisri)
        VLMG_fecvensri = FMRetParamATX(VGSqlConn, 4)
        VLFecvenSRI = Trim(VLMG_fecvensri)
        If VGTipoEjecucion% <> CGReverso% Then
            VLFechaCorte = FMRetParamATX(VGSqlConn, 1)
            VLFechaContable = VLFechaCorte
        End If
        VLHorario = Trim(FMRetParamATX(VGSqlConn, 12))
        VLDpCcodResp = Trim(FMRetParamATX(VGSqlConn, 8))
        VLfact_elect = Trim(FMRetParamATX(VGSqlConn, 6))
        VLSerie_Secuencia = Trim(FMRetParamATX(VGSqlConn, 5))
        
        VLMG_Fecinivig = FMRetParamATX(VGSqlConn, 9)
        VLFecinivig = Trim(VLMG_Fecinivig)
        VLMG_Fecfinvig = FMRetParamATX(VGSqlConn, 10)
        VLFecfinvig = Trim(VLMG_Fecfinvig)
        If VGTipoEjecucion% = CGReverso% Then 'ultimo
            VLCodAutorizacion = vtma(1, 5)
        Else
           VLCodAutorizacion = Trim(FMRetParamATX(VGSqlConn, 16))
        End If
        
        VLNombSuscr = Me.txtNombre

        PMChequeaATX VGSqlConn
        PMTotalesBranch "51"
        FLTransmitir_EPMTG_pago = True
        VLCambio% = False
        VLCambioCedruc% = False
        'TPE ------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 2)
        VTIndicadorSum = 1
        PMIniciaRegSum
        '<-----
    Else
        VLCambio% = True
        VLCambioCedruc% = True
        FLTransmitir_EPMTG_pago = False
        'TPE ------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 2)
        VTIndicadorSum = 0
        PMChequeaATX VGSqlConn
        '<------
    End If
    
    PMChequeaATX VGSqlConn
    If FMRetStatusATX(VGSqlConn) <> 0 Then
        VTIndicadorSum = 0
        FLTransmitir_EPMTG_pago = False
    End If
    
    PMFinTransaccion
    
    If FLTransmitir_EPMTG_pago = True Then
      'JPM Lectora de Billetes -->
      If CCur(Efe.Text) > 0 And ((VGDatPersBillAltDen.dataOK And VGTipoEjecucion = CGNormal%) Or VGTipoEjecucion = CGReverso%) Then
        'Call PMGuardarDsglsBillete("134", SGSecTrn$, VLTrn, rptBAD, CboTipCta.Text, Cta.ClipText)
        Call PMGuardarDsglsBillete("134", SGSecTrn$, VLTrn, rptBAD, "REC", "")
      End If
      '<-- JPM Lectora de Billetes
      Call PLFactura
    End If
    'Sumadora -->
    If VGTipoEjecucion% <> CGReverso% Then   'Validacion por REVERSO
        If (VTIndicadorSum = 1 _
        And (Trim$(VGStatusCon) = "A" _
        Or Trim$(VGStatusCon) = "")) Then
            SGPrimeraVez = 0     ' ya no es primera vez
            PMGrabaDesglose VLTrn, CStr(SGUsar), VLCambio%
            If VLCambio% = True Then
                MsgBox "Error en la Grabacion del Desglose. Favor comuniquese con su Supervisor.", vbCritical, "Error de Sistema"
                FLTransmitir_EPMTG_pago = False
            End If
            SGActual = 1  'seteo Variable para borrar desglose
        ElseIf VTIndicadorSum = 0 Then
            SGActual = 0  'no borrar desglose en caso de Error en Transaccion
        End If
    ElseIf VTIndicadorSum = 1 Then                'Por REVERSO
        PMEgresoEfectivo SGUsar, VLTrn, VGSSNCorr&
    End If
    
    Exit Function
    
Error:
    MsgBox "Error al transmitir la transaccion " & Chr(13) & "Error:" & Err.Description, vbCritical
    PMChequeaATX VGSqlConn
    PMFinTransaccion
    FLTransmitir_EPMTG_pago = False
    
End Function

Function FLTransmitir_ANT_pago() As Boolean 'dpereirv
On Error GoTo Error
    Dim fr_ced_ruc As String
    Dim flujo As String
    Dim VLTrnF As String
    Dim cnv_FechaDebito As String
    fr_ced_ruc = Replace(SGCedula, "_", "")
    VLServicio = "Recaudacion"
    VLTrnF = "62685"
    flujo = "fp_pago_reca_ms"
    VLTrn = "3925"
    VLHorario = "N"
    '***************** VALIDACION HORARIO ***********
    If VGHorarioDif = True Then
        If VLHorarioEmp = "N" Then
            If CCur(Loc) > 0 Then
                VLTrn = "3926"
                VLHorario = "D"
            Else
                VLTrn = "3925"
                VLHorario = "N"
            End If
        Else
            VLTrn = "3927"
            VLHorario = "D"
        End If
    End If
      
    VGTrn = IIf(VLTrn = "", 0, VLTrn)
    VLIndReverso = False
    
    If VGTipoEjecucion% = CGReverso% Then
        VLIndReverso = True
        VLTrnF = "62690"
        flujo = "fp_reverso_reca_ms"
    End If

    '***************** OBTENER INFO DE OFICINA ***********
    If VGTipoEjecucion = CGNormal% And Me.Credito.Text > 0 Then
        If FLTransmitirDatos() = False Then
            MsgBox "No existen datos de referencia de oficina", vbCritical, "Error"
        End If
    End If

    PMChequeaATX VGSqlConn
    PMFinTransaccion
    PMInicioTransaccion
    If VGTipoEjecucion% <> CGReverso% Then
        PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLVARCHAR, "N", "TCORR", ""
        PMPasoValoresATX VGSqlConn, "@e_corr", 0, SQLVARCHAR, "N", "TCORR", ""
    End If
    
    
    If Debito.Text > 0 Then
        VLTPCuenta = CboTipCta.Text
    End If
    
          
    '****** BRANCH *******************************************************
    PMPasoValoresATX VGSqlConn, "@i_moneda", 0, SQLINT1, str(FMObtenerMonedaForma("134")), "Moneda", ""
    PMPasoValoresATX VGSqlConn, "@i_val", 0, SQLMONEY, Efe.Text, "Efectivo", ""
    PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, Debito.Text, "Debito", ""
    PMPasoValoresATX VGSqlConn, "@i_tarjeta", 0, SQLMONEY, (Credito.Text), "tarjeta", ""
    PMPasoValoresATX VGSqlConn, "@i_efe_com", 0, SQLMONEY, (VLEfe_com), "Com. efectivo", ""
    PMPasoValoresATX VGSqlConn, "@i_deb_com", 0, SQLMONEY, (VLDeb_com), "Com. Debito", ""
    PMPasoValoresATX VGSqlConn, "@i_chq_com", 0, SQLMONEY, (VLChq_com), "Com. Cheques", ""
    If Me.Cta.ClipText <> "" Then
        PMPasoValoresATX VGSqlConn, "@i_tipo_cta", 0, SQLCHAR, (VLTPCuenta), "TipoCta", ""
        PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
    Else
        PMPasoValoresATX VGSqlConn, "@i_tipo_cta", 0, SQLVARCHAR, (VLTipCta_com), "TipoCta", ""
        PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (VLCta_com), "Cuenta", ""
    End If
    PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, (Loc.Text), "Cheques", ""
    If CantChq.Text = "" Then
        PMPasoValoresATX VGSqlConn, "@i_cant_cheques", 0, SQLINT4, "0", "Cantidad de cheques", ""
        PMPasoValoresATX VGSqlConn, "@i_cant_chq", 0, SQLINT4, "0", "CantChq", ""
    Else
        PMPasoValoresATX VGSqlConn, "@i_cant_cheques", 0, SQLINT4, (CantChq.Text), "Cantidad de cheques", ""
        PMPasoValoresATX VGSqlConn, "@i_cant_chq", 0, SQLINT4, val(CantChq.Text), "CantChq", ""
    End If
    '****** MS-COBIS *******************************************************
    PMPasoValoresATX VGSqlConn, "@e_empresa", 0, SQLINT4, CInt(txtCampo(1).Text), "Empresa", ""
    PMPasoValoresATX VGSqlConn, "@i_emp", 0, SQLINT4, CInt(txtCampo(1).Text), "Empresa", ""
    PMPasoValoresATX VGSqlConn, "@e_convenio", 0, SQLVARCHAR, VLConvenio, "Empresa", ""
    PMPasoValoresATX VGSqlConn, "@e_tipo_servicio", 0, SQLVARCHAR, "AUTOMOTORES_PEATONES", "Tipo Servicio", ""
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrnF, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_trn", 0, SQLINT4, VLTrn, "Itrn", ""
    PMPasoValoresATX VGSqlConn, "@e_tipo_banca", 0, SQLVARCHAR, "BP", "BP", ""
    
    'Variables Para MS-Pago
    If VLTipoID = "PASS" Then
        VLTipoID = "PAS"
    End If
    If VLTipoID = "" Then
        'PMPasoValoresATX VGSqlConn, "@e_tipo_identificador", 0, SQLVARCHAR, VLConvenio, "Tipo Identificador", ""
        PMPasoValoresATX VGSqlConn, "@e_tipo_identificador", 0, SQLVARCHAR, "SOL", "Tipo Identificador", ""
    Else
        PMPasoValoresATX VGSqlConn, "@e_tipo_identificador", 0, SQLVARCHAR, VLTipoID, "Tipo Identificador", ""
    End If
    
    PMPasoValoresATX VGSqlConn, "@e_cod_cliente", 0, SQLVARCHAR, (Me.txtIngreso(0).Text), "Cod. Cliente", ""
    
    If Me.Cta.ClipText <> "" Then
        PMPasoValoresATX VGSqlConn, "@e_tipocta", 0, SQLCHAR, (VLTPCuenta), "TipoCta", ""
        PMPasoValoresATX VGSqlConn, "@e_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
    Else
        PMPasoValoresATX VGSqlConn, "@e_tipocta", 0, SQLVARCHAR, (VLTipCta_com), "TipoCta", ""
        PMPasoValoresATX VGSqlConn, "@e_cuenta", 0, SQLVARCHAR, (VLCta_com), "Cuenta", ""
    End If
    
    PMPasoValoresATX VGSqlConn, "@e_moneda", 0, SQLINT1, str(FMObtenerMonedaForma("134")), "Moneda", ""
    PMPasoValoresATX VGSqlConn, "@e_val", 0, SQLMONEY, Efe.Text, "Efectivo", ""
    PMPasoValoresATX VGSqlConn, "@e_opcion", 0, SQLCHAR, "P", "Opcion", ""
    PMPasoValoresATX VGSqlConn, "@e_canal", 0, SQLVARCHAR, "VEN", "Canal", ""
    PMPasoValoresATX VGSqlConn, "@e_nombre", 0, SQLVARCHAR, txtNombre, "Nom. Cliente", ""
    PMPasoValoresATX VGSqlConn, "@e_total", 0, SQLMONEY, (TotalPagar.Text), "Total pagado", ""
    PMPasoValoresATX VGSqlConn, "@e_tipo_id", 0, SQLCHAR, VLTipoID, "Tipo Id", ""
    PMPasoValoresATX VGSqlConn, "@e_fecha_real", 0, SQLVARCHAR, Format(Date, "mm/dd/yyyy"), "FechaReal", ""
    PMPasoValoresATX VGSqlConn, "@srv", 0, SQLVARCHAR, "", "SRVDESA2", ""
    PMPasoValoresATX VGSqlConn, "@e_concepto", 0, SQLVARCHAR, VLNumCitaciones, "SRVDESA2", ""
    PMPasoValoresATX VGSqlConn, "@s_date", 0, SQLVARCHAR, Format$(VGFechaProceso, "yyyy-mm-dd") + "T" + Format$(Time(), "hh:mm:ss"), "FechaLocal", ""
    PMPasoValoresATX VGSqlConn, "@e_nombre_cta", 0, SQLVARCHAR, NomCta.Text, "Nombre cuenta", ""
    PMPasoValoresATX VGSqlConn, "@e_identificacion", 0, SQLVARCHAR, (Me.txtIngreso(0).Text), "Cod. Cliente", ""
    PMPasoValoresATX VGSqlConn, "@e_comision_tot", 0, SQLMONEY, (Comision.Text), "valor de la comision", ""
    PMPasoValoresATX VGSqlConn, "@s_sectrx", 1, SQLINT4, 0, "SecTrn", ""
    PMPasoValoresATX VGSqlConn, "@e_localidad", 0, SQLVARCHAR, vllocalidad, "Localidad", ""
    PMPasoValoresATX VGSqlConn, "@e_provincia", 0, SQLVARCHAR, vlnomprov, "Provincia", ""
    
    
    If CantChq.Text = "" Then
        PMPasoValoresATX VGSqlConn, "@e_cant_cheques", 0, SQLINT4, "0", "Cantidad de cheques", ""
    Else
        PMPasoValoresATX VGSqlConn, "@e_cant_cheques", 0, SQLINT4, (CantChq.Text), "Cantidad de cheques", ""
    End If
    '****** COMISION PAGO*******************************************************
    PMPasoValoresATX VGSqlConn, "@e_efectivo", 0, SQLMONEY, (Efe.Text), "efe", ""
    PMPasoValoresATX VGSqlConn, "@e_cheque", 0, SQLMONEY, (Loc.Text), "Cheques", ""
    PMPasoValoresATX VGSqlConn, "@e_debito", 0, SQLMONEY, Debito.Text, "Debito", ""
    PMPasoValoresATX VGSqlConn, "@e_comision_efe", 0, SQLMONEY, (VLEfe_com), "Com. efectivo", ""
    PMPasoValoresATX VGSqlConn, "@e_comision_chq", 0, SQLMONEY, (VLChq_com), "Com. Cheques", ""
    PMPasoValoresATX VGSqlConn, "@e_comision_db", 0, SQLMONEY, (VLDeb_com), "Com. debito", ""
    '****** TC *******************************************************
                                             
    If Credito.Text <> "0.00" Then
        PMPasoValoresATX VGSqlConn, "@e_tarjeta", 0, SQLMONEY, Credito.Text, "Valor TC", ""
        PMPasoValoresATX VGSqlConn, "@FPA_TC", 0, SQLVARCHAR, VLVISA_meses, "Meses Diferidos", ""
        PMPasoValoresATX VGSqlConn, "@MPA_TC", 0, SQLVARCHAR, VLVISA_ClaveUnicaTC, "Numero Tarjeta", ""
        Else
        PMPasoValoresATX VGSqlConn, "@e_tarjeta", 0, SQLMONEY, 0, "Valor TC", ""
    End If
    
    
    '****** TC DENTRO DEL MICRO PAGO *******************************************************
    'PMPasoValoresATX VGSqlConn, "@e_mes_pago", 0, SQLINT1, (VLVISA_meses), "N Meses", ""
    'PMPasoValoresATX VGSqlConn, "@e_tarjeta", 0, SQLVARCHAR, (VLVISA_ClaveUnicaTC), "N Tarjeta", ""
    'PMPasoValoresATX VGSqlConn, "@e_codigo_comercio", 0, SQLINT1, 906785, "Codigo Comercio", ""
    'PMPasoValoresATX VGSqlConn, "@e_tipo_operacion", 0, SQLINT1, 9311, "Tipo Operacion", ""
    
    '****** VARIABLE DE SALIDA *******************************************************
    PMPasoValoresATX VGSqlConn, "@referencia", 1, SQLINT4, 0, "0", "sec"
    
    If FMTransmitirRPCATX(VGSqlConn, "RECSRV", "cob_procesador", flujo, True, "Transaccion Ok", "S", "N", "S", "134", "S", "S") = True Then
        
        VTResult% = FMMapeaMatrizATX(VGSqlConn&, vtmatrizcps())
        VLTsnTemporal = VGTSN%
        PMChequeaATX VGSqlConn
        PMTotalesBranch "51"
        VLCambio% = False
        '------> Sumadora
        SGSecTrn$ = FLBuscarItem("@referencia")
        VLSSnCorreccion = FLBuscarItem("@referencia")
        '****** TC
        If Me.Credito.Text > 0 Then
            VLNumTranAutorizaVisa = FLBuscarItem("@referencia")
            VLNumAutorizaVisa = FLBuscarItem("@ptc_codigoAutorizacion")
            VLInteres = 0.9  'FLBuscarItem("@ptc_valorComision")
        End If
        '****** TC
        VLMG_ossn = FLBuscarItem("@referencia")
        VLSsn = FLBuscarItem("@referencia")
        If VGTipoEjecucion% <> CGReverso% Then
            VLFechaCorte = Format$(VGFechaProceso, "yyyy-mm-dd")
            VLFechaContable = VLFechaCorte
        End If
        
        '****** OBTENER FECHA PROCESO Y IP *******************************************************
        VLFechaProceso = Mid(VGFechaProceso, 4, 2) & "-" & Mid(VGFechaProceso, 1, 2) & "-" & Mid(VGFechaProceso, 7, 4) & " " & VLHoraProceso
        VLTSN = VGTSN
        
        PMChequeaATX VGSqlConn
        PMTotalesBranch "51"
        FLTransmitir_ANT_pago = True
        VLCambio% = False
        VLCambioCedruc% = False
        '------> Sumadora
            SGSecTrn$ = FLBuscarItem("@referencia")
            VTIndicadorSum = 1
            PMIniciaRegSum
        '<-----
    Else
        VLCambio% = True
        VLCambioCedruc% = True
        FLTransmitir_ANT_pago = False
        'TPE ------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 2)
        VTIndicadorSum = 0
        PMChequeaATX VGSqlConn
        '<------
    End If
    
    PMChequeaATX VGSqlConn
    If FMRetStatusATX(VGSqlConn) <> 0 Then
        VTIndicadorSum = 0
        FLTransmitir_ANT_pago = False
    End If
    
    PMFinTransaccion
    
    If FLTransmitir_ANT_pago = True Then
      'JPM Lectora de Billetes -->
      If CCur(Efe.Text) > 0 And ((VGDatPersBillAltDen.dataOK And VGTipoEjecucion = CGNormal%) Or VGTipoEjecucion = CGReverso%) Then
        Call PMGuardarDsglsBillete("134", SGSecTrn$, VLTrn, rptBAD, "REC", "")
      End If
      '<-- JPM Lectora de Billetes
      Call PLFactura
    End If
    'Sumadora -->
    If VGTipoEjecucion% <> CGReverso% Then   'Validacion por REVERSO
        If (VTIndicadorSum = 1 _
        And (Trim$(VGStatusCon) = "A" _
        Or Trim$(VGStatusCon) = "")) Then
            SGPrimeraVez = 0     ' ya no es primera vez
            PMGrabaDesglose VLTrn, CStr(SGUsar), VLCambio%
            If VLCambio% = True Then
                MsgBox "Error en la Grabacion del Desglose. Favor comuniquese con su Supervisor.", vbCritical, "Error de Sistema"
                FLTransmitir_ANT_pago = False
            End If
            SGActual = 1  'seteo Variable para borrar desglose
        ElseIf VTIndicadorSum = 0 Then
            SGActual = 0  'no borrar desglose en caso de Error en Transaccion
        End If
    ElseIf VTIndicadorSum = 1 Then                'Por REVERSO
        PMEgresoEfectivo SGUsar, VLTrn, VGSSNCorr&
    End If
    
    
    Exit Function
    
Error:
    MsgBox "Error al transmitir la transaccion " & Chr(13) & "Error:" & Err.Description, vbCritical
    PMChequeaATX VGSqlConn
    PMFinTransaccion
    FLTransmitir_ANT_pago = False
End Function


Private Sub PLImprimeComprobanteEPMTG()
Dim infor As String

   VGparformato$ = "01"
   If Not FMFormatPagina(VGparformato$, VGparlong$, VGpartop$, VGparleft$, VGparrig$) Then
      VGparlong$ = "66"
      VGpartop$ = "04"
      VGparleft$ = "20"
      VGparrig$ = "00"
   End If

   PMSetDetalle "v" + "Este pago sera procesado el " + VLFechaCorte 'hy-31-ene-2005 Formatear fecha
   PMSetDetalle "v" + "Empresa: " + FMEspaciosATX(Trim(txtCampo(1).Text) + " " + Mid(Trim(lblDescripcion(1).Caption), 1, 24), 28, CGJustificacionIzquierda) + " RUC: " + Trim(VlRucEmp)
   PMSetDetalle "v" + "Servicio: " + Trim(lblDescripcion(0).Caption) + " Autorizacion:" + Trim(VLCodAutorizacion)
   If Trim(txtCampo(0).Text) = "1" Then
    PMSetDetalle "v" + "No.Solicitud:" + Trim(txtIngreso(0).Text)
    PMSetDetalle "v" + "Nombre de Tramite:" + Trim(Mid(VLNombre_tramite, 1, 24))
   Else
    PMSetDetalle "v" + "No. de citaciones: " + Trim(VLNumCitaciones)
   End If
   infor = ""
   If Trim(txtCampo(0).Text) = "2" And Trim(VLTipoID) <> "" Then
    'PMSetDetalle "v" + "Cedula/RUC/PAS: " + Trim(txtIngreso(0).Text)
    infor = "Cedula/RUC/PAS: " + Trim(txtIngreso(0).Text)
   End If
   If Trim(txtCampo(0).Text) = "3" Then
    'PMSetDetalle "v" + "Cedula/RUC/PAS: " + Trim(VLIdentf_Placa)
    infor = "Cedula/RUC/PAS: " + Trim(VLIdentf_Placa)
   End If
   If (Trim(txtCampo(0).Text) = "2" Or Trim(txtCampo(0).Text) = "3") And Trim(VLTipoID) = "" Then
    'PMSetDetalle "v" + "Placa: " + Trim(txtIngreso(0).Text)
    infor = infor + "   Placa: " + Trim(txtIngreso(0).Text)
   End If
   PMSetDetalle "v" + infor
   PMSetDetalle "v" + "Nombre: " + Trim(Mid(Me.txtNombre, 1, 25)) + " Valor: " + FMEspaciosATX(FMObtenerSimbolo("51") + Format(Me.TotalPagar.Text, VGFormatoMoney), 12, CGJustificacionDerecha)  '/*JPM 08122004*/

   ef$ = ""
   If FMCCurATX((Efe.Text)) > 0 Then
      ef$ = "EFE.: " + FMEspaciosATX(Format(Efe, VGFormatoMoney), 12, CGJustificacionDerecha) + "   "
   End If
   Chq$ = ""
   If FMCCurATX((Loc.Text)) > 0 Then
      Chq$ = "CHQ.: " + FMEspaciosATX("(" + Trim(CantChq) + ")", 4, CGJustificacionIzquierda) + FMEspaciosATX(Format(Loc, VGFormatoMoney), 12, CGJustificacionDerecha)
   End If
   If ef$ <> "" Or Chq$ <> "" Then
      PMSetDetalle "v" + ef$ + Chq$
   End If
   If FMCCurATX((Debito.Text)) > 0 Then
      PMSetDetalle "v" + "DEB.: " + FMEspaciosATX(Format(Debito, VGFormatoMoney), 12, CGJustificacionDerecha) + "   CTA.: " + Format(Cta.ClipText, "000-000000-0")
   End If
'   If FMCCurATX((Reten.Text)) > 0 Then
'      PMSetDetalle "v" + "RETENCION:" + FMEspaciosATX(Trim(Comprob), 13, CGJustificacionIzquierda) + FMEspaciosATX(Format(Reten, VGFormatoMoney), 12, CGJustificacionDerecha)
'   End If
   If FMCCurATX((Comision.Text)) > 0 Then
      Coms = " COMISION: " + FMEspaciosATX(Format(Comision, VGFormatoMoney), 6, CGJustificacionIzquierda) + " "
   End If
'   VLNeto = FMCCurATX(Pago_Val.Text) '- FMCCurATX(Comision.Text)  '/*cambio JPM 08122004*/
   PMSetDetalle "v" + "Valor TOTAL:" + FMEspaciosATX(FMObtenerSimbolo("51") + Format(TotalPagar.Text, VGFormatoMoney), 12, CGJustificacionIzquierda) + Coms   '/*JPM 08122004*/
   
   'VLSaldo = FMCCurATX(Me.ValMaximo.Text)
   'PMSetDetalle "v" + "SALDO DE LA TARJETA: " + FMEspaciosATX(FMObtenerSimbolo("51") + Format(FMCCurATX(VLDpPValorPendienteCobro), VGFormatoMoney), 12, CGJustificacionDerecha)     'tc 07272009
'***ref02 vmirandt inicio, se imprime al final del documento
    If VLclave_acceso <> "" Then
        PMSetDetalle "v" + "Clave de Acceso/Autorizacion: "
        PMSetDetalle "v" + VLclave_acceso
    End If
    VGpartop$ = "00"
    VGparleft$ = "10"
    'ref02 vmirandt
   
   If VLTsnTemp% = 0 Then
      VLTsnTemp% = VGTSN%
   End If
   VLEtiqTrn = "RECAUDACIONES AUTOMOTRICES"
   FMPRN_StdImpresion "IMPRESORA_1", False, CStr(VLTsnTemp%), "134", SGDatosDetalle, "Inserte papeleta", CStr(VGpartop$), 4, CStr(VGparleft$), , VLEtiqTrn, IIf(VLHorario = "0", "", VLHorario), VLTrn, , Trim$(str$(FMObtenerMonedaForma("51")))        'hy-categ agregar la moneda

End Sub

Public Sub PLImprimirNotaEPMTG()

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
        'PMSetDetalle "v" + "Costo Serv. Recaudacion  " + "Fecha: " + Format(VGFechaProceso, VGFormatoFecha$) + " " + IIf(VGHorarioDif, "H:D", "H:N")
        PMSetDetalle "v" + "Costo Serv. Recaudacion  " + "Fecha: " + VGFechaProceso2 + " " + IIf(VGHorarioDif, "H:D", "H:N")
        PMSetDetalle "v" + "PORTA:                   " + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 8, CGJustificacionDerecha)
        PMSetDetalle "v" + "Subtotal:      " + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 8, CGJustificacionDerecha) + "    " + "Iva 12%: " + FMEspaciosATX(Format(0, VGFormatoMoney), 8, CGJustificacionDerecha)
        PMSetDetalle "v" + "VALOR TOTAL:   " + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 8, CGJustificacionDerecha) + "    " + "Referencia: " + (Trim(Ref))
     If VLTipo_imp = "O" Then
        PMSetDetalle "v" + "Caj: " + VGLogin$ + "              " + "Original: Adquiriente"
     Else
        PMSetDetalle "v" + "Caj: " + VGLogin$ + "              " + "Copia: Emisor"
     End If
        
       ' PMSetDetalle "v" + " "
        
        If VGModeloImp$ = "590" Then
            PMSetDetalle "%R" & 2
        End If
    
       
 FMPRN_StdImpresion "IMPRESORA_1", False, "", "51", SGDatosDetalle, "Inserte COMPROBANTE Cobro Comision", CStr(VGpartop$), 1, CStr(VGparleft$), , , , , False, , VLTrn
'  'PAOLA PRUEBA
'
End If
    
End Sub


'pricaura Inicio Bus Fase 2
Private Sub Consulta_parametro_OSB()
    If VGTipoEjecucion% = CGReverso% Then
   VGTipoEjecucion% = CGNormal%
    PMChequeaATX VGSqlConn&
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "sv_servidor_servicios_soa", "", ""
    PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR, "V", "", ""
    PMPasoValoresATX VGSqlConn&, "@i_codigo", 0, SQLVARCHAR, (Me.txtCampo(1).Text), "", ""
    If FMTransmitirRPCATX(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "", "N", "S", "I", "0", "N", "N") Then
        PMMapeaObjetoATX VGSqlConn&, txtTemp 'txtTemporal
        vl_servidor_BUS = txtTemp
    End If
    PMChequeaATX VGSqlConn&
    PMFinTransaccion
    VGTipoEjecucion% = CGReverso%
Else
    PMChequeaATX VGSqlConn&
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "sv_servidor_servicios_soa", "", ""
    PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR, "V", "", ""
    PMPasoValoresATX VGSqlConn&, "@i_codigo", 0, SQLVARCHAR, (Me.txtCampo(1).Text), "", ""
    If FMTransmitirRPCATX(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "", "N", "S", "I", "0", "N", "N") Then
        PMMapeaObjetoATX VGSqlConn&, txtTemp
        vl_servidor_BUS = txtTemp
    End If
    PMChequeaATX VGSqlConn&
    PMFinTransaccion
End If


End Sub
'pricaura Fin
