VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "GRID32.OCX"
Object = "{0F1F1508-C40A-101B-AD04-00AA00575482}#1.0#0"; "mhrinp32.ocx"
Object = "{9AED8C43-3F39-11D1-8BB4-0000C039C248}#2.0#0"; "txtin.ocx"
Object = "{DECFDD03-1E4B-11D1-B65E-0000C039C248}#5.0#0"; "mskedit.ocx"
Object = "{00025600-0000-0000-C000-000000000046}#5.2#0"; "crystl32.ocx"
Begin VB.Form FCC78 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "PAGO DE MATRICULA DE VEHICULOS/AJUSTES - 78"
   ClientHeight    =   6630
   ClientLeft      =   705
   ClientTop       =   855
   ClientWidth     =   4440
   KeyPreview      =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6630
   ScaleWidth      =   4440
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
      Left            =   1440
      MaxLength       =   60
      TabIndex        =   10
      Top             =   4875
      Width           =   2895
   End
   Begin VB.TextBox txtTempo 
      Height          =   375
      Left            =   120
      TabIndex        =   39
      Top             =   4920
      Visible         =   0   'False
      Width           =   735
   End
   Begin TxtinLib.TextValid txtChasis 
      Height          =   285
      Left            =   0
      TabIndex        =   37
      Top             =   3360
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
      TabIndex        =   36
      Top             =   3000
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
      TabIndex        =   35
      Top             =   2640
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
      TabIndex        =   34
      Top             =   2280
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
      TabIndex        =   33
      Top             =   1920
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
      TabIndex        =   32
      Top             =   1560
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
   Begin VB.TextBox txtNotaVenta 
      Height          =   375
      Left            =   3600
      TabIndex        =   30
      Top             =   4680
      Visible         =   0   'False
      Width           =   735
   End
   Begin TxtinLib.TextValid moneda 
      Height          =   285
      Left            =   1920
      TabIndex        =   22
      Top             =   5040
      Visible         =   0   'False
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
      BackColor       =   &H80000004&
      BorderStyle     =   0  'None
      Enabled         =   0   'False
      ForeColor       =   &H80000008&
      Height          =   615
      Left            =   120
      ScaleHeight     =   615
      ScaleWidth      =   855
      TabIndex        =   20
      Top             =   720
      Visible         =   0   'False
      Width           =   855
   End
   Begin VB.Frame Frame 
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
      Height          =   3975
      Left            =   120
      TabIndex        =   12
      Top             =   840
      Width           =   4215
      Begin VB.TextBox txt_tipo_deuda 
         Height          =   285
         Left            =   960
         TabIndex        =   42
         Top             =   120
         Visible         =   0   'False
         Width           =   1215
      End
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
         Left            =   1160
         TabIndex        =   29
         Top             =   2060
         Width           =   2895
      End
      Begin VB.ComboBox CboTipCta 
         Height          =   315
         Left            =   2100
         Style           =   2  'Dropdown List
         TabIndex        =   5
         Tag             =   "CboProd"
         Top             =   1400
         Width           =   855
      End
      Begin MhinrelLib.MhRealInput Total 
         Height          =   285
         Left            =   2100
         TabIndex        =   9
         Top             =   3250
         Width           =   1935
         _Version        =   65536
         _ExtentX        =   3413
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
         Top             =   1090
         Width           =   1935
         _Version        =   65536
         _ExtentX        =   3413
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
         Top             =   495
         Width           =   1935
         _Version        =   65536
         _ExtentX        =   3413
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
         Left            =   2100
         TabIndex        =   6
         Tag             =   "Cta"
         Top             =   1750
         Width           =   1590
         _Version        =   262144
         _ExtentX        =   2805
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
         Top             =   2360
         Width           =   1935
         _Version        =   65536
         _ExtentX        =   3413
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
      Begin MhinrelLib.MhRealInput Tarjeta 
         Height          =   285
         Left            =   2100
         TabIndex        =   8
         ToolTipText     =   "Ingrese Valor en Tarjeta de Crédito"
         Top             =   2655
         Width           =   1935
         _Version        =   65536
         _ExtentX        =   3413
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
         ReadOnly        =   -1  'True
         SpinChangeReal  =   0
         AutoHScroll     =   -1  'True
         CaretColor      =   -2147483642
         DecimalPlaces   =   2
         Separator       =   -1  'True
      End
      Begin TxtinLib.TextValid CantChq 
         Height          =   285
         Left            =   2100
         TabIndex        =   3
         ToolTipText     =   "Cantidad de Cheques"
         Top             =   800
         Width           =   1215
         _Version        =   65536
         _ExtentX        =   2143
         _ExtentY        =   503
         _StockProps     =   253
         BorderStyle     =   1
         Range           =   ""
         MaxLength       =   0
         Character       =   0
         Type            =   2
         HelpLine        =   ""
         Pendiente       =   ""
         Connection      =   0
         AsociatedLabelIndex=   0
         TableName       =   ""
         MinChar         =   0
         Error           =   0
      End
      Begin MhinrelLib.MhRealInput Comision 
         Height          =   285
         Left            =   2100
         TabIndex        =   24
         ToolTipText     =   "Valor de Comision [F5 Presenta Forma de Pago]"
         Top             =   2955
         Width           =   1935
         _Version        =   65536
         _ExtentX        =   3413
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
         ReadOnly        =   -1  'True
         SpinChangeReal  =   0
         AutoHScroll     =   -1  'True
         CaretColor      =   -2147483642
         DecimalPlaces   =   2
         Separator       =   -1  'True
      End
      Begin MhinrelLib.MhRealInput TotPago 
         Height          =   285
         Left            =   2100
         TabIndex        =   26
         Top             =   3540
         Width           =   1935
         _Version        =   65536
         _ExtentX        =   3413
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
         Left            =   1575
         Top             =   2970
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
         Left            =   1125
         TabIndex        =   43
         Top             =   3375
         Width           =   900
      End
      Begin VB.Label LblNomCta 
         AutoSize        =   -1  'True
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
         TabIndex        =   28
         Top             =   2040
         Width           =   1080
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
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
         TabIndex        =   27
         Top             =   3540
         Width           =   1215
      End
      Begin VB.Label Label6 
         Caption         =   "Comisión:"
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
         TabIndex        =   25
         Top             =   2955
         Width           =   1455
      End
      Begin VB.Label lblCantchq 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Cant.Cheques:"
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
         TabIndex        =   23
         Top             =   800
         Width           =   1260
      End
      Begin VB.Label LblEfect 
         AutoSize        =   -1  'True
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
         TabIndex        =   19
         Top             =   480
         Width           =   840
      End
      Begin VB.Label LblChq 
         AutoSize        =   -1  'True
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
         TabIndex        =   18
         Top             =   1090
         Width           =   780
      End
      Begin VB.Label LblTotal 
         AutoSize        =   -1  'True
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
         TabIndex        =   17
         Top             =   3250
         Width           =   570
      End
      Begin VB.Label LblDebito 
         AutoSize        =   -1  'True
         Caption         =   "Débito :"
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
         TabIndex        =   16
         Top             =   2355
         Width           =   675
      End
      Begin VB.Label LblTipCta 
         AutoSize        =   -1  'True
         Caption         =   "Tipo Cta :"
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
         TabIndex        =   15
         Top             =   1400
         Width           =   855
      End
      Begin VB.Label LblCuenta 
         AutoSize        =   -1  'True
         Caption         =   "No. Cuenta :"
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
         TabIndex        =   14
         Top             =   1750
         Width           =   1095
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Tarjeta de Crédito:"
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
         TabIndex        =   13
         Top             =   2655
         Width           =   1590
      End
   End
   Begin TxtinLib.TextValid Matricula 
      Height          =   285
      Left            =   2280
      TabIndex        =   1
      Top             =   480
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
   Begin TxtinLib.TextValid txtmensaje 
      Height          =   285
      Left            =   4080
      TabIndex        =   31
      Top             =   120
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
      TabIndex        =   38
      Top             =   5400
      Visible         =   0   'False
      Width           =   4215
      _Version        =   65536
      _ExtentX        =   7435
      _ExtentY        =   1931
      _StockProps     =   77
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin TxtinLib.TextValid txt_rubro 
      Height          =   285
      Left            =   1920
      TabIndex        =   0
      Top             =   120
      Width           =   315
      _Version        =   65536
      _ExtentX        =   556
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
      TableName       =   "cl_rubros_sri"
      MinChar         =   0
      Error           =   0
   End
   Begin VB.Label lbl_rubro 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   285
      Left            =   2280
      TabIndex        =   41
      Top             =   120
      Width           =   1635
   End
   Begin VB.Label lbl_deuda 
      AutoSize        =   -1  'True
      Caption         =   "Tipo de Deuda:"
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
      TabIndex        =   40
      Top             =   120
      Width           =   1335
   End
   Begin VB.Label LblNomProp 
      AutoSize        =   -1  'True
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
      TabIndex        =   11
      Top             =   4875
      Width           =   1125
   End
   Begin VB.Label LblPlaca 
      AutoSize        =   -1  'True
      Caption         =   "Placa/DUI/Cert. Prod :"
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
      TabIndex        =   21
      Top             =   480
      Width           =   1980
   End
End
Attribute VB_Name = "FCC78"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'********************************************************************************'
'*              MODIFICACIONES                                                  *'
'* REF  FECHA       AUTOR          DESCRIPCION                                  *'
'*  02  19/Sep/2017 Vanessa Miranda FACOFF-AP-SGC00029747-SGC00029748 Agregar   *'
'*      Clave de Acceso Facturación Electrónica Offline                         *'
'*  03  29/JUN/2018 Paul Hoyos V.   CTE-CC-SGC00031990 Consumo TC con cedula    *'
'*  04  17/JUN/2019 Danny Olaya S.  RECM-2 Modificar Impresion Valor Avaluo en Comprobante    *'
'*  05  21/JUN/2019 Pablo Ricaurte  Comision 0 cuando pago con TC    *'
'********************************************************************************'
Dim VLCambio As Integer
Dim VLCambioMatri As Integer
Dim Comprobante As Long
Dim motor As String
Dim chasis As String
Dim periodo As String
Dim fisco As Currency
Dim administracion As Currency
Dim VLProd As Integer
Dim VLTrn As String
Dim VLfirma As Boolean

'-- variables para la comision --
Dim VLAcum78 As Currency
Dim VLTotCom78 As Currency
Dim VLEfe_com78  As Currency
Dim VLChq_com78 As Currency
Dim VLDeb_com78 As Currency
Dim VLCta_com78  As String
Dim VLTipCta_com78 As String

Dim VLautoriSri As String
Dim VLFecvenSRI As String
Dim VLSerie_Secuencia As String 'hy-24-feb-2005
'-------------------------------
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
Dim VLRucPropietario As String
Dim VLTitulo1 As String
Dim VLValor1 As Currency
Dim VLTitulo2 As String
Dim VLValor2 As Currency
Dim VLTitulo3 As String
Dim VLValor3 As Currency
Dim VLTitulo4 As String
Dim VLValor4 As Currency
Dim VLTitulo5 As String
Dim VLValor5 As Currency
Dim VLTitulo6 As String
Dim VLValor6 As Currency
Dim VLTitulo7 As String
Dim VLValor7 As Currency
Dim VLTitulo8 As String
Dim VLValor8 As Currency
Dim VLTitulo9 As String
Dim VLValor9 As Currency
Dim VLTitulo10 As String
Dim VLValor10 As Currency
Dim VLValAvaluo As Currency
'-->hy-13-dic-2005
Dim VLValidaEfeCom As Currency
Dim VLtxtMCN As String
Dim VLtxtCodVehiculo As String
Dim VLtxtTranRevSri As String
Dim VLtxtLogRevSri As String
Dim VLtxtChasis As String
Dim VLtxtMotor As String
'<--hy-13-dic-2005
Dim VLMCNRevForzado As String  'hy-27-dic-2005
Dim VLUsarRevForzado As Boolean  'hy-27-dic-2005
Dim VLMoneda As Integer
Dim VLDescMonCta As String
'Parametros por CPS JUNIO 2006
Dim psRetorno() As String
Dim VLSecTrnCorr As String
Dim VLLogSri As String
Dim VLMCN As String
Dim VLRecibo As String
'dolayas Ini
Dim VLAdicional As String
'dolayas Fin
'-->hy-18-junio-2007
Dim VLVISA_numtar As String
Dim VLVISA_ClaveUnicaTC As String   'PHOYOSV REF_02 20170714
Dim VLVISA_numtar_mask As String    'JPM 09/14/2012
Dim VLVISA_cvv1 As String
Dim VLVISA_cvv2 As String
Dim VLVISA_fechaven As String
Dim VLVISA_meses As String
Dim VLVISA_monto As Currency
Dim VLVISA_tipoconsumo As String
Dim VLVISA_ssn_corr1 As String
Dim VLVISA_autorizacion As String
Dim VLVISA_banda_sn As String
Dim VLVISA_track1 As String
Dim VLVISA_track2 As String
Dim VLVISA_nombre As String
Dim psRetorno2() As String
Dim VLCiudadOficina As String
Dim VLDireccionOficina As String
Dim VLTelefonoOficina As String
Dim VLNumAutorizaVisa As String
Dim VLNumTranAutorizaVisa As String
Dim VLCodigoComercio As String
Dim VLNombreComercio As String
Dim VLCodigoComercioAjus As String 'smerino
Dim VLNombreComercioAjus As String 'smerino

Dim VLDatoCatalogo As String
Dim VLFlagMultiFlujo As String
'<--hy-18-junio-2007
Dim VLNombre As String  'TC 19/02/2010
Dim VLTipo_imp As String        'ame 08/04/2010
Dim VLfact_elect As String      'ame 08/04/2010
Dim VLInteres As Currency       ' ame 08/25/2010
Dim VLTotal   As Currency       ' ame 08/25/2010
Dim VLFecinivig As String       'sme 06/08/2011
Dim VLFecfinvig As String       'sme 06/08/2011
Dim VLbasecero As String        'joel 05/30/2012
Dim VLiva As Currency 'smerino iva
Dim VlbaseImp As Currency 'smerino iva
Dim VLStrEncrypt As String      'jpm 10/02/2012
Dim VLTipoDeuda As String      'smerino
Dim VLCodigoTerminal As String 'smerino codigo de terminal credimatic
Dim VLclave_acceso As String 'ref02 vmirandt
Dim VLParametroServer As String 'PHOYOSV REF_03 20180629
Dim LOG_AUTORIZACION As String






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
Function FLConsMatriculaCPS() As Integer

     If Not FLSecuencias() Then
            Exit Function
        End If
        
    If VGHorarioDif Then
        VLTrn = "3331"
    Else
        VLTrn = "3142"
    End If
        
  'obtener tipo de deuda smerino
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLVARCHAR, "X", "opcion", ""
    PMPasoValoresATX VGSqlConn, "@i_rubro", 0, SQLVARCHAR, Me.txt_rubro.Text, "rubro", ""
    PMPasoValoresATX VGSqlConn, "@o_tipoDeuda", 1, SQLVARCHAR, "0", "empresa", ""
    
    If FMTransmitirRPCATX(VGSqlConn, "", "cob_servicios", "sp_tr_pago_matrvehi_rc", True, "Transaccion Ok", "S", "N", "N", "0", "S", "S") = True Then
        txt_tipo_deuda.Text = FMRetParamATX(VGSqlConn, 1)
        VLTipoDeuda = txt_tipo_deuda.Text
       PMChequeaATX VGSqlConn&
       Else
        MsgBox "Tipo de deuda no parametrizada", vbInformation, "Aviso"
        Exit Function
       'Empresa.Text = "0"
       PMChequeaATX VGSqlConn&
       PMFinTransaccion
    End If
    
 ' End If 'fin de la validacion

        
               
    PMInicioTransaccion
    Total.Text = "0"
    TotPago.Text = "0"
    
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, "18009", "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_pcodcanalpagifi", 0, SQLVARCHAR, "VENTANILLA", "Ppsi_cod_canal_pago_ifi", ""
    PMPasoValoresATX VGSqlConn, "@i_pfeccontifi", 0, SQLVARCHAR, Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2), "Ppsio_fecha_contable_ifi", ""
    PMPasoValoresATX VGSqlConn, "@i_pplacacamvcpn", 0, SQLVARCHAR, Trim$(Matricula.Text), "Ppsi_placa_camv_cpn", ""
    PMPasoValoresATX VGSqlConn, "@i_pprovifi", 0, SQLVARCHAR, Trim$(VLProvincia), "Ppsi_provincia_ifi", ""
  'smerino ajustes
   ' If Me.txt_rubro.Text = "02" Then
        PMPasoValoresATX VGSqlConn, "@i_ptipodeuda", 0, SQLVARCHAR, VLTipoDeuda, "Ppsi_tipo_deuda", ""
    'Else
        'PMPasoValoresATX VGSqlConn, "@i_ptipodeuda", 0, SQLVARCHAR, "AJUSTES", "Ppsi_tipo_deuda", ""
    'End If
    'FIN SMERINO
    
    If FMTransmitirRPCATX(VGSqlConn, VLParametroServer, "cob_procesador", "sp_tr_consulta_matrvehi_rc", True, "Transaccion Ok", "S", "N", "N", "78", "S", "S") = True Then
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
        
        LOG_AUTORIZACION = psRetorno(1, 6)
        TxtNomProp.Text = psRetorno(1, 18)
        VLRucPropietario = psRetorno(1, 19)
        VLCodigoVehiculo = psRetorno(1, 2)
        Total.Text = CDbl(psRetorno(1, 3)) / 100
        VLTranRevSri = 0
        VLValAvaluo = psRetorno(1, 7)
        VLTramaRetorno = Space(93) & psRetorno(1, 1)
        VLTitulo1 = Trim$(Mid$(VLTramaRetorno, 93, 12))
        If Trim$(VLTitulo1) = "" Then
            VLValor1 = 0
        Else
            VLValor1 = CDbl(Trim$(psRetorno(1, 3))) / 100
        End If
        VLTitulo2 = Trim$(Mid$(VLTramaRetorno, 111, 12))
        If Trim$(VLTitulo2) = "" Then
            VLValor2 = 0
        Else
            VLValor2 = CDbl(Trim$(Mid$(VLTramaRetorno, 123, 6))) / 100
        End If
        VLTitulo3 = Trim$(Mid$(VLTramaRetorno, 129, 12))
        If Trim$(VLTitulo3) = "" Then
            VLValor3 = 0
        Else
            VLValor3 = CDbl(Trim$(Mid$(VLTramaRetorno, 141, 6))) / 100
        End If
        VLTitulo4 = Trim$(Mid$(VLTramaRetorno, 147, 12))
        If Trim$(VLTitulo4) = "" Then
            VLValor4 = 0
        Else
            VLValor4 = CDbl(Trim$(Mid$(VLTramaRetorno, 159, 6))) / 100
        End If
        VLTitulo5 = Trim$(Mid$(VLTramaRetorno, 165, 12))
        If Trim$(VLTitulo5) = "" Then
            VLValor5 = 0
        Else
            VLValor5 = CDbl(Trim$(Mid$(VLTramaRetorno, 177, 6))) / 100
        End If
        VLTitulo6 = Trim$(Mid$(VLTramaRetorno, 183, 12))
        If Trim$(VLTitulo6) = "" Then
            VLValor6 = 0
        Else
            VLValor6 = CDbl(Trim$(Mid$(VLTramaRetorno, 195, 6))) / 100
        End If
        VLTitulo7 = Trim$(Mid$(VLTramaRetorno, 201, 12))
        If Trim$(VLTitulo7) = "" Then
            VLValor7 = 0
        Else
            VLValor7 = CDbl(Trim$(Mid$(VLTramaRetorno, 213, 6))) / 100
        End If
        VLTitulo8 = Trim$(Mid$(VLTramaRetorno, 219, 12))
        If Trim$(VLTitulo8) = "" Then
            VLValor8 = 0
        Else
            VLValor8 = CDbl(Trim$(Mid$(VLTramaRetorno, 231, 6))) / 100
        End If
        VLTitulo9 = Trim$(Mid$(VLTramaRetorno, 237, 12))
        If Trim$(VLTitulo9) = "" Then
            VLValor9 = 0
        Else
            VLValor9 = CDbl(Trim$(Mid$(VLTramaRetorno, 249, 6))) / 100
        End If
        VLTitulo10 = Trim$(Mid$(VLTramaRetorno, 255, 12))
        If Trim$(VLTitulo10) = "" Then
            VLValor10 = 0
        Else
            VLValor10 = CDbl(Trim$(Mid$(VLTramaRetorno, 267, 6))) / 100
        End If
    
        VLtxtMCN = VLSsn
        txtMCN.Text = VLSsn 'ssn de pago para luego hacerlo reversar
        VLtxtCodVehiculo = VLCodigoVehiculo
        txtCodVehiculo.Text = VLCodigoVehiculo 'Código de vehiculo
        VLtxtTranRevSri = psRetorno(1, 6)
        txtTranRevSri.Text = VLtxtTranRevSri  'id_tran_reverso_sri
        VLtxtLogRevSri = psRetorno(1, 6)
        txtLogRevSri.Text = VLtxtLogRevSri   'log_reverso_sri
        'txtChasis.Text = Trim$(Mid$(VLTramaRetorno, 398, 13))
        VLtxtChasis = psRetorno(1, 11)
        txtChasis.Text = VLtxtChasis
        'txtMotor.Text = Trim$(Mid$(VLTramaRetorno, 469, 13))
        VLtxtMotor = psRetorno(1, 17)
        txtMotor.Text = VLtxtMotor
        
        PMChequeaATX VGSqlConn
        FLConsMatriculaCPS = True
        VLCambioMatri% = False
        Matricula.Enabled = False
    Else
        TxtNomProp.Text = ""
        Total.Text = "0.00"
        TotPago.Text = "0.00"
        VLCambioMatri% = True
        FLConsMatriculaCPS = False
    End If
    PMChequeaATX VGSqlConn
