VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "GRID32.OCX"
Object = "{0F1F1508-C40A-101B-AD04-00AA00575482}#1.0#0"; "mhrinp32.ocx"
Object = "{9AED8C43-3F39-11D1-8BB4-0000C039C248}#2.0#0"; "txtin.ocx"
Object = "{DECFDD03-1E4B-11D1-B65E-0000C039C248}#5.0#0"; "mskedit.ocx"
Object = "{00025600-0000-0000-C000-000000000046}#5.2#0"; "crystl32.ocx"
Begin VB.Form FCC35 
   BackColor       =   &H00C0C0C0&
   Caption         =   "TRANSFERENCIA DE DOMINIO - 35"
   ClientHeight    =   6225
   ClientLeft      =   720
   ClientTop       =   870
   ClientWidth     =   5055
   KeyPreview      =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   6225
   ScaleWidth      =   5055
   Begin VB.TextBox txtNotaVenta 
      Height          =   375
      Left            =   2280
      TabIndex        =   36
      Top             =   5760
      Visible         =   0   'False
      Width           =   735
   End
   Begin MskeditLib.MaskInBox mskfechacont 
      Height          =   300
      Left            =   3480
      TabIndex        =   11
      Top             =   5700
      Width           =   1095
      _Version        =   262144
      _ExtentX        =   1931
      _ExtentY        =   529
      _StockProps     =   253
      Text            =   "__/__/____"
      Enabled         =   0   'False
      Appearance      =   1
      Decimals        =   2
      Separator       =   -1  'True
      MaskType        =   2
      HideSelection   =   0   'False
      MaxLength       =   0
      AutoTab         =   0   'False
      DateString      =   "__/__/____"
      FormattedText   =   ""
      Mask            =   "##/##/####"
      HelpLine        =   ""
      ClipText        =   ""
      ClipMode        =   0
      StringIndex     =   0
      DateType        =   0
      DateSybase      =   ""
      AutoDecimal     =   0   'False
      MinReal         =   -1.1e38
      MaxReal         =   3.4e38
      Units           =   0
      Errores         =   0
   End
   Begin VB.TextBox cedula 
      Appearance      =   0  'Flat
      Height          =   280
      Left            =   2400
      MaxLength       =   13
      TabIndex        =   1
      ToolTipText     =   "Código de Identificación del Beneficiario"
      Top             =   5415
      Width           =   2175
   End
   Begin TxtinLib.TextValid moneda 
      Height          =   285
      Left            =   5880
      TabIndex        =   24
      Top             =   5400
      Width           =   795
      _Version        =   65536
      _ExtentX        =   1402
      _ExtentY        =   503
      _StockProps     =   253
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderStyle     =   1
      Enabled         =   0   'False
      Range           =   ""
      MaxLength       =   10
      Character       =   0
      Type            =   4
      HelpLine        =   "Ingrese codigo de la Matricula "
      Pendiente       =   ""
      Connection      =   0
      AsociatedLabelIndex=   0
      TableName       =   ""
      MinChar         =   0
      Error           =   0
   End
   Begin VB.PictureBox bitmap 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   0  'None
      Enabled         =   0   'False
      ForeColor       =   &H80000008&
      Height          =   615
      Left            =   120
      ScaleHeight     =   615
      ScaleWidth      =   855
      TabIndex        =   22
      Top             =   360
      Visible         =   0   'False
      Width           =   855
   End
   Begin VB.Frame Frame 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Frame1"
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
      Height          =   3915
      Left            =   120
      TabIndex        =   15
      Top             =   480
      Width           =   4455
      Begin VB.TextBox TxtNomCta 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   1500
         TabIndex        =   35
         Top             =   1640
         Width           =   2895
      End
      Begin VB.ComboBox CboTipCta 
         Height          =   315
         Left            =   2100
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Tag             =   "CboProd"
         Top             =   1330
         Width           =   855
      End
      Begin MhinrelLib.MhRealInput Total 
         Height          =   285
         Left            =   2100
         TabIndex        =   9
         Top             =   3180
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
         TintColor       =   16711935
         FillColor       =   16777215
         SpinChangeReal  =   0
         CaretColor      =   -2147483642
         DecimalPlaces   =   2
         Separator       =   -1  'True
      End
      Begin MhinrelLib.MhRealInput Cheque 
         Height          =   285
         Left            =   2100
         TabIndex        =   4
         Top             =   1050
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
         Text            =   "0"
         SpinChangeReal  =   0
         CaretColor      =   -2147483642
         DecimalPlaces   =   2
         Separator       =   -1  'True
      End
      Begin MhinrelLib.MhRealInput Efectivo 
         Height          =   285
         Left            =   2100
         TabIndex        =   2
         Top             =   480
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
         Text            =   "0"
         SpinChangeReal  =   0
         CaretColor      =   -2147483642
         DecimalPlaces   =   2
         Separator       =   -1  'True
      End
      Begin MskeditLib.MaskInBox Cta 
         Height          =   285
         Left            =   2940
         TabIndex        =   6
         Tag             =   "Cta"
         Top             =   1330
         Width           =   1455
         _Version        =   262144
         _ExtentX        =   2566
         _ExtentY        =   503
         _StockProps     =   253
         Text            =   "___-______-_"
         BorderStyle     =   1
         Enabled         =   -1  'True
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
         Left            =   2100
         TabIndex        =   7
         Top             =   2310
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
         AutoHScroll     =   -1  'True
         CaretColor      =   -2147483642
         DecimalPlaces   =   2
         Separator       =   -1  'True
      End
      Begin MhinrelLib.MhRealInput Tarjeta 
         Height          =   285
         Left            =   2100
         TabIndex        =   8
         ToolTipText     =   "Ingrese Valor en Tarjeta de Crédito"
         Top             =   2595
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
         AutoHScroll     =   -1  'True
         CaretColor      =   -2147483642
         DecimalPlaces   =   2
         Separator       =   -1  'True
      End
      Begin TxtinLib.TextValid CantChq 
         Height          =   285
         Left            =   3420
         TabIndex        =   3
         ToolTipText     =   "Cantidad de Cheques"
         Top             =   760
         Width           =   975
         _Version        =   65536
         _ExtentX        =   1720
         _ExtentY        =   503
         _StockProps     =   253
         BorderStyle     =   1
         Range           =   ""
         MaxLength       =   13
         Character       =   0
         Type            =   2
         HelpLine        =   "Ingrese Cantidad de Cheques"
         Pendiente       =   ""
         Connection      =   0
         AsociatedLabelIndex=   0
         TableName       =   ""
         MinChar         =   0
         Error           =   0
      End
      Begin MhinrelLib.MhRealInput Comision 
         Height          =   315
         Left            =   2100
         TabIndex        =   30
         ToolTipText     =   "Valor de Comision [F5 Presenta Forma de Pago]"
         Top             =   2880
         Width           =   2295
         _Version        =   65536
         _ExtentX        =   4048
         _ExtentY        =   547
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
         ReadOnly        =   -1  'True
         SpinChangeReal  =   0
         AutoHScroll     =   -1  'True
         CaretColor      =   -2147483642
         DecimalPlaces   =   2
         Separator       =   -1  'True
         VAlignment      =   2
      End
      Begin MhinrelLib.MhRealInput TotPago 
         Height          =   285
         Left            =   2100
         TabIndex        =   32
         Top             =   3465
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
         Enabled         =   0   'False
         TintColor       =   16711935
         FillColor       =   16777215
         SpinChangeReal  =   0
         CaretColor      =   -2147483642
         DecimalPlaces   =   2
         Separator       =   -1  'True
      End
      Begin Crystal.CrystalReport rptBAD 
         Left            =   1620
         Top             =   2790
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
         Left            =   1170
         TabIndex        =   47
         Top             =   3240
         Visible         =   0   'False
         Width           =   900
      End
      Begin VB.Label lblMoneda 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   285
         Left            =   2100
         TabIndex        =   46
         Top             =   2040
         Width           =   2295
      End
      Begin VB.Label Label4 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Moneda:"
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
         Left            =   120
         TabIndex        =   45
         Top             =   2040
         Width           =   750
      End
      Begin VB.Label LblNomCta 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Nomb. Cta. :"
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
         Left            =   120
         TabIndex        =   34
         Top             =   1640
         Width           =   1080
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Total a pagar:"
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
         Left            =   120
         TabIndex        =   33
         Top             =   3465
         Width           =   1215
      End
      Begin VB.Label Label6 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Comision:"
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
         Left            =   120
         TabIndex        =   31
         Top             =   2880
         Width           =   1455
      End
      Begin VB.Label Label1 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Cant. de Chq:"
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
         Left            =   2080
         TabIndex        =   29
         Top             =   760
         Width           =   1185
      End
      Begin VB.Label LblEfect 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Efectivo :"
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
         Left            =   120
         TabIndex        =   21
         Top             =   480
         Width           =   840
      End
      Begin VB.Label LblChq 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Cheque :"
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
         Left            =   120
         TabIndex        =   20
         Top             =   1050
         Width           =   780
      End
      Begin VB.Label LblTotal 
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
         Left            =   120
         TabIndex        =   19
         Top             =   3180
         Width           =   570
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
         Left            =   120
         TabIndex        =   18
         Top             =   2310
         Width           =   690
      End
      Begin VB.Label LblTipCta 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "ND a Cta:"
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
         Left            =   120
         TabIndex        =   17
         Top             =   1330
         Width           =   855
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Tarjeta de Credito:"
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
         Left            =   120
         TabIndex        =   16
         Top             =   2595
         Width           =   1605
      End
   End
   Begin VB.TextBox TxtNomProp 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   1680
      MaxLength       =   60
      TabIndex        =   12
      Top             =   4560
      Width           =   2895
   End
   Begin TxtinLib.TextValid Matricula 
      Height          =   285
      Left            =   2520
      TabIndex        =   0
      Top             =   120
      Width           =   2055
      _Version        =   65536
      _ExtentX        =   3625
      _ExtentY        =   503
      _StockProps     =   253
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderStyle     =   1
      Range           =   ""
      MaxLength       =   13
      Character       =   0
      Type            =   4
      HelpLine        =   "Ingrese codigo de la Matricula "
      Pendiente       =   ""
      Connection      =   0
      AsociatedLabelIndex=   0
      TableName       =   ""
      MinChar         =   0
      Error           =   0
   End
   Begin MhinrelLib.MhRealInput Contrato 
      Height          =   285
      Left            =   2400
      TabIndex        =   10
      Top             =   5130
      Width           =   2175
      _Version        =   65536
      _ExtentX        =   3836
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
      Text            =   "0"
      SpinChangeReal  =   0
      CaretColor      =   -2147483642
      DecimalPlaces   =   2
      Separator       =   -1  'True
   End
   Begin MhinrelLib.MhRealInput Avaluo 
      Height          =   285
      Left            =   2400
      TabIndex        =   13
      ToolTipText     =   "Valor Total de la Transacción"
      Top             =   4845
      Width           =   2175
      _Version        =   65536
      _ExtentX        =   3836
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
   Begin TxtinLib.TextValid txtChasis 
      Height          =   285
      Left            =   0
      TabIndex        =   37
      Top             =   3240
      Visible         =   0   'False
      Width           =   1635
      _Version        =   65536
      _ExtentX        =   2884
      _ExtentY        =   503
      _StockProps     =   253
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderStyle     =   1
      Range           =   ""
      MaxLength       =   0
      Character       =   0
      Type            =   4
      HelpLine        =   "Ingrese codigo de la Matricula "
      Pendiente       =   ""
      Connection      =   0
      AsociatedLabelIndex=   0
      TableName       =   ""
      MinChar         =   0
      Error           =   0
   End
   Begin TxtinLib.TextValid txtMotor 
      Height          =   285
      Left            =   0
      TabIndex        =   38
      Top             =   2880
      Visible         =   0   'False
      Width           =   1635
      _Version        =   65536
      _ExtentX        =   2884
      _ExtentY        =   503
      _StockProps     =   253
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderStyle     =   1
      Range           =   ""
      MaxLength       =   0
      Character       =   0
      Type            =   4
      HelpLine        =   "Ingrese codigo de la Matricula "
      Pendiente       =   ""
      Connection      =   0
      AsociatedLabelIndex=   0
      TableName       =   ""
      MinChar         =   0
      Error           =   0
   End
   Begin TxtinLib.TextValid txtLogRevSri 
      Height          =   285
      Left            =   0
      TabIndex        =   39
      Top             =   2520
      Visible         =   0   'False
      Width           =   1635
      _Version        =   65536
      _ExtentX        =   2884
      _ExtentY        =   503
      _StockProps     =   253
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderStyle     =   1
      Range           =   ""
      MaxLength       =   0
      Character       =   0
      Type            =   4
      HelpLine        =   "Ingrese codigo de la Matricula "
      Pendiente       =   ""
      Connection      =   0
      AsociatedLabelIndex=   0
      TableName       =   ""
      MinChar         =   0
      Error           =   0
   End
   Begin TxtinLib.TextValid txtTranRevSri 
      Height          =   285
      Left            =   0
      TabIndex        =   40
      Top             =   2160
      Visible         =   0   'False
      Width           =   1635
      _Version        =   65536
      _ExtentX        =   2884
      _ExtentY        =   503
      _StockProps     =   253
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderStyle     =   1
      Range           =   ""
      MaxLength       =   0
      Character       =   0
      Type            =   4
      HelpLine        =   "Ingrese codigo de la Matricula "
      Pendiente       =   ""
      Connection      =   0
      AsociatedLabelIndex=   0
      TableName       =   ""
      MinChar         =   0
      Error           =   0
   End
   Begin TxtinLib.TextValid txtCodVehiculo 
      Height          =   285
      Left            =   0
      TabIndex        =   41
      Top             =   1800
      Visible         =   0   'False
      Width           =   1635
      _Version        =   65536
      _ExtentX        =   2884
      _ExtentY        =   503
      _StockProps     =   253
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderStyle     =   1
      Range           =   ""
      MaxLength       =   0
      Character       =   0
      Type            =   4
      HelpLine        =   "Ingrese codigo de la Matricula "
      Pendiente       =   ""
      Connection      =   0
      AsociatedLabelIndex=   0
      TableName       =   ""
      MinChar         =   0
      Error           =   0
   End
   Begin TxtinLib.TextValid txtMCN 
      Height          =   285
      Left            =   0
      TabIndex        =   42
      Top             =   1440
      Visible         =   0   'False
      Width           =   1635
      _Version        =   65536
      _ExtentX        =   2884
      _ExtentY        =   503
      _StockProps     =   253
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderStyle     =   1
      Range           =   ""
      MaxLength       =   0
      Character       =   0
      Type            =   4
      HelpLine        =   "Ingrese codigo de la Matricula "
      Pendiente       =   ""
      Connection      =   0
      AsociatedLabelIndex=   0
      TableName       =   ""
      MinChar         =   0
      Error           =   0
   End
   Begin TxtinLib.TextValid txtmensaje 
      Height          =   285
      Left            =   4080
      TabIndex        =   43
      Top             =   0
      Visible         =   0   'False
      Width           =   1635
      _Version        =   65536
      _ExtentX        =   2884
      _ExtentY        =   503
      _StockProps     =   253
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BorderStyle     =   1
      Range           =   ""
      MaxLength       =   10
      Character       =   0
      Type            =   4
      HelpLine        =   "Ingrese codigo de la Matricula "
      Pendiente       =   ""
      Connection      =   0
      AsociatedLabelIndex=   0
      TableName       =   ""
      MinChar         =   0
      Error           =   0
   End
   Begin MSGrid.Grid grdGrid 
      Height          =   1095
      Left            =   120
      TabIndex        =   44
      Top             =   5880
      Width           =   4215
      _Version        =   65536
      _ExtentX        =   7435
      _ExtentY        =   1931
      _StockProps     =   77
      BackColor       =   16777215
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Fecha contrato:"
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
      Left            =   240
      TabIndex        =   28
      Top             =   5700
      Width           =   1365
   End
   Begin VB.Label lblValor 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Valor del Avalúo:"
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
      Left            =   240
      TabIndex        =   27
      Top             =   4845
      Width           =   1470
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Valor del Contrato:"
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
      Left            =   240
      TabIndex        =   26
      Top             =   5130
      Width           =   1605
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Ced/Ruc Comprador:"
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
      Left            =   240
      TabIndex        =   25
      Top             =   5415
      Width           =   1800
   End
   Begin VB.Label LblPlaca 
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Placa:"
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
      Left            =   240
      TabIndex        =   23
      Top             =   120
      Width           =   555
   End
   Begin VB.Label LblNomProp 
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Nomb. Prop.:"
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
      Left            =   240
      TabIndex        =   14
      Top             =   4560
      Width           =   1125
   End
End
Attribute VB_Name = "FCC35"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'********************************************************************************'
'*              MODIFICACIONES                                                  *'
'* REF  FECHA       AUTOR          DESCRIPCION                                  *'
'*  02  02/Oct/2017 Vanessa Miranda FACOFF-AP-SGC00029747-SGC00029748 Agregar   *'
'*      Clave de Acceso Facturación Electrónica Offline                         *'
'*  03  09/Mar/2018 Danny Olaya     SGC00030409                                 *'
'*      Cobro de Comisión Déb. Cuenta Facturación Offline                       *'
'********************************************************************************'

Dim VLCambio As Integer
Dim VLCambioMatri As Integer
Dim Comprobante As Long
Dim motor As String
Dim chasis As String
'Dim periodo As String
'Dim fisco As Currency
Dim administracion As Currency
Dim VLProd As Integer
Dim VLTrn As String
Dim VLfirma As Boolean

'-- variables para la comision --
Dim VLAcum35 As Currency
Dim VLTotCom35 As Currency
Dim VLEfe_com35  As Currency
Dim VLChq_com35 As Currency
Dim VLDeb_com35 As Currency
Dim VLCta_com35  As String
Dim VLTipCta_com35 As String

Dim VLautoriSri As String
Dim VLFecvenSRI As String
Dim VLSerie_Secuencia As String 'hy-24-feb-2005

