VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "GRID32.OCX"
Object = "{0F1F1508-C40A-101B-AD04-00AA00575482}#1.0#0"; "mhrinp32.ocx"
Object = "{9AED8C43-3F39-11D1-8BB4-0000C039C248}#2.0#0"; "txtin.ocx"
Object = "{DECFDD03-1E4B-11D1-B65E-0000C039C248}#5.0#0"; "mskedit.ocx"
Object = "{00025600-0000-0000-C000-000000000046}#5.2#0"; "crystl32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Begin VB.Form FCC19 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "MUNICIPIOS - 19"
   ClientHeight    =   6120
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4800
   KeyPreview      =   -1  'True
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   6120
   ScaleWidth      =   4800
   Begin VB.TextBox txt_tmp_mim 
      Enabled         =   0   'False
      Height          =   285
      Left            =   4980
      TabIndex        =   82
      Top             =   0
      Width           =   1320
   End
   Begin MSGrid.Grid grdDetalle 
      Height          =   2775
      Left            =   0
      TabIndex        =   56
      Top             =   6000
      Width           =   2025
      _Version        =   65536
      _ExtentX        =   3572
      _ExtentY        =   4895
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
   Begin VB.TextBox txtTemporal 
      Height          =   495
      Left            =   1800
      TabIndex        =   74
      Top             =   6000
      Visible         =   0   'False
      Width           =   1215
   End
   Begin MSGrid.Grid grdBloque 
      Height          =   3375
      Left            =   120
      TabIndex        =   72
      Top             =   6000
      Visible         =   0   'False
      Width           =   1575
      _Version        =   65536
      _ExtentX        =   2778
      _ExtentY        =   5953
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
      Rows            =   13
      Cols            =   6
   End
   Begin VB.TextBox txtMensaje 
      Height          =   495
      Left            =   1800
      TabIndex        =   71
      Top             =   6000
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.TextBox txtHorario 
      Height          =   285
      Left            =   0
      TabIndex        =   68
      Top             =   6000
      Visible         =   0   'False
      Width           =   615
   End
   Begin VB.TextBox Prioridad 
      Height          =   375
      Left            =   1560
      TabIndex        =   65
      Top             =   6000
      Visible         =   0   'False
      Width           =   1335
   End
   Begin VB.TextBox ValInteres 
      Height          =   375
      Left            =   3360
      TabIndex        =   64
      Top             =   6000
      Visible         =   0   'False
      Width           =   1335
   End
   Begin VB.TextBox ValImpto 
      Height          =   375
      Left            =   2280
      TabIndex        =   63
      Top             =   6000
      Visible         =   0   'False
      Width           =   1335
   End
   Begin VB.TextBox DescripImpto 
      Height          =   375
      Left            =   0
      TabIndex        =   62
      Top             =   6000
      Visible         =   0   'False
      Width           =   1335
   End
   Begin VB.TextBox Direccion 
      Height          =   375
      Left            =   840
      TabIndex        =   61
      Top             =   6000
      Visible         =   0   'False
      Width           =   1335
   End
   Begin VB.Frame Frame2 
      ForeColor       =   &H8000000D&
      Height          =   1700
      Left            =   120
      TabIndex        =   49
      Top             =   120
      Width           =   4455
      Begin VB.TextBox CEP 
         BackColor       =   &H00FFFFFF&
         ForeColor       =   &H80000012&
         Height          =   285
         Left            =   2520
         MaxLength       =   10
         TabIndex        =   84
         ToolTipText     =   "Código CEP"
         Top             =   555
         Visible         =   0   'False
         Width           =   1455
      End
      Begin MSMask.MaskEdBox claveCatastral 
         Height          =   255
         Left            =   1800
         TabIndex        =   81
         Top             =   840
         Visible         =   0   'False
         Width           =   1575
         _ExtentX        =   2778
         _ExtentY        =   450
         _Version        =   393216
         MaxLength       =   18
         Mask            =   "  -  -  -  -  -   "
         PromptChar      =   "_"
      End
      Begin VB.TextBox txtCatasSamb 
         Height          =   285
         Left            =   1800
         MaxLength       =   60
         TabIndex        =   80
         Top             =   840
         Visible         =   0   'False
         Width           =   2535
      End
      Begin VB.TextBox txtcat1 
         Appearance      =   0  'Flat
         BackColor       =   &H80000004&
         Height          =   285
         Left            =   1640
         TabIndex        =   73
         Top             =   880
         Visible         =   0   'False
         Width           =   375
      End
      Begin MhinrelLib.MhRealInput MhRealInput4 
         Height          =   285
         Left            =   2025
         TabIndex        =   50
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
      Begin TxtinLib.TextValid tipo 
         Height          =   285
         Left            =   1800
         TabIndex        =   3
         ToolTipText     =   "Tipo de Impuesto (F5 Ayuda)"
         Top             =   880
         Width           =   450
         _Version        =   65536
         _ExtentX        =   794
         _ExtentY        =   503
         _StockProps     =   253
         BorderStyle     =   1
         Range           =   ""
         MaxLength       =   4
         Character       =   2
         Type            =   4
         HelpLine        =   "Ingrese Tipo de impuesto,  F5 Ayuda"
         Pendiente       =   ""
         Connection      =   -4908
         AsociatedLabelIndex=   0
         TableName       =   "sv_impto_mun"
         MinChar         =   0
         Error           =   0
      End
      Begin TxtinLib.TextValid municipio 
         Height          =   285
         Left            =   1800
         TabIndex        =   0
         ToolTipText     =   "Tipo de Impuesto (F5 Ayuda)"
         Top             =   240
         Width           =   450
         _Version        =   65536
         _ExtentX        =   794
         _ExtentY        =   503
         _StockProps     =   253
         BorderStyle     =   1
         Range           =   ""
         MaxLength       =   4
         Character       =   2
         Type            =   1
         HelpLine        =   "Ingrese Tipo de impuesto,  F5 Ayuda"
         Pendiente       =   ""
         Connection      =   -4908
         AsociatedLabelIndex=   0
         TableName       =   "sv_municipios"
         MinChar         =   0
         Error           =   0
      End
      Begin MskeditLib.MaskInBox cat1 
         Height          =   285
         Left            =   1640
         TabIndex        =   6
         Tag             =   "Chq"
         ToolTipText     =   "Cédula o Ruc del Contribuyente"
         Top             =   880
         Visible         =   0   'False
         Width           =   375
         _Version        =   262144
         _ExtentX        =   661
         _ExtentY        =   503
         _StockProps     =   253
         Text            =   "___"
         BorderStyle     =   1
         Enabled         =   -1  'True
         Decimals        =   0
         Separator       =   -1  'True
         MaskType        =   1
         HideSelection   =   0   'False
         MaxLength       =   0
         AutoTab         =   -1  'True
         DateString      =   "___"
         FormattedText   =   ""
         Mask            =   "###"
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
      Begin MskeditLib.MaskInBox cat2 
         Height          =   285
         Left            =   2040
         TabIndex        =   7
         Tag             =   "Chq"
         ToolTipText     =   "Cédula o Ruc del Contribuyente"
         Top             =   880
         Visible         =   0   'False
         Width           =   450
         _Version        =   262144
         _ExtentX        =   794
         _ExtentY        =   503
         _StockProps     =   253
         Text            =   "____"
         BorderStyle     =   1
         Enabled         =   -1  'True
         Decimals        =   0
         Separator       =   -1  'True
         MaskType        =   1
         HideSelection   =   0   'False
         MaxLength       =   0
         AutoTab         =   -1  'True
         DateString      =   "____"
         FormattedText   =   ""
         Mask            =   "####"
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
      Begin MskeditLib.MaskInBox cat3 
         Height          =   285
         Left            =   2520
         TabIndex        =   8
         Tag             =   "Chq"
         ToolTipText     =   "Cédula o Ruc del Contribuyente"
         Top             =   880
         Visible         =   0   'False
         Width           =   375
         _Version        =   262144
         _ExtentX        =   661
         _ExtentY        =   503
         _StockProps     =   253
         Text            =   "___"
         BorderStyle     =   1
         Enabled         =   -1  'True
         Decimals        =   0
         Separator       =   -1  'True
         MaskType        =   1
         HideSelection   =   0   'False
         MaxLength       =   0
         AutoTab         =   -1  'True
         DateString      =   "___"
         FormattedText   =   ""
         Mask            =   "###"
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
      Begin MskeditLib.MaskInBox cat4 
         Height          =   285
         Left            =   2920
         TabIndex        =   9
         Tag             =   "Chq"
         ToolTipText     =   "Cédula o Ruc del Contribuyente"
         Top             =   880
         Visible         =   0   'False
         Width           =   450
         _Version        =   262144
         _ExtentX        =   794
         _ExtentY        =   503
         _StockProps     =   253
         Text            =   "____"
         BorderStyle     =   1
         Enabled         =   -1  'True
         Decimals        =   0
         Separator       =   -1  'True
         MaskType        =   1
         HideSelection   =   0   'False
         MaxLength       =   0
         AutoTab         =   -1  'True
         DateString      =   "____"
         FormattedText   =   ""
         Mask            =   "####"
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
      Begin MskeditLib.MaskInBox cat5 
         Height          =   285
         Left            =   3400
         TabIndex        =   10
         Tag             =   "Chq"
         ToolTipText     =   "Cédula o Ruc del Contribuyente"
         Top             =   880
         Visible         =   0   'False
         Width           =   450
         _Version        =   262144
         _ExtentX        =   794
         _ExtentY        =   503
         _StockProps     =   253
         Text            =   "____"
         BorderStyle     =   1
         Enabled         =   -1  'True
         Decimals        =   0
         Separator       =   -1  'True
         MaskType        =   1
         HideSelection   =   0   'False
         MaxLength       =   0
         AutoTab         =   -1  'True
         DateString      =   "____"
         FormattedText   =   ""
         Mask            =   "####"
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
      Begin MskeditLib.MaskInBox cat6 
         Height          =   285
         Left            =   3880
         TabIndex        =   11
         Tag             =   "Chq"
         ToolTipText     =   "Cédula o Ruc del Contribuyente"
         Top             =   880
         Visible         =   0   'False
         Width           =   450
         _Version        =   262144
         _ExtentX        =   794
         _ExtentY        =   503
         _StockProps     =   253
         Text            =   "____"
         BorderStyle     =   1
         Enabled         =   -1  'True
         Decimals        =   0
         Separator       =   -1  'True
         MaskType        =   1
         HideSelection   =   0   'False
         MaxLength       =   0
         AutoTab         =   -1  'True
         DateString      =   "____"
         FormattedText   =   ""
         Mask            =   "####"
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
      Begin MskeditLib.MaskInBox Cedula 
         Height          =   285
         Left            =   2880
         TabIndex        =   2
         Tag             =   "Chq"
         ToolTipText     =   "Cédula o Ruc del Contribuyente"
         Top             =   555
         Width           =   1455
         _Version        =   262144
         _ExtentX        =   2566
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
      Begin VB.TextBox txtLlaveMunicipal 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   2880
         MaxLength       =   15
         TabIndex        =   5
         ToolTipText     =   "Número de Operación/Documento"
         Top             =   555
         Visible         =   0   'False
         Width           =   1455
      End
      Begin TxtinLib.TextValid txtTipoConsulta 
         Height          =   285
         Left            =   1680
         TabIndex        =   85
         ToolTipText     =   "Tipo de Consulta (F5 Ayuda)"
         Top             =   1200
         Width           =   450
         _Version        =   65536
         _ExtentX        =   794
         _ExtentY        =   503
         _StockProps     =   253
         BorderStyle     =   1
         Range           =   ""
         MaxLength       =   4
         Character       =   2
         Type            =   3
         HelpLine        =   "Ingrese Tipo de Consulta,  F5 Ayuda"
         Pendiente       =   ""
         Connection      =   -4908
         AsociatedLabelIndex=   0
         TableName       =   "sv_impto_mungye"
         MinChar         =   0
         Error           =   0
      End
      Begin VB.Label lblTipoConsulta 
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
         Left            =   2160
         TabIndex        =   87
         Top             =   1200
         Width           =   2055
      End
      Begin VB.Label Label5 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "TIPO CONSULTA"
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
         TabIndex        =   86
         Top             =   1200
         Width           =   1500
      End
      Begin VB.Label Etiqueta1 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "MUNICIPIO"
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
         TabIndex        =   57
         Top             =   240
         Width           =   990
      End
      Begin VB.Label sal_municipio 
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
         TabIndex        =   1
         Top             =   240
         Width           =   2055
      End
      Begin VB.Label Etiqueta2 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "No.PREDIO/PATENTE/VARIOS"
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
         TabIndex        =   53
         Top             =   555
         Width           =   2745
      End
      Begin VB.Label Etiqueta3 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "TIPO IMPUESTO"
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
         TabIndex        =   52
         Top             =   880
         Width           =   1470
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
         Left            =   2280
         TabIndex        =   4
         Top             =   880
         Width           =   2055
      End
      Begin VB.Label Label6 
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
         TabIndex        =   51
         Top             =   5250
         Visible         =   0   'False
         Width           =   1260
      End
   End
   Begin VB.Frame Frame1 
      Enabled         =   0   'False
      ForeColor       =   &H8000000D&
      Height          =   4245
      Left            =   120
      TabIndex        =   34
      Top             =   1800
      Width           =   4455
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
         TabIndex        =   18
         ToolTipText     =   "Cantidad de Cheques"
         Top             =   1440
         Width           =   495
         _Version        =   65536
         _ExtentX        =   873
         _ExtentY        =   503
         _StockProps     =   77
         TintColor       =   16711935
         FillColor       =   -2147483645
         MinReal         =   0
         SpinChangeReal  =   0
         AutoHScroll     =   -1  'True
         CaretColor      =   -2147483642
         DecimalPlaces   =   0
         Separator       =   -1  'True
      End
      Begin VB.TextBox Nombre 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Enabled         =   0   'False
         Height          =   285
         Left            =   1440
         Locked          =   -1  'True
         TabIndex        =   22
         Top             =   2070
         Width           =   2865
      End
      Begin VB.ComboBox CboTipCta 
         Height          =   315
         Left            =   2010
         Style           =   2  'Dropdown List
         TabIndex        =   20
         Tag             =   "CboProd"
         Top             =   1740
         Width           =   855
      End
      Begin MhinrelLib.MhRealInput efe 
         Height          =   285
         Left            =   2010
         TabIndex        =   17
         ToolTipText     =   "Valor en Efectivo"
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
         TabIndex        =   19
         ToolTipText     =   "Valor en Cheques"
         Top             =   1440
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
      Begin MhinrelLib.MhRealInput mhNCReal 
         Height          =   285
         Left            =   2025
         TabIndex        =   27
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
         TabIndex        =   21
         Tag             =   "Cta"
         Top             =   1740
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
         TabIndex        =   23
         Top             =   2670
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
      Begin MhinrelLib.MhRealInput ValorMun 
         Height          =   285
         Left            =   2010
         TabIndex        =   26
         ToolTipText     =   "Valor Total del Impuesto"
         Top             =   3570
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
      Begin MhinrelLib.MhRealInput Comision 
         Height          =   285
         Left            =   2010
         TabIndex        =   25
         Top             =   3270
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
      Begin MhinrelLib.MhRealInput Tarjeta 
         Height          =   285
         Left            =   2010
         TabIndex        =   24
         Top             =   2970
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
      Begin MhinrelLib.MhRealInput Total 
         Height          =   285
         Left            =   2010
         TabIndex        =   70
         ToolTipText     =   "Valor Total del Impuesto"
         Top             =   3870
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
      Begin Crystal.CrystalReport rptBAD 
         Left            =   1215
         Top             =   2745
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
         Left            =   990
         TabIndex        =   88
         Top             =   3150
         Visible         =   0   'False
         Width           =   900
      End
      Begin VB.Label descripcion 
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
         Left            =   2010
         TabIndex        =   83
         Top             =   540
         Visible         =   0   'False
         Width           =   1095
      End
      Begin VB.Label Label3 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
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
         TabIndex        =   75
         Top             =   2400
         Width           =   750
      End
      Begin VB.Label Label1 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "TOTAL A PAGAR"
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
         TabIndex        =   69
         Top             =   3870
         Width           =   1485
      End
      Begin VB.Label Etiqueta14 
         AutoSize        =   -1  'True
         Caption         =   "Tarjeta"
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
         TabIndex        =   67
         Top             =   2970
         Width           =   615
      End
      Begin VB.Label Etiqueta8 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Semestre/Dividendo"
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
         Left            =   2040
         TabIndex        =   66
         Top             =   840
         Width           =   1740
      End
      Begin VB.Label Semestre 
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
         Left            =   3780
         TabIndex        =   16
         Top             =   840
         Width           =   525
      End
      Begin VB.Label Agno 
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
         Left            =   1440
         TabIndex        =   15
         Top             =   840
         Width           =   525
      End
      Begin VB.Label Etiqueta7 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Año"
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
         TabIndex        =   60
         Top             =   840
         Width           =   345
      End
      Begin VB.Label Impto 
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
         Left            =   3780
         TabIndex        =   14
         Top             =   540
         Width           =   525
      End
      Begin VB.Label Etiqueta6 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Impto"
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
         Left            =   3240
         TabIndex        =   59
         Top             =   540
         Width           =   480
      End
      Begin VB.Label Predio 
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
         Left            =   2010
         TabIndex        =   13
         Top             =   540
         Width           =   1095
      End
      Begin VB.Label Etiqueta5 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Predio / patente"
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
         TabIndex        =   58
         Top             =   540
         Width           =   1410
      End
      Begin VB.Label Etiqueta16 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Valor municipio"
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
         TabIndex        =   55
         Top             =   3570
         Width           =   1305
      End
      Begin VB.Label Etiqueta4 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Nombre contribuyente"
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
         TabIndex        =   54
         Top             =   240
         Width           =   1875
      End
      Begin VB.Label Contribuyente 
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
         Left            =   2010
         TabIndex        =   12
         Top             =   240
         Width           =   2295
      End
      Begin VB.Label Etiqueta15 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Comisión"
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
         TabIndex        =   48
         Top             =   3270
         Width           =   765
      End
      Begin VB.Label Etiqueta12 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Nombre cuenta"
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
         Top             =   2070
         Width           =   1305
      End
      Begin VB.Label Etiqueta13 
         AutoSize        =   -1  'True
         Caption         =   "Debito"
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
         TabIndex        =   44
         Top             =   2670
         Width           =   570
      End
      Begin VB.Label Etiqueta11 
         AutoSize        =   -1  'True
         Caption         =   "ND a cta"
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
         TabIndex        =   43
         Top             =   1740
         Width           =   780
      End
      Begin VB.Label Label2 
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
         TabIndex        =   39
         Top             =   5250
         Visible         =   0   'False
         Width           =   1260
      End
      Begin VB.Label Etiqueta9 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         Caption         =   "Efectivo"
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
         TabIndex        =   36
         Top             =   1140
         Width           =   720
      End
      Begin VB.Label Etiqueta10 
         Caption         =   "Cheques"
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
         TabIndex        =   35
         Top             =   1440
         Width           =   1815
      End
      Begin VB.Label lblMoneda 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   285
         Left            =   2010
         TabIndex        =   76
         Top             =   2370
         Width           =   2295
      End
   End
   Begin MhinrelLib.MhRealInput prop 
      Height          =   285
      Left            =   0
      TabIndex        =   28
      TabStop         =   0   'False
      Top             =   6960
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
      Left            =   3840
      TabIndex        =   29
      TabStop         =   0   'False
      Top             =   7200
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
      Left            =   0
      TabIndex        =   30
      TabStop         =   0   'False
      Top             =   7560
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
      Left            =   3840
      TabIndex        =   37
      TabStop         =   0   'False
      Top             =   6840
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
      Left            =   3360
      TabIndex        =   38
      TabStop         =   0   'False
      ToolTipText     =   "Valor Total del Pago"
      Top             =   6825
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
      Left            =   120
      TabIndex        =   46
      TabStop         =   0   'False
      Top             =   6825
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
      Left            =   0
      TabIndex        =   47
      Top             =   7080
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
   Begin VB.TextBox txtTitulo 
      Height          =   300
      Left            =   0
      TabIndex        =   77
      Top             =   5000
      Visible         =   0   'False
      Width           =   500
   End
   Begin VB.TextBox txtLlave 
      Height          =   375
      Left            =   3480
      TabIndex        =   78
      Top             =   0
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.TextBox txtPapeletaSamb 
      Height          =   285
      Left            =   0
      TabIndex        =   79
      Top             =   0
      Visible         =   0   'False
      Width           =   1575
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
      Left            =   2925
      TabIndex        =   42
      Top             =   7200
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
      Left            =   1800
      TabIndex        =   41
      Top             =   7200
      Width           =   855
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
      Left            =   2295
      TabIndex        =   40
      Top             =   6960
      Width           =   855
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
      Left            =   4680
      TabIndex        =   31
      Top             =   8280
      Visible         =   0   'False
      Width           =   1080
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
      Left            =   6600
      TabIndex        =   32
      Top             =   8280
      Visible         =   0   'False
      Width           =   870
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
      Left            =   6720
      TabIndex        =   33
      Top             =   6600
      Visible         =   0   'False
      Width           =   1290
   End
End
Attribute VB_Name = "FCC19"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'Luis F. Chacha 13-agosto-2009 Obtener la fecha de la base, no de la función date,
'debido a que PC's que recaudan SOAT tienen otra configuración regional y esto ocasiona
'que la trx se envie con otra fecha contable y se grabe con una fecha diferente a la del
'dia en el Municipio.
'********************************************************************************'
'*              MODIFICACIONES                                                  *'
'* REF  FECHA       AUTOR          DESCRIPCION                                  *'
'*  02  19/Sep/2017 Vanessa Miranda FACOFF-AP-SGC00029747-SGC00029748 Agregar   *'
'*      Clave de Acceso Facturación Electrónica Offline                         *'
'*  03  01/Mar/2018 Danny Olaya SGC00030409 Facturacion OFFLINE - Cobro de Comision Deb Cta *'
'*  04  21/JUN/2019 Pablo Ricaurte  Comision 0 cuando pago con TC    *'
'*  05  25/NOV/2022 Luis Cepeda F  RECMPS-1892 omitir oficina de entrega para municipio de Daule    *'
'*  06  28/NOV/2022 Luis Cepeda F  RECMPS-1896 CAMBIO DE MENSAJE EN COMPROBANTE DESDE ATX - MUNICIPIO DE DAULE    *'
'********************************************************************************'

Dim VL_Prioridad As Integer
Dim VLCambio As Integer
Dim VTNombreClte As String
Dim VTNombreOfic As String
Dim VTTipoCta As String
Dim VTCta As String
Dim VTEfeCob As String
Dim VTCupoArancel As Long
Dim VTCupoMin As Long
Dim VTClte As Long
Dim VTDiasGracia As Integer
Dim VTOficial As Long
Dim VLTotEfe As Long
Dim activa As Boolean
Dim VLCta As String
Dim VLTrn As String
Dim VLfirma As Boolean
Dim VLTipoOK As Boolean
Dim VLautoriSri As String
Dim VLFecvenSRI As String
Dim VLSerie_Secuencia As String
Dim VLFlagFoco As Boolean
Dim VLFlagUnico As Boolean
Dim VLHorario As String
'-->hy-30-ene-2006
Dim VLEfe_com As Currency
Dim VLChq_com As Currency
Dim VLDeb_com As Currency
Dim VLTotCom As Currency
Dim VLCta_com As String
Dim VLTipCta_com As String
Dim VLSsn As String
Dim VLSsnRevTimeOut As String
Dim VLFecHora As String
Dim VLFecContable As String
Dim VLFecContable_aaaammdd As String 'GAMC - 12ENE10
Dim VLContribuyente As String
Dim VLTopeMax As Integer
Dim VLNombreCliente As String
Dim VLNumAutorizacion As String
Dim VLFlagSumadora As Boolean
Dim VLTipoEjecucionTemporal As Integer
Dim VLFlagRevSP As Boolean
Dim VLRevTimeOut As Boolean
Dim VLTotalTrama As String
Dim VLHoraReversar As String
Dim VLSSnCorreccion As String
Dim VLFechaEfe As String
Dim VLReversarSoloSP As Boolean
Dim VLTsnTemporal As Integer
'<--hy-30-ene-2006
Dim VLMoneda As Integer
Dim VLDescMonCta As String
'-->hy-14-agosto-2006
Dim VLIdentificacion As String
Dim VLFechaEmision As String
Dim VLAvaluoComercial As String
Dim VLExoneracion As String
Dim VLDireccion As String
Dim VLNoCasa As String
Dim VLDatoOriginal As String
Dim VLSecuencialOriginal As String
Dim vlclavecatastral As String
Dim VLDescripcionRubro1 As String
Dim VLValorRubro1 As String
Dim VLDescripcionRubro2 As String
Dim VLValorRubro2 As String
Dim VLDescripcionRubro3 As String
Dim VLValorRubro3 As String
Dim VLDescripcionRubro4 As String
Dim VLValorRubro4 As String
Dim VLDescripcionRubro5 As String
Dim VLValorRubro5 As String
Dim VLDescripcionRubro6 As String
Dim VLValorRubro6 As String
Dim VLDescripcionRubro7 As String
Dim VLValorRubro7 As String
Dim VLDescripcionRubro8 As String
Dim VLValorRubro8 As String
Dim VLDescripcionRubro9 As String
Dim VLValorRubro9 As String
Dim VLDescripcionRubro10 As String
Dim VLValorRubro10 As String
Dim VLValorInteres As String
Dim VLValorRecargo As String
Dim VLValorCostas As String
Dim VLValorDescuentos As String
Dim VLValorRubros As String
Dim VLValorTotalPagar As String
Dim VLIdenReverso As String
Dim VLNumeroAutorizacion As String
Dim VLConcepto As String
'<--hy-14-agosto-2006
'-->hy-22-febrero-2007
'Dim vtmatrizcps(2, 33) As String
Dim vtmatrizcps(2, 52) As String  'smerino cep
Dim VLValoresPago1 As String
Dim VLValoresPago2 As String
Dim VLSecuencialAdqMunCue As String
Dim VLFechaMunCue As String
Dim VLHoraMunCue As String
Dim VLAutorizacionMunCue As String
Dim VLMunCue_Emision As String
Dim VLMunCue_Exoneracion As String
Dim VLMunCue_Descuentos As String
Dim VLMunCue_Recargos As String
Dim VLMunCue_Intereses As String
Dim VLMunCue_Total As String
Dim VLFlagUnicoMunCuenca As Boolean
Public VLItemSeleccionado As String
'-->hy-22-febrero-2007
'-->hy-05-noviembre-2007
Public VLGridImpuestos As String
Public VLGridDescuentos As String
Public VLGridFecVen As String
Public VLRemoverFila As Integer
Dim VLNombreImpuesto As String
Dim VLMuniSamb(10) As String 'GAMC - 24/02/2008
Public VLOficinaRetiro As String 'GAMC - 27/03/2008
Dim VLCodigoCUIC As String 'GAMC - 21ENE2010

'-->lfcm 16-junio-2009 Mi Lote
Dim VLMLSecBr As String
Dim VLMLContribuyente As String
Dim VLMLAnioConvenio As String
Dim VLMLNoConvenio As String
Dim VLMLValoresPagar As String
Dim VLMLNoCuota As String
Dim VLMLPeriodoVigencia As String
Dim VLPasoFecha As String
Dim VLPasoHora As String
Dim VLFechaRegistro As String
Dim VLValorAPagar As String
Dim VLFlagUnicoMiLote As Boolean
'--<lfcm 16-junio-2009 Mi Lote
Dim psRetorno() As String           'lfcm 27-enero-2009
Dim psretornomimg() As String       'lfcm 06-marzo-2009
Dim VGSecBanredMG As Long           'lfcm 09-febrero-2009
Dim VLPagosAnio As String           'lfcm 09-febrero-2009
Dim VLPagosValor As Currency        'lfcm 09-febrero-2009
Dim VLFlagUnicoMunGye As Boolean        'lfcm 17-febrero-2009
Dim VLFlagUnicoMunQto As Boolean    'migracion csp
Dim VLFlagUnicoMunMyC As Boolean    'nchavezb 03/14/2011
Dim VGSecBanredMQ As Long           'migracion csp
Dim VLArregloPago1 As String        'migracion csp
Dim VLArregloPago2 As String        'migracion csp
Dim VLArregloRef As String 'ame 07/08/2010
Public VLRubro As String 'ame 07/08/2010
Dim VLNombre_com As String 'ame 07/20/2010
Dim VLImprCompComi As String 'GAMC - 02/08/2010
'MUNICIPIO GUAYAQUIL MERCADOS Y CREDENCIALES
'Dim VLIdenDeuda As Integer 'nchavezb msilvag Migracion WebService
Dim VLPProducto As String 'nchavezb
Dim VLArregloMunCre As String 'nchavezb
Dim VLMercado As String
Dim VLSolicitud As String
Dim VLCodSolicitud As String
Dim VLFechaVigencia As String
Dim VLAutorizacion As String
Dim VLFecinivig As String       'sme 06/08/2011
Dim VLFecfinvig As String       'sme 06/08/2011
Dim VGFechaProceso2 As String 'sme 09/20/2011
Dim VLcodifi As String    'ame 09/07/2012
Dim VLiva As Currency 'smerino iva
Dim VlbaseImp As Currency 'smerino iva
'Migracion SOA msilvag
Dim vl_servidor_BUS As String
Dim VLMLValoresPagar1 As String
Dim VLMLValoresPagar2 As String
Dim vl_base As String
Dim vlServidor As String
Dim vtmatrizcps2(30, 30) As String
'Migracion SOA msilvag
Dim VLAutorizacionCep As String 'smerino
Dim VLCodPredial As String 'smerino
Dim VLTipoServicio As String 'smerino
Dim VLValorMiLote As Integer 'msilvag

Dim VLIdenDeuda As String 'msilvag Migracion WebService
Dim VLObservacion1 As String
Dim VLObservacion2 As String
Dim VLObservacion3 As String
'msilvag Migracion Web Service Municipio
Dim VLCedulaMig As String
Dim VLCedMigMer As String
Dim VLMercadoReverso As String
Dim VLclaCatastralReverso As String
Dim VLMercadosDatos As String
Dim VLCodMunicipio As Integer
'msilvag fin Migracion Web Service Municipio
Dim VLclave_acceso As String '--ref02 vmirandt

'pricaura REF_04 FIN 20190621
Private Function consultarParametroCte(Nemonico As String) As String
Dim VLarregloParametro(30) As String
PMInicioTransaccion
PMPasoValoresATX VGSqlConn&, "@t_trn", 0, SQLINT2, 1579, "", ""
PMPasoValoresATX VGSqlConn&, "@i_operacion", 0, SQLVARCHAR, "Q", "", ""
PMPasoValoresATX VGSqlConn&, "@i_nemonico", 0, SQLVARCHAR, Nemonico, "", ""
PMPasoValoresATX VGSqlConn&, "@i_producto", 0, SQLVARCHAR, "CTE", "", ""
If FMTransmitirRPCATX(VGSqlConn&, "", "cobis", "sp_parametro", True, " Consulta de motivos ", "N", "N", "S", "19", "N", "N") Then
   VTR1% = FMMapeaArregloATX(VGSqlConn, VLarregloParametro())
   consultarParametroCte = LTrim(RTrim(Trim(VLarregloParametro(4))))
Else
   consultarParametroCte = ""
End If
PMChequeaATX VGSqlConn&
PMFinTransaccion
End Function
'pricaura REF_04 FIN 20190621


Public Sub Muni_2319(Opcion As String)
    'GAMC - Emision inicial
    Select Case Opcion
    Case "1" 'Muestra campos para el Municipio de Samborondom
        Etiqueta2.Visible = False
        Etiqueta3.Caption = "Cod. Predial"
        Tipo.Visible = False
        Me.claveCatastral.Visible = False 'GAMC - 05/03/2008
        sal_tipo.Visible = False
        cat1.Visible = False
        cat2.Visible = False
        cat3.Visible = False
        cat4.Visible = False
        cat5.Visible = False
        cat6.Visible = False
        
        '-->lfcm 29-octubre-2008
        cat1.Top = 880
        cat2.Top = 880
        cat3.Top = 880
        cat4.Top = 880
        cat5.Top = 880
        cat6.Top = 880
        Etiqueta3.Top = 880
        '--<lfcm 29-octubre-2008
        
        Etiqueta5.Visible = False
        Etiqueta6.Visible = False
        Etiqueta8.Visible = False
        Semestre.Visible = False
        Predio.Visible = False
        Impto.Visible = False
        cedula.Visible = False
        
        Agno.Left = 2010
        Contribuyente.Height = 570
        txtLlaveMunicipal.Visible = False
        txtCatasSamb.Visible = True
        If VGTipoEjecucion% <> CGReverso% Then
            txtCatasSamb.SetFocus
        End If
    
        
    End Select
End Sub

Public Function Muni_2237(Opcion As String, Opcion2 As Integer) As String
    On Error GoTo error
    'GAMC - Emision inicial - 05/MAR/2008 - Municipio de Salinas
    Select Case Opcion
    Case "1" 'Muestra campos para el Municipio de Salinas
        If Opcion2 = 0 Then
            Me.claveCatastral.Mask = "##-##-##-##-##-###"
            Me.claveCatastral.Visible = True
            Me.claveCatastral.Width = 1575  'GAMC - 09/04/2008
            Etiqueta3.Visible = True
            Etiqueta3.Caption = "Clave Catastral"
            
            Etiqueta2.Visible = False
            Tipo.Visible = False
            sal_tipo.Visible = False
            cat1.Visible = False
            cat2.Visible = False
            cat3.Visible = False
            cat4.Visible = False
            cat5.Visible = False
            cat6.Visible = False
            
            '-->lfcm 29-octubre-2008
            cat1.Top = 880
            cat2.Top = 880
            cat3.Top = 880
            cat4.Top = 880
            cat5.Top = 880
            cat6.Top = 880
            Etiqueta3.Top = 880
            '--<lfcm 29-octubre-2008
            
            Tipo.Visible = False
            sal_tipo.Visible = False
            Etiqueta5.Visible = False
            Etiqueta6.Visible = False
            Etiqueta8.Visible = False
            Semestre.Visible = False
            Predio.Visible = False
            Impto.Visible = False
            cedula.Visible = False
            Agno.Left = 2010
            Contribuyente.Height = 570
            cedula.Left = 1800
            txtLlaveMunicipal.Visible = False
            txtCatasSamb.Visible = False
            
            If VGTipoEjecucion% <> CGReverso% Then
                claveCatastral.SetFocus
            End If
        ElseIf Opcion2 = 1 Then
            Dim Impto_tmp As String
            Call Muni_2237("1", 0)
            PMSetValorReverso Me.claveCatastral, "@i_catastro2"
            PMSetValorReverso Impto, "@i_cod_impto"
            Impto.Tag = Impto.Caption
            Impto.Caption = ""
            PMSetValorReverso Impto, "@i_nom_impto"
            Impto_tmp = Impto.Caption
            Impto.Caption = Impto.Tag
            Impto.Tag = Impto_tmp
            Predio = Me.claveCatastral.Text
            
            PMSetValorReverso txtPapeletaSamb, "@o_referencia2"
            VLMuniSamb(0) = txtPapeletaSamb.Text
            txtPapeletaSamb.Text = ""
            PMSetValorReverso txtPapeletaSamb, "@o_direccion"
            VLMuniSamb(1) = txtPapeletaSamb.Text
            txtPapeletaSamb.Text = ""
            PMSetValorReverso txtPapeletaSamb, "@o_solar"
            VLMuniSamb(2) = txtPapeletaSamb.Text
            txtPapeletaSamb.Text = ""
            PMSetValorReverso txtPapeletaSamb, "@o_valorpredio"
            VLMuniSamb(3) = txtPapeletaSamb.Text
            txtPapeletaSamb.Text = ""
            PMSetValorReverso txtPapeletaSamb, "@o_valorotros"
            VLMuniSamb(4) = txtPapeletaSamb.Text
            txtPapeletaSamb.Text = ""
            PMSetValorReverso txtPapeletaSamb, "@o_doc_ident"
            VLMuniSamb(5) = txtPapeletaSamb.Text
            txtPapeletaSamb.Text = ""
            PMSetValorReverso txtPapeletaSamb, "@i_ofiretiro"
            
        End If
    Case "2" 'Transmitir
        Dim vltmp As String
        Dim vlclvcatastral As String
        Dim I As Byte
        'msilvag Inicios Otros Municipios
        If vl_servidor_BUS = "PSSRV1" Then
            PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
        Else
            PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 62645, "Trn", ""
            If VGTipoEjecucion% <> CGReverso% Then
                PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLCHAR, "N", "TCorr", ""
            End If
            PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLCHAR, "VEN", "Canal", ""
        End If
        'msilvag Fin
        PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "T", "opcion", ""
        PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
        PMPasoValoresATX VGSqlConn, "@i_cod_impto", 0, SQLCHAR, (Impto.Caption), "tipo", ""
        For I = 1 To Len(Me.claveCatastral.Text)
            If Mid(Me.claveCatastral.Text, I, 1) = "-" Then
                vltmp = "-"
                vlclvcatastral = vlclvcatastral & vltmp
            ElseIf Mid(Me.claveCatastral.Text, I, 1) <> "_" Then
                vltmp = FMValidarNumero((Mid(Me.claveCatastral.Text, I, 1)), 10, CInt(Mid(Me.claveCatastral.Text, I, 1)), "19")
                vlclvcatastral = vlclvcatastral & vltmp
            End If
        Next
        If vlclvcatastral <> "" Then
            PMPasoValoresATX VGSqlConn, "@i_catastro2", 0, SQLVARCHAR, vlclvcatastral, "Catastro", ""
        Else
            PMPasoValoresATX VGSqlConn, "@i_catastro2", 0, SQLVARCHAR, (Me.claveCatastral.Text), "Catastro", ""
        End If
        'OJO - Poner la prioridad
        PMPasoValoresATX VGSqlConn, "@i_prioridad", 0, SQLINT4, val(Prioridad.Text), "Prioridad", ""
        
        PMPasoValoresATX VGSqlConn, "@i_agno", 0, SQLINT4, val(Agno.Caption), "Autorizacion", ""
        PMPasoValoresATX VGSqlConn, "@i_semestre", 0, SQLVARCHAR, (Semestre.Caption), "Autorizacion", ""
        'PMPasoValoresATX VGSqlConn, "@i_referencia2", 0, SQLVARCHAR, (Prioridad.Text), "Referencia", ""
        PMPasoValoresATX VGSqlConn, "@i_nombre", 0, SQLVARCHAR, (Contribuyente.Caption), "Nombre", ""
        PMPasoValoresATX VGSqlConn, "@i_nom_impto", 0, SQLCHAR, (Impto.Tag), "nomimpto", ""
        PMPasoValoresATX VGSqlConn, "@i_fecven", 0, SQLCHAR, (VLGridFecVen), "fecven", ""
        PMPasoValoresATX VGSqlConn, "@i_ofiretiro", 0, SQLVARCHAR, (txtPapeletaSamb.Text), "OficinaRetiro", ""
        'txtPapeletaSamb.Text = ""
        PMPasoValoresATX VGSqlConn, "@i_efe", 0, SQLMONEY, (efe.Text), "efe", ""
        PMPasoValoresATX VGSqlConn, "@i_cant_chq", 0, SQLINT4, val(CantChq.Text), "Moneda", ""
        PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, (Cheques.Text), "Cheques", ""
        PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(FMObtenerMonedaForma("19")), "Moneda", ""
        PMPasoValoresATX VGSqlConn, "@i_autoriza", 0, SQLVARCHAR, VGAutoriza, "Autorizacion", ""
        PMPasoValoresATX VGSqlConn, "@i_supautor", 0, SQLVARCHAR, VGSuperAutoriza$, "Supervisor de Monto", ""
        PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, (Debito.Text), "Debito", ""
        PMPasoValoresATX VGSqlConn, "@i_tarjeta", 0, SQLMONEY, (Tarjeta.Text), "Tarjeta", ""
        'ref003 Ini
        If Me.Cta.ClipText <> "" Then
          PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (CboTipCta.Text), "CboTipCta", ""
        PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
        Else
          PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (VLTipCta_com), "CboTipCta", ""
          PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (VLCta_com), "Cta", ""
        End If
        'ref003 Fin
        'PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
        'PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (CboTipCta.Text), "CboTipCta", ""
        PMPasoValoresATX VGSqlConn, "@i_contribuyente", 0, SQLVARCHAR, (Contribuyente.Caption), "contribuyente", ""
        PMPasoValoresATX VGSqlConn, "@i_valor_mun", 0, SQLMONEY, (ValorMun.Text), "valormun", ""
        
        PMPasoValoresATX VGSqlConn, "@i_tipo_impto", 0, SQLVARCHAR, (Tipo), "tipoimpto", ""
        PMPasoValoresATX VGSqlConn, "@i_totaltrama", 0, SQLMONEY, (ValorMun), "cat1", ""
        PMPasoValoresATX VGSqlConn, "@i_horatrama", 0, SQLVARCHAR, Mid$(VLFecHora, 9, 6), "hora", ""
        PMPasoValoresATX VGSqlConn, "@i_vlfechora", 0, SQLVARCHAR, VLFecHora, "vlfechora", ""
        PMPasoValoresATX VGSqlConn, "@i_vlfeccontable", 0, SQLVARCHAR, VLFecContable, "vlfeccontable", ""
        PMPasoValoresATX VGSqlConn, "@i_vlexoneracion", 0, SQLVARCHAR, VLExoneracion, "vlexoneracion", ""
        PMPasoValoresATX VGSqlConn, "@i_vlavaluocomercial", 0, SQLVARCHAR, VLAvaluoComercial, "vlavaluocomercial", ""
        PMPasoValoresATX VGSqlConn, "@i_VLIdentificacion", 0, SQLVARCHAR, VLIdentificacion, "VLIdentificacion", ""  'hy-22-septiembre-2006
        PMPasoValoresATX VGSqlConn, "@i_valimpto", 0, SQLMONEY, "0", "valimpto", ""
        PMPasoValoresATX VGSqlConn, "@i_valinteres", 0, SQLMONEY, "0", "valinteres", ""
            
        PMPasoValoresATX VGSqlConn, "@i_sal_municipio", 0, SQLVARCHAR, (sal_municipio.Caption), "sal_municipio", ""
        PMPasoValoresATX VGSqlConn, "@i_sal_tipo", 0, SQLVARCHAR, (sal_tipo.Caption), "sal_tipo", ""
        PMPasoValoresATX VGSqlConn, "@i_desc_impto", 0, SQLVARCHAR, (DescripImpto.Text), "sal_tipo", ""
        PMPasoValoresATX VGSqlConn, "@i_direccion", 0, SQLVARCHAR, (direccion.Text), "direccion", ""
        
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
        
        'SE COMENTARON PORQUE EL ORDEN DE LOS PARAMETROS DE SALIDA ESTABAN CAUSANDO ERROR EN EL REVERSO
        'NCHAVEZB 09/Agosto/2011 ERROR EN REVERSO
'        PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, "0", "SecTrn", ""
'        PMPasoValoresATX VGSqlConn, "@o_horario", 1, SQLCHAR, Space(1), "Horario", ""
'
'        PMPasoValoresATX VGSqlConn, "@o_autorisri", 1, SQLVARCHAR, VLautoriSri, "AutorizacionSRI", ""
'        PMPasoValoresATX VGSqlConn, "@o_fecvensri", 1, SQLVARCHAR, VLFecvenSRI, "Stk", ""
'        PMPasoValoresATX VGSqlConn, "@o_fechora", 1, SQLVARCHAR, 0, "Fechora", ""
'        PMPasoValoresATX VGSqlConn, "@o_feccontable", 1, SQLVARCHAR, 0, "Feccontable", ""
'        PMPasoValoresATX VGSqlConn, "@o_fecha_ef", 1, SQLVARCHAR, "", "Fechaefe", ""
'        PMPasoValoresATX VGSqlConn, "@o_nota_venta", 1, SQLVARCHAR, VLSerie_Secuencia, "Nota_venta", ""
'
'        'GAMC - 24/02/2008 - CAPTURAR LOS PARAMETROS DE SALIDA
'        PMPasoValoresATX VGSqlConn, "@o_referencia2", 1, SQLVARCHAR, "", "Referencia2", ""
'        PMPasoValoresATX VGSqlConn, "@o_direccion", 1, SQLVARCHAR, "", "Direccion2", ""
'        PMPasoValoresATX VGSqlConn, "@o_valorotros", 1, SQLMONEY, "", "ValorOtros2", ""
'        PMPasoValoresATX VGSqlConn, "@o_solar", 1, SQLVARCHAR, "", "Solar2", ""
'        PMPasoValoresATX VGSqlConn, "@o_valorpredio", 1, SQLMONEY, "", "ValorPredio2", ""
'        PMPasoValoresATX VGSqlConn, "@o_doc_ident", 1, SQLVARCHAR, "", "Ced/Ruc/Pas", ""
'        PMPasoValoresATX VGSqlConn, "@o_nombcta", 1, SQLVARCHAR, (Nombre.Text), "nombre", ""
          'CAPTURAR LOS PARAMETROS DE SALIDA
        If vl_servidor_BUS = "PSSRV1" Then 'msilvag Otros Municipios
            PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, "0", "SecTrn", ""
            PMPasoValoresATX VGSqlConn, "@o_nombcta", 1, SQLVARCHAR, (Nombre.Text), "nombre", ""
            PMPasoValoresATX VGSqlConn, "@o_horario", 1, SQLCHAR, Space(1), "Horario", ""
            PMPasoValoresATX VGSqlConn, "@o_autorisri", 1, SQLVARCHAR, VLautoriSri, "AutorizacionSRI", ""
            PMPasoValoresATX VGSqlConn, "@o_fecvensri", 1, SQLVARCHAR, VLFecvenSRI, "Stk", ""
            PMPasoValoresATX VGSqlConn, "@o_nota_venta", 1, SQLVARCHAR, VLSerie_Secuencia, "Nota_venta", ""
            PMPasoValoresATX VGSqlConn, "@o_fechora", 1, SQLVARCHAR, "xxxxxxxxxxxxxxxx", "Fechora", ""
            PMPasoValoresATX VGSqlConn, "@o_feccontable", 1, SQLVARCHAR, "xxxxxxxxxx", "", ""
            PMPasoValoresATX VGSqlConn, "@o_fecha_ef", 1, SQLVARCHAR, "xxxxxxxxxx", "Fechaefe", ""
                 
            PMPasoValoresATX VGSqlConn, "@o_referencia2", 1, SQLVARCHAR, "XXXXXXXXXXXXXXXX", "Referencia2", ""
            PMPasoValoresATX VGSqlConn, "@o_direccion", 1, SQLVARCHAR, "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Direccion2", ""
            PMPasoValoresATX VGSqlConn, "@o_solar", 1, SQLVARCHAR, "", "Solar2", ""
            PMPasoValoresATX VGSqlConn, "@o_valorpredio", 1, SQLMONEY, "0", "ValorPredio2", ""
            PMPasoValoresATX VGSqlConn, "@o_valorotros", 1, SQLMONEY, "0.00", "ValorOtros2", ""
            PMPasoValoresATX VGSqlConn, "@o_doc_ident", 1, SQLVARCHAR, "XXXXXXXXXXXXXX", "Ced/Ruc/Pas", ""
        'msilvag Inicio Otros Municipios
        Else
            PMPasoValoresATX VGSqlConn, "@o_referencia2", 1, SQLVARCHAR, "XXXXXXXXXXXXXXXXXXXX", "Referencia2", ""
            PMPasoValoresATX VGSqlConn, "@o_direccion", 1, SQLVARCHAR, "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Direccion2", ""
            PMPasoValoresATX VGSqlConn, "@o_solar", 1, SQLVARCHAR, "XXXXXXXXXXXXXXX", "Solar2", ""
            PMPasoValoresATX VGSqlConn, "@o_valorpredio", 1, SQLMONEY, "0", "ValorPredio2", ""
            PMPasoValoresATX VGSqlConn, "@o_valorotros", 1, SQLMONEY, "0", "ValorOtros2", ""
            PMPasoValoresATX VGSqlConn, "@o_doc_ident", 1, SQLVARCHAR, "XXXXXXXXXXXXXXX", "Ced/Ruc/Pas", ""
            PMPasoValoresATX VGSqlConn, "@o_cod_ident", 1, SQLVARCHAR, "XXXXXXXXXXXXXXX", "CodIdent", ""
        End If
        'msilvag Fin
    Case "3" 'Imprimir Comprobante
        VGparlong$ = "90"
        VGpartop$ = "10"
        VGparleft$ = "10"
        VGparrig$ = "00"
        
        PMSetDetalle "v" + "Este pago sera procesado el " + VLFechaEfe
        PMSetDetalle "v" + " "
        PMSetDetalle "v" + "EMPRESA    : " + Trim$(municipio.Text) + " " + Trim$(Mid$(sal_municipio.Caption, 1, 36))
        PMSetDetalle "v" + "IMPUESTO   : " + Trim$(Impto.Caption) + "-" + Trim$(Impto.Tag)
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "ClAVE CATASTRAL    : " + Trim$(Me.claveCatastral.Text) + "      " + VLMuniSamb(0)
        PMSetDetalle "v" + "PERIODO TRIBUTACION: " + Trim$(Agno.Caption) ' + " FEC.VENC: " + VLGridFecVen
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "CONTRIBUYENTE      : " + Trim$(Left(Contribuyente.Caption, 35))
        PMSetDetalle "v" + "CEDULA/RUC/PASAP   : " + Trim$(Mid$(VLMuniSamb(5), 1, 30))
        'PMSetDetalle "v" + "SOLAR              : " + Trim$(Mid$(VLMuniSamb(2), 1, 30))
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "CONCEPTO"
        PMSetDetalle "v" + "-------------------------------------------------"
        Dim VLTemporal As String
        VLTemporal = Trim$(Impto.Tag)
        VLTemporal = Mid$(VLTemporal, 1, 19)
        VLTemporal = VLTemporal + String(19 - Len(VLTemporal), " ")
        'PMSetDetalle "v" + VLTemporal + ": " + FMEspaciosATX("USD      " + Format(Trim$(VLGridImpuestos), VGFormatoMoney), 5, CGJustificacionDerecha)
        'PMSetDetalle "v" + "PREDIO RUBANO      : " + FMEspaciosATX("USD      " + Format(Trim$(VLMuniSamb(3)), VGFormatoMoney), 13, CGJustificacionDerecha)
        PMSetDetalle "v" + VLTemporal + ": " + FMEspaciosATX("USD      " + Format(Trim$(VLMuniSamb(3)), VGFormatoMoney), 13, CGJustificacionDerecha)
        PMSetDetalle "v" + "DESC/INTERES/RECAR : " + FMEspaciosATX("USD      " + Format(Trim$(VLMuniSamb(4)), VGFormatoMoney), 13, CGJustificacionDerecha)
        PMSetDetalle "v" + "TOTAL A PAGAR      : " + FMEspaciosATX("USD      " + Format(Trim$(ValorMun.Text), VGFormatoMoney), 13, CGJustificacionDerecha)
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "FORMAS DE PAGO:"
        PMSetDetalle "v" + "-------------------------------------------------"
        If val(efe.Text) > 0 Then
            PMSetDetalle "v" + "EFECTIVO           : " + FMEspaciosATX("USD      " + Format(efe, VGFormatoMoney), 13, CGJustificacionDerecha)
        End If
        If val(Cheques.Text) > 0 Then
            PMSetDetalle "v" + "CHEQUE(" + Trim$(CantChq.Text) + ")          : " + FMEspaciosATX("USD      " + Format(Cheques, VGFormatoMoney), 13, CGJustificacionDerecha)
        End If
        If val(Debito.Text) > 0 Then
            PMSetDetalle "v" + "DEBITO             : " + FMEspaciosATX("USD      " + Format(Debito, VGFormatoMoney), 13, CGJustificacionDerecha) + " CUENTA : " + Format(Cta.ClipText, "000-000000-0")
        End If
        If val(Tarjeta.Text) > 0 Then
            PMSetDetalle "v" + "TARJETA CREDITO    : " + FMEspaciosATX("USD      " + Format(Tarjeta, VGFormatoMoney), 13, CGJustificacionDerecha)
        End If
        
'***ref02 vmirandt inicio, se imprime al final del documento
    If VLclave_acceso <> "" Then
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "Clave de Acceso/Autorizacion: "
        PMSetDetalle "v" + VLclave_acceso
    End If
    'ref02 vmirandt
    
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + " "
        PMSetDetalle "v" + "AVISO: PARA RETIRAR SU TITULO DE CREDITO, "
        PMSetDetalle "v" + "ACERCARSE CON ESTE COMPROBANTE A LAS VENTANILLAS DE LA"
        PMSetDetalle "v" + "OFICINA " & Me.VLOficinaRetiro
        If VLHorario = "N" Then
            PMSetDetalle "v" + "DEL BANCO BOLIVARIANO, LUEGO DE 3 DIAS LABORABLES"
            PMSetDetalle "v" + "DE HABER REALIZADO EL PAGO"
        Else
            PMSetDetalle "v" + "DEL BANCO BOLIVARIANO, LUEGO DE 4 DIAS LABORABLES"
            PMSetDetalle "v" + "DE HABER REALIZADO EL PAGO"
        End If
        PMSetDetalle "v" + " "
        PMSetDetalle "v" + ""
        
        VLHorarioDifTemporal = VGHorarioDif
        If VLHorario = "N" Then
            VGHorarioDif = False
            VLTrn = "3215"
        Else
            VGHorarioDif = True
            VLTrn = "3216"
        End If
        
        FMPRN_StdImpresion "IMPRESORA_1", False, Trim$(str$(VLTsnTemporal)), "19", SGDatosDetalle, "Inserte papeleta", CStr(VGpartop$), 1, CStr(VGparleft$), , , VLHorario, , , "1", VLTrn
        VGHorarioDif = VLHorarioDifTemporal
        
        If VGTipoEjecucion = CGNormal% Then
            While MsgBox("Desea Reimprimir la papeleta para certificacion?", vbYesNo, "Mensaje") = vbYes
                PMReimpresion
            Wend
        End If
    Case "4" 'Mensajes de Ayuda
'        If Len(Me.claveCatastral.ClipText) >= 10 Then
'            FPrincipal!pnlHelpLine.Caption = "Digite No Prop. Horiz."
'        ElseIf Len(Me.claveCatastral.ClipText) >= 8 Then
'            FPrincipal!pnlHelpLine.Caption = "Digite No Solar"
'        ElseIf Len(Me.claveCatastral.ClipText) >= 6 Then
'            FPrincipal!pnlHelpLine.Caption = "Digite No Manzana"
'        ElseIf Len(Me.claveCatastral.ClipText) >= 4 Then
'            FPrincipal!pnlHelpLine.Caption = "Digite No Sector"
'        ElseIf Len(Me.claveCatastral.ClipText) >= 2 Then
'            FPrincipal!pnlHelpLine.Caption = "Digite No Zona"
'        Else 'If Len(Me.claveCatastral.ClipText) > 10 Then
'            FPrincipal!pnlHelpLine.Caption = "Digite No Parroquia"
'        End If
        FPrincipal!pnlHelpLine.Caption = "Digite Clave Catastral"
        If Opcion2 = 13 Then
            SendKeys "{RIGHT}"
        End If
    Case "5"
        Dim vltemp As String
        Dim vlseparador As String
        Dim vlclavecatastral As String
        Dim k As Byte
        If Opcion2 = 0 Then
            vlseparador = "-"
        ElseIf Opcion2 = 1 Then
            vlseparador = "."
        End If
        For k = 1 To Len(Me.claveCatastral.Text)
            If Mid(Me.claveCatastral.Text, k, 1) = vlseparador Then
                vlclavecatastral = vlclavecatastral & vlseparador
            ElseIf Mid(Me.claveCatastral.Text, k, 1) <> "_" Then
                vltemp = FMValidarNumero((Mid(Me.claveCatastral.Text, k, 1)), 10, CInt(Mid(Me.claveCatastral.Text, k, 1)), "19")
                vlclavecatastral = vlclavecatastral & vltemp
            End If
        Next
        Muni_2237 = vlclavecatastral
    End Select
error:
Exit Function
End Function

Public Function Muni_1430(Opcion As String, Opcion2 As Integer) As String
    On Error GoTo error
    'nchavezb - Emision inicial - 04/08/2011 - Municipio Daule
    Select Case Opcion
    Case "1" 'Muestra campos para el Municipio Daule
        If Opcion2 = 0 Then
        Etiqueta2.Visible = False
        'Etiqueta3.Top = 640
        Etiqueta3.Caption = "Código de Predio"
        Tipo.Visible = False
        Me.claveCatastral.Visible = False
        sal_tipo.Visible = False
        cat1.Visible = False
        cat2.Visible = False
        cat3.Visible = False
        cat4.Visible = False
        cat5.Visible = False
        cat6.Visible = False
       
       
        cat1.Top = 880
        cat2.Top = 880
        cat3.Top = 880
        cat4.Top = 880
        cat5.Top = 880
        cat6.Top = 880
        Etiqueta3.Top = 880
       
        
        Etiqueta5.Visible = False
        Etiqueta6.Visible = False
        Etiqueta8.Visible = False
        Semestre.Visible = False
        Predio.Visible = False
        Impto.Visible = False
        cedula.Visible = False
        
        Agno.Left = 2010
        Contribuyente.Height = 570
        txtLlaveMunicipal.Visible = False
        txtCatasSamb.Width = 1200
        'txtCatasSamb.Top = 640
        txtCatasSamb.Visible = True
        Prioridad.Visible = True
        Prioridad.Top = 955
        Prioridad.Left = 3200
        Prioridad.Height = 285
        Prioridad.Width = 400
        
        
        'DAPV - INI  09/01/2011
        If Trim(txtCatasSamb.Text) = "" Then
            VL_Prioridad = 0
        End If
        
        If VGTipoEjecucion% <> CGReverso% Then
            If VL_Prioridad <> 1 Then
                txtCatasSamb.SetFocus
            Else
                Prioridad.SetFocus
            End If
        End If
        
        'DAPV - FIN  09/01/2011

        ElseIf Opcion2 = 1 Then
            Dim Impto_tmp As String
            Call Muni_1430("1", 0)
            'PMSetValorReverso Me.claveCatastral, "@i_catastro2"
            PMSetValorReverso Impto, "@i_cod_impto"
            Impto.Tag = Impto.Caption
            Impto.Caption = ""
            PMSetValorReverso Impto, "@i_nom_impto"
            Impto_tmp = Impto.Caption
            Impto.Caption = Impto.Tag
            Impto.Tag = Impto_tmp
            Predio = Me.claveCatastral.Text
            PMSetValorReverso Agno, "@i_agno"
            PMSetValorReverso Prioridad, "@i_referencia"
            PMSetValorReverso txtTemporal, "@i_no_predio"
            Me.txtCatasSamb.Text = txtTemporal
            Me.txtCatasSamb.Enabled = False

            PMSetValorReverso txtPapeletaSamb, "@o_referencia2"
            VLMuniSamb(0) = txtPapeletaSamb.Text
            txtPapeletaSamb.Text = ""
            PMSetValorReverso txtPapeletaSamb, "@o_direccion"
            VLMuniSamb(1) = txtPapeletaSamb.Text
            txtPapeletaSamb.Text = ""
            PMSetValorReverso txtPapeletaSamb, "@o_solar"
            VLMuniSamb(2) = txtPapeletaSamb.Text
            txtPapeletaSamb.Text = ""
            PMSetValorReverso txtPapeletaSamb, "@o_valorpredio"
            VLMuniSamb(3) = txtPapeletaSamb.Text
            txtPapeletaSamb.Text = ""
            PMSetValorReverso txtPapeletaSamb, "@o_valorotros"
            VLMuniSamb(4) = txtPapeletaSamb.Text
            txtPapeletaSamb.Text = ""
            PMSetValorReverso txtPapeletaSamb, "@o_doc_ident"
            VLMuniSamb(5) = txtPapeletaSamb.Text
            txtPapeletaSamb.Text = ""
            PMSetValorReverso txtPapeletaSamb, "@i_ofiretiro"
            
        End If
    Case "2" 'Transmitir
        Dim vltmp As String
        Dim vlclvcatastral As String
        Dim I As Byte
         'msilvag Inicio SOA Fase2
        If vl_servidor_BUS = "PSSRV1" Then
            PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
        Else
            PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 62645, "Trn", ""
            If VGTipoEjecucion% <> CGReverso% Then
                PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLCHAR, "N", "TCorr", ""
            End If
            PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLCHAR, "VEN", "Canal", ""
        End If
        'msilvag Fin SOA Fase2
        'PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
        PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "T", "opcion", ""
        PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
        PMPasoValoresATX VGSqlConn, "@i_cod_impto", 0, SQLCHAR, (Impto.Caption), "tipo", ""

        PMPasoValoresATX VGSqlConn, "@i_agno", 0, SQLINT4, val(Agno.Caption), "Autorizacion", ""
        PMPasoValoresATX VGSqlConn, "@i_referencia", 0, SQLVARCHAR, (Prioridad.Text), "Referencia", ""
        PMPasoValoresATX VGSqlConn, "@i_nombre", 0, SQLVARCHAR, (Contribuyente.Caption), "Nombre", ""
        PMPasoValoresATX VGSqlConn, "@i_nom_impto", 0, SQLCHAR, (Impto.Tag), "nomimpto", ""
        PMPasoValoresATX VGSqlConn, "@i_fecven", 0, SQLCHAR, (VLGridFecVen), "fecven", ""
        PMPasoValoresATX VGSqlConn, "@i_ofiretiro", 0, SQLVARCHAR, (txtPapeletaSamb.Text), "OficinaRetiro", ""
        PMPasoValoresATX VGSqlConn, "@i_identifica", 0, SQLVARCHAR, cedula.ClipText, "identificacion", ""
        PMPasoValoresATX VGSqlConn, "@i_no_predio", 0, SQLINT4, Me.txtCatasSamb, "no predio", ""
        'txtPapeletaSamb.Text = ""
        PMPasoValoresATX VGSqlConn, "@i_efe", 0, SQLMONEY, (efe.Text), "efe", ""
        PMPasoValoresATX VGSqlConn, "@i_cant_chq", 0, SQLINT4, val(CantChq.Text), "Moneda", ""
        PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, (Cheques.Text), "Cheques", ""
        PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(FMObtenerMonedaForma("19")), "Moneda", ""
        PMPasoValoresATX VGSqlConn, "@i_autoriza", 0, SQLVARCHAR, VGAutoriza, "Autorizacion", ""
        PMPasoValoresATX VGSqlConn, "@i_supautor", 0, SQLVARCHAR, VGSuperAutoriza$, "Supervisor de Monto", ""
        PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, (Debito.Text), "Debito", ""
        PMPasoValoresATX VGSqlConn, "@i_tarjeta", 0, SQLMONEY, (Tarjeta.Text), "Tarjeta", ""
        'ref003 Ini
        If Me.Cta.ClipText <> "" Then
          PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (CboTipCta.Text), "CboTipCta", ""
        PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
        Else
          PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (VLTipCta_com), "CboTipCta", ""
          PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (VLCta_com), "Cta", ""
        End If
        'ref003 Fin
        'PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
        'PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (CboTipCta.Text), "CboTipCta", ""
        
        PMPasoValoresATX VGSqlConn, "@i_contribuyente", 0, SQLVARCHAR, (Contribuyente.Caption), "contribuyente", ""
        PMPasoValoresATX VGSqlConn, "@i_valor_mun", 0, SQLMONEY, (ValorMun.Text), "valormun", ""
        
        PMPasoValoresATX VGSqlConn, "@i_tipo_impto", 0, SQLVARCHAR, (Tipo), "tipoimpto", ""
        PMPasoValoresATX VGSqlConn, "@i_totaltrama", 0, SQLMONEY, (ValorMun), "cat1", ""
        PMPasoValoresATX VGSqlConn, "@i_horatrama", 0, SQLVARCHAR, Mid$(VLFecHora, 9, 6), "hora", ""
        PMPasoValoresATX VGSqlConn, "@i_vlfechora", 0, SQLVARCHAR, VLFecHora, "vlfechora", ""
        PMPasoValoresATX VGSqlConn, "@i_vlfeccontable", 0, SQLVARCHAR, VLFecContable, "vlfeccontable", ""
        PMPasoValoresATX VGSqlConn, "@i_vlexoneracion", 0, SQLVARCHAR, VLExoneracion, "vlexoneracion", ""
        PMPasoValoresATX VGSqlConn, "@i_vlavaluocomercial", 0, SQLVARCHAR, VLAvaluoComercial, "vlavaluocomercial", ""
        PMPasoValoresATX VGSqlConn, "@i_VLIdentificacion", 0, SQLVARCHAR, VLIdentificacion, "VLIdentificacion", ""  'hy-22-septiembre-2006
        PMPasoValoresATX VGSqlConn, "@i_valimpto", 0, SQLMONEY, "0", "valimpto", ""
        PMPasoValoresATX VGSqlConn, "@i_valinteres", 0, SQLMONEY, "0", "valinteres", ""
            
        PMPasoValoresATX VGSqlConn, "@i_sal_municipio", 0, SQLVARCHAR, (sal_municipio.Caption), "sal_municipio", ""
        PMPasoValoresATX VGSqlConn, "@i_sal_tipo", 0, SQLVARCHAR, (sal_tipo.Caption), "sal_tipo", ""
        PMPasoValoresATX VGSqlConn, "@i_desc_impto", 0, SQLVARCHAR, (DescripImpto.Text), "sal_tipo", ""
        PMPasoValoresATX VGSqlConn, "@i_direccion", 0, SQLVARCHAR, (direccion.Text), "direccion", ""
        
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
        
        'CAPTURAR LOS PARAMETROS DE SALIDA
        If vl_servidor_BUS = "PSSRV1" Then 'msilvag Otros Municipios
            PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, "0", "SecTrn", ""
            PMPasoValoresATX VGSqlConn, "@o_nombcta", 1, SQLVARCHAR, (Nombre.Text), "nombre", ""
            PMPasoValoresATX VGSqlConn, "@o_horario", 1, SQLCHAR, Space(1), "Horario", ""
            PMPasoValoresATX VGSqlConn, "@o_autorisri", 1, SQLVARCHAR, VLautoriSri, "AutorizacionSRI", ""
            PMPasoValoresATX VGSqlConn, "@o_fecvensri", 1, SQLVARCHAR, VLFecvenSRI, "Stk", ""
            PMPasoValoresATX VGSqlConn, "@o_nota_venta", 1, SQLVARCHAR, VLSerie_Secuencia, "Nota_venta", ""
            PMPasoValoresATX VGSqlConn, "@o_fechora", 1, SQLVARCHAR, "xxxxxxxxxxxxxxxx", "Fechora", ""
            PMPasoValoresATX VGSqlConn, "@o_feccontable", 1, SQLVARCHAR, "xxxxxxxxxx", "", ""
            PMPasoValoresATX VGSqlConn, "@o_fecha_ef", 1, SQLVARCHAR, "xxxxxxxxxx", "Fechaefe", ""
                 
            PMPasoValoresATX VGSqlConn, "@o_referencia2", 1, SQLVARCHAR, "XXXXXXXXXXXXXXXX", "Referencia2", ""
            PMPasoValoresATX VGSqlConn, "@o_direccion", 1, SQLVARCHAR, "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Direccion2", ""
            PMPasoValoresATX VGSqlConn, "@o_solar", 1, SQLVARCHAR, "", "Solar2", ""
            PMPasoValoresATX VGSqlConn, "@o_valorpredio", 1, SQLMONEY, "0", "ValorPredio2", ""
            PMPasoValoresATX VGSqlConn, "@o_valorotros", 1, SQLMONEY, "0", "ValorOtros2", ""
            PMPasoValoresATX VGSqlConn, "@o_doc_ident", 1, SQLVARCHAR, "XXXXXXXXXXXXXX", "Ced/Ruc/Pas", ""
        'msilvag Inicio Otros Municipios
        Else
            PMPasoValoresATX VGSqlConn, "@o_referencia2", 1, SQLVARCHAR, "XXXXXXXXXXXXXXXXXXXX", "Referencia2", ""
            PMPasoValoresATX VGSqlConn, "@o_direccion", 1, SQLVARCHAR, "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Direccion2", ""
            PMPasoValoresATX VGSqlConn, "@o_solar", 1, SQLVARCHAR, "XXXXXXXXXXXXXXX", "Solar2", ""
            PMPasoValoresATX VGSqlConn, "@o_valorpredio", 1, SQLMONEY, "0", "ValorPredio2", ""
            PMPasoValoresATX VGSqlConn, "@o_valorotros", 1, SQLMONEY, "0", "ValorOtros2", ""
            PMPasoValoresATX VGSqlConn, "@o_doc_ident", 1, SQLVARCHAR, "XXXXXXXXXXXXXXX", "Ced/Ruc/Pas", ""
            PMPasoValoresATX VGSqlConn, "@o_cod_ident", 1, SQLVARCHAR, "XXXXXXXXXXXXXXX", "CodIdent", ""
        End If
        'msilvag Fin
    Case "3" 'Imprimir Comprobante
        VGparlong$ = "90"
        VGpartop$ = "10"
        VGparleft$ = "10"
        VGparrig$ = "00"
        
        PMSetDetalle "v" + "Este pago sera procesado el " + VLFechaEfe
        PMSetDetalle "v" + " "
        PMSetDetalle "v" + "EMPRESA    : " + Trim$(municipio.Text) + " " + Trim$(Mid$(sal_municipio.Caption, 1, 36))
        PMSetDetalle "v" + "IMPUESTO   : " + Trim$(Impto.Caption) + "-" + Trim$(Impto.Tag)
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "CODIGO DE CATASTRO : " + Trim(Trim$(Me.txtCatasSamb) + "-" + Trim(Prioridad.Text)) '+ "-" + Trim(Prioridad.Text))'DAPV - MUN.Daule  09/01/2011
        PMSetDetalle "v" + "CONTRIBUYENTE      : " + Trim$(Left(Contribuyente.Caption, 35))
        PMSetDetalle "v" + "PERIODO TRIBUTACION: " + Trim$(Agno.Caption) ' + " FEC.VENC: " + VLGridFecVen
        PMSetDetalle "v" + "DIRECCION   :        " + Trim$(Mid$(VLMuniSamb(1), 1, 30))
        'PMSetDetalle "v" + "SOLAR              : " + Trim$(Mid$(VLMuniSamb(2), 1, 30))
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "CONCEPTO                       VALOR"
        PMSetDetalle "v" + "-------------------------------------------------"
        Dim VLTemporal As String
        VLTemporal = Trim$(Impto.Tag)
        VLTemporal = Mid$(VLTemporal, 1, 19)
        VLTemporal = VLTemporal + String(19 - Len(VLTemporal), " ")
        'PMSetDetalle "v" + VLTemporal + ": " + FMEspaciosATX("USD      " + Format(Trim$(VLGridImpuestos), VGFormatoMoney), 5, CGJustificacionDerecha)
        'PMSetDetalle "v" + "PREDIO RUBANO      : " + FMEspaciosATX("USD      " + Format(Trim$(VLMuniSamb(3)), VGFormatoMoney), 13, CGJustificacionDerecha)
        PMSetDetalle "v" + VLTemporal + ": " + FMEspaciosATX("USD      " + Format(Trim$(VLMuniSamb(3)), VGFormatoMoney), 13, CGJustificacionDerecha)
        PMSetDetalle "v" + "DESC/INTERES/RECAR  : " + FMEspaciosATX("USD      " + Format(Trim$(VLMuniSamb(4)), VGFormatoMoney), 13, CGJustificacionDerecha)
        PMSetDetalle "v" + "TOTAL A PAGAR       : " + FMEspaciosATX("USD      " + Format(Trim$(ValorMun.Text), VGFormatoMoney), 13, CGJustificacionDerecha)
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "FORMAS DE PAGO:"
        PMSetDetalle "v" + "-------------------------------------------------"
        If val(efe.Text) > 0 Then
            PMSetDetalle "v" + "EFECTIVO           : " + FMEspaciosATX("USD      " + Format(efe, VGFormatoMoney), 13, CGJustificacionDerecha)
        End If
        If val(Cheques.Text) > 0 Then
            PMSetDetalle "v" + "CHEQUE(" + Trim$(CantChq.Text) + ")          : " + FMEspaciosATX("USD      " + Format(Cheques, VGFormatoMoney), 13, CGJustificacionDerecha)
        End If
        If val(Debito.Text) > 0 Then
            PMSetDetalle "v" + "DEBITO             : " + FMEspaciosATX("USD      " + Format(Debito, VGFormatoMoney), 13, CGJustificacionDerecha) + " CUENTA : " + Format(Cta.ClipText, "000-000000-0")
        End If
        If val(Tarjeta.Text) > 0 Then
            PMSetDetalle "v" + "TARJETA CREDITO    : " + FMEspaciosATX("USD      " + Format(Tarjeta, VGFormatoMoney), 13, CGJustificacionDerecha)
        End If
    '***ref02 vmirandt inicio, se imprime al final del documento
    If VLclave_acceso <> "" Then
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "Clave de Acceso/Autorizacion: "
        PMSetDetalle "v" + VLclave_acceso
    End If
    'ref02 vmirandt
        
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + " "
        'PMSetDetalle "v" + "AVISO: PARA RETIRAR SU TITULO DE CREDITO, " 'lcepeda -ref 06
        PMSetDetalle "v" + "GRACIAS POR SU PAGO, PODRA RETIRAR SU TITULO DE CREDITO, " 'lcepeda -ref 06
        'PMSetDetalle "v" + "ACERCARSE CON ESTE COMPROBANTE A LAS VENTANILLAS DE LA" '-ref 06
        PMSetDetalle "v" + "EN LAS VENTANILLAS DEL MUNICIPIO DE DAULE EN LAS PROXIMAS " '-ref 06
        'PMSetDetalle "v" + "OFICINA " & Me.VLOficinaRetiro '-ref 06
        PMSetDetalle "v" + "72 HORAS LABORALES " '-ref 06
        'If VLHorario = "N" Then '- inicio ref 06
            'PMSetDetalle "v" + "DEL BANCO BOLIVARIANO, LUEGO DE 3 DIAS LABORABLES"
            'PMSetDetalle "v" + "DE HABER REALIZADO EL PAGO"
        'Else
            'PMSetDetalle "v" + "DEL BANCO BOLIVARIANO, LUEGO DE 4 DIAS LABORABLES"
            'PMSetDetalle "v" + "DE HABER REALIZADO EL PAGO"
        'End If
        '- fin ref 06
        PMSetDetalle "v" + " "
        PMSetDetalle "v" + ""
        
        VLHorarioDifTemporal = VGHorarioDif
        If VLHorario = "N" Then
            VGHorarioDif = False
            VLTrn = "3215"
        Else
            VGHorarioDif = True
            VLTrn = "3216"
        End If
        
        FMPRN_StdImpresion "IMPRESORA_1", False, Trim$(str$(VLTsnTemporal)), "19", SGDatosDetalle, "Inserte papeleta", CStr(VGpartop$), 1, CStr(VGparleft$), , , VLHorario, , , "1", VLTrn
        VGHorarioDif = VLHorarioDifTemporal
        
        If VGTipoEjecucion = CGNormal% Then
            While MsgBox("Desea Reimprimir la papeleta para certificacion?", vbYesNo, "Mensaje") = vbYes
                PMReimpresion
            Wend
        End If
    Case "4" 'Mensajes de Ayuda
        FPrincipal!pnlHelpLine.Caption = "Ingrese código de predio"
        If Opcion2 = 13 Then
            SendKeys "{RIGHT}"
        End If
    Case "5"
        Dim vltemp As String
        Dim vlseparador As String
        Dim vlclavecatastral As String
        Dim k As Byte
        If Opcion2 = 0 Then
            vlseparador = "-"
        ElseIf Opcion2 = 1 Then
            vlseparador = "."
        End If
        For k = 1 To Len(Me.claveCatastral.Text)
            If Mid(Me.claveCatastral.Text, k, 1) = vlseparador Then
                vlclavecatastral = vlclavecatastral & vlseparador
            ElseIf Mid(Me.claveCatastral.Text, k, 1) <> "_" Then
                vltemp = FMValidarNumero((Mid(Me.claveCatastral.Text, k, 1)), 10, CInt(Mid(Me.claveCatastral.Text, k, 1)), "19")
                vlclavecatastral = vlclavecatastral & vltemp
            End If
        Next
        Muni_1430 = vlclavecatastral
    End Select
error:
Exit Function
End Function


Public Function Muni_2235(Opcion As String, Opcion2 As Integer) As String
    On Error GoTo error
    'GAMC - Emision inicial - 09/ABR/2008 - Municipio de Santa Elena
    Select Case Opcion
    Case "1" 'Muestra campos para el Municipio de Santa Elena
        If Opcion2 = 0 Then
            Me.claveCatastral.Mask = "###-###-###-##-##-##"
            Me.claveCatastral.Visible = True
            Me.claveCatastral.Width = 1800
            Etiqueta3.Visible = True
            Etiqueta3.Caption = "Clave Catastral"
            
            Etiqueta2.Visible = False
            Tipo.Visible = False
            sal_tipo.Visible = False
            cat1.Visible = False
            cat2.Visible = False
            cat3.Visible = False
            cat4.Visible = False
            cat5.Visible = False
            cat6.Visible = False
            
            cat1.Top = 880
            cat2.Top = 880
            cat3.Top = 880
            cat4.Top = 880
            cat5.Top = 880
            cat6.Top = 880
            
            '-->lfcm 29-octubre-2008
            Etiqueta3.Top = 880
            '--<lfcm 29-octubre-2008
            
            Tipo.Visible = False
            sal_tipo.Visible = False
            Etiqueta5.Visible = False
            Etiqueta6.Visible = False
            Etiqueta8.Visible = False
            Semestre.Visible = False
            Predio.Visible = False
            Impto.Visible = False
            cedula.Visible = False
            Agno.Left = 2010
            Contribuyente.Height = 570
            cedula.Left = 1800
            txtLlaveMunicipal.Visible = False
            txtCatasSamb.Visible = False
            
            If VGTipoEjecucion% <> CGReverso% Then
                claveCatastral.SetFocus
            End If
        ElseIf Opcion2 = 1 Then
            Dim Impto_tmp As String
            Call Muni_2235("1", 0)
            PMSetValorReverso Me.claveCatastral, "@i_catastro2"
            PMSetValorReverso Impto, "@i_cod_impto"
            Impto.Tag = Impto.Caption
            Impto.Caption = ""
            PMSetValorReverso Impto, "@i_nom_impto"
            Impto_tmp = Impto.Caption
            Impto.Caption = Impto.Tag
            Impto.Tag = Impto_tmp
            Predio = Me.claveCatastral.Text
            
            PMSetValorReverso txtPapeletaSamb, "@o_referencia2"
            VLMuniSamb(0) = txtPapeletaSamb.Text
            txtPapeletaSamb.Text = ""
            PMSetValorReverso txtPapeletaSamb, "@o_direccion"
            VLMuniSamb(1) = txtPapeletaSamb.Text
            txtPapeletaSamb.Text = ""
            PMSetValorReverso txtPapeletaSamb, "@o_solar"
            VLMuniSamb(2) = txtPapeletaSamb.Text
            txtPapeletaSamb.Text = ""
            PMSetValorReverso txtPapeletaSamb, "@o_valorpredio"
            VLMuniSamb(3) = txtPapeletaSamb.Text
            txtPapeletaSamb.Text = ""
            PMSetValorReverso txtPapeletaSamb, "@o_valorotros"
            VLMuniSamb(4) = txtPapeletaSamb.Text
            txtPapeletaSamb.Text = ""
            PMSetValorReverso txtPapeletaSamb, "@o_doc_ident"
            VLMuniSamb(5) = txtPapeletaSamb.Text
            txtPapeletaSamb.Text = ""
            PMSetValorReverso txtPapeletaSamb, "@i_ofiretiro"
            
        End If
    Case "2" 'Transmitir
        Dim vltmp As String
        Dim vlclvcatastral As String
        Dim I As Byte
        'msilvag Inicio SOA Fase2
        'PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
        If vl_servidor_BUS = "PSSRV1" Then
            PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
        Else
            PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 62645, "Trn", ""
            If VGTipoEjecucion% <> CGReverso% Then
                PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLCHAR, "N", "TCorr", ""
            End If
            PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLCHAR, "VEN", "Canal", ""
        End If
        'msilvag Fin SOA Fase2
        PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "T", "opcion", ""
        PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
        PMPasoValoresATX VGSqlConn, "@i_cod_impto", 0, SQLCHAR, (Impto.Caption), "tipo", ""
        For I = 1 To Len(Me.claveCatastral.Text)
            If Mid(Me.claveCatastral.Text, I, 1) = "-" Then
                vltmp = "-"
                vlclvcatastral = vlclvcatastral & vltmp
            ElseIf Mid(Me.claveCatastral.Text, I, 1) <> "_" Then
                vltmp = FMValidarNumero((Mid(Me.claveCatastral.Text, I, 1)), 10, CInt(Mid(Me.claveCatastral.Text, I, 1)), "19")
                vlclvcatastral = vlclvcatastral & vltmp
            End If
        Next
        If vlclvcatastral <> "" Then
            PMPasoValoresATX VGSqlConn, "@i_catastro2", 0, SQLVARCHAR, vlclvcatastral, "Catastro", ""
        Else
            PMPasoValoresATX VGSqlConn, "@i_catastro2", 0, SQLVARCHAR, (Me.claveCatastral.Text), "Catastro", ""
        End If
        
        PMPasoValoresATX VGSqlConn, "@i_prioridad", 0, SQLINT4, val(Prioridad.Text), "Prioridad", ""
        
        PMPasoValoresATX VGSqlConn, "@i_agno", 0, SQLINT4, val(Agno.Caption), "Autorizacion", ""
        PMPasoValoresATX VGSqlConn, "@i_semestre", 0, SQLVARCHAR, (Semestre.Caption), "Autorizacion", ""
        'PMPasoValoresATX VGSqlConn, "@i_referencia2", 0, SQLVARCHAR, (Prioridad.Text), "Referencia", ""
        PMPasoValoresATX VGSqlConn, "@i_nombre", 0, SQLVARCHAR, (Contribuyente.Caption), "Nombre", ""
        PMPasoValoresATX VGSqlConn, "@i_nom_impto", 0, SQLCHAR, (Impto.Tag), "nomimpto", ""
        PMPasoValoresATX VGSqlConn, "@i_fecven", 0, SQLCHAR, (VLGridFecVen), "fecven", ""
        PMPasoValoresATX VGSqlConn, "@i_ofiretiro", 0, SQLVARCHAR, (txtPapeletaSamb.Text), "OficinaRetiro", ""
        'txtPapeletaSamb.Text = ""
        PMPasoValoresATX VGSqlConn, "@i_efe", 0, SQLMONEY, (efe.Text), "efe", ""
        PMPasoValoresATX VGSqlConn, "@i_cant_chq", 0, SQLINT4, val(CantChq.Text), "Moneda", ""
        PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, (Cheques.Text), "Cheques", ""
        PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(FMObtenerMonedaForma("19")), "Moneda", ""
        PMPasoValoresATX VGSqlConn, "@i_autoriza", 0, SQLVARCHAR, VGAutoriza, "Autorizacion", ""
        PMPasoValoresATX VGSqlConn, "@i_supautor", 0, SQLVARCHAR, VGSuperAutoriza$, "Supervisor de Monto", ""
        PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, (Debito.Text), "Debito", ""
        PMPasoValoresATX VGSqlConn, "@i_tarjeta", 0, SQLMONEY, (Tarjeta.Text), "Tarjeta", ""
        'ref003 Ini
        If Me.Cta.ClipText <> "" Then
          PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (CboTipCta.Text), "CboTipCta", ""
        PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
        Else
          PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (VLTipCta_com), "CboTipCta", ""
          PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (VLCta_com), "Cta", ""
        End If
        'ref003 Fin
        'PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
        'PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (CboTipCta.Text), "CboTipCta", ""
        PMPasoValoresATX VGSqlConn, "@i_contribuyente", 0, SQLVARCHAR, (Contribuyente.Caption), "contribuyente", ""
        PMPasoValoresATX VGSqlConn, "@i_valor_mun", 0, SQLMONEY, (ValorMun.Text), "valormun", ""
        
        PMPasoValoresATX VGSqlConn, "@i_tipo_impto", 0, SQLVARCHAR, (Tipo), "tipoimpto", ""
        PMPasoValoresATX VGSqlConn, "@i_totaltrama", 0, SQLMONEY, (ValorMun), "cat1", ""
        PMPasoValoresATX VGSqlConn, "@i_horatrama", 0, SQLVARCHAR, Mid$(VLFecHora, 9, 6), "hora", ""
        PMPasoValoresATX VGSqlConn, "@i_vlfechora", 0, SQLVARCHAR, VLFecHora, "vlfechora", ""
        PMPasoValoresATX VGSqlConn, "@i_vlfeccontable", 0, SQLVARCHAR, VLFecContable, "vlfeccontable", ""
        PMPasoValoresATX VGSqlConn, "@i_vlexoneracion", 0, SQLVARCHAR, VLExoneracion, "vlexoneracion", ""
        PMPasoValoresATX VGSqlConn, "@i_vlavaluocomercial", 0, SQLVARCHAR, VLAvaluoComercial, "vlavaluocomercial", ""
        PMPasoValoresATX VGSqlConn, "@i_VLIdentificacion", 0, SQLVARCHAR, VLIdentificacion, "VLIdentificacion", ""  'hy-22-septiembre-2006
        PMPasoValoresATX VGSqlConn, "@i_valimpto", 0, SQLMONEY, "0", "valimpto", ""
        PMPasoValoresATX VGSqlConn, "@i_valinteres", 0, SQLMONEY, "0", "valinteres", ""
            
        PMPasoValoresATX VGSqlConn, "@i_sal_municipio", 0, SQLVARCHAR, (sal_municipio.Caption), "sal_municipio", ""
        PMPasoValoresATX VGSqlConn, "@i_sal_tipo", 0, SQLVARCHAR, (sal_tipo.Caption), "sal_tipo", ""
        PMPasoValoresATX VGSqlConn, "@i_desc_impto", 0, SQLVARCHAR, (DescripImpto.Text), "sal_tipo", ""
        PMPasoValoresATX VGSqlConn, "@i_direccion", 0, SQLVARCHAR, (direccion.Text), "direccion", ""
        
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
        
'        PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, "0", "SecTrn", ""
'        PMPasoValoresATX VGSqlConn, "@o_horario", 1, SQLCHAR, Space(1), "Horario", ""
'
'
'        PMPasoValoresATX VGSqlConn, "@o_autorisri", 1, SQLVARCHAR, VLautoriSri, "AutorizacionSRI", ""
'        PMPasoValoresATX VGSqlConn, "@o_fecvensri", 1, SQLVARCHAR, VLFecvenSRI, "Stk", ""
'        PMPasoValoresATX VGSqlConn, "@o_fechora", 1, SQLVARCHAR, 0, "Fechora", ""
'        PMPasoValoresATX VGSqlConn, "@o_feccontable", 1, SQLVARCHAR, 0, "Feccontable", ""
'        PMPasoValoresATX VGSqlConn, "@o_fecha_ef", 1, SQLVARCHAR, "", "Fechaefe", ""
'        PMPasoValoresATX VGSqlConn, "@o_nota_venta", 1, SQLVARCHAR, VLSerie_Secuencia, "Nota_venta", ""
'
'        'GAMC - 24/02/2008 - CAPTURAR LOS PARAMETROS DE SALIDA
'        PMPasoValoresATX VGSqlConn, "@o_referencia2", 1, SQLVARCHAR, "", "Referencia2", ""
'        PMPasoValoresATX VGSqlConn, "@o_direccion", 1, SQLVARCHAR, "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Direccion2", ""
'        PMPasoValoresATX VGSqlConn, "@o_solar", 1, SQLVARCHAR, "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Solar2", ""
'        PMPasoValoresATX VGSqlConn, "@o_valorpredio", 1, SQLMONEY, "0", "ValorPredio2", ""
'        PMPasoValoresATX VGSqlConn, "@o_valorotros", 1, SQLMONEY, "0", "ValorOtros2", ""
'        PMPasoValoresATX VGSqlConn, "@o_doc_ident", 1, SQLVARCHAR, "", "Ced/Ruc/Pas", ""
'        PMPasoValoresATX VGSqlConn, "@o_nombcta", 1, SQLVARCHAR, (Nombre.Text), "nombre", ""
        If vl_servidor_BUS = "PSSRV1" Then
            PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, "0", "SecTrn", ""
            PMPasoValoresATX VGSqlConn, "@o_nombcta", 1, SQLVARCHAR, (Nombre.Text), "nombre", ""
            PMPasoValoresATX VGSqlConn, "@o_horario", 1, SQLCHAR, Space(1), "Horario", ""
            PMPasoValoresATX VGSqlConn, "@o_autorisri", 1, SQLVARCHAR, VLautoriSri, "AutorizacionSRI", ""
            PMPasoValoresATX VGSqlConn, "@o_fecvensri", 1, SQLVARCHAR, VLFecvenSRI, "Stk", ""
            PMPasoValoresATX VGSqlConn, "@o_nota_venta", 1, SQLVARCHAR, VLSerie_Secuencia, "Nota_venta", ""
            PMPasoValoresATX VGSqlConn, "@o_fechora", 1, SQLVARCHAR, "xxxxxxxxxxxxxxxx", "Fechora", ""
            PMPasoValoresATX VGSqlConn, "@o_feccontable", 1, SQLVARCHAR, "xxxxxxxxxx", "", ""
            PMPasoValoresATX VGSqlConn, "@o_fecha_ef", 1, SQLVARCHAR, "xxxxxxxxxx", "Fechaefe", ""
                 
            PMPasoValoresATX VGSqlConn, "@o_referencia2", 1, SQLVARCHAR, "XXXXXXXXXXXXXXXX", "Referencia2", ""
            PMPasoValoresATX VGSqlConn, "@o_direccion", 1, SQLVARCHAR, "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Direccion2", ""
            PMPasoValoresATX VGSqlConn, "@o_solar", 1, SQLVARCHAR, "", "Solar2", ""
            PMPasoValoresATX VGSqlConn, "@o_valorpredio", 1, SQLMONEY, "0", "ValorPredio2", ""
            PMPasoValoresATX VGSqlConn, "@o_valorotros", 1, SQLMONEY, "0", "ValorOtros2", ""
            PMPasoValoresATX VGSqlConn, "@o_doc_ident", 1, SQLVARCHAR, "XXXXXXXXXXXXXX", "Ced/Ruc/Pas", ""
        'msilvag Inicio Otros Municipios Soa Fase 2
        Else
            PMPasoValoresATX VGSqlConn, "@o_referencia2", 1, SQLVARCHAR, "XXXXXXXXXXXXXXXXXXXX", "Referencia2", ""
            PMPasoValoresATX VGSqlConn, "@o_direccion", 1, SQLVARCHAR, "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Direccion2", ""
            PMPasoValoresATX VGSqlConn, "@o_solar", 1, SQLVARCHAR, "XXXXXXXXXXXXXXX", "Solar2", ""
            PMPasoValoresATX VGSqlConn, "@o_valorpredio", 1, SQLMONEY, "0", "ValorPredio2", ""
            PMPasoValoresATX VGSqlConn, "@o_valorotros", 1, SQLMONEY, "0", "ValorOtros2", ""
            PMPasoValoresATX VGSqlConn, "@o_doc_ident", 1, SQLVARCHAR, "XXXXXXXXXXXXXXX", "Ced/Ruc/Pas", ""
            PMPasoValoresATX VGSqlConn, "@o_cod_ident", 1, SQLVARCHAR, "XXXXXXXXXXXXXXX", "CodIdent", ""
        End If
        'msilvag Fin
    Case "3" 'Imprimir Comprobante
        VGparlong$ = "90"
        VGpartop$ = "10"
        VGparleft$ = "10"
        VGparrig$ = "00"
        
        PMSetDetalle "v" + "Este pago sera procesado el " + VLFechaEfe
        PMSetDetalle "v" + " "
        PMSetDetalle "v" + "EMPRESA    : " + Trim$(municipio.Text) + " " + Trim$(Mid$(sal_municipio.Caption, 1, 36))
        PMSetDetalle "v" + "IMPUESTO   : " + Trim$(Impto.Caption) + "-" + Trim$(Impto.Tag)
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "ClAVE CATASTRAL    : " + Trim$(Me.claveCatastral.Text)
        If Trim$(Agno.Caption) = "0" Then
            'PMSetDetalle "v" + "PERIODO TRIBUTACION: "
        Else
            PMSetDetalle "v" + "PERIODO TRIBUTACION: " + Trim$(Agno.Caption)
        End If
        PMSetDetalle "v" + "DIRECCION          : " + Trim$(Mid$(VLMuniSamb(1), 1, 30))
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "CONTRIBUYENTE      : " + Trim$(Left(Contribuyente.Caption, 35))
        PMSetDetalle "v" + "CEDULA/RUC/PASAP   : " + Trim$(Mid$(VLMuniSamb(5), 1, 30))
        'PMSetDetalle "v" + "SOLAR              : " + Trim$(Mid$(VLMuniSamb(2), 1, 30))
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "CONCEPTO"
        PMSetDetalle "v" + "-------------------------------------------------"
        Dim VLTemporal As String
        VLTemporal = Trim$(Impto.Tag)
        VLTemporal = Mid$(VLTemporal, 1, 19)
        VLTemporal = VLTemporal + String(19 - Len(VLTemporal), " ")
        'PMSetDetalle "v" + VLTemporal + ": " + FMEspaciosATX("USD      " + Format(Trim$(VLGridImpuestos), VGFormatoMoney), 5, CGJustificacionDerecha)
        'PMSetDetalle "v" + "PREDIO RUBANO      : " + FMEspaciosATX("USD      " + Format(Trim$(VLMuniSamb(3)), VGFormatoMoney), 13, CGJustificacionDerecha)
        PMSetDetalle "v" + VLTemporal + ": " + FMEspaciosATX("USD      " + Format(Trim$(VLMuniSamb(3)), VGFormatoMoney), 13, CGJustificacionDerecha)
        PMSetDetalle "v" + "DESC/INTERES/RECAR : " + FMEspaciosATX("USD      " + Format(Trim$(VLMuniSamb(4)), VGFormatoMoney), 13, CGJustificacionDerecha)
        PMSetDetalle "v" + "TOTAL A PAGAR      : " + FMEspaciosATX("USD      " + Format(Trim$(ValorMun.Text), VGFormatoMoney), 13, CGJustificacionDerecha)
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "FORMAS DE PAGO:"
        PMSetDetalle "v" + "-------------------------------------------------"
        If val(efe.Text) > 0 Then
            PMSetDetalle "v" + "EFECTIVO           : " + FMEspaciosATX("USD      " + Format(efe, VGFormatoMoney), 13, CGJustificacionDerecha)
        End If
        If val(Cheques.Text) > 0 Then
            PMSetDetalle "v" + "CHEQUE(" + Trim$(CantChq.Text) + ")          : " + FMEspaciosATX("USD      " + Format(Cheques, VGFormatoMoney), 13, CGJustificacionDerecha)
        End If
        If val(Debito.Text) > 0 Then
            PMSetDetalle "v" + "DEBITO             : " + FMEspaciosATX("USD      " + Format(Debito, VGFormatoMoney), 13, CGJustificacionDerecha) + " CUENTA : " + Format(Cta.ClipText, "000-000000-0")
        End If
        If val(Tarjeta.Text) > 0 Then
            PMSetDetalle "v" + "TARJETA CREDITO    : " + FMEspaciosATX("USD      " + Format(Tarjeta, VGFormatoMoney), 13, CGJustificacionDerecha)
        End If
    '***ref02 vmirandt inicio, se imprime al final del documento
    If VLclave_acceso <> "" Then
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "Clave de Acceso/Autorizacion: "
        PMSetDetalle "v" + VLclave_acceso
    End If
    'ref02 vmirandt
        
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + " "
        PMSetDetalle "v" + "AVISO: PARA RETIRAR SU TITULO DE CREDITO, "
        PMSetDetalle "v" + "ACERCARSE CON ESTE COMPROBANTE A LAS VENTANILLAS DE LA"
        PMSetDetalle "v" + "OFICINA " & Me.VLOficinaRetiro
        If VLHorario = "N" Then
            PMSetDetalle "v" + "DEL BANCO BOLIVARIANO, LUEGO DE 3 DIAS LABORABLES"
            PMSetDetalle "v" + "DE HABER REALIZADO EL PAGO"
        Else
            PMSetDetalle "v" + "DEL BANCO BOLIVARIANO, LUEGO DE 4 DIAS LABORABLES"
            PMSetDetalle "v" + "DE HABER REALIZADO EL PAGO"
        End If
        PMSetDetalle "v" + " "
        PMSetDetalle "v" + ""
        
        
        VLHorarioDifTemporal = VGHorarioDif
        If VGTipoEjecucion% <> CGReverso% Then
            If VLHorario = "N" Then
                VGHorarioDif = False
                VLTrn = "3215"
            Else
                VGHorarioDif = True
                VLTrn = "3216"
            End If
        End If
        If VGTipoEjecucion% = CGReverso% Then
            If VGHorarioDif = False Then
                VLTrn = "3215"
                VLHorario = "N"
            Else
                VLTrn = "3216"
                VLHorario = "D"
            End If
        End If
        
        FMPRN_StdImpresion "IMPRESORA_1", False, Trim$(str$(VLTsnTemporal)), "19", SGDatosDetalle, "Inserte papeleta", CStr(VGpartop$), 1, CStr(VGparleft$), , , VLHorario, , , "1", VLTrn
        VGHorarioDif = VLHorarioDifTemporal
        
        If VGTipoEjecucion = CGNormal% Then
            While MsgBox("Desea Reimprimir la papeleta para certificacion?", vbYesNo, "Mensaje") = vbYes
                PMReimpresion
            Wend
        End If
    Case "4" 'Mensajes de Ayuda
        FPrincipal!pnlHelpLine.Caption = "Digite Clave Catastral"
        If Opcion2 = 13 Then
            SendKeys "{RIGHT}"
        End If
    Case "5"
        Dim vltemp As String
        Dim vlseparador As String
        Dim vlclavecatastral As String
        Dim k As Byte
        If Opcion2 = 0 Then
            vlseparador = "-"
        ElseIf Opcion2 = 1 Then
            vlseparador = "."
        End If
        For k = 1 To Len(Me.claveCatastral.Text)
            If Mid(Me.claveCatastral.Text, k, 1) = vlseparador Then
                vlclavecatastral = vlclavecatastral & vlseparador
            ElseIf Mid(Me.claveCatastral.Text, k, 1) <> "_" Then
                vltemp = FMValidarNumero((Mid(Me.claveCatastral.Text, k, 1)), 10, CInt(Mid(Me.claveCatastral.Text, k, 1)), "19")
                vlclavecatastral = vlclavecatastral & vltemp
            End If
        Next
        Muni_2235 = vlclavecatastral
    End Select
error:
Exit Function
End Function

'<--hy-05-noviembre-2007
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

Private Sub Cedula_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Ingrese Cédula/Ruc/Pasaporte"
End Sub

Private Sub CEP_Change()
FPrincipal!pnlHelpLine.Caption = "Ingrese Código CEP"
End Sub

Private Sub CEP_KeyPress(KeyAscii As Integer)
    If Me.municipio.Text = 7749 And Me.Tipo.Text = "004" Then
        If Not (KeyAscii >= 48 And KeyAscii <= 57 Or KeyAscii = 8) Then
            KeyAscii = 0
        End If
    End If
End Sub

'Private Sub Cedula_KeyDown(KeyCode As Integer, Shift As Integer)
'    Dim i As Integer
'    Dim j As Integer
'    If KeyCode <> CGTeclaF5% Then
'        Exit Sub
'    End If
'    If FLConsultar() = False Then
'        Exit Sub
'    End If
'    Frame2.Enabled = False
'    FCC19_grid.grdDetalle.Rows = grdDetalle.Rows
'    FCC19_grid.grdDetalle.Cols = grdDetalle.Cols
'    For i = 0 To grdDetalle.Rows - 1
'         For j = 0 To grdDetalle.Cols - 1
'             grdDetalle.Row = i
'             grdDetalle.Col = j
'             FCC19_grid.grdDetalle.Row = i
'             FCC19_grid.grdDetalle.Col = j
'             FCC19_grid.grdDetalle.Text = grdDetalle.Text
'         Next
'    Next
'    FCC19_grid.grdDetalle.Row = 1
'    FCC19_grid.grdDetalle.Col = 1
'    FCC19_grid.Show vbModal
'    If ValorMun > 0 Then
'        Frame1.Enabled = True
'        Efe.SetFocus
'    End If
'End Sub

Private Sub Cheques_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Ingrese Valor en Cheque"
End Sub


Private Sub claveCatastral_GotFocus()
    'GAMC - 10/03/2008 - Municipio de Salinas
    'GAMC - 09/04/2008 - Municipio de Santa Elena
    If Me.municipio.Text = "2237" Then
        Call Me.Muni_2237("4", 0)
        SendKeys ("{HOME}+{END}")
   
    Else
        Call Me.Muni_2235("4", 0)
        SendKeys ("{HOME}+{END}")
    End If
    
End Sub

Private Sub claveCatastral_KeyDown(KeyCode As Integer, Shift As Integer)
    'GAMC - 10/03/2008 - Municipio de Salinas
    Call Me.Muni_2237("4", KeyCode)
    'nchavezb Municipio Daule
    Call Me.Muni_1430("4", KeyCode)
End Sub

Private Sub claveCatastral_KeyPress(KeyAscii As Integer)
    'GAMC - 10/03/2008 - Municipio de Salinas
    Call Me.Muni_2237("4", KeyAscii)
    'nchavezb Municipio Daule 08/Agosto/2011
    Call Me.Muni_1430("4", KeyAscii)
End Sub



Private Sub Comision_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "F5 Detalle de Comision"
End Sub

Private Sub Comision_KeyDown(KeyCode As Integer, Shift As Integer)
Dim VLAcumulado As Currency
 If KeyCode% = CGTeclaF5% Then
      If Comision <> 0# Then
            '-- inicializo variables
           SGComision = 0#
           SGTipoCta = ""
           SGCedula = ""
           SGNombre = ""  'ame 07/20/2010
           SGValida = "S"
           
           'ref003 Ini
            If val(municipio.Text) = "2234" Or val(municipio.Text) = "2235" Or val(municipio.Text) = "2236" Or val(municipio.Text) = "2237" Or val(municipio.Text) = "2239" Or val(municipio.Text) = "1430" Or val(municipio.Text) = "7749" Then
              SGNumCuenta = FCC19.Cta.Text
            End If
            'ref003 Fin
     
           VLAcumulado = SGAcumulado
           
           VGUsar15 = efe.ValueReal     'eas
           
           SGUsar = VLEfe_com
           
           SGComision = Comision
           SGTipoCta = FCC19.CboTipCta.ListIndex
           SGCedula = cedula.ClipText
           
           FCC112.Show 1
           VLEfe_com = FCC112.VLEfe_com
           VLChq_com = FCC112.VLChq_com
           VLDeb_com = FCC112.VLDeb_com
           VLTipCta_com = FCC112.VLTipCta_com
           VLCta_com = FCC112.VLCta_com
           'VLNombre_com = FCC112.VLNombre_com  'ame 07/20/2010
           VLNombre_com = SGNombre 'ame 07/20/2010
           VLTotCom = VLEfe_com + VLChq_com + VLDeb_com
           
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
    VLCta = Cta.Text
    VLfirma = False
End Sub

Private Sub Efe_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Valor en Efectivo"

   'Sumadora ----->
    If SGActivaSum = False Then
        FSumIng.abrirAltaDenominacion = True
        PMIngresoEfectivo
        efe.Text = Format$(SGUsar, "####,###,##0.00")
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

Sub Form_Load()
Dim VLValorTemporal As Long

    'CGLongTramaBill = CadenaLarga   'JPM lectora de billetes
    CGLongTramaBill = CadenaCorta   'JPM lectora de billetes
    lectoraBill.Limpiar             'JPM lectora de billetes
    VLfirma = False
    VLTipoOK = False
    'Sumadora  ----->
    SGUsar = 0
    SGActivaSum = False
    SGActual = 1
    '<-----
    'Inicio Moneda
    VLMoneda = VGmoneda%
    
    VLCambio% = False
    Me.Move VGLeft%, VGTop%, 4710, 6540  '6105
   'Me.Width = 9165
   'Me.Height = 8085
   
    vlclavecatastral = ""
    VLPProducto = ""
    VLMercado = ""
    VLSolicitud = ""
    VLCodSolicitud = ""
    VLAutorizacion = ""
    
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
    efe.DecimalPlaces = FMObtenerDecimales(VGmoneda%)
    Cheques.DecimalPlaces = FMObtenerDecimales(VGmoneda%)
    Prop.DecimalPlaces = FMObtenerDecimales(VGmoneda%)
    locobj.DecimalPlaces = FMObtenerDecimales(VGmoneda%)
    plaz.DecimalPlaces = FMObtenerDecimales(VGmoneda%)
    If VGTipoLogon% = CGNormal% Then
        municipio.Connection = VGMap
        Set municipio.AsociatedLabel = sal_municipio
        municipio.Enabled = True
        Tipo.Connection = VGMap
        Set Tipo.AsociatedLabel = sal_tipo
        Tipo.Enabled = True
        'msilvag Inicio
        Me.txtTipoConsulta.Connection = VGMap
        Set txtTipoConsulta.AsociatedLabel = lblTipoConsulta
        txtTipoConsulta.Enabled = True
        'msilvag Fin
    End If
  
    'Se descomento por que si entra reverso para esta transaccion
    If VGTipoEjecucion% = CGReverso% Or VGTipoEjecucion% = CGAutoriza% Then
        If VGTipoEjecucion% = CGReverso% Then
            'Sumadora ----->
            SGPrimeraVezRev = 0
            '<----------

            PMSetValorReverso municipio, "@i_municipio"
            If municipio.Text = "7749" Then
                PMSetValorReverso Me.Tipo, "@i_tipo_impto"
            End If
            '-->lfcm 30-junio-2009
            If municipio.Text = "1434" Or (Me.municipio.Text = "7749" And Me.Tipo.Text = "002") Then 'msilvag Migracion WebService
               
               PMSetValorReverso Agno, "@i_cuota"
               VLMLNoCuota = Agno  'lfcm 07-julio-2009
               
               PMSetValorReverso txtTemporal, "@i_panio_vigencia" 'msilvag Migracion WebService"@i_cuota"
               'PMSetValorReverso txtTemporal, "@i_anioconvenio"
               VLMLAnioConvenio = txtTemporal
               PMSetValorReverso txtTemporal, "@i_pnumero" 'msilvag Migracion WebService "@i_numeroconvenio"
               VLMLNoConvenio = txtTemporal

               PMSetValorReverso txtTemporal, "@i_valorapagar"
               VLMLValoresPagar = txtTemporal
               
               PMSetValorReverso txtTemporal, "@i_valorapagar2"
               VLValorAPagar = txtTemporal
               'PMSetValorReverso txtTemporal, "@i_phoratrxlocal"
               'PMSetValorReverso txtTemporal, "@o_fechareg"
               'VLFechaRegistro = txtTemporal
               
               PMSetValorReverso txtTemporal, "@i_phora_trx_local" 'msilvag Migracion WebService "@i_phoratrxlocal"
               VLPasoHora = txtTemporal
               PMSetValorReverso txtTemporal, "@i_pfecha_trx_local"  'msilvag Migracion WebService "@i_pfechatrxlocal"
               VLPasoFecha = txtTemporal
               municipio_LostFocus
            End If
            '--<lfcm 30-junio-2009
            
            '-->hy-30-ene-2006
           ' If Me.municipio.Text <> "1417" Then
               PMSetValorReverso Comision, "@i_efe_com"
               VLEfe_com = Comision.ValueReal
               PMSetValorReverso Comision, "@i_chq_com"
               VLChq_com = Comision.ValueReal
           ' End If
            '-->lfcm 30-junio-2009
           If Me.municipio.Text <> "1434" And Me.municipio.Text <> "1433" And Me.municipio.Text <> "1417" And Me.municipio.Text <> "1435" And Me.municipio.Text <> "7749" Then      'ame 03/2010 smerino CPEP
               PMSetValorReverso Comision, "@i_deb_com"
               VLDeb_com = Comision.ValueReal
            Else
               VLDeb_com = 0
            End If
            '--<lfcm 30-junio-2009
            VLTotCom = VLEfe_com + VLChq_com + VLDeb_com
            Comision = VLTotCom
            '-->lfcm 30-junio-2009
            If Me.municipio.Text <> "1434" And Me.municipio.Text <> "1435" And Me.municipio.Text <> "1433" And Me.municipio.Text <> "1417" And Me.municipio.Text <> "1435" And Me.municipio.Text <> "7749" Then 'SMERINO CEP
               PMSetValorReverso Cta, "@i_cta_com"
               VLCta_com = Cta.ClipText
               PMSetValorReverso CboTipCta, "@i_tipocta_com"
               VLTipCta_com = CboTipCta.Text
            End If
            '--<lfcm 30-junio-2009
            If Trim$(municipio.Text) = "1433" Then
                'PMSetValorReverso txtcat1, "@i_cod_cat1"
                'PMSetValorReverso cat2, "@i_cod_cat2"
                'PMSetValorReverso cat3, "@i_cod_cat3"
                'PMSetValorReverso cat4, "@i_cod_cat4"
                'PMSetValorReverso cat5, "@i_cod_cat5"
                'PMSetValorReverso cat6, "@i_cod_cat6"
                'PMSetValorReverso cat6, "@i_cod_cat6"
                
                PMSetValorReverso txtcat1, "@i_psector"
                PMSetValorReverso cat2, "@i_pmanzana"
                PMSetValorReverso cat3, "@i_plote"
                PMSetValorReverso cat4, "@i_pdivision"
                PMSetValorReverso cat5, "@i_pphv"
                PMSetValorReverso cat6, "@i_pphh"
                PMSetValorReverso Me.Contribuyente, "@i_nombre"
                PMSetValorReverso sal_municipio, "@i_desmun"           'lfcm 04-marzo-2009
                PMSetValorReverso Agno, "@i_panio_vigencia"   'lfcm 04-marzo-2009
                PMSetValorReverso txtTemporal, "@o_pautorizacion"   'lfcm 04-marzo-2009
                VGSecBanredMG = txtTemporal
                txtTemporal = "" 'GAMC - 21ENE2010
                PMSetValorReverso txtTemporal, "@o_pcuic"   'GAMC - 21ENE2010
                VLCodigoCUIC = txtTemporal 'GAMC - 21ENE2010
                
            End If
            
            If (Me.municipio.Text <> "1430") And (Me.municipio.Text <> "2234") And (Me.municipio.Text <> "2235") And (Me.municipio.Text <> "2236") And (Me.municipio.Text <> "2237") And (Me.municipio.Text <> "2319") Then 'msilvag SOA Fase2
                PMSetValorReverso txtTemporal, "@o_ssn"
                VLSsnRevTimeOut = Trim$(txtTemporal.Text)
                If Len(Trim$(VLSsnRevTimeOut)) > 6 Then
                    VLSsnRevTimeOut = Right$(Trim$(VLSsnRevTimeOut), 6)
                Else
                    VLSsnRevTimeOut = String(6 - Len(Trim$(VLSsnRevTimeOut)), "0") + Trim$(VLSsnRevTimeOut)
                End If
            End If 'msilvag soa fase 2
            
                If (Me.municipio.Text = "1434" Or (Me.municipio.Text = "7749" And Me.Tipo.Text = "002")) Then 'msilvag Migracion Web Service Mi Lote
                   PMSetValorReverso txtTemporal, "@i_psecuencial_adq"
                    VLSsnRevTimeOut = Trim$(txtTemporal.Text)
                End If
            
             '-->lfcm 30-junio-2009
            If Me.municipio.Text <> "1434" And Me.municipio.Text <> "1435" And Me.municipio.Text <> "7749" Then 'SMERINO CEP
                'PMSetValorReverso txtTemporal, "@i_totaltrama"
                
                'VLValorTemporal = CDbl(txtTemporal.Text) * 100
                'VLTotalTrama = String(12 - Len(Trim$(Str$(VLValorTemporal))), "0") + Trim$(Str$(VLValorTemporal))
                
                'PMSetValorReverso txtTemporal, "@i_horatrama"
                'VLHoraReversar = txtTemporal.Text
                
                'PMSetValorReverso txtTemporal, "@o_fecha_ef"
                'VLFechaEfe = txtTemporal.Text
                
                PMSetValorReverso txtTemporal, "@i_nombre"
                VLNombreCliente = txtTemporal.Text

                'PMSetValorReverso txtTemporal, "@i_vlfechora"
                'VLFecHora = txtTemporal.Text

                'PMSetValorReverso txtTemporal, "@i_vlfeccontable"
                'VLFecContable = txtTemporal.Text
             End If
             '--<lfcm 30-junio-2009
                '-->hy-14-agosto-2006
                If Trim$(municipio.Text) = "1417" Then
                    ' ame 08/28/2012 VLDatoOriginal = VLSsnRevTimeOut + Mid$(VLFecHora, 1, 14) + "1007" + String(6 - Len(Trim$(Str$(VGOficina))), "0") + Trim$(Str$(VGOficina)) + String(6 - Len(Trim$(VGUsuario)), "0") + VGUsuario
                    VLDatoOriginal = VLSsnRevTimeOut + Mid$(VLFecHora, 1, 14) + "0233" + String(6 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) + String(6 - Len(Trim$(VGUsuario)), "0") + VGUsuario
                    PMSetValorReverso Tipo, "@i_tipo_impto"   'lfcm 02-marzo-2009
                    PMSetValorReverso sal_municipio, "@i_sal_municipio"   'lfcm 02-marzo-2009
                    
                    PMSetValorReverso efe, "@i_efe"   'lfcm 02-marzo-2009
                    PMSetValorReverso Cheques, "@i_cheque"   'lfcm 02-marzo-2009
                    PMSetValorReverso Debito, "@i_debito"   'lfcm 02-marzo-2009
                    PMSetValorReverso Tarjeta, "@i_tarjeta"   'lfcm 02-marzo-2009
                    Me.ValorMun.Text = CCur(efe.Text) + CCur(Cheques.Text) + CCur(Debito.Text) + CCur(Tarjeta.Text)
                    PMSetValorReverso Contribuyente, "@i_nombre"   'lfcm 02-marzo-2009
                    PMSetValorReverso txtTemporal, "@i_identifica"
                    cedula.Text = txtTemporal.Text
                    PMSetValorReverso cedula, "@i_identifica" 'lfcm 02-marzo-2009
                 
                    PMSetValorReverso txt_tmp_mim, "@o_pintereses"   'lfcm 02-marzo-2009
                    If Me.txt_tmp_mim <> "" Then
                    VLValorInteres = Me.txt_tmp_mim / 100
                    End If
                    
                    PMSetValorReverso txt_tmp_mim, "@o_pdescuento"   'lfcm 02-marzo-2009
                    If Me.txt_tmp_mim <> "" Then
                      VLValorDescuentos = Me.txt_tmp_mim / 100
                    End If
                    PMSetValorReverso txt_tmp_mim, "@o_precargo"   'lfcm 02-marzo-2009
                    If Me.txt_tmp_mim <> "" Then
                    VLValorRecargo = Me.txt_tmp_mim / 100
                    End If
                    
                    PMSetValorReverso txt_tmp_mim, "@o_pcostas" 'lfcm 02-marzo-2009
                    If Me.txt_tmp_mim <> "" Then
                    VLValorCostas = Me.txt_tmp_mim / 100
                    End If
                    PMSetValorReverso txt_tmp_mim, "@i_dirmimq"   'lfcm 02-marzo-2009
                    VLDireccion = Me.txt_tmp_mim
                    
                    PMSetValorReverso txt_tmp_mim, "@i_pvalores_pago2"   'lfcm 02-marzo-2009
                    Agno.Tag = Me.txt_tmp_mim
                    
                    'PMSetValorReverso txt_tmp_mim, "@i_psecbr"   'lfcm 02-marzo-2009
                    PMSetValorReverso txt_tmp_mim, "@o_pautorizacion"   'lfcm 02-marzo-2009
                    VLNumeroAutorizacion = txt_tmp_mim
                    VLNumeroAutorizacion = Format(VLNumeroAutorizacion, "0000000000")
                    
                    'PMSetValorReverso txt_tmp_mim, "@o_dacodexon"   'lfcm 02-marzo-2009
                    'VLExoneracion = txt_tmp_mim
                    
                    'msilvag RECMPS-977 no se esta guardando esta informacion
                    'PMSetValorReverso txt_tmp_mim, "@o_danumcasa"   'lfcm 02-marzo-2009
                    'VLNoCasa = txt_tmp_mim
                    'msilvag Fin
                    
                    PMSetValorReverso txt_tmp_mim, "@o_padicionales" 'lfcm 02-marzo-2009
                    'VLNoCasa = Mid(txt_tmp_mim, 1, 1)

                    'PMSetValorReverso txt_tmp_mim, "@o_pdocumento"   'lfcm 02-marzo-2009
                    'VLIdentificacion = txt_tmp_mim
                    
                    'PMSetValorReverso txt_tmp_mim, "@o_daclavecatastro"   'lfcm 02-marzo-2009
                    'vlclavecatastral = txt_tmp_mim
                    
'                    PMSetValorReverso txt_tmp_mim, "@o_pintereses"   'lfcm 02-marzo-2009
'                    VLValorInteres = txt_tmp_mim
'
'                    PMSetValorReverso txt_tmp_mim, "@o_pdescuento"   'lfcm 02-marzo-2009
'                    VLValorDescuentos = txt_tmp_mim
'
'                    PMSetValorReverso txt_tmp_mim, "@o_precargo"   'lfcm 02-marzo-2009
'                    VLValorRecargo = txt_tmp_mim
'
'                    PMSetValorReverso txt_tmp_mim, "@o_pcostas"   'lfcm 02-marzo-2009
'                    VLValorCostas = txt_tmp_mim
                    
                    'msilvag RECMPS-977 no se esta guardando esta informacion
                    'PMSetValorReverso txt_tmp_mim, "@o_dadireccion"   'lfcm 02-marzo-2009
                    'VLDireccion = txt_tmp_mim
                    'msilvag Fin
                    
                    PMSetValorReverso txt_tmp_mim, "@i_cedruc"   'lfcm 02-marzo-2009
                    VLIdentificacion = txt_tmp_mim
                    
                    PMSetValorReverso txt_tmp_mim, "@i_ptrx_original1"   'lfcm 02-marzo-2009
                    VLTmptmp = txt_tmp_mim
                    
                    PMSetValorReverso txt_tmp_mim, "@i_titulo"   'lfcm 02-marzo-2009
                    txt_tmp_mim = txt_tmp_mim + VLTmptmp
                    
                    PMSetValorReverso sal_tipo, "@i_tipoimpto"   'lfcm 02-marzo-2009
                    PMSetValorReverso Agno, "@i_agno"   'lfcm 02-marzo-2009
                    PMSetValorReverso Impto, "@i_cod_impto"   'lfcm 02-marzo-2009
                                        
                    PMSetValorReverso txtTemporal, "@i_pvalores_pago1"
                    VLArregloPago1 = txtTemporal.Text
                    PMSetValorReverso txtTemporal, "@i_pvalores_pago2"
                    VLArregloPago2 = txtTemporal.Text
                               
                   If Trim$(VLArregloPago1) = "" Then
                      PMSetValorReverso txtTemporal, "@i_pvalores_pago1_2"
                      VLArregloPago1 = Trim$(VLValoresPago1) + Trim$(txtTemporal.Text)
                   End If
                   If Trim$(VLArregloPago2) = "" Then
                      PMSetValorReverso txtTemporal, "@i_pvalores_pago2_2"
                      VLArregloPago2 = Trim$(VLValoresPago2) + Trim$(txtTemporal.Text)
                   End If
                     
                                        
                                        
                End If
                '<--hy-14-agosto-2006
            'End If
            '<--hy-30-ene-2006
            
            '-->lfcm 30-junio-2009
             If Me.municipio.Text <> "1434" And Trim$(municipio.Text) <> "1433" And Trim$(municipio.Text) <> "1417" And Trim$(municipio.Text) <> "1800" And Me.municipio.Text <> "1435" And Me.municipio.Text <> "7749" Then 'SMERINO CEP
               '-->hy-14-agosto-2006
               
               PMSetValorReverso Tipo, "@i_cod_impto"
               PMSetValorReverso Tipo, "@i_tipo_impto"
               
               '<--hy-14-agosto-2006
            End If
            '--<lfcm 30-junio-2009
            
            'If Trim$(municipio.Text) = "1417" Then  'hy-21-diciembre-2006 [pase rezagado]
                'If Trim$(municipio.Text) <> "2319" Then 'GAMC - 24/02/2008
                'If Trim$(municipio.Text) <> "2319" And Trim$(municipio.Text) <> "2237" Then 'GAMC - 17/03/2008
                'If Trim$(municipio.Text) <> "2319" And Trim$(municipio.Text) <> "2237" And Trim$(municipio.Text) <> "2235" Then 'GAMC - 14/04/2008
                
                If Trim$(municipio.Text) <> "2319" And Trim$(municipio.Text) <> "2237" And Trim$(municipio.Text) <> "2235" And Trim$(municipio.Text) <> "2236" And Trim$(municipio.Text) <> "1417" And Trim$(municipio.Text) <> "1430" And (Trim$(municipio.Text) <> "7749" And Trim$(Me.Tipo.Text) <> "004") Then   'Wise - 18/Agt/2008 M. Libertad=2236 SMERINO CEP
                    PMSetValorReverso cedula, "@i_identifica"
                End If
            'End If
            '-->hy-14-agosto-2006
            If Trim$(municipio.Text) = "1417" Then
                PMSetValorReverso txtTemporal, "@i_identifica"
                VLIdenReverso = txtTemporal.Text
                PMSetValorReverso txtLlave, "@i_identifica"
            End If
            '<--hy-14-agosto-2006
            '-->hy-22-febrero-2007
            If Trim$(municipio.Text) = "1800" Then
                PMSetValorReverso Tipo, "@i_tipo_impto"
                PMSetValorReverso txtLlaveMunicipal, "@i_identifica"
                PMSetValorReverso descripcion, "@i_ref_servicio"
                PMSetValorReverso Agno, "@i_agno"
                
                PMSetValorReverso txtTemporal, "@i_pvalores_pago1"
                VLValoresPago1 = txtTemporal.Text
                PMSetValorReverso txtTemporal, "@i_pvalores_pago2"
                VLValoresPago2 = txtTemporal.Text
                
                'lfcm 20-junio-2007 (4 lineas siguientes)
                If Trim$(VLValoresPago1) = "" Then
                   PMSetValorReverso txtTemporal, "@i_pvalores_pago1_2"
                   VLValoresPago1 = Trim$(VLValoresPago1) + Trim$(txtTemporal.Text)
                End If
                If VLValoresPago2 = "" Then
                   PMSetValorReverso txtTemporal, "@i_pvalores_pago2_2"
                   VLValoresPago2 = Trim$(VLValoresPago2) + Trim$(txtTemporal.Text)
                End If
                
                PMSetValorReverso txtTemporal, "@i_psecuencial_adq"
                VLSecuencialAdqMunCue = txtTemporal.Text
                
                VLSecuencialAdqMunCue = String(6 - Len(Trim$(VLSecuencialAdqMunCue)), "0") + Trim$(VLSecuencialAdqMunCue)
                
                PMSetValorReverso txtTemporal, "@i_pfecha_trx_local"
                VLFechaMunCue = txtTemporal.Text
                PMSetValorReverso txtTemporal, "@i_phora_trx_local"
                VLHoraMunCue = txtTemporal.Text
                PMSetValorReverso txtTemporal, "@o_pautorizacion"
                VLAutorizacionMunCue = txtTemporal.Text
                PMSetValorReverso txtTemporal, "@i_mc_emision"
                VLMunCue_Emision = txtTemporal.Text
                PMSetValorReverso txtTemporal, "@i_mc_exoneracion"
                VLMunCue_Exoneracion = txtTemporal.Text
                PMSetValorReverso txtTemporal, "@i_mc_descuentos"
                VLMunCue_Descuentos = txtTemporal.Text
                PMSetValorReverso txtTemporal, "@i_mc_recargos"
                VLMunCue_Recargos = txtTemporal.Text
                PMSetValorReverso txtTemporal, "@i_mc_intereses"
                VLMunCue_Intereses = txtTemporal.Text
                PMSetValorReverso txtTemporal, "@i_mc_total"
                VLMunCue_Total = txtTemporal.Text
                PMSetValorReverso txtTemporal, "@i_mc_direccion"
                VLDireccion = txtTemporal.Text
                If Tipo.Text = "003" Then
                   Etiqueta2.Caption = "Céd./RUC:"
                Else
                   Etiqueta2.Caption = "CLAVE CATASTRAL:"
                End If
                Etiqueta3.Top = 555
                Tipo.Top = 555
                sal_tipo.Top = 555
                txtLlaveMunicipal.Top = 880 ' ame 06/30/2010
                Etiqueta2.Top = 880 ' ame 06/30/20
            End If
            '<--hy-22-febrero-2007
            
            '-->lfcm 30-junio-2009
             If Me.municipio.Text <> "1434" And Me.municipio.Text <> "1433" And Me.municipio.Text <> "1417" And Me.municipio.Text <> "1435" And Me.municipio.Text <> "7749" Then 'SMERINO CEP
               PMSetValorReverso Contribuyente, "@i_contribuyente"
            End If
            '--<lfcm 30-junio-2009
            If Trim$(municipio.Text) = "2234" Then
                PMSetValorReverso Predio, "@i_catastro"
            ElseIf Trim$(municipio.Text) = "2319" Then 'GAMC - 24/02/2008
                'PMSetValorReverso Predio, "@i_catastro2"
                Dim catastro As String
                Dim tmp As String
                PMSetValorReverso txtCatasSamb, "@i_catastro2"
                catastro = txtCatasSamb.Text
                txtCatasSamb.Text = ""
                PMSetValorReverso txtCatasSamb, "@i_catastro3"
                catastro = catastro + txtCatasSamb.Text
                txtCatasSamb.Text = ""
                PMSetValorReverso txtCatasSamb, "@i_catastro4"
                If txtCatasSamb.Text <> "" Then
                    catastro = catastro + txtCatasSamb.Text
                End If
                Me.txtCatasSamb.Text = catastro
                PMSetValorReverso Impto, "@i_cod_impto"
                Impto.Tag = Impto.Caption
                Impto.Caption = ""
                PMSetValorReverso Impto, "@i_nom_impto"
                tmp = Impto.Caption
                Impto.Caption = Impto.Tag
                Impto.Tag = tmp
                Predio = Me.txtCatasSamb.Text
            ElseIf Trim$(municipio.Text) = "2237" Then 'GAMC - 17/03/2008
                Call Muni_2237("1", 1)
            ElseIf Trim$(municipio.Text) = "2235" Then 'GAMC - 14/04/2008
                Call Muni_2235("1", 1)
            ElseIf Trim$(municipio.Text) = "2236" Then 'Wise - 18/Agt/2008 M. Libertad=2236
                Call Muni_2236("1", 1)
            ElseIf Trim$(municipio.Text) = "1430" Then ' nchavezb 04/Agosto/2011 Municipio Daule
                Call Muni_1430("1", 1)
            
            Else
               '-->lfcm 30-junio-2009 MiLote
               If Me.municipio.Text <> "1434" And Me.municipio.Text <> "1433" And Me.municipio.Text <> "1417" And Me.municipio.Text <> "1800" And Me.municipio.Text <> "1435" And Me.municipio.Text <> "1430" And Me.municipio.Text <> "7749" Then 'SMERINO
                PMSetValorReverso Predio, "@i_no_predio"
               End If
               '--<lfcm 30-junio-2009 MiLote
               
               
            End If
            '-->lfcm 30-junio-2009 MiLote
             If Me.municipio.Text <> "1434" And Me.municipio.Text <> "1433" And Me.municipio.Text <> "1800" And Me.municipio.Text <> "1435" And Me.municipio.Text <> "7749" Then  'SMERINO CEP
               PMSetValorReverso Impto, "@i_cod_impto"
               'PMSetValorReverso Prioridad, "@i_referencia"
            End If
            '--<lfcm 30-junio-2009 MiLote
            If Trim$(municipio.Text) = "2234" Then
                PMSetValorReverso txtTemporal, "@i_nom_impto"
                VLNombreImpuesto = txtTemporal.Text
                Impto.Tag = VLNombreImpuesto
                PMSetValorReverso txtTemporal, "@i_fecven"
                VLGridFecVen = txtTemporal.Text
            End If
'            If Me.municipio.Text = "1430" Then
'                  PMSetValorReverso txtTemporal, "@i_no_predio"
'                  Me.txtCatasSamb.Text = txtTemporal
'            End If
               
            '-->lfcm 30-junio-2009 MiLote
            If Me.municipio.Text <> "1434" And Me.municipio.Text <> "1433" And Me.municipio.Text <> "1417" And Me.municipio.Text <> "1800" And Me.municipio.Text <> "1435" And Me.municipio.Text <> "1430" And Me.municipio.Text <> "1434" And Me.municipio.Text <> "7749" Then 'SMERINO CEP
               PMSetValorReverso Agno, "@i_agno"
               PMSetValorReverso Semestre, "@i_semestre"
            End If
'            If Me.municipio.Text = "1430" Then
'               PMSetValorReverso Agno, "@i_agno"
'            End If
            '--<lfcm 30-junio-2009 MiLote
            PMSetValorReverso efe, "@i_efe"
            PMSetValorReverso CantChq, "@i_cant_chq"
            PMSetValorReverso Cheques, "@i_cheque"
            PMSetValorReverso CboTipCta, "@i_producto"
            PMSetValorReverso Cta, "@i_cuenta"
            PMSetValorReverso Debito, "@i_debito"
            '-->lfcm 30-junio-2009 MiLote
            If Me.municipio.Text <> "1434" Then
               If Trim$(Tipo.Text) <> "002" Then
                    PMSetValorReverso Tarjeta, "@i_tarjeta"
                End If
            End If
            '--<lfcm 30-junio-2009 MiLote
            'PMSetValorReverso Total, "@i_valor_mun"  hy-30-ene-2006
            '-->lfcm 30-junio-2009 MiLote
              If Me.municipio.Text <> "1434" And Me.municipio.Text <> "1433" And Me.municipio.Text <> "1417" And Me.municipio.Text <> "1435" And Me.municipio.Text <> "7749" Then
               PMSetValorReverso ValorMun, "@i_valor_mun"
            End If
            '--<lfcm 30-junio-2009 MiLote
            'If Trim$(municipio.Text) <> "1800" Then  'hy-22-febrero-2007
            If Trim$(municipio.Text) <> "1800" And Trim$(municipio.Text) <> "1434" And Me.municipio.Text <> "1433" And Me.municipio.Text <> "1417" And Me.municipio.Text <> "1435" And Me.municipio.Text <> "7749" Then   'lfcm 30-junio-2008
                PMSetValorReverso ValImpto, "@i_valimpto"
                PMSetValorReverso ValInteres, "@i_valinteres"
            End If  'hy-22-febrero-2007
            
            
            '-->lfcm 30-junio-2009 MiLote
            'If Me.municipio.Text <> "1434" Then
            If Trim$(municipio.Text) <> "1433" And Trim$(municipio.Text) <> "1417" And Me.municipio.Text <> "1435" And Me.municipio.Text <> "7749" Then   'lfcm 13-febrero-2009 SMERINO CEP
               PMSetValorReverso sal_municipio, "@i_sal_municipio"
            End If
            'End If
            '--<lfcm 30-junio-2009 MiLote
            
            If Trim$(municipio.Text) <> "1433" And Trim$(municipio.Text) <> "1434" And Trim$(municipio.Text) <> "1800" And Trim$(municipio.Text) <> "1417" And Me.municipio.Text <> "1435" And Me.municipio.Text <> "7749" Then 'SMERINO CEP
                PMSetValorReverso sal_tipo, "@i_desc_impto"
            Else
               '-->lfcm 30-junio-2009 MiLote
               If Me.municipio.Text <> "1434" And Trim$(municipio.Text) <> "1433" And Trim$(municipio.Text) <> "1417" And Me.municipio.Text <> "1435" And Me.municipio.Text <> "7749" Then  'lfcm 13-febrero-2009 SMERINO CEP
                  PMSetValorReverso txtTemporal, "@i_sal_tipo"
                  sal_tipo.Caption = txtTemporal.Text
                  PMSetValorReverso txtTemporal, "@i_vlexoneracion"
                  VLExoneracion = txtTemporal.Text
                  PMSetValorReverso txtTemporal, "@i_vlavaluocomercial"
                  VLAvaluoComercial = txtTemporal.Text
                  '-->hy-22-septiembre-2006
                  PMSetValorReverso txtTemporal, "@i_VLIdentificacion"
                  VLIdentificacion = txtTemporal.Text
                  '<--hy-22-septiembre-2006
               End If
               '--<lfcm 30-junio-2009 MiLote
            End If
            '-->lfcm 30-junio-2009 MiLote
            If Me.municipio.Text <> "1434" And Trim$(municipio.Text) <> "1433" And Trim$(municipio.Text) <> "1417" And Me.municipio.Text <> "1435" And Me.municipio.Text <> "7749" Then
               PMSetValorReverso DescripImpto, "@i_desc_impto"
               PMSetValorReverso direccion, "@i_direccion"
            End If
            '--<lfcm 30-junio-2009 MiLote
            If Trim$(municipio.Text) = "2234" Then
                PMSetValorReverso Prioridad, "@i_referencia"
            'ElseIf Trim$(municipio.Text) <> "2319" Then 'GAMC - 24/02/2008
            'ElseIf Trim$(municipio.Text) <> "2319" And Trim$(municipio.Text) <> "2237" Then  'GAMC - 17/03/2008
            'ElseIf Trim$(municipio.Text) <> "2319" And Trim$(municipio.Text) <> "2237" And Trim$(municipio.Text) <> "2235" Then  'GAMC - 14/04/2008
            'ElseIf Trim$(municipio.Text) <> "2319" And Trim$(municipio.Text) <> "2237" And Trim$(municipio.Text) <> "2235" And Trim$(municipio.Text) <> "2236" Then  'Wise - 18/Agt/2008 M. Libertad=2236
            ElseIf Trim$(municipio.Text) <> "2319" And Trim$(municipio.Text) <> "2237" And Trim$(municipio.Text) <> "2235" And Trim$(municipio.Text) <> "2236" And Trim$(municipio.Text) <> "1434" Then   'lfcm 30-junio-2009
                If Trim$(municipio.Text) <> "1433" And Trim$(municipio.Text) <> "1417" And Me.municipio.Text <> "1800" And Me.municipio.Text <> "1435" And Me.municipio.Text <> "1430" And Me.municipio.Text <> "7749" Then     'lfcm 13-febrero-2009
                     PMSetValorReverso Prioridad, "@i_prioridad"
                End If   'lfcm 13-febrero-2009
            End If
            
            If Trim$(municipio.Text) <> "1430" And Trim$(municipio.Text) <> "2234" And Trim$(municipio.Text) <> "2235" And Trim$(municipio.Text) <> "2236" And Trim$(municipio.Text) <> "2237" And Trim$(municipio.Text) <> "2319" Then
                PMSetValorReverso txthorario, "@o_horario"
            End If 'msilvag Otros Municipios
            
            '-->hy-15-feb-2006
            PMSetValorReverso cat1, "@i_municipio"
            
'            '-->hy-14-agosto-2006
            If Trim$(municipio.Text) = "1417" Then
                PMSetValorReverso txtTitulo, "@i_titulo"   'hy-22-septiembre-2006 antes @i_municipio ahora @i_titulo
                Agno.Tag = txtTitulo.Text
            End If
'            '<--hy-14-agosto-2006
'           'REVERSO DE MUNICIPIO
            If Trim$(municipio.Text) = "1435" Or (Trim$(municipio.Text) = "7749" And Me.Tipo.Text = "003") Then
                'PMSetValorReverso txtTemporal, "@i_no_predio"
                'Agno = String(3 - Len(Trim$(txtTemporal.Text)), "0") + Trim$(txtTemporal.Text)
            
                PMSetValorReverso sal_municipio, "@i_desmun"
                PMSetValorReverso cedula, "@i_identifica"
                PMSetValorReverso txtTemporal, "@i_pnumero" '"@i_pid_deuda"
                VLIdenDeuda = txtTemporal.Text
                PMSetValorReverso Contribuyente, "@i_nombre"
                PMSetValorReverso Tipo, "@i_tipo_impto"
                PMSetValorReverso txtTemporal, "@i_sal_tipo"
                sal_tipo.Caption = txtTemporal.Text
               
                PMSetValorReverso txtTemporal, "@i_pcodigo_puesto1"
                vlclavecatastral = txtTemporal.Text
                PMSetValorReverso txtTemporal, "@i_nom_mercado"
                VLMercado = txtTemporal.Text
                PMSetValorReverso txtTemporal, "@i_cod_solicitud"
                VLCodSolicitud = txtTemporal.Text
                
                
                PMSetValorReverso efe, "@i_efe"
                PMSetValorReverso CantChq, "@i_cant_chq"
                PMSetValorReverso Cheques, "@i_cheque"
                PMSetValorReverso CboTipCta, "@i_producto"
                PMSetValorReverso Cta, "@i_cuenta"
                VLCta_com = Cta.ClipText
                PMSetValorReverso Debito, "@i_debito"
                PMSetValorReverso ValorMun, "@i_pvalor_total"
                PMSetValorReverso txtTemporal, "@i_valorapagar" 'msilvag Migracion WebService "@i_pvalores_pago1"
                'VLArregloMunCre = txtTemporal.Text
                VLMLValoresPagar = txtTemporal.Text 'VLMLValoresPagar
                PMSetValorReverso txtTemporal, "@i_psecuencial_adq"
                VLSecuencialAdqMunCue = txtTemporal.Text
                PMSetValorReverso txtTemporal, "@i_pfecha_trx_local"
                'VLFechaMunCue = txtTemporal.Text
                VLFecContable_aaaammdd = txtTemporal.Text
                PMSetValorReverso txtTemporal, "@i_phora_trx_local"
                VLHoraMunCue = String(6 - Len(Trim$(txtTemporal.Text)), "0") + Trim$(txtTemporal.Text)
                'VLArregloMunCre =
'                PMSetValorReverso Cta, "@i_cta_com"
'                VLCta_com = Cta.ClipText
                PMSetValorReverso CboTipCta, "@i_tipocta_com"
                VLTipCta_com = CboTipCta.Text
                'msilvag Inicio Migracion WebService
                PMSetValorReverso txtTemporal, "@o_pautorizacion"
                VLAutorizacionCep = txtTemporal.Text
                'msilvag Fin
            End If
            
            
            
            
            Select Case Trim$(municipio.Text)
            Case "1417", "1800"  'hy-22-febrero-2007
                '-->hy-22-febrero-2007
                If Trim$(municipio.Text) = "1417" Then
                    Tipo.TableName = "sv_impto_mun"
                Else
                    Tipo.TableName = "sv_impto_muncue"
                End If
                '<--hy-22-febrero-2007
                If Trim$(municipio.Text) = "1417" Then       'hy-22-febrero-2007
                    Etiqueta2.Caption = "No.PREDIO/PATENTE/VARIOS"
                Else                                         'hy-22-febrero-2007
                    If Tipo.Text = "003" Then
                       Etiqueta2.Caption = "Céd./RUC:"
                    Else
                       Etiqueta2.Caption = "CLAVE CATASTRAL:"
                    End If
                        Etiqueta3.Top = 555
                        Tipo.Top = 555
                        sal_tipo.Top = 555
                        txtLlaveMunicipal.Top = 880 ' ame 06/30/2010
                        Etiqueta2.Top = 880 ' ame 06/30/20

                End If                                       'hy-22-febrero-2007
                'Etiqueta2.Visible = True 'hy-21-diciembre-2006 [pase rezagado]
                Etiqueta3.Caption = "TIPO IMPUESTO"
                'Etiqueta3.Top = 880 'hy-21-diciembre-2006 [pase rezagado]
                Tipo.Visible = True
                sal_tipo.Visible = True
                cat1.Visible = False
                cat2.Visible = False
                cat3.Visible = False
                cat4.Visible = False
                cat5.Visible = False
                cat6.Visible = False
                Etiqueta5.Visible = True
                Etiqueta6.Visible = True
                Predio.Visible = True
                Impto.Visible = True
                Etiqueta8.Visible = False  'hy-14-agosto-2006 antes true
                Semestre.Visible = False  'hy-14-agosto-2006 antes true
                Agno.Left = 1440
                Contribuyente.Height = 285
                Select Case Trim$(municipio.Text)       'hy-22-febrero-2007
                Case "1417"                             'hy-22-febrero-2007
                    cedula.Visible = True 'hy-21-diciembre-2006 [pase rezagado]
                    'cedula.Visible = False              'hy-22-febrero-2007
                    txtLlaveMunicipal.Visible = False   'hy-22-febrero-2007
                Case "1800"                             'hy-22-febrero-2007
                    cedula.Visible = False              'hy-22-febrero-2007
                    txtLlaveMunicipal.Visible = True    'hy-22-febrero-2007
                    txtLlaveMunicipal.Top = 880         ' ame 06/30/2010
                    Etiqueta5.Caption = "Impto./Rubro:" ' ame 06/30/2010
                    Etiqueta7.Caption = "Año/Dividendo:" ' ame 06/30/2010
                    Agno.Left = 2010                     ' ame 06/30/2010
                    Etiqueta6.Visible = False           ' ame 06/30/2010
                    Impto.Visible = False               ' ame 06/30/2010
                    Predio.Visible = False
                    descripcion.Visible = True ' ame 06/30/2010
                    descripcion.Width = 2295 ' ame 06/30/2010
                    
                    
                End Select                              'hy-22-febrero-2007
            Case "1433"
                Etiqueta2.Caption = "CEDULA/RUC"     'lfcm 29-octubre-2008
                Etiqueta2.Visible = False
                Etiqueta2.Visible = False 'hy-21-diciembre-2006 [pase rezagado]
                Etiqueta3.Caption = "Cod. Catastral"
                Tipo.Visible = False
                sal_tipo.Visible = False
                txtcat1.Visible = True
                cat2.Visible = True
                cat3.Visible = True
                cat4.Visible = True
                cat5.Visible = True
                cat6.Visible = True
                Etiqueta5.Visible = False
                Etiqueta6.Visible = False
                Etiqueta8.Visible = False
                Semestre.Visible = False
                Predio.Visible = False
                Impto.Visible = False
                Agno.Left = 2010
                Contribuyente.Height = 570
                '-->hy-21-diciembre-2006 [pase rezagado]
                cedula.Visible = False                 'lfcm 29-octubre-2008
                'txtLlaveMunicipal.Visible = False  'hy-22-febrero-2007
                Etiqueta3.Top = 700     'lfcm 29-octubre-2008
                txtcat1.Top = 700       'lfcm 29-octubre-2008
                cat1.Top = 700          'lfcm 29-octubre-2008
                cat2.Top = 700          'lfcm 29-octubre-2008
                cat3.Top = 700          'lfcm 29-octubre-2008
                cat4.Top = 700          'lfcm 29-octubre-2008
                cat5.Top = 700          'lfcm 29-octubre-2008
                cat6.Top = 700          'lfcm 29-octubre-2008
                '<--hy-21-diciembre-2006 [pase rezagado]
            Case "2319" 'GAMC - 24/02/2008
                Call Muni_2319("1")
                
                PMSetValorReverso txtPapeletaSamb, "@o_referencia2"
                VLMuniSamb(0) = txtPapeletaSamb.Text
                txtPapeletaSamb.Text = ""
                PMSetValorReverso txtPapeletaSamb, "@o_direccion"
                VLMuniSamb(1) = txtPapeletaSamb.Text
                txtPapeletaSamb.Text = ""
                PMSetValorReverso txtPapeletaSamb, "@o_solar"
                VLMuniSamb(2) = txtPapeletaSamb.Text
                txtPapeletaSamb.Text = ""
                PMSetValorReverso txtPapeletaSamb, "@o_valorpredio"
                VLMuniSamb(3) = txtPapeletaSamb.Text
                txtPapeletaSamb.Text = ""
                PMSetValorReverso txtPapeletaSamb, "@o_valorotros"
                VLMuniSamb(4) = txtPapeletaSamb.Text
                txtPapeletaSamb.Text = ""
            Case "1434"   'MiLote
               PMSetValorReverso Contribuyente, "@i_nombre"
               ValorMun = CDbl(Me.efe.Text) + CDbl(Me.Cheques.Text) + CDbl(Me.Debito.Text)
               
            Case "1435" 'mercado y credenciales nchavezb
                'Parte Superior de la Pantalla
                Me.Etiqueta2.Visible = True
                Me.Etiqueta3.Visible = True
                Me.Etiqueta3.Caption = "No. Cédula: "
                Me.Etiqueta2.Caption = "Tipo de Consulta"
                
                Tipo.TableName = "sv_impto_mungye"
                Tipo.Visible = True
                Me.Tipo.Top = 555
                'Me.Tipo.SetFocus
                Me.sal_tipo.Visible = True
                Me.sal_tipo.Top = 555
                Me.cedula.Left = 1800
                Me.cedula.Top = 880
                Me.cedula.Visible = True
                Me.cedula.TabIndex = 3
                Me.cat1.Visible = False
                Me.cat2.Visible = False
                Me.cat3.Visible = False
                Me.cat4.Visible = False
                Me.cat5.Visible = False
                Me.cat6.Visible = False
                'Me.cedula.maxlenght
              
              'Parte Previa a Formas de Pago
                Me.Agno.Left = 2010
                Etiqueta5.Visible = False
                Etiqueta6.Visible = False
                Etiqueta8.Visible = False
                Predio.Visible = False
                Impto.Visible = False
                Semestre.Visible = False
                Etiqueta7.Caption = "No. Abono:"
                Contribuyente.Height = 570
            End Select
            
            '<--hy-15-feb-2006

            Tipo.Text = Tipo.Tag
            municipio.Text = municipio.Tag
            
            SGUsar = CDbl(efe.Text + VLEfe_com)  'hy-30-ene-2006 se adiciono vlefe_com
        End If
    End If
    If Me.municipio.Text = "1433" Then
        Me.ValorMun.Text = FMCCurATX((efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((Debito.Text)) + FMCCurATX((Tarjeta.Text))
        Total.Text = FMCCurATX((efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((Debito.Text)) + FMCCurATX((Tarjeta.Text)) + FMCCurATX((Comision.Text))
    Else
        Total.Text = CDbl(ValorMun.Text) + CDbl(Comision)  'hy-30-ene-2006
    End If
        
    If Me.municipio.Text = "7749" Then   'MUNICIPIOS MIGRACION
    
        If Trim$(Tipo.Text) = "004" Then   'CEP
            Me.Etiqueta2.Visible = True
            Me.Etiqueta3.Visible = True
            Me.Etiqueta3.Caption = "Cód. CEP: "
            Me.Etiqueta2.Caption = "Tipo de Impuesto"
            Tipo.TableName = "sv_impto_mungye_cep"
            Tipo.Visible = True
            Tipo.Enabled = False
            Me.Tipo.Top = 555
            Me.sal_tipo.Visible = True
            Me.sal_tipo.Top = 555
            Me.cedula.Visible = False
            Me.CEP.Left = 1800
            Me.CEP.Top = 880
            Me.CEP.Visible = True
            Me.CEP.TabIndex = 5
            Me.cat1.Visible = False
            Me.cat2.Visible = False
            Me.cat3.Visible = False
            Me.cat4.Visible = False
            Me.cat5.Visible = False
            Me.cat6.Visible = False
            'Parte Previa a Formas de Pago
            Me.Agno.Left = 2010
            Me.Agno.Width = 2295
            Etiqueta5.Visible = False
            Etiqueta6.Visible = False
            Etiqueta8.Visible = False
            Predio.Visible = False
            Impto.Visible = False
            Semestre.Visible = False
            Etiqueta7.Caption = "Descripción del CEP"
            Contribuyente.Height = 570
            CantChq.Enabled = True
            PMSetValorReverso efe, "@i_efe"
            PMSetValorReverso CantChq, "@i_cant_chq"
            PMSetValorReverso Cheques, "@i_cheque"
            PMSetValorReverso CboTipCta, "@i_producto"
            PMSetValorReverso Cta, "@i_cuenta"
            VLCta_com = Cta.ClipText
            PMSetValorReverso Debito, "@i_debito"
            PMSetValorReverso ValorMun, "@i_pvalor_total"
            PMSetValorReverso Tarjeta, "@i_tarjeta"
            Me.ValorMun.Text = CCur(efe.Text) + CCur(Cheques.Text) + CCur(Debito.Text) + CCur(Tarjeta.Text)
            PMSetValorReverso Contribuyente, "@i_nombre"
            PMSetValorReverso CEP, "@i_cep"
            PMSetValorReverso sal_municipio, "@i_desmun"
            PMSetValorReverso txthorario, "@o_horario"
            PMSetValorReverso DescripImpto, "@i_desmun"
            PMSetValorReverso sal_tipo, "@i_sal_tipo"
            PMSetValorReverso Tipo, "@i_ptipo_consulta"
            PMSetValorReverso Nombre, "@i_nombcta" 'paola
            PMSetValorReverso lblMoneda, "@i_desmon" 'paola
            PMSetValorReverso Agno, "@i_pid_deuda"
            PMSetValorReverso txtTemporal, "@o_pautorizacion" '@o_pautorizacion
            VLAutorizacion = txtTemporal.Text
            Me.ValorMun.Text = FMCCurATX((efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((Debito.Text)) + FMCCurATX((Tarjeta.Text))
            Total.Text = FMCCurATX((efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((Debito.Text)) + FMCCurATX((Tarjeta.Text)) + FMCCurATX((Comision.Text))
        End If  '---If Trim$(Tipo.Text) = "004" Then

        If Trim$(Tipo.Text) = "001" Then   'PREDIOS
            Me.Etiqueta2.Visible = True
            Me.Etiqueta3.Visible = True
            Me.Etiqueta2.Caption = "Tipo de Impuesto"
            Tipo.TableName = "sv_impto_mungye_cep"
            Tipo.Visible = True
            Tipo.Enabled = False
            Me.Tipo.Top = 555
            Me.sal_tipo.Visible = True
            Me.sal_tipo.Top = 555
            Etiqueta3.Caption = "Cod. Catastral"
            Etiqueta3.Top = 880
            Me.CEP.Visible = False
            Me.sal_tipo.Visible = True
            Me.sal_tipo.Top = 555
            cat1.Visible = True
            cat2.Visible = True
            cat3.Visible = True
            cat4.Visible = True
            cat5.Visible = True
            cat6.Visible = True
            Etiqueta5.Visible = False
            Etiqueta6.Visible = False
            Etiqueta8.Visible = False
            Semestre.Visible = False
            Predio.Visible = False
            Impto.Visible = False
            Agno.Left = 2010
            Me.Agno.Visible = True
            Contribuyente.Height = 570
            cedula.Left = 1800
            txtLlaveMunicipal.Visible = False
            Etiqueta7.Caption = "Anio Vigencia"
            txtCatasSamb.Visible = False
            Me.claveCatastral.Visible = False
            cedula.Visible = False
            Etiqueta3.Top = 880
            txtcat1.Top = 880
            cat1.Top = 880
            cat2.Top = 880
            cat3.Top = 880
            cat4.Top = 880
            cat5.Top = 880
            cat6.Top = 880
            PMSetValorReverso Agno, "@i_panio_vigencia"
            PMSetValorReverso CantChq, "@i_cant_chq"
            PMSetValorReverso ValorMun, "@i_pvalor_total"
            PMSetValorReverso Tarjeta, "@i_tarjeta"  'msilvag Pago de Tarjeta Municipio
            Me.ValorMun.Text = CCur(efe.Text) + CCur(Cheques.Text) + CCur(Debito.Text) + CCur(Tarjeta.Text)
            PMSetValorReverso Contribuyente, "@i_nombre"
            PMSetValorReverso cat1, "@i_psector"
            PMSetValorReverso cat2, "@i_pmanzana"
            PMSetValorReverso cat3, "@i_plote"
            PMSetValorReverso cat4, "@i_pdivision"
            PMSetValorReverso cat5, "@i_pphv"
            PMSetValorReverso cat6, "@i_pphh"
            PMSetValorReverso sal_municipio, "@i_desmun"
            PMSetValorReverso DescripImpto, "@i_desmun"
            PMSetValorReverso sal_tipo, "@i_sal_tipo"
            PMSetValorReverso Nombre, "@i_nombre"
            PMSetValorReverso txtTemporal, "@o_pautorizacion" '@o_pautorizacion
            VLAutorizacion = txtTemporal.Text
            Me.ValorMun.Text = FMCCurATX((efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((Debito.Text)) + FMCCurATX((Tarjeta.Text))
            Total.Text = FMCCurATX((efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((Debito.Text)) + FMCCurATX((Tarjeta.Text)) + FMCCurATX((Comision.Text))
        End If
        
        If Trim$(Tipo.Text) = "002" Then   'MI LOTE
            Me.Etiqueta2.Visible = True
            Me.Etiqueta3.Visible = True
            Me.Etiqueta2.Caption = "Tipo de Impuesto"
            Tipo.TableName = "sv_impto_mungye_cep"
            Tipo.Visible = True
            Tipo.Enabled = False
            Me.Tipo.Top = 555
            Me.sal_tipo.Visible = True
            Me.sal_tipo.Top = 555
            Etiqueta3.Top = 880
            Me.Etiqueta3.Caption = "No. Cédula: "
            Me.claveCatastral.Visible = False
            Me.txtCatasSamb.Visible = False
            Me.CEP.Visible = False
            
            Me.cedula.Left = 1800
            Me.cedula.Visible = True
            Me.cedula.Top = 880
            Me.txtcat1.Visible = False
            Me.cat1.Visible = False
            Me.cat2.Visible = False
            Me.cat3.Visible = False
            Me.cat4.Visible = False
            Me.cat5.Visible = False
            Me.cat6.Visible = False
            Me.txtLlaveMunicipal.Visible = False
            Me.Tarjeta.Enabled = False
            
            Me.Agno.Left = 2010
            Etiqueta5.Visible = False
            Etiqueta6.Visible = False
            Etiqueta8.Visible = False
            Predio.Visible = False
            Impto.Visible = False
            Semestre.Visible = False
            Etiqueta7.Caption = "No. Cuota:"
            Contribuyente.Height = 570
            
            'PMSetValorReverso Agno(0), "@i_panio_vigencia"
            PMSetValorReverso CantChq, "@i_cant_chq"
            PMSetValorReverso ValorMun, "@i_pvalor_total"
            PMSetValorReverso Tarjeta, "@i_tarjeta" 'msilvag pago de Municipio
            Me.ValorMun.Text = CCur(efe.Text) + CCur(Cheques.Text) + CCur(Debito.Text) + CCur(Tarjeta.Text)
            PMSetValorReverso Contribuyente, "@i_nombre"
            PMSetValorReverso txtTemporal, "@i_identifica"
            VLCedulaMig = Me.txtTemporal.Text
            PMSetValorReverso cedula, "@i_identifica"
            PMSetValorReverso sal_municipio, "@i_sal_municipio"
            PMSetValorReverso DescripImpto, "@i_sal_tipo"
            PMSetValorReverso sal_tipo, "@i_sal_tipo"
            PMSetValorReverso Nombre, "@i_nombre"
            PMSetValorReverso txtTemporal, "@o_pautorizacion" '@o_pautorizacion
            VLAutorizacion = txtTemporal.Text
            Me.ValorMun.Text = FMCCurATX((efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((Debito.Text)) + FMCCurATX((Tarjeta.Text))
            Total.Text = FMCCurATX((efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((Debito.Text)) + FMCCurATX((Tarjeta.Text)) + FMCCurATX((Comision.Text))
        End If
        
        If Trim$(Tipo.Text) = "003" Then   'MERCADOS
            Me.Etiqueta2.Visible = True
            Me.Etiqueta3.Visible = True
            Me.Etiqueta2.Caption = "Tipo de Impuesto"
            Tipo.TableName = "sv_impto_mungye_cep"
            Tipo.Visible = True
            Tipo.Enabled = False
            Me.Tipo.Top = 555
            Me.sal_tipo.Visible = True
            Me.sal_tipo.Top = 555
            Etiqueta3.Top = 880
            Me.Etiqueta3.Caption = "No. Cédula: "
            Me.claveCatastral.Visible = False
            Me.txtCatasSamb.Visible = False
            Me.CEP.Visible = False
            
            Me.cedula.Left = 1800
            Me.cedula.Visible = True
            Me.cedula.Top = 880
            Me.txtcat1.Visible = False
            Me.cat1.Visible = False
            Me.cat2.Visible = False
            Me.cat3.Visible = False
            Me.cat4.Visible = False
            Me.cat5.Visible = False
            Me.cat6.Visible = False
            Me.txtLlaveMunicipal.Visible = False
            Me.Tarjeta.Enabled = False
            
            Me.Agno.Left = 2010
            Etiqueta5.Visible = False
            Etiqueta6.Visible = False
            Etiqueta8.Visible = False
            Predio.Visible = False
            Impto.Visible = False
            Semestre.Visible = False
            Etiqueta7.Caption = "No. Cuota:"
            Contribuyente.Height = 570
            
'            PMSetValorReverso Agno(0), "@i_panio_vigencia"
            PMSetValorReverso CantChq, "@i_cant_chq"
            PMSetValorReverso ValorMun, "@i_pvalor_total"
            PMSetValorReverso Tarjeta, "@i_tarjeta" 'msilvag pago de Municipio
            Me.ValorMun.Text = CCur(efe.Text) + CCur(Cheques.Text) + CCur(Debito.Text) + CCur(Tarjeta.Text)
            PMSetValorReverso Contribuyente, "@i_nombre"
            PMSetValorReverso cedula, "@i_identifica"
            
            PMSetValorReverso Me.txtTemporal, "@i_identifica"
            VLCedMigMer = Me.txtTemporal.Text
            PMSetValorReverso Me.txtTemporal, "@o_pautorizacion"
            VLAutorizacionCep = Me.txtTemporal.Text
            
            PMSetValorReverso sal_municipio, "@i_desmun"
            PMSetValorReverso DescripImpto, "@i_sal_tipo"
            PMSetValorReverso sal_tipo, "@i_sal_tipo"
            PMSetValorReverso Nombre, "@i_nombre"
            PMSetValorReverso txtTemporal, "@o_pautorizacion" '@o_pautorizacion
            VLAutorizacion = txtTemporal.Text
            
            PMSetValorReverso txtTipoConsulta, "@i_tipoConsulta"  'Tipo de Consulta
            PMSetValorReverso lblTipoConsulta, "@i_descripTipCons"  'Descipcion de Tipo de Consulta
            
            PMSetValorReverso txtTemporal, "@i_pcodigo_puesto1"  'clave catrastral
            VLclaCatastralReverso = Me.txtTemporal.Text
            PMSetValorReverso txtTemporal, "@i_nom_mercado"  'Nombre del Mercado
            VLMercadoReverso = Me.txtTemporal.Text
            
            PMSetValorReverso txtTemporal, "@i_valorapagar"  'Valor a Pagar
            VLMercadosDatos = Me.txtTemporal.Text
            
            PMSetValorReverso Agno, "@i_cuota"  'cuota
            'VLMercadosDatos = Me.txtTemporal.Text
            
            Me.txtTipoConsulta.Top = 880
            Me.lblTipoConsulta.Top = 880
            Me.Label5.Caption = "Tipo de Consulta"
            Me.Label5.Top = 880
            
            Me.cedula.Left = 1800
            Me.cedula.Top = 1200 '880
            Me.cedula.Visible = True
            Me.Etiqueta3.Top = 1200
            
            
            Me.ValorMun.Text = FMCCurATX((efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((Debito.Text)) + FMCCurATX((Tarjeta.Text))
            Total.Text = FMCCurATX((efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((Debito.Text)) + FMCCurATX((Tarjeta.Text)) + FMCCurATX((Comision.Text))
        End If
    End If
        
    'msilvag Inicio
    If Me.municipio.Text = "7749" And Me.Tipo.Text = "003" Then
        Me.txtTipoConsulta.Visible = True
        Me.lblTipoConsulta.Visible = True
        Me.Label5.Visible = True
    Else
        Me.txtTipoConsulta.Visible = False
        Me.lblTipoConsulta.Visible = False
        Me.Label5.Visible = False
    End If
    'msilvag Fin
    
    '-->hy-15-feb-2006
    VLFlagSumadora = True
    If Not (VGMatrizSwitchFlagSRI) Then
        VGDatosConexionSRI = FMParametroUpLoadDll("IPSW", "CTE")
        VGMatrizSwitchFlagSRI = True
    End If
    '<--hy-15-feb-2006
End Sub

Sub Form_Unload(Cancel As Integer)
    PMCerrarForma "19"
    lectoraBill.Limpiar   'JPM lectora de billetes
End Sub
 
Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    If Shift = CGTeclaCTRL% + CGTeclaALT% And KeyCode% = CGTeclaF9% Then
        PMObtenerMonedaForma "19"
        Exit Sub
    End If
    If Shift = CGTeclaCTRL% And KeyCode% = CGTeclaI% Then
        PMReimpresion
        Exit Sub
    End If
    If Shift = CGTeclaCTRL% And KeyCode% = CGTeclaF2% Then
        If VGTipoEjecucion% = CGNormal% Then
            PMSetEjecucionReverso
            If FMSupervisor("19") = True Then
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
            VLFlagSumadora = True
        End If
    Case CGTeclaESC%
        Unload Me
        VLCta = ""
    Case CGTeclaHOME%
        PMCambiarForma Me
   Case CGTeclaF2%
      If Me.municipio.Text = "1800" Then
         descripcion.Caption = ""
      End If
      '-->lfcm 16-junio-2009 Mi Lote
      If Me.municipio.Text = "1434" Then
         VLMLSecBr = ""
         VLMLContribuyente = ""
         VLMLAnioConvenio = ""
         VLMLNoConvenio = ""
         VLMLValoresPagar = ""
         VLMLNoCuota = ""
      End If
      
      If Me.municipio.Text = "1435" Or Me.municipio.Text = "7749" Then  'smerino cep
        VLMLContribuyente = ""
        Contribuyente.Caption = ""
        VLNombreCliente = ""
        Me.CEP.Enabled = True
        Me.CEP.Text = ""  'smerino cep
        descripcion.Caption = ""
      End If
      '--<lfcm 16-junio-2009 Mi Lote
      Me.Tarjeta.Enabled = True    '--lfcm 01-julio-2009 MiLote
      Me.txtCatasSamb.Text = "" 'GAMC - 25/02/2008
      txtPapeletaSamb.Text = "" 'GAMC - 25/02/2008
      Me.VLOficinaRetiro = "" 'GAMC - 27/03/2008
      Me.claveCatastral.Mask = "  -  -  -  -   " 'GAMC - 05/03/2008
      VLMoneda = VGmoneda%
      VLDescMonCta = ""
      lblMoneda.Caption = ""
      
      VLfirma = False
      VLTipoOK = False
      activa = True
      Tipo.Text = ""
      municipio.Text = ""
      
        'LBP Inicio RECA-CC-SGC00025869 30/07/2016
        VGFormaPago = ""
        VGCom_aux = 0
        VGComision_original = 0
        VGCompensacion = 0
        VGPorcentajeComp = "0"
        VGPorcentajeIVA = "0"
        'LBP Fin 30/07/2016'Fin LBP
        
      cedula.Clear
      '-->hy-30-ene-2006
      cat1.Clear
      cat2.Clear
      cat3.Clear
      cat4.Clear
      cat5.Clear
      cat6.Clear
      Comision.Text = "0.00"
      VLTotCom = 0
      VLEfe_com = 0
      VLChq_com = 0
        VLDeb_com = 0
        VLNombre_com = "" 'ame 07/20/2010
        '<--hy-30-ene-2006
        efe.Text = "0.00"
        CantChq.Text = "0"
        Cheques.Text = "0.00"
        sal_tipo.Caption = ""
        sal_municipio.Caption = ""
        direccion.Text = ""
        DescripImpto.Text = ""
        Cau.Text = ""
        Frame1.Caption = ""
        Contribuyente.Caption = ""
        Predio.Caption = ""
        Impto.Caption = ""
        Agno.Caption = ""
        Semestre.Caption = ""
        Debito.Enabled = False
        CboTipCta.ListIndex = 0
        VGSecBanredMG = 0
        Debito.Text = "0.00"
        Tarjeta.Text = "0.00"   'hy-14-agosto-2006
        txtLlaveMunicipal.Text = "" 'hy-22-febrero-2007
        ValorMun.Text = "0.00"
        Total.Text = "0.00"
        Total.Text = CDbl(ValorMun.Text) + CDbl(Comision) 'hy-30-ene-2006
        Cta.Text = ""
        Nombre.Text = ""
        Cheques.Enabled = True
        VLCta = ""
        Frame1.Enabled = False
        Frame2.Enabled = True
        PMLimpiarTransaccion "19"
        VGAutoriza = "N"
        Prioridad.Text = "" 'referencia Municipio 1430 nchavezb
        Prioridad.Visible = False
        
        'msilvag Inicio
        Me.Label5.Visible = False
        Me.txtTipoConsulta.Visible = False
        Me.lblTipoConsulta.Visible = False
        Me.txtTipoConsulta.Text = ""
        Me.lblTipoConsulta.Caption = ""
        'msilvag Fin
      
        '------> Sumadora
        If VLFlagSumadora Then
            SGUsar = 0
            If Shift = 0 And VGTipoConsAutom% = 0 And VGTipoEjecucion% <> CGReverso% Then  'TPEAdiciono Validacion Por Consulta Automatica y Reverso
                SGActual = 1
                FSumIng.Hide
                FSumIng.Form_KeyDown CGTeclaF2%, 0
                If Tipo.Visible Then 'hy-30-ene-2006
                    Tipo.SetFocus
                Else
                    If cat1.Visible = True Then 'GAMC - 24/02/2008
                        cat1.SetFocus
                    End If
                End If
                Unload FSumIng
            End If
            SGActivaSum = False
        Else
            VLFlagSumadora = True
        End If
        '<------
        If Frame2.Enabled And municipio.Enabled Then
              municipio.SetFocus
        End If
        lectoraBill.Limpiar  'JPM Lectora Billetes
    Case CGTeclaF3%
        'Sumadora ------>
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
        '<------
   Case CGTeclaF5%
        If VGTipoEjecucion% = CGReverso% Then
            Exit Sub
        End If
        If VLFlagFoco Then
            Exit Sub
        End If
        'If Not Frame2.Enabled Then
        '    Exit Sub
        'End If
        If ValorMun.ValueReal > 0 Then
            Exit Sub
        End If
        
        If municipio.Text = "2319" Then
            'GAMC - 23/02/2008 - INI
            If Not (Len(Trim$(Me.txtCatasSamb.Text)) > 30) Then
                MsgBox "El CODIGO CATASTRAL mínimo debe tener 16 numeros", vbInformation, "Aviso"
                If txtCatasSamb.Enabled Then
                    txtCatasSamb.SetFocus
                End If
                Exit Sub
            End If
            If Trim$(txtCatasSamb.Text) = "" Then
                MsgBox "Ingrese No. Cód. Predial", vbInformation, "Aviso"
                If txtCatasSamb.Enabled Then
                    txtCatasSamb.SetFocus
                End If
                Exit Sub
            End If
            'GAMC - 23/02/2008 - FIN
            'ref003
            SGEmpresa = municipio.Text
        End If
        
        'Wise (Para el Municipio de Libertad 08/13/2008)
        If municipio.Text = "2236" Then
            If Trim$(txtCatasSamb.Text) = "" Then
                MsgBox "Ingrese No. Código Predial", vbInformation, "Aviso"
                If txtCatasSamb.Enabled Then
                    txtCatasSamb.SetFocus
                End If
                Exit Sub
            End If
            'If Not (Len(Trim$(Me.txtCatasSamb.Text)) > 19) Then
            '    MsgBox "El CODIGO PREDIAL mínimo debe tener 20 numeros", vbInformation, "Aviso"
            '    If txtCatasSamb.Enabled Then
            '        txtCatasSamb.SetFocus
            '    End If
            '    Exit Sub
            'End If
        End If
        'End Libertad
        
        'If municipio.Text = "2237" Then
        If municipio.Text = "2237" Or municipio.Text = "2235" Then 'GAMC - 14/04/2008 - SANTA ELENA
            'GAMC - 05/03/2008 - INI
            If Trim$(Me.claveCatastral.Text) = "" Then
                MsgBox "Ingrese Clave Catastral", vbInformation, "Aviso"
                If claveCatastral.Enabled Then
                    claveCatastral.SetFocus
                End If
                Exit Sub
            End If
            'GAMC - 05/03/2008 - FIN
            'ref003
            SGEmpresa = municipio.Text
        End If
        
        'ref003 Ini
        If municipio.Text = "2236" Then
          SGEmpresa = municipio.Text
        End If
        'ref003 Fin
        
        If municipio.Text = "1430" Then  'nchavezb 04/Agosto/2011 Municipio Daule
           
           If Trim$(txtCatasSamb.Text) = "" Then
                MsgBox "Ingrese No. Código Predial", vbInformation, "Aviso"
                If txtCatasSamb.Enabled Then
                    txtCatasSamb.SetFocus
                End If
                Exit Sub
            End If
           'ref003
            SGEmpresa = municipio.Text
           
        End If
        
        If Trim$(municipio.Text) = "" Then
            MsgBox "El código del municipio es mandatorio", vbInformation, "Aviso"
            If municipio.Enabled Then
                municipio.SetFocus
            End If
            Exit Sub
        End If
        
        '-->hy-21-diciembre-2006 [pase rezagado] estaba comentado
        'If municipio.Text = "1433" Or municipio.Text = "2234" Then  'hy-05-noviembre-2007
        If municipio.Text = "2234" Then                              'lfcm 29-octubre-2008
            If Trim$(cedula.ClipText) = "" Then
                MsgBox "La cédula/ruc/pas/otros es mandatoria", vbInformation, "Aviso"
                If cedula.Enabled Then
                    cedula.SetFocus
                End If
                Exit Sub
            End If
            'ref003
            SGEmpresa = municipio.Text
        End If
        
        If municipio.Text = "7749" And Tipo.Text = "004" Then                              'lfcm 29-octubre-2008
            If Trim$(Me.CEP.Text) = "" Then
                MsgBox "El Código CEP es mandatorio", vbInformation, "Aviso"
                If Me.CEP.Enabled Then
                    CEP.SetFocus
                End If
                Exit Sub
            End If
        End If
        '<--hy-21-diciembre-2006
        If municipio.Text = "1417" Then  'hy-21-diciembre-2006
            If Trim$(cedula.ClipText) = "" Then
                MsgBox "La No.PREDIO/PATENTE/VARIOS es mandatoria", vbInformation, "Aviso"
                If cedula.Enabled Then
                    cedula.SetFocus
                End If
                Exit Sub
            End If
        End If
        
        If municipio.Text = "1417" Or municipio.Text = "2234" Or municipio.Text = "1800" Then
            If Trim$(Tipo.Text) = "" Then
                MsgBox "El tipo de impuesto es mandatorio", vbInformation, "Aviso"
                If Tipo.Enabled Then
                    Tipo.SetFocus
                End If
                Exit Sub
            End If
        End If
        
        '-->hy-22-febrero-2007
        If Trim$(municipio.Text) = "" Then
            MsgBox "Escoja un municipio", vbInformation, "AVISO"
            Exit Sub
        End If
        If municipio.Text = "1800" Then 'ame 07/06/2010
            If (Trim$(Tipo.Text) = "001" Or Trim$(Tipo.Text) = "002") And Not (Len(Trim$(txtLlaveMunicipal.Text)) = 13 Or Len(Trim$(txtLlaveMunicipal.Text)) = 15) Then
                MsgBox "La CLAVE CATASTRAL mínimo debe tener 13 o 15 caracteres", vbInformation, "Aviso"
                If txtLlaveMunicipal.Enabled Then
                    txtLlaveMunicipal.SetFocus
                End If
                Exit Sub
            End If
            If (Trim$(Tipo.Text) = "001" Or Trim$(Tipo.Text) = "002") And Trim$(txtLlaveMunicipal.Text) = "" Then
                MsgBox "La CLAVE CATASTRAL es mandatoria", vbInformation, "Aviso"
                If txtLlaveMunicipal.Enabled Then
                    txtLlaveMunicipal.SetFocus
                End If
                Exit Sub
            End If
            If Trim$(Tipo.Text) = "003" And Trim$(txtLlaveMunicipal.Text) = "" Then
                MsgBox "La CEDULA es mandatoria", vbInformation, "Aviso"
                If txtLlaveMunicipal.Enabled Then
                    txtLlaveMunicipal.SetFocus
                End If
                Exit Sub
            End If
            If Trim$(Tipo.Text) = "003" And Not (Len(Trim$(txtLlaveMunicipal.Text)) = 10 Or Len(Trim$(txtLlaveMunicipal.Text)) = 13) Then
                MsgBox "La Cedula/RUC mínimo debe tener 10 o 13 caracteres", vbInformation, "Aviso"
                If txtLlaveMunicipal.Enabled Then
                    txtLlaveMunicipal.SetFocus
                End If
                Exit Sub
            End If
            
            If Trim$(Tipo.Text) = "" Or Trim$(sal_tipo.Caption) = "" Then
                MsgBox "El tipo de impuesto es mandatorio", vbInformation, "Aviso"
                If Tipo.Enabled Then
                    Tipo.SetFocus
                End If
                Exit Sub
            End If
        End If
        
        '<--hy-22-febrero-2007
        
        'msilvag Inicio
        If Me.municipio.Text = "7749" And Me.Tipo.Text = "003" Then
            If Me.txtTipoConsulta.Text = "" Then
                MsgBox "El tipo de Consulta es mandatorio", vbInformation, "Aviso"
                If txtTipoConsulta.Enabled Then
                    txtTipoConsulta.SetFocus
                End If
                Exit Sub
            End If
        End If
        'msilvag Fin
        
      '-->lfcm 16-junio-2009 MiLote
      If municipio.Text = "1434" Then
      
      'SMERINO VALIDACION
      If Not (Len(Trim$(cedula.ClipText))) = 10 Then
          MsgBox "La Cedula mínimo debe tener 10  caracteres", vbInformation, "Aviso"
                If cedula.Enabled Then
                    cedula.SetFocus
                End If
                Exit Sub
            'End If
         Else
         
         If FLTransmitir_CPS_MILOTE_consulta() = False Then
            Exit Sub
         End If
        End If 'fin smerino
      Else
         Dim I As Integer
         Dim j As Integer
         If FLConsultar() = False Then
            Exit Sub
         End If
      End If
      '--<lfcm 16-junio-2009 MiLote
        
        efe.Text = "0.00"
        CantChq.Text = "0"
        Cheques.Text = "0.00"
        direccion.Text = ""
        DescripImpto.Text = ""
        Cau.Text = ""
        '-->hy-14-agosto-2006
        'comentar
        'If municipio.Text = "1417" Then  'Si es quito blanquear el campo
        '    Contribuyente.Caption = ""
        'End If
        '-->hy-14-agosto-2006
        Predio.Caption = ""
        Impto.Caption = ""
        '-->lfcm 16-junio-2009 Mi Lote
        If Me.municipio.Text <> "1434" And Me.municipio.Text <> "1433" And Me.municipio.Text <> "7749" Then 'smerino cep
           Agno.Caption = ""
        End If
        '--<lfcm 16-junio-2009 Mi Lote
        Semestre.Caption = ""
        Debito.Enabled = False
        CboTipCta.ListIndex = 0
        Debito.Text = "0.00"
        Tarjeta.Text = "0.00"   'lfcm 20/Octubre/2006
        If Me.municipio.Text <> "1433" And Me.municipio.Text <> "7749" Then 'smerino cep
            ValorMun.Text = "0.00"
            Total.Text = "0.00"
        End If
        Cta.Text = ""
        Nombre.Text = ""
        Cheques.Enabled = True
        VLCta = ""
        
        '-->hy-14-agosto-2006
        '-->hy-05-noviembre-2007 reapertura de este codigo que estaba comentado
        'pero exclusivamente para el municipio 2234 ibarra
        Select Case municipio.Text
        'Case "2319", "2237" 'GAMC - 05/03/2008
        'Case "2319", "2237", "2235" 'GAMC - 14/04/2008
        'Case "2319", "2237", "2235", "2236", "1430" nchavezb 04/Agosto/2011 Municipio Daule
        Case "2319", "2237", "2235", "2236", "1430" 'Wise Libertad="2236" - 14/Agt/2008
            FCC19_grid2.VLCodMunicipio = municipio.Text
            FCC19_grid2.VLIdentificacion = VLIdentificacion
            FCC19_grid2.VLContribuyente = VLContribuyente
            Frame2.Enabled = False
            FCC19_grid2.grdDetalle.Rows = grdDetalle.Rows
            FCC19_grid2.grdDetalle.Cols = grdDetalle.Cols
            For I = 1 To grdDetalle.Rows - 1
                 grdDetalle.Row = I
                 grdDetalle.Col = 0
                 FCC19_grid2.grdDetalle.Row = I
                 FCC19_grid2.grdDetalle.Col = 0
                 FCC19_grid2.grdDetalle.Text = Trim$(str$(I))
                 For j = 1 To grdDetalle.Cols - 1
                     grdDetalle.Col = j
                     FCC19_grid2.grdDetalle.Row = I
                     FCC19_grid2.grdDetalle.Col = j
                     FCC19_grid2.grdDetalle.Text = grdDetalle.Text
                 Next
            Next
            FCC19_grid2.grdDetalle.Row = 1
            FCC19_grid2.grdDetalle.Col = 1
            FCC19_grid2.Show vbModal
            If ValorMun > 0 Then
                Total.Text = CDbl(ValorMun.Text) + CDbl(Comision)  'hy-30-ene-2006
                Frame1.Enabled = True
                efe.SetFocus
            Else
                If CantChq.Enabled Then
                    CantChq.SetFocus
                End If
            End If
            
            If VLTopeMax <= 1 Then
                VLFlagUnico = True
            Else
                VLFlagUnico = False
            End If
        Case "2234"
            FCC19_grid2.VLCodMunicipio = municipio.Text
            FCC19_grid2.VLIdentificacion = VLIdentificacion
            FCC19_grid2.VLContribuyente = VLContribuyente
            Frame2.Enabled = False
            FCC19_grid2.grdDetalle.Rows = grdDetalle.Rows
            FCC19_grid2.grdDetalle.Cols = grdDetalle.Cols
            For I = 1 To grdDetalle.Rows - 1
                 grdDetalle.Row = I
                 grdDetalle.Col = 0
                 FCC19_grid2.grdDetalle.Row = I
                 FCC19_grid2.grdDetalle.Col = 0
                 FCC19_grid2.grdDetalle.Text = Trim$(str$(I))
                 For j = 1 To grdDetalle.Cols - 1
                     grdDetalle.Col = j
                     FCC19_grid2.grdDetalle.Row = I
                     FCC19_grid2.grdDetalle.Col = j
                     FCC19_grid2.grdDetalle.Text = grdDetalle.Text
                 Next
            Next
            FCC19_grid2.grdDetalle.Row = 1
            FCC19_grid2.grdDetalle.Col = 1
            FCC19_grid2.Show vbModal
            If ValorMun > 0 Then
                Total.Text = CDbl(ValorMun.Text) + CDbl(Comision)  'hy-30-ene-2006
                Frame1.Enabled = True
                efe.SetFocus
            Else
                If CantChq.Enabled Then
                    CantChq.SetFocus
                End If
            End If
            
            If VLTopeMax <= 1 Then
                VLFlagUnico = True
            Else
                VLFlagUnico = False
            End If
        
        Case "1433", "1417", "1800"
        '<--hy-05-noviembre-2007
        '<--hy-14-agosto-2006
            '-->hy-14-agosto-2006
            FCC19_grid2.VLCodMunicipio = municipio.Text
            If Trim$(municipio.Text) = "1417" Or Trim$(municipio.Text) = "1800" Then  'hy-22-febrero-2007 agregar 1800
                FCC19_grid2.VLIdentificacion = VLIdentificacion
                FCC19_grid2.VLContribuyente = VLContribuyente
                FCC19_grid2.VLTipoimp = Trim$(Tipo.Text)  'ame 07/08/2010
            End If
            '<--hy-14-agosto-2006
            Frame2.Enabled = False
            FCC19_grid2.grdDetalle.Rows = grdBloque.Rows
            FCC19_grid2.grdDetalle.Cols = grdBloque.Cols
            For I = 1 To grdBloque.Rows - 1
                 '-->hy-14-agosto-2006
                 grdBloque.Row = I
                 grdBloque.Col = 0
                 FCC19_grid2.grdDetalle.Row = I
                 FCC19_grid2.grdDetalle.Col = 0
                 FCC19_grid2.grdDetalle.Text = Trim$(str$(I))
                 '<--hy-14-agosto-2006
                 For j = 1 To grdBloque.Cols - 1
                     'grdBloque.Row = i  hy-14-agosto-2006
                     grdBloque.Col = j
                     FCC19_grid2.grdDetalle.Row = I
                     FCC19_grid2.grdDetalle.Col = j
                     FCC19_grid2.grdDetalle.Text = grdBloque.Text
                 Next
            Next
            FCC19_grid2.grdDetalle.Row = 1
            FCC19_grid2.grdDetalle.Col = 1
            FCC19_grid2.Show vbModal
            If ValorMun > 0 Then
                Total.Text = CDbl(ValorMun.Text) + CDbl(Comision)  'hy-30-ene-2006
                Frame1.Enabled = True
                efe.SetFocus
            Else
                If CantChq.Enabled Then
                    CantChq.SetFocus
                End If
            End If
            
            If VLTopeMax <= 1 Then
                VLFlagUnico = True
            Else
                VLFlagUnico = False
            End If

        '-->lfcm 16-junio-2009 Mi Lote
        Case "1434"                    '"MI LOTE"
           'If grdDetalle.Rows = 2 Then
'           pricaura ini 05/11/2017 MiLote borraba forma cuando solo habia un detalle de pago
'           If grdBloque.Rows = 2 Then
'              Call Form_KeyDown(CGTeclaF2%, 0)
'              Exit Sub
'           End If
'           pricaura fin
           Frame2.Enabled = False
           FCC19_gridMiLote.grdDetalleML.Rows = grdBloque.Rows
           FCC19_gridMiLote.grdDetalleML.Cols = grdBloque.Cols
           FCC19_gridMiLote.grdDetalleML.Row = 0
           FCC19_gridMiLote.grdDetalleML.Col = 0
           FCC19_gridMiLote.grdDetalleML.ColWidth(0) = 450
           FCC19_gridMiLote.grdDetalleML.Col = 1
           FCC19_gridMiLote.grdDetalleML.ColWidth(1) = 1000
           FCC19_gridMiLote.grdDetalleML.ColAlignment(1) = 4
           FCC19_gridMiLote.grdDetalleML.Text = "No. Cuota"
           FCC19_gridMiLote.grdDetalleML.Col = 2
           FCC19_gridMiLote.grdDetalleML.ColWidth(2) = 2300
           FCC19_gridMiLote.grdDetalleML.ColAlignment(2) = 4
           FCC19_gridMiLote.grdDetalleML.Text = "F. Vigencia"
           FCC19_gridMiLote.grdDetalleML.Col = 3
           FCC19_gridMiLote.grdDetalleML.ColWidth(3) = 1200
           FCC19_gridMiLote.grdDetalleML.ColAlignment(3) = 4
           FCC19_gridMiLote.grdDetalleML.Text = "Valor"
           FCC19_gridMiLote.grdDetalleML.Col = 3
           For I = 1 To grdBloque.Rows - 1
              grdBloque.Row = I
              grdBloque.Col = 0
              FCC19_gridMiLote.grdDetalleML.Row = I
              FCC19_gridMiLote.grdDetalleML.Col = 0
              FCC19_gridMiLote.grdDetalleML.Text = Trim$(str$(I))
              For j = 1 To grdBloque.Cols - 1
                 grdBloque.Col = j
                 FCC19_gridMiLote.grdDetalleML.Row = I
                 FCC19_gridMiLote.grdDetalleML.Col = j
                 FCC19_gridMiLote.grdDetalleML.Text = grdBloque.Text
                 If j = 3 Then
                    FCC19_gridMiLote.grdDetalleML.CellAlignment = 6
                 End If
              Next
           Next
           
           FCC19_gridMiLote.grdDetalleML.Cols = grdBloque.Cols - 2
           FCC19_gridMiLote.grdDetalleML.Row = 1
           FCC19_gridMiLote.grdDetalleML.Col = 1
           FCC19_gridMiLote.Show vbModal
           If ValorMun > 0 Then
              Total.Text = CDbl(ValorMun.Text) + CDbl(Comision)  'Sumo el valor a pagar del Municipio + la Comision
              Frame1.Enabled = True
              efe.SetFocus
           Else
              If CantChq.Enabled Then
                 CantChq.SetFocus
              End If
           End If
            
           If VLTopeMax <= 1 Then
              VLFlagUnico = True
           Else
              VLFlagUnico = False
           End If
        '--<lfcm 16-junio-2009 Mi Lote
        
        'nchavezb
        Case "1435"  'llamar al grid
'           If grdBloque.Rows = 2 Then
'             Call Form_KeyDown(CGTeclaF2%, 0)
'              Exit Sub
'           End If
           Frame2.Enabled = False
          
           FCC19_gridMiLote.Top = 1100
           FCC19_gridMiLote.Left = 4700
           FCC19_gridMiLote.Caption = "Detalle de Cuotas - Mercados"
           FCC19_gridMiLote.grdDetalleML.Rows = grdBloque.Rows
           FCC19_gridMiLote.grdDetalleML.Cols = grdBloque.Cols
           FCC19_gridMiLote.grdDetalleML.Row = 0
           FCC19_gridMiLote.grdDetalleML.Col = 0
           FCC19_gridMiLote.grdDetalleML.ColWidth(0) = 450
           FCC19_gridMiLote.grdDetalleML.Col = 1
           FCC19_gridMiLote.grdDetalleML.ColWidth(1) = 1000
           FCC19_gridMiLote.grdDetalleML.ColAlignment(1) = 4
           FCC19_gridMiLote.grdDetalleML.Text = "No. Abono"
           FCC19_gridMiLote.grdDetalleML.Col = 2
           FCC19_gridMiLote.grdDetalleML.ColWidth(2) = 2300
           FCC19_gridMiLote.grdDetalleML.ColAlignment(2) = 4
           FCC19_gridMiLote.grdDetalleML.Text = "F. Vigencia (yy/mm/dd)"
           FCC19_gridMiLote.grdDetalleML.Col = 3
           FCC19_gridMiLote.grdDetalleML.ColWidth(3) = 1200
           FCC19_gridMiLote.grdDetalleML.ColAlignment(3) = 4
           FCC19_gridMiLote.grdDetalleML.Text = "Valor"
           FCC19_gridMiLote.grdDetalleML.Col = 3
           For I = 1 To grdBloque.Rows - 1
              grdBloque.Row = I
              grdBloque.Col = 0
              FCC19_gridMiLote.grdDetalleML.Row = I
              FCC19_gridMiLote.grdDetalleML.Col = 0
              FCC19_gridMiLote.grdDetalleML.Text = Trim$(str$(I))
              For j = 1 To grdBloque.Cols - 1
                 grdBloque.Col = j
                 FCC19_gridMiLote.grdDetalleML.Row = I
                 FCC19_gridMiLote.grdDetalleML.Col = j
                 FCC19_gridMiLote.grdDetalleML.Text = grdBloque.Text
                 If j = 3 Then
                    FCC19_gridMiLote.grdDetalleML.CellAlignment = 6
                 End If
              Next
           Next
           
           FCC19_gridMiLote.grdDetalleML.Cols = grdBloque.Cols - 2
           FCC19_gridMiLote.grdDetalleML.Row = 1
           FCC19_gridMiLote.grdDetalleML.Col = 1
           FCC19.Agno = FCC19_gridMiLote.grdDetalleML.Text
           FCC19_gridMiLote.grdDetalleML.Col = 2
           'VLFechaVigencia = Trim$(FCC19_gridMiLote.grdDetalleML.Text)
           VLFechaVigencia = Mid(FCC19_gridMiLote.grdDetalleML.Text, 1, 4) + "-" + Mid(FCC19_gridMiLote.grdDetalleML.Text, 6, 2) + "-" + Mid(FCC19_gridMiLote.grdDetalleML.Text, 9, 2) + " - " + Mid(FCC19_gridMiLote.grdDetalleML.Text, 14, 4) + "-" + Mid(FCC19_gridMiLote.grdDetalleML.Text, 19, 2) + "-" + Mid(FCC19_gridMiLote.grdDetalleML.Text, 22, 2)
           
           FCC19_gridMiLote.Show vbModal
           
          
           
   
           If ValorMun > 0 Then
              Total.Text = CDbl(ValorMun.Text) + CDbl(Comision)  'Sumo el valor a pagar del Municipio + la Comision
              Frame1.Enabled = True
              efe.SetFocus
           Else
              If CantChq.Enabled Then
                 CantChq.SetFocus
              End If
           End If
            
           If VLTopeMax <= 1 Then
              VLFlagUnico = True
           Else
              VLFlagUnico = False
           End If 'nchavezb fin 1435
        'msilvag Inicio Migracion WebService
        Case "7749"
        
            If Me.Tipo.Text = "001" Then 'Predios  1433
            
                FCC19_grid2.VLCodMunicipio = municipio.Text
                If Trim$(municipio.Text) = "1417" Or Trim$(municipio.Text) = "1800" Then
                    FCC19_grid2.VLIdentificacion = VLIdentificacion
                    FCC19_grid2.VLContribuyente = VLContribuyente
                    FCC19_grid2.VLTipoimp = Trim$(Tipo.Text)
                End If

                Frame2.Enabled = False
                FCC19_grid2.grdDetalle.Rows = grdBloque.Rows
                FCC19_grid2.grdDetalle.Cols = grdBloque.Cols
                For I = 1 To grdBloque.Rows - 1
                     grdBloque.Row = I
                     grdBloque.Col = 0
                     FCC19_grid2.grdDetalle.Row = I
                     FCC19_grid2.grdDetalle.Col = 0
                     FCC19_grid2.grdDetalle.Text = Trim$(str$(I))
              
                     For j = 1 To grdBloque.Cols - 1
                        
                         grdBloque.Col = j
                         FCC19_grid2.grdDetalle.Row = I
                         FCC19_grid2.grdDetalle.Col = j
                         FCC19_grid2.grdDetalle.Text = grdBloque.Text
                     Next
                Next
                FCC19_grid2.grdDetalle.Row = 1
                FCC19_grid2.grdDetalle.Col = 1
                FCC19_grid2.Show vbModal
                If ValorMun > 0 Then
                    Total.Text = CDbl(ValorMun.Text) + CDbl(Comision)
                    Frame1.Enabled = True
                    efe.SetFocus
                Else
                    If CantChq.Enabled Then
                        CantChq.SetFocus
                    End If
                End If
                
                If VLTopeMax <= 1 Then
                    VLFlagUnico = True
                Else
                    VLFlagUnico = False
                End If
                
            End If
        
            If Me.Tipo.Text = "002" Then  'Mi Lote  1434
                If grdBloque.Rows = 2 Then
                   Call Form_KeyDown(CGTeclaF2%, 0)
                   Exit Sub
                End If
                Frame2.Enabled = False
                FCC19_gridMiLote.grdDetalleML.Rows = grdBloque.Rows
                FCC19_gridMiLote.grdDetalleML.Cols = grdBloque.Cols
                FCC19_gridMiLote.grdDetalleML.Row = 0
                FCC19_gridMiLote.grdDetalleML.Col = 0
                FCC19_gridMiLote.grdDetalleML.ColWidth(0) = 450
                FCC19_gridMiLote.grdDetalleML.Col = 1
                FCC19_gridMiLote.grdDetalleML.ColWidth(1) = 1000
                FCC19_gridMiLote.grdDetalleML.ColAlignment(1) = 4
                FCC19_gridMiLote.grdDetalleML.Text = "No. Cuota"
                'msilvag Inicio Migracion WebService
                FCC19_gridMiLote.grdDetalleML.Col = 2
                FCC19_gridMiLote.grdDetalleML.ColWidth(2) = 1000
                FCC19_gridMiLote.grdDetalleML.ColAlignment(2) = 4
                FCC19_gridMiLote.grdDetalleML.Text = "Abono"
                'msilvag Fin
                FCC19_gridMiLote.grdDetalleML.Col = 3 '2 Migracion WebService
                FCC19_gridMiLote.grdDetalleML.ColWidth(3) = 2300
                FCC19_gridMiLote.grdDetalleML.ColAlignment(3) = 4
                FCC19_gridMiLote.grdDetalleML.Text = "F. Vigencia"
                FCC19_gridMiLote.grdDetalleML.Col = 4 '3 Migracion WebService
                FCC19_gridMiLote.grdDetalleML.ColWidth(4) = 1200
                FCC19_gridMiLote.grdDetalleML.ColAlignment(4) = 4
                FCC19_gridMiLote.grdDetalleML.Text = "Valor"
                FCC19_gridMiLote.grdDetalleML.Col = 4
                For I = 1 To grdBloque.Rows - 1
                   grdBloque.Row = I
                   grdBloque.Col = 1
                   If grdBloque.Text <> "000000/12" Or grdBloque.Text <> "" Then
                        grdBloque.Col = 0
                        FCC19_gridMiLote.grdDetalleML.Row = I
                        FCC19_gridMiLote.grdDetalleML.Col = 0
                        FCC19_gridMiLote.grdDetalleML.Text = Trim$(str$(I))
                        For j = 1 To grdBloque.Cols - 1
                           grdBloque.Col = j
                           
                             FCC19_gridMiLote.grdDetalleML.Row = I
                             FCC19_gridMiLote.grdDetalleML.Col = j
                             FCC19_gridMiLote.grdDetalleML.Text = grdBloque.Text
                           'If FCC19_gridMiLote.grdDetalleML.Text <> "000000/12" Then
                             If j = 3 Then '3 migracion WebService
                                FCC19_gridMiLote.grdDetalleML.CellAlignment = 6
                             End If
                        Next
                   End If
                Next
                
                FCC19_gridMiLote.grdDetalleML.Cols = grdBloque.Cols - 1 '2
                FCC19_gridMiLote.grdDetalleML.Row = 1
                FCC19_gridMiLote.grdDetalleML.Col = 1
                FCC19_gridMiLote.Show vbModal
                If ValorMun > 0 Then
                   Total.Text = CDbl(ValorMun.Text) + CDbl(Comision)  'Sumo el valor a pagar del Municipio + la Comision
                   Frame1.Enabled = True
                   efe.SetFocus
                Else
                   If CantChq.Enabled Then
                      CantChq.SetFocus
                   End If
                End If
                 
                If VLTopeMax <= 1 Then
                   VLFlagUnico = True
                Else
                   VLFlagUnico = False
                End If
            End If
            
            If Me.Tipo.Text = "003" Then 'mercados  1435
                Frame2.Enabled = False
                FCC19_gridMiLote.Top = 1100
                FCC19_gridMiLote.Left = 4700
                FCC19_gridMiLote.Caption = "Detalle de Cuotas - Mercados"
                FCC19_gridMiLote.grdDetalleML.Rows = grdBloque.Rows
                FCC19_gridMiLote.grdDetalleML.Cols = grdBloque.Cols
                FCC19_gridMiLote.grdDetalleML.Row = 0
                FCC19_gridMiLote.grdDetalleML.Col = 0
                FCC19_gridMiLote.grdDetalleML.ColWidth(0) = 450
                FCC19_gridMiLote.grdDetalleML.Col = 1
                FCC19_gridMiLote.grdDetalleML.ColWidth(1) = 1000
                FCC19_gridMiLote.grdDetalleML.ColAlignment(1) = 4
                FCC19_gridMiLote.grdDetalleML.Text = "No. Cuota"
                'msilvag Inicio Migracion WebService
                FCC19_gridMiLote.grdDetalleML.Col = 2
                FCC19_gridMiLote.grdDetalleML.ColWidth(2) = 1000
                FCC19_gridMiLote.grdDetalleML.ColAlignment(2) = 4
                FCC19_gridMiLote.grdDetalleML.Text = "Abono"
                'msilvag Fin
                FCC19_gridMiLote.grdDetalleML.Col = 3 '2 msilvag Migracion WebService
                FCC19_gridMiLote.grdDetalleML.ColWidth(3) = 2300 '2300 msilvag Migracion WebService
                FCC19_gridMiLote.grdDetalleML.ColAlignment(3) = 4
                FCC19_gridMiLote.grdDetalleML.Text = "F. Vigencia (yy/mm/dd)"
                FCC19_gridMiLote.grdDetalleML.Col = 4 '3 msilvag Migracion WebService
                FCC19_gridMiLote.grdDetalleML.ColWidth(4) = 1200
                FCC19_gridMiLote.grdDetalleML.ColAlignment(4) = 4
                FCC19_gridMiLote.grdDetalleML.Text = "Valor"
                FCC19_gridMiLote.grdDetalleML.Col = 3
                For I = 1 To grdBloque.Rows - 1
                   grdBloque.Row = I
                   grdBloque.Col = 0
                   FCC19_gridMiLote.grdDetalleML.Row = I
                   FCC19_gridMiLote.grdDetalleML.Col = 0
                   FCC19_gridMiLote.grdDetalleML.Text = Trim$(str$(I))
                   For j = 1 To grdBloque.Cols - 1
                      grdBloque.Col = j
                      FCC19_gridMiLote.grdDetalleML.Row = I
                      FCC19_gridMiLote.grdDetalleML.Col = j
                      FCC19_gridMiLote.grdDetalleML.Text = grdBloque.Text
                      If j = 3 Then
                         FCC19_gridMiLote.grdDetalleML.CellAlignment = 6
                      End If
                   Next
                Next
                
                FCC19_gridMiLote.grdDetalleML.Cols = grdBloque.Cols - 1 '2 msilvag Migracion WebService
                FCC19_gridMiLote.grdDetalleML.Row = 1
                FCC19_gridMiLote.grdDetalleML.Col = 1
                FCC19.Agno = FCC19_gridMiLote.grdDetalleML.Text
                FCC19_gridMiLote.grdDetalleML.Col = 2
                'VLFechaVigencia = Trim$(FCC19_gridMiLote.grdDetalleML.Text)
                VLFechaVigencia = Mid(FCC19_gridMiLote.grdDetalleML.Text, 1, 4) + "-" + Mid(FCC19_gridMiLote.grdDetalleML.Text, 6, 2) + "-" + Mid(FCC19_gridMiLote.grdDetalleML.Text, 9, 2) + " - " + Mid(FCC19_gridMiLote.grdDetalleML.Text, 14, 4) + "-" + Mid(FCC19_gridMiLote.grdDetalleML.Text, 19, 2) + "-" + Mid(FCC19_gridMiLote.grdDetalleML.Text, 22, 2)
                
                FCC19_gridMiLote.Show vbModal
                
               
                
        
                If ValorMun > 0 Then
                   Total.Text = CDbl(ValorMun.Text) + CDbl(Comision)  'Sumo el valor a pagar del Municipio + la Comision
                   Frame1.Enabled = True
                   efe.SetFocus
                Else
                   If CantChq.Enabled Then
                      CantChq.SetFocus
                   End If
                End If
                 
                If VLTopeMax <= 1 Then
                   VLFlagUnico = True
                Else
                   VLFlagUnico = False
                End If 'nchavezb fin 1435
            End If
            
            'msilvag Fin
            
        End Select  'hy-14-agosto-2006
    
    Case CGTeclaF9%
        If VGTipoEjecucion% = CGNormal% Then
            If FMSupervisor("19") = True Then
                VGAutoriza = "S"
            End If
        End If
    End Select
End Sub

Sub PLTransmitir()
Dim VLHorarioDifTemporal As Boolean
Dim VLUbicacion As Integer  'hy-14-agosto-2006
VLclave_acceso = "" 'ref02 vmirandt
    Dim VLContribuyente As String
    'TPE05/30/2006 Validacion Por Moneda.
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
    'TPE Validacion de Monto Efectivo
    If CDbl(efe.Text + VLEfe_com) <> SGUsar Then
        MsgBox "El Monto Efetivo No Coincide con el Monto Desglosado. Verificar", vbCritical, "Mensaje del Sistema"
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
   
   '-->lfcm 17-junio-2009 MiLote
   If municipio.Text = "1434" Then
      If Not FLTransmitir_CPS_MILOTE_pago() Then
         Exit Sub
      End If
   End If
   '--<lfcm 17-junio-2009 MiLote
   
   If municipio.Text = "1433" Then                  'lfcm 29-enero-2009
      If Not FLTransmitir_CPS_MUNGYE_pago() Then   'lfcm 29-enero-2009
         Exit Sub                                 'lfcm 29-enero-2009
      End If                                       'lfcm 29-enero-2009
   End If
   
    If municipio.Text = "1417" Then                  'ame 02/18/2010
        If Not FLTransmitir_CPS_MUNQTO_pago() Then   'ame 02/18/2010
            Exit Sub                                 'ame 02/18/2010
        End If                                       'ame 02/18/2010
    End If
   
    If municipio.Text = "1800" Then                  'hy-22-febrero-2007
        If Not FLTransmitir_CSP_MUNCUE_pago() Then   'hy-22-febrero-2007
            Exit Sub                                 'hy-22-febrero-2007
        End If                                       'hy-22-febrero-2007
    Else                                             'hy-22-febrero-2007
      VLFlagRevSP = False  'hy-15-feb-2006
    
   'nchavezb 14/02/2011 PAGO MUNICIPIO MERCADOS Y CREDENCIALES
    If municipio.Text = "1435" Then
        If Not FLTransmitir_CSP_Mercados_MUNGYE_pago() Then
            Exit Sub
        End If
    End If
    
       'smerino 10/02/2015 PAGO MUNICIPIO GUAYAQUIL CEP
    If municipio.Text = "7749" And Me.Tipo = "004" Then 'CEP Migracion WebService msilvag
        If Not FLTransmitir_MUNGYE_CEP_pago() Then
            Exit Sub
        End If
    End If
    
    'msilvag Inicio Feb-10-2016
    If Me.municipio.Text = "7749" And Me.Tipo.Text = "001" Then 'Predios
        If Not FLTransmitir_CPS_MUNGYE_pago() Then
            Exit Sub
        End If
    End If
    
    If Me.municipio.Text = "7749" And Me.Tipo.Text = "002" Then 'Mi lote
        If Not FLTransmitir_CPS_MILOTE_pago() Then
            Exit Sub
        End If
    End If
    
    If Me.municipio.Text = "7749" And Me.Tipo.Text = "003" Then 'Mercados
        If Not FLTransmitir_CSP_Mercados_MUNGYE_pago() Then
            Exit Sub
        End If
    End If
    'msilvag Fin
    
    If municipio.Text <> "1434" And municipio.Text <> "1433" And municipio.Text <> "1417" And municipio.Text <> "1800" And municipio.Text <> "1435" And municipio.Text <> "7749" Then   '-->lfcm 30-junio-2009 smerino CEP
      If FLTransmitir() = False Then
          'Sumadora ------->
          If (SGAcumulado + SGAcumuladoAdi) = 0 Then
              If efe.Enabled = True Then
                  efe.SetFocus
              End If
          End If
          '<---------
          Exit Sub
      End If
   End If    '--<lfcm 30-junio-2009
   
      '-->hy-15-feb-2006
      If VLFlagRevSP Then
          VLTipoEjecucionTemporal = VGTipoEjecucion
          VGTipoEjecucion = CGReverso
          If FLTransmitir() = False Then
              MsgBox "Fallo en la reversa del movimiento local, comunicarse con sistemas"
          End If
          VGTipoEjecucion = VLTipoEjecucionTemporal
          VLFlagRevSP = False
          Exit Sub
      End If
      
     
      '<--hy-15-feb-2006
    End If
  
    If VGTipoEjecucion = CGReverso And VGReversoLoger = "S" Then
        PMMsgError "Reverso OK", "", CGErrorInformativo
        FReverso!grdValores(0).Col = 4
        FReverso!grdValores(0).Text = "R"
    End If
  
    Select Case municipio.Text
    Case "1417"
        '-->hy-14-agosto-2006
        'PMInicioImpresion "IMPRESORA_1"
        'PMBorrarDatosImpresion
        'PMSetLineaImpresion "x" + "Inserte el formulario a imprimir"
        'PMSetLineaImpresion "<"
        'If VGTipoEjecucion = CGReverso Then
        '    VLHorario = Trim$(txtHorario.Text)
        'End If
        'PMSetLineaImpresion "v" + CStr(VGTSN%) + " " + Format(VGFechaProceso, VGFormatoFecha$) + " " + Format(Now, VGFormatoHora$) + " " + CStr(VGOficina%) + " " + CStr(FMObtenerMonedaForma("35")) + " " + VGLogin$ + " SEC" + SGSecTrn$
        'PMSetLineaImpresion "v" + VGMensImpr + IIf(Trim$(VLHorario) = "D", "3216", "3215") + " RECAUDACION DE MUNICIPIOS " + IIf(Trim$(VLHorario) = "D", "H:D", "H:N") + " " '+ IIf(VGTipoEjecucion = CGReverso, "REVERSO", "")
        'PMSetLineaImpresion "v" + "EMPRESA:" + Trim$(municipio.Text) + " " + Trim$(Mid$(sal_municipio.Caption, 1, 36))
        'PMSetLineaImpresion "v" + "CED/RUC/PAS/OTROS: " + String(14 - Len(Trim(cedula.ClipText)), "0") + Trim(cedula.ClipText)
        'PMSetLineaImpresion "v" + "CONTRIBUYENTE: " + Trim$(Left(Contribuyente.Caption, 34))
        'PMSetLineaImpresion "v" + "DIRECCION: " + Trim$(Left(Direccion.Text, 38))
        'PMSetLineaImpresion "v" + "NO.PRED/REG: " + Trim$(Predio.Caption)
        'PMSetLineaImpresion "v" + "PREDIO/RUBRO: " + Trim$(Impto.Caption) + "-" + Trim$(Left(DescripImpto.Text, 20))
        'If Trim$(Semestre.Caption) = "0" Then
        '    PMSetLineaImpresion "v" + "PERIODO TRIBUTARIO: " + Trim$(Agno.Caption)
        'Else
        '    PMSetLineaImpresion "v" + "PERIODO TRIBUTARIO: " + Trim$(Agno.Caption) + " DIV/SEM: " + Trim$(Semestre.Caption)
        'End If
        'PMSetLineaImpresion "v" + "VALOR IMPUESTO    : " + FMEspaciosATX("us$" + Format(ValImpto, VGFormatoMoney), 13, CGJustificacionDerecha)
        'PMSetLineaImpresion "v" + "DESC/INTERES/RECAR: " + FMEspaciosATX("us$" + Format(ValInteres, VGFormatoMoney), 13, CGJustificacionDerecha)
        'PMSetLineaImpresion "v" + "TOTAL             : " + FMEspaciosATX("us$" + Format(ValorMun, VGFormatoMoney), 13, CGJustificacionDerecha)
        'If Val(Efe.Text) > 0 Or Val(Cheques.Text) > 0 Then
        '    PMSetLineaImpresion "v" + "EFECTIVO: " + FMEspaciosATX("us$" + Format(Efe, VGFormatoMoney), 13, CGJustificacionDerecha) + " CHQ(" + Trim$(CantChq.Text) + "): " + FMEspaciosATX("us$" + Format(Cheques, VGFormatoMoney), 13, CGJustificacionDerecha)
        'End If
        'If Val(Debito.Text) > 0 Then
        '    PMSetLineaImpresion "v" + "CUENTA  : " + Format(Cta.ClipText, "000-000000-0") + " DEBITO : " + FMEspaciosATX("us$" + Format(Debito, VGFormatoMoney), 13, CGJustificacionDerecha)
        'End If
        'If Val(Tarjeta.Text) > 0 Then
        '    PMSetLineaImpresion "v" + "TARJETA CREDITO : " + FMEspaciosATX("us$" + Format(Tarjeta, VGFormatoMoney), 13, CGJustificacionDerecha)
        'End If
        'if VGModeloImp$ = "590" Then
        '    PMSetLineaImpresion "%R" & 6
        'End If
        'PMSetLineaImpresion ">"
        'PMImprimir "IMPRESORA_1", False
        'PMFinImpresion "IMPRESORA_1"
        'If VGTipoEjecucion = CGNormal% Then
        '    While MsgBox("Desea Reimprimir la papeleta para certificacion?", vbYesNo, "Mensaje") = vbYes
        '        PMReimpresion
        '    Wend
        'End If
        
        VGparlong$ = "90"
        VGpartop$ = "10"
        VGparleft$ = "10"
        VGparrig$ = "00"
        
        PMSetDetalle "v" + "Este pago sera procesado el " + VLFechaEfe
        PMSetDetalle "v" + " "
        PMSetDetalle "v" + "EMPRESA    : " + Trim$(municipio.Text) + " " + Trim$(Mid$(sal_municipio.Caption, 1, 36))
        PMSetDetalle "v" + "IMPUESTO   : " + Trim$(sal_tipo.Caption)
        PMSetDetalle "v" + "-------------------------------------------------"
        'msilvag Inicio SOA fase2
        If vl_servidor_BUS = "PSSRV1" Then
            PMSetDetalle "v" + "TITULO CREDITO     : " + Trim$(Mid$(Agno.Tag, 1, 12)) + " FECHA EMISION: " + Mid$(VLFechaEmision, 5, 2) + "/" + Mid$(VLFechaEmision, 7, 2) + "/" + Mid$(VLFechaEmision, 1, 4)
        Else
            PMSetDetalle "v" + "TITULO CREDITO     : " + Trim$(Mid$(Agno.Tag, 1, 12)) + " FECHA EMISION: " + VLFechaEmision  'Mid$(VLFechaEmision, 5, 2) + "/" + Mid$(VLFechaEmision, 7, 2) + "/" + Mid$(VLFechaEmision, 1, 4)
        End If
        'msilvag Fin
        If VGTipoEjecucion = CGReverso Then
            PMSetDetalle "v" + "REGISTRO MUNICIPAL : " + Trim$(VLIdenReverso)
        Else
            PMSetDetalle "v" + "REGISTRO MUNICIPAL : " + Trim$(cedula.ClipText)
        End If
        If Trim$(Tipo.Text) = "001" Then
            PMSetDetalle "v" + "CLAVE CATASTRAL    : " + Trim$(vlclavecatastral)
        End If
        PMSetDetalle "v" + "PERIODO TRIBUTACION: " + Trim$(Agno.Caption) + "   AVALUO COMERCIAL: us$" + Format$(Trim$(VLAvaluoComercial), "###,##0.00")
        PMSetDetalle "v" + "NUMERO AUTORIZACION: " + Trim$(VLNumeroAutorizacion)
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "CONTRIBUYENTE      : " + Trim$(Left(Contribuyente.Caption, 35))
        PMSetDetalle "v" + "CEDULA/RUC         : " + Trim$(VLIdentificacion)
        PMSetDetalle "v" + "DIRECCION          : " + Trim$(VLDireccion)
        PMSetDetalle "v" + "NUMERO DE CASA     : " + Trim$(VLNoCasa)
        PMSetDetalle "v" + "EXONERACION        : " + Trim$(VLExoneracion)
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "CONCEPTO"
        PMSetDetalle "v" + "-------------------------------------------------"
        'If Trim$(VLDescripcionRubro1) <> "" And CCur(VLValorRubro1) > 0 Then PMSetDetalle "v" + Trim$(VLDescripcionRubro1) + String(24 - Len(Trim$(VLDescripcionRubro1)), " ") + FMEspaciosATX("us$" + Format(Trim$(VLValorRubro1), VGFormatoMoney), 13, CGJustificacionDerecha)
        'If Trim$(VLDescripcionRubro2) <> "" And CCur(VLValorRubro2) > 0 Then PMSetDetalle "v" + Trim$(VLDescripcionRubro2) + String(24 - Len(Trim$(VLDescripcionRubro2)), " ") + FMEspaciosATX("us$" + Format(Trim$(VLValorRubro2), VGFormatoMoney), 13, CGJustificacionDerecha)
        'If Trim$(VLDescripcionRubro3) <> "" And CCur(VLValorRubro3) > 0 Then PMSetDetalle "v" + Trim$(VLDescripcionRubro3) + String(24 - Len(Trim$(VLDescripcionRubro3)), " ") + FMEspaciosATX("us$" + Format(Trim$(VLValorRubro3), VGFormatoMoney), 13, CGJustificacionDerecha)
        'If Trim$(VLDescripcionRubro4) <> "" And CCur(VLValorRubro4) > 0 Then PMSetDetalle "v" + Trim$(VLDescripcionRubro4) + String(24 - Len(Trim$(VLDescripcionRubro4)), " ") + FMEspaciosATX("us$" + Format(Trim$(VLValorRubro4), VGFormatoMoney), 13, CGJustificacionDerecha)
        'If Trim$(VLDescripcionRubro5) <> "" And CCur(VLValorRubro5) > 0 Then PMSetDetalle "v" + Trim$(VLDescripcionRubro5) + String(24 - Len(Trim$(VLDescripcionRubro5)), " ") + FMEspaciosATX("us$" + Format(Trim$(VLValorRubro5), VGFormatoMoney), 13, CGJustificacionDerecha)
        'If Trim$(VLDescripcionRubro6) <> "" And CCur(VLValorRubro6) > 0 Then PMSetDetalle "v" + Trim$(VLDescripcionRubro6) + String(24 - Len(Trim$(VLDescripcionRubro6)), " ") + FMEspaciosATX("us$" + Format(Trim$(VLValorRubro6), VGFormatoMoney), 13, CGJustificacionDerecha)
        'If Trim$(VLDescripcionRubro7) <> "" And CCur(VLValorRubro7) > 0 Then PMSetDetalle "v" + Trim$(VLDescripcionRubro7) + String(24 - Len(Trim$(VLDescripcionRubro7)), " ") + FMEspaciosATX("us$" + Format(Trim$(VLValorRubro7), VGFormatoMoney), 13, CGJustificacionDerecha)
        'If Trim$(VLDescripcionRubro8) <> "" And CCur(VLValorRubro8) > 0 Then PMSetDetalle "v" + Trim$(VLDescripcionRubro8) + String(24 - Len(Trim$(VLDescripcionRubro8)), " ") + FMEspaciosATX("us$" + Format(Trim$(VLValorRubro8), VGFormatoMoney), 13, CGJustificacionDerecha)
        'If Trim$(VLDescripcionRubro9) <> "" And CCur(VLValorRubro9) > 0 Then PMSetDetalle "v" + Trim$(VLDescripcionRubro9) + String(24 - Len(Trim$(VLDescripcionRubro9)), " ") + FMEspaciosATX("us$" + Format(Trim$(VLValorRubro9), VGFormatoMoney), 13, CGJustificacionDerecha)
        'If Trim$(VLDescripcionRubro10) <> "" And CCur(VLValorRubro10) > 0 Then PMSetDetalle "v" + Trim$(VLDescripcionRubro10) + String(24 - Len(Trim$(VLDescripcionRubro10)), " ") + FMEspaciosATX("us$" + Format(Trim$(VLValorRubro10), VGFormatoMoney), 13, CGJustificacionDerecha)
        VLValorTotalPagar = CCur(efe.Text) + CCur(Cheques.Text) + CCur(Debito.Text) + CCur(Tarjeta.Text)
        VLUbicacion = InStr(VLConcepto, "..")
        If VLUbicacion > 0 Then VLConcepto = Mid$(VLConcepto, 1, VLUbicacion - 1)
        If Trim$(VLConcepto) <> "" Then PMSetDetalle "v" + VLConcepto + String(24 - Len(Trim$(VLConcepto)), " ") + FMEspaciosATX("us$" + Format(Trim$(VLValorRubros), VGFormatoMoney), 13, CGJustificacionDerecha)
        If CCur(VLValorRecargo) <> 0 Then PMSetDetalle "v" + "Recargos                " + FMEspaciosATX("us$" + Format(Trim$(VLValorRecargo), VGFormatoMoney), 13, CGJustificacionDerecha)
        If CCur(VLValorInteres) <> 0 Then PMSetDetalle "v" + "Intereses               " + FMEspaciosATX("us$" + Format(Trim$(VLValorInteres), VGFormatoMoney), 13, CGJustificacionDerecha)
        If CCur(VLValorCostas) <> 0 Then PMSetDetalle "v" + "Costas judiciales       " + FMEspaciosATX("us$" + Format(Trim$(VLValorCostas), VGFormatoMoney), 13, CGJustificacionDerecha)
        If CCur(VLValorDescuentos) <> 0 Then PMSetDetalle "v" + "Descuentos              " + FMEspaciosATX("us$" + Format(Trim$(VLValorDescuentos), VGFormatoMoney), 13, CGJustificacionDerecha)
        PMSetDetalle "v" + "TOTAL A PAGAR           " + FMEspaciosATX("us$" + Format(Trim$(VLValorTotalPagar), VGFormatoMoney), 13, CGJustificacionDerecha)
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "FORMAS DE PAGO:"
        PMSetDetalle "v" + "-------------------------------------------------"
        If val(efe.Text) > 0 Then
            PMSetDetalle "v" + "EFECTIVO: " + FMEspaciosATX("us$" + Format(efe, VGFormatoMoney), 13, CGJustificacionDerecha)
        End If
        If val(Cheques.Text) > 0 Then
            PMSetDetalle "v" + "CHEQUE(" + Trim$(CantChq.Text) + "): " + FMEspaciosATX("us$" + Format(Cheques, VGFormatoMoney), 13, CGJustificacionDerecha)
        End If
        If val(Debito.Text) > 0 Then
            PMSetDetalle "v" + "DEBITO : " + FMEspaciosATX("us$" + Format(Debito, VGFormatoMoney), 13, CGJustificacionDerecha) + " CUENTA : " + Format(Cta.ClipText, "000-000000-0")
        End If
        If val(Tarjeta.Text) > 0 Then
            PMSetDetalle "v" + "TARJETA CREDITO : " + FMEspaciosATX("us$" + Format(Tarjeta, VGFormatoMoney), 13, CGJustificacionDerecha)
        End If
    '***ref02 vmirandt inicio, se imprime al final del documento
    If VLclave_acceso <> "" Then
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "Clave de Acceso/Autorizacion: "
        PMSetDetalle "v" + VLclave_acceso
    End If
    'ref02 vmirandt
    PMSetDetalle "v" + "-------------------------------------------------"
    

        VLHorarioDifTemporal = VGHorarioDif
        'If VLHorario = "N" Then
           ' VGHorarioDif = False
        'Else
        '    VGHorarioDif = True
        'End If
        
    If VGHorarioDif Then
        VLTrn = "3216"
    Else
        VLTrn = "3215"
    End If
    
FMPRN_StdImpresion "IMPRESORA_1", False, Trim$(str$(VLTsnTemporal)), "19", SGDatosDetalle, "Inserte papeleta", CStr(VGpartop$), 1, CStr(VGparleft$), , , VLHorario, , , "1", VLTrn
 
'FMPRN_StdImpresion "IMPRESORA_1", False, Trim$(Str$(VLTsnTemporal)), "19", SGDatosDetalle, "Inserte papeleta", CStr(VGpartop$), 1, CStr(VGparleft$), , , , , 3215, "1"
        VGHorarioDif = VLHorarioDifTemporal
    
        If VGTipoEjecucion = CGNormal% Then
            While MsgBox("Desea Reimprimir la papeleta para certificacion?", vbYesNo, "Mensaje") = vbYes
                PMReimpresion
            Wend
        End If
        '-->hy-14-agosto-2006
    Case "1435"
    'Comprobante de Mercados y Credenciales Guayaquil
'nchavezb 02/14/2011

         VGparlong$ = "66"
         VGpartop$ = "00"
         VGparleft$ = "10"
         VGparrig$ = "00"
    Dim Fecha As String
    Fecha = Trim$(Mid$(VLFechaEfe, 1, 11))
    PMSetDetalle "v" + "Este pago sera procesado el " + Trim$(Fecha)
    PMSetDetalle "v" + "EMPRESA:   " + Trim$(municipio.Text) + " " + Trim$(Mid$(sal_municipio.Caption, 1, 30))
    PMSetDetalle "v" + "SOLICITUD: " + Trim$(sal_tipo.Caption) + " - " + Trim$(VLCodSolicitud) + "  " + "No. AUT.:" + Trim$(VGSecBanredMG)
    If vlclavecatastral <> "" Then
    PMSetDetalle "v" + "CED.: " + Trim$(cedula.ClipText) + "  " + "#CATAST.:  " + (vlclavecatastral) + "   "
    End If
    If vlclavecatastral = "" Then
    PMSetDetalle "v" + "CED.: " + Trim$(cedula.ClipText)
    End If
    
    PMSetDetalle "v" + "CONTRIBU.: " + Trim$(Left(Contribuyente.Caption, 30))
    PMSetDetalle "v" + "VIGENC.:" + Trim$(VLMLPeriodoVigencia) + "  " + "MERCADO: " + Trim$(Mid$(VLMercado, 1, 20))
    If Tarjeta = "0.00" Then
    PMSetDetalle "v" + "VALOR:     " + FMEspaciosATX("USD.   " + Format(Trim$(ValorMun), VGFormatoMoney), 13, CGJustificacionDerecha)
    End If
    If Tarjeta <> "0.00" Then
    PMSetDetalle "v" + "VALOR:  " + FMEspaciosATX("USD.   " + Format(Trim$(ValorMun), VGFormatoMoney), 13, CGJustificacionDerecha) + "  " + "TARJETA: " + FMEspaciosATX("USD.   " + Format(Trim$(Tarjeta.Text), VGFormatoMoney), 13, CGJustificacionDerecha)
    End If
    If efe.Text <> "0.00" And Cheques.Text <> "0.00" Then
    PMSetDetalle "v" + "EFE.:   " + FMEspaciosATX("USD.   " + Format(Trim$(efe.Text), VGFormatoMoney), 13, CGJustificacionDerecha) + "  " + "CHQ(1):" + FMEspaciosATX(Format(Trim$(Cheques.Text), VGFormatoMoney), 13, CGJustificacionDerecha)
    End If
    If efe.Text <> "0.00" And Cheques.Text = "0.00" Then
    PMSetDetalle "v" + "EFE.:   " + FMEspaciosATX("USD.   " + Format(Trim$(efe.Text), VGFormatoMoney), 13, CGJustificacionDerecha)
    End If
    If efe.Text = "0.00" And Cheques.Text <> "0.00" Then
    PMSetDetalle "v" + "CHQ(1): " + FMEspaciosATX(Format(Trim$(Cheques.Text), VGFormatoMoney), 13, CGJustificacionDerecha)
    End If
    If Debito.Text <> "0.00" Then
    PMSetDetalle "v" + "DEB.:   " + FMEspaciosATX("USD.   " + Format(Trim$(Debito.Text), VGFormatoMoney), 13, CGJustificacionDerecha) + "  " + "CTA. :    " + Trim$(Cta.ClipText)
    End If
    
    
    PMSetDetalle "v" + "TOTAL:   " + FMEspaciosATX("USD.   " + Format(Trim$(ValorMun.Text), VGFormatoMoney), 13, CGJustificacionDerecha)

    If Debito.Text <> "0.00" And efe.Text <> "0.00" And Cheques.Text <> "0.00" Then
    If VGModeloImp$ = "590" Then
        PMSetDetalle "%R" & 4
    End If
    End If

    '***ref02 vmirandt inicio, se imprime al final del documento
    If VLclave_acceso <> "" Then
        PMSetDetalle "v" + "Clave de Acceso/Autorizacion: "
        PMSetDetalle "v" + VLclave_acceso
    End If
    'ref02 vmirandt

    VLHorarioDifTemporal = VGHorarioDif
'    If VLHorario = "N" Then
'        VGHorarioDif = False
'        VLTrn = "3215"
'    Else
'        VGHorarioDif = True
'        VLTrn = "3216"
'    End If
    
    If VGHorarioDif Then
        VLTrn = "3216"
    Else
        VLTrn = "3215"
    End If
    
 FMPRN_StdImpresion "IMPRESORA_1", False, Trim$(str$(VLTsnTemporal)), "19", SGDatosDetalle, "Inserte papeleta", CStr(VGpartop$), 1, CStr(VGparleft$), , , VLHorario, , , "1", VLTrn
'FMPRN_StdImpresion "IMPRESORA_1", False, Trim$(Str$(VLTsnTemporal)), "19", SGDatosDetalle, "Inserte papeleta", CStr(VGpartop$), 1, CStr(VGparleft$), , , VLHorario, , "3215", "1", VLTrn
 
        If VGTipoEjecucion = CGNormal% Then
            While MsgBox("Desea Reimprimir la papeleta para certificacion?", vbYesNo, "Mensaje") = vbYes
                PMReimpresion
            Wend
        End If
    Case "1433"
        'If Not FMFormatPagina(VGparformato$, VGparlong$, VGpartop$, VGparleft$, VGparrig$) Then
            VGparlong$ = "90"
            VGpartop$ = "10"
            VGparleft$ = "10"
            VGparrig$ = "00"
        'End If
        
        PMSetDetalle "v" + "Este pago sera procesado el " + VLFechaEfe
        PMSetDetalle "v" + " "
        PMSetDetalle "v" + "EMPRESA    : " + Trim$(municipio.Text) + " " + Trim$(Mid$(sal_municipio.Caption, 1, 36))
        '-->hy-21-diciembre-2006 [pase rezagado] estaba comentado
'-->lfcm 29-octubre-2008
'        PMSetDetalle "v" + "CLIENTE    : " + Trim$(VLNombreCliente)
'        If (Len(Trim$(cedula.ClipText)) = 13 Or Len(Trim$(cedula.ClipText)) = 14) And Mid$(cedula.ClipText, 1, 3) = "000" Then
'            PMSetDetalle "v" + "CEDULA/RUC : " + Right(cedula.ClipText, 10)
'        Else
'            PMSetDetalle "v" + "CEDULA/RUC : " + cedula.ClipText
'        End If
'--<lfcm 29-octubre-2008
        '<--hy-21-diciembre-2006 [pase rezagado] estaba comentado
        PMSetDetalle "v" + " "
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "CONTRIBUYENTE      : " + Trim$(Left(Contribuyente.Caption, 35))
        PMSetDetalle "v" + "COD CATASTRAL      : " + IIf(VGTipoEjecucion = CGReverso, txtcat1.Text, cat1.ClipText) + "-" + String(4 - Len(Trim$(cat2.ClipText)), "0") + Trim$(cat2.ClipText) + "-" + String(3 - Len(Trim$(cat3.ClipText)), "0") + Trim$(cat3.ClipText) + "-" + String(4 - Len(Trim$(cat4.ClipText)), "0") + Trim$(cat4.ClipText) + "-" + String(4 - Len(Trim$(cat5.ClipText)), "0") + Trim$(cat5.ClipText) + "-" + String(4 - Len(Trim$(cat6.ClipText)), "0") + Trim$(cat6.ClipText)
        PMSetDetalle "v" + "PERIODO TRIBUTARIO : " + Agno.Caption
        'PMSetDetalle "v" + "AUTORIZACION       : " + VLNumAutorizacion
        PMSetDetalle "v" + "AUTORIZACION       : " + CStr(Format(VGSecBanredMG, "0000000000"))                'lfcm 13-febrero-2009
        PMSetDetalle "v" + "COMP. INGRESO CAJA : " + CStr(Format(VLCodigoCUIC, "0000000000"))                'GAMC 21ENE2010
        PMSetDetalle "v" + " "
        PMSetDetalle "v" + "TOTAL A PAGAR      : " + FMEspaciosATX("us$" + Format(ValorMun, VGFormatoMoney), 13, CGJustificacionDerecha)
        PMSetDetalle "v" + " "
        PMSetDetalle "v" + "FORMAS DE PAGO:"
        PMSetDetalle "v" + " "
        PMSetDetalle "v" + "-------------------------------------------------"
        If val(efe.Text) > 0 Then
            PMSetDetalle "v" + "EFECTIVO: " + FMEspaciosATX("us$" + Format(efe, VGFormatoMoney), 13, CGJustificacionDerecha)
        End If
        If val(Cheques.Text) > 0 Then
            PMSetDetalle "v" + "CHEQUE(" + Trim$(CantChq.Text) + "): " + FMEspaciosATX("us$" + Format(Cheques, VGFormatoMoney), 13, CGJustificacionDerecha)
        End If
        If val(Debito.Text) > 0 Then
            PMSetDetalle "v" + "DEBITO : " + FMEspaciosATX("us$" + Format(Debito, VGFormatoMoney), 13, CGJustificacionDerecha) + " CUENTA : " + Format(Cta.ClipText, "000-000000-0")
        End If
        If val(Tarjeta.Text) > 0 Then
            PMSetDetalle "v" + "TARJETA CREDITO : " + FMEspaciosATX("us$" + Format(Tarjeta, VGFormatoMoney), 13, CGJustificacionDerecha)
        End If
    '***ref02 vmirandt inicio, se imprime al final del documento
    If VLclave_acceso <> "" Then
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "Clave de Acceso/Autorizacion: "
        PMSetDetalle "v" + VLclave_acceso
    End If
    'ref02 vmirandt
        
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + " "
        '-->hy-21-diciembre-2006 [pase rezagado]
        'PMSetDetalle "v" + "AVISO:PARA RETIRAR SU TITULO DE CREDITO ACERCARSE"
        'PMSetDetalle "v" + "CON ESTE COMPROBANTE A LA VENTANILLA DE 'ENTREGA"
        'PMSetDetalle "v" + "DE TITULOS DE CREDITO' DE LA M.I. MUNICIPALIDAD"
        'PMSetDetalle "v" + "DE GUAYAQUIL, LUEGO DE 3 DIAS LABORABLES DE HABER"
        'PMSetDetalle "v" + "REALIZADO EL PAGO"
'--> lfcm 29-octubre-2008
'        PMSetDetalle "v" + "AVISO:PARA RETIRAR SU TITULO DE CREDITO ACERCARSE"
'        PMSetDetalle "v" + "CON ESTE COMPROBANTE A LA VENTANILLA DEL 'LOBBY"
'        PMSetDetalle "v" + "24 HORAS' DE LA MATRIZ DEL BANCO BOLIVARIANO,"
'        PMSetDetalle "v" + "UBICADO EN JUNIN 200 Y PANAMA, LUEGO DE 3 DIAS"
'        PMSetDetalle "v" + "LABORABLES DE HABER REALIZADO EL PAGO"
        
        'PMSetDetalle "v" + "AVISO: PARA RETIRAR SU TITULO DE CREDITO ACERCARSE"     'lfcm 09-diciembre-2009
        'PMSetDetalle "v" + "CON ESTE COMPROBANTE A LAS VENTANILLAS DE 'ENTREGA"     'lfcm 09-diciembre-2009
        'PMSetDetalle "v" + "DE TITULOS DE CREDITO' DE LA M.I. MUNICIPALIDAD"        'lfcm 09-diciembre-2009
        'PMSetDetalle "v" + "DE GUAYAQUIL, LUEGO DE 3 DIAS LABORABLES DE HABER"      'lfcm 09-diciembre-2009
        'PMSetDetalle "v" + "REALIZADO EL PAGO"                                      'lfcm 09-diciembre-2009
'--< lfcm 29-octubre-2008

'--> lfcm 09-diciembre-2009 SMERINO COMENTA
'        PMSetDetalle "v" + "AVISO: PARA RETIRAR SU TITULO DE CREDITO ACERCARSE CON"
'        PMSetDetalle "v" + "ESTE COMPROBANTE A LA VENTANILLA #17 DE RECAUDACIONES "
'        PMSetDetalle "v" + "DEL DPTO. DE RENTAS DE LA DIRECCION FINANCIERA DE LA  "
'        PMSetDetalle "v" + "M.I. MUNICIPALIDAD DE GUAYAQUIL, UBICADA EN EL BLOQUE "
'        PMSetDetalle "v" + "#2 NOROESTE, PICHINCHA Y CLEMENTE BALLEN (ESQUINA),   "
'        PMSetDetalle "v" + "LUEGO DE 3 DIAS LABORABLES DE HABER REALIZADO EL PAGO."
'--< lfcm 09-diciembre-2009
'-->smerinom 09-diciembre-2014 COMPROBANTE
        PMSetDetalle "v" + "AVISO: ESTIMADO CLIENTE  EN 48 HORAS LABORABLES, USTED"
        PMSetDetalle "v" + "PODRA   DESCARGAR   EL  RECIBO  ELECTRONICO  DE   PAGO"
        PMSetDetalle "v" + "EN  LA PAGINA   WEB   DEL   MUNICIPIO   DE   GUAYAQUIL"
        PMSetDetalle "v" + "(www.guayaquil.gob.ec) EN LA RUTA SERVICIOS EN LINEA"

'--<smerinom 09-diciembre-2014


        '<--hy-21-diciembre-2006 [pase rezagado]
        PMSetDetalle "v" + " "
        PMSetDetalle "v" + ""
        
        VLHorarioDifTemporal = VGHorarioDif
'        If VLHorario = "N" Then
'            VGHorarioDif = False
'            VLTrn = "3215"    'lfcm 06-marzo-2009
'        Else
'            VGHorarioDif = True
'            VLTrn = "3216"     'lfcm 06-marzo-2009
'        End If
        
        If VGHorarioDif Then
        VLTrn = "3216"
    Else
        VLTrn = "3215"
    End If
    
 FMPRN_StdImpresion "IMPRESORA_1", False, Trim$(str$(VLTsnTemporal)), "19", SGDatosDetalle, "Inserte papeleta", CStr(VGpartop$), 1, CStr(VGparleft$), , , VLHorario, , , "1", VLTrn
        'FMPRN_StdImpresion "IMPRESORA_1", False, Trim$(Str$(VLTsnTemporal)), "19", SGDatosDetalle, "Inserte papeleta", CStr(VGpartop$), 1, CStr(VGparleft$), , , , , "3215"
        'FMPRN_StdImpresion "IMPRESORA_1", False, Trim$(Str$(VLTsnTemporal)), "19", SGDatosDetalle, "Inserte papeleta", CStr(VGpartop$), 1, CStr(VGparleft$), , , , , "3215", , VLTrn
        VGHorarioDif = VLHorarioDifTemporal
    
        If VGTipoEjecucion = CGNormal% Then
            While MsgBox("Desea Reimprimir la papeleta para certificacion?", vbYesNo, "Mensaje") = vbYes
                PMReimpresion
            Wend
        End If
    
    '-->hy-22-febrero-2007
    Case "1800"
        VGparlong$ = "90"
        VGpartop$ = "10"
        VGparleft$ = "10"
        VGparrig$ = "00"
        
        PMSetDetalle "v" + "Este pago sera procesado el " + VLFechaEfe
        PMSetDetalle "v" + " "
        PMSetDetalle "v" + "EMPRESA    : " + Trim$(municipio.Text) + " " + Trim$(Mid$(sal_municipio.Caption, 1, 36))
        PMSetDetalle "v" + "IMPUESTO   : " + Trim$(sal_tipo.Caption)
        PMSetDetalle "v" + "-------------------------------------------------"
        If Trim$(Tipo.Text) = "003" Then
           PMSetDetalle "v" + "CÉDULA/RUC         : " + Trim$(txtLlaveMunicipal.Text)
        Else
           PMSetDetalle "v" + "CLAVE CATASTRAL    : " + Trim$(txtLlaveMunicipal.Text)
        End If
        If Trim$(Tipo.Text) = "002" Then
           PMSetDetalle "v" + "No. DIVIDENDO: " + Trim$(Agno.Caption)
        Else
           PMSetDetalle "v" + "PERIODO TRIBUTACION: " + Trim$(Agno.Caption)
        End If
        
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "CONTRIBUYENTE      : " + Trim$(Left(Contribuyente.Caption, 35))
        PMSetDetalle "v" + "CEDULA/RUC         : " + Trim$(VLIdentificacion)
        PMSetDetalle "v" + "DIRECCION          : " + Trim$(VLDireccion)
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "CONCEPTO"
        PMSetDetalle "v" + "-------------------------------------------------"
        
        If Trim$(VLRubro) <> "" Then
          PMSetDetalle "v" + VLRubro + String(24 - Len(Trim$(VLRubro)), " ") + FMEspaciosATX("us$" + Format(CDbl(VLMunCue_Emision) / 100, VGFormatoMoney), 13, CGJustificacionDerecha)
        End If
        
        'PMSetDetalle "v" + "Emision                 " + FMEspaciosATX("us$" + Format(CDbl(VLMunCue_Emision) / 100, VGFormatoMoney), 13, CGJustificacionDerecha)
        
        'PMSetDetalle "v" + "Exoneracion             " + FMEspaciosATX("us$" + Format(CDbl(VLMunCue_Exoneracion) / 100, VGFormatoMoney), 13, CGJustificacionDerecha)
        'PMSetDetalle "v" + "Descuentos              " + FMEspaciosATX("us$" + Format(CDbl(VLMunCue_Descuentos) / 100, VGFormatoMoney), 13, CGJustificacionDerecha)
        'PMSetDetalle "v" + "Recargos                " + FMEspaciosATX("us$" + Format(CDbl(VLMunCue_Recargos) / 100, VGFormatoMoney), 13, CGJustificacionDerecha)
        'PMSetDetalle "v" + "Intereses               " + FMEspaciosATX("us$" + Format(CDbl(VLMunCue_Intereses) / 100, VGFormatoMoney), 13, CGJustificacionDerecha)
        'PMSetDetalle "v" + "TOTAL A PAGAR           " + FMEspaciosATX("us$" + Format(CDbl(VLMunCue_Total) / 100, VGFormatoMoney), 13, CGJustificacionDerecha)
        'PMSetDetalle "v" + "TOTAL A PAGAR           " + FMEspaciosATX("us$" + Format(CDbl(VLMunCue_Total) / 100, VGFormatoMoney), 13, CGJustificacionDerecha)  'smerino
        PMSetDetalle "v" + "TOTAL A PAGAR           " + FMEspaciosATX("us$" + ValorMun.Text, 13, CGJustificacionDerecha)
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "FORMAS DE PAGO:"
        PMSetDetalle "v" + "-------------------------------------------------"
        If val(efe.Text) > 0 Then
            PMSetDetalle "v" + "EFECTIVO: " + FMEspaciosATX("us$" + Format(efe, VGFormatoMoney), 13, CGJustificacionDerecha)
        End If
        If val(Cheques.Text) > 0 Then
            PMSetDetalle "v" + "CHEQUE(" + Trim$(CantChq.Text) + "): " + FMEspaciosATX("us$" + Format(Cheques, VGFormatoMoney), 13, CGJustificacionDerecha)
        End If
        If val(Debito.Text) > 0 Then
            PMSetDetalle "v" + "DEBITO : " + FMEspaciosATX("us$" + Format(Debito, VGFormatoMoney), 13, CGJustificacionDerecha) + " CUENTA : " + Format(Cta.ClipText, "000-000000-0")
        End If
        If val(Tarjeta.Text) > 0 Then
            PMSetDetalle "v" + "TARJETA CREDITO : " + FMEspaciosATX("us$" + Format(Tarjeta, VGFormatoMoney), 13, CGJustificacionDerecha)
        End If
    '***ref02 vmirandt inicio, se imprime al final del documento
    If VLclave_acceso <> "" Then
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "Clave de Acceso/Autorizacion: "
        PMSetDetalle "v" + VLclave_acceso
    End If
    'ref02 vmirandt
        
        PMSetDetalle "v" + "-------------------------------------------------"
        If Trim$(Tipo.Text) = "001" Then
            PMSetDetalle "v" + " "
            PMSetDetalle "v" + "SU TITULO DE IMPUESTO MUNICIPAL DEBERA SER"
            PMSetDetalle "v" + "RETIRADO EN LA TESORERIA DEL MUNICIPIO DE CUENCA"
            PMSetDetalle "v" + "A LAS 48 HORAS LABORABLES DE LA FECHA DE PAGO"
            PMSetDetalle "v" + " "
        End If
        PMSetDetalle "v" + ""
        VLHorarioDifTemporal = VGHorarioDif
        VGHorarioDif = False
        FMPRN_StdImpresion "IMPRESORA_1", False, Trim$(str$(VLTsnTemporal)), "19", SGDatosDetalle, "Inserte papeleta", CStr(VGpartop$), 1, CStr(VGparleft$), , , VLHorario, , "3215", "1"
        VGHorarioDif = VLHorarioDifTemporal
    
        If VGTipoEjecucion = CGNormal% Then
            While MsgBox("Desea Reimprimir la papeleta para certificacion?", vbYesNo, "Mensaje") = vbYes
                PMReimpresion
            Wend
        End If
    '<--hy-22-febrero-2007
    
    '-->hy-22-febrero-2007
    'GAMC - 05/03/2008 - Municipio de Salinas
    Case "2237"
        Call Muni_2237("3", 0)
    'GAMC - 05/03/2008 - Municipio de Salinas
    Case "2235"
        Call Muni_2235("3", 0)
    'Wise - 14/Agt/2008 - Municio Libertad = 2236
    Case "2236"
        Call Muni_2236("3", 0)
        
    Case "1430" 'nchavezb 08/Agosto/2011
        Call Muni_1430("3", 0) 'Municipio Daule
        
    '-- End Wise --
    'GAMC - 23/02/2008 - COMPROBANTE DE PAGO - INI
    Case "2319"
        VGparlong$ = "90"
        VGpartop$ = "10"
        VGparleft$ = "10"
        VGparrig$ = "00"
        
        PMSetDetalle "v" + "Este pago sera procesado el " + VLFechaEfe
        PMSetDetalle "v" + " "
        PMSetDetalle "v" + "EMPRESA    : " + Trim$(municipio.Text) + " " + Trim$(Mid$(sal_municipio.Caption, 1, 36))
        PMSetDetalle "v" + "IMPUESTO   : " + Trim$(Impto.Caption) + "-" + Trim$(Impto.Tag)
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "CODIGO PREDIAL     : " + Trim$(Me.txtCatasSamb.Text)
        PMSetDetalle "v" + "CODIGO ANTERIOR    : " + Trim$(Mid$(VLMuniSamb(0), 1, 30))
        PMSetDetalle "v" + "PERIODO TRIBUTACION: " + Trim$(Agno.Caption) ' + " FEC.VENC: " + VLGridFecVen
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "CONTRIBUYENTE      : " + Trim$(Left(Contribuyente.Caption, 35))
        PMSetDetalle "v" + "DIRECCION          : " + Trim$(Mid$(VLMuniSamb(1), 1, 30))
        PMSetDetalle "v" + "SOLAR              : " + Trim$(Mid$(VLMuniSamb(2), 1, 30))
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "CONCEPTO"
        PMSetDetalle "v" + "-------------------------------------------------"
        Dim VLTemporal As String
        VLTemporal = Trim$(Impto.Tag)
        VLTemporal = Mid$(VLTemporal, 1, 19)
        VLTemporal = VLTemporal + String(19 - Len(VLTemporal), " ")
        'PMSetDetalle "v" + VLTemporal + ": " + FMEspaciosATX("USD      " + Format(Trim$(VLGridImpuestos), VGFormatoMoney), 5, CGJustificacionDerecha)
        'PMSetDetalle "v" + "PREDIO RUBANO      : " + FMEspaciosATX("USD      " + Format(Trim$(VLMuniSamb(3)), VGFormatoMoney), 13, CGJustificacionDerecha)
        PMSetDetalle "v" + VLTemporal + ": " + FMEspaciosATX("USD      " + Format(Trim$(VLMuniSamb(3)), VGFormatoMoney), 13, CGJustificacionDerecha)
        PMSetDetalle "v" + "DESC/INTERES/RECAR : " + FMEspaciosATX("USD      " + Format(Trim$(VLMuniSamb(4)), VGFormatoMoney), 13, CGJustificacionDerecha)
        PMSetDetalle "v" + "TOTAL A PAGAR      : " + FMEspaciosATX("USD      " + Format(Trim$(ValorMun.Text), VGFormatoMoney), 13, CGJustificacionDerecha)
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "FORMAS DE PAGO:"
        PMSetDetalle "v" + "-------------------------------------------------"
        If val(efe.Text) > 0 Then
            PMSetDetalle "v" + "EFECTIVO           : " + FMEspaciosATX("USD      " + Format(efe, VGFormatoMoney), 13, CGJustificacionDerecha)
        End If
        If val(Cheques.Text) > 0 Then
            PMSetDetalle "v" + "CHEQUE(" + Trim$(CantChq.Text) + ")          : " + FMEspaciosATX("USD      " + Format(Cheques, VGFormatoMoney), 13, CGJustificacionDerecha)
        End If
        If val(Debito.Text) > 0 Then
            PMSetDetalle "v" + "DEBITO             : " + FMEspaciosATX("USD      " + Format(Debito, VGFormatoMoney), 13, CGJustificacionDerecha) + " CUENTA : " + Format(Cta.ClipText, "000-000000-0")
        End If
        If val(Tarjeta.Text) > 0 Then
            PMSetDetalle "v" + "TARJETA CREDITO    : " + FMEspaciosATX("USD      " + Format(Tarjeta, VGFormatoMoney), 13, CGJustificacionDerecha)
        End If
    '***ref02 vmirandt inicio, se imprime al final del documento
    If VLclave_acceso <> "" Then
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "Clave de Acceso/Autorizacion: "
        PMSetDetalle "v" + VLclave_acceso
    End If
    'ref02 vmirandt
        PMSetDetalle "v" + "-------------------------------------------------"
        If VGTipoEjecucion <> CGReverso Then
            'PMSetDetalle "v" + "AVISO: PARA RETIRAR SU TITULO DE CREDITO, "
            'PMSetDetalle "v" + "ACERCARSE CON ESTE COMPROBANTE AL MUNICIPIO DE"
            'PMSetDetalle "v" + "SAMBORONDON AGENCIA SUR EN EL C.C.RIO PLAZA OF. 5,"
            PMSetDetalle "v" + "AVISO: PARA RETIRAR SU TITULO, ACERCARSE CON ESTE"      'GAMC 07FEB2012 - CAMBIO EN COMPROBANTE
            PMSetDetalle "v" + "COMPROBANTE AL MUN. DE SAMBORONDON,"
            PMSetDetalle "v" + "AG. SUR-LA PUNTILLA, KM 10 VIA SAMBORONDON"
            PMSetDetalle "v" + "LUEGO DE 48 HORAS LABORABLES DE HABER REALIZADO EL PAGO"
        End If
        
        VLHorarioDifTemporal = VGHorarioDif
        If VLHorario = "N" Then
            VGHorarioDif = False
            VLTrn = "3215"
        Else
            VGHorarioDif = True
            VLTrn = "3216"
        End If
        
        FMPRN_StdImpresion "IMPRESORA_1", False, Trim$(str$(VLTsnTemporal)), "19", SGDatosDetalle, "Inserte papeleta", CStr(VGpartop$), 1, CStr(VGparleft$), , , VLHorario, , , "1", VLTrn
        VGHorarioDif = VLHorarioDifTemporal
        
        If VGTipoEjecucion = CGNormal% Then
            While MsgBox("Desea Reimprimir la papeleta para certificacion?", vbYesNo, "Mensaje") = vbYes
                PMReimpresion
            Wend
        End If
        '<--hy-05-noviembre-2007
        
        Case "2234"
        VGparlong$ = "90"
        VGpartop$ = "10"
        VGparleft$ = "10"
        VGparrig$ = "00"
        
        PMSetDetalle "v" + "Este pago sera procesado el " + VLFechaEfe
        PMSetDetalle "v" + " "
        PMSetDetalle "v" + "EMPRESA    : " + Trim$(municipio.Text) + " " + Trim$(Mid$(sal_municipio.Caption, 1, 36))
        PMSetDetalle "v" + "IMPUESTO   : " + Trim$(Impto.Caption) + "-" + Trim$(Impto.Tag)
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "CLAVE CATASTRAL    : " + Trim$(Predio.Caption)
        PMSetDetalle "v" + "CODIGO DE INGRESO  : " + Trim$(Prioridad.Text)
        PMSetDetalle "v" + "PERIODO TRIBUTACION: " + Trim$(Agno.Caption) + " FEC.VENC: " + VLGridFecVen
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "CONTRIBUYENTE      : " + Trim$(Left(Contribuyente.Caption, 35))
        PMSetDetalle "v" + "CEDULA/RUC         : " + Trim$(VLIdentificacion)
        PMSetDetalle "v" + "DIRECCION          : " + Trim$(direccion.Text)   'Trim$(VLDireccion)
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "CONCEPTO"
        PMSetDetalle "v" + "-------------------------------------------------"
        Dim VLTemporal1 As String
        VLTemporal1 = Trim$(Impto.Tag)
        VLTemporal1 = Mid$(VLTemporal1, 1, 33)
        VLTemporal1 = VLTemporal1 + String(33 - Len(VLTemporal1), " ")
        PMSetDetalle "v" + VLTemporal1 + ": " + FMEspaciosATX("us$" + Format(Trim$(VLGridImpuestos), VGFormatoMoney), 13, CGJustificacionDerecha)
        PMSetDetalle "v" + "DESC/INTERES/RECAR               : " + FMEspaciosATX("us$" + Format(Trim$(VLGridDescuentos), VGFormatoMoney), 13, CGJustificacionDerecha)
        PMSetDetalle "v" + "TOTAL A PAGAR                    : " + FMEspaciosATX("us$" + Format(Trim$(ValorMun.Text), VGFormatoMoney), 13, CGJustificacionDerecha)
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "FORMAS DE PAGO:"
        PMSetDetalle "v" + "-------------------------------------------------"
        If val(efe.Text) > 0 Then
            PMSetDetalle "v" + "EFECTIVO: " + FMEspaciosATX("us$" + Format(efe, VGFormatoMoney), 13, CGJustificacionDerecha)
        End If
        If val(Cheques.Text) > 0 Then
            PMSetDetalle "v" + "CHEQUE(" + Trim$(CantChq.Text) + "): " + FMEspaciosATX("us$" + Format(Cheques, VGFormatoMoney), 13, CGJustificacionDerecha)
        End If
        If val(Debito.Text) > 0 Then
            PMSetDetalle "v" + "DEBITO : " + FMEspaciosATX("us$" + Format(Debito, VGFormatoMoney), 13, CGJustificacionDerecha) + " CUENTA : " + Format(Cta.ClipText, "000-000000-0")
        End If
        If val(Tarjeta.Text) > 0 Then
            PMSetDetalle "v" + "TARJETA CREDITO : " + FMEspaciosATX("us$" + Format(Tarjeta, VGFormatoMoney), 13, CGJustificacionDerecha)
        End If
    '***ref02 vmirandt inicio, se imprime al final del documento
    If VLclave_acceso <> "" Then
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "Clave de Acceso/Autorizacion: "
        PMSetDetalle "v" + VLclave_acceso
    End If
    'ref02 vmirandt
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "AVISO: PARA RETIRAR SU TITULO DE CREDITO, "
        PMSetDetalle "v" + "ACERCARSE CON ESTE COMPROBANTE A LA TESORERIA DE"
        PMSetDetalle "v" + "LA ILUSTRE MUNICIPALIDAD DE IBARRA, LUEGO DE "
        PMSetDetalle "v" + "24 HORAS DE HABER REALIZADO EL PAGO"
        
        VLHorarioDifTemporal = VGHorarioDif
        If VLHorario = "N" Then
            VGHorarioDif = False
            VLTrn = "3215"
        Else
            VGHorarioDif = True
            VLTrn = "3216"
        End If
        
        FMPRN_StdImpresion "IMPRESORA_1", False, Trim$(str$(VLTsnTemporal)), "19", SGDatosDetalle, "Inserte papeleta", CStr(VGpartop$), 1, CStr(VGparleft$), , , , , , "1", VLTrn
        VGHorarioDif = VLHorarioDifTemporal
        
        If VGTipoEjecucion = CGNormal% Then
            While MsgBox("Desea Reimprimir la papeleta para certificacion?", vbYesNo, "Mensaje") = vbYes
                PMReimpresion
            Wend
        End If
        'GAMC - 23/02/2008 - COMPROBANTE DE PAGO - FIN
    'smerino Munic Cep 11062015
    Case "7749" 'paola2
         If Trim(Me.Tipo.Text) = "001" Then
            VGparlong$ = "90"
            VGpartop$ = "10"
            VGparleft$ = "10"
            VGparrig$ = "00"
        
                    PMSetDetalle "v" + "Este pago sera procesado el " + VLFechaEfe
                    PMSetDetalle "v" + " "
                    PMSetDetalle "v" + "Empresa: " + Trim$(municipio.Text) + " " + Trim$(Mid$(sal_municipio.Caption, 1, 36))
                    PMSetDetalle "v" + "Tipo de Servicio: " + Trim$(sal_tipo)
                    PMSetDetalle "v" + " "
                    PMSetDetalle "v" + "-------------------------------------------------"
                    PMSetDetalle "v" + "CONTRIBUYENTE      : " + Trim$(Left(Contribuyente.Caption, 35))
                    'PMSetDetalle "v" + "COD CATASTRAL      : " + IIf(VGTipoEjecucion = CGReverso, txtcat1.Text, cat1.ClipText) + "-" + String(4 - Len(Trim$(cat2.ClipText)), "0") + Trim$(cat2.ClipText) + "-" + String(3 - Len(Trim$(cat3.ClipText)), "0") + Trim$(cat3.ClipText) + "-" + String(4 - Len(Trim$(cat4.ClipText)), "0") + Trim$(cat4.ClipText) + "-" + String(4 - Len(Trim$(cat5.ClipText)), "0") + Trim$(cat5.ClipText) + "-" + String(4 - Len(Trim$(cat6.ClipText)), "0") + Trim$(cat6.ClipText)
                    PMSetDetalle "v" + "COD CATASTRAL      : " + cat1.ClipText + "-" + String(4 - Len(Trim$(cat2.ClipText)), "0") + Trim$(cat2.ClipText) + "-" + String(3 - Len(Trim$(cat3.ClipText)), "0") + Trim$(cat3.ClipText) + "-" + String(4 - Len(Trim$(cat4.ClipText)), "0") + Trim$(cat4.ClipText) + "-" + String(4 - Len(Trim$(cat5.ClipText)), "0") + Trim$(cat5.ClipText) + "-" + String(4 - Len(Trim$(cat6.ClipText)), "0") + Trim$(cat6.ClipText)
                    PMSetDetalle "v" + "PERIODO TRIBUTARIO : " + Agno.Caption
                    'PMSetDetalle "v" + "AUTORIZACION       : " + VLNumAutorizacion
                    PMSetDetalle "v" + "AUTORIZACION       : " + CStr(Format(VGSecBanredMG, "0000000000"))                'lfcm 13-febrero-2009
                    PMSetDetalle "v" + "COMP. INGRESO CAJA : " + CStr(Format(VLCodigoCUIC, "0000000000"))                'GAMC 21ENE2010
                    PMSetDetalle "v" + " "
                    PMSetDetalle "v" + "TOTAL A PAGAR      : " + FMEspaciosATX("us$" + Format(ValorMun, VGFormatoMoney), 13, CGJustificacionDerecha)
                    PMSetDetalle "v" + " "
                    PMSetDetalle "v" + "FORMAS DE PAGO:"
                    PMSetDetalle "v" + " "
                    PMSetDetalle "v" + "-------------------------------------------------"
                    If val(efe.Text) > 0 Then
                        PMSetDetalle "v" + "EFECTIVO: " + FMEspaciosATX("us$" + Format(efe, VGFormatoMoney), 13, CGJustificacionDerecha)
                    End If
                    If val(Cheques.Text) > 0 Then
                        PMSetDetalle "v" + "CHEQUE(" + Trim$(CantChq.Text) + "): " + FMEspaciosATX("us$" + Format(Cheques, VGFormatoMoney), 13, CGJustificacionDerecha)
                    End If
                    If val(Debito.Text) > 0 Then
                        PMSetDetalle "v" + "DEBITO : " + FMEspaciosATX("us$" + Format(Debito, VGFormatoMoney), 13, CGJustificacionDerecha) + " CUENTA : " + Format(Cta.ClipText, "000-000000-0")
                    End If
                    If val(Tarjeta.Text) > 0 Then
                        PMSetDetalle "v" + "TARJETA CREDITO : " + FMEspaciosATX("us$" + Format(Tarjeta, VGFormatoMoney), 13, CGJustificacionDerecha)
                    End If
                    '***ref02 vmirandt inicio, se imprime al final del documento
                    If VLclave_acceso <> "" Then
                        PMSetDetalle "v" + "-------------------------------------------------"
                        PMSetDetalle "v" + "Clave de Acceso/Autorizacion: "
                        PMSetDetalle "v" + VLclave_acceso
                    End If
                    'ref02 vmirandt
                    PMSetDetalle "v" + "-------------------------------------------------"
                    PMSetDetalle "v" + " "
                    PMSetDetalle "v" + "AVISO: ESTIMADO CLIENTE  EN 48 HORAS LABORABLES, USTED"
                    PMSetDetalle "v" + "PODRA   DESCARGAR   EL  RECIBO  ELECTRONICO  DE   PAGO"
                    PMSetDetalle "v" + "EN  LA PAGINA   WEB   DEL   MUNICIPIO   DE   GUAYAQUIL"
                    PMSetDetalle "v" + "(www.guayaquil.gob.ec) EN LA RUTA SERVICIOS EN LINEA"
                   
                    PMSetDetalle "v" + ""
                    
                    VLHorarioDifTemporal = VGHorarioDif
            
                    
                    If VGHorarioDif Then
                    VLTrn = "3216"
                Else
                    VLTrn = "3215"
                End If
                
                    FMPRN_StdImpresion "IMPRESORA_1", False, Trim$(str$(VLTsnTemporal)), "19", SGDatosDetalle, "Inserte papeleta", CStr(VGpartop$), 1, CStr(VGparleft$), , , VLHorario, , , "1", VLTrn
                    
                    VGHorarioDif = VLHorarioDifTemporal
                
                If VGTipoEjecucion = CGNormal% Then
                    While MsgBox("Desea Reimprimir la papeleta para certificacion?", vbYesNo, "Mensaje") = vbYes
                        PMReimpresion
                    Wend
                End If
    
         End If
         
         If Trim(Me.Tipo.Text) = "004" Then
                VGparlong$ = "90"
                VGpartop$ = "10"
                VGparleft$ = "10"
                VGparrig$ = "00"
                
                PMSetDetalle "v" + "Este pago sera procesado el " + VLFechaEfe
                PMSetDetalle "v" + " "
                PMSetDetalle "v" + "Empresa: " + Trim$(municipio.Text) + " " + Trim$(Mid$(sal_municipio.Caption, 1, 36))
                PMSetDetalle "v" + "Tipo de Servicio: " + Trim$(sal_tipo)
                PMSetDetalle "v" + "-------------------------------------------------"
                PMSetDetalle "v" + "Código CEP : " + Trim$(Me.CEP.Text)
                PMSetDetalle "v" + "#CATAST.: " + Trim$(VLCodPredial)
                PMSetDetalle "v" + "CEDULA/RUC         : " + Trim$(VLIdentificacion)
                PMSetDetalle "v" + "CONTRIBU.      : " + Trim$(Left(Contribuyente.Caption, 35))
                PMSetDetalle "v" + "ID COBRO.      : : " + Trim$(VLAutorizacion)
                PMSetDetalle "v" + " "
                PMSetDetalle "v" + "VALOR  A PAGAR                    : " + FMEspaciosATX("us$" + Format(Trim$(ValorMun.Text), VGFormatoMoney), 13, CGJustificacionDerecha)
                PMSetDetalle "v" + " "
                PMSetDetalle "v" + "FORMAS DE PAGO:"
                PMSetDetalle "v" + "-------------------------------------------------"
                If val(efe.Text) > 0 Then
                    PMSetDetalle "v" + "EFECTIVO: " + FMEspaciosATX("us$" + Format(efe, VGFormatoMoney), 13, CGJustificacionDerecha)
                End If
                If val(Cheques.Text) > 0 Then
                    PMSetDetalle "v" + "CHEQUE(" + Trim$(CantChq.Text) + "): " + FMEspaciosATX("us$" + Format(Cheques, VGFormatoMoney), 13, CGJustificacionDerecha)
                End If
                If val(Debito.Text) > 0 Then
                    PMSetDetalle "v" + "DEBITO : " + FMEspaciosATX("us$" + Format(Debito, VGFormatoMoney), 13, CGJustificacionDerecha) + " CUENTA : " + Format(Cta.ClipText, "000-000000-0")
                End If
                If val(Tarjeta.Text) > 0 Then
                    PMSetDetalle "v" + "TARJETA CREDITO : " + FMEspaciosATX("us$" + Format(Tarjeta, VGFormatoMoney), 13, CGJustificacionDerecha)
                End If
                PMSetDetalle "v" + "-------------------------------------------------"
                PMSetDetalle "v" + "TOTAL                    : " + FMEspaciosATX("us$" + Format(Trim$(ValorMun.Text), VGFormatoMoney), 13, CGJustificacionDerecha)
                
                    '***ref02 vmirandt inicio, se imprime al final del documento
                    If VLclave_acceso <> "" Then
                        PMSetDetalle "v" + "-------------------------------------------------"
                        PMSetDetalle "v" + "Clave de Acceso/Autorizacion: "
                        PMSetDetalle "v" + VLclave_acceso
                    End If
                    'ref02 vmirandt
                
                PMSetDetalle "v" + "-------------------------------------------------"
                If Trim(VLObservacion1) <> "" Then
                    PMSetDetalle "v" + "OBSERVACION  1: " + VLObservacion1
                End If
                If Trim(VLObservacion2) <> "" Then
                    PMSetDetalle "v" + "OBSERVACION  2: " + VLObservacion2
                End If
                If Trim(VLObservacion3) <> "" Then
                    PMSetDetalle "v" + "OBSERVACION  3: " + VLObservacion3
                End If
                PMSetDetalle "v" + " "
                
                VLHorarioDifTemporal = VGHorarioDif
                If VLHorario = "N" Then
                    VGHorarioDif = False
                    VLTrn = "3215"
                Else
                    VGHorarioDif = True
                    VLTrn = "3216"
                End If
                        
                FMPRN_StdImpresion "IMPRESORA_1", False, Trim$(str$(VLTsnTemporal)), "19", SGDatosDetalle, "Inserte papeleta", CStr(VGpartop$), 1, CStr(VGparleft$), , , , , , "1", VLTrn
                VGHorarioDif = VLHorarioDifTemporal
        
                If VGTipoEjecucion = CGNormal% Then
                    While MsgBox("Desea Reimprimir la papeleta para certificacion?", vbYesNo, "Mensaje") = vbYes
                        PMReimpresion
                    Wend
                End If
                'smerino Munic Cep - COMPROBANTE DE PAGO - FIN
        End If 'Trim(Me.Tipo.Text) = "004"
        
    End Select
    
    '-->hy-15-feb-2006

    'GAMC - 02AGO10 - Se agregó método para impreisón de comprobante de comisión
    If VLTotCom > 0 And VGTipoEjecucion = CGNormal% Then
        If VLImprCompComi = "N" Then
            PLImprimeComprobante "O"
            While MsgBox("Desea Reimprimir el Comprobante de Comisión?", vbYesNo, "Mensaje") = vbYes
                PLImprimeComprobante "C"
            Wend
'        Else
'            MsgBox "Cliente tiene facturación electrónica imprimir comprobante por 24Online", vbInformation, "Sistema"
        End If
    End If
    VLEfe_com = 0
    VLTotCom = 0
    
    
    If municipio = "1430" Then
         Me.Tarjeta.Enabled = True    '--lfcm 01-julio-2009 MiLote
      Me.txtCatasSamb.Text = "" 'GAMC - 25/02/2008
      txtPapeletaSamb.Text = "" 'GAMC - 25/02/2008
      Me.VLOficinaRetiro = "" 'GAMC - 27/03/2008
      Me.claveCatastral.Mask = "  -  -  -  -   " 'GAMC - 05/03/2008
      VLMoneda = VGmoneda%
      VLDescMonCta = ""
      lblMoneda.Caption = ""
      
      VLfirma = False
      VLTipoOK = False
      activa = True
      Tipo.Text = ""
      municipio.Text = ""
        
      cedula.Clear
      '-->hy-30-ene-2006
      cat1.Clear
      cat2.Clear
      cat3.Clear
      cat4.Clear
      cat5.Clear
      cat6.Clear
      Comision.Text = "0.00"
      VLTotCom = 0
      VLEfe_com = 0
      VLChq_com = 0
        VLDeb_com = 0
        VLNombre_com = "" 'ame 07/20/2010
        '<--hy-30-ene-2006
        efe.Text = "0.00"
        CantChq.Text = "0"
        Cheques.Text = "0.00"
        sal_tipo.Caption = ""
        sal_municipio.Caption = ""
        direccion.Text = ""
        DescripImpto.Text = ""
        Cau.Text = ""
        Frame1.Caption = ""
        Contribuyente.Caption = ""
        Predio.Caption = ""
        Impto.Caption = ""
        Agno.Caption = ""
        Semestre.Caption = ""
        Debito.Enabled = False
        CboTipCta.ListIndex = 0
        VGSecBanredMG = 0
        Debito.Text = "0.00"
        Tarjeta.Text = "0.00"   'hy-14-agosto-2006
        txtLlaveMunicipal.Text = "" 'hy-22-febrero-2007
        ValorMun.Text = "0.00"
        Total.Text = "0.00"
        Total.Text = CDbl(ValorMun.Text) + CDbl(Comision) 'hy-30-ene-2006
        Cta.Text = ""
        Nombre.Text = ""
        Cheques.Enabled = True
        VLCta = ""
        Frame1.Enabled = False
        Frame2.Enabled = True
        PMLimpiarTransaccion "19"
        VGAutoriza = "N"
        Prioridad.Text = "" 'referencia Municipio 1430 nchavezb
        
    End If
    
    
    
    
    
    
'GAMC - 02AGO10 - Comentado se agrego método para impreisón de comprobante de comisión
'    If VLTotCom > 0 And VGTipoEjecucion = CGNormal% Then
'        PMInicioImpresion "IMPRESORA_1"
'        PMBorrarDatosImpresion
'
'        VGparlong$ = "66"
'        VGpartop$ = "00"
'        VGparleft$ = "30"
'        VGparrig$ = "00"
'
'        PMSetLineaImpresion "x" + "Inserte COMPROBANTE Cobro Comision"
'        PMSetLineaImpresion "<"
'
'        VLTotal = Format(FMCCurATX((efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((Debito.Text)) + FMCCurATX((Tarjeta.Text)) + FMCCurATX((Comision.Text)), "###,###,###,##0.00")
'
'        '-->hy-05-noviembre-2007
'        VLHorarioDifTemporal = VGHorarioDif
'        If VLHorario = "N" Then
'            VGHorarioDif = False
'        Else
'            VGHorarioDif = True
'        End If
'        '<--hy-05-noviembre-2007
'
'        PMSetLineaImpresion "!" & VGpartop$
'        PMSetLineaImpresion "%N" & VGparleft$
'        PMSetLineaImpresion "v" + "NOTA DE VENTA               ORIGINAL"
'        PMSetLineaImpresion "v" + "BCO.BOLIVARIANO " + "RUC.: " + " 0990379017001"
'        PMSetLineaImpresion "v" + "CONTRIBUYENTE ESPECIAL"
'        PMSetLineaImpresion "v" + "NOTIFICACION No. 39 de Julio 18 de 1995"
'        PMSetLineaImpresion "v" + "RESOLUCION No. 6925 de Julio 4 de 1995"
'        PMSetLineaImpresion "v" + "Autoriz.:" + Trim$(VLautoriSri) + " Doc.: " + Trim$(VLSerie_Secuencia)   'hy-22-febrero-2007 agregar trim$
'        PMSetLineaImpresion "v" + "Valido Hasta :" + Trim$(VLFecvenSRI)    'hy-22-febrero-2007 agregar trim$
'        PMSetLineaImpresion "v" + "Oficina : " + VGDes_Oficina$ + " " + "Dir.Matriz : " + "Junin 200 y Panama "
'        'PMSetLineaImpresion "v" + "Oficina : " + VGDes_Oficina$ + " " + IIf(VGHorarioDif, "H:D", "H:N") + " " + IIf(VGTipoEjecucion = CGReverso, "REVERSO", "")
'        PMSetLineaImpresion "v" + "Caj: " + VGLogin$ + " " + "Fecha: " + Format(VGFechaProceso, VGFormatoFecha$) + " " + Format(Now, VGFormatoHora$) + " " + IIf(VGHorarioDif, "H:D", "H:N") + " " + IIf(VGTipoEjecucion = CGReverso, "REVERSO", "") 'ame 07/20/2010
'        PMSetLineaImpresion "v" + "Nombre : " + VLNombre_com 'ame 07/20/2010
'        PMSetLineaImpresion "v" + "C.I/RUC: " + (SGCedula)  'ame 07/201/2010
'        PMSetLineaImpresion "v" + "Servicio Recaudacion municipal: " + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 8, CGJustificacionDerecha)
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
'        If FMCCurATX((VLDeb_com)) > 0 Then
'           PMSetLineaImpresion "v" + (VLTipCta_com) + " CTA: " + Format(VLCta_com, "000-000000-0") + " DEB.: " + FMEspaciosATX(Format(VLDeb_com, VGFormatoMoney), 10, CGJustificacionDerecha)
'        End If
'        PMSetLineaImpresion "v" + "PAGO TOTAL: " + FMEspaciosATX(FMObtenerSimbolo("15") + Format(FMCCurATX(VLTotCom), VGFormatoMoney), 12, CGJustificacionDerecha)  ' ame 07/20/2010
'        PMSetLineaImpresion "v" + " "
'
'        If VGModeloImp$ = "590" Then
'            PMSetLineaImpresion "%R" & 8
'        End If
'
'        PMSetLineaImpresion ">"
'        PMImprimir "IMPRESORA_1", False
'        PMFinImpresion "IMPRESORA_1"
'        VGHorarioDif = VLHorarioDifTemporal  'hy-05-noviembre-2007
'    End If
    '<--hy-15-feb-2006
    
        'msilvag Inicio
        If Me.municipio.Text = "7749" And Me.Tipo.Text = "001" Then  'predios
            Me.cat1.Clear
            Me.cat2.Clear
            Me.cat3.Clear
            Me.cat4.Clear
            Me.cat5.Clear
            Me.cat6.Clear
        End If
        
        If Me.municipio.Text = "7749" And Me.Tipo.Text = "002" Then  'Mi Lote
            Me.cedula.Text = ""
        End If
        
        If Me.municipio.Text = "7749" And Me.Tipo.Text = "003" Then  'Mercados
            Me.cedula.Text = ""
        End If
        
        If Me.municipio.Text = "7749" And Me.Tipo.Text = "004" Then  'CEP
            Me.CEP.Text = ""
        End If
        'msilvag Fin
    
        VLfirma = False
        VLTipoOK = False
        activa = True
        efe.Text = "0.00"
        CantChq.Text = "0"
        Cheques.Text = "0.00"
        direccion.Text = ""
        DescripImpto.Text = ""
        Cau.Text = ""
        Frame1.Caption = ""
        VLContribuyente = Trim$(Contribuyente.Caption)
        Contribuyente.Caption = ""
        Predio.Caption = ""
        Impto.Caption = ""
        Agno.Caption = ""
        Semestre.Caption = ""
        Debito.Enabled = False
        Tarjeta.Text = "0.00"    'lfcm 20/octubre/2006
        CboTipCta.ListIndex = 0
        Debito.Text = "0.00"
        ValorMun.Text = "0.00"
        Total.Text = "0.00"
        Cta.Text = ""
        Nombre.Text = ""
        Cheques.Enabled = True
        VLCta = ""
        PMLimpiarTransaccion "19"
        VGAutoriza = "N"
        '------> Sumadora
        SGUsar = 0
        If Shift = 0 And VGTipoConsAutom% = 0 And VGTipoEjecucion% <> CGReverso% Then  'TPEAdiciono Validacion Por Consulta Automatica y Reverso
            SGActual = 1
            FSumIng.Hide
            FSumIng.Form_KeyDown CGTeclaF2%, 0
            'tipo.SetFocus
            Unload FSumIng
        End If
        SGActivaSum = False
        '<------
        If Frame2.Enabled And municipio.Enabled Then
            municipio.SetFocus
        End If
        
        '-->hy-22-febrero-2007
        If VGTipoEjecucion% <> CGReverso% Then
            
                       ' ame 06/15/2010
           If municipio.Text = "1417" Then
              If VLFlagUnicoMunQto Then
                    Call Form_KeyDown(CGTeclaF2%, 0)
              Else
                 Call Form_KeyDown(CGTeclaF5%, 0)
              End If
           End If
            
            '-->lfcm 17-febrero-2009
            If municipio.Text = "1433" Then
               If VLFlagUnicoMunGye Then
                  Call Form_KeyDown(CGTeclaF2%, 0)
               Else
                  'Call Form_KeyDown(CGTeclaF5%, 0)
                  If grdBloque.Rows = 2 Then
                     Call Form_KeyDown(CGTeclaF2%, 0)
                     Exit Sub
                  End If
                  grdBloque.Row = 1
                  grdBloque.RemoveItem (1)
                  Frame2.Enabled = False
                  FCC19_grid2.grdDetalle.Rows = grdBloque.Rows
                  FCC19_grid2.grdDetalle.Cols = grdBloque.Cols
                  For I = 1 To grdBloque.Rows - 1
                     For j = 1 To grdBloque.Cols - 1
                        grdBloque.Row = I
                        grdBloque.Col = j
                        FCC19_grid2.grdDetalle.Row = I
                        FCC19_grid2.grdDetalle.Col = j
                        FCC19_grid2.grdDetalle.Text = grdBloque.Text
                     Next
                  Next
                  FCC19_grid2.grdDetalle.Row = 1
                  FCC19_grid2.grdDetalle.Col = 1
                  FCC19_grid2.Show vbModal
                  If ValorMun > 0 Then
                     Total.Text = CDbl(ValorMun.Text) + CDbl(Comision)  'hy-30-ene-2006
                     Frame1.Enabled = True
                     efe.SetFocus
                  Else
                     If CantChq.Enabled Then
                        CantChq.SetFocus
                     End If
                  End If
                  If grdBloque.Rows = 2 Then
                     VLFlagUnicoMunGye = True
                  Else
                     VLFlagUnicoMunGye = False
                  End If
                  Contribuyente.Caption = VLContribuyente
               End If
               
               
               Exit Sub
            End If
            '--<lfcm 17-febrero-2009
            'nchavezb 03/01/2011
             If municipio.Text = "1435" Then
               If VLFlagUnicoMunMyC Then
                  VLContribuyente = ""
                  Call Form_KeyDown(CGTeclaF2%, 0)
               Else
                  VLTotCom = 0
                  VLEfe_com = 0
                  VLChq_com = 0
                  VLNombre_com = ""
                  Call Form_KeyDown(CGTeclaF5%, 0)
'                  'Call Form_KeyDown(CGTeclaF5%, 0)
'                  If grdBloque.Rows = 2 Then
'                     Call Form_KeyDown(CGTeclaF2%, 0)
'                     Exit Sub
'                  End If
'                  grdBloque.Row = 1
'                  grdBloque.RemoveItem (1)
'                  Frame2.Enabled = False
'                  FCC19_gridMiLote.grdDetalleML.Rows = grdBloque.Rows
'                  FCC19_gridMiLote.grdDetalleML.Cols = grdBloque.Cols
'                  FCC19_gridMiLote.grdDetalleML.Row = 0
'                  FCC19_gridMiLote.grdDetalleML.Col = 0
'                  FCC19_gridMiLote.grdDetalleML.ColWidth(0) = 450
'                  FCC19_gridMiLote.grdDetalleML.Col = 1
'                  FCC19_gridMiLote.grdDetalleML.ColWidth(1) = 1000
'                  FCC19_gridMiLote.grdDetalleML.ColAlignment(1) = 4
'                  FCC19_gridMiLote.grdDetalleML.Text = "No. Cuota"
'                  FCC19_gridMiLote.grdDetalleML.Col = 2
'                  FCC19_gridMiLote.grdDetalleML.ColWidth(2) = 2300
'                  FCC19_gridMiLote.grdDetalleML.ColAlignment(2) = 4
'                  FCC19_gridMiLote.grdDetalleML.Text = "F. Vigencia"
'                  FCC19_gridMiLote.grdDetalleML.Col = 3
'                  FCC19_gridMiLote.grdDetalleML.ColWidth(3) = 1200
'                  FCC19_gridMiLote.grdDetalleML.ColAlignment(3) = 4
'                  FCC19_gridMiLote.grdDetalleML.Text = "Valor"
'                  FCC19_gridMiLote.grdDetalleML.Col = 3
'                  For I = 1 To grdBloque.Rows - 1
'                     For j = 1 To grdBloque.Cols - 1
'                        grdBloque.Row = I
'                        grdBloque.Col = j
'                        FCC19_gridMiLote.grdDetalleML.Row = I
'                        FCC19_gridMiLote.grdDetalleML.Col = j
'                        FCC19_gridMiLote.grdDetalleML.Text = grdBloque.Text
'                     Next
'                  Next
'                  FCC19_gridMiLote.grdDetalleML.Row = 1
'                  FCC19_gridMiLote.grdDetalleML.Col = 1
'                  FCC19_gridMiLote.Show vbModal
'                  If ValorMun > 0 Then
'                     Total.Text = CDbl(ValorMun.Text) + CDbl(Comision)  'hy-30-ene-2006
'                     Frame1.Enabled = True
'                     Efe.SetFocus
'                  Else
'                     If CantChq.Enabled Then
'                        CantChq.SetFocus
'                     End If
'                  End If
'                  If grdBloque.Rows = 2 Then
'                     VLFlagUnicoMiLote = True
'                  Else
'                     VLFlagUnicoMiLote = False
'                  End If
               End If
               Contribuyente.Caption = VLContribuyente
               Exit Sub
            End If
            '--<lfcm 02-julio-2009 MiLote
            '-->lfcm 02-julio-2009 MiLote
            If municipio.Text = "1434" Then
               If VLFlagUnicoMiLote Then
                  Call Form_KeyDown(CGTeclaF2%, 0)
               Else
                  VLTotCom = 0
                  VLEfe_com = 0
                  VLChq_com = 0
                  VLNombre_com = ""
                  Call Form_KeyDown(CGTeclaF5%, 0)
'                  'Call Form_KeyDown(CGTeclaF5%, 0)
'                  If grdBloque.Rows = 2 Then
'                     Call Form_KeyDown(CGTeclaF2%, 0)
'                     Exit Sub
'                  End If
'                  grdBloque.Row = 1
'                  grdBloque.RemoveItem (1)
'                  Frame2.Enabled = False
'                  FCC19_gridMiLote.grdDetalleML.Rows = grdBloque.Rows
'                  FCC19_gridMiLote.grdDetalleML.Cols = grdBloque.Cols
'                  FCC19_gridMiLote.grdDetalleML.Row = 0
'                  FCC19_gridMiLote.grdDetalleML.Col = 0
'                  FCC19_gridMiLote.grdDetalleML.ColWidth(0) = 450
'                  FCC19_gridMiLote.grdDetalleML.Col = 1
'                  FCC19_gridMiLote.grdDetalleML.ColWidth(1) = 1000
'                  FCC19_gridMiLote.grdDetalleML.ColAlignment(1) = 4
'                  FCC19_gridMiLote.grdDetalleML.Text = "No. Cuota"
'                  FCC19_gridMiLote.grdDetalleML.Col = 2
'                  FCC19_gridMiLote.grdDetalleML.ColWidth(2) = 2300
'                  FCC19_gridMiLote.grdDetalleML.ColAlignment(2) = 4
'                  FCC19_gridMiLote.grdDetalleML.Text = "F. Vigencia"
'                  FCC19_gridMiLote.grdDetalleML.Col = 3
'                  FCC19_gridMiLote.grdDetalleML.ColWidth(3) = 1200
'                  FCC19_gridMiLote.grdDetalleML.ColAlignment(3) = 4
'                  FCC19_gridMiLote.grdDetalleML.Text = "Valor"
'                  FCC19_gridMiLote.grdDetalleML.Col = 3
'                  For I = 1 To grdBloque.Rows - 1
'                     For j = 1 To grdBloque.Cols - 1
'                        grdBloque.Row = I
'                        grdBloque.Col = j
'                        FCC19_gridMiLote.grdDetalleML.Row = I
'                        FCC19_gridMiLote.grdDetalleML.Col = j
'                        FCC19_gridMiLote.grdDetalleML.Text = grdBloque.Text
'                     Next
'                  Next
'                  FCC19_gridMiLote.grdDetalleML.Row = 1
'                  FCC19_gridMiLote.grdDetalleML.Col = 1
'                  FCC19_gridMiLote.Show vbModal
'                  If ValorMun > 0 Then
'                     Total.Text = CDbl(ValorMun.Text) + CDbl(Comision)  'hy-30-ene-2006
'                     Frame1.Enabled = True
'                     Efe.SetFocus
'                  Else
'                     If CantChq.Enabled Then
'                        CantChq.SetFocus
'                     End If
'                  End If
'                  If grdBloque.Rows = 2 Then
'                     VLFlagUnicoMiLote = True
'                  Else
'                     VLFlagUnicoMiLote = False
'                  End If
               End If
               Contribuyente.Caption = VLContribuyente
               Exit Sub
            End If
            '--<lfcm 02-julio-2009 MiLote
            
            '-->hy-05-noviembre-2007
            If municipio.Text = "2234" Then
                
                If grdDetalle.Rows = 2 Then
                    Call Form_KeyDown(CGTeclaF2%, 0)
                    Exit Sub
                End If
                
                'grdDetalle.Row = 1
                grdDetalle.RemoveItem (VLRemoverFila)
                Frame2.Enabled = False
                FCC19_grid2.grdDetalle.Rows = grdDetalle.Rows
                FCC19_grid2.grdDetalle.Cols = grdDetalle.Cols
                VLFlagUnico = True
                For I = 1 To grdDetalle.Rows - 1
                    VLFlagUnico = False
                     For j = 1 To grdDetalle.Cols - 1
                         grdDetalle.Row = I
                         grdDetalle.Col = j
                         FCC19_grid2.grdDetalle.Row = I
                         FCC19_grid2.grdDetalle.Col = j
                         FCC19_grid2.grdDetalle.Text = grdDetalle.Text
                     Next
                Next
                FCC19_grid2.grdDetalle.Row = 1
                FCC19_grid2.grdDetalle.Col = 1
                FCC19_grid2.Show vbModal
                If ValorMun > 0 Then
                    Total.Text = CDbl(ValorMun.Text) + CDbl(Comision)  'hy-30-ene-2006
                    Frame1.Enabled = True
                    efe.SetFocus
                Else
                    If CantChq.Enabled Then
                        CantChq.SetFocus
                    End If
                End If
            End If
            '<--hy-05-noviembre-2007
            
         
            
            If municipio.Text = "1800" Then
                If VLFlagUnicoMunCuenca Then
                    Call Form_KeyDown(CGTeclaF2%, 0)
                Else
                    Call Form_KeyDown(CGTeclaF5%, 0)
            End If
                    
       'comenta ame 07/09/2010
    
'    If grdBloque.Rows = 2 Then
'        Call Form_KeyDown(CGTeclaF2%, 0)
'        Exit Sub
'    End If
'
'
'    grdBloque.Row = 1
'    grdBloque.RemoveItem (1)
'
'
'
'
'
'            Frame2.Enabled = False
'            FCC19_grid2.GrdDetalle.Rows = grdBloque.Rows
'            FCC19_grid2.GrdDetalle.Cols = grdBloque.Cols
'            For I = 1 To grdBloque.Rows - 1
'                 For j = 1 To grdBloque.Cols - 1
'                     grdBloque.Row = I
'                     grdBloque.Col = j
'                     FCC19_grid2.GrdDetalle.Row = I
'                     FCC19_grid2.GrdDetalle.Col = j
'                     FCC19_grid2.GrdDetalle.Text = grdBloque.Text
'                 Next
'            Next
'            FCC19_grid2.GrdDetalle.Row = 1
'            FCC19_grid2.GrdDetalle.Col = 1
'            FCC19_grid2.Show vbModal
'            If ValorMun > 0 Then
'                Total.Text = CDbl(ValorMun.Text) + CDbl(Comision)  'hy-30-ene-2006
'                Frame1.Enabled = True
'                Efe.SetFocus
'            Else
'                If CantChq.Enabled Then
'                    CantChq.SetFocus
'                End If
'            End If
'
'            If grdBloque.Rows = 2 Then
'                VLFlagUnicoMunCuenca = True
'            Else
'                VLFlagUnicoMunCuenca = False
'            End If
                    
                    
                    
                    
                    
                    
                    
                    
                End If
            Else
                If municipio.Text = "2234" Then
                    If VLFlagUnico Then  'hy-11-enero-2006
                        Call Form_KeyDown(CGTeclaF2%, 0)
                    End If
                ElseIf municipio.Text = "2319" Then 'GAMC - 11/03/2008 - INI
                    If grdDetalle.Rows = 2 Then
                        Call Form_KeyDown(CGTeclaF2%, 0)
                        Exit Sub
                    Else
                        Call Form_KeyDown(CGTeclaF5%, 0)
                    End If
                    'GAMC - 11/03/2008 - FIN
                'ElseIf municipio.Text = "2237" Or municipio.Text = "2235" Then 'GAMC - 17/03/2008 - INI
                    'GAMC - 14/04/2008 - Santa Elena
                    'nchavezb 08/Agosto Municipio Daule 1430 'lcepeda
                ElseIf municipio.Text = "2237" Or municipio.Text = "2235" Or municipio.Text = "2236" Or municipio.Text = "1430" Then 'Wise - 15/Agt/2008
                    'Wise - 14/04/2008 - M. Libertad=2236
                    If grdDetalle.Rows = 2 Then
                        Call Form_KeyDown(CGTeclaF2%, 0)
                        Exit Sub
                    Else
                        Call Form_KeyDown(CGTeclaF5%, 0)
                    End If
                    'GAMC - 11/03/2008 - FIN
                Else
                    If VLFlagUnico Then  'hy-11-enero-2006
                        Call Form_KeyDown(CGTeclaF2%, 0)
                    Else
                        If municipio.Text = "1417" Then
                            Call Form_KeyDown(CGTeclaF5%, 0)
                        Else
                            Call PLMuestraGrid
                            Contribuyente.Caption = VLContribuyente
                        End If
                    End If
                End If
            End If
        'End If 'comenta ame 07/09/2010
        '<--hy-22-febrero-2007
    
    'If SGAcumulado = 0 Then
    '    Form_KeyDown CGTeclaF2%, 0
    'Else
    '    Form_KeyDown CGTeclaF2%, -1
    'End If
End Sub
 
Public Sub PLImprimeComprobante(original As String)
    'PMInicioImpresion "IMPRESORA_1"
    'PMBorrarDatosImpresion

'    VGparlong$ = "66"
'    VGpartop$ = "00"
'    VGparleft$ = "30"
'    VGparrig$ = "00"
'
'    PMSetLineaImpresion "x" + "Inserte COMPROBANTE Cobro Comision"
'    PMSetLineaImpresion "<"
'
'    VLTotal = Format(FMCCurATX((efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((Debito.Text)) + FMCCurATX((Tarjeta.Text)) + FMCCurATX((Comision.Text)), "###,###,###,##0.00")
'
'    VLHorarioDifTemporal = VGHorarioDif
'    If VLHorario = "N" Then
'        VGHorarioDif = False
'    Else
'        VGHorarioDif = True
'    End If
'
'    PMSetLineaImpresion "!" & VGpartop$
'    PMSetLineaImpresion "%N" & VGparleft$
'    PMSetLineaImpresion "v" + "BANCO BOLIVARIANO S.A.   FACTURA"
'    PMSetLineaImpresion "v" + "RUC: 0990379017001       No. " + Trim$(VLSerie_Secuencia)
'    PMSetLineaImpresion "v" + "Junin 200 y Panama       No. Autoriz.: " + Trim$(VLautoriSri)
'    PMSetLineaImpresion "v" + "CONTRIBUYENTE ESPECIAL   Validez: " + Trim$(VLFecvenSRI)
'    PMSetLineaImpresion "v" + "NOTIFICACION No. 39 de Julio 18 de 1995"
'    PMSetLineaImpresion "v" + "RESOLUCION No. 6925 de Julio 4 de 1995"
'    PMSetLineaImpresion "v" + "Sr.(es): " + SGNombre
'    PMSetLineaImpresion "v" + "CI/RUC:  " + FMEspaciosATX(SGCedula, 15, CGJustificacionIzquierda) + "Oficina : " + FMEspaciosATX(VGDes_Oficina$, 10, CGJustificacionIzquierda)
'    PMSetLineaImpresion "v" + "Costo Servicio Recaudacion    Fecha: " + Format(VGFechaProceso, VGFormatoFecha$)
'    PMSetLineaImpresion "v" + "Municipios:                " + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 8, CGJustificacionDerecha)
'    PMSetLineaImpresion "v" + "Subtotal: " + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 8, CGJustificacionDerecha) + " Iva 12%:    0.00"
'
'
'    If Predio.Caption <> "" Then '1800 - 1417 - 2234
'        VLCodigo = Predio.Caption
'    ElseIf claveCatastral.ClipText <> "" Then '2237 - 2235
'        VLCodigo = claveCatastral.ClipText
'    ElseIf txtCatasSamb.Text <> "" Then '2319 - 2236
'        VLCodigo = txtCatasSamb.Text
'    ElseIf Cedula.ClipText <> "" And (municipio.Text = 1434 Or municipio.Text = 1800 Or municipio.Text = 1417) Then    '1434
'        VLCodigo = Cedula.ClipText & " - " & CStr(VLMLNoCuota)
'    ElseIf Cedula.ClipText <> "" And (municipio.Text = 1435) Then
'        VLCodigo = Cedula.ClipText & " - " & Trim$(Me.Agno.Caption)
'    ElseIf txtLlaveMunicipal.Text <> "" Then
'        VLCodigo = txtLlaveMunicipal.Text & " - " & CStr(VLMLNoCuota)
'    Else    '1433
'        VLCodigo = cat1.ClipText & cat2.ClipText & cat3.ClipText & cat4.ClipText & cat5.ClipText & cat6.ClipText
'    End If
'
'    PMSetLineaImpresion "v" + "VALOR TOTAL: " + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 5, CGJustificacionDerecha) + " Referencia: " + Mid(VLCodigo, 1, 18)
'
'    If original = "O" Then
'        PMSetLineaImpresion "v" + "Caj: " + VGLogin$ + "      Original: Adquiriente"
'    Else
'        PMSetLineaImpresion "v" + "Caj: " + VGLogin$ + "      Copia: Emisor"
'    End If
'
'    If VGModeloImp$ = "590" Then
'        PMSetLineaImpresion "%R" & 3
'    End If
'
'    PMSetLineaImpresion ">"
'    PMImprimir "IMPRESORA_1", False
'    PMFinImpresion "IMPRESORA_1"
'    VGHorarioDif = VLHorarioDifTemporal  'hy-05-noviembre-2007

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
        
        
       
  VLTotal = Format(FMCCurATX((efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((Debito.Text)) + FMCCurATX((Tarjeta.Text)) + FMCCurATX((Comision.Text)), "###,###,###,##0.00")

    VLHorarioDifTemporal = VGHorarioDif
    If VLHorario = "N" Then
        VGHorarioDif = False
    Else
        VGHorarioDif = True
    End If

  
    PMSetDetalle "v" + "BANCO BOLIVARIANO C.A.   FACTURA"
    PMSetDetalle "v" + "RUC: 0990379017001       No. " + Trim$(VLSerie_Secuencia)
    PMSetDetalle "v" + "Junin 200 y Panama       Aut. SRI : " + Trim$(VLautoriSri)
    PMSetDetalle "v" + "CONTRIBUYENTE ESPECIAL   Fecha aut: " + Trim$(VLFecinivig)
    PMSetDetalle "v" + "NOTIFICACION No. 39 de Julio 18 de 1995 " + "Valido hasta :" + VLFecfinvig
    PMSetDetalle "v" + "RESOLUCION No. 6925 de Julio 4 de 1995"
    PMSetDetalle "v" + "Sr.(es): " + SGNombre
    PMSetDetalle "v" + "CI/RUC:  " + FMEspaciosATX(SGCedula, 15, CGJustificacionIzquierda) + "Oficina : " + FMEspaciosATX(VGDes_Oficina$, 10, CGJustificacionIzquierda)
    PMSetDetalle "v" + "Costo Servicio Recaudacion    Fecha: " + VGFechaProceso2
    'PMSetDetalle "v" + "Costo Servicio Recaudacion    Fecha: " + Format(VGFechaProceso, VGFormatoFecha$)
    PMSetDetalle "v" + "Municipios:                " + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 8, CGJustificacionDerecha)
    PMSetDetalle "v" + "Subtotal: " + FMEspaciosATX(Format(VlbaseImp, VGFormatoMoney), 8, CGJustificacionDerecha) + " Iva 12%:" + FMEspaciosATX(Format(VLiva, VGFormatoMoney), 8, CGJustificacionDerecha) 'smerino iva
    
    
    If Predio.Caption <> "" Then '1800 - 1417 - 2234
        VLCodigo = Predio.Caption
    ElseIf claveCatastral.ClipText <> "" Then '2237 - 2235
        VLCodigo = claveCatastral.ClipText
    ElseIf txtCatasSamb.Text <> "" Then '2319 - 2236
        VLCodigo = txtCatasSamb.Text
    ElseIf cedula.ClipText <> "" And (municipio.Text = 1434 Or municipio.Text = 1800 Or municipio.Text = 1417) Then    '1434
        VLCodigo = cedula.ClipText & " - " & CStr(VLMLNoCuota)
    ElseIf cedula.ClipText <> "" And (municipio.Text = 1435) Then
        VLCodigo = cedula.ClipText & " - " & Trim$(Me.Agno.Caption)
    ElseIf txtLlaveMunicipal.Text <> "" Then
        VLCodigo = txtLlaveMunicipal.Text & " - " & CStr(VLMLNoCuota)
    Else    '1433
        VLCodigo = cat1.ClipText & cat2.ClipText & cat3.ClipText & cat4.ClipText & cat5.ClipText & cat6.ClipText
    End If
        
         
    ''PMSetDetalle "v" + "VALOR TOTAL: " + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 5, CGJustificacionDerecha) + " Referencia: " + Mid(VLCodigo, 1, 18)
    'DAPV -INICIO
    If municipio.Text = 1430 Then  'DAPV   24/08/2011 ''Para que salga la referencia junto al codigo de predio
        PMSetDetalle "v" + "VALOR TOTAL: " + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 5, CGJustificacionDerecha) + " Referencia: " + Trim(Mid(VLCodigo, 1, 18)) + "-" + Trim(Prioridad.Text)
    Else
        PMSetDetalle "v" + "VALOR TOTAL: " + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 5, CGJustificacionDerecha) + " Referencia: " + Mid(VLCodigo, 1, 18)
    End If
    'DAPV - FIN

    
    If original = "O" Then
        PMSetDetalle "v" + "Caj: " + VGLogin$ + "      Original: Adquiriente"
    Else
        PMSetDetalle "v" + "Caj: " + VGLogin$ + "      Copia: Emisor"
    End If
    
    If VGModeloImp$ = "590" Then
        PMSetDetalle "%R" & 2
    End If
   VGHorarioDif = VLHorarioDifTemporal  'hy-05-noviembre-2007
FMPRN_StdImpresion "IMPRESORA_1", False, "", "19", SGDatosDetalle, "Inserte COMPROBANTE Cobro Comision", CStr(VGpartop$), 1, CStr(VGparleft$), , , , , False, , VLTrn
End Sub

Sub PLMuestraGrid()
    VLTopeMax = VLTopeMax - 1
    If VLTopeMax < 0 Then
        Call Form_KeyDown(CGTeclaF2%, 0)
        Exit Sub
    End If
    
    grdBloque.Row = 1
    grdBloque.RemoveItem (1)
    
    
    
    
    
            Frame2.Enabled = False
            FCC19_grid2.grdDetalle.Rows = grdBloque.Rows
            FCC19_grid2.grdDetalle.Cols = grdBloque.Cols
            For I = 1 To grdBloque.Rows - 1
                 For j = 1 To grdBloque.Cols - 1
                     grdBloque.Row = I
                     grdBloque.Col = j
                     FCC19_grid2.grdDetalle.Row = I
                     FCC19_grid2.grdDetalle.Col = j
                     FCC19_grid2.grdDetalle.Text = grdBloque.Text
                 Next
            Next
            FCC19_grid2.grdDetalle.Row = 1
            FCC19_grid2.grdDetalle.Col = 1
            FCC19_grid2.Show vbModal
            If ValorMun > 0 Then
                Total.Text = CDbl(ValorMun.Text) + CDbl(Comision)  'hy-30-ene-2006
                Frame1.Enabled = True
                efe.SetFocus
            Else
                If CantChq.Enabled Then
                    CantChq.SetFocus
                End If
            End If
            
            If VLTopeMax <= 1 Then
                VLFlagUnico = True
            Else
                VLFlagUnico = False
            End If
    
    
    
    
    
    Exit Sub
    
    
    FCC19_grid2.grdDetalle.Row = 1
    FCC19_grid2.grdDetalle.RemoveItem (FCC19_grid2.grdDetalle.Row)
            
    FCC19_grid2.Show vbModal
    If ValorMun > 0 Then
        Total.Text = CDbl(ValorMun.Text) + CDbl(Comision)  'hy-30-ene-2006
        Frame1.Enabled = True
        efe.SetFocus
    Else
        If CantChq.Enabled Then
            CantChq.SetFocus
        End If
    End If
    
    If VLTopeMax <= 1 Then
        VLFlagUnico = True
    Else
        VLFlagUnico = False
    End If

End Sub

Function FLTransmitir() As Integer
Dim VTIndicadorSum As Integer
    VTIndicadorSum = 0
    
    '-->lfcm 13-febrero-2009
    '-->hy-15-feb-2006
    'If municipio.Text = "1433" Then
    '    If VGTipoEjecucion% = CGReverso% Then
    '        If Not VLFlagRevSP Then
    '            If Not FLTramaSwitch("R") Then
    '                FLTransmitir = False
    '                Exit Function
    '            End If
    '        End If
    '    End If
    'End If
    '<--hy-15-feb-2006
    '--<lfcm 13-febrero-2009

    '-->lfcm 13-febrero-2009
    If municipio.Text = "1433" Then
       FLTransmitir = True
       Exit Function
    End If
    '-->lfcm 13-febrero-2009
    
    
'    '-->hy-15-feb-2006
'    If municipio.Text = "1417" Then
'        If VGTipoEjecucion% = CGReverso% Then
'            If Not VLFlagRevSP Then
'                If Not FLTramaSwitch_MQ("R") Then
'                    FLTransmitir = False
'                    Exit Function
'                End If
'            End If
'        End If
'    End If
'    '<--hy-15-feb-2006
    
    If municipio.Text = "1417" Then
       FLTransmitir = True
       Exit Function
    End If
    
    '-->hy-15-feb-2006
    If VLFlagRevSP Then
        VGSSNCorr& = VLSSnCorreccion
    End If
    VLTsnTemporal = 0
    '<--hy-15-feb-2006
    
    If VGHorarioDif Then
        VLTrn = "3216"
    Else
        VLTrn = "3215"
    End If
    VGTrn = IIf(VLTrn = "", 0, VLTrn)
    
    'msilvag SOA fase2 Otros Municipios
    Consulta_parametro_OSB
    'msilvag Fin
    
    PMInicioTransaccion
    
    'GAMC - 05/03/2008 - Se separo por municipios
    If municipio.Text = "2237" Then
        Call Me.Muni_2237("2", 0)
    ElseIf municipio.Text = "2235" Then 'GAMC - 14/04/2008 - Municiapio de Santa Elena
        Call Me.Muni_2235("2", 0)
    'Wise - 15/Agt/2008 - Municio Libertad=2236
    ElseIf municipio.Text = "2236" Then
        Call Me.Muni_2236("2", 0)
    'End Wise
    ElseIf municipio.Text = "1430" Then 'nchavezb 08/Agosto/2011 Municipio Daule
        Call Me.Muni_1430("2", 0)
    Else
        'PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
        If (municipio.Text = "2234" Or municipio.Text = "2319") And vl_servidor_BUS <> "PSSRV1" Then
            PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 62645, "Trn", ""
            If VGTipoEjecucion% <> CGReverso% Then
                PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLCHAR, "N", "TCorr", ""
            End If
            PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLCHAR, "VEN", "Canal", ""
        Else
            PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
        End If
        PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "T", "opcion", ""
        PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
        'If municipio.Text = "1417" Then  'hy-21-diciembre-2006 [pase rezagado]
        If Me.municipio.Text <> "2319" Then 'GAMC - 23/02/2008
            PMPasoValoresATX VGSqlConn, "@i_identifica", 0, SQLVARCHAR, cedula.ClipText, "identificacion", ""
        End If
        'End If
        PMPasoValoresATX VGSqlConn, "@i_cod_impto", 0, SQLCHAR, (Impto.Caption), "tipo", ""
        If municipio.Text = "2234" Then  'hy-05-noviembre-2007
            PMPasoValoresATX VGSqlConn, "@i_catastro", 0, SQLVARCHAR, (Predio.Caption), "Catastro", ""     'hy-05-noviembre-2007
        ElseIf municipio.Text = "2319" Then  'GAMC - 23/02/2008
            PMPasoValoresATX VGSqlConn, "@i_catastro2", 0, SQLVARCHAR, Mid(Me.txtCatasSamb.Text, 1, 19), "Catastro", ""
            PMPasoValoresATX VGSqlConn, "@i_catastro3", 0, SQLVARCHAR, Mid(Me.txtCatasSamb.Text, 20, 19), "Catastro", ""
            PMPasoValoresATX VGSqlConn, "@i_catastro4", 0, SQLVARCHAR, Mid(Me.txtCatasSamb.Text, 40, 20), "Catastro", ""
            
        Else
            PMPasoValoresATX VGSqlConn, "@i_no_predio", 0, SQLINT4, (Predio.Caption), "Moneda", ""
        End If
        PMPasoValoresATX VGSqlConn, "@i_agno", 0, SQLINT4, val(Agno.Caption), "Autorizacion", ""
        PMPasoValoresATX VGSqlConn, "@i_semestre", 0, SQLVARCHAR, (Semestre.Caption), "Autorizacion", ""
        If municipio.Text = "2234" Then  'hy-05-noviembre-2007
            PMPasoValoresATX VGSqlConn, "@i_referencia", 0, SQLVARCHAR, (Prioridad.Text), "Referencia", ""    'hy-05-noviembre-2007
        ElseIf municipio.Text = "2319" Then  'GAMC - 23/02/2008
            PMPasoValoresATX VGSqlConn, "@i_referencia2", 0, SQLVARCHAR, (Prioridad.Text), "Referencia", ""
        Else
            PMPasoValoresATX VGSqlConn, "@i_prioridad", 0, SQLINT4, val(Prioridad.Text), "Prioridad", ""
        End If
        'GAMC - 23/02/2008 - SE AGREGO 2319(SAMBORONDON)
         If municipio.Text = "2234" Or municipio.Text = "2319" Or municipio.Text = "1435" Then
            PMPasoValoresATX VGSqlConn, "@i_nombre", 0, SQLVARCHAR, (Contribuyente.Caption), "Nombre", ""   'hy-05-noviembre-2007
            PMPasoValoresATX VGSqlConn, "@i_nom_impto", 0, SQLCHAR, (Impto.Tag), "nomimpto", ""
            PMPasoValoresATX VGSqlConn, "@i_fecven", 0, SQLCHAR, (VLGridFecVen), "fecven", ""
        Else  'hy-05-noviembre-2007
            If municipio.Text = "1433" Then  'hy-14-agosto-2006
                PMPasoValoresATX VGSqlConn, "@i_nombre", 0, SQLVARCHAR, (VLNombreCliente), "Nombre", ""
            Else
                'hy-14-agosto-2006 para municipio de quito es el nombre de la trama
                PMPasoValoresATX VGSqlConn, "@i_nombre", 0, SQLVARCHAR, (VLContribuyente), "Nombre", ""
            End If
        End If  'hy-05-noviembre-2007
        PMPasoValoresATX VGSqlConn, "@i_efe", 0, SQLMONEY, (efe.Text), "efe", ""
        PMPasoValoresATX VGSqlConn, "@i_cant_chq", 0, SQLINT4, val(CantChq.Text), "Moneda", ""
        PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, (Cheques.Text), "Cheques", ""
        PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(FMObtenerMonedaForma("19")), "Moneda", ""
        PMPasoValoresATX VGSqlConn, "@i_autoriza", 0, SQLVARCHAR, VGAutoriza, "Autorizacion", ""
        PMPasoValoresATX VGSqlConn, "@i_supautor", 0, SQLVARCHAR, VGSuperAutoriza$, "Supervisor de Monto", ""       'ref:esma10mar2003
        PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, (Debito.Text), "Debito", ""
        PMPasoValoresATX VGSqlConn, "@i_tarjeta", 0, SQLMONEY, (Tarjeta.Text), "Tarjeta", ""
        'ref003 Ini
        'PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
        If Me.Cta.ClipText <> "" Then
          PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (CboTipCta.Text), "CboTipCta", ""
        PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
        Else
          PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (VLTipCta_com), "CboTipCta", ""
          PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (VLCta_com), "Cta", ""
        End If
        
        'ref003 Fin
        'PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (CboTipCta.Text), "CboTipCta", ""
        PMPasoValoresATX VGSqlConn, "@i_contribuyente", 0, SQLVARCHAR, (Contribuyente.Caption), "contribuyente", ""
        PMPasoValoresATX VGSqlConn, "@i_valor_mun", 0, SQLMONEY, (ValorMun.Text), "valormun", ""
        If municipio.Text = "1433" Then
            PMPasoValoresATX VGSqlConn, "@i_valimpto", 0, SQLMONEY, 0, "valimpto", ""
            PMPasoValoresATX VGSqlConn, "@i_valinteres", 0, SQLMONEY, 0, "valinteres", ""
            If VGTipoEjecucion% = CGReverso% Then
                PMPasoValoresATX VGSqlConn, "@i_cod_cat1", 0, SQLVARCHAR, txtcat1.Text, "cat1", ""
            Else
                PMPasoValoresATX VGSqlConn, "@i_cod_cat1", 0, SQLVARCHAR, cat1.ClipText, "cat1", ""
            End If
            PMPasoValoresATX VGSqlConn, "@i_cod_cat2", 0, SQLVARCHAR, cat2.ClipText, "cat1", ""
            PMPasoValoresATX VGSqlConn, "@i_cod_cat3", 0, SQLVARCHAR, cat3.ClipText, "cat1", ""
            PMPasoValoresATX VGSqlConn, "@i_cod_cat4", 0, SQLVARCHAR, cat4.ClipText, "cat1", ""
            PMPasoValoresATX VGSqlConn, "@i_cod_cat5", 0, SQLVARCHAR, cat5.ClipText, "cat1", ""
            PMPasoValoresATX VGSqlConn, "@i_cod_cat6", 0, SQLVARCHAR, cat6.ClipText, "cat1", ""
            PMPasoValoresATX VGSqlConn, "@i_totaltrama", 0, SQLMONEY, (ValorMun), "cat1", ""
            PMPasoValoresATX VGSqlConn, "@i_horatrama", 0, SQLVARCHAR, Mid$(VLFecHora, 9, 6), "hora", ""
            PMPasoValoresATX VGSqlConn, "@i_vlfechora", 0, SQLVARCHAR, VLFecHora, "vlfechora", ""
            PMPasoValoresATX VGSqlConn, "@i_vlfeccontable", 0, SQLVARCHAR, VLFecContable, "vlfeccontable", ""
        Else
            '-->hy-14-agosto-2006
            PMPasoValoresATX VGSqlConn, "@i_tipo_impto", 0, SQLVARCHAR, (Tipo), "tipoimpto", ""
            PMPasoValoresATX VGSqlConn, "@i_totaltrama", 0, SQLMONEY, (ValorMun), "cat1", ""
            PMPasoValoresATX VGSqlConn, "@i_horatrama", 0, SQLVARCHAR, Mid$(VLFecHora, 9, 6), "hora", ""
            PMPasoValoresATX VGSqlConn, "@i_vlfechora", 0, SQLVARCHAR, VLFecHora, "vlfechora", ""
            PMPasoValoresATX VGSqlConn, "@i_vlfeccontable", 0, SQLVARCHAR, VLFecContable, "vlfeccontable", ""
            PMPasoValoresATX VGSqlConn, "@i_vlexoneracion", 0, SQLVARCHAR, VLExoneracion, "vlexoneracion", ""
            PMPasoValoresATX VGSqlConn, "@i_vlavaluocomercial", 0, SQLVARCHAR, VLAvaluoComercial, "vlavaluocomercial", ""
            '<--hy-14-agosto-2006
            PMPasoValoresATX VGSqlConn, "@i_VLIdentificacion", 0, SQLVARCHAR, VLIdentificacion, "VLIdentificacion", ""  'hy-22-septiembre-2006
            'GAMC - 24/02/2008 - Se agrego el 2319(Samborondon)
            If municipio.Text = "2234" Or municipio.Text = "2319" Then
                PMPasoValoresATX VGSqlConn, "@i_valimpto", 0, SQLMONEY, "0", "valimpto", ""
                PMPasoValoresATX VGSqlConn, "@i_valinteres", 0, SQLMONEY, "0", "valinteres", ""
            Else
                PMPasoValoresATX VGSqlConn, "@i_valimpto", 0, SQLMONEY, (ValImpto.Text), "valimpto", ""
                PMPasoValoresATX VGSqlConn, "@i_valinteres", 0, SQLMONEY, (ValInteres.Text), "valinteres", ""
            End If
        End If
        PMPasoValoresATX VGSqlConn, "@i_sal_municipio", 0, SQLVARCHAR, (sal_municipio.Caption), "sal_municipio", ""
        PMPasoValoresATX VGSqlConn, "@i_sal_tipo", 0, SQLVARCHAR, (sal_tipo.Caption), "sal_tipo", ""
        PMPasoValoresATX VGSqlConn, "@i_desc_impto", 0, SQLVARCHAR, (DescripImpto.Text), "sal_tipo", ""
        PMPasoValoresATX VGSqlConn, "@i_direccion", 0, SQLVARCHAR, (direccion.Text), "direccion", ""
        '-->hy-30-ene-2006
        PMPasoValoresATX VGSqlConn, "@i_efe_com", 0, SQLMONEY, (VLEfe_com), "Com. efectivo", ""
        PMPasoValoresATX VGSqlConn, "@i_chq_com", 0, SQLMONEY, (VLChq_com), "Com. Cheques", ""
        PMPasoValoresATX VGSqlConn, "@i_deb_com", 0, SQLMONEY, (VLDeb_com), "Com. Debito", ""
        PMPasoValoresATX VGSqlConn, "@i_cta_com", 0, SQLVARCHAR, (VLCta_com), "Com. Cta", ""
        PMPasoValoresATX VGSqlConn, "@i_tipocta_com", 0, SQLCHAR, (VLTipCta_com), "Com. TipCta", ""
        
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
        
        '-->hy-14-agosto-2006
        If municipio.Text = "1417" Then
            PMPasoValoresATX VGSqlConn, "@i_titulo", 0, SQLCHAR, Trim$(Agno.Tag), "Titulo", ""
        End If
        '<--hy-14-agosto-2006
        'If municipio.Text = "1433" Then
        '    PMPasoValoresATX VGSqlConn, "@i_hora_trama", 0, SQLVARCHAR, Mid$(VLFecHora, 9, 6), "HoraTrama", ""
        'End If
        'msilvag Inicio SOA Fase 2 Otros Municipios
         If (municipio.Text = "2319" Or municipio.Text = "2234") And vl_servidor_BUS <> "PSSRV1" Then
            PMPasoValoresATX VGSqlConn, "@o_referencia2", 1, SQLVARCHAR, "XXXXXXXXXXXXXXXXXXXX", "Referencia2", ""
            PMPasoValoresATX VGSqlConn, "@o_direccion", 1, SQLVARCHAR, "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Direccion2", ""
            PMPasoValoresATX VGSqlConn, "@o_solar", 1, SQLVARCHAR, "XXXXXXXXXXXXXXX", "Solar2", ""
            PMPasoValoresATX VGSqlConn, "@o_valorpredio", 1, SQLMONEY, "0", "ValorPredio2", ""
            PMPasoValoresATX VGSqlConn, "@o_valorotros", 1, SQLMONEY, "0", "ValorOtros2", ""
            PMPasoValoresATX VGSqlConn, "@o_doc_ident", 1, SQLVARCHAR, "XXXXXXXXXXXXXXX", "Ced/Ruc/Pas", ""
            PMPasoValoresATX VGSqlConn, "@o_cod_ident", 1, SQLVARCHAR, "XXXXXXXXXXXXXXX", "Ced/Ruc/Pas", ""
         Else
         'msilvag Inicio SOA Fase 2 Otros Municipios
             '<--hy-30-ene-2006
             PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, "0", "SecTrn", ""
             PMPasoValoresATX VGSqlConn, "@o_nombcta", 1, SQLVARCHAR, (Nombre.Text), "nombre", ""
             PMPasoValoresATX VGSqlConn, "@o_horario", 1, SQLCHAR, Space(1), "Horario", ""
             '-->hy-30-ene-2006
             PMPasoValoresATX VGSqlConn, "@o_autorisri", 1, SQLVARCHAR, VLautoriSri, "AutorizacionSRI", ""
             PMPasoValoresATX VGSqlConn, "@o_fecvensri", 1, SQLVARCHAR, VLFecvenSRI, "Stk", ""
             PMPasoValoresATX VGSqlConn, "@o_nota_venta", 1, SQLVARCHAR, VLSerie_Secuencia, "Nota_venta", ""
             PMPasoValoresATX VGSqlConn, "@o_fechora", 1, SQLVARCHAR, 0, "Fechora", ""
             PMPasoValoresATX VGSqlConn, "@o_feccontable", 1, SQLVARCHAR, 0, "Feccontable", ""
             PMPasoValoresATX VGSqlConn, "@o_fecha_ef", 1, SQLVARCHAR, "", "Fechaefe", ""
            ' PMPasoValoresATX VGSqlConn, "@o_nota_venta", 1, SQLVARCHAR, VLSerie_Secuencia, "Nota_venta", ""
             
             'GAMC - 24/02/2008 - CAPTURAR LOS PARAMETROS DE SALIDA
             If Me.municipio.Text = "2319" Then
                 PMPasoValoresATX VGSqlConn, "@o_referencia2", 1, SQLVARCHAR, "", "Referencia2", ""
                 PMPasoValoresATX VGSqlConn, "@o_direccion", 1, SQLVARCHAR, "", "Direccion2", ""
                 PMPasoValoresATX VGSqlConn, "@o_solar", 1, SQLVARCHAR, "", "Solar2", ""
                 PMPasoValoresATX VGSqlConn, "@o_valorpredio", 1, SQLMONEY, "0", "ValorPredio2", "" 'smerino
                 PMPasoValoresATX VGSqlConn, "@o_valorotros", 1, SQLMONEY, "0", "ValorOtros2", ""  'smerino
             End If
        End If
        'PMPasoValoresATX VGSqlConn, "@o_nombcta", 1, SQLVARCHAR, (Nombre.Text), "nombre", ""
        
    End If 'GAMC - 05/03/2008 - Se separo por municipios
    
    '<--hy-30-ene-2006
    'msilvag Otros Municipios
    vlServidor = vl_servidor_BUS
    If vl_servidor_BUS <> "PSSRV1" And ((Me.municipio.Text = "1430") Or (Me.municipio.Text = "2234") Or (Me.municipio.Text = "2235") Or (Me.municipio.Text = "2236") Or (Me.municipio.Text = "2237") Or (Me.municipio.Text = "2319")) Then
        vl_base = "cob_procesador"
    Else
        vl_servidor_BUS = ""
        vl_base = "cob_pagos"
    End If
    
    If FMTransmitirRPCATX(VGSqlConn, vl_servidor_BUS, vl_base, "sp_tr_municipio_recaudacion", True, "Transaccion Ok", "S", "N", "S", "19", "S", "S") = True Then 'msilvag soa Fase 2 Otros Municipios
    'msilvag Fin
    'If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_tr_municipio_recaudacion", True, "Transaccion Ok", "S", "N", "S", "19", "S", "S") = True Then
        VLTsnTemporal = VGTSN  'hy-15-feb-2006
        'msilvag soa fase 2 Otros Municipios
        If vlServidor <> "PSSRV1" And ((Me.municipio.Text = "1430") Or (Me.municipio.Text = "2234") Or (Me.municipio.Text = "2235") Or (Me.municipio.Text = "2236") Or (Me.municipio.Text = "2237") Or (Me.municipio.Text = "2319")) Then
            'VTResult% = FMMapeaMatrizATX(VGSqlConn&, vtmatrizcps2())
            VTResult% = FMMapeaMatrizATX(VGSqlConn&, vtmatrizcps2())
            Nombre.Text = FLBuscarItem2("@nombre")
            SGSecTrn$ = FLBuscarItem2("@o_ssn")
            VLSSnCorreccion = FLBuscarItem2("@o_ssn")
            VLSsn = FLBuscarItem2("@o_ssn")
            VLHorario = FLBuscarItem2("@o_horario")
             VLautoriSri = FLBuscarItem2("@autorizacionSRI")
            VLFecvenSRI = FLBuscarItem2("@fechaSRI")
            If VGTipoEjecucion% <> CGReverso% Then
                VLFechaEfe = FLBuscarItem2("@fechaEfectiva")
            End If
        Else
        'msilvag Fin
            Nombre.Text = Mid$(FMRetParamATX(VGSqlConn, 2), 1, 30)
            SGSecTrn$ = FMRetParamATX(VGSqlConn, 1)
            VLSSnCorreccion = FMRetParamATX(VGSqlConn, 1)
            VLSsn = FMRetParamATX(VGSqlConn, 1)
            VLHorario = Trim$(FMRetParamATX(VGSqlConn, 3))
            '-->hy-15-feb-2006
            VLautoriSri = FMRetParamATX(VGSqlConn, 4)
            VLFecvenSRI = FMRetParamATX(VGSqlConn, 5)
            VLSerie_Secuencia = FMRetParamATX(VGSqlConn, 6)  'hy-24-feb-2005
            If VGTipoEjecucion% <> CGReverso% Then
                VLFechaEfe = FMRetParamATX(VGSqlConn, 9)
            End If
            '<--hy-15-feb-2006
        End If
        
        
        PMChequeaATX VGSqlConn
        PMTotalesBranch "19"
        FLTransmitir = True
        VLCambio% = False
        'TPE ------> Sumadora
       
        If Len(Trim$(VLSsn)) > 6 Then
            VLSsn = Right$(Trim$(VLSsn), 6)
        Else
            VLSsn = String(6 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
        End If
        
       
        
        VTIndicadorSum = 1
        PMIniciaRegSum
        '<-----
        'GAMC - 24/02/2008 - Municipio de Samborondon
        'Guardo los campos para usar en la papeleta
        'GAMC - 05/03/2008 - Municipio de Salinas
        'GAMC - 14/04/2008 - Municipio de Santa Elena
        'If municipio.Text = "2319" Or municipio.Text = "2237" Or municipio.Text = "2235" Then
        'Se aumenta Municipio 1430 Mun. Daule nchavezb 08/Agosto/2011
        If municipio.Text = "2319" Or municipio.Text = "2237" Or municipio.Text = "2235" Or municipio.Text = "2236" Or municipio.Text = "1430" Then 'Wise M. Libertad=2236 - 15/Agt/2008
            If vlServidor = "PSSRV1" Then
                If VGTipoEjecucion% <> CGReverso% Then
                    VLMuniSamb(0) = CStr(FMRetParamATX(VGSqlConn, 10))
                    VLMuniSamb(1) = CStr(FMRetParamATX(VGSqlConn, 11))
                    VLMuniSamb(2) = CStr(FMRetParamATX(VGSqlConn, 12))
                    VLMuniSamb(3) = CStr(FMRetParamATX(VGSqlConn, 13))
                    VLMuniSamb(4) = CStr(FMRetParamATX(VGSqlConn, 14))
                    VLMuniSamb(5) = CStr(FMRetParamATX(VGSqlConn, 15))
                End If
            'msilvag Inicio soa Fase 2 Otros Municipios
            Else
                If VGTipoEjecucion% <> CGReverso% Then
                    VLMuniSamb(0) = CStr(FMRetParamATX(VGSqlConn, 1))
                    VLMuniSamb(1) = CStr(FMRetParamATX(VGSqlConn, 2))
                    VLMuniSamb(2) = CStr(FMRetParamATX(VGSqlConn, 3))
                    VLMuniSamb(3) = CStr(FMRetParamATX(VGSqlConn, 4))
                    VLMuniSamb(4) = CStr(FMRetParamATX(VGSqlConn, 5))
                    If municipio.Text <> "2319" Then
                        VLMuniSamb(5) = CStr(FMRetParamATX(VGSqlConn, 6))
                    End If
                End If
            End If
            'msilvag Fin
        End If
    Else
        VLCambio% = True
        FLTransmitir = False
        'TPE ------> Sumadora
        'msilvag Inicio soa Fase 2 Otros Municipios
        If vlServidor <> "PSSRV1" And ((Me.municipio.Text = "1430") Or (Me.municipio.Text = "2234") Or (Me.municipio.Text = "2235") Or (Me.municipio.Text = "2236") Or (Me.municipio.Text = "2237") Or (Me.municipio.Text = "2319")) Then
            SGSecTrn$ = FMRetParamATX(VGSqlConn, 11)
        Else
            SGSecTrn$ = FMRetParamATX(VGSqlConn, 1)
        End If
        'SGSecTrn$ = FMRetParamATX(VGSqlConn, 1)
        'msilvag Fin
        VTIndicadorSum = 0
        PMChequeaATX VGSqlConn
        PMFinTransaccion
        Exit Function
        '<------
    End If
    PMChequeaATX VGSqlConn
    If vlServidor = "PSSRV1" Then 'And (Me.municipio.Text = "1430") And (Me.municipio.Text = "2234") And (Me.municipio.Text = "2235") And (Me.municipio.Text = "2236") And (Me.municipio.Text = "2237") And (Me.municipio.Text = "2319") Then 'msilvag Otros Municipios
        If FMRetStatusATX(VGSqlConn) <> 0 Then
            VTIndicadorSum = 0
            FLTransmitir = False
            PMFinTransaccion
            Exit Function
        End If
    End If 'msilvag Otros Municipios
    PMFinTransaccion
   
    '-->hy-15-feb-2006
    
'-->lfcm 12-febrero-2009
'    If municipio.Text = "1433" Then
'        If VGTipoEjecucion% <> CGReverso% Then
'            If Not FLTramaSwitch("P") Then
'                If VLRevTimeOut Then
'                    VLFlagRevSP = True
'                    FLTransmitir = True
'                End If
'                Exit Function
'            End If
'        Else
'            If VLFlagRevSP Then
'                If VLRevTimeOut Then
'                    If Not VLReversarSoloSP Then
'                        If Not FLTramaSwitch("Z") Then
'                            FLTransmitir = True
'                            Exit Function
'                        End If
'                    End If
'                End If
'            'Else
'            '    If Not FLTramaSwitch("R") Then
'            '        FLTransmitir = True
'            '        Exit Function
'            '    End If
'            End If
'        End If
'    End If
'    '<--hy-15-feb-2006
'--<lfcm 12-febrero-2009

    
    '-->hy-14-agosto-2006
    If municipio.Text = "1417" Then
        If VGTipoEjecucion% <> CGReverso% Then
            If Not FLTramaSwitch_MQ("P") Then
                If VLRevTimeOut Then
                    VLFlagRevSP = True
                    FLTransmitir = True
                End If
                Exit Function
            End If
        Else
            If VLFlagRevSP Then
                If VLRevTimeOut Then
                    If Not VLReversarSoloSP Then
                        If Not FLTramaSwitch_MQ("Z") Then
                            FLTransmitir = True
                            Exit Function
                        End If
                    End If
                End If
            End If
        End If
    End If
    '<--hy-14-agosto-2006
    
    'GAMC - 02AGO10
VLclave_acceso = "" 'ref02 vmirandt

'ref02 Ini

    'JPM Lectora de Billetes -->
    If CCur(efe.Text) > 0 And ((VGDatPersBillAltDen.dataOK And VGTipoEjecucion = CGNormal%) Or VGTipoEjecucion = CGReverso%) Then
      Call PMGuardarDsglsBillete("19", SGSecTrn$, VLTrn, rptBAD, "REC", "")
      lectoraBill.Limpiar
    End If
    '<-- JPM Lectora de Billetes
    If VLDeb_com = 0 Then
      Call PLFactura
    End If
    
'ref02 Fin
    
    'Sumadora -->
    If VGTipoEjecucion% <> CGReverso% Then   'Validacion por REVERSO
        If (VTIndicadorSum = 1 And (Trim$(VGStatusCon) = "A" Or Trim$(VGStatusCon) = "")) Then
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

Public Sub PLFactura()
    '**************************************
    'GAMC - 02AGO10 - GUARDAR FACTURA - INI
    '**************************************
    If Comision.Text > 0 And VLDeb_com = 0# Then
        Dim fr_secuencia As Long, fr_ssn As Long
        Dim fr_ced_ruc As String, fr_nombre As String, fr_fact_elect As String, fr_pto_estab As String, fr_pto_emis As String, _
            fr_fecha_validez As String, fr_nautorizacion As String, fr_valor As String, fr_iva As String, _
            fr_referencia As String, fr_servicio As String, nro_factura As String, fr_baseImp As String, fr_impresa As String, fr_fecha_ini_vig As String, fr_fecha_fin_vig As String 'SMERINO
        Dim fr_descuento As String, fr_forma_pag As String, fr_porc_compensa As String, fr_porc_iva As String 'LBP RECA-CC-SGC00025869 30/07/2016
        
        If VGTipoEjecucion% <> CGReverso% Then
            fr_ssn = CLng(SGSecTrn)
        Else
            fr_ssn = CLng(VGSSNCorr)
        End If
        
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
        fr_impresa = "S" 'smerino 'smerino
        
        If Predio.Caption <> "" Then '1800 - 1417 - 2234
            fr_referencia = Predio.Caption
        ElseIf claveCatastral.ClipText <> "" Then '2237 - 2235
            fr_referencia = claveCatastral.ClipText
        ElseIf txtCatasSamb.Text <> "" Then '2319 - 2236
            fr_referencia = txtCatasSamb.Text
        ElseIf cedula.ClipText <> "" And (municipio.Text = 1434 Or municipio.Text = 1800 Or municipio.Text = 1417 Or municipio.Text = 1435) Then    '1434
            fr_referencia = cedula.ClipText & " - " & CStr(VLMLNoCuota)
        ElseIf cedula.ClipText <> "" And ((Me.municipio.Text = 7749 And Me.Tipo.Text = "003") Or (Me.municipio.Text = 7749 And Me.Tipo.Text = "002")) Then
            fr_referencia = cedula.ClipText & " - " & Me.Agno.Caption
        ElseIf Me.CEP.Text <> "" And Me.municipio.Text = 7749 And Me.Tipo.Text = "004" Then
            fr_referencia = Me.CEP.Text
        ElseIf txtLlaveMunicipal.Text <> "" Then
             fr_referencia = txtLlaveMunicipal.Text & " - " & CStr(VLMLNoCuota)
        Else    '1433
            fr_referencia = cat1.ClipText & cat2.ClipText & cat3.ClipText & cat4.ClipText & cat5.ClipText & cat6.ClipText
        End If
        
        fr_servicio = "Municipios"
        If VGTipoEjecucion% <> CGReverso% Then
            If FMFacturaRecaudacion("1", fr_secuencia, fr_ssn, fr_ced_ruc, fr_nombre, fr_fact_elect, _
                fr_pto_estab, fr_pto_emis, fr_fecha_validez, fr_nautorizacion, fr_valor, fr_iva, _
                fr_baseImp, fr_impresa, fr_referencia, fr_servicio, nro_factura, fr_fecha_ini_vig, fr_fecha_fin_vig, _
                fr_descuento, fr_forma_pag, fr_porc_compensa, fr_porc_iva) Then    'LBP RECA-CC-SGC00025869 30/07/2016
                'VLautoriSri = fr_nautorizacion
                VLclave_acceso = fr_nautorizacion '--ref02 vmirandt
                VLFecvenSRI = fr_fecha_validez
                VLSerie_Secuencia = nro_factura
                VLImprCompComi = fr_fact_elect
                VLFecinivig = fr_fecha_ini_vig  'SMERINO
                VLFecfinvig = fr_fecha_fin_vig  'SMERINO
            Else
                MsgBox "ERROR: Al guardar factura: " & CStr(fr_ssn)
            End If
        Else
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

Function FLConsultar() As Integer
Dim VTIndicadorSum As Integer
Dim VLClavtemp As String
    VTIndicadorSum = 0
    
    VLFlagSumadora = False  'hy-15-feb-2006
    
    If VGHorarioDif Then
        VLTrn = "3216"
    Else
        VLTrn = "3215"
    End If
    VGTrn = IIf(VLTrn = "", 0, VLTrn)

    '-->lfcm 19-enero-2009
    'If Trim$(municipio.Text) = "1433" Then
    '   If FLTransmitir_CPS_MUNGYE_consulta() = False Then
    '      Exit Function
    '   End If
    'ElseIf Trim$(municipio.Text) = "1417" Then
    '   FLTransmitir_CPS_MUNQTO_consulta
    '   Exit Function
    'End If
    '--<lfcm 19-enero-2009

    Consulta_parametro_OSB 'msilvag SOA fase2 Otros Municipios
    
    PMInicioTransaccion
    
    'msilvag Inicio Soa fase 2 Otros Municipios
    If vl_servidor_BUS <> "PSSRV1" And ((Me.municipio.Text = "1430") Or (Me.municipio.Text = "2234") Or (Me.municipio.Text = "2235") Or (Me.municipio.Text = "2236") Or (Me.municipio.Text = "2237") Or (Me.municipio.Text = "2319")) Then
        PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 3214, "Trn", ""
        'vl_base = "cob_procesador"
    Else
        PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
        'vl_servidor_BUS = ""
        'vl_base = "cob_pagos"
    End If
    PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Canal", ""
    'msilvag Fin
    
    'GAMC - 23/02/2008 - SE INCLUYO EL 2319(SAMBORONDON)
    'If Trim$(municipio.Text) = "1433" Or Trim$(municipio.Text) = "2234" Or Trim$(municipio.Text) = "2319" Then  'Si es municipio de guayaquil  hy-05-noviembre-2007 incluir mun 2234
    'If Trim$(municipio.Text) = "1433" Or Trim$(municipio.Text) = "2234" Or Trim$(municipio.Text) = "2319" Or Trim$(municipio.Text) = "2237" Then  ' Municipio de Salinas - GAMC - 05/03/2008
    'If Trim$(municipio.Text) = "1433" Or Trim$(municipio.Text) = "2234" Or Trim$(municipio.Text) = "2319" Or Trim$(municipio.Text) = "2237" Or Trim$(municipio.Text) = "2235" Then  ' Municipio de Santa Elena - GAMC - 14/04/2008
    'Se aumento 1430 Municipio Daule nchavezb 04/08/2011
    If Trim$(municipio.Text) = "1433" Or Trim$(municipio.Text) = "2234" Or Trim$(municipio.Text) = "2319" Or Trim$(municipio.Text) = "2237" Or Trim$(municipio.Text) = "2235" Or Trim$(municipio.Text) = "2236" Or Trim$(municipio.Text) = "1430" Then   ' Wise se Agregó Munic. Libertad=2236 13/Agt/2008
        PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "C", "opcion", ""
    Else
        PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "V", "opcion", ""
    End If
    PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_tipo_impto", 0, SQLVARCHAR, (Me.Tipo.Text), "tipoimpto", ""  'msilvag Migracion Municipio
    'If Trim$(municipio.Text) = "2319" Then 'GAMC - 23/02/2008
    If Trim$(municipio.Text) = "2319" Or Trim$(municipio.Text) = "2236" Then 'Wise agregó validacion para Municipio Libertad=2236 13/Agt/2008
        PMPasoValoresATX VGSqlConn, "@i_catastro2", 0, SQLVARCHAR, Me.txtCatasSamb.Text, "catastro", ""
    'ElseIf Trim$(municipio.Text) = "2237" Then 'GAMC - 05/03/2008
    ElseIf Trim$(municipio.Text) = "2237" Or Trim$(municipio.Text) = "2235" Then 'GAMC - 14/04/2008
        VLClavtemp = Muni_2237("5", 0)
        PMPasoValoresATX VGSqlConn, "@i_catastro2", 0, SQLVARCHAR, VLClavtemp, "catastro", ""
    ElseIf Trim$(municipio.Text) = "1430" Then 'nchavezb Municipio Daule 08/Agosto/2011
        PMPasoValoresATX VGSqlConn, "@i_no_predio", 0, SQLINT4, val(Me.txtCatasSamb.Text), "Predio", ""
        PMPasoValoresATX VGSqlConn, "@i_referencia", 0, SQLVARCHAR, Me.Prioridad.Text, "Predio", ""
    End If
    'If municipio.Text = "1417" Then  'hy-21-diciembre-2006 [pase rezagado]
        'If Trim$(municipio.Text) <> "2319" Then 'GAMC - 23/02/2008
        'If Trim$(municipio.Text) <> "2319" And Trim$(municipio.Text) <> "2237" Then 'GAMC - 05/03/2008
        'If Trim$(municipio.Text) <> "2319" And Trim$(municipio.Text) <> "2237" And Trim$(municipio.Text) <> "2235" Then 'GAMC - 14/04/2008 - Santa Elena
        If Trim$(municipio.Text) <> "2319" And Trim$(municipio.Text) <> "2237" And Trim$(municipio.Text) <> "2235" And Trim$(municipio.Text) <> "2236" Then ''Wise agreago para Municipio Libertad = "2236") - 14/Agt/2008
            PMPasoValoresATX VGSqlConn, "@i_identifica", 0, SQLVARCHAR, cedula.ClipText, "identificacion", ""
        End If
    'End If
    If Trim$(Tipo.Text) <> "" Then
        PMPasoValoresATX VGSqlConn, "@i_cod_impto", 0, SQLCHAR, (Tipo.Text), "tipo", ""
    End If
    
    If vl_servidor_BUS <> "PSSRV1" And ((Me.municipio.Text = "1430") Or (Me.municipio.Text = "2234") Or (Me.municipio.Text = "2235") Or (Me.municipio.Text = "2236") Or (Me.municipio.Text = "2237") Or (Me.municipio.Text = "2319")) Then
        PMPasoValoresATX VGSqlConn, "@o_comision", 1, SQLMONEY, 0, "comision", ""
        PMPasoValoresATX VGSqlConn, "@o_nom_cli", 1, SQLVARCHAR, "XXXXXXXXXXXXXXXXXXXXXXX", "nomcli", ""
        PMPasoValoresATX VGSqlConn, "@o_base_imp", 1, SQLMONEY, "0", "base_imp", ""
        PMPasoValoresATX VGSqlConn, "@o_tasa", 1, SQLMONEY, "0", "tasa", ""
        PMPasoValoresATX VGSqlConn, "@o_impuesto", 1, SQLMONEY, "0", "impuesto", ""
    Else
        PMPasoValoresATX VGSqlConn, "@o_comision", 1, SQLMONEY, 0, "comision", ""
        PMPasoValoresATX VGSqlConn, "@o_nom_cli", 1, SQLVARCHAR, 0, "nomcli", ""
         'smerino
        PMPasoValoresATX VGSqlConn, "@o_tasa", 1, SQLMONEY, "0", "tasa", ""
        PMPasoValoresATX VGSqlConn, "@o_base_imp", 1, SQLMONEY, "0", "base_imp", ""
        PMPasoValoresATX VGSqlConn, "@o_impuesto", 1, SQLMONEY, "0", "impuesto", ""
        'smerino
    End If
    'msilvag SOA fase2 otros municipios
    vlServidor = vl_servidor_BUS
    If vl_servidor_BUS <> "PSSRV1" And ((Me.municipio.Text = "1430") Or (Me.municipio.Text = "2234") Or (Me.municipio.Text = "2235") Or (Me.municipio.Text = "2236") Or (Me.municipio.Text = "2237") Or (Me.municipio.Text = "2319")) Then
        vl_base = "cob_procesador"
    Else
        vl_servidor_BUS = ""
        vl_base = "cob_pagos"
    End If
    
    If FMTransmitirRPCATX(VGSqlConn, vl_servidor_BUS, vl_base, "sp_tr_municipio_recaudacion", True, "Transaccion Ok", "S", "N", "N", "19", "S", "S") = True Then 'msilvag Otros municipios
    'If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_tr_municipio_recaudacion", True, "Transaccion Ok", "S", "N", "N", "19", "S", "S") = True Then
    'msilvag fin
        PMMapeaGridATX VGSqlConn, grdDetalle, False
        Comision = FMRetParamATX(VGSqlConn, 1)
        VLNombreCliente = FMRetParamATX(VGSqlConn, 2)
        VlbaseImp = FMRetParamATX(VGSqlConn, 4) 'smerino iva
        VLiva = FMRetParamATX(VGSqlConn, 5) 'smerino iva
        '-->hy-05-noviembre-2007
        If municipio.Text = "2234" Then
            VLContribuyente = VLNombreCliente
            VLIdentificacion = cedula.ClipText
        End If
        '<--hy-05-noviembre-2007
        'GAMC - 23/02/2008 - INI
        'If municipio.Text = "2319" Then
        If municipio.Text = "2319" Or municipio.Text = "2236" Then ' Wise Agrego Munc. Libertad=2236 - 13/Agt/2008
            VLContribuyente = VLNombreCliente
            VLIdentificacion = Me.txtCatasSamb.Text
        End If
        'GAMC - 23/02/2008 - INI
        'GAMC - 05/03/2008 - INI
        'If municipio.Text = "2237" Then
        If municipio.Text = "2237" Or municipio.Text = "2235" Then 'GAMC - 14/04/2008 - Santa Elena
            VLContribuyente = VLNombreCliente
            VLIdentificacion = Me.claveCatastral.Text
        End If
        
        If municipio.Text = "1430" Then
            VLContribuyente = VLNombreCliente
            VLIdentificacion = Me.txtCatasSamb.Text
        End If
        'GAMC - 05/03/2008 - INI
        PMChequeaATX VGSqlConn
        PMTotalesBranch "19"
        FLConsultar = True
        VLCambio% = False
        
        'msilvag Inicio Migracion WebService Banred CEPMG-AP-SGC00022255-SGC00023616
        If Me.municipio.Text = 7749 And Me.Tipo.Text = "001" Then
            VLCodMunicipio = 1433
        Else
            If Me.municipio.Text = 7749 And Me.Tipo.Text = "002" Then
                VLCodMunicipio = 1434
            Else
                If Me.municipio.Text = 7749 And Me.Tipo.Text = "003" Then
                    VLCodMunicipio = 1435
                Else
                    If Me.municipio.Text = 7749 And Me.Tipo.Text = "004" Then
                        VLCodMunicipio = 7749
                    Else
                        VLCodMunicipio = Me.municipio.Text
                    End If
                End If
            End If
        End If
        'msilvag Fin
        
         'LBP Inicio RECA-CC-SGC00025869
         If Comision.Text > 0 Then
            VGCom_aux = FMDevuelveComisionReal(Comision, False, VLCodMunicipio) 'FMDevuelveComisionReal(Comision, False, municipio.Text)
            If VGCom_aux <> CDbl(Comision.Text) Then
                VGComision_original = Comision.Text
                Comision.Text = VGCom_aux
            Else
                VGComision_original = Comision.Text
            End If
         End If
        'LBP Fin RECA-CC-SGC00025869
        
    Else
        VLCambio% = True
        FLConsultar = False
        PMChequeaATX VGSqlConn
        PMFinTransaccion
        Exit Function
        '<------
    End If
    PMChequeaATX VGSqlConn
    'msilvag soa fase 2 Otros Municipios
'    If vlServidor = "PSSRV1" Then 'And ((Me.municipio.Text = "1430") Or (Me.municipio.Text = "2234") Or (Me.municipio.Text = "2235") Or (Me.municipio.Text = "2236") Or (Me.municipio.Text = "2237") Or (Me.municipio.Text = "2319")) Then
'        If FMRetStatusATX(VGSqlConn) <> 0 Then
'            FLConsultar = False
'            Exit Function
'        End If
'    End If
    'msilvag Fin
    PMFinTransaccion

    '-->hy-22-febrero-2007
    If Trim$(municipio.Text) = "1800" Then
        'If FLTransmitir_CPS_MUNCUE_consulta() Then
        If FLTransmitir_CSP_MUNCUE_consulta() Then  ' ame 06/24/2010
            FLConsultar = True
        Else
            FLConsultar = False
        End If
        Exit Function
    End If
    '<--hy-22-febrero-2007
    
    '-->lfcm-13-febrero-2009
    If Trim$(municipio.Text) = "1433" Then
        If FLTransmitir_CPS_MUNGYE_consulta() Then
            FLConsultar = True
        Else
            FLConsultar = False
        End If
        Exit Function
    End If
    '<--lfcm 13-febrero-2009
    
    '-->lfcm-08-junio-2009 MiLote
    If Trim$(municipio.Text) = "1434" Then
        If FLTransmitir_CPS_MILOTE_consulta() Then
            FLConsultar = True
        Else
            FLConsultar = False
        End If
        Exit Function
    End If
    '<--lfcm 08-junio-2009 MiLote
    
     'nchavezb 02/04/2011 MUNICIP. MERCADOS Y CREDENCIALES
    If Trim$(municipio.Text) = "1435" Then
        If FLTransmitir_CSP_Mercados_MUNGYE_consulta() Then
            FLConsultar = True
        Else
            FLConsultar = False
        End If
        Exit Function
    End If
    
     'SMERINOM 10/02/2015 MUNICIP. DE GUAYAQUIL CEP
    If Trim$(municipio.Text) = "7749" And Tipo.Text = "004" Then
        If FLTransmitir_MUNGYE_CEP_consulta() Then
            FLConsultar = True
        Else
            FLConsultar = False
        End If
        Exit Function
    End If
    
    'msilvag Inicio Feb-10-2016 Migracion WebService Municipio
    If Trim$(municipio.Text) = "7749" And Tipo.Text = "001" Then 'Predios
        If FLTransmitir_CPS_MUNGYE_consulta() Then
            FLConsultar = True
        Else
            FLConsultar = False
        End If
        Exit Function
    End If
    
    If Trim$(municipio.Text) = "7749" And Tipo.Text = "002" Then  'Mi lote
        If FLTransmitir_CPS_MILOTE_consulta() Then
            FLConsultar = True
        Else
            FLConsultar = False
        End If
        Exit Function
    End If
    
    If Trim$(municipio.Text) = "7749" And Tipo.Text = "003" Then  'Mercados
        If FLTransmitir_CSP_Mercados_MUNGYE_consulta() Then
            FLConsultar = True
        Else
            FLConsultar = False
        End If
        Exit Function
    End If
    'msilvag Fin
    
        ' ame 02/18/2010
    If Trim$(municipio.Text) = "1417" Then
        If FLTransmitir_CPS_MUNQTO_consulta() Then
            FLConsultar = True
        Else
            FLConsultar = False
        End If
        Exit Function
    End If

    'nchavezb 08/Agosto/2011 Municipio Daule
    If Trim$(municipio.Text) = "1430" Then
        
    End If
    
    
    '-->hy-15-feb-2006
    VLFlagSumadora = True
    
    If Trim$(municipio.Text) = "1433" Then  'Si es municipio de guayaquil
        '-->hy-21-diciembre-2006 [pase rezagado] he quitado el comentario
        'If Trim$(cedula.ClipText) = "" Then                                          'lfcm 29-octubre-2008
        '    MsgBox "La identificación es necesaria", vbInformation, "Aviso"          'lfcm 29-octubre-2008
        '    FLConsultar = False                                                      'lfcm 29-octubre-2008
        '    Exit Function                                                            'lfcm 29-octubre-2008
        'End If                                                                       'lfcm 29-octubre-2008
        '<--hy-21-diciembre-2006 [pase rezagado] he quitado el comentario
        If Len(cat1.ClipText) = 0 Or Len(cat2.ClipText) = 0 Or _
           Len(cat3.ClipText) = 0 Or Len(cat4.ClipText) = 0 Or _
           Len(cat5.ClipText) = 0 Or Len(cat6.ClipText) = 0 Then
            MsgBox "El código catastral esta incompleto", vbInformation, "Aviso"
            FLConsultar = False
            Exit Function
        End If
    End If   'hy-14-agosto-2006
    
    'msilvag SOA fase 2 Inicio consulta comision
    If vlServidor <> "PSSRV1" And ((Me.municipio.Text = "1430") Or (Me.municipio.Text = "2234") Or (Me.municipio.Text = "2235") Or (Me.municipio.Text = "2236") Or (Me.municipio.Text = "2237") Or (Me.municipio.Text = "2319")) Then
        If VGHorarioDif Then
            VLTrn = "3216"
        Else
            VLTrn = "3215"
        End If
        
       PMInicioTransaccion
       PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
       PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "V", "opcion", ""
       PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
       PMPasoValoresATX VGSqlConn, "@o_comision", 1, SQLMONEY, 0, "comision", ""
    
        PMPasoValoresATX VGSqlConn, "@o_tasa", 1, SQLMONEY, "0", "tasa", ""
        PMPasoValoresATX VGSqlConn, "@o_base_imp", 1, SQLMONEY, "0", "base_imp", ""
        PMPasoValoresATX VGSqlConn, "@o_impuesto", 1, SQLMONEY, "0", "impuesto", ""
       
       If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_tr_municipio_recaudacion", True, "Transaccion Ok", "S", "N", "N", "19", "S", "S") = True Then
          Comision = FMRetParamATX(VGSqlConn, 1)
           VlbaseImp = FMRetParamATX(VGSqlConn, 3)
           VLiva = FMRetParamATX(VGSqlConn, 4)
          PMChequeaATX VGSqlConn
          PMTotalesBranch "19"
          FLConsultar = True
          VLCambio% = False
          
         'LBP Inicio RECA-CC-SGC00025869
         If Comision.Text > 0 Then
            VGCom_aux = FMDevuelveComisionReal(Comision, False, val(municipio.Text))
            If VGCom_aux <> CDbl(Comision.Text) Then
                VGComision_original = Comision.Text
                Comision.Text = VGCom_aux
            Else
                VGComision_original = Comision.Text
            End If
         End If
        'LBP Fin RECA-CC-SGC00025869
          
       Else
          VLCambio% = True
          MsgBox "ERROR AL OBTENER LA COMISION(MI LOTE)", vbCritical, "Aviso"
          FLConsultar = False
          PMChequeaATX VGSqlConn
          PMFinTransaccion
          Exit Function
       End If
       PMChequeaATX VGSqlConn
       PMFinTransaccion
   End If
   
   'msilvag SOA fase 2 Fin consulta comision
   
    'Llamar al sp para obtener usuario fechas
    If VGHorarioDif Then
        VLTrn = "3216"
    Else
        VLTrn = "3215"
    End If
    VGTrn = IIf(VLTrn = "", 0, VLTrn)
    
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "S", "opcion", ""
    PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@o_fechora", 1, SQLVARCHAR, 0, "Fechora", ""
    PMPasoValoresATX VGSqlConn, "@o_feccontable", 1, SQLVARCHAR, 0, "Feccontable", ""
    PMPasoValoresATX VGSqlConn, "@o_secuencial", 1, SQLINT4, 0, "Secuencial", ""
    
    If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_tr_municipio_recaudacion", True, "Transaccion Ok", "S", "N", "N", "19", "S", "S") = True Then
        VLFecHora = FMRetParamATX(VGSqlConn, 1)
        VLFecContable = FMRetParamATX(VGSqlConn, 2)
        VLSsn = FMRetParamATX(VGSqlConn, 3)
        If Len(Trim$(VLSsn)) > 6 Then
            VLSsn = Right$(Trim$(VLSsn), 6)
        Else
            VLSsn = String(6 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
        End If
        PMChequeaATX VGSqlConn
        PMTotalesBranch "19"
        FLConsultar = True
        VLCambio% = False
        'TPE ------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 3)
        VTIndicadorSum = 1
        PMIniciaRegSum
        '<-----
    Else
        VLCambio% = True
        FLConsultar = False
        'TPE ------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 3)
        VTIndicadorSum = 0
        PMChequeaATX VGSqlConn
        PMFinTransaccion
        Exit Function
        '<------
    End If
    PMChequeaATX VGSqlConn
    If FMRetStatusATX(VGSqlConn) <> 0 Then
        VTIndicadorSum = 0
        FLConsultar = False
        PMFinTransaccion
        Exit Function
    End If
    PMFinTransaccion
    
    '-->hy-muncue
    Select Case Trim$(municipio.Text)
    Case "1433"
        'If Not FLTramaSwitch("C") Then
        If Not FLTransmitir_CPS_MUNGYE_consulta() Then
            FLConsultar = False
            Exit Function
        End If
    Case "1417"
        If Not FLTramaSwitch_MQ("C") Then
            FLConsultar = False
            Exit Function
        End If
    Case "1800"
        'If Not FLTransmitir_CPS_MUNCUE_consulta() Then
        If Not FLTransmitir_CSP_MUNCUE_consulta() Then ' ame 06/24/2010
            FLConsultar = False
            Exit Function
        End If
    End Select
    
    'If Trim$(municipio.Text) = "1433" Then  'Si es municipio de guayaquil
    '    If Not FLTramaSwitch("C") Then
    '        FLConsultar = False
    '        Exit Function
    '    End If
    'Else
    '    If Not FLTramaSwitch_MQ("C") Then
    '        FLConsultar = False
    '        Exit Function
    '    End If
    'End If
    '<--hy-muncue
    
        'Exit Function  hy-14-agosto-2006
    'End If  hy-14-agosto-2006
    '<--hy-15-feb-2006
End Function

Sub Efe_KeyPress(KeyAscii As Integer)
    KeyAscii = FMValidarNumero((efe.Text), VGLongitudMoney, KeyAscii, "19")     'RCO 04/99'
End Sub

Sub Efe_KeyDown(KeyCode As Integer, Shift As Integer)
    Select Case KeyCode%
    Case CGTeclaSUPR%
        efe.Text = ""
    Case CGTeclaENTER%
        SendKeys "{TAB}"
    Case CGTeclaMAS%
        efe.Text = FMCalculadora(FMObtenerTitulo("19") + "Efectivo:", 14, "19")
        SendKeys "{TAB}"
    Case CGTeclaPOR%
        efe.Text = FMSumadora(FMObtenerTitulo("19") + "Efectivo:", 14, "19")
    Case CGTeclaHOME%
        PMCambiarForma Me
    Case CGTeclaUP%, CGTeclaREPAG%
        Tipo.SetFocus
    Case CGTeclaDOWN%, CGTeclaAVPAG%
        SendKeys "{TAB}"
    End Select
End Sub

Sub Efe_LostFocus()
    If SGActivaSum = True Then
        Exit Sub
    End If
  
    If VGDecimales$ = "S" And (FMObtenerDecimales(FMObtenerMonedaForma("19")) > 0) Then
        efe.Text = str(FMCCurATX((efe.Text)) / FMObtenerFactorDecimal(FMObtenerMonedaForma("19")))
    End If
  
    If VGTotalizar$ = "S" Then
        If efe.Text <> "" Or efe.Text <> "0.00" Then
            valor.Text = str(FMCCurATX((efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((Ntcr.Text)) + FMCCurATX((EfeCob.Text)) + FMCCurATX((mhNCReal.Text)))   'VIVI
        End If
    End If
    
    'Sumadora ------>
    If CDbl(efe.Text) <> SGUsar Then
        MsgBox "El Monto Efetivo No Coincide con el Monto Desglosado para el Deposito. Verificar", vbCritical, "Mensaje del Sistema"
                FSumIng.abrirAltaDenominacion = True
        PMIngresoEfectivo
        efe.Text = Format$(SGUsar, "####,###,##0.00")
        SGActual = 0
    End If
    SGActivaSum = False
    '<------
End Sub



Private Sub municipio_Change()
    VLPaso% = False
    VLCambio% = True
End Sub

Private Sub municipio_GotFocus()
    VLFlagFoco = True
    FPrincipal!pnlHelpLine.Caption = "F5 Detalle de municipios"
End Sub

Private Sub municipio_KeyDown(KeyCode As Integer, Shift As Integer)
    Select Case KeyCode%
    Case CGTeclaSUPR%
        Tipo.Text = ""
    Case CGTeclaUP%, CGTeclaREPAG%
        KeyCode = 0
    Case CGTeclaDOWN%, CGTeclaAVPAG%
        SendKeys "{TAB}"
    End Select
End Sub

Private Sub Valor_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Ingrese Valor Total"
End Sub

Sub Cheques_KeyPress(KeyAscii As Integer)
    KeyAscii = FMValidarNumero((Cheques.Text), VGLongitudMoney, KeyAscii, "19")
End Sub

Sub Cheques_KeyDown(KeyCode As Integer, Shift As Integer)
    Select Case KeyCode%
    Case CGTeclaSUPR%
        Cheques.Text = ""
    Case CGTeclaENTER%
        SendKeys "{TAB}"
    Case CGTeclaMAS%
        Cheques.Text = FMCalculadora(FMObtenerTitulo("19") + "Cheques Locales:", 14, "19")
        SendKeys "{TAB}"
    Case CGTeclaPOR%
        Cheques.Text = FMSumadora(FMObtenerTitulo("19") + "Cheques Locales:", 14, "19")
    Case CGTeclaHOME%
        PMCambiarForma Me
    Case CGTeclaUP%, CGTeclaREPAG%
        efe.SetFocus
    Case CGTeclaDOWN%, CGTeclaAVPAG%
        SendKeys "{TAB}"
    End Select
End Sub

Sub Cheques_LostFocus()
    If VGDecimales$ = "S" And (FMObtenerDecimales(FMObtenerMonedaForma("19")) > 0) Then
        Cheques.Text = str(FMCCurATX((Cheques.Text)) / FMObtenerFactorDecimal(FMObtenerMonedaForma("19")))
    End If
    If VGTotalizar$ = "S" Then
        If Cheques.Text <> "" Or Cheques.Text <> "0.00" Then
            valor.Text = str(FMCCurATX((efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((Ntcr.Text)) + FMCCurATX((EfeCob.Text)) + FMCCurATX((mhNCReal.Text)))
        End If
    End If
End Sub

Private Sub municipio_LostFocus()
    VLFlagFoco = False
    

   '-->lfcm 08-junio-2009 MiLote
   If Me.municipio.Text <> "" Then
      Agno.Left = 1440
      Etiqueta5.Visible = True
      Etiqueta6.Visible = True
      Etiqueta8.Visible = True
      Predio.Visible = True
      Impto.Visible = True
      Semestre.Visible = True
      Etiqueta7.Caption = "Año:"
      Contribuyente.Height = 285
      txtLlaveMunicipal.Top = 555 ' ame 06/30/2010
      Etiqueta2.Top = 555 ' ame 06/30/2010
      Etiqueta3.Top = 880 ' ame 06/30/2010
      Tipo.Top = 880 ' ame 06/30/2010
      sal_tipo.Top = 880 ' ame 06/30/2010
      descripcion.Visible = False ' ame 06/30/2010
   End If
   '--<lfcm 08-junio-2009 MiLote
    
    
    
    '-->hy-30-ene-2006
    Select Case Trim$(municipio.Text)
    Case "1417", "1800"  'hy-22-febrero-2007 agregar 1800
        '-->hy-22-febrero-2007
        If Trim$(municipio.Text) = "1417" Then
            Tipo.TableName = "sv_impto_mun"
        Else
            Tipo.TableName = "sv_impto_muncue"
        End If
        '<--hy-22-febrero-2007
        '-->hy-14-agosto-2006
        'Etiqueta2.Caption = "C.I./RUC/PAS/OTROS"
        If Trim$(municipio.Text) = "1417" Then        'hy-22-febrero-2007
            Etiqueta2.Caption = "No.PREDIO/PATENTE/VARIOS"
        Else                                          'hy-22-febrero-2007
            'Etiqueta2.Caption = "CLAVE CATASTRAL"     'hy-22-febrero-2007
            'ame 06/30/2010
            If Tipo.Text = "003" Then
               Etiqueta2.Caption = "Céd./RUC:"
            Else
               Etiqueta2.Caption = "CLAVE CATASTRAL:"
            End If
            Etiqueta3.Top = 555
            Tipo.Top = 555
            sal_tipo.Top = 555
            txtLlaveMunicipal.Top = 880 ' ame 06/30/2010
            Etiqueta2.Top = 880 ' ame 06/30/2010
        End If                                        'hy-22-febrero-2007
        'Etiqueta2.Visible = True 'hy-21-diciembre-2006 [pase rezagado]
        '<--hy-14-agosto-2006
        Etiqueta3.Caption = "TIPO IMPUESTO"
        Tipo.Visible = True
        sal_tipo.Visible = True
        cat1.Visible = False
        cat2.Visible = False
        cat3.Visible = False
        cat4.Visible = False
        cat5.Visible = False
        cat6.Visible = False
        '-->lfcm 29-octubre-2008
        cat1.Top = 880
        cat2.Top = 880
        cat3.Top = 880
        cat4.Top = 880
        cat5.Top = 880
        cat6.Top = 880
        ' ame 06/30/2010 Etiqueta3.Top = 880
        '--<lfcm 29-octubre-2008
        
        Etiqueta5.Visible = True
        Etiqueta6.Visible = True
        Predio.Visible = True
        Impto.Visible = True
        Etiqueta8.Visible = False  'hy-14-agosto-2006 antes true
        Semestre.Visible = False  'hy-14-agosto-2006 antes true
        txtCatasSamb.Visible = False 'GAMC - 23/02/2008
        Me.claveCatastral.Visible = False 'GAMC - 05/03/2008
        Etiqueta2.Visible = True 'GAMC - 23/02/2008
        Agno.Left = 1440
        Contribuyente.Height = 285
        cedula.Left = 2880  'hy-14-agosto-2006
        Select Case Trim$(municipio.Text)       'hy-22-febrero-2007
        Case "1417"                             'hy-22-febrero-2007
            cedula.Visible = True 'hy-21-diciembre-2006 [pase rezagado]
            cedula.SetFocus  'hy-21-diciembre-2006 [pase rezagado]
            txtLlaveMunicipal.Visible = False   'hy-22-febrero-2007
            Etiqueta5.Caption = "Predio / patente" ' ame 06/30/2010
            
            'msilvag Migracion WebSevice Municipio CEP
            Me.cedula.Top = 555
            Me.CEP.Visible = False
            Me.txtTipoConsulta.Visible = False
            Me.lblTipoConsulta.Visible = False
            Me.Tipo.Text = ""
            Me.sal_tipo.Caption = ""
            Me.CEP.Visible = False
            'msilvag Fin
        Case "1800"                             'hy-22-febrero-2007
            cedula.Visible = False              'hy-22-febrero-2007
            txtLlaveMunicipal.Visible = True    'hy-22-febrero-2007
            'txtLlaveMunicipal.SetFocus         ' ame 06/30/2010
            txtLlaveMunicipal.Top = 880         ' ame 06/30/2010
            Etiqueta5.Caption = "Impto./Rubro:" ' ame 06/30/2010
            Etiqueta7.Caption = "Año/Dividendo:" ' ame 06/30/2010
            Agno.Left = 2010                     ' ame 06/30/2010
            Etiqueta6.Visible = False           ' ame 06/30/2010
            Impto.Visible = False               ' ame 06/30/2010
            Predio.Visible = False
            descripcion.Visible = True ' ame 06/30/2010
            descripcion.Width = 2295 ' ame 06/30/2010
            Tipo.SetFocus
            
            'msilvag Inicio Migracion WebService Municipio CEP
                Me.txtTipoConsulta.Visible = False
                Me.lblTipoConsulta.Visible = False
                Me.Tipo.Text = ""
                Me.sal_tipo.Caption = ""
                Me.CEP.Visible = False
            'msilvag Fin
        End Select                              'hy-22-febrero-2007
    Case "1433"
        Etiqueta2.Caption = "CEDULA/RUC"
        Etiqueta2.Visible = False 'lfcm 29-octubre-2008 hy-21-diciembre-2006 [pase rezagado]
        Etiqueta3.Caption = "Cod. Catastral"
        Tipo.Visible = False
        sal_tipo.Visible = False
        cat1.Visible = True
        cat2.Visible = True
        cat3.Visible = True
        cat4.Visible = True
        cat5.Visible = True
        cat6.Visible = True
        Etiqueta5.Visible = False
        Etiqueta6.Visible = False
        Etiqueta8.Visible = False
        Semestre.Visible = False
        Predio.Visible = False
        Impto.Visible = False
        Agno.Left = 2010
        Contribuyente.Height = 570
        cedula.Left = 1800  'hy-14-agosto-2006
        txtLlaveMunicipal.Visible = False  'hy-22-febrero-2007
        '-->hy-21-diciembre-2006 [pase rezagado]
        txtCatasSamb.Visible = False 'GAMC - 23/02/2008
        Me.claveCatastral.Visible = False 'GAMC - 05/03/2008
        'Etiqueta2.Visible = True 'GAMC - 23/02/2008      'lfcm 29-octubre-2008
        'cedula.Visible = True    'lfcm 29-octubre-2008
        cedula.Visible = False    'lfcm 29-octubre-2008
        'cedula.SetFocus          'lfcm 29-octubre-2008
        Etiqueta3.Top = 700       'lfcm 29-octubre-2008
        txtcat1.Top = 700         'lfcm 29-octubre-2008
        cat1.Top = 700            'lfcm 29-octubre-2008
        cat2.Top = 700            'lfcm 29-octubre-2008
        cat3.Top = 700            'lfcm 29-octubre-2008
        cat4.Top = 700            'lfcm 29-octubre-2008
        cat5.Top = 700            'lfcm 29-octubre-2008
        cat6.Top = 700            'lfcm 29-octubre-2008
        cat1.SetFocus             'lfcm 29-octubre-2008
        '<--hy-21-diciembre-2006 [pase rezagado]
    '-->hy-05-noviembre-2007
    Case "2234"
        Etiqueta2.Caption = "CEDULA/RUC/PAS"
        Etiqueta3.Caption = "Impuesto"
        Tipo.TableName = "sv_impto_mibarra"
        Tipo.Visible = True
        sal_tipo.Visible = True
        cat1.Visible = False
        cat2.Visible = False
        cat3.Visible = False
        cat4.Visible = False
        cat5.Visible = False
        cat6.Visible = False
        '-->lfcm 29-octubre-2008
        cat1.Top = 880
        cat2.Top = 880
        cat3.Top = 880
        cat4.Top = 880
        cat5.Top = 880
        cat6.Top = 880
        Etiqueta3.Top = 880
        '--<lfcm 29-octubre-2008
        Etiqueta5.Visible = True
        Etiqueta6.Visible = True
        Etiqueta8.Visible = True
        Semestre.Visible = True
        Predio.Visible = True
        Impto.Visible = True
        Agno.Left = 1440
        Contribuyente.Height = 285
        cedula.Left = 1800
        cedula.Visible = True
        txtCatasSamb.Visible = False 'GAMC - 23/02/2008
        Me.claveCatastral.Visible = False 'GAMC - 05/03/2008
        Etiqueta2.Visible = True 'GAMC - 23/02/2008
        cedula.SetFocus
    '<--hy-05-noviembre-2007
    
        'msilvag Inicio Migracion WebService Municipio CEP
        Me.txtTipoConsulta.Visible = False
        Me.lblTipoConsulta.Visible = False
        Me.Tipo.Text = ""
        Me.sal_tipo.Caption = ""
        Me.cedula.Top = 555
        Me.CEP.Visible = False
        'msilvag Fin
    Case "2319"
        'GAMC - 23/02/2008 - SAMBORONDOM
        Call Muni_2319("1")
        
        'msilvag Inicio Migracion WebService Municipio CEP
        Me.txtTipoConsulta.Visible = False
        Me.lblTipoConsulta.Visible = False
        Me.Tipo.Text = ""
        Me.sal_tipo.Caption = ""
        Me.CEP.Visible = False
        'msilvag Fin
    Case "2237"
        'GAMC - 05/03/2008 - SAMBORONDOM
        Call Muni_2237("1", 0)
        
        'msilvag Inicio Migracion WebService Municipio CEP
        Me.txtTipoConsulta.Visible = False
        Me.lblTipoConsulta.Visible = False
        Me.Tipo.Text = ""
        Me.sal_tipo.Caption = ""
        Me.CEP.Visible = False
        'msilvag Fin
    Case "2235"
        'GAMC - 05/03/2008 - SANTA ELENA
        Call Muni_2235("1", 0)
        
        'msilvag Inicio Migracion WebService Municipio CEP
        Me.txtTipoConsulta.Visible = False
        Me.lblTipoConsulta.Visible = False
        Me.Tipo.Text = ""
        Me.sal_tipo.Caption = ""
        Me.CEP.Visible = False
        'msilvag Fin
    Case "2236" 'Wise se Agrego 2236=Munic. Libertad 13/Agt/2008
        Call Muni_2236("1", 0)
        
        'msilvag Inicio Migracion WebService Municipio CEP
        Me.txtTipoConsulta.Visible = False
        Me.lblTipoConsulta.Visible = False
        Me.Tipo.Text = ""
        Me.sal_tipo.Caption = ""
        Me.CEP.Visible = False
        'msilvag Fin
    Case "1430"
        'nchavezb - 04/Agosto/2011 - Municipio Daule
        Call Muni_1430("1", 0)
        
        'msilvag Inicio Migracion WebService Municipio CEP
        Me.txtTipoConsulta.Visible = False
        Me.lblTipoConsulta.Visible = False
        Me.Tipo.Text = ""
        Me.sal_tipo.Caption = ""
        Me.CEP.Visible = False
        'msilvag Fin
   '-->lfcm 08-junio-2009 MiLote
   Case "1434"    'MI LOTE
      'Parte Superior de la Pantalla
      Me.Etiqueta2.Visible = True
      Me.Etiqueta2.Caption = "No. Cédula: "
      Me.Etiqueta3.Caption = ""
      Me.claveCatastral.Visible = False
      Me.txtCatasSamb.Visible = False
      Me.Tipo.Visible = False
      Me.sal_tipo.Visible = False
      Me.cedula.Left = 1800
      Me.cedula.Visible = True
      Me.txtcat1.Visible = False
      Me.cat1.Visible = False
      Me.cat2.Visible = False
      Me.cat3.Visible = False
      Me.cat4.Visible = False
      Me.cat5.Visible = False
      Me.cat6.Visible = False
      Me.txtLlaveMunicipal.Visible = False
      Me.Tarjeta.Enabled = False
      
      'Parte Previa a Formas de Pago
      Me.Agno.Left = 2010
      Etiqueta5.Visible = False
      Etiqueta6.Visible = False
      Etiqueta8.Visible = False
      Predio.Visible = False
      Impto.Visible = False
      Semestre.Visible = False
      Etiqueta7.Caption = "No. Cuota:"
      Contribuyente.Height = 570
   '--<lfcm 08-junio-2009 MiLote
    Case "1435" 'nchavezb 02/03/2011 Municipio por Pago de Mercados y Credenciales
    'Parte Superior de la Pantalla
      Me.Etiqueta2.Visible = True
      Me.Etiqueta3.Visible = True
      Me.Etiqueta3.Caption = "No. Cédula: "
      Me.Etiqueta2.Caption = "Tipo de Consulta"
      
      Tipo.TableName = "sv_impto_mungye"
      Tipo.Visible = True
      Me.Tipo.Top = 555
      Me.Tipo.SetFocus
      Me.sal_tipo.Visible = True
      Me.sal_tipo.Top = 555
      Me.cedula.Left = 1800
      Me.cedula.Top = 880
      Me.cedula.Visible = True
      Me.cedula.TabIndex = 3
      Me.cat1.Visible = False
      Me.cat2.Visible = False
      Me.cat3.Visible = False
      Me.cat4.Visible = False
      Me.cat5.Visible = False
      Me.cat6.Visible = False
      
       'Parte Previa a Formas de Pago
      Me.Agno.Left = 2010
      Etiqueta5.Visible = False
      Etiqueta6.Visible = False
      Etiqueta8.Visible = False
      Predio.Visible = False
      Impto.Visible = False
      Semestre.Visible = False
      Etiqueta7.Caption = "No. Abono:"
      Contribuyente.Height = 570
      CantChq.Enabled = True
    Case "7749" 'smerinom  Municipio de guayaquil->CEP
    'Parte Superior de la Pantalla
      Me.Etiqueta2.Visible = True
      Me.Etiqueta3.Visible = True
      Me.Etiqueta3.Caption = "Cód. CEP: "
      Me.Etiqueta2.Caption = "Tipo de Impuesto"
      Me.claveCatastral.Visible = False
      
      txtLlaveMunicipal.Visible = False
      
      Tipo.TableName = "sv_impto_mungye_ce"
      Tipo.Visible = True
      Me.Tipo.Top = 555
      If VGTipoEjecucion <> CGReverso Then
        Me.Tipo.SetFocus
      End If
      Me.sal_tipo.Visible = True
      Me.sal_tipo.Top = 555
      'Me.Cedula.Left = 1800
      'Me.Cedula.Top = 880
     ' Me.Cedula.Visible = True
     ' Me.Cedula.TabIndex = 3
      Me.cedula.Visible = False
      Me.CEP.Left = 1800
      Me.CEP.Top = 880
      Me.CEP.Visible = True
      Me.CEP.TabIndex = 5
      'Me.CEP.SetFocus
      
     
      Me.cat1.Visible = False
      Me.cat2.Visible = False
      Me.cat3.Visible = False
      Me.cat4.Visible = False
      Me.cat5.Visible = False
      Me.cat6.Visible = False
      
       'Parte Previa a Formas de Pago
      Me.Agno.Left = 2010
      Me.Agno.Width = 2295
      Etiqueta5.Visible = False
      Etiqueta6.Visible = False
      Etiqueta8.Visible = False
      Predio.Visible = False
      Impto.Visible = False
      Semestre.Visible = False
      Etiqueta7.Caption = "Descripción del CEP"
      Contribuyente.Height = 570
      Me.Agno.Height = 500
      CantChq.Enabled = True
       Me.CEP.TabIndex = 5
       
    End Select
    '<--hy-30-ene-2006
End Sub

Private Sub Tarjeta_Change()
    VLCambio% = True
End Sub

Private Sub Tarjeta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Ingrese el Valor de la tarjeta de crédito"
End Sub

Private Sub Tarjeta_KeyDown(KeyCode As Integer, Shift As Integer)
    Select Case KeyCode%
    Case CGTeclaSUPR%
        Tarjeta.Text = ""
    Case CGTeclaENTER%
        SendKeys "{TAB}"
    Case CGTeclaMAS%
        Tarjeta.Text = FMCalculadora(FMObtenerTitulo("104") + "Tarjeta:", 14, "104")
        SendKeys "{TAB}"
    Case CGTeclaPOR%
        Tarjeta.Text = FMSumadora(FMObtenerTitulo("104") + "Tarjeta:", 14, "104")
    Case CGTeclaHOME%
        PMCambiarForma Me
    Case CGTeclaUP%, CGTeclaREPAG%
        Total.SetFocus
    Case CGTeclaDOWN%, CGTeclaAVPAG%
        SendKeys "{TAB}"
    End Select
    'TPE Activo bandera para mostrar Sumadora
    SGActivaSum = False
End Sub

Private Sub Tarjeta_KeyPress(KeyAscii As Integer)
    KeyAscii = FMValidarNumero((Tarjeta.Text), VGLongitudMoney, KeyAscii, "104")
End Sub

Private Sub Tarjeta_LostFocus()
    If VGDecimales$ = "S" And (FMObtenerDecimales(FMObtenerMonedaForma("104")) > 0) Then
        Tarjeta.Text = str(FMCCurATX((Tarjeta.Text)) / FMObtenerFactorDecimal(FMObtenerMonedaForma("104")))
    End If
    
    'pricaura REF_04 INI 20190621
    If Tarjeta.Text > 0 And consultarParametroCte("FCCTC") = "S" Then
        Comision.Text = 0
    Else
        Comision.Text = VGComision_original
    End If
    Total.Text = CDbl(ValorMun.Text) + CDbl(Comision.Text)
    'pricaura REF_04 INI 20190621
    
End Sub

Private Sub tipo_GotFocus()
    VLFlagFoco = True
    FPrincipal!pnlHelpLine.Caption = "F5 Detalle de tipo de impuestos"
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

Function FLChequeos() As Integer
    On Error GoTo error 'GAMC - 18/03/2008
    FLChequeos = False
    '-->lfcm 13-febrero-2009
    'If VGTipoEjecucion = CGReverso Then
    '    If Trim$(municipio.Text) = "1433" Then
    '        If Trim$(VLHoraReversar) = "" Then
    '            MsgBox "Error en parámetros de reversa, intentelo nuevamente", vbCritical, "Error"
    '            Exit Function
    '        End If
    '    End If
    'End If
    '-->lfcm 13-febrero-2009
    If Trim(Contribuyente.Caption) = "" Then
        MsgBox "Es necesario seleccionar un registro para pagar"
        Exit Function
    End If
    If Cta.ClipText <> "" And Debito.ValueReal = 0 Then
        MsgBox "El campo Debito: es Mandatorio"
        Debito.SetFocus
        Exit Function
    End If
    If CInt(CantChq.Text) <> 0 And Cheques.ValueReal = 0 Then
        MsgBox "Verifique el Campo Valor en Cheque"
        Cheques.SetFocus
        Exit Function
    End If
    
    'msilvag RECA-CC-SGC00030409 - Facturacion OffLine Debitos
    If FCC19.Cta.ClipText <> "" Then
        If VLDeb_com > 0 And FCC19.Cta.ClipText <> VLCta_com Then
            MsgBox "La cuenta de la comision debe ser la misma con la que realiza el pago del servicio."
            Comision.SetFocus
            FLChequeos = False
            Exit Function
        End If
    End If
    'msilvag Fin
    
    '-->hy-30-ene-2006.
    If VLTotCom <> FMCCurATX((Comision.Text)) Then   ' ps 28/01/2004
        MsgBox "Verifique el Campo Valor de Comision"
        Comision.SetFocus
        FLChequeos = False
        Exit Function
    End If
    '<--hy-30-ene-2006
    If VGTotalizar$ = "N" Then
        If Format(Total.Text, "###,###,###,##0.00") <> Format(FMCCurATX((efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((Debito.Text)) + FMCCurATX((Tarjeta.Text)) + FMCCurATX((Comision.Text)), "###,###,###,##0.00") Then
            MsgBox " El campo Total no cuadra"
            If Total.Enabled = True Then
                Total.SetFocus
            End If
            Exit Function
        End If
    End If
    '-->hy-30-ene-2006
      
   '-->lfcm 01-julio-2009
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
   '-->lfcm 01-julio-2009

    
    'Comentar
    'If Format(Total.Text, "###,###,###,##0.00") <> Format(ValorMun.Text, "###,###,###,##0.00") Then
    '    MsgBox "El valor es distinto al que indica el municipio"
    '    Exit Function
    'End If
    '<--hy-30-ene-2006
    FLChequeos = True
    Exit Function   'GAMC - 18/03/2008
error:  'GAMC - 18/03/2008
FLChequeos = False  'GAMC - 18/03/2008
End Function

Sub Tipo_Change()
    VLPaso% = False
    VLCambio% = True
End Sub

Sub Efe_Change()
    VLCambio% = True
End Sub

Sub Cheques_Change()
    VLCambio% = True
End Sub

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
        Cta.SetFocus
    End Select
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
Dim VTTipoDatoCta As StructDatoCta  'hy-05-noviembre-2007

    VLfirma = FMValidaFirma(VLfirma, CboTipCta.Text, Cta, "19", Nombre, VLMoneda, VLDescMonCta)
    lblMoneda.Caption = VLDescMonCta
    
    '-->hy-05-noviembre-2007
    'If Trim$(municipio.Text) = "2234" Then
    If Trim$(municipio.Text) = "2234" Or Trim$(municipio.Text) = "2236" Or Trim$(municipio.Text) = "1800" Or Trim$(municipio.Text) = "1435" Or Trim$(municipio.Text) = "7749" Then   'Wise M. Libertad=2236 19/Agt/2008
        VTTipoDatoCta = LoNombreCta(CboTipCta.Text, Cta.ClipText, "19")
        Nombre.Text = VTTipoDatoCta.NombreCta
    End If
    '<--hy-05-noviembre-2007
    
    If VLfirma = True Then
        Debito.Enabled = True
        Debito.SetFocus
    End If
End Sub

Sub Debito_Change()
    VLCambio% = True
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

Private Sub tipo_LostFocus()
    VLFlagFoco = False
    Tipo.Text = UCase$(Trim$(Tipo.Text))
    If Trim$(municipio.Text) = "1800" Then
        If Tipo.Text = "003" Then
           Etiqueta2.Caption = "Céd./RUC:"
        Else
           Etiqueta2.Caption = "CLAVE CATASTRAL:"
        End If
        
    End If
    
    'msilvag Inicio Migracion WebService Febrero-10-2016
    If Me.municipio.Text = "7749" Then
        
        If Me.Tipo.Text = "001" Then    'Predios
            Etiqueta3.Caption = "Cod. Catastral"
            Etiqueta3.Top = 880
            Me.CEP.Visible = False
            Me.sal_tipo.Visible = True
            Me.sal_tipo.Top = 555
            
            cat1.Visible = True
            cat2.Visible = True
            cat3.Visible = True
            cat4.Visible = True
            cat5.Visible = True
            cat6.Visible = True
            Etiqueta5.Visible = False
            Etiqueta6.Visible = False
            Etiqueta8.Visible = False
            Semestre.Visible = False
            Predio.Visible = False
            Impto.Visible = False
            Agno.Left = 2010
            Me.Agno.Visible = True
            Contribuyente.Height = 570
            cedula.Left = 1800
            txtLlaveMunicipal.Visible = False
            Etiqueta7.Caption = "Anio Vigencia"
            
            txtCatasSamb.Visible = False
            Me.claveCatastral.Visible = False
           
            cedula.Visible = False
          
            Etiqueta3.Top = 880
            txtcat1.Top = 880
            cat1.Top = 880
            cat2.Top = 880
            cat3.Top = 880
            cat4.Top = 880
            cat5.Top = 880
            cat6.Top = 880
            cat1.SetFocus
            
            Me.Label5.Visible = False
            Me.txtTipoConsulta.Visible = False
            Me.lblTipoConsulta.Visible = False
        ElseIf Me.Tipo.Text = "002" Then   'Mi lote
            Me.Etiqueta3.Caption = "No. Cédula: "
            Me.claveCatastral.Visible = False
            Me.txtCatasSamb.Visible = False
            Me.CEP.Visible = False
            
            Me.cedula.Left = 1800
            Me.cedula.Visible = True
            Me.cedula.Top = 880
            Me.txtcat1.Visible = False
            Me.cat1.Visible = False
            Me.cat2.Visible = False
            Me.cat3.Visible = False
            Me.cat4.Visible = False
            Me.cat5.Visible = False
            Me.cat6.Visible = False
            Me.txtLlaveMunicipal.Visible = False
            Me.Tarjeta.Enabled = False
            
            Me.Agno.Left = 2010
            Etiqueta5.Visible = False
            Etiqueta6.Visible = False
            Etiqueta8.Visible = False
            Predio.Visible = False
            Impto.Visible = False
            Semestre.Visible = False
            Etiqueta7.Caption = "No. Cuota:"
            Contribuyente.Height = 570
            cedula.SetFocus
            
            Me.Label5.Visible = False
            Me.txtTipoConsulta.Visible = False
            Me.lblTipoConsulta.Visible = False
        ElseIf Me.Tipo.Text = "003" Then  'Mercados
        
            Me.Etiqueta2.Visible = True
            Me.Etiqueta3.Visible = True
            Me.Etiqueta3.Caption = "No. Cédula: "
            'Me.Etiqueta2.Caption = "Tipo de Consulta"
            Me.CEP.Visible = False
            Tipo.Visible = True
            Me.Tipo.Top = 555
            'Me.Tipo.SetFocus
            
            Me.txtTipoConsulta.TableName = "sv_impto_mungye"
            Me.Label5.Visible = True
            Me.txtTipoConsulta.Visible = True
            Me.lblTipoConsulta.Visible = True
            Me.Label5.Top = 880
            Me.txtTipoConsulta.Top = 880
            Me.lblTipoConsulta.Top = 880
            Me.Label5.Caption = "Tipo de Consulta"
            
            Me.sal_tipo.Visible = True
            Me.sal_tipo.Top = 555
            Me.cedula.Left = 1800
            Me.cedula.Top = 1200 '880
            Me.cedula.Visible = True
            Me.Etiqueta3.Top = 1200
            'Me.cedula.TabIndex = 3
            'Me.Cedula.SetFocus
            Me.cat1.Visible = False
            Me.cat2.Visible = False
            Me.cat3.Visible = False
            Me.cat4.Visible = False
            Me.cat5.Visible = False
            Me.cat6.Visible = False
            
            'Parte Previa a Formas de Pago
            Me.Agno.Left = 2010
            Etiqueta5.Visible = False
            Etiqueta6.Visible = False
            Etiqueta8.Visible = False
            Predio.Visible = False
            Impto.Visible = False
            Semestre.Visible = False
            Etiqueta7.Caption = "No. Abono:"
            Contribuyente.Height = 570
            CantChq.Enabled = True
            
            Me.municipio.TabIndex = 0
            Me.Tipo.TabIndex = 1
            Me.txtTipoConsulta.TabIndex = 2
            Me.cedula.TabIndex = 3
            
            'cedula.SetFocus
            Me.txtTipoConsulta.SetFocus
        ElseIf Me.Tipo.Text = "004" Then  'Codigo Electronio de Pago CEP
            Me.Etiqueta2.Visible = True
            Me.Etiqueta3.Visible = True
            Me.Etiqueta3.Caption = "Cód. CEP: "
            
            Me.sal_tipo.Visible = True
            Me.sal_tipo.Top = 555
           
            Me.cedula.Visible = False
            Me.CEP.Left = 1800
            Me.CEP.Top = 880
            Me.CEP.Visible = True
            Me.CEP.TabIndex = 5
            
            Me.cat1.Visible = False
            Me.cat2.Visible = False
            Me.cat3.Visible = False
            Me.cat4.Visible = False
            Me.cat5.Visible = False
            Me.cat6.Visible = False
            
            'Parte Previa a Formas de Pago
            Me.Agno.Left = 2010
            Me.Agno.Width = 2295
            Etiqueta5.Visible = False
            Etiqueta6.Visible = False
            Etiqueta8.Visible = False
            Predio.Visible = False
            Impto.Visible = False
            Semestre.Visible = False
            Etiqueta7.Caption = "Descripción del CEP"
            Contribuyente.Height = 570
            Me.Agno.Height = 500
            CantChq.Enabled = True
            Me.CEP.TabIndex = 5
            
            Me.Label5.Visible = False
            Me.txtTipoConsulta.Visible = False
            Me.lblTipoConsulta.Visible = False
        End If
    End If
    'msilvag Fin
End Sub

Function FLTramaSwitch(VLTipo As String) As Boolean
On Error GoTo Etiqueta_Error
    Dim VLTramaEnvio As String
    Dim VLTramaRetorno As String
    Dim VLCodRetorno As String
    Dim VLCodRetornoInd As String
    Dim VLValorPagar As String
    Dim VLSSNREV As String
    Dim VLLongitud As Integer
    Dim VLFila As Integer
    Dim VLColumna As Integer
    Dim VLColInicio As Integer
    Dim VLFlagExiste As Boolean
    Dim VLItems As Integer
    'VLTipo
    'C=Consulta
    'P=Pago
    'R=Reversa normal
    
    FLTramaSwitch = False
    'Armar y lanzar la trama de pago al sri
    Select Case VLTipo
    '*****************************************************************
    '*****************************************************************
    '*************** C O N S U L T A *********************************
    '*****************************************************************
    '*****************************************************************
    Case "C"
        'Bloquear controles
        'Matricula.Enabled = False
        'Arma trama
        VLTramaEnvio = "006          "
        VLTramaEnvio = VLTramaEnvio + VLFecHora 'Fecha y hora real aaaammddhhmmsscc
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2) 'Fecha contable
        VLTramaEnvio = VLTramaEnvio + "006200C00"
        VLTramaEnvio = VLTramaEnvio + "00" + VLSsn 'SSN
        VLTramaEnvio = VLTramaEnvio + "N00000000"
        VLTramaEnvio = VLTramaEnvio + String(3 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) 'Oficina
        VLTramaEnvio = VLTramaEnvio + Trim$(VGUsuario) + String(10 - Len(Trim$(VGUsuario)), " ") 'Usuario
        VLTramaEnvio = VLTramaEnvio + "0200A23A0001888090000000000001FF0000"
        VLTramaEnvio = VLTramaEnvio + "310003"  'Transaccion de consulta
        VLTramaEnvio = VLTramaEnvio + "00000000000000000000"  'Fecha hora y secuencial de banred
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecHora, 9, 6)
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2)
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2)
        VLTramaEnvio = VLTramaEnvio + "06597777"  'Institucion adquiriente
        VLTramaEnvio = VLTramaEnvio + String(6 - Len(Trim$(VGUsuario)), "0") + VGUsuario  'Codigo del operador
        VLTramaEnvio = VLTramaEnvio + VLSsn 'SSN
        ' ame 02/28/2012VLTramaEnvio = VLTramaEnvio + "1007"  'Número de terminal 1007
        VLTramaEnvio = VLTramaEnvio + "0233"  'Número de terminal 1007
        VLTramaEnvio = VLTramaEnvio + String(6 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina))  'Número de terminal codigo de oficina
        VLTramaEnvio = VLTramaEnvio + Mid$(VGterminal, 1, 6) 'Número de terminal codigo de terminal
        VLTramaEnvio = VLTramaEnvio + "840"  'Código de moneda
        VLTramaEnvio = VLTramaEnvio + "0010031003"  'Producto
        VLLongitud = Len(Trim$(cat1.ClipText))
        If VLLongitud = 1 Then
            VLLongitud = 2
        End If
        VLTramaEnvio = VLTramaEnvio + String(2 - Len(Trim$(str$(VLLongitud))), "0") + Trim$(str$(VLLongitud))
        VLTramaEnvio = VLTramaEnvio + String(VLLongitud - Len(Trim$(cat1.ClipText)), "0") + Trim$(cat1.ClipText)
        VLTramaEnvio = VLTramaEnvio + "04" + String(4 - Len(Trim$(cat2.ClipText)), "0") + Trim$(cat2.ClipText)  'Manzana
        VLTramaEnvio = VLTramaEnvio + "03" + String(3 - Len(Trim$(cat3.ClipText)), "0") + Trim$(cat3.ClipText)  'Lote
        VLTramaEnvio = VLTramaEnvio + "04" + String(4 - Len(Trim$(cat4.ClipText)), "0") + Trim$(cat4.ClipText)  'Division
        VLTramaEnvio = VLTramaEnvio + "04" + String(4 - Len(Trim$(cat5.ClipText)), "0") + Trim$(cat5.ClipText)  'PHV
        VLTramaEnvio = VLTramaEnvio + "04" + String(4 - Len(Trim$(cat6.ClipText)), "0") + Trim$(cat6.ClipText)  'PHH
        VLTramaEnvio = VLTramaEnvio + "01" + "1"  'Número
        VLTramaEnvio = VLTramaEnvio + "04" + "9999"  'Año vigencia
        VLTramaEnvio = VLTramaEnvio + "01" + "3"  'Semestre
        VLLongitud = Len(Trim$(VLTramaEnvio)) + 4
        VLTramaEnvio = String(4 - Len(Trim$(str$(VLLongitud))), "0") + Trim$(str$(VLLongitud)) + VLTramaEnvio
        'Enviar trama
        Set objUpdate = CreateObject("UpLoadDll.LoadDllCobis")
        Debug.Print VLTramaEnvio
        With objUpdate
            Screen.MousePointer = 11
            .SendDataClient VGDatosConexionSRI.UpLoadIp, VGDatosConexionSRI.UpLoadPuerto, VGDatosConexionSRI.UpLoadTime, VLTramaEnvio, VLTramaRetorno
            '.SendDataClient "172.16.23.117", VGDatosConexionSRI.UpLoadPuerto, VGDatosConexionSRI.UpLoadTime, VLTramaEnvio, VLTramaRetorno
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
        VLCodRetorno = Mid$(VLTramaRetorno, 179, 2)
        If VLCodRetorno <> "00" Then
            PMInicioTransaccion
            PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "cl_errores_mimg", "", ""
            PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR&, "V", "", ""
            PMPasoValoresATX VGSqlConn&, "@i_codigo", 0, SQLCHAR&, Trim$(VLCodRetorno), "", ""
            If FMTransmitirRPCATX(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "", "N", "S", "I", "0", "N", "N") Then
                PMMapeaObjetoATX VGSqlConn&, txtMensaje
                MsgBox "(" + Trim$(VLCodRetorno) + ") " + txtMensaje, vbCritical, "MENSAJE DEL MUNICIPIO"
                PMChequeaATX VGSqlConn&
                PMFinTransaccion
            Else
                MsgBox "MENSAJE DE ERROR NO CATALOGADO EN EL BANCO", vbCritical, "ERROR"
                PMChequeaATX VGSqlConn&
                PMFinTransaccion
            End If
            Exit Function
        End If
        'Desglosa la trama y muestra el resultado
        VLContribuyente = Trim$(Mid$(VLTramaRetorno, 197, 35))
        Contribuyente.Caption = VLContribuyente
        
        'VLTopeMax = 0
        'For VLFila = 1 To 12
        '    For VLColumna = 1 To 3
        '        grdBloque.Row = VLFila
        '        grdBloque.Col = VLColumna
        '        grdBloque.Text = ""
        '    Next VLColumna
        'Next VLFila
        
        VLFlagExiste = False
        VLTopeMax = 0
        VLColInicio = 296  '256
        VLItems = val(Mid$(VLTramaRetorno, VLColInicio - 3, 3)) / 16
        If VLItems <> 0 Then
            grdBloque.Rows = VLItems + 1
            For VLFila = 1 To VLItems
                VLFlagExiste = True
                VLTopeMax = VLTopeMax + 1
                grdBloque.Row = VLTopeMax
                grdBloque.Col = 1
                grdBloque.Text = Trim$(Mid$(VLTramaRetorno, VLColInicio, 4))
                grdBloque.Col = 2
                grdBloque.Text = "0"
                grdBloque.Col = 3
                grdBloque.Text = CDbl(Trim$(Mid$(VLTramaRetorno, VLColInicio + 4, 12))) / 100
                VLColInicio = VLColInicio + 16
            Next VLFila
        End If
        If Not VLFlagExiste Then
            MsgBox "EL CODIGO CATASTRAL NO TIENE DEUDAS PENDIENTES", vbInformation, "Aviso"
        End If

    '*****************************************************************
    '*****************************************************************
    '*************** P A G O *****************************************
    '*****************************************************************
    '*****************************************************************
    Case "P"
        VLUsarRevForzado = True  'hy-27-dic-2005
        VLMCNRevForzado = VLSsn  'hy-27-dic-2005
        'Bloquear controles
        'Matricula.Enabled = False
        'Arma trama
        
        
        
        
        
        
        VLTramaEnvio = "006          "
        VLTramaEnvio = VLTramaEnvio + VLFecHora 'Fecha y hora real aaaammddhhmmsscc
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2) 'Fecha contable
        VLTramaEnvio = VLTramaEnvio + "006200P00"
        VLTramaEnvio = VLTramaEnvio + "00" + VLSsn 'SSN
        VLTramaEnvio = VLTramaEnvio + "N00000000"
        VLTramaEnvio = VLTramaEnvio + String(3 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) 'Oficina
        VLTramaEnvio = VLTramaEnvio + Trim$(VGUsuario) + String(10 - Len(Trim$(VGUsuario)), " ") 'Usuario
        VLTramaEnvio = VLTramaEnvio + "0200A23A0001888090000000000001FF0000"
        VLTramaEnvio = VLTramaEnvio + "010002"  'Transaccion de consulta
        VLTramaEnvio = VLTramaEnvio + "00000000000000000000"  'Fecha hora y secuencial de banred
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecHora, 9, 6)
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2)
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFechaEfe, 7, 4) + Mid$(VLFechaEfe, 1, 2) + Mid$(VLFechaEfe, 4, 2)
        VLTramaEnvio = VLTramaEnvio + "06597777"  'Institucion adquiriente
        VLTramaEnvio = VLTramaEnvio + String(6 - Len(Trim$(VGUsuario)), "0") + VGUsuario  'Codigo del operador
        VLTramaEnvio = VLTramaEnvio + VLSsn 'SSN
' ame 08/28/2012        VLTramaEnvio = VLTramaEnvio + "1007"  'Número de terminal 1007
        VLTramaEnvio = VLTramaEnvio + "0233"  'Número de terminal 1007
        VLTramaEnvio = VLTramaEnvio + String(6 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina))  'Número de terminal codigo de oficina
        VLTramaEnvio = VLTramaEnvio + Mid$(VGterminal, 1, 6) 'Número de terminal codigo de terminal
        VLTramaEnvio = VLTramaEnvio + "840"  'Código de moneda
        VLTramaEnvio = VLTramaEnvio + "0010031003"  'Producto
        VLLongitud = Len(Trim$(cat1.ClipText))
        If VLLongitud = 1 Then
            VLLongitud = 2
        End If
        VLTramaEnvio = VLTramaEnvio + String(2 - Len(Trim$(str$(VLLongitud))), "0") + Trim$(str$(VLLongitud))
        VLTramaEnvio = VLTramaEnvio + String(VLLongitud - Len(Trim$(cat1.ClipText)), "0") + Trim$(cat1.ClipText)
        VLTramaEnvio = VLTramaEnvio + "04" + String(4 - Len(Trim$(cat2.ClipText)), "0") + Trim$(cat2.ClipText)  'Manzana
        VLTramaEnvio = VLTramaEnvio + "03" + String(3 - Len(Trim$(cat3.ClipText)), "0") + Trim$(cat3.ClipText)  'Lote
        VLTramaEnvio = VLTramaEnvio + "04" + String(4 - Len(Trim$(cat4.ClipText)), "0") + Trim$(cat4.ClipText)  'Division
        VLTramaEnvio = VLTramaEnvio + "04" + String(4 - Len(Trim$(cat5.ClipText)), "0") + Trim$(cat5.ClipText)  'PHV
        VLTramaEnvio = VLTramaEnvio + "04" + String(4 - Len(Trim$(cat6.ClipText)), "0") + Trim$(cat6.ClipText)  'PHH
        VLTramaEnvio = VLTramaEnvio + "01" + "1"  'Número
        VLTramaEnvio = VLTramaEnvio + "04" + Trim$(Agno.Caption)   'Año vigencia
        VLTramaEnvio = VLTramaEnvio + "01" + "3"  'Semestre
        VLLongitud = Len(Trim$(VLTramaEnvio)) + 4
        VLTramaEnvio = String(4 - Len(Trim$(str$(VLLongitud))), "0") + Trim$(str$(VLLongitud)) + VLTramaEnvio
        
        
        
        
        
        
        
        'Enviar trama
        Set objUpdate = CreateObject("UpLoadDll.LoadDllCobis")
        Debug.Print VLTramaEnvio
        With objUpdate
            Screen.MousePointer = 11
            .SendDataClient VGDatosConexionSRI.UpLoadIp, VGDatosConexionSRI.UpLoadPuerto, VGDatosConexionSRI.UpLoadTime, VLTramaEnvio, VLTramaRetorno
            '.SendDataClient "172.16.23.117", VGDatosConexionSRI.UpLoadPuerto, VGDatosConexionSRI.UpLoadTime, VLTramaEnvio, VLTramaRetorno
            Screen.MousePointer = 0
        End With
        Debug.Print VLTramaRetorno
        Set objUpdate = Nothing
        'Validar la trama
        If Mid$(VLTramaRetorno, 1, 4) <> "0000" Then
            VLRevTimeOut = True
            VLSsnRevTimeOut = VLSsn
            Exit Function
        End If
        VLCodRetornoInd = Mid$(VLTramaRetorno, 53, 2)
        If VLCodRetornoInd = "01" Then
            MsgBox "Tiempo de Espera Agotado. Proveedor no respondio", vbCritical, "Aviso"
            VLRevTimeOut = True
            VLSsnRevTimeOut = VLSsn
            Exit Function
        End If
        VLReversarSoloSP = False
        VLCodRetorno = Mid$(VLTramaRetorno, 179, 2)
        If VLCodRetorno <> "00" Then
            VLReversarSoloSP = True
            VLRevTimeOut = True
            VLSsnRevTimeOut = VLSsn
            VLUsarRevForzado = False
            PMInicioTransaccion
            PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "cl_errores_mimg", "", ""
            PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR&, "V", "", ""
            PMPasoValoresATX VGSqlConn&, "@i_codigo", 0, SQLCHAR&, Trim$(VLCodRetorno), "", ""
            If FMTransmitirRPCATX(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "", "N", "S", "I", "0", "N", "N") Then
                PMMapeaObjetoATX VGSqlConn&, txtMensaje
                MsgBox "(" + Trim$(VLCodRetorno) + ") " + txtMensaje, vbExclamation, "MENSAJE DEL MUNICIPIO"
                PMChequeaATX VGSqlConn&
                PMFinTransaccion
            Else
                MsgBox "MENSAJE DE ERROR DEL MUNICIPIO NO CATALOGADO EN EL BANCO", vbCritical, "ERROR"
                PMChequeaATX VGSqlConn&
                PMFinTransaccion
            End If
            Exit Function
        End If
        'Desglosa la trama y muestra el resultado
        VLNumAutorizacion = Mid$(VLTramaRetorno, 626, 10)
        
        
    '*****************************************************************
    '*****************************************************************
    '*************** R E V E R S A ***********************************
    '*****************************************************************
    '*****************************************************************
    Case "R"
        'Bloquear controles
        'Matricula.Enabled = False
        'Arma trama
        
        
        VLTramaEnvio = "006          "
        VLTramaEnvio = VLTramaEnvio + VLFecHora 'Fecha y hora real aaaammddhhmmsscc
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2) 'Fecha contable
        VLTramaEnvio = VLTramaEnvio + "006420R00"
        
        VLSsn = VLSsnRevTimeOut + 1
        If Len(Trim$(VLSsn)) > 6 Then
            VLSsn = Right$(Trim$(VLSsn), 6)
        Else
            VLSsn = String(6 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
        End If
        
        VLTramaEnvio = VLTramaEnvio + "00" + VLSsn 'SSN
        VLTramaEnvio = VLTramaEnvio + "S00" + VLSsnRevTimeOut
        VLTramaEnvio = VLTramaEnvio + String(3 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) 'Oficina
        VLTramaEnvio = VLTramaEnvio + Trim$(VGUsuario) + String(10 - Len(Trim$(VGUsuario)), " ") 'Usuario
        VLTramaEnvio = VLTramaEnvio + "0420B23A0081888091000000000001FF0000"
        VLTramaEnvio = VLTramaEnvio + "010002"  'Transaccion de consulta
        VLTramaEnvio = VLTramaEnvio + VLTotalTrama 'Valor
        VLTramaEnvio = VLTramaEnvio + "00000000000000000000"  'Fecha hora y secuencial de banred
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecHora, 9, 6)
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2)
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFechaEfe, 7, 4) + Mid$(VLFechaEfe, 1, 2) + Mid$(VLFechaEfe, 4, 2)
        VLTramaEnvio = VLTramaEnvio + "02"  'Indicador del reverso
        VLTramaEnvio = VLTramaEnvio + "06597777"  'Institucion adquiriente
        VLTramaEnvio = VLTramaEnvio + String(6 - Len(Trim$(VGUsuario)), "0") + VGUsuario  'Codigo del operador
        VLTramaEnvio = VLTramaEnvio + VLSsn 'SSN
        ' ame 08/28/2012 VLTramaEnvio = VLTramaEnvio + "1007"  'Número de terminal 1007
        VLTramaEnvio = VLTramaEnvio + "0233"  'Número de terminal 1007
        VLTramaEnvio = VLTramaEnvio + String(6 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina))  'Número de terminal codigo de oficina
        VLTramaEnvio = VLTramaEnvio + Mid$(VGterminal, 1, 6) 'Número de terminal codigo de terminal
        VLTramaEnvio = VLTramaEnvio + "840"  'Código de moneda
        VLTramaEnvio = VLTramaEnvio + "0010031003"  'Producto
        
        VLTramaEnvio = VLTramaEnvio + "0200"
        VLTramaEnvio = VLTramaEnvio + VLSsnRevTimeOut
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2)
        VLTramaEnvio = VLTramaEnvio + VLHoraReversar
        'ame 08/28/2012 VLTramaEnvio = VLTramaEnvio + "1007"  'Número de terminal 1007
        VLTramaEnvio = VLTramaEnvio + "0233"  'Número de terminal 1007
        VLTramaEnvio = VLTramaEnvio + String(6 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina))  'Número de terminal codigo de oficina
        VLTramaEnvio = VLTramaEnvio + Mid$(VGterminal, 1, 6) 'Número de terminal codigo de terminal
        
        VLLongitud = Len(Trim$(txtcat1.Text))
        If VLLongitud = 1 Then
            VLLongitud = 2
        End If
        VLTramaEnvio = VLTramaEnvio + String(2 - Len(Trim$(str$(VLLongitud))), "0") + Trim$(str$(VLLongitud))
        VLTramaEnvio = VLTramaEnvio + String(VLLongitud - Len(Trim$(txtcat1.Text)), "0") + Trim$(txtcat1.Text)
        VLTramaEnvio = VLTramaEnvio + "04" + String(4 - Len(Trim$(cat2.ClipText)), "0") + Trim$(cat2.ClipText)  'Manzana
        VLTramaEnvio = VLTramaEnvio + "03" + String(3 - Len(Trim$(cat3.ClipText)), "0") + Trim$(cat3.ClipText)  'Lote
        VLTramaEnvio = VLTramaEnvio + "04" + String(4 - Len(Trim$(cat4.ClipText)), "0") + Trim$(cat4.ClipText)  'Division
        VLTramaEnvio = VLTramaEnvio + "04" + String(4 - Len(Trim$(cat5.ClipText)), "0") + Trim$(cat5.ClipText)  'PHV
        VLTramaEnvio = VLTramaEnvio + "04" + String(4 - Len(Trim$(cat6.ClipText)), "0") + Trim$(cat6.ClipText)  'PHH
        VLTramaEnvio = VLTramaEnvio + "01" + "1"  'Número
        VLTramaEnvio = VLTramaEnvio + "04" + Trim$(Agno.Caption)   'Año vigencia
        VLTramaEnvio = VLTramaEnvio + "01" + "3"  'Semestre
        VLLongitud = Len(Trim$(VLTramaEnvio)) + 4
        VLTramaEnvio = String(4 - Len(Trim$(str$(VLLongitud))), "0") + Trim$(str$(VLLongitud)) + VLTramaEnvio
        
        
        'Enviar trama
        Set objUpdate = CreateObject("UpLoadDll.LoadDllCobis")
        Debug.Print VLTramaEnvio
        With objUpdate
            Screen.MousePointer = 11
            .SendDataClient VGDatosConexionSRI.UpLoadIp, VGDatosConexionSRI.UpLoadPuerto, VGDatosConexionSRI.UpLoadTime, VLTramaEnvio, VLTramaRetorno
            '.SendDataClient "172.16.23.117", VGDatosConexionSRI.UpLoadPuerto, VGDatosConexionSRI.UpLoadTime, VLTramaEnvio, VLTramaRetorno
            Screen.MousePointer = 0
        End With
        Debug.Print VLTramaRetorno
        Set objUpdate = Nothing
        'Validar la trama
        If Mid$(VLTramaRetorno, 1, 4) <> "0000" Then
            If Mid$(VLTramaRetorno, 1, 4) = "7806" Then
                MsgBox "TIME OUT DE LA TRANSACCION DE REVERSA", vbCritical, "MUNICIPIO"
            Else
                MsgBox "REVERSA CON PROBLEMAS DE COMUNICACION", vbCritical, "MUNICIPIO"
            End If
            Exit Function
        End If
        VLCodRetornoInd = Mid$(VLTramaRetorno, 53, 2)
        If VLCodRetornoInd = "01" Then
            MsgBox "Tiempo de Espera Agotado. Proveedor no respondio", vbCritical, "Aviso"
            Exit Function
        End If
        VLCodRetorno = Mid$(VLTramaRetorno, 179, 2)
        If VLCodRetorno <> "00" Then
            PMInicioTransaccion
            PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "cl_errores_matsri", "", ""
            PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR&, "V", "", ""
            PMPasoValoresATX VGSqlConn&, "@i_codigo", 0, SQLCHAR&, Trim$(VLCodRetorno), "", ""
            If FMTransmitirRPCATX(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "", "N", "S", "I", "0", "N", "N") Then
                'PMMapeaObjetoATX VGSqlConn&, txtmensaje
                PMChequeaATX VGSqlConn&
                PMFinTransaccion
            Else
                MsgBox "MENSAJE DE ERROR DEL MUNICIPIO NO CATALOGADO EN EL BANCO", vbCritical, "ERROR"
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
        'Bloquear controles
        'Matricula.Enabled = False
        'Arma trama
        
        
        
        
        VLTramaEnvio = "006          "
        VLTramaEnvio = VLTramaEnvio + VLFecHora 'Fecha y hora real aaaammddhhmmsscc
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2) 'Fecha contable
        VLTramaEnvio = VLTramaEnvio + "006420R00"
        VLTramaEnvio = VLTramaEnvio + "00" + VLSsn 'SSN
        VLTramaEnvio = VLTramaEnvio + "S00" + VLSsnRevTimeOut
        VLTramaEnvio = VLTramaEnvio + String(3 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) 'Oficina
        VLTramaEnvio = VLTramaEnvio + Trim$(VGUsuario) + String(10 - Len(Trim$(VGUsuario)), " ") 'Usuario
        VLTramaEnvio = VLTramaEnvio + "0420B23A0081888091000000000001FF0000"
        VLTramaEnvio = VLTramaEnvio + "010002"  'Transaccion de consulta
        VLTotalTrama = str$(CDbl(ValorMun.Text) * 100)
        VLTotalTrama = String(12 - Len(Trim$(VLTotalTrama)), "0") + Trim$(VLTotalTrama)
        VLTramaEnvio = VLTramaEnvio + VLTotalTrama
        VLTramaEnvio = VLTramaEnvio + "00000000000000000000"  'Fecha hora y secuencial de banred
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecHora, 9, 6)
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2)
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFechaEfe, 7, 4) + Mid$(VLFechaEfe, 1, 2) + Mid$(VLFechaEfe, 4, 2)
        VLTramaEnvio = VLTramaEnvio + "02"  'Indicador del reverso
        VLTramaEnvio = VLTramaEnvio + "06597777"  'Institucion adquiriente
        VLTramaEnvio = VLTramaEnvio + String(6 - Len(Trim$(VGUsuario)), "0") + VGUsuario  'Codigo del operador
        VLTramaEnvio = VLTramaEnvio + VLSsn 'SSN
        ' ame 08/28/2012 VLTramaEnvio = VLTramaEnvio + "1007"  'Número de terminal 1007
        VLTramaEnvio = VLTramaEnvio + "0233"  'Número de terminal 1007
        VLTramaEnvio = VLTramaEnvio + String(6 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina))  'Número de terminal codigo de oficina
        VLTramaEnvio = VLTramaEnvio + Mid$(VGterminal, 1, 6) 'Número de terminal codigo de terminal
        VLTramaEnvio = VLTramaEnvio + "840"  'Código de moneda
        VLTramaEnvio = VLTramaEnvio + "0010031003"  'Producto
        
        VLTramaEnvio = VLTramaEnvio + "0200"
        VLTramaEnvio = VLTramaEnvio + VLSsnRevTimeOut
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2)
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecHora, 9, 6)
        ' VLTramaEnvio = VLTramaEnvio + "1007"  'Número de terminal 1007
        VLTramaEnvio = VLTramaEnvio + "0233"  'Número de terminal 1007
        VLTramaEnvio = VLTramaEnvio + String(6 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina))  'Número de terminal codigo de oficina
        VLTramaEnvio = VLTramaEnvio + Mid$(VGterminal, 1, 6) 'Número de terminal codigo de terminal
        
        VLLongitud = Len(Trim$(cat1.ClipText))
        If VLLongitud = 1 Then
            VLLongitud = 2
        End If
        VLTramaEnvio = VLTramaEnvio + String(2 - Len(Trim$(str$(VLLongitud))), "0") + Trim$(str$(VLLongitud))
        VLTramaEnvio = VLTramaEnvio + String(VLLongitud - Len(Trim$(cat1.ClipText)), "0") + Trim$(cat1.ClipText)
        VLTramaEnvio = VLTramaEnvio + "04" + String(4 - Len(Trim$(cat2.ClipText)), "0") + Trim$(cat2.ClipText)  'Manzana
        VLTramaEnvio = VLTramaEnvio + "03" + String(3 - Len(Trim$(cat3.ClipText)), "0") + Trim$(cat3.ClipText)  'Lote
        VLTramaEnvio = VLTramaEnvio + "04" + String(4 - Len(Trim$(cat4.ClipText)), "0") + Trim$(cat4.ClipText)  'Division
        VLTramaEnvio = VLTramaEnvio + "04" + String(4 - Len(Trim$(cat5.ClipText)), "0") + Trim$(cat5.ClipText)  'PHV
        VLTramaEnvio = VLTramaEnvio + "04" + String(4 - Len(Trim$(cat6.ClipText)), "0") + Trim$(cat6.ClipText)  'PHH
        VLTramaEnvio = VLTramaEnvio + "01" + "1"  'Número
        VLTramaEnvio = VLTramaEnvio + "04" + Trim$(Agno.Caption)   'Año vigencia
        VLTramaEnvio = VLTramaEnvio + "01" + "3"  'Semestre
        VLLongitud = Len(Trim$(VLTramaEnvio)) + 4
        VLTramaEnvio = String(4 - Len(Trim$(str$(VLLongitud))), "0") + Trim$(str$(VLLongitud)) + VLTramaEnvio
        
        
        
        
        
        'Enviar trama
        Set objUpdate = CreateObject("UpLoadDll.LoadDllCobis")
        Debug.Print VLTramaEnvio
        With objUpdate
            Screen.MousePointer = 11
            .SendDataClient VGDatosConexionSRI.UpLoadIp, VGDatosConexionSRI.UpLoadPuerto, VGDatosConexionSRI.UpLoadTime, VLTramaEnvio, VLTramaRetorno
            '.SendDataClient "172.16.23.117", VGDatosConexionSRI.UpLoadPuerto, VGDatosConexionSRI.UpLoadTime, VLTramaEnvio, VLTramaRetorno
            Screen.MousePointer = 0
        End With
        Debug.Print VLTramaRetorno
        Set objUpdate = Nothing
        'Validar la trama
        If Mid$(VLTramaRetorno, 1, 4) <> "0000" Then
            If Mid$(VLTramaRetorno, 1, 4) = "7806" Then
                MsgBox "SE HA APLICADO UNA REVERSA FORZADA SIN OBTENER RESPUESTA", vbCritical, "MUNICIPIO"
            Else
                MsgBox "SE HA APLICADO UNA REVERSA FORZADA CON PROBLEMAS", vbCritical, "MUNICIPIO"
            End If
            Exit Function
        End If
        VLCodRetornoInd = Mid$(VLTramaRetorno, 53, 2)
        If VLCodRetornoInd = "01" Then
            MsgBox "Tiempo de Espera Agotado. Proveedor no respondio", vbCritical, "Aviso"
            Exit Function
        End If
        MsgBox "SE HA APLICADO UNA REVERSA FORZADA", vbCritical, "MUNICIPIO"
        VLCodRetorno = Mid$(VLTramaRetorno, 179, 2)
        If VLCodRetorno <> "00" Then
            PMInicioTransaccion
            PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "cl_errores_matsri", "", ""
            PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR&, "V", "", ""
            PMPasoValoresATX VGSqlConn&, "@i_codigo", 0, SQLCHAR&, Trim$(VLCodRetorno), "", ""
            If FMTransmitirRPCATX(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "", "N", "S", "I", "0", "N", "N") Then
                'PMMapeaObjetoATX VGSqlConn&, txtmensaje
                PMChequeaATX VGSqlConn&
                PMFinTransaccion
            Else
                MsgBox "MENSAJE DE ERROR DEL MUNICIPIO NO CATALOGADO EN EL BANCO", vbCritical, "ERROR"
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

'hy-14-agosto-2006
Function FLTramaSwitch_MQ(VLTipo As String) As Boolean
On Error GoTo Etiqueta_Error
    Dim VLTramaEnvio As String
    Dim VLTramaRetorno As String
    Dim VLCodRetorno As String
    Dim VLCodRetornoInd As String
    Dim VLValorPagar As String
    Dim VLSSNREV As String
    Dim VLLongitud As Integer
    Dim VLFila As Integer
    Dim VLColumna As Integer
    Dim VLColInicio As Integer
    Dim VLFlagExiste As Boolean
    Dim VLItems As Integer
    
    FLTramaSwitch_MQ = False
    'Armar y lanzar la trama de pago al sri
    Select Case VLTipo
    '*****************************************************************
    '*****************************************************************
    '*************** C O N S U L T A *********************************
    '*****************************************************************
    '*****************************************************************
    Case "C"
        'Arma trama
        VLTramaEnvio = "006          "
        VLTramaEnvio = VLTramaEnvio + VLFecHora 'Fecha y hora real aaaammddhhmmsscc
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2) 'Fecha contable
        VLTramaEnvio = VLTramaEnvio + "006200C00"
        VLTramaEnvio = VLTramaEnvio + "00" + VLSsn 'SSN
        VLTramaEnvio = VLTramaEnvio + "N00000000"
        VLTramaEnvio = VLTramaEnvio + String(3 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) 'Oficina
        VLTramaEnvio = VLTramaEnvio + Trim$(VGUsuario) + String(10 - Len(Trim$(VGUsuario)), " ") 'Usuario
        VLTramaEnvio = VLTramaEnvio + "0200E23A0001888090000000000000180000"
        'aqui empieza trama variable
        VLTramaEnvio = VLTramaEnvio + Trim$(cedula.ClipText) + String(19 - Len(Trim$(cedula.ClipText)), " ")
        VLTramaEnvio = VLTramaEnvio + "310004"  'Transaccion de consulta
        VLTramaEnvio = VLTramaEnvio + "00000000000000000000"  'Fecha hora y secuencial de banred
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecHora, 9, 6)
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2)
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2)
        VLTramaEnvio = VLTramaEnvio + "06597777"  'Institucion adquiriente
        VLTramaEnvio = VLTramaEnvio + String(6 - Len(Trim$(VGUsuario)), "0") + VGUsuario  'Codigo del operador
        VLTramaEnvio = VLTramaEnvio + VLSsn 'SSN
        ' ame 08/28/2012 VLTramaEnvio = VLTramaEnvio + "1007"  'Número de terminal 1007
        VLTramaEnvio = VLTramaEnvio + "0233"  'Número de terminal 1007
        VLTramaEnvio = VLTramaEnvio + String(6 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina))  'Número de terminal codigo de oficina
        VLTramaEnvio = VLTramaEnvio + Mid$(VGterminal, 1, 6) 'Número de terminal codigo de terminal
        VLTramaEnvio = VLTramaEnvio + "840"  'Código de moneda
        VLTramaEnvio = VLTramaEnvio + "0010031004"  'Producto
        VLTramaEnvio = VLTramaEnvio + "03001"  'canal siempre 03001
        VLTramaEnvio = VLTramaEnvio + "03"  'tipo de impuesto: predio-001 patente-002 varios-003
        VLTramaEnvio = VLTramaEnvio + Tipo.Text
        VLLongitud = Len(Trim$(VLTramaEnvio)) + 4
        VLTramaEnvio = String(4 - Len(Trim$(str$(VLLongitud))), "0") + Trim$(str$(VLLongitud)) + VLTramaEnvio
        'Enviar trama
        Set objUpdate = CreateObject("UpLoadCSwitch.LoadDllCobis")
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
        VLCodRetorno = Mid$(VLTramaRetorno, 212, 2)
        If VLCodRetorno <> "00" Then
            PMInicioTransaccion
            PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "cl_errores_mimg", "", ""
            PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR&, "V", "", ""
            PMPasoValoresATX VGSqlConn&, "@i_codigo", 0, SQLCHAR&, Trim$(VLCodRetorno), "", ""
            If FMTransmitirRPCATX(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "", "N", "S", "I", "0", "N", "N") Then
                PMMapeaObjetoATX VGSqlConn&, txtMensaje
                MsgBox "(" + Trim$(VLCodRetorno) + ") " + txtMensaje, vbCritical, "MENSAJE DEL MUNICIPIO"
                PMChequeaATX VGSqlConn&
                PMFinTransaccion
            Else
                MsgBox "MENSAJE DE ERROR NO CATALOGADO EN EL BANCO", vbCritical, "ERROR"
                PMChequeaATX VGSqlConn&
                PMFinTransaccion
            End If
            Exit Function
        End If
        'Desglosa la trama y muestra el resultado
        VLContribuyente = Trim$(Mid$(VLTramaRetorno, 230, 35))
        Contribuyente.Caption = VLContribuyente
        VLSecuencialOriginal = Trim$(Mid$(VLTramaRetorno, 150, 6))
        VLIdentificacion = Trim$(Mid$(VLTramaRetorno, 178, 14))
        VLAvaluoComercial = str$(CCur(Trim$(Mid$(VLTramaRetorno, 336, 12))) / 100)
        VLExoneracion = Trim$(Mid$(VLTramaRetorno, 328, 2))
        If Trim$(VLExoneracion) = "00" Then
            VLExoneracion = "NO"
        Else
            VLExoneracion = "SI"
        End If
        'IMPORTANTE VERIFICAR LA LONGITUD DE LA IDENTIFICACION
        'IMPORTANTE VERIFICAR LA LONGITUD DE LA IDENTIFICACION
        'IMPORTANTE VERIFICAR LA LONGITUD DE LA IDENTIFICACION
        'If Mid$(VLIdentificacion, 1, 4) = "0000" Then
        '    VLIdentificacion = Mid$(VLIdentificacion, 5, 10)
        'Else
        '    VLIdentificacion = Mid$(VLIdentificacion, 2, 13)
        'End If
        'IMPORTANTE VERIFICAR LA LONGITUD DE LA IDENTIFICACION
        'IMPORTANTE VERIFICAR LA LONGITUD DE LA IDENTIFICACION
        'IMPORTANTE VERIFICAR LA LONGITUD DE LA IDENTIFICACION
        
        If Trim$(Mid$(VLTramaRetorno, 348, 3)) = "000" Then
            MsgBox "EL CODIGO CATASTRAL NO TIENE DEUDAS PENDIENTES", vbInformation, "Aviso"
            Exit Function
        End If
        
        VLTopeMax = 0
        VLColInicio = 351
        VLItems = val(Mid$(VLTramaRetorno, VLColInicio - 3, 3)) / 39
        grdBloque.Rows = VLItems + 1
        For VLFila = 1 To VLItems
            VLTopeMax = VLTopeMax + 1
            grdBloque.Row = VLTopeMax
            grdBloque.Col = 1
            grdBloque.Text = Trim$(Mid$(VLTramaRetorno, VLColInicio, 3))
            grdBloque.Col = 2
            grdBloque.Text = Trim$(Mid$(VLTramaRetorno, VLColInicio + 3, 22))
            grdBloque.Col = 3
            grdBloque.Text = Trim$(Mid$(VLTramaRetorno, VLColInicio + 25, 4))
            grdBloque.Col = 4
            grdBloque.Text = CDbl(Trim$(Mid$(VLTramaRetorno, VLColInicio + 29, 10))) / 100
            VLColInicio = VLColInicio + 39
        Next VLFila

        VLTopeMax = 0
        VLColInicio = 1134
        For VLFila = 1 To VLItems
            VLTopeMax = VLTopeMax + 1
            grdBloque.Row = VLTopeMax
            grdBloque.Col = 5
            grdBloque.Text = Trim$(Mid$(VLTramaRetorno, VLColInicio, 25))
            VLColInicio = VLColInicio + 25
        Next VLFila

    '*****************************************************************
    '*****************************************************************
    '*************** P A G O *****************************************
    '*****************************************************************
    '*****************************************************************
    Case "P"
        VLUsarRevForzado = True
        VLMCNRevForzado = VLSsn
        
        VLTramaEnvio = "006          "
        VLTramaEnvio = VLTramaEnvio + VLFecHora 'Fecha y hora real aaaammddhhmmsscc
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2) 'Fecha contable
        VLTramaEnvio = VLTramaEnvio + "006200P00"
        VLTramaEnvio = VLTramaEnvio + "00" + VLSsn 'SSN
        VLTramaEnvio = VLTramaEnvio + "N00000000"
        VLTramaEnvio = VLTramaEnvio + String(3 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) 'Oficina
        VLTramaEnvio = VLTramaEnvio + Trim$(VGUsuario) + String(10 - Len(Trim$(VGUsuario)), " ") 'Usuario
        VLTramaEnvio = VLTramaEnvio + "0200E23A0001888090003000000000180000"
        VLTramaEnvio = VLTramaEnvio + Trim$(cedula.ClipText) + String(19 - Len(Trim$(cedula.ClipText)), " ")
        VLTramaEnvio = VLTramaEnvio + "010005"  'Transaccion de pago
        VLTramaEnvio = VLTramaEnvio + "00000000000000000000"  'Fecha hora y secuencial de banred
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecHora, 9, 6)
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2)
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFechaEfe, 7, 4) + Mid$(VLFechaEfe, 1, 2) + Mid$(VLFechaEfe, 4, 2)
        VLTramaEnvio = VLTramaEnvio + "06597777"  'Institucion adquiriente
        VLTramaEnvio = VLTramaEnvio + String(6 - Len(Trim$(VGUsuario)), "0") + VGUsuario  'Codigo del operador
        VLTramaEnvio = VLTramaEnvio + VLSsn 'SSN
        ' ame 08/28/2012 VLTramaEnvio = VLTramaEnvio + "1007"  'Número de terminal 1007
        VLTramaEnvio = VLTramaEnvio + "0233"  'Número de terminal 1007
        VLTramaEnvio = VLTramaEnvio + String(6 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina))  'Número de terminal codigo de oficina
        VLTramaEnvio = VLTramaEnvio + Mid$(VGterminal, 1, 6) 'Número de terminal codigo de terminal
        VLTramaEnvio = VLTramaEnvio + "840"  'Código de moneda
        VLTramaEnvio = VLTramaEnvio + "0010031004"  'Producto
        'Primer arreglo seleccionado
        VLTramaEnvio = VLTramaEnvio + "039"
        VLTramaEnvio = VLTramaEnvio + String(3 - Len(Trim$(Impto.Caption)), "0") + Trim$(Impto.Caption)
        VLTramaEnvio = VLTramaEnvio + Trim$(Impto.Tag) + String(22 - Len(Trim$(Impto.Tag)), " ")
        VLTramaEnvio = VLTramaEnvio + Trim$(Agno.Caption)
        VLTramaEnvio = VLTramaEnvio + String(10 - Len(Trim$(str$(CCur(ValorMun) * 100))), "0") + Trim$(str$(CCur(ValorMun) * 100))
        'Segundo arreglo seleccionado
        VLTramaEnvio = VLTramaEnvio + "025"
        VLTramaEnvio = VLTramaEnvio + Trim$(Agno.Tag)
        VLTramaEnvio = VLTramaEnvio + "03001"  'canal siempre 03001
        VLTramaEnvio = VLTramaEnvio + "03"  'tipo de impuesto: predio-001 patente-002 varios-003
        VLTramaEnvio = VLTramaEnvio + Tipo.Text
        VLLongitud = Len(Trim$(VLTramaEnvio)) + 4
        VLTramaEnvio = String(4 - Len(Trim$(str$(VLLongitud))), "0") + Trim$(str$(VLLongitud)) + VLTramaEnvio
' ame 08/28/2012        VLDatoOriginal = VLSsn + Mid$(VLFecHora, 1, 14) + "1007" + String(6 - Len(Trim$(Str$(VGOficina))), "0") + Trim$(Str$(VGOficina)) + String(6 - Len(Trim$(VGUsuario)), "0") + VGUsuario
        VLDatoOriginal = VLSsn + Mid$(VLFecHora, 1, 14) + "0233" + String(6 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) + String(6 - Len(Trim$(VGUsuario)), "0") + VGUsuario
        'Enviar trama
        Set objUpdate = CreateObject("UpLoadCSwitch.LoadDllCobis")
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
            VLRevTimeOut = True
            VLSsnRevTimeOut = VLSsn
            Exit Function
        End If
        VLCodRetornoInd = Mid$(VLTramaRetorno, 53, 2)
        If VLCodRetornoInd = "01" Then
            MsgBox "Tiempo de Espera Agotado. Proveedor no respondio", vbCritical, "Aviso"
            VLRevTimeOut = True
            VLSsnRevTimeOut = VLSsn
            Exit Function
        End If
        VLReversarSoloSP = False
        VLCodRetorno = Mid$(VLTramaRetorno, 212, 2)
        If VLCodRetorno <> "00" Then
            VLReversarSoloSP = True
            VLRevTimeOut = True
            VLSsnRevTimeOut = VLSsn
            VLUsarRevForzado = False
            PMInicioTransaccion
            PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "cl_errores_mimg", "", ""
            PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR&, "V", "", ""
            PMPasoValoresATX VGSqlConn&, "@i_codigo", 0, SQLCHAR&, Trim$(VLCodRetorno), "", ""
            If FMTransmitirRPCATX(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "", "N", "S", "I", "0", "N", "N") Then
                PMMapeaObjetoATX VGSqlConn&, txtMensaje
                MsgBox "(" + Trim$(VLCodRetorno) + ") " + txtMensaje, vbExclamation, "MENSAJE DEL MUNICIPIO"
                PMChequeaATX VGSqlConn&
                PMFinTransaccion
            Else
                MsgBox "MENSAJE DE ERROR DEL MUNICIPIO NO CATALOGADO EN EL BANCO", vbCritical, "ERROR"
                PMChequeaATX VGSqlConn&
                PMFinTransaccion
            End If
            Exit Function
        End If
        'Desglosa la trama y muestra el resultado
        VLNumAutorizacion = Mid$(VLTramaRetorno, 1752, 15)
        VLSecuencialOriginal = Trim$(Mid$(VLTramaRetorno, 150, 6))
        VLDireccion = Trim$(Mid$(VLTramaRetorno, 276, 20))
        VLNoCasa = Trim$(Mid$(VLTramaRetorno, 296, 5))
        VLExoneracion = Trim$(Mid$(VLTramaRetorno, 328, 2))
        If Trim$(VLExoneracion) = "00" Then
            VLExoneracion = "NO"
        Else
            VLExoneracion = "SI"
        End If
        VLFechaEmision = Trim$(Mid$(VLTramaRetorno, 1688, 8))
        VLConcepto = Trim$(Mid$(VLTramaRetorno, 1656, 30))
        VLAvaluoComercial = str$(CCur(Trim$(Mid$(VLTramaRetorno, 336, 12))) / 100)
        vlclavecatastral = Trim$(Mid$(VLTramaRetorno, 301, 13))
        VLValorRecargo = str$(CCur(Mid$(VLTramaRetorno, 1726, 12)) / 100)
        VLValorDescuentos = str$(CCur(Mid$(VLTramaRetorno, 1712, 12)) / 100)
        VLValorInteres = str$(CCur(Mid$(VLTramaRetorno, 138, 12)) / 100)
        VLValorRubros = str$(CCur(Mid$(VLTramaRetorno, 126, 12)) / 100)
        VLValorCostas = str$(CCur(Mid$(VLTramaRetorno, 1740, 12)) / 100)
        VLValorTotalPagar = str$(CCur(Mid$(VLTramaRetorno, 114, 12)) / 100)
        VLNumeroAutorizacion = Trim$(Mid$(VLTramaRetorno, 1754, 10))
        VLDescripcionRubro1 = Trim$(Mid$(VLTramaRetorno, 1767, 22))
        VLValorRubro1 = str$(CCur(Mid$(VLTramaRetorno, 1789, 9)) / 100)
        VLDescripcionRubro2 = Trim$(Mid$(VLTramaRetorno, 1798, 22))
        VLValorRubro2 = str$(CCur(Mid$(VLTramaRetorno, 1820, 9)) / 100)
        VLDescripcionRubro3 = Trim$(Mid$(VLTramaRetorno, 1829, 22))
        VLValorRubro3 = str$(CCur(Mid$(VLTramaRetorno, 1851, 9)) / 100)
        VLDescripcionRubro4 = Trim$(Mid$(VLTramaRetorno, 1860, 22))
        VLValorRubro4 = str$(CCur(Mid$(VLTramaRetorno, 1882, 9)) / 100)
        VLDescripcionRubro5 = Trim$(Mid$(VLTramaRetorno, 1891, 22))
        VLValorRubro5 = str$(CCur(Mid$(VLTramaRetorno, 1913, 9)) / 100)
        VLDescripcionRubro6 = Trim$(Mid$(VLTramaRetorno, 1922, 22))
        VLValorRubro6 = str$(CCur(Mid$(VLTramaRetorno, 1944, 9)) / 100)
        VLDescripcionRubro7 = Trim$(Mid$(VLTramaRetorno, 1953, 22))
        VLValorRubro7 = str$(CCur(Mid$(VLTramaRetorno, 1975, 9)) / 100)
        VLDescripcionRubro8 = Trim$(Mid$(VLTramaRetorno, 1984, 22))
        VLValorRubro8 = str$(CCur(Mid$(VLTramaRetorno, 2006, 9)) / 100)
        VLDescripcionRubro9 = Trim$(Mid$(VLTramaRetorno, 2015, 22))
        VLValorRubro9 = str$(CCur(Mid$(VLTramaRetorno, 2037, 9)) / 100)
        VLDescripcionRubro10 = Trim$(Mid$(VLTramaRetorno, 2046, 22))
        VLValorRubro10 = str$(CCur(Mid$(VLTramaRetorno, 2068, 9)) / 100)
        
    '*****************************************************************
    '*****************************************************************
    '*************** R E V E R S A ***********************************
    '*****************************************************************
    '*****************************************************************
    Case "R"
        VLTramaEnvio = "006          "
        VLTramaEnvio = VLTramaEnvio + VLFecHora 'Fecha y hora real aaaammddhhmmsscc
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2) 'Fecha contable
        VLTramaEnvio = VLTramaEnvio + "006420R00"
        VLSsn = VLSsnRevTimeOut + 1
        If Len(Trim$(VLSsn)) > 6 Then
            VLSsn = Right$(Trim$(VLSsn), 6)
        Else
            VLSsn = String(6 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
        End If
        VLTramaEnvio = VLTramaEnvio + "00" + VLSsn 'SSN
        VLTramaEnvio = VLTramaEnvio + "S00" + VLSsnRevTimeOut
        VLTramaEnvio = VLTramaEnvio + String(3 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) 'Oficina
        VLTramaEnvio = VLTramaEnvio + Trim$(VGUsuario) + String(10 - Len(Trim$(VGUsuario)), " ") 'Usuario
        VLTramaEnvio = VLTramaEnvio + "0420F23A0081888091000000000000180000"
        VLTramaEnvio = VLTramaEnvio + Trim$(txtLlave.Text) + String(19 - Len(Trim$(txtLlave.Text)), " ")
        VLTramaEnvio = VLTramaEnvio + "010005"  'Transaccion de reverso
        VLTramaEnvio = VLTramaEnvio + String(12 - Len(Trim$(str$(CCur(ValorMun) * 100))), "0") + Trim$(str$(CCur(ValorMun) * 100))
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2)
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecHora, 9, 6)
        VLTramaEnvio = VLTramaEnvio + "000000"  'VLSecuencialOriginal  'Secuencial de banred original
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecHora, 9, 6)
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2)
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFechaEfe, 7, 4) + Mid$(VLFechaEfe, 1, 2) + Mid$(VLFechaEfe, 4, 2)
        VLTramaEnvio = VLTramaEnvio + "02"  'indicador de reverso
        VLTramaEnvio = VLTramaEnvio + "06597777"  'Institucion adquiriente
        VLTramaEnvio = VLTramaEnvio + String(6 - Len(Trim$(VGUsuario)), "0") + VGUsuario  'Codigo del operador
        VLTramaEnvio = VLTramaEnvio + VLSsn 'SSN
        ' ame 08/28/2012 VLTramaEnvio = VLTramaEnvio + "1007"  'Número de terminal 1007
        VLTramaEnvio = VLTramaEnvio + "0233"  'Número de terminal 1007
        VLTramaEnvio = VLTramaEnvio + String(6 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina))  'Número de terminal codigo de oficina
        VLTramaEnvio = VLTramaEnvio + Mid$(VGterminal, 1, 6) 'Número de terminal codigo de terminal
        VLTramaEnvio = VLTramaEnvio + "840"  'Código de moneda
        VLTramaEnvio = VLTramaEnvio + "0010031004"  'Producto
        VLTramaEnvio = VLTramaEnvio + "0200" + VLDatoOriginal 'Datos de transaccion original 0200+ssssss+aaaammddhhmmss+terminal(1007+oficin+usuari)
        VLTramaEnvio = VLTramaEnvio + "03001"  'canal siempre 03001
        VLTramaEnvio = VLTramaEnvio + "03"  'tipo de impuesto: predio-001 patente-002 varios-003
        VLTramaEnvio = VLTramaEnvio + Tipo.Text
        VLLongitud = Len(Trim$(VLTramaEnvio)) + 4
        VLTramaEnvio = String(4 - Len(Trim$(str$(VLLongitud))), "0") + Trim$(str$(VLLongitud)) + VLTramaEnvio
        
        'Enviar trama
        Set objUpdate = CreateObject("UpLoadCSwitch.LoadDllCobis")
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
                MsgBox "TIME OUT DE LA TRANSACCION DE REVERSA", vbCritical, "MUNICIPIO"
            Else
                MsgBox "REVERSA CON PROBLEMAS DE COMUNICACION", vbCritical, "MUNICIPIO"
            End If
            Exit Function
        End If
        VLCodRetornoInd = Mid$(VLTramaRetorno, 53, 2)
        If VLCodRetornoInd = "01" Then
            MsgBox "Tiempo de Espera Agotado. Proveedor no respondio", vbCritical, "Aviso"
            Exit Function
        End If
        VLCodRetorno = Mid$(VLTramaRetorno, 212, 2)
        If VLCodRetorno <> "00" Then
            PMInicioTransaccion
            PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "cl_errores_matsri", "", ""
            PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR&, "V", "", ""
            PMPasoValoresATX VGSqlConn&, "@i_codigo", 0, SQLCHAR&, Trim$(VLCodRetorno), "", ""
            If FMTransmitirRPCATX(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "", "N", "S", "I", "0", "N", "N") Then
                PMChequeaATX VGSqlConn&
                PMFinTransaccion
            Else
                MsgBox "MENSAJE DE ERROR DEL MUNICIPIO NO CATALOGADO EN EL BANCO", vbCritical, "ERROR"
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
        VLTramaEnvio = "006          "
        VLTramaEnvio = VLTramaEnvio + VLFecHora 'Fecha y hora real aaaammddhhmmsscc
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2) 'Fecha contable
        VLTramaEnvio = VLTramaEnvio + "006420R00"
        VLTramaEnvio = VLTramaEnvio + "00" + VLSsn 'SSN
        VLTramaEnvio = VLTramaEnvio + "S00000000"
        VLTramaEnvio = VLTramaEnvio + String(3 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) 'Oficina
        VLTramaEnvio = VLTramaEnvio + Trim$(VGUsuario) + String(10 - Len(Trim$(VGUsuario)), " ") 'Usuario
        VLTramaEnvio = VLTramaEnvio + "0420F23A0081888091000000000000180000"
        VLTramaEnvio = VLTramaEnvio + Trim$(cedula.ClipText) + String(19 - Len(Trim$(cedula.ClipText)), " ")
        VLTramaEnvio = VLTramaEnvio + "010005"  'Transaccion de reverso
        VLTramaEnvio = VLTramaEnvio + String(12 - Len(Trim$(str$(CCur(ValorMun) * 100))), "0") + Trim$(str$(CCur(ValorMun) * 100))
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2)
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecHora, 9, 6)
        VLTramaEnvio = VLTramaEnvio + "000000"  'VLSecuencialOriginal  'Secuencial de banred original
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecHora, 9, 6)
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2)
        VLTramaEnvio = VLTramaEnvio + Mid$(VLFechaEfe, 7, 4) + Mid$(VLFechaEfe, 1, 2) + Mid$(VLFechaEfe, 4, 2)
        VLTramaEnvio = VLTramaEnvio + "02"  'indicador de reverso
        VLTramaEnvio = VLTramaEnvio + "06597777"  'Institucion adquiriente
        VLTramaEnvio = VLTramaEnvio + String(6 - Len(Trim$(VGUsuario)), "0") + VGUsuario  'Codigo del operador
        VLTramaEnvio = VLTramaEnvio + VLSsn 'SSN
        'ame 08/28/2012 VLTramaEnvio = VLTramaEnvio + "1007"  'Número de terminal 1007
        VLTramaEnvio = VLTramaEnvio + "0233"
        VLTramaEnvio = VLTramaEnvio + String(6 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina))  'Número de terminal codigo de oficina
        VLTramaEnvio = VLTramaEnvio + Mid$(VGterminal, 1, 6) 'Número de terminal codigo de terminal
        VLTramaEnvio = VLTramaEnvio + "840"  'Código de moneda
        VLTramaEnvio = VLTramaEnvio + "0010031004"  'Producto
        VLTramaEnvio = VLTramaEnvio + "0200" + VLDatoOriginal 'Datos de transaccion original 0200+ssssss+aaaammddhhmmss+terminal(1007+oficin+usuari)
        VLTramaEnvio = VLTramaEnvio + "03001"  'canal siempre 03001
        VLTramaEnvio = VLTramaEnvio + "03"  'tipo de impuesto: predio-001 patente-002 varios-003
        VLTramaEnvio = VLTramaEnvio + Tipo.Text
        VLLongitud = Len(Trim$(VLTramaEnvio)) + 4
        VLTramaEnvio = String(4 - Len(Trim$(str$(VLLongitud))), "0") + Trim$(str$(VLLongitud)) + VLTramaEnvio
        
        'Enviar trama
        Set objUpdate = CreateObject("UpLoadCSwitch.LoadDllCobis")
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
                MsgBox "SE HA APLICADO UNA REVERSA FORZADA SIN OBTENER RESPUESTA", vbCritical, "MUNICIPIO"
            Else
                MsgBox "SE HA APLICADO UNA REVERSA FORZADA CON PROBLEMAS", vbCritical, "MUNICIPIO"
            End If
            Exit Function
        End If
        VLCodRetornoInd = Mid$(VLTramaRetorno, 212, 2)
        If VLCodRetornoInd = "01" Then
            MsgBox "Tiempo de Espera Agotado. Proveedor no respondio", vbCritical, "Aviso"
            Exit Function
        End If
        MsgBox "SE HA APLICADO UNA REVERSA FORZADA", vbCritical, "MUNICIPIO"
        VLCodRetorno = Mid$(VLTramaRetorno, 179, 2)
        If VLCodRetorno <> "00" Then
            PMInicioTransaccion
            PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "cl_errores_matsri", "", ""
            PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR&, "V", "", ""
            PMPasoValoresATX VGSqlConn&, "@i_codigo", 0, SQLCHAR&, Trim$(VLCodRetorno), "", ""
            If FMTransmitirRPCATX(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "", "N", "S", "I", "0", "N", "N") Then
                PMChequeaATX VGSqlConn&
                PMFinTransaccion
            Else
                MsgBox "MENSAJE DE ERROR DEL MUNICIPIO NO CATALOGADO EN EL BANCO", vbCritical, "ERROR"
                PMChequeaATX VGSqlConn&
                PMFinTransaccion
            End If
            Exit Function
        End If
    End Select
    
    FLTramaSwitch_MQ = True
    Exit Function
Etiqueta_Error:
    Screen.MousePointer = 0
    MsgBox Err.Description, vbCritical, "Error"
End Function

'-->hy-22-febrero-2007
Function FLTransmitir_CPS_MUNCUE_consulta() As Boolean
    Dim VLArregloPago1 As String
    Dim VLArregloPago2 As String
    
    FLTransmitir_CPS_MUNCUE_consulta = False
    
    VLSsn = Trim$(str$(VGSqlConn))
    If Len(Trim$(VLSsn)) > 6 Then
        VLSsn = Right$(Trim$(VLSsn), 6)
    Else
        VLSsn = String(6 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
    End If

    
    VLTsnTemp = 0
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 62026, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_pllave_municipal", 0, SQLVARCHAR, Trim$(txtLlaveMunicipal.Text), "", ""
    PMPasoValoresATX VGSqlConn, "@i_ptipo_transacción", 0, SQLINT4, "310005", "", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_hora_br", 0, SQLINT4, "00000000000000", "", ""
    PMPasoValoresATX VGSqlConn, "@i_psecuencial__br", 0, SQLINT4, "000000", "", ""
    PMPasoValoresATX VGSqlConn, "@i_phora_trx_local", 0, SQLINT4, Format$(Time(), "hhmmss"), "", ""
    
    'lfcm 20-junio-2007 (2 lineas)
    'PMPasoValoresATX VGSqlConn, "@i_pfecha_trx_local", 0, SQLINT4, Format$(Date, "yymmdd"), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_trx_local", 0, SQLINT4, Format$(Date, "yyyymmdd"), "", ""
    
    'lfcm 20-junio-2007 (2 lineas)
    'PMPasoValoresATX VGSqlConn, "@i_pfecha_comp", 0, SQLINT4, Format$(Date, "yymmdd"), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_comp", 0, SQLINT4, Format$(Date, "yyyymmdd"), "", ""
    
    PMPasoValoresATX VGSqlConn, "@i_pinst_adquirente", 0, SQLINT4, "597777", "", ""
    PMPasoValoresATX VGSqlConn, "@i_poperador", 0, SQLVARCHAR, String(6 - Len(Trim$(VGUsuario)), "0") + VGUsuario, "", ""
    PMPasoValoresATX VGSqlConn, "@i_psecuencial_adq", 0, SQLINT4, Trim(VLSsn), "", ""
' ame 08/28/2012    PMPasoValoresATX VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, "1007" + String(6 - Len(Trim$(Str$(VGOficina))), "0") + Trim$(Str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, "0233" + String(6 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pcanal", 0, SQLVARCHAR, "001", "", ""
    PMPasoValoresATX VGSqlConn, "@i_pimpuesto", 0, SQLVARCHAR, Trim$(Tipo.Text), "", ""
    
    If FMTransmitirRPCATX(VGSqlConn, "PSSRV1", "cob_procesador", "fp_consulta_municipios", True, "Transaccion Ok", "S", "N", "N", "19", "S", "S") = True Then
        FLTransmitir_CPS_MUNCUE_consulta = True
        VTResult% = FMMapeaMatrizATX(VGSqlConn&, vtmatrizcps())
        VLContribuyente = FLBuscarItem("@o_pnombres")
        Contribuyente.Caption = VLContribuyente
        VLIdentificacion = FLBuscarItem("@o_pdocumento")
        VLDireccion = FLBuscarItem("@o_pdireccion")
        VLArregloPago1 = FLBuscarItem("@o_pvalores_pago1")
        If Trim$(VLArregloPago1) = "" Then
            VLArregloPago1 = FLBuscarItem("@o_pvalores_pago1_0")
            VLArregloPago1 = VLArregloPago1 + FLBuscarItem("@o_pvalores_pago1_1")
            VLArregloPago1 = VLArregloPago1 + FLBuscarItem("@o_pvalores_pago1_2")
            VLArregloPago1 = VLArregloPago1 + FLBuscarItem("@o_pvalores_pago1_3")
        End If
        VLArregloPago2 = FLBuscarItem("@o_pvalores_pago2")
        If Trim$(VLArregloPago2) = "" Then
            VLArregloPago2 = FLBuscarItem("@o_pvalores_pago2_0")
            VLArregloPago2 = VLArregloPago2 + FLBuscarItem("@o_pvalores_pago2_1")
            VLArregloPago2 = VLArregloPago2 + FLBuscarItem("@o_pvalores_pago2_2")
            VLArregloPago2 = VLArregloPago2 + FLBuscarItem("@o_pvalores_pago2_3")
        End If
        
        If Trim$(VLArregloPago1) = "" Then
            MsgBox "NO TIENE DEUDAS PENDIENTES", vbInformation, "Aviso"
            Exit Function
        End If
        
        VLItems = Len(VLArregloPago1) / 39
        grdBloque.Rows = VLItems + 1
        For VLFila = 1 To VLItems
            grdBloque.Row = VLFila
            grdBloque.Col = 1
            grdBloque.Text = Trim$(Mid$(VLArregloPago1, (VLFila - 1) * 39 + 33, 4))
            grdBloque.Col = 3
            grdBloque.Text = Trim$(Mid$(VLArregloPago1, (VLFila - 1) * 39 + 1, 39))
            grdBloque.Text = grdBloque.Text + Trim$(Mid$(VLArregloPago2, (VLFila - 1) * 25 + 1, 25))
        Next VLFila

        For VLFila = 1 To VLItems
            grdBloque.Row = VLFila
            grdBloque.Col = 2
            grdBloque.Text = CDbl(Trim$(Mid$(VLArregloPago2, (VLFila - 1) * 25 + 9, 8))) / 100
        Next VLFila
        If VLItems = 1 Then
            VLFlagUnicoMunCuenca = True
        Else
            VLFlagUnicoMunCuenca = False
        End If
    Else
        PMChequeaATX VGSqlConn
    End If
    PMChequeaATX VGSqlConn
    PMFinTransaccion
End Function

Function FLTransmitir_CPS_MUNCUE_pago() As Boolean
Dim VTIndicadorSum As Integer
Dim VLIndReverso As Boolean
    VTIndicadorSum = 0
    
    FLTransmitir_CPS_MUNCUE_pago = False
    
    If VGHorarioDif Then
        VLTrn = "3216"
    Else
        VLTrn = "3215"
    End If
    
    VGTrn = IIf(VLTrn = "", 0, VLTrn)
    
    VLIndReverso = False
    If VGTipoEjecucion% = CGReverso% Then
        VGTipoEjecucion% = CGNormal%
        VLIndReverso = True
    End If
            
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "S", "opcion", ""
    PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@o_fechora", 1, SQLVARCHAR, 0, "Fechora", ""
    PMPasoValoresATX VGSqlConn, "@o_feccontable", 1, SQLVARCHAR, 0, "Feccontable", ""
    PMPasoValoresATX VGSqlConn, "@o_secuencial", 1, SQLINT4, 0, "Secuencial", ""
    
    If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_tr_municipio_recaudacion", True, "Transaccion Ok", "S", "N", "N", "19", "S", "S") = True Then
        VLFecHora = FMRetParamATX(VGSqlConn, 1)
        VLFecContable = FMRetParamATX(VGSqlConn, 2)
        VLSsn = FMRetParamATX(VGSqlConn, 3)
        If Len(Trim$(VLSsn)) > 6 Then
            VLSsn = Right$(Trim$(VLSsn), 6)
        Else
            VLSsn = String(6 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
        End If
        PMChequeaATX VGSqlConn
        PMTotalesBranch "19"
        FLTransmitir_CPS_MUNCUE_pago = True
        VLCambio% = False
        'TPE ------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 3)
        VTIndicadorSum = 1
        PMIniciaRegSum
        '<-----
    Else
        VLCambio% = True
        FLTransmitir_CPS_MUNCUE_pago = False
        'TPE ------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 3)
        VTIndicadorSum = 0
        PMChequeaATX VGSqlConn
        PMFinTransaccion
        Exit Function
        '<------
    End If
    PMChequeaATX VGSqlConn
    If FMRetStatusATX(VGSqlConn) <> 0 Then
        VTIndicadorSum = 0
        FLTransmitir_CPS_MUNCUE_pago = False
        PMFinTransaccion
        Exit Function
    End If
    PMFinTransaccion
    
    
    If VLIndReverso Then
        VLIndReverso = False
        VGTipoEjecucion% = CGReverso%
    End If
    
    FLTransmitir_CPS_MUNCUE_pago = False
    
    If VGTipoEjecucion% = CGReverso% Then
        VLSsn = Trim$(str$(VGSqlConn))
    End If
    If Len(Trim$(VLSsn)) > 6 Then
        VLSsn = Right$(Trim$(VLSsn), 6)
    Else
        VLSsn = String(6 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
    End If
    
    PMInicioTransaccion
    
    
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 62027, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "T", "opcion", ""
    PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_identifica", 0, SQLVARCHAR, (txtLlaveMunicipal.Text), "identificacion", ""
    PMPasoValoresATX VGSqlConn, "@i_cod_impto", 0, SQLCHAR, (Impto.Caption), "tipo", ""
    PMPasoValoresATX VGSqlConn, "@i_no_predio", 0, SQLINT4, (Predio.Caption), "Moneda", ""
    PMPasoValoresATX VGSqlConn, "@i_agno", 0, SQLINT4, val(Agno.Caption), "Autorizacion", ""
    PMPasoValoresATX VGSqlConn, "@i_semestre", 0, SQLVARCHAR, (Semestre.Caption), "Autorizacion", ""
    PMPasoValoresATX VGSqlConn, "@i_prioridad", 0, SQLINT4, val(Prioridad.Text), "Prioridad", ""
    PMPasoValoresATX VGSqlConn, "@i_nombre", 0, SQLVARCHAR, (Contribuyente.Caption), "Nombre", ""
    PMPasoValoresATX VGSqlConn, "@i_efe", 0, SQLMONEY, (efe.Text), "efe", ""
    PMPasoValoresATX VGSqlConn, "@i_cant_chq", 0, SQLINT4, val(CantChq.Text), "Moneda", ""
    PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, (Cheques.Text), "Cheques", ""
    PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(FMObtenerMonedaForma("19")), "Moneda", ""
    PMPasoValoresATX VGSqlConn, "@i_autoriza", 0, SQLVARCHAR, VGAutoriza, "Autorizacion", ""
    PMPasoValoresATX VGSqlConn, "@i_supautor", 0, SQLVARCHAR, VGSuperAutoriza$, "Supervisor de Monto", ""       'ref:esma10mar2003
    PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, (Debito.Text), "Debito", ""
    PMPasoValoresATX VGSqlConn, "@i_tarjeta", 0, SQLMONEY, (Tarjeta.Text), "Tarjeta", ""
    PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
    PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (CboTipCta.Text), "CboTipCta", ""
    PMPasoValoresATX VGSqlConn, "@i_contribuyente", 0, SQLVARCHAR, (Contribuyente.Caption), "contribuyente", ""
    PMPasoValoresATX VGSqlConn, "@i_valor_mun", 0, SQLMONEY, (ValorMun.Text), "valormun", ""
    PMPasoValoresATX VGSqlConn, "@i_tipo_impto", 0, SQLVARCHAR, (Tipo), "tipoimpto", ""
    PMPasoValoresATX VGSqlConn, "@i_totaltrama", 0, SQLMONEY, (ValorMun), "cat1", ""
    PMPasoValoresATX VGSqlConn, "@i_horatrama", 0, SQLVARCHAR, Mid$(VLFecHora, 9, 6), "hora", ""
    PMPasoValoresATX VGSqlConn, "@i_vlfechora", 0, SQLVARCHAR, VLFecHora, "vlfechora", ""
    PMPasoValoresATX VGSqlConn, "@i_vlfeccontable", 0, SQLVARCHAR, VLFecContable, "vlfeccontable", ""
    PMPasoValoresATX VGSqlConn, "@i_vlexoneracion", 0, SQLVARCHAR, VLExoneracion, "vlexoneracion", ""
    PMPasoValoresATX VGSqlConn, "@i_vlavaluocomercial", 0, SQLVARCHAR, VLAvaluoComercial, "vlavaluocomercial", ""
    PMPasoValoresATX VGSqlConn, "@i_VLIdentificacion", 0, SQLVARCHAR, VLIdentificacion, "VLIdentificacion", ""  'hy-22-septiembre-2006
    PMPasoValoresATX VGSqlConn, "@i_sal_municipio", 0, SQLVARCHAR, (sal_municipio.Caption), "sal_municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_sal_tipo", 0, SQLVARCHAR, (sal_tipo.Caption), "sal_tipo", ""
    PMPasoValoresATX VGSqlConn, "@i_desc_impto", 0, SQLVARCHAR, (DescripImpto.Text), "sal_tipo", ""
    PMPasoValoresATX VGSqlConn, "@i_direccion", 0, SQLVARCHAR, (direccion.Text), "direccion", ""
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
    
    PMPasoValoresATX VGSqlConn, "@i_titulo", 0, SQLCHAR, Trim$(Agno.Tag), "Titulo", ""
    PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, "0", "SecTrn", ""
    PMPasoValoresATX VGSqlConn, "@o_nombcta", 1, SQLVARCHAR, (Nombre.Text), "nombre", ""
    PMPasoValoresATX VGSqlConn, "@o_horario", 1, SQLCHAR, Space(1), "Horario", ""
    PMPasoValoresATX VGSqlConn, "@o_autorisri", 1, SQLVARCHAR, VLautoriSri, "AutorizacionSRI", ""
    PMPasoValoresATX VGSqlConn, "@o_fecvensri", 1, SQLVARCHAR, VLFecvenSRI, "Stk", ""
    PMPasoValoresATX VGSqlConn, "@o_nota_venta", 1, SQLVARCHAR, VLSerie_Secuencia, "Nota_venta", ""
    PMPasoValoresATX VGSqlConn, "@o_fechora", 1, SQLVARCHAR, 0, "Fechora", ""
    PMPasoValoresATX VGSqlConn, "@o_feccontable", 1, SQLVARCHAR, 0, "Feccontable", ""
    PMPasoValoresATX VGSqlConn, "@o_fecha_ef", 1, SQLVARCHAR, "", "Fechaefe", ""
    PMPasoValoresATX VGSqlConn, "@i_secuencial", 0, SQLVARCHAR, VLSsn, "", ""    'hy-22-febrero-2007
    If VGHorarioDif Then                                                         'hy-22-febrero-2007
        PMPasoValoresATX VGSqlConn, "@i_hora_trama", 0, SQLVARCHAR, "D", "", ""  'hy-22-febrero-2007
    Else                                                                         'hy-22-febrero-2007
        PMPasoValoresATX VGSqlConn, "@i_hora_trama", 0, SQLVARCHAR, "H", "", ""  'hy-22-febrero-2007
    End If                                                                       'hy-22-febrero-2007
    
    PMPasoValoresATX VGSqlConn, "@i_pllave_municipal", 0, SQLVARCHAR, Trim$(txtLlaveMunicipal.Text), "", ""
    PMPasoValoresATX VGSqlConn, "@i_ptipo_transaccion", 0, SQLINT4, "010006", "", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_hora_br", 0, SQLINT4, "00000000000000", "", ""
    PMPasoValoresATX VGSqlConn, "@i_psecuencial__br", 0, SQLINT4, "000000", "", ""
    PMPasoValoresATX VGSqlConn, "@i_phora_trx_local", 0, SQLINT4, Mid$(VLFecHora, 9, 6), "", ""
    
    'lfcm 20-junio-2007 (2 junio)
    'PMPasoValoresATX VGSqlConn, "@i_pfecha_trx_local", 0, SQLINT4, Mid$(VLFecHora, 3, 6), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_trx_local", 0, SQLINT4, Mid$(VLFecHora, 1, 8), "", ""
    
    'lfcm 20-junio-2007 (2 junio)
    'PMPasoValoresATX VGSqlConn, "@i_pfecha_comp", 0, SQLINT4, Mid$(VLFecHora, 3, 6), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_comp", 0, SQLINT4, Mid$(VLFecHora, 1, 8), "", ""
    
    PMPasoValoresATX VGSqlConn, "@i_pinst_adquirente", 0, SQLINT4, "597777", "", ""
    PMPasoValoresATX VGSqlConn, "@i_poperador", 0, SQLVARCHAR, String(6 - Len(Trim$(VGUsuario)), "0") + VGUsuario, "", ""
    PMPasoValoresATX VGSqlConn, "@i_psecuencial_adq", 0, SQLINT4, Trim(VLSsn), "", ""
    ' ame 08/28/2012 PMPasoValoresATX VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, "1007" + String(6 - Len(Trim$(Str$(VGOficina))), "0") + Trim$(Str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, "0233" + String(6 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pmoneda", 0, SQLINT4, "840", "", ""
    PMPasoValoresATX VGSqlConn, "@i_pproducto", 0, SQLINT4, "0010031005", "", ""
    
    'lfcm 20-junio-2007 (11 lineas siguientes)
    'PMPasoValoresATX VGSqlConn, "@i_pvalores_pago1", 0, SQLVARCHAR, Mid$(VLItemSeleccionado, 1, 39), "", ""
    'PMPasoValoresATX VGSqlConn, "@i_pvalores_pago2", 0, SQLVARCHAR, Mid$(VLItemSeleccionado, 40, 25), "", ""
    If VGTipoEjecucion% = CGReverso% Then
        PMPasoValoresATX VGSqlConn, "@i_pvalores_pago1", 0, SQLVARCHAR, VLValoresPago1, "", "", True
        PMPasoValoresATX VGSqlConn, "@i_pvalores_pago2", 0, SQLVARCHAR, VLValoresPago2, "", "", True
    Else
        PMPasoValoresATX VGSqlConn, "@i_pvalores_pago1", 0, SQLVARCHAR, Mid$(VLItemSeleccionado, 1, 39), "", ""
        PMPasoValoresATX VGSqlConn, "@i_pvalores_pago2", 0, SQLVARCHAR, Mid$(VLItemSeleccionado, 40, 25), "", ""
        PMPasoValoresATX VGSqlConn, "@i_pvalores_pago1_2", 0, SQLVARCHAR, Mid$(VLItemSeleccionado, 21, 19), "", ""
        PMPasoValoresATX VGSqlConn, "@i_pvalores_pago2_2", 0, SQLVARCHAR, Mid$(VLItemSeleccionado, 60, 20), "", ""
    End If
    
    
    PMPasoValoresATX VGSqlConn, "@i_pcanal", 0, SQLVARCHAR, "001", "", ""
    PMPasoValoresATX VGSqlConn, "@i_pimpuesto", 0, SQLVARCHAR, Trim$(Tipo.Text), "", ""
    
    If VGTipoEjecucion% <> CGReverso% Then
        PMPasoValoresATX VGSqlConn, "@o_pautorizacion", 1, SQLVARCHAR, 0, "", ""
    End If
    
    If VGTipoEjecucion% = CGReverso% Then
        PMPasoValoresATX VGSqlConn, "@i_preverso", 0, SQLVARCHAR, "2", "", "", True
        PMPasoValoresATX VGSqlConn, "@i_pautorizacion", 0, SQLVARCHAR, VLAutorizacionMunCue, "", "", True
        'lfcm 19-junio-2007 (2 lineas siguientes)
        'PMPasoValoresATX VGSqlConn, "@i_ptrx_original", 0, SQLVARCHAR, "0200" + VLSecuencialAdqMunCue + VLFechaMunCue + VLHoraMunCue + Trim$(VGterminal), "", "", True
        ' ame 08/28/2012 PMPasoValoresATX VGSqlConn, "@i_ptrx_original", 0, SQLVARCHAR, "0200" + VLSecuencialAdqMunCue + Format(VLFechaMunCue, "00000000") + VLHoraMunCue + "1007" + String(6 - Len(Trim$(Str$(VGOficina))), "0") + Trim$(Str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", "", True
        PMPasoValoresATX VGSqlConn, "@i_ptrx_original", 0, SQLVARCHAR, "0200" + VLSecuencialAdqMunCue + Format(VLFechaMunCue, "00000000") + VLHoraMunCue + "0233" + String(6 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", "", True
        VGErrorTransmision = False
    Else
        ' ame 08/28/2012 PMPasoValoresATX VGSqlConn, "@i_ptrx_original", 0, SQLVARCHAR, "0200" + Trim(VLSsn) + Format(Mid$(VLFecHora, 1, 8), "00000000") + VLHoraMunCue + "1007" + String(6 - Len(Trim$(Str$(VGOficina))), "0") + Trim$(Str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", "", True   'ame marzo 16/2010
        PMPasoValoresATX VGSqlConn, "@i_ptrx_original", 0, SQLVARCHAR, "0200" + Trim(VLSsn) + Format(Mid$(VLFecHora, 1, 8), "00000000") + VLHoraMunCue + "0233" + String(6 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", "", True   'ame marzo 16/2010
    End If
    
    VLMunCue_Emision = Trim$(Mid$(VLItemSeleccionado, 1, 8))
    VLMunCue_Exoneracion = Trim$(Mid$(VLItemSeleccionado, 9, 8))
    VLMunCue_Descuentos = Trim$(Mid$(VLItemSeleccionado, 17, 8))
    VLMunCue_Recargos = Trim$(Mid$(VLItemSeleccionado, 25, 8))
    VLMunCue_Intereses = Trim$(Mid$(VLItemSeleccionado, 40, 8))
    VLMunCue_Total = Trim$(Mid$(VLItemSeleccionado, 48, 8))
    
    PMPasoValoresATX VGSqlConn, "@i_mc_emision", 0, SQLVARCHAR, VLMunCue_Emision, "", ""
    PMPasoValoresATX VGSqlConn, "@i_mc_exoneracion", 0, SQLVARCHAR, VLMunCue_Exoneracion, "", ""
    PMPasoValoresATX VGSqlConn, "@i_mc_descuentos", 0, SQLVARCHAR, VLMunCue_Descuentos, "", ""
    PMPasoValoresATX VGSqlConn, "@i_mc_recargos", 0, SQLVARCHAR, VLMunCue_Recargos, "", ""
    PMPasoValoresATX VGSqlConn, "@i_mc_intereses", 0, SQLVARCHAR, VLMunCue_Intereses, "", ""
    PMPasoValoresATX VGSqlConn, "@i_mc_total", 0, SQLVARCHAR, VLMunCue_Total, "", ""
    PMPasoValoresATX VGSqlConn, "@i_mc_direccion", 0, SQLVARCHAR, VLDireccion, "", ""
    
    
    If FMTransmitirRPCATX(VGSqlConn, "PSSRV1", "cob_procesador", "fp_pago_municipio", True, "Transaccion Ok", "S", "N", "S", "19", "S", "S") = True Then
        FLTransmitir_CPS_MUNCUE_pago = True
        VTResult% = FMMapeaMatrizATX(VGSqlConn&, vtmatrizcps())
        VLTsnTemporal = VGTSN
        PMChequeaATX VGSqlConn
        PMTotalesBranch "19"
        VLCambio% = False
        'TPE ------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 1)
        VLSSnCorreccion = FMRetParamATX(VGSqlConn, 1)
        VLSsn = FMRetParamATX(VGSqlConn, 1)
        If Len(Trim$(VLSsn)) > 6 Then
            VLSsn = Right$(Trim$(VLSsn), 6)
        Else
            VLSsn = String(6 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
        End If
        VLHorario = Trim$(FMRetParamATX(VGSqlConn, 3))    'ame 03/2010
        VLautoriSri = FMRetParamATX(VGSqlConn, 4)         'ame 03/2010
        VLFecvenSRI = FMRetParamATX(VGSqlConn, 5)         'ame 03/2010
        VLSerie_Secuencia = FMRetParamATX(VGSqlConn, 9)  'hy-24-feb-2005 'ame 03/2010
        If VGTipoEjecucion% <> CGReverso% Then
            VLFechaEfe = FMRetParamATX(VGSqlConn, 6)       'ame 03/2010
        Else
            VLFechaEfe = ""     'ame 03/2010
        End If
        VTIndicadorSum = 1
        PMIniciaRegSum
        '<-----
    Else
        RevCondMunicipioCuenca
    
        'PLReversoCondicionalMuCuenca        'lfcm 22-junio-2007
    
        VLCambio% = True
        FLTransmitir_CPS_MUNCUE_pago = False
        'TPE ------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 1)
        VTIndicadorSum = 0
        PMChequeaATX VGSqlConn
        PMFinTransaccion
        Exit Function
        '<------
    End If
    PMChequeaATX VGSqlConn
    If FMRetStatusATX(VGSqlConn) <> 0 Then
        VTIndicadorSum = 0
        FLTransmitir_CPS_MUNCUE_pago = False
        PMFinTransaccion
        Exit Function
    End If
    PMFinTransaccion
    
    'GAMC - 02AGO10
VLclave_acceso = "" 'ref02 vmirandt
    
    'JPM Lectora de Billetes -->
    If CCur(efe.Text) > 0 And ((VGDatPersBillAltDen.dataOK And VGTipoEjecucion = CGNormal%) Or VGTipoEjecucion = CGReverso%) Then
      Call PMGuardarDsglsBillete("19", SGSecTrn$, VLTrn, rptBAD, "REC", "")
      lectoraBill.Limpiar
    End If
    '<-- JPM Lectora de Billetes
    'ref003 Ini
    If VLDeb_com = 0 Then
        Call PLFactura
    End If
    'ref003 Fin
    
    'Sumadora -->
    If VGTipoEjecucion% <> CGReverso% Then   'Validacion por REVERSO
        If (VTIndicadorSum = 1 And (Trim$(VGStatusCon) = "A" Or Trim$(VGStatusCon) = "")) Then
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

Function FLBuscarItem(VLELemento As String) As String
    Dim I As Integer
    Dim hallado As Boolean
    I = 1
    hallado = False
    Do While I < 52 And Not hallado
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

'msilvag Inicio Otros Municipios
Function FLBuscarItem2(VLELemento As String) As String
    Dim I As Integer
    Dim hallado As Boolean
    I = 0
    hallado = False
    'VLELemento = "@nombre"
    Do While I < 30 And Not hallado
        If vtmatrizcps2(I, 0) = Trim$(VLELemento) Then
            hallado = True
        Else
            I = I + 1
        End If
    Loop
    If hallado Then
        FLBuscarItem2 = vtmatrizcps2(I, 1)
    Else
        FLBuscarItem2 = ""
    End If
End Function
'msilvag Fin
Private Sub txtCatasSamb_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Ingrese Código Unico."
    
     
    If Me.municipio.Text = "1430" Then ' nchavezb 04/Agosto/2011 Municipio Daule
        Call Muni_1430("4", 0)
        SendKeys ("{HOME}+{END}")
    End If
End Sub

Private Sub txtCatasSamb_KeyPress(KeyAscii As Integer)
'DAPV - INI  09/01/2011
If KeyAscii = 13 Then
    Prioridad.SetFocus
    'txtCampo_LostFocus (Index)
End If

 If (KeyAscii% < 48 Or KeyAscii% > 57) And KeyAscii% <> 8 And KeyAscii% <> 46 Then
          KeyAscii% = 0
 End If
      
'DAPV -FIN 09/01/2011

End Sub

Private Sub txtCatasSamb_LostFocus()
On Error GoTo Etiqueta_Error

'DAPV - INI  09/01/2011
        VL_Prioridad = 1
        Prioridad.SetFocus
        'Prioridad.SetFocus
'DAPV -FIN
Etiqueta_Error:

End Sub

Private Sub txtLlaveMunicipal_KeyPress(KeyAscii As Integer)
    If KeyAscii = CGTeclaENTER% Then
        SendKeys "{TAB}"
        Exit Sub
    End If
    If Not ((KeyAscii >= 48 And keuascii <= 57) Or (KeyAscii >= 65 And KeyAscii <= 90) Or (KeyAscii >= 97 And KeyAscii <= 122) Or (KeyAscii = 8)) Then
        KeyAscii = 0
    End If

    
End Sub

Private Sub txtLlaveMunicipal_LostFocus()
    txtLlaveMunicipal.Text = UCase(txtLlaveMunicipal.Text)
End Sub
'<--hy-22-febrero-2007




'Reverso condicional de Municipio de Cuenca
'Reverso condicional de Municipio de Cuenca
'Reverso condicional de Municipio de Cuenca
'Reverso condicional de Municipio de Cuenca
'Reverso condicional de Municipio de Cuenca
'Reverso condicional de Municipio de Cuenca
'Reverso condicional de Municipio de Cuenca
'Reverso condicional de Municipio de Cuenca
'Reverso condicional de Municipio de Cuenca
'Reverso condicional de Municipio de Cuenca
'Reverso condicional de Municipio de Cuenca
'Reverso condicional de Municipio de Cuenca
'Reverso condicional de Municipio de Cuenca
'Reverso condicional de Municipio de Cuenca
'Reverso condicional de Municipio de Cuenca


Sub RevCondMunicipioCuenca()

    If VGTipoEjecucion% = CGNormal% Then
        VTReturn = FMRetStatusATX(VGSqlConn)  'Para capturar el código del error
        If VTReturn = 30002 Then    '30002 = Código del TimeOut
            '(Inicio del reverso condicional por TimeOut)
            PMInicioTransaccion
            PMPasoValores VGSqlConn, "@t_trn", 0, SQLINT4, 62027
            PMPasoValores VGSqlConn, "@t_corr", 0, SQLVARCHAR, "S"
            PMPasoValores VGSqlConn, "@i_opcion", 0, SQLCHAR, "T"
            'PMPasoValores VGSqlConn, "@i_municipio", 0, SQLINT4, Val(municipio.Text), "municipio", ""
            PMPasoValores VGSqlConn, "@i_municipio", 0, SQLINT4, val("9999")
            PMPasoValores VGSqlConn, "@i_identifica", 0, SQLVARCHAR, (txtLlaveMunicipal.Text)
            PMPasoValores VGSqlConn, "@i_cod_impto", 0, SQLCHAR, (Impto.Caption)
            PMPasoValores VGSqlConn, "@i_no_predio", 0, SQLINT4, (Predio.Caption)
            PMPasoValores VGSqlConn, "@i_agno", 0, SQLINT4, val(Agno.Caption)
            PMPasoValores VGSqlConn, "@i_semestre", 0, SQLVARCHAR, (Semestre.Caption)
            PMPasoValores VGSqlConn, "@i_prioridad", 0, SQLINT4, val(Prioridad.Text)
            PMPasoValores VGSqlConn, "@i_nombre", 0, SQLVARCHAR, (Contribuyente.Caption)
            PMPasoValores VGSqlConn, "@i_efe", 0, SQLMONEY, (efe.Text)
            PMPasoValores VGSqlConn, "@i_cant_chq", 0, SQLINT4, val(CantChq.Text)
            PMPasoValores VGSqlConn, "@i_cheque", 0, SQLMONEY, (Cheques.Text)
            PMPasoValores VGSqlConn, "@i_mon", 0, SQLINT1, str(FMObtenerMonedaForma("19"))
            PMPasoValores VGSqlConn, "@i_autoriza", 0, SQLVARCHAR, VGAutoriza
            PMPasoValores VGSqlConn, "@i_supautor", 0, SQLVARCHAR, VGSuperAutoriza$
            PMPasoValores VGSqlConn, "@i_debito", 0, SQLMONEY, (Debito.Text)
            PMPasoValores VGSqlConn, "@i_tarjeta", 0, SQLMONEY, (Tarjeta.Text)
            PMPasoValores VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText)
            PMPasoValores VGSqlConn, "@i_producto", 0, SQLCHAR, (CboTipCta.Text)
            PMPasoValores VGSqlConn, "@i_contribuyente", 0, SQLVARCHAR, (Contribuyente.Caption)
            PMPasoValores VGSqlConn, "@i_valor_mun", 0, SQLMONEY, (ValorMun.Text)
            PMPasoValores VGSqlConn, "@i_tipo_impto", 0, SQLVARCHAR, (Tipo)
            PMPasoValores VGSqlConn, "@i_totaltrama", 0, SQLMONEY, (ValorMun)
            PMPasoValores VGSqlConn, "@i_horatrama", 0, SQLVARCHAR, Mid$(VLFecHora, 9, 6)
            PMPasoValores VGSqlConn, "@i_vlfechora", 0, SQLVARCHAR, VLFecHora
            PMPasoValores VGSqlConn, "@i_vlfeccontable", 0, SQLVARCHAR, VLFecContable
            PMPasoValores VGSqlConn, "@i_vlexoneracion", 0, SQLVARCHAR, VLExoneracion
            PMPasoValores VGSqlConn, "@i_vlavaluocomercial", 0, SQLVARCHAR, VLAvaluoComercial
            PMPasoValores VGSqlConn, "@i_VLIdentificacion", 0, SQLVARCHAR, VLIdentificacion
            PMPasoValores VGSqlConn, "@i_sal_municipio", 0, SQLVARCHAR, (sal_municipio.Caption)
            PMPasoValores VGSqlConn, "@i_sal_tipo", 0, SQLVARCHAR, (sal_tipo.Caption)
            PMPasoValores VGSqlConn, "@i_desc_impto", 0, SQLVARCHAR, (DescripImpto.Text)
            PMPasoValores VGSqlConn, "@i_direccion", 0, SQLVARCHAR, (direccion.Text)
            PMPasoValores VGSqlConn, "@i_efe_com", 0, SQLMONEY, (VLEfe_com)
            PMPasoValores VGSqlConn, "@i_chq_com", 0, SQLMONEY, (VLChq_com)
            PMPasoValores VGSqlConn, "@i_deb_com", 0, SQLMONEY, (VLDeb_com)
            PMPasoValores VGSqlConn, "@i_cta_com", 0, SQLVARCHAR, (VLCta_com)
            PMPasoValores VGSqlConn, "@i_tipocta_com", 0, SQLCHAR, (VLTipCta_com)
            
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
            
            PMPasoValores VGSqlConn, "@i_titulo", 0, SQLCHAR, Trim$(Agno.Tag)
            PMPasoValores VGSqlConn, "@o_ssn", 1, SQLINT4, "0"
            PMPasoValores VGSqlConn, "@o_nombcta", 1, SQLVARCHAR, (Nombre.Text)
            PMPasoValores VGSqlConn, "@o_horario", 1, SQLCHAR, Space(1)
            PMPasoValores VGSqlConn, "@o_autorisri", 1, SQLVARCHAR, VLautoriSri
            PMPasoValores VGSqlConn, "@o_fecvensri", 1, SQLVARCHAR, VLFecvenSRI
            PMPasoValores VGSqlConn, "@o_nota_venta", 1, SQLVARCHAR, VLSerie_Secuencia
            PMPasoValores VGSqlConn, "@o_fechora", 1, SQLVARCHAR, 0
            PMPasoValores VGSqlConn, "@o_feccontable", 1, SQLVARCHAR, 0
            PMPasoValores VGSqlConn, "@o_fecha_ef", 1, SQLVARCHAR, ""
            PMPasoValores VGSqlConn, "@i_secuencial", 0, SQLVARCHAR, VLSsn
            If VGHorarioDif Then                                                         'hy-22-febrero-2007
                PMPasoValores VGSqlConn, "@i_hora_trama", 0, SQLVARCHAR, "D"
            Else                                                                         'hy-22-febrero-2007
                PMPasoValores VGSqlConn, "@i_hora_trama", 0, SQLVARCHAR, "H"
            End If                                                                       'hy-22-febrero-2007
    
            PMPasoValores VGSqlConn, "@i_pllave_municipal", 0, SQLVARCHAR, Trim$(txtLlaveMunicipal.Text)
            PMPasoValores VGSqlConn, "@i_ptipo_transaccion", 0, SQLINT4, "010006"
            PMPasoValores VGSqlConn, "@i_pfecha_hora_br", 0, SQLINT4, "00000000000000"
            PMPasoValores VGSqlConn, "@i_psecuencial__br", 0, SQLINT4, "000000"
            PMPasoValores VGSqlConn, "@i_phora_trx_local", 0, SQLINT4, Mid$(VLFecHora, 9, 6)
    
            'lfcm 20-junio-2007 (2 junio)
            'PMPasoValoresATX VGSqlConn, "@i_pfecha_trx_local", 0, SQLINT4, Mid$(VLFecHora, 3, 6), "", ""
            PMPasoValores VGSqlConn, "@i_pfecha_trx_local", 0, SQLINT4, Mid$(VLFecHora, 1, 8)
            
            'lfcm 20-junio-2007 (2 junio)
            'PMPasoValoresATX VGSqlConn, "@i_pfecha_comp", 0, SQLINT4, Mid$(VLFecHora, 3, 6), "", ""
            PMPasoValores VGSqlConn, "@i_pfecha_comp", 0, SQLINT4, Mid$(VLFecHora, 1, 8)
    
            PMPasoValores VGSqlConn, "@i_pinst_adquirente", 0, SQLINT4, "597777"
            PMPasoValores VGSqlConn, "@i_poperador", 0, SQLVARCHAR, String(6 - Len(Trim$(VGUsuario)), "0") + VGUsuario
            PMPasoValores VGSqlConn, "@i_psecuencial_adq", 0, SQLINT4, Trim(VLSsn)
            ' ame 08/28/2012 PMPasoValores VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, "1007" + String(6 - Len(Trim$(Str$(VGOficina))), "0") + Trim$(Str$(VGOficina)) + Mid$(VGterminal, 1, 6)
            PMPasoValores VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, "0233" + String(6 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) + Mid$(VGterminal, 1, 6)
            PMPasoValores VGSqlConn, "@i_pmoneda", 0, SQLINT4, "840"
            PMPasoValores VGSqlConn, "@i_pproducto", 0, SQLINT4, "0010031005"
            
            'lfcm 20-junio-2007 (11 lineas siguientes)
            'PMPasoValoresATX VGSqlConn, "@i_pvalores_pago1", 0, SQLVARCHAR, Mid$(VLItemSeleccionado, 1, 39), "", ""
            'PMPasoValoresATX VGSqlConn, "@i_pvalores_pago2", 0, SQLVARCHAR, Mid$(VLItemSeleccionado, 40, 25), "", ""
            'If VGTipoEjecucion% = CGReverso% Then
                'PMPasoValores VGSqlConn, "@i_pvalores_pago1", 0, SQLVARCHAR, VLValoresPago1, "", "", True
                'PMPasoValores VGSqlConn, "@i_pvalores_pago2", 0, SQLVARCHAR, VLValoresPago2, "", "", True
            PMPasoValores VGSqlConn, "@i_pvalores_pago1", 0, SQLVARCHAR, Mid$(VLItemSeleccionado, 1, 39)
            PMPasoValores VGSqlConn, "@i_pvalores_pago2", 0, SQLVARCHAR, Mid$(VLItemSeleccionado, 40, 25)
            'Else
            '    PMPasoValoresATX VGSqlConn, "@i_pvalores_pago1", 0, SQLVARCHAR, Mid$(VLItemSeleccionado, 1, 39), "", ""
            '    PMPasoValoresATX VGSqlConn, "@i_pvalores_pago2", 0, SQLVARCHAR, Mid$(VLItemSeleccionado, 40, 25), "", ""
            '    PMPasoValoresATX VGSqlConn, "@i_pvalores_pago1_2", 0, SQLVARCHAR, Mid$(VLItemSeleccionado, 21, 19), "", ""
            '    PMPasoValoresATX VGSqlConn, "@i_pvalores_pago2_2", 0, SQLVARCHAR, Mid$(VLItemSeleccionado, 60, 20), "", ""
            'End If
    
    
            PMPasoValores VGSqlConn, "@i_pcanal", 0, SQLVARCHAR, "001"
            PMPasoValores VGSqlConn, "@i_pimpuesto", 0, SQLVARCHAR, Trim$(Tipo.Text)
            
            'If VGTipoEjecucion% <> CGReverso% Then
            '    PMPasoValoresATX VGSqlConn, "@o_pautorizacion", 1, SQLVARCHAR, 0, "", ""
            'End If
            
            'If VGTipoEjecucion% = CGReverso% Then
                PMPasoValores VGSqlConn, "@i_preverso", 0, SQLVARCHAR, "4"
                'PMPasoValores VGSqlConn, "@i_pautorizacion", 0, SQLVARCHAR, VLAutorizacionMunCue, "", "", True
                PMPasoValores VGSqlConn, "@i_pautorizacion", 0, SQLVARCHAR, ""
                'lfcm 19-junio-2007 (2 lineas siguientes)
                'PMPasoValoresATX VGSqlConn, "@i_ptrx_original", 0, SQLVARCHAR, "0200" + VLSecuencialAdqMunCue + VLFechaMunCue + VLHoraMunCue + Trim$(VGterminal), "", "", True
                'PMPasoValores VGSqlConn, "@i_ptrx_original", 0, SQLVARCHAR, "0200" + VLSecuencialAdqMunCue + Format(VLFechaMunCue, "00000000") + VLHoraMunCue + "1007" + String(6 - Len(Trim$(Str$(VGOficina))), "0") + Trim$(Str$(VGOficina)) + Mid$(VGterminal, 1, 6)
                ' ame 08/28/2012 PMPasoValores VGSqlConn, "@i_ptrx_original", 0, SQLVARCHAR, "0200" + Trim(VLSsn) + Format(Mid$(VLFecHora, 1, 8), "00000000") + Format$(Time(), "hhmmss") + "1007" + String(6 - Len(Trim$(Str$(VGOficina))), "0") + Trim$(Str$(VGOficina)) + Mid$(VGterminal, 1, 6)
                PMPasoValores VGSqlConn, "@i_ptrx_original", 0, SQLVARCHAR, "0200" + Trim(VLSsn) + Format(Mid$(VLFecHora, 1, 8), "00000000") + Format$(Time(), "hhmmss") + "0233" + String(6 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) + Mid$(VGterminal, 1, 6)
                
                'VGErrorTransmision = False
            'End If
            
            VLMunCue_Emision = Trim$(Mid$(VLItemSeleccionado, 1, 8))
            VLMunCue_Exoneracion = Trim$(Mid$(VLItemSeleccionado, 9, 8))
            VLMunCue_Descuentos = Trim$(Mid$(VLItemSeleccionado, 17, 8))
            VLMunCue_Recargos = Trim$(Mid$(VLItemSeleccionado, 25, 8))
            VLMunCue_Intereses = Trim$(Mid$(VLItemSeleccionado, 40, 8))
            VLMunCue_Total = Trim$(Mid$(VLItemSeleccionado, 48, 8))
    
            PMPasoValores VGSqlConn, "@i_mc_emision", 0, SQLVARCHAR, VLMunCue_Emision
            PMPasoValores VGSqlConn, "@i_mc_exoneracion", 0, SQLVARCHAR, VLMunCue_Exoneracion
            PMPasoValores VGSqlConn, "@i_mc_descuentos", 0, SQLVARCHAR, VLMunCue_Descuentos
            PMPasoValores VGSqlConn, "@i_mc_recargos", 0, SQLVARCHAR, VLMunCue_Recargos
            PMPasoValores VGSqlConn, "@i_mc_intereses", 0, SQLVARCHAR, VLMunCue_Intereses
            PMPasoValores VGSqlConn, "@i_mc_total", 0, SQLVARCHAR, VLMunCue_Total
            PMPasoValores VGSqlConn, "@i_mc_direccion", 0, SQLVARCHAR, VLDireccion
            
            'If FMTransmitirRPC(VGSqlConn, "PSSRV", "cob_procesador", "fp_pago_municipio", True, "Transaccion Ok", "S", "N", "S", "19", "S", "S") = True Then
            If FMTransmitirRPC(VGSqlConn, "PSSRV", "cob_procesador", "fp_pago_municipio", True, "") Then
                
            End If
        End If
    End If
End Sub

Public Sub Muni_2236(Opcion As String, Opcion2 As Integer)
    'Wise - M. Libertad, Emision inicial -15/Agt/2008
    Select Case Opcion
    Case "1" 'Muestra campos para el Municipio de Libertad
        If Opcion2 = 0 Then
            Etiqueta2.Visible = False
            Etiqueta3.Caption = "Cod. Predial"
            Tipo.Visible = False
            Me.claveCatastral.Visible = False 'GAMC - 05/03/2008
            sal_tipo.Visible = False
            cat1.Visible = False
            cat2.Visible = False
            cat3.Visible = False
            cat4.Visible = False
            cat5.Visible = False
            cat6.Visible = False
            
            '-->lfcm 29-octubre-2008
            cat1.Top = 880
            cat2.Top = 880
            cat3.Top = 880
            cat4.Top = 880
            cat5.Top = 880
            cat6.Top = 880
            Etiqueta3.Top = 880
            '--<lfcm 29-octubre-2008
            
            Etiqueta5.Visible = False
            Etiqueta6.Visible = False
            Etiqueta8.Visible = False
            Semestre.Visible = False
            Predio.Visible = False
            Impto.Visible = False
            cedula.Visible = False
            
            Agno.Left = 2010
            Contribuyente.Height = 570
            txtLlaveMunicipal.Visible = False
            'txtCatasSamb.MaxLength = 20
            txtCatasSamb.Text = ""
            'txtCatasSamb.Width = 2000
            txtCatasSamb.Visible = True
            If VGTipoEjecucion% <> CGReverso% Then
                txtCatasSamb.SetFocus
            End If
        ElseIf Opcion2 = 1 Then
            Dim Impto_tmp As String
            Call Muni_2236("1", 0)
            PMSetValorReverso Me.txtCatasSamb, "@i_catastro2"
            PMSetValorReverso Impto, "@i_cod_impto"
            Impto.Tag = Impto.Caption
            Impto.Caption = ""
            PMSetValorReverso Impto, "@i_nom_impto"
            Impto_tmp = Impto.Caption
            Impto.Caption = Impto.Tag
            Impto.Tag = Impto_tmp
            Predio = Me.txtCatasSamb.Text
            
            PMSetValorReverso txtPapeletaSamb, "@o_referencia2"
            VLMuniSamb(0) = txtPapeletaSamb.Text
            txtPapeletaSamb.Text = ""
            PMSetValorReverso txtPapeletaSamb, "@o_direccion"
            VLMuniSamb(1) = txtPapeletaSamb.Text
            txtPapeletaSamb.Text = ""
            PMSetValorReverso txtPapeletaSamb, "@o_solar"
            VLMuniSamb(2) = txtPapeletaSamb.Text
            txtPapeletaSamb.Text = ""
            PMSetValorReverso txtPapeletaSamb, "@o_valorpredio"
            VLMuniSamb(3) = txtPapeletaSamb.Text
            txtPapeletaSamb.Text = ""
            PMSetValorReverso txtPapeletaSamb, "@o_valorotros"
            VLMuniSamb(4) = txtPapeletaSamb.Text
            txtPapeletaSamb.Text = ""
            PMSetValorReverso txtPapeletaSamb, "@o_doc_ident"
            VLMuniSamb(5) = txtPapeletaSamb.Text
            txtPapeletaSamb.Text = ""
            PMSetValorReverso txtPapeletaSamb, "@i_ofiretiro"
        End If
    Case "2" 'Transmitir
        'Dim vltmp As String
        'Dim vlclvcatastral As String
        'Dim i As Byte
        'msilvag Inicio SOA Fase2 Otros Municipios
        If vl_servidor_BUS = "PSSRV1" Then
            PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
        Else
            PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 62645, "Trn", ""
            If VGTipoEjecucion% <> CGReverso% Then
                PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLCHAR, "N", "TCorr", ""
            End If
            PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLCHAR, "VEN", "Canal", ""
        End If
        'msilvag Fin SOA Fase2
        PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "T", "opcion", ""
        PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
        PMPasoValoresATX VGSqlConn, "@i_cod_impto", 0, SQLCHAR, (Impto.Caption), "tipo", ""
'        For i = 1 To Len(Me.claveCatastral.Text)
'            If Mid(Me.claveCatastral.Text, i, 1) = "-" Then
'                vltmp = "-"
'                vlclvcatastral = vlclvcatastral & vltmp
'            ElseIf Mid(Me.claveCatastral.Text, i, 1) <> "_" Then
'                vltmp = FMValidarNumero((Mid(Me.claveCatastral.Text, i, 1)), 10, CInt(Mid(Me.claveCatastral.Text, i, 1)), "19")
'                vlclvcatastral = vlclvcatastral & vltmp
'            End If
'        Next
        'If vlclvcatastral <> "" Then
        '    PMPasoValoresATX VGSqlConn, "@i_catastro2", 0, SQLVARCHAR, vlclvcatastral, "Catastro", ""
        'Else
            PMPasoValoresATX VGSqlConn, "@i_catastro2", 0, SQLVARCHAR, (Me.txtCatasSamb.Text), "Catastro", ""
        'End If
        'OJO - Poner la prioridad
        PMPasoValoresATX VGSqlConn, "@i_prioridad", 0, SQLINT4, val(Prioridad.Text), "Prioridad", ""
        
        PMPasoValoresATX VGSqlConn, "@i_agno", 0, SQLINT4, val(Agno.Caption), "Autorizacion", ""
        PMPasoValoresATX VGSqlConn, "@i_semestre", 0, SQLVARCHAR, (Semestre.Caption), "Autorizacion", ""
        'PMPasoValoresATX VGSqlConn, "@i_referencia2", 0, SQLVARCHAR, (Prioridad.Text), "Referencia", ""
        PMPasoValoresATX VGSqlConn, "@i_nombre", 0, SQLVARCHAR, (Contribuyente.Caption), "Nombre", ""
        PMPasoValoresATX VGSqlConn, "@i_nom_impto", 0, SQLCHAR, (Impto.Tag), "nomimpto", ""
        PMPasoValoresATX VGSqlConn, "@i_fecven", 0, SQLCHAR, (VLGridFecVen), "fecven", ""
        PMPasoValoresATX VGSqlConn, "@i_ofiretiro", 0, SQLVARCHAR, (txtPapeletaSamb.Text), "OficinaRetiro", ""
        'txtPapeletaSamb.Text = ""
        PMPasoValoresATX VGSqlConn, "@i_efe", 0, SQLMONEY, (efe.Text), "efe", ""
        PMPasoValoresATX VGSqlConn, "@i_cant_chq", 0, SQLINT4, val(CantChq.Text), "Moneda", ""
        PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, (Cheques.Text), "Cheques", ""
        PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(FMObtenerMonedaForma("19")), "Moneda", ""
        PMPasoValoresATX VGSqlConn, "@i_autoriza", 0, SQLVARCHAR, VGAutoriza, "Autorizacion", ""
        PMPasoValoresATX VGSqlConn, "@i_supautor", 0, SQLVARCHAR, VGSuperAutoriza$, "Supervisor de Monto", ""
        PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, (Debito.Text), "Debito", ""
        PMPasoValoresATX VGSqlConn, "@i_tarjeta", 0, SQLMONEY, (Tarjeta.Text), "Tarjeta", ""
        'ref003 Ini
        If Me.Cta.ClipText <> "" Then
          PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (CboTipCta.Text), "CboTipCta", ""
        PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
        Else
          PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (VLTipCta_com), "CboTipCta", ""
          PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (VLCta_com), "Cta", ""
        End If
        'ref003 Fin
        'PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
        'PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (CboTipCta.Text), "CboTipCta", ""
        PMPasoValoresATX VGSqlConn, "@i_contribuyente", 0, SQLVARCHAR, (Contribuyente.Caption), "contribuyente", ""
        PMPasoValoresATX VGSqlConn, "@i_valor_mun", 0, SQLMONEY, (ValorMun.Text), "valormun", ""
        
        PMPasoValoresATX VGSqlConn, "@i_tipo_impto", 0, SQLVARCHAR, (Tipo), "tipoimpto", ""
        PMPasoValoresATX VGSqlConn, "@i_totaltrama", 0, SQLMONEY, (ValorMun), "cat1", ""
        PMPasoValoresATX VGSqlConn, "@i_horatrama", 0, SQLVARCHAR, Mid$(VLFecHora, 9, 6), "hora", ""
        PMPasoValoresATX VGSqlConn, "@i_vlfechora", 0, SQLVARCHAR, VLFecHora, "vlfechora", ""
        PMPasoValoresATX VGSqlConn, "@i_vlfeccontable", 0, SQLVARCHAR, VLFecContable, "vlfeccontable", ""
        PMPasoValoresATX VGSqlConn, "@i_vlexoneracion", 0, SQLVARCHAR, VLExoneracion, "vlexoneracion", ""
        PMPasoValoresATX VGSqlConn, "@i_vlavaluocomercial", 0, SQLVARCHAR, VLAvaluoComercial, "vlavaluocomercial", ""
        PMPasoValoresATX VGSqlConn, "@i_VLIdentificacion", 0, SQLVARCHAR, VLIdentificacion, "VLIdentificacion", ""  'hy-22-septiembre-2006
        PMPasoValoresATX VGSqlConn, "@i_valimpto", 0, SQLMONEY, "0", "valimpto", ""
        PMPasoValoresATX VGSqlConn, "@i_valinteres", 0, SQLMONEY, "0", "valinteres", ""
            
        PMPasoValoresATX VGSqlConn, "@i_sal_municipio", 0, SQLVARCHAR, (sal_municipio.Caption), "sal_municipio", ""
        PMPasoValoresATX VGSqlConn, "@i_sal_tipo", 0, SQLVARCHAR, (sal_tipo.Caption), "sal_tipo", ""
        PMPasoValoresATX VGSqlConn, "@i_desc_impto", 0, SQLVARCHAR, (DescripImpto.Text), "sal_tipo", ""
        PMPasoValoresATX VGSqlConn, "@i_direccion", 0, SQLVARCHAR, (direccion.Text), "direccion", ""
        
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
        
        If vl_servidor_BUS = "PSSRV1" Then 'msilvag Otros Municipios
            PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, "0", "SecTrn", ""
            PMPasoValoresATX VGSqlConn, "@o_horario", 1, SQLCHAR, Space(1), "Horario", ""
            
            PMPasoValoresATX VGSqlConn, "@o_autorisri", 1, SQLVARCHAR, VLautoriSri, "AutorizacionSRI", ""
            PMPasoValoresATX VGSqlConn, "@o_fecvensri", 1, SQLVARCHAR, VLFecvenSRI, "Stk", ""
            PMPasoValoresATX VGSqlConn, "@o_fechora", 1, SQLVARCHAR, 0, "Fechora", ""
            PMPasoValoresATX VGSqlConn, "@o_feccontable", 1, SQLVARCHAR, 0, "Feccontable", ""
            PMPasoValoresATX VGSqlConn, "@o_fecha_ef", 1, SQLVARCHAR, "", "Fechaefe", ""
            PMPasoValoresATX VGSqlConn, "@o_nota_venta", 1, SQLVARCHAR, VLSerie_Secuencia, "Nota_venta", ""
            
            '- CAPTURAR LOS PARAMETROS DE SALIDA
            PMPasoValoresATX VGSqlConn, "@o_referencia2", 1, SQLVARCHAR, "", "Referencia2", ""
            PMPasoValoresATX VGSqlConn, "@o_direccion", 1, SQLVARCHAR, "", "Direccion2", ""
            PMPasoValoresATX VGSqlConn, "@o_solar", 1, SQLVARCHAR, "", "Solar2", ""
            PMPasoValoresATX VGSqlConn, "@o_valorpredio", 1, SQLMONEY, "", "ValorPredio2", ""
            PMPasoValoresATX VGSqlConn, "@o_valorotros", 1, SQLMONEY, "0", "ValorOtros2", ""
            PMPasoValoresATX VGSqlConn, "@o_doc_ident", 1, SQLVARCHAR, "", "Ced/Ruc/Pas", ""
            PMPasoValoresATX VGSqlConn, "@o_nombcta", 1, SQLVARCHAR, (Nombre.Text), "nombre", ""
        'msilvag Inicio Otros Municipios
        Else
            PMPasoValoresATX VGSqlConn, "@o_referencia2", 1, SQLVARCHAR, "XXXXXXXXXXXXXXXXXXXX", "Referencia2", ""
            PMPasoValoresATX VGSqlConn, "@o_direccion", 1, SQLVARCHAR, "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "Direccion2", ""
            PMPasoValoresATX VGSqlConn, "@o_solar", 1, SQLVARCHAR, "XXXXXXXXXXXXXXX", "Solar2", ""
            PMPasoValoresATX VGSqlConn, "@o_valorpredio", 1, SQLMONEY, "0", "ValorPredio2", ""
            PMPasoValoresATX VGSqlConn, "@o_valorotros", 1, SQLMONEY, "0", "ValorOtros2", ""
            PMPasoValoresATX VGSqlConn, "@o_doc_ident", 1, SQLVARCHAR, "XXXXXXXXXXXXXXX", "Ced/Ruc/Pas", ""
            PMPasoValoresATX VGSqlConn, "@o_nombcta", 1, SQLVARCHAR, (Nombre.Text), "nombre", ""
        End If
        'msilvag Fin
    Case "3" 'Imprimir Comprobante
        VGparlong$ = "90"
        VGpartop$ = "10"
        VGparleft$ = "10"
        VGparrig$ = "00"
        
        PMSetDetalle "v" + "Este pago sera procesado el " + VLFechaEfe
        'PMSetDetalle "v" + " "
        PMSetDetalle "v" + "EMPRESA    : " + Trim$(municipio.Text) + " " + Trim$(Mid$(sal_municipio.Caption, 1, 36))
        PMSetDetalle "v" + "IMPUESTO   : " + Trim$(Impto.Caption) + "-" + Trim$(Impto.Tag)
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "CODIGO PREDIAL     : " + Trim$(Me.txtCatasSamb.Text)  '+ "      " + VLMuniSamb(0)  '29/Agt/2008
        PMSetDetalle "v" + "PERIODO TRIBUTACION: " + Trim$(Agno.Caption) ' + " FEC.VENC: " + VLGridFecVen
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "CONTRIBUYENTE      : " + Trim$(Left(Contribuyente.Caption, 35))
        PMSetDetalle "v" + "CEDULA/RUC/PASAP   : " + Trim$(Mid$(VLMuniSamb(5), 1, 30))
        'PMSetDetalle "v" + "SOLAR              : " + Trim$(Mid$(VLMuniSamb(2), 1, 30))
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "CONCEPTO"
        PMSetDetalle "v" + "-------------------------------------------------"
        Dim VLTemporal As String
        VLTemporal = Trim$(Impto.Tag)
        VLTemporal = Mid$(VLTemporal, 1, 19)
        VLTemporal = VLTemporal + String(19 - Len(VLTemporal), " ")
        'PMSetDetalle "v" + VLTemporal + ": " + FMEspaciosATX("USD      " + Format(Trim$(VLGridImpuestos), VGFormatoMoney), 5, CGJustificacionDerecha)
        'PMSetDetalle "v" + "PREDIO RUBANO      : " + FMEspaciosATX("USD      " + Format(Trim$(VLMuniSamb(3)), VGFormatoMoney), 13, CGJustificacionDerecha)
        PMSetDetalle "v" + VLTemporal + ": " + FMEspaciosATX("USD      " + Format(Trim$(VLMuniSamb(3)), VGFormatoMoney), 13, CGJustificacionDerecha)
        PMSetDetalle "v" + "DESC/INTERES/RECAR : " + FMEspaciosATX("USD      " + Format(Trim$(VLMuniSamb(4)), VGFormatoMoney), 13, CGJustificacionDerecha)
        PMSetDetalle "v" + "TOTAL A PAGAR      : " + FMEspaciosATX("USD      " + Format(Trim$(ValorMun.Text), VGFormatoMoney), 13, CGJustificacionDerecha)
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "FORMAS DE PAGO:"
        PMSetDetalle "v" + "-------------------------------------------------"
        If val(efe.Text) > 0 Then
            PMSetDetalle "v" + "EFECTIVO           : " + FMEspaciosATX("USD      " + Format(efe, VGFormatoMoney), 13, CGJustificacionDerecha)
        End If
        If val(Cheques.Text) > 0 Then
            PMSetDetalle "v" + "CHEQUE(" + Trim$(CantChq.Text) + ")          : " + FMEspaciosATX("USD      " + Format(Cheques, VGFormatoMoney), 13, CGJustificacionDerecha)
        End If
        If val(Debito.Text) > 0 Then
            PMSetDetalle "v" + "DEBITO             : " + FMEspaciosATX("USD      " + Format(Debito, VGFormatoMoney), 13, CGJustificacionDerecha) + " CUENTA : " + Format(Cta.ClipText, "000-000000-0")
        End If
        If val(Tarjeta.Text) > 0 Then
            PMSetDetalle "v" + "TARJETA CREDITO    : " + FMEspaciosATX("USD      " + Format(Tarjeta, VGFormatoMoney), 13, CGJustificacionDerecha)
        End If

'***ref02 vmirandt inicio, se imprime al final del documento
    If VLclave_acceso <> "" Then
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + "Clave de Acceso/Autorizacion: "
        PMSetDetalle "v" + VLclave_acceso
    End If
    'ref02 vmirandt
    
        PMSetDetalle "v" + "-------------------------------------------------"
        PMSetDetalle "v" + " "
        PMSetDetalle "v" + "AVISO: PARA RETIRAR SU TITULO DE CREDITO, "
        PMSetDetalle "v" + "ACERCARSE CON ESTE COMPROBANTE A LAS VENTANILLAS DE LA"
        PMSetDetalle "v" + "OFICINA " & Me.VLOficinaRetiro
        If VLHorario = "N" Then
            PMSetDetalle "v" + "DEL BANCO BOLIVARIANO, LUEGO DE 3 DIAS LABORABLES"
            PMSetDetalle "v" + "DE HABER REALIZADO EL PAGO"
        Else
            PMSetDetalle "v" + "DEL BANCO BOLIVARIANO, LUEGO DE 4 DIAS LABORABLES"
            PMSetDetalle "v" + "DE HABER REALIZADO EL PAGO"
        End If
        PMSetDetalle "v" + ""
        
        VLHorarioDifTemporal = VGHorarioDif
        
'        If VLHorario = "N" Then
'            VGHorarioDif = False
'            VLTrn = "3215"
'        Else
'            VGHorarioDif = True
'            VLTrn = "3216"
'            VLHorario = "D" 'Wise 01/Sept/2008 - Aparesca en Papeleta.  H:D  --> H.Diferido
'        End If
        
        If VGTipoEjecucion% <> CGReverso% Then
            If VLHorario = "N" Then
                VGHorarioDif = False
                VLTrn = "3215"
            Else
                VGHorarioDif = True
                VLTrn = "3216"
                VLHorario = "D"
            End If
        End If
        If VGTipoEjecucion% = CGReverso% Then
            If VGHorarioDif = False Then
                VLTrn = "3215"
                VLHorario = "N"
            Else
                VLTrn = "3216"
                VLHorario = "D"
            End If
        End If
        
        
        FMPRN_StdImpresion "IMPRESORA_1", False, Trim$(str$(VLTsnTemporal)), "19", SGDatosDetalle, "Inserte papeleta", CStr(VGpartop$), 1, CStr(VGparleft$), , , VLHorario, , , "1", VLTrn
        VGHorarioDif = VLHorarioDifTemporal
        
        If VGTipoEjecucion = CGNormal% Then
            While MsgBox("Desea Reimprimir la papeleta para certificacion?", vbYesNo, "Mensaje") = vbYes
                PMReimpresion
            Wend
        End If
    Case "4" 'Mensajes de Ayuda
        FPrincipal!pnlHelpLine.Caption = "Digite Código Predial"
        If Opcion2 = 13 Then
            SendKeys "{RIGHT}"
        End If
    End Select
End Sub


Function FLTransmitir_MUNGYE_CEP_consulta() As Boolean
 Dim VLArregloPago1 As String
    Dim VLArregloPago2 As String
    
    Dim FechaVigencia1 As String
    Dim FechaVigencia2 As String
    
    FLTransmitir_MUNGYE_CEP_consulta = False
    
  If Trim$(Me.CEP.Text) = "" Then
      MsgBox "El CEP es mandatoria", vbCritical, "Aviso"
      If Me.CEP.Enabled Then
        Me.CEP.SetFocus
      End If
      Exit Function
   End If
   
'   If Len(Me.CEP.Text) <> 0 Then
'      If FMValidaCedulaRuc(Me.CEP.Text) = False Then
'         If Me.CEP.Enabled Then
'            Me.CEP.SetFocus
'         End If
'         Exit Function
'      End If
'   End If
      
   '-->Consulta el valor de la comision
   If VGHorarioDif Then
      VLTrn = "3216"
   Else
      VLTrn = "3215"
   End If
   VGTrn = IIf(VLTrn = "", 0, VLTrn)
    
   'Consulta de mercados y credenciales
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "S", "opcion", ""
    PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@o_fechora", 1, SQLVARCHAR, 0, "Fechora", ""
    PMPasoValoresATX VGSqlConn, "@o_feccontable", 1, SQLVARCHAR, 0, "Feccontable", ""
    PMPasoValoresATX VGSqlConn, "@o_secuencial", 1, SQLINT4, 0, "Secuencial", ""
   If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_tr_municipio_recaudacion", True, "Transaccion Ok", "S", "N", "N", "19", "S", "S") = True Then
        VLFecHora = FMRetParamATX(VGSqlConn, 1)
        VLFecContable = FMRetParamATX(VGSqlConn, 2)
        VLSsn = FMRetParamATX(VGSqlConn, 3)
        If Len(Trim$(VLSsn)) > 6 Then
            VLSsn = Right$(Trim$(VLSsn), 6)
        Else
            VLSsn = String(6 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
        End If
        PMChequeaATX VGSqlConn
        PMTotalesBranch "19"
        'FLConsultar = True
        FLTransmitir_MUNGYE_CEP_consulta = True
        VLCambio% = False
        '------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 3)
        VTIndicadorSum = 1
        PMIniciaRegSum
        PMFinTransaccion
        '<-----
    Else
        VLCambio% = True
        'FLConsultar = False
        FLTransmitir_MUNGYE_CEP_consulta = False
        '------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 3)
        VTIndicadorSum = 0
        PMChequeaATX VGSqlConn
        PMFinTransaccion
        Exit Function
        '<------
    End If
    
     VLPagosAnio = "0"
     VLPagosValor = 0
   
    FLTransmitir_MUNGYE_CEP_consulta = False
    Consulta_parametro_OSB 'SOA fase2
     
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 62073, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "C", "opcion", ""
    PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
    
    'Fecha formato yyyymmdd
    VLFecContable_aaaammdd = FMConvFecha(VLFecContable, "mm/dd/yyyy", "yyyy/mm/dd")
    VLFecContable_aaaammdd = Mid(VLFecContable_aaaammdd, 1, 4) & Mid(VLFecContable_aaaammdd, 6, 2) & Mid(VLFecContable_aaaammdd, 9, 2)

     'Parametros esperador por el CPS
    PMPasoValoresATX VGSqlConn, "@i_ptipo_transaccion", 0, SQLINT4, 310000, "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_hora_br", 0, SQLVARCHAR, VLFecContable_aaaammdd & Format$(Time(), "hhmmss"), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_psecbr", 0, SQLINT4, "000001", "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_pcomp", 0, SQLINT4, "2245", "mun_cod", ""
    PMPasoValoresATX VGSqlConn, "@i_phora_trx_local", 0, SQLINT4, Format$(Time(), "hhmmss"), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_trx_local", 0, SQLVARCHAR, VLFecContable_aaaammdd, "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_comp", 0, SQLINT4, VLFecContable_aaaammdd, "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Canal", ""
    
    PMPasoValoresATX VGSqlConn, "@i_serv_code", 0, SQLVARCHAR, "01", "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_pinst_adquirente", 0, SQLVARCHAR, "00597777", "mun_aba", ""
    PMPasoValoresATX VGSqlConn, "@i_pcod_adquirente", 0, SQLVARCHAR, "0233", "muni_codIntAdq", ""
    PMPasoValoresATX VGSqlConn, "@i_pchanal", 0, SQLVARCHAR, "9", "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_poperador", 0, SQLVARCHAR, String(9 - Len(Trim$(VGUsuario)), "0") + VGUsuario, "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_psecuencial_adq", 0, SQLINT4, Trim$(VLSsn), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, "0233000000" & Mid$(VGterminal, 1, 6), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_cep", 0, SQLVARCHAR, CEP.Text, "identificacion", ""
    PMPasoValoresATX VGSqlConn, "@i_pmoneda", 0, SQLINT4, "840", "mon", ""
    ' "C"=Credencial "P"=Puesto de Mercado
    If Trim$(Tipo.Text) <> "" Then
        PMPasoValoresATX VGSqlConn, "@i_ptipo_consulta", 0, SQLCHAR, (Tipo.Text), "tipo", ""
    End If
    PMPasoValoresATX VGSqlConn, "@i_pproducto", 0, SQLVARCHAR, "0010031008", "", ""
    VGDebugFile = True
    
    
    PMPasoValoresATX VGSqlConn, "@o_codAutoriza", 1, SQLINT4, "0", "SecAutor", ""   'smerino
    PMPasoValoresATX VGSqlConn, "@o_valor", 1, SQLVARCHAR, Space(15), "valor", "" 'smerino
     
    If FMTransmitirRPCATX(VGSqlConn, vl_servidor_BUS, "cob_procesador", "fp_consulta_mimg_cep", True, "Transaccion Ok", "S", "N", "N", "19", "S", "S") = True Then
    'If FMTransmitirRPCATX(VGSqlConn, "PSSRV1", "cob_procesador", "fp_consulta_mercados_mimg", True, "Transaccion Ok", "S", "N", "N", "19", "S", "S") = True Then
        FLTransmitir_MUNGYE_CEP_consulta = True
        VTResult% = FMMapeaMatrizATX(VGSqlConn&, vtmatrizcps())
        VLAutorizacionCep = FLBuscarItem("@o_pautorizacion")
        VLContribuyente = FLBuscarItem("@o_pnombres")
        Contribuyente.Caption = VLContribuyente
        'VLIdenDeuda = FLBuscarItem("@o_pvalor_total")  '@o_pnombre
        ValorMun.Text = CDbl(FLBuscarItem("@o_pvalor_total")) / 100
        Total.Text = CDbl(ValorMun.Text) + CDbl(Comision)  'smerino
        VLIdentificacion = FLBuscarItem("@o_pcuic") 'CI
        VLCodPredial = FLBuscarItem("@o_pnumero")  'COD PREDIAL
        VLTipoServicio = FLBuscarItem("@o_pcodigo_liquidacion")
        VLObservacion1 = FLBuscarItem("@o_observacion1")
        VLObservacion2 = FLBuscarItem("@o_observacion2")
        VLObservacion3 = FLBuscarItem("@o_observacion3")
        Consulta_tipoCep 'consulta la descripcion del cep
        VLFlagSumadora = False  'hy-15-feb-2006
        VTIndicadorSum = 1
        SGActivaSum = False 'smerino para que muetsre la sumador
        Frame1.Enabled = True
        efe.Enabled = True
        efe.SetFocus 'smerino
        Me.CEP.Enabled = False
         
                 'efe.SetFocus
'
'
'        If Trim$(VLArregloPago1) = "" Then
'            MsgBox "NO TIENE DEUDAS PENDIENTES", vbInformation, "Aviso"
'            Exit Function
'        End If

        'ref003
        SGEmpresa = municipio.Text
        
   Else
        'SGActivaSum = False 'smerino para que muetsre la sumador
        PMChequeaATX VGSqlConn
    End If
    PMChequeaATX VGSqlConn
    PMFinTransaccion
        
End Function
Function FLTransmitir_MUNGYE_CEP_pago() As Boolean
 Dim VTIndicadorSum As Integer
  Dim VLIndReverso As Boolean
  VTIndicadorSum = 0

   FLTransmitir_MUNGYE_CEP_pago = False
   
   Consulta_parametro_OSB 'msilvag SOA fase2

    If VGHorarioDif Then
        VLTrn = "3216"
    Else
        VLTrn = "3215"
    End If

     VGTrn = IIf(VLTrn = "", 0, VLTrn)

    VLIndReverso = False
    If VGTipoEjecucion% = CGReverso% Then
        VGTipoEjecucion% = CGNormal%
        VLIndReverso = True
    End If
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "S", "opcion", ""
    PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@o_fechora", 1, SQLVARCHAR, 0, "Fechora", ""
    PMPasoValoresATX VGSqlConn, "@o_feccontable", 1, SQLVARCHAR, 0, "Feccontable", ""
    PMPasoValoresATX VGSqlConn, "@o_secuencial", 1, SQLINT4, 0, "Secuencial", ""

     If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_tr_municipio_recaudacion", True, "Transaccion Ok", "S", "N", "N", "19", "S", "S") = True Then
        VLFecHora = FMRetParamATX(VGSqlConn, 1)
        VLFecContable = FMRetParamATX(VGSqlConn, 2)
        VLSsn = FMRetParamATX(VGSqlConn, 3)
        If Len(Trim$(VLSsn)) > 6 Then
            VLSsn = Right$(Trim$(VLSsn), 6)
         Else
            VLSsn = String(6 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
        End If
        PMChequeaATX VGSqlConn
        PMTotalesBranch "19"

        FLTransmitir_MUNGYE_CEP_pago = True
        VLCambio% = False
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 3)
        VTIndicadorSum = 1
        PMIniciaRegSum
         Else
        VLCambio% = True
        FLTransmitir_MUNGYE_CEP_pago = False
        '------> Sumadora
        'SGSecTrn$ = FMRetParamATX(VGSqlConn, 3)
        VTIndicadorSum = 0
        PMChequeaATX VGSqlConn
        PMFinTransaccion
        Exit Function
    End If
        PMChequeaATX VGSqlConn
        If FMRetStatusATX(VGSqlConn) <> 0 Then
            VTIndicadorSum = 0
            FLTransmitir_MUNGYE_CEP_pago = False
            PMFinTransaccion
             Exit Function
            End If
        PMFinTransaccion

        If VLIndReverso Then
        VLIndReverso = False
        VGTipoEjecucion% = CGReverso%
        End If

        FLTransmitir_MUNGYE_CEP_pago = False

        If VGTipoEjecucion% = CGReverso% Then
        VLSsn = Trim$(str$(VGSqlConn))
        End If
        If Len(Trim$(VLSsn)) > 6 Then
        VLSsn = Right$(Trim$(VLSsn), 6)
         Else
        VLSsn = String(6 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
        End If

        PMChequeaATX VGSqlConn
        VLFecContable_aaaammdd = FMConvFecha(VLFecContable, "mm/dd/yyyy", "yyyy/mm/dd")
        VLFecContable_aaaammdd = Mid(VLFecContable_aaaammdd, 1, 4) & Mid(VLFecContable_aaaammdd, 6, 2) & Mid(VLFecContable_aaaammdd, 9, 2)

    VLIndReverso = False
    If VGTipoEjecucion% = CGReverso% Then
        'VGTipoEjecucion% = CGNormal%
        VLIndReverso = True
    End If
    
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 62074, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "T", "opcion", ""
    PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_desmun", 0, SQLVARCHAR, (Me.sal_municipio.Caption), "DescMun", ""
    PMPasoValoresATX VGSqlConn, "@i_cep", 0, SQLVARCHAR, CEP.Text, "identificacion", ""
    PMPasoValoresATX VGSqlConn, "@i_sal_tipo", 0, SQLVARCHAR, (sal_tipo.Caption), "descripcion", ""
    
    PMPasoValoresATX VGSqlConn, "@i_nombre", 0, SQLVARCHAR, (Contribuyente.Caption), "Nombre", ""
    PMPasoValoresATX VGSqlConn, "@i_efe", 0, SQLMONEY, (efe.Text), "efe", ""
    PMPasoValoresATX VGSqlConn, "@i_cant_chq", 0, SQLINT4, val(CantChq.Text), "Moneda", ""
    PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, (Cheques.Text), "Cheques", ""
    PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(FMObtenerMonedaForma("19")), "Moneda", ""
    PMPasoValoresATX VGSqlConn, "@i_autoriza", 0, SQLVARCHAR, VGAutoriza, "Autorizacion", ""
    PMPasoValoresATX VGSqlConn, "@i_supautor", 0, SQLVARCHAR, VGSuperAutoriza$, "Supervisor de Monto", ""
    PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, (Debito.Text), "Debito", ""
    PMPasoValoresATX VGSqlConn, "@i_tarjeta", 0, SQLMONEY, (Tarjeta.Text), "Tarjeta", ""
    'ref003 Ini
    If Me.Cta.ClipText <> "" Then
      PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (CboTipCta.Text), "CboTipCta", ""
    PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
    Else
      PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (VLTipCta_com), "CboTipCta", ""
      PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (VLCta_com), "Cta", ""
    End If
    'PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
    'PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (CboTipCta.Text), "CboTipCta", ""
    'ref003 Fin
    PMPasoValoresATX VGSqlConn, "@i_efe_com", 0, SQLMONEY, (VLEfe_com), "Com. efectivo", ""
    PMPasoValoresATX VGSqlConn, "@i_chq_com", 0, SQLMONEY, (VLChq_com), "Com. Cheques", ""
    PMPasoValoresATX VGSqlConn, "@i_deb_com", 0, SQLMONEY, (VLDeb_com), "Com. Debito", ""
    'PMPasoValoresATX VGSqlConn, "@i_tipocta_com", 0, SQLCHAR, (VLTipCta_com), "Com. TipCta", ""
    
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

    'PMPasoValoresATX VGSqlConn, "@i_cta_com", 0, SQLVARCHAR, (VLCta_com), "Com. Cta", ""
    
    If VGTipoEjecucion% = CGReverso% Then
        PMPasoValoresATX VGSqlConn, "@i_preverso", 0, SQLVARCHAR, "02", "", "", True
        VGTipoEjecucion% = CGNormal%
        PMPasoValoresATX VGSqlConn, "@i_pcodigo_puesto", 0, SQLVARCHAR, (VLAutorizacion), "cod_autoriza", ""
        VGTipoEjecucion% = CGReverso%
    Else
        PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLVARCHAR, "N", "", ""
    End If
    
    PMPasoValoresATX VGSqlConn, "@i_secuencial", 0, SQLVARCHAR, Format(VLSsn, "000000"), "", ""
    PMPasoValoresATX VGSqlConn, "@i_ptipo_transaccion", 0, SQLVARCHAR, "45109M", "tipotran", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_hora_br", 0, SQLVARCHAR, VLFecContable_aaaammdd & Format$(Time(), "hhmmss"), "vlfec", ""
    PMPasoValoresATX VGSqlConn, "@i_psecbr", 0, SQLVARCHAR, "000001", "", ""
    PMPasoValoresATX VGSqlConn, "@i_phora_trx_local", 0, SQLINT4, Format$(Time(), "hhmmss"), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_trx_local", 0, SQLINT4, VLFecContable_aaaammdd, "", ""
    PMPasoValoresATX VGSqlConn, "@i_serv_code", 0, SQLVARCHAR, "01", "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Canal", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_comp", 0, SQLINT4, VLFecContable_aaaammdd, "", ""
    PMPasoValoresATX VGSqlConn, "@i_pinst_adquirente", 0, SQLVARCHAR, "00597777", "mun_aba", ""
    PMPasoValoresATX VGSqlConn, "@i_pcod_adquirente", 0, SQLVARCHAR, "0233", "muni_codIntAdq", ""
    PMPasoValoresATX VGSqlConn, "@i_poperador", 0, SQLVARCHAR, String(9 - Len(Trim$(VGUsuario)), "0") + VGUsuario, "", ""
    PMPasoValoresATX VGSqlConn, "@i_psecuencial_adq", 0, SQLINT4, Format(VLSsn, "000000"), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, "0233" + String(6 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pproducto", 0, SQLVARCHAR, "0010031008", "", ""
    PMPasoValoresATX VGSqlConn, "@i_pid_deuda", 0, SQLVARCHAR, Trim$(Me.Agno.Caption), "tipoimpto", ""
    PMPasoValoresATX VGSqlConn, "@i_ptipo_consulta", 0, SQLCHAR, (Tipo.Text), "tipo", ""
    PMPasoValoresATX VGSqlConn, "@i_pmoneda", 0, SQLINT4, "840", "mon", ""
    PMPasoValoresATX VGSqlConn, "@i_pcomp", 0, SQLINT4, "2245", "mun_cod", ""

    '-->Parametros requeridos por el CPS para armar la trama.
    PMPasoValoresATX VGSqlConn, "@i_pchanal", 0, SQLVARCHAR, "9", "", ""
    PMPasoValoresATX VGSqlConn, "@i_tipo_impto", 0, SQLVARCHAR, (Tipo), "tipoimpto", ""

        
    
    PMPasoValoresATX VGSqlConn, "@i_pid_pago", 0, SQLCHAR, (Tipo.Text), "tipo", ""
    PMPasoValoresATX VGSqlConn, "@i_pvalor_total", 0, SQLMONEY, (Me.ValorMun.Text), "ValorMun", ""
    PMPasoValoresATX VGSqlConn, "@i_ptrx_original", 0, SQLVARCHAR, "0200" + Format(VLSsn, "000000") + Format(VLFecContable_aaaammdd, "00000000") + Format$(Time(), "hhmmss") + "0233" + String(6 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", "", True
    PMPasoValoresATX VGSqlConn, "@i_pvalores_pago1", 0, SQLVARCHAR, Mid(VLArregloMunCre, 1, 28), "", ""
    PMPasoValoresATX VGSqlConn, "@i_nombcta", 0, SQLVARCHAR, (Nombre.Text), "nombrecta", ""
    PMPasoValoresATX VGSqlConn, "@i_desmon", 0, SQLVARCHAR, (lblMoneda.Caption), "desmon", ""
   
   ' Parametros de Output
   PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, 0, "", ""
   PMPasoValoresATX VGSqlConn, "@o_horario", 1, SQLCHAR, "x", "", ""
   PMPasoValoresATX VGSqlConn, "@o_autorisri", 1, SQLVARCHAR, "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "OAutoriSri", ""
   PMPasoValoresATX VGSqlConn, "@o_fecvensri", 1, SQLVARCHAR, "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "OFecVenSri", ""
   PMPasoValoresATX VGSqlConn, "@o_fechora", 1, SQLVARCHAR, "xxxxxxxxxxxxxxxx", "OFechaHora", ""
   PMPasoValoresATX VGSqlConn, "@o_feccontable", 1, SQLVARCHAR, "XXXXXXXXXX", "OFechaContable", ""
   PMPasoValoresATX VGSqlConn, "@o_fecha_ef", 1, SQLVARCHAR, "xxxxxxxxxx", "", "oFechaEfec"
   PMPasoValoresATX VGSqlConn, "@o_nota_venta", 1, SQLVARCHAR, "XXXXXXXXXXXXXXX", "ONotaVenta", ""
    PMPasoValoresATX VGSqlConn, "@o_pcuic", 1, SQLVARCHAR, "xxxxxxxxxx", "OCuid", ""
   PMPasoValoresATX VGSqlConn, "@o_pautorizacion", 1, SQLVARCHAR, "xxxxxxxxxx", "Autorizacion", ""
   
   

   'PMPasoValoresATX VGSqlConn, "@o_fechap_reg", 1, SQLVARCHAR, "xxxxxxxxxx", "", ""

   If FMTransmitirRPCATX(VGSqlConn, vl_servidor_BUS, "cob_procesador", "fp_pago_mimg_cep", True, "Transaccion Ok", "S", "N", "S", "19", "S", "S") = True Then

    'entro al pago
    FLTransmitir_MUNGYE_CEP_pago = True
    VTResult% = FMMapeaMatrizATX(VGSqlConn&, vtmatrizcps())
 
      VLTsnTemporal = VGTSN
      PMChequeaATX VGSqlConn
      PMTotalesBranch "19"
      VLCambio% = False
      'TPE ------> Sumadora
      
      SGSecTrn$ = FMRetParamATX(VGSqlConn, 1)
      VLSSnCorreccion = FMRetParamATX(VGSqlConn, 1)
      VLSsn = FMRetParamATX(VGSqlConn, 1)
      VLHorario = Trim$(FMRetParamATX(VGSqlConn, 2))
      VLAutorizacion1 = Trim$(FMRetParamATX(VGSqlConn, 10)) 'Autorizacion branch
      VLFechaEfe = VLFecContable
      If Len(Trim$(VLSsn)) > 6 Then
         VLSsn = Right$(Trim$(VLSsn), 6)
      Else
         VLSsn = String(6 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
      End If
      
      VLMG_ossn = FMRetParamATX(VGSqlConn, 1)
      
        If VGTipoEjecucion% <> CGReverso% Then
            VGSecBanredMG = FLBuscarItem("@o_pnumero")
            VLAutorizacion = FLBuscarItem("@o_pautorizacion")
        Else
            PMSetValorReverso txtTemporal, "@o_pautorizacion"
            VLAutorizacion = txtTemporal
        End If
        
      VTIndicadorSum = 1
      PMIniciaRegSum
      
    Else
      VLTsnTemporal = VGTSN     'lfcm borrar esta linea
      FLTransmitir_MUNGYE_CEP_pago = False
      VLCambio% = True
      VLFechaCorte = ""
      SGSecTrn$ = FMRetParamATX(VGSqlConn, 3)
      VTIndicadorSum = 0
      PMChequeaATX VGSqlConn
      PMFinTransaccion
      Exit Function
    End If
      
        PMChequeaATX VGSqlConn
        If FMRetStatusATX(VGSqlConn) <> 0 Then
        VTIndicadorSum = 0
        FLTransmitir_MUNGYE_CEP_pago = False
        PMFinTransaccion
        Exit Function
        End If
        PMFinTransaccion
    
    'JPM Lectora de Billetes -->
    If CCur(efe.Text) > 0 And ((VGDatPersBillAltDen.dataOK And VGTipoEjecucion = CGNormal%) Or VGTipoEjecucion = CGReverso%) Then
      Call PMGuardarDsglsBillete("19", SGSecTrn$, VLTrn, rptBAD, "REC", "")
      lectoraBill.Limpiar
    End If
    '<-- JPM Lectora de Billetes
    'ref003 Ini
    If VLDeb_com = 0 Then
        Call PLFactura
    End If
    'ref003 Fin
    
    'Sumadora -->
   If VGTipoEjecucion% <> CGReverso% Then   'Validacion por REVERSO
      If (VTIndicadorSum = 1 And (Trim$(VGStatusCon) = "A" Or Trim$(VGStatusCon) = "")) Then
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
    
     
     ' ImprimirComprobanteMercados_MUNGYE
      
      'Call Form_KeyDown(CGTeclaF5%, 0)
End Function

Function FLTransmitir_CPS_MUNGYE_consulta() As Boolean
    Dim VLArregloPago1 As String
    Dim VLArregloPago2 As String
    FLTransmitir_CPS_MUNGYE_consulta = False
   'Obtener el Ssn
'-->lfcm 16-febrero-2009
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "S", "opcion", ""
    PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@o_fechora", 1, SQLVARCHAR, 0, "Fechora", ""
    PMPasoValoresATX VGSqlConn, "@o_feccontable", 1, SQLVARCHAR, 0, "Feccontable", ""
    PMPasoValoresATX VGSqlConn, "@o_secuencial", 1, SQLINT4, 0, "Secuencial", ""
    If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_tr_municipio_recaudacion", True, "Transaccion Ok", "S", "N", "N", "19", "S", "S") = True Then
        VLFecHora = FMRetParamATX(VGSqlConn, 1)
        VLFecContable = FMRetParamATX(VGSqlConn, 2)
        VLSsn = FMRetParamATX(VGSqlConn, 3)
        If Len(Trim$(VLSsn)) > 6 Then
            VLSsn = Right$(Trim$(VLSsn), 6)
        Else
            VLSsn = String(6 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
        End If
        PMChequeaATX VGSqlConn
        PMTotalesBranch "19"
        'FLConsultar = True                         'lfcm 19-enero-2009
        FLTransmitir_CPS_MUNGYE_consulta = True     'lfcm 19-enero-2009
        VLCambio% = False
        'TPE ------> Sumadora
       SGSecTrn$ = FMRetParamATX(VGSqlConn, 3)
        VTIndicadorSum = 1
        PMIniciaRegSum
        PMFinTransaccion
        '<-----
    Else
        VLCambio% = True
        'FLConsultar = False                        'lfcm 19-enero-2009
        FLTransmitir_CPS_MUNGYE_consulta = False    'lfcm 19-enero-2009
        'TPE ------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 3)
        VTIndicadorSum = 0
        PMChequeaATX VGSqlConn
        PMFinTransaccion
        Exit Function
        '<------
    End If
'--<lfcm 16-febrero-2009
    
    Consulta_parametro_OSB 'msilvag SOA fase2
    
    
    VLPagosAnio = "0"
    VLPagosValor = 0
    
    FLTransmitir_CPS_MUNGYE_consulta = False    'lfcm 19-enero-2009
    PMInicioTransaccion  '62163 trx anterior de municipioGYE
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 62073, "Trn", "" 'msilvag Migracion WebService Dic-29-2015
    If Trim$(municipio.Text) = "1433" Then
        PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "C", "opcion", ""
    End If
    PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
    
    'GAMC - 21ENE10 - Fecha formato yyyymmdd
    VLFecContable_aaaammdd = FMConvFecha(VLFecContable, "mm/dd/yyyy", "yyyy/mm/dd")
    VLFecContable_aaaammdd = Mid(VLFecContable_aaaammdd, 1, 4) & Mid(VLFecContable_aaaammdd, 6, 2) & Mid(VLFecContable_aaaammdd, 9, 2)
    
    PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Canal", "" ' dpereirv Bus Fase2
    
    'Parametros esperador por el CPS
    'msilvag Inicion Migracion WebService Dic-29-2015
    'PMPasoValoresATX VGSqlConn, "@i_ptipo_transaccion", 0, SQLINT4, 310003, "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_ptipo_transaccion", 0, SQLINT4, 310000, "municipio", ""
    'msilvag Fin
    
    'PMPasoValoresATX VGSqlConn, "@i_pfecha_hora_br", 0, SQLVARCHAR, Format$(Date, "yyyymmdd") & Format$(Time(), "hhmmss"), "municipio", ""
    'GAMC - 21ENE10
    PMPasoValoresATX VGSqlConn, "@i_pfecha_hora_br", 0, SQLVARCHAR, VLFecContable_aaaammdd & Format$(Time(), "hhmmss"), "municipio", ""
    'PMPasoValoresATX VGSqlConn, "@i_psecuencial__br", 0, SQLINT4, "000001", "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_psecbr", 0, SQLINT4, "000001", "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_phora_trx_local", 0, SQLINT4, Format$(Time(), "hhmmss"), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_trx_local", 0, SQLVARCHAR, VLFecContable_aaaammdd, "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_comp", 0, SQLINT4, VLFecContable_aaaammdd, "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_pinst_adquirente", 0, SQLVARCHAR, "00597777", "municipio", "" 'msilvag Migracion WebService 597777
    
    'msilvag Inicion Migracion WebService Dic-29-2015
    'PMPasoValoresATX VGSqlConn, "@i_poperador", 0, SQLVARCHAR, String(6 - Len(Trim$(VGUsuario)), "0") + VGUsuario, "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_poperador", 0, SQLVARCHAR, String(9 - Len(Trim$(VGUsuario)), "0") + VGUsuario, "municipio", ""
    'msilvag Fin
    
    PMPasoValoresATX VGSqlConn, "@i_psecuencial_adq", 0, SQLINT4, Trim$(VLSsn), "municipio", ""
    ' ame 08/28/2012 PMPasoValoresATX VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, "1007000000" & Mid$(VGterminal, 1, 6), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, "0233000000" & Mid$(VGterminal, 1, 6), "municipio", ""

    PMPasoValoresATX VGSqlConn, "@i_psector", 0, SQLINT4, String(3 - Len(Trim$(cat1.ClipText)), "0") + Trim$(cat1.ClipText), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_pmanzana", 0, SQLVARCHAR, String(4 - Len(Trim$(cat2.ClipText)), "0") + Trim$(cat2.ClipText), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_plote", 0, SQLVARCHAR, String(3 - Len(Trim$(cat3.ClipText)), "0") + Trim$(cat3.ClipText), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_pdivision", 0, SQLVARCHAR, String(4 - Len(Trim$(cat4.ClipText)), "0") + Trim$(cat4.ClipText), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_pphv", 0, SQLVARCHAR, String(4 - Len(Trim$(cat5.ClipText)), "0") + Trim$(cat5.ClipText), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_pphh", 0, SQLVARCHAR, String(4 - Len(Trim$(cat6.ClipText)), "0") + Trim$(cat6.ClipText), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_pnumero", 0, SQLINT4, "1", "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_panio_vigencia", 0, SQLINT4, "9999", "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_psemestre", 0, SQLINT4, "3", "municipio", ""
    
    'msilvag BUS Inicio
    PMPasoValoresATX VGSqlConn, "@i_pmoneda", 0, SQLINT4, "840", "", ""
    PMPasoValoresATX VGSqlConn, "@i_pproducto", 0, SQLVARCHAR, "0010031003", "", ""
    'msilvag Fin
    
    'msilvag Inicion Migracion WebService Dic-29-2015
    PMPasoValoresATX VGSqlConn, "@i_pcomp", 0, SQLINT4, "2245", "mun_cod", ""
    PMPasoValoresATX VGSqlConn, "@i_serv_code", 0, SQLVARCHAR, "03", "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_pchanal", 0, SQLVARCHAR, "9", "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_pcod_adquirente", 0, SQLVARCHAR, "0233", "muni_codIntAdq", ""
    'msilvag FIn
    
    PMPasoValoresATX VGSqlConn, "@i_identifica", 0, SQLVARCHAR, cedula.ClipText, "identificacion", ""
        
    If Trim$(Tipo.Text) <> "" Then
        PMPasoValoresATX VGSqlConn, "@i_cod_impto", 0, SQLCHAR, (Tipo.Text), "tipo", ""
    End If
    VGDebugFile = True
    'fp_consulta_mimg_cep  fp_consulta_mimg 'consulta de Municipio
    If FMTransmitirRPCATX(VGSqlConn, vl_servidor_BUS, "cob_procesador", "fp_consulta_mimg_cep", True, "Transaccion Ok", "S", "N", "N", "19", "S", "S") = True Then 'msilvag SOA fase2
    'If FMTransmitirRPCATX(VGSqlConn, "PSSRV1", "cob_procesador", "fp_consulta_mimg", True, "Transaccion Ok", "S", "N", "N", "19", "S", "S") = True Then
        FLTransmitir_CPS_MUNGYE_consulta = True
        VTResult% = FMMapeaMatrizATX(VGSqlConn&, vtmatrizcps())
        VLContribuyente = FLBuscarItem("@o_pnombres")
        Contribuyente.Caption = VLContribuyente
        'VLIdentificacion = FLBuscarItem("@o_pdocumento")    'No viene
        'VLDireccion = FLBuscarItem("@o_pdireccion")         'No viene
        VLArregloPago1 = FLBuscarItem("@o_ppagos")
        If Trim$(VLArregloPago1) = "" Then
            VLArregloPago1 = FLBuscarItem("@o_pvalores_pago1_0")
            VLArregloPago1 = VLArregloPago1 + FLBuscarItem("@o_pvalores_pago1_1")
            VLArregloPago1 = VLArregloPago1 + FLBuscarItem("@o_pvalores_pago1_2")
            VLArregloPago1 = VLArregloPago1 + FLBuscarItem("@o_pvalores_pago1_3")
        End If
        VLArregloPago2 = FLBuscarItem("@o_pvalores_pago2")
        If Trim$(VLArregloPago2) = "" Then
            VLArregloPago2 = FLBuscarItem("@o_pvalores_pago2_0")
            VLArregloPago2 = VLArregloPago2 + FLBuscarItem("@o_pvalores_pago2_1")
            VLArregloPago2 = VLArregloPago2 + FLBuscarItem("@o_pvalores_pago2_2")
            VLArregloPago2 = VLArregloPago2 + FLBuscarItem("@o_pvalores_pago2_3")
        End If
        
        If Trim$(VLArregloPago1) = "" Then
            MsgBox "NO TIENE DEUDAS PENDIENTES", vbInformation, "Aviso"
            Exit Function
        End If
        
        VLItems = Len(VLArregloPago1) / 14 '16
        grdBloque.Rows = VLItems + 1
        For VLFila = 1 To VLItems
            grdBloque.Row = VLFila
            grdBloque.Col = 1
            'grdBloque.Text = Trim$(Mid$(VLArregloPago1, (VLFila - 1) * 16 + 33, 4))
            If Mid(VLArregloPago1, (1 + (14 * VLFila) - 14), 4) <> "0000" Then
                grdBloque.Text = Mid(VLArregloPago1, (1 + (14 * VLFila) - 14), 4)  'era antes 16 en todo
                grdBloque.Col = 2
                grdBloque.Text = "0"
                grdBloque.Col = 3
                grdBloque.Text = CCur(Mid(VLArregloPago1, 5 + (14 * VLFila) - 14, 10)) / 100
                VLItems2 = VLItems2 + 1
            End If
            'grdBloque.Text = grdBloque.Text + Trim$(Mid$(VLArregloPago2, (VLFila - 1) * 25 + 1, 25))
        Next VLFila
        grdBloque.Rows = VLItems2 + 1
        For VLFila = 1 To VLItems2
            grdBloque.Row = VLFila
            grdBloque.Col = 2
            'grdBloque.Text = CDbl(Trim$(Mid$(VLArregloPago2, (VLFila - 1) * 25 + 9, 8))) / 100
        Next VLFila
        If VLItems = 1 Then
            VLFlagUnicoMunGye = True
        Else
            VLFlagUnicoMunGye = False
        End If
        'ref003
        SGEmpresa = municipio.Text
    Else
        PMChequeaATX VGSqlConn
    End If
    PMChequeaATX VGSqlConn
    PMFinTransaccion
End Function


Function FLTransmitir_CPS_MUNQTO_consulta()
    
    FLTransmitir_CPS_MUNQTO_consulta = False
    
    Consulta_parametro_OSB 'msilvag SOA fase2
    
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 62167, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "C", "opcion", ""
    PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
    
    'Parametros esperador por el CPS para Municipio de Guayaquil
'    PMPasoValoresATX VGSqlConn, "@i_ptipo_transaccion", 0, SQLINT4, 310003, "municipio", ""
'    PMPasoValoresATX VGSqlConn, "@i_pfecha_hora_br", 0, SQLVARCHAR, "20090121111111", "municipio", ""
'    PMPasoValoresATX VGSqlConn, "@i_psecuencial__br", 0, SQLINT4, "00000001", "municipio", ""
'    'PMPasoValoresATX VGSqlConn, "@i_phora_trx_local", 0, SQLINT4, Mid$(VLFecHora, 9, 6), "municipio", ""
'    PMPasoValoresATX VGSqlConn, "@i_phora_trx_local", 0, SQLINT4, "110909", "municipio", ""
'    'PMPasoValoresATX VGSqlConn, "@i_pfecha_trx_local", 0, SQLINT4, Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2), "municipio", ""
'    'PMPasoValoresATX VGSqlConn, "@i_pfecha_comp", 0, SQLINT4, Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2), "municipio", ""
'    PMPasoValoresATX VGSqlConn, "@i_pfecha_trx_local", 0, SQLINT4, "20090121", "municipio", ""
'    PMPasoValoresATX VGSqlConn, "@i_pfecha_comp", 0, SQLINT4, "010109", "municipio", ""
'    PMPasoValoresATX VGSqlConn, "@i_pinst_adquirente", 0, SQLVARCHAR, "597777", "municipio", ""
'    PMPasoValoresATX VGSqlConn, "@i_poperador", 0, SQLVARCHAR, String(6 - Len(Trim$(VGUsuario)), "0") + VGUsuario, "municipio", ""
'    PMPasoValoresATX VGSqlConn, "@i_psecuencial_adq", 0, SQLINT4, Val(municipio.Text), "municipio", ""
'    PMPasoValoresATX VGSqlConn, "@i_pterminal", 0, SQLINT4, Val(Mid$(VGterminal, 1, 6)), "municipio", ""
'    'PMPasoValoresATX VGSqlConn, "@i_psector", 0, SQLINT4, Val(municipio.Text), "municipio", ""
'    PMPasoValoresATX VGSqlConn, "@i_psector", 0, SQLINT4, "123", "municipio", ""
'    'PMPasoValoresATX VGSqlConn, "@i_pmanzana", 0, SQLINT4, "04" + String(4 - Len(Trim$(cat2.ClipText)), "0") + Trim$(cat2.ClipText), "municipio", ""
'    PMPasoValoresATX VGSqlConn, "@i_pmanzana", 0, SQLVARCHAR, String(4 - Len(Trim$(cat2.ClipText)), "0") + Trim$(cat2.ClipText), "municipio", ""
'    'PMPasoValoresATX VGSqlConn, "@i_plote", 0, SQLINT4, "03" + String(3 - Len(Trim$(cat3.ClipText)), "0") + Trim$(cat3.ClipText), "municipio", ""
'    PMPasoValoresATX VGSqlConn, "@i_plote", 0, SQLVARCHAR, String(3 - Len(Trim$(cat3.ClipText)), "0") + Trim$(cat3.ClipText), "municipio", ""
'    'PMPasoValoresATX VGSqlConn, "@i_pdivision", 0, SQLINT4, "04" + String(4 - Len(Trim$(cat4.ClipText)), "0") + Trim$(cat4.ClipText), "municipio", ""
'    PMPasoValoresATX VGSqlConn, "@i_pdivision", 0, SQLVARCHAR, String(4 - Len(Trim$(cat4.ClipText)), "0") + Trim$(cat4.ClipText), "municipio", ""
'    'PMPasoValoresATX VGSqlConn, "@i_pphv", 0, SQLINT4, "04" + String(4 - Len(Trim$(cat5.ClipText)), "0") + Trim$(cat5.ClipText), "municipio", ""
'    PMPasoValoresATX VGSqlConn, "@i_pphv", 0, SQLVARCHAR, String(4 - Len(Trim$(cat5.ClipText)), "0") + Trim$(cat5.ClipText), "municipio", ""
'    'PMPasoValoresATX VGSqlConn, "@i_pphh", 0, SQLINT4, "04" + String(4 - Len(Trim$(cat6.ClipText)), "0") + Trim$(cat6.ClipText), "municipio", ""
'    PMPasoValoresATX VGSqlConn, "@i_pphh", 0, SQLVARCHAR, String(4 - Len(Trim$(cat6.ClipText)), "0") + Trim$(cat6.ClipText), "municipio", ""
'    'PMPasoValoresATX VGSqlConn, "@i_pnumero", 0, SQLINT4, "01" + "1", "municipio", ""
'    PMPasoValoresATX VGSqlConn, "@i_pnumero", 0, SQLINT4, "1", "municipio", ""
'    'PMPasoValoresATX VGSqlConn, "@i_panio_vigencia", 0, SQLINT4, "04" + "9999", "municipio", ""
'    PMPasoValoresATX VGSqlConn, "@i_panio_vigencia", 0, SQLINT4, "9999", "municipio", ""
'    'PMPasoValoresATX VGSqlConn, "@i_psemestre", 0, SQLINT4, "01" + "3", "municipio", ""
'    PMPasoValoresATX VGSqlConn, "@i_psemestre", 0, SQLINT4, "3", "municipio", ""
    
    
    'Parametros esperados por el CPS para Municipio de Quito
    PMPasoValoresATX VGSqlConn, "@i_pllave_municipal", 0, SQLVARCHAR, cedula.ClipText, "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_hora_br", 0, SQLVARCHAR, Format$(Date, "yyyymmdd") & Format$(Time(), "hhmmss"), "municipio", ""
    'PMPasoValoresATX VGSqlConn, "@i_psecuencial__br", 0, SQLVARCHAR, "000001", "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_psecbr", 0, SQLVARCHAR, "000001", "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_phora_trx_local", 0, SQLVARCHAR, Format$(Time(), "hhmmss"), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_trx_local", 0, SQLVARCHAR, Format$(Date, "yyyymmdd"), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_comp", 0, SQLVARCHAR, Format$(Date, "yyyymmdd"), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_pinst_adquirente", 0, SQLVARCHAR, "597777", "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_poperador", 0, SQLVARCHAR, String(6 - Len(Trim$(VGUsuario)), "0") + VGUsuario, "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_psecuencial_adq", 0, SQLVARCHAR, "123456", "municipio", ""
    ' ame 08/28/2012    PMPasoValoresATX VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, "1007000000" & Mid$(VGterminal, 1, 6), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, "0233000000" & Mid$(VGterminal, 1, 6), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_pcanal", 0, SQLVARCHAR, "001", "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_pimpuesto", 0, SQLVARCHAR, Tipo.Text, "municipio", ""

    'If Trim$(Tipo.Text) <> "" Then
    '    PMPasoValoresATX VGSqlConn, "@i_cod_impto", 0, SQLCHAR, (Tipo.Text), "tipo", ""
    'End If
    'PMPasoValoresATX VGSqlConn, "@o_comision", 1, SQLMONEY, 0, "comision", ""
    'PMPasoValoresATX VGSqlConn, "@o_nom_cli", 1, SQLVARCHAR, 0, "nomcli", ""
    'VGDebugFile = True     'lfcm 21-enero-2009
    
    If FMTransmitirRPCATX(VGSqlConn, vl_servidor_BUS, "cob_procesador", "fp_consulta_mimq", True, "Transaccion Ok", "S", "N", "N", "19", "S", "S") = True Then 'msilvag Bus Fase2
    'If FMTransmitirRPCATX(VGSqlConn, "PSSRV1", "cob_procesador", "fp_consulta_mimq", True, "Transaccion Ok", "S", "N", "N", "19", "S", "S") = True Then
        FLTransmitir_CPS_MUNQTO_consulta = True
        VTResult% = FMMapeaMatrizATX(VGSqlConn&, vtmatrizcps())
        VLContribuyente = FLBuscarItem("@o_pnombres")
        Contribuyente.Caption = VLContribuyente
        VLIdentificacion = Format(FLBuscarItem("@o_pdocumento"), "0000000000000")
        VLDireccion = FLBuscarItem("@o_pdireccion")         'No viene
        VLArregloPago1 = FLBuscarItem("@o_pvalores_pago1")
        VLArregloPago2 = FLBuscarItem("@o_pvalores_pago2")
        VGSecBanredMQ = FLBuscarItem("@o_psecuencial_br")
        If Trim$(VLArregloPago1) = "" Then
            VLArregloPago1 = FLBuscarItem("@o_pvalores_pago1_0") + Space(255 - Len(FLBuscarItem("@o_pvalores_pago1_0")))
            VLArregloPago1 = VLArregloPago1 + FLBuscarItem("@o_pvalores_pago1_1")
            VLArregloPago1 = VLArregloPago1 + FLBuscarItem("@o_pvalores_pago1_2")
            VLArregloPago1 = VLArregloPago1 + FLBuscarItem("@o_pvalores_pago1_3")
        End If
        VLArregloPago2 = FLBuscarItem("@o_pvalores_pago2")
        If Trim$(VLArregloPago2) = "" Then
            VLArregloPago2 = FLBuscarItem("@o_pvalores_pago2_0")
            VLArregloPago2 = VLArregloPago2 + FLBuscarItem("@o_pvalores_pago2_1")
            VLArregloPago2 = VLArregloPago2 + FLBuscarItem("@o_pvalores_pago2_2")
            VLArregloPago2 = VLArregloPago2 + FLBuscarItem("@o_pvalores_pago2_3")
        End If
        
        If Trim$(VLArregloPago1) = "" Then
            MsgBox "NO TIENE DEUDAS PENDIENTES", vbInformation, "Aviso"
            FLTransmitir_CPS_MUNQTO_consulta = False
            PMChequeaATX VGSqlConn
            PMFinTransaccion
            Exit Function
        End If
        
        VLItems = Len(VLArregloPago1) / 39
        grdBloque.Rows = VLItems + 1
        For VLFila = 1 To VLItems
            grdBloque.Row = VLFila
            grdBloque.Col = 1
            'grdBloque.Text = Trim$(Mid$(VLArregloPago1, (VLFila - 1) * 16 + 33, 4))
            grdBloque.Text = Mid(VLArregloPago1, (1 + (39 * VLFila) - 39), 3)
            grdBloque.Col = 2
            grdBloque.Text = Mid(VLArregloPago1, (4 + (39 * VLFila) - 39), 22) '"0"
            grdBloque.Col = 3
            grdBloque.Text = Mid(VLArregloPago1, (26 + (39 * VLFila) - 39), 4)
            grdBloque.Col = 4
            grdBloque.Text = CCur(Mid(VLArregloPago1, 30 + (39 * VLFila) - 39, 10)) / 100
            'grdBloque.Text = grdBloque.Text + Trim$(Mid$(VLArregloPago2, (VLFila - 1) * 25 + 1, 25))
        Next VLFila

        For VLFila = 1 To VLItems
            grdBloque.Row = VLFila
            grdBloque.Col = 2
            'grdBloque.Text = CDbl(Trim$(Mid$(VLArregloPago2, (VLFila - 1) * 25 + 9, 8))) / 100
        Next VLFila
        If VLItems = 1 Then
            VLFlagUnicoMunQto = True
        Else
            VLFlagUnicoMunQto = False
        End If
        'ref003
        SGEmpresa = municipio.Text
    Else
        PMChequeaATX VGSqlConn
    End If
    PMChequeaATX VGSqlConn
    PMFinTransaccion
       
       
       
       'Obtengo la respuesta desde el CPS
'       ReDim Preserve psRetorno(1, 150)
'      FMMapeaMatriz VGSqlConn, psRetorno
'      VLpllave_municipal = psRetorno(1, 1)
'      VLptipo_transaccion = psRetorno(1, 2)
'      VLpsecuencial_br = psRetorno(1, 3)
'      VLphora_trx_local = psRetorno(1, 4)
'      VLpfecha_trx_local = psRetorno(1, 5)
'      VLpfecha_comp = psRetorno(1, 6)
'      VLpdocumento = psRetorno(1, 7)
'      VLpinst_adquirente = psRetorno(1, 8)
'      VLpoperador = psRetorno(1, 9)
'      VLpsecuencial_adq = psRetorno(1, 10)
'      VLpresultado = psRetorno(1, 11)
'      VLpterminal = psRetorno(1, 12)
'      VLpnombres = psRetorno(1, 13)
'      VLpinstitucion_autorizadora = psRetorno(1, 14)
'      VLpvalores_pago1 = psRetorno(1, 15)
'      VLpvalores_pago2 = psRetorno(1, 16)
'      VLpdireccion = psRetorno(1, 17)
End Function
Function FLTransmitir_CSP_MUNCUE_consulta()
            
    Dim VLArregloPago1 As String
    Dim VLArregloPago2 As String
    
    
    txtLlaveMunicipal.Text = UCase(txtLlaveMunicipal.Text) 'ame 07/23/2010
    
    
    FLTransmitir_CSP_MUNCUE_consulta = False
    
    VLSsn = Trim$(str$(VGSqlConn))
    If Len(Trim$(VLSsn)) > 6 Then
        VLSsn = Right$(Trim$(VLSsn), 6)
    Else
        VLSsn = String(6 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
    End If

    
    VLTsnTemp = 0
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 62026, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_pllave_municipal", 0, SQLVARCHAR, Trim$(txtLlaveMunicipal.Text), "", ""
    PMPasoValoresATX VGSqlConn, "@i_ptipo_transacción", 0, SQLINT4, "310005", "", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_hora_br", 0, SQLINT4, "00000000000000", "", ""
    PMPasoValoresATX VGSqlConn, "@i_psecuencial__br", 0, SQLINT4, "000000", "", ""
    PMPasoValoresATX VGSqlConn, "@i_phora_trx_local", 0, SQLINT4, Format$(Time(), "hhmmss"), "", ""
    
    'lfcm 20-junio-2007 (2 lineas)
    'PMPasoValoresATX VGSqlConn, "@i_pfecha_trx_local", 0, SQLINT4, Format$(Date, "yymmdd"), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_trx_local", 0, SQLINT4, Format$(Date, "yyyymmdd"), "", ""
    
    'lfcm 20-junio-2007 (2 lineas)
    'PMPasoValoresATX VGSqlConn, "@i_pfecha_comp", 0, SQLINT4, Format$(Date, "yymmdd"), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_comp", 0, SQLINT4, Format$(Date, "yyyymmdd"), "", ""
    
    PMPasoValoresATX VGSqlConn, "@i_pinst_adquirente", 0, SQLINT4, "597777", "", ""
    PMPasoValoresATX VGSqlConn, "@i_poperador", 0, SQLVARCHAR, String(6 - Len(Trim$(VGUsuario)), "0") + VGUsuario, "", ""
    PMPasoValoresATX VGSqlConn, "@i_psecuencial_adq", 0, SQLINT4, Trim(VLSsn), "", ""
    ' ame 08/28/2012 PMPasoValoresATX VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, "1007" + String(6 - Len(Trim$(Str$(VGOficina))), "0") + Trim$(Str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, "0233" + String(6 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pcanal", 0, SQLVARCHAR, "001", "", ""
    PMPasoValoresATX VGSqlConn, "@i_pimpuesto", 0, SQLVARCHAR, Trim$(Tipo.Text), "", ""
    PMPasoValoresATX VGSqlConn, "@i_cod_banred", 0, SQLVARCHAR, "1", "", ""
    
    If FMTransmitirRPCATX(VGSqlConn, "PSSRV1", "cob_procesador", "fp_consulta_municipios", True, "Transaccion Ok", "S", "N", "N", "19", "S", "S") = True Then
        FLTransmitir_CSP_MUNCUE_consulta = True
        VTResult% = FMMapeaMatrizATX(VGSqlConn&, vtmatrizcps())
        VLContribuyente = FLBuscarItem("@o_pnombres")
        Contribuyente.Caption = VLContribuyente
        VLIdentificacion = FLBuscarItem("@o_pdocumento")
        VLDireccion = FLBuscarItem("@o_pdireccion")
        VGSecBanredMQ = FLBuscarItem("@o_psecuencial_br")
        VLArregloPago1 = FLBuscarItem("@o_pvalores_pago1")
        If Trim$(VLArregloPago1) = "" Then
            VLArregloPago1 = FLBuscarItem("@o_pvalores_pago1_0")
            VLArregloPago1 = VLArregloPago1 + FLBuscarItem("@o_pvalores_pago1_1")
            VLArregloPago1 = VLArregloPago1 + FLBuscarItem("@o_pvalores_pago1_2")
            VLArregloPago1 = VLArregloPago1 + FLBuscarItem("@o_pvalores_pago1_3")
        End If
        VLArregloPago2 = FLBuscarItem("@o_pvalores_pago2")
        If Trim$(VLArregloPago2) = "" Then
            VLArregloPago2 = FLBuscarItem("@o_pvalores_pago2_0")
            VLArregloPago2 = VLArregloPago2 + FLBuscarItem("@o_pvalores_pago2_1")
            VLArregloPago2 = VLArregloPago2 + FLBuscarItem("@o_pvalores_pago2_2")
            VLArregloPago2 = VLArregloPago2 + FLBuscarItem("@o_pvalores_pago2_3")
        End If
        
        VLArregloRef = FLBuscarItem("@o_ref_servicio")
        
        If Trim$(VLArregloPago1) = "" Or Len(VLArregloPago1) < 39 Then 'ame 07/05/2010
            MsgBox "NO TIENE DEUDAS PENDIENTES", vbInformation, "Aviso"
            FLTransmitir_CSP_MUNCUE_consulta = False
            Exit Function
        End If
        
        VLItems = Len(VLArregloPago1) / 39
        'If Trim$(Tipo.Text) = "002" Then
        '   grdBloque.Rows = VLItems + 1
        'Else
           grdBloque.Rows = VLItems + 1
        'End If
        For VLFila = 1 To VLItems
        
            If Trim$(Tipo.Text) = "002" Then
               If Trim$(Mid$(VLArregloPago1, (VLFila - 1) * 39 + 33, 4)) = "0099" Then
                  grdBloque.Row = 1
               Else
                  grdBloque.Row = VLFila + 1
               End If
            Else
               grdBloque.Row = VLFila
            End If
            
            grdBloque.Col = 1
            grdBloque.Text = Trim$(Mid$(VLArregloPago1, (VLFila - 1) * 39 + 33, 4))
            'ame 07/07/2010
            grdBloque.Col = 2
            
            If Trim$(Tipo.Text) = "001" Then
                grdBloque.Text = "Impuesto Predial"
            End If
            
            If Trim$(Tipo.Text) = "002" Then
               If Trim$(Mid$(VLArregloPago1, (VLFila - 1) * 39 + 33, 4)) = "0099" Then
                   grdBloque.Text = "Total Dividendos"
               Else
                   grdBloque.Text = "Dividendo"
               End If
            End If
            
            If Trim$(Tipo.Text) = "003" Then
                grdBloque.Text = Trim$(Mid$(VLArregloRef, (VLFila - 1) * 15 + 1, 15))
            End If
            'ame 07/07/2010
            grdBloque.Col = 3
            grdBloque.Text = CDbl(Trim$(Mid$(VLArregloPago2, (VLFila - 1) * 25 + 9, 8))) / 100  'ame 07/07/2010
            grdBloque.Col = 4
            'grdBloque.Text = Trim$(Mid$(VLArregloPago1, (VLFila - 1) * 39 + 1, 32)) + Trim$(Mid$(VLArregloPago2, (VLFila - 1) * 25 + 1, 16)) 'ame 07/07/2010
            grdBloque.Text = Trim$(Mid$(VLArregloPago1, (VLFila - 1) * 39 + 1, 39))
            grdBloque.Text = grdBloque.Text + Trim$(Mid$(VLArregloPago2, (VLFila - 1) * 25 + 1, 25))

            
            
        Next VLFila

'        For VLFila = 1 To VLItems
'            grdBloque.Row = VLFila
'            grdBloque.Col = 3
'           grdBloque.Text = CDbl(Trim$(Mid$(VLArregloPago2, (VLFila - 1) * 25 + 9, 8))) / 100
'        Next VLFila
        
        If VLItems = 1 Then
            VLFlagUnicoMunCuenca = True
        Else
            VLFlagUnicoMunCuenca = False
        End If
      
        'ref003
        SGEmpresa = municipio.Text
    Else
        PMChequeaATX VGSqlConn
    End If
    PMChequeaATX VGSqlConn
    PMFinTransaccion
       
End Function

Function FLTransmitir_CPS_MUNQTO_pago() As Boolean
         
Dim VTIndicadorSum As Integer
Dim VLIndReverso As Boolean
'    VTIndicadorSum = 0
    FLTransmitir_CPS_MUNQTO_pago = False
    If VGHorarioDif Then
        VLTrn = "3216"
    Else
        VLTrn = "3215"
    End If
    
    VGTrn = IIf(VLTrn = "", 0, VLTrn)
    
    VLIndReverso = False
    If VGTipoEjecucion% = CGReverso% Then
        VGTipoEjecucion% = CGNormal%
        VLIndReverso = True
    End If
    
'-->lfcm 12-febrero-2009
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "S", "opcion", ""
    PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, (Cheques.Text), "Cheques", ""
    PMPasoValoresATX VGSqlConn, "@i_autoriza", 0, SQLCHAR, VGAutoriza, "Autorizacion", ""
    PMPasoValoresATX VGSqlConn, "@o_fechora", 1, SQLVARCHAR, 0, "Fechora", ""
    PMPasoValoresATX VGSqlConn, "@o_feccontable", 1, SQLVARCHAR, 0, "Feccontable", ""
    PMPasoValoresATX VGSqlConn, "@o_secuencial", 1, SQLINT4, 0, "Secuencial", ""

    If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_tr_municipio_recaudacion", True, "Transaccion Ok", "S", "N", "N", "19", "S", "S") = True Then
        VLFecHora = FMRetParamATX(VGSqlConn, 1)
        VLFecContable = FMRetParamATX(VGSqlConn, 2)
        VLSsn = FMRetParamATX(VGSqlConn, 3)
        If Len(Trim$(VLSsn)) > 6 Then
            VLSsn = Right$(Trim$(VLSsn), 6)
        Else
            VLSsn = String(6 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
        End If
        PMChequeaATX VGSqlConn
        FLTransmitir_CPS_MUNQTO_pago = True
    Else
         FLTransmitir_CPS_MUNQTO_pago = False
        PMChequeaATX VGSqlConn
        PMFinTransaccion
        Exit Function
        '<------
    End If
    PMChequeaATX VGSqlConn
    If FMRetStatusATX(VGSqlConn) <> 0 Then
        FLTransmitir_CPS_MUNQTO_pago = False
        PMFinTransaccion
        Exit Function
    End If
    PMFinTransaccion
'--<lfcm 12-febrero-2009
    
    If VLIndReverso Then
        VLIndReverso = False
        VGTipoEjecucion% = CGReverso%
    End If
    
    FLTransmitir_CPS_MUNQTO_pago = False
    
    If VGTipoEjecucion% = CGReverso% Then
        VLSsn = Trim$(str$(VGSqlConn))
    End If
    If Len(Trim$(VLSsn)) > 6 Then
        VLSsn = Right$(Trim$(VLSsn), 6)
    Else
        VLSsn = String(6 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
    End If

    'VLArregloPago1 = ""
    'VLArregloPago2 = ""
    
     Consulta_parametro_OSB 'msilvag SOA fase2
     
    VTIndicadorSum = 0
    PMChequeaATX VGSqlConn
    PMInicioTransaccion
    
    'msilvag Bus Fase2 Inicio
    If VGTipoEjecucion% <> CGReverso% Then
        If vl_servidor_BUS <> "PSSRV1" Then 'msilvag RECA-CE-SGC00021700
            PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLVARCHAR, "N", "TCORR", ""
        End If 'msilvag RECA-CE-SGC00021700
    End If
    'msilvag Fin
    
    'PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 3215, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 62168, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "T", "opcion", "" ' msilvag BUS Fase2
    PMPasoValoresATX VGSqlConn, "@i_aplcobis", 0, SQLVARCHAR, "S", "AplCobis", "" ' msilvag Bus Fase2
    PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_nombre", 0, SQLVARCHAR, (Contribuyente.Caption), "Nombre", ""
    PMPasoValoresATX VGSqlConn, "@i_cant_chq", 0, SQLINT4, val(CantChq.Text), "Moneda", ""
    PMPasoValoresATX VGSqlConn, "@i_efe", 0, SQLMONEY, (efe.Text), "efe", ""
    PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, (Cheques.Text), "Cheques", ""
    'ref003 Ini
    If Me.Cta.ClipText <> "" Then
    PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (CboTipCta.Text), "CboTipCta", ""
    PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
    Else
      PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (VLTipCta_com), "CboTipCta", ""
      PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (VLCta_com), "Cta", ""
    End If
    'PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (CboTipCta.Text), "CboTipCta", ""
    'PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
    'ref003 Fin
    PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, (Debito.Text), "Debito", ""
    PMPasoValoresATX VGSqlConn, "@i_tarjeta", 0, SQLMONEY, (Tarjeta.Text), "Tarjeta", ""
    PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(FMObtenerMonedaForma("19")), "Moneda", ""
    PMPasoValoresATX VGSqlConn, "@i_autoriza", 0, SQLCHAR, VGAutoriza, "Autorizacion", ""
    PMPasoValoresATX VGSqlConn, "@i_supautor", 0, SQLVARCHAR, VGSuperAutoriza$, "Supervisor de Monto", ""       'ref:esma10mar2003
    'OJO PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "", ""
    PMPasoValoresATX VGSqlConn, "@i_valch", 0, SQLMONEY, (Cheques.Text), "Cheques", ""
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
    
    '-->Parametros requeridos por el CPS para armar la trama.
    If VGTipoEjecucion% = CGReverso% Then
       PMPasoValoresATX VGSqlConn, "@i_identifica", 0, SQLVARCHAR, txtLlave.Text, "", ""
    Else
       PMPasoValoresATX VGSqlConn, "@i_identifica", 0, SQLVARCHAR, cedula.ClipText, "", ""
    End If
    PMPasoValoresATX VGSqlConn, "@i_ptipo_transaccion", 0, SQLINT4, "010005", "", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_hora_br", 0, SQLVARCHAR, Mid(VGFechaReal, 7, 4) & Mid(VGFechaReal, 1, 2) & Mid(VGFechaReal, 4, 2) & Format$(Time(), "hhmmss"), "", ""
    PMPasoValoresATX VGSqlConn, "@i_psecbr", 0, SQLVARCHAR, (VGSecBanredMQ), "", ""
    PMPasoValoresATX VGSqlConn, "@i_phora_trx_local", 0, SQLINT4, Format$(Time(), "hhmmss"), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_trx_local", 0, SQLINT4, Mid(VGFechaReal, 7, 4) & Mid(VGFechaReal, 1, 2) & Mid(VGFechaReal, 4, 2), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_comp", 0, SQLINT4, Mid$(VLFecContable, 7, 4) + Mid$(VLFecContable, 1, 2) + Mid$(VLFecContable, 4, 2), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pinst_adquirente", 0, SQLINT4, "597777", "", ""
    PMPasoValoresATX VGSqlConn, "@i_poperador", 0, SQLVARCHAR, String(6 - Len(Trim$(VGUsuario)), "0") + VGUsuario, "", ""
    PMPasoValoresATX VGSqlConn, "@i_psecuencial_adq", 0, SQLINT4, Format(VLSsn, "000000"), "", ""
    ' ame 08/28/2012 PMPasoValoresATX VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, "1007" + String(6 - Len(Trim$(Str$(VGOficina))), "0") + Trim$(Str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, "0233" + String(6 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pproducto", 0, SQLVARCHAR, "0010031004", "", ""
    PMPasoValoresATX VGSqlConn, "@i_pvalores_pago1", 0, SQLVARCHAR, Mid(VLArregloPago1, 1, 39), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pvalores_pago1_1", 0, SQLVARCHAR, Mid(VLArregloPago1, 21, 19), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pvalores_pago2", 0, SQLVARCHAR, Mid(VLArregloPago2, 1, 25), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pvalores_pago2_1", 0, SQLVARCHAR, Mid(VLArregloPago2, 21, 5), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pcanal", 0, SQLVARCHAR, "001", "", ""
    PMPasoValoresATX VGSqlConn, "@i_tipo_impto", 0, SQLVARCHAR, Me.Tipo.Text, "", ""  ' ame 01/29/2010
    PMPasoValoresATX VGSqlConn, "@i_cod_impto", 0, SQLVARCHAR, Me.Impto.Caption, "", ""
    PMPasoValoresATX VGSqlConn, "@i_agno", 0, SQLINT4, val(Me.Agno.Caption), "", ""
    PMPasoValoresATX VGSqlConn, "@i_adicionales", 0, SQLVARCHAR, Space(120), "", ""
    VLFechaMunQto = Mid(VGFechaReal, 7, 4) & Mid(VGFechaReal, 1, 2) & Mid(VGFechaReal, 4, 2)
    VLHoraMunQto = Format$(Time(), "hhmmss")
    If VGTipoEjecucion% = CGReverso% Then
       PMPasoValoresATX VGSqlConn, "@i_pvalor_total", 0, SQLMONEY, (Me.ValorMun.Text), "", ""
       PMPasoValoresATX VGSqlConn, "@i_preverso", 0, SQLVARCHAR, "02", "", "", True
       PMPasoValoresATX VGSqlConn, "@i_titulo", 0, SQLVARCHAR, Me.txt_tmp_mim.Text, "", "", True
    Else
       VLSecuencialAdqMunQto = VLSsn
       'Me.txt_tmp_mim.Text = "0200" + VLSecuencialAdqMunQto + Format(VLFechaMunQto, "00000000") + VLHoraMunQto + "1007" + String(6 - Len(Trim$(Str$(VGOficina))), "0") + Trim$(Str$(VGOficina)) + Mid$(VGterminal, 1, 6)
       Me.txt_tmp_mim.Text = "0200" + VLSecuencialAdqMunQto + Format(VLFechaMunQto, "00000000") + VLHoraMunQto + "0233" + String(6 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) + Mid$(VGterminal, 1, 6)
       PMPasoValoresATX VGSqlConn, "@i_pvalor_total", 0, SQLMONEY, (Me.ValorMun.Text), "", ""
       PMPasoValoresATX VGSqlConn, "@i_preverso", 0, SQLVARCHAR, "02", "", "", True
       PMPasoValoresATX VGSqlConn, "@i_titulo", 0, SQLVARCHAR, Me.txt_tmp_mim.Text, "", "", True
       PMPasoValoresATX VGSqlConn, "@i_ptrx_original1", 0, SQLVARCHAR, Mid(Me.txt_tmp_mim.Text, 21, 20), "", "", True
    End If
   
    '-->Parametros para cargar los datos en el reverso. No pasan al BE
    PMPasoValoresATX VGSqlConn, "@i_sal_municipio", 0, SQLVARCHAR, Me.sal_municipio.Caption, "sal_municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_dirmimq", 0, SQLVARCHAR, VLDireccion, "direccion", ""
    PMPasoValoresATX VGSqlConn, "@i_tipoimpto", 0, SQLVARCHAR, Me.sal_tipo, "TipoImpto", ""
    PMPasoValoresATX VGSqlConn, "@i_cedruc", 0, SQLVARCHAR, VLIdentificacion, "Cedula/Ruc", ""    ' enviar @i_cedruc   VLIdentificacion ame 02/03/2010
    
    'msilvag Inicio Bus Fase 2
     PMPasoValoresATX VGSqlConn, "@i_ptipomoneda", 0, SQLVARCHAR, "840", "TipoMoneda", ""
    'msilvag FIn
    
    '--<Parametros para cargar los datos en el reverso. No pasan al BE
   
   '--<Parametros requeridos por el CPS para armar la trama.

   If VGTipoEjecucion% <> CGReverso% Then
           PMPasoValoresATX VGSqlConn, "@o_pautorizacion", 1, SQLVARCHAR, "0000000000", "", ""
           PMPasoValoresATX VGSqlConn, "@o_pintereses", 1, SQLVARCHAR, "000000000000", "", ""
           PMPasoValoresATX VGSqlConn, "@o_padicionales", 1, SQLVARCHAR, "000000000000", "", ""
           PMPasoValoresATX VGSqlConn, "@o_pdescuento", 1, SQLVARCHAR, "000000000000", "", ""
           PMPasoValoresATX VGSqlConn, "@o_precargo", 1, SQLVARCHAR, "000000000000", "", ""
           PMPasoValoresATX VGSqlConn, "@o_pcostas", 1, SQLVARCHAR, "000000000000", "", ""
   End If
    
    
   'Parametros de Output
   PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, 0, "", ""
   PMPasoValoresATX VGSqlConn, "@o_horario", 1, SQLCHAR, "X", "", ""
   PMPasoValoresATX VGSqlConn, "@o_autorisri", 1, SQLVARCHAR, "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "", ""
   PMPasoValoresATX VGSqlConn, "@o_fecvensri", 1, SQLVARCHAR, "XXXXXXXXXXXXXXXXXXXX", "", "" 'msilvag RECA-CE-SGC00021700
   PMPasoValoresATX VGSqlConn, "@o_feccontable", 1, SQLVARCHAR, "XXXXXXXXXX", "", ""
   'PMPasoValoresATX VGSqlConn, "@o_nota_venta", 1, SQLVARCHAR, "XXXXXXXXXXXXXXX", "", "" 'msilvag RECA-CE-SGC00021700
   PMPasoValoresATX VGSqlConn, "@o_comision", 1, SQLMONEY, 0, "", ""
   PMPasoValoresATX VGSqlConn, "@o_nom_cli", 1, SQLVARCHAR, "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "", ""
   PMPasoValoresATX VGSqlConn, "@o_fecha_ef", 1, SQLVARCHAR, "XXXXXXXXXX", "", ""
   PMPasoValoresATX VGSqlConn, "@o_nombcta", 1, SQLVARCHAR, (Nombre.Text), "nombre", ""
   
   'If VGTipoEjecucion% <> CGReverso% Then
      'PMPasoValoresATX VGSqlConn, "@o_dadireccion", 1, SQLVARCHAR, "000000000000", "", ""
      'PMPasoValoresATX VGSqlConn, "@o_danumcasa", 1, SQLVARCHAR, "000000000000", "", ""
      'PMPasoValoresATX VGSqlConn, "@o_daclavecatastro", 1, SQLVARCHAR, "000000000000", "", ""
      'PMPasoValoresATX VGSqlConn, "@o_dacodexon", 1, SQLVARCHAR, "000000000000", "", ""
      'PMPasoValoresATX VGSqlConn, "@o_pvalor_rubro", 1, SQLVARCHAR, "000000000000", "", ""
   'End If
   
   If FMTransmitirRPCATX(VGSqlConn, vl_servidor_BUS, "cob_procesador", "mp_pago_mimq", True, "Transaccion Ok", "S", "N", "S", "19", "S", "S") = True Then 'msilvag SOA fase2
   'If FMTransmitirRPCATX(VGSqlConn, "PSSRV1", "cob_procesador", "mp_pago_mimq", True, "Transaccion Ok", "S", "N", "S", "19", "S", "S") = True Then

        FLTransmitir_CPS_MUNQTO_pago = True
        VTResult% = FMMapeaMatrizATX(VGSqlConn&, vtmatrizcps())
        
        VTIndicadorSum = 1
        PMIniciaRegSum

        PMTotalesBranch "19"
        VLCambio% = False

        PMChequeaATX VGSqlConn
        If VGTipoEjecucion% = CGReverso% Then
          VLResultado = FLBuscarItem("@o_presultado")
           VLFechaEfe = VLFecContable ' FMRetParamATX(VGSqlConn, 16) 'ame 07/04/2012
           FLTransmitir_CPS_MUNQTO_pago = True
           VLtmp_ssn = FMRetParamATX(VGSqlConn, 1)    'ojo con esta variable ver seteo de la misma
           VLSsn = FMRetParamATX(VGSqlConn, 1)    'ojo con esta variable ver seteo de la misma
           SGSecTrn$ = FMRetParamATX(VGSqlConn, 1)
           VLTsnTemporal = VGTSN
           PMChequeaATX VGSqlConn
           PMFinTransaccion
           'Exit Function
           Else '03/22/2011
           VLSsn = FMRetParamATX(VGSqlConn, 7)    'ojo con esta variable ver seteo de la misma
           SGSecTrn$ = VLSsn
        End If
        
        VLFechaEmision = FLBuscarItem("@o_pfecha_emision")
        VGSecBanredMQ = FLBuscarItem("@o_psecuencial__br") 'ame 05/21/2010
        
        If VGTipoEjecucion% <> CGReverso% Then
                VLValorTotalPagar = FLBuscarItem("@o_pvalor_total") '  / 100
                If Trim$(VLValorTotalPagar) <> "" Then
                   VLValorTotalPagar = VLValorTotalPagar / 100
                Else
                    VLValorTotalPagar = 0
                End If
                
                VLValorRubros = FLBuscarItem("@o_pvalor_rubro") '/ 100
                If Trim$(VLValorRubros) <> "" Then
                   VLValorRubros = VLValorRubros / 100
                Else
                    VLValorRubros = 0
                End If
        
                VLValorInteres = FLBuscarItem("@o_pintereses") '/ 100
                If Trim$(VLValorInteres) <> "" Then
                   VLValorInteres = VLValorInteres / 100
                Else
                    VLValorInteres = 0
                End If
                Me.Agno.Tag = FLBuscarItem("@o_ptitulo_credito")
        End If
        
        VLValor = FLBuscarItem("@o_precargo")
        If VLValor <> "" Then
           VLValorRecargo = VLValor / 100
        End If
        
        VLValor = FLBuscarItem("@o_pcostas")
        If VLValor <> "" Then
           VLValorCostas = VLValor / 100
        End If
        
        VLValor = FLBuscarItem("@o_pdescuento")
        If VLValor <> "" Then
           VLValorDescuentos = VLValor / 100
        End If
        VLNumeroAutorizacion = Format(FLBuscarItem("@o_pautorizacion"), "0000000000")
        'VLIdentificacion = FLBuscarItem("@o_pdocumento")
        
        VLAvaluoComercial = FLBuscarItem("@o_pavaluocom")
        If VLValor <> "" Then
           VLAvaluoComercial = VLValor / 100
        End If
        vlclavecatastral = Mid(FLBuscarItem("@o_padicionales"), 26, 13)
        VLNoCasa = Mid(FLBuscarItem("@o_padicionales"), 21, 5)
        VLExoneracion = Mid(FLBuscarItem("@o_padicionales"), 53, 2)
        If Trim$(VLExoneracion) = "00" Then
            VLExoneracion = "NO"
        Else
            VLExoneracion = "SI"
        End If
        
        VLConcepto = FLBuscarItem("@o_pdescripcion_varios")
        grdBloque.Rows = VLItems + 1
        
        'msilvag Inicio RECMPS-977 Muncipio Quito Migracion bus 12C
        If vl_servidor_BUS = "BBTSSRV" Then
            If VGTipoEjecucion% <> CGReverso% Then
                VLtmppautorizacion = FMRetParamATX(VGSqlConn, 1)
                VL_pintereses = FMRetParamATX(VGSqlConn, 2)
                VL_padicionales = FMRetParamATX(VGSqlConn, 3)
                VL_pdescuento = FMRetParamATX(VGSqlConn, 4)
                VL_precargo = FMRetParamATX(VGSqlConn, 5)
                VL_pcostas = FMRetParamATX(VGSqlConn, 6)
                VLtmp_ssn = FMRetParamATX(VGSqlConn, 7)
                VLtmphorario = FMRetParamATX(VGSqlConn, 8)
                VLtmpautorisri = FMRetParamATX(VGSqlConn, 9)
                VLtmpfecvensri = FMRetParamATX(VGSqlConn, 10)
                VLFechaEfe = FMRetParamATX(VGSqlConn, 11)
                'VLtmpnota_venta = FMRetParamATX(VGSqlConn, 12)
                VLtmpcomision = FMRetParamATX(VGSqlConn, 12)
                VLtmpnom_cli = FMRetParamATX(VGSqlConn, 13)
                VLFechaEfe2 = FMRetParamATX(VGSqlConn, 14)
                VLNombreCuenta = FMRetParamATX(VGSqlConn, 15)
            Else
                VLtmp_ssn = FMRetParamATX(VGSqlConn, 1)
                VLtmphorario = FMRetParamATX(VGSqlConn, 2)
                VLtmpautorisri = FMRetParamATX(VGSqlConn, 3)
                VLtmpfecvensri = FMRetParamATX(VGSqlConn, 4)
                VLFechaEfe = FMRetParamATX(VGSqlConn, 5)
                VLtmpcomision = FMRetParamATX(VGSqlConn, 6)
                VLtmpnom_cli = FMRetParamATX(VGSqlConn, 7)
                VLFechaEfe2 = FMRetParamATX(VGSqlConn, 8)
                VLNombreCuenta = FMRetParamATX(VGSqlConn, 9)
            End If
        Else
            VLtmppautorizacion = FMRetParamATX(VGSqlConn, 1)
            
            VLtmp_ssn = FMRetParamATX(VGSqlConn, 7)    'ojo con esta variable ver seteo de la misma
            VLSsn = FMRetParamATX(VGSqlConn, 7)    'ojo con esta variable ver seteo de la misma
            VLTsnTemporal = VGTSN
            
            VLtmphorario = FMRetParamATX(VGSqlConn, 8)
            VLtmpcomision = FMRetParamATX(VGSqlConn, 9)
            VLtmpautorisri = FMRetParamATX(VGSqlConn, 9) 'msilvag FMRetParamATX(VGSqlConn, 10)
            VLtmpfecvensri = FMRetParamATX(VGSqlConn, 10) ' FMRetParamATX(VGSqlConn, 11)
            VLtmpnota_venta = FMRetParamATX(VGSqlConn, 12)
            'VLFechaEmision = FMRetParamATX(VGSqlConn, 13)
            VLtmpnom_cli = FMRetParamATX(VGSqlConn, 14)
            
            VLFechaEfe = FMRetParamATX(VGSqlConn, 15) 'ame 07/04/2012
        End If
        'msilvag Fin
        
        
        'vlclavecatastral = Trim(FMRetParamATX(VGSqlConn, 18))
        
'        If VLItems = 1 Then
'            VLFlagUnicoMunQto = True
'        Else
'            VLFlagUnicoMunQto = False
'        End If

        VTIndicadorSum = 1
        PMIniciaRegSum
    Else
        VLCambio% = True
        FLTransmitir_CPS_MUNQTO_pago = False
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 1)
        VTIndicadorSum = 0
        PMChequeaATX VGSqlConn
        PMFinTransaccion
        Exit Function
    End If
    PMChequeaATX VGSqlConn
    PMFinTransaccion
    
    'GAMC - 02AGO10
    'JPM Lectora de Billetes -->
    If CCur(efe.Text) > 0 And ((VGDatPersBillAltDen.dataOK And VGTipoEjecucion = CGNormal%) Or VGTipoEjecucion = CGReverso%) Then
      Call PMGuardarDsglsBillete("19", SGSecTrn$, VLTrn, rptBAD, "REC", "")
      lectoraBill.Limpiar
    End If
    '<-- JPM Lectora de Billetes
    'ref02 Ini
    If VLDeb_com = 0 Then
        Call PLFactura
    End If
    'ref02 Fin
    
        If VGTipoEjecucion% <> CGReverso% Then
        If (VTIndicadorSum = 1 And (Trim$(VGStatusCon) = "A" Or Trim$(VGStatusCon) = "")) Then
            SGPrimeraVez = 0     ' ya no es primera vez
            'PMGrabaDesglose VLTrn, Efe.Text, VLCambio%
            PMGrabaDesglose VLTrn, SGUsar, VLCambio%
            If VLCambio% = True Then
                MsgBox "Error en la Grabacion del Desglose. Favor comuniquese con su Supervisor.", vbCritical, "Error de Sistema"
            End If
            SGActual = 1  'seteo Variable para borrar desglose
        ElseIf VTIndicadorSum = 0 Then
            SGActual = 0  'no borrar desglose en caso de Error en Transaccion
        End If
    ElseIf VTIndicadorSum = 1 Then 'Por REVERSO
        VLTsnTemp = VGTSN
        'PMEgresoEfectivo Efe.ValueReal, VLTrn
        PMEgresoEfectivo SGUsar, VLTrn
    End If
    If SGAcumulado < 0 Then
        VLDescargar = 1
    End If

    
End Function
Function FLTransmitir_CSP_MUNCUE_pago() As Boolean
Dim VTIndicadorSum As Integer
Dim VLIndReverso As Boolean
    VTIndicadorSum = 0
    
    FLTransmitir_CSP_MUNCUE_pago = False
    
    If VGHorarioDif Then
        VLTrn = "3216"
    Else
        VLTrn = "3215"
    End If
    
    VGTrn = IIf(VLTrn = "", 0, VLTrn)
    
    VLIndReverso = False
    If VGTipoEjecucion% = CGReverso% Then
        VGTipoEjecucion% = CGNormal%
        VLIndReverso = True
    End If
    
    If VGTipoEjecucion% <> CGReverso% Then
    'VERIFICA MONTO MAXIMO
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 4050, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_empresa", 0, SQLVARCHAR, val(municipio.Text), "Empresa", ""
    PMPasoValoresATX VGSqlConn, "@i_codigo", 0, SQLVARCHAR, txtLlaveMunicipal.Text, "Suministro", ""
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
      
    If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_val_servicios_varios", True, "Transaccion Ok", "S", "N", "N", "19", "S", "S") = True Then
        PMChequeaATX VGSqlConn&
        PMFinTransaccion
    Else
        VLCambio% = True
        FLTransmitir_CSP_MUNCUE_pago = False
        VTIndicadorSum = 0
        PMChequeaATX VGSqlConn&
        PMFinTransaccion
        Exit Function
    End If
    
    End If
    
    
    
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "S", "opcion", ""
    PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@o_fechora", 1, SQLVARCHAR, 0, "Fechora", ""
    PMPasoValoresATX VGSqlConn, "@o_feccontable", 1, SQLVARCHAR, 0, "Feccontable", ""
    PMPasoValoresATX VGSqlConn, "@o_secuencial", 1, SQLINT4, 0, "Secuencial", ""
    
    If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_tr_municipio_recaudacion", True, "Transaccion Ok", "S", "N", "N", "19", "S", "S") = True Then
        VLFecHora = FMRetParamATX(VGSqlConn, 1)
        VLFecContable = FMRetParamATX(VGSqlConn, 2)
        VLSsn = FMRetParamATX(VGSqlConn, 3)
        If Len(Trim$(VLSsn)) > 6 Then
            VLSsn = Right$(Trim$(VLSsn), 6)
        Else
            VLSsn = String(6 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
        End If
        PMChequeaATX VGSqlConn
        PMTotalesBranch "19"
        FLTransmitir_CSP_MUNCUE_pago = True
        VLCambio% = False
        'TPE ------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 3)
        VTIndicadorSum = 1
        PMIniciaRegSum
        '<-----
    Else
        VLCambio% = True
        FLTransmitir_CSP_MUNCUE_pago = False
        'TPE ------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 3)
        VTIndicadorSum = 0
        PMChequeaATX VGSqlConn
        PMFinTransaccion
        Exit Function
        '<------
    End If
    PMChequeaATX VGSqlConn
    If FMRetStatusATX(VGSqlConn) <> 0 Then
        VTIndicadorSum = 0
        FLTransmitir_CSP_MUNCUE_pago = False
        PMFinTransaccion
        Exit Function
    End If
    PMFinTransaccion
    
    
    If VLIndReverso Then
        VLIndReverso = False
        VGTipoEjecucion% = CGReverso%
    End If
    
    FLTransmitir_CSP_MUNCUE_pago = False
    
    If VGTipoEjecucion% = CGReverso% Then
        VLSsn = Trim$(str$(VGSqlConn))
    End If
    If Len(Trim$(VLSsn)) > 6 Then
        VLSsn = Right$(Trim$(VLSsn), 6)
    Else
        VLSsn = String(6 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
    End If
    
    PMInicioTransaccion
    
    
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 62027, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "T", "opcion", ""
    PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_identifica", 0, SQLVARCHAR, (txtLlaveMunicipal.Text), "identificacion", ""
    'PMPasoValoresATX VGSqlConn, "@i_cod_impto", 0, SQLCHAR, (Impto.Caption), "tipo", ""                 'comenta ame 07/12/2010
    'PMPasoValoresATX VGSqlConn, "@i_no_predio", 0, SQLINT4, (Predio.Caption), "Moneda", ""              'comenta ame 07/12/2010
    PMPasoValoresATX VGSqlConn, "@i_agno", 0, SQLINT4, val(Agno.Caption), "Autorizacion", ""
    'PMPasoValoresATX VGSqlConn, "@i_semestre", 0, SQLVARCHAR, (Semestre.Caption), "Autorizacion", ""     'comenta ame 07/12/2010
    'PMPasoValoresATX VGSqlConn, "@i_prioridad", 0, SQLINT4, Val(Prioridad.Text), "Prioridad", ""         'comenta ame 07/12/2010
    PMPasoValoresATX VGSqlConn, "@i_nombre", 0, SQLVARCHAR, (Contribuyente.Caption), "Nombre", ""
    PMPasoValoresATX VGSqlConn, "@i_efe", 0, SQLMONEY, (efe.Text), "efe", ""
    PMPasoValoresATX VGSqlConn, "@i_cant_chq", 0, SQLINT4, val(CantChq.Text), "Moneda", ""
    PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, (Cheques.Text), "Cheques", ""
    PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(FMObtenerMonedaForma("19")), "Moneda", ""
    PMPasoValoresATX VGSqlConn, "@i_autoriza", 0, SQLVARCHAR, VGAutoriza, "Autorizacion", ""
    PMPasoValoresATX VGSqlConn, "@i_supautor", 0, SQLVARCHAR, VGSuperAutoriza$, "Supervisor de Monto", ""       'ref:esma10mar2003
    PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, (Debito.Text), "Debito", ""
    PMPasoValoresATX VGSqlConn, "@i_tarjeta", 0, SQLMONEY, (Tarjeta.Text), "Tarjeta", ""
    
    'ref003 Ini
    If Me.Cta.ClipText <> "" Then
      PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (CboTipCta.Text), "CboTipCta", ""
    PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
    Else
      PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (VLTipCta_com), "CboTipCta", ""
      PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (VLCta_com), "Cta", ""
    End If
    'PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (CboTipCta.Text), "CboTipCta", ""
    'PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
    'ref003 Fin
    
    PMPasoValoresATX VGSqlConn, "@i_contribuyente", 0, SQLVARCHAR, (Contribuyente.Caption), "contribuyente", ""
    PMPasoValoresATX VGSqlConn, "@i_valor_mun", 0, SQLMONEY, (ValorMun.Text), "valormun", ""
    PMPasoValoresATX VGSqlConn, "@i_tipo_impto", 0, SQLVARCHAR, (Tipo), "tipoimpto", ""
    PMPasoValoresATX VGSqlConn, "@i_totaltrama", 0, SQLMONEY, (ValorMun), "cat1", ""
    PMPasoValoresATX VGSqlConn, "@i_horatrama", 0, SQLVARCHAR, Mid$(VLFecHora, 9, 6), "hora", ""
    PMPasoValoresATX VGSqlConn, "@i_vlfechora", 0, SQLVARCHAR, VLFecHora, "vlfechora", ""
    PMPasoValoresATX VGSqlConn, "@i_vlfeccontable", 0, SQLVARCHAR, VLFecContable, "vlfeccontable", ""
    PMPasoValoresATX VGSqlConn, "@i_vlexoneracion", 0, SQLVARCHAR, VLExoneracion, "vlexoneracion", ""
    PMPasoValoresATX VGSqlConn, "@i_vlavaluocomercial", 0, SQLVARCHAR, VLAvaluoComercial, "vlavaluocomercial", ""
    PMPasoValoresATX VGSqlConn, "@i_VLIdentificacion", 0, SQLVARCHAR, VLIdentificacion, "VLIdentificacion", ""  'hy-22-septiembre-2006
    PMPasoValoresATX VGSqlConn, "@i_sal_municipio", 0, SQLVARCHAR, (sal_municipio.Caption), "sal_municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_sal_tipo", 0, SQLVARCHAR, (sal_tipo.Caption), "sal_tipo", ""
    PMPasoValoresATX VGSqlConn, "@i_desc_impto", 0, SQLVARCHAR, (DescripImpto.Text), "sal_tipo", ""
    PMPasoValoresATX VGSqlConn, "@i_direccion", 0, SQLVARCHAR, (direccion.Text), "direccion", ""
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
    
    PMPasoValoresATX VGSqlConn, "@i_titulo", 0, SQLCHAR, Trim$(Agno.Tag), "Titulo", ""
    PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, "0", "SecTrn", ""
    PMPasoValoresATX VGSqlConn, "@o_nombcta", 1, SQLVARCHAR, (Nombre.Text), "nombre", ""
    PMPasoValoresATX VGSqlConn, "@o_horario", 1, SQLCHAR, "N", "Horario", ""
    PMPasoValoresATX VGSqlConn, "@o_autorisri", 1, SQLVARCHAR, VLautoriSri, "AutorizacionSRI", ""
    PMPasoValoresATX VGSqlConn, "@o_fecvensri", 1, SQLVARCHAR, VLFecvenSRI, "Stk", ""
    'PMPasoValoresATX VGSqlConn, "@o_nota_venta", 1, SQLVARCHAR, VLSerie_Secuencia, "Nota_venta", ""
    PMPasoValoresATX VGSqlConn, "@o_fechora", 1, SQLVARCHAR, 0, "Fechora", ""
    PMPasoValoresATX VGSqlConn, "@o_feccontable", 1, SQLVARCHAR, 0, "Feccontable", ""
    PMPasoValoresATX VGSqlConn, "@o_fecha_ef", 1, SQLVARCHAR, "", "Fechaefe", ""
    PMPasoValoresATX VGSqlConn, "@i_secuencial", 0, SQLVARCHAR, VLSsn, "", ""    'hy-22-febrero-2007
    If VGHorarioDif Then                                                         'hy-22-febrero-2007
        PMPasoValoresATX VGSqlConn, "@i_hora_trama", 0, SQLVARCHAR, "D", "", ""  'hy-22-febrero-2007
    Else                                                                         'hy-22-febrero-2007
        PMPasoValoresATX VGSqlConn, "@i_hora_trama", 0, SQLVARCHAR, "H", "", ""  'hy-22-febrero-2007
    End If                                                                       'hy-22-febrero-2007
    
    PMPasoValoresATX VGSqlConn, "@i_pllave_municipal", 0, SQLVARCHAR, Trim$(txtLlaveMunicipal.Text), "", ""
    PMPasoValoresATX VGSqlConn, "@i_ptipo_transaccion", 0, SQLINT4, "010006 ", "", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_hora_br", 0, SQLINT4, "00000000000000", "", ""
    PMPasoValoresATX VGSqlConn, "@i_psecuencial__br", 0, SQLINT4, "000000", "", ""
    PMPasoValoresATX VGSqlConn, "@i_phora_trx_local", 0, SQLINT4, Mid$(VLFecHora, 9, 6), "", ""
    
    'lfcm 20-junio-2007 (2 junio)
    'PMPasoValoresATX VGSqlConn, "@i_pfecha_trx_local", 0, SQLINT4, Mid$(VLFecHora, 3, 6), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_trx_local", 0, SQLINT4, Mid$(VLFecHora, 1, 8), "", ""
    
    'lfcm 20-junio-2007 (2 junio)
    'PMPasoValoresATX VGSqlConn, "@i_pfecha_comp", 0, SQLINT4, Mid$(VLFecHora, 3, 6), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_comp", 0, SQLINT4, Mid$(VLFecHora, 1, 8), "", ""
    
    PMPasoValoresATX VGSqlConn, "@i_pinst_adquirente", 0, SQLINT4, "597777", "", ""
    PMPasoValoresATX VGSqlConn, "@i_poperador", 0, SQLVARCHAR, String(6 - Len(Trim$(VGUsuario)), "0") + VGUsuario, "", ""
    PMPasoValoresATX VGSqlConn, "@i_psecuencial_adq", 0, SQLINT4, Trim(VLSsn), "", ""
    ' ame 08/28/2012 PMPasoValoresATX VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, "1007" + String(6 - Len(Trim$(Str$(VGOficina))), "0") + Trim$(Str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, "0233" + String(6 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pmoneda", 0, SQLINT4, "840", "", ""
    PMPasoValoresATX VGSqlConn, "@i_pproducto", 0, SQLINT4, "0010031005", "", ""
    
    'lfcm 20-junio-2007 (11 lineas siguientes)
    'PMPasoValoresATX VGSqlConn, "@i_pvalores_pago1", 0, SQLVARCHAR, Mid$(VLItemSeleccionado, 1, 39), "", ""
    'PMPasoValoresATX VGSqlConn, "@i_pvalores_pago2", 0, SQLVARCHAR, Mid$(VLItemSeleccionado, 40, 25), "", ""
    
   If VGTipoEjecucion% = CGReverso% Then
        PMPasoValoresATX VGSqlConn, "@i_pvalores_pago1", 0, SQLVARCHAR, VLValoresPago1, "", "", True
        PMPasoValoresATX VGSqlConn, "@i_pvalores_pago2", 0, SQLVARCHAR, VLValoresPago2, "", "", True
    Else
        PMPasoValoresATX VGSqlConn, "@i_pvalores_pago1", 0, SQLVARCHAR, Mid$(VLItemSeleccionado, 1, 39), "", ""
        PMPasoValoresATX VGSqlConn, "@i_pvalores_pago2", 0, SQLVARCHAR, Mid$(VLItemSeleccionado, 40, 25), "", ""
        PMPasoValoresATX VGSqlConn, "@i_pvalores_pago1_2", 0, SQLVARCHAR, Mid$(VLItemSeleccionado, 21, 19), "", ""
        PMPasoValoresATX VGSqlConn, "@i_pvalores_pago2_2", 0, SQLVARCHAR, Mid$(VLItemSeleccionado, 60, 20), "", ""
    End If

    
    
    PMPasoValoresATX VGSqlConn, "@i_pcanal", 0, SQLVARCHAR, "001", "", ""
    PMPasoValoresATX VGSqlConn, "@i_pimpuesto", 0, SQLVARCHAR, Trim$(Tipo.Text), "", ""
    
    If VGTipoEjecucion% <> CGReverso% Then
        PMPasoValoresATX VGSqlConn, "@o_pautorizacion", 1, SQLVARCHAR, 0, "", ""
    End If
    
    If VGTipoEjecucion% = CGReverso% Then
        PMPasoValoresATX VGSqlConn, "@i_preverso", 0, SQLVARCHAR, "2", "", "", True
        PMPasoValoresATX VGSqlConn, "@i_pautorizacion", 0, SQLVARCHAR, VLAutorizacionMunCue, "", "", True
        'lfcm 19-junio-2007 (2 lineas siguientes)
        'PMPasoValoresATX VGSqlConn, "@i_ptrx_original", 0, SQLVARCHAR, "0200" + VLSecuencialAdqMunCue + VLFechaMunCue + VLHoraMunCue + Trim$(VGterminal), "", "", True
        ' ame 08/28/2012 PMPasoValoresATX VGSqlConn, "@i_ptrx_original", 0, SQLVARCHAR, "0200" + VLSecuencialAdqMunCue + Format(VLFechaMunCue, "00000000") + VLHoraMunCue + "1007" + String(6 - Len(Trim$(Str$(VGOficina))), "0") + Trim$(Str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", "", True
        PMPasoValoresATX VGSqlConn, "@i_ptrx_original", 0, SQLVARCHAR, "0200" + VLSecuencialAdqMunCue + Format(VLFechaMunCue, "00000000") + VLHoraMunCue + "0233" + String(6 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", "", True
        'VGErrorTransmision = False
    Else
        ' ame 08/28/2012 PMPasoValoresATX VGSqlConn, "@i_ptrx_original", 0, SQLVARCHAR, "0200" + Trim(VLSsn) + Format(Mid$(VLFecHora, 1, 8), "00000000") + VLHoraMunCue + "1007" + String(6 - Len(Trim$(Str$(VGOficina))), "0") + Trim$(Str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", "", True   'ame marzo 16/2010
        PMPasoValoresATX VGSqlConn, "@i_ptrx_original", 0, SQLVARCHAR, "0200" + Trim(VLSsn) + Format(Mid$(VLFecHora, 1, 8), "00000000") + VLHoraMunCue + "0233" + String(6 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", "", True   'ame marzo 16/2010
    End If
    
'    VLMunCue_Emision = Trim$(Mid$(VLItemSeleccionado, 1, 8))
'    VLMunCue_Exoneracion = Trim$(Mid$(VLItemSeleccionado, 9, 8))
'    VLMunCue_Descuentos = Trim$(Mid$(VLItemSeleccionado, 17, 8))
'    VLMunCue_Recargos = Trim$(Mid$(VLItemSeleccionado, 25, 8))
'    VLMunCue_Intereses = Trim$(Mid$(VLItemSeleccionado, 33, 8))
'    VLMunCue_Total = Trim$(Mid$(VLItemSeleccionado, 41, 8))
If VGTipoEjecucion% <> CGReverso% Then
    VLMunCue_Emision = Trim$(Mid$(VLItemSeleccionado, 1, 8))
    VLMunCue_Exoneracion = Trim$(Mid$(VLItemSeleccionado, 9, 8))
    VLMunCue_Descuentos = Trim$(Mid$(VLItemSeleccionado, 17, 8))
    VLMunCue_Recargos = Trim$(Mid$(VLItemSeleccionado, 25, 8))
    VLMunCue_Intereses = Trim$(Mid$(VLItemSeleccionado, 40, 8))
    VLMunCue_Total = Trim$(Mid$(VLItemSeleccionado, 48, 8))
End If
    
    PMPasoValoresATX VGSqlConn, "@i_mc_emision", 0, SQLVARCHAR, VLMunCue_Emision, "", ""
    PMPasoValoresATX VGSqlConn, "@i_mc_exoneracion", 0, SQLVARCHAR, VLMunCue_Exoneracion, "", ""
    PMPasoValoresATX VGSqlConn, "@i_mc_descuentos", 0, SQLVARCHAR, VLMunCue_Descuentos, "", ""
    PMPasoValoresATX VGSqlConn, "@i_mc_recargos", 0, SQLVARCHAR, VLMunCue_Recargos, "", ""
    PMPasoValoresATX VGSqlConn, "@i_mc_intereses", 0, SQLVARCHAR, VLMunCue_Intereses, "", ""
    PMPasoValoresATX VGSqlConn, "@i_mc_total", 0, SQLVARCHAR, VLMunCue_Total, "", ""
    PMPasoValoresATX VGSqlConn, "@i_mc_direccion", 0, SQLVARCHAR, VLDireccion, "", ""
    'ame 06/22/2010
    PMPasoValoresATX VGSqlConn, "@i_ref_servicio", 0, SQLVARCHAR, VLRubro, "", ""
    PMPasoValoresATX VGSqlConn, "@i_cod_banred", 0, SQLVARCHAR, "1", "", ""
    'If VGTipoEjecucion% = CGReverso% Then
     '  VGReversoLoger$ = "N"
       PMPasoValoresATX VGSqlConn, "@i_aut_servicio", 0, SQLVARCHAR, "0", "", ""
      ' VGReversoLoger$ = "S"
    'End If
    
    If FMTransmitirRPCATX(VGSqlConn, "PSSRV1", "cob_procesador", "fp_pago_municipio", True, "Transaccion Ok", "S", "N", "S", "19", "S", "S") = True Then
        FLTransmitir_CSP_MUNCUE_pago = True
        VTResult% = FMMapeaMatrizATX(VGSqlConn&, vtmatrizcps())
        VLTsnTemporal = VGTSN
        PMChequeaATX VGSqlConn
        PMTotalesBranch "19"
        VLCambio% = False
        'TPE ------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 1)
        VLSSnCorreccion = FMRetParamATX(VGSqlConn, 1)
        VLSsn = FMRetParamATX(VGSqlConn, 1)
        If Len(Trim$(VLSsn)) > 6 Then
            VLSsn = Right$(Trim$(VLSsn), 6)
        Else
            VLSsn = String(6 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
        End If
        VLHorario = Trim$(FMRetParamATX(VGSqlConn, 3))    'ame 03/2010
        VLautoriSri = FMRetParamATX(VGSqlConn, 4)         'ame 03/2010
        VLFecvenSRI = FMRetParamATX(VGSqlConn, 5)         'ame 03/2010
        VLSerie_Secuencia = FMRetParamATX(VGSqlConn, 6)  'hy-24-feb-2005 'ame 03/2010
        If VGTipoEjecucion% <> CGReverso% Then
            VLFechaEfe = FMRetParamATX(VGSqlConn, 9)       'ame 03/2010
        Else
            VLFechaEfe = ""     'ame 03/2010
        End If
        
        If val(Agno.Caption) = 99 Then
           VLFlagUnicoMunCuenca = True
        End If
        
        If Trim$(Tipo.Text) = "002" Then
           VLMLNoCuota = val(Agno.Caption)
        Else
           VLMLNoCuota = ""
        End If
        
        VTIndicadorSum = 1
        PMIniciaRegSum
        '<-----
    Else
        RevCondMunicipioCuenca
    
        'PLReversoCondicionalMuCuenca        'lfcm 22-junio-2007
    
        VLCambio% = True
        FLTransmitir_CSP_MUNCUE_pago = False
        'TPE ------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 1)
        VTIndicadorSum = 0
        PMChequeaATX VGSqlConn
        PMFinTransaccion
        Exit Function
        '<------
    End If
    PMChequeaATX VGSqlConn
    If FMRetStatusATX(VGSqlConn) <> 0 Then
        VTIndicadorSum = 0
        FLTransmitir_CSP_MUNCUE_pago = False
        PMFinTransaccion
        Exit Function
    End If
    PMFinTransaccion
    
    'GAMC - 02AGO10
    'JPM Lectora de Billetes -->
    If CCur(efe.Text) > 0 And ((VGDatPersBillAltDen.dataOK And VGTipoEjecucion = CGNormal%) Or VGTipoEjecucion = CGReverso%) Then
      Call PMGuardarDsglsBillete("19", SGSecTrn$, VLTrn, rptBAD, "REC", "")
      lectoraBill.Limpiar
    End If
    '<-- JPM Lectora de Billetes
    'ref003 Ini
    If VLDeb_com = 0 Then
    Call PLFactura
    End If
    'ref003 Fin
    
    'Sumadora -->
    If VGTipoEjecucion% <> CGReverso% Then   'Validacion por REVERSO
        If (VTIndicadorSum = 1 And (Trim$(VGStatusCon) = "A" Or Trim$(VGStatusCon) = "")) Then
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


Function FLTransmitir_CPS_MUNGYE_pago() As Boolean
Dim VTIndicadorSum As Integer
Dim VLIndReverso As Boolean
    VTIndicadorSum = 0
    
    FLTransmitir_CPS_MUNGYE_pago = False
    
    If VGHorarioDif Then
        VLTrn = "3216"
    Else
        VLTrn = "3215"
    End If
    
    VGTrn = IIf(VLTrn = "", 0, VLTrn)
    
    VLIndReverso = False
    If VGTipoEjecucion% = CGReverso% Then
        VGTipoEjecucion% = CGNormal%
        VLIndReverso = True
    End If
    
'-->lfcm 12-febrero-2009
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "S", "opcion", ""
    PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@o_fechora", 1, SQLVARCHAR, 0, "Fechora", ""
    PMPasoValoresATX VGSqlConn, "@o_feccontable", 1, SQLVARCHAR, 0, "Feccontable", ""
    PMPasoValoresATX VGSqlConn, "@o_secuencial", 1, SQLINT4, 0, "Secuencial", ""
    

    If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_tr_municipio_recaudacion", True, "Transaccion Ok", "S", "N", "N", "19", "S", "S") = True Then
        VLFecHora = FMRetParamATX(VGSqlConn, 1)
        VLFecContable = FMRetParamATX(VGSqlConn, 2)
        VLSsn = FMRetParamATX(VGSqlConn, 3)
        If Len(Trim$(VLSsn)) > 6 Then
            VLSsn = Right$(Trim$(VLSsn), 6)
        Else
            VLSsn = String(6 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
        End If
        PMChequeaATX VGSqlConn
        PMTotalesBranch "19"
        FLTransmitir_CPS_MUNGYE_pago = True
        VLCambio% = False
        'TPE ------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 3)
        VTIndicadorSum = 1
        PMIniciaRegSum
        '<-----
    Else
        VLCambio% = True
        FLTransmitir_CPS_MUNGYE_pago = False
        'TPE ------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 3)
        VTIndicadorSum = 0
        PMChequeaATX VGSqlConn
        PMFinTransaccion
        Exit Function
        '<------
    End If
    PMChequeaATX VGSqlConn
    If FMRetStatusATX(VGSqlConn) <> 0 Then
        VTIndicadorSum = 0
        FLTransmitir_CPS_MUNGYE_pago = False
        PMFinTransaccion
        Exit Function
    End If
    PMFinTransaccion
'--<lfcm 12-febrero-2009
    
    If VLIndReverso Then
        VLIndReverso = False
        VGTipoEjecucion% = CGReverso%
    End If
    
    FLTransmitir_CPS_MUNGYE_pago = False
    
    If VGTipoEjecucion% = CGReverso% Then
        VLSsn = Trim$(str$(VGSqlConn))
    End If
    If Len(Trim$(VLSsn)) > 6 Then
        VLSsn = Right$(Trim$(VLSsn), 6)
    Else
        VLSsn = String(6 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
    End If
    
    PMChequeaATX VGSqlConn
    
    'GAMC - 21ENE10 - Fecha formato yyyymmdd
    VLFecContable_aaaammdd = FMConvFecha(VLFecContable, "mm/dd/yyyy", "yyyy/mm/dd")
    VLFecContable_aaaammdd = Mid(VLFecContable_aaaammdd, 1, 4) & Mid(VLFecContable_aaaammdd, 6, 2) & Mid(VLFecContable_aaaammdd, 9, 2)
    
    Consulta_parametro_OSB 'msilvag SOA fase2
    
    PMInicioTransaccion
    
    'dpereirv Bus Fase2 Inicio
    If VGTipoEjecucion% <> CGReverso% Then
        PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLVARCHAR, "N", "TCORR", ""
'    Else
'        PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLVARCHAR, "S", "TCORR", ""
    End If
    'dpereirv Fin
    
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 62074, "Trn", "" '62164 msilvag Ene-06-2016
    'PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 3216, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "T", "opcion", ""
    PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Canal", "" ' dpereirv Bus Fase2
    PMPasoValoresATX VGSqlConn, "@i_aplcobis", 0, SQLVARCHAR, "S", "AplCobis", "" ' msilvag Bus Fase2
    PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
'    PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, 1433, "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_desmun", 0, SQLVARCHAR, (Me.sal_municipio.Caption), "DescMun", ""    'lfcm 04-marzo-2009 Para obtener del logger la desc.del Municipio en el reverso
    PMPasoValoresATX VGSqlConn, "@i_identifica", 0, SQLVARCHAR, (txtLlaveMunicipal.Text), "identificacion", ""
    PMPasoValoresATX VGSqlConn, "@i_nombre", 0, SQLVARCHAR, (Contribuyente.Caption), "Nombre", ""
    PMPasoValoresATX VGSqlConn, "@i_efe", 0, SQLMONEY, (efe.Text), "efe", ""
    PMPasoValoresATX VGSqlConn, "@i_cant_chq", 0, SQLINT4, val(CantChq.Text), "Moneda", ""
    PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, (Cheques.Text), "Cheques", ""
    PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(FMObtenerMonedaForma("19")), "Moneda", ""   'lfcm 04-marzo-2009 Para enviar el nombre del municipio y poder Mapearlo en el Reverso
    PMPasoValoresATX VGSqlConn, "@i_autoriza", 0, SQLVARCHAR, VGAutoriza, "Autorizacion", ""
    PMPasoValoresATX VGSqlConn, "@i_supautor", 0, SQLVARCHAR, VGSuperAutoriza$, "Supervisor de Monto", ""       'ref:esma10mar2003
    PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, (Debito.Text), "Debito", ""
    PMPasoValoresATX VGSqlConn, "@i_tarjeta", 0, SQLMONEY, (Tarjeta.Text), "Tarjeta", ""
    'ref003 Ini
    If Me.Cta.ClipText <> "" Then
      PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (CboTipCta.Text), "CboTipCta", ""
    PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
    Else
      PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (VLTipCta_com), "CboTipCta", ""
      PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (VLCta_com), "Cta", ""
    End If
    'PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
    'PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (CboTipCta.Text), "CboTipCta", ""
    PMPasoValoresATX VGSqlConn, "@i_deb_com", 0, SQLMONEY, (VLDeb_com), "Com. Debito", ""
    'ref003 Fin
    PMPasoValoresATX VGSqlConn, "@i_efe_com", 0, SQLMONEY, (VLEfe_com), "Com. efectivo", ""
    PMPasoValoresATX VGSqlConn, "@i_chq_com", 0, SQLMONEY, (VLChq_com), "Com. Cheques", ""
    
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
    
    PMPasoValoresATX VGSqlConn, "@i_secuencial", 0, SQLVARCHAR, Format(VLSsn, "000000"), "", ""
    'PMPasoValoresATX VGSqlConn, "@i_secuencial", 0, SQLVARCHAR, "001", "", ""    'hy-22-febrero-2007
    PMPasoValoresATX VGSqlConn, "@i_pmoneda", 0, SQLINT4, "840", "", ""
    'PMPasoValoresATX VGSqlConn, "@i_fecven", 0, SQLDATETIME, Format$(Date, "yyyymmdd"), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_hora_br", 0, SQLVARCHAR, VLFecContable_aaaammdd & Format$(Time(), "hhmmss"), "", ""
    'PMPasoValoresATX VGSqlConn, "@i_psecuencial__br", 0, SQLINT4, (VGSecBanredMG), "", ""
    PMPasoValoresATX VGSqlConn, "@i_psecbr", 0, SQLVARCHAR, (VGSecBanredMG), "", ""
    PMPasoValoresATX VGSqlConn, "@i_phora_trx_local", 0, SQLINT4, Format$(Time(), "hhmmss"), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_trx_local", 0, SQLINT4, VLFecContable_aaaammdd, "", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_comp", 0, SQLINT4, VLFecContable_aaaammdd, "", ""
    
    PMPasoValoresATX VGSqlConn, "@i_psecuencial_adq", 0, SQLINT4, Format(VLSsn, "000000"), "", ""
    ' ame 08/28/2012 PMPasoValoresATX VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, "1007" + String(6 - Len(Trim$(Str$(VGOficina))), "0") + Trim$(Str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, "0233" + String(6 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pproducto", 0, SQLVARCHAR, "0010031003", "", ""
    '-->Parametros requeridos por el CPS para armar la trama.
    
    'PMPasoValoresATX VGSqlConn, "@i_pcanal", 0, SQLVARCHAR, "001", "", ""
    'PMPasoValoresATX VGSqlConn, "@i_pimpuesto", 0, SQLVARCHAR, Trim$(tipo.ClipText), "", ""
    
    VLLongitud = Len(Trim$(cat1.ClipText))
    
    PMPasoValoresATX VGSqlConn, "@i_psector", 0, SQLVARCHAR, String(VLLongitud - Len(Trim$(cat1.ClipText)), "0") + Trim$(cat1.ClipText), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pmanzana", 0, SQLVARCHAR, String(4 - Len(Trim$(cat2.ClipText)), "0") + Trim$(cat2.ClipText), "", ""
    PMPasoValoresATX VGSqlConn, "@i_plote", 0, SQLVARCHAR, String(3 - Len(Trim$(cat3.ClipText)), "0") + Trim$(cat3.ClipText), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pdivision", 0, SQLVARCHAR, String(4 - Len(Trim$(cat4.ClipText)), "0") + Trim$(cat4.ClipText), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pphv", 0, SQLVARCHAR, String(4 - Len(Trim$(cat5.ClipText)), "0") + Trim$(cat5.ClipText), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pphh", 0, SQLVARCHAR, String(4 - Len(Trim$(cat6.ClipText)), "0") + Trim$(cat6.ClipText), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pnumero", 0, SQLVARCHAR, Trim$("1"), "", ""
    PMPasoValoresATX VGSqlConn, "@i_panio_vigencia", 0, SQLVARCHAR, Me.Agno.Caption, "", ""
    PMPasoValoresATX VGSqlConn, "@i_psemestre", 0, SQLINT4, Trim$("3"), "", ""
    
    'msilvag Inicio Migracion WebService Ene-06-2015
    PMPasoValoresATX VGSqlConn, "@i_ptipo_transaccion", 0, SQLVARCHAR, "45109M", "", ""  'msilvag Migracion WebService "010002"
    PMPasoValoresATX VGSqlConn, "@i_pinst_adquirente", 0, SQLVARCHAR, "00597777", "", ""  '00597777
    PMPasoValoresATX VGSqlConn, "@i_poperador", 0, SQLVARCHAR, String(9 - Len(Trim$(VGUsuario)), "0") + VGUsuario, "municipio", ""
    'PMPasoValoresATX VGSqlConn, "@i_poperador", 0, SQLVARCHAR, String(6 - Len(Trim$(VGUsuario)), "0") + VGUsuario, "", ""
    PMPasoValoresATX VGSqlConn, "@i_pcomp", 0, SQLINT4, "2245", "mun_cod", ""
    PMPasoValoresATX VGSqlConn, "@i_serv_code", 0, SQLVARCHAR, "03", "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_pchanal", 0, SQLVARCHAR, "9", "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_pcod_adquirente", 0, SQLVARCHAR, "0233", "muni_codIntAdq", ""
    'msilvag FIn
    
    'PMPasoValoresATX VGSqlConn, "@i_pnumero", 0, SQLVARCHAR, Trim$("1"), "", ""
   '--<Parametros requeridos por el CPS para armar la trama.

   If VGTipoEjecucion% = CGReverso% Then
      PMPasoValoresATX VGSqlConn, "@i_pvalor_total", 0, SQLMONEY, (Me.ValorMun.Text), "ValorMun", ""
      PMPasoValoresATX VGSqlConn, "@i_preverso", 0, SQLVARCHAR, "02", "", "", True
      ' ame 08/28/2012 PMPasoValoresATX VGSqlConn, "@i_ptrx_original", 0, SQLVARCHAR, "0200" + VLSecuencialAdqMunCue + Format(VLFechaMunCue, "00000000") + VLHoraMunCue + "1007" + String(6 - Len(Trim$(Str$(VGOficina))), "0") + Trim$(Str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", "", True
      PMPasoValoresATX VGSqlConn, "@i_ptrx_original", 0, SQLVARCHAR, "0200" + VLSecuencialAdqMunCue + Format(VLFechaMunCue, "00000000") + VLHoraMunCue + "0233" + String(6 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", "", True
   Else
      PMPasoValoresATX VGSqlConn, "@i_pvalor_total", 0, SQLMONEY, (Me.ValorMun.Text), "ValorMun", ""
      PMPasoValoresATX VGSqlConn, "@i_preverso", 0, SQLVARCHAR, "02", "", "", True
      ' ame 08/28/2012 PMPasoValoresATX VGSqlConn, "@i_ptrx_original", 0, SQLVARCHAR, "0200" + VLSecuencialAdqMunCue + Format(VLFechaMunCue, "00000000") + VLHoraMunCue + "1007" + String(6 - Len(Trim$(Str$(VGOficina))), "0") + Trim$(Str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", "", True
      PMPasoValoresATX VGSqlConn, "@i_ptrx_original", 0, SQLVARCHAR, "0200" + VLSecuencialAdqMunCue + Format(VLFechaMunCue, "00000000") + VLHoraMunCue + "0233" + String(6 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", "", True
   End If

    PMPasoValoresATX VGSqlConn, "@i_sal_tipo", 0, SQLVARCHAR, (sal_tipo.Caption), "sal_tipo", ""
    PMPasoValoresATX VGSqlConn, "@i_tipo_impto", 0, SQLVARCHAR, (Tipo), "tipoimpto", ""
    
    If VGTipoEjecucion% = CGReverso% Then
'        PMPasoValoresATX VGSqlConn, "@i_preverso", 0, SQLVARCHAR, "2", "", "", True
'        PMPasoValoresATX VGSqlConn, "@i_pautorizacion", 0, SQLVARCHAR, VLAutorizacionMunCue, "", "", True
'        'lfcm 19-junio-2007 (2 lineas siguientes)
'        'PMPasoValoresATX VGSqlConn, "@i_ptrx_original", 0, SQLVARCHAR, "0200" + VLSecuencialAdqMunCue + VLFechaMunCue + VLHoraMunCue + Trim$(VGterminal), "", "", True
'        PMPasoValoresATX VGSqlConn, "@i_ptrx_original", 0, SQLVARCHAR, "0200" + VLSecuencialAdqMunCue + Format(VLFechaMunCue, "00000000") + VLHoraMunCue + "1007" + String(6 - Len(Trim$(Str$(VGOficina))), "0") + Trim$(Str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", "", True
'        VGErrorTransmision = False
    End If

    VLMunCue_Emision = Trim$(Mid$(VLItemSeleccionado, 1, 8))
    VLMunCue_Exoneracion = Trim$(Mid$(VLItemSeleccionado, 9, 8))
    VLMunCue_Descuentos = Trim$(Mid$(VLItemSeleccionado, 17, 8))
    VLMunCue_Recargos = Trim$(Mid$(VLItemSeleccionado, 25, 8))
    VLMunCue_Intereses = Trim$(Mid$(VLItemSeleccionado, 40, 8))
    VLMunCue_Total = Trim$(Mid$(VLItemSeleccionado, 48, 8))
    
'    PMPasoValoresATX VGSqlConn, "@i_mc_emision", 0, SQLVARCHAR, VLMunCue_Emision, "", ""
'    PMPasoValoresATX VGSqlConn, "@i_mc_exoneracion", 0, SQLVARCHAR, VLMunCue_Exoneracion, "", ""
'    PMPasoValoresATX VGSqlConn, "@i_mc_descuentos", 0, SQLVARCHAR, VLMunCue_Descuentos, "", ""
'    PMPasoValoresATX VGSqlConn, "@i_mc_recargos", 0, SQLVARCHAR, VLMunCue_Recargos, "", ""
'    PMPasoValoresATX VGSqlConn, "@i_mc_intereses", 0, SQLVARCHAR, VLMunCue_Intereses, "", ""
'    PMPasoValoresATX VGSqlConn, "@i_mc_total", 0, SQLVARCHAR, VLMunCue_Total, "", ""
'    PMPasoValoresATX VGSqlConn, "@i_mc_direccion", 0, SQLVARCHAR, VLDireccion, "", ""
    
    
    'If VGTipoEjecucion% <> CGReverso% Then
        
    'End If
    
   'Parametros de Output
   PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, 0, "", ""
   PMPasoValoresATX VGSqlConn, "@o_horario", 1, SQLCHAR, "x", "", ""
   PMPasoValoresATX VGSqlConn, "@o_autorisri", 1, SQLVARCHAR, "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", "", ""
   PMPasoValoresATX VGSqlConn, "@o_fecvensri", 1, SQLVARCHAR, "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", "", ""
   PMPasoValoresATX VGSqlConn, "@o_fechora", 1, SQLVARCHAR, "xxxxxxxxxxxxxxxx", "", ""
   PMPasoValoresATX VGSqlConn, "@o_feccontable", 1, SQLVARCHAR, "xxxxxxxxxx", "", ""
   PMPasoValoresATX VGSqlConn, "@o_fecha_ef", 1, SQLVARCHAR, "xxxxxxxxxx", "", ""
   PMPasoValoresATX VGSqlConn, "@o_nota_venta", 1, SQLVARCHAR, "xxxxxxxxxxxxxxx", "", ""
   PMPasoValoresATX VGSqlConn, "@o_pcuic", 1, SQLVARCHAR, "xxxxxxxxxx", "", ""
   PMPasoValoresATX VGSqlConn, "@o_pautorizacion", 1, SQLVARCHAR, "xxxxxxxxxx", "", ""
   'fp_pago_mimg msilvag Migracion WebService
   If FMTransmitirRPCATX(VGSqlConn, vl_servidor_BUS, "cob_procesador", "fp_pago_mimg_cep", True, "Transaccion Ok", "S", "N", "S", "19", "S", "S") = True Then 'msilvag SOA fase2
   'If FMTransmitirRPCATX(VGSqlConn, "PSSRV1", "cob_procesador", "fp_pago_mimg", True, "Transaccion Ok", "S", "N", "S", "19", "S", "S") = True Then
   'If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_tr_municipio_recaudacion", True, "Transaccion Ok", "S", "N", "S", "19", "S", "S") = True Then
      FLTransmitir_CPS_MUNGYE_pago = True
   
      VLTsnTemporal = VGTSN
      PMTotalesBranch "19"
      VLCambio% = False
      'TPE ------> Sumadora
      'Recuperacion de los parametros de Output
      'SGSecTrn$ = FMRetParamATX(VGSqlConn, 1)
      'VLSSnCorreccion = FMRetParamATX(VGSqlConn, 1)
      'VLSsn = FMRetParamATX(VGSqlConn, 1)
      If VGTipoEjecucion% <> CGReverso% Then
'         ReDim Preserve psretornomimg(6, 3)
'         FMMapeaMatriz VGSqlConn, psretornomimg
'         VLHorario = psretornomimg(0, 1)     'Horario
'         VLSsn = psretornomimg(1, 1)         'Ssn
'         VLFechaEfe = psretornomimg(2, 1)    'Fecha Contable
'         VLFechaEfe = psretornomimg(3, 1)    'Fecha Efectiva
'         VLSerie_Secuencia = psretornomimg(4, 1)   'Fecha de Vencimiento Sri
'         VLautoriSri = psretornomimg(5, 1)   'Autorizacion Sri
'         VLFecvenSRI = psretornomimg(6, 1)   'Fecha de Vencimiento
         
         
         VGSecBanredMG = FMRetParamATX(VGSqlConn, 10)
         VLMG_ossn = FMRetParamATX(VGSqlConn, 1)
         VLSsn = FMRetParamATX(VGSqlConn, 1)
         VLHorario = FMRetParamATX(VGSqlConn, 2)
         VLMG_autorisri = FMRetParamATX(VGSqlConn, 3)
         VLautoriSri = Trim(VLMG_autorisri)
         VLMG_fecvensri = FMRetParamATX(VGSqlConn, 4)
         VLFecvenSRI = Trim(VLMG_fecvensri)
         VLMG_fechora = FMRetParamATX(VGSqlConn, 5)
         VLMG_feccontable = FMRetParamATX(VGSqlConn, 7)
         VLMG_fecha_ef = FMRetParamATX(VGSqlConn, 7)
         VLFechaEfe = VLMG_fecha_ef
         VLSerie_Secuencia = FMRetParamATX(VGSqlConn, 8)
         VLCodigoCUIC = FMRetParamATX(VGSqlConn, 9)
      Else
         ReDim Preserve psretornomimg(6, 3)
         FMMapeaMatriz VGSqlConn, psretornomimg
         VLHorario = psretornomimg(0, 1)     'Horario
         VLSsn = psretornomimg(1, 1)         'Ssn
         VLFechaEfe = psretornomimg(2, 1)    'Fecha Contable
         VLFechaEfe = psretornomimg(3, 1)    'Fecha Efectiva
         'VLFechaEfe = psretornomimg(4, 1)    'Nota de Venta
         'VLFechaEfe = psretornomimg(5, 1)    'Autorizacion Sri
         
         
         
         
         PMChequeaATX VGSqlConn
         PMSetValorReverso txtTemporal, "@o_ssn"
         VLMG_ossn = txtTemporal
         txtTemporal = ""
         PMSetValorReverso txtTemporal, "@o_autorisri"
         VLMG_autorisri = txtTemporal
         txtTemporal = ""
         PMSetValorReverso txtTemporal, "@o_fecvensri"
         VLMG_fecvensri = txtTemporal
         txtTemporal = ""
         PMSetValorReverso txtTemporal, "@o_nota_venta"
         VLMG_nota_venta = txtTemporal
         txtTemporal = ""
         'PMSetValorReverso txtTemporal, "@o_ssn"
         'VLMG_fechora = txtTemporal
         'txtTemporal = ""
         PMSetValorReverso txtTemporal, "@o_fecha_ef"
         VLMG_feccontable = txtTemporal
         txtTemporal = ""
         PMSetValorReverso txtTemporal, "@o_fecha_ef"
         VLMG_fecha_ef = txtTemporal
         VLFechaEfe = VLMG_fecha_ef
         txtTemporal = ""
         PMSetValorReverso txtTemporal, "@o_pautorizacion"
         VLMG_ssn_banred = txtTemporal
         txtTemporal = ""
         PMSetValorReverso txtTemporal, "@o_horario"
         VLHorario = txtTemporal
         txtTemporal = ""
         
         
      End If
      
      If Len(Trim$(VLSsn)) > 6 Then
          VLSsn = Right$(Trim$(VLSsn), 6)
      Else
            VLSsn = String(6 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
        End If
        'VLHorario = Trim$(FMRetParamATX(VGSqlConn, 4))
        'VLautoriSri = Trim$(FMRetParamATX(VGSqlConn, 6))
        'VLFecvenSRI = Trim$(FMRetParamATX(VGSqlConn, 7))
        'VLSerie_Secuencia = Trim$(FMRetParamATX(VGSqlConn, 6))  'hy-24-feb-2005
        If VGTipoEjecucion% <> CGReverso% Then
            'VLFechaEfe = Trim$(FMRetParamATX(VGSqlConn, 13))   'lfcm 06-marzo-2009
        End If
        VTIndicadorSum = 1
        PMIniciaRegSum
        '<-----
    
    
    'FCC19_grid2.grdDetalle.Row = 1
'    FCC19_grid2.grdDetalle.RemoveItem (FCC19_grid2.grdDetalle.Row)
    'FCC19_grid2.Show vbModal
    
    Else
        'RevCondMunicipioCuenca
        'PLReversoCondicionalMuCuenca        'lfcm 22-junio-2007
    
        VLCambio% = True
        FLTransmitir_CPS_MUNGYE_pago = False
        'TPE ------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 1)
        VTIndicadorSum = 0
        PMChequeaATX VGSqlConn
        PMFinTransaccion
        Exit Function
        '<------
    End If
    PMChequeaATX VGSqlConn
    SGSecTrn$ = VLMG_ossn
    If FMRetStatusATX(VGSqlConn) <> 0 Then
        VTIndicadorSum = 0
        FLTransmitir_CPS_MUNGYE_pago = False
        PMFinTransaccion
        Exit Function
    End If
    PMFinTransaccion
    
    'GAMC - 02AGO10
    'JPM Lectora de Billetes -->
    If CCur(efe.Text) > 0 And ((VGDatPersBillAltDen.dataOK And VGTipoEjecucion = CGNormal%) Or VGTipoEjecucion = CGReverso%) Then
      Call PMGuardarDsglsBillete("19", SGSecTrn$, VLTrn, rptBAD, "REC", "")
      lectoraBill.Limpiar
    End If
    '<-- JPM Lectora de Billetes
    'ref003 Ini
    If VLDeb_com = 0 Then
        Call PLFactura
    End If
    'ref003 Fin
    
    'Sumadora -->
    If VGTipoEjecucion% <> CGReverso% Then   'Validacion por REVERSO
        If (VTIndicadorSum = 1 And (Trim$(VGStatusCon) = "A" Or Trim$(VGStatusCon) = "")) Then
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


'-----------------------------------------------------------------------------------------------
'------------------------------- C O N S U L T A : M I    L O T E ------------------------------
'-----------------------------------------------------------------------------------------------

Function FLTransmitir_CPS_MILOTE_consulta() As Boolean
   VLTotCom = 0
   VLEfe_com = 0
   VLChq_com = 0
   VLNombre_com = ""  'ame 07/20/2010

   FLTransmitir_CPS_MILOTE_consulta = False
   If Trim$(cedula.ClipText) = "" Then
      MsgBox "La cédula es mandatoria", vbCritical, "Aviso"
      If cedula.Enabled Then
         cedula.SetFocus
      End If
      Exit Function
   End If
   
   If Len(cedula.ClipText) <> 0 Then
      If FMValidaCedulaRuc(cedula.ClipText) = False Then
         If cedula.Enabled Then
            cedula.SetFocus
         End If
         Exit Function
      End If
   End If
      
   '-->Consulta el valor de la comision
   If VGHorarioDif Then
      VLTrn = "3216"
   Else
      VLTrn = "3215"
   End If
   VGTrn = IIf(VLTrn = "", 0, VLTrn)
   PMInicioTransaccion
   PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
   PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "V", "opcion", ""
   PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
   PMPasoValoresATX VGSqlConn, "@i_tipo_impto", 0, SQLVARCHAR, (Me.Tipo.Text), "tipoimpto", ""  'msilvag Migracion Municipio
   PMPasoValoresATX VGSqlConn, "@o_comision", 1, SQLMONEY, 0, "comision", ""
   'PMPasoValoresATX VGSqlConn, "@o_cod_ifib", 1, SQLVARCHAR, 0, "codigo IFI", ""
   'smerino
    PMPasoValoresATX VGSqlConn, "@o_tasa", 1, SQLMONEY, "0", "tasa", ""
    PMPasoValoresATX VGSqlConn, "@o_base_imp", 1, SQLMONEY, "0", "base_imp", ""
    PMPasoValoresATX VGSqlConn, "@o_impuesto", 1, SQLMONEY, "0", "impuesto", ""
    'smerino
   
   
   If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_tr_municipio_recaudacion", True, "Transaccion Ok", "S", "N", "N", "19", "S", "S") = True Then
      Comision = FMRetParamATX(VGSqlConn, 1)
       VlbaseImp = FMRetParamATX(VGSqlConn, 3) 'smerino
       VLiva = FMRetParamATX(VGSqlConn, 4) 'smerino
    '  VLcodifi = FMRetParamATX(VGSqlConn, 2)
      PMChequeaATX VGSqlConn
      PMTotalesBranch "19"
      FLTransmitir_CPS_MILOTE_consulta = True
      VLCambio% = False
      
        'msilvag Inicio Migracion WebService Banred CEPMG-AP-SGC00022255-SGC00023616
        If Me.municipio.Text = 7749 And Me.Tipo.Text = "001" Then
            VLCodMunicipio = 1433
        Else
            If Me.municipio.Text = 7749 And Me.Tipo.Text = "002" Then
                VLCodMunicipio = 1434
            Else
                If Me.municipio.Text = 7749 And Me.Tipo.Text = "003" Then
                    VLCodMunicipio = 1435
                Else
                    If Me.municipio.Text = 7749 And Me.Tipo.Text = "004" Then
                        VLCodMunicipio = 7749
                    Else
                        VLCodMunicipio = Me.municipio.Text
                    End If
                End If
            End If
        End If
        'msilvag Fin
        
         'LBP Inicio RECA-CC-SGC00025869
         If Comision.Text > 0 Then
            VGCom_aux = FMDevuelveComisionReal(Comision, False, val(VLCodMunicipio)) 'FMDevuelveComisionReal(Comision, False, val(municipio.Text))
            If VGCom_aux <> CDbl(Comision.Text) Then
                VGComision_original = Comision.Text
                Comision.Text = VGCom_aux
            Else
                VGComision_original = Comision.Text
            End If
         End If
        'LBP Fin RECA-CC-SGC00025869
      
   Else
      VLCambio% = True
      MsgBox "ERROR AL OBTENER LA COMISION(MI LOTE)", vbCritical, "Aviso"
      FLTransmitir_CPS_MILOTE_consulta = False
      PMChequeaATX VGSqlConn
      PMFinTransaccion
      Exit Function
   End If
   PMChequeaATX VGSqlConn
   PMFinTransaccion
   
   '--<Consulta el valor de la comision
   
   FLTransmitir_CPS_MILOTE_consulta = False
   'Valida que solo ingrese cuando es MiLote
'   If Me.municipio.Text <> 1434 Then
'      MsgBox "CODIGO DE MUNICIPO NO PERMITIDO", vbInformation, "Aviso"
'      Exit Function
'   Else
'      'VLTrn = 62189
'   End If
   
   Dim VLArregloPago1 As String
   Dim VLArregloPago2 As String
   FLTransmitir_CPS_MILOTE_consulta = False
   'Obtener FechaHora, FechaContable, y Ssn.
   '-->lfcm 16-febrero-2009
   PMInicioTransaccion
   PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
   PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "S", "opcion", ""
   PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
   PMPasoValoresATX VGSqlConn, "@o_fechora", 1, SQLVARCHAR, 0, "Fechora", ""
   PMPasoValoresATX VGSqlConn, "@o_feccontable", 1, SQLVARCHAR, 0, "Feccontable", ""
   PMPasoValoresATX VGSqlConn, "@o_secuencial", 1, SQLINT4, 0, "Secuencial", ""
   If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_tr_municipio_recaudacion", True, "Transaccion Ok", "S", "N", "N", "19", "S", "S") = True Then
      VLFecHora = FMRetParamATX(VGSqlConn, 1)
      VLFecContable = FMRetParamATX(VGSqlConn, 2)
      VLFechaEfe = VLFecContable   'Borrar esta linea y tomarla de la respuesta del pago(CPS)
      VLSsn = FMRetParamATX(VGSqlConn, 3)
      If Len(Trim$(VLSsn)) > 6 Then
         VLSsn = Right$(Trim$(VLSsn), 6)
      Else
         VLSsn = String(6 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
      End If
      PMChequeaATX VGSqlConn
      PMTotalesBranch "19"
      'FLConsultar = True                         'lfcm 19-enero-2009
      FLTransmitir_CPS_MILOTE_consulta = True     'lfcm 19-enero-2009
      VLCambio% = False
      'TPE ------> Sumadora
      SGSecTrn$ = FMRetParamATX(VGSqlConn, 3)
      VTIndicadorSum = 1
      PMIniciaRegSum
      PMFinTransaccion
      '<-----
   Else
      VLCambio% = True
      'FLConsultar = False                        'lfcm 19-enero-2009
      FLTransmitir_CPS_MILOTE_consulta = False    'lfcm 19-enero-2009
      'TPE ------> Sumadora
      SGSecTrn$ = FMRetParamATX(VGSqlConn, 3)
      VTIndicadorSum = 0
      PMChequeaATX VGSqlConn
      PMFinTransaccion
      Exit Function
      '<------
   End If
   '--<lfcm 16-febrero-2009
    
    Consulta_parametro_OSB 'msilvag SOA fase2
   'GAMC - 12ENE10 - Fecha formato yyyymmdd
   VLFecContable_aaaammdd = FMConvFecha(VLFecContable, "mm/dd/yyyy", "yyyy/mm/dd")
   VLFecContable_aaaammdd = Mid(VLFecContable_aaaammdd, 1, 4) & Mid(VLFecContable_aaaammdd, 6, 2) & Mid(VLFecContable_aaaammdd, 9, 2)
    
   VLPagosAnio = "0"
   VLPagosValor = 0
   FLTransmitir_CPS_MILOTE_consulta = False    'lfcm 19-enero-2009
   PMInicioTransaccion
   'PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 62189, "TrnCps", ""
   PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 62073, "Trn", "" 'msilvag Migracion WebService Ene-12-2016
     PMPasoValoresATX VGSqlConn, "@i_pfecha_hora_br", 0, SQLVARCHAR, VLFecContable_aaaammdd & Format$(Time(), "hhmmss"), "FechaHoraBr", ""    'GAMC - 12ENE10
   
   'PMPasoValoresATX VGSqlConn, "@i_psecbr", 0, SQLVARCHAR, "000000", "SecBr", ""    'Es la primera consulta por lo tanto se envia cero. msilvag Migracion WebService
   
   PMPasoValoresATX VGSqlConn, "@i_phora_trx_local", 0, SQLVARCHAR, Format$(Time(), "hhmmss"), "HoraTrnLocal", ""
   PMPasoValoresATX VGSqlConn, "@i_pfecha_trx_local", 0, SQLVARCHAR, VLFecContable_aaaammdd, "FechaTrnLocal", ""     'GAMC - 12ENE10
   
    PMPasoValoresATX VGSqlConn, "@i_pfecha_comp", 0, SQLVARCHAR, VLFecContable_aaaammdd, "FechaComp", ""             'GAMC - 12ENE10
    
    'msilvag Migracion WebService Enero-12-2016
    PMPasoValoresATX VGSqlConn, "@i_ptipo_transaccion", 0, SQLVARCHAR, 310000, "TipoTrn", ""
    PMPasoValoresATX VGSqlConn, "@i_pinst_adquirente", 0, SQLVARCHAR, "00597777", "CodigoABA", ""
    PMPasoValoresATX VGSqlConn, "@i_poperador", 0, SQLVARCHAR, String(9 - Len(Trim$(VGUsuario)), "0") + VGUsuario, "CodigoOperador", ""
    PMPasoValoresATX VGSqlConn, "@i_pcomp", 0, SQLINT4, "2245", "mun_cod", ""
    PMPasoValoresATX VGSqlConn, "@i_serv_code", 0, SQLVARCHAR, "02", "ServCode", ""
    PMPasoValoresATX VGSqlConn, "@i_pchanal", 0, SQLVARCHAR, "9", "iPChanel", ""
    PMPasoValoresATX VGSqlConn, "@i_pcod_adquirente", 0, SQLVARCHAR, "0233", "muni_codIntAdq", ""
    PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Canal", ""
    PMPasoValoresATX VGSqlConn, "@i_pmoneda", 0, SQLINT4, "840", "mon", ""
    PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_psecbr", 0, SQLINT4, "000001", "municipio", ""
   'msilvag Fin
   
   PMPasoValoresATX VGSqlConn, "@i_psecuencial_adq", 0, SQLVARCHAR, Trim$(CStr(VLSsn)), "SecAdquiriente", ""
   'Verificar la longitud de la variable VGAgencia, y VGterminal
   ' ame 08/28/2012 PMPasoValoresATX VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, "1007" & Format(Mid(VGAgencia, 1, 6), "000000") & Mid$(VGterminal, 1, 6), "NumeroTerminal", ""
   PMPasoValoresATX VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, "0233" & Format(Mid(VGAgencia, 1, 6), "000000") & Mid$(VGterminal, 1, 6), "NumeroTerminal", ""
   PMPasoValoresATX VGSqlConn, "@i_identifica", 0, SQLVARCHAR, Mid(Trim$(cedula.ClipText), 1, 13), "Cedula", ""
   PMPasoValoresATX VGSqlConn, "@i_pproducto", 0, SQLVARCHAR, "0010031006", "Producto", ""
   PMPasoValoresATX VGSqlConn, "@i_ptipo", 0, SQLVARCHAR, "VTA", "Tipo", ""
   PMPasoValoresATX VGSqlConn, "@i_psubtipo", 0, SQLVARCHAR, "23", "SubTipo", ""
   '  fp_consulta_milote Migracion WebService Mi lote Enero-13-2016
   If FMTransmitirRPCATX(VGSqlConn, vl_servidor_BUS, "cob_procesador", "fp_consulta_mimg_cep", True, "Transaccion Ok", "S", "N", "N", "19", "S", "S") = True Then 'msilvag SOA fase2
      FLTransmitir_CPS_MILOTE_consulta = True
      VTResult% = FMMapeaMatrizATX(VGSqlConn&, vtmatrizcps())
      'VLMLCuotaMaxima = FLBuscarItem("@o_cuota_maxima")
      'VLMLSecBr = FLBuscarItem("@o_psecuencial_br")
      VLMLContribuyente = FLBuscarItem("@o_pnombres")
      VLMLAnioConvenio = FLBuscarItem("@o_panio_vigencia") 'FLBuscarItem("@o_panio_convenio")
      
     'msilvag Migracion WebService Inicion Enero-13-2016
      VLMLNoConvenio = FLBuscarItem("@o_pautorizacion")  'FLBuscarItem("@o_pnumero_convenio")
      VLMLValoresPagar = FLBuscarItem("@o_pvalor_pagar")  'ame 07/04/2012
      'msilvag Fin
      
      If Trim$(VLMLValoresPagar) = "" Then  'ame 07/04/2012
        'msilvag BUS
        VLMLValoresPagar1 = FLBuscarItem("@o_pvalor_pagar_0")
        VLMLValoresPagar2 = FLBuscarItem("@o_pvalor_pagar_1")
        If Trim(VLMLValoresPagar1) = "" Then
              VLMLValoresPagar1 = "0"
        End If
        If Trim(VLMLValoresPagar2) = "" Then
              VLMLValoresPagar2 = "0"
        End If
        If VLMLValoresPagar1 <> "0" And VLMLValoresPagar2 <> "0" Then
            VLMLValoresPagar = VLMLValoresPagar1 + VLMLValoresPagar2
           ElseIf VLMLValoresPagar1 <> "0" Then
                VLMLValoresPagar = VLMLValoresPagar1
            ElseIf VLMLValoresPagar2 <> "0" Then
                VLMLValoresPagar = VLMLValoresPagar2
        Else
            VLMLValoresPagar = FLBuscarItem("@o_ppagos")
        End If
        'msilvag BUS
'          VLMLValoresPagar = FLBuscarItem("@o_pvalor_pagar_0")
'          VLMLValoresPagar = VLMLValoresPagar + FLBuscarItem("@o_pvalor_pagar_1") 'ame 07/04/2012
      End If
      prueba = FLBuscarItem("@o_pfecha_registro")
      'prueba2 = CInt(Mid(prueba, 7, 3))
      
      'Validar que Banred siempre devuelva un valor para poder cancelar
      If Trim$(VLMLValoresPagar) = "" Then
         FLTransmitir_CPS_MILOTE_consulta = False
         MsgBox "NO TIENE DEUDAS PENDIENTES", vbInformation, "Aviso"
         Exit Function
      End If
      'VLMLValoresPagar = VLMLValoresPagar + FLBuscarItem("@o_pvalor_pagar_1")
      
      VLMLNumCuotaMaxima = "12" '"24" 'temporal solo pruebas Migracion WebService FLBuscarItem("@o_cuota_maxima")
      If Len(VLMLValoresPagar) > 28 Then
         'VLMLNoCuota = "1/" & CStr(Len(VLMLValoresPagar) / 34)
         VVLMLtmpCuota = CInt(Mid(VLMLValoresPagar, 7, 3))
         'VLMLNoCuota = VVLMLtmpCuota & "/" & CStr(Len(VLMLValoresPagar) / 28)
         VLMLNoCuota = VVLMLtmpCuota & "/" & CStr(VLMLNumCuotaMaxima)
      
      End If
      
      VLItems = Len(VLMLValoresPagar) / 28
      grdBloque.Rows = VLItems + 1
      For VLFila = 1 To VLItems
         grdBloque.Row = VLFila
         grdBloque.Col = 1
         'grdBloque.Text = Mid(VLMLValoresPagar, (1 + (34 * VLFila) - 34), 8)
         VVLMLtmpCuota = CInt(Mid(VLMLValoresPagar, (1 + (28 * VLFila) - 28) + 6, 3))
         VVLMLtmpCuota = CStr(Mid(VLMLValoresPagar, (1 + (28 * VLFila) - 28), 6))
         grdBloque.Text = CStr(VVLMLtmpCuota) '& "/" & CStr(VLItems)
         
         
         If VVLMLtmpCuota <> "000000" Then
            'msilvag Inicio Migracion WebService
            Me.grdBloque.Col = 2
            VLAbono = CStr(Mid(VLMLValoresPagar, (1 + (28 * VLFila) - 28) + 6, 3))
            grdBloque.Text = VLAbono
            'msilvag Fin
            grdBloque.Col = 3 '2 Migracion WebService msilvag
            VLMLFecha1 = Mid(VLMLValoresPagar, (1 + (28 * VLFila) - 28) + 9, 6)
            VLMLFecha2 = Mid(VLMLValoresPagar, (1 + (28 * VLFila) - 28) + 9 + 6, 6)
            VLMLFecha1 = Mid(Date, 7, 2) & Mid(VLMLFecha1, 1, 2) & "/" & Mid(VLMLFecha1, 3, 2) & "/" & Mid(VLMLFecha1, 5, 2)
            VLMLFecha2 = Mid(Date, 7, 2) & Mid(VLMLFecha2, 1, 2) & "/" & Mid(VLMLFecha2, 3, 2) & "/" & Mid(VLMLFecha2, 5, 2)
            grdBloque.Text = CStr(VLMLFecha1) & " - " & CStr(VLMLFecha2)
            grdBloque.Col = 4 '3 Migracion WebService msilvag
            'grdBloque.Text = Format(Mid(VLMLValoresPagar, (1 + (28 * VLFila) - 28) + 27, 7) / 100, "######.00")
            grdBloque.Text = Format(CCur(Mid(VLMLValoresPagar, 22 + (28 * VLFila) - 28, 7)) / 100, "######.00")
        Else
            Me.grdBloque.RemoveItem (VLFila)
         End If
         
      Next VLFila
      'Asignar a los controles el contenido de las variables.
      TmpMLVigencia = Mid(VLMLValoresPagar, 10, 12)
      TmpMLVigencia = Mid(Date, 7, 2) & Mid(TmpMLVigencia, 1, 2) & "/" & Mid(TmpMLVigencia, 3, 2) & "/" & Mid(TmpMLVigencia, 5, 2) & " - " & Mid(Date, 7, 2) & Mid(TmpMLVigencia, 7, 2) & "/" & Mid(TmpMLVigencia, 9, 2) & "/" & Mid(TmpMLVigencia, 11, 2)
      Contribuyente.Caption = VLMLContribuyente
      Agno.Caption = VLMLNoCuota
      VLMLPeriodoVigencia = TmpMLVigencia
      'VLIdentificacion = FLBuscarItem("@o_pdocumento")    'No viene
      'VLDireccion = FLBuscarItem("@o_pdireccion")         'No viene
      'VLArregloPago1 = FLBuscarItem("@o_ppagos")

      If VLItems = 1 Then
         VLFlagUnicoMiLote = True
      Else
         VLFlagUnicoMiLote = False
      End If
      'ref003
      SGEmpresa = municipio.Text
   Else
      FLTransmitir_CPS_MILOTE_consulta = False
      PMMapeaGridATX VGSqlConn, grdBloque, False
      PMChequeaATX VGSqlConn
      'Debido a que no tendremos respuesta por parte de Banred, simulamos una respuesta.
      '-->
      'SimulaRespuestaConsultaBanredMiLote
      
      '--<
      
      
   End If
   PMChequeaATX VGSqlConn
   PMFinTransaccion
End Function




Sub SimulaRespuestaConsultaBanredMiLote()
   'Datos que se recuperan del ResultSet del CPS
   VLMLContribuyente = "NOMBRE DE PRUEBA"   'Se debe tomar del ResultSet
   VLMLNoConvenio = "123"
   VLMLValoresPagar = "1111111122220050101200512310010000"
   'VLMLValoresPagar = VLMLValoresPagar & "2222222233320060101200612310020000"
   'VLMLValoresPagar = VLMLValoresPagar & "3333333344420070101200712310020000"
   'VLMLValoresPagar = VLMLValoresPagar & "4444444455520080101200812310020000"
   'VLMLValoresPagar = VLMLValoresPagar & "5555555566620090101200912310020000"
   VLMLAnioConvenio = "2006"
   VLMLNoCuota = ""   'Se calcula en las lineas siguientes
      
   'Validar que Banred siempre devuelva un valor para poder cancelar
   If Trim$(VLMLValoresPagar) = "" Then
      MsgBox "Valores a Pagar devuelto por Banred es vacio"
      Exit Sub
   End If
   
   If Len(VLMLValoresPagar) > 34 Then
      VLMLNoCuota = "1/" & CStr(Len(VLMLValoresPagar) / 34)
   Else
      VLMLNoCuota = "1/1"
   End If
   
   VLItems = Len(VLMLValoresPagar) / 34
   grdBloque.Rows = VLItems + 1
   For VLFila = 1 To VLItems
      grdBloque.Row = VLFila
      grdBloque.Col = 1
      'grdBloque.Text = Mid(VLMLValoresPagar, (1 + (34 * VLFila) - 34), 8)
      grdBloque.Text = CStr(VLFila) & "/" & CStr(VLItems)
      'grdBloque.Col = 2
      'grdBloque.Text = Mid(VLMLValoresPagar, (1 + (34 * VLFila) - 34) + 8, 3)
      grdBloque.Col = 2
      VLMLFecha1 = Mid(VLMLValoresPagar, (1 + (34 * VLFila) - 34) + 11, 16)
      VLMLFecha2 = Mid(VLMLValoresPagar, (1 + (34 * VLFila) - 34) + 11, 16)
      VLMLFecha1 = Mid(VLMLFecha1, 1, 4) & "/" & Mid(VLMLFecha1, 5, 2) & "/" & Mid(VLMLFecha1, 7, 2)
      VLMLFecha2 = Mid(VLMLFecha2, 1 + 8, 4) & "/" & Mid(VLMLFecha2, 5 + 8, 2) & "/" & Mid(VLMLFecha2, 7 + 8, 2)
      grdBloque.Text = CStr(VLMLFecha1) & " - " & CStr(VLMLFecha2)
      grdBloque.Col = 3
      grdBloque.Text = Format(Mid(VLMLValoresPagar, (1 + (34 * VLFila) - 34) + 27, 7) / 100, "######.00")
   Next VLFila

   'For VLFila = 1 To VLItems
   '   grdBloque.Row = VLFila
   '   grdBloque.Col = 2
   '   'grdBloque.Text = CDbl(Trim$(Mid$(VLArregloPago2, (VLFila - 1) * 25 + 9, 8))) / 100
   'Next VLFila
      
   TmpMLVigencia = Mid(VLMLValoresPagar, 12, 16)
   TmpMLVigencia = Mid(TmpMLVigencia, 1, 4) & "/" & Mid(TmpMLVigencia, 5, 2) & "/" & Mid(TmpMLVigencia, 7, 2) & " - " & Mid(TmpMLVigencia, 9, 4) & "/" & Mid(TmpMLVigencia, 13, 2) & "/" & Mid(TmpMLVigencia, 15, 2)
   
   Contribuyente.Caption = VLMLContribuyente
   Agno.Caption = VLMLNoCuota
   VLMLPeriodoVigencia = TmpMLVigencia
   
      
End Sub




'-----------------------------------------------------------------------------------------------
'--------------------------------- P A G O : M I    L O T E ------------------------------------
'-----------------------------------------------------------------------------------------------

Function FLTransmitir_CPS_MILOTE_pago() As Boolean
   Dim VTIndicadorSum As Integer
   Dim VLIndReverso As Boolean
   VTIndicadorSum = 0
   VLIndReverso = False
 
   FLTransmitir_CPS_MILOTE_pago = False
   
   If VGHorarioDif Then
        VLTrn = "3216"
    Else
        VLTrn = "3215"
    End If
   
   VGTrn = IIf(VLTrn = "", 0, VLTrn)

    VLIndReverso = False
    If VGTipoEjecucion% = CGReverso% Then
        VGTipoEjecucion% = CGNormal%
        VLIndReverso = True
    End If
    
   PMInicioTransaccion
   PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
   PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "S", "opcion", ""
   PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
   PMPasoValoresATX VGSqlConn, "@o_fechora", 1, SQLVARCHAR, 0, "Fechora", ""
   PMPasoValoresATX VGSqlConn, "@o_feccontable", 1, SQLVARCHAR, 0, "Feccontable", ""
   PMPasoValoresATX VGSqlConn, "@o_secuencial", 1, SQLINT4, 0, "Secuencial", ""
   If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_tr_municipio_recaudacion", True, "Transaccion Ok", "S", "N", "N", "19", "S", "S") = True Then
      VLFecHora = FMRetParamATX(VGSqlConn, 1)
      VLFecContable = FMRetParamATX(VGSqlConn, 2)
      VLSsn = FMRetParamATX(VGSqlConn, 3)
      If Len(Trim$(VLSsn)) > 6 Then
         VLSsn = Right$(Trim$(VLSsn), 6)
      Else
         VLSsn = String(6 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
      End If
      PMChequeaATX VGSqlConn
      PMTotalesBranch "19"
      FLTransmitir_CPS_MILOTE_pago = True     'lfcm 19-enero-2009
      VLCambio% = False
      'TPE ------> Sumadora
      SGSecTrn$ = FMRetParamATX(VGSqlConn, 3)
      VTIndicadorSum = 1
      PMIniciaRegSum
      PMFinTransaccion
   Else
      VLCambio% = True
      FLTransmitir_CPS_MILOTE_pago = False    'lfcm 19-enero-2009
      SGSecTrn$ = FMRetParamATX(VGSqlConn, 3)
      VTIndicadorSum = 0
      PMChequeaATX VGSqlConn
      PMFinTransaccion
      Exit Function
   End If

   If VLIndReverso Then
        VLIndReverso = False
        VGTipoEjecucion% = CGReverso%
        End If
        
   Consulta_parametro_OSB 'msilvag SOA fase2
   
   'GAMC - 12ENE10 - Fecha formato yyyymmdd
   VLFecContable_aaaammdd = FMConvFecha(VLFecContable, "mm/dd/yyyy", "yyyy/mm/dd")
   VLFecContable_aaaammdd = Mid(VLFecContable_aaaammdd, 1, 4) & Mid(VLFecContable_aaaammdd, 6, 2) & Mid(VLFecContable_aaaammdd, 9, 2)

   PMInicioTransaccion

   If VGTipoEjecucion% <> CGReverso% Then
      'VLPasoFecha = Format$(Date, "yyyymmdd")                 'lfcm 13-agosto-2009
      VLPasoFecha = Format$(VLFecContable, "yyyymmdd")         'lfcm 13-agosto-2009
      VLPasoHora = Format$(Time(), "hhmmss")
      VLSecuencialAdqMiLote = VLSsn
   Else
      VLSecuencialAdqMiLote = VLSsnRevTimeOut
   End If
   
   'msilvag Inicio Migracion WebService
   PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 62074, "TrnCps", ""
   'PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 62190, "TrnCps", ""
   'msilvag Fin
   
   'msilvag Bus Fase2 Inicio
   If VGTipoEjecucion% <> CGReverso% Then
    'PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLVARCHAR, "S", "TCORR", ""
   'Else
    PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLVARCHAR, "N", "TCORR", ""
   End If
   'msilvag Fin
   
   If VGTipoEjecucion% = CGReverso% Then
      PMPasoValoresATX VGSqlConn, "@i_pcodres", 0, SQLVARCHAR, "00", "CodRes", "", True
      PMPasoValoresATX VGSqlConn, "@i_preverso", 0, SQLVARCHAR, "2", "", "", True
      ' ame 08/28/2012 PMPasoValoresATX VGSqlConn, "@i_ptrx_original", 0, SQLVARCHAR, "0200" + VLSecuencialAdqMiLote + VLPasoFecha + VLPasoHora + "1007" & Format(Mid(VGAgencia, 1, 6), "000000") & Mid$(VGterminal, 1, 6), "", "", True
      PMPasoValoresATX VGSqlConn, "@i_ptrx_original", 0, SQLVARCHAR, "0200" + VLSecuencialAdqMiLote + VLPasoFecha + VLPasoHora + "0233" & Format(Mid(VGAgencia, 1, 6), "000000") & Mid$(VGterminal, 1, 6), "", "", True
      PMPasoValoresATX VGSqlConn, "@i_fechareg", 0, SQLVARCHAR, (VLFechaRegistro), "FechaRegistro", "", True
      PMPasoValoresATX VGSqlConn, "@i_psecuencial_adq", 0, SQLVARCHAR, (VLSecuencialAdqMiLote), "SecRevAut", "", True
   Else
      PMPasoValoresATX VGSqlConn, "@i_fechareg", 0, SQLVARCHAR, VLFecContable_aaaammdd, "FecRegRevAut", ""    'GAMC - 12ENE10
      
      PMPasoValoresATX VGSqlConn, "@i_psecuencial_adq", 0, SQLVARCHAR, (VLSecuencialAdqMiLote), "SecRevAut", ""
   End If
   
   PMPasoValoresATX VGSqlConn, "@i_secuencial", 0, SQLVARCHAR, (VLSecuencialAdqMiLote), "SecRevAut", ""
   PMPasoValoresATX VGSqlConn, "@i_tipotran", 0, SQLVARCHAR, "010007", "TipoTrn", ""
   'PMPasoValoresATX VGSqlConn, "@i_ptipo_transaccion", 0, SQLVARCHAR, "310006", "PTipoTrn", "" 'msilvag Bus Fase2
   PMPasoValoresATX VGSqlConn, "@i_aplcobis", 0, SQLVARCHAR, "S", "AplCobis", "" 'msilvag Bus Fase2
      
   PMPasoValoresATX VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, "0233" & Format(Mid(VGAgencia, 1, 6), "000000") & Mid$(VGterminal, 1, 6), "NumeroTerminal", ""
   PMPasoValoresATX VGSqlConn, "@i_identifica", 0, SQLVARCHAR, Mid(Trim$(cedula.ClipText), 1, 13), "Cedula", ""
   PMPasoValoresATX VGSqlConn, "@i_pmoneda", 0, SQLVARCHAR, "840", "TipoMoneda", ""
   PMPasoValoresATX VGSqlConn, "@i_pproducto", 0, SQLVARCHAR, "0010031006", "Producto", ""
   'PMPasoValoresATX VGSqlConn, "@i_ptipo", 0, SQLVARCHAR, "VTA", "Tipo", ""
   PMPasoValoresATX VGSqlConn, "@i_psubtipo", 0, SQLVARCHAR, "23", "SubTipo", ""
   'PMPasoValoresATX VGSqlConn, "@i_anioconvenio", 0, SQLVARCHAR, CStr(VLMLAnioConvenio), "AnioConvenio", ""
   'PMPasoValoresATX VGSqlConn, "@i_cuota", 0, SQLVARCHAR, CStr(VLMLNoCuota), "AnioConvenio", ""
   PMPasoValoresATX VGSqlConn, "@i_cuota", 0, SQLVARCHAR, Me.Agno.Caption, "AnioConvenio", ""
   
   
   'PMPasoValoresATX VGSqlConn, "@i_agno", 0, SQLINT2, CInt(Format(Replace(VLMLNoCuota, "/", ""), "0000")), "AnioConvenio", ""
   PMPasoValoresATX VGSqlConn, "@i_codresbr", 0, SQLVARCHAR, "000000", "CodResBr", ""
   
   'PMPasoValoresATX VGSqlConn, "@i_numeroconvenio", 0, SQLVARCHAR, CStr(Format(VLMLNoConvenio, "000000")), "NumeroConvenio", ""
   If VGTipoEjecucion% = CGReverso% Then
      'PMPasoValoresATX VGSqlConn, "@i_valorapagar", 0, SQLVARCHAR, CStr(Mid(VLMLValoresPagar, 1, 28)) + Mid(VLValorAPagar, 1, 8), "ValorAPagarBr", "", True
      PMPasoValoresATX VGSqlConn, "@i_valorapagar", 0, SQLVARCHAR, CStr(Mid(VLMLValoresPagar, 1, 28)), "ValorAPagarBr", ""
      PMPasoValoresATX VGSqlConn, "@i_Agno(0)", 0, SQLINT4, VLMLNoCuota, "AnioConvenio", ""
   Else
      PMPasoValoresATX VGSqlConn, "@i_valorapagar", 0, SQLVARCHAR, CStr(Mid(VLMLValoresPagar, 1, 28)), "ValorAPagarBr", ""
      PMPasoValoresATX VGSqlConn, "@i_valorapagar2", 0, SQLVARCHAR, CStr(Mid(VLMLValoresPagar, 21, 8)), "ValorAPagarBr2", ""
      PMPasoValoresATX VGSqlConn, "@i_Agno(0)", 0, SQLINT2, CInt(Format(Replace(VLMLNoCuota, "/", ""), "0000")), "AnioConvenio", ""
   End If
   'PMPasoValoresATX VGSqlConn, "@i_pcanal", 0, SQLVARCHAR, "VEN", "Canal", ""
   PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(FMObtenerMonedaForma("19")), "Moneda", ""
   
   PMPasoValoresATX VGSqlConn, "@i_efe", 0, SQLMONEY, CCur(efe.Text), "ValEfectivo", ""
    
   PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, CInt(Me.municipio.Text), "MunicipioMiLote", ""
   
   'msilvag Inicio Migracion WebService Ene-06-2015
    PMPasoValoresATX VGSqlConn, "@i_pfecha_comp", 0, SQLVARCHAR, VLFecContable_aaaammdd, "FechaComp", ""     'GAMC - 12ENE10
    PMPasoValoresATX VGSqlConn, "@i_pfecha_hora_br", 0, SQLVARCHAR, VLFecContable_aaaammdd & Format$(Time(), "hhmmss"), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_trx_local", 0, SQLINT4, VLFecContable_aaaammdd, "", ""
    PMPasoValoresATX VGSqlConn, "@i_phora_trx_local", 0, SQLINT4, Format$(Time(), "hhmmss"), "", ""
    PMPasoValoresATX VGSqlConn, "@i_psecbr", 0, SQLVARCHAR, "000001", "SecBr", ""    'Es la primera consulta por lo tanto se envia cero.
    PMPasoValoresATX VGSqlConn, "@i_pvalor_total", 0, SQLMONEY, (Me.ValorMun.Text), "ValorMun", ""
    PMPasoValoresATX VGSqlConn, "@i_pnumero", 0, SQLVARCHAR, VLMLNoConvenio, "NoCatastral", ""
    PMPasoValoresATX VGSqlConn, "@i_panio_vigencia", 0, SQLVARCHAR, CStr(VLMLAnioConvenio), "AnioConvenio", ""
    
    PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Canal", ""
    
    PMPasoValoresATX VGSqlConn, "@i_ptipo_transaccion", 0, SQLVARCHAR, "45109M", "", ""  'msilvag Migracion WebService "010002"
    PMPasoValoresATX VGSqlConn, "@i_pinst_adquirente", 0, SQLVARCHAR, "00597777", "", ""  '00597777
    PMPasoValoresATX VGSqlConn, "@i_poperador", 0, SQLVARCHAR, String(9 - Len(Trim$(VGUsuario)), "0") + VGUsuario, "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_pcomp", 0, SQLINT4, "2245", "mun_cod", ""
    PMPasoValoresATX VGSqlConn, "@i_serv_code", 0, SQLVARCHAR, "02", "municipio", "" 'Servicio Mi lote
    PMPasoValoresATX VGSqlConn, "@i_pchanal", 0, SQLVARCHAR, "9", "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_pcod_adquirente", 0, SQLVARCHAR, "0233", "muni_codIntAdq", ""
    'msilvag FIn
    
   PMPasoValoresATX VGSqlConn, "@i_empresa", 0, SQLVARCHAR, CStr(Me.municipio.Text), "MunicipioCatalogo", ""
   PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, CCur(Cheques.Text), "ValCheque", ""
   PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, CCur(Debito.Text), "ValDebito", ""
   PMPasoValoresATX VGSqlConn, "@i_autoriza", 0, SQLCHAR, VGAutoriza, "Autoriza", ""
   PMPasoValoresATX VGSqlConn, "@i_cant_chq", 0, SQLINT4, val(CantChq.Text), "CantCh.", ""
   PMPasoValoresATX VGSqlConn, "@i_nombre", 0, SQLVARCHAR, CStr(VLMLContribuyente), "NombreContrib", ""
   PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "T", "Opcion", "" 'msilvag SOA fase 2 "V"
   
   'ref003 Ini SGC00030409
   If Me.Cta.ClipText <> "" Then
     PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (CboTipCta.Text), "ProductoCta", ""
     PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cuenta", ""
   Else
     PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (VLTipCta_com), "ProductoCta", ""
     PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (VLCta_com), "Cuenta", ""
   End If
   'PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLVARCHAR, (CboTipCta.Text), "ProductoCta", ""
   'PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, CStr(Cta.ClipText), "Cuenta", ""
   PMPasoValoresATX VGSqlConn, "@i_deb_com", 0, SQLMONEY, (VLDeb_com), "ComisionDebito", ""
   'ref003 Fin SGC00030409
      
   PMPasoValoresATX VGSqlConn, "@i_efe_com", 0, SQLMONEY, (VLEfe_com), "ComisionEfectivo", ""
   PMPasoValoresATX VGSqlConn, "@i_chq_com", 0, SQLMONEY, (VLChq_com), "ComisionCheque", ""
   PMPasoValoresATX VGSqlConn, "@i_tarjeta", 0, SQLMONEY, (Tarjeta.Text), "Tarjeta", "" 'msilvag:RECA-CE-SGC000  enviar campo tarjeta
   
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
   
   'PMPasoValoresATX VGSqlConn, "@o_codautorizador", 1, SQLINT4, 0, "OCodAutorizador", ""
   PMPasoValoresATX VGSqlConn, "@i_sal_municipio", 0, SQLVARCHAR, (sal_municipio.Caption), "sal_municipio", ""
   PMPasoValoresATX VGSqlConn, "@i_sal_tipo", 0, SQLVARCHAR, (sal_tipo.Caption), "sal_tipo", ""
   PMPasoValoresATX VGSqlConn, "@i_tipo_impto", 0, SQLVARCHAR, (Tipo), "tipoimpto", ""
   
   'PMPasoValoresATX VGSqlConn, "@o_codresbr", 1, SQLVARCHAR, "000000", "OCodigoResultadoBanred", ""
   'PMPasoValoresATX VGSqlConn, "@o_fechareg", 1, SQLVARCHAR, "XXXXXXXX", "OFechaRegistro", ""
   PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, 0, "Ossn", ""
   PMPasoValoresATX VGSqlConn, "@o_horario", 1, SQLCHAR, "X", "OHorario", ""
   'PMPasoValoresATX VGSqlConn, "@o_comision", 1, SQLMONEY, 0, "OComision", ""
   PMPasoValoresATX VGSqlConn, "@o_autorisri", 1, SQLVARCHAR, "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "OAutoriSri", ""
   PMPasoValoresATX VGSqlConn, "@o_fecvensri", 1, SQLVARCHAR, "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", "OFecVenSri", ""
   PMPasoValoresATX VGSqlConn, "@o_fechora", 1, SQLVARCHAR, "xxxxxxxxxxxxxxxx", "OFechaHora", ""
   PMPasoValoresATX VGSqlConn, "@o_feccontable", 1, SQLVARCHAR, "XXXXXXXXXX", "OFechaContable", ""
   PMPasoValoresATX VGSqlConn, "@o_fecha_ef", 1, SQLVARCHAR, "xxxxxxxxxx", "", "oFechaEfec"
   PMPasoValoresATX VGSqlConn, "@o_nota_venta", 1, SQLVARCHAR, "XXXXXXXXXXXXXXX", "ONotaVenta", ""
   PMPasoValoresATX VGSqlConn, "@o_pcuic", 1, SQLVARCHAR, "xxxxxxxxxx", "OCuid", ""
   PMPasoValoresATX VGSqlConn, "@o_pautorizacion", 1, SQLVARCHAR, "xxxxxxxxxx", "Autorizacion", ""
   
   'If FMTransmitirRPCATX(VGSqlConn, vl_servidor_BUS, "cob_procesador", "fp_pago_mimg_cep", True, "Transaccion Ok", "S", "N", "S", "19", "S", "S") = True Then
   If FMTransmitirRPCATX(VGSqlConn, vl_servidor_BUS, "cob_procesador", "fp_pago_mimg_cep", True, "Transaccion Ok", "S", "N", "S", "19", "S", "S") = True Then 'msilvag Migracion WebService
        FLTransmitir_CPS_MILOTE_pago = True
      VTResult% = FMMapeaMatrizATX(VGSqlConn&, vtmatrizcps())

      If VGTipoEjecucion% = CGReverso% Then
'         VLMLAnioConvenio = FLBuscarItem("@o_panio_convenio")
'         VLMLNoConvenio = FLBuscarItem("@o_pnumero_convenio")
         VLMLValoresPagar = CStr(VLMLValoresPagar) + CStr(VLValorAPagar)
         TmpMLVigencia = Mid(VLMLValoresPagar, 10, 12)
         TmpMLVigencia = Mid(Date, 7, 2) & Mid(TmpMLVigencia, 1, 2) & "/" & Mid(TmpMLVigencia, 3, 2) & "/" & Mid(TmpMLVigencia, 5, 2) & " - " & Mid(Date, 7, 2) & Mid(TmpMLVigencia, 7, 2) & "/" & Mid(TmpMLVigencia, 9, 2) & "/" & Mid(TmpMLVigencia, 11, 2)
         VLMLPeriodoVigencia = TmpMLVigencia
      End If
      
      
      VLTsnTemporal = VGTSN
      PMChequeaATX VGSqlConn
      PMTotalesBranch "19"
      VLCambio% = False
      'TPE ------> Sumadora
     SGSecTrn$ = FMRetParamATX(VGSqlConn, 1) 'FMRetParamATX(VGSqlConn, 3)
      VLSSnCorreccion = FMRetParamATX(VGSqlConn, 1) 'FMRetParamATX(VGSqlConn, 3)
      VLSsn = FMRetParamATX(VGSqlConn, 1) 'FMRetParamATX(VGSqlConn, 3)
      VLHorario = Trim$(FMRetParamATX(VGSqlConn, 2)) 'Trim$(FMRetParamATX(VGSqlConn, 4))
      If Len(Trim$(VLSsn)) > 6 Then
         VLSsn = Right$(Trim$(VLSsn), 6)
      Else
         VLSsn = String(6 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
      End If
      
      VLautoriSri = Mid(FMRetParamATX(VGSqlConn, 3), 1, 10) 'Mid(FMRetParamATX(VGSqlConn, 7), 1, 10)   'GAMC - 05FEB10 - Cambio por Muni. GYE
      VLFecvenSRI = Mid(FMRetParamATX(VGSqlConn, 4), 14, 10) 'Mid(FMRetParamATX(VGSqlConn, 7), 14, 10)  'GAMC - 05FEB10 - Cambio por Muni. GYE
      VLSerie_Secuencia = FMRetParamATX(VGSqlConn, 1)  'FMRetParamATX(VGSqlConn, 8)  'hy-24-feb-2005
      VLFechaEfe = FMRetParamATX(VGSqlConn, 7) 'FMRetParamATX(VGSqlConn, 10)
      'VLFechaEfe = Mid(VLFechaEfe, 5, 2) & "/" & Mid(VLFechaEfe, 7, 2) & "/" & Mid(VLFechaEfe, 1, 4)
      
      VTIndicadorSum = 1
      PMIniciaRegSum
      '<-----
   Else
      VLTsnTemporal = VGTSN     'lfcm borrar esta linea
      FLTransmitir_CPS_MILOTE_pago = False
      VLCambio% = True
      VLFechaCorte = ""
      SGSecTrn$ = FMRetParamATX(VGSqlConn, 3)
      VTIndicadorSum = 0
      PMChequeaATX VGSqlConn
      PMFinTransaccion
      Exit Function
   End If
    PMChequeaATX VGSqlConn
    If FMRetStatusATX(VGSqlConn) <> 0 Then
        VTIndicadorSum = 0
        FLTransmitir_CPS_MILOTE_pago = False
        PMFinTransaccion
        Exit Function
    End If
    
    'msilvag Inicio Migracion WebService Feb-26-2016
'    PMChequeaATX VGSqlConn
'    If FMRetStatusATX(VGSqlConn) <> 0 Then
'        VTIndicadorSum = 0
'        FLTransmitir_CPS_MILOTE_pago = False
'        PMFinTransaccion
'        Exit Function
'    End If
    'msilvag Fin
    
    PMFinTransaccion
    
    'GAMC - 02AGO10
    'JPM Lectora de Billetes -->
    If CCur(efe.Text) > 0 And ((VGDatPersBillAltDen.dataOK And VGTipoEjecucion = CGNormal%) Or VGTipoEjecucion = CGReverso%) Then
      Call PMGuardarDsglsBillete("19", SGSecTrn$, VLTrn, rptBAD, "REC", "")
      lectoraBill.Limpiar
    End If
    '<-- JPM Lectora de Billetes
    'ref003 Ini
    If VLDeb_com = 0 Then
        Call PLFactura
    End If
    'ref003 Fin
    
   'Sumadora -->
   If VGTipoEjecucion% <> CGReverso% Then   'Validacion por REVERSO
      If (VTIndicadorSum = 1 And (Trim$(VGStatusCon) = "A" Or Trim$(VGStatusCon) = "")) Then
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
   ImprimeComprobanteMiLote
End Function

Sub ImprimeComprobanteMiLote()
'VGparlong$ = "90"
'VGpartop$ = "10"
'VGparleft$ = "10"
'VGparrig$ = "00"
'PMSetDetalle "v" + "Este pago sera procesado el " + VLFechaEfe
'PMSetDetalle "v" + " "
'PMSetDetalle "v" + "EMPRESA    : " + Trim$(municipio.Text) + " " + Trim$(Mid$(sal_municipio.Caption, 1, 36))
'PMSetDetalle "v" + "                PAGO DE MI LOTE"
'PMSetDetalle "v" + "-------------------------------------------------"
'PMSetDetalle "v" + "CONTRIBUYENTE   : " + Trim$(Left(Contribuyente.Caption, 35))
'PMSetDetalle "v" + "No. CEDULA      : " + Trim$(Cedula.ClipText)
'PMSetDetalle "v" + "No. CONVENIO    : " + Trim$(VLMLNoConvenio)
'PMSetDetalle "v" + "No. CUOTA       : " + Trim$(Agno.Caption)
'PMSetDetalle "v" + "PERIODO VIGENCIA: " + Trim$(VLMLPeriodoVigencia)
'PMSetDetalle "v" + " "
'PMSetDetalle "v" + "TOTAL A PAGAR   :" + FMEspaciosATX("USD.   " + Format(Trim$(ValorMun), VGFormatoMoney), 13, CGJustificacionDerecha)
'PMSetDetalle "v" + "-------------------------------------------------"
'PMSetDetalle "v" + "FORMAS DE PAGO:"
'PMSetDetalle "v" + "-------------------------------------------------"
'If Val(efe.Text) > 0 Then
'    PMSetDetalle "v" + "EFECTIVO        : " + FMEspaciosATX("USD.   " + Format(efe, VGFormatoMoney), 13, CGJustificacionDerecha)
'End If
'If Val(Cheques.Text) > 0 Then
'    PMSetDetalle "v" + "CHEQUE(" + Trim$(CantChq.Text) + ")       : " + FMEspaciosATX("USD.   " + Format(Cheques, VGFormatoMoney), 13, CGJustificacionDerecha)
'End If
'If Val(Debito.Text) > 0 Then
'    PMSetDetalle "v" + "DEBITO          : " + FMEspaciosATX("USD.   " + Format(Debito, VGFormatoMoney), 13, CGJustificacionDerecha) + " CUENTA : " + Format(Cta.ClipText, "000-000000-0")
'End If
'PMSetDetalle "v" + "-------------------------------------------------"
'PMSetDetalle "v" + ""

 ' If Not FMFormatPagina(VGparformato$, VGparlong$, VGpartop$, VGparleft$, VGparrig$) Then
     VGparlong$ = "66"
     VGpartop$ = "00"
     VGparleft$ = "08" 'ref02 vmirandt
     VGparrig$ = "00"
 ' End If
    PMSetDetalle "v" + "Este pago sera procesado el " + VLFechaEfe
    PMSetDetalle "v" + "EMPRESA: " + Trim$(municipio.Text) + " " + Trim$(Mid$(sal_municipio.Caption, 1, 24)) + "  Tipo Serv.: " + Trim$(Tipo.Text) + " " + Trim$(Mid$(Me.sal_tipo.Caption, 1, 15))

    PMSetDetalle "v" + "CONTRIBUYENTE   : " + Trim$(Left(Contribuyente.Caption, 30))
    If VGTipoEjecucion% <> CGReverso% Then
        PMSetDetalle "v" + "CED: " + Trim$(cedula.ClipText) '+ "    " + "No.CONVENIO: " + Trim$(VLMLNoConvenio)
    Else
        PMSetDetalle "v" + "CED: " + Trim$(VLCedulaMig)
    End If
    PMSetDetalle "v" + "PERIODO VIGENCIA: " + Trim$(VLMLPeriodoVigencia) + "    " + "CUOTA: " + Trim$(Agno.Caption)
    PMSetDetalle "v" + "VALOR:            " + FMEspaciosATX("USD.   " + Format(Trim$(ValorMun), VGFormatoMoney), 13, CGJustificacionDerecha)
    If val(efe.Text) > 0 Then
       
       If val(Cheques.Text) > 0 Then
          PMSetDetalle "v" + "EFE: " + FMEspaciosATX("USD.   " + Format(efe, VGFormatoMoney), 13, CGJustificacionDerecha) + "    " + "CHQ(" + Trim$(CantChq.Text) + ")       : " + FMEspaciosATX("USD.   " + Format(Cheques, VGFormatoMoney), 13, CGJustificacionDerecha)
       Else
          PMSetDetalle "v" + "EFE: " + FMEspaciosATX("USD.   " + Format(efe, VGFormatoMoney), 13, CGJustificacionDerecha)
       
       End If
       
    
    Else
       If val(Cheques.Text) > 0 Then
          PMSetDetalle "v" + "CHQ(" + Trim$(CantChq.Text) + ")       : " + FMEspaciosATX("USD.   " + Format(Cheques, VGFormatoMoney), 13, CGJustificacionDerecha)
       End If
    End If
    
    If val(Debito.Text) > 0 Then
       PMSetDetalle "v" + "DEB: " + FMEspaciosATX("USD.   " + Format(Debito, VGFormatoMoney), 13, CGJustificacionDerecha) + " CTA : " + Format(Cta.ClipText, "000-000000-0")
    End If
    
    PMSetDetalle "v" + "TOTAL:            " + FMEspaciosATX("USD.   " + Format(Trim$(ValorMun.Text), VGFormatoMoney), 13, CGJustificacionDerecha)
    'aqui voy
    
'***ref02 vmirandt inicio, se imprime al final del documento
    If VLclave_acceso <> "" Then
        PMSetDetalle "v" + "Clave de Acceso/Autorizacion: "
        PMSetDetalle "v" + VLclave_acceso
    End If
    'ref02 vmirandt
VLHorarioDifTemporal = VGHorarioDif
If VLHorario = "N" Then
    VGHorarioDif = False
    VLTrn = "3215"
Else
    VGHorarioDif = True
    VLTrn = "3216"
End If

'FMPRN_StdImpresion "IMPRESORA_1", False, Trim$(Str$(VLTsnTemporal)), "19", SGDatosDetalle, "Inserte papeleta", CStr(VGpartop$), 1, CStr(VGparleft$), , , , , "3215", "1"
FMPRN_StdImpresion "IMPRESORA_1", False, Trim$(str$(VLTsnTemporal)), "19", SGDatosDetalle, "Inserte papeleta", CStr(VGpartop$), 4, CStr(VGparleft$), , , VLHorario, , "3215", "1", VLTrn

    'msilvag Inicio Migracion WebService de Municipio
    If VGTipoEjecucion = CGNormal% Then
        While MsgBox("Desea Reimprimir la papeleta para certificacion?", vbYesNo, "Mensaje") = vbYes
            PMReimpresion
        Wend
    End If
    'msilvag fin
End Sub


'MUNICIPIO POR CONCEPTOS DE MERCADOS Y CREDENCIALES
'nchavezb 02/03/2011
Function FLTransmitir_CSP_Mercados_MUNGYE_consulta() As Boolean
    Dim VLArregloPago1 As String
    Dim VLArregloPago2 As String
    
    Dim FechaVigencia1 As String
    Dim FechaVigencia2 As String
    
    FLTransmitir_CSP_Mercados_MUNGYE_consulta = False
    
   If Trim$(cedula.ClipText) = "" Then
      MsgBox "La cédula es mandatoria", vbCritical, "Aviso"
      If cedula.Enabled Then
         cedula.SetFocus
      End If
      Exit Function
   End If
   
   If Len(cedula.ClipText) <> 0 Then
      If FMValidaCedulaRuc(cedula.ClipText) = False Then
         If cedula.Enabled Then
            cedula.SetFocus
         End If
         Exit Function
      End If
   End If
      
   '-->Consulta el valor de la comision
   If VGHorarioDif Then
      VLTrn = "3216"
   Else
      VLTrn = "3215"
   End If
   VGTrn = IIf(VLTrn = "", 0, VLTrn)
    
   'Consulta de mercados y credenciales
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "S", "opcion", ""
    PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@o_fechora", 1, SQLVARCHAR, 0, "Fechora", ""
    PMPasoValoresATX VGSqlConn, "@o_feccontable", 1, SQLVARCHAR, 0, "Feccontable", ""
    PMPasoValoresATX VGSqlConn, "@o_secuencial", 1, SQLINT4, 0, "Secuencial", ""
    If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_tr_municipio_recaudacion", True, "Transaccion Ok", "S", "N", "N", "19", "S", "S") = True Then
        VLFecHora = FMRetParamATX(VGSqlConn, 1)
        VLFecContable = FMRetParamATX(VGSqlConn, 2)
        VLSsn = FMRetParamATX(VGSqlConn, 3)
        If Len(Trim$(VLSsn)) > 6 Then
            VLSsn = Right$(Trim$(VLSsn), 6)
        Else
            VLSsn = String(6 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
        End If
        PMChequeaATX VGSqlConn
        PMTotalesBranch "19"
        'FLConsultar = True
        FLTransmitir_CSP_Mercados_MUNGYE_consulta = True
        VLCambio% = False
        '------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 3)
        VTIndicadorSum = 1
        PMIniciaRegSum
        PMFinTransaccion
        '<-----
    Else
        VLCambio% = True
        'FLConsultar = False
        FLTransmitir_CSP_Mercados_MUNGYE_consulta = False
        '------> Sumadora
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 3)
        VTIndicadorSum = 0
        PMChequeaATX VGSqlConn
        PMFinTransaccion
        Exit Function
        '<------
    End If
    
     VLPagosAnio = "0"
     VLPagosValor = 0
   
     FLTransmitir_CSP_Mercados_MUNGYE_consulta = False
     
     Consulta_parametro_OSB 'msilvag Migracion WebService
     
     PMInicioTransaccion
    'PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 62232, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 62073, "Trn", "" 'msilvag Migracion WebService
    'If Trim$(municipio.Text) = "1435" Then
        PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "C", "opcion", ""
    'End If
    'PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
    
    'Fecha formato yyyymmdd
    VLFecContable_aaaammdd = FMConvFecha(VLFecContable, "mm/dd/yyyy", "yyyy/mm/dd")
    VLFecContable_aaaammdd = Mid(VLFecContable_aaaammdd, 1, 4) & Mid(VLFecContable_aaaammdd, 6, 2) & Mid(VLFecContable_aaaammdd, 9, 2)
    
    PMPasoValoresATX VGSqlConn, "@i_pfecha_hora_br", 0, SQLVARCHAR, VLFecContable_aaaammdd & Format$(Time(), "hhmmss"), "FechaHoraBr", ""
   
    PMPasoValoresATX VGSqlConn, "@i_phora_trx_local", 0, SQLVARCHAR, Format$(Time(), "hhmmss"), "HoraTrnLocal", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_trx_local", 0, SQLVARCHAR, VLFecContable_aaaammdd, "FechaTrnLocal", ""
   
    PMPasoValoresATX VGSqlConn, "@i_pfecha_comp", 0, SQLVARCHAR, VLFecContable_aaaammdd, "FechaComp", ""
    
     'msilvag Migracion WebService Enero-12-2016
    PMPasoValoresATX VGSqlConn, "@i_ptipo_transaccion", 0, SQLVARCHAR, 310000, "TipoTrn", ""
    PMPasoValoresATX VGSqlConn, "@i_pinst_adquirente", 0, SQLVARCHAR, "00597777", "CodigoABA", ""
    PMPasoValoresATX VGSqlConn, "@i_poperador", 0, SQLVARCHAR, String(9 - Len(Trim$(VGUsuario)), "0") + VGUsuario, "CodigoOperador", ""
    PMPasoValoresATX VGSqlConn, "@i_pcomp", 0, SQLINT4, "2245", "mun_cod", ""
    PMPasoValoresATX VGSqlConn, "@i_serv_code", 0, SQLVARCHAR, "04", "ServCode", ""
    PMPasoValoresATX VGSqlConn, "@i_pchanal", 0, SQLVARCHAR, "9", "iPChanel", ""
    PMPasoValoresATX VGSqlConn, "@i_pcod_adquirente", 0, SQLVARCHAR, "0233", "muni_codIntAdq", ""
    PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Canal", ""
    PMPasoValoresATX VGSqlConn, "@i_pmoneda", 0, SQLINT4, "840", "mon", ""
    PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_psecbr", 0, SQLINT4, "000001", "municipio", ""
   'msilvag Fin
   
    PMPasoValoresATX VGSqlConn, "@i_psecuencial_adq", 0, SQLVARCHAR, Trim$(CStr(VLSsn)), "SecAdquiriente", ""
   'Verificar la longitud de la variable VGAgencia, y VGterminal
   ' ame 08/28/2012 PMPasoValoresATX VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, "1007" & Format(Mid(VGAgencia, 1, 6), "000000") & Mid$(VGterminal, 1, 6), "NumeroTerminal", ""
   PMPasoValoresATX VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, "0233" & Format(Mid(VGAgencia, 1, 6), "000000") & Mid$(VGterminal, 1, 6), "NumeroTerminal", ""
   PMPasoValoresATX VGSqlConn, "@i_identifica", 0, SQLVARCHAR, Mid(Trim$(cedula.ClipText), 1, 13), "Cedula", ""
   PMPasoValoresATX VGSqlConn, "@i_pproducto", 0, SQLVARCHAR, "0010031006", "Producto", ""
   PMPasoValoresATX VGSqlConn, "@i_ptipo", 0, SQLVARCHAR, "VTA", "Tipo", ""
   PMPasoValoresATX VGSqlConn, "@i_psubtipo", 0, SQLVARCHAR, "23", "SubTipo", ""
   
   PMPasoValoresATX VGSqlConn, "@i_tipoConsulta", 0, SQLVARCHAR, (Me.txtTipoConsulta.Text), "TipoConsulta", ""
   PMPasoValoresATX VGSqlConn, "@i_descripTipCons", 0, SQLVARCHAR, (Me.lblTipoConsulta.Caption), "DescripTipoCons", ""
    
   VGErrorTransmision = False 'msilvag Migracion WebService
   'If FMTransmitirRPCATX(VGSqlConn, vl_servidor_BUS, "cob_procesador", "fp_consulta_mimg_cep", True, "Transaccion Ok", "S", "N", "N", "19", "S", "S") = True Then 'msilvag SOA fase2
    If FMTransmitirRPCATX(VGSqlConn, vl_servidor_BUS, "cob_procesador", "fp_consulta_mimg_cep", True, "Transaccion Ok", "S", "N", "N", "19", "S", "S") = True Then 'msilvag SOA Migracion WebService
    'If FMTransmitirRPCATX(VGSqlConn, "PSSRV1", "cob_procesador", "fp_consulta_mercados_mimg", True, "Transaccion Ok", "S", "N", "N", "19", "S", "S") = True Then
        FLTransmitir_CSP_Mercados_MUNGYE_consulta = True
         'VLMLNoCuota = Val(Agno.Caption)
        VTResult% = FMMapeaMatrizATX(VGSqlConn&, vtmatrizcps())
        VLContribuyente = FLBuscarItem("@o_pnombres") 'FLBuscarItem("@o_pnombre_apellido")
        Contribuyente.Caption = VLContribuyente
        VLIdenDeuda = FLBuscarItem("@o_pautorizacion") 'FLBuscarItem("@o_pid_deuda")
        vlclavecatastral = FLBuscarItem("@o_pnumero") 'FLBuscarItem("@o_pcodigo_puesto")
        'VLPProducto = FLBuscarItem("@o_pproducto")
        VLMercado = FLBuscarItem("@o_observacion1") 'FLBuscarItem("@o_pdescripcion")
        VLSolicitud = FLBuscarItem("@o_observacion2") 'FLBuscarItem("@o_ptipo_descrip")
        VLCodSolicitud = FLBuscarItem("@o_pdescrip_varios") 'FLBuscarItem("@o_ptipo_sol")
        'VLAutorizacion = FLBuscarItem("@o_pinstitucion_autorizadora")
        
        'msilvag Inicio Migracion WebService
        'VLArregloPago1 = FLBuscarItem("@o_pvalores_pago1")
        'VLArregloMunCre = FLBuscarItem("@o_pvalores_pago1")
        VLMLValoresPagar = FLBuscarItem("@o_pvalor_pagar")
        VLArregloMunCre = FLBuscarItem("@o_pvalor_pagar")
        
        If Trim$(VLMLValoresPagar) = "" Then
            VLMLValoresPagar1 = FLBuscarItem("@o_pvalor_pagar_0")
            VLMLValoresPagar2 = FLBuscarItem("@o_pvalor_pagar_1")
            If Trim(VLMLValoresPagar1) = "" Then
                VLMLValoresPagar1 = "0"
            End If
            If Trim(VLMLValoresPagar2) = "" Then
                VLMLValoresPagar2 = "0"
            End If
            If VLMLValoresPagar1 <> "0" And VLMLValoresPagar2 <> "0" Then
                VLMLValoresPagar = VLMLValoresPagar1 + VLMLValoresPagar2
                'VLArregloMunCre = VLMLValoresPagar1 + VLMLValoresPagar2
            ElseIf VLArregloPago1 <> "" Then
                VLMLValoresPagar = VLMLValoresPagar1
                'VLArregloMunCre = VLArregloPago1
            ElseIf VLArregloPago2 <> "" Then
                VLMLValoresPagar = VLMLValoresPagar2
                'VLArregloMunCre = VLArregloPago2
            Else
                VLMLValoresPagar = FLBuscarItem("@o_ppagos")
                'VLArregloMunCre = FLBuscarItem("@o_ppagos")
            End If
        End If
        'msilvag Fin
        
'         If Trim$(VLArregloMunCre) = "" Then
'            VLArregloMunCre = FLBuscarItem("@o_pvalores_pago1_0")
'         End If
'        If Trim$(VLArregloPago1) = "" Then
'            VLArregloPago1 = FLBuscarItem("@o_pvalores_pago1_0")
'            VLArregloPago1 = VLArregloPago1 + FLBuscarItem("@o_pvalores_pago1_1")
'            VLArregloPago1 = VLArregloPago1 + FLBuscarItem("@o_pvalores_pago1_2")
'            VLArregloPago1 = VLArregloPago1 + FLBuscarItem("@o_pvalores_pago1_3")
'        End If
'        VLArregloPago2 = FLBuscarItem("@o_pvalores_pago2")
'        If Trim$(VLArregloPago2) = "" Then
'            VLArregloPago2 = FLBuscarItem("@o_pvalores_pago2_0")
'            VLArregloPago2 = VLArregloPago2 + FLBuscarItem("@o_pvalores_pago2_1")
'            VLArregloPago2 = VLArregloPago2 + FLBuscarItem("@o_pvalores_pago2_2")
'            VLArregloPago2 = VLArregloPago2 + FLBuscarItem("@o_pvalores_pago2_3")
'        End If
        
        If Trim$(VLMLValoresPagar) = "" Then 'msilvag Migracion WebService
        'If Trim$(VLArregloPago1) = "" Then
            MsgBox "NO TIENE DEUDAS PENDIENTES", vbInformation, "Aviso"
            Exit Function
        End If
        
        'msilvag Migracion Web Service Inicio
        VLItems = Len(VLMLValoresPagar) / 28
        grdBloque.Rows = VLItems + 1
        For VLFila = 1 To VLItems
            grdBloque.Row = VLFila
            grdBloque.Col = 1
            VVLMLtmpCuota = CInt(Mid(VLMLValoresPagar, (1 + (28 * VLFila) - 28) + 6, 3))
            VVLMLtmpCuota = CStr(Mid(VLMLValoresPagar, (1 + (28 * VLFila) - 28), 6))
            grdBloque.Text = CStr(VVLMLtmpCuota) '& "/" & CStr(VLItems)
            
            If VVLMLtmpCuota <> "000000" Then
                'msilvag Inicio Migracion WebService
                Me.grdBloque.Col = 2
                VLAbono = CStr(Mid(VLMLValoresPagar, (1 + (28 * VLFila) - 28) + 6, 3))
                grdBloque.Text = VLAbono
                'msilvag Fin
                grdBloque.Col = 3 '2 Migracion WebService msilvag
                VLMLFecha1 = Mid(VLMLValoresPagar, (1 + (28 * VLFila) - 28) + 9, 6)
                VLMLFecha2 = Mid(VLMLValoresPagar, (1 + (28 * VLFila) - 28) + 9 + 6, 6)
                VLMLFecha1 = Mid(Date, 7, 2) & Mid(VLMLFecha1, 1, 2) & "/" & Mid(VLMLFecha1, 3, 2) & "/" & Mid(VLMLFecha1, 5, 2)
                VLMLFecha2 = Mid(Date, 7, 2) & Mid(VLMLFecha2, 1, 2) & "/" & Mid(VLMLFecha2, 3, 2) & "/" & Mid(VLMLFecha2, 5, 2)
                grdBloque.Text = CStr(VLMLFecha1) & " - " & CStr(VLMLFecha2)
                grdBloque.Col = 4 '3 Migracion WebService msilvag
                'grdBloque.Text = Format(Mid(VLMLValoresPagar, (1 + (28 * VLFila) - 28) + 27, 7) / 100, "######.00")
                grdBloque.Text = Format(CCur(Mid(VLMLValoresPagar, 22 + (28 * VLFila) - 28, 7)) / 100, "######.00")
            End If
        Next VLFila
        'msilvag Fin
        
        If VLItems = 1 Then
            VLFlagUnicoMunMyC = True
        Else
            VLFlagUnicoMunMyC = False
        End If
        
        Else
        PMChequeaATX VGSqlConn
    End If
    PMChequeaATX VGSqlConn
    PMFinTransaccion
        
    
End Function

'MUNICIPIO POR CONCEPTOS DE MERCADOS Y CREDENCIALES
'nchavezb 02/14/2011
Function FLTransmitir_CSP_Mercados_MUNGYE_pago() As Boolean
  Dim VTIndicadorSum As Integer
  Dim VLIndReverso As Boolean
  VTIndicadorSum = 0

  FLTransmitir_CSP_Mercados_MUNGYE_pago = False

    If VGHorarioDif Then
        VLTrn = "3216"
    Else
        VLTrn = "3215"
    End If

     VGTrn = IIf(VLTrn = "", 0, VLTrn)

    VLIndReverso = False
    If VGTipoEjecucion% = CGReverso% Then
        VGTipoEjecucion% = CGNormal%
        VLIndReverso = True
    End If
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "S", "opcion", ""
    PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@o_fechora", 1, SQLVARCHAR, 0, "Fechora", ""
    PMPasoValoresATX VGSqlConn, "@o_feccontable", 1, SQLVARCHAR, 0, "Feccontable", ""
    PMPasoValoresATX VGSqlConn, "@o_secuencial", 1, SQLINT4, 0, "Secuencial", ""

     If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_tr_municipio_recaudacion", True, "Transaccion Ok", "S", "N", "N", "19", "S", "S") = True Then
        VLFecHora = FMRetParamATX(VGSqlConn, 1)
        VLFecContable = FMRetParamATX(VGSqlConn, 2)
        VLSsn = FMRetParamATX(VGSqlConn, 3)
        If Len(Trim$(VLSsn)) > 6 Then
            VLSsn = Right$(Trim$(VLSsn), 6)
         Else
            VLSsn = String(6 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
        End If
        PMChequeaATX VGSqlConn
        PMTotalesBranch "19"

        FLTransmitir_CSP_Mercados_MUNGYE_pago = True
        VLCambio% = False
        SGSecTrn$ = FMRetParamATX(VGSqlConn, 3)
        VTIndicadorSum = 1
        PMIniciaRegSum
         Else
        VLCambio% = True
        FLTransmitir_CSP_Mercados_MUNGYE_pago = False
        '------> Sumadora
        'SGSecTrn$ = FMRetParamATX(VGSqlConn, 3)
        VTIndicadorSum = 0
        PMChequeaATX VGSqlConn
        PMFinTransaccion
        Exit Function
    End If
        PMChequeaATX VGSqlConn
        If FMRetStatusATX(VGSqlConn) <> 0 Then
            VTIndicadorSum = 0
            FLTransmitir_CSP_Mercados_MUNGYE_pago = False
            PMFinTransaccion
             Exit Function
            End If
        PMFinTransaccion

        If VLIndReverso Then
        VLIndReverso = False
        VGTipoEjecucion% = CGReverso%
        End If

        FLTransmitir_CSP_Mercados_MUNGYE_pago = False

        If VGTipoEjecucion% = CGReverso% Then
        VLSsn = Trim$(str$(VGSqlConn))
        End If
        If Len(Trim$(VLSsn)) > 6 Then
        VLSsn = Right$(Trim$(VLSsn), 6)
         Else
        VLSsn = String(6 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
        End If

    If VGTipoEjecucion% <> CGReverso% Then
        'VLPasoFecha = Format$(Date, "yyyymmdd")                 'lfcm 13-agosto-2009
        VLPasoFecha = Format$(VLFecContable, "yyyymmdd")         'lfcm 13-agosto-2009
        VLPasoHora = Format$(Time(), "hhmmss")
        VLSecuencialAdqMunCue = VLSsn
    Else
        VLSecuencialAdqMunCue = VLSsnRevTimeOut
    End If
    
        PMChequeaATX VGSqlConn
        VLFecContable_aaaammdd = FMConvFecha(VLFecContable, "mm/dd/yyyy", "yyyy/mm/dd")
        VLFecContable_aaaammdd = Mid(VLFecContable_aaaammdd, 1, 4) & Mid(VLFecContable_aaaammdd, 6, 2) & Mid(VLFecContable_aaaammdd, 9, 2)

    VLIndReverso = False
    If VGTipoEjecucion% = CGReverso% Then
        'VGTipoEjecucion% = CGNormal%
        VLIndReverso = True
    End If
    
    Consulta_parametro_OSB 'msilvag Migracion WebService
    
    PMInicioTransaccion
    'PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 62233, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 62074, "Trn", "" 'msilvag Migracion WebService
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "T", "opcion", ""
    PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
'    PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, 1435, "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_desmun", 0, SQLVARCHAR, (Me.sal_municipio.Caption), "DescMun", ""    'lfcm 04-marzo-2009 Para obtener del logger la desc.del Municipio en el reverso
    PMPasoValoresATX VGSqlConn, "@i_identifica", 0, SQLVARCHAR, cedula.ClipText, "identificacion", ""
    PMPasoValoresATX VGSqlConn, "@i_tipo_impto", 0, SQLVARCHAR, (Tipo.Text), "Tipo", ""
    PMPasoValoresATX VGSqlConn, "@i_sal_tipo", 0, SQLVARCHAR, (sal_tipo.Caption), "descripcion", ""
    
    PMPasoValoresATX VGSqlConn, "@i_nombre", 0, SQLVARCHAR, (Contribuyente.Caption), "Nombre", ""
    PMPasoValoresATX VGSqlConn, "@i_efe", 0, SQLMONEY, (efe.Text), "efe", ""
    PMPasoValoresATX VGSqlConn, "@i_cant_chq", 0, SQLINT4, val(CantChq.Text), "Moneda", ""
    PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, (Cheques.Text), "Cheques", ""
    PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(FMObtenerMonedaForma("19")), "Moneda", ""   'lfcm 04-marzo-2009 Para enviar el nombre del municipio y poder Mapearlo en el Reverso
    PMPasoValoresATX VGSqlConn, "@i_autoriza", 0, SQLVARCHAR, VGAutoriza, "Autorizacion", ""
    PMPasoValoresATX VGSqlConn, "@i_supautor", 0, SQLVARCHAR, VGSuperAutoriza$, "Supervisor de Monto", ""       'ref:esma10mar2003
    PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, (Debito.Text), "Debito", ""
    PMPasoValoresATX VGSqlConn, "@i_tarjeta", 0, SQLMONEY, (Tarjeta.Text), "Tarjeta", ""
    'ref003 Ini
    If Me.Cta.ClipText <> "" Then
      PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (CboTipCta.Text), "CboTipCta", ""
    PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
    Else
      PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (VLTipCta_com), "CboTipCta", ""
      PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (VLCta_com), "Cta", ""
    End If
    'PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
    'PMPasoValoresATX VGSqlConn, "@i_producto", 0, SQLCHAR, (CboTipCta.Text), "CboTipCta", ""
   'ref003 Fin
    PMPasoValoresATX VGSqlConn, "@i_efe_com", 0, SQLMONEY, (VLEfe_com), "Com. efectivo", ""
    PMPasoValoresATX VGSqlConn, "@i_chq_com", 0, SQLMONEY, (VLChq_com), "Com. Cheques", ""
    PMPasoValoresATX VGSqlConn, "@i_deb_com", 0, SQLMONEY, (VLDeb_com), "Com. Debito", ""
    'PMPasoValoresATX VGSqlConn, "@i_tipocta_com", 0, SQLCHAR, (VLTipCta_com), "Com. TipCta", ""
    'PMPasoValoresATX VGSqlConn, "@i_cta_com", 0, SQLVARCHAR, (VLCta_com), "Com. Cta", ""
    
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
    
    'msilvag Inicio Migracion WebService
    PMPasoValoresATX VGSqlConn, "@i_psecuencial_adq", 0, SQLVARCHAR, VLSecuencialAdqMunCue, "SecAdqui", ""
    PMPasoValoresATX VGSqlConn, "@i_tipotran", 0, SQLVARCHAR, "010007", "TipoTrn", ""
    PMPasoValoresATX VGSqlConn, "@i_aplcobis", 0, SQLVARCHAR, "S", "AplCobis", ""
    PMPasoValoresATX VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, "0233" & Format(Mid(VGAgencia, 1, 6), "000000") & Mid$(VGterminal, 1, 6), "NumeroTerminal", ""
    PMPasoValoresATX VGSqlConn, "@i_pmoneda", 0, SQLINT4, "840", "mon", ""
    PMPasoValoresATX VGSqlConn, "@i_pproducto", 0, SQLVARCHAR, "0010031006", "Producto", ""
    PMPasoValoresATX VGSqlConn, "@i_tipoConsulta", 0, SQLVARCHAR, (Me.txtTipoConsulta.Text), "TipoConsulta", ""
    PMPasoValoresATX VGSqlConn, "@i_descripTipCons", 0, SQLVARCHAR, (Me.lblTipoConsulta.Caption), "DescripTipoCons", ""
    
    PMPasoValoresATX VGSqlConn, "@i_cuota", 0, SQLVARCHAR, (Me.Agno.Caption), "cuota", ""
    'variables que faltaban recuperar en reverso
    
    PMPasoValoresATX VGSqlConn, "@i_pcodigo_puesto1", 0, SQLVARCHAR, (vlclavecatastral), "tipoimpto1", ""
    PMPasoValoresATX VGSqlConn, "@i_nom_mercado", 0, SQLVARCHAR, (VLMercado), "NombreMercado", ""
    PMPasoValoresATX VGSqlConn, "@i_cod_solicitud", 0, SQLVARCHAR, (VLCodSolicitud), "CodigoSolicitud", ""
    'fin variables a recuperar
    
    If VGTipoEjecucion% = CGReverso% Then
        PMPasoValoresATX VGSqlConn, "@i_valorapagar", 0, SQLVARCHAR, CStr(Mid(VLMLValoresPagar, 1, 28)), "ValorAPagarBr", ""
        'PMPasoValoresATX VGSqlConn, "@i_ptrx_original", 0, SQLVARCHAR, "0200" + Format(VLSsn, "000000") + Format(VLFecContable_aaaammdd, "00000000") + Format$(Time(), "hhmmss") + "0233" + String(6 - Len(Trim$(Str$(VGOficina))), "0") + Trim$(Str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", "", True
        PMPasoValoresATX VGSqlConn, "@i_ptrx_original", 0, SQLVARCHAR, "0200" + Format(VLSecuencialAdqMunCue, "000000") + Format(VLFecContable_aaaammdd, "00000000") + Format$(Time(), "hhmmss") + "0233" + String(6 - Len(Trim$(str$(VGOficina))), "0") + Trim$(str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", "", True
        PMPasoValoresATX VGSqlConn, "@i_preverso", 0, SQLVARCHAR, "02", "", "", True
        
        'msilvag Inicio Migracion WebService
        VGTipoEjecucion% = CGNormal%
        PMPasoValoresATX VGSqlConn, "@i_pcodigo_puesto", 0, SQLVARCHAR, (VLAutorizacionCep), "tipoimpto", "" 'msilvag Migracion WebService
        VGTipoEjecucion% = CGReverso%
        VGErrorTransmision = False
        'msilvag Fin
    Else
        PMPasoValoresATX VGSqlConn, "@i_valorapagar", 0, SQLVARCHAR, CStr(Mid(VLMLValoresPagar, 1, 28)), "ValorAPagarBr", ""
        PMPasoValoresATX VGSqlConn, "@i_valorapagar2", 0, SQLVARCHAR, CStr(Mid(VLMLValoresPagar, 21, 8)), "ValorAPagarBr2", ""
        PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLVARCHAR, "N", "TCORR", ""
        'PMPasoValoresATX VGSqlConn, "@i_pcodigo_puesto", 0, SQLVARCHAR, (vlclavecatastral), "tipoimpto", ""
    End If
   
    'Parametros de Migracion WebService
    PMPasoValoresATX VGSqlConn, "@i_pfecha_comp", 0, SQLVARCHAR, VLFecContable_aaaammdd, "FechaComp", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_hora_br", 0, SQLVARCHAR, VLFecContable_aaaammdd & Format$(Time(), "hhmmss"), "", ""
    PMPasoValoresATX VGSqlConn, "@i_pfecha_trx_local", 0, SQLINT4, VLFecContable_aaaammdd, "", ""
    PMPasoValoresATX VGSqlConn, "@i_phora_trx_local", 0, SQLINT4, Format$(Time(), "hhmmss"), "", ""
    PMPasoValoresATX VGSqlConn, "@i_psecbr", 0, SQLVARCHAR, "000001", "SecBr", ""
    PMPasoValoresATX VGSqlConn, "@i_pvalor_total", 0, SQLMONEY, (Me.ValorMun.Text), "ValorMun", ""
    PMPasoValoresATX VGSqlConn, "@i_pnumero", 0, SQLVARCHAR, VLIdenDeuda, "IdCobro", ""
    'PMPasoValoresATX VGSqlConn, "@i_panio_vigencia", 0, SQLVARCHAR, CStr(VLMLAnioConvenio), "AnioConvenio", ""
    
    PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Canal", ""
    
    PMPasoValoresATX VGSqlConn, "@i_ptipo_transaccion", 0, SQLVARCHAR, "45109M", "", ""
    PMPasoValoresATX VGSqlConn, "@i_pinst_adquirente", 0, SQLVARCHAR, "00597777", "", ""
    PMPasoValoresATX VGSqlConn, "@i_poperador", 0, SQLVARCHAR, String(9 - Len(Trim$(VGUsuario)), "0") + VGUsuario, "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_pcomp", 0, SQLINT4, "2245", "mun_cod", ""
    PMPasoValoresATX VGSqlConn, "@i_serv_code", 0, SQLVARCHAR, "04", "municipio", ""  'Mercados
    PMPasoValoresATX VGSqlConn, "@i_pchanal", 0, SQLVARCHAR, "9", "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_pcod_adquirente", 0, SQLVARCHAR, "0233", "muni_codIntAdq", ""
    'msilvag Fin
    
    '******************************************************************
    'msilvag Inicio Comento bloque Migracion WebService
'    If VGTipoEjecucion% = CGReverso% Then
'        PMPasoValoresATX VGSqlConn, "@i_secuencial", 0, SQLVARCHAR, "001", "Sec", "", True      'hy-22-febrero-2007
'        PMPasoValoresATX VGSqlConn, "@i_ptipo_transaccion", 0, SQLINT4, "010008", "tipotran", "", True
'        PMPasoValoresATX VGSqlConn, "@i_pfecha_hora_br", 0, SQLVARCHAR, VLFecContable_aaaammdd & Format$(Time(), "hhmmss"), "vlfec", "", True
'        PMPasoValoresATX VGSqlConn, "@i_psecbr", 0, SQLVARCHAR, "0", "", "", True
'        PMPasoValoresATX VGSqlConn, "@i_phora_trx_local", 0, SQLINT4, Format$(Time(), "hhmmss"), "", "", True
'        PMPasoValoresATX VGSqlConn, "@i_pfecha_trx_local", 0, SQLINT4, VLFecContable_aaaammdd, "", "", True
'        PMPasoValoresATX VGSqlConn, "@i_pfecha_comp", 0, SQLINT4, VLFecContable_aaaammdd, "", "", True
'        PMPasoValoresATX VGSqlConn, "@i_pinst_adquirente", 0, SQLINT4, "597777", "", "", True
'        PMPasoValoresATX VGSqlConn, "@i_poperador", 0, SQLVARCHAR, String(6 - Len(Trim$(VGUsuario)), "0") + VGUsuario, "", "", True
'        PMPasoValoresATX VGSqlConn, "@i_psecuencial_adq", 0, SQLINT4, Format(VLSecuencialAdqMunCue, "000000"), "", "", True
'        ' ame 08/28/2012 PMPasoValoresATX VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, "1007" + String(6 - Len(Trim$(Str$(VGOficina))), "0") + Trim$(Str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", "", True
'        PMPasoValoresATX VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, "0233" + String(6 - Len(Trim$(Str$(VGOficina))), "0") + Trim$(Str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", "", True
'        PMPasoValoresATX VGSqlConn, "@i_pproducto", 0, SQLVARCHAR, "0010031008", "", "", True
'        PMPasoValoresATX VGSqlConn, "@i_pid_deuda", 0, SQLINT4, (VLIdenDeuda), "tipoimpto", "", True
'        PMPasoValoresATX VGSqlConn, "@i_no_predio", 0, SQLINT4, (Agno.Caption), "Numero deuda", ""
'        PMPasoValoresATX VGSqlConn, "@i_ptipo_consulta", 0, SQLCHAR, (tipo.Text), "tipo", "", True
'        PMPasoValoresATX VGSqlConn, "@i_pmoneda", 0, SQLINT4, "840", "mon", "", True
'        'PMPasoValoresATX VGSqlConn, "@i_psecbr", 0, SQLVARCHAR, (VGSecBanredMG), "", ""
'        '-->Parametros requeridos por el CPS para armar la trama.
'        PMPasoValoresATX VGSqlConn, "@i_pcanal", 0, SQLVARCHAR, "001", "", "", True
'        PMPasoValoresATX VGSqlConn, "@i_tipo_impto", 0, SQLVARCHAR, (tipo), "tipoimpto", "", True
'        PMPasoValoresATX VGSqlConn, "@i_pcodigo_puesto", 0, SQLVARCHAR, (vlclavecatastral), "tipoimpto", "", True
'        PMPasoValoresATX VGSqlConn, "@i_pid_pago", 0, SQLCHAR, (tipo.Text), "tipo", "", True
'        PMPasoValoresATX VGSqlConn, "@i_pvalor_total", 0, SQLMONEY, (Me.ValorMun.Text), "ValorMun", "", True
'
'      PMPasoValoresATX VGSqlConn, "@i_preverso", 0, SQLVARCHAR, "02", "", "", True
'      ' ame 08/28/2012 PMPasoValoresATX VGSqlConn, "@i_ptrx_original", 0, SQLVARCHAR, "0200" + VLSecuencialAdqMunCue + Format(VLFechaMunCue, "00000000") + VLHoraMunCue + "1007" + String(6 - Len(Trim$(Str$(VGOficina))), "0") + Trim$(Str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", "", True
'      PMPasoValoresATX VGSqlConn, "@i_ptrx_original", 0, SQLVARCHAR, "0200" + VLSecuencialAdqMunCue + Format(VLFechaMunCue, "00000000") + VLHoraMunCue + "0233" + String(6 - Len(Trim$(Str$(VGOficina))), "0") + Trim$(Str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", "", True
'      PMPasoValoresATX VGSqlConn, "@i_pvalores_pago1", 0, SQLVARCHAR, Mid(VLArregloMunCre, 1, 28), "", "", True
'      'PMPasoValoresATX VGSqlConn, "@i_pvalores_pago2", 0, SQLVARCHAR, "000", "", ""
'      'PMPasoValoresATX VGSqlConn, "@i_pvalores_pago1_1", 0, SQLVARCHAR, "000", "", ""
'      'PMPasoValoresATX VGSqlConn, "@i_pvalores_pago2_1", 0, SQLVARCHAR, "000", "", ""
'   Else
'    'PMPasoValoresATX VGSqlConn, "@i_secuencial", 0, SQLVARCHAR, "001", "Sec", ""     'hy-22-febrero-2007
'    PMPasoValoresATX VGSqlConn, "@i_secuencial", 0, SQLVARCHAR, Format(VLSsn, "000000"), "", ""
'    PMPasoValoresATX VGSqlConn, "@i_ptipo_transaccion", 0, SQLINT4, "010008", "tipotran", ""
'    PMPasoValoresATX VGSqlConn, "@i_pfecha_hora_br", 0, SQLVARCHAR, VLFecContable_aaaammdd & Format$(Time(), "hhmmss"), "vlfec", ""
'    PMPasoValoresATX VGSqlConn, "@i_psecbr", 0, SQLVARCHAR, "0", "", ""
'    PMPasoValoresATX VGSqlConn, "@i_phora_trx_local", 0, SQLINT4, Format$(Time(), "hhmmss"), "", ""
'    PMPasoValoresATX VGSqlConn, "@i_pfecha_trx_local", 0, SQLINT4, VLFecContable_aaaammdd, "", ""
'    PMPasoValoresATX VGSqlConn, "@i_pfecha_comp", 0, SQLINT4, VLFecContable_aaaammdd, "", ""
'    PMPasoValoresATX VGSqlConn, "@i_pinst_adquirente", 0, SQLINT4, "597777", "", ""
'    PMPasoValoresATX VGSqlConn, "@i_poperador", 0, SQLVARCHAR, String(6 - Len(Trim$(VGUsuario)), "0") + VGUsuario, "", ""
'    PMPasoValoresATX VGSqlConn, "@i_psecuencial_adq", 0, SQLINT4, Format(VLSsn, "000000"), "", ""
'    ' ame 08/28/2012 PMPasoValoresATX VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, "1007" + String(6 - Len(Trim$(Str$(VGOficina))), "0") + Trim$(Str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", ""
'    PMPasoValoresATX VGSqlConn, "@i_pterminal", 0, SQLVARCHAR, "0233" + String(6 - Len(Trim$(Str$(VGOficina))), "0") + Trim$(Str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", ""
'    PMPasoValoresATX VGSqlConn, "@i_pproducto", 0, SQLVARCHAR, "0010031008", "", ""
'    PMPasoValoresATX VGSqlConn, "@i_pid_deuda", 0, SQLINT4, (VLIdenDeuda), "tipoimpto", ""
'    PMPasoValoresATX VGSqlConn, "@i_no_predio", 0, SQLINT4, (Agno.Caption), "Numero deuda", ""
'    PMPasoValoresATX VGSqlConn, "@i_ptipo_consulta", 0, SQLCHAR, (tipo.Text), "tipo", ""
'    PMPasoValoresATX VGSqlConn, "@i_pmoneda", 0, SQLINT4, "840", "mon", ""
'    'PMPasoValoresATX VGSqlConn, "@i_psecbr", 0, SQLVARCHAR, (VGSecBanredMG), "", ""
'    '-->Parametros requeridos por el CPS para armar la trama.
'    PMPasoValoresATX VGSqlConn, "@i_pcanal", 0, SQLVARCHAR, "001", "", ""
'    PMPasoValoresATX VGSqlConn, "@i_tipo_impto", 0, SQLVARCHAR, (tipo), "tipoimpto", ""
'    PMPasoValoresATX VGSqlConn, "@i_pcodigo_puesto", 0, SQLVARCHAR, (vlclavecatastral), "tipoimpto", ""
'    PMPasoValoresATX VGSqlConn, "@i_pid_pago", 0, SQLCHAR, (tipo.Text), "tipo", ""
'    PMPasoValoresATX VGSqlConn, "@i_pvalor_total", 0, SQLMONEY, (Me.ValorMun.Text), "ValorMun", ""
'    PMPasoValoresATX VGSqlConn, "@i_nom_mercado", 0, SQLVARCHAR, (VLMercado), "NombreMercado", ""
'    PMPasoValoresATX VGSqlConn, "@i_cod_solicitud", 0, SQLVARCHAR, (VLCodSolicitud), "CodigoSolicitud", ""
'
'
'      'PMPasoValoresATX VGSqlConn, "@i_preverso", 0, SQLVARCHAR, "02", "", "", True
'      ' ame 08/28/2012 PMPasoValoresATX VGSqlConn, "@i_ptrx_original", 0, SQLVARCHAR, "0200" + Format(VLSsn, "000000") + Format(VLFecContable_aaaammdd, "00000000") + Format$(Time(), "hhmmss") + "1007" + String(6 - Len(Trim$(Str$(VGOficina))), "0") + Trim$(Str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", "", True
'      PMPasoValoresATX VGSqlConn, "@i_ptrx_original", 0, SQLVARCHAR, "0200" + Format(VLSsn, "000000") + Format(VLFecContable_aaaammdd, "00000000") + Format$(Time(), "hhmmss") + "0233" + String(6 - Len(Trim$(Str$(VGOficina))), "0") + Trim$(Str$(VGOficina)) + Mid$(VGterminal, 1, 6), "", "", True
'      PMPasoValoresATX VGSqlConn, "@i_pvalores_pago1", 0, SQLVARCHAR, Mid(VLArregloMunCre, 1, 28), "", ""
'     ' PMPasoValoresATX VGSqlConn, "@i_pvalores_pago2", 0, SQLVARCHAR, "000", "", ""
'      'PMPasoValoresATX VGSqlConn, "@i_pvalores_pago1_1", 0, SQLVARCHAR, "000", "", ""
'      'PMPasoValoresATX VGSqlConn, "@i_pvalores_pago2_1", 0, SQLVARCHAR, "000", "", ""
'   End If
    'msilvag Fin
    '******************************************************************

   ' Parametros de Output
   PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, 0, "", ""
   PMPasoValoresATX VGSqlConn, "@o_horario", 1, SQLCHAR, "x", "", ""
   PMPasoValoresATX VGSqlConn, "@o_autorisri", 1, SQLVARCHAR, "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", "", ""
   PMPasoValoresATX VGSqlConn, "@o_fecvensri", 1, SQLVARCHAR, "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", "", ""
   PMPasoValoresATX VGSqlConn, "@o_fechora", 1, SQLVARCHAR, "xxxxxxxxxxxxxxxx", "", ""
   PMPasoValoresATX VGSqlConn, "@o_feccontable", 1, SQLVARCHAR, "xxxxxxxxxx", "", ""
   PMPasoValoresATX VGSqlConn, "@o_fecha_ef", 1, SQLVARCHAR, "xxxxxxxxxx", "", ""
   PMPasoValoresATX VGSqlConn, "@o_nota_venta", 1, SQLVARCHAR, "xxxxxxxxxxxxxxx", "", ""
   PMPasoValoresATX VGSqlConn, "@o_pcuic", 1, SQLVARCHAR, "xxxxxxxxxx", "", ""
   PMPasoValoresATX VGSqlConn, "@o_pautorizacion", 1, SQLVARCHAR, "xxxxxxxxxx", "", ""
   'PMPasoValoresATX VGSqlConn, "@o_fechap_reg", 1, SQLVARCHAR, "xxxxxxxxxx", "", ""

   If FMTransmitirRPCATX(VGSqlConn, vl_servidor_BUS, "cob_procesador", "fp_pago_mimg_cep", True, "Transaccion Ok", "S", "N", "S", "19", "S", "S") = True Then 'msilvag Migracion WebService
   'If FMTransmitirRPCATX(VGSqlConn, "PSSRV1", "cob_procesador", "fp_pago_mimg", True, "Transaccion Ok", "S", "N", "S", "19", "S", "S") = True Then

    'entro al pago
    FLTransmitir_CSP_Mercados_MUNGYE_pago = True
    VTResult% = FMMapeaMatrizATX(VGSqlConn&, vtmatrizcps())

      If VGTipoEjecucion% = CGReverso% Then
         'VLMLValoresPagar = CStr(VLArregloMunCre) + CStr(Mid(VLArregloMunCre, 1, 8))
         VLMLValoresPagar = CStr(VLMercadosDatos) '(VLMLValoresPagar) 'msilvag Migracion WebService CStr(VLArregloMunCre)
         TmpMLVigencia = Mid(VLMLValoresPagar, 10, 12)
         TmpMLVigencia = Mid(Date, 7, 2) & Mid(TmpMLVigencia, 1, 2) & "/" & Mid(TmpMLVigencia, 3, 2) & "/" & Mid(TmpMLVigencia, 5, 2) & " - " & Mid(Date, 7, 2) & Mid(TmpMLVigencia, 7, 2) & "/" & Mid(TmpMLVigencia, 9, 2) & "/" & Mid(TmpMLVigencia, 11, 2)
         VLMLPeriodoVigencia = TmpMLVigencia
         
        Else
         VLMLValoresPagar = CStr(VLMLValoresPagar) 'msilvag Migracion WebService CStr(VLArregloMunCre)
        TmpMLVigencia = Mid(VLMLValoresPagar, 10, 12)
        TmpMLVigencia = Mid(Date, 7, 2) & Mid(TmpMLVigencia, 1, 2) & "/" & Mid(TmpMLVigencia, 3, 2) & "/" & Mid(TmpMLVigencia, 5, 2) & " - " & Mid(Date, 7, 2) & Mid(TmpMLVigencia, 7, 2) & "/" & Mid(TmpMLVigencia, 9, 2) & "/" & Mid(TmpMLVigencia, 11, 2)
        VLMLPeriodoVigencia = TmpMLVigencia
      
      End If
       
      VLTsnTemporal = VGTSN
      PMChequeaATX VGSqlConn
      PMTotalesBranch "19"
      VLCambio% = False
      'TPE ------> Sumadora
      SGSecTrn$ = FMRetParamATX(VGSqlConn, 1)
      VLSSnCorreccion = FMRetParamATX(VGSqlConn, 1)
      VLSsn = FMRetParamATX(VGSqlConn, 1)
      VLHorario = Trim$(FMRetParamATX(VGSqlConn, 2))
      If Len(Trim$(VLSsn)) > 6 Then
         VLSsn = Right$(Trim$(VLSsn), 6)
      Else
         VLSsn = String(6 - Len(Trim$(VLSsn)), "0") + Trim$(VLSsn)
      End If
      
      'VGSecBanredMG = FMRetParamATX(VGSqlConn, 10)
      VLMG_ossn = FMRetParamATX(VGSqlConn, 1)
      VLSsn = FMRetParamATX(VGSqlConn, 1)
      VLHorario = FMRetParamATX(VGSqlConn, 2)
'      VLMG_autorisri = FMRetParamATX(VGSqlConn, 3)
'      VLautoriSri = Trim(VLMG_autorisri)
'      VLMG_fecvensri = FMRetParamATX(VGSqlConn, 4)
'      VLFecvenSRI = Trim(VLMG_fecvensri)
      'VLMG_fechora = FMRetParamATX(VGSqlConn, 5)
      'VLMG_feccontable = FMRetParamATX(VGSqlConn, 6)
      VLMG_fecha_ef = FMRetParamATX(VGSqlConn, 7) 'msilvag Migracion WebService
      VLFechaEfe = VLMG_fecha_ef
      'VLSerie_Secuencia = FMRetParamATX(VGSqlConn, 8)
      VLCodigoCUIC = FMRetParamATX(VGSqlConn, 9)
      VLAutorizacion = FMRetParamATX(VGSqlConn, 10)  'msilvag Migracion WebService FLBuscarItem("@o_psecuencial_br")

      
      VTIndicadorSum = 1
      PMIniciaRegSum
      
    Else
      VLTsnTemporal = VGTSN     'lfcm borrar esta linea
      FLTransmitir_CSP_Mercados_MUNGYE_pago = False
      VLCambio% = True
      VLFechaCorte = ""
      SGSecTrn$ = FMRetParamATX(VGSqlConn, 1) 'msilvag Migracion WebService FMRetParamATX(VGSqlConn, 3)
      VTIndicadorSum = 0
      PMChequeaATX VGSqlConn
      PMFinTransaccion
      Exit Function
    End If
      
        PMChequeaATX VGSqlConn
        If FMRetStatusATX(VGSqlConn) <> 0 Then
        VTIndicadorSum = 0
        FLTransmitir_CSP_Mercados_MUNGYE_pago = False
        PMFinTransaccion
        Exit Function
        End If
        PMFinTransaccion
    
    'JPM Lectora de Billetes -->
    If CCur(efe.Text) > 0 And ((VGDatPersBillAltDen.dataOK And VGTipoEjecucion = CGNormal%) Or VGTipoEjecucion = CGReverso%) Then
      Call PMGuardarDsglsBillete("19", SGSecTrn$, VLTrn, rptBAD, "REC", "")
      lectoraBill.Limpiar
    End If
    '<-- JPM Lectora de Billetes
    'ref003 Ini
    If VLDeb_com = 0 Then
    
    Call PLFactura
    End If
    'ref003 Fin
    
    'Sumadora -->
   If VGTipoEjecucion% <> CGReverso% Then   'Validacion por REVERSO
      If (VTIndicadorSum = 1 And (Trim$(VGStatusCon) = "A" Or Trim$(VGStatusCon) = "")) Then
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
    
     
ImprimirComprobanteMercados_MUNGYE
      
      'Call Form_KeyDown(CGTeclaF5%, 0)

End Function
Sub ImprimirComprobanteMercados_MUNGYE()
'Comprobante de Mercados y Credenciales Guayaquil
'nchavezb 02/14/2011

         VGparlong$ = "66"
         VGpartop$ = "00"
         VGparleft$ = "08"
         VGparrig$ = "00"
  Dim Fecha As String
 Fecha = Trim$(Mid$(VLFechaEfe, 1, 11))
    PMSetDetalle "v" + "Este pago sera procesado el " + Trim$(Fecha)
    PMSetDetalle "v" + "EMPRESA:" + Trim$(municipio.Text) + " " + Trim$(Mid$(sal_municipio.Caption, 1, 24)) + "  Tipo Serv.: " + Trim$(Mid$(Me.sal_tipo, 1, 10)) 'ref02 vmirandt

    'PMSetDetalle "v" + "SOLICITUD: " + Trim$(sal_tipo.Caption) + " - " + Trim$(VLCodSolicitud) + "  " + "No. AUT.:" + Trim$(VGSecBanredMG)
    'msilvag Inicio Migracion WebService
    If VGTipoEjecucion% <> CGReverso% Then
        PMSetDetalle "v" + "CED.: " + Trim$(cedula.ClipText) + "#CATAST.:  " + (vlclavecatastral) + "   "
    Else
        PMSetDetalle "v" + "CED.: " + Trim$(VLCedMigMer) + "#CATAST.:  " + (VLclaCatastralReverso) + "   "
    End If
    'msilvag Fin
    PMSetDetalle "v" + "CONTRIBU.: " + Trim$(Left(Contribuyente.Caption, 30))
    
    'msilvag Inicio Migracion WebService
    If VGTipoEjecucion% <> CGReverso% Then
        PMSetDetalle "v" + "VIGENC.:" + Trim$(VLMLPeriodoVigencia) + "  " + "MERCADO: " + Trim$(Mid$(VLMercado, 1, 20))
    Else
        PMSetDetalle "v" + "VIGENC.:" + Trim$(VLMLPeriodoVigencia) + "  " + "MERCADO: " + Trim$(Mid$(VLMercadoReverso, 1, 20))
    End If
    'msilvag Fin
    
    If Tarjeta = "0.00" Then
    PMSetDetalle "v" + "VALOR:     " + FMEspaciosATX("USD.   " + Format(Trim$(ValorMun), VGFormatoMoney), 13, CGJustificacionDerecha)
    End If
    If Tarjeta <> "0.00" Then
    PMSetDetalle "v" + "VALOR:  " + FMEspaciosATX("USD.   " + Format(Trim$(ValorMun), VGFormatoMoney), 13, CGJustificacionDerecha) + "  " + "TARJETA: " + FMEspaciosATX("USD.   " + Format(Trim$(Tarjeta.Text), VGFormatoMoney), 13, CGJustificacionDerecha)
    End If
    If efe.Text <> "0.00" And Cheques.Text <> "0.00" Then
    PMSetDetalle "v" + "EFE.:   " + FMEspaciosATX("USD.   " + Format(Trim$(efe.Text), VGFormatoMoney), 13, CGJustificacionDerecha) + "  " + "CHQ(1):" + FMEspaciosATX(Format(Trim$(Cheques.Text), VGFormatoMoney), 13, CGJustificacionDerecha)
    End If
    If efe.Text <> "0.00" And Cheques.Text = "0.00" Then
    PMSetDetalle "v" + "EFE.:   " + FMEspaciosATX("USD.   " + Format(Trim$(efe.Text), VGFormatoMoney), 13, CGJustificacionDerecha)
    End If
    If efe.Text = "0.00" And Cheques.Text <> "0.00" Then
    PMSetDetalle "v" + "CHQ(1): " + FMEspaciosATX(Format(Trim$(Cheques.Text), VGFormatoMoney), 13, CGJustificacionDerecha)
    End If
    If Debito.Text <> "0.00" Then
    PMSetDetalle "v" + "DEB.:   " + FMEspaciosATX("USD.   " + Format(Trim$(Debito.Text), VGFormatoMoney), 13, CGJustificacionDerecha) + "  " + "CTA. :    " + Trim$(Cta.ClipText)
    End If
    
    
    PMSetDetalle "v" + "TOTAL:   " + FMEspaciosATX("USD.   " + Format(Trim$(ValorMun.Text), VGFormatoMoney), 13, CGJustificacionDerecha)
'ref02 vmirandt comentado

'    If Debito.Text <> "0.00" And efe.Text <> "0.00" And Cheques.Text <> "0.00" Then
'    If VGModeloImp$ = "590" Then
'        PMSetDetalle "%R" & 4
'    End If
'    End If
'***ref02 vmirandt inicio, se imprime al final del documento
    If VLclave_acceso <> "" Then
        PMSetDetalle "v" + "Clave de Acceso/Autorizacion: "
        PMSetDetalle "v" + VLclave_acceso
    End If
    'ref02 vmirandt
    VLHorarioDifTemporal = VGHorarioDif
    If VLHorario = "N" Then
        VGHorarioDif = False
        VLTrn = "3215"
    Else
        VGHorarioDif = True
        VLTrn = "3216"
    End If
    
    

FMPRN_StdImpresion "IMPRESORA_1", False, Trim$(str$(VLTsnTemporal)), "19", SGDatosDetalle, "Inserte papeleta", CStr(VGpartop$), 4, CStr(VGparleft$), , , VLHorario, , "3215", "1", VLTrn
 
        If VGTipoEjecucion = CGNormal% Then
            While MsgBox("Desea Reimprimir la papeleta para certificacion?", vbYesNo, "Mensaje") = vbYes
                PMReimpresion
            Wend
        End If
    
End Sub

Private Sub Consulta_tipoCep()
    
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "S", "opcion", ""
    PMPasoValoresATX VGSqlConn, "@i_municipio", 0, SQLINT4, val(municipio.Text), "municipio", ""
    PMPasoValoresATX VGSqlConn, "@i_tipo_impto", 0, SQLVARCHAR, Trim$(VLTipoServicio), "tipo_cep", ""
    PMPasoValoresATX VGSqlConn, "@o_referencia2", 1, SQLVARCHAR, 0, "TipoServicio", ""
   If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_tr_municipio_recaudacion", True, "Transaccion Ok", "S", "N", "N", "19", "S", "S") = True Then
         VLTipoSerCep = FMRetParamATX(VGSqlConn, 1)
           Agno.Caption = VLTipoSerCep 'descripcion del cep
   End If
        PMChequeaATX VGSqlConn&
        PMFinTransaccion
        
        

End Sub

'msilvag SOA fase 2 Inicio
Private Sub Consulta_parametro_OSB()
    If VGTipoEjecucion% = CGReverso% Then
        VGTipoEjecucion% = CGNormal%
        PMChequeaATX VGSqlConn&
        PMInicioTransaccion
        PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "sv_servidor_servicios_soa", "", ""
        PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR, "V", "", ""
        PMPasoValoresATX VGSqlConn&, "@i_codigo", 0, SQLVARCHAR, (municipio.Text), "", ""
        If FMTransmitirRPCATX(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "", "N", "S", "I", "0", "N", "N") Then
            PMMapeaObjetoATX VGSqlConn&, txtTemporal
            vl_servidor_BUS = txtTemporal
        End If
        PMChequeaATX VGSqlConn&
        PMFinTransaccion
        VGTipoEjecucion% = CGReverso%
    Else
        PMInicioTransaccion
        PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "sv_servidor_servicios_soa", "", ""
        PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR, "V", "", ""
        PMPasoValoresATX VGSqlConn&, "@i_codigo", 0, SQLVARCHAR, (municipio.Text), "", ""
        If FMTransmitirRPCATX(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "", "N", "S", "I", "0", "N", "N") Then
            PMMapeaObjetoATX VGSqlConn&, txtTemporal
            vl_servidor_BUS = txtTemporal
        End If
        PMChequeaATX VGSqlConn&
        PMFinTransaccion
    End If

End Sub
'msilvag Fin

'msilvag Web Service Migracion Municipio
Private Sub txtTipoConsulta_Change()
    VLPaso% = False
    VLCambio% = True
End Sub

Private Sub txtTipoConsulta_GotFocus()
    VLFlagFoco = True
    FPrincipal!pnlHelpLine.Caption = "F5 Detalle de Tipo de Consulta"
End Sub

Private Sub txtTipoConsulta_KeyDown(KeyCode As Integer, Shift As Integer)
    Select Case KeyCode%
    Case CGTeclaSUPR%
        Me.txtTipoConsulta.Text = ""
    Case CGTeclaUP%, CGTeclaREPAG%
        KeyCode = 0
    Case CGTeclaDOWN%, CGTeclaAVPAG%
        SendKeys "{TAB}"
    End Select
End Sub

Private Sub txtTipoConsulta_LostFocus()
    VLFlagFoco = False
    txtTipoConsulta.Text = UCase$(Trim$(Me.txtTipoConsulta.Text))
End Sub
'msilvag Fin