'    If FMRetStatusATX(VGSqlConn) <> 0 Then
'        On Error Resume Next
'        Matricula.Enabled = True
'        Me.Refresh
'        Matricula.Refresh
'        If Matricula.Enabled Then Matricula.SetFocus
'        FLConsMatriculaCPS = False
'    End If
    PMFinTransaccion
End Function

Function FLConsMatricula() As Integer
  PMInicioTransaccion
  Total.Text = "0"
  TotPago.Text = "0"
  PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, "3142", "Trn", ""
  PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "C", "", ""
  PMPasoValoresATX VGSqlConn, "@i_matricula", 0, SQLVARCHAR, (Matricula.Text), "Matricula", ""
  PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(FMObtenerMonedaForma("78")), "Moneda", ""
  PMPasoValoresATX VGSqlConn, "@o_nomprop", 1, SQLVARCHAR, (TxtNomProp.Text), "TxtNomProp", ""
  PMPasoValoresATX VGSqlConn, "@o_nomcta", 1, SQLVARCHAR, (TxtNomCta.Text), "TxtNomCta", ""
  PMPasoValoresATX VGSqlConn, "@o_total", 1, SQLMONEY, (Total.Text), "Total", ""
  PMPasoValoresATX VGSqlConn, "@o_compro", 1, SQLINT4, "0", "Comprobante", ""
  PMPasoValoresATX VGSqlConn, "@o_motor", 1, SQLVARCHAR, "0", "Motor", ""
  PMPasoValoresATX VGSqlConn, "@o_chasis", 1, SQLVARCHAR, "0", "Chasis", ""
  PMPasoValoresATX VGSqlConn, "@o_periodo", 1, SQLVARCHAR, "0", "Periodo", ""
  PMPasoValoresATX VGSqlConn, "@o_fisco", 1, SQLMONEY, "0", "Fisco", ""
  PMPasoValoresATX VGSqlConn, "@o_adminis", 1, SQLMONEY, "0", "Administradora", ""
  PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, "0", "SecTrn", ""
  If FMTransmitirRPCATX(VGSqlConn, "", "cob_servicios", "sp_tr_pago_matrvehi_rc", True, "Transaccion Ok", "S", "N", "N", "78", "S", "S") = True Then
    TxtNomProp.Text = Mid$(FMRetParamATX(VGSqlConn, 1), 1, 50)
    Total.Text = FMRetParamATX(VGSqlConn, 3)
    PMChequeaATX VGSqlConn
    FLConsMatricula = True
    VLCambioMatri% = False
  Else
    TxtNomProp.Text = ""
    Total.Text = "0.00"
    TotPago.Text = "0.00"
    VLCambioMatri% = True
    FLConsMatricula = False
  End If
  PMChequeaATX VGSqlConn
  If FMRetStatusATX(VGSqlConn) <> 0 Then
     If Matricula.Enabled Then Matricula.SetFocus
     FLConsMatricula = False
  End If
  PMFinTransaccion
End Function

Sub PLFactura()
    'ame 08/03/2010
    
        '**************************************
    'GAMC - 02AGO10 - GUARDAR FACTURA - INI
    '**************************************
    If Comision.Text > 0 And VLDeb_com78 = 0# Then 'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
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
    fr_referencia = (Trim(Matricula.Text))
    fr_servicio = "Matricula de Vehiculo"
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

    If VLTotCom78 > 0 And VGTipoEjecucion = CGNormal% Then
    
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
        'PMSetDetalle "v" + "Costo Serv. Recaudacion  " + "Fecha: " + Format(VGFechaProceso, VGFormatoFecha$) + " " + IIf(VGHorarioDif, "H:D", "H:N")
        PMSetDetalle "v" + "Costo Serv. Recaudacion  " + "Fecha: " + VGFechaProceso2 + " " + IIf(VGHorarioDif, "H:D", "H:N")
        
        If Me.txt_rubro.Text = "02" Then
        PMSetDetalle "v" + "Matricula de Vehiculo" + FMEspaciosATX(Format(VLTotCom78, VGFormatoMoney), 8, CGJustificacionDerecha)
        Else
         PMSetDetalle "v" + "Ajuste del SRI" + FMEspaciosATX(Format(VLTotCom78, VGFormatoMoney), 8, CGJustificacionDerecha)
       End If
       
        PMSetDetalle "v" + "Subtotal:    " + FMEspaciosATX(Format(VlbaseImp, VGFormatoMoney), 8, CGJustificacionDerecha) + " " + "Iva 12%: " + FMEspaciosATX(Format(VLiva, VGFormatoMoney), 8, CGJustificacionDerecha)
        PMSetDetalle "v" + "VALOR TOTAL: " + FMEspaciosATX(Format(VLTotCom78, VGFormatoMoney), 8, CGJustificacionDerecha) + " " + "Referencia: " + (Matricula.Text)
     If VLTipo_imp = "O" Then
        PMSetDetalle "v" + "Caj: " + VGLogin$ + "              " + "Original: Adquiriente"
     Else
        PMSetDetalle "v" + "Caj: " + VGLogin$ + "              " + "Copia: Emisor"
     End If
        
        'PMSetDetalle "v" + " "
        
        VLEfe_com = "0"
        If VGModeloImp$ = "590" Then
            PMSetDetalle "%R" & 2
        End If
    
    
FMPRN_StdImpresion "IMPRESORA_1", False, "", "78", SGDatosDetalle, "Inserte COMPROBANTE Cobro Comision", CStr(VGpartop$), 1, CStr(VGparleft$), , , , , False, , VLTrn
'  'PAOLA PRUEBA
'

    
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
'        PMSetLineaImpresion "v" + "CI/RUC: " + (Replace(SGCedula, "_", "")) + "   " + "Ofic.: " + VGDes_Oficina$
'        'PMSetLineaImpresion "v" + "Costo Serv. Recaudacion  " + "Fecha: " + Format(VGFechaProceso, VGFormatoFecha$) + " " + Format(Now, VGFormatoHora$) + " " + IIf(VGHorarioDif, "H:D", "H:N")
'        PMSetLineaImpresion "v" + "Costo Serv. Recaudacion  " + "Fecha: " + Format(VGFechaProceso, VGFormatoFecha$) + " " + IIf(VGHorarioDif, "H:D", "H:N")
'        PMSetLineaImpresion "v" + "Matricula de Vehiculo" + FMEspaciosATX(Format(VLTotCom78, VGFormatoMoney), 8, CGJustificacionDerecha)
'        PMSetLineaImpresion "v" + "Subtotal:    " + FMEspaciosATX(Format(VLTotCom78, VGFormatoMoney), 8, CGJustificacionDerecha) + " " + "Iva 12%: " + FMEspaciosATX(Format(0, VGFormatoMoney), 8, CGJustificacionDerecha)
'        PMSetLineaImpresion "v" + "VALOR TOTAL: " + FMEspaciosATX(Format(VLTotCom78, VGFormatoMoney), 8, CGJustificacionDerecha) + " " + "Referencia: " + (Matricula.Text)
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
'        'VGHorarioDif = VLHorarioDifTemporal 'comenta ame 08/17/2010

    End If
    
End Sub

Sub PLTransmitir()
'Dim VLTotal As Currency   ' ame 08/25/2010
Dim I As Integer
Dim n As Integer
VLclave_acceso = "" '--ref02 vmirandt
 
    'TPE05/302006 Validacion Por moneda Base
    If VLMoneda <> VGmoneda% Then
        MsgBox "No Es Posible Aplicar un Pago en moneda diferente a la moneda Base.", vbExclamation
        If Cta.Enabled Then Cta.SetFocus
        Exit Sub
    End If
    
'TPE Validacion necesaria para No permitir Transacciones en caso de Valor Acumulado negativo
    If SGAcumulado < 0 And VGTipoEjecucion = CGNormal% Then
        MsgBox "Valor acumulado < 0 por Reverso. Transaccion No Permitida", vbInformation, "Mensaje del Sistema"
'        If Not FMSupervisor("08") Then
'            Unload Me
            Exit Sub
'        End If
    End If

  If VGTipoEjecucion = CGRedigitacion% Then
    If FMSecuencialReverso() = False Then
      Exit Sub
    End If
  End If
  
  
  If VGTipoEjecucion% <> CGReverso% Then
    If FLChequeos() = False Then
      Exit Sub
  End If
  
  
  End If
  
  
  If VLCambio = False And VGTipoEjecucion = CGNormal% Then
    MsgBox " Transaccion Repetida"
    Exit Sub
  End If
  '------> Sumadora
  'TPE Validacion de Monto Efectivo
  If (CDbl(Efectivo.Text) + VLEfe_com78) <> SGUsar Then
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

    'Validacion de emergencia
    If FMCCurATX(Total.Text) <> FMCCurATX(Efectivo.Text) + FMCCurATX(Cheque.Text) + FMCCurATX(Debito.Text) + FMCCurATX(Tarjeta.Text) Then
        MsgBox "No cuadran los totales en la sumadora, favor salga de la opción y vuelva a aplicar la transacción"
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

    '-->hy-18-junio-2007
    'pricaura Ini 08-ago-2019 Evitar flujos separados
'    If Tarjeta > 0 And VLFlagMultiFlujo = "S" Then
'        If FLTransmitirTarjeta() = False Then
'            If (SGAcumulado + SGAcumuladoAdi) = 0 Then
'                If Matricula.Enabled = True Then
'                    Matricula.SetFocus
'                End If
'            End If
'            'MsgBox "Transaccion No ha sido realizada intente nuevamente", vbInformation, "AVISO"
'            Exit Sub
'        End If
'        If VGTipoEjecucion = CGNormal% Then
'            If FLTransmitirDatos() = False Then
'                MsgBox "No existen datos de referencia de oficina", vbCritical, "Error"
'                Exit Sub
'            End If
'        End If
'    Else
'
'    '<--hy-18-junio-2007
'    If FLTransmitir() = False Then
'        'Sumadora ------->
'        If (SGAcumulado + SGAcumuladoAdi) = 0 Then
'            If Matricula.Enabled = True Then
'                Matricula.SetFocus
'            End If
'        End If
'        MsgBox "Transaccion No ha sido realizada intente nuevamente", vbInformation, "AVISO"
''        If Not FLTramaSwitch("R") Then
''            If Trim$(txtMensaje.Text) <> "" Then
''                MsgBox txtMensaje.Text, vbInformation, "Mensaje del sri"
''            Else
''                MsgBox "Transaccion No ha sido realizada intente nuevamente", vbInformation, "AVISO"
''            End If
''            Exit Sub
''        End If
'        Exit Sub
'    End If
'    End If  'hy-18-junio-2007
'
'
'  'If VGTipoEjecucion = CGNormal Then
'  '  PMMsgError "Tran OK:" + CStr(VGTSN), "", CGErrorInformativo
'  '  Me.SetFocus
'  'End If
'  If VGTipoEjecucion = CGReverso And VGReversoLoger = "S" Then
'    PMMsgError "Reverso OK", "", CGErrorInformativo
'    FReverso!grdValores(0).Col = 4
'    FReverso!grdValores(0).Text = "R"
'  End If


    If VGTipoEjecucion = CGNormal% And Tarjeta.Text > 0 Then
        If FLTransmitirDatos() = False Then
            MsgBox "No existen datos de referencia de oficina", vbCritical, "Error"
            Exit Sub
        End If
    End If

    
    If FLTransmitirUnificadoOsb() = False Then
        'Sumadora ------->
        If (SGAcumulado + SGAcumuladoAdi) = 0 Then
            If Matricula.Enabled = True Then
                Matricula.SetFocus
            End If
        End If
        MsgBox "Transaccion No ha sido realizada intente nuevamente", vbInformation, "AVISO"
'        If Not FLTramaSwitch("R") Then
'            If Trim$(txtMensaje.Text) <> "" Then
'                MsgBox txtMensaje.Text, vbInformation, "Mensaje del sri"
'            Else
'                MsgBox "Transaccion No ha sido realizada intente nuevamente", vbInformation, "AVISO"
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
    'pricaura Fin 08-ago-2019 Evitar flujos separados
    
    
    
  
 
  
  'LLAMADA A LA FUNCION DE FORMATOS DE REPORTES
  'VGparformato$ = "01"
  'If Not FMFormatPagina(VGparformato$, VGparlong$, VGpartop$, VGparleft$, VGparrig$) Then
     VGparlong$ = "90"
     VGpartop$ = "15"
     VGparleft$ = "00"
     VGparrig$ = "00"
    PMSetDetalle "v" + "BANCO BOLIVARIANO"
    PMSetDetalle "v" + " "
    'smerino ajustes
    If Me.txt_rubro.Text = "02" Then
        PMSetDetalle "v" + "MATRICULACION VEHICULAR"
    Else
       PMSetDetalle "v" + "AJUSTES VEHICULAR"
    End If
    PMSetDetalle "v" + "Ruc             :  " + "0990379017001"
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + "Fecha           : " + Format(VGFechaProceso, VGFormatoFecha$) + Space(2) + IIf(VGHorarioDif, "H:D", "H:N") + " " + IIf(VGTipoEjecucion = CGReverso, "REVERSO", "")
    'PMSetDetalle "v" + "Autorizacion SRI: " & txtLogRevSri.Text
    '<-hy-26-sep-2005
    PMSetDetalle "v" + "Propietario     : " + Mid$(Trim(TxtNomProp), 1, 25)
    PMSetDetalle "v" + "Ced/Ruc/Pas Prop: " + Trim(VLRucPropietario)
    PMSetDetalle "v" + "Placa/CPN/CAMV  : " + Trim(Matricula)
    PMSetDetalle "v" + "Chasis/VIN      : " + Trim(txtChasis.Text)
    PMSetDetalle "v" + "Log Autorizacion SRI: " + LOG_AUTORIZACION
    'PMSetDetalle "v" + "Sec             : " + Trim(Format(VGFechaProceso, "yyyymmdd") & SGSecTrn)
    
    n = 1
    If VGTipoEjecucion <> CGReverso Then
    n = 31
    'cambio por FMV
    For ina = 1 To Me.grdGrid.Rows - 1
       grdGrid.Row = ina
       grdGrid.Col = 2   ' ame 12/05/2011 descripcion del rubro
       VLTitulo1 = grdGrid.Text
       grdGrid.Col = 3
       VLValor1 = val(grdGrid.Text) / 100
       VLTitulo1 = Mid(VLTitulo1, 1, 49)  'ame 12/06/2011
       PMSetDetalle "v" + Trim$(VLTitulo1) + String(30 - Len(Trim$(VLTitulo1)), " ") + FMEspaciosATX("us$" + Format(VLValor1, "##,###,##0.00"), 2, CGJustificacionDerecha)  'ame 12/06/2011
    Next ina
   End If
   'PMSetDetalle "v" + "Valor Avaluo                                     " + FMEspaciosATX("us$" + Format(Str(val(VLValAvaluo) / 100), "##,###,##0.00"), 18, CGJustificacionDerecha)
   PMSetDetalle "v" + "Comision         :" + FMEspaciosATX("us$" + Format(str(val(Comision.Text)), "##,###,##0.00"), 18, CGJustificacionDerecha)
   PMSetDetalle "v" + "Valor Avaluo     :" + FMEspaciosATX("us$" + Format(str(val(VLValAvaluo)), "##,###,##0.00"), 18, CGJustificacionDerecha) 'Ref004
   PMSetDetalle "v" + "Valor Total      :" + FMEspaciosATX("us$" + Format((Total.Text), "##,###,##0.00"), 18, CGJustificacionDerecha)  'hy - antes estaba fisco + administracion y no total
   If VGmoneda% = 0 Then
      PMSetDetalle "v" + Mid(VGAgencia$, 1, 10) + " " + Mid(VGLogin$, 1, 8) + " " + Mid(Format(Now, VGFormatoHora$), 1, 5) + " " + Mid(CStr(VGTSN%), 1, 4) + " " + FMEspaciosATX(Format(Total, "########0"), 9, CGJustificacionDerecha)
   Else
      PMSetDetalle "v" + Mid(VGAgencia$, 1, 10) + " " + Mid(VGLogin$, 1, 8) + " " + Mid(Format(Now, VGFormatoHora$), 1, 5) + " " + Mid(CStr(VGTSN%), 1, 4)
   End If
   
   'For I = 1 To n
     PMSetDetalle "v" + " "
   'Next I