Dim objUpdate As Object
Dim VLSsn As String
Dim VLSsnRevTimeOut As String
Dim VLFecHora As String
Dim VLFecContable As String
Dim VLProvincia As String
Dim VLTerminal As String
Dim VLRevTimeOut As Boolean
Dim VLCodigoVehiculo As String
Dim VLTranRevSri As String
Dim VLLogReversoSri As String
'-->hy-13-dic-2005
Dim VLValidaEfeCom As Currency
Dim VLtxtMCN As String
Dim VLtxtCodVehiculo As String
Dim VLtxtTranRevSri As String
Dim VLtxtLogRevSri As String
'<--hy-13-dic-2005
Dim VLMCNRevForzado As String  'hy-27-dic-2005
Dim VLUsarRevForzado As Boolean  'hy-27-dic-2005
Dim psRetorno() As String
Dim VLSecTrnCorr As String
Dim VLMoneda As Integer
Dim VLDescMonCta As String

Dim VLNombre As String  'TC 19/02/2010
Dim VLTipo_imp As String        'ame 08/04/2010
Dim VLfact_elect As String      'ame 08/04/2010
Dim VLFecinivig As String       'sme 06/08/2011
Dim VLFecfinvig As String       'sme 06/08/2011
Dim VGFechaProceso2 As String  'sme 06/08/2011
Dim VLiva As Currency 'smerino iva
Dim VlbaseImp As Currency 'smerino iva
Dim VLclave_acceso As String 'ref02 vmirandt
Dim PNIO_CODIGO_VEHICULO As String
Dim LOG_AUTORIZACION As String
Dim CODIGO_TRN_IFI As String



Public Function DatoSwitch(tParametro) As String
    DatoSwitch = ""
    For I% = 1 To FReverso!grdValores(1).Rows - 1
        FReverso!grdValores(1).Row = I%
        FReverso!grdValores(1).Col = 6
        If FReverso!grdValores(1).Text = tParametro Then
            FReverso!grdValores(1).Row = I%
            FReverso!grdValores(1).Col = 2
            DatoSwitch = FReverso!grdValores(1).Text
            Exit For
        End If
    Next I%
End Function


Function FLConsMatricula() As Integer
    PMInicioTransaccion
    Total.Text = "0"
    TotPago.Text = "0"
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, "3295", "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "C", "", ""
    PMPasoValoresATX VGSqlConn, "@i_matricula", 0, SQLVARCHAR, (Matricula.Text), "Matricula", ""
    PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(FMObtenerMonedaForma("35")), "Moneda", ""
    PMPasoValoresATX VGSqlConn, "@o_nomprop", 1, SQLVARCHAR, (TxtNomProp.Text), "TxtNomProp", ""
    PMPasoValoresATX VGSqlConn, "@o_nomcta", 1, SQLVARCHAR, (TxtNomCta.Text), "TxtNomCta", ""
    PMPasoValoresATX VGSqlConn, "@o_total", 1, SQLMONEY, (Total.Text), "Total", ""
    PMPasoValoresATX VGSqlConn, "@o_compro", 1, SQLINT4, "0", "Comprobante", ""
    PMPasoValoresATX VGSqlConn, "@o_motor", 1, SQLVARCHAR, "0", "Motor", ""
    PMPasoValoresATX VGSqlConn, "@o_chasis", 1, SQLVARCHAR, "0", "Chasis", ""
    'PMPasoValoresATX VGSqlConn, "@o_periodo", 1, SQLVARCHAR, "0", "Periodo", ""
    'PMPasoValoresATX VGSqlConn, "@o_fisco", 1, SQLMONEY, "0", "Fisco", ""
    PMPasoValoresATX VGSqlConn, "@o_avaluo", 1, SQLMONEY, "0", "Avaluo", ""
    PMPasoValoresATX VGSqlConn, "@o_valor", 1, SQLMONEY, (Contrato.Text), "Val", ""
    PMPasoValoresATX VGSqlConn, "@o_cedruc", 1, SQLCHAR, Trim(cedula.Text), "Cedula", ""
    PMPasoValoresATX VGSqlConn, "@o_fecha_contrato", 1, SQLDATETIME, Format$("01/01/1900", VGFormatoFecha$), "mskfechacont", ""       'GYC 2002/ABR/08
    PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, "0", "SecTrn", ""
    
    If FMTransmitirRPCATX(VGSqlConn, "", "cob_servicios", "sp_imp_x_transfer_dominio_rc", True, "Transaccion Ok", "S", "N", "N", "35", "S", "S") = True Then
        TxtNomProp.Text = Mid$(FMRetParamATX(VGSqlConn, 1), 1, 50)
        Total.Text = FMRetParamATX(VGSqlConn, 3)
        Avaluo.Text = FMRetParamATX(VGSqlConn, 7)
        Contrato.Text = FMRetParamATX(VGSqlConn, 8)
        cedula.Text = FMRetParamATX(VGSqlConn, 9)
        mskfechacont.Text = Format$(FMRetParamATX(VGSqlConn, 10), VGFormatoFecha$)
        PMChequeaATX VGSqlConn
        FLConsMatricula = True
        VLCambioMatri% = False
        Matricula.Enabled = False
    Else
        TxtNomProp.Text = ""
        Total.Text = "0.00"
        TotPago.Text = "0.00"
        VLCambioMatri% = True
        FLConsMatricula = False
    End If
    PMChequeaATX VGSqlConn
    If FMRetStatusATX(VGSqlConn) <> 0 Then
        Matricula.Enabled = True
        Matricula.SetFocus
        FLConsMatricula = False
    End If
    PMFinTransaccion
End Function

Function FLConsTransDom() As Integer
    PMInicioTransaccion
    Total.Text = "0"
    TotPago.Text = "0"
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, "18008", "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_pcodcanalpagifi", 0, SQLVARCHAR, "VENTANILLA", "Ppsi_cod_canal_pago_ifi", ""
    PMPasoValoresATX VGSqlConn, "@i_pfeccontifi", 0, SQLVARCHAR, Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2), "Ppsio_fecha_contable_ifi", ""
    PMPasoValoresATX VGSqlConn, "@i_pplacacamvcpn", 0, SQLVARCHAR, Trim$(Matricula.Text), "Ppsi_placa_camv_cpn", ""
    PMPasoValoresATX VGSqlConn, "@i_pprovifi", 0, SQLVARCHAR, Trim$(VLProvincia), "Ppsi_provincia_ifi", ""
    PMPasoValoresATX VGSqlConn, "@i_ptipodeuda", 0, SQLVARCHAR, "TRANSF_DOM", "Ppsi_tipo_deuda", ""
       If FMTransmitirRPCATX(VGSqlConn, "PSSRV1", "cob_procesador", "sp_cons_trans_dominio", True, "Transaccion Ok", "S", "N", "N", "35", "S", "S") = True Then
        ReDim psRetorno(1, 22)
        FMMapeaMatriz VGSqlConn, psRetorno
        PMMapeaGrid VGSqlConn, grdGrid, False
        
'Orden de retorno de los resultsets CPS 06/07/2006
'Pdo_fecha_cad_matricula (1)
'Pnio_cod_vehiculo (2)
'Pnio_valor_total_pago   (3)
'Pno_codigo_canton_vehiculo   (4)
'Pno_cod_operativo_cod_msj    (5)
'Pno_log_sri   (6)
'Pno_valor_avaluo_vehiculo    (7)
'Pno_valor_contratos   (8)
'Pso_anio_vehiculo    (9)
'Pso_camv_cpn_vehiculo   (10)
'Pso_chasis_vehiculo    (11)
'Pso_clase_vehiculo (12)
'Pso_cod_ent_pol_vehiculo    (13)
'Pso_est_matricula_vehiculo (14)
'Pso_marca_vehiculo (15)
'Pso_modelo_vehiculo   (16)
'Pso_motor_vehiculo (17)
'Pso_nombre_propietario  (18)
'Pso_num_iden_propietario   (19)
'Pso_pais_vehiculo  (20)
'Pso_placa_vehiculo (21)
'Pso_servicio_vehiculo  (22)

'Resultsets Propios de la mensajería
        
        'OJO REVISAR BIEN
        TxtNomProp.Text = psRetorno(1, 18) 'Mid$(FMRetParamATX(VGSqlConn, 1), 1, 50)
        Total.Text = CDbl(psRetorno(1, 3)) / 100 'FMRetParamATX(VGSqlConn, 3)
        VLCodigoVehiculo = Trim$(psRetorno(1, 2))
        Avaluo.Text = CDbl(psRetorno(1, 7)) / 100
        txtChasis = Trim$(psRetorno(1, 11))
        Contrato.Text = CDbl(Trim$(psRetorno(1, 8))) / 100
        'Cedula.Text = Trim$(Mid$(VLTramaRetorno, 517, 13))
        cedula.Text = Trim$(psRetorno(1, 19))
        TotPago.Text = CDbl(Total.Text) + CDbl(Comision.Text)
        
'        Avaluo.Text = FMRetParamATX(VGSqlConn, 7)
'        Contrato.Text = FMRetParamATX(VGSqlConn, 8)
'        cedula.Text = FMRetParamATX(VGSqlConn, 9)
        mskfechacont.Text = VLFecContable 'Format$(FMRetParamATX(VGSqlConn, 10), VGFormatoFecha$)
        PMChequeaATX VGSqlConn
        FLConsTransDom = True
        VLCambioMatri% = False
        Matricula.Enabled = False
    Else
        TxtNomProp.Text = ""
        Total.Text = "0.00"
        TotPago.Text = "0.00"
        VLCambioMatri% = True
        FLConsTransDom = False
    End If
    PMChequeaATX VGSqlConn
'    If FMRetStatusATX(VGSqlConn) <> 0 Then
'        Matricula.Enabled = True
'        Matricula.SetFocus
'        FLConsTransDom = False
'    End If
    PMFinTransaccion
End Function

Function FLConsTransDom_MS() As Integer
    PMInicioTransaccion
    'Orden de retorno de los resultsets CPS 25/04/2023
    'Pdo_fecha_cad_matricula (1)
    'Pnio_cod_vehiculo (2)
    'Pnio_valor_total_pago   (3)
    'Pno_codigo_canton_vehiculo   (4)
    'Pno_cod_operativo_cod_msj    (5)
    'Pno_log_sri   (6)
    'Pno_valor_avaluo_vehiculo    (7)
    'Pno_valor_contratos   (8)
    'Pso_anio_vehiculo    (9)
    'Pso_camv_cpn_vehiculo   (10)
    'Pso_chasis_vehiculo    (11)
    'Pso_clase_vehiculo (12)
    'Pso_cod_ent_pol_vehiculo    (13)
    'Pso_est_matricula_vehiculo (14)
    'Pso_marca_vehiculo (15)
    'Pso_modelo_vehiculo   (16)
    'Pso_motor_vehiculo (17)
    'Pso_nombre_propietario  (18)
    'Pso_num_iden_propietario   (19)
    'Pso_pais_vehiculo  (20)
    'Pso_placa_vehiculo (21)
    'Pso_servicio_vehiculo  (22)
    Dim VLTrn As String
    Dim VLTrnF As String
    VLTrnF = "62684"
    VLTrn = "18008"
    
    Total.Text = "0"
    TotPago.Text = "0"
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrnF, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_trn", 0, SQLINT4, VLTrn, "Itrn", ""
    PMPasoValoresATX VGSqlConn, "@e_tipo_banca", 0, SQLVARCHAR, "BP", "BP", ""
    PMPasoValoresATX VGSqlConn, "@s_ofi", 0, SQLINT4, str(VGOficina%), "VGOficina%", ""
    PMPasoValoresATX VGSqlConn, "@e_empresa", 0, SQLINT4, "9718", "Empresa", ""
    PMPasoValoresATX VGSqlConn, "@e_convenio", 0, SQLVARCHAR, "SRI-TRNF-DOM", "Convenio", ""
    PMPasoValoresATX VGSqlConn, "@e_servicio", 0, SQLVARCHAR, "SRI-TRNF-DOM", "Servicio", ""
    PMPasoValoresATX VGSqlConn, "@e_tipo_servicio", 0, SQLVARCHAR, "IMPUESTOS_OBLIGACIONES", "Tipo Servicio", ""

    PMPasoValoresATX VGSqlConn, "@e_canal", 0, SQLVARCHAR, "VEN", "PSI_CODIGO_CANAL_PAGO_IFI", ""
    PMPasoValoresATX VGSqlConn, "@e_fecha_real", 0, SQLVARCHAR, Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2), "PSIO_FECHA_CONTABLE_IFI", ""
    PMPasoValoresATX VGSqlConn, "@e_identificacion", 0, SQLVARCHAR, Trim$(Matricula.Text), "PSI_PLACA_CAMV_CPN", ""
    PMPasoValoresATX VGSqlConn, "@e_provincia", 0, SQLVARCHAR, Trim$(VLProvincia), "PSI_PROVINCIA_IFI", ""
    PMPasoValoresATX VGSqlConn, "@e_tipo_identificador", 0, SQLVARCHAR, "TRANSF_DOM", "PSI_TIPO_DEUDA", ""
    PMPasoValoresATX VGSqlConn, "@s_date", 0, SQLVARCHAR, Format$(VGFechaProceso, "yyyy-mm-dd") + "T" + Format$(Time(), "hh:mm:ss"), "FechaLocal", ""
    

       If FMTransmitirRPCATX(VGSqlConn, "RECSRV", "cob_procesador", "fp_consulta_reca_ms", True, "Transaccion Ok", "S", "N", "N", "35", "S", "S") = True Then
        'ReDim psRetorno(1, 22)
        'FMMapeaMatriz VGSqlConn, psRetorno
        'PMMapeaGrid VGSqlConn, grdGrid, False
        'Resultsets Propios de la mensajeria
        
        
        PMMapeaGridATX VGSqlConn, grdGrid, False
        'LLenar el grid con la info del micro Ini
            grdGrid.Rows = grdGrid.Rows
            grdGrid.Cols = grdGrid.Cols
            For I = 1 To grdGrid.Rows - 1
                 grdGrid.Row = I
                 grdGrid.Col = 0
                 grdGrid.Text = Trim$(str$(I))
                 For j = 1 To grdGrid.Cols - 1
                     grdGrid.Col = j
                     grdGrid.Row = I
                 Next
            Next
        'LLenar el grid con la info del micro Ini
        grdGrid.Row = 1
        grdGrid.Col = 1
        TxtNomProp.Text = grdGrid.Text
        
        grdGrid.Col = 12
        Total.Text = CDbl(grdGrid.Text)
        
        grdGrid.Col = 4
        VLCodigoVehiculo = grdGrid.Text
        
        grdGrid.Col = 16
        Avaluo.Text = CDbl(grdGrid.Text) / 100
        
        grdGrid.Col = 5
        txtChasis = Trim$(grdGrid.Text)
        
        grdGrid.Col = 11
        Contrato.Text = CDbl(grdGrid.Text) / 100
        
        grdGrid.Col = 2
        cedula.Text = Trim$(grdGrid.Text)
        
        grdGrid.Col = 6
        PNIO_CODIGO_VEHICULO = grdGrid.Text
        
        TotPago.Text = CDbl(Total.Text) + CDbl(Comision.Text)
        mskfechacont.Text = VLFecContable
        PMChequeaATX VGSqlConn
        FLConsTransDom_MS = True
        VLCambioMatri% = False
        Matricula.Enabled = False
    Else
        TxtNomProp.Text = ""
        Total.Text = "0.00"
        TotPago.Text = "0.00"
        VLCambioMatri% = True
        FLConsTransDom_MS = False
    End If
    PMChequeaATX VGSqlConn
    PMFinTransaccion
End Function
Sub PLFactura()
    'ame 08/03/2010
    
    '**************************************
    'GAMC - 02AGO10 - GUARDAR FACTURA - INI
    '**************************************
    If Comision.Text > 0 And VLDeb_com35 = 0# Then 'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
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

    'fr_iva = "0"
    fr_iva = VLiva    'smerino"0" cambios iva
    fr_baseImp = VlbaseImp 'smerino iva
    fr_impresa = "S" 'smerino
    fr_referencia = Trim(Matricula)
    fr_servicio = "TRANSFERENCIA DE DOMINIO"
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

Public Sub PLImprimirComprobante()

    If VLTotCom35 > 0 And VGTipoEjecucion = CGNormal% Then
    
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
        PMSetDetalle "v" + "LOG AUTORIZACION SRI: " + LOG_AUTORIZACION
        PMSetDetalle "v" + "SEC: " + Trim(Format(VGFechaProceso, "yyyymmdd") & SGSecTrn)
        'PMSetDetalle "v" + "AUTORIZACION SRI: " + CODIGO_TRN_IFI
        'PMSetLineaImpresion "v" + "Costo Serv. Recaudacion  " + "Fecha: " + Format(VGFechaProceso, VGFormatoFecha$) + " " + Format(Now, VGFormatoHora$) + " " + IIf(VGHorarioDif, "H:D", "H:N")
        PMSetDetalle "v" + "Costo Serv. Recaudacion  " + "Fecha: " + VGFechaProceso2 + " " + IIf(VGHorarioDif, "H:D", "H:N")
        PMSetDetalle "v" + "TRANSFERENCIA DE DOMINIO" + FMEspaciosATX(Format(VLTotCom35, VGFormatoMoney), 8, CGJustificacionDerecha)
        PMSetDetalle "v" + "Subtotal:      " + FMEspaciosATX(Format(VlbaseImp, VGFormatoMoney), 8, CGJustificacionDerecha) + "    " + "Iva 12%: " + FMEspaciosATX(Format(VLiva, VGFormatoMoney), 8, CGJustificacionDerecha)
        PMSetDetalle "v" + "VALOR TOTAL:   " + FMEspaciosATX(Format(VLTotCom35, VGFormatoMoney), 8, CGJustificacionDerecha) + "    " + "Referencia: " + (Trim(Matricula))
     If VLTipo_imp = "O" Then
        PMSetDetalle "v" + "Caj: " + VGLogin$ + "              " + "Original: Adquiriente"
     Else
        PMSetDetalle "v" + "Caj: " + VGLogin$ + "              " + "Copia: Emisor"
     End If
        
        PMSetDetalle "v" + " "
        
        VLEfe_com = "0"
        If VGModeloImp$ = "590" Then
            PMSetDetalle "%R" & 2
        End If
