VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "GRID32.OCX"
Object = "{0F1F1508-C40A-101B-AD04-00AA00575482}#1.0#0"; "mhrinp32.ocx"
Object = "{9AED8C43-3F39-11D1-8BB4-0000C039C248}#2.0#0"; "txtin.ocx"
Object = "{DECFDD03-1E4B-11D1-B65E-0000C039C248}#5.0#0"; "mskedit.ocx"
Object = "{00025600-0000-0000-C000-000000000046}#5.2#0"; "crystl32.ocx"
Begin VB.Form FCC77 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "SRI - Imp. Fiscales con CEP-77"
   ClientHeight    =   5850
   ClientLeft      =   705
   ClientTop       =   855
   ClientWidth     =   4920
   KeyPreview      =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5850
   ScaleWidth      =   4920
   Begin VB.PictureBox bitmap 
      Appearance      =   0  'Flat
      BackColor       =   &H80000004&
      BorderStyle     =   0  'None
      Enabled         =   0   'False
      ForeColor       =   &H80000008&
      Height          =   495
      Left            =   360
      ScaleHeight     =   495
      ScaleWidth      =   735
      TabIndex        =   35
      TabStop         =   0   'False
      Top             =   1080
      Visible         =   0   'False
      Width           =   735
   End
   Begin VB.Frame Frame1 
      Enabled         =   0   'False
      ForeColor       =   &H8000000D&
      Height          =   4605
      Left            =   240
      TabIndex        =   21
      Top             =   1200
      Width           =   4455
      Begin MhinrelLib.MhRealInput tarjCredito 
         Height          =   300
         Left            =   2010
         TabIndex        =   13
         Top             =   2385
         Width           =   2280
         _Version        =   65536
         _ExtentX        =   4022
         _ExtentY        =   529
         _StockProps     =   77
         TintColor       =   16711935
         FillColor       =   -2147483634
         CaretColor      =   -2147483642
      End
      Begin VB.TextBox RazonSocial 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Enabled         =   0   'False
         Height          =   285
         Left            =   960
         Locked          =   -1  'True
         TabIndex        =   52
         Top             =   180
         Width           =   3350
      End
      Begin VB.TextBox Stk 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Enabled         =   0   'False
         Height          =   285
         Left            =   2010
         MaxLength       =   18
         TabIndex        =   17
         Top             =   3930
         Width           =   1695
      End
      Begin VB.ComboBox CboTipCta 
         Height          =   315
         Left            =   2010
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Tag             =   "CboProd"
         Top             =   1440
         Width           =   855
      End
      Begin VB.TextBox Nombre 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Enabled         =   0   'False
         Height          =   285
         Left            =   930
         Locked          =   -1  'True
         TabIndex        =   11
         Top             =   1755
         Width           =   3380
      End
      Begin MhinrelLib.MhRealInput CantChq 
         BeginProperty DataFormat 
            Type            =   1
            Format          =   "0"
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   3082
            SubFormatType   =   1
         EndProperty
         Height          =   285
         Left            =   2010
         TabIndex        =   6
         ToolTipText     =   "Cantidad de Cheques"
         Top             =   780
         Width           =   495
         _Version        =   65536
         _ExtentX        =   873
         _ExtentY        =   503
         _StockProps     =   77
         TintColor       =   16711935
         FillColor       =   -2147483639
         MinReal         =   0
         SpinChangeReal  =   0
         AutoHScroll     =   -1  'True
         CaretColor      =   -2147483642
         DecimalPlaces   =   0
         Separator       =   -1  'True
      End
      Begin MhinrelLib.MhRealInput efe 
         Height          =   285
         Left            =   2025
         TabIndex        =   5
         ToolTipText     =   "Valor en Efectivo"
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
      Begin MhinrelLib.MhRealInput Valor 
         Height          =   285
         Left            =   2010
         TabIndex        =   14
         ToolTipText     =   "Valor Total del Impuesto"
         Top             =   2730
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
      Begin MhinrelLib.MhRealInput Cheques 
         Height          =   285
         Left            =   2610
         TabIndex        =   7
         ToolTipText     =   "Valor en Cheques"
         Top             =   780
         Width           =   1695
         _Version        =   65536
         _ExtentX        =   2990
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
      Begin MhinrelLib.MhRealInput EfeCob 
         Height          =   285
         Left            =   2010
         TabIndex        =   8
         ToolTipText     =   "Valor de Efectos de Cobro [F5 Presenta Forma de Pago]"
         Top             =   1140
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
      Begin MhinrelLib.MhRealInput mhNC 
         Height          =   285
         Left            =   2010
         TabIndex        =   4
         ToolTipText     =   "Valor Total del Pago"
         Top             =   3600
         Visible         =   0   'False
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
      Begin MhinrelLib.MhRealInput mhNCReal 
         Height          =   285
         Left            =   2025
         TabIndex        =   22
         TabStop         =   0   'False
         ToolTipText     =   "Valor Total del Pago"
         Top             =   5250
         Visible         =   0   'False
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
      Begin MskeditLib.MaskInBox Cta 
         Height          =   285
         Left            =   2970
         TabIndex        =   10
         Tag             =   "Cta"
         Top             =   1440
         Width           =   1335
         _Version        =   262144
         _ExtentX        =   2355
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
         Left            =   2010
         TabIndex        =   12
         Top             =   2055
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
      Begin MhinrelLib.MhRealInput Comision 
         Height          =   285
         Left            =   2010
         TabIndex        =   15
         ToolTipText     =   "Valor de Comision [F5 Presenta Forma de Pago]"
         Top             =   3330
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
         ReadOnly        =   -1  'True
         SpinChangeReal  =   0
         AutoHScroll     =   -1  'True
         CaretColor      =   -2147483642
         DecimalPlaces   =   2
         Separator       =   -1  'True
      End
      Begin MhinrelLib.MhRealInput Total 
         Height          =   285
         Left            =   2010
         TabIndex        =   16
         ToolTipText     =   "Valor Total del Impuesto"
         Top             =   3630
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
      Begin MhinrelLib.MhRealInput ValorSRI 
         Height          =   285
         Left            =   2010
         TabIndex        =   50
         ToolTipText     =   "Valor de Comision [F5 Presenta Forma de Pago]"
         Top             =   3030
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
         ReadOnly        =   -1  'True
         SpinChangeReal  =   0
         AutoHScroll     =   -1  'True
         CaretColor      =   -2147483642
         DecimalPlaces   =   2
         Separator       =   -1  'True
      End
      Begin MhinrelLib.MhRealInput ValorNC 
         Height          =   285
         Left            =   1200
         TabIndex        =   53
         ToolTipText     =   "Valor de Comision [F5 Presenta Forma de Pago]"
         Top             =   3855
         Visible         =   0   'False
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
         ReadOnly        =   -1  'True
         SpinChangeReal  =   0
         AutoHScroll     =   -1  'True
         CaretColor      =   -2147483642
         DecimalPlaces   =   2
         Separator       =   -1  'True
      End
      Begin MhinrelLib.MhRealInput ValorSubtotal 
         Height          =   285
         Left            =   1200
         TabIndex        =   54
         ToolTipText     =   "Valor de Comision [F5 Presenta Forma de Pago]"
         Top             =   3495
         Visible         =   0   'False
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
         ReadOnly        =   -1  'True
         SpinChangeReal  =   0
         AutoHScroll     =   -1  'True
         CaretColor      =   -2147483642
         DecimalPlaces   =   2
         Separator       =   -1  'True
      End
      Begin MhinrelLib.MhRealInput ValorMulta 
         Height          =   285
         Left            =   1200
         TabIndex        =   55
         ToolTipText     =   "Valor de Comision [F5 Presenta Forma de Pago]"
         Top             =   3135
         Visible         =   0   'False
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
         ReadOnly        =   -1  'True
         SpinChangeReal  =   0
         AutoHScroll     =   -1  'True
         CaretColor      =   -2147483642
         DecimalPlaces   =   2
         Separator       =   -1  'True
      End
      Begin MhinrelLib.MhRealInput ValorInteres 
         Height          =   285
         Left            =   1200
         TabIndex        =   56
         ToolTipText     =   "Valor de Comision [F5 Presenta Forma de Pago]"
         Top             =   2775
         Visible         =   0   'False
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
         ReadOnly        =   -1  'True
         SpinChangeReal  =   0
         AutoHScroll     =   -1  'True
         CaretColor      =   -2147483642
         DecimalPlaces   =   2
         Separator       =   -1  'True
      End
      Begin MhinrelLib.MhRealInput ValorImpto 
         Height          =   285
         Left            =   1200
         TabIndex        =   57
         ToolTipText     =   "Valor de Comision [F5 Presenta Forma de Pago]"
         Top             =   2040
         Visible         =   0   'False
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
         ReadOnly        =   -1  'True
         SpinChangeReal  =   0
         AutoHScroll     =   -1  'True
         CaretColor      =   -2147483642
         DecimalPlaces   =   2
         Separator       =   -1  'True
      End
      Begin MhinrelLib.MhRealInput ValorComp 
         Height          =   285
         Left            =   1200
         TabIndex        =   58
         ToolTipText     =   "Valor de Comision [F5 Presenta Forma de Pago]"
         Top             =   1440
         Visible         =   0   'False
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
         ReadOnly        =   -1  'True
         SpinChangeReal  =   0
         AutoHScroll     =   -1  'True
         CaretColor      =   -2147483642
         DecimalPlaces   =   2
         Separator       =   -1  'True
      End
      Begin TxtinLib.TextValid NumSSN 
         Height          =   285
         Left            =   1200
         TabIndex        =   59
         ToolTipText     =   "Cantidad de Cheques"
         Top             =   1080
         Visible         =   0   'False
         Width           =   855
         _Version        =   65536
         _ExtentX        =   1508
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
         TableName       =   "cc_tipo_impto_sri"
         MinChar         =   0
         Error           =   0
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Tarj.Credito"
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
         TabIndex        =   62
         Top             =   2415
         Width           =   1005
      End
      Begin VB.Label Label5 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Moneda"
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
         TabIndex        =   61
         Top             =   4215
         Width           =   690
      End
      Begin VB.Label lblMoneda 
         Appearance      =   0  'Flat
         BackColor       =   &H00FFFFFF&
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
         Left            =   1200
         TabIndex        =   60
         Top             =   4215
         Width           =   2895
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "Valor a pagar sri:"
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
         TabIndex        =   51
         Top             =   3030
         Width           =   1470
      End
      Begin VB.Label lblChq 
         Caption         =   "Cant - Cheque Cert.:"
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
         Top             =   780
         Width           =   1815
      End
      Begin VB.Label lblefe 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
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
         Left            =   120
         TabIndex        =   32
         Top             =   480
         Width           =   780
      End
      Begin VB.Label lblval 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Valor total:"
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
         Top             =   2730
         Width           =   945
      End
      Begin VB.Label lblStk 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Aut. SRI :"
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
         TabIndex        =   30
         Top             =   3930
         Width           =   855
      End
      Begin VB.Label Label9 
         Caption         =   "Efecto de Cobro:"
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
         TabIndex        =   29
         Top             =   1140
         Width           =   1455
      End
      Begin VB.Label Label8 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Chq.Custodia :"
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
         ForeColor       =   &H00800000&
         Height          =   195
         Left            =   240
         TabIndex        =   28
         Top             =   5250
         Visible         =   0   'False
         Width           =   1260
      End
      Begin VB.Label LblCuenta 
         AutoSize        =   -1  'True
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
         Left            =   120
         TabIndex        =   27
         Top             =   1440
         Width           =   840
      End
      Begin VB.Label LblDebito 
         AutoSize        =   -1  'True
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
         TabIndex        =   26
         Top             =   2055
         Width           =   690
      End
      Begin VB.Label lblValor 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
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
         Index           =   1
         Left            =   120
         TabIndex        =   25
         Top             =   1755
         Width           =   720
      End
      Begin VB.Label Label6 
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
         TabIndex        =   24
         Top             =   3330
         Width           =   1455
      End
      Begin VB.Label Label7 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Total:"
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
         Top             =   3630
         Width           =   510
      End
   End
   Begin VB.TextBox CedRuc 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Enabled         =   0   'False
      Height          =   285
      Left            =   2250
      MaxLength       =   15
      TabIndex        =   20
      Top             =   6600
      Width           =   1695
   End
   Begin VB.TextBox txtNotaVenta 
      Height          =   375
      Left            =   3900
      TabIndex        =   19
      Top             =   6795
      Visible         =   0   'False
      Width           =   735
   End
   Begin TxtinLib.TextValid Tipo 
      Height          =   285
      Left            =   1200
      TabIndex        =   3
      ToolTipText     =   "Cantidad de Cheques"
      Top             =   720
      Visible         =   0   'False
      Width           =   615
      _Version        =   65536
      _ExtentX        =   1085
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
      TableName       =   "cc_tipo_impto_sri"
      MinChar         =   0
      Error           =   0
   End
   Begin MskeditLib.MaskInBox Cedula 
      Height          =   285
      Left            =   3000
      TabIndex        =   1
      Tag             =   "Chq"
      ToolTipText     =   "Cédula o Ruc del Contribuyente"
      Top             =   360
      Visible         =   0   'False
      Width           =   1335
      _Version        =   262144
      _ExtentX        =   2355
      _ExtentY        =   503
      _StockProps     =   253
      Text            =   "_____________"
      BorderStyle     =   1
      Enabled         =   -1  'True
      Decimals        =   0
      Separator       =   -1  'True
      MaskType        =   1
      HideSelection   =   0   'False
      MaxLength       =   0
      AutoTab         =   -1  'True
      DateString      =   "_____________"
      FormattedText   =   ""
      Mask            =   "#############"
      HelpLine        =   "Ingrese el numero de cheque."
      ClipText        =   ""
      ClipMode        =   0
      StringIndex     =   0
      DateType        =   0
      DateSybase      =   "09/08/1997"
      AutoDecimal     =   -1  'True
      MinReal         =   0
      MaxReal         =   3.4e38
      Units           =   0
      Errores         =   0
   End
   Begin MskeditLib.MaskInBox CEP 
      Height          =   285
      Left            =   1200
      TabIndex        =   2
      Tag             =   "Chq"
      ToolTipText     =   "CEP del sri"
      Top             =   420
      Width           =   1335
      _Version        =   262144
      _ExtentX        =   2355
      _ExtentY        =   503
      _StockProps     =   253
      Text            =   "____________"
      BorderStyle     =   1
      Enabled         =   -1  'True
      Decimals        =   0
      Separator       =   -1  'True
      MaskType        =   1
      HideSelection   =   0   'False
      MaxLength       =   0
      AutoTab         =   -1  'True
      DateString      =   "____________"
      FormattedText   =   ""
      Mask            =   "############"
      HelpLine        =   "Ingrese el numero de cheque."
      ClipText        =   ""
      ClipMode        =   0
      StringIndex     =   0
      DateType        =   0
      DateSybase      =   "09/08/1997"
      AutoDecimal     =   -1  'True
      MinReal         =   0
      MaxReal         =   3.4e38
      Units           =   0
      Errores         =   0
   End
   Begin MhinrelLib.MhRealInput txttotchq 
      Height          =   285
      Left            =   450
      TabIndex        =   34
      TabStop         =   0   'False
      Top             =   6600
      Visible         =   0   'False
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
      Enabled         =   0   'False
      TintColor       =   16711935
      FillColor       =   16777215
      MaxReal         =   3.4E+38
      MinReal         =   0
      AutoHScroll     =   -1  'True
      CaretColor      =   -2147483642
      DecimalPlaces   =   2
      Separator       =   -1  'True
   End
   Begin MhinrelLib.MhRealInput prop 
      Height          =   285
      Left            =   240
      TabIndex        =   36
      TabStop         =   0   'False
      Top             =   7215
      Visible         =   0   'False
      Width           =   1935
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
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
      AutoHScroll     =   -1  'True
      CaretColor      =   -2147483642
      DecimalPlaces   =   2
      Separator       =   -1  'True
   End
   Begin MhinrelLib.MhRealInput locobj 
      Height          =   285
      Left            =   3960
      TabIndex        =   37
      TabStop         =   0   'False
      Top             =   6615
      Visible         =   0   'False
      Width           =   1935
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
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
      AutoHScroll     =   -1  'True
      CaretColor      =   -2147483642
      DecimalPlaces   =   2
      Separator       =   -1  'True
   End
   Begin MhinrelLib.MhRealInput plaz 
      Height          =   285
      Left            =   240
      TabIndex        =   38
      TabStop         =   0   'False
      Top             =   7815
      Visible         =   0   'False
      Width           =   1935
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
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
      AutoHScroll     =   -1  'True
      CaretColor      =   -2147483642
      DecimalPlaces   =   2
      Separator       =   -1  'True
   End
   Begin MSGrid.Grid grdEfectoCob 
      Height          =   1335
      Left            =   4080
      TabIndex        =   39
      TabStop         =   0   'False
      Top             =   7095
      Width           =   4215
      _Version        =   65536
      _ExtentX        =   7435
      _ExtentY        =   2355
      _StockProps     =   77
      BackColor       =   16777215
      Enabled         =   0   'False
      Rows            =   11
      Cols            =   12
      FixedRows       =   0
      FixedCols       =   0
   End
   Begin MhinrelLib.MhRealInput mhrCupoMin 
      Height          =   285
      Left            =   3690
      TabIndex        =   40
      TabStop         =   0   'False
      ToolTipText     =   "Valor Total del Pago"
      Top             =   6915
      Width           =   1215
      _Version        =   65536
      _ExtentX        =   2143
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
   Begin MhinrelLib.MhRealInput txttotodb 
      Height          =   285
      Left            =   450
      TabIndex        =   41
      TabStop         =   0   'False
      Top             =   6915
      Visible         =   0   'False
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
      Enabled         =   0   'False
      TintColor       =   16711935
      FillColor       =   16777215
      MaxReal         =   3.4E+38
      MinReal         =   0
      AutoHScroll     =   -1  'True
      CaretColor      =   -2147483642
      DecimalPlaces   =   2
      Separator       =   -1  'True
   End
   Begin TxtinLib.TextValid Cau 
      Height          =   285
      Left            =   240
      TabIndex        =   42
      Top             =   7335
      Visible         =   0   'False
      Width           =   450
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   253
      BorderStyle     =   1
      Enabled         =   0   'False
      Range           =   ""
      MaxLength       =   3
      Character       =   0
      Type            =   4
      HelpLine        =   "Ingrese el tipo de operacion. F5 Ayuda"
      Pendiente       =   ""
      Connection      =   0
      AsociatedLabelIndex=   0
      TableName       =   "cc_causa_oioe"
      MinChar         =   0
      Error           =   0
   End
   Begin TxtinLib.TextValid Cedula1 
      Height          =   285
      Left            =   1200
      TabIndex        =   0
      Top             =   120
      Visible         =   0   'False
      Width           =   1335
      _Version        =   65536
      _ExtentX        =   2355
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
   Begin Crystal.CrystalReport rptBAD 
      Left            =   2610
      Top             =   0
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
      TabIndex        =   63
      Top             =   45
      Visible         =   0   'False
      Width           =   900
   End
   Begin VB.Label sal_tipo 
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
      Left            =   1845
      TabIndex        =   49
      Top             =   720
      Visible         =   0   'False
      Width           =   2895
   End
   Begin VB.Label lblplaz 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Chq ot. plazas:"
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
      ForeColor       =   &H00800000&
      Height          =   195
      Left            =   6960
      TabIndex        =   48
      Top             =   6855
      Visible         =   0   'False
      Width           =   1290
   End
   Begin VB.Label lblloc 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Chq local:"
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
      ForeColor       =   &H00800000&
      Height          =   195
      Left            =   6840
      TabIndex        =   47
      Top             =   8535
      Visible         =   0   'False
      Width           =   870
   End
   Begin VB.Label lblprop 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Chq propios:"
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
      ForeColor       =   &H00800000&
      Height          =   195
      Left            =   4920
      TabIndex        =   46
      Top             =   8535
      Visible         =   0   'False
      Width           =   1080
   End
   Begin VB.Label lblCliente 
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
      Left            =   2535
      TabIndex        =   45
      Top             =   7215
      Width           =   855
   End
   Begin VB.Label lblNombreClte 
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
      Left            =   1920
      TabIndex        =   44
      Top             =   6615
      Width           =   855
   End
   Begin VB.Label lblDias 
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
      Left            =   3045
      TabIndex        =   43
      Top             =   6615
      Width           =   855
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      Caption         =   "C.E.P.:"
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
      TabIndex        =   18
      Top             =   420
      Width           =   615
   End