'***ref02 vmirandt inicio, se imprime al final del documento
    If VLclave_acceso <> "" Then
        PMSetDetalle "v" + "Clave de Acceso/Autorizacion: "
        PMSetDetalle "v" + VLclave_acceso
    End If
    'ref02 vmirandt
   
   VLHorarioDifTemporal = VGHorarioDif
   FMPRN_StdImpresion "IMPRESORA_1", False, Trim$(str$(VGTSN%)), "78", SGDatosDetalle, "Inserte papeleta para certificacion", CStr(VGpartop$), 1, CStr(VGparleft$), , , "", , , "1", VLTrn
   If VGTipoEjecucion = CGNormal% Then
      While MsgBox("Desea Reimprimir la papeleta para certificacion?", vbYesNo, "Mensaje") = vbYes
                PMReimpresion
      Wend
   End If
                 
  'End If
  ' FIN DE LLAMADA A LA FUNCION

   
       'ame 08/04/2010  factura cobro comision
    If VGTipoEjecucion% <> CGReverso% And VLTotCom78 > 0 Then
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
   
    '-->hy-18-junio-2007
    If VGTipoEjecucion <> CGReverso Then
        If Tarjeta > 0 And VLFlagMultiFlujo = "S" Then
            Dim VlRelleno As Integer
            If VGModeloImp$ = "5021" Or VGModeloImp$ = "590" Then
                VGpartop$ = "7"  ' Ubica la impresion con margen superior de n. Contando de abajo hacia arriba
                VGparleft$ = "0"
            End If
            PMSetDetalle "v" + Space(16) + "        BANCO BOLIVARIANO C.A"
            PMSetDetalle "v" + Space(16) + "    MATRICULACION VEHICULAR BB"
            PMSetDetalle "v" + Space(16) + "         RUC: 0990379017001"
            PMSetDetalle "v" + " "
            VlRelleno = 24 - Len(VGDes_Oficina$ + "(" + Trim$(str$(VGOficina)) + ")")
            If VlRelleno < 0 Then VlRelleno = 0
            PMSetDetalle "v" + "OFICINA        :" + VGDes_Oficina$ + "(" + Trim$(str$(VGOficina)) + ")" + String(VlRelleno, " ") + "FECHA EMISION   :" + Format(VGFechaProceso, VGFormatoFecha$)
            VlRelleno = 24 - Len(VLCiudadOficina)
            If VlRelleno < 0 Then VlRelleno = 0
            PMSetDetalle "v" + "LOCALIDAD      :" + VLCiudadOficina + String(VlRelleno, " ") + "HORA EMISION    :" + Format(Now, VGFormatoHora$)
            VlRelleno = 24 - Len(VLDireccionOficina)
            If VlRelleno < 0 Then VlRelleno = 0
            PMSetDetalle "v" + "DIREC/UBICACION:" + VLDireccionOficina + String(VlRelleno, " ") + "CODIGO COMERCIO : " + VLCodigoComercio
            VlRelleno = 24 - Len(VLTelefonoOficina)
            If VlRelleno < 0 Then VlRelleno = 0
            PMSetDetalle "v" + "TELEFONO       :" + VLTelefonoOficina + String(VlRelleno, " ")
            VlRelleno = 24 - Len(VGLogin)
            If VlRelleno < 0 Then VlRelleno = 0
            'smerino ajustes
            If Me.txt_rubro.Text = "02" Then
            PMSetDetalle "v" + "OPERADOR       :" + VGLogin + String(VlRelleno, " ") + "SERVICIO PAGAR  : MAT.VEHICULAR-SRI"
            Else
            PMSetDetalle "v" + "OPERADOR       :" + VGLogin + String(VlRelleno, " ") + "SERVICIO PAGAR  : AJUSTES-SRI"
            End If
            
            PMSetDetalle "v" + " "
            PMSetDetalle "v" + "NUM.LOTE       :" + Format(VGFechaProceso, "yyyymmdd") + String(16, " ") + "NUM.AUTORIZACION: " + VLNumAutorizaVisa
            VlRelleno = 23 - Len(VLVISA_fechaven)
            If VlRelleno < 0 Then VlRelleno = 0
            PMSetDetalle "v" + "FEC.VENCIMIENTO:" + "XX/XX" + String(VlRelleno, " ") + "NUM.TARJETA     :" + Mid$(VLVISA_numtar, 1, 6) + "XXXXXX" + Mid$(VLVISA_numtar, 13, 4)
            VlRelleno = 24 - Len(VLVISA_nombre)
            If VlRelleno < 0 Then VlRelleno = 0
            PMSetDetalle "v" + "NOMBRE CLIENTE :" + VLVISA_nombre + String(VlRelleno, " ")
            If VLVISA_tipoconsumo = "R" Then
                PMSetDetalle "v" + "TIPO CONSUMO   :ROTATIVO                MESES DIFERIR   : 0"
            Else
                PMSetDetalle "v" + "TIPO CONSUMO   :DIFERIDO CON INTERESES  MESES DIFERIR   : " + Trim$(str$(VLVISA_meses))
            End If
            PMSetDetalle "v" + "NUM.TRANSAC.   :" + VLNumTranAutorizaVisa
            'joel
            PMSetDetalle "v" + " "
            PMSetDetalle "v" + "BASE CONSUMO TARIFA 12%:" + FMEspaciosATX("us$" + Format("0", "##,###,##0.00"), 10, CGJustificacionDerecha)
            PMSetDetalle "v" + "BASE CONSUMO TARIFA 0% :" + FMEspaciosATX("us$" + Format((Tarjeta.Text), "##,###,##0.00"), 10, CGJustificacionDerecha)
            PMSetDetalle "v" + "SUBTOTAL CONSUMO       :" + FMEspaciosATX("us$" + Format((Tarjeta.Text), "##,###,##0.00"), 10, CGJustificacionDerecha)
            'PMSetDetalle "v" + "Valor Consumo  :" + FMEspaciosATX("us$" + Format((Tarjeta.Text), "##,###,##0.00"), 18, CGJustificacionDerecha)
            'PMSetDetalle "v" + "Cant.Cuotas    :" + Trim$(Str$(VLVISA_meses))
            
            'PMSetDetalle "v" + "Valor IVA      : 0.00"
            'PMSetDetalle "v" + "Valor Interes  : 0.00"
            'PMSetDetalle "v" + "Total          :" + FMEspaciosATX("us$" + Format((Tarjeta.Text), "##,###,##0.00"), 18, CGJustificacionDerecha)
            ' ame 08/25/2010
            PMSetDetalle "v" + "IVA 12%        :" + FMEspaciosATX(Format(("0.00"), "##,###,##0.00"), 18, CGJustificacionDerecha) '"0.00"
            PMSetDetalle "v" + "SUBTOTAL       :" + FMEspaciosATX("us$" + Format((Tarjeta.Text), "##,###,##0.00"), 18, CGJustificacionDerecha)
            PMSetDetalle "v" + "INTERESES      :" + FMEspaciosATX(Format(VLInteres, "##,###,##0.00"), 18, CGJustificacionDerecha) '
            PMSetDetalle "v" + "TOTAL          :" + FMEspaciosATX("us$" + Format((VLTotal), "##,###,##0.00"), 18, CGJustificacionDerecha)
            ' ame 08/25/2010
            
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
            FMPRN_StdImpresion "IMPRESORA_1", False, "", "78", SGDatosDetalle, "Inserte comprobante voucher adquiriente", CStr(VGpartop$), 1, CStr(VGparleft$), , , , , False
            PMFinImpresion "IMPRESORA_1"

            If VGModeloImp$ = "5021" Or VGModeloImp$ = "590" Then
                VGpartop$ = "7"  ' Ubica la impresion con margen superior de n. Contando de abajo hacia arriba
                VGparleft$ = "0"
            End If
            
            PMSetDetalle "v" + Space(16) + "        BANCO BOLIVARIANO C.A"
            PMSetDetalle "v" + Space(16) + "    MATRICULACION VEHICULAR BB"
            PMSetDetalle "v" + Space(16) + "         RUC: 0990379017001"
            PMSetDetalle "v" + Space(16) + "         COPIA-CLIENTE"
            PMSetDetalle "v" + " "
            VlRelleno = 24 - Len(VGDes_Oficina$ + "(" + Trim$(str$(VGOficina)) + ")")
            If VlRelleno < 0 Then VlRelleno = 0
            PMSetDetalle "v" + "OFICINA        :" + VGDes_Oficina$ + "(" + Trim$(str$(VGOficina)) + ")" + String(VlRelleno, " ") + "FECHA EMISION   :" + Format(VGFechaProceso, VGFormatoFecha$)
            VlRelleno = 24 - Len(VLCiudadOficina)
            If VlRelleno < 0 Then VlRelleno = 0
            PMSetDetalle "v" + "LOCALIDAD      :" + VLCiudadOficina + String(VlRelleno, " ") + "HORA EMISION    :" + Format(Now, VGFormatoHora$)
            VlRelleno = 24 - Len(VLDireccionOficina)
            If VlRelleno < 0 Then VlRelleno = 0
            PMSetDetalle "v" + "DIREC/UBICACION:" + VLDireccionOficina + String(VlRelleno, " ")
            VlRelleno = 24 - Len(VLTelefonoOficina)
            If VlRelleno < 0 Then VlRelleno = 0
            PMSetDetalle "v" + "TELEFONO       :" + VLTelefonoOficina + String(VlRelleno, " ")
            VlRelleno = 24 - Len(VGLogin)
            If VlRelleno < 0 Then VlRelleno = 0
            'smerino ajustes
            If Me.txt_rubro.Text = "02" Then
            PMSetDetalle "v" + "OPERADOR       :" + VGLogin + String(VlRelleno, " ") + "SERVICIO PAGAR  : MAT.VEHICULAR-SRI"
            Else
            PMSetDetalle "v" + "OPERADOR       :" + VGLogin + String(VlRelleno, " ") + "SERVICIO PAGAR  : AJUSTES-SRI"
            End If
            
            PMSetDetalle "v" + " "
            PMSetDetalle "v" + "NUM.LOTE       :" + Format(VGFechaProceso, "yyyymmdd") + String(16, " ") + "NUM.AUTORIZACION: " + VLNumAutorizaVisa
            VlRelleno = 23 - Len(VLVISA_fechaven)
            If VlRelleno < 0 Then VlRelleno = 0
            PMSetDetalle "v" + "FEC.VENCIMIENTO:" + "XX/XX" + String(VlRelleno, " ") + "NUM.TARJETA     :" + Mid$(VLVISA_numtar, 1, 6) + "XXXXXX" + Mid$(VLVISA_numtar, 13, 4)
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
            PMSetDetalle "v" + "TOTAL          :" + FMEspaciosATX("us$" + Format((VLTotal), "##,###,##0.00"), 18, CGJustificacionDerecha)
            ' ame 08/25/2010
            
            PMSetDetalle "v" + " "
            PMSetDetalle "v" + " "
            FMPRN_StdImpresion "IMPRESORA_1", False, "", "78", SGDatosDetalle, "Inserte comprobante voucher adquiriente", CStr(VGpartop$), 1, CStr(VGparleft$), , , , , False
            PMFinImpresion "IMPRESORA_1"

        End If
    End If
    '<--hy-18-junio-2007

  'Call Form_KeyDown(CGTeclaF2%, 0) 'Borrar la pantalla al término de la transacción
  If SGAcumulado = 0 Then
        Form_KeyDown CGTeclaF2%, 0
  Else
          Form_KeyDown CGTeclaF2%, -1
        'SGAcumulado = SGAcumulado + SGUsar
  End If

  SGActivaSum = False

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
  
  If VLTotCom78 <> FMCCurATX((Comision.Text)) Then   ' ps 28/01/2004
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
       If FMValidaCuenta(VLProd, Cta, "78") = False Then
         FLChequeos = False
         Exit Function
       End If
     End If
  End If
  
  If Len(Cta.ClipText) <> 0 Then
     If FMCCurATX((Debito.Text)) = 0# Or Debito.Text = "" Then
        MsgBox " El campo Debito: es Mandatorio"
        Debito.SetFocus
        FLChequeos = False
        Exit Function
     End If
  End If
  If val(CantChq.Text) <> 0 And val(Cheque.Text) = 0 Then
    MsgBox "Verificar campos Cant. de Cheques y Valor Cheques"
    FLChequeos = False
    CantChq.SetFocus
    Exit Function
  End If
  
    'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
    If FCC78.Cta.ClipText <> "" Then
        If VLDeb_com78 > 0 And FCC78.Cta.ClipText <> VLCta_com78 Then
            MsgBox "La cuenta de la comision debe ser la misma con la que realiza el pago del servicio."
            FLChequeos = False
            Comision.SetFocus
            Exit Function
        End If
    End If
    'msilvag Fin
  
  If VGTotalizar$ = "N" Then
     If Format(TotPago.Text, "###,###,###,##0.00") <> Format(FMCCurATX((Efectivo.Text)) + FMCCurATX((Cheque.Text)) + FMCCurATX((Debito.Text)) + FMCCurATX((Tarjeta.Text)) + FMCCurATX((Comision.Text)), "###,###,###,##0.00") Then
        MsgBox " El campo Total a cancelar no cuadra"
        FLChequeos = False
        If Efectivo.Enabled = True Then
            Efectivo.SetFocus
        End If
        Exit Function
     End If
  Else
     Total.Text = Format(FMCCurATX((Efectivo.Text)) + FMCCurATX((Cheque.Text)) + FMCCurATX((Debito.Text)) + FMCCurATX((Tarjeta.Text)), "###,###,###,##0.00")
  End If
End Function

Function FLTransmitir() As Integer
Dim VTIndicadorSum As Integer

     'Validacion de emergencia
    If FMCCurATX(Total.Text) <> FMCCurATX(Efectivo.Text) + FMCCurATX(Cheque.Text) + FMCCurATX(Debito.Text) + FMCCurATX(Tarjeta.Text) Then
        MsgBox "No cuadran los totales en la sumadora, favor salga de la opción y vuelva a aplicar la transacción"
        FLTransmitir = False
        VTIndicadorSum = 0
        Exit Function
    End If
    '---

    VTIndicadorSum = 0

    If VGHorarioDif Then
        VLTrn = "3331"
    Else
        VLTrn = "3142"
    End If
    VGTrn = IIf(VLTrn = "", 0, VLTrn)
    
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
 '   If VGTipoEjecucion% <> CGReverso% Then
'         PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLVARCHAR, "N", "TCORR", ""
  '  End If
    PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(FMObtenerMonedaForma("78")), "Moneda", ""
   ' PMPasoValoresATX VGSqlConn, "@i_tsn", 0, SQLINT4, Str(VGTSN%), "SecAut", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "P", "", ""
    PMPasoValoresATX VGSqlConn, "@i_matricula", 0, SQLVARCHAR, (Matricula.Text), "Matricula", ""
    PMPasoValoresATX VGSqlConn, "@i_efe", 0, SQLMONEY, (Efectivo.Text), "Efectivo", ""
    PMPasoValoresATX VGSqlConn, "@i_cheq", 0, SQLMONEY, (Cheque.Text), "Cheque", ""
    'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
    If Me.Cta.ClipText <> "" Then
        PMPasoValoresATX VGSqlConn, "@i_tipocta", 0, SQLVARCHAR, (CboTipCta.Text), "CboTipCta", ""
        PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
    Else
        PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (VLCta_com78), "Com. Cta", ""
        PMPasoValoresATX VGSqlConn, "@i_tipocta", 0, SQLCHAR, (VLTipCta_com78), "Com. TipCta", ""
    End If
    'msilvag FIn
    PMPasoValoresATX VGSqlConn, "@i_deb", 0, SQLMONEY, (Debito.Text), "Debito", ""
    PMPasoValoresATX VGSqlConn, "@i_tarjeta", 0, SQLMONEY, (Tarjeta.Text), "tarjeta", ""
    PMPasoValoresATX VGSqlConn, "@i_total", 0, SQLMONEY, (Total.Text), "Total", ""
    PMPasoValoresATX VGSqlConn, "@i_autoriza", 0, SQLCHAR, VGAutoriza, "Autorizacion", ""
    PMPasoValoresATX VGSqlConn, "@i_cant_chq", 0, SQLINT4, val(CantChq.Text), "CantChq", ""  'ame 23.may.03
    PMPasoValoresATX VGSqlConn, "@i_efe_com", 0, SQLMONEY, (VLEfe_com78), "Com. efectivo", ""
    PMPasoValoresATX VGSqlConn, "@i_chq_com", 0, SQLMONEY, (VLChq_com78), "Com. Cheques", ""
    PMPasoValoresATX VGSqlConn, "@i_deb_com", 0, SQLMONEY, (VLDeb_com78), "Com. Debito", ""
    
   
    'LBP Inicio RECA-CC-SGC00025869
    If VLEfe_com78 > 0 And VLChq_com78 > 0 And VLDeb_com78 > 0 Then
        VGFormaPago = "EFE;" & Format(VLEfe_com78, "#0.00") & "_" & "CHE;" & Format(VLChq_com78, "#0.00") & "_" & "DEB;" & Format(VLDeb_com78, "#0.00")
    ElseIf VLEfe_com78 > 0 And VLChq_com78 > 0 Then
        VGFormaPago = "EFE;" & Format(VLEfe_com78, "#0.00") & "_" & "CHE;" & Format(VLChq_com78, "#0.00")
    ElseIf VLEfe_com78 > 0 And VLDeb_com > 0 Then
        VGFormaPago = "EFE;" & Format(VLEfe_com78, "#0.00") & "_" & "DEB;" & Format(VLDeb_com78, "#0.00")
    ElseIf VLDeb_com78 > 0 And VLChq_com78 > 0 Then
        VGFormaPago = "DEB;" & Format(VLDeb_com78, "#0.00") & "_" & "CHE;" & Format(VLChq_com78, "#0.00")
    ElseIf VLEfe_com78 > 0 Then
        VGFormaPago = "EFE;" & Format(VLEfe_com78, "#0.00")
    ElseIf VLChq_com78 > 0 Then
        VGFormaPago = "CHE;" & Format(VLChq_com78, "#0.00")
    ElseIf VLDeb_com78 > 0 Then
        VGFormaPago = "DEB;" & Format(VLDeb_com78, "#0.00")
    End If
    'LBP Fin RECA-CC-SGC00025869
    
    If VGTipoEjecucion% <> CGReverso% Then
        PMPasoValoresATX VGSqlConn, "@i_cta_com", 0, SQLVARCHAR, (VLCta_com78), "Com. Cta", ""
        PMPasoValoresATX VGSqlConn, "@i_tipocta_com", 0, SQLCHAR, (VLTipCta_com78), "Com. TipCta", ""
        PMPasoValoresATX VGSqlConn, "@i_propietario", 0, SQLVARCHAR, TxtNomProp.Text, "Propietario", ""
    
        '-->hy-13-dic-2005
        PMPasoValoresATX VGSqlConn, "@i_motor", 0, SQLVARCHAR, VLtxtMotor, "Motor", ""
        PMPasoValoresATX VGSqlConn, "@i_chasis", 0, SQLVARCHAR, VLtxtChasis, "Chasis", ""
        PMPasoValoresATX VGSqlConn, "@i_cod_vehiculo", 0, SQLVARCHAR, VLtxtCodVehiculo, "CodVehiculo", ""
        PMPasoValoresATX VGSqlConn, "@i_mcn", 0, SQLVARCHAR, VLtxtMCN, "MCN", ""
        PMPasoValoresATX VGSqlConn, "@i_tranrevsri", 0, SQLVARCHAR, VLtxtTranRevSri, "Tranrevsri", ""
        PMPasoValoresATX VGSqlConn, "@i_logrevsri", 0, SQLVARCHAR, VLtxtLogRevSri, "Logrevsri", ""
        '<--hy-13-dic-2005
        
    Else
        'msilvag Inicio RECA-CC-SGC00030409 - Facturacion OffLine Debitos
        'PMPasoValoresATX VGSqlConn, "@i_cta_com", 0, SQLVARCHAR, "X", "Com. Cta", ""
        'PMPasoValoresATX VGSqlConn, "@i_tipocta_com", 0, SQLCHAR, "X", "Com. TipCta", ""
        PMPasoValoresATX VGSqlConn, "@i_cta_com", 0, SQLVARCHAR, (VLCta_com78), "Com. Cta", ""
        PMPasoValoresATX VGSqlConn, "@i_tipocta_com", 0, SQLCHAR, (VLTipCta_com78), "Com. TipCta", ""
        'msilvag Fin
        PMPasoValoresATX VGSqlConn, "@i_propietario", 0, SQLVARCHAR, "X", "Propietario", ""
    
        PMPasoValoresATX VGSqlConn, "@i_motor", 0, SQLVARCHAR, txtMotor.Text, "Motor", ""
        PMPasoValoresATX VGSqlConn, "@i_chasis", 0, SQLVARCHAR, txtChasis.Text, "Chasis", ""
        PMPasoValoresATX VGSqlConn, "@i_cod_vehiculo", 0, SQLVARCHAR, txtCodVehiculo.Text, "CodVehiculo", ""
        PMPasoValoresATX VGSqlConn, "@i_mcn", 0, SQLVARCHAR, txtMCN.Text, "MCN", ""
        PMPasoValoresATX VGSqlConn, "@i_tranrevsri", 0, SQLVARCHAR, txtTranRevSri.Text, "Tranrevsri", ""
        PMPasoValoresATX VGSqlConn, "@i_logrevsri", 0, SQLVARCHAR, txtLogRevSri.Text, "Logrevsri", ""
    End If
    '<--hy
    PMPasoValoresATX VGSqlConn, "@i_pcodcanalpagifi", 0, SQLVARCHAR, "VENTANILLA", "Ppsi_cod_canal_pago_ifi", ""
    PMPasoValoresATX VGSqlConn, "@i_pfeccontifi", 0, SQLVARCHAR, Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2), "Ppsio_fecha_contable_ifi", ""
    PMPasoValoresATX VGSqlConn, "@i_pprovifi", 0, SQLVARCHAR, Trim$(VLProvincia), "Ppsi_provincia_ifi", ""
    
      'smerino ajustes
    'If Me.txt_rubro.Text = "02" Then
      ' PMPasoValoresATX VGSqlConn, "@i_ptipodeuda", 0, SQLVARCHAR, "MATRICULA", "Ppsi_tipo_deuda", ""
   ' Else
       PMPasoValoresATX VGSqlConn, "@i_ptipodeuda", 0, SQLVARCHAR, VLTipoDeuda, "Ppsi_tipo_deuda", ""
    'End If
    'FIN SMERINO
    'smerino ajustes
       PMPasoValoresATX VGSqlConn, "@i_rubro", 0, SQLVARCHAR, Me.txt_rubro.Text, "Codrubro", ""
       PMPasoValoresATX VGSqlConn, "@i_desc_rubro", 0, SQLVARCHAR, Me.lbl_rubro.Caption, "DescRubro", ""
    'fin smerino ajustes
    

    VLValorPagar = Trim$(str$(CDbl(Total.Text) * 100))
    PMPasoValoresATX VGSqlConn, "@i_pvaltotpag", 0, SQLFLT8, CDbl(VLValorPagar), "Ppsi_tipo_tran", ""
    PMPasoValoresATX VGSqlConn, "@i_tipopago", 0, SQLVARCHAR, "O", "", ""  'hy-18-junio-2007
     
    'Joel Lozano 05/04/2012
    PMPasoValoresATX VGSqlConn, "@i_valor_iva_cero", 0, SQLMONEY, "0", "i_valor_iva_cero", ""    'JLF 05/04/2012
    PMPasoValoresATX VGSqlConn, "@i_valor_iva", 0, SQLMONEY, "000000000000", "i_valor_iva", ""  'JLF 05/04/2012
    
    If VGTipoEjecucion% <> CGReverso% Then
        PMPasoValoresATX VGSqlConn, "@o_nomprop", 1, SQLVARCHAR, (TxtNomProp.Text), "TxtNomProp", "" '1
        PMPasoValoresATX VGSqlConn, "@o_nomcta", 1, SQLVARCHAR, (TxtNomCta.Text), "TxtNomCta", "" '2
    Else
        PMPasoValoresATX VGSqlConn, "@o_nomprop", 1, SQLVARCHAR, "X", "TxtNomProp", "" '1
         PMPasoValoresATX VGSqlConn, "@o_nomcta", 1, SQLVARCHAR, "X", "TxtNomCta", "" '2
    End If
    PMPasoValoresATX VGSqlConn, "@o_total", 1, SQLMONEY, (Total.Text), "Total", "" '3
    PMPasoValoresATX VGSqlConn, "@o_compro", 1, SQLINT4, "0", "Comprobante", ""
    PMPasoValoresATX VGSqlConn, "@o_motor", 1, SQLVARCHAR, "0", "Motor", ""
    PMPasoValoresATX VGSqlConn, "@o_chasis", 1, SQLVARCHAR, "0", "Chasis", ""
    PMPasoValoresATX VGSqlConn, "@o_periodo", 1, SQLVARCHAR, "0", "Periodo", ""
    PMPasoValoresATX VGSqlConn, "@o_fisco", 1, SQLMONEY, "0", "Fisco", ""
    PMPasoValoresATX VGSqlConn, "@o_adminis", 1, SQLMONEY, "0", "Administradora", ""
    PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, "0", "SecTrn", ""
    If VGTipoEjecucion% <> CGReverso% Then
        PMPasoValoresATX VGSqlConn, "@o_autorisri", 1, SQLVARCHAR, VLautoriSri, "AutorizacionSRI", ""
        PMPasoValoresATX VGSqlConn, "@o_fecvensri", 1, SQLVARCHAR, VLFecvenSRI, "Stk", ""
    Else
        PMPasoValoresATX VGSqlConn, "@o_autorisri", 1, SQLVARCHAR, "X", "AutorizacionSRI", ""
        PMPasoValoresATX VGSqlConn, "@o_fecvensri", 1, SQLVARCHAR, "X", "Stk", ""
    End If
    '  PMPasoValoresATX VGSqlConn, "@o_consulta", 1, SQLINT4, (VTIndicadorSum), "SecTrn", ""
    
    '****** COMISION *******************************************************
    'If VLTotCom78 <> 0 Then
     PMPasoValoresATX VGSqlConn, "@o_nota_venta", 1, SQLVARCHAR, VLSerie_Secuencia, "Nota_venta", "" 'hy-24-feb-2005
    'End If
    '-->hy