FMPRN_StdImpresion "IMPRESORA_1", False, "", "35", SGDatosDetalle, "Inserte papeleta", CStr(VGpartop$), 1, CStr(VGparleft$), , , , , False, , VLTrn

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
'        PMSetLineaImpresion "v" + "TRANSFERENCIA DE DOMINIO" + FMEspaciosATX(Format(VLTotCom35, VGFormatoMoney), 8, CGJustificacionDerecha)
'        PMSetLineaImpresion "v" + "Subtotal:      " + FMEspaciosATX(Format(VLTotCom35, VGFormatoMoney), 8, CGJustificacionDerecha) + "    " + "Iva 12%: " + FMEspaciosATX(Format(0, VGFormatoMoney), 8, CGJustificacionDerecha)
'        PMSetLineaImpresion "v" + "VALOR TOTAL:   " + FMEspaciosATX(Format(VLTotCom35, VGFormatoMoney), 8, CGJustificacionDerecha) + "    " + "Referencia: " + (Trim(Matricula))
'     If VLTipo_imp = "O" Then
'        PMSetLineaImpresion "v" + "Caj: " + VGLogin$ + "              " + "Original: Adquiriente"
'     Else
'        PMSetLineaImpresion "v" + "Caj: " + VGLogin$ + "              " + "Copia: Emisor"
'     End If
'
'        PMSetLineaImpresion "v" + " "
'
'        VLEfe_com = "0"
'        If VGModeloImp$ = "590" Then
'            PMSetLineaImpresion "%R" & 8
'        End If
'
'        PMSetLineaImpresion ">"
'
'        PMImprimir "IMPRESORA_1", False
'        PMFinImpresion "IMPRESORA_1"
'        ' VGHorarioDif = VLHorarioDifTemporal 'comenta ame 08/17/2010

    End If
    
End Sub

Sub PLTransmitir()
Dim VLTotal As Currency
VLclave_acceso = "" '--ref02 vmirandt
    'TPE05/302006 Validacion Debito por moneda diferente a Bae
    If VLMoneda <> VGmoneda% Then
        MsgBox "No se Puede Debitar a Cuentas con Moneda diferente a Moneda Base.", vbExclamation
        If Cta.Enabled Then Cta.SetFocus
        Exit Sub
    End If
    
  'TPE Validacion necesaria para No permitir Transacciones en caso de Valor Acumulado negativo
    If SGAcumulado < 0 And VGTipoEjecucion = CGNormal% Then
        MsgBox "Valor acumulado < 0 por Reverso. Transaccion No Permitida", vbInformation, "Mensaje del Sistema"
            Exit Sub
    End If

  '------> Sumadora
  'TPE Validacion de Monto Efectivo
  If (CDbl(Efectivo.Text) + VLEfe_com35) <> SGUsar Then
      MsgBox "El Monto Efetivo No Coincide con el Monto Desglosado para el Deposito. Verificar", vbCritical, "Mensaje del Sistema"
      Efectivo.Text = Format$(SGUsar, "####,###,##0.00")
      Exit Sub
  End If
  '<--------

    '-->hy-13-dic-2005
    If VGTipoEjecucion = CGNormal% Then
        If (CDbl(Efectivo.Text) + VLValidaEfeCom) <> SGUsar Then
            MsgBox "El Monto Efetivo No Coincide con el Monto Desglosado para el Deposito. Verificar", vbCritical, "Mensaje del Sistema"
            Exit Sub
        End If
    End If
    '<--hy-13-dic-2005

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
  
    'Validacion de emergencia
    If FMCCurATX(Total.Text) <> FMCCurATX(Efectivo.Text) + FMCCurATX(Cheque.Text) + FMCCurATX(Debito.Text) + FMCCurATX(Tarjeta.Text) Then
        MsgBox "No cuadran los totales en la sumadora, favor salga de la opción y vuelva a aplicar la transacción"
        Exit Sub
    End If
    '---
'COMENTADO POR CPS
'    If VGTipoEjecucion% <> CGReverso% Then
'        If Not FLTramaSwitch("P") Then
'            '-->hy-27-dic-2005
'            If VLUsarRevForzado Then
'                If Not FLTramaSwitch("Z") Then
'                    MsgBox "Reversa forzada sin confirmación", vbInformation, "Mensaje del sri"
'                End If
'            End If
'            '<--hy-27-dic-2005
'            If Trim$(txtmensaje.Text) <> "" Then
'                MsgBox txtmensaje.Text, vbInformation, "Mensaje del sri"
'            Else
'                MsgBox "Transaccion No ha sido realizada intente nuevamente", vbInformation, "AVISO"
'            End If
'            Exit Sub
'        End If
'    Else
'        If Not FLTramaSwitch("R") Then
'            If Trim$(txtmensaje.Text) <> "" Then
'                MsgBox txtmensaje.Text, vbInformation, "Mensaje del sri"
'            Else
'                MsgBox "Transaccion No ha sido realizada intente nuevamente", vbInformation, "AVISO"
'            End If
'            Exit Sub
'        End If
'    End If
  'JPM ContadorBillete -->
  If lectoraBill.HayAltaDenom Then
    If Not VGDatPersBillAltDen.dataOK Then
      MsgBox "Existen Billetes de Alta Denominación cuyos Número de Serie no se han confirmado", vbCritical, "Mensaje del Sistema"
      Exit Sub
    End If
  End If
  '<-- JPM ContadorBillete
  
  If FLTransmitir_MS() = False Then
  'If FLTransmitir() = False Then
      'Sumadora ------->
      If (SGAcumulado + SGAcumuladoAdi) = 0 Then
            If Matricula.Enabled = True Then
                Matricula.SetFocus
            End If
      End If
      '<---------
        MsgBox "Transaccion No ha sido realizada intente nuevamente", vbInformation, "AVISO"
'        If Not FLTramaSwitch("R") Then
'            If Trim$(txtMensaje.Text) <> "" Then
'                MsgBox txtMensaje.Text, vbInformation, "Mensaje del sri"
'            End If
'            Exit Sub
'        End If
  
      Exit Sub
  End If
  
  If VGTipoEjecucion = CGReverso And VGReversoLoger = "S" Then
    PMMsgError "Reverso OK", "", CGErrorInformativo
    FReverso!grdValores(0).Col = 4
    FReverso!grdValores(0).Text = "R"
  End If
  
  'LLAMADA A LA FUNCION DE FORMATOS DE REPORTES
  VGparformato$ = "01"
  If Not FMFormatPagina(VGparformato$, VGparlong$, VGpartop$, VGparleft$, VGparrig$) Then
     VGparlong$ = "66"
     VGpartop$ = "04"
     VGparleft$ = "20"
     VGparrig$ = "00"
  End If
   '--ref02 inicio
    VGpartop$ = "00" '00
    VGparleft$ = "20" '10
    '--ref02 fin
  ' FIN DE LLAMADA A LA FUNCION
  impresiones = 1
  For j = 1 To UBound(SGNumImpresion)
    If Trim(SGNumImpresion(j).transaccion) = "3257" Then
        impresiones = SGNumImpresion(j).veces
        Exit For
    End If
  Next j
            
  If impresiones > 0 Then
    For j = 1 To impresiones
        PMInicioImpresion "IMPRESORA_1"
        PMBorrarDatosImpresion
        PMSetLineaImpresion "x" + "Inserte COMPROBANTE de Transaccion"
        PMSetLineaImpresion "<"
        PMSetLineaImpresion "!" & VGpartop$
        PMSetLineaImpresion "%N" & VGparleft$
        PMSetLineaImpresion "v" + CStr(VGTSN%) + " " + Format(Now, VGFormatoHora$) + " " + Format(VGFechaProceso, VGFormatoFecha$) + " " + CStr(VGOficina%) + " " + CStr(FMObtenerMonedaForma("35")) + " " + VGLogin$
        PMSetLineaImpresion "v" + VGMensImpr + IIf(VGHorarioDif, "3336", "3295") + " " + FMObtenerTitulo("35") + " " + IIf(VGHorarioDif, "H:D", "H:N") + " " + IIf(VGTipoEjecucion = CGReverso, "REVERSO", "")
        PMSetLineaImpresion "v" + "Sec: " + Trim(Format(VGFechaProceso, "yyyymmdd") & SGSecTrn) + " Chasis:" + Trim(txtChasis.Text)
        
        'hy-->
        'PMSetLineaImpresion "v" + "Motor:" + Trim(txtMotor.Text) + " Chasis: " + Trim(txtChasis.Text)
        PMSetLineaImpresion "v" + "Log Autorizacion SRI:" + LOG_AUTORIZACION
        '<--hy
        PMSetLineaImpresion "v" + "Nuevo Propietario: " + Mid$(Trim(TxtNomProp), 1, 25)
        'PMSetLineaImpresion "v" + "Ced/Ruc/Pas nuevo prop:" + FMEspaciosATX(Mid((cedula.Text), 1, 14), 14, CGJustificacionIzquierda) + "Placa:" + Mid(Trim(Matricula), 1, 10)
        PMSetLineaImpresion "v" + "Ced/Ruc/Pas nuevo prop:" + Mid((cedula.Text), 1, 14) + " Placa:" + Mid(Trim(Matricula), 1, 10)
        
        PMSetLineaImpresion "v" + "Avaluo:" + FMEspaciosATX("us$" + Format(Avaluo, "#,###,##0.00"), 13, CGJustificacionDerecha) + " " + "Cont:" + FMEspaciosATX("us$" + Format((Contrato + administracion), "#,###,##0.00"), 13, CGJustificacionDerecha)
  
        If FMCCurATX((Efectivo.Text)) > 0 Or FMCCurATX((Cheque.Text)) > 0 Then
            PMSetLineaImpresion "v" + "Efe:   " + FMEspaciosATX("us$" + Format(Efectivo, VGFormatoMoney), 13, CGJustificacionDerecha) + " CHQ :" + FMEspaciosATX("us$" + Format(Cheque, VGFormatoMoney), 13, CGJustificacionDerecha)
        End If
  
        If FMCCurATX((Debito.Text)) > 0 Or FMCCurATX((Tarjeta.Text)) > 0 Then
            PMSetLineaImpresion "v" + "Deb:   " + FMEspaciosATX("us$" + Format(Debito, VGFormatoMoney), 13, CGJustificacionDerecha) + " TAR :" + FMEspaciosATX("us$" + Format(Tarjeta, VGFormatoMoney), 13, CGJustificacionDerecha)
        End If
        PMSetLineaImpresion "v" + "Comision: " + FMEspaciosATX("us$" + Format(Comision.Text, VGFormatoMoney), 13, CGJustificacionDerecha) + " Total: " + FMEspaciosATX("us$" + Format((Total + administracion), "##,###,##0.00"), 13, CGJustificacionDerecha)
        
    '***ref02 vmirandt inicio, se imprime al final del documento
    If VLclave_acceso <> "" Then
        PMSetLineaImpresion "v" + "Clave de Acceso/Autorizacion: "
        PMSetLineaImpresion "v" + VLclave_acceso
    End If
    'ref02 vmirandt
  
        PMSetLineaImpresion ">"
        PMImprimir "IMPRESORA_1", False
        PMFinImpresion "IMPRESORA_1"
  
        'If VGTipoEjecucion = CGNormal% Then gmartillo 05/26/2008
        '  While MsgBox("Desea Reimprimir el Comprobante?", vbYesNo, "Mensaje") = vbYes
        '      PMReimpresion
        '  Wend
        'End If
  
        
    Next j
  End If
  
    'ame 08/04/2010  factura cobro comision
    If VGTipoEjecucion% <> CGReverso% Then
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

  
  If SGAcumulado = 0 Then
     Form_KeyDown CGTeclaF2%, 0
  Else
     Form_KeyDown CGTeclaF2%, -1
  End If

End Sub
 

 Function FLChequeos() As Integer
  FLChequeos = True
  
  If Len(Matricula.Text) = 0 Then
    MsgBox " El campo Matricula: es Mandatorio"
    Matricula.SetFocus
    FLChequeos = False
    Exit Function
  End If
  
 If FMCCurATX((Total.Text)) = 0# Or Total.Text = "" Then
    MsgBox "El campo Total a Pagar: es Mandatorio"
    If Efectivo.Enabled = True Then
       Efectivo.SetFocus
    End If
    FLChequeos = False
    Exit Function
  End If
  
  If VLTotCom35 <> FMCCurATX((Comision.Text)) Then   ' ps 28/01/2004
      MsgBox "Verifique el Campo Valor de Comision"
      Comision.SetFocus
      FLChequeos = False
      Exit Function
  End If
  
  If CboTipCta.Text = "AHO" Then
    VLProd = 4
  Else
    VLProd = 3
  End If
  
  If FMCCurATX((Debito.Text)) <> 0# Then
     If Len(Cta.ClipText) = 0 Then
        MsgBox " El campo No. Cuenta: es Mandatorio"
        Cta.SetFocus
        FLChequeos = False
        Exit Function
     Else
       If FMValidaCuenta(VLProd, Cta, "35") = False Then
         FLChequeos = False
         Exit Function
       End If
     End If
  End If
'  canChq = IIf(CantChq.Text = "", 0, CantChq.Text)
'  Chq = IIf(Cheque.Text = "0.00", 0, Cheque.Text)
'  If (Val(canChq) <> 0 And Trim(CantChq.Text) <> "") And CDbl(Cheque.Text) = 0 Then
  If (val(CantChq.Text) <> 0 And Trim(CantChq.Text) <> "") And val(Cheque.Text) = 0 Then
      MsgBox "Verificar campos Cant. de Cheques y Valor Cheques"
      FLChequeos = False
      If CantChq.Enabled = True Then
        CantChq.SetFocus
      End If
      Exit Function
  End If

  If Len(Cta.ClipText) <> 0 Then
     If FMCCurATX((Debito.Text)) = 0# Or Debito.Text = "" Then
        MsgBox " El campo Debito: es Mandatorio"
        Debito.SetFocus
        FLChequeos = False
        Exit Function
     End If
  End If
  
    'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
    If FCC35.Cta.ClipText <> "" Then
        If VLDeb_com35 > 0 And FCC35.Cta.ClipText <> VLCta_com35 Then
            MsgBox "La cuenta de la comision debe ser la misma con la que realiza el pago del servicio."
            Comision.SetFocus
            FLChequeos = False
            Exit Function
        End If
    End If
    'msilvag Fin
    
  If VGTotalizar$ = "N" Then
     If Format(TotPago.Text, "###,###,###,##0.00") <> Format(FMCCurATX((Efectivo.Text)) + FMCCurATX((Cheque.Text)) + FMCCurATX((Debito.Text)) + FMCCurATX((Tarjeta.Text)) + FMCCurATX((Comision.Text)), "###,###,###,##0.00") Then
        MsgBox " El campo Total a cancelar no cuadra"
        FLChequeos = False
        Efectivo.SetFocus
        Exit Function
     End If
  Else
     Total.Text = Format(FMCCurATX((Efectivo.Text)) + FMCCurATX((Cheque.Text)) + FMCCurATX((Debito.Text)) + FMCCurATX((Tarjeta.Text)), "###,###,###,##0.00")
  End If
End Function