End
Attribute VB_Name = "FCC77"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'********************************************************************************'
'*              MODIFICACIONES                                                  *'
'* REF  FECHA       AUTOR          DESCRIPCION                                  *'
'*  02  19/Sep/2017 Vanessa Miranda FACOFF-AP-SGC00029747-SGC00029748 Agregar   *'
'*      Clave de Acceso Facturación Electrónica Offline                         *'
'*  03  28/Feb/2018 Danny Olaya     SGC00030409                                 *'
'*      Cobro de Comisión Déb. Cuenta Facturación Offline                       *'
'*  04  23/Dic/2019 Pablo Ricaurte     RECMPS-78                                *'
'*      Migracion de csp a OSB                                                  *'
'********************************************************************************'

Dim VLCambio As Integer
Dim VLCambioCedruc As Integer
'-------------------------------
Dim VTNombreClte As String
Dim VTNombreOfic As String
Dim VTTipoCta As String
Dim VTCta   As String
Dim VTEfeCob As String
Dim VTCupoArancel As Long
Dim VTCupoMin As Long
Dim VTClte As Long
Dim VTDiasGracia As Integer
Dim VTOficial As Long
Dim VLTotEfe As Long
Dim activa As Boolean
'-------------------------------
Dim VLCta As String
Dim VLTrn As String
Dim VLfirma As Boolean
Dim VLTipoOK As Boolean
Dim VLautoriSri As String
Dim VLFecvenSRI As String
'----------------------
Dim VLTotCom As Currency
Dim VLEfe_com  As Currency
Dim VLChq_com As Currency
Dim VLDeb_com As Currency
Dim VLCta_com  As String
Dim VLTipCta_com As String
Dim VLSerie_Secuencia As String
'-------------------------------
Dim objUpdate As Object
Dim VLSsn As String
Dim VLSsnRevTimeOut As String
Dim VLFecHora As String
Dim VLFecContable As String
Dim VLProvincia As String
Dim VLRevTimeOut As Boolean
Dim VLFlagSumadora As Boolean
Dim psRetorno() As String
Dim VLFechaPago As String
Dim VLValorPagar As String
Dim VLMoneda As Integer
Dim VLDescMonCta As String
Dim VLNombre As String  'TC 19/02/2010
Dim VLTipo_imp As String        'ame 08/04/2010
Dim VLfact_elect As String      'ame 08/04/2010
Dim VLFecinivig As String       'sme 06/08/2011
Dim VLFecfinvig As String       'sme 06/08/2011
Dim VGFechaProceso2 As String   'sme 09/20/2011
Dim VLiva As Currency 'smerino iva
Dim VlbaseImp As Currency 'smerino iva
Dim VLclave_acceso As String 'ref02 vmirandt
Dim VLHorario As String 'ref02 vmirandt
Dim LOG_AUTORIZACION As String
Dim VLParametroServer As String 'pricaura REF_04 20191223


Private Sub CantChq_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Ingrese Cantidad de Cheques"
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

Private Sub CboTipCta_Click()
    VLfirma = False
End Sub

Private Sub Cedula1_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Número de Cédula/RUC"
End Sub

Private Sub Cedula1_KeyPress(KeyAscii As Integer)
    VLCambio = True
    VLCambioCedruc% = True
End Sub

Private Sub Cedula1_LostFocus()
    If VLCambio% Then
        For k% = 0 To grdEfectoCob.Rows - 1
            grdEfectoCob.Row = k%
            For I% = 0 To 6
                grdEfectoCob.Col = I%
                grdEfectoCob.Text = ""
            Next I%
        Next k%
    End If
    If Len(Cedula1.Text) = 13 Then
        activa = True
    End If
    If activa = True Then
        activa = False
    End If
End Sub

Private Sub CEP_KeyDown(KeyCode As Integer, Shift As Integer)
    Select Case KeyCode%
    Case CGTeclaSUPR%
        CEP.Text = ""
    Case CGTeclaENTER%
        activa = True
    Case CGTeclaUP%, CGTeclaREPAG%
        SendKeys "+{TAB}"
    Case CGTeclaDOWN%, CGTeclaAVPAG%
        SendKeys "{TAB}"
    Case CGTeclaF5%
        If VGTipoEjecucion% <> CGReverso% Then
'            pricaura Ini Ref-04 20191223
'            If Trim(Cedula1) = "" Or Trim(Cedula1) = "_____________" Then
'                Exit Sub
'            End If
'            pricaura Fin Ref-04 20191223
            If Trim(CEP) = "" Or Trim(CEP) = "____________" Then
                Exit Sub
            End If
'            pricaura Ini Ref-04 20191223
'            If Trim$(Tipo.Text) = "" Or Trim$(sal_tipo.Caption) = "" Then
'                Exit Sub
'            End If
'            pricaura Fin Ref-04 20191223
            'If Not FLTramaSwitch("C") Then
            If Not FLConsOFP() = True Then
                If Trim$(Nombre.Text) <> "" Then
                    MsgBox Nombre.Text, vbInformation, "Mensaje del sri"
                End If
                Exit Sub
            End If
        End If
    End Select
    VLCambio% = True
    VLCambioCedruc% = True
End Sub

Private Sub Cheques_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Ingrese Valor en Cheque"
End Sub

Private Sub Comision_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "F5 Detalle de Comision"
End Sub

Private Sub Comision_KeyDown(KeyCode As Integer, Shift As Integer)
Dim VLAcumulado As Currency
    If KeyCode% = CGTeclaF5% Then
        If Comision <> 0# Then
            '-- inicializo variables
            SGComision = 0#   'PS 29/01/2004
            SGTipoCta = ""    'PS 29/01/2004
            SGCedula = ""     'PS 29/01/2004
     
            VLAcumulado = SGAcumulado
           
            VGUsar15 = efe.ValueReal     'eas
           
            SGUsar = VLEfe_com
            
            SGComision = Comision
            SGTipoCta = FCC77.CboTipCta.ListIndex
            SGCedula = Cedula1
            SGValida = "S"
            'ref03 Ini
            SGNumCuenta = FCC77.Cta.Text
            'ref03 Fin
            
            FCC112.Show 1
            VLEfe_com = FCC112.VLEfe_com
            VLChq_com = FCC112.VLChq_com
            VLDeb_com = FCC112.VLDeb_com
            VLTipCta_com = FCC112.VLTipCta_com
            VLCta_com = FCC112.VLCta_com
            VLTotCom = VLEfe_com + VLChq_com + VLDeb_com
            
            VLNombre = SGNombre
            
            SGUsar = VGUsar15  'efe.ValueReal
            efe.ValueReal = SGUsar
            
            SGAcumulado = VLAcumulado
            VGUsar15 = VLEfe_com
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
    'TPE Validacion Para Cuenta.
    VLCta = Cta.Text
    VLfirma = False
End Sub

Private Sub Efe_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Valor en Efectivo"

    If Not VLFlagSumadora Then
        Exit Sub
    End If
    
    If VLTipoOK = False Then
        'Tipo.SetFocus    pricaura Ref-04 20191223
        Exit Sub
    End If
    'Sumadora ----->
    If SGActivaSum = False Then
        FSumIng.abrirAltaDenominacion = True
        PMIngresoEfectivo
        efe.Text = Format$(SGUsar, "####,###,##0.00")
        SGActual = 0
        If CantChq.Enabled Then
            CantChq.SetFocus
        End If
    Else
        SGActivaSum = False
    End If
    '<-------
End Sub

Private Sub EfeCob_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "F5 Detalle de Efecto Cobro"
    EfeCob.Text = EfeCob.Text
End Sub

Private Sub EfeCob_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode% = 8 Or KeyCode% = 46 Then
        EfeCob = VLTotEfe
    End If
    If KeyCode% = CGTeclaF5% Then
    VLEfecto = FLEfeCobro
       FCC84EC.MhrValor = 0
       For contador = 0 To 9
            FCC77.grdEfectoCob.Row = contador
            FCC77.grdEfectoCob.Col = 0
            If Trim(FCC77.grdEfectoCob.Text) = "" Then
               Exit For
            End If
            If contador > 0 Then
               FCC84EC.GrdForPag.AddItem ""
            End If
            FCC84EC.GrdForPag.Row = contador + 1
            FCC84EC.GrdForPag.Col = 0
            FCC84EC.GrdForPag.Text = contador + 1
            
            For k% = 1 To 12
                 FCC84EC.GrdForPag.Col = k%
                 FCC77.grdEfectoCob.Col = k% - 1
                 FCC84EC.GrdForPag.Text = FCC77.grdEfectoCob.Text
                 If k% = 2 Then
                    FCC84EC.MhrValor = FCC84EC.MhrValor + CCur(FCC77.grdEfectoCob.Text)
                 End If
            Next k%
       Next contador
       
      If contador > 0 Then
            FCC84EC.GrdForPag.AddItem ""
            FCC84EC.txtdatos(3).Enabled = False
       End If
       
       FCC84EC.txtdatos(3).Text = Trim(lblCliente.Caption)
       FCC84EC.lbldatos(2).Caption = lblNombreClte.Caption ' VTNombreClte$
       FCC84EC.txtdatos(0).Text = VTOficial
       FCC84EC.lbldatos(1).Caption = VTNombreOfic$
       FCC84EC.LblTipoCta.Caption = VTTipoCta$
       FCC84EC.Cta.Clear
       FCC84EC.Cta.Text = Format(VTCta$, "000-000000-0")
       FCC84EC.mhNC = mhNCReal
       If Trim(lblCliente) = "" Then lblCliente.Caption = "0"
       FCC84EC.FLRecibe FCC77, 77, CLng(lblCliente), CedRuc.Text, "01"
       FCC84EC.Show 1
       VLTotEfe = EfeCob
'       If EfeCob.Text <> "" Or EfeCob.Text <> "0.00" Then
'            valor.Text = Str(FMCCurATX((Efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((EfeCob.Text)) + FMCCurATX((mhNCReal.Text)))   'VIVI
'       End If

  End If
  
  If KeyCode% = CGTeclaENTER% Then
      SendKeys "{TAB}"
  End If

End Sub

Private Sub EfeCob_KeyPress(KeyAscii As Integer)
    KeyAscii% = 0
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
    And CCur(efe.Text) <> 0 _
    And VGTran = "03" Then
        SGUsar = efe.Text
    End If
    VGTran = "0"
    If VGTipoEjecucion% <> CGReverso% Then
        CEP.Clear      'pricaura Ref-04 20191223
        Cedula1.Text = "" 'smerino ajustes
    End If
    
    'LBP Inicio RECA-CC-SGC00025869 30/07/2016
    VGFormaPago = ""
    VGCom_aux = 0
    VGComision_original = 0
    VGCompensacion = 0
    VGPorcentajeComp = "0"
    VGPorcentajeIVA = "0"
    'LBP Fin 30/07/2016'Fin LBP
    
    Consulta_Parametro  'pricaura REF_04 20191223
End Sub

Sub Form_Load()
On Error GoTo Etiqueta_Error

  CGLongTramaBill = TipoTramaBillete.CadenaCorta   'JPM lectora de billetes
  lectoraBill.Limpiar             'JPM lectora de billetes
    VLFlagSumadora = True
  VLfirma = False
  VLTipoOK = False
  'Sumadora  ----->
  SGUsar = 0
  SGActivaSum = False
  SGActual = 1
  '<-----
  'Inicio Moneda
  VLMoneda = VGmoneda%
  
   
    'LBP Inicio RECA-CC-SGC00025869 30/07/2016
    VGFormaPago = ""
    VGCom_aux = 0
    VGComision_original = 0
    VGCompensacion = 0
    VGPorcentajeComp = "0"
    VGPorcentajeIVA = "0"
    'LBP Fin 30/07/2016'Fin LBP
      
  VLTotCom = 0#
  VLEfe_com = 0#
  VLChq_com = 0#
  VLDeb_com = 0#
  VLCta_com = ""
  VLTipCta_com = ""
    'Cuando las tablas se encuentren listas proceder con el llamado al sp
  VLCambio% = False
  VLCambioCedruc% = False
  Me.Move VGLeft%, VGTop%, 5010, 5805
  
  CboTipCta.AddItem "CTE"
  CboTipCta.AddItem "AHO"
  CboTipCta.ListIndex = 0
  efe.DecimalPlaces = FMObtenerDecimales(VGmoneda%)
  Cheques.DecimalPlaces = FMObtenerDecimales(VGmoneda%)
  prop.DecimalPlaces = FMObtenerDecimales(VGmoneda%)
  locobj.DecimalPlaces = FMObtenerDecimales(VGmoneda%)
  plaz.DecimalPlaces = FMObtenerDecimales(VGmoneda%)
  Valor.DecimalPlaces = FMObtenerDecimales(VGmoneda%)
  EfeCob.DecimalPlaces = FMObtenerDecimales(VGmoneda%)
  If VGTipoLogon% = CGNormal% Then
    Tipo.Connection = VGMap
    Set Tipo.AsociatedLabel = sal_tipo
    Tipo.Enabled = True
  End If
  
  'lfcm 22-marzo-2007
  'Se aumenta el tamanio de la forma porque se agrega la forma de Pago Tarjeta de Credito
  Me.Height = 6330
  
  '-- obtiene el valor de la comision
  'PMInicioTransaccion
  'PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "cl_costo_serv_comision", "", ""
  'PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR&, "V", "", ""
 'PMPasoValoresATX VGSqlConn&, "@i_codigo", 0, SQLCHAR&, "IMPFISC", "", ""
  'If FMTransmitirRPCATX(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "", "N", "S", "I", "0", "N", "N") Then
   ' PMMapeaObjetoATX VGSqlConn&, Comision
    'PMChequeaATX VGSqlConn&
   ' PMFinTransaccion
 ' Else
   ' Comision = 0#
   ' PMChequeaATX VGSqlConn&
   ' PMFinTransaccion
 ' End If
  
  'Total.Text = CDbl(Comision.Text)
  
  
  'smerino aumenta comision
    'CONSULTA TASA DEL IVA Y BASE IMPONBLE
   PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 4050, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLVARCHAR, "C", "opcion", ""
    PMPasoValoresATX VGSqlConn, "@i_servi_person", 0, SQLVARCHAR, "SRI", "Servicio Person", ""
    PMPasoValoresATX VGSqlConn, "@i_rubro_person", 0, SQLVARCHAR, "POFP", "Rubro Person", ""
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
    
    'pricaura Ref-04 ini 20191223
    If VGTipoEjecucion% = CGReverso% Then
        Comision = 0#
    End If
    If VGTipoEjecucion% <> CGReverso% Then
        If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_val_servicios_varios", True, "Transaccion Ok", "S", "N", "N", "0", "S", "S") = True Then
        'If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_val_servicios_varios", True, "", "N", "S", "I", "0", "N", "N") = True Then
            'MsgBox "Paso 3"
            Comision.Text = FMRetParamATX(VGSqlConn, 1)
            VlbaseImp = FMRetParamATX(VGSqlConn, 3) 'smerino
            VLiva = FMRetParamATX(VGSqlConn, 4) 'smerino
           'PMChequeaATX VGSqlConn&
           
             'LBP Inicio RECA-CC-SGC00025869
             If Comision.Text > 0 Then
                VGCom_aux = FMDevuelveComisionReal(Comision, False, 77)
                If VGCom_aux <> CDbl(Comision.Text) Then
                    VGComision_original = Comision.Text
                    Comision.Text = VGCom_aux
                Else
                    VGComision_original = Comision.Text
                End If
             End If
            'LBP Fin RECA-CC-SGC00025869
           
        Else
           Comision = 0#
           PMChequeaATX VGSqlConn&
           PMFinTransaccion
        End If
    End If
    'pricaura Ref-04 fin 20191223

 'FIN DE BASE IMPONIBLE
 Total.Text = CDbl(Comision.Text)
 
  
  If FMFileExist(VGDirBitmaps$ & "\sri.bmp") Then
     bitmap.Picture = LoadPicture(VGDirBitmaps$ & "\sri.bmp")
  Else
     bitmap.Picture = LoadPicture()
  End If
  
  bitmap.Visible = True
  
  Frame1.Enabled = False
  
  If VGTipoEjecucion% = CGReverso% Or VGTipoEjecucion% = CGAutoriza% Then
    If VGTipoEjecucion% = CGReverso% Then
      'Sumadora ----->
      SGPrimeraVezRev = 0
      '<----------
      PMSetValorReverso sal_tipo, "@i_descrip_impto"
      PMSetValorReverso NumSSN, "@o_ssn"
      PMSetValorReverso CEP, "@i_cep"
      PMSetValorReverso efe, "@i_efe"
      PMSetValorReverso CantChq, "@i_cant_chq"
      PMSetValorReverso Cheques, "@i_cheque"
      PMSetValorReverso RazonSocial, "@i_razon_soc"
      PMSetValorReverso Valor, "@i_total"
      PMSetValorReverso ValorSRI, "@i_total"
      PMSetValorReverso txtNotaVenta, "@o_nota_venta"
      VLSerie_Secuencia = txtNotaVenta.Text
      PMSetValorReverso Comision, "@i_efe_com"
      VLEfe_com = Comision.ValueReal
      PMSetValorReverso Comision, "@i_chq_com"
      VLChq_com = Comision.ValueReal
      PMSetValorReverso Comision, "@i_deb_com"
      VLDeb_com = Comision.ValueReal
      VLTotCom = VLEfe_com + VLChq_com + VLDeb_com
      Comision = VLTotCom
      
      PMSetValorReverso Cta, "@i_cta_com"
      VLCta_com = Cta.ClipText
      PMSetValorReverso CboTipCta, "@i_tipocta_com"
      VLTipCta_com = CboTipCta.Text
      
      PMSetValorReverso CboTipCta, "@i_producto"
      PMSetValorReverso Cta, "@i_cuenta"
      PMSetValorReverso Debito, "@i_debito"
      
      'lfcm 22-marzo-2007
      'Valor de reverso por pago con Tarjeta de Credito
      PMSetValorReverso Me.tarjCredito, "@i_valtarjeta"
  
      PMSetValorReverso Tipo, "@i_tipo"
      Tipo.Text = Tipo.Tag
      PMSetValorReverso Cedula1, "@i_Cedula"
      PMSetValorReverso EfeCob, "@i_efecob"     'VIVI
      PMSetValorReverso Stk, "@i_adhesivo"
      PMSetValorReverso txttotchq, "@i_efechq"
      'JPM lectora de billetes -->
      'recuperar solo la primera trama, reverso no requiere todas las tramas completas
      lbl_paramrev.Visible = False
      VGNumParamBAD = 0
      PMSetValorReverso lbl_paramrev, "@e_desglose1"
      VGDesglAltaDenom(0) = lbl_paramrev.Caption
'      PMSetValorReverso lbl_paramrev, "@e_desglose2"
'      VGDesglAltaDenom(1) = lbl_paramrev.Caption
'      PMSetValorReverso lbl_paramrev, "@e_desglose3"
'      VGDesglAltaDenom(2) = lbl_paramrev.Caption
'      If VGDesglAltaDenom(0) + VGDesglAltaDenom(1) + VGDesglAltaDenom(2) <> "" Then
      If Trim(VGDesglAltaDenom(0)) <> "" Then
        VGDatPersBillAltDen.dataOK = True
      End If