'PARAMETROS CPS
    If VGTipoEjecucion% = CGReverso% Then
        VLSecTrnCorr = DatoSwitch("@o_ssn")
        PMPasoValoresATX VGSqlConn, "@o_ptranidrevifi", 0, SQLFLT8&, VLSecTrnCorr, "Ppni_id_tran_reverso_ifi", ""
        'PMPasoValoresATX VGSqlConn, "@t_ssn_corr1", 0, SQLINT4, Str(VLSecTrnCorr), "", "", True 'Reverso banco
    End If
    
    PMPasoValoresATX VGSqlConn, "@o_plogsri", 1, SQLVARCHAR, "0", "", ""
    PMPasoValoresATX VGSqlConn, "@o_pmcn", 1, SQLINT4, "0", "", ""
    PMPasoValoresATX VGSqlConn, "@o_precibo", 1, SQLINT4, "0", "", ""
  If FMTransmitirRPCATX(VGSqlConn, VLParametroServer, "cob_procesador", "sp_tr_pago_matrvehi_rc", True, "Transaccion Ok", "S", "N", "S", "78", "S", "S") = True Then
        ReDim psRetorno(2, 22)
        FMMapeaMatriz VGSqlConn, psRetorno
        PMMapeaGrid VGSqlConn, grdGrid, False
        VLLogSri = FMRetParamATX(VGSqlConn, 14)   'Log SRI
        VLMCN = FMRetParamATX(VGSqlConn, 15)  'MCN
        VLRecibo = FMRetParamATX(VGSqlConn, 16)    'Recibo
        
'Orden de retorno de los resultsets COBIS PS 06/07/2006
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
        LOG_AUTORIZACION = psRetorno(1, 6)
        If Len(Cta.ClipText) <> 0 Then
            TxtNomCta.Text = FMRetParamATX(VGSqlConn, 2)
        End If
        Comprobante = FMRetParamATX(VGSqlConn, 4)
        'motor = FMRetParamATX(VGSqlConn, 5)
        'chasis = FMRetParamATX(VGSqlConn, 6)
        'periodo = FMRetParamATX(VGSqlConn, 7)
        'fisco = FMRetParamATX(VGSqlConn, 8)
        'administracion = FMRetParamATX(VGSqlConn, 9)
        'TPE ------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 10)
        VLautoriSri = FMRetParamATX(VGSqlConn, 11)
        VLautoriSri = Trim(VLautoriSri)
        VLFecvenSRI = FMRetParamATX(VGSqlConn, 12)
        VLFecvenSRI = Trim(VLFecvenSRI)
        VLSerie_Secuencia = FMRetParamATX(VGSqlConn, 13)  'hy-24-feb-2005
        VLSerie_Secuencia = Trim(VLSerie_Secuencia)
        VTIndicadorSum = 1
        PMIniciaRegSum
        '<-----
        
        PMChequeaATX VGSqlConn
        FLTransmitir = True
        VLCambio% = False
      
    Else
        'TPE ------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 10)
        VTIndicadorSum = 0
        PMChequeaATX VGSqlConn
        '<------
        
        'TxtNomProp.Text = ""   'comenta smerino
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
         'Call PMGuardarDsglsBillete("78", SGSecTrn$, VLTrn, rptBAD, CboTipCta.Text, Cta.ClipText)
         Call PMGuardarDsglsBillete("78", SGSecTrn$, VLTrn, rptBAD, "REC", "")
         lectoraBill.Limpiar
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
   
Private Sub CantChq_Change()
  VLCambio% = True
End Sub

Private Sub CantChq_KeyDown(KeyCode As Integer, Shift As Integer)
  Select Case KeyCode%
    Case CGTeclaSUPR%
      CantChq.Text = ""
    'Case CGTeclaENTER%
    '  SendKeys "{TAB}"
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
 'VLValidaEfeCom = 0#  'hy-13-dic-2005  'hy-visa-credimatic
 If KeyCode% = CGTeclaF5% Then
    VLValidaEfeCom = 0#  'hy-visa-credimatic
    If Comision <> 0# Then
       '-- inicializo variables
       SGComision = 0#   'PS 29/01/2004
       SGTipoCta = ""    'PS 29/01/2004
       SGCedula = ""     'PS 29/01/2004
       
       'msilvag:Inicio RECA-CC-SGC00030409 - Facturacion OffLine Debitos
       SGNumCuenta = ""
       SGEmpresa = ""
       SGNumCuenta = Me.Cta.Text
       
       If Me.txt_rubro.Text = "01" Then
        SGEmpresa = "SRIAJU"
       Else
        SGEmpresa = "SRIMATRI"
       End If
       'msilvag Fin
 
       VLAcum78 = SGAcumulado
       
       VGUsar15 = Efectivo.ValueReal
       
       SGUsar = VLEfe_com78
       
       SGComision = Comision
       SGTipoCta = FCC78.CboTipCta.ListIndex  'Me.CboTipCta.ListIndex
       SGValida = "S"
       
       FCC112.Show 1
       VLEfe_com78 = FCC112.VLEfe_com
       VLChq_com78 = FCC112.VLChq_com
       VLDeb_com78 = FCC112.VLDeb_com
       VLTipCta_com78 = FCC112.VLTipCta_com
       VLCta_com78 = FCC112.VLCta_com
       VLTotCom78 = VLEfe_com78 + VLChq_com78 + VLDeb_com78
       
       VLValidaEfeCom = VLEfe_com78  'hy-13-dic-2005
       
       VLNombre = SGNombre
       
       SGUsar = VGUsar15
       Efectivo.ValueReal = SGUsar

       SGAcumulado = VLAcum78
       VGUsar15 = VLEfe_com78
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
    VLfirma = FMValidaFirma(VLfirma, CboTipCta.Text, Cta, "78", TxtNomCta, VLMoneda, VLDescMonCta)
    VTipoDatoCta = LoNombreCta(CboTipCta.Text, Cta.ClipText, "78")  'jlf  05AGO2006  PARA TRAER EL NOMBRE DE LA CTA
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
      Cheque.Text = FMCalculadora(FMObtenerTitulo("78") + "Cheque:", 14, "78")
      SendKeys "{TAB}"
    Case CGTeclaPOR%
      Cheque.Text = FMSumadora(FMObtenerTitulo("78") + "Cheque:", 14, "78")
    Case CGTeclaHOME%
      PMCambiarForma Me
    Case CGTeclaUP%, CGTeclaREPAG%
      CantChq.SetFocus
    Case CGTeclaDOWN%, CGTeclaAVPAG%
      SendKeys "{TAB}"
  End Select
End Sub

Private Sub Cheque_KeyPress(KeyAscii As Integer)
  KeyAscii = FMValidarNumero((Cheque.Text), VGLongitudMoney, KeyAscii, "78")
End Sub

Private Sub Cheque_LostFocus()
  If VGDecimales$ = "S" And (FMObtenerDecimales(FMObtenerMonedaForma("78")) > 0) Then
    Cheque.Text = str(FMCCurATX((Cheque.Text)) / FMObtenerFactorDecimal(FMObtenerMonedaForma("78")))
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
      Debito.Text = FMCalculadora(FMObtenerTitulo("78") + "Debito:", 14, "78")
      SendKeys "{TAB}"
    Case CGTeclaPOR%
      Debito.Text = FMSumadora(FMObtenerTitulo("78") + "Debito:", 14, "78")
    Case CGTeclaHOME%
      PMCambiarForma Me
    Case CGTeclaUP%, CGTeclaREPAG%
      Cta.SetFocus
    Case CGTeclaDOWN%, CGTeclaAVPAG%
      SendKeys "{TAB}"
  End Select
End Sub

Private Sub Debito_KeyPress(KeyAscii As Integer)
  KeyAscii = FMValidarNumero((Debito.Text), VGLongitudMoney, KeyAscii, "78")
End Sub

Private Sub Debito_LostFocus()
  If VGDecimales$ = "S" And (FMObtenerDecimales(FMObtenerMonedaForma("78")) > 0) Then
     Debito.Text = str(FMCCurATX((Debito.Text)) / FMObtenerFactorDecimal(FMObtenerMonedaForma("78")))
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
    '      SendKeys "{TAB}"
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
      Efectivo.Text = FMCalculadora(FMObtenerTitulo("78") + "Efectivo:", 14, "78")
      SendKeys "{TAB}"
    Case CGTeclaPOR%
      Efectivo.Text = FMSumadora(FMObtenerTitulo("78") + "Efectivo:", 14, "78")
    Case CGTeclaHOME%
      PMCambiarForma Me
    Case CGTeclaUP%, CGTeclaREPAG%
      Matricula.SetFocus
    Case CGTeclaDOWN%, CGTeclaAVPAG%
      SendKeys "{TAB}"
  End Select
End Sub

Private Sub Efectivo_KeyPress(KeyAscii As Integer)
  KeyAscii = FMValidarNumero((Efectivo.Text), VGLongitudMoney, KeyAscii, "78")
End Sub


Private Sub Efectivo_LostFocus()
    'EAS: Evita procesar el lostfocus cuando se carga Sumadora
    If SGActivaSum = True Then
        Exit Sub
    End If
  
    If VGDecimales$ = "S" And (FMObtenerDecimales(FMObtenerMonedaForma("78")) > 0) Then
        Efectivo.Text = str(FMCCurATX((Efectivo.Text)) / FMObtenerFactorDecimal(FMObtenerMonedaForma("78")))
    End If
    If VGTotalizar$ = "S" Then
        If Efectivo.Text <> "" Or Efectivo.Text <> "0.00" Then
            Total.Text = str(FMCCurATX((Efectivo.Text)) + FMCCurATX((Cheque.Text)) + FMCCurATX((Debito.Text)))
        End If
    End If
      'Sumadora ------>
    If CDbl(Efectivo.Text) <> SGUsar Then
        MsgBox "El Monto Efetivo No coincide con el Monto desglosado para el Deposito. Verificar", vbCritical, "Mensaje del Sistema"
        Efectivo.SetFocus
        Efectivo.Text = Format$(SGUsar, "####,###,##0.00")
        SGActual = 0
    End If
    '<------
    SGActivaSum = False
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
    Consulta_Parametro  'PHOYOSV REF_03 20180710
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
If Shift = CGTeclaCTRL% + CGTeclaALT% And KeyCode% = CGTeclaF9% Then
    PMObtenerMonedaForma "78"
    Exit Sub
 End If
If Shift = CGTeclaCTRL% And KeyCode% = CGTeclaI% Then
    PMReimpresion
    Exit Sub
 End If
If Shift = CGTeclaCTRL% And KeyCode% = CGTeclaF2% Then
   If VGTipoEjecucion% = CGNormal% Then
     PMSetEjecucionReverso
     If FMSupervisor("78") = True Then
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
       'Consulta_Parametro   'PHOYOSV REF_03 20180709
       PLTransmitir
       VGReversoLoger = "N"
       Unload Me
     End If
   Case CGTeclaF1%
     If VGTipoEjecucion% <> CGReverso% Then
        Consulta_Parametro   'PHOYOSV REF_03 20180709
        If Not Frame.Enabled Then
            Exit Sub
        End If
        'PHOYOSV INI REF_03 20180913 se comenta uso de llave publica por CSP
        'JPM 14/09/2012: obtener llave publica ---> COMENTA SMERINO AJUISTES
        'If Trim(VXmlPublicKey) = "" Then
        '  If ObtieneLlavePublica = False Then
        '      Exit Sub
        '   End If
        'End If
        '<--- JPM 14/09/2012: obtener llave publica
        'PHOYOSV FIN REF_03 20180913 se comenta uso de llave publica por CSP
        SGUsar = Efectivo.ValueReal + VLEfe_com78
        PLTransmitir
     End If
   Case CGTeclaESC%
     Unload Me
   Case CGTeclaHOME%
     PMCambiarForma Me
   Case CGTeclaF2%
     VLMoneda = VGmoneda%
     VLDescMonCta = ""
     Consulta_Parametro   'PHOYOSV REF_03 20180709
     If VGTipoEjecucion% <> CGNormal% Then
        Exit Sub
     End If
     Frame.Enabled = False
     VLfirma = False
     Matricula.Enabled = True
     'If Matricula.Enabled Then
      ' Matricula.SetFocus 'smerino ajustes comenta serino
     'End If
     'Total.Enabled = True
     Matricula.Clear
     Efectivo.Text = "0.00"
     CantChq.Text = ""
     Cheque.Text = "0.00"
     CboTipCta.ListIndex = 0
     Cta.Clear
     Debito.Text = "0.00"
     Tarjeta.Text = "0.00"
     Total.Text = "0.00"
     TotPago.Text = "0.00"
     TxtNomCta.Text = ""
    TxtNomProp.Text = ""
     VGAutoriza = "N"
     
    'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
    SGNumCuenta = ""
    SGEmpresa = ""
    'msilvag Fin
     
    'LBP Inicio RECA-CC-SGC00025869 30/07/2016
    VGFormaPago = ""
    VGCom_aux = 0
    VGComision_original = 0
    VGCompensacion = 0
    VGPorcentajeComp = "0"
    VGPorcentajeIVA = "0"
    'LBP Fin 30/07/2016'Fin LBP
     
     Me.txt_rubro.Text = "" 'smerino ajustes
     Me.lbl_rubro.Caption = "" 'smerino ajustes
    Me.txt_rubro.SetFocus 'smerino ajustes
     Me.lbl_deuda.Visible = True 'smerino ajustes
     
     
     VLTotCom78 = 0#      ' ps 26/01/2004
     VLEfe_com78 = 0#     ' ps 26/01/2004
     VLChq_com78 = 0#     ' ps 26/01/2004
     VLDeb_com78 = 0#     ' ps 26/01/2004
     VLCta_com78 = ""     ' ps 26/01/2004
     VLTipCta_com78 = ""  ' ps 26/01/2004
     VLValidaEfeCom = 0#  'hy-13-dic-2005
          
     PMLimpiarTransaccion "78"
    '------> Sumadora
    SGUsar = 0
    VGUsar15 = 0
    If Shift = 0 _
    And VGTipoConsAutom% = 0 _
    And VGTipoEjecucion% <> CGReverso% Then  'TPEAdiciono Validacion Por Consulta Automatica y Reverso
        SGActual = 1
        FSumIng.Hide
        FSumIng.Form_KeyDown CGTeclaF2%, 0
        Unload FSumIng
        'If Matricula.Enabled Then Matricula.SetFocus 'smerino ajustes comenta
    'End If 'smerino ajustes comenta
    
     If Me.txt_rubro.Enabled Then Me.txt_rubro.SetFocus 'smerino ajustes
    End If 'smerino ajustes
    
    
    SGActivaSum = False
    '<------
    lectoraBill.Limpiar       'JPM lectora de billetes
   Case CGTeclaF3%
    'Unload Me
    'Sumadora ------>
     If VGTipoEjecucion% <> CGReverso% Then
            If (VGTipoConsAutom% = 1 _
            And VGStatusCon = "A") _
            Or VGTipoConsAutom% = 0 Then
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
     If Frame.Enabled Then
        Exit Sub
     End If
     
     If Len(Matricula.Text) = 0 And Me.txt_rubro.Text <> "" Then 'smerino ajustes
        MsgBox "El campo Matricula: es Mandatorio"
        Matricula.SetFocus
     Else
        If VLCambioMatri% = True Then
            Efectivo.Text = "0.00"
            CantChq.Text = ""
            Cheque.Text = "0.00"
            CboTipCta.ListIndex = 0
            Cta.Clear
            Debito.Text = "0.00"
            Tarjeta.Text = "0.00"
            Total.Text = "0.00"
            TxtNomCta.Text = ""
            TxtNomProp.Text = ""
            PMLimpiarTransaccion "78"
            Me.Enabled = False
            txtmensaje.Text = ""
            
            'If Not FLTramaSwitch("C") Then
            'CPS-MAY2006 FMV - CAMBIAR LLAMADA AL FLUJO
            If FLConsMatriculaCPS() = False Then
                'If Trim$(txtMensaje.Text) <> "" Then
                '    MsgBox txtMensaje.Text, vbInformation, "Mensaje del sri"
                'Else
                '    MsgBox "Transaccion No ha sido realizada intente nuevamente", vbInformation, "AVISO"
                'End If
                Me.Enabled = True
                Exit Sub
            End If
            Me.Enabled = True
            Frame.Enabled = True
            Total.Enabled = False
            Efectivo.SetFocus
            
            'If FLConsMatricula() = True Then
               'Total.Enabled = False
            '   Efectivo.SetFocus
            'End If
        End If
     End If

  Case CGTeclaF9%
    If VGTipoEjecucion% = CGNormal% Then
       If FMSupervisor("78") = True Then
          If Trim(str(FMObtenerMonedaForma("78"))) = "1" Then
             moneda = "DOLAR"
          Else
             moneda = "SUCRES"
          End If
          PMMsgError "ESTA AUTORIZANDO UN MONTO DE:      " + Total.Text + " " + moneda, "", CGErrorInformativo
          VGAutoriza = "S"
       End If
    End If
    If Matricula.Enabled Then
       Matricula.SetFocus
    End If
     
 End Select
End Sub