Function FLTransmitir_MS() As Integer
  Dim VTSecuencialTrx As String
  Dim VTIndicadorSum As Integer
  Dim tValor As String
  Dim fr_ced_ruc As String
  Dim flujo As String
  Dim VLTrnF As String
  Dim cnv_FechaDebito As String
  
  VLTrnF = "62685"
  flujo = "fp_pago_reca_ms"

    'Validacion de emergencia
    If FMCCurATX(Total.Text) <> FMCCurATX(Efectivo.Text) + FMCCurATX(Cheque.Text) + FMCCurATX(Debito.Text) + FMCCurATX(Tarjeta.Text) Then
        MsgBox "No cuadran los totales en la sumadora, favor salga de la opción y vuelva a aplicar la transacción"
        FLTransmitir_MS = False
        VTIndicadorSum = 0
        Exit Function
    End If
    
    If VGTipoEjecucion = CGNormal Then
        If Not FLSecuencias() Then
            Me.Enabled = True
            Exit Function
        End If
    End If
    VTIndicadorSum = 0
    
    VLTrn = "3295"
    VGTrn = IIf(VLTrn = "", 0, VLTrn)
    
    If VGTipoEjecucion% <> CGReverso% Then
        'VERIFICA MONTO MAXIMO
        PMInicioTransaccion
        PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 4050, "Trn", ""
        PMPasoValoresATX VGSqlConn, "@i_empresa", 0, SQLVARCHAR, "2", "Empresa", ""
        PMPasoValoresATX VGSqlConn, "@i_codigo", 0, SQLVARCHAR, (Matricula.Text), "Suministro", ""
        PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "CSP", "Canal", ""
        PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLVARCHAR, "T", "Opcion", ""
        PMPasoValoresATX VGSqlConn, "@i_aplcobis", 0, SQLVARCHAR, "S", "Aplicacion Cobis", ""
        PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLVARCHAR, "C", "Aplicacion Cobis", ""
        PMPasoValoresATX VGSqlConn, "@i_efectivo", 0, SQLMONEY, Efectivo.Text, "efectivo", ""
        PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, Cheque.Text, "cheque", ""
        PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, Debito.Text, "debito", ""
        PMPasoValoresATX VGSqlConn, "@i_comision_efe", 0, SQLMONEY, CCur(VLEfe_com35), "comision_efe", ""
        PMPasoValoresATX VGSqlConn, "@i_comision_chq", 0, SQLMONEY, CCur(VLChq_com35), "comision_chq", ""
        PMPasoValoresATX VGSqlConn, "@i_comision_db", 0, SQLMONEY, CCur(VLDeb_com35), "comision_deb", ""
          
        If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_val_servicios_varios", True, "Transaccion Ok", "S", "N", "N", "35", "S", "S") = True Then
            PMChequeaATX VGSqlConn&
            PMFinTransaccion
        Else
            VTIndicadorSum = 0
            TxtNomCta.Text = ""
            VLCambio% = True
            FLTransmitir_MS = False
            PMChequeaATX VGSqlConn
            PMFinTransaccion
            Exit Function
        End If
    End If

 
    If VGTipoEjecucion% = CGReverso% Then
        VLIndReverso = True
        VLTrnF = "62690"
        flujo = "fp_reverso_reca_ms"
    End If
      
    PMInicioTransaccion
    If VGTipoEjecucion% <> CGReverso% Then
        PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLVARCHAR, "N", "TCORR", ""
        PMPasoValoresATX VGSqlConn, "@e_corr", 0, SQLVARCHAR, "N", "TCORR", ""
    End If

    '****** BRANCH *******************************************************
    PMPasoValoresATX VGSqlConn, "@i_moneda", 0, SQLINT1, str(FMObtenerMonedaForma("35")), "Moneda", ""
    PMPasoValoresATX VGSqlConn, "@i_val", 0, SQLMONEY, Efectivo.Text, "Efectivo", ""
    PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, Debito.Text, "Debito", ""
    PMPasoValoresATX VGSqlConn, "@i_tarjeta", 0, SQLMONEY, (Tarjeta.Text), "tarjeta", ""
    If Me.Cta.ClipText <> "" Then
        PMPasoValoresATX VGSqlConn, "@i_tipo_cta", 0, SQLCHAR, (CboTipCta.Text), "TipoCta", ""
        PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
    Else
        PMPasoValoresATX VGSqlConn, "@i_tipo_cta", 0, SQLVARCHAR, (VLTipCta_com35), "TipoCta", ""
        PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (VLCta_com35), "Cuenta", ""
    End If

    PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, (Cheque.Text), "Cheques", ""
    If CantChq.Text = "" Then
        PMPasoValoresATX VGSqlConn, "@i_cant_cheques", 0, SQLINT4, "0", "Cantidad de cheques", ""
        PMPasoValoresATX VGSqlConn, "@i_cant_chq", 0, SQLINT4, "0", "CantChq", ""
    Else
        PMPasoValoresATX VGSqlConn, "@i_cant_cheques", 0, SQLINT4, (CantChq.Text), "Cantidad de cheques", ""
        PMPasoValoresATX VGSqlConn, "@i_cant_chq", 0, SQLINT4, val(CantChq.Text), "CantChq", ""
    End If
    
    '****** MS-COBIS *******************************************************
    PMPasoValoresATX VGSqlConn, "@e_empresa", 0, SQLINT4, "9718", "Empresa", ""
    PMPasoValoresATX VGSqlConn, "@e_convenio", 0, SQLVARCHAR, "SRI-TRNF-DOM", "Empresa", ""
    PMPasoValoresATX VGSqlConn, "@e_servicio", 0, SQLVARCHAR, "SRI-TRNF-DOM", "Servicio", ""
    PMPasoValoresATX VGSqlConn, "@e_tipo_servicio", 0, SQLVARCHAR, "IMPUESTOS_OBLIGACIONES", "Tipo Servicio", ""
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrnF, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_trn", 0, SQLINT4, VLTrn, "Itrn", ""
    PMPasoValoresATX VGSqlConn, "@e_tipo_banca", 0, SQLVARCHAR, "BP", "BP", ""
    
    '****** MS-PAGO *******************************************************
    If Me.Cta.ClipText <> "" Then
        PMPasoValoresATX VGSqlConn, "@e_tipocta", 0, SQLCHAR, (CboTipCta.Text), "TipoCta", ""
        PMPasoValoresATX VGSqlConn, "@e_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
    Else
        PMPasoValoresATX VGSqlConn, "@e_tipocta", 0, SQLVARCHAR, (VLTipCta_com35), "TipoCta", ""
        PMPasoValoresATX VGSqlConn, "@e_cuenta", 0, SQLVARCHAR, (VLCta_com35), "Cuenta", ""
    End If
    PMPasoValoresATX VGSqlConn, "@e_moneda", 0, SQLINT1, str(FMObtenerMonedaForma("134")), "Moneda", ""
    PMPasoValoresATX VGSqlConn, "@e_val", 0, SQLMONEY, Efectivo.Text, "Efectivo", ""
    PMPasoValoresATX VGSqlConn, "@e_opcion", 0, SQLCHAR, "P", "Opcion", ""
    PMPasoValoresATX VGSqlConn, "@e_canal", 0, SQLVARCHAR, "VEN", "Canal", ""
    PMPasoValoresATX VGSqlConn, "@e_nombre", 0, SQLVARCHAR, TxtNomProp.Text, "Nom. Cliente", ""
    PMPasoValoresATX VGSqlConn, "@e_total", 0, SQLMONEY, (Total.Text), "Total pagado", ""
    PMPasoValoresATX VGSqlConn, "@e_fecha_real", 0, SQLVARCHAR, Format(Date, "mm/dd/yyyy"), "FechaReal", ""
    PMPasoValoresATX VGSqlConn, "@srv", 0, SQLVARCHAR, "", "SRVDESA2", ""
    PMPasoValoresATX VGSqlConn, "@e_concepto", 0, SQLVARCHAR, Matricula.Text, "SRVDESA2", ""
    PMPasoValoresATX VGSqlConn, "@s_date", 0, SQLVARCHAR, Format$(VGFechaProceso, "yyyy-mm-dd") + "T" + Format$(Time(), "hh:mm:ss"), "FechaLocal", ""
    PMPasoValoresATX VGSqlConn, "@e_nombre_cta", 0, SQLVARCHAR, TxtNomCta.Text, "Nombre cuenta", ""
    PMPasoValoresATX VGSqlConn, "@e_identificacion", 0, SQLVARCHAR, (Matricula.Text), "Cod. Cliente", ""
    PMPasoValoresATX VGSqlConn, "@e_comision_tot", 0, SQLMONEY, (Comision.Text), "valor de la comision", ""
    PMPasoValoresATX VGSqlConn, "@s_sectrx", 1, SQLINT4, 0, "SecTrn", ""
    PMPasoValoresATX VGSqlConn, "@e_cod_cliente", 0, SQLVARCHAR, (VGAutoriza), "Cod. Cliente", ""
    If CantChq.Text = "" Then
        PMPasoValoresATX VGSqlConn, "@e_cant_cheques", 0, SQLINT4, "0", "Cantidad de cheques", ""
    Else
        PMPasoValoresATX VGSqlConn, "@e_cant_cheques", 0, SQLINT4, (CantChq.Text), "Cantidad de cheques", ""
    End If
    
    PMPasoValoresATX VGSqlConn, "@e_ruc_cliente", 0, SQLVARCHAR, (cedula.Text), "Ruc Cliente", ""
    
    
    
    PMPasoValoresATX VGSqlConn, "@e_factura", 0, SQLVARCHAR, (Avaluo.Text), "Avaluo", ""
    PMPasoValoresATX VGSqlConn, "@e_cod_respuesta", 0, SQLVARCHAR, (Contrato.Text), "Contrato", ""
    
    '****** COMISION PAGO*******************************************************
    PMPasoValoresATX VGSqlConn, "@e_efectivo", 0, SQLMONEY, (Efectivo.Text), "efe", ""
    PMPasoValoresATX VGSqlConn, "@e_cheque", 0, SQLMONEY, (Cheque.Text), "Cheques", ""
    PMPasoValoresATX VGSqlConn, "@e_debito", 0, SQLMONEY, Debito.Text, "Debito", ""
    PMPasoValoresATX VGSqlConn, "@e_comision_efe", 0, SQLMONEY, (VLEfe_com35), "Com. efectivo", ""
    PMPasoValoresATX VGSqlConn, "@e_comision_chq", 0, SQLMONEY, (VLChq_com35), "Com. Cheques", ""
    PMPasoValoresATX VGSqlConn, "@e_comision_db", 0, SQLMONEY, (VLDeb_com35), "Com. debito", ""
    
    '****** TC *******************************************************
    If Tarjeta.Text <> "0.00" Then
        PMPasoValoresATX VGSqlConn, "@e_tarjeta", 0, SQLMONEY, Tarjeta.Text, "Valor TC", ""
        Else
        PMPasoValoresATX VGSqlConn, "@e_tarjeta", 0, SQLMONEY, 0, "Valor TC", ""
    End If
    
    '****** VARIABLES PARA REVERSO *******************************************************
    PMPasoValoresATX VGSqlConn, "@e_avaluo", 0, SQLVARCHAR, (Avaluo.Text), "Avaluo", ""
    PMPasoValoresATX VGSqlConn, "@e_cedula", 0, SQLVARCHAR, (cedula.Text), "Cedula", ""
    PMPasoValoresATX VGSqlConn, "@e_contrato", 0, SQLVARCHAR, (Contrato.Text), "Contrato", ""
    PMPasoValoresATX VGSqlConn, "@e_chasis", 0, SQLVARCHAR, (txtChasis.Text), "Chasis", ""
        
    'LBP Inicio RECA-CC-SGC00025869 30/07/2016
    If VLEfe_com35 > 0 And VLChq_com35 > 0 And VLDeb_com35 > 0 Then
       VGFormaPago = "EFE;" & Format(VLEfe_com35, "#0.00") & "_" & "CHE;" & Format(VLChq_com35, "#0.00") & "_" & "DEB;" & Format(VLDeb_com35, "#0.00")
    ElseIf VLEfe_com35 > 0 And VLChq_com35 > 0 Then
       VGFormaPago = "EFE;" & Format(VLEfe_com35, "#0.00") & "_" & "CHE;" & Format(VLChq_com35, "#0.00")
    ElseIf VLEfe_com35 > 0 And VLDeb_com > 0 Then
       VGFormaPago = "EFE;" & Format(VLEfe_com35, "#0.00") & "_" & "DEB;" & Format(VLDeb_com35, "#0.00")
    ElseIf VLChq_com35 > 0 And VLDeb_com > 0 Then
       VGFormaPago = "CHE;" & Format(VLChq_com35, "#0.00") & "_" & "DEB;" & Format(VLDeb_com35, "#0.00")
    ElseIf VLEfe_com35 > 0 Then
       VGFormaPago = "EFE;" & Format(VLEfe_com35, "#0.00")
    ElseIf VLChq_com35 > 0 Then
       VGFormaPago = "CHE;" & Format(VLChq_com35, "#0.00")
    ElseIf VLDeb_com35 > 0 Then
       VGFormaPago = "DEB;" & Format(VLDeb_com35, "#0.00")
    End If
    
    PMPasoValoresATX VGSqlConn, "@e_codigo_vehiculo", 0, SQLVARCHAR, PNIO_CODIGO_VEHICULO, "PNIO_CODIGO_VEHICULO", ""
    If FMTransmitirRPCATX(VGSqlConn, "RECSRV", "cob_procesador", flujo, True, "Transaccion Ok", "S", "N", "S", "35", "S", "S") = True Then
    
    PMMapeaGridATX VGSqlConn, grdGrid, False
        'LLenar el grid con la info del micro Ini
            grdGrid.Rows = grdGrid.Rows
            grdGrid.Cols = grdGrid.Cols
            For I = 1 To grdGrid.Rows - 1
                 grdGrid.Row = I
                 grdGrid.Col = 0
                 grdGrid.Text = Trim$(str$(I))
                 For j = 1 To grdGrid.Cols - 1
                     grdGrid.Col = j
                     grdGrid.Row = I
                 Next
            Next
        'LLenar el grid con la info del micro Ini
        
        grdGrid.Row = 5
        grdGrid.Col = 2
        VTSecuencialTrx = grdGrid.Text
        
        VLMCN = VTSecuencialTrx 'FMRetParamATX(VGSqlConn, 15)  'MCN
        VLMCN = Trim(VLMCN)
        'KBastidz RECMPS-3004
        grdGrid.Row = 21
        grdGrid.Col = 2
        LOG_AUTORIZACION = grdGrid.Text
        txtLogRevSri.Text = VLMCN
        
        VLSerie_Secuencia = VTSecuencialTrx 'FMRetParamATX(VGSqlConn, 14)  'hy-24-feb-2005
        VLSerie_Secuencia = Trim(VLSerie_Secuencia)
        If VGTipoEjecucion = CGNormal Then
            VLtxtLogRevSri = VLMCN
        Else
            VLMCN = txtLogRevSri.Text
        End If
        
        
        'TPE ------> Sumadora
        SGSecTrn$ = VTSecuencialTrx  'FMRetParamATX(VGSqlConn, 11)
        VTIndicadorSum = 1
        PMIniciaRegSum
        '<-----
        
        PMChequeaATX VGSqlConn
        FLTransmitir_MS = True
        VLCambio% = False
    Else
        'TPE ------> Sumadora
        SGSecTrn$ = VTSecuencialTrx 'FMRetParamATX(VGSqlConn, 11)
        VTIndicadorSum = 0
        '<------
        
        TxtNomCta.Text = ""
        VLCambio% = True
        FLTransmitir_MS = False
    End If
    PMChequeaATX VGSqlConn
    If FMRetStatusATX(VGSqlConn) <> 0 Then
        On Error Resume Next
        Matricula.SetFocus
        FLTransmitir_MS = False
        VTIndicadorSum = 0
    End If
    PMFinTransaccion
    
    'ame 08/04/2010
    If FLTransmitir_MS = True Then
       'JPM Lectora de Billetes -->
       If CCur(Efectivo.Text) > 0 And ((VGDatPersBillAltDen.dataOK And VGTipoEjecucion = CGNormal%) Or VGTipoEjecucion = CGReverso%) Then
         Call PMGuardarDsglsBillete("35", SGSecTrn$, VLTrn, rptBAD, "REC", "")
       End If
       '<-- JPM Lectora de Billetes
       Call PLFactura
    End If

    
    If VGTipoEjecucion% <> CGReverso% Then   'Validacion por REVERSO
        If (VTIndicadorSum = 1 And (Trim$(VGStatusCon) = "A" Or Trim$(VGStatusCon) = "")) Then
            SGPrimeraVez = 0            ' ya no es primera vez
            PMGrabaDesglose VLTrn, CStr(SGUsar), VLCambio%
            If VLCambio% = True Then
                MsgBox "Error en la Grabacion del Desglose. Favor comuniquese con su Supervisor.", vbCritical, "Error de Sistema"
            End If
            SGActual = 1                'seteo Variable para borrar desglose
        ElseIf VTIndicadorSum = 0 Then
            SGActual = 0               'no borrar desglose en caso de Error en Transaccion
        End If
    ElseIf VTIndicadorSum = 1 Then       'Por REVERSO
        PMEgresoEfectivo SGUsar, VLTrn, VGSSNCorr&
    End If
    '<-----
  