'      '<-- JPM lectora de billetes
      
      SGUsar = CDbl(efe.Text) + CDbl(VLEfe_com) 'por reverso sumadora
    End If
  End If

    If Not (VGMatrizSwitchFlagSRI) Then
        VGDatosConexionSRI = FMParametroUpLoadDll("IPSW", "CTE")
        VGMatrizSwitchFlagSRI = True
    End If
    Exit Sub
Etiqueta_Error:
    MsgBox Err.Description, vbCritical, "Error"
End Sub

Sub Form_Unload(Cancel As Integer)
  VGUsar15 = 0
  PMCerrarForma "77"
  lectoraBill.Limpiar   'JPM lectora de billetes
End Sub
 
Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
 
If Shift = CGTeclaCTRL% + CGTeclaALT% And KeyCode% = CGTeclaF9% Then
  PMObtenerMonedaForma "77"
  Exit Sub
End If
If Shift = CGTeclaCTRL% And KeyCode% = CGTeclaI% Then
  PMReimpresion
  Exit Sub
End If
If Shift = CGTeclaCTRL% And KeyCode% = CGTeclaF2% Then
  If VGTipoEjecucion% = CGNormal% Then
    PMSetEjecucionReverso
    If FMSupervisor("77") = True Then
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
       SGUsar = efe.ValueReal + VLEfe_com
       PLTransmitir
    End If
  Case CGTeclaESC%
    Unload Me
    'TPE variable para validacion de Cod Cuenta
    VLCta = ""      'Solo en caso de existir campo Cod. De cuenta.
  Case CGTeclaHOME%
    PMCambiarForma Me
  Case CGTeclaF2%
    VLMoneda = VGmoneda%
    VLDescMonCta = ""
    lblMoneda.Caption = ""
    ' Me.Cedula1.SetFocus
    Frame1.Enabled = False
    RazonSocial.Text = ""
    VLfirma = False
    VLTipoOK = False
    If Tipo.Enabled Then
      'Tipo.SetFocus    pricaura Ref-04 20191223
    End If
    activa = True
    Tipo.Text = ""
    efe.Text = "0.00"
    CantChq.Text = "0"
    Cheques.Text = "0.00"
    prop.Text = "0.00"
    locobj.Text = "0.00"
    plaz.Text = "0.00"
    Valor.Text = "0.00"
    ValorSRI.Text = "0.00"
    sal_tipo.Caption = ""
    EfeCob.Text = "0.00"
    mhNC.Text = "0.00"
    mhNCReal.Text = "0.00"
    txttotchq.Text = "0.00"
    txttotodb.Text = "0.00"
    Cau.Text = ""
    Cedula1.Enabled = True       'VIVI
    Stk.Text = ""
    Cedula1.Text = ""
    CEP.Text = ""
    Frame1.Caption = ""
    Debito.Enabled = False
    CboTipCta.ListIndex = 0
    Debito.Text = "0.00"
    
    'LBP Inicio RECA-CC-SGC00025869 30/07/2016
    VGFormaPago = ""
    VGCom_aux = 0
    VGComision_original = 0
    VGCompensacion = 0
    VGPorcentajeComp = "0"
    VGPorcentajeIVA = "0"
    'LBP Fin 30/07/2016'Fin LBP
    
    'lfcm 22-marzo-2007
    'Borrado del campo Tarjeta de Credito
    Me.tarjCredito.Text = "0.00"
    
    Cta.Text = ""
    Nombre.Text = ""
    Cheques.Enabled = True
    'inicio variable de Validación
    VLCta = ""
    '*********************************
    'EFECTO DE COBRO
    lblCliente.Caption = ""
    lblNombreClte.Caption = ""
    CedRuc.Text = ""
    VTEfeCob$ = 0#
    VTCupoArancel = 0#
    VTDiasGracia = 0
    VTClte = 0
    VTNombreClte$ = ""
    VTOficial = 0
    VTNombreOfic$ = ""
    VTTipoCta$ = ""
    VTCta$ = ""
    mhrCupoMin = 0#
    VLTotEfe = 0#
    VLTotCom = 0#
    VLEfe_com = 0#
    VLChq_com = 0#
    VLDeb_com = 0#
    VLCta_com = ""
    VLTipCta_com = ""
    For contador = 0 To 9
         grdEfectoCob.Row = contador
         For I% = 0 To grdEfectoCob.Cols - 1
            grdEfectoCob.Col = I%
            grdEfectoCob.Text = ""
         Next I%
    Next
    For I% = 0 To 2
        FCC84EC.lbldatos(I%) = ""
    Next I%
    FCC84EC.lblciudad.Caption = ""
    FCC84EC.lblOficina.Caption = ""
    FCC84EC.lblTipChq.Caption = ""
    Unload FCC84EC
    
    '*********************************
    PMLimpiarTransaccion "77"
    VGAutoriza = "N"
    
    '------> Sumadora
    SGUsar = 0
    VGUsar15 = 0
    If Shift = 0 _
    And VGTipoConsAutom% = 0 _
    And VGTipoEjecucion% <> CGReverso% Then  'TPEAdiciono Validacion Por Consulta Automatica y Reverso
        SGActual = 1
        FSumIng.Hide
        FSumIng.Form_KeyDown CGTeclaF2%, 0
        If Tipo.Enabled Then
            'Tipo.SetFocus    pricaura Ref-04 20191223
        End If
        Unload FSumIng
    End If
    SGActivaSum = False
    '<------
    Cedula1.Enabled = True
    CEP.Enabled = True
    Tipo.Enabled = True
    'Cedula1.SetFocus
    lectoraBill.Limpiar     'JPM lectora de billetes
  Case CGTeclaF3%
    'Sumadora ------>
     If VGTipoEjecucion% <> CGReverso% Then
        If (VGTipoConsAutom% = 1 _
            And VGStatusCon = "A") _
            Or VGTipoConsAutom% = 0 Then
                FSumIng.abrirAltaDenominacion = True
                PMIngresoEfectivo
                SGActual = 0
                efe.Text = SGUsar
                If efe.Enabled Then
                    efe.SetFocus
                End If
        End If
    End If
    '<------

 Case CGTeclaF9%
    If VGTipoEjecucion% = CGNormal% Then
       If FMSupervisor("77") = True Then
          VGAutoriza = "S"
          VLFlagSumadora = False
       End If
    End If
    
  End Select
End Sub
Public Sub PLImprimirComprobante()

     If VLTotCom > 0 And VGTipoEjecucion = CGNormal% Then
    
        VGparlong$ = "66"  'smerino
        VGpartop$ = "00"
        VGparleft$ = "07"
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
        'PMSetDetalle "v" + "Junin 200 y Panama         " + "Aut. SRI:" + VLautoriSri
        PMSetDetalle "v" + "Junin 200 y Panama         "
        PMSetDetalle "v" + "CONTRIBUYENTE ESPECIAL     " + "Fecha aut :" + VLFecinivig
        PMSetDetalle "v" + "NOTIFICACION No. 39 de Julio 18 de 1995 " + "Valido hasta :" + VLFecfinvig
        PMSetDetalle "v" + "RESOLUCION No. 6925 de Julio 4 de 1995"
        PMSetDetalle "v" + "Sr.(es): " + (SGNombre)
        PMSetDetalle "v" + "CI/RUC: " + (Replace(SGCedula, "_", "")) + "   " + "Ofic.: " + VGDes_Oficina$
        'PMSetLineaImpresion "v" + "Costo Serv. Recaudacion  " + "Fecha: " + Format(VGFechaProceso, VGFormatoFecha$) + " " + Format(Now, VGFormatoHora$) + " " + IIf(VGHorarioDif, "H:D", "H:N")
        'PMSetDetalle "v" + "Costo Serv. Recaudacion  " + "Fecha: " + Format(VGFechaProceso, VGFormatoFecha$) + " " + IIf(VGHorarioDif, "H:D", "H:N")
        PMSetDetalle "v" + "LOG AUTORIZACION SRI: " + LOG_AUTORIZACION
        PMSetDetalle "v" + "Costo Serv. Recaudacion  " + "Fecha: " + VGFechaProceso2 + " " + IIf(VGHorarioDif, "H:D", "H:N")
        PMSetDetalle "v" + "SRI-Imp. Fiscales con CEP" + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 8, CGJustificacionDerecha)
        PMSetDetalle "v" + "Subtotal:    " + FMEspaciosATX(Format(VlbaseImp, VGFormatoMoney), 8, CGJustificacionDerecha) + " " + "Iva 12%: " + FMEspaciosATX(Format(VLiva, VGFormatoMoney), 8, CGJustificacionDerecha)
        PMSetDetalle "v" + "VALOR TOTAL: " + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 8, CGJustificacionDerecha) + " " + "Referencia: " + (Trim(Cedula1))
        If VLTipo_imp = "O" Then
        PMSetDetalle "v" + "Caj: " + VGLogin$ + "              " + "Original: Adquiriente"
     Else
        PMSetDetalle "v" + "Caj: " + VGLogin$ + "              " + "Copia: Emisor"
     End If

        VLEfe_com = "0"
        If VGModeloImp$ = "590" Then
            PMSetDetalle "%R" & 2
        End If


        
 FMPRN_StdImpresion "IMPRESORA_1", False, "", "77", SGDatosDetalle, "Inserte COMPROBANTE Cobro Comision", CStr(VGpartop$), 1, CStr(VGparleft$), , , , , False, , VLTrn
    
    
    
    
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
'        PMSetLineaImpresion "v" + "Junin 200 y Panama         " + "Aut. SRI:" + VLautoriSri
'        PMSetLineaImpresion "v" + "CONTRIBUYENTE ESPECIAL     " + "Fecha aut :" + VLFecinivig
'        PMSetLineaImpresion "v" + "NOTIFICACION No. 39 de Julio 18 de 1995 " + "Válido hasta :" + VLFecfinvig
'        PMSetLineaImpresion "v" + "RESOLUCION No. 6925 de Julio 4 de 1995"
'        PMSetLineaImpresion "v" + "Sr.(es): " + (SGNombre)
'        PMSetLineaImpresion "v" + "CI/RUC: " + (Replace(SGCedula, "_", "")) + "   " + "Ofic.: " + VGDes_Oficina$
'        'PMSetLineaImpresion "v" + "Costo Serv. Recaudacion  " + "Fecha: " + Format(VGFechaProceso, VGFormatoFecha$) + " " + Format(Now, VGFormatoHora$) + " " + IIf(VGHorarioDif, "H:D", "H:N")
'        PMSetLineaImpresion "v" + "Costo Serv. Recaudacion  " + "Fecha: " + Format(VGFechaProceso, VGFormatoFecha$) + " " + IIf(VGHorarioDif, "H:D", "H:N")
'        PMSetLineaImpresion "v" + "SRI-Imp. Fiscales con CEP" + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 8, CGJustificacionDerecha)
'        PMSetLineaImpresion "v" + "Subtotal:    " + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 8, CGJustificacionDerecha) + " " + "Iva 12%: " + FMEspaciosATX(Format(0, VGFormatoMoney), 8, CGJustificacionDerecha)
'        PMSetLineaImpresion "v" + "VALOR TOTAL: " + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 8, CGJustificacionDerecha) + " " + "Referencia: " + (Trim(Cedula1))
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

Sub PLFactura()
    'ame 08/03/2010
    
        '**************************************
    'GAMC - 02AGO10 - GUARDAR FACTURA - INI
    '**************************************
    If Comision.Text > 0 Then
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
    
   ' fr_iva = "0"
    fr_iva = VLiva    'smerino"0" cambios iva
    fr_baseImp = VlbaseImp 'smerino iva
    fr_impresa = "S" 'smerino
    fr_referencia = (Trim(Cedula1.Text))
    fr_servicio = "SRI-Imp. Fiscales con CEP"
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
Sub PLTransmitir()
    If VLMoneda <> VGmoneda% Then
        MsgBox "No se Puede Debitar a Cuentas con Moneda diferente a Moneda Base.", vbExclamation
        If Cta.Enabled Then Cta.SetFocus
        Exit Sub
    End If
     VLclave_acceso = "" '--ref02 vmirandt
    'TPE Validacion necesaria para No permitir Transacciones en caso de Valor Acumulado negativo
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
  
  If VLCambio = False And VLCambioCedruc = False And VGTipoEjecucion = CGNormal% Then
    MsgBox " Transaccion Repetida"
    Exit Sub
  End If
  '------> Sumadora
  'TPE Validacion de Monto Efectivo
  If (CDbl(efe.Text) + VLEfe_com) <> SGUsar Then
      MsgBox "El Monto Efetivo No Coincide con el Monto Desglosado para el Deposito. Verificar", vbCritical, "Mensaje del Sistema"
      efe.Text = Format$(SGUsar, "####,###,##0.00")
      Exit Sub
  End If
  '<--------
  'JPM ContadorBillete -->
  If lectoraBill.HayAltaDenom Then
    If Not VGDatPersBillAltDen.dataOK Then
      MsgBox "Existen Billetes de Alta Denominación cuyos Número de Serie no se han confirmado", vbCritical, "Mensaje del Sistema"
      Exit Sub
    End If
  End If
  '<-- JPM ContadorBillete

    VLRevTimeOut = False
    
'    If VGTipoEjecucion% <> CGReverso% Then
'        If Not FLTramaSwitch("P") Then
'            If VLRevTimeOut Then
'                If Not FLTramaSwitch("R") Then
'                    MsgBox "ERROR DE COMUNICACION EN EL PAGO, SE PROCEDIO A REVERSAR AUTOMATICAMENTE", vbCritical, "AVISO"
'                    Exit Sub
'                End If
'                If Trim$(Nombre.Text) <> "" Then
'                    MsgBox Nombre.Text, vbCritical, "Aviso"
'                End If
'                MsgBox "ERROR DE COMUNICACION EN EL PAGO, SE PROCEDIO A REVERSAR AUTOMATICAMENTE", vbCritical, "AVISO"
'            Else
'                If Trim$(Nombre.Text) <> "" Then
'                    MsgBox Nombre.Text, vbCritical, "Aviso"
'                End If
'                MsgBox "ERROR DE COMUNICACION EN EL PAGO, SE PROCEDIO A REVERSAR AUTOMATICAMENTE", vbCritical, "AVISO"
'            End If
'            Exit Sub
'        End If
'    Else
'        If Not FLTramaSwitch("R") Then
'            If Not VLRevTimeOut Then
'                Exit Sub
'            Else
'                MsgBox "TIME OUT EN LA REVERSA PERO SE REVERSA EL MOVIMIENTO EN EL BANCO", vbCritical, "AVISO"
'            End If
'        End If
'    End If
    
    If FLTransmitirCPS() = False Then
        'Sumadora ------->
        If (SGAcumulado + SGAcumuladoAdi) = 0 Then
            If Tipo.Enabled = True Then
                'Tipo.SetFocus    pricaura Ref-04 20191223
            End If
        End If
        '<---------
        'If Not FLTramaSwitch("R") Then
        '    Exit Sub
        'End If
        Exit Sub
    End If
    
  If VGTipoEjecucion = CGReverso And VGReversoLoger = "S" Then
    PMMsgError "Reverso OK", "", CGErrorInformativo
    FReverso!grdValores(0).Col = 4
    FReverso!grdValores(0).Text = "R"
  End If