Private Sub Form_Load()
  'CGLongTramaBill = CadenaLarga   'JPM lectora de billetes
  CGLongTramaBill = CadenaCorta   'JPM lectora de billetes
  lectoraBill.Limpiar             'JPM lectora de billetes
  'Sumadora  ----->
  SGUsar = 0
  SGActivaSum = False
  SGActual = 1
  '<-----
  'Inicio Moneda
  VLMoneda = VGmoneda%
  
  VLTotCom78 = 0#     ' ps 26/01/2004
  VLEfe_com78 = 0#    ' ps 26/01/2004
  VLChq_com78 = 0#    ' ps 26/01/2004
  VLDeb_com78 = 0#    ' ps 26/01/2004
  VLCta_com78 = ""    ' ps 26/01/2004
  VLTipCta_com78 = "" ' ps 26/01/2004
  
    'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
    SGNumCuenta = ""
    SGEmpresa = ""
    'msilvag Fin
  
    'LBP Inicio RECA-CC-SGC00025869 30/07/2016
    VGFormaPago = ""
    VGCom_aux = 0
    VGComision_original = 0
    VGCompensacion = 0
    VGPorcentajeComp = "0"
    VGPorcentajeIVA = "0"
    'LBP Fin 30/07/2016'Fin LBP
  
    '-->hy-18-junio-2007
    ReDim VTArreglo(30) As String
    PMChequea VGSqlConn&
    PMPasoValores VGSqlConn, "@t_trn", 0, SQLINT2, 1579
    PMPasoValores VGSqlConn&, "@i_operacion", 0, SQLVARCHAR, "Q"
    PMPasoValores VGSqlConn&, "@i_nemonico", 0, SQLVARCHAR, "FMMV"
    PMPasoValores VGSqlConn&, "@i_producto", 0, SQLVARCHAR, "CTE"
    If FMTransmitirRPC(VGSqlConn, "", "cobis", "sp_parametro", True, "Transaccion Ok") = True Then
        VTR1% = FMMapeaArreglo(VGSqlConn&, VTArreglo())
        VLFlagMultiFlujo = LTrim(RTrim(Trim(VTArreglo(4))))
    Else
        VLFlagMultiFlujo = "N"
    End If
    PMChequea VGSqlConn&
    If VLFlagMultiFlujo = "S" Then
        Tarjeta.ReadOnly = True
    Else
        Tarjeta.ReadOnly = False
    End If
    '<--hy-18-junio-2007
   
  VLfirma = False
  VLCambio% = False
  VLCambioMatri% = False
  Me.Move VGLeft%, VGTop%, 4600, 5640  'smerinom  Ajuste
  
  CboTipCta.AddItem "CTE"
  
  CboTipCta.AddItem "AHO"
  CboTipCta.ListIndex = 0
  
  Efectivo.DecimalPlaces = FMObtenerDecimales(VGmoneda%)
  Cheque.DecimalPlaces = FMObtenerDecimales(VGmoneda%)
  Debito.DecimalPlaces = FMObtenerDecimales(VGmoneda%)
  Tarjeta.DecimalPlaces = FMObtenerDecimales(VGmoneda%)
  Total.DecimalPlaces = FMObtenerDecimales(VGmoneda%)
  TotPago.DecimalPlaces = FMObtenerDecimales(VGmoneda%)
  moneda = str(VGmoneda%)
   
'   '-->hy-18-junio-2007 SMERINO OJOOOOOO
'    PMChequea VGSqlConn&
'    PMPasoValores VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "svcodcomercio"
'    PMPasoValores VGSqlConn&, "@i_tipo", 0, SQLCHAR, "V"
'    PMPasoValores VGSqlConn&, "@i_codigo", 0, SQLVARCHAR, "COD78"
'   If FMTransmitirRPC(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "") Then
'        PMMapeaVariableATX VGSqlConn&, VLCodigoComercio
'        PMChequea VGSqlConn&
'    Else
'        VLCodigoComercio = ""
'        PMChequea VGSqlConn&
'    End If
'
'    ' Else PMPasoValores VGSqlConn&, "@i_codigo", 0, SQLVARCHAR, "COD77"
'    PMChequea VGSqlConn&
'    PMPasoValores VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "svcodcomercio"
'    PMPasoValores VGSqlConn&, "@i_tipo", 0, SQLCHAR, "V"
'    PMPasoValores VGSqlConn&, "@i_codigo", 0, SQLVARCHAR, "COD77"
'   If FMTransmitirRPC(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "") Then
'        PMMapeaVariableATX VGSqlConn&, VLCodigoComercioAjus
'        PMChequea VGSqlConn&
'    Else
'        VLCodigoComercio = ""
'        PMChequea VGSqlConn&
'    End If
'
'    PMChequea VGSqlConn&
'    PMPasoValores VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "svcodcomercio"
'    PMPasoValores VGSqlConn&, "@i_tipo", 0, SQLCHAR, "V"
'    PMPasoValores VGSqlConn&, "@i_codigo", 0, SQLVARCHAR, "NOM78"
' If FMTransmitirRPC(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "") Then
'        PMMapeaVariableATX VGSqlConn&, VLNombreComercio
'        PMChequea VGSqlConn&
'    Else
'        VLCodigoComercio = ""
'        PMChequea VGSqlConn&
'    End If
'
'    'PMPasoValores VGSqlConn&, "@i_codigo", 0, SQLVARCHAR, "NOM77"
'        PMChequea VGSqlConn&
'    PMPasoValores VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "svcodcomercio"
'    PMPasoValores VGSqlConn&, "@i_tipo", 0, SQLCHAR, "V"
'    PMPasoValores VGSqlConn&, "@i_codigo", 0, SQLVARCHAR, "NOM77"
' If FMTransmitirRPC(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "") Then
'        PMMapeaVariableATX VGSqlConn&, VLNombreComercioAjus
'        PMChequea VGSqlConn&
'    Else
'        VLCodigoComercio = ""
'        PMChequea VGSqlConn&
'    End If
    
   '<--hy-18-junio-2007
   
   'smerino ajustes
    If VGTipoLogon% = CGNormal% Then
    txt_rubro.Connection = VGMap
    Set txt_rubro.AsociatedLabel = Me.lbl_rubro
    txt_rubro.Enabled = True
  End If
  'fin smerino ajustes
  
   
   
  If VGTipoEjecucion% = CGReverso% Or VGTipoEjecucion% = CGAutoriza% Then
     If VGTipoEjecucion% = CGReverso% Then
        'Valores de Comision
        PMSetValorReverso Comision, "@i_efe_com"
        VLEfe_com78 = Comision.ValueReal
        PMSetValorReverso Comision, "@i_chq_com"
       VLChq_com78 = Comision.ValueReal
        PMSetValorReverso Comision, "@i_deb_com"
        VLDeb_com78 = Comision.ValueReal
        VLTotCom78 = VLEfe_com78 + VLChq_com78 + VLDeb_com78
        Comision = VLTotCom78
        PMSetValorReverso Cta, "@i_cta_com"
        VLCta_com78 = Me.Cta.ClipText
        PMSetValorReverso CboTipCta, "@i_tipocta_com"
        VLTipCta_com78 = CboTipCta.Text
        
        PMSetValorReverso Matricula, "@i_matricula"
        PMSetValorReverso Efectivo, "@i_efe"
        PMSetValorReverso Cheque, "@i_cheq"
        PMSetValorReverso CboTipCta, "@i_tipocta"
        PMSetValorReverso Cta, "@i_cuenta"
        PMSetValorReverso Debito, "@i_deb"
        PMSetValorReverso Tarjeta, "@i_tarjeta"
        PMSetValorReverso Total, "@i_total"
        PMSetValorReverso moneda, "@i_mon"
        PMSetValorReverso CantChq, "@i_cant_chq"
        
        'smerino ajustes
        PMSetValorReverso txt_rubro, "@i_rubro"
        PMSetValorReverso lbl_rubro, "@i_desc_rubro"
        PMSetValorReverso Me.txt_tipo_deuda, "@i_ptipodeuda"
        VLTipoDeuda = Me.txt_tipo_deuda.Text
        'fin smerino ajustes
        
      '-->hy-24-feb-2005
      'JPM 14/09/2012 --->
      Dim VLTipoPago As String
      PMSetValorReverso txtTempo, "@i_tipopago"
      VLTipoPago = Trim$(txtTempo.Text)
      If VLTipoPago <> "T" Then
      ' deshabilitar, recuperar parametro solo si forma de pago no utiliza Tarjeta
        PMSetValorReverso txtNotaVenta, "@o_nota_venta"
        VLSerie_Secuencia = txtNotaVenta.Text
      End If
      PMSetValorReverso txtTempo, "@t_trn"
      Select Case txtTempo
        Case "62060", "62061", "62062", "62063":  VLVISA_tipoconsumo = "R"
        Case Else:     VLVISA_tipoconsumo = ""
      End Select
      '<--- JPM 14/09/2012
      '<--hy-24-feb-2005
      '-->hy
      
      PMSetValorReverso txtMCN, "@i_mcn"
      PMSetValorReverso txtCodVehiculo, "@i_cod_vehiculo"
      PMSetValorReverso txtTranRevSri, "@i_tranrevsri"
      PMSetValorReverso txtLogRevSri, "@i_logrevsri"
      PMSetValorReverso TxtNomProp, "@i_propietario"
      PMSetValorReverso txtMotor, "@i_motor"
      PMSetValorReverso txtChasis, "@i_chasis"
      
      PMSetValorReverso txtTempo, "@i_pfeccontifi"
      VLFecContable = txtTempo
      
      PMSetValorReverso txtTempo, "@i_pprovifi"
      VLProvincia = txtTempo
      
      '<--hy
      '-->hy-18-junio-2007
      If VLFlagMultiFlujo = "S" Then
        'PMSetValorReverso txtTempo, "@i_tipopago"      'JPM deshabilitar
        'If Trim$(txtTempo.Text) = "T" Then             'JPM deshabilitar
        If VLTipoPago = "T" Then
              PMSetValorReverso txtTempo, "@o_pauthnumber"
              VLVISA_autorizacion = Trim$(txtTempo.Text)
              PMSetValorReverso txtTempo, "@o_psystemtauditNumber"
              VLVISA_ssn_corr1 = Trim$(txtTempo.Text)
              PMSetValorReverso txtTempo, "@i_ptarjeta"
              'VLVISA_numtar = Trim$(txtTempo.Text)                 'JPM 14/09/2012: se deshabilita por venir enmascarado
              VLVISA_numtar_mask = Trim$(txtTempo.Text)             'JPM 14/09/2012: recuperar num.tarjeta enmascarado
              PMSetValorReverso txtTempo, "@i_pfechaexpiracion"
              VLVISA_fechaven = Trim$(txtTempo.Text)
              'JPM 14/09/2012 --->
              'armar numero de tarjeta encriptada y fraccionada     'JPM 14/09/2012: verificar la afectación en las trn 19 y 136
              PMSetValorReverso txtTempo, "@i_tja"
              VLVISA_numtar = Trim$(txtTempo.Text)
              PMSetValorReverso txtTempo, "@i_tjb"
              VLVISA_numtar = VLVISA_numtar & Trim$(txtTempo.Text)
              
              'cambio en el modo manejo de cvv2
              'VLVISA_cvv2 = Trim$(txtTempo.Text)
              'arma cadena cvv2 fraccionada
              PMSetValorReverso txtTempo, "@i_cvva"
              VLVISA_cvv2 = Trim(Trim$(txtTempo.Text))
              
              PMSetValorReverso txtTempo, "@i_cvvb"
              VLVISA_cvv2 = VLVISA_cvv2 & Trim$(txtTempo.Text)
              '<--- JPM 14/08/2012
              PMSetValorReverso txtTempo, "@i_pinfodiferido"
              VLVISA_meses = Trim$(txtTempo.Text)
              PMSetValorReverso txtTempo, "@i_banda_sn"
              VLVISA_banda_sn = Trim$(txtTempo.Text)

'              If Trim$(VLVISA_banda_sn) = "S" Then  'PHOYOSV REF_03 20181108 Se comenta
              'JPM 14/09/2012 --->
              'si la lectura es por Banda se convierte en Manual se comenta el bloque
'                  PMSetValorReverso txtTempo, "@i_ptrack1"
'                  VLVISA_track1 = Trim$(txtTempo.Text)
'                  PMSetValorReverso txtTempo, "@i_ptrack1a"
'                  'VLVISA_track1 = VLVISA_track1 + Trim$(txtTempo.Text) 'comenta joel
'                  PMSetValorReverso txtTempo, "@i_ptrack1b"
'                  VLVISA_track1 = VLVISA_track1 + Trim$(txtTempo.Text)
'                  PMSetValorReverso txtTempo, "@i_ptrack1c"
'                  VLVISA_track1 = VLVISA_track1 + Trim$(txtTempo.Text)
'                  PMSetValorReverso txtTempo, "@i_ptrack2"
'                  VLVISA_track2 = Trim$(txtTempo.Text)
'                  PMSetValorReverso txtTempo, "@i_ptrack2a"
'                  'VLVISA_track2 = VLVISA_track2 + Trim$(txtTempo.Text) comenta joel
              '<--- JPM 14/08/2012
'              End If                                'PHOYOSV REF_03 20181108 Se comenta
              PMSetValorReverso txtTempo, "@i_nombre"
              VLVISA_nombre = Trim$(txtTempo.Text)
          End If
      End If
      '<--hy-18-junio-2007

        SGUsar = CDbl(Efectivo.Text) + CDbl(VLEfe_com78)  'por reverso sumadora
        TotPago.Text = CDbl(Total.Text) + CDbl(Comision.Text)
     End If
  End If
  If moneda = 0 Then
     bitmap.Picture = LoadPicture(VGDirBitmaps$ & "\sucres.bmp")
     Frame = Space(15) + "PAGO DE MATRICULAS SUCRES"
     LblTipCta.Enabled = False
     CboTipCta.Enabled = False
     LblCuenta.Enabled = False
     Cta.Enabled = False
     LblDebito.Enabled = False
     Debito.Enabled = False
  Else
     bitmap.Picture = LoadPicture(VGDirBitmaps$ & "\dolares.bmp")
     Frame = Space(15) + "PAGO DE MATRICULAS DOLARES"
  End If
  bitmap.Visible = True
  Total.Enabled = False
  VLValidaEfeCom = 0#  'hy-13-dic-2005

    If Not (VGMatrizSwitchFlagSRI) Then
        VGDatosConexionSRI = FMParametroUpLoadDll("IPSW", "CTE")
        VGMatrizSwitchFlagSRI = True
    End If
    
    Frame.Enabled = False

End Sub


Private Sub Form_Unload(Cancel As Integer)
  VGUsar15 = 0
  PMCerrarForma "78"
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
 'PMInicioTransaccion
 ' PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "cl_costo_serv_comision", "", ""
  'PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR&, "V", "", ""
  'PMPasoValoresATX VGSqlConn&, "@i_codigo", 0, SQLCHAR&, "MATVEH", "", ""
  'If FMTransmitirRPCATX(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "", "N", "S", "I", "0", "N", "N") Then
   ' PMMapeaObjetoATX VGSqlConn&, Comision
   ' TotPago.Text = CDbl(Total.Text) + CDbl(Comision)
   ' PMChequeaATX VGSqlConn&
   ' PMFinTransaccion
 ' Else
   ' Comision = 0#
   ' PMChequeaATX VGSqlConn&
   ' PMFinTransaccion
  'End If
' 'CONSULTA TASA DEL IVA Y BASE IMPONBLE SMERINO AJUSTE
   PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 4050, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLVARCHAR, "C", "opcion", ""
    PMPasoValoresATX VGSqlConn, "@i_servi_person", 0, SQLVARCHAR, "SRI", "Servicio Person", ""
    'smerino ajustes
    If Me.txt_rubro.Text = "02" Then
    PMPasoValoresATX VGSqlConn, "@i_rubro_person", 0, SQLVARCHAR, "MATV", "Rubro Person", ""
    Else
     PMPasoValoresATX VGSqlConn, "@i_rubro_person", 0, SQLVARCHAR, "AJUS", "Rubro Person", "" ''AJUS'
    End If
    
 'Variables de salida
    PMPasoValoresATX VGSqlConn, "@o_comision", 1, SQLMONEY, 0, "Comision", ""
    'smerino
    PMPasoValoresATX VGSqlConn, "@o_tasa", 1, SQLMONEY, "0", "tasa", ""
    PMPasoValoresATX VGSqlConn, "@o_base_imp", 1, SQLMONEY, "0", "base_imp", ""
    PMPasoValoresATX VGSqlConn, "@o_impuesto", 1, SQLMONEY, "0", "impuesto", ""
    'smerino
   If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_val_servicios_varios", True, "Transaccion Ok", "S", "N", "N", "0", "S", "S") = True Then
      Comision.Text = FMRetParamATX(VGSqlConn, 1)
        VlbaseImp = FMRetParamATX(VGSqlConn, 3) 'smerino
        VLiva = FMRetParamATX(VGSqlConn, 4) 'smerino
        
         'LBP Inicio RECA-CC-SGC00025869
         If Comision.Text > 0 Then
            VGCom_aux = FMDevuelveComisionReal(Comision, False, 78)
            If VGCom_aux <> CDbl(Comision.Text) Then
                VGComision_original = Comision.Text
                Comision.Text = VGCom_aux
            Else
                VGComision_original = Comision.Text
            End If
         End If
         TotPago.Text = CDbl(Total.Text) + CDbl(Comision) 'LBP RECA-CE-SGC00026470 Se cambio orden de sumatoria 13/09/2016
        'LBP Fin RECA-CC-SGC00025869
        
       'PMChequeaATX VGSqlConn&
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

'pricaura REF_05 FIN 20190621
Private Function consultarParametroCte(Nemonico As String) As String
Dim VLarregloParametro(30) As String
PMInicioTransaccion
PMPasoValoresATX VGSqlConn&, "@t_trn", 0, SQLINT2, 1579, "", ""
PMPasoValoresATX VGSqlConn&, "@i_operacion", 0, SQLVARCHAR, "Q", "", ""
PMPasoValoresATX VGSqlConn&, "@i_nemonico", 0, SQLVARCHAR, Nemonico, "", ""
PMPasoValoresATX VGSqlConn&, "@i_producto", 0, SQLVARCHAR, "CTE", "", ""
If FMTransmitirRPCATX(VGSqlConn&, "", "cobis", "sp_parametro", True, " Consulta de motivos ", "N", "N", "S", "78", "N", "N") Then
   VTR1% = FMMapeaArregloATX(VGSqlConn, VLarregloParametro())
   consultarParametroCte = LTrim(RTrim(Trim(VLarregloParametro(4))))
Else
   consultarParametroCte = ""
End If
PMChequeaATX VGSqlConn&
PMFinTransaccion
End Function
'pricaura REF_05 FIN 20190621

Private Sub Tarjeta_KeyDown(KeyCode As Integer, Shift As Integer)
  Select Case KeyCode%
    Case CGTeclaSUPR%
      Tarjeta.Text = ""
    Case CGTeclaENTER%
      SendKeys "{TAB}"
    Case CGTeclaMAS%
      Tarjeta.Text = FMCalculadora(FMObtenerTitulo("78") + "Tarjeta:", 14, "78")
      'SendKeys "{TAB}"
    Case CGTeclaPOR%
      Tarjeta.Text = FMSumadora(FMObtenerTitulo("78") + "Tarjeta:", 14, "78")
    Case CGTeclaHOME%
      PMCambiarForma Me
    Case CGTeclaUP%, CGTeclaREPAG%
      Debito.SetFocus
    Case CGTeclaDOWN%, CGTeclaAVPAG%
      KeyCode = 0
      'SendKeys "{TAB}"
    '-->hy-18-junio-2007
    Case CGTeclaF5%
        If VLFlagMultiFlujo = "S" Then
            FVISA.VLFlagAutorizacion = True
            FVISA.VLnemonico = "78"
            FVISA.Show 1
            'VLFVISA_VLClaveUnicaTC = ""     'PHOYOSV REF_02 20170714
            VLVISA_numtar = FVISA.VLFVISA_numtar
            VLVISA_numtar_mask = Mid(VLVISA_numtar, 1, 6) + "XXXXXX" + Mid(VLVISA_numtar, 13, 4)    'JPM 14/09/21012
            VLVISA_ClaveUnicaTC = FVISA.VLFVISA_ClaveUnicaTC
           'VLVISA_cvv2 = FVISA.VLFVISA_cvv2
            VLVISA_fechaven = FVISA.VLFVISA_fechaven
            VLVISA_meses = FVISA.VLFVISA_meses
            VLVISA_monto = FVISA.VLFVISA_monto
            VLVISA_tipoconsumo = FVISA.VLFVISA_tipoconsumo
            VLVISA_banda_sn = FVISA.VLFVISA_banda_sn
            VLVISA_nombre = FVISA.VLFVISA_nombre
            VLVISA_track1 = FVISA.VLFVISA_track1
            VLVISA_track2 = FVISA.VLFVISA_track2
            Tarjeta = VLVISA_monto
            
            'pricaura REF_05 INI 20190621
            If VLVISA_monto > 0 And VLVISA_tipoconsumo = "D" And consultarParametroCte("FCCTC") = "S" Then
                Comision.Text = 0
            Else
                Comision.Text = VGComision_original
            End If
            TotPago.Text = CDbl(Total.Text) + CDbl(Comision.Text)
            'pricaura REF_05 INI 20190621
            
            'If VLVISA_banda_sn = "N" Then  'PHOYOSV REF_02 20170714
            '   PLTraeNombreTarjeta         'PHOYOSV REF_02 20170714
            'End If                         'PHOYOSV REF_02 20170714
            If Trim(VLVISA_nombre) = "" And Trim(VLVISA_ClaveUnicaTC) <> "" Then
               PLTraeNombreTarjeta
            End If
        End If
    '<--hy-18-junio-2007
  
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
      Total.Text = FMCalculadora(FMObtenerTitulo("78") + "Total Depositado:", 14, "78")
      SendKeys "{TAB}"
    Case CGTeclaPOR%
      Total.Text = FMSumadora(FMObtenerTitulo("78") + "Total Depositado:", 14, "78")
    Case CGTeclaHOME%
      PMCambiarForma Me
    Case CGTeclaUP%, CGTeclaREPAG%
      Debito.SetFocus
    Case CGTeclaDOWN%, CGTeclaAVPAG%
      SendKeys "{TAB}"
  End Select