End Function
Function FLTransmitir() As Integer
  Dim VTIndicadorSum As Integer
  Dim tValor As String
  
    'Validacion de emergencia
    If FMCCurATX(Total.Text) <> FMCCurATX(Efectivo.Text) + FMCCurATX(Cheque.Text) + FMCCurATX(Debito.Text) + FMCCurATX(Tarjeta.Text) Then
        MsgBox "No cuadran los totales en la sumadora, favor salga de la opción y vuelva a aplicar la transacción"
        FLTransmitir = False
        VTIndicadorSum = 0
        Exit Function
    End If
    '---
    If VGTipoEjecucion = CGNormal Then
        If Not FLSecuencias() Then
            Me.Enabled = True
            Exit Function
        End If
    End If
    VTIndicadorSum = 0
    If VGHorarioDif Then
        VLTrn = "3336"
    Else
        VLTrn = "3295"
    End If
    VGTrn = IIf(VLTrn = "", 0, VLTrn)
    
    If VGTipoEjecucion% <> CGReverso% Then
      
    'VERIFICA MONTO MAXIMO
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 4050, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_empresa", 0, SQLVARCHAR, "2", "Empresa", ""
    PMPasoValoresATX VGSqlConn, "@i_codigo", 0, SQLVARCHAR, (Matricula.Text), "Suministro", ""
    PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "CSP", "Canal", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLVARCHAR, "T", "Opcion", ""
    PMPasoValoresATX VGSqlConn, "@i_aplcobis", 0, SQLVARCHAR, "S", "Aplicacion Cobis", ""
    PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLVARCHAR, "C", "Aplicacion Cobis", ""
    PMPasoValoresATX VGSqlConn, "@i_efectivo", 0, SQLMONEY, Efectivo.Text, "efectivo", ""
    PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, Cheque.Text, "cheque", ""
    PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, Debito.Text, "debito", ""
    PMPasoValoresATX VGSqlConn, "@i_comision_efe", 0, SQLMONEY, CCur(VLEfe_com35), "comision_efe", ""
    PMPasoValoresATX VGSqlConn, "@i_comision_chq", 0, SQLMONEY, CCur(VLChq_com35), "comision_chq", ""
    PMPasoValoresATX VGSqlConn, "@i_comision_db", 0, SQLMONEY, CCur(VLDeb_com35), "comision_deb", ""
      
    If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_val_servicios_varios", True, "Transaccion Ok", "S", "N", "N", "35", "S", "S") = True Then
        PMChequeaATX VGSqlConn&
        PMFinTransaccion
    Else
        VTIndicadorSum = 0
        TxtNomCta.Text = ""
        VLCambio% = True
        FLTransmitir = False
        PMChequeaATX VGSqlConn
        PMFinTransaccion
        Exit Function
    End If

    End If
    
    
    
      
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
    'If VGTipoEjecucion% <> CGReverso% Then
    '     PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLVARCHAR, "N", "TCORR", ""
    'End If
    PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(FMObtenerMonedaForma("35")), "Moneda", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "P", "", ""
    PMPasoValoresATX VGSqlConn, "@i_matricula", 0, SQLVARCHAR, (Matricula.Text), "Matricula", ""
    PMPasoValoresATX VGSqlConn, "@i_efe", 0, SQLMONEY, (Efectivo.Text), "Efectivo", ""
    PMPasoValoresATX VGSqlConn, "@i_cant_chq", 0, SQLINT4, (CantChq.Text), "Cantidad", ""
    PMPasoValoresATX VGSqlConn, "@i_cheq", 0, SQLMONEY, (Cheque.Text), "Cheque", ""
    PMPasoValoresATX VGSqlConn, "@i_tipocta", 0, SQLVARCHAR, (CboTipCta.Text), "CboTipCta", ""
    PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
    PMPasoValoresATX VGSqlConn, "@i_deb", 0, SQLMONEY, (Debito.Text), "Debito", ""
    PMPasoValoresATX VGSqlConn, "@i_tarjeta", 0, SQLMONEY, (Tarjeta.Text), "tarjeta", ""
    PMPasoValoresATX VGSqlConn, "@i_total", 0, SQLMONEY, (Total.Text), "Total", ""
    PMPasoValoresATX VGSqlConn, "@i_autoriza", 0, SQLCHAR, VGAutoriza, "Autorizacion", ""
    PMPasoValoresATX VGSqlConn, "@o_nomprop", 1, SQLVARCHAR, (TxtNomProp.Text), "TxtNomProp", ""
    If VGTipoEjecucion = CGReverso Then
        PMPasoValoresATX VGSqlConn, "@o_nomcta", 1, SQLVARCHAR, "X", "TxtNomCta", ""
    Else
        PMPasoValoresATX VGSqlConn, "@o_nomcta", 1, SQLVARCHAR, (TxtNomCta.Text), "TxtNomCta", ""
    End If
    PMPasoValoresATX VGSqlConn, "@o_total", 1, SQLMONEY, (Total.Text), "Total", ""
    
    If VGTipoEjecucion = CGReverso Then
        tValor = DatoSwitch("@o_compro")
        PMPasoValoresATX VGSqlConn, "@o_compro", 1, SQLINT4, tValor, "Comprobante", ""
        
        tValor = DatoSwitch("@o_cedruc")
        PMPasoValoresATX VGSqlConn, "@o_cedruc", 1, SQLCHAR, tValor, "Cedula", ""
    Else
        PMPasoValoresATX VGSqlConn, "@o_compro", 1, SQLINT4, "0", "Comprobante", ""
        PMPasoValoresATX VGSqlConn, "@o_cedruc", 1, SQLCHAR, "", "Cedula", ""
    End If
    PMPasoValoresATX VGSqlConn, "@o_motor", 1, SQLVARCHAR, "0", "Motor", ""
    PMPasoValoresATX VGSqlConn, "@o_chasis", 1, SQLVARCHAR, "0", "Chasis", ""
    PMPasoValoresATX VGSqlConn, "@o_avaluo", 1, SQLMONEY, "0", "Avaluo", ""
    PMPasoValoresATX VGSqlConn, "@o_valor", 1, SQLMONEY, "0", "Valor", ""
    PMPasoValoresATX VGSqlConn, "@o_fecha_contrato", 1, SQLDATETIME, Format$("01/01/1900", VGFormatoFecha$), "mskfechacont", ""
    PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, "0", "SecTrn", ""
    If VGTipoEjecucion = CGReverso Then
        PMPasoValoresATX VGSqlConn, "@o_autorisri", 1, SQLVARCHAR, "X", "AutorizacionSRI", ""
        PMPasoValoresATX VGSqlConn, "@o_fecvensri", 1, SQLVARCHAR, "X", "Stk", ""
    Else
        PMPasoValoresATX VGSqlConn, "@o_autorisri", 1, SQLVARCHAR, VLautoriSri, "AutorizacionSRI", ""
        PMPasoValoresATX VGSqlConn, "@o_fecvensri", 1, SQLVARCHAR, VLFecvenSRI, "Stk", ""
    End If
    
    '****** COMISION *******************************************************
    'If VLTotCom35 <> 0 Then
     PMPasoValoresATX VGSqlConn, "@i_efe_com", 0, SQLMONEY, (VLEfe_com35), "Com. efectivo", ""
     PMPasoValoresATX VGSqlConn, "@i_chq_com", 0, SQLMONEY, (VLChq_com35), "Com. Cheques", ""
     PMPasoValoresATX VGSqlConn, "@i_deb_com", 0, SQLMONEY, (VLDeb_com35), "Com. Debito", ""
     PMPasoValoresATX VGSqlConn, "@i_cta_com", 0, SQLVARCHAR, (VLCta_com35), "Com. Cta", ""
     PMPasoValoresATX VGSqlConn, "@i_tipocta_com", 0, SQLCHAR, (VLTipCta_com35), "Com. TipCta", ""
     
    'LBP Inicio RECA-CC-SGC00025869 30/07/2016
    If VLEfe_com35 > 0 And VLChq_com35 > 0 And VLDeb_com35 > 0 Then
       VGFormaPago = "EFE;" & Format(VLEfe_com35, "#0.00") & "_" & "CHE;" & Format(VLChq_com35, "#0.00") & "_" & "DEB;" & Format(VLDeb_com35, "#0.00")
    ElseIf VLEfe_com35 > 0 And VLChq_com35 > 0 Then
       VGFormaPago = "EFE;" & Format(VLEfe_com35, "#0.00") & "_" & "CHE;" & Format(VLChq_com35, "#0.00")
    ElseIf VLEfe_com35 > 0 And VLDeb_com > 0 Then
       VGFormaPago = "EFE;" & Format(VLEfe_com35, "#0.00") & "_" & "DEB;" & Format(VLDeb_com35, "#0.00")
    ElseIf VLChq_com35 > 0 And VLDeb_com > 0 Then
       VGFormaPago = "CHE;" & Format(VLChq_com35, "#0.00") & "_" & "DEB;" & Format(VLDeb_com35, "#0.00")
    ElseIf VLEfe_com35 > 0 Then
       VGFormaPago = "EFE;" & Format(VLEfe_com35, "#0.00")
    ElseIf VLChq_com35 > 0 Then
       VGFormaPago = "CHE;" & Format(VLChq_com35, "#0.00")
    ElseIf VLDeb_com35 > 0 Then
       VGFormaPago = "DEB;" & Format(VLDeb_com35, "#0.00")
    End If
    'LBP Fin RECA-CC-SGC00025869 30/07/2016
     
     PMPasoValoresATX VGSqlConn, "@o_nota_venta", 1, SQLVARCHAR, VLSerie_Secuencia, "Nota_venta", "" 'hy-24-feb-2005
    'End If
    '-->hy
    PMPasoValoresATX VGSqlConn, "@i_nomprop", 0, SQLVARCHAR, TxtNomProp.Text, "nomprop", ""
    PMPasoValoresATX VGSqlConn, "@i_compro", 0, SQLINT4, txtMCN.Text, "SecTrn", ""
    PMPasoValoresATX VGSqlConn, "@i_motor", 0, SQLVARCHAR, txtMotor.Text, "motor", ""
    PMPasoValoresATX VGSqlConn, "@i_chasis", 0, SQLVARCHAR, txtChasis.Text, "chasis", ""
    PMPasoValoresATX VGSqlConn, "@i_fisco", 0, SQLMONEY, Total.Text, "fisco", ""
    PMPasoValoresATX VGSqlConn, "@i_avaluo", 0, SQLMONEY, Avaluo.Text, "avaluo", ""
    PMPasoValoresATX VGSqlConn, "@i_valor", 0, SQLMONEY, Contrato.Text, "Valor", ""
    PMPasoValoresATX VGSqlConn, "@i_cedruc", 0, SQLCHAR, cedula.Text, "Cedula", ""
    PMPasoValoresATX VGSqlConn, "@i_propietario", 0, SQLVARCHAR, TxtNomProp.Text, "Propietario", ""
    
    If VGTipoEjecucion% <> CGReverso% Then
        '-->hy-13-dic-2005
        PMPasoValoresATX VGSqlConn, "@i_cod_vehiculo", 0, SQLVARCHAR, VLCodigoVehiculo, "CodVehiculo", ""
        PMPasoValoresATX VGSqlConn, "@i_mcn", 0, SQLVARCHAR, VLtxtMCN, "MCN", ""
        PMPasoValoresATX VGSqlConn, "@i_tranrevsri", 0, SQLVARCHAR, VLtxtTranRevSri, "Tranrevsri", ""
        PMPasoValoresATX VGSqlConn, "@i_logrevsri", 0, SQLVARCHAR, VLtxtLogRevSri, "Logrevsri", ""
        '<--hy-13-dic-2005
    Else
        PMPasoValoresATX VGSqlConn, "@i_cod_vehiculo", 0, SQLVARCHAR, txtCodVehiculo.Text, "CodVehiculo", ""
        PMPasoValoresATX VGSqlConn, "@i_mcn", 0, SQLVARCHAR, txtMCN.Text, "MCN", ""
        PMPasoValoresATX VGSqlConn, "@i_tranrevsri", 0, SQLVARCHAR, txtTranRevSri.Text, "Tranrevsri", ""
        PMPasoValoresATX VGSqlConn, "@i_logrevsri", 0, SQLVARCHAR, txtLogRevSri.Text, "Logrevsri", ""
    End If
    '<--hy
    
'PARAMETROS CPS
    If VGTipoEjecucion% = CGReverso% Then
        VLSecTrnCorr = DatoSwitch("@o_ssn")
        PMPasoValoresATX VGSqlConn, "@o_ptranidrevifi", 0, SQLFLT8&, VLSecTrnCorr, "Ppni_id_tran_reverso_ifi", ""
        'PMPasoValoresATX VGSqlConn, "@t_ssn_corr1", 0, SQLINT4, Str(VLSecTrnCorr), "", "", True 'Reverso banco
    End If
    PMPasoValoresATX VGSqlConn, "@i_pcodcanalpagifi", 0, SQLVARCHAR, "VENTANILLA", "Ppsi_cod_canal_pago_ifi", ""
    PMPasoValoresATX VGSqlConn, "@i_pfeccontifi", 0, SQLVARCHAR, Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2), "Ppsio_fecha_contable_ifi", ""
    PMPasoValoresATX VGSqlConn, "@i_pprovifi", 0, SQLVARCHAR, Trim$(VLProvincia), "Ppsi_provincia_ifi", ""
    PMPasoValoresATX VGSqlConn, "@i_ptipodeuda", 0, SQLVARCHAR, "TRANSF_DOM", "Ppsi_tipo_deuda", ""
    VLValorPagar = Trim$(str$(CDbl(Total.Text) * 100))
    PMPasoValoresATX VGSqlConn, "@i_pvaltotpag", 0, SQLFLT8, CDbl(VLValorPagar), "Ppsi_tipo_tran", ""
    PMPasoValoresATX VGSqlConn, "@o_plogsri", 1, SQLVARCHAR, "0", "", ""
    PMPasoValoresATX VGSqlConn, "@o_pmcn", 1, SQLINT4, "0", "", ""
    PMPasoValoresATX VGSqlConn, "@o_precibo", 1, SQLINT4, "0", "", ""
  If FMTransmitirRPCATX(VGSqlConn, "PSSRV1", "cob_procesador", "sp_pago_trans_dominio", True, "Transaccion Ok", "S", "N", "S", "35", "S", "S") = True Then
'  If FMTransmitirRPCATX(VGSqlConn, "", "cob_servicios", "sp_imp_x_transfer_dominio_rc", True, "Transaccion Ok", "S", "N", "N", "35", "S", "S") = True Then 'lbp
        ReDim psRetorno(2, 22)
        FMMapeaMatriz VGSqlConn, psRetorno
        PMMapeaGrid VGSqlConn, grdGrid, False
        VLLogSri = FMRetParamATX(VGSqlConn, 14)   'Log SRI
        VLLogSri = Trim(VLLogSri)
        VLMCN = FMRetParamATX(VGSqlConn, 15)  'MCN
        VLMCN = Trim(VLMCN)
        VLRecibo = FMRetParamATX(VGSqlConn, 16)    'Recibo
        VLRecibo = Trim(VLRecibo)
        'TxtNomProp.Text = Mid$(FMRetParamATX(VGSqlConn, 1), 1, 35)
        If Len(Cta.ClipText) <> 0 Then
            TxtNomCta.Text = FMRetParamATX(VGSqlConn, 2)
        End If
        'Comprobante = FMRetParamATX(VGSqlConn, 4)
        'motor = FMRetParamATX(VGSqlConn, 5)
        'chasis = FMRetParamATX(VGSqlConn, 6)
        'Avaluo = FMRetParamATX(VGSqlConn, 7)
        'Contrato = FMRetParamATX(VGSqlConn, 8)
        'Cedula = FMRetParamATX(VGSqlConn, 9)
        'mskfechacont.Text = Format$(FMRetParamATX(VGSqlConn, 10), VGFormatoFecha$)
        VLautoriSri = FMRetParamATX(VGSqlConn, 12)
        VLautoriSri = Trim(VLautoriSri)
        VLFecvenSRI = FMRetParamATX(VGSqlConn, 13)
        VLFecvenSRI = Trim(VLFecvenSRI)
        VLSerie_Secuencia = FMRetParamATX(VGSqlConn, 14)  'hy-24-feb-2005
        VLSerie_Secuencia = Trim(VLSerie_Secuencia)
'        VLtxtLogRevSri = VLMCN
'        txtLogRevSri.Text = VLtxtLogRevSri
        If VGTipoEjecucion = CGNormal Then
            VLtxtLogRevSri = VLMCN
            txtLogRevSri.Text = VLtxtLogRevSri
        Else
            VLMCN = txtLogRevSri.Text
            VLLogSri = txtLogRevSri.Text
            VLtxtLogRevSri = txtLogRevSri.Text
        End If
        
        '-->hy comentar
        'If VGTipoEjecucion% = CGNormal% Then
        '    Efectivo.Enabled = True
        '    CantChq.Enabled = True
        '    Cheque.Enabled = True
         '   CboTipCta.Enabled = True
         '   Cta.Enabled = True
         '   Debito.Enabled = True
         '   Tarjeta.Enabled = True
        'End If
        '<--hy
        'TPE ------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 11)
        VTIndicadorSum = 1
        PMIniciaRegSum
        '<-----
        
        PMChequeaATX VGSqlConn
        FLTransmitir = True
        VLCambio% = False
    Else
        'TPE ------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 11)
        VTIndicadorSum = 0
        '<------
        
        TxtNomCta.Text = ""
        VLCambio% = True
        FLTransmitir = False
    End If
    PMChequeaATX VGSqlConn
    If FMRetStatusATX(VGSqlConn) <> 0 Then
        On Error Resume Next
        Matricula.SetFocus
        FLTransmitir = False
        VTIndicadorSum = 0
    End If
    PMFinTransaccion
    
    'ame 08/04/2010
    If FLTransmitir = True Then
       'JPM Lectora de Billetes -->
       If CCur(Efectivo.Text) > 0 And ((VGDatPersBillAltDen.dataOK And VGTipoEjecucion = CGNormal%) Or VGTipoEjecucion = CGReverso%) Then
         'Call PMGuardarDsglsBillete("35", SGSecTrn$, VLTrn, rptBAD, CboTipCta.Text, Cta.ClipText)
         Call PMGuardarDsglsBillete("35", SGSecTrn$, VLTrn, rptBAD, "REC", "")
       End If
       '<-- JPM Lectora de Billetes
       Call PLFactura
    End If

    
    If VGTipoEjecucion% <> CGReverso% Then   'Validacion por REVERSO
        If (VTIndicadorSum = 1 And (Trim$(VGStatusCon) = "A" Or Trim$(VGStatusCon) = "")) Then
            SGPrimeraVez = 0            ' ya no es primera vez
            PMGrabaDesglose VLTrn, CStr(SGUsar), VLCambio%
            If VLCambio% = True Then
                MsgBox "Error en la Grabacion del Desglose. Favor comuniquese con su Supervisor.", vbCritical, "Error de Sistema"
            End If
            SGActual = 1                'seteo Variable para borrar desglose
        ElseIf VTIndicadorSum = 0 Then
            SGActual = 0               'no borrar desglose en caso de Error en Transaccion
        End If
    ElseIf VTIndicadorSum = 1 Then       'Por REVERSO
        PMEgresoEfectivo SGUsar, VLTrn, VGSSNCorr&
    End If
    '<-----
  
End Function
   
Private Sub CantChq_KeyDown(KeyCode As Integer, Shift As Integer)
Select Case KeyCode%
    Case CGTeclaSUPR%
      CantChq.Text = ""
    Case CGTeclaHOME%
      PMCambiarForma Me
    Case CGTeclaUP%, CGTeclaREPAG%
       Efectivo.SetFocus
    Case CGTeclaDOWN%, CGTeclaAVPAG%
       SendKeys "{TAB}"
   End Select
End Sub

Private Sub CboTipCta_Click()
    VLfirma = False
End Sub

Private Sub CboTipCta_GotFocus()
  FPrincipal!pnlHelpLine.Caption = "CTE|Cta Corrientes,  AHO|Cta de Ahorros"
End Sub


Private Sub CboTipCta_KeyDown(KeyCode As Integer, Shift As Integer)
  Select Case KeyCode%
    Case CGTeclaENTER%
      SendKeys "{TAB}"
    Case CGTeclaUP%, CGTeclaREPAG%
      Cheque.SetFocus
    Case CGTeclaDOWN%, CGTeclaAVPAG%
      SendKeys "{TAB}"
    End Select
End Sub

Private Sub Comision_GotFocus()
FPrincipal!pnlHelpLine.Caption = "F5 Detalle de Comision"
End Sub

Private Sub Comision_KeyDown(KeyCode As Integer, Shift As Integer)
'-- implementacion del campo comision -- PS 23/01/2004
VLValidaEfeCom = 0#  'hy-13-dic-2005
 If KeyCode% = CGTeclaF5% Then
    If Comision <> 0# Then
        '-- inicializo variables
       SGComision = 0#   'PS 29/01/2004
       SGTipoCta = ""    'PS 29/01/2004
       SGCedula = ""     'PS 29/01/2004

       VLAcum35 = SGAcumulado
       
        VGUsar15 = Efectivo.ValueReal
       
       SGUsar = VLEfe_com35
       
        'msilvag:Inicio RECA-CC-SGC00030409 - Facturacion OffLine Debitos
        SGNumCuenta = Me.Cta.Text
        SGEmpresa = "SRIDOMI"
        'msilvag Fin
       
       SGComision = Comision
       SGTipoCta = CboTipCta.ListIndex
       SGCedula = ""
       SGValida = "S"
       FCC112.Show 1
       VLEfe_com35 = FCC112.VLEfe_com
       VLChq_com35 = FCC112.VLChq_com
       VLDeb_com35 = FCC112.VLDeb_com
       VLTipCta_com35 = FCC112.VLTipCta_com
       VLCta_com35 = FCC112.VLCta_com
       VLTotCom35 = VLEfe_com35 + VLChq_com35 + VLDeb_com35
       
       VLValidaEfeCom = VLEfe_com35  'hy-13-dic-2005
       
       VLNombre = SGNombre
       
       SGUsar = VGUsar15
       Efectivo.ValueReal = SGUsar

       SGAcumulado = VLAcum35
       VGUsar15 = VLEfe_com35
    End If
  End If
  
  If KeyCode% = CGTeclaENTER% Then
      SendKeys "{TAB}"
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
  FPrincipal!pnlHelpLine.Caption = Cta.HelpLine
End Sub


Private Sub Cta_KeyDown(KeyCode As Integer, Shift As Integer)
  Select Case KeyCode%
    Case CGTeclaSUPR%
      If Cta.Enabled Then
         Cta.Clear
      End If
    Case CGTeclaUP%, CGTeclaREPAG%
      CboTipCta.SetFocus
    Case CGTeclaDOWN%, CGTeclaAVPAG%
      SendKeys "{TAB}"
  End Select
End Sub