'ref02 vmirandt  se comenta porque no permitía adicionar mas lineas en el comprobante, salía montada la infomación en el mismo
'  PMInicioImpresion "IMPRESORA_1"
'  PMBorrarDatosImpresion
'
'  'PMSetLineaImpresion "!" & VGpartop$
'  PMSetLineaImpresion "%N" & VGparleft$
'
'  PMSetLineaImpresion "x" + " Ingrese el comprobante para impresión"
'  PMSetLineaImpresion "<"
'  PMSetLineaImpresion "!" & VGpartop$ 'linea Adicionada
'  PMSetLineaImpresion "%N" & VGparleft$ 'linea adicionada
'
'  If VGModeloImp = "2400" Then
'        PMSetLineaImpresion "i" + CStr(VGTSN%) + " " + Format(Now, VGFormatoHora$) + " " + Format(VGFechaProceso, VGFormatoFecha$) + " " + CStr(VGOficina%) + " " + CStr(FMObtenerMonedaForma("77")) + " " + VGLogin$
'        PMSetLineaImpresion "v" + VGMensImpr + FmObtenermodo() + " " + IIf(VGHorarioDif, "3612", "3611") + " SRI IMPTO FISCALES CEP " + IIf(VGHorarioDif, "H:D", "H:N")
'        PMSetLineaImpresion "i" + "R.U.C/C.I. : " + Cedula1.Text
'        PMSetLineaImpresion "i" + "Razon social : " + Trim(RazonSocial.Text)
'        PMSetLineaImpresion "i" + "Tip.Impto.: " + FMEspaciosATX(Mid(Tipo.Text, 1, 4), 4, CGJustificacionDerecha) + " " + Trim$(Mid(sal_tipo, 1, 23))
'        PMSetLineaImpresion "i" + "Cep : " + CEP.Text
'        PMSetLineaImpresion "i" + "Aut. SRI : " + Format(FMEspaciosATX(Stk, 15, CGJustificacionIzquierda), "##-###-######-#")
'
'        If FMCCurATX((efe.Text)) > 0 Or FMCCurATX((Cheques.Text)) > 0 Then
'            PMSetLineaImpresion "i" + "Efe:   " + FMEspaciosATX("us$" + Format(efe, VGFormatoMoney), 13, CGJustificacionDerecha) + " CHQ :" + FMEspaciosATX("us$" + Format(Cheques, VGFormatoMoney), 13, CGJustificacionDerecha)
'        End If
'
'        If FMCCurATX((Debito.Text)) > 0 Then
'            PMSetLineaImpresion "i" + "Deb:   " + FMEspaciosATX("us$" + Format(Debito, VGFormatoMoney), 13, CGJustificacionDerecha) + " EFECOB :" + FMEspaciosATX("us$" + Format(EfeCob, VGFormatoMoney), 13, CGJustificacionDerecha)
'        End If
'
'        If FMCCurATX((Debito.Text)) > 0 Then
'            PMSetLineaImpresion "i" + "CTA: " + Format(Cta.Text, "000-000000-0")
'        End If
'
'        'lfcm 22-marzo-2007
'        'Agregar la seccion respecitva de la tarjeta de credito
'        If FMCCurATX((tarjcredito.Text)) > 0 Then
'            PMSetLineaImpresion "i" + "Tar:   " + FMEspaciosATX("us$" + Format(tarjcredito, VGFormatoMoney), 13, CGJustificacionDerecha)
'        End If
'
'        PMSetLineaImpresion "i" + "PAGO TOTAL: " + FMEspaciosATX(FMObtenerSimbolo("77") + Format(FMCCurATX(valor), VGFormatoMoney), 25, CGJustificacionDerecha)
'
'        '***ref02 vmirandt inicio, se imprime al final del documento
'        If VLclave_acceso <> "" Then
'          PMSetLineaImpresion "i" + "Clave de Acceso/Autorizacion: "
'          PMSetLineaImpresion "i" + VLclave_acceso
'        End If
'    'ref02 vmirandt
'
'  Else
'        PMSetLineaImpresion "v" + CStr(VGTSN%) + " " + Format(Now, VGFormatoHora$) + " " + Format(VGFechaProceso, VGFormatoFecha$) + " " + CStr(VGOficina%) + " " + CStr(FMObtenerMonedaForma("77")) + " " + VGLogin$
'        Debug.Print "v" + CStr(VGTSN%) + " " + Format(Now, VGFormatoHora$) + " " + Format(VGFechaProceso, VGFormatoFecha$) + " " + CStr(VGOficina%) + " " + CStr(FMObtenerMonedaForma("77")) + " " + VGLogin$
'        PMSetLineaImpresion "v" + VGMensImpr + FmObtenermodo() + " " + IIf(VGHorarioDif, "3612", "3611") + " SRI IMPTO FISCALES CEP " + IIf(VGHorarioDif, "H:D", "H:N")
'        Debug.Print "v" + VGMensImpr + FmObtenermodo() + " " + IIf(VGHorarioDif, "3612", "3611") + " SRI IMPTO FISCALES CEP " + IIf(VGHorarioDif, "H:D", "H:N")
'        PMSetLineaImpresion "v" + "R.U.C/C.I. : " + Cedula1.Text
'        Debug.Print "v" + "R.U.C/C.I. : " + Cedula1.Text
'        PMSetLineaImpresion "v" + "Razon social : " + RazonSocial.Text
'        Debug.Print "v" + "Razon social : " + RazonSocial.Text
'        PMSetLineaImpresion "v" + "Tip.Impto.: " + FMEspaciosATX(Mid(Tipo.Text, 1, 4), 4, CGJustificacionDerecha) + " " + Trim$(Mid(sal_tipo, 1, 23))
'        Debug.Print "v" + "Tip.Impto.: " + FMEspaciosATX(Mid(Tipo.Text, 1, 4), 4, CGJustificacionDerecha) + " " + Trim$(Mid(sal_tipo, 1, 23))
'        PMSetLineaImpresion "v" + "Cep : " + CEP.Text
'        Debug.Print "v" + "Cep : " + CEP.Text
'        PMSetLineaImpresion "v" + "Aut. SRI : " + Format(FMEspaciosATX(Stk, 15, CGJustificacionIzquierda), "##-###-######-#")
'        Debug.Print "v" + "Aut. SRI : " + Format(FMEspaciosATX(Stk, 15, CGJustificacionIzquierda), "##-###-######-#")
'
'        If FMCCurATX((efe.Text)) > 0 Or FMCCurATX((Cheques.Text)) > 0 Then
'            PMSetLineaImpresion "v" + "Efe:   " + FMEspaciosATX("us$" + Format(efe, VGFormatoMoney), 13, CGJustificacionDerecha) + " CHQ :" + FMEspaciosATX("us$" + Format(Cheques, VGFormatoMoney), 13, CGJustificacionDerecha)
'            Debug.Print "v" + "Efe:   " + FMEspaciosATX("us$" + Format(efe, VGFormatoMoney), 13, CGJustificacionDerecha) + " CHQ :" + FMEspaciosATX("us$" + Format(Cheques, VGFormatoMoney), 13, CGJustificacionDerecha)
'        End If
'
'        If FMCCurATX((Debito.Text)) > 0 Or FMCCurATX((EfeCob.Text)) > 0 Then
'            PMSetLineaImpresion "v" + "Deb:   " + FMEspaciosATX("us$" + Format(Debito, VGFormatoMoney), 13, CGJustificacionDerecha) + " EFECOB :" + FMEspaciosATX("us$" + Format(EfeCob, VGFormatoMoney), 13, CGJustificacionDerecha)
'            Debug.Print "v" + "Deb:   " + FMEspaciosATX("us$" + Format(Debito, VGFormatoMoney), 13, CGJustificacionDerecha) + " EFECOB :" + FMEspaciosATX("us$" + Format(EfeCob, VGFormatoMoney), 13, CGJustificacionDerecha)
'        End If
'
'        If FMCCurATX((Debito.Text)) > 0 Then
'            PMSetLineaImpresion "v" + "CTA: " + Format(Cta.Text, "000-000000-0")
'            Debug.Print "v" + "CTA: " + Format(Cta.Text, "000-000000-0")
'        End If
'
'        'lfcm 22-marzo-2007
'        'Se agrega la impresion del valor de pago con Tarjeta de Credito si este rubro es mayor a cero (0)
'        If FMCCurATX((Me.tarjcredito.Text)) > 0 Then
'            PMSetLineaImpresion "v" + "Tar:   " + FMEspaciosATX("us$" + Format(tarjcredito, VGFormatoMoney), 13, CGJustificacionDerecha)
'            Debug.Print "v" + "Tar:   " + FMEspaciosATX("us$" + Format(tarjcredito, VGFormatoMoney), 13, CGJustificacionDerecha)
'        End If
'
'        PMSetLineaImpresion "v" + "PAGO TOTAL: " + FMEspaciosATX(FMObtenerSimbolo("77") + Format(FMCCurATX(valor), VGFormatoMoney), 25, CGJustificacionDerecha)
'        Debug.Print "v" + "PAGO TOTAL: " + FMEspaciosATX(FMObtenerSimbolo("77") + Format(FMCCurATX(valor), VGFormatoMoney), 25, CGJustificacionDerecha)
'       '***ref02 vmirandt inicio, se imprime al final del documento
'        If VLclave_acceso <> "" Then
'           PMSetLineaImpresion "v" + "Clave de Acceso/Autorizacion: "
'           Debug.Print "v" + "Clave de Acceso/Autorizacion: "
'           PMSetLineaImpresion "v" + VLclave_acceso
'           Debug.Print "v" + VLclave_acceso
'        End If
'    'ref02 vmirandt
'
'  End If

'  PMSetLineaImpresion ">"
'  PMImprimir "IMPRESORA_1", False
'  PMFinImpresion "IMPRESORA_1"
  
  
'LLAMADA A LA FUNCION DE FORMATOS DE REPORTES
  VGparformato$ = "01"
   If Not FMFormatPagina(VGparformato$, VGparlong$, VGpartop$, VGparleft$, VGparrig$) Then
      VGparlong$ = "66"
      VGpartop$ = "04"
      VGparleft$ = "20"
      VGparrig$ = "00"
   End If
    If VGHorarioDif = False Then
      VLHorario = "N"
    Else
      VLHorario = "D"
    End If
  PMSetDetalle "v"
  PMSetDetalle "v" + "R.U.C/C.I. : " + Cedula1.Text
  PMSetDetalle "v" + "Razon social : " + RazonSocial.Text
  PMSetDetalle "v" + "Tip.Impto.: " + FMEspaciosATX(Mid(Tipo.Text, 1, 4), 4, CGJustificacionDerecha) + " " + Trim$(Mid(sal_tipo, 1, 23))
  'PMSetDetalle "v" + "Cep : " + CEP.Text + " Aut. SRI : " + Format(FMEspaciosATX(Stk, 15, CGJustificacionIzquierda), "##-###-######-#")
  PMSetDetalle "v" + "Cep : " + CEP.Text
  PMSetDetalle "v" + "Log Autorizacion SRI: " + LOG_AUTORIZACION
  'PMSetDetalle "v" + "Aut. SRI : " + Format(FMEspaciosATX(Stk, 15, CGJustificacionIzquierda), "##-###-######-#")
  If FMCCurATX((efe.Text)) > 0 Or FMCCurATX((Cheques.Text)) > 0 Then
      PMSetDetalle "v" + "Efe:   " + FMEspaciosATX("us$" + Format(efe, VGFormatoMoney), 13, CGJustificacionDerecha) + " CHQ :" + FMEspaciosATX("us$" + Format(Cheques, VGFormatoMoney), 13, CGJustificacionDerecha)
  End If
        
  If FMCCurATX((Debito.Text)) > 0 Or FMCCurATX((EfeCob.Text)) > 0 Then
     PMSetDetalle "v" + "Deb:   " + FMEspaciosATX("us$" + Format(Debito, VGFormatoMoney), 13, CGJustificacionDerecha) + " EFECOB :" + FMEspaciosATX("us$" + Format(EfeCob, VGFormatoMoney), 13, CGJustificacionDerecha)
  End If
  If FMCCurATX((Debito.Text)) > 0 Then
     PMSetDetalle "v" + "CTA: " + Format(Cta.Text, "000-000000-0")
  End If
     PMSetDetalle "v" + "Comision: " + Comision.Text
  'lfcm 22-marzo-2007
  'Se agrega la impresion del valor de pago con Tarjeta de Credito si este rubro es mayor a cero (0)
   If FMCCurATX((Me.tarjCredito.Text)) > 0 Then
      PMSetDetalle "v" + "Tar:   " + FMEspaciosATX("us$" + Format(tarjCredito, VGFormatoMoney), 13, CGJustificacionDerecha)
   End If
      PMSetDetalle "v" + "PAGO TOTAL: " + FMEspaciosATX(FMObtenerSimbolo("77") + Format(FMCCurATX(Valor), VGFormatoMoney), 25, CGJustificacionDerecha)
        
   '***ref02 vmirandt inicio, se imprime al final del documento
   If VLclave_acceso <> "" Then
      PMSetDetalle "v" + "Clave de Acceso/Autorizacion: "
      PMSetDetalle "v" + VLclave_acceso
   End If
   VGparleft$ = "10"
   VGpartop$ = "00"
   'ref02 vmirandt
 VLTsnTemp% = VGTSN%
  VLEtiqTrn = " SRI IMPTO FISCALES CEP "
 FMPRN_StdImpresion "IMPRESORA_1", False, CStr(VLTsnTemp%), "77", SGDatosDetalle, "Inserte papeleta", CStr(VGpartop$), 4, CStr(VGparleft$), , VLEtiqTrn, IIf(VLHorario = "0", "", VLHorario), IIf(VGHorarioDif, "3612", "3611"), , Trim$(str$(FMObtenerMonedaForma("77")))
    
  If VGTipoEjecucion = CGNormal% Then
    While MsgBox("Desea Reimprimir el Formulario?", vbYesNo, "Mensaje") = vbYes
        PMReimpresion
    Wend
  End If

    'ame 08/04/2010  factura cobro comision
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

 
  
    If SGAcumulado = 0 Then
        Form_KeyDown CGTeclaF2%, 0
    Else
        Form_KeyDown CGTeclaF2%, -1
    End If
End Sub
 
Function FLTransmitir() As Integer
Dim VTIndicadorSum As Integer
    VTIndicadorSum = 0
    
    If VGHorarioDif Then
        VLTrn = "3612"
    Else
        VLTrn = "3611"
    End If
    VGTrn = IIf(VLTrn = "", 0, VLTrn)
    
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_tipo", 0, SQLCHAR, (Tipo.Text), "tipo", ""
    PMPasoValoresATX VGSqlConn, "@i_val", 0, SQLMONEY, (Total.Text), "Tot Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_total", 0, SQLMONEY, (Valor.Text), "tot formulario", ""
    PMPasoValoresATX VGSqlConn, "@i_efe", 0, SQLMONEY, (efe.Text), "efe", ""
    PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, (Cheques.Text), "Cheques", ""
    PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(FMObtenerMonedaForma("77")), "Moneda", ""
    PMPasoValoresATX VGSqlConn, "@i_Cedula", 0, SQLVARCHAR, (Cedula1.Text), "Cedula", ""  'PHV   23/SEP/1999
    PMPasoValoresATX VGSqlConn, "@i_autoriza", 0, SQLVARCHAR, VGAutoriza, "Autorizacion", ""
    PMPasoValoresATX VGSqlConn, "@i_supautor", 0, SQLVARCHAR, VGSuperAutoriza$, "Supervisor de Monto", ""       'ref:esma10mar2003
    PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, (Debito.Text), "Debito", ""
    
    'lfcm 22-marzo-2007
    'Se agrega por pagos con Tarjeta de Credito
    PMPasoValoresATX VGSqlConn, "@i_valtarjeta", 0, SQLMONEY, (tarjCredito.Text), "tarjCredito", ""
    
    PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
    PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (CboTipCta.Text), "CboTipCta", ""
        PMPasoValoresATX VGSqlConn, "@i_efecob", 0, SQLMONEY, (EfeCob.Text), "efecob", ""
        PMPasoValoresATX VGSqlConn, "@i_efechq", 0, SQLMONEY, (txttotchq), "", ""  'ame 30May03
        PMPasoValoresATX VGSqlConn, "@i_efeodb", 0, SQLMONEY, (txttotodb), "", ""  'ame 30May03
    If CCur(EfeCob.Text) > 0 Or CCur(mhNC.Text) > 0 Then
        PMPasoValoresATX VGSqlConn, "@i_ced_ruc", 0, SQLVARCHAR, (CedRuc.Text), "", ""
        PMPasoValoresATX VGSqlConn, "@i_clte", 0, SQLINT4, (lblCliente), "", ""
        PMPasoValoresATX VGSqlConn, "@i_nombre_clte", 0, SQLVARCHAR, (lblNombreClte), "", ""
        PMPasoValoresATX VGSqlConn, "@i_dias_gracia", 0, SQLINT2, (lblDias), "", ""
        If CCur(mhNC.Text) > 0 Then
            PMPasoValoresATX VGSqlConn, "@i_efenc", 0, SQLMONEY, (mhNC.Text), "efenc", ""
            PMPasoValoresATX VGSqlConn, "@i_ncreal", 0, SQLMONEY, (mhNCReal.Text), "ncreal", ""
        End If
        For k% = 0 To 9
            grdEfectoCob.Row = k%
            grdEfectoCob.Col = 0
            If Trim(grdEfectoCob.Text) <> "" Then
                grdEfectoCob.Row = k%
                
                grdEfectoCob.Col = 0
                VLFp$ = FMEspaciosATX(Trim(grdEfectoCob.Text), 3, CGJustificacionIzquierda%) + "|"
                grdEfectoCob.Col = 1
                VLValor$ = FMEspaciosATX(Format(grdEfectoCob, "#########.00"), 12, CGJustificacionDerecha) + "|"
                grdEfectoCob.Col = 2
                VLCodBco$ = FMEspaciosATX(Trim(grdEfectoCob.Text), 3, CGJustificacionIzquierda%) + "|"
                grdEfectoCob.Col = 3
                VLbanco$ = FMEspaciosATX(Trim(grdEfectoCob.Text), 40, CGJustificacionIzquierda%) + "|"
                grdEfectoCob.Col = 4
                VLTipCta$ = FMEspaciosATX(Trim(grdEfectoCob.Text), 3, CGJustificacionIzquierda%) + "|"
                grdEfectoCob.Col = 5
                VLCta$ = FMEspaciosATX(Trim(grdEfectoCob.Text), 10, CGJustificacionIzquierda%) + "|"
                grdEfectoCob.Col = 6
                VLNumChq$ = FMEspaciosATX(Format(grdEfectoCob.Text, "##########"), 10, CGJustificacionDerecha%) + "|"
                grdEfectoCob.Col = 7
                VLTipChq$ = FMEspaciosATX(grdEfectoCob.Text, 1, CGJustificacionIzquierda%) + "|"
                grdEfectoCob.Col = 8
                VLOficina$ = FMEspaciosATX(grdEfectoCob.Text, 3, CGJustificacionDerecha%) + "|"
                grdEfectoCob.Col = 9
                VLCiudad$ = FMEspaciosATX(grdEfectoCob.Text, 3, CGJustificacionDerecha%) + "|"
                grdEfectoCob.Col = 10
                VLid$ = FMEspaciosATX(grdEfectoCob.Text, 10, CGJustificacionDerecha%) + "|"
                grdEfectoCob.Col = 11
                VLsec$ = FMEspaciosATX(grdEfectoCob.Text, 10, CGJustificacionDerecha%) + "|"
                
                VLParametro$ = "@i_param_efe" & Trim(str(k% + 1))
                VLParamEfe$ = VLFp$ & VLValor$ & VLCodBco$ & VLbanco$ & VLTipCta$ & VLCta$ & VLNumChq$ & VLTipChq$ & VLOficina$ & VLCiudad$ & VLid$ & VLsec$
                PMPasoValoresATX VGSqlConn, VLParametro$, 0, SQLVARCHAR, VLParamEfe$, "Efecto de Cobro", ""
            Else
                k% = 9
            End If
        Next k%
    End If
    PMPasoValoresATX VGSqlConn, "@i_adhesivo", 0, SQLVARCHAR, Stk.Text, "adhesivo", ""
    PMPasoValoresATX VGSqlConn, "@i_cep", 0, SQLVARCHAR, CEP.ClipText, "Cep", ""
    PMPasoValoresATX VGSqlConn, "@i_razon_soc", 0, SQLVARCHAR, RazonSocial.Text, "Razon", ""
    '****** COMISION *******************************************************
     PMPasoValoresATX VGSqlConn, "@i_efe_com", 0, SQLMONEY, (VLEfe_com), "Com. efectivo", ""
     PMPasoValoresATX VGSqlConn, "@i_chq_com", 0, SQLMONEY, (VLChq_com), "Com. Cheques", ""
     PMPasoValoresATX VGSqlConn, "@i_deb_com", 0, SQLMONEY, (VLDeb_com), "Com. Debito", ""
     PMPasoValoresATX VGSqlConn, "@i_cta_com", 0, SQLVARCHAR, (VLCta_com), "Com. Cta", ""
     PMPasoValoresATX VGSqlConn, "@i_tipocta_com", 0, SQLCHAR, (VLTipCta_com), "Com. TipCta", ""
     
    'LBP Inicio RECA-CC-SGC00025869 30/07/2016
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
    'LBP Fin RECA-CC-SGC00025869 30/07/2016

    '*******************************************************************
    PMPasoValoresATX VGSqlConn, "@i_cant_chq", 0, SQLINT4, val(CantChq.Text), "CantChq", ""
    PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, "0", "SecTrn", ""
    PMPasoValoresATX VGSqlConn, "@o_nombcta", 1, SQLVARCHAR, (Nombre.Text), "nombre", ""
    PMPasoValoresATX VGSqlConn, "@o_autorisri", 1, SQLVARCHAR, VLautoriSri, "AutorizacionSRI", ""
    PMPasoValoresATX VGSqlConn, "@o_fecvensri", 1, SQLVARCHAR, VLFecvenSRI, "Stk", ""
    PMPasoValoresATX VGSqlConn, "@o_nota_venta", 1, SQLVARCHAR, VLSerie_Secuencia, "Nota_venta", ""
    PMPasoValoresATX VGSqlConn, "@i_descrip_impto", 0, SQLVARCHAR, (sal_tipo), "Descrip_impto", ""
    PMAParamBillAltaDenom    'JPM lectora de billetes
    
    'If FMTransmitirRPCATX(VGSqlConn, VLParametroServer, "cob_cuentas", "sp_tr_ofp_sri", True, "Transaccion Ok", "S", "N", "S", "77", "S", "S") = True Then  'pricaura Ref-04 20191223 TODO revisar si es necesario
    If FMTransmitirRPCATX(VGSqlConn, "", "cob_cuentas", "sp_tr_ofp_sri", True, "Transaccion Ok", "S", "N", "S", "77", "S", "S") = True Then
        Nombre.Text = Mid$(FMRetParamATX(VGSqlConn, 2), 1, 30)
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 1)
        VLautoriSri = FMRetParamATX(VGSqlConn, 3)
        VLFecvenSRI = FMRetParamATX(VGSqlConn, 4)
        VLSerie_Secuencia = FMRetParamATX(VGSqlConn, 5)
        'If CCur(Efe.Text) > 0 And VGDatPersBillAltDen.dataOK Then         'JPM lectora de billetes -->
        '  VGDatPersBillAltDen.tIdCli = FMRetParamATX(VGSqlConn, arrParOut_get("@s_tid_cliente"))
        '  VGDatPersBillAltDen.nIdCli = FMRetParamATX(VGSqlConn, arrParOut_get("@s_id_cliente"))
        '  VGDatPersBillAltDen.nomCli = FMRetParamATX(VGSqlConn, arrParOut_get("@s_nomb_cliente"))
        '  VGDatPersBillAltDen.Cuenta = Cta.Text
        'End If                                                            '<-- JPM lectora de billetes
        PMChequeaATX VGSqlConn
        PMTotalesBranch "77"
        FLTransmitir = True
        VLCambio% = False
        VLCambioCedruc% = False
        'TPE ------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 1)
        VTIndicadorSum = 1
        PMIniciaRegSum
        VLFlagSumadora = True
        '<-----
    Else
        VLCambio% = True
        VLCambioCedruc% = True
        FLTransmitir = False
        'TPE ------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 1)
        VTIndicadorSum = 0
        PMChequeaATX VGSqlConn
        VLFlagSumadora = False
        '<------
    End If
    PMChequeaATX VGSqlConn
    If FMRetStatusATX(VGSqlConn) <> 0 Then
        VTIndicadorSum = 0
        FLTransmitir = False
    End If
    PMFinTransaccion
    'JPM Lectora de Billetes -->
    If FLTransmitir Then
      If CCur(efe.Text) > 0 And ((VGDatPersBillAltDen.dataOK And VGTipoEjecucion = CGNormal%) Or VGTipoEjecucion = CGReverso%) Then
        'VGDatPersBillAltDen.Cuenta = Cta.Text
        'Call ImprimeComprobanteBillAltaDenom("77", SGSecTrn$, VGFechaProceso, rptBAD)
        Call PMGuardarDsglsBillete("77", SGSecTrn$, VLTrn, rptBAD, "REC", "")
        lectoraBill.Limpiar
      End If
    End If
    '<-- JPM Lectora de Billetes
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