End Sub

Private Sub Total_KeyPress(KeyAscii As Integer)
  KeyAscii = FMValidarNumero((Total.Text), VGLongitudMoney, KeyAscii, "78")
End Sub


Private Sub Total_LostFocus()
  If VGDecimales$ = "S" And (FMObtenerDecimales(FMObtenerMonedaForma("78")) > 0) Then
     Total.Text = str(FMCCurATX((Total.Text)) / FMObtenerFactorDecimal(FMObtenerMonedaForma("78")))
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
    
    If VGHorarioDif Then
        VLTrn = "3331"
    Else
        VLTrn = "3142"
    End If
    VGTrn = IIf(VLTrn = "", 0, VLTrn)
    
    '-->hy-13-dic-2005
    VLSsn = ""
    VLFecHora = ""
    VLFecContable = ""
    VLProvincia = ""
    VLTerminal = ""
    VLtxtMCN = ""
    VLtxtCodVehiculo = ""
    VLtxtTranRevSri = ""
    VLtxtLogRevSri = ""
    VLtxtChasis = ""
    VLtxtMotor = ""
    '<--hy-13-dic-2005
    
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLVARCHAR, "C", "Opcion", ""
    PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, "0", "SecTrn", ""
    PMPasoValoresATX VGSqlConn, "@o_fechora", 1, SQLVARCHAR, Space(16), "fechora", ""
    PMPasoValoresATX VGSqlConn, "@o_feccontable", 1, SQLVARCHAR, Space(10), "feccontable", ""
    PMPasoValoresATX VGSqlConn, "@o_provincia", 1, SQLVARCHAR, Space(7), "Provincia", ""
    PMPasoValoresATX VGSqlConn, "@o_terminal", 1, SQLVARCHAR, Space(6), "Terminal", ""
    If FMTransmitirRPCATX(VGSqlConn, "", "cob_servicios", "sp_tr_pago_matrvehi_rc", True, "Transaccion Ok", "S", "N", "N", "78", "S", "S") = True Then
        VLSsn = FMRetParamATX(VGSqlConn, 1)
        If Len(Trim$(VLSsn)) > 8 Then
            VLSsn = Mid$(Trim$(VLSsn), 1, 8)
        End If
        VLSsn = String(8 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
        VLFecHora = FMRetParamATX(VGSqlConn, 2)
        VLFecContable = FMRetParamATX(VGSqlConn, 3)
        VLProvincia = FMRetParamATX(VGSqlConn, 4)
        VLTerminal = FMRetParamATX(VGSqlConn, 5)
        PMChequeaATX VGSqlConn
        PMTotalesBranch "78"
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
        VLTramaEnvio = VLTramaEnvio + "MATRICULA TRA_CON"
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
        'VLRucPropietario = Trim$(Mid$(VLTramaRetorno, 517, 13))
        VLRucPropietario = Trim$(Mid$(VLTramaRetorno, 541, 13))
        VLCodigoVehiculo = Trim$(Mid$(VLTramaRetorno, 282, 13))
        Total.Text = CDbl(Trim$(Mid$(VLTramaRetorno, 295, 15))) / 100
        VLTranRevSri = Trim$(Mid$(VLTramaRetorno, 310, 15))
        VLValAvaluo = CDbl(Trim$(Mid$(VLTramaRetorno, 347, 10))) / 100
        VLTitulo1 = Trim$(Mid$(VLTramaRetorno, 93, 12))
        If Trim$(VLTitulo1) = "" Then
            VLValor1 = 0
        Else
            VLValor1 = CDbl(Trim$(Mid$(VLTramaRetorno, 105, 6))) / 100
        End If
        VLTitulo2 = Trim$(Mid$(VLTramaRetorno, 111, 12))
        If Trim$(VLTitulo2) = "" Then
            VLValor2 = 0
        Else
            VLValor2 = CDbl(Trim$(Mid$(VLTramaRetorno, 123, 6))) / 100
        End If
        VLTitulo3 = Trim$(Mid$(VLTramaRetorno, 129, 12))
        If Trim$(VLTitulo3) = "" Then
            VLValor3 = 0
        Else
            VLValor3 = CDbl(Trim$(Mid$(VLTramaRetorno, 141, 6))) / 100
        End If
        VLTitulo4 = Trim$(Mid$(VLTramaRetorno, 147, 12))
        If Trim$(VLTitulo4) = "" Then
            VLValor4 = 0
        Else
            VLValor4 = CDbl(Trim$(Mid$(VLTramaRetorno, 159, 6))) / 100
        End If
        VLTitulo5 = Trim$(Mid$(VLTramaRetorno, 165, 12))
        If Trim$(VLTitulo5) = "" Then
            VLValor5 = 0
        Else
            VLValor5 = CDbl(Trim$(Mid$(VLTramaRetorno, 177, 6))) / 100
        End If
        VLTitulo6 = Trim$(Mid$(VLTramaRetorno, 183, 12))
        If Trim$(VLTitulo6) = "" Then
            VLValor6 = 0
        Else
            VLValor6 = CDbl(Trim$(Mid$(VLTramaRetorno, 195, 6))) / 100
        End If
        VLTitulo7 = Trim$(Mid$(VLTramaRetorno, 201, 12))
        If Trim$(VLTitulo7) = "" Then
            VLValor7 = 0
        Else
            VLValor7 = CDbl(Trim$(Mid$(VLTramaRetorno, 213, 6))) / 100
        End If
        VLTitulo8 = Trim$(Mid$(VLTramaRetorno, 219, 12))
        If Trim$(VLTitulo8) = "" Then
            VLValor8 = 0
        Else
            VLValor8 = CDbl(Trim$(Mid$(VLTramaRetorno, 231, 6))) / 100
        End If
        VLTitulo9 = Trim$(Mid$(VLTramaRetorno, 237, 12))
        If Trim$(VLTitulo9) = "" Then
            VLValor9 = 0
        Else
            VLValor9 = CDbl(Trim$(Mid$(VLTramaRetorno, 249, 6))) / 100
        End If
        VLTitulo10 = Trim$(Mid$(VLTramaRetorno, 255, 12))
        If Trim$(VLTitulo10) = "" Then
            VLValor10 = 0
        Else
            VLValor10 = CDbl(Trim$(Mid$(VLTramaRetorno, 267, 6))) / 100
        End If
    '*****************************************************************
    '*****************************************************************
    '*************** P A G O *****************************************
    '*****************************************************************
    '*****************************************************************
    Case "P"
        VLUsarRevForzado = True  'hy-27-dic-2005
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
        VLTramaEnvio = VLTramaEnvio + "MATRICULA TRA_AFE"
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
            VLUsarRevForzado = False  'hy-27-dic-2005
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
        txtTranRevSri.Text = VLtxtTranRevSri  'id_tran_reverso_sri
        VLtxtLogRevSri = Trim$(Mid$(VLTramaRetorno, 332, 15))
        txtLogRevSri.Text = VLtxtLogRevSri   'log_reverso_sri
        'txtChasis.Text = Trim$(Mid$(VLTramaRetorno, 398, 13))
        VLtxtChasis = Trim$(Mid$(VLTramaRetorno, 398, 25))
        txtChasis.Text = VLtxtChasis
        'txtMotor.Text = Trim$(Mid$(VLTramaRetorno, 469, 13))
        VLtxtMotor = Trim$(Mid$(VLTramaRetorno, 481, 25))
        txtMotor.Text = VLtxtMotor
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
        VLTramaEnvio = VLTramaEnvio + "MATRICULA TRA_REV"
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
    'hy-27-dic-2005
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
        VLTramaEnvio = VLTramaEnvio + "MATRICULA TRA_REV"
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
Function BuscaComercio() As Boolean

 
    PMChequea VGSqlConn&
    PMPasoValores VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "svcodcomercio"
    PMPasoValores VGSqlConn&, "@i_tipo", 0, SQLCHAR, "V"
    'smerino ajustes
    If Me.txt_rubro.Text = "02" Then
    PMPasoValores VGSqlConn&, "@i_codigo", 0, SQLVARCHAR, "COD78"
    Else
    PMPasoValores VGSqlConn&, "@i_codigo", 0, SQLVARCHAR, "COD77"
    End If
    
    If FMTransmitirRPC(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "") Then
        PMMapeaVariableATX VGSqlConn&, VLCodigoComercio
        PMChequea VGSqlConn&
        BuscaComercio = True
    Else
        VLCodigoComercio = ""
        PMChequea VGSqlConn&
         BuscaComercio = False
    End If
 
 
    PMChequea VGSqlConn&
    PMPasoValores VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "svcodcomercio"
    PMPasoValores VGSqlConn&, "@i_tipo", 0, SQLCHAR, "V"
      'smerino ajustes
    If Me.txt_rubro.Text = "02" Then
    PMPasoValores VGSqlConn&, "@i_codigo", 0, SQLVARCHAR, "NOM78"
    Else
    PMPasoValores VGSqlConn&, "@i_codigo", 0, SQLVARCHAR, "NOM77"
    End If
    
    If FMTransmitirRPC(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "") Then
        PMMapeaVariableATX VGSqlConn&, VLNombreComercio
        PMChequea VGSqlConn&
        BuscaComercio = True
    Else
        VLNombreComercio = ""
        PMChequea VGSqlConn&
         BuscaComercio = False
    End If
  
   '<--hy-18-junio-2007
   
   
    PMChequea VGSqlConn&
    PMPasoValores VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "svcodcomercio"
    PMPasoValores VGSqlConn&, "@i_tipo", 0, SQLCHAR, "V"
      'smerino ajustes
    If Me.txt_rubro.Text = "02" Then
    PMPasoValores VGSqlConn&, "@i_codigo", 0, SQLVARCHAR, "TER78"
    Else
    PMPasoValores VGSqlConn&, "@i_codigo", 0, SQLVARCHAR, "TER77"
    End If
    
    If FMTransmitirRPC(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "") Then
        PMMapeaVariableATX VGSqlConn&, VLCodigoTerminal
        PMChequea VGSqlConn&
        BuscaComercio = True
    Else
        VLCodigoTerminal = ""
        PMChequea VGSqlConn&
         BuscaComercio = False
    End If
   'FIN SMERINO

End Function
'hy-18-junio-2007
Function FLTransmitirTarjeta() As Integer
Dim VTIndicadorSum As Integer
Dim VLTemporal As String
Dim VLCvv_aux As String  'JPM 14/09/2012

   
    If BuscaComercio() = False Then
         MsgBox "No exite Comercio de tarjeta ", vbCritical, "Error"
          Exit Function
    End If
  
    'Validacion de emergencia
    If FMCCurATX(Total.Text) <> FMCCurATX(Efectivo.Text) + FMCCurATX(Cheque.Text) + FMCCurATX(Debito.Text) + FMCCurATX(Tarjeta.Text) Then
        MsgBox "No cuadran los totales en la sumadora, favor salga de la opción y vuelva a aplicar la transacción"
        FLTransmitirTarjeta = False
        VTIndicadorSum = 0
        Exit Function
    End If
    '---
    'PHOYOSV INI REF_03 20181108 se comenta por el no uso de lectora para tarjeta
'''''If VLVISA_banda_sn = "S" Then
'''''   If Trim$(VLVISA_track1) = Trim$(VLVISA_track2) Then
'''''      MsgBox "Error en la lectora, por favor pase nuevamente la tarjeta o reinicie la opción", vbCritical, "Error"
'''''      FLTransmitirTarjeta = False
'''''      VTIndicadorSum = 0
'''''      Exit Function
'''''   End If
'''''End If
    'PHOYOSV FIN REF_03 20181108
    VTIndicadorSum = 0
    
  If VGHorarioDif Then
        VLTrn = "3331"
    Else
        VLTrn = "3142"
    End If
    VGTrn = IIf(VLTrn = "", 0, VLTrn)

    PMInicioTransaccion
 
    If VLVISA_tipoconsumo = "R" Then
        If Not VGHorarioDif Then
            PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, "62060", "Trn", ""
        Else
            PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, "62061", "Trn", ""
        End If
    Else
        If Not VGHorarioDif Then
            PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, "62064", "Trn", ""
        Else
            PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, "62065", "Trn", ""
        End If
    End If

    PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Canal", "" 'DOLAYAS 08/06/2018
    PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(FMObtenerMonedaForma("78")), "Moneda", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "P", "", ""
    PMPasoValoresATX VGSqlConn, "@i_matricula", 0, SQLVARCHAR, (Matricula.Text), "Matricula", ""
    PMPasoValoresATX VGSqlConn, "@i_efe", 0, SQLMONEY, (Efectivo.Text), "Efectivo", ""
    PMPasoValoresATX VGSqlConn, "@i_cheq", 0, SQLMONEY, (Cheque.Text), "Cheque", ""
    'msilvag: Inicio RECA-CC-SGC00030409 - Facturacion OffLine Debitos
    'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
    If Me.Cta.ClipText <> "" Then
        PMPasoValoresATX VGSqlConn, "@i_tipocta", 0, SQLVARCHAR, (CboTipCta.Text), "CboTipCta", ""
        PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
    Else
        PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (VLCta_com78), "Com. Cta", ""
        PMPasoValoresATX VGSqlConn, "@i_tipocta", 0, SQLCHAR, (VLTipCta_com78), "Com. TipCta", ""
    End If
    'msilvag FIn
   
    PMPasoValoresATX VGSqlConn, "@i_deb", 0, SQLMONEY, (Debito.Text), "Debito", ""
    PMPasoValoresATX VGSqlConn, "@i_tarjeta", 0, SQLMONEY, (Tarjeta.Text), "tarjeta", ""
    PMPasoValoresATX VGSqlConn, "@i_total", 0, SQLMONEY, (Total.Text), "Total", ""
    PMPasoValoresATX VGSqlConn, "@i_autoriza", 0, SQLCHAR, VGAutoriza, "Autorizacion", ""
    
    PMPasoValoresATX VGSqlConn, "@i_cant_chq", 0, SQLINT4, val(CantChq.Text), "CantChq", ""  'ame 23.may.03
      
    '****** COMISION *******************************************************
    PMPasoValoresATX VGSqlConn, "@i_efe_com", 0, SQLMONEY, (VLEfe_com78), "Com. efectivo", ""
    PMPasoValoresATX VGSqlConn, "@i_chq_com", 0, SQLMONEY, (VLChq_com78), "Com. Cheques", ""
    PMPasoValoresATX VGSqlConn, "@i_deb_com", 0, SQLMONEY, (VLDeb_com78), "Com. Debito", ""
    
    'LBP Inicio RECA-CC-SGC00025869
    If VLEfe_com78 > 0 And VLChq_com78 > 0 And VLDeb_com78 > 0 Then
        VGFormaPago = "EFE;" & Format(VLEfe_com78, "#0.00") & "_" & "CHE;" & Format(VLChq_com78, "#0.00") & "_" & "DEB;" & Format(VLDeb_com78, "#0.00")
    ElseIf VLEfe_com78 > 0 And VLChq_com78 > 0 Then
        VGFormaPago = "EFE;" & Format(VLEfe_com78, "#0.00") & "_" & "CHE;" & Format(VLChq_com78, "#0.00")
    ElseIf VLEfe_com78 > 0 And VLDeb_com > 0 Then
        VGFormaPago = "EFE;" & Format(VLEfe_com78, "#0.00") & "_" & "DEB;" & Format(VLDeb_com78, "#0.00")
    ElseIf VLDeb_com78 > 0 And VLChq_com78 > 0 Then
        VGFormaPago = "DEB;" & Format(VLDeb_com78, "#0.00") & "_" & "CHE;" & Format(VLChq_com78, "#0.00")
    ElseIf VLEfe_com78 > 0 Then
        VGFormaPago = "EFE;" & Format(VLEfe_com78, "#0.00")
    ElseIf VLChq_com78 > 0 Then
        VGFormaPago = "CHE;" & Format(VLChq_com78, "#0.00")
    ElseIf VLDeb_com78 > 0 Then
        VGFormaPago = "DEB;" & Format(VLDeb_com78, "#0.00")
    End If
    'LBP Fin RECA-CC-SGC00025869
    
    If VGTipoEjecucion% <> CGReverso% Then
        PMPasoValoresATX VGSqlConn, "@i_cta_com", 0, SQLVARCHAR, (VLCta_com78), "Com. Cta", ""
        PMPasoValoresATX VGSqlConn, "@i_tipocta_com", 0, SQLCHAR, (VLTipCta_com78), "Com. TipCta", ""
    Else
        PMPasoValoresATX VGSqlConn, "@i_cta_com", 0, SQLVARCHAR, (VLCta_com78), "Com. Cta", ""
       PMPasoValoresATX VGSqlConn, "@i_tipocta_com", 0, SQLCHAR, (VLTipCta_com78), "Com. TipCta", ""
    End If
    
    'PMPasoValoresATX VGSqlConn, "@o_nota_venta", 1, SQLVARCHAR, VLSerie_Secuencia, "Nota_venta", "" 'hy-24-feb-2005    'JPM 14/09/2012: parámetro no usado
    PMPasoValoresATX VGSqlConn, "@i_propietario", 0, SQLVARCHAR, TxtNomProp.Text, "Propietario", ""
    If VGTipoEjecucion% <> CGReverso% Then
        PMPasoValoresATX VGSqlConn, "@i_motor", 0, SQLVARCHAR, VLtxtMotor, "Motor", ""
        PMPasoValoresATX VGSqlConn, "@i_chasis", 0, SQLVARCHAR, VLtxtChasis, "Chasis", ""
        PMPasoValoresATX VGSqlConn, "@i_cod_vehiculo", 0, SQLVARCHAR, VLtxtCodVehiculo, "CodVehiculo", ""
        PMPasoValoresATX VGSqlConn, "@i_mcn", 0, SQLVARCHAR, VLtxtMCN, "MCN", ""
        PMPasoValoresATX VGSqlConn, "@i_tranrevsri", 0, SQLVARCHAR, VLtxtTranRevSri, "Tranrevsri", ""
        PMPasoValoresATX VGSqlConn, "@i_logrevsri", 0, SQLVARCHAR, VLtxtLogRevSri, "Logrevsri", ""
    Else
        PMPasoValoresATX VGSqlConn, "@i_motor", 0, SQLVARCHAR, txtMotor.Text, "Motor", ""
        PMPasoValoresATX VGSqlConn, "@i_chasis", 0, SQLVARCHAR, txtChasis.Text, "Chasis", ""
        PMPasoValoresATX VGSqlConn, "@i_cod_vehiculo", 0, SQLVARCHAR, txtCodVehiculo.Text, "CodVehiculo", ""
        PMPasoValoresATX VGSqlConn, "@i_mcn", 0, SQLVARCHAR, txtMCN.Text, "MCN", ""
        PMPasoValoresATX VGSqlConn, "@i_tranrevsri", 0, SQLVARCHAR, txtTranRevSri.Text, "Tranrevsri", ""
        PMPasoValoresATX VGSqlConn, "@i_logrevsri", 0, SQLVARCHAR, txtLogRevSri.Text, "Logrevsri", ""
    End If
    '*******PARAMETROS CPS**************************************************
    If VGTipoEjecucion% = CGReverso% Then
'        VLSecTrnCorr = DatoSwitch("@o_ssn") DOLAYAS 08/06/2018
'        PMPasoValoresATX VGSqlConn, "@o_ptranidrevifi", 0, SQLFLT8&, VLSecTrnCorr, "Ppni_id_tran_reverso_ifi", "" 08/06/2018
        PMPasoValoresATX VGSqlConn, "@k_ptarjeta", 0, SQLVARCHAR, Trim(VLVISA_numtar), "", "", True                     'JPM 14/09/2012: cambiar prefijo parametro
        PMPasoValoresATX VGSqlConn, "@i_ptarjeta", 0, SQLVARCHAR, VLVISA_numtar_mask, "TARJETA", ""                     'JPM 14/09/2012
    Else
        'PHOYOSV INI REF_03 20180913 se comenta la encriptacion
        'JPM 14/09/2012 --->
        '
        'If (PLEncripta(Trim(VLVISA_numtar), "Nro. de Tarjeta")) = False Then
        '   PMFinTransaccion
        '   VLStrEncrypt = ""
        '   Exit Function
        'End If
        VLStrEncrypt = ""
        'PHOYOSV INI REF_03 20180913 se comenta la encriptacion
        PMPasoValoresATX VGSqlConn, "@k_ptarjeta", 0, SQLVARCHAR, Trim(VLStrEncrypt), "", "", True
        PMPasoValoresATX VGSqlConn, "@i_tja", 0, SQLVARCHAR, Mid$(VLStrEncrypt, 1, 64), "", "", True
        PMPasoValoresATX VGSqlConn, "@i_tjb", 0, SQLVARCHAR, Mid$(VLStrEncrypt, 65, 128), "", "", True
        VLVISA_numtar_mask = Mid(VLVISA_numtar, 1, 6) + "XXXXXX" + Mid(VLVISA_numtar, 13, 4)
        PMPasoValoresATX VGSqlConn, "@i_ptarjeta", 0, SQLVARCHAR, VLVISA_numtar_mask, "TARJETA", ""
        '<--- JPM 14/09/2012
    End If
    
    PMPasoValoresATX VGSqlConn, "@i_pcodcanalpagifi", 0, SQLVARCHAR, "VENTANILLA", "Ppsi_cod_canal_pago_ifi", ""
    PMPasoValoresATX VGSqlConn, "@i_pfeccontifi", 0, SQLVARCHAR, Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2), "Ppsio_fecha_contable_ifi", ""
    PMPasoValoresATX VGSqlConn, "@i_pprovifi", 0, SQLVARCHAR, Trim$(VLProvincia), "Ppsi_provincia_ifi", ""
    
   'smerino ajustes

    PMPasoValoresATX VGSqlConn, "@i_ptipodeuda", 0, SQLVARCHAR, VLTipoDeuda, "Ppsi_tipo_deuda", ""
 
     'FIN SMERINO
    'smerino ajustes
       PMPasoValoresATX VGSqlConn, "@i_rubro", 0, SQLVARCHAR, Me.txt_rubro.Text, "Codrubro", ""
       PMPasoValoresATX VGSqlConn, "@i_desc_rubro", 0, SQLVARCHAR, Me.lbl_rubro.Caption, "DescRubro", ""
    'fin smerino ajustes
    
    
    VLValorPagar = Trim$(str$(CDbl(Total.Text) * 100))
    PMPasoValoresATX VGSqlConn, "@i_pvaltotpag", 0, SQLFLT8, CDbl(VLValorPagar), "Ppsi_tipo_tran", ""
    '*******PARAMETROS CPS TARJETA VISA***************************************
    PMPasoValoresATX VGSqlConn, "@i_tipopago", 0, SQLVARCHAR, "T", "", "", True
    
    PMPasoValoresATX VGSqlConn, "@i_pmonto", 0, SQLMONEY, Tarjeta.Text, "", "", True
    PMPasoValoresATX VGSqlConn, "@i_phora", 0, SQLINT4, Mid$(VLFecHora, 9, 6), "", "", True
    PMPasoValoresATX VGSqlConn, "@i_pfecha", 0, SQLINT4, Mid$(VLFecHora, 7, 2) + Mid$(VLFecHora, 5, 2), "", "", True
    PMPasoValoresATX VGSqlConn, "@i_pfechaexpiracion", 0, SQLINT4, VLVISA_fechaven, "", "", True
    PMPasoValoresATX VGSqlConn, "@i_pcategory", 0, SQLINT4, "9311", "", "", True
    
    'JPM 14/09/2012 ---> la lectura se convierte en manual