Private Sub Cta_LostFocus()
    Dim VTipoDatoCta As StructDatoCta   'jlf  05AGO2006  PARA TRAER EL NOMBRE DE LA CTA
    VLfirma = FMValidaFirma(VLfirma, CboTipCta.Text, Cta, "35", TxtNomCta, VLMoneda, VLDescMonCta)
    lblMoneda.Caption = VLDescMonCta
    
    VTipoDatoCta = LoNombreCta(CboTipCta.Text, Cta.ClipText, "35")  'jlf  05AGO2006  PARA TRAER EL NOMBRE DE LA CTA
    TxtNomCta = VTipoDatoCta.NombreCta
End Sub

Private Sub Cheque_Change()
  VLCambio% = True
End Sub


Private Sub Cheque_GotFocus()
  FPrincipal!pnlHelpLine.Caption = "Ingrese Valor en cheque a cancelar"
End Sub


Private Sub Cheque_KeyDown(KeyCode As Integer, Shift As Integer)
  Select Case KeyCode%
   Case CGTeclaSUPR%
      Cheque.Text = ""
    Case CGTeclaENTER%
      SendKeys "{TAB}"
    Case CGTeclaMAS%
      Cheque.Text = FMCalculadora(FMObtenerTitulo("35") + "Cheque:", 14, "35")
      SendKeys "{TAB}"
    Case CGTeclaPOR%
      Cheque.Text = FMSumadora(FMObtenerTitulo("35") + "Cheque:", 14, "35")
    Case CGTeclaHOME%
      PMCambiarForma Me
    Case CGTeclaUP%, CGTeclaREPAG%
      Efectivo.SetFocus
    Case CGTeclaDOWN%, CGTeclaAVPAG%
      SendKeys "{TAB}"
  End Select
End Sub

Private Sub Cheque_KeyPress(KeyAscii As Integer)
  KeyAscii = FMValidarNumero((Cheque.Text), VGLongitudMoney, KeyAscii, "35")
End Sub

Private Sub Cheque_LostFocus()
  If VGDecimales$ = "S" And (FMObtenerDecimales(FMObtenerMonedaForma("35")) > 0) Then
    Cheque.Text = str(FMCCurATX((Cheque.Text)) / FMObtenerFactorDecimal(FMObtenerMonedaForma("35")))
  End If
  If VGTotalizar$ = "S" Then
    If Cheque.Text <> "" Or Cheque.Text <> "0.00" Then
      Total.Text = str(FMCCurATX((Efectivo.Text)) + FMCCurATX((Cheque.Text)) + FMCCurATX((Debito.Text)))
    End If
  End If
End Sub


Private Sub Debito_Change()
  VLCambio% = True
End Sub


Private Sub Debito_GotFocus()
  FPrincipal!pnlHelpLine.Caption = "Ingrese Valor a debitar de la cuenta"
End Sub


Private Sub Debito_KeyDown(KeyCode As Integer, Shift As Integer)
  Select Case KeyCode%
    Case CGTeclaSUPR%
      Debito.Text = ""
    Case CGTeclaENTER%
      SendKeys "{TAB}"
    Case CGTeclaMAS%
      Debito.Text = FMCalculadora(FMObtenerTitulo("35") + "Debito:", 14, "35")
      SendKeys "{TAB}"
    Case CGTeclaPOR%
      Debito.Text = FMSumadora(FMObtenerTitulo("35") + "Debito:", 14, "35")
    Case CGTeclaHOME%
      PMCambiarForma Me
    Case CGTeclaUP%, CGTeclaREPAG%
      Cta.SetFocus
    Case CGTeclaDOWN%, CGTeclaAVPAG%
      SendKeys "{TAB}"
  End Select
End Sub

Private Sub Debito_KeyPress(KeyAscii As Integer)
  KeyAscii = FMValidarNumero((Debito.Text), VGLongitudMoney, KeyAscii, "35")
End Sub

Private Sub Debito_LostFocus()
  If VGDecimales$ = "S" And (FMObtenerDecimales(FMObtenerMonedaForma("35")) > 0) Then
     Debito.Text = str(FMCCurATX((Debito.Text)) / FMObtenerFactorDecimal(FMObtenerMonedaForma("35")))
  End If
  If VGTotalizar$ = "S" Then
    If Debito.Text <> "" Or Debito.Text <> "0.00" Then
      Total.Text = str(FMCCurATX((Efectivo.Text)) + FMCCurATX((Cheque.Text)) + FMCCurATX((Debito.Text)))
    End If
  End If
End Sub

Private Sub Efectivo_Change()
  VLCambio% = True
End Sub


Private Sub Efectivo_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Ingrese Valor en efectivo a cancelar"
    'Sumadora ----->
    If SGActivaSum = False Then
        FSumIng.abrirAltaDenominacion = True
       PMIngresoEfectivo
       Efectivo.Text = Format$(SGUsar, "####,###,##0.00")
       SGActual = 0
       SGActivaSum = True
       'SendKeys "{TAB}"
    Else
        SGActivaSum = False
    End If
    '<-------

End Sub


Private Sub Efectivo_KeyDown(KeyCode As Integer, Shift As Integer)
  Select Case KeyCode%
   Case CGTeclaSUPR%
      Efectivo.Text = ""
    Case CGTeclaENTER%
      SendKeys "{TAB}"
    Case CGTeclaMAS%
      Efectivo.Text = FMCalculadora(FMObtenerTitulo("35") + "Efectivo:", 14, "35")
      SendKeys "{TAB}"
    Case CGTeclaPOR%
      Efectivo.Text = FMSumadora(FMObtenerTitulo("35") + "Efectivo:", 14, "35")
    Case CGTeclaHOME%
      PMCambiarForma Me
    Case CGTeclaUP%, CGTeclaREPAG%
      Matricula.SetFocus
    Case CGTeclaDOWN%, CGTeclaAVPAG%
      SendKeys "{TAB}"
  End Select
End Sub

Private Sub Efectivo_KeyPress(KeyAscii As Integer)
  KeyAscii = FMValidarNumero((Efectivo.Text), VGLongitudMoney, KeyAscii, "35")
End Sub


Private Sub Efectivo_LostFocus()
  If SGActivaSum = True Then
    Exit Sub
  End If
  
  If VGDecimales$ = "S" And (FMObtenerDecimales(FMObtenerMonedaForma("35")) > 0) Then
    Efectivo.Text = str(FMCCurATX((Efectivo.Text)) / FMObtenerFactorDecimal(FMObtenerMonedaForma("35")))
  End If
  If VGTotalizar$ = "S" Then
    If Efectivo.Text <> "" Or Efectivo.Text <> "0.00" Then
      Total.Text = str(FMCCurATX((Efectivo.Text)) + FMCCurATX((Cheque.Text)) + FMCCurATX((Debito.Text)))
    End If
  End If
  
  'Sumadora ------>
    If CDbl(Efectivo.Text) <> SGUsar Then
        MsgBox "El Monto Efetivo No Coincide con el Monto Desglosado para el Deposito. Verificar", vbCritical, "Mensaje del Sistema"
        FSumIng.abrirAltaDenominacion = True
        PMIngresoEfectivo
        Efectivo.Text = Format$(SGUsar, "####,###,##0.00")
        SGActual = 0
    End If
    SGActivaSum = False
  '<------
End Sub

Private Sub Form_Activate()
    'TPE05/16/2006 Al Activar la forma debe colocar sumadora en Moneda de la forma
    If SGMonedaTran <> VGmoneda% _
    And VGmoneda% <> 0 Then
        SGMonedaTran = VGmoneda%
        PMCargaIniSumadora VGmoneda%
        PMIniciaIngreso 1
    End If
    
    If Matricula.Enabled Then
        FMPasoControl Matricula
    End If
    If VGTipoEjecucion% <> CGReverso% _
    And CCur(Efectivo.Text) <> 0 _
    And VGTran = "03" Then
        SGUsar = Efectivo.Text
    End If
    VGTran = 0
    
    'LBP Inicio RECA-CC-SGC00025869 30/07/2016
    VGFormaPago = ""
    VGCom_aux = 0
    VGComision_original = 0
    VGCompensacion = 0
    VGPorcentajeComp = "0"
    VGPorcentajeIVA = "0"
    'LBP Fin 30/07/2016'Fin LBP
    
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
 If Shift = CGTeclaCTRL% + CGTeclaALT% And KeyCode% = CGTeclaF9% Then
    PMObtenerMonedaForma "35"
    Exit Sub
 End If
 If Shift = CGTeclaCTRL% And KeyCode% = CGTeclaI% Then
    PMReimpresion
    Exit Sub
 End If
 If Shift = CGTeclaCTRL% And KeyCode% = CGTeclaF2% Then
   If VGTipoEjecucion% = CGNormal% Then
     PMSetEjecucionReverso
     If FMSupervisor("35") = True Then
       If FMSecuencialReverso() = False Then
         PMSetEjecucionNormal
         Exit Sub
       End If
       PLTransmitir
     End If
     PMSetEjecucionNormal
     Exit Sub
   End If
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
        SGUsar = Efectivo.ValueReal + VLEfe_com35
        PLTransmitir
     End If
   Case CGTeclaESC%
     'TPE variable para validacion de Cod Cuenta
     VLCta = ""
     Unload Me
   Case CGTeclaHOME%
     PMCambiarForma Me
    Case CGTeclaF2%
        VLMoneda = VGmoneda%
        VLDescMonCta = ""
        lblMoneda = ""
        SGNumCuenta = ""
        SGEmpresa = ""
    
        If VGTipoEjecucion% <> CGNormal% Then
           Exit Sub
        End If
        VLfirma = False
        'TPE 06/19/2003 inicio variable de Validación
        VLCta = ""
        Matricula.Enabled = True
        If Matricula.Enabled Then
          Matricula.SetFocus
        End If
        Matricula.Clear
        cedula.Text = ""
        CantChq.Text = ""
        Contrato = "0.00"
        Efectivo.Text = "0.00"
        Cheque.Text = "0.00"
        CboTipCta.ListIndex = 0
        Cta.Clear
        Debito.Text = "0.00"
        Tarjeta.Text = "0.00"
        Total.Text = "0.00"
        TotPago.Text = "0.00"
        Avaluo.Text = "0.00"
        TxtNomCta.Text = ""
        TxtNomProp.Text = ""
        mskfechacont.Clear
        Efectivo.Enabled = False
        CantChq.Enabled = False
        Cheque.Enabled = False
        CboTipCta.Enabled = False
        Cta.Enabled = False
        Debito.Enabled = False
        Tarjeta.Enabled = False
        Avaluo.Enabled = False
        Contrato.Enabled = False
        cedula.Enabled = False
        mskfechacont.Enabled = False
    
        '-- inicializa variables para la comision -- PS 23/01/2004
        VLAcum35 = 0#
        VLTotCom35 = 0#
        VLEfe_com35 = 0#
        VLChq_com35 = 0#
        VLDeb_com35 = 0#
        VLCta_com35 = ""
        VLTipCta_com35 = ""
        
        'LBP Inicio RECA-CC-SGC00025869 30/07/2016
        VGFormaPago = ""
        VGCom_aux = 0
        VGComision_original = 0
        VGCompensacion = 0
        VGPorcentajeComp = "0"
        VGPorcentajeIVA = "0"
        'LBP Fin 30/07/2016'Fin LBP
        
        VLValidaEfeCom = 0#  'hy-13-dic-2005
    
        VGAutoriza = "N"
        PMLimpiarTransaccion "35"
     
        '------> Sumadora
        SGUsar = 0
        VGUsar15 = 0
        If Shift = 0 _
        And VGTipoConsAutom% = 0 _
        And VGTipoEjecucion% <> CGReverso% Then  'TPEAdiciono Validacion Por Consulta Automatica y Reverso
            SGActual = 1
            FSumIng.Hide
            FSumIng.Form_KeyDown CGTeclaF2%, 0
            Matricula.SetFocus
        End If
        SGActivaSum = False
        '<------
        lectoraBill.Limpiar     'JPM Lectora de Billetes
   Case CGTeclaF3%
     If Matricula.Text = "" Then
        Exit Sub
     End If
     'Unload Me
     'Sumadora ------>
     If VGTipoEjecucion% <> CGReverso% Then
        If (VGTipoConsAutom% = 1 And VGStatusCon = "A") Or VGTipoConsAutom% = 0 Then
                FSumIng.abrirAltaDenominacion = True
                PMIngresoEfectivo
                SGActual = 0
                Efectivo.Text = SGUsar
                If Efectivo.Enabled Then
                   Efectivo.SetFocus
                End If

        End If
     End If
     '<------
     
   Case CGTeclaF4%
     If Cta.ClipText <> "" Then
        If FMfirmas((Cta.ClipText), CboTipCta.Text, FMCCurATX((Total.Text))) = False Then
           Cta.SetFocus
           Exit Sub
        End If
        Debito.SetFocus
     End If
     
   Case CGTeclaF5%
     If Not Matricula.Enabled Then
        Exit Sub
     End If
     If Len(Matricula.Text) = 0 Then
        MsgBox "El campo Matricula: es Mandatorio"
        Matricula.SetFocus
     Else
        If VLCambioMatri% = True Then
            Efectivo.Text = "0.00"
            Cheque.Text = "0.00"
            Cta.Clear
            Debito.Text = "0.00"
            Tarjeta.Text = "0.00"
            Total.Text = "0.00"
            TotPago.Text = "0.00"
            Avaluo.Text = "0.00"
            TxtNomCta.Text = ""
            TxtNomProp.Text = ""
            PMLimpiarTransaccion "35"
            
            'CAMBIOS POR CPS
            'If Not FLTramaSwitch("C") Then
            'If FLConsTransDom() = False Then
            If FLConsTransDom_MS() = False Then
                If Trim$(txtmensaje.Text) <> "" Then
                    MsgBox txtmensaje.Text, vbInformation, "Mensaje del sri"
                End If
                Me.Enabled = True
                Exit Sub
            End If
            Me.Enabled = True
            Frame.Enabled = True
            Total.Enabled = False
            'If FLConsMatricula() = True Then
               Efectivo.Enabled = True
               Efectivo.SetFocus
               CantChq.Enabled = True
               Cheque.Enabled = True
               Tarjeta.Enabled = True
               Debito.Enabled = True
               CboTipCta.Enabled = True
               Cta.Enabled = True
            'End If
        End If
     End If

  Case CGTeclaF9%
    If VGTipoEjecucion% = CGNormal% Then
       If FMSupervisor("35") = True Then
          If Trim(str(FMObtenerMonedaForma("35"))) = "1" Then
             moneda = "DOLAR"
          Else
             moneda = "SUCRES"
          End If
          PMMsgError "ESTA AUTORIZANDO UN MONTO DE:      " + Total.Text + " " + moneda, "", CGErrorInformativo
          If FMSupervisor("35") = True Then
             VGAutoriza = "S"
          End If
       End If
    End If
    If Matricula.Enabled Then
       Matricula.SetFocus
    End If
     
 End Select
End Sub

Private Sub Form_Load()
  'CGLongTramaBill = CadenaLarga   'JPM lectora de billetes
  CGLongTramaBill = CadenaCorta    'JPM lectora de billetes
  lectoraBill.Limpiar             'JPM lectora de billetes
  VLCambio% = False
  VLfirma = False
  VLCambioMatri% = False
  Me.Move VGLeft%, VGTop%, 4750, 5900
  
  'Sumadora  ----->
  SGUsar = 0
  SGActivaSum = False
  SGActual = 1
  '<-----
  'Inicio Moneda
  VLMoneda = VGmoneda%
    
  VLTotCom35 = 0#           ' ps 23/01/2004
  VLEfe_com35 = 0#          ' ps 23/01/2004
  VLChq_com35 = 0#          ' ps 23/01/2004
  VLDeb_com35 = 0#          ' ps 23/01/2004
  VLCta_com35 = ""          ' ps 23/01/2004
  VLTipCta_com35 = ""       ' ps 23/01/2004
  SGNumCuenta = ""
  SGEmpresa = ""
  
    'LBP Inicio RECA-CC-SGC00025869 30/07/2016
    VGFormaPago = ""
    VGCom_aux = 0
    VGComision_original = 0
    VGCompensacion = 0
    VGPorcentajeComp = "0"
    VGPorcentajeIVA = "0"
    'LBP Fin 30/07/2016'Fin LBP
 
  CboTipCta.AddItem "CTE"
  CboTipCta.AddItem "AHO"
  CboTipCta.ListIndex = 0
  
  Efectivo.Enabled = False
  CantChq.Enabled = False
  Cheque.Enabled = False
  CboTipCta.Enabled = False
  Cta.Enabled = False
  Debito.Enabled = False
  Tarjeta.Enabled = False
  Avaluo.Enabled = False
  Contrato.Enabled = False
  cedula.Enabled = False
  mskfechacont.Enabled = False
   
  Efectivo.DecimalPlaces = FMObtenerDecimales(VGmoneda%)
  Cheque.DecimalPlaces = FMObtenerDecimales(VGmoneda%)
  Debito.DecimalPlaces = FMObtenerDecimales(VGmoneda%)
  Tarjeta.DecimalPlaces = FMObtenerDecimales(VGmoneda%)
  Total.DecimalPlaces = FMObtenerDecimales(VGmoneda%)
  TotPago.DecimalPlaces = FMObtenerDecimales(VGmoneda%)
  moneda = str(VGmoneda%)
      
  If VGTipoEjecucion% = CGReverso% Or VGTipoEjecucion% = CGAutoriza% Then
     If VGTipoEjecucion% = CGReverso% Then
     
        'Sumadora ----->
        SGPrimeraVezRev = 0
        '<----------
        
        PMSetValorReverso Comision, "@e_comision_efe"
        VLEfe_com35 = Comision.ValueReal
        PMSetValorReverso Comision, "@e_comision_chq"
        VLChq_com35 = Comision.ValueReal
        PMSetValorReverso Comision, "@e_comision_db"
        VLDeb_com35 = Comision.ValueReal
        VLTotCom35 = VLEfe_com35 + VLChq_com35 + VLDeb_com35
        Comision = VLTotCom35
        
        PMSetValorReverso Cta, "@e_cuenta"
        'PMSetValorReverso Cta, "@i_cta_com"
        VLCta_com35 = Cta.ClipText
        
        PMSetValorReverso CboTipCta, "@e_tipocta"
        'PMSetValorReverso CboTipCta, "@i_tipocta_com"
        VLTipCta_com35 = CboTipCta.Text

        PMSetValorReverso Matricula, "@e_identificacion" '"@i_matricula"
        PMSetValorReverso Efectivo, "@e_efectivo" '"@i_efe"
        PMSetValorReverso CantChq, "@e_cant_cheques" '"@i_cant_chq"
        PMSetValorReverso Cheque, "@e_cheque" '"@i_cheq"
        PMSetValorReverso CboTipCta, "@e_tipocta" '"@i_tipocta"
        PMSetValorReverso Cta, "@e_cuenta" '"@i_cuenta"
        PMSetValorReverso Debito, "@e_debito" '"@i_deb"
        PMSetValorReverso Tarjeta, "@e_tarjeta" '"@i_tarjeta"
        PMSetValorReverso Total, "@e_total" '"@i_total"
        PMSetValorReverso moneda, "@e_moneda" '"@i_mon"
        PMSetValorReverso cedula, "@e_cedula" '"@o_cedruc"
        PMSetValorReverso Contrato, "@e_contrato" '"@o_valor"
        PMSetValorReverso Avaluo, "@e_avaluo"
        
      '-->hy-24-feb-2005
      'PMSetValorReverso txtNotaVenta, "@o_nota_venta"
      'VLSerie_Secuencia = txtNotaVenta.Text
      '<--hy-24-feb-2005
        
      '-->hy
      'PMSetValorReverso txtMCN, "@i_mcn"
      'PMSetValorReverso txtCodVehiculo, "@i_cod_vehiculo"
      'PMSetValorReverso txtTranRevSri, "@i_tranrevsri"
      'PMSetValorReverso txtLogRevSri, "@o_plogsri"
      PMSetValorReverso TxtNomProp, "@e_nombre" '@i_propietario"
      'PMSetValorReverso txtMotor, "@i_motor"
      PMSetValorReverso txtChasis, "@e_chasis" '"i_chasis"
      '<--hy
        
        'PMSetValorReverso mskfechacont, "@o_fecha_contrato"         'GYC 2002/ABR/08
        'mskfechacont.Text = Format$(mskfechacont.Text, VGFormatoFecha$)
        
        SGUsar = CDbl(Efectivo.Text) + CDbl(VLEfe_com35) ' RCA 07/10/2003
        TotPago.Text = CDbl(Total.Text) + CDbl(Comision.Text)
     End If
  End If
  If moneda = 0 Then
     bitmap.Picture = LoadPicture(VGDirBitmaps$ & "\sucres.bmp")
     Frame = Space(15) + "TRANSFER. DOMINIO SUCRES"
     LblTipCta.Enabled = False
     CboTipCta.Enabled = False
     LblCuenta.Enabled = False
     Cta.Enabled = False
     LblDebito.Enabled = False
     Debito.Enabled = False
  Else
     bitmap.Picture = LoadPicture(VGDirBitmaps$ & "\dolares.bmp")
     Frame = Space(15) + "TRANSFER. DOMINIO DOLARES"
  End If
  bitmap.Visible = True
  Total.Enabled = False
  VLValidaEfeCom = 0#  'hy-13-dic-2005

    If Not (VGMatrizSwitchFlagSRI) Then
        VGDatosConexionSRI = FMParametroUpLoadDll("IPSW", "CTE")
        VGMatrizSwitchFlagSRI = True
    End If