Function FLTransmitirCPS() As Integer
 Dim VTIndicadorSum As Integer
    
    VTIndicadorSum = 0
    
    If VGHorarioDif Then
        VLTrn = "3612"
    Else
        VLTrn = "3611"
    End If
    VGTrn = IIf(VLTrn = "", 0, VLTrn)
    
    If VGTipoEjecucion = CGNormal Then
        If Not FLSecuencias() Then
            Me.Enabled = True
            Exit Function
        End If
    End If
    
     If VGTipoEjecucion% <> CGReverso% Then
       
    'VERIFICA MONTO MAXIMO
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 4050, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_empresa", 0, SQLVARCHAR, "8369", "Empresa", ""
    PMPasoValoresATX VGSqlConn, "@i_codigo", 0, SQLVARCHAR, CEP.ClipText, "Suministro", ""
    PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "CSP", "Canal", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLVARCHAR, "T", "Opcion", ""
    PMPasoValoresATX VGSqlConn, "@i_aplcobis", 0, SQLVARCHAR, "S", "Aplicacion Cobis", ""
    PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLVARCHAR, "C", "Aplicacion Cobis", ""
    PMPasoValoresATX VGSqlConn, "@i_efectivo", 0, SQLMONEY, efe.Text, "efectivo", ""
    PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, Cheques.Text, "cheque", ""
    PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, Debito.Text, "debito", ""
    PMPasoValoresATX VGSqlConn, "@i_comision_efe", 0, SQLMONEY, CCur(VLEfe_com), "comision_efe", ""
    PMPasoValoresATX VGSqlConn, "@i_comision_chq", 0, SQLMONEY, CCur(VLChq_com), "comision_chq", ""
    PMPasoValoresATX VGSqlConn, "@i_comision_db", 0, SQLMONEY, CCur(VLDeb_com), "comision_deb", ""
      
    If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_val_servicios_varios", True, "Transaccion Ok", "S", "N", "N", "77", "S", "S") = True Then
        PMChequeaATX VGSqlConn&
        PMFinTransaccion
    Else
        VLCambio% = True
        VLCambioCedruc% = True
        FLTransmitirCPS = False
        VTIndicadorSum = 0
        PMChequeaATX VGSqlConn
        VLFlagSumadora = False
        PMFinTransaccion
        Exit Function
    End If

    End If
    
    
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_tipo", 0, SQLCHAR, (Tipo.Text), "tipo", ""
    PMPasoValoresATX VGSqlConn, "@i_val", 0, SQLMONEY, (Total.Text), "Tot Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_total", 0, SQLMONEY, (Valor.Text), "tot formulario", ""
    PMPasoValoresATX VGSqlConn, "@i_efe", 0, SQLMONEY, (efe.Text), "efe", ""
    PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, (Cheques.Text), "Cheques", ""
    
    'lfcm 22-marzo-2007
    'Envio del parametro de Tarjeta de Credito
    PMPasoValoresATX VGSqlConn, "@i_valtarjeta", 0, SQLMONEY, (Me.tarjCredito.Text), "TarjCredito", ""
    
    PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(FMObtenerMonedaForma("77")), "Moneda", ""
    PMPasoValoresATX VGSqlConn, "@i_Cedula", 0, SQLVARCHAR, (Cedula1.Text), "Cedula", ""  'PHV   23/SEP/1999
    PMPasoValoresATX VGSqlConn, "@i_autoriza", 0, SQLVARCHAR, VGAutoriza, "Autorizacion", ""
    PMPasoValoresATX VGSqlConn, "@i_supautor", 0, SQLVARCHAR, VGSuperAutoriza$, "Supervisor de Monto", ""       'ref:esma10mar2003
    PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, (Debito.Text), "Debito", ""
    'ref03 Ini
    PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
    PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (CboTipCta.Text), "CboTipCta", ""
        PMPasoValoresATX VGSqlConn, "@i_efecob", 0, SQLMONEY, (EfeCob.Text), "efecob", ""
        PMPasoValoresATX VGSqlConn, "@i_efechq", 0, SQLMONEY, (txttotchq), "", ""  'ame 30May03
        PMPasoValoresATX VGSqlConn, "@i_efeodb", 0, SQLMONEY, (txttotodb), "", ""  'ame 30May03
        
    If CCur(EfeCob.Text) > 0 Or CCur(mhNC.Text) > 0 Then
        PMPasoValoresATX VGSqlConn, "@i_ced_ruc", 0, SQLVARCHAR, (CedRuc.Text), "", ""
        PMPasoValoresATX VGSqlConn, "@i_clte", 0, SQLINT4, (lblCliente), "", ""
        PMPasoValoresATX VGSqlConn, "@i_nombre_clte", 0, SQLVARCHAR, (lblNombreClte), "", ""
        PMPasoValoresATX VGSqlConn, "@i_dias_gracia", 0, SQLINT2, (lblDias), "", ""
        If CCur(mhNC.Text) > 0 Then
            PMPasoValoresATX VGSqlConn, "@i_efenc", 0, SQLMONEY, (mhNC.Text), "efenc", ""
            PMPasoValoresATX VGSqlConn, "@i_ncreal", 0, SQLMONEY, (mhNCReal.Text), "ncreal", ""
        End If
        For k% = 0 To 9
            grdEfectoCob.Row = k%
            grdEfectoCob.Col = 0
            If Trim(grdEfectoCob.Text) <> "" Then
                grdEfectoCob.Row = k%
                
                grdEfectoCob.Col = 0
                VLFp$ = FMEspaciosATX(Trim(grdEfectoCob.Text), 3, CGJustificacionIzquierda%) + "|"
                grdEfectoCob.Col = 1
                VLValor$ = FMEspaciosATX(Format(grdEfectoCob, "#########.00"), 12, CGJustificacionDerecha) + "|"
                grdEfectoCob.Col = 2
                VLCodBco$ = FMEspaciosATX(Trim(grdEfectoCob.Text), 3, CGJustificacionIzquierda%) + "|"
                grdEfectoCob.Col = 3
                VLbanco$ = FMEspaciosATX(Trim(grdEfectoCob.Text), 40, CGJustificacionIzquierda%) + "|"
                grdEfectoCob.Col = 4
                VLTipCta$ = FMEspaciosATX(Trim(grdEfectoCob.Text), 3, CGJustificacionIzquierda%) + "|"
                grdEfectoCob.Col = 5
                VLCta$ = FMEspaciosATX(Trim(grdEfectoCob.Text), 10, CGJustificacionIzquierda%) + "|"
                grdEfectoCob.Col = 6
                VLNumChq$ = FMEspaciosATX(Format(grdEfectoCob.Text, "##########"), 10, CGJustificacionDerecha%) + "|"
                grdEfectoCob.Col = 7
                VLTipChq$ = FMEspaciosATX(grdEfectoCob.Text, 1, CGJustificacionIzquierda%) + "|"
                grdEfectoCob.Col = 8
                VLOficina$ = FMEspaciosATX(grdEfectoCob.Text, 3, CGJustificacionDerecha%) + "|"
                grdEfectoCob.Col = 9
                VLCiudad$ = FMEspaciosATX(grdEfectoCob.Text, 3, CGJustificacionDerecha%) + "|"
                grdEfectoCob.Col = 10
                VLid$ = FMEspaciosATX(grdEfectoCob.Text, 10, CGJustificacionDerecha%) + "|"
                grdEfectoCob.Col = 11
                VLsec$ = FMEspaciosATX(grdEfectoCob.Text, 10, CGJustificacionDerecha%) + "|"
                
                VLParametro$ = "@i_param_efe" & Trim(str(k% + 1))
                VLParamEfe$ = VLFp$ & VLValor$ & VLCodBco$ & VLbanco$ & VLTipCta$ & VLCta$ & VLNumChq$ & VLTipChq$ & VLOficina$ & VLCiudad$ & VLid$ & VLsec$
                PMPasoValoresATX VGSqlConn, VLParametro$, 0, SQLVARCHAR, VLParamEfe$, "Efecto de Cobro", ""
            Else
                k% = 9
            End If
        Next k%
    End If
    PMPasoValoresATX VGSqlConn, "@i_adhesivo", 0, SQLVARCHAR, Stk.Text, "adhesivo", ""
   ' PMPasoValoresATX VGSqlConn, "@i_adhesivo", 0, SQLVARCHAR, "21545454", "adhesivo", ""
    PMPasoValoresATX VGSqlConn, "@i_cep", 0, SQLVARCHAR, CEP.ClipText, "Cep", ""
    
    '-->hy-15-marzo-2007
    'salvando los muebles
    Dim VLNuevoCampo As String
    VLNuevoCampo = RazonSocial.Text
    VLNuevoCampo = Replace(VLNuevoCampo, Chr(38), "&amp;")
    VLNuevoCampo = Replace(VLNuevoCampo, Chr(60), "&lt;")
    VLNuevoCampo = Replace(VLNuevoCampo, Chr(62), "&gt;")
    VLNuevoCampo = Replace(VLNuevoCampo, Chr(39), "&apos;")
    VLNuevoCampo = Replace(VLNuevoCampo, Chr(34), "&quot;")
    PMPasoValoresATX VGSqlConn, "@i_razon_soc", 0, SQLVARCHAR, VLNuevoCampo, "Razon", ""
    'PMPasoValoresATX VGSqlConn, "@i_razon_soc", 0, SQLVARCHAR, RazonSocial.Text, "Razon", ""
    '<--hy-15-marzo-2007
    '****** COMISION *******************************************************
     PMPasoValoresATX VGSqlConn, "@i_efe_com", 0, SQLMONEY, (VLEfe_com), "Com. efectivo", ""
     PMPasoValoresATX VGSqlConn, "@i_chq_com", 0, SQLMONEY, (VLChq_com), "Com. Cheques", ""
     PMPasoValoresATX VGSqlConn, "@i_deb_com", 0, SQLMONEY, (VLDeb_com), "Com. Debito", ""
     'ref03 Ini
     PMPasoValoresATX VGSqlConn, "@i_cta_com", 0, SQLVARCHAR, (VLCta_com), "Com. Cta", ""
     'PMPasoValoresATX VGSqlConn, "@i_cta_com", 0, SQLVARCHAR, "X", "Com. Cta", ""
     'ref03 Fin
     PMPasoValoresATX VGSqlConn, "@i_tipocta_com", 0, SQLCHAR, (VLTipCta_com), "Com. TipCta", ""
     
    'LBP Inicio RECA-CC-SGC00025869 30/07/2016
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
    'LBP Fin RECA-CC-SGC00025869 30/07/2016
     
    '*******************************************************************
    PMPasoValoresATX VGSqlConn, "@i_cant_chq", 0, SQLINT4, val(CantChq.Text), "CantChq", ""
    PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, "0", "SecTrn", ""
    If VGTipoEjecucion% <> CGReverso% Then   'Validacion por REVERSO
        PMPasoValoresATX VGSqlConn, "@o_nombcta", 1, SQLVARCHAR, (Nombre.Text), Space(200), ""
        PMPasoValoresATX VGSqlConn, "@o_autorisri", 1, SQLVARCHAR, VLautoriSri, "AutorizacionSRI", ""
        PMPasoValoresATX VGSqlConn, "@o_fecvensri", 1, SQLVARCHAR, VLFecvenSRI, "Stk", ""
    Else
        PMPasoValoresATX VGSqlConn, "@o_nombcta", 1, SQLVARCHAR, "X", "X", ""
        PMPasoValoresATX VGSqlConn, "@o_autorisri", 1, SQLVARCHAR, "X", "AutorizacionSRI", ""
        PMPasoValoresATX VGSqlConn, "@o_fecvensri", 1, SQLVARCHAR, "X", "Stk", ""
    End If
    PMPasoValoresATX VGSqlConn, "@o_nota_venta", 1, SQLVARCHAR, VLSerie_Secuencia, "Nota_venta", ""
    PMPasoValoresATX VGSqlConn, "@i_descrip_impto", 0, SQLVARCHAR, (sal_tipo), "Descrip_impto", ""
    
    'CPS
    
    PMPasoValoresATX VGSqlConn, "@i_pcodcanalpago", 0, SQLVARCHAR, "VENTANILLA", "Pcodcanalpago", ""
    PMPasoValoresATX VGSqlConn, "@i_pnumruc", 0, SQLVARCHAR, Cedula1.Text, "Pnumruc", ""
    PMPasoValoresATX VGSqlConn, "@i_pnumserial", 0, SQLVARCHAR, CEP.Text, "Pnumserial", ""
    'PMPasoValoresATX VGSqlConn, "@i_pcodimp", 0, SQLVARCHAR, Tipo.Text, "Pcodimp", ""
    PMPasoValoresATX VGSqlConn, "@i_pprovagencia", 0, SQLVARCHAR, VLProvincia, "Pprovagencia", ""
    'VLValorPagar = Trim$(Str$(CDbl(ValorSRI.Text) * 100)) 'SMERINO CAMBIA PRUEBA
     VLValorPagar = Trim$(str$(CDec(ValorSRI.Text) * 100)) 'SMERINO
     PMPasoValoresATX VGSqlConn, "@i_pdebbanco", 0, SQLVARCHAR, VLValorPagar, "Pdebbanco", "" 'SMERINO
   'PMPasoValoresATX VGSqlConn, "@i_pdebbanco", 0, SQLFLT8&, VLValorPagar, "Pdebbanco", "" comenta smerino
    PMPasoValoresATX VGSqlConn, "@i_pfechpago", 0, SQLVARCHAR, VLFechaPago, "Pfechpago", ""
    
    'TRANSMITIR DEL PAGO    'lfcm 22-marzo-2007
    If FMTransmitirRPCATX(VGSqlConn, VLParametroServer, "cob_procesador", "sp_tr_ofp_sri", True, "Transaccion Ok", "S", "N", "S", "77", "S", "S") = True Then  'pricaura Ref-04 20191223
    'If FMTransmitirRPCATX(VGSqlConn, "PSSRV1", "cob_procesador", "sp_tr_ofp_sri", True, "Transaccion Ok", "S", "N", "S", "77", "S", "S") = True Then
        ReDim psRetorno(1, 22)
        FMMapeaMatriz VGSqlConn, psRetorno
        
        'AD_FECHA_RECEPCION_CEP 1
        'AD_PERIODO_FISCAL_DESDE 2
        'AD_PERIODO_FISCAL_HASTA 3
        'AN_CODIGO_LOG_MONITOR 4
        'AN_COD_OPE_COD_MEN 5
        'AN_NUMERO_CUOTA 6
        'AN_TOTAL_PAGO 7
        'AN_VALOR_COMPENSACIONES 8
        'AN_VALOR_IMPUESTO 9
        'AN_VALOR_INTERES 10
        'AN_VALOR_MULTAS 11
        'AS_CLASE_CONTRIBUYENTES 13
        'AS_ORIGINAL_SUSTITUTIVA 14
        'AS_RAZON_SOCIAL 15
        
'        'Desglosa la trama y muestra el resultado
'        RazonSocial.Text = psRetorno(1, 15)
'        ValorComp.Text = CDbl(psRetorno(1, 8)) / 100
'        ValorImpto.Text = CDbl(psRetorno(1, 9)) / 100
'        ValorInteres.Text = CDbl(psRetorno(1, 10)) / 100
'        ValorMulta.Text = CDbl(psRetorno(1, 11)) / 100
'        ValorSubtotal.Text = CDbl(psRetorno(1, 9)) / 100
'        ValorNC.Text = CDbl(0) / 100
'        ValorSRI.Text = CDbl(psRetorno(1, 7)) / 100
        

        'pricaura Ref-04 ini 20191223
        If VGTipoEjecucion% <> CGReverso% Then
            Stk.Text = psRetorno(1, 4)
        End If
        'pricaura Ref-04 fin 20191223
        NumSSN.Text = Trim$(VLSsn)
        
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 1)
        Nombre.Text = Mid$(FMRetParamATX(VGSqlConn, 2), 1, 30)
        VLautoriSri = FMRetParamATX(VGSqlConn, 3)
        VLautoriSri = Trim(VLautoriSri)
        VLFecvenSRI = FMRetParamATX(VGSqlConn, 4)
        VLFecvenSRI = Trim(VLFecvenSRI)
        VLSerie_Secuencia = FMRetParamATX(VGSqlConn, 5)
        VLSerie_Secuencia = Trim(VLSerie_Secuencia)
        
        LOG_AUTORIZACION = psRetorno(1, 4) 'KBastidz RECMPS-30004
        If LOG_AUTORIZACION = "" Then
            LOG_AUTORIZACION = Stk.Text
        End If
        
        PMChequeaATX VGSqlConn
        PMTotalesBranch "77"
        FLTransmitirCPS = True
        VLCambio% = False
        VLCambioCedruc% = False
        'TPE ------> Sumadora
'        SGSecTrn$ = FMRetParamATX(VGSqlConn, 1)
        VTIndicadorSum = 1
        PMIniciaRegSum
        VLFlagSumadora = True
        '<-----
    Else
        VLCambio% = True
        VLCambioCedruc% = True
        FLTransmitirCPS = False
        'TPE ------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 1)
        VTIndicadorSum = 0
        PMChequeaATX VGSqlConn
        VLFlagSumadora = False
        '<------
    End If
    PMChequeaATX VGSqlConn
    If FMRetStatusATX(VGSqlConn) <> 0 Then
        VTIndicadorSum = 0
        FLTransmitirCPS = False
    End If
    PMFinTransaccion
    
    'ame 08/04/2010
    If FLTransmitirCPS = True Then
       'JPM lectora de billetes -->
       If CCur(efe.Text) > 0 And ((VGDatPersBillAltDen.dataOK And VGTipoEjecucion = CGNormal%) Or VGTipoEjecucion = CGReverso%) Then
         'Call PMGuardarDsglsBillete("77", SGSecTrn$, VLTrn, rptBAD, CboTipCta.Text, Cta.ClipText)
         Call PMGuardarDsglsBillete("77", SGSecTrn$, VLTrn, rptBAD, "REC", "")
       End If
       '<-- JPM lectora de billetes
       'ref03 Ini
       If VLDeb_com = 0 Then
                Call PLFactura
        End If
       'ref03 Fin
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


Sub Efe_KeyPress(KeyAscii As Integer)
  KeyAscii = FMValidarNumero((efe.Text), VGLongitudMoney, KeyAscii, "77")
End Sub

Sub Efe_KeyDown(KeyCode As Integer, Shift As Integer)
  Select Case KeyCode%
    Case CGTeclaSUPR%
      efe.Text = ""
    Case CGTeclaENTER%
      SendKeys "{TAB}"
    Case CGTeclaMAS%
      efe.Text = FMCalculadora(FMObtenerTitulo("77") + "Efectivo:", 14, "77")
      SendKeys "{TAB}"
    Case CGTeclaPOR%
      efe.Text = FMSumadora(FMObtenerTitulo("77") + "Efectivo:", 14, "77")
    Case CGTeclaHOME%
      PMCambiarForma Me
    Case CGTeclaUP%, CGTeclaREPAG%
      'Tipo.SetFocus    pricaura Ref-04 20191223
    Case CGTeclaDOWN%, CGTeclaAVPAG%
      SendKeys "{TAB}"
  End Select