'    If VLVISA_banda_sn = "S" Then
'        PMPasoValoresATX VGSqlConn, "@i_pmodo", 0, SQLINT4, "902", "", "", True
'    Else
        PMPasoValoresATX VGSqlConn, "@i_pmodo", 0, SQLINT4, "012", "", "", True
'    End If
    'PMPasoValoresATX VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, "00023118", "", "", True  'VLCodigoTerminal
    PMPasoValoresATX VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, VLCodigoTerminal, "", "", True
   
    If VGTipoEjecucion% = CGReverso% Then
        PMPasoValoresATX VGSqlConn, "@i_pautorizacion", 0, SQLVARCHAR, VLVISA_autorizacion, "", "", True
'        PMPasoValoresATX VGSqlConn, "@t_ssn_corr1", 0, SQLINT4, VLVISA_ssn_corr1, "", "", True
'        PMPasoValoresATX VGSqlConn, "@t_ssn_corr2", 0, SQLINT4, VLSecTrnCorr, "", "", True
    Else
        PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLCHAR, "N", "", "", True 'DOLAYAS 08/06/2018
    End If
   
     VLTemporal = String(15 - Len(Trim$(VLCodigoComercio)), "0") + Trim$(VLCodigoComercio)
  
    PMPasoValoresATX VGSqlConn, "@i_pnegocio", 0, SQLVARCHAR, VLTemporal, "", "", True
    
    'PMPasoValoresATX VGSqlConn, "@i_pnegocio", 0, SQLVARCHAR, "000000000800173", "", "", True
    PMPasoValoresATX VGSqlConn, "@i_plote", 0, SQLVARCHAR, "000181", "", "", True
    PMPasoValoresATX VGSqlConn, "@i_piva", 0, SQLVARCHAR, "11", "", "", True
    PMPasoValoresATX VGSqlConn, "@i_pvaloriva", 0, SQLVARCHAR, "000000000000", "", "", True
    PMPasoValoresATX VGSqlConn, "@i_pbitmap", 0, SQLVARCHAR, "0040", "", "", True
    If VGTipoEjecucion% = CGReverso% Then
        'PMPasoValoresATX VGSqlConn, "@i_pvalorcvv", 0, SQLVARCHAR, VLVISA_cvv2, "", "", True                 'JPM 14/09/2012: cambiar prefijo parametro
        PMPasoValoresATX VGSqlConn, "@k_pvalorcvv", 0, SQLVARCHAR, VLVISA_cvv2, "", "", True                  'JPM 14/09/2012: cambiar prefijo parametro
    Else
        'JPM 14/09/2012 --->
        'Nuevo esquema de envío de CVV2 para trx normal
        'ORG:
        'PMPasoValoresATX VGSqlConn, "@i_pvalorcvv", 0, SQLVARCHAR, "11 " + VLVISA_cvv2, "", "", True
'        VLCvv_aux = "11 " + VLVISA_cvv2
'        If (PLEncripta(VLCvv_aux, "CVV")) = False Then
'          PMFinTransaccion
'          VLStrEncrypt = ""
'          Exit Function
'        End If
    
        PMPasoValoresATX VGSqlConn, "@k_pvalorcvv", 0, SQLVARCHAR, Trim(VLStrEncrypt), "", "", True
        PMPasoValoresATX VGSqlConn, "@i_cvva", 0, SQLVARCHAR, Mid$(VLStrEncrypt, 1, 64), "", "", True
        PMPasoValoresATX VGSqlConn, "@i_cvvb", 0, SQLVARCHAR, Mid$(VLStrEncrypt, 65, 128), "", "", True
        '<--- JPM 14/09/2012
    End If
    PMPasoValoresATX VGSqlConn, "@i_pcoddiferido", 0, SQLVARCHAR, "9506ECUCTA", "", "", True
    If VGTipoEjecucion% = CGReverso% Then
        PMPasoValoresATX VGSqlConn, "@i_pinfodiferido", 0, SQLVARCHAR, VLVISA_meses, "", "", True
    Else
        PMPasoValoresATX VGSqlConn, "@i_pinfodiferido", 0, SQLVARCHAR, "0050060" + "1" + VLVISA_meses + "00", "", "", True
    End If
    'PMPasoValoresATX VGSqlConn, "@o_ssn_atomico", 1, SQLINT4, "0", "", "" DOLAYAS
    PMPasoValoresATX VGSqlConn, "@i_banda_sn", 0, SQLVARCHAR, VLVISA_banda_sn, "", ""
    If VGTipoEjecucion% = CGReverso% Then
        PMPasoValoresATX VGSqlConn, "@i_nombre", 0, SQLVARCHAR, "X", "", ""
    Else
        PMPasoValoresATX VGSqlConn, "@i_nombre", 0, SQLVARCHAR, VLVISA_nombre, "", ""
    End If
    'PMPasoValoresATX VGSqlConn, "@i_autorizat", 0, SQLVARCHAR, VGAutoriza$, "", "", True
    PMPasoValoresATX VGSqlConn, "@i_supautor", 0, SQLVARCHAR, VGSuperAutoriza$, "", "", True
      
     'Joel Lozano 05/04/2012
    If Tarjeta.Text > 0# Then
       VLbasecero = CDbl(Trim$(Tarjeta.Text)) * 100 'Tarjeta.Text
       'VLbasecero = String(12 - Len(Trim$(VLbasecero)), "0") + VLbasecero
       VLbasecero = String(24 - Len(Trim$(VLbasecero)), "0") + VLbasecero
    End If
    PMPasoValoresATX VGSqlConn, "@i_valor_iva_cero", 0, SQLVARCHAR, VLbasecero, "i_valor_iva_cero", ""     'JLF 05/04/2012
    PMPasoValoresATX VGSqlConn, "@i_valor_iva", 0, SQLVARCHAR, "000000000000", "i_valor_iva", ""  'JLF 05/04/2012
    PMPasoValoresATX VGSqlConn, "@i_clave_unica", 0, SQLVARCHAR, VLVISA_ClaveUnicaTC, "ClaveUnicaTC", "" 'PHOYOS 08/06/2018
    'PMPasoValoresATX VGSqlConn, "@i_fecha_contable", 0, SQLVARCHAR, "2018-07-24", "", ""
    
    PMPasoValoresATX VGSqlConn, "@o_codigo_error", 1, SQLINT4, "0", "", ""
    PMPasoValoresATX VGSqlConn, "@o_pauthnumber", 1, SQLVARCHAR, "0", "", ""
    PMPasoValoresATX VGSqlConn, "@o_psystemtauditNumber", 1, SQLVARCHAR, "0", "", ""
    PMPasoValoresATX VGSqlConn, "@o_compro", 1, SQLINT4, 0, "Comprobante", ""
    PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, "0", "SecTrn", ""
    PMPasoValoresATX VGSqlConn, "@o_plogsri", 1, SQLVARCHAR, "0", "", ""
    PMPasoValoresATX VGSqlConn, "@o_pmcn", 1, SQLVARCHAR, "0", "", ""
    PMPasoValoresATX VGSqlConn, "@o_precibo", 1, SQLVARCHAR, "0", "", ""
    PMPasoValoresATX VGSqlConn, "@o_adicionales", 1, SQLVARCHAR, "0", "", ""
        
    If FMTransmitirRPCATX(VGSqlConn, VLParametroServer, "cob_procesador", "pago_matricula_veh_tarjeta", True, "Transaccion Ok", "S", "N", "S", "78", "S", "S") = True Then
        PMChequeaATX VGSqlConn
        ' ame 08/25/2010
        'dolaya Ini
        VLAdicional = FMRetParamATX(VGSqlConn, 9)
         If VGTipoEjecucion% <> CGReverso% And VLVISA_meses <> "00" Then
             str_Interes = Right(VLAdicional, 11) 'INTERES
             int_enteros = CCur(Mid(Trim(str_Interes), 1, Len(Trim(str_Interes)) - 2))
             int_decimales = "0" + "." + Format(Right(str_Interes, 2), "00")
             VLInteres = int_enteros + int_decimales
             VLTotal = CCur(Tarjeta.Text) + VLInteres
          Else
             VLInteres = 0
             VLTotal = CCur(Tarjeta.Text)
          End If

        VLNumAutorizaVisa = FMRetParamATX(VGSqlConn, 2)
        VLNumTranAutorizaVisa = FMRetParamATX(VGSqlConn, 3)
'        'JPM 20121004: --->
'        'cambiar indice por eliminacion de outparams "@o_nota_venta", "@o_autorisri", "@o_fecvensri"
        VLLogSri = FMRetParamATX(VGSqlConn, 6)   'Log SRI  'JPM antes 16
        VLMCN = FMRetParamATX(VGSqlConn, 7)  'MCN          'JPM antes 17
        VLRecibo = FMRetParamATX(VGSqlConn, 8)    'Recibo  'JPM antes 18
'        '<--- JPM 20121004
'        'If Len(Cta.ClipText) <> 0 Then
'        '    TxtNomCta.Text = FMRetParamATX(VGSqlConn, 3)
'        'End If
        Comprobante = FMRetParamATX(VGSqlConn, 4)
'        'TPE ------> Sumadora
'        'JPM 20121004: cambiar indice por eliminacion de outparams "@o_nota_venta", "@o_autorisri", "@o_fecvensri"
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 5)            'JPM antes 19 -antes16smerino
        
        VTIndicadorSum = 1
        PMIniciaRegSum
        '<-----
        FLTransmitirTarjeta = True
        VLCambio% = False
    Else
        'TPE ------> Sumadora
        'JPM 20121004: cambiar indice por eliminacion de outparams "@o_nota_venta", "@o_autorisri", "@o_fecvensri"
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 14)          'JPM antes 19 -antes 16smerino
        VTIndicadorSum = 0
        PMChequeaATX VGSqlConn
        '<------
        VLCambio% = True
        FLTransmitirTarjeta = False
    End If
    VGAutoriza = "N"
    PMChequeaATX VGSqlConn
    If FMRetStatusATX(VGSqlConn) <> 0 Then
        On Error Resume Next
        Matricula.SetFocus
        FLTransmitirTarjeta = False
        VTIndicadorSum = 0
    End If
    PMFinTransaccion
    
    'ame 08/04/2010
     If FLTransmitirTarjeta = True Then
       'JPM Lectora de Billetes -->
       If CCur(Efectivo.Text) > 0 And ((VGDatPersBillAltDen.dataOK And VGTipoEjecucion = CGNormal%) Or VGTipoEjecucion = CGReverso%) Then
         'Call PMGuardarDsglsBillete("78", SGSecTrn$, VLTrn, rptBAD, CboTipCta.Text, Cta.ClipText)
         Call PMGuardarDsglsBillete("78", SGSecTrn$, VLTrn, rptBAD, "REC", "")
         lectoraBill.Limpiar
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

Function FLTransmitirDatos() As Integer
    If VGHorarioDif Then
        VLTrn = "3331"
    Else
        VLTrn = "3142"
    End If
    VGTrn = IIf(VLTrn = "", 0, VLTrn)
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "B", "", ""
    PMPasoValoresATX VGSqlConn, "@o_direccion_of", 1, SQLVARCHAR, "", "", ""
    PMPasoValoresATX VGSqlConn, "@o_telefono_of", 1, SQLVARCHAR, "", "", ""
    PMPasoValoresATX VGSqlConn, "@o_ciudad_of", 1, SQLVARCHAR, "", "", ""
    If FMTransmitirRPCATX(VGSqlConn, "", "cob_servicios", "sp_tr_pago_matrvehi_rc", True, "Transaccion Ok", "S", "N", "N", "78", "S", "S") = True Then
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



Function FLTransmitirUnificadoOsb() As Integer
Dim VTIndicadorSum As Integer
Dim procedimiento As String
Dim trnTransaccion As String

     'Validacion de emergencia
    If FMCCurATX(Total.Text) <> FMCCurATX(Efectivo.Text) + FMCCurATX(Cheque.Text) + FMCCurATX(Debito.Text) + FMCCurATX(Tarjeta.Text) Then
        MsgBox "No cuadran los totales en la sumadora, favor salga de la opción y vuelva a aplicar la transacción"
        FLTransmitirUnificadoOsb = False
        VTIndicadorSum = 0
        Exit Function
    End If
    '---

    VTIndicadorSum = 0

    'trn para el desglose de la sumadora 3331 o 3142
    If VGHorarioDif Then
        VLTrn = "3331"
    Else
        VLTrn = "3142"
    End If
    If Tarjeta.Text > 0 Then
        procedimiento = "pago_matricula_veh_tarjeta"
        If VLVISA_tipoconsumo = "R" Then
            If Not VGHorarioDif Then
                trnTransaccion = "62060"
            Else
                trnTransaccion = "62061"
            End If
        Else
            If Not VGHorarioDif Then
                trnTransaccion = "62064"
            Else
                trnTransaccion = "62065"
            End If
        End If
    Else
        procedimiento = "sp_tr_pago_matrvehi_rc"
        If VGHorarioDif Then
            trnTransaccion = "3331"
        Else
            trnTransaccion = "3142"
        End If
    End If
    'VGTrn = IIf(VLTrn = "", 0, VLTrn) da overflow con 62064
    
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@i_mesesdiferido", 0, SQLINT4, VLVISA_meses, "", ""
    PMPasoValoresATX VGSqlConn, "@i_clave_unica", 0, SQLVARCHAR, VLVISA_ClaveUnicaTC, "", ""
    
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, trnTransaccion, "Trn", ""
 '   If VGTipoEjecucion% <> CGReverso% Then