End Sub


Private Sub Form_Unload(Cancel As Integer)
  VGUsar15 = 0
  PMCerrarForma "35"
  FPrincipal!pnlHelpLine.Caption = ""
  lectoraBill.Limpiar     'JPM lectora de billetes
End Sub

Private Sub Matricula_Change()
  VLCambio% = True
  VLCambioMatri% = True
End Sub

Private Sub Matricula_GotFocus()
  FPrincipal!pnlHelpLine.Caption = Matricula.HelpLine
End Sub


Private Sub Matricula_KeyDown(KeyCode As Integer, Shift As Integer)
  Select Case KeyCode%
     Case CGTeclaSUPR%
       If Matricula.Enabled Then
          Matricula.Text = ""
       End If
     Case CGTeclaUP%, CGTeclaREPAG%
        KeyCode = 0
     Case CGTeclaDOWN%, CGTeclaAVPAG%
        SendKeys "{TAB}"
  End Select
End Sub

Private Sub Matricula_LostFocus()
'-- obtiene el valor de la comision -- PS 26/01/2004
 ' PMInicioTransaccion
 ' PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "cl_costo_serv_comision", "", ""
  'PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR&, "V", "", ""
 ' PMPasoValoresATX VGSqlConn&, "@i_codigo", 0, SQLCHAR&, "TRANDOM", "", ""
 ' If FMTransmitirRPCATX(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "", "N", "S", "I", "0", "N", "N") Then
  '  PMMapeaObjetoATX VGSqlConn&, Comision
    'TotPago.Text = CDbl(Total.Text) + CDbl(Comision)
   ' PMChequeaATX VGSqlConn&
   ' PMFinTransaccion
 ' Else
   ' Comision = 0#
   ' PMChequeaATX VGSqlConn&
   ' PMFinTransaccion
 ' End If
  
  ' Comision = 0#
    'smerino aumenta comision
    'CONSULTA TASA DEL IVA Y BASE IMPONBLE
   PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 4050, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLVARCHAR, "C", "opcion", ""
    PMPasoValoresATX VGSqlConn, "@i_servi_person", 0, SQLVARCHAR, "SRI", "Servicio Person", ""
    PMPasoValoresATX VGSqlConn, "@i_rubro_person", 0, SQLVARCHAR, "TRDO", "Rubro Person", ""
    'PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "IBK", "Rubro Person", ""
    
    'Variables de salida
    PMPasoValoresATX VGSqlConn, "@o_comision", 1, SQLMONEY, 0, "Comision", ""
    'smerino
    PMPasoValoresATX VGSqlConn, "@o_tasa", 1, SQLMONEY, "0", "tasa", ""
    PMPasoValoresATX VGSqlConn, "@o_base_imp", 1, SQLMONEY, "0", "base_imp", ""
    PMPasoValoresATX VGSqlConn, "@o_impuesto", 1, SQLMONEY, "0", "impuesto", ""
    'smerino
    'MsgBox "Paso 2"
    'If FMTransmitirRPCATX(VGSqlConn&, "", "cob_pagos", "sp_val_servicios_varios", True, "", "N", "S", "I", "0", "N", "N") Then
    If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_val_servicios_varios", True, "Transaccion Ok", "S", "N", "N", "0", "S", "S") = True Then
    'If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_val_servicios_varios", True, "", "N", "S", "I", "0", "N", "N") = True Then
        'MsgBox "Paso 3"
        Comision.Text = FMRetParamATX(VGSqlConn, 1)
        VlbaseImp = FMRetParamATX(VGSqlConn, 3) 'smerino
        VLiva = FMRetParamATX(VGSqlConn, 4) 'smerino
        PMChequeaATX VGSqlConn&
        PMFinTransaccion
       'PMChequeaATX VGSqlConn&
       
         'LBP Inicio RECA-CC-SGC00025869
         If Comision.Text > 0 Then
            VGCom_aux = FMDevuelveComisionReal(Comision, False, 35)
            If VGCom_aux <> CDbl(Comision.Text) Then
                VGComision_original = Comision.Text
                Comision.Text = VGCom_aux
            Else
                VGComision_original = Comision.Text
            End If
         End If
        'LBP Fin RECA-CC-SGC00025869
        
        TotPago.Text = CDbl(Total.Text) + CDbl(Comision)
       
    Else
       Comision = 0#
       PMChequeaATX VGSqlConn&
       PMFinTransaccion
    End If

 'FIN DE BASE IMPONIBLE
 
 
  
  
  
End Sub

Private Sub Tarjeta_Change()
   VLCambio% = True
End Sub

Private Sub Tarjeta_GotFocus()
   FPrincipal!pnlHelpLine.Caption = "Ingrese Valor en Tarjeta de Crédito"
End Sub

Private Sub Tarjeta_KeyDown(KeyCode As Integer, Shift As Integer)
  Select Case KeyCode%
    Case CGTeclaSUPR%
      Tarjeta.Text = ""
    Case CGTeclaENTER%
      SendKeys "{TAB}"
    Case CGTeclaMAS%
      Tarjeta.Text = FMCalculadora(FMObtenerTitulo("35") + "Tarjeta:", 14, "35")
      'SendKeys "{TAB}"
    Case CGTeclaPOR%
      Tarjeta.Text = FMSumadora(FMObtenerTitulo("35") + "Tarjeta:", 14, "35")
    Case CGTeclaHOME%
      PMCambiarForma Me
    Case CGTeclaUP%, CGTeclaREPAG%
      Debito.SetFocus
    Case CGTeclaDOWN%, CGTeclaAVPAG%
      KeyCode = 0
    End Select
End Sub

Private Sub Total_Change()
  If VGTotalizar$ = "N" Then
     VLCambio% = True
  End If
End Sub


Private Sub Total_GotFocus()
  FPrincipal!pnlHelpLine.Caption = "Total a cancelar"
End Sub


Private Sub Total_KeyDown(KeyCode As Integer, Shift As Integer)
  Select Case KeyCode%
    Case CGTeclaSUPR%
      Total.Text = ""
    Case CGTeclaENTER%
      SendKeys "{TAB}"
    Case CGTeclaMAS%
      Total.Text = FMCalculadora(FMObtenerTitulo("35") + "Total Depositado:", 14, "35")
      SendKeys "{TAB}"
    Case CGTeclaPOR%
      Total.Text = FMSumadora(FMObtenerTitulo("35") + "Total Depositado:", 14, "35")
    Case CGTeclaHOME%
      PMCambiarForma Me
    Case CGTeclaUP%, CGTeclaREPAG%
      Debito.SetFocus
    Case CGTeclaDOWN%, CGTeclaAVPAG%
      SendKeys "{TAB}"
  End Select
End Sub


Private Sub Total_KeyPress(KeyAscii As Integer)
  KeyAscii = FMValidarNumero((Total.Text), VGLongitudMoney, KeyAscii, "35")
End Sub


Private Sub Total_LostFocus()
  If VGDecimales$ = "S" And (FMObtenerDecimales(FMObtenerMonedaForma("35")) > 0) Then
     Total.Text = str(FMCCurATX((Total.Text)) / FMObtenerFactorDecimal(FMObtenerMonedaForma("35")))
  End If
  If VGTotalizar$ = "S" Then
    If Total.Text <> "" Or Total.Text <> "0.00" Then
       Total.Text = str(FMCCurATX((Efectivo.Text)) + FMCCurATX((Cheque.Text)) + FMCCurATX((Debito.Text)))
    End If
  End If
End Sub

Function FLSecuencias() As Boolean 'hy-13-dic-2005 cambiar integer por boolean
Dim VTIndicadorSum As Integer
Dim VLTipoEjecucion As Integer
    
    VLTipoEjecucion = VGTipoEjecucion
    VGTipoEjecucion = CGNormal
    
    VTIndicadorSum = 0
    
    '-->hy-13-dic-2005
    VLSsn = ""
    VLFecHora = ""
    VLFecContable = ""
    VLProvincia = ""
    VLTerminal = ""