End Sub

Sub Efe_LostFocus()
    
    If Not VLFlagSumadora Then
        VLFlagSumadora = True
        Exit Sub
    End If

  'EAS
  If SGActivaSum = True Then
   Exit Sub
  End If
  
  If VGDecimales$ = "S" And (FMObtenerDecimales(FMObtenerMonedaForma("77")) > 0) Then
    efe.Text = str(FMCCurATX((efe.Text)) / FMObtenerFactorDecimal(FMObtenerMonedaForma("77")))
  End If
  If VGTotalizar$ = "S" Then
    If efe.Text <> "" Or efe.Text <> "0.00" Then
        'valor.Text = Str(FMCCurATX((efe.Text)) + FMCCurATX((prop.Text)) + FMCCurATX((locobj.Text)) + FMCCurATX((plaz.Text)) + FMCCurATX((ntcr.Text)))   'PHV 2/SEP/1999
        Valor.Text = str(FMCCurATX((efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((EfeCob.Text)) + FMCCurATX((mhNCReal.Text)))   'VIVI
    End If
  End If
    'Sumadora ------>
    If CDbl(efe.Text) <> SGUsar Then
        MsgBox "El Monto Efetivo No Coincide con el Monto Desglosado para el Deposito. Verificar", vbCritical, "Mensaje del Sistema"
        PMIngresoEfectivo
        efe.Text = Format$(SGUsar, "####,###,##0.00")
        SGActual = 0
    End If
    SGActivaSum = False
    '<------
End Sub

Sub Prop_KeyPress(KeyAscii As Integer)
  KeyAscii = FMValidarNumero((prop.Text), VGLongitudMoney, KeyAscii, "77")        'RCO 04/99
End Sub

Sub Prop_KeyDown(KeyCode As Integer, Shift As Integer)
  Select Case KeyCode%
    Case CGTeclaSUPR%
      prop.Text = ""
    Case CGTeclaENTER%
      SendKeys "{TAB}"
    Case CGTeclaMAS%
      prop.Text = FMCalculadora(FMObtenerTitulo("77") + "Chq propios:", 14, "77")
      SendKeys "{TAB}"
    Case CGTeclaPOR%
      prop.Text = FMSumadora(FMObtenerTitulo("77") + "Chq propios:", 14, "77")
    Case CGTeclaHOME%
      PMCambiarForma Me
    End Select
End Sub

Sub Prop_LostFocus()
  If VGDecimales$ = "S" And (FMObtenerDecimales(FMObtenerMonedaForma("77")) > 0) Then
    prop.Text = str(FMCCurATX((prop.Text)) / FMObtenerFactorDecimal(FMObtenerMonedaForma("77")))
  End If
  If VGTotalizar$ = "S" Then
    If prop.Text <> "" Or prop.Text <> "0.00" Then
      Valor.Text = str(FMCCurATX((efe.Text)) + FMCCurATX((prop.Text)) + FMCCurATX((locobj.Text)) + FMCCurATX((plaz.Text)) + FMCCurATX((EfeCob.Text)) + FMCCurATX((mhNCReal.Text)))
    End If
  End If
End Sub

Sub locobj_KeyPress(KeyAscii As Integer)
  KeyAscii = FMValidarNumero((locobj.Text), VGLongitudMoney, KeyAscii, "77")      'RCO 04/99
End Sub

Sub locobj_KeyDown(KeyCode As Integer, Shift As Integer)
  Select Case KeyCode%
    Case CGTeclaSUPR%
      locobj.Text = ""
    Case CGTeclaENTER%
      SendKeys "{TAB}"
    Case CGTeclaMAS%
      locobj.Text = FMCalculadora(FMObtenerTitulo("77") + "Chq local:", 14, "77")
      SendKeys "{TAB}"
    Case CGTeclaPOR%
      locobj.Text = FMSumadora(FMObtenerTitulo("77") + "Chq local:", 14, "77")
    Case CGTeclaHOME%
      PMCambiarForma Me
    End Select
End Sub

Sub locobj_LostFocus()
  If VGDecimales$ = "S" And (FMObtenerDecimales(FMObtenerMonedaForma("77")) > 0) Then
    locobj.Text = str(FMCCurATX((locobj.Text)) / FMObtenerFactorDecimal(FMObtenerMonedaForma("77")))
  End If
  If VGTotalizar$ = "S" Then
    If locobj.Text <> "" Or locobj.Text <> "0.00" Then
            Valor.Text = str(FMCCurATX((efe.Text)) + FMCCurATX((prop.Text)) + FMCCurATX((locobj.Text)) + FMCCurATX((plaz.Text)) + FMCCurATX((EfeCob.Text)) + FMCCurATX((mhNCReal.Text)))
    End If
  End If
End Sub

Sub Plaz_KeyPress(KeyAscii As Integer)
  KeyAscii = FMValidarNumero((plaz.Text), VGLongitudMoney, KeyAscii, "77")    'RCO 04/99
End Sub

Sub Plaz_KeyDown(KeyCode As Integer, Shift As Integer)
  Select Case KeyCode%
    Case CGTeclaSUPR%
      plaz.Text = ""
    Case CGTeclaENTER%
      SendKeys "{TAB}"
    Case CGTeclaMAS%
      plaz.Text = FMCalculadora(FMObtenerTitulo("77") + "Chq ot. plazas:", 14, "77")
      SendKeys "{TAB}"
    Case CGTeclaPOR%
      plaz.Text = FMSumadora(FMObtenerTitulo("77") + "Chq ot. plazas:", 14, "77")
    Case CGTeclaHOME%
      PMCambiarForma Me
    End Select
End Sub

Sub Plaz_LostFocus()
  If VGDecimales$ = "S" And (FMObtenerDecimales(FMObtenerMonedaForma("77")) > 0) Then
    plaz.Text = str(FMCCurATX((plaz.Text)) / FMObtenerFactorDecimal(FMObtenerMonedaForma("77")))
  End If
  If VGTotalizar$ = "S" Then
    If plaz.Text <> "" Or plaz.Text <> "0.00" Then
      Valor.Text = str(FMCCurATX((efe.Text)) + FMCCurATX((prop.Text)) + FMCCurATX((locobj.Text)) + FMCCurATX((plaz.Text)) + FMCCurATX((EfeCob.Text)) + FMCCurATX((mhNCReal.Text)))
    End If
  End If
End Sub


'lfcm 22-marzo-2007
'Se agrega por pago con Tarjeta de Credito
Private Sub tarjCredito_Change()
    VLCambio% = True
    VLCambioCedruc% = True
End Sub

'lfcm 22-marzo-2007
'Se agrega por pago con Tarjeta de Credito
Private Sub tarjCredito_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Ingrese el Valor de la Tarjeta"
End Sub

'lfcm 22-marzo-2007
'Se agrega por pago con Tarjeta de Credito
Private Sub tarjCredito_KeyDown(KeyCode As Integer, Shift As Integer)
  Select Case KeyCode%
    Case CGTeclaSUPR%
      tarjCredito.Text = ""
    Case CGTeclaENTER%
      SendKeys "{TAB}"
    Case CGTeclaMAS%
      SendKeys "{TAB}"
    Case CGTeclaHOME%
      PMCambiarForma Me
    Case CGTeclaUP%, CGTeclaREPAG%
      If Debito.Enabled Then
         Debito.SetFocus
      Else
         Cta.SetFocus
      End If
    Case CGTeclaDOWN%, CGTeclaAVPAG%
      SendKeys "{TAB}"
    End Select
    'TPE Activo bandera para mostrar Sumadora
    SGActivaSum = False
End Sub

'lfcm 22-marzo-2007
'Se agrega por pago con Tarjeta de Credito
Private Sub tarjCredito_KeyPress(KeyAscii As Integer)
    KeyAscii = FMValidarNumero((tarjCredito.Text), VGLongitudMoney, KeyAscii, "104")
End Sub

'lfcm 22-marzo-2007
'Se agrega por pago con Tarjeta de Credito
Private Sub tarjCredito_LostFocus()
    If VGDecimales$ = "S" And (FMObtenerDecimales(FMObtenerMonedaForma("104")) > 0) Then
        tarjCredito.Text = str(FMCCurATX((tarjCredito.Text)) / FMObtenerFactorDecimal(FMObtenerMonedaForma("104")))
    End If
End Sub


Private Sub tipo_LostFocus()
'   DoEvents
   If Trim(Tipo.Text) = "" Then
      Frame1.Caption = ""
      VLTipoOK = False
   Else
      Frame1.Caption = Space(20) & Mid(sal_tipo, 1, 30)
      VLTipoOK = True
      'SendKeys "{TAB}"
   End If
  '-- obtiene el valor de la comision -- PS 26/01/2004
 ' PMInicioTransaccion
 ' PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "cl_costo_serv_comision", "", ""
 ' PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR&, "V", "", ""
  'PMPasoValoresATX VGSqlConn&, "@i_codigo", 0, SQLCHAR&, "IMPFISC", "", ""
  'If FMTransmitirRPCATX(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "", "N", "S", "I", "0", "N", "N") Then
  '  PMMapeaObjetoATX VGSqlConn&, Comision
  '  PMChequeaATX VGSqlConn&
  '  PMFinTransaccion
 ' Else
   ' Comision = 0#
  '  PMChequeaATX VGSqlConn&
   ' PMFinTransaccion
 ' End If
  
  
  
  'smerino aumenta comision
    'CONSULTA TASA DEL IVA Y BASE IMPONBLE
   PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 4050, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLVARCHAR, "C", "opcion", ""
    PMPasoValoresATX VGSqlConn, "@i_servi_person", 0, SQLVARCHAR, "SRI", "Servicio Person", ""
    PMPasoValoresATX VGSqlConn, "@i_rubro_person", 0, SQLVARCHAR, "POFP", "Rubro Person", ""
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
        
         'LBP Inicio RECA-CC-SGC00025869
         If Comision.Text > 0 Then
            VGCom_aux = FMDevuelveComisionReal(Comision, False, 77)
            If VGCom_aux <> CDbl(Comision.Text) Then
                VGComision_original = Comision.Text
                Comision.Text = VGCom_aux
            Else
                VGComision_original = Comision.Text
            End If
         End If
        'LBP Fin RECA-CC-SGC00025869
        
    Else
       Comision = 0#
       PMChequeaATX VGSqlConn&
       PMFinTransaccion
    End If
'FIN DE BASE IMPONIBLE
  

End Sub

Private Sub Valor_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Ingrese Valor Total"
End Sub

Sub valor_KeyPress(KeyAscii As Integer)
  KeyAscii = FMValidarNumero((Valor.Text), VGLongitudMoney, KeyAscii, "77")  'RCO 04/99
End Sub

Sub valor_KeyDown(KeyCode As Integer, Shift As Integer)
  Select Case KeyCode%
    Case CGTeclaSUPR%
      Valor.Text = ""
    Case CGTeclaENTER%
      SendKeys "{TAB}"
    Case CGTeclaMAS%
      Valor.Text = FMCalculadora(FMObtenerTitulo("77") + "Valor total:", 14, "77")
      SendKeys "{TAB}"
    Case CGTeclaPOR%
      Valor.Text = FMSumadora(FMObtenerTitulo("77") + "Valor total:", 14, "77")
    Case CGTeclaHOME%
      PMCambiarForma Me
    Case CGTeclaUP%, CGTeclaREPAG%
      'Cedula1.SetFocus  pricaura Ref-04 20191223
    Case CGTeclaDOWN%, CGTeclaAVPAG%
      KeyCode = 0
    End Select
End Sub

Sub valor_LostFocus()
  If VGDecimales$ = "S" And (FMObtenerDecimales(FMObtenerMonedaForma("77")) > 0) Then
    Valor.Text = str(FMCCurATX((Valor.Text)) / FMObtenerFactorDecimal(FMObtenerMonedaForma("77")))
  End If
  If VGTotalizar$ = "S" Then
    If Valor.Text <> "" Or Valor.Text <> "0.00" Then
        Valor.Text = str(FMCCurATX((efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((EfeCob.Text)) + FMCCurATX((mhNCReal.Text)))
    End If
  End If
End Sub

Sub Cheques_KeyPress(KeyAscii As Integer)
  KeyAscii = FMValidarNumero((Cheques.Text), VGLongitudMoney, KeyAscii, "77")
End Sub

Sub Cheques_KeyDown(KeyCode As Integer, Shift As Integer)
  Select Case KeyCode%
    Case CGTeclaSUPR%
      Cheques.Text = ""
    Case CGTeclaENTER%
      SendKeys "{TAB}"
    Case CGTeclaMAS%
      Cheques.Text = FMCalculadora(FMObtenerTitulo("77") + "Cheques Locales:", 14, "77")
      SendKeys "{TAB}"
    Case CGTeclaPOR%
      Cheques.Text = FMSumadora(FMObtenerTitulo("77") + "Cheques Locales:", 14, "77")
    Case CGTeclaHOME%
      PMCambiarForma Me
    Case CGTeclaUP%, CGTeclaREPAG%
      efe.SetFocus
    Case CGTeclaDOWN%, CGTeclaAVPAG%
      SendKeys "{TAB}"
    End Select
End Sub

Sub Cheques_LostFocus()
  If VGDecimales$ = "S" And (FMObtenerDecimales(FMObtenerMonedaForma("77")) > 0) Then
    Cheques.Text = str(FMCCurATX((Cheques.Text)) / FMObtenerFactorDecimal(FMObtenerMonedaForma("77")))
  End If
  If VGTotalizar$ = "S" Then
    If Cheques.Text <> "" Or Cheques.Text <> "0.00" Then
        Valor.Text = str(FMCCurATX((efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((EfeCob.Text)) + FMCCurATX((mhNCReal.Text)))
    End If
  End If
End Sub

Private Sub tipo_KeyDown(KeyCode As Integer, Shift As Integer)
  Select Case KeyCode%
    Case CGTeclaSUPR%
      Tipo.Text = ""
    Case CGTeclaUP%, CGTeclaREPAG%
      KeyCode = 0
    Case CGTeclaDOWN%, CGTeclaAVPAG%
      SendKeys "{TAB}"
  End Select
End Sub

Private Sub Cedula1_KeyDown(KeyCode As Integer, Shift As Integer)
    Select Case KeyCode%
        Case CGTeclaSUPR%
            Cedula1.Text = ""
        Case CGTeclaENTER%
            activa = True
        Case CGTeclaUP%, CGTeclaREPAG%
            SendKeys "+{TAB}"
        Case CGTeclaDOWN%, CGTeclaAVPAG%
            SendKeys "{TAB}"
    Case CGTeclaF5%
        If VGTipoEjecucion% <> CGReverso% Then
'            pricaura ini Ref-04 20191223
'            If Trim(Cedula1) = "" Or Trim(Cedula1) = "_____________" Then
'                MsgBox "La identificación es necesaria", vbInformation, "Aviso"
'                Exit Sub
'            End If
'            pricaura fin Ref-04 20191223
            If Trim(CEP) = "" Or Trim(CEP) = "____________" Then
                MsgBox "El CEP es necesario", vbInformation, "Aviso"
                Exit Sub
            End If
'            pricaura ini Ref-04 20191223
'            If Trim$(Tipo.Text) = "" Or Trim$(sal_tipo.Caption) = "" Then
'                MsgBox "El tipo de impuesto es necesario", vbInformation, "Aviso"
'                Exit Sub
'            End If
'            pricaura fin Ref-04 20191223
            'If Not FLTramaSwitch("C") Then
            If Not FLConsOFP() = True Then
                If Trim$(Nombre.Text) <> "" Then
                    MsgBox Nombre.Text, vbInformation, "Mensaje del sri"
                End If
                Exit Sub
            End If
        End If
    End Select
    VLCambio% = True
    VLCambioCedruc% = True
End Sub

Sub Stk_KeyDown(KeyCode As Integer, Shift As Integer)
  Select Case KeyCode%
    Case CGTeclaENTER%
      SendKeys "{TAB}"
    Case CGTeclaSUPR%
      If Stk.Enabled Then
        Stk.Text = ""
      End If
    End Select
  End Sub

Function FLChequeos() As Integer
  FLChequeos = True
  If Trim(Tipo) = "" Then
     MsgBox "El campo Tipo de Impuesto es mandatorio"
     If Tipo.Enabled Then
        'Tipo.SetFocus    pricaura Ref-04 20191223
     End If
     FLChequeos = False
     Exit Function
  End If
  If Trim(Cedula1) = "" Or Trim(Cedula1) = "_____________" Then
     MsgBox "El campo de Cédula/RUC es mandatorio"
    If Cedula1.Enabled Then
       'Cedula1.SetFocus  pricaura Ref-04 20191223
    End If
     FLChequeos = False
    Exit Function
  End If
 ''If FMValidaCedula1Ruc(Cedula1) = False Then smerino ajustes
     ''FLChequeos = False
     ''Exit Function
  ''End If
  If Cta.ClipText <> "" And Debito.ValueReal = 0 Then
    MsgBox "El campo Debito: es Mandatorio"
    If Debito.Enabled Then
        Debito.SetFocus
    End If
    FLChequeos = False
    Exit Function
  End If
  If CInt(CantChq.Text) <> 0 And Cheques.ValueReal = 0 Then
    MsgBox "Verifique el Campo Valor en Cheque"
    Cheques.SetFocus
    FLChequeos = False
    Exit Function
  End If
  
    'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
    If FCC77.Cta.ClipText <> "" Then
        If VLDeb_com > 0 And FCC77.Cta.ClipText <> VLCta_com Then
            MsgBox "La cuenta de la comision debe ser la misma con la que realiza el pago del servicio."
            Comision.SetFocus
            FLChequeos = False
            Exit Function
        End If
    End If
    'msilvag Fin
    
  If VLTotCom <> FMCCurATX((Comision.Text)) Then   ' ame 01/07/2004
      MsgBox "Verifique el Campo Valor de Comision"
      If Comision.Enabled Then
        Comision.SetFocus
      End If
      FLChequeos = False
      Exit Function
  End If
  
    If Format(Valor.Text, "###,###,###,##0.00") <> Format(FMCCurATX(ValorSRI.Text), "###,###,###,##0.00") Then
      MsgBox "El valor a pagar es distinto al indicado :" & FMCCurATX((Debito.Text)) + FMCCurATX((efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((EfeCob.Text)) + FMCCurATX((mhNCReal.Text))
      Valor.Text = 0
      If Valor.Enabled = True Then
          Valor.SetFocus
      End If
      FLChequeos = False
      Exit Function
    End If
  
  If VGTotalizar$ = "N" Then
    'lfcm 22-marzo-2007
    'Se aumenta el campo Tarjeta de Credito para validar los totales
    'If Format(valor.Text, "###,###,###,##0.00") <> Format(FMCCurATX((Debito.Text)) + FMCCurATX((Efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((EfeCob.Text)) + FMCCurATX((mhNCReal.Text)), "###,###,###,##0.00") Then
    If Format(Valor.Text, "###,###,###,##0.00") <> Format(FMCCurATX((Debito.Text)) + FMCCurATX((efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((EfeCob.Text)) + FMCCurATX((mhNCReal.Text)) + FMCCurATX((Me.tarjCredito.Text)), "###,###,###,##0.00") Then
      'lfcm 22-marzo-2007
      'Se aumenta el campo Tarjeta de Credito para validar los totales
      'MsgBox " El campo Total no cuadra :" & FMCCurATX((Debito.Text)) + FMCCurATX((Efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((EfeCob.Text)) + FMCCurATX((mhNCReal.Text))
      MsgBox " El campo Total no cuadra :" & FMCCurATX((Debito.Text)) + FMCCurATX((efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((EfeCob.Text)) + FMCCurATX((mhNCReal.Text) + FMCCurATX((Me.tarjCredito.Text)))
      
      Valor.Text = 0
      If Valor.Enabled = True Then
          Valor.SetFocus
      End If
      FLChequeos = False
      Exit Function
    End If
  Else
    'lfcm 22-marzo-2007
    'Se aumenta el campo Tarjeta de Credito para validar los totales
    'valor.Text = Format(FMCCurATX((Efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((EfeCob.Text)) + FMCCurATX((mhNCReal.Text)), "###,###,###,##0.00")
    Valor.Text = Format(FMCCurATX((efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((EfeCob.Text)) + FMCCurATX((mhNCReal.Text)) + FMCCurATX((Me.tarjCredito.Text)), "###,###,###,##0.00")
  End If
  
  If FMCCurATX((efe.Text)) > 0 And CCur(VLEfe_com) > 0 And VGTipoEjecucion = CGNormal% Then
     VTTotalDesglose = 0
        For I% = 1 To SGNumDen
            If SGIngreso(I% - 1).cant_ingr > 0 Then
                VTTotalDesglose = VTTotalDesglose + SGIngreso(I% - 1).mont_ingr
            End If
        Next I%
        If CCur(VTTotalDesglose + SGAcumulado) < (FMCCurATX((efe.Text)) + CCur(VLEfe_com)) Then
            MsgBox "Desglose menor a efectivo ingresado. Verifique...", vbCritical, "Mensaje del Servidor"
            FLChequeos = False
            Exit Function
        End If
  End If
End Function

Sub Tipo_Change()
  VLPaso% = False
  VLCambio% = True
  VLCambioCedruc% = True
End Sub

Sub Efe_Change()
  VLCambio% = True
  VLCambioCedruc% = True
End Sub

Sub Prop_Change()
  VLCambio% = True
  VLCambioCedruc% = True
End Sub

Sub locobj_Change()
  VLCambio% = True
  VLCambioCedruc% = True
End Sub

Sub Plaz_Change()
  VLCambio% = True
  VLCambioCedruc% = True
End Sub

Sub valor_Change()
  If VGTotalizar$ = "N" Then
    VLCambio% = True
    VLCambioCedruc% = True
  End If
  Total.Text = CDbl(Valor.Text) + CDbl(Comision.Text)
End Sub

'PHV 2/SEP/1999
Sub Cheques_Change()
  VLCambio% = True
  VLCambioCedruc% = True
End Sub

Private Sub Cedula1_Change()
  VLCambio% = False ' Modificado por VIVI
  VLCambioCedruc% = True ' RCA 14/Ene/2003
  CedRuc = Cedula1
End Sub
'PHV 2/SEP/1999

Public Function FLEfeCobro() As Integer
'********************************************************
'  VIVI, 24/Sep/2002
'  VERIFICA SI EL CLIENTE TIENE ASIGNADO UN CUPO PARA
'  EFECTO DE COBRO Y RECUPERA SUS CUPOS Y DIAS DE GRACIA
'********************************************************
 If Trim(Cedula1.Text) <> "" Then
    VTEfeCob$ = " "
    VTCupoArancel = 0#
    VTDiasGracia = 0
    VTNombreClte$ = ""
    VTClte = 0
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, "3440", "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLVARCHAR, "C", "Opcion", ""
    If CedRuc.Text <> Cedula1.Text Then
        PMPasoValoresATX VGSqlConn, "@i_cedruc", 0, SQLVARCHAR, (CedRuc.Text), "CedRuc", ""
    Else
        PMPasoValoresATX VGSqlConn, "@i_cedruc", 0, SQLVARCHAR, (Cedula1.Text), "CedRuc", ""
    End If
    PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLINT2, "3", "Producto", ""
    PMPasoValoresATX VGSqlConn, "@i_prod_efe", 0, SQLVARCHAR, "01", "Producto Efecto", ""
    PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, Trim(str(FMObtenerMonedaForma("77"))), "Moneda", ""
    '*********************************************************************************
    'VAL  20/Sep/2002 CAMPOS PARA MANEJO DE EFECTO DE COBRO
    'SE RECUPERA CLASIFICACION DEL CLIENTE, CUPO, COD.OFICIAL, NOMBRE OFICIAL, CUENTA DEBITO
    PMPasoValoresATX VGSqlConn, "@o_efe_cobro", 1, SQLCHAR, VTEfeCob$, "", ""
    PMPasoValoresATX VGSqlConn, "@o_cupo", 1, SQLMONEY, str(VTCupoArancel), "", ""
    PMPasoValoresATX VGSqlConn, "@o_dias_gracia", 1, SQLINT1, (VTDiasGracia), "", ""
    PMPasoValoresATX VGSqlConn, "@o_clte", 1, SQLMONEY, str(VTClte), "", ""
    PMPasoValoresATX VGSqlConn, "@o_nombre_clte", 1, SQLVARCHAR, (VTNombreClte$), "", ""
    PMPasoValoresATX VGSqlConn, "@o_oficial", 1, SQLMONEY, str(VTOficial), "", ""
    PMPasoValoresATX VGSqlConn, "@o_nombre_oficial", 1, SQLVARCHAR, (VTNombreOfic$), "", ""
    PMPasoValoresATX VGSqlConn, "@o_tipo_cta", 1, SQLVARCHAR, (VTTipoCta$), "", ""
    PMPasoValoresATX VGSqlConn, "@o_cta", 1, SQLVARCHAR, (VTCta$), "", ""
    PMPasoValoresATX VGSqlConn, "@o_cupo_min", 1, SQLMONEY, (mhrCupoMin), "Cupo", ""
    '*********************************************************************************
    If FMTransmitirRPCATX(VGSqlConn, "", "cob_servicios", "sp_tr_cons_efecto_cobro", True, "Transaccion Ok", "N", "N", "N", "77", "S", "S") = True Then
       'PMMapeaGrid VGSqlConn&, grdRegistros, VTModo%
       VTEfeCob$ = FMRetParamATX(VGSqlConn, 1)
       VTCupoArancel = FMRetParamATX(VGSqlConn, 2)
       VTDiasGracia = FMRetParamATX(VGSqlConn, 3)
       VTClte = FMRetParamATX(VGSqlConn, 4)
       VTNombreClte$ = FMRetParamATX(VGSqlConn, 5)
       VTOficial = FMRetParamATX(VGSqlConn, 6)
       VTNombreOfic$ = FMRetParamATX(VGSqlConn, 7)
       VTTipoCta$ = FMRetParamATX(VGSqlConn, 8)
       VTCta$ = FMRetParamATX(VGSqlConn, 9)
       mhrCupoMin = FMRetParamATX(VGSqlConn, 10)
       lblCliente.Caption = VTClte
       'Valor = CCur(MhRDato(0))
       If VTEfeCob$ = "S" Then
          'EfeCob.Enabled = True
          FLEfeCobro = True
       Else
          EfeCob.Text = 0#
          VTNombreClte$ = ""
          VTNombreOfic$ = ""
          VTTipoCta$ = ""
          VTCta$ = ""
          'EfeCob.Enabled = False
          FLEfeCobro = False
       End If
       
       PMChequeaATX VGSqlConn
       'PMTotalesBranch "15"
 '      PMFinTransaccion
       VLCambio% = False
       VLCambioCedruc% = False
    Else
'       PMFinTransaccion
       VLCambio% = True
       VLCambioCedruc% = True
       FLEfeCobro = False
    End If
    PMChequeaATX VGSqlConn
    If FMRetStatusATX(VGSqlConn) <> 0 Then
       FLEfeCobro = False
    End If
    PMFinTransaccion
Else
    MsgBox "Ingrese Número de Cédula/RUC", vbExclamation, "Mensaje de Error"
    'Cedula1.SetFocus  pricaura Ref-04 20191223
    FLEfeCobro = False
End If
End Function

Private Sub CboTipCta_GotFocus()
  FPrincipal!pnlHelpLine.Caption = "CTE|Cta Corrientes,  AHO|Cta de Ahorros"
End Sub

Private Sub Cta_GotFocus()
  FPrincipal!pnlHelpLine.Caption = Cta.HelpLine
End Sub

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

Private Sub Cta_KeyDown(KeyCode As Integer, Shift As Integer)
  Select Case KeyCode%
    Case CGTeclaSUPR%
      If Cta.Enabled Then
         Cta.Clear
      End If
'    Case CGTeclaENTER%
'      SendKeys "{TAB}"
    Case CGTeclaUP%, CGTeclaREPAG%
      CboTipCta.SetFocus
    Case CGTeclaDOWN%, CGTeclaAVPAG%
      SendKeys "{TAB}"
  End Select
End Sub

Private Sub Cta_LostFocus()
    Dim VTipoDatoCta As StructDatoCta   'jlf  05AGO2006  PARA TRAER EL NOMBRE DE LA CTA
    VLfirma = FMValidaFirma(VLfirma, CboTipCta.Text, Cta, "77", Nombre, VLMoneda, VLDescMonCta)
    lblMoneda.Caption = VLDescMonCta
    VTipoDatoCta = LoNombreCta(CboTipCta.Text, Cta.ClipText, "77")  'jlf  05AGO2006  PARA TRAER EL NOMBRE DE LA CTA
    Nombre = VTipoDatoCta.NombreCta                           'jlf  05AGO2006  PARA TRAER EL NOMBRE DE LA CTA
    
    If VLfirma = True Then
        Debito.Enabled = True
        Debito.SetFocus
    End If
End Sub

Sub Debito_Change()
  VLCambio% = True
  VLCambioCedruc% = True
End Sub

Sub Debito_GotFocus()
  FPrincipal!pnlHelpLine.Caption = "Ingrese el Valor del Debito"
End Sub

Sub Debito_KeyDown(KeyCode As Integer, Shift As Integer)
  Select Case KeyCode%
    Case CGTeclaSUPR%
      Debito.Text = ""
    Case CGTeclaENTER%
      SendKeys "{TAB}"
    Case CGTeclaMAS%
      Debito.Text = FMCalculadora(FMObtenerTitulo("104") + "Debito:", 14, "104")
      SendKeys "{TAB}"
    Case CGTeclaPOR%
      Debito.Text = FMSumadora(FMObtenerTitulo("104") + "Debito:", 14, "104")
    Case CGTeclaHOME%
      PMCambiarForma Me
    Case CGTeclaUP%, CGTeclaREPAG%
      Reten.SetFocus
    Case CGTeclaDOWN%, CGTeclaAVPAG%
      SendKeys "{TAB}"
    End Select
    'TPE Activo bandera para mostrar Sumadora
    SGActivaSum = False
End Sub

Sub Debito_KeyPress(KeyAscii As Integer)
  KeyAscii = FMValidarNumero((Debito.Text), VGLongitudMoney, KeyAscii, "104")
End Sub

Sub Debito_LostFocus()
  If VGDecimales$ = "S" And (FMObtenerDecimales(FMObtenerMonedaForma("104")) > 0) Then
    Debito.Text = str(FMCCurATX((Debito.Text)) / FMObtenerFactorDecimal(FMObtenerMonedaForma("104")))
  End If
End Sub

Function FLSecuencias() As Integer
Dim VTIndicadorSum As Integer
Dim VLTipoEjecucion As Integer
    
    VLTipoEjecucion = VGTipoEjecucion
    VGTipoEjecucion = CGNormal
    
    VTIndicadorSum = 0
    
    If VGHorarioDif Then
        VLTrn = "3612"
    Else
        VLTrn = "3611"
    End If
    
    VGTrn = IIf(VLTrn = "", 0, VLTrn)
    
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLVARCHAR, "C", "Opcion", ""
    PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, "0", "SecTrn", ""
    PMPasoValoresATX VGSqlConn, "@o_fechora", 1, SQLVARCHAR, Space(16), "fechora", ""
    PMPasoValoresATX VGSqlConn, "@o_feccontable", 1, SQLVARCHAR, Space(10), "feccontable", ""
    PMPasoValoresATX VGSqlConn, "@o_provincia", 1, SQLVARCHAR, Space(3), "Provincia", ""
    If FMTransmitirRPCATX(VGSqlConn, "", "cob_cuentas", "sp_tr_ofp_sri", True, "Transaccion Ok", "S", "N", "N", "77", "S", "S") = True Then
        VLSsn = FMRetParamATX(VGSqlConn, 1)
        If Len(Trim$(VLSsn)) > 8 Then
            VLSsn = Mid$(Trim$(VLSsn), 1, 8)
        End If
        VLFecHora = FMRetParamATX(VGSqlConn, 2)
        VLFecContable = FMRetParamATX(VGSqlConn, 3)
        VLProvincia = FMRetParamATX(VGSqlConn, 4)
        PMChequeaATX VGSqlConn
        PMTotalesBranch "77"
         VLFechaPago = Mid$(VLFecHora, 7, 2) + "-"
        Select Case Mid$(VLFecHora, 5, 2)
        Case "01"
            VLFechaPago = VLFechaPago + "JAN"
        Case "02"
            VLFechaPago = VLFechaPago + "FEB"
        Case "03"
            VLFechaPago = VLFechaPago + "MAR"
        Case "04"
            VLFechaPago = VLFechaPago + "APR"
        Case "05"
            VLFechaPago = VLFechaPago + "MAY"
        Case "06"
            VLFechaPago = VLFechaPago + "JUN"
        Case "07"
            VLFechaPago = VLFechaPago + "JUL"
        Case "08"
            VLFechaPago = VLFechaPago + "AUG"
        Case "09"
            VLFechaPago = VLFechaPago + "SEP"
        Case "10"
            VLFechaPago = VLFechaPago + "OCT"
        Case "11"
            VLFechaPago = VLFechaPago + "NOV"
        Case "12"
            VLFechaPago = VLFechaPago + "DEC"
        End Select
        VLFechaPago = VLFechaPago + "-" + Mid$(VLFecHora, 3, 2)
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
    Dim VLCodRetornoInd  As String
    Dim VLValorPagar As String
    Dim VLSSNREV As String
    'VLTipo
    'C=Consulta
    'P=Pago
    'R=Reversa normal
    MsgBox "ALERTA - ARREGLAR ESTE CAMBIO QUE NO PUEDE LLAMAR AL SWITCH", vbCritical, "ATXVB"
    FLTramaSwitch = False
    Exit Function
    
    Me.Enabled = False
    
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
            Me.Enabled = True
            Exit Function
        End If
        'Bloquear controles
        Cedula1.Enabled = False
        CEP.Enabled = False
        Tipo.Enabled = False
        'Arma trama
        VLTramaEnvio = "0314006          "
        VLTramaEnvio = VLTramaEnvio + VLFecHora 'Fecha y hora real aaaammddhhmmsscc
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2) 'Fecha contable
        VLTramaEnvio = VLTramaEnvio + "004001C00"
        VLTramaEnvio = VLTramaEnvio + String(8 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn) 'SSN
        VLTramaEnvio = VLTramaEnvio + "N00000000"
        VLTramaEnvio = VLTramaEnvio + String(3 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) 'Oficina
        VLTramaEnvio = VLTramaEnvio + Trim$(VGUsuario) + String(10 - Len(Trim$(VGUsuario)), " ") 'Usuario
        VLTramaEnvio = VLTramaEnvio + String(8 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn) 'MCN
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecHora, 7, 2) + "-"
        Select Case Mid$(VLFecHora, 5, 2)
        Case "01"
            VLTramaEnvio = VLTramaEnvio + "JAN"
        Case "02"
            VLTramaEnvio = VLTramaEnvio + "FEB"
        Case "03"
            VLTramaEnvio = VLTramaEnvio + "MAR"
        Case "04"
            VLTramaEnvio = VLTramaEnvio + "APR"
        Case "05"
            VLTramaEnvio = VLTramaEnvio + "MAY"
        Case "06"
            VLTramaEnvio = VLTramaEnvio + "JUN"
        Case "07"
            VLTramaEnvio = VLTramaEnvio + "JUL"
        Case "08"
            VLTramaEnvio = VLTramaEnvio + "AUG"
        Case "09"
            VLTramaEnvio = VLTramaEnvio + "SEP"
        Case "10"
            VLTramaEnvio = VLTramaEnvio + "OCT"
        Case "11"
            VLTramaEnvio = VLTramaEnvio + "NOV"
        Case "12"
            VLTramaEnvio = VLTramaEnvio + "DEC"
        End Select
        VLTramaEnvio = VLTramaEnvio + "-" + Mid$(VLFecHora, 3, 2)
        VLTramaEnvio = VLTramaEnvio + "                           07000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000   VENTANILLA  "
        VLTramaEnvio = VLTramaEnvio + String(4 - Len(Trim$(Tipo.Text)), "0") + Trim$(Tipo.Text) 'Impuesto
        VLTramaEnvio = VLTramaEnvio + "TRA_CON"
        VLTramaEnvio = VLTramaEnvio + Trim$(Cedula1.Text) + String(15 - Len(Trim$(Cedula1.Text)), " ") 'RUC
        VLTramaEnvio = VLTramaEnvio + Trim$(CEP.ClipText) + String(20 - Len(Trim$(CEP.ClipText)), " ") 'CEP
        VLTramaEnvio = VLTramaEnvio + " "
        VLTramaEnvio = VLTramaEnvio + Trim$(VLProvincia) + String(3 - Len(Trim$(VLProvincia)), " ")  'Provincia
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
            MsgBox "Transaccion No ha sido realizada intente nuevamente", vbInformation, "AVISO"
            Me.Enabled = True
            Exit Function
        End If
        VLCodRetornoInd = Mid$(VLTramaRetorno, 53, 2)
        If VLCodRetornoInd = "01" Then
            MsgBox "Tiempo de Espera Agotado. Problema de comunicación del SRI", vbCritical, "Aviso"
            Exit Function
        End If
        VLCodRetorno = val(Mid$(VLTramaRetorno, 144, 2))
        If VLCodRetorno > 1 Then
            PMInicioTransaccion
            PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "cl_errores_sri", "", ""
            PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR&, "V", "", ""
            PMPasoValoresATX VGSqlConn&, "@i_codigo", 0, SQLCHAR&, Trim$(str$(VLCodRetorno)), "", ""
            If FMTransmitirRPCATX(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "", "N", "S", "I", "0", "N", "N") Then
                PMMapeaObjetoATX VGSqlConn&, Nombre
                PMChequeaATX VGSqlConn&
                PMFinTransaccion
            Else
                MsgBox "MENSAJE DE ERROR DEL SRI NO CATALOGADO EN EL BANCO", vbCritical, "ERROR"
                PMChequeaATX VGSqlConn&
                PMFinTransaccion
            End If
            Me.Enabled = True
            Exit Function
        End If
        If VLCodRetorno < 0 Then
            MsgBox Trim$(Mid$(VLTramaRetorno, 257, 255)), vbExclamation, "Aviso"
            Me.Enabled = True
            Exit Function
        End If
        'Desglosa la trama y muestra el resultado
        RazonSocial.Text = Trim$(Mid$(VLTramaRetorno, 257, 255))
        ValorComp.Text = CDbl(Trim$(Mid$(VLTramaRetorno, 178, 15))) / 100
        ValorImpto.Text = CDbl(Trim$(Mid$(VLTramaRetorno, 193, 15))) / 100
        ValorInteres.Text = CDbl(Trim$(Mid$(VLTramaRetorno, 208, 15))) / 100
        ValorMulta.Text = CDbl(Trim$(Mid$(VLTramaRetorno, 223, 15))) / 100
        ValorSubtotal.Text = CDbl(Trim$(Mid$(VLTramaRetorno, 163, 15))) / 100
        ValorNC.Text = CDbl(Trim$(Mid$(VLTramaRetorno, 238, 15))) / 100
        ValorSRI.Text = CDbl(Trim$(Mid$(VLTramaRetorno, 146, 15))) / 100
        Frame1.Enabled = True
        Me.Enabled = True
    '*****************************************************************
    '*****************************************************************
    '*************** P A G O *****************************************
    '*****************************************************************
    '*****************************************************************
    Case "P"
        If Not FLSecuencias() Then
            Me.Enabled = True
            Exit Function
        End If
        'Arma trama
        VLTramaEnvio = "0314006          "
        VLTramaEnvio = VLTramaEnvio + VLFecHora 'Fecha y hora real aaaammddhhmmsscc
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2) 'Fecha contable
        VLTramaEnvio = VLTramaEnvio + "004001P00"
        VLTramaEnvio = VLTramaEnvio + String(8 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn) 'SSN
        VLTramaEnvio = VLTramaEnvio + "N00000000"
        VLTramaEnvio = VLTramaEnvio + String(3 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) 'Oficina
        VLTramaEnvio = VLTramaEnvio + Trim$(VGUsuario) + String(10 - Len(Trim$(VGUsuario)), " ") 'Usuario
        VLTramaEnvio = VLTramaEnvio + String(8 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)  'MCN
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecHora, 7, 2) + "-"
        Select Case Mid$(VLFecHora, 5, 2)
        Case "01"
            VLTramaEnvio = VLTramaEnvio + "JAN"
        Case "02"
            VLTramaEnvio = VLTramaEnvio + "FEB"
        Case "03"
            VLTramaEnvio = VLTramaEnvio + "MAR"
        Case "04"
            VLTramaEnvio = VLTramaEnvio + "APR"
        Case "05"
            VLTramaEnvio = VLTramaEnvio + "MAY"
        Case "06"
            VLTramaEnvio = VLTramaEnvio + "JUN"
        Case "07"
            VLTramaEnvio = VLTramaEnvio + "JUL"
        Case "08"
            VLTramaEnvio = VLTramaEnvio + "AUG"
        Case "09"
            VLTramaEnvio = VLTramaEnvio + "SEP"
        Case "10"
            VLTramaEnvio = VLTramaEnvio + "OCT"
        Case "11"
            VLTramaEnvio = VLTramaEnvio + "NOV"
        Case "12"
            VLTramaEnvio = VLTramaEnvio + "DEC"
        End Select
        VLTramaEnvio = VLTramaEnvio + "-" + Mid$(VLFecHora, 3, 2)
        VLTramaEnvio = VLTramaEnvio + "                           070000000000000000"
        VLValorPagar = Trim$(str$(CDbl(ValorSRI.Text) * 100))
        VLTramaEnvio = VLTramaEnvio + String(15 - Len(Trim$(VLValorPagar)), "0") + VLValorPagar
        VLTramaEnvio = VLTramaEnvio + "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000   VENTANILLA  "
        VLTramaEnvio = VLTramaEnvio + String(4 - Len(Trim$(Tipo.Text)), "0") + Trim$(Tipo.Text) 'Impuesto
        VLTramaEnvio = VLTramaEnvio + "TRA_AFE"
        VLTramaEnvio = VLTramaEnvio + Trim$(Cedula1.Text) + String(15 - Len(Trim$(Cedula1.Text)), " ") 'RUC
        VLTramaEnvio = VLTramaEnvio + Trim$(CEP.ClipText) + String(20 - Len(Trim$(CEP.ClipText)), " ") 'CEP
        VLTramaEnvio = VLTramaEnvio + " "
        VLTramaEnvio = VLTramaEnvio + Trim$(VLProvincia) + String(3 - Len(Trim$(VLProvincia)), " ")  'Provincia
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
            If Mid$(VLTramaRetorno, 1, 4) = "7806" Then
                VLRevTimeOut = True
                VLSsnRevTimeOut = VLSsn
            End If
            Me.Enabled = True
            Exit Function
        End If
        VLCodRetornoInd = Mid$(VLTramaRetorno, 53, 2)
        If VLCodRetornoInd = "01" Then
            VLRevTimeOut = True
            VLSsnRevTimeOut = VLSsn
            MsgBox "Tiempo de Espera Agotado. Problema de comunicación del SRI", vbCritical, "Aviso"
            Exit Function
        End If
        VLCodRetorno = val(Mid$(VLTramaRetorno, 144, 2))
        If VLCodRetorno > 1 Then
            PMInicioTransaccion
            PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "cl_errores_sri", "", ""
            PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR&, "V", "", ""
            PMPasoValoresATX VGSqlConn&, "@i_codigo", 0, SQLCHAR&, Trim$(str$(VLCodRetorno)), "", ""
            If FMTransmitirRPCATX(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "", "N", "S", "I", "0", "N", "N") Then
                PMMapeaObjetoATX VGSqlConn&, Nombre
                PMChequeaATX VGSqlConn&
                PMFinTransaccion
            Else
                MsgBox "MENSAJE DE ERROR DEL SRI NO CATALOGADO EN EL BANCO", vbCritical, "ERROR"
                PMChequeaATX VGSqlConn&
                PMFinTransaccion
            End If
            Me.Enabled = True
            Exit Function
        End If
        If VLCodRetorno < 0 Then
            MsgBox Trim$(Mid$(VLTramaRetorno, 257, 255)), vbExclamation, "Aviso"
            Me.Enabled = True
            Exit Function
        End If
        'Desglosa la trama y muestra el resultado
        Stk.Text = Trim$(Mid$(VLTramaRetorno, 129, 18))
        NumSSN.Text = Trim$(VLSsn)
        Me.Enabled = True
    '*****************************************************************
    '*****************************************************************
    '*************** R E V E R S A ***********************************
    '*****************************************************************
    '*****************************************************************
    Case "R"
        If Not FLSecuencias() Then
            Me.Enabled = True
            Exit Function
        End If
        'Arma trama
        VLTramaEnvio = "0314006          "
        VLTramaEnvio = VLTramaEnvio + VLFecHora 'Fecha y hora real aaaammddhhmmsscc
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2) 'Fecha contable
        VLTramaEnvio = VLTramaEnvio + "004001P00"
        VLTramaEnvio = VLTramaEnvio + String(8 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn) 'SSN
        VLTramaEnvio = VLTramaEnvio + "N"
        If VLRevTimeOut Then
            If Len(Trim$(VLSsnRevTimeOut)) >= 8 Then
                VLSSNREV = Mid$(Trim$(VLSsnRevTimeOut), 1, 8)
            Else
                VLSSNREV = String(8 - Len(Trim$(VLSsnRevTimeOut)), "0") + Trim$(VLSsnRevTimeOut)
            End If
        Else
            If Len(Trim$(NumSSN.Text)) >= 8 Then
                VLSSNREV = Mid$(Trim$(NumSSN.Text), 1, 8)
            Else
                VLSSNREV = String(8 - Len(Trim$(NumSSN.Text)), "0") + Trim$(NumSSN.Text)
            End If
        End If
        VLTramaEnvio = VLTramaEnvio + VLSSNREV 'SSN Original
        VLTramaEnvio = VLTramaEnvio + String(3 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) 'Oficina
        VLTramaEnvio = VLTramaEnvio + Trim$(VGUsuario) + String(10 - Len(Trim$(VGUsuario)), " ") 'Usuario
        VLTramaEnvio = VLTramaEnvio + String(8 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)  'MCN
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecHora, 7, 2) + "-"
        Select Case Mid$(VLFecHora, 5, 2)
        Case "01"
            VLTramaEnvio = VLTramaEnvio + "JAN"
        Case "02"
            VLTramaEnvio = VLTramaEnvio + "FEB"
        Case "03"
            VLTramaEnvio = VLTramaEnvio + "MAR"
        Case "04"
            VLTramaEnvio = VLTramaEnvio + "APR"
        Case "05"
            VLTramaEnvio = VLTramaEnvio + "MAY"
        Case "06"
            VLTramaEnvio = VLTramaEnvio + "JUN"
        Case "07"
            VLTramaEnvio = VLTramaEnvio + "JUL"
        Case "08"
            VLTramaEnvio = VLTramaEnvio + "AUG"
        Case "09"
            VLTramaEnvio = VLTramaEnvio + "SEP"
        Case "10"
            VLTramaEnvio = VLTramaEnvio + "OCT"
        Case "11"
            VLTramaEnvio = VLTramaEnvio + "NOV"
        Case "12"
            VLTramaEnvio = VLTramaEnvio + "DEC"
        End Select
        VLTramaEnvio = VLTramaEnvio + "-" + Mid$(VLFecHora, 3, 2)
        VLTramaEnvio = VLTramaEnvio + "                           070000000000000000"
        VLValorPagar = Trim$(str$(CDbl(Valor.Text) * 100))
        VLTramaEnvio = VLTramaEnvio + String(15 - Len(Trim$(VLValorPagar)), "0") + VLValorPagar
        VLTramaEnvio = VLTramaEnvio + "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000   VENTANILLA  "
        VLTramaEnvio = VLTramaEnvio + String(4 - Len(Trim$(Tipo.Text)), "0") + Trim$(Tipo.Text) 'Impuesto
        VLTramaEnvio = VLTramaEnvio + "TRA_REV"
        VLTramaEnvio = VLTramaEnvio + Trim$(Cedula1.Text) + String(15 - Len(Trim$(Cedula1.Text)), " ") 'RUC
        VLTramaEnvio = VLTramaEnvio + Trim$(CEP.ClipText) + String(20 - Len(Trim$(CEP.ClipText)), " ") 'CEP
        VLTramaEnvio = VLTramaEnvio + " "
        VLTramaEnvio = VLTramaEnvio + Trim$(VLProvincia) + String(3 - Len(Trim$(VLProvincia)), " ")  'Provincia
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
            If Mid$(VLTramaRetorno, 1, 4) = "7806" Then
                VLRevTimeOut = True
            End If
            Me.Enabled = True
            Exit Function
        End If
        VLCodRetornoInd = Mid$(VLTramaRetorno, 53, 2)
        If VLCodRetornoInd = "01" Then
            MsgBox "Tiempo de Espera Agotado. Problema de comunicación del SRI", vbCritical, "Aviso"
            Exit Function
        End If
        VLCodRetorno = val(Mid$(VLTramaRetorno, 144, 2))
        If VLCodRetorno > 1 Then
            PMInicioTransaccion
            PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "cl_errores_sri", "", ""
            PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR&, "V", "", ""
            PMPasoValoresATX VGSqlConn&, "@i_codigo", 0, SQLCHAR&, Trim$(str$(VLCodRetorno)), "", ""
            If FMTransmitirRPCATX(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "", "N", "S", "I", "0", "N", "N") Then
                PMMapeaObjetoATX VGSqlConn&, Nombre
                PMChequeaATX VGSqlConn&
                PMFinTransaccion
            Else
                MsgBox "MENSAJE DE ERROR DEL SRI NO CATALOGADO EN EL BANCO", vbCritical, "ERROR"
                PMChequeaATX VGSqlConn&
                PMFinTransaccion
            End If
            Me.Enabled = True
            Exit Function
        End If
        If VLCodRetorno < 0 Then
            MsgBox Trim$(Mid$(VLTramaRetorno, 257, 255)), vbExclamation, "Aviso"
            Me.Enabled = True
            Exit Function
        End If
    End Select
    
    Me.Enabled = True
    
    FLTramaSwitch = True
    Exit Function
Etiqueta_Error:
    Screen.MousePointer = 0
    Me.Enabled = True
    MsgBox Err.Description, vbCritical, "Error"
End Function

Public Function FLConsOFP() As Boolean

    If Not FLSecuencias() Then
        Me.Enabled = True
        Exit Function
    End If
        
    PMInicioTransaccion
   ' Total.Text = "0"
'    TotPago.Text = "0"
   

    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, "18006", "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_pcodcanalpago", 0, SQLVARCHAR, "VENTANILLA", "Pcodcanalpago", ""
    'PMPasoValoresATX VGSqlConn, "@i_pnumruc", 0, SQLVARCHAR, Cedula1.Text, "Pnumruc", ""      pricaura Ref-04 20191223
    PMPasoValoresATX VGSqlConn, "@i_pnumserial", 0, SQLVARCHAR, CEP.Text, "Pnumserial", ""
    'PMPasoValoresATX VGSqlConn, "@i_tipo", 0, SQLVARCHAR, Tipo.Text, "Pcodimp", ""      pricaura Ref-04 20191223
    PMPasoValoresATX VGSqlConn, "@i_pprovagencia", 0, SQLVARCHAR, VLProvincia, "Pprovagencia", ""
    'PMPasoValoresATX VGSqlConn, "@i_pdebbanco", 0, SQLFLT8&, "0", "Pdebbanco", ""
    'PMPasoValoresATX VGSqlConn, "@i_pfechpago", 0, SQLVARCHAR, VLFechaPago, "Pfechpago", ""
    
    'TRANSMITIR DE LA CONSULTA   lfcm 22-marzo-2007
    If FMTransmitirRPCATX(VGSqlConn, VLParametroServer, "cob_procesador", "sp_cons_ofp_sri", True, "Transaccion Ok", "S", "N", "N", "77", "S", "S") = True Then 'pricaura   Ref-04 20191223
    'If FMTransmitirRPCATX(VGSqlConn, "PSSRV1", "cob_procesador", "sp_cons_ofp_sri", True, "Transaccion Ok", "S", "N", "N", "77", "S", "S") = True Then
        ReDim psRetorno(1, 22)
        FMMapeaMatriz VGSqlConn, psRetorno
        
        'AN_CODIGO_LOG_MONITOR 5
        'AN_COD_OPE_COD_MEN 6
        'AN_DEBITO_BANCO 7
        'AN_NUMERO_CUOTA 8
        'AN_TOTAL_PAGO 9
        'AN_VALOR_COMPENSACIONES 10
        'AN_VALOR_IMPUESTO 11
        'AN_VALOR_INTERES 12
        'AN_VALOR_MULTAS 13
        'AS_RAZON_SOCIAL 14
        
        
        
        'lfcm 08-mayo-2007
        ' Descripcion
        ' Psretorno(0,0)  name
        ' Psretorno(0,1)  AD_FECHA_PAGO
        ' Psretorno(0,2)  AD_FECHA_RECEPCION_CEP
        ' Psretorno(0,3)  AD_PERIODO_FISCAL_DESDE
        ' Psretorno(0,4)  AD_PERIODO_FISCAL_HASTA
        ' Psretorno(0,5)  AN_CODIGO_LOG_MONITOR
        ' Psretorno(0,6)  AN_COD_OPE_COD_MEN
        ' Psretorno(0,7)  AN_DEBITO_BANCO
        ' Psretorno(0,8)  AN_NUMERO_CUOTA
        ' Psretorno(0,9)  AN_TOTAL_PAGO
        ' Psretorno(0,10) AN_VALOR_COMPENSACIONES
        ' Psretorno(0,11) AN_VALOR_IMPUESTO
        ' Psretorno(0,12) AN_VALOR_INTERES
        ' Psretorno(0,13) AN_VALOR_MULTAS
        ' Psretorno(0,14) AN_VALOR_NOTAS_CREDITO
        ' Psretorno(0,15) AS_CLASE_CONTRIBUYENTES
        ' Psretorno(0,16) AS_ORIGINAL_SUSTITUTIVA
        ' Psretorno(0,17) AS_RAZON_SOCIAL
        ' Psretorno(0,18)
        ' Psretorno(0,19)
        ' Psretorno(0,20)
        
        '--Valores
        ' Psretorno(1,0)  value
        ' Psretorno(1,1)  0
        ' Psretorno(1,2)  08-MAY-07
        ' Psretorno(1,3)  01-FEB-07
        ' Psretorno(1,4)  28-FEB-07
        ' Psretorno(1,5)  708052007310039
        ' Psretorno(1,6)  1
        ' Psretorno(1,7)  85400
        ' Psretorno(1,8)  0
        ' Psretorno(1,9)  185400
        ' Psretorno(1,10) 0
        ' Psretorno(1,11) 185400
        ' Psretorno(1,12) 0
        ' Psretorno(1,13) 0
        ' Psretorno(1,14) 100000
        ' Psretorno(1,15) OTR
        ' Psretorno(1,16) O
        ' Psretorno(1,17) RAZON SOCIAL 238242
        ' Psretorno(1,18)
        ' Psretorno(1,19)
        ' Psretorno(1,20)
        
        'Desglosa la trama y muestra el resultado
        RazonSocial.Text = psRetorno(1, 17)
        ValorComp.Text = CDbl(psRetorno(1, 10)) / 100
        ValorImpto.Text = CDbl(psRetorno(1, 11)) / 100
        ValorInteres.Text = CDbl(psRetorno(1, 12)) / 100
        ValorMulta.Text = CDbl(psRetorno(1, 13)) / 100
        ValorSubtotal.Text = CDbl(psRetorno(1, 9)) / 100
        ValorNC.Text = CDbl(psRetorno(1, 14)) / 100
         'ref vmirant , se agrega porque si previo a esta pantalla se abre mnemónico 143 por la empresa 120 se quedaba guardado
         'la variable  SGEmpresa donde la pantalla de comisión tiene una validación x esa empresa que hacía que al cerrarse
         ' se abriera el mnemónico 143 sobre el 77
         SGEmpresa = "SRICEP" 'ref vmirant , se agrega 'ref03
        'Este es el valor que se muestra en (Valor a pagar sri:)
        'Inicialmente se toma el dato del psretorno(1,9) que tiene el valor total
        'se hace el cambio para que considere el valor del psretorno(1,7) que contiene el valor
        'que debe cobrar el banco
        'ValorSRI.Text = CDbl(psRetorno(1, 9)) / 100
        ValorSRI.Text = CDbl(psRetorno(1, 7)) / 100 'SMERINO
        Cedula1.Text = psRetorno(1, 18) 'pricaura Ref-04 20191223
        Tipo.Text = psRetorno(1, 19)    'pricaura Ref-04 20191223
        VLTipoOK = True    'pricaura Ref-04 20191223
        
        'Variables solo Pago
        Stk.Text = psRetorno(1, 5)
        NumSSN.Text = Trim$(VLSsn)
        Frame1.Enabled = True
        Me.Enabled = True
        FLConsOFP = True
        Cedula1.Enabled = False
        CEP.Enabled = False
        Tipo.Enabled = False
        If efe.Enabled Then
            efe.SetFocus
        End If
        
    Else
        CEP.SetFocus      'pricaura Ref-04 20191223
        CEP.Clear      'pricaura Ref-04 20191223
        'MsgBox "MENSAJE DE ERROR DEL SRI NO CATALOGADO EN EL BANCO", vbCritical, "ERROR"
        PMChequeaATX VGSqlConn&
        PMFinTransaccion
        FLConsOFP = False
        Exit Function
    End If
    
    PMChequeaATX VGSqlConn
    If FMRetStatusATX(VGSqlConn) <> 0 Then
        FLConsOFP = False
    End If
    FLConsOFP = True
    PMFinTransaccion
End Function




'pricaura Inicio REF_04 20191223
Private Sub Consulta_Parametro()
'Consulta parametro para utilizar el servicio del Bus O Csp
Dim VLarregloParametro(30) As String
PMInicioTransaccion
PMPasoValoresATX VGSqlConn&, "@t_trn", 0, SQLINT2, 1579, "", ""
PMPasoValoresATX VGSqlConn&, "@i_operacion", 0, SQLVARCHAR, "Q", "", ""
PMPasoValoresATX VGSqlConn&, "@i_nemonico", 0, SQLVARCHAR, "SRVOSB", "", ""
PMPasoValoresATX VGSqlConn&, "@i_producto", 0, SQLVARCHAR, "CTE", "", ""
If FMTransmitirRPCATX(VGSqlConn&, "", "cobis", "sp_parametro", True, " Consulta de motivos ", "N", "N", "S", "77", "N", "N") Then
   VTR1% = FMMapeaArregloATX(VGSqlConn, VLarregloParametro())
   VLParametroServer = LTrim(RTrim(Trim(VLarregloParametro(4))))
Else
   VLParametroServer = ""
End If
PMChequeaATX VGSqlConn&
PMFinTransaccion
End Sub
'pricaura Fin REF_04 20191223