'         PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLVARCHAR, "N", "TCORR", ""
  '  End If
    PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(FMObtenerMonedaForma("78")), "Moneda", ""
   ' PMPasoValoresATX VGSqlConn, "@i_tsn", 0, SQLINT4, Str(VGTSN%), "SecAut", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "P", "", ""
    PMPasoValoresATX VGSqlConn, "@i_matricula", 0, SQLVARCHAR, (Matricula.Text), "Matricula", ""
    PMPasoValoresATX VGSqlConn, "@i_efe", 0, SQLMONEY, (Efectivo.Text), "Efectivo", ""
    PMPasoValoresATX VGSqlConn, "@i_cheq", 0, SQLMONEY, (Cheque.Text), "Cheque", ""
    'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
    If Me.Cta.ClipText <> "" Then
        PMPasoValoresATX VGSqlConn, "@i_tipocta", 0, SQLVARCHAR, (CboTipCta.Text), "CboTipCta", ""
        PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
    Else
        PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (VLCta_com78), "Com. Cta", ""
        PMPasoValoresATX VGSqlConn, "@i_tipocta", 0, SQLCHAR, (VLTipCta_com78), "Com. TipCta", ""
    End If
    'msilvag FIn
    PMPasoValoresATX VGSqlConn, "@i_deb", 0, SQLMONEY, (Debito.Text), "Debito", ""
    PMPasoValoresATX VGSqlConn, "@i_tarjeta", 0, SQLMONEY, (Tarjeta.Text), "tarjeta", ""
    PMPasoValoresATX VGSqlConn, "@i_total", 0, SQLMONEY, (Total.Text), "Total", ""
    PMPasoValoresATX VGSqlConn, "@i_autoriza", 0, SQLCHAR, VGAutoriza, "Autorizacion", ""
    PMPasoValoresATX VGSqlConn, "@i_cant_chq", 0, SQLINT4, val(CantChq.Text), "CantChq", ""  'ame 23.may.03
    PMPasoValoresATX VGSqlConn, "@i_efe_com", 0, SQLMONEY, (VLEfe_com78), "Com. efectivo", ""
    PMPasoValoresATX VGSqlConn, "@i_chq_com", 0, SQLMONEY, (VLChq_com78), "Com. Cheques", ""
    PMPasoValoresATX VGSqlConn, "@i_deb_com", 0, SQLMONEY, (VLDeb_com78), "Com. Debito", ""
    
   
    'LBP Inicio RECA-CC-SGC00025869
    If VLEfe_com78 > 0 And VLChq_com78 > 0 And VLDeb_com78 > 0 Then
        VGFormaPago = "EFE;" & Format(VLEfe_com78, "#0.00") & "_" & "CHE;" & Format(VLChq_com78, "#0.00") & "_" & "DEB;" & Format(VLDeb_com78, "#0.00")
    ElseIf VLEfe_com78 > 0 And VLChq_com78 > 0 Then
        VGFormaPago = "EFE;" & Format(VLEfe_com78, "#0.00") & "_" & "CHE;" & Format(VLChq_com78, "#0.00")
    ElseIf VLEfe_com78 > 0 And VLDeb_com > 0 Then
        VGFormaPago = "EFE;" & Format(VLEfe_com78, "#0.00") & "_" & "DEB;" & Format(VLDeb_com78, "#0.00")
    ElseIf VLDeb_com78 > 0 And VLChq_com78 > 0 Then
        VGFormaPago = "DEB;" & Format(VLDeb_com78, "#0.00") & "_" & "CHE;" & Format(VLChq_com78, "#0.00")
    ElseIf VLEfe_com78 > 0 Then
        VGFormaPago = "EFE;" & Format(VLEfe_com78, "#0.00")
    ElseIf VLChq_com78 > 0 Then
        VGFormaPago = "CHE;" & Format(VLChq_com78, "#0.00")
    ElseIf VLDeb_com78 > 0 Then
        VGFormaPago = "DEB;" & Format(VLDeb_com78, "#0.00")
    End If
    'LBP Fin RECA-CC-SGC00025869
    
    If VGTipoEjecucion% <> CGReverso% Then
        PMPasoValoresATX VGSqlConn, "@i_cta_com", 0, SQLVARCHAR, (VLCta_com78), "Com. Cta", ""
        PMPasoValoresATX VGSqlConn, "@i_tipocta_com", 0, SQLCHAR, (VLTipCta_com78), "Com. TipCta", ""
        PMPasoValoresATX VGSqlConn, "@i_propietario", 0, SQLVARCHAR, TxtNomProp.Text, "Propietario", ""
    
        '-->hy-13-dic-2005
        PMPasoValoresATX VGSqlConn, "@i_motor", 0, SQLVARCHAR, VLtxtMotor, "Motor", ""
        PMPasoValoresATX VGSqlConn, "@i_chasis", 0, SQLVARCHAR, VLtxtChasis, "Chasis", ""
        PMPasoValoresATX VGSqlConn, "@i_cod_vehiculo", 0, SQLVARCHAR, VLtxtCodVehiculo, "CodVehiculo", ""
        PMPasoValoresATX VGSqlConn, "@i_mcn", 0, SQLVARCHAR, VLtxtMCN, "MCN", ""
        PMPasoValoresATX VGSqlConn, "@i_tranrevsri", 0, SQLVARCHAR, VLtxtTranRevSri, "Tranrevsri", ""
        PMPasoValoresATX VGSqlConn, "@i_logrevsri", 0, SQLVARCHAR, VLtxtLogRevSri, "Logrevsri", ""
        '<--hy-13-dic-2005
        
    Else
        'msilvag Inicio RECA-CC-SGC00030409 - Facturacion OffLine Debitos
        'PMPasoValoresATX VGSqlConn, "@i_cta_com", 0, SQLVARCHAR, "X", "Com. Cta", ""
        'PMPasoValoresATX VGSqlConn, "@i_tipocta_com", 0, SQLCHAR, "X", "Com. TipCta", ""
        PMPasoValoresATX VGSqlConn, "@i_cta_com", 0, SQLVARCHAR, (VLCta_com78), "Com. Cta", ""
        PMPasoValoresATX VGSqlConn, "@i_tipocta_com", 0, SQLCHAR, (VLTipCta_com78), "Com. TipCta", ""
        'msilvag Fin
        PMPasoValoresATX VGSqlConn, "@i_propietario", 0, SQLVARCHAR, "X", "Propietario", ""
    
        PMPasoValoresATX VGSqlConn, "@i_motor", 0, SQLVARCHAR, txtMotor.Text, "Motor", ""
        PMPasoValoresATX VGSqlConn, "@i_chasis", 0, SQLVARCHAR, txtChasis.Text, "Chasis", ""
        PMPasoValoresATX VGSqlConn, "@i_cod_vehiculo", 0, SQLVARCHAR, txtCodVehiculo.Text, "CodVehiculo", ""
        PMPasoValoresATX VGSqlConn, "@i_mcn", 0, SQLVARCHAR, txtMCN.Text, "MCN", ""
        PMPasoValoresATX VGSqlConn, "@i_tranrevsri", 0, SQLVARCHAR, txtTranRevSri.Text, "Tranrevsri", ""
        PMPasoValoresATX VGSqlConn, "@i_logrevsri", 0, SQLVARCHAR, txtLogRevSri.Text, "Logrevsri", ""
    End If
    '<--hy
    PMPasoValoresATX VGSqlConn, "@i_pcodcanalpagifi", 0, SQLVARCHAR, "VENTANILLA", "Ppsi_cod_canal_pago_ifi", ""
    PMPasoValoresATX VGSqlConn, "@i_pfeccontifi", 0, SQLVARCHAR, Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2), "Ppsio_fecha_contable_ifi", ""
    PMPasoValoresATX VGSqlConn, "@i_pprovifi", 0, SQLVARCHAR, Trim$(VLProvincia), "Ppsi_provincia_ifi", ""
    
      'smerino ajustes
    'If Me.txt_rubro.Text = "02" Then
      ' PMPasoValoresATX VGSqlConn, "@i_ptipodeuda", 0, SQLVARCHAR, "MATRICULA", "Ppsi_tipo_deuda", ""
   ' Else
       PMPasoValoresATX VGSqlConn, "@i_ptipodeuda", 0, SQLVARCHAR, VLTipoDeuda, "Ppsi_tipo_deuda", ""
    'End If
    'FIN SMERINO
    'smerino ajustes
       PMPasoValoresATX VGSqlConn, "@i_rubro", 0, SQLVARCHAR, Me.txt_rubro.Text, "Codrubro", ""
       PMPasoValoresATX VGSqlConn, "@i_desc_rubro", 0, SQLVARCHAR, Me.lbl_rubro.Caption, "DescRubro", ""
    'fin smerino ajustes
    

    VLValorPagar = Trim$(str$(CDbl(Total.Text) * 100))
    PMPasoValoresATX VGSqlConn, "@i_pvaltotpag", 0, SQLFLT8, CDbl(VLValorPagar), "Ppsi_tipo_tran", ""
    PMPasoValoresATX VGSqlConn, "@i_tipopago", 0, SQLVARCHAR, "O", "", ""  'hy-18-junio-2007
     
    'Joel Lozano 05/04/2012
    PMPasoValoresATX VGSqlConn, "@i_valor_iva_cero", 0, SQLMONEY, "0", "i_valor_iva_cero", ""    'JLF 05/04/2012
    PMPasoValoresATX VGSqlConn, "@i_valor_iva", 0, SQLMONEY, "000000000000", "i_valor_iva", ""  'JLF 05/04/2012
    
    If VGTipoEjecucion% <> CGReverso% Then
        PMPasoValoresATX VGSqlConn, "@o_nomprop", 1, SQLVARCHAR, (TxtNomProp.Text), "TxtNomProp", "" '1
        PMPasoValoresATX VGSqlConn, "@o_nomcta", 1, SQLVARCHAR, (TxtNomCta.Text), "TxtNomCta", "" '2
    Else
        PMPasoValoresATX VGSqlConn, "@o_nomprop", 1, SQLVARCHAR, "X", "TxtNomProp", "" '1
         PMPasoValoresATX VGSqlConn, "@o_nomcta", 1, SQLVARCHAR, "X", "TxtNomCta", "" '2
    End If
    PMPasoValoresATX VGSqlConn, "@o_total", 1, SQLMONEY, (Total.Text), "Total", "" '3
    PMPasoValoresATX VGSqlConn, "@o_compro", 1, SQLINT4, "0", "Comprobante", ""
    PMPasoValoresATX VGSqlConn, "@o_motor", 1, SQLVARCHAR, "0", "Motor", ""
    PMPasoValoresATX VGSqlConn, "@o_chasis", 1, SQLVARCHAR, "0", "Chasis", ""
    PMPasoValoresATX VGSqlConn, "@o_periodo", 1, SQLVARCHAR, "0", "Periodo", ""
    PMPasoValoresATX VGSqlConn, "@o_fisco", 1, SQLMONEY, "0", "Fisco", ""
    PMPasoValoresATX VGSqlConn, "@o_adminis", 1, SQLMONEY, "0", "Administradora", ""
    PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, "0", "SecTrn", ""
    If VGTipoEjecucion% <> CGReverso% Then
        PMPasoValoresATX VGSqlConn, "@o_autorisri", 1, SQLVARCHAR, VLautoriSri, "AutorizacionSRI", ""
        PMPasoValoresATX VGSqlConn, "@o_fecvensri", 1, SQLVARCHAR, VLFecvenSRI, "Stk", ""
    Else
        PMPasoValoresATX VGSqlConn, "@o_autorisri", 1, SQLVARCHAR, "X", "AutorizacionSRI", ""
        PMPasoValoresATX VGSqlConn, "@o_fecvensri", 1, SQLVARCHAR, "X", "Stk", ""
    End If
    '  PMPasoValoresATX VGSqlConn, "@o_consulta", 1, SQLINT4, (VTIndicadorSum), "SecTrn", ""
    
    '****** COMISION *******************************************************
    'If VLTotCom78 <> 0 Then
     PMPasoValoresATX VGSqlConn, "@o_nota_venta", 1, SQLVARCHAR, VLSerie_Secuencia, "Nota_venta", "" 'hy-24-feb-2005
    'End If
    '-->hy
'PARAMETROS CPS
    If VGTipoEjecucion% = CGReverso% Then
        VLSecTrnCorr = DatoSwitch("@o_ssn")
        PMPasoValoresATX VGSqlConn, "@o_ptranidrevifi", 0, SQLFLT8&, VLSecTrnCorr, "Ppni_id_tran_reverso_ifi", ""
        'PMPasoValoresATX VGSqlConn, "@t_ssn_corr1", 0, SQLINT4, Str(VLSecTrnCorr), "", "", True 'Reverso banco
    End If
    
    PMPasoValoresATX VGSqlConn, "@o_plogsri", 1, SQLVARCHAR, "0", "", ""
    PMPasoValoresATX VGSqlConn, "@o_pmcn", 1, SQLINT4, "0", "", ""
    PMPasoValoresATX VGSqlConn, "@o_precibo", 1, SQLINT4, "0", "", ""
    PMPasoValoresATX VGSqlConn, "@o_autcredimatic", 1, SQLVARCHAR, "0", "", ""
    PMPasoValoresATX VGSqlConn, "@o_codcomercio", 1, SQLVARCHAR, "0", "", ""
    PMPasoValoresATX VGSqlConn, "@o_interescredimatic", 1, SQLMONEY, 0, "interes", ""
    PMPasoValoresATX VGSqlConn, "@o_nombcomercio", 1, SQLVARCHAR, "0", "", ""
  If FMTransmitirRPCATX(VGSqlConn, VLParametroServer, "cob_procesador", "sp_tr_pago_matrvehi_rc", True, "Transaccion Ok", "S", "N", "S", "78", "S", "S") = True Then
        ReDim psRetorno(2, 22)
        FMMapeaMatriz VGSqlConn, psRetorno
        PMMapeaGrid VGSqlConn, grdGrid, False
        VLLogSri = FMRetParamATX(VGSqlConn, 14)   'Log SRI
        VLMCN = FMRetParamATX(VGSqlConn, 15)  'MCN
        VLRecibo = FMRetParamATX(VGSqlConn, 16)    'Recibo
        
'Orden de retorno de los resultsets COBIS PS 06/07/2006
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
        
        If Len(Cta.ClipText) <> 0 Then
            TxtNomCta.Text = FMRetParamATX(VGSqlConn, 2)
        End If
        Comprobante = FMRetParamATX(VGSqlConn, 4)
        'motor = FMRetParamATX(VGSqlConn, 5)
        'chasis = FMRetParamATX(VGSqlConn, 6)
        'periodo = FMRetParamATX(VGSqlConn, 7)
        'fisco = FMRetParamATX(VGSqlConn, 8)
        'administracion = FMRetParamATX(VGSqlConn, 9)
        'TPE ------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 10)
        
        VLNumAutorizaVisa = FMRetParamATX(VGSqlConn, 17)
        VLNumTranAutorizaVisa = SGSecTrn$
        VLCodigoComercio = FMRetParamATX(VGSqlConn, 18)
        VLNombreComercio = FMRetParamATX(VGSqlConn, 20)
        VLInteres = FMRetParamATX(VGSqlConn, 19)
        VLTotal = CCur(Tarjeta.Text) + VLInteres
        
        LOG_AUTORIZACION = psRetorno(1, 4) 'FMRetParamATX(VGSqlConn, 14)
        VLautoriSri = FMRetParamATX(VGSqlConn, 11)
        VLautoriSri = Trim(VLautoriSri)
        VLFecvenSRI = FMRetParamATX(VGSqlConn, 12)
        VLFecvenSRI = Trim(VLFecvenSRI)
        VLSerie_Secuencia = FMRetParamATX(VGSqlConn, 13)  'hy-24-feb-2005
        VLSerie_Secuencia = Trim(VLSerie_Secuencia)
        VTIndicadorSum = 1
        PMIniciaRegSum
        '<-----
        
        PMChequeaATX VGSqlConn
        FLTransmitirUnificadoOsb = True
        VLCambio% = False
      
    Else
        'TPE ------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 10)
        VTIndicadorSum = 0
        PMChequeaATX VGSqlConn
        '<------
        
        'TxtNomProp.Text = ""   'comenta smerino
        TxtNomCta.Text = ""
        VLCambio% = True
        FLTransmitirUnificadoOsb = False
    End If
    PMChequeaATX VGSqlConn
    If FMRetStatusATX(VGSqlConn) <> 0 Then
        On Error Resume Next
        Matricula.SetFocus
        FLTransmitirUnificadoOsb = False
        VTIndicadorSum = 0
    End If
    PMFinTransaccion
    
     'ame 08/04/2010
     If FLTransmitirUnificadoOsb = True Then
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




Public Sub PLTraeNombreTarjeta()

PMInicioTransaccion
PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, "3232", "Trn", ""
PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "S", "", ""
PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(FMObtenerMonedaForma("78")), "Moneda", ""
PMPasoValoresATX VGSqlConn, "@i_empresa", 0, SQLINT2, 0, "Empresa", ""
PMPasoValoresATX VGSqlConn, "@i_codigo", 0, SQLVARCHAR, "0", "Codigo", ""
PMPasoValoresATX VGSqlConn, "@i_nro_tarjeta", 0, SQLVARCHAR, VLVISA_numtar, "", ""    'JPM 14/09/2012: para que no se registra en la tira

If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_tr_pago_colegio_rc", True, "Transaccion Ok", "S", "N", "N", "78", "S", "S") = True Then
    PMMapeaVariableATX VGSqlConn&, VLVISA_nombre
    PMChequea VGSqlConn&
'Else
'    VLVISA_nombre = VLVISA_nombre
End If
PMFinTransaccion

End Sub
'fin cmeg 09Nov2005

'JPM 14/09/2012: rutina de encriptación
Function PLEncripta(p_cadena As String, Dato As String) As Boolean
On Error GoTo errores
Dim crip As New RSA.Criptografo

PLEncripta = True

    'VXmlPublicKey = "mines"
    'VXmlPublicKey = "<?xml version='1.0' encoding='UTF-8' standalone='no'?><RSAKeyValue><Modulus>21LxMEauK0R//RvASYadc/vKLQYVmSJlg41k7C/zxc9d6PeXG1whJ3ylSb8QpX9qZQqyp52k3T6Q&#13;olku68oS7bvmKu/mxoZcoJBGNzu/R4ENgdsWNuNxuTIkXO7lzLmjwuMaHerL82FpjoD75liw1lgf&#13;h0e4hXPUEc0vGHJh4qU=</Modulus><Exponent>AQAB</Exponent></RSAKeyValue>"
    VLStrEncrypt = ""
    crip.readKey VXmlPublicKey
    VLStrEncrypt = crip.EncryptData(p_cadena)
    'MsgBox VLStrEncrypt
    
    Exit Function

errores:
     MsgBox "Error en la ENCRIPTACION de (" & Trim(Dato) & "): " & Trim(CStr(Err.Number)) & " - " & Err.Description & " - Comunique al Jefe de Agencia", _
            vbCritical, "Mensaje"
     PLEncripta = False
End Function

'JPM 14/09/2012: obtiene llave publica de encriptación
Private Function ObtieneLlavePublica() As Boolean
Dim w_retorno As Integer
Dim VGParametros(3, 10) As String
Dim resultado As Integer
On Error GoTo errores

ObtieneLlavePublica = False

PMInicioTransaccion
PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, "62567", "Trn", ""
PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Canal", ""
If FMTransmitirRPCATX(VGSqlConn, "PSSRV1", "cob_procesador", "fp_cons_llave_publica", True, "Llave publica Ok", "S", "N", "S", "78", "S", "S") = True Then
    ReDim Preserve psRetorno(1, 2)
    FMMapeaMatriz VGSqlConn, psRetorno
    VXmlPublicKey = psRetorno(1, 1)
    ObtieneLlavePublica = True
Else
    MsgBox "Error al obtener la LLAVE PUBLICA desde el CSP.", vbCritical, "Mensaje"
End If
PMChequeaATX VGSqlConn  '09/10/2012
PMFinTransaccion

Exit Function

errores:
    MsgBox "Error al obtener la LLAVE PUBLICA.", vbCritical, "Mensaje"
End Function

Private Sub txt_rubro_Change()
 VLCambio% = True 'SMERINO CAMBIO NEW
  VLCambioMatri% = True
End Sub

Private Sub txt_rubro_LostFocus()
 If VGHorarioDif Then 'new smerino
        VLTrn = "3331"
    Else
        VLTrn = "3142"
    End If
        
  'obtener tipo de deuda smerino
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLVARCHAR, "X", "opcion", ""
    PMPasoValoresATX VGSqlConn, "@i_rubro", 0, SQLVARCHAR, Me.txt_rubro.Text, "rubro", ""
    PMPasoValoresATX VGSqlConn, "@o_tipoDeuda", 1, SQLVARCHAR, "0", "empresa", ""
    
    If FMTransmitirRPCATX(VGSqlConn, "", "cob_servicios", "sp_tr_pago_matrvehi_rc", True, "Transaccion Ok", "S", "N", "N", "0", "S", "S") = True Then
        txt_tipo_deuda.Text = FMRetParamATX(VGSqlConn, 1)
        VLTipoDeuda = txt_tipo_deuda.Text
       PMChequeaATX VGSqlConn&
       Else
        MsgBox "Tipo de deuda no parametrizada", vbInformation, "Aviso"
        Exit Sub
       'Empresa.Text = "0"
       PMChequeaATX VGSqlConn&
       PMFinTransaccion
    End If
    
 ' End If 'fin de la validacion
End Sub

'PHOYOSV REF_03 FIN 20180709
Private Sub Consulta_Parametro()
'Consulta parametro para utilizar el servicio del Bus O Csp
Dim VLarregloParametro(30) As String
PMInicioTransaccion
PMPasoValoresATX VGSqlConn&, "@t_trn", 0, SQLINT2, 1579, "", ""
PMPasoValoresATX VGSqlConn&, "@i_operacion", 0, SQLVARCHAR, "Q", "", ""
PMPasoValoresATX VGSqlConn&, "@i_nemonico", 0, SQLVARCHAR, "SRVOSB", "", ""
PMPasoValoresATX VGSqlConn&, "@i_producto", 0, SQLVARCHAR, "CTE", "", ""
If FMTransmitirRPCATX(VGSqlConn&, "", "cobis", "sp_parametro", True, " Consulta de motivos ", "N", "N", "S", "78", "N", "N") Then
   VTR1% = FMMapeaArregloATX(VGSqlConn, VLarregloParametro())
   VLParametroServer = LTrim(RTrim(Trim(VLarregloParametro(4))))
Else
   VLParametroServer = ""
End If
PMChequeaATX VGSqlConn&
PMFinTransaccion
End Sub
'PHOYOSV REF_03 FIN 20180709