'    VLtxtMCN = ""
'    VLtxtCodVehiculo = ""
    VLtxtTranRevSri = ""
    VLtxtLogRevSri = ""
    '<--hy-13-dic-2005
    
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, "3295", "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLVARCHAR, "L", "Opcion", ""
    PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, "0", "SecTrn", ""
    PMPasoValoresATX VGSqlConn, "@o_fechora", 1, SQLVARCHAR, Space(16), "fechora", ""
    PMPasoValoresATX VGSqlConn, "@o_feccontable", 1, SQLVARCHAR, Space(10), "feccontable", ""
    PMPasoValoresATX VGSqlConn, "@o_provincia", 1, SQLVARCHAR, Space(7), "Provincia", ""
    PMPasoValoresATX VGSqlConn, "@o_terminal", 1, SQLVARCHAR, Space(6), "Terminal", ""
    If FMTransmitirRPCATX(VGSqlConn, "", "cob_servicios", "sp_imp_x_transfer_dominio_rc", True, "Transaccion Ok", "S", "N", "N", "35", "S", "S") = True Then
        VLSsn = FMRetParamATX(VGSqlConn, 1)
        If Len(Trim$(VLSsn)) > 8 Then
            VLSsn = Mid$(Trim$(VLSsn), 1, 8)
        End If
        VLtxtMCN = VLSsn
        VLSsn = String(8 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
        VLFecHora = FMRetParamATX(VGSqlConn, 2)
        VLFecContable = FMRetParamATX(VGSqlConn, 3)
        VLProvincia = FMRetParamATX(VGSqlConn, 4)
        VLTerminal = FMRetParamATX(VGSqlConn, 5)
        PMChequeaATX VGSqlConn
        PMTotalesBranch "35"
        FLSecuencias = True
    Else
        FLSecuencias = False
    End If
    PMChequeaATX VGSqlConn
    If FMRetStatusATX(VGSqlConn) <> 0 Then
        VTIndicadorSum = 0
        FLSecuencias = False
    End If
    PMFinTransaccion
    VGTipoEjecucion = VLTipoEjecucion
End Function

Function FLTramaSwitch(VLTipo As String) As Boolean
On Error GoTo Etiqueta_Error
    Dim VLTramaEnvio As String
    Dim VLTramaRetorno As String
    Dim VLCodRetorno As Integer
    Dim VLCodRetornoInd As String
    Dim VLValorPagar As String
    Dim VLSSNREV As String
    'VLTipo
    'C=Consulta
    'P=Pago
    'R=Reversa normal
    MsgBox "ALERTA - ARREGLAR ESTE CAMBIO QUE NO PUEDE LLAMAR AL SWITCH", vbCritical, "ATXVB"
    FLTramaSwitch = False
    Exit Function
    
    FLTramaSwitch = False
    'Armar y lanzar la trama de pago al sri
    Select Case VLTipo
    '*****************************************************************
    '*****************************************************************
    '*************** C O N S U L T A *********************************
    '*****************************************************************
    '*****************************************************************
    Case "C"
        If Not FLSecuencias() Then
            Exit Function
        End If
        'Bloquear controles
        Matricula.Enabled = False
        'Arma trama
        VLTramaEnvio = "0255006          "
        VLTramaEnvio = VLTramaEnvio + VLFecHora 'Fecha y hora real aaaammddhhmmsscc
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2) 'Fecha contable
        VLTramaEnvio = VLTramaEnvio + "004002C00"
        VLTramaEnvio = VLTramaEnvio + VLSsn 'SSN
        VLTramaEnvio = VLTramaEnvio + "N00000000"
        VLTramaEnvio = VLTramaEnvio + String(3 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) 'Oficina
        VLTramaEnvio = VLTramaEnvio + Trim$(VGUsuario) + String(10 - Len(Trim$(VGUsuario)), " ") 'Usuario
        VLTramaEnvio = VLTramaEnvio + VLSsn 'MCN
        VLTramaEnvio = VLTramaEnvio + "000000000000000000000000000007"
        VLTramaEnvio = VLTramaEnvio + VLSsn 'COD_TRAN_PROVEED
        VLTramaEnvio = VLTramaEnvio + "00000000000000000000000000000000000000"
        VLTramaEnvio = VLTramaEnvio + String(3 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) + "   " 'PSI_CODIGO_AGENCIA_IFI
        VLTramaEnvio = VLTramaEnvio + "VENTANILLA  "
        VLTramaEnvio = VLTramaEnvio + Trim$(VGUsuario) + String(10 - Len(Trim$(VGUsuario)), " ") 'PSI_CODIGO_OPERADOR_IFI
        VLTramaEnvio = VLTramaEnvio + "07"  'PSI_CODIGO_PROVE_SWITCH_IFI
        VLTramaEnvio = VLTramaEnvio + VLTerminal  'PSIO_CODIGO_TERMINAL_IFI
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2) 'PSI_FECHA_CONTABLE_IFI
        VLTramaEnvio = VLTramaEnvio + Trim$(VGUsuario) + String(10 - Len(Trim$(VGUsuario)), " ") 'PSI_NOMBRE_OPERADOR_IFI
        VLTramaEnvio = VLTramaEnvio + Trim$(Matricula.Text) + String(13 - Len(Trim$(Matricula.Text)), " ")   'PSI_PLACA_CAMV_CPN
        VLTramaEnvio = VLTramaEnvio + Trim$(VLProvincia) + String(7 - Len(Trim$(VLProvincia)), " ")  'PSI_PROVINCIA_IFI
        VLTramaEnvio = VLTramaEnvio + "TRANSF_DOMTRA_CON"
        'Enviar trama
        Set objUpdate = CreateObject("UpLoadDll.LoadDllCobis")
        Debug.Print VLTramaEnvio
        With objUpdate
            Screen.MousePointer = 11
            .SendDataClient VGDatosConexionSRI.UpLoadIp, VGDatosConexionSRI.UpLoadPuerto, VGDatosConexionSRI.UpLoadTime, VLTramaEnvio, VLTramaRetorno
            Screen.MousePointer = 0
        End With
        Debug.Print VLTramaRetorno
        Set objUpdate = Nothing
        'Validar la trama
        If Mid$(VLTramaRetorno, 1, 4) <> "0000" Then
            MsgBox "Transaccion No ha sido realizada intente nuevamente", vbCritical, "AVISO"
            Exit Function
        End If
        VLCodRetornoInd = Mid$(VLTramaRetorno, 53, 2)
        If VLCodRetornoInd = "01" Then
            MsgBox "Tiempo de Espera Agotado. Proveedor no respondio", vbCritical, "Aviso"
            Exit Function
        End If
        VLCodRetorno = val(Mid$(VLTramaRetorno, 330, 2))
        If VLCodRetorno <> 15 Then
        PMInicioTransaccion
            PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "cl_errores_matsri", "", ""
            PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR&, "V", "", ""
            PMPasoValoresATX VGSqlConn&, "@i_codigo", 0, SQLCHAR&, Trim$(str$(VLCodRetorno)), "", ""
            If FMTransmitirRPCATX(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "", "N", "S", "I", "0", "N", "N") Then
                PMMapeaObjetoATX VGSqlConn&, txtmensaje
                PMChequeaATX VGSqlConn&
                PMFinTransaccion
            Else
                MsgBox "MENSAJE DE ERROR DEL SRI NO CATALOGADO EN EL BANCO", vbCritical, "ERROR"
                PMChequeaATX VGSqlConn&
                PMFinTransaccion
            End If
            Exit Function
        End If
        'Desglosa la trama y muestra el resultado
        'TxtNomProp.Text = Trim$(Mid$(VLTramaRetorno, 482, 35))
        TxtNomProp.Text = Trim$(Mid$(VLTramaRetorno, 506, 35))
        VLCodigoVehiculo = Trim$(Mid$(VLTramaRetorno, 282, 13))
        Total.Text = CDbl(Trim$(Mid$(VLTramaRetorno, 295, 15))) / 100
        Avaluo.Text = CDbl(Trim$(Mid$(VLTramaRetorno, 347, 10))) / 100
        Contrato.Text = CDbl(Trim$(Mid$(VLTramaRetorno, 357, 10))) / 100
        'Cedula.Text = Trim$(Mid$(VLTramaRetorno, 517, 13))
        cedula.Text = Trim$(Mid$(VLTramaRetorno, 541, 13))
        TotPago.Text = CDbl(Total.Text) + CDbl(Comision.Text)
        'mskfechacont.Text = Format$(Trim$(Mid$(VLTramaRetorno, 470, 35)), VGFormatoFecha$)
    '*****************************************************************
    '*****************************************************************
    '*************** P A G O *****************************************
    '*****************************************************************
    '*****************************************************************
    Case "P"
        VLUsarRevForzado = True
        If Not FLSecuencias() Then
            Exit Function
        End If
        VLMCNRevForzado = VLSsn  'hy-27-dic-2005
        'Bloquear controles
        Matricula.Enabled = False
        'Arma trama
        VLTramaEnvio = "0255006          "
        VLTramaEnvio = VLTramaEnvio + VLFecHora 'Fecha y hora real aaaammddhhmmsscc
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2) 'Fecha contable
        VLTramaEnvio = VLTramaEnvio + "004002P00"
        VLTramaEnvio = VLTramaEnvio + VLSsn 'SSN
        VLTramaEnvio = VLTramaEnvio + "N00000000"
        VLTramaEnvio = VLTramaEnvio + String(3 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) 'Oficina
        VLTramaEnvio = VLTramaEnvio + Trim$(VGUsuario) + String(10 - Len(Trim$(VGUsuario)), " ") 'Usuario
        VLTramaEnvio = VLTramaEnvio + VLSsn 'MCN
        VLTramaEnvio = VLTramaEnvio + VLCodigoVehiculo  'PNIO_CODIGO_VEHICULO
        VLValorPagar = Trim$(str$(CDbl(Total.Text) * 100))
        VLTramaEnvio = VLTramaEnvio + String(15 - Len(Trim$(VLValorPagar)), "0") + VLValorPagar 'PNIO_VALOR_TOTAL_PAGO
        VLTramaEnvio = VLTramaEnvio + "07"
        VLTramaEnvio = VLTramaEnvio + VLSsn 'COD_TRAN_PROVEED
        VLTramaEnvio = VLTramaEnvio + "00000000000000000000000000000000000000"
        VLTramaEnvio = VLTramaEnvio + String(3 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) + "   " 'PSI_CODIGO_AGENCIA_IFI
        VLTramaEnvio = VLTramaEnvio + "VENTANILLA  "
        VLTramaEnvio = VLTramaEnvio + Trim$(VGUsuario) + String(10 - Len(Trim$(VGUsuario)), " ") 'PSI_CODIGO_OPERADOR_IFI
        VLTramaEnvio = VLTramaEnvio + "07"  'PSI_CODIGO_PROVE_SWITCH_IFI
        VLTramaEnvio = VLTramaEnvio + VLTerminal  'PSIO_CODIGO_TERMINAL_IFI
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2) 'PSI_FECHA_CONTABLE_IFI
        VLTramaEnvio = VLTramaEnvio + Trim$(VGUsuario) + String(10 - Len(Trim$(VGUsuario)), " ") 'PSI_NOMBRE_OPERADOR_IFI
        VLTramaEnvio = VLTramaEnvio + Trim$(Matricula.Text) + String(13 - Len(Trim$(Matricula.Text)), " ")   'PSI_PLACA_CAMV_CPN
        VLTramaEnvio = VLTramaEnvio + Trim$(VLProvincia) + String(7 - Len(Trim$(VLProvincia)), " ")  'PSI_PROVINCIA_IFI
        VLTramaEnvio = VLTramaEnvio + "TRANSF_DOMTRA_AFE"
        'Enviar trama
        Set objUpdate = CreateObject("UpLoadDll.LoadDllCobis")
        Debug.Print VLTramaEnvio
        With objUpdate
            Screen.MousePointer = 11
            .SendDataClient VGDatosConexionSRI.UpLoadIp, VGDatosConexionSRI.UpLoadPuerto, VGDatosConexionSRI.UpLoadTime, VLTramaEnvio, VLTramaRetorno
            Screen.MousePointer = 0
        End With
        Debug.Print VLTramaRetorno
        Set objUpdate = Nothing
        'Validar la trama
        If Mid$(VLTramaRetorno, 1, 4) <> "0000" Then
            If Mid$(VLTramaRetorno, 5, 4) = "7806" Then
                VLRevTimeOut = True
                VLSsnRevTimeOut = VLSsn
            End If
            Exit Function
        End If
        VLCodRetornoInd = Mid$(VLTramaRetorno, 53, 2)
        If VLCodRetornoInd = "01" Then
            MsgBox "Tiempo de Espera Agotado. Proveedor no respondio", vbCritical, "Aviso"
            Exit Function
        End If
        VLCodRetorno = val(Mid$(VLTramaRetorno, 330, 2))
        If VLCodRetorno <> 15 Then
            VLUsarRevForzado = False
            PMInicioTransaccion
            PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "cl_errores_matsri", "", ""
            PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR&, "V", "", ""
            PMPasoValoresATX VGSqlConn&, "@i_codigo", 0, SQLCHAR&, Trim$(str$(VLCodRetorno)), "", ""
            If FMTransmitirRPCATX(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "", "N", "S", "I", "0", "N", "N") Then
                PMMapeaObjetoATX VGSqlConn&, txtmensaje
                PMChequeaATX VGSqlConn&
                PMFinTransaccion
            Else
                MsgBox "MENSAJE DE ERROR DEL SRI NO CATALOGADO EN EL BANCO", vbCritical, "ERROR"
                PMChequeaATX VGSqlConn&
                PMFinTransaccion
            End If
            Exit Function
        End If
        'Desglosa la trama y muestra el resultado
        'Para el reverso se necesita conocer o mantener guardado los siguiente
        VLtxtMCN = VLSsn
        txtMCN.Text = VLSsn 'ssn de pago para luego hacerlo reversar
        VLtxtCodVehiculo = VLCodigoVehiculo
        txtCodVehiculo.Text = VLCodigoVehiculo 'Código de vehiculo
        VLtxtTranRevSri = Trim$(Mid$(VLTramaRetorno, 310, 15))
        txtTranRevSri.Text = VLtxtTranRevSri   'id_tran_reverso_sri
        VLtxtLogRevSri = Trim$(Mid$(VLTramaRetorno, 332, 15))
        txtLogRevSri.Text = VLtxtLogRevSri   'log_reverso_sri
        'txtChasis.Text = Trim$(Mid$(VLTramaRetorno, 398, 13))
        txtChasis.Text = Trim$(Mid$(VLTramaRetorno, 398, 25))
        'txtMotor.Text = Trim$(Mid$(VLTramaRetorno, 469, 13))
        txtMotor.Text = Trim$(Mid$(VLTramaRetorno, 481, 25))
    '*****************************************************************
    '*****************************************************************
    '*************** R E V E R S A ***********************************
    '*****************************************************************
    '*****************************************************************
    Case "R"
        If Not FLSecuencias() Then
            Exit Function
        End If
        'Bloquear controles
        Matricula.Enabled = False
        'Arma trama
        VLTramaEnvio = "0255006          "
        VLTramaEnvio = VLTramaEnvio + VLFecHora 'Fecha y hora real aaaammddhhmmsscc
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2) 'Fecha contable
        VLTramaEnvio = VLTramaEnvio + "004002P00"
        VLTramaEnvio = VLTramaEnvio + VLSsn 'SSN
        VLTramaEnvio = VLTramaEnvio + "S"
        VLTramaEnvio = VLTramaEnvio + Trim$(txtMCN.Text)  'MCN a corregir
        VLTramaEnvio = VLTramaEnvio + String(3 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) 'Oficina
        VLTramaEnvio = VLTramaEnvio + Trim$(VGUsuario) + String(10 - Len(Trim$(VGUsuario)), " ") 'Usuario
        VLTramaEnvio = VLTramaEnvio + VLSsn 'MCN
        VLTramaEnvio = VLTramaEnvio + Trim$(txtCodVehiculo.Text)   'PNIO_CODIGO_VEHICULO
        VLValorPagar = Trim$(str$(CDbl(Total.Text) * 100))
        VLTramaEnvio = VLTramaEnvio + String(15 - Len(Trim$(VLValorPagar)), "0") + VLValorPagar 'PNIO_VALOR_TOTAL_PAGO
        VLTramaEnvio = VLTramaEnvio + "07"
        VLTramaEnvio = VLTramaEnvio + VLSsn 'COD_TRAN_PROVEED
        VLTramaEnvio = VLTramaEnvio + Trim$(txtMCN.Text) 'tran_reverso_ifi (mcn con que se pagó)
        VLTramaEnvio = VLTramaEnvio + Trim$(txtTranRevSri.Text)  'tran_reverso_sri
        VLTramaEnvio = VLTramaEnvio + Trim$(txtLogRevSri.Text) 'log_reverso_sri
        VLTramaEnvio = VLTramaEnvio + String(3 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) + "   " 'PSI_CODIGO_AGENCIA_IFI
        VLTramaEnvio = VLTramaEnvio + "VENTANILLA  "
        VLTramaEnvio = VLTramaEnvio + Trim$(VGUsuario) + String(10 - Len(Trim$(VGUsuario)), " ") 'PSI_CODIGO_OPERADOR_IFI
        VLTramaEnvio = VLTramaEnvio + "07"  'PSI_CODIGO_PROVE_SWITCH_IFI
        VLTramaEnvio = VLTramaEnvio + VLTerminal  'PSIO_CODIGO_TERMINAL_IFI
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2) 'PSI_FECHA_CONTABLE_IFI
        VLTramaEnvio = VLTramaEnvio + Trim$(VGUsuario) + String(10 - Len(Trim$(VGUsuario)), " ") 'PSI_NOMBRE_OPERADOR_IFI
        VLTramaEnvio = VLTramaEnvio + Trim$(Matricula.Text) + String(13 - Len(Trim$(Matricula.Text)), " ")   'PSI_PLACA_CAMV_CPN
        VLTramaEnvio = VLTramaEnvio + Trim$(VLProvincia) + String(7 - Len(Trim$(VLProvincia)), " ")  'PSI_PROVINCIA_IFI
        VLTramaEnvio = VLTramaEnvio + "TRANSF_DOMTRA_REV"
        'Enviar trama
        Set objUpdate = CreateObject("UpLoadDll.LoadDllCobis")
        Debug.Print VLTramaEnvio
        With objUpdate
            Screen.MousePointer = 11
            .SendDataClient VGDatosConexionSRI.UpLoadIp, VGDatosConexionSRI.UpLoadPuerto, VGDatosConexionSRI.UpLoadTime, VLTramaEnvio, VLTramaRetorno
            Screen.MousePointer = 0
        End With
        Debug.Print VLTramaRetorno
        Set objUpdate = Nothing
        'Validar la trama
        If Mid$(VLTramaRetorno, 1, 4) <> "0000" Then
            If Mid$(VLTramaRetorno, 5, 4) = "7806" Then
                VLRevTimeOut = True
            End If
            Exit Function
        End If
        VLCodRetornoInd = Mid$(VLTramaRetorno, 53, 2)
        If VLCodRetornoInd = "01" Then
            MsgBox "Tiempo de Espera Agotado. Proveedor no respondio", vbCritical, "Aviso"
            Exit Function
        End If
        VLCodRetorno = val(Mid$(VLTramaRetorno, 330, 2))
        If VLCodRetorno <> 15 Then
            PMInicioTransaccion
            PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "cl_errores_matsri", "", ""
            PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR&, "V", "", ""
            PMPasoValoresATX VGSqlConn&, "@i_codigo", 0, SQLCHAR&, Trim$(str$(VLCodRetorno)), "", ""
            If FMTransmitirRPCATX(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "", "N", "S", "I", "0", "N", "N") Then
                PMMapeaObjetoATX VGSqlConn&, txtmensaje
                PMChequeaATX VGSqlConn&
                PMFinTransaccion
            Else
                MsgBox "MENSAJE DE ERROR DEL SRI NO CATALOGADO EN EL BANCO", vbCritical, "ERROR"
                PMChequeaATX VGSqlConn&
                PMFinTransaccion
            End If
            Exit Function
        End If
    '*****************************************************************
    '*****************************************************************
    '*************** R E V E R S A    F O R Z A D A ******************
    '*****************************************************************
    '*****************************************************************
    Case "Z"
        If Not FLSecuencias() Then
            Exit Function
        End If
        'Bloquear controles
        Matricula.Enabled = False
        'Arma trama
        VLTramaEnvio = "0255006          "
        VLTramaEnvio = VLTramaEnvio + VLFecHora 'Fecha y hora real aaaammddhhmmsscc
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2) 'Fecha contable
        VLTramaEnvio = VLTramaEnvio + "004002P00"
        VLTramaEnvio = VLTramaEnvio + VLSsn 'SSN
        VLTramaEnvio = VLTramaEnvio + "S"
        VLTramaEnvio = VLTramaEnvio + Trim$(VLMCNRevForzado)  'MCN a corregir
        VLTramaEnvio = VLTramaEnvio + String(3 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) 'Oficina
        VLTramaEnvio = VLTramaEnvio + Trim$(VGUsuario) + String(10 - Len(Trim$(VGUsuario)), " ") 'Usuario
        VLTramaEnvio = VLTramaEnvio + VLSsn 'MCN
        VLTramaEnvio = VLTramaEnvio + Trim$(VLCodigoVehiculo)   'PNIO_CODIGO_VEHICULO
        VLValorPagar = Trim$(str$(CDbl(Total.Text) * 100))
        VLTramaEnvio = VLTramaEnvio + String(15 - Len(Trim$(VLValorPagar)), "0") + VLValorPagar 'PNIO_VALOR_TOTAL_PAGO
        VLTramaEnvio = VLTramaEnvio + "07"
        VLTramaEnvio = VLTramaEnvio + VLSsn 'COD_TRAN_PROVEED
        VLTramaEnvio = VLTramaEnvio + Trim$(VLMCNRevForzado) 'tran_reverso_ifi (mcn con que se pagó)
        VLTramaEnvio = VLTramaEnvio + "000000000000000000000000000000"
        VLTramaEnvio = VLTramaEnvio + String(3 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) + "   " 'PSI_CODIGO_AGENCIA_IFI
        VLTramaEnvio = VLTramaEnvio + "VENTANILLA  "
        VLTramaEnvio = VLTramaEnvio + Trim$(VGUsuario) + String(10 - Len(Trim$(VGUsuario)), " ") 'PSI_CODIGO_OPERADOR_IFI
        VLTramaEnvio = VLTramaEnvio + "07"  'PSI_CODIGO_PROVE_SWITCH_IFI
        VLTramaEnvio = VLTramaEnvio + VLTerminal  'PSIO_CODIGO_TERMINAL_IFI
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2) 'PSI_FECHA_CONTABLE_IFI
        VLTramaEnvio = VLTramaEnvio + Trim$(VGUsuario) + String(10 - Len(Trim$(VGUsuario)), " ") 'PSI_NOMBRE_OPERADOR_IFI
        VLTramaEnvio = VLTramaEnvio + Trim$(Matricula.Text) + String(13 - Len(Trim$(Matricula.Text)), " ")   'PSI_PLACA_CAMV_CPN
        VLTramaEnvio = VLTramaEnvio + Trim$(VLProvincia) + String(7 - Len(Trim$(VLProvincia)), " ")  'PSI_PROVINCIA_IFI
        VLTramaEnvio = VLTramaEnvio + "TRANSF_DOMTRA_REV"
        'Enviar trama
        Set objUpdate = CreateObject("UpLoadDll.LoadDllCobis")
        Debug.Print VLTramaEnvio
        With objUpdate
            Screen.MousePointer = 11
            .SendDataClient VGDatosConexionSRI.UpLoadIp, VGDatosConexionSRI.UpLoadPuerto, VGDatosConexionSRI.UpLoadTime, VLTramaEnvio, VLTramaRetorno
            Screen.MousePointer = 0
        End With
        Debug.Print VLTramaRetorno
        Set objUpdate = Nothing
        'Validar la trama
        If Mid$(VLTramaRetorno, 1, 4) <> "0000" Then
            If Mid$(VLTramaRetorno, 5, 4) = "7806" Then
                VLRevTimeOut = True
            End If
            Exit Function
        End If
        VLCodRetornoInd = Mid$(VLTramaRetorno, 53, 2)
        If VLCodRetornoInd = "01" Then
            MsgBox "Tiempo de Espera Agotado. Proveedor no respondio", vbCritical, "Aviso"
            Exit Function
        End If
        VLCodRetorno = val(Mid$(VLTramaRetorno, 330, 2))
        If VLCodRetorno <> 15 Then
            PMInicioTransaccion
            PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "cl_errores_matsri", "", ""
            PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR&, "V", "", ""
            PMPasoValoresATX VGSqlConn&, "@i_codigo", 0, SQLCHAR&, Trim$(str$(VLCodRetorno)), "", ""
            If FMTransmitirRPCATX(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "", "N", "S", "I", "0", "N", "N") Then
                PMMapeaObjetoATX VGSqlConn&, txtmensaje
                PMChequeaATX VGSqlConn&
                PMFinTransaccion
            Else
                MsgBox "MENSAJE DE ERROR DEL SRI NO CATALOGADO EN EL BANCO", vbCritical, "ERROR"
                PMChequeaATX VGSqlConn&
                PMFinTransaccion
            End If
            Exit Function
        End If
    End Select
    
    FLTramaSwitch = True
    Exit Function
Etiqueta_Error:
    Screen.MousePointer = 0
    MsgBox Err.Description, vbCritical, "Error"
End Function

