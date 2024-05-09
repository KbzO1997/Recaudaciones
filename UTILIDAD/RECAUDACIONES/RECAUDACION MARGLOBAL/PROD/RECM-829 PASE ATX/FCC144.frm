VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "GRID32.OCX"
Object = "{0F1F1508-C40A-101B-AD04-00AA00575482}#1.0#0"; "mhrinp32.ocx"
Object = "{9AED8C43-3F39-11D1-8BB4-0000C039C248}#2.0#0"; "txtin.ocx"
Object = "{DECFDD03-1E4B-11D1-B65E-0000C039C248}#5.0#0"; "mskedit.ocx"
Object = "{00025600-0000-0000-C000-000000000046}#5.2#0"; "crystl32.ocx"
Begin VB.Form FCC144 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "DEPOSITO ESPECIAL EN LINEA"
   ClientHeight    =   5730
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   4560
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5730
   ScaleWidth      =   4560
   Begin MskeditLib.MaskInBox Masc_codigo 
      Height          =   285
      Left            =   3240
      TabIndex        =   3
      Tag             =   "Cta"
      Top             =   825
      Visible         =   0   'False
      Width           =   1965
      _Version        =   262144
      _ExtentX        =   3466
      _ExtentY        =   503
      _StockProps     =   253
      Text            =   "MSC-____-____"
      BorderStyle     =   1
      Decimals        =   0
      Separator       =   -1  'True
      MaskType        =   1
      HideSelection   =   0   'False
      MaxLength       =   0
      AutoTab         =   0   'False
      DateString      =   "MSC-____-____"
      FormattedText   =   ""
      Mask            =   "MSC-####-####"
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
   Begin VB.CheckBox Check_Certificado 
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
      Height          =   255
      Left            =   1560
      TabIndex        =   7
      Top             =   2160
      Width           =   2535
   End
   Begin VB.TextBox txt_campo 
      Height          =   285
      Left            =   3720
      TabIndex        =   34
      Top             =   600
      Visible         =   0   'False
      Width           =   495
   End
   Begin VB.ComboBox cboTipoId 
      Height          =   315
      ItemData        =   "FCC144.frx":0000
      Left            =   1800
      List            =   "FCC144.frx":0002
      Style           =   2  'Dropdown List
      TabIndex        =   1
      Tag             =   "CboProd"
      Top             =   430
      Width           =   1700
   End
   Begin VB.Frame Frame2 
      BackColor       =   &H00C0C0C0&
      Height          =   4335
      Left            =   120
      TabIndex        =   15
      Top             =   1200
      Width           =   4215
      Begin VB.TextBox valor_minimo 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Enabled         =   0   'False
         Height          =   285
         Left            =   1680
         TabIndex        =   39
         Top             =   3840
         Visible         =   0   'False
         Width           =   2415
      End
      Begin VB.TextBox valor_pagar 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Enabled         =   0   'False
         Height          =   285
         Left            =   1680
         Locked          =   -1  'True
         TabIndex        =   14
         Top             =   3480
         Width           =   2415
      End
      Begin MhinrelLib.MhRealInput Total 
         Height          =   285
         Left            =   1440
         TabIndex        =   12
         Top             =   2760
         Width           =   2655
         _Version        =   65536
         _ExtentX        =   4683
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
      Begin VB.TextBox NomCta 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Enabled         =   0   'False
         Height          =   285
         Left            =   1440
         Locked          =   -1  'True
         TabIndex        =   22
         Top             =   1680
         Width           =   2655
      End
      Begin VB.ComboBox CboTipCta 
         Enabled         =   0   'False
         Height          =   315
         ItemData        =   "FCC144.frx":0004
         Left            =   1440
         List            =   "FCC144.frx":0006
         Style           =   2  'Dropdown List
         TabIndex        =   8
         Tag             =   "CboProd"
         Top             =   1320
         Width           =   1320
      End
      Begin VB.TextBox Nombre 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Enabled         =   0   'False
         Height          =   285
         Left            =   960
         Locked          =   -1  'True
         TabIndex        =   13
         Top             =   3120
         Width           =   3135
      End
      Begin VB.Frame Frame3 
         BackColor       =   &H00C0C0C0&
         Height          =   2655
         Left            =   0
         TabIndex        =   17
         Top             =   480
         Width           =   15
         Begin MhinrelLib.MhRealInput MhRealInput1 
            Height          =   285
            Left            =   1320
            TabIndex        =   18
            ToolTipText     =   "Valor en Efectivo"
            Top             =   840
            Width           =   2775
            _Version        =   65536
            _ExtentX        =   4904
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
         Begin VB.Label Label3 
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
            Left            =   120
            TabIndex        =   20
            Top             =   1560
            Width           =   900
         End
         Begin VB.Label Label2 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H00C0C0C0&
            Caption         =   "Valor a pagar:"
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
            Top             =   240
            Width           =   1215
         End
      End
      Begin MhinrelLib.MhRealInput efe 
         Height          =   285
         Left            =   1440
         TabIndex        =   4
         ToolTipText     =   "Valor en Efectivo"
         Top             =   240
         Width           =   2655
         _Version        =   65536
         _ExtentX        =   4683
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
      Begin MhinrelLib.MhRealInput Cheques 
         Height          =   285
         Left            =   2865
         TabIndex        =   6
         ToolTipText     =   "Valor en Cheques"
         Top             =   600
         Width           =   1230
         _Version        =   65536
         _ExtentX        =   2170
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
         Left            =   2865
         TabIndex        =   9
         Tag             =   "Cta"
         Top             =   1320
         Width           =   1230
         _Version        =   262144
         _ExtentX        =   2178
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
         Left            =   1440
         TabIndex        =   10
         Top             =   2040
         Width           =   2655
         _Version        =   65536
         _ExtentX        =   4683
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
      Begin TxtinLib.TextValid CantChq 
         Height          =   285
         Left            =   1440
         TabIndex        =   5
         Top             =   600
         Width           =   580
         _Version        =   65536
         _ExtentX        =   1023
         _ExtentY        =   503
         _StockProps     =   253
         Text            =   "0"
         BorderStyle     =   1
         Enabled         =   0   'False
         Range           =   ""
         MaxLength       =   5
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
         Left            =   1440
         TabIndex        =   11
         Top             =   2400
         Width           =   2655
         _Version        =   65536
         _ExtentX        =   4683
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
      Begin Crystal.CrystalReport rptBAD 
         Left            =   945
         Top             =   2655
         _ExtentX        =   741
         _ExtentY        =   741
         _Version        =   348160
         DiscardSavedData=   -1  'True
         PrintFileLinesPerPage=   60
      End
      Begin MSGrid.Grid grdDetalle 
         Height          =   375
         Left            =   2760
         TabIndex        =   41
         Top             =   3480
         Visible         =   0   'False
         Width           =   1935
         _Version        =   65536
         _ExtentX        =   3413
         _ExtentY        =   661
         _StockProps     =   77
         BackColor       =   16777215
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.24
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin VB.Label lbl_paramrev 
         AutoSize        =   -1  'True
         Caption         =   "lbl_paramrev"
         Height          =   195
         Left            =   585
         TabIndex        =   40
         Top             =   2205
         Visible         =   0   'False
         Width           =   900
      End
      Begin VB.Label lbl_minPagar 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Caption         =   "Mínimo a pagar:"
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
         TabIndex        =   38
         Top             =   3840
         Visible         =   0   'False
         Width           =   1575
      End
      Begin VB.Label Label5 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Valor a pagar:"
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
         Left            =   0
         TabIndex        =   37
         Top             =   0
         Width           =   1215
      End
      Begin VB.Label Etiqueta15 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
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
         TabIndex        =   36
         Top             =   2400
         Width           =   825
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Certificado:"
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
         Top             =   960
         Width           =   990
      End
      Begin VB.Label Etiqueta16 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Valor a pagar:"
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
         Top             =   3480
         Width           =   1215
      End
      Begin VB.Label ValPago 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
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
         TabIndex        =   28
         Top             =   2760
         Width           =   510
      End
      Begin VB.Label Etiqueta12 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Nombre Cta:"
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
         Top             =   1710
         Width           =   1065
      End
      Begin VB.Label Etiqueta13 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Débito:"
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
         Top             =   2040
         Width           =   630
      End
      Begin VB.Label Etiqueta11 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "ND.Cta:"
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
         Top             =   1365
         Width           =   690
      End
      Begin VB.Label Etiqueta10 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Cheques:"
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
         TabIndex        =   24
         Top             =   600
         Width           =   855
      End
      Begin VB.Label lbl_cant_ch 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Cant.Ch.:"
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
         Top             =   600
         Width           =   855
      End
      Begin VB.Label lblValor 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
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
         Index           =   1
         Left            =   120
         TabIndex        =   21
         Top             =   3120
         Width           =   780
      End
      Begin VB.Label lblEfe 
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
         Left            =   120
         TabIndex        =   16
         Top             =   250
         Width           =   900
      End
   End
   Begin TxtinLib.TextValid txt_empresa 
      Height          =   285
      Left            =   1200
      TabIndex        =   0
      ToolTipText     =   "Tipo de Empresa (F5 Ayuda)"
      Top             =   120
      Width           =   615
      _Version        =   65536
      _ExtentX        =   1085
      _ExtentY        =   503
      _StockProps     =   253
      ForeColor       =   -2147483640
      BackColor       =   -2147483643
      BorderStyle     =   1
      Range           =   ""
      MaxLength       =   3
      Character       =   2
      Type            =   1
      HelpLine        =   "Ingrese Tipo de impuesto,  F5 Ayuda"
      Pendiente       =   ""
      Connection      =   -4908
      AsociatedLabelIndex=   0
      TableName       =   "sv_emp_recauda_deposito"
      MinChar         =   0
      Error           =   0
   End
   Begin TxtinLib.TextValid Ref 
      Height          =   285
      Left            =   1800
      TabIndex        =   2
      ToolTipText     =   "Código del Cliente de acuerdo al código de empresa"
      Top             =   825
      Width           =   1965
      _Version        =   65536
      _ExtentX        =   3466
      _ExtentY        =   503
      _StockProps     =   253
      BorderStyle     =   1
      Range           =   ""
      MaxLength       =   15
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
   Begin VB.Label lblCobAlum 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Código:"
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
      TabIndex        =   33
      Top             =   825
      Width           =   660
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Tipo:"
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
      Left            =   240
      TabIndex        =   32
      Top             =   430
      Width           =   450
   End
   Begin VB.Label txt_des_empresa 
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
      TabIndex        =   31
      Top             =   120
      Width           =   2460
   End
   Begin VB.Label lblempresa 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Empresa:"
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
      Left            =   240
      TabIndex        =   30
      Top             =   120
      Width           =   855
   End
End
Attribute VB_Name = "FCC144"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim VTIndicadorSum As Integer
Dim MatrizCnel(2, 55) As String
Dim VLFlag As Boolean
Dim VLTotCom As Currency
Dim VLEfe_com  As Currency
Dim VLChq_com As Currency
Dim VLDeb_com As Currency
Dim VLCta_com  As String
Dim VLTipCta_com As String
Dim VLCambio As Integer
Dim VLfirma As Boolean
Dim VLCta As String
Dim VLMoneda As Integer
Dim VLDescMonCta As String
Dim VLBand As Boolean
Dim VLNom_Emp As String
Dim VLTipoCtaEmp As String
Dim VLTrn As String
Dim VLProcedure As String
Dim VLBase As String
Dim VLMonto As Currency
Dim VLNombre As String 'msilvag RECMPS-19
Dim VLNumDocumento As String
Dim VLIdentificacion As String
Dim VLiva As Currency
Dim VlbaseImp As Currency
Dim VLclave_acceso As String
Dim VLFecvenSRI As String
Dim VLSerie_Secuencia As String
Dim VLfact_elect As String
Dim VLFecinivig As String
Dim VLFecfinvig As String
Dim VLGrupo As String 'msilvag RECMPS-26
Dim VLIndReverso As String 'msilvag RECMPS-26
Dim VLConvenio As String
'jg Inicio RECMPS-463
Dim VFecCont As String
Dim VNumDoc As String
Dim VTipDoc As String
'jg Fin RECMPS-272
            
            
'JG Ini

Private Sub CantChq_KeyDown(KeyCode As Integer, Shift As Integer)
  Select Case KeyCode%
    Case CGTeclaSUPR%
      If CantChq.Enabled Then
         CantChq.Clear
      End If
    Case CGTeclaHOME%
      PMCambiarForma Me
    Case CGTeclaUP%, CGTeclaREPAG%
      KeyCode = 0
    Case CGTeclaDOWN%, CGTeclaAVPAG%
      SendKeys "{TAB}"
    
  End Select
End Sub

Private Sub CantChq_KeyPress(KeyAscii As Integer)
    If CGTeclaENTER = KeyAscii% Then
        SendKeys "{TAB}"
    End If
End Sub

Private Sub CantChq_LostFocus()
    'lgusnayc Inicio RECMPS-80
    Dim msg, Style, Title, Response
    msg = "Verifique que el cheque sea Certificado."
    Style = vbCritical
    Title = "Mensaje del Sistema"
    
    If val(CantChq.Text) > 0 Then
      Response = MsgBox(msg, Style, Title)
      If Response = 1 Then
        Cheques.SetFocus
      End If
    End If
    'lgusnayc Fin RECMPS-80
End Sub

Private Sub CboTipCta_Click()
    If VGTipoEjecucion% <> CGReverso% Then
        Cta.Text = ""
    End If
End Sub

Private Sub CboTipCta_KeyDown(KeyCode As Integer, Shift As Integer)
    Select Case KeyCode%
        Case CGTeclaENTER%
            SendKeys "{TAB}"
        Case CGTeclaUP%, CGTeclaREPAG%
            SendKeys "+{TAB}"
        Case CGTeclaDOWN%, CGTeclaAVPAG%
            If Cta.Enabled = True Then
            Cta.SetFocus
            Else
            SendKeys "+{TAB}"
            End If
    End Select
End Sub

Private Sub CboTipoID_Click()
    If VGTipoEjecucion% <> CGReverso% Then
        Ref.Text = ""
        If Me.txt_empresa.Text = "9291" Then 'msilvag RECMPS-19
            Select Case CboTipoID.ListIndex
            Case 0
                Ref.MaxLength = 10
            Case 1
                Ref.MaxLength = 13
            Case 2
                Ref.MaxLength = 20
            End Select
        'msilvag Inicio RECMPS-19
        Else
'            Select Case cboTipoId.ListIndex
'            Case 0
'                Ref.MaxLength = 13
'            Case 1
                Ref.MaxLength = 20
'            End Select
        End If
        'msilvag Fin
    End If
End Sub

Private Sub cboTipoId_GotFocus()
If VLFlag <> False Then
    If Trim(txt_des_empresa) = "" And Len(txt_empresa.Text) >= 1 Then
        'If txt_empresa <> "9291" And txt_empresa <> "6930" Then
            'MsgBox "Empresa no existe", vbInformation + vbOKOnly, "ATX"
            txt_empresa.SetFocus
        'End If
    End If
End If
VLBand = True
End Sub

Private Sub CboTipoID_KeyDown(KeyCode As Integer, Shift As Integer)
    Select Case KeyCode%
    Case CGTeclaENTER%
        If Trim(txt_empresa.Text) = "6930" Then
            Me.Masc_codigo.SetFocus
        Else
            Ref.SetFocus
        End If
    Case CGTeclaUP%, CGTeclaREPAG%
        If CboTipoID.ListIndex = 0 Then
            SendKeys "+{TAB}"
        End If
    Case CGTeclaDOWN%, CGTeclaAVPAG%
        If CboTipoID.ListIndex = 2 Then
            SendKeys "{TAB}"
        End If
    End Select
End Sub

Private Sub CboTipoID_KeyPress(KeyAscii As Integer)
    If KeyAscii = 13 And efe.Enabled = True Then efe.SetFocus  'SendKeys "{TAB}"
End Sub


Private Sub cboTipoId_LostFocus()
VLBand = False
End Sub

Private Sub Cheques_Change()
    Total.Text = FMCCurATX(efe.Text) + FMCCurATX(Debito.Text) + FMCCurATX(Cheques.Text) + Me.Comision.Text
    If Cheques.Text <> 0 Then
        Check_Certificado.Enabled = True
    Else
        Check_Certificado.Enabled = False
        Check_Certificado.Value = 0
    End If
End Sub

Private Sub Cheques_KeyPress(KeyAscii As Integer)
    KeyAscii = FMValidarNumero((Cheques.Text), VGLongitudMoney, KeyAscii, "144")
    If CGTeclaENTER = KeyAscii% Then
        SendKeys "{TAB}"
    End If
End Sub

Private Sub Cheques_LostFocus()
    If Cheques.Text <> "" Or Cheques.Text <> "0.00" Then
        Total.Text = FMCCurATX(efe.Text) + FMCCurATX(Debito.Text) + FMCCurATX(Cheques.Text) + Me.Comision.Text
    End If
End Sub


Private Sub Comision_Change()
    If VGTipoEjecucion% <> CGReverso% Then
        Total.Text = FMCCurATX(efe.Text) + FMCCurATX(Debito.Text) + FMCCurATX(Cheques.Text) + Me.Comision.Text
    End If
End Sub

Private Sub Comision_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "F5 Detalle de Comision"
End Sub

Private Sub Comision_KeyDown(KeyCode As Integer, Shift As Integer)
Dim VLAcumulado As Currency
    If KeyCode% = CGTeclaF5% Then
        If Comision <> 0# Then
            'Inicializo las variables
            SGComision = 0#
            SGTipoCta = ""
            SGCedula = ""
            
            VLAcumulado = SGAcumulado
            VGUsar15 = efe.ValueReal
            SGUsar = VLEfe_com

            SGComision = Comision
            SGTipoCta = FCC144.CboTipCta.ListIndex
            VGNumCuenta = Cta.Text
            SGValida = "S"
            SGNumCuenta = Cta.Text
            SGEmpresa = "DEPLINE" 'txt_empresa.Text
            
            FCC112.Show 1
            'Valores
            VLEfe_com = FCC112.VLEfe_com
            VLChq_com = FCC112.VLChq_com
            VLDeb_com = FCC112.VLDeb_com
            VLTipCta_com = FCC112.VLTipCta_com
            VLCta_com = FCC112.VLCta_com
            VLTotCom = VLEfe_com + VLChq_com + VLDeb_com
     

            SGUsar = VGUsar15
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
    VLfirma = False
    VLCambio% = True
    VLCta = Cta.Text
End Sub

Private Sub Cta_GotFocus()
    If Trim$(VLCta) <> "" _
    And Trim$(VLCta) <> "___-______-_" Then
        Cta.Text = VLCta
    End If
    FPrincipal!pnlHelpLine.Caption = "Ingrese el No. de la Cuenta."
End Sub

Private Sub Cta_KeyDown(KeyCode As Integer, Shift As Integer)
    Select Case KeyCode%
          Case CGTeclaSUPR%
             Cta.Text = ""
          Case CGTeclaENTER%
             SendKeys "{TAB}"
          Case CGTeclaUP%, CGTeclaREPAG%
             Me.CboTipCta.SetFocus
          Case CGTeclaDOWN%, CGTeclaAVPAG%
             SendKeys "{TAB}"
    End Select
End Sub

Private Sub Cta_LostFocus()
 Dim VTipoDatoCta As StructDatoCta
 
    If Cta.ClipText <> "" Then
       VLfirma = FMValidaFirma(VLfirma, CboTipCta.Text, Cta, "144", NomCta, VLMoneda, VLDescMonCta)
       VTipoDatoCta = LoNombreCta(CboTipCta.Text, Cta.ClipText, "144")
       NomCta.Text = VTipoDatoCta.NombreCta
       If VLfirma = False Then
          Debito.Text = ""
          Debito.Enabled = False
       Else
          Debito.Enabled = True
          Debito.SetFocus
       End If
    End If
    
End Sub

Private Sub Debito_Change()
    If Debito.Text <> "" Or Debito.Text <> "0.00" Then
        Total.Text = FMCCurATX(efe.Text) + FMCCurATX(Debito.Text) + FMCCurATX(Cheques.Text) + Me.Comision.Text
    End If
End Sub

Private Sub Debito_KeyDown(KeyCode As Integer, Shift As Integer)
    Select Case KeyCode%
        Case CGTeclaSUPR%
            Debito.Text = ""
        Case CGTeclaENTER%
            SendKeys "{TAB}"
        Case CGTeclaMAS%
            Debito.Text = FMCalculadora(FMObtenerTitulo("144") + "Debito:", 14, "144")
            SendKeys "{TAB}"
        Case CGTeclaPOR%
            Debito.Text = FMSumadora(FMObtenerTitulo("144") + "Debito:", 14, "144")
        Case CGTeclaHOME%
            PMCambiarForma Me
        Case CGTeclaUP%, CGTeclaREPAG%
            SendKeys "+{TAB}"
        Case CGTeclaDOWN%, CGTeclaAVPAG%
            SendKeys "{TAB}"
    End Select
End Sub

Private Sub Debito_KeyPress(KeyAscii As Integer)
    KeyAscii = FMValidarNumero((Debito.Text), VGLongitudMoney, KeyAscii, "144")
End Sub

Private Sub Debito_LostFocus()
    If Debito.Text <> "" Or Debito.Text <> "0.00" Then
        Total.Text = FMCCurATX(efe.Text) + FMCCurATX(Debito.Text) + FMCCurATX(Cheques.Text) + Me.Comision.Text
    End If
End Sub

Private Sub Efe_Change()
    VLCambio% = True
    Total.Text = FMCCurATX(efe.Text) + FMCCurATX(Debito.Text) + FMCCurATX(Cheques.Text) + Me.Comision.Text
End Sub

Private Sub Efe_GotFocus()
 FPrincipal!pnlHelpLine.Caption = "Ingrese el Valor en Efectivo"
    'Sumadora ----->
    If SGActivaSum = False And Ref.Text <> "" Then
        FSumIng.abrirAltaDenominacion = True
        PMIngresoEfectivo
        efe.Text = Format$(SGUsar, "####,###,##0.00")
        SGActual = 0
    Else
        SGActivaSum = False
    End If
    '<-------
End Sub

Private Sub Efe_KeyDown(KeyCode As Integer, Shift As Integer)
 Select Case KeyCode%
    Case CGTeclaSUPR%
        efe.Text = ""
    Case CGTeclaHOME%
        PMCambiarForma Me
    Case CGTeclaF5%
        FPrincipal!pnlHelpLine.Caption = "Ingrese la cantidad en efectivo"
        
        'Sumadora ----->
        If SGActivaSum = False Then
            PMIngresoEfectivo
            efe.Text = Format$(SGUsar, "####,###,##0.00")
            SGActual = 0
            SGActivaSum = True
        Else
            SGActivaSum = False
        End If
'    Case CGTeclaUP%, CGTeclaREPAG%
'        SendKeys "+{TAB}"
'    Case CGTeclaDOWN%, CGTeclaAVPAG%
'        SendKeys "{TAB}"
    End Select
End Sub

Private Sub Efe_KeyPress(KeyAscii As Integer)
    KeyAscii = FMValidarNumero((efe.Text), VGLongitudMoney, KeyAscii, "144")
End Sub

Private Sub Efe_LostFocus()
    'EAS: Evita procesar el lostfocus cuando se carga Sumadora
    If SGActivaSum = True Then
        Exit Sub
    End If
    
    If VTIndicadorSum = 1 Then
        Exit Sub
    End If
    
    Total.Text = FMCCurATX(efe.Text) + FMCCurATX(Debito.Text) + FMCCurATX(Cheques.Text) + Me.Comision.Text
    
    If VGDecimales$ = "S" And (FMObtenerDecimales(FMObtenerMonedaForma("144")) > 0) Then
        efe.Text = str(FMCCurATX((efe.Text)) / FMObtenerFactorDecimal(FMObtenerMonedaForma("144")))
    End If
    
    'Sumadora ------>
    If CDbl(efe.Text) <> SGUsar And Ref.Text <> "" Then
        MsgBox "El Monto Efetivo No coincide con el Monto desglosado para el Deposito. Verificar", vbCritical, "Mensaje del Sistema"
        efe.SetFocus
        efe.Text = Format$(SGUsar, "####,###,##0.00")
        SGActual = 0
    End If
    SGActivaSum = False
  
'    Total.Text = FMCCurATX(efe.Text)
End Sub

Private Sub Form_Activate()
On Error GoTo Error
    If (SGMonedaTran <> VGmoneda% And VGmoneda% <> 0) Then
        SGMonedaTran = VGmoneda%
        PMCargaIniSumadora VGmoneda%
        PMIniciaIngreso 1
    End If
    
Exit Sub
Error:
MsgBox "Error - Form_Activate: " & Err.Description, vbExclamation
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    If Shift = CGTeclaCTRL% + CGTeclaALT% And KeyCode% = CGTeclaF9% Then
        PMObtenerMonedaForma "144"
        Exit Sub
    End If
  
    If Shift = CGTeclaCTRL% And KeyCode% = CGTeclaI% Then
        If VG_reimpresion144 = True Then
            imprimeComprobante 2, VG_cta_empresa_imp144
        End If
       
'        PMReimpresion
        Exit Sub
    End If
    
    Select Case KeyCode%
        Case CGTeclaSUPR%
            If VGTipoEjecucion% = CGReverso% Then
                PLTransmitir
                Unload Me
            End If
            
        Case CGTeclaF1%
            If VGTipoEjecucion% <> CGReverso% Then
                SGUsar = efe.ValueReal + VLEfe_com
                PLTransmitir
            End If
            
        Case CGTeclaESC%
            Unload Me
            VLCta = ""
            
        Case CGTeclaHOME%
            PMCambiarForma Me
            
        Case CGTeclaF2%
            Ref.TabIndex = 2
            Masc_codigo.TabIndex = 3
            Masc_codigo.Visible = False
'            Ref.Visible = True
            Masc_codigo.Text = ""
            VLclave_acceso = ""
            VLIdentificacion = ""
            Check_Certificado.Enabled = False
            VLNumDocumento = ""
            VLTipoCtaEmp = ""
            efe.Text = "0.00"
            VLBand = False
            CantChq.Text = "0"
            Cheques = "0.00"
            CantChq.Enabled = False
            Cheques.Enabled = False
            VLCta = ""
            NomCta.Text = ""
            Cta.Text = ""
            CboTipCta.Enabled = False
            Cta.Enabled = False
            Debito.Text = "0.00"
            Debito.Enabled = False
'            SGUsar = 0
'            SGActivaSum = False
'            SGActual = 1
            VLFlag = False
            txt_empresa.Text = ""
            txt_des_empresa.Caption = ""
            CboTipoID.ListIndex = 0
            Ref.Text = ""
            
            Total.Text = "0.00"
            Nombre.Text = ""
            valor_pagar.Text = ""
            valor_minimo.Text = "" 'jg RECMPS-272
            efe.Enabled = False
            Total.Enabled = False
            txt_empresa.Enabled = True
            CboTipoID.Enabled = True
            Ref.Enabled = True
            txt_empresa.SetFocus
             VGAutoriza = "N"
             VTIndicadorSum = 0
            
            'msilvag Inicio RECMPS-26
            VLGrupo = ""
            Me.Comision.Text = "0.00"
            'msilvag Fin
            
            'jg Inicio RECMPS-463
            VFecCont = ""
            VTipDoc = ""
            VNumDoc = ""
            'jg Fin
            Me.lblCobAlum.Caption = "Código"
            lectoraBill.Limpiar             'JPM lectora de billetes
        Case CGTeclaF9%
            If VGTipoEjecucion% = CGNormal% Then
                If FMSupervisor("144") = True Then
                    VGAutoriza = "S"
                End If
            End If
            
        Case CGTeclaF3%
            If efe.Enabled = False Then
                Exit Sub
            End If
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
    End Select
End Sub
Private Sub Form_Load()
    CGLongTramaBill = CadenaCorta   'JPM lectora de billetes
    lectoraBill.Limpiar             'JPM lectora de billetes
    'Posision de la pantalla
    Move VGLeft%, VGTop%, 4500, 6200
    
    'Me.Width = 9465 'msilvag temporal
    
    VLFlag = False
    VLBand = False
'    VG_reimpresion144 = False
    
    'Sumadora  ----->
    SGUsar = 0
    SGActivaSum = False
    SGActual = 1
    SGAcumRev = 0
    SGReversoAct = False
    '<-----
    
    SGEmpresa = "" 'msilvag RECMPS-19
    
    VGFormaPago = ""
    VGCom_aux = 0
    VGComision_original = 0
    VGCompensacion = 0
    VGPorcentajeComp = "0"
    VGPorcentajeIVA = "0"
  
    VLTotCom = 0#
    VLEfe_com = 0#
    VLChq_com = 0#
    VLDeb_com = 0#
    VLCta_com = ""
    VLTipCta_com = ""

    VLCambio% = False
     
    'Inicio Moneda
    VLMoneda = VGmoneda%
    
    VLGrupo = "" 'msilvag RECMPS-26
    VLIndReverso = ""  'msilvag RECMPS-26
    
    'Agregar contenido al combo
    CboTipoID.Clear
    
    CboTipoID.AddItem "CEDULA"
    CboTipoID.AddItem "RUC"
    CboTipoID.AddItem "PASAPORTE"
    CboTipoID.ListIndex = 0
    Ref.MaxLength = 10
    
    CboTipCta.AddItem "CTE"
    CboTipCta.AddItem "AHO"
    CboTipCta.ListIndex = 0
    VLCta = ""
    VLfirma = False
    
    'Llamar al catalogo de empresa
    txt_empresa.Connection = VGMap
    Set txt_empresa.AsociatedLabel = txt_des_empresa
    txt_empresa.Enabled = True
    
    If VGTipoEjecucion% = CGReverso% Then
        Call PLReverso
    End If
    
End Sub
Private Sub Form_Unload(Cancel As Integer)
    PMCerrarForma "144"
    lectoraBill.Limpiar   'JPM lectora de billetes
End Sub



Private Sub Masc_codigo_KeyDown(KeyCode As Integer, Shift As Integer)
    Select Case KeyCode%
        Case CGTeclaSUPR%
            Masc_codigo.Text = ""
        Case CGTeclaUP%, CGTeclaREPAG%
            SendKeys "+{TAB}"
        Case CGTeclaF5%
                Ref.Text = Masc_codigo.Text
                If txt_empresa.Text = "20717" Then
                    If Not FLTransmitir_consulta_CMA_MS() Then
                        Exit Sub
                    End If
                ElseIf txt_empresa.Text = "22289" Then
                    If Not FLTransmitir_consulta_Marglobal() Then
                        Exit Sub
                    End If
                Else
                    If Not FLTransmitir_consulta_Ecuaquimica() Then
                        Exit Sub
                    End If
                End If
                
    End Select
End Sub

Private Sub Ref_Change()
    VLCambio% = True
End Sub


Private Sub Ref_KeyDown(KeyCode As Integer, Shift As Integer)
    Select Case KeyCode%
        Case CGTeclaSUPR%
            Ref.Text = ""
        Case CGTeclaUP%, CGTeclaREPAG%
            SendKeys "+{TAB}"
        Case CGTeclaF5%
        
        If txt_empresa.Text = "20717" Then
            If Not FLTransmitir_consulta_CMA_MS() Then
                Exit Sub
            End If
        ElseIf txt_empresa.Text = "22289" Then
             If Not FLTransmitir_consulta_Marglobal() Then
                 Exit Sub
             End If
        Else
            If Not FLTransmitir_consulta_Ecuaquimica() Then
                    Exit Sub
            End If
        End If
        
    End Select
End Sub
Private Sub Ref_KeyPress(KeyAscii As Integer)
    If Me.txt_empresa = "9291" Then 'msilvag RECMPS-19
        If (CboTipoID.ListIndex = 2) Then
            If (KeyAscii% <> 8) And ((KeyAscii% < 65) Or (KeyAscii% > 90)) Then
                If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
                    KeyAscii% = 0
                End If
            End If
            KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
        Else
            If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
                KeyAscii% = 0
            End If
        End If
    'msilvag Inicio RECMPS-19
    Else
'        If (cboTipoId.ListIndex = 0) Then
'            If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
'                KeyAscii% = 0
'            End If
'        Else
'            If (KeyAscii% <> 8) And ((KeyAscii% < 65) Or (KeyAscii% > 90)) Then
'                If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
'                    KeyAscii% = 0
'                End If
'            End If
'            KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
'        End If
        If (KeyAscii% <> 8) And ((KeyAscii% < 65) Or (KeyAscii% > 90)) Then
            If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
                If (KeyAscii% <> 45) Then
                    KeyAscii% = 0
                End If
            End If
        End If
        KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
    End If
    'msilvag Fin
End Sub


Private Sub Total_KeyDown(KeyCode As Integer, Shift As Integer)
    Select Case KeyCode%
        Case CGTeclaSUPR%
            Total.Text = ""
        Case CGTeclaHOME%
            PMCambiarForma Me
        Case CGTeclaUP%, CGTeclaREPAG%
            SendKeys "+{TAB}"
'        Case CGTeclaDOWN%, CGTeclaAVPAG%
'            SendKeys "{TAB}"
    End Select
End Sub

Private Sub txt_empresa_KeyPress(KeyAscii As Integer)
    VLFlag = True
End Sub

Function FLTransmitir_consulta_Marglobal() As Boolean
    'msilvag Inicio RECMPS-19
    Dim vl_procedure As String
    Dim vl_trx As String
    Dim vl_tipo_cons As String
    
    vl_tipo_cons = "1"
          
    'msilvag Inicio RECMPS-19
    SGEmpresa = "DEPLINE" 'Me.txt_empresa.Text
    vl_procedure = "fp_con_depenlinea"
    vl_trx = "62675"
    'msilvag Fin
    
    'msilvag Inicio RECMPS-26
    VLGrupo = ""
    'FPrincipal.Map.PMMapConfig "SHOWMESSAGE"
    
    PMInicioTransaccion
    FLTransmitir_consulta_Marglobal = False
    
    VG_empresa_imp144 = ""
    VG_des_empresa_imp144 = ""
    VG_cta_empresa_imp144 = ""
    VG_ref_imp144 = ""
    VG_nombre_imp144 = ""
    VG_efe_imp144 = 0
    VG_deb_imp144 = 0
    VG_cta_imp144 = ""
    VG_total144 = 0
    VG_reimpresion144 = False
    VGCantChq = 0
    VGCheques = 0
    VGAutoriza = "N"
    VLNom_Emp = ""

    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLVARCHAR, vl_trx, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Canal", ""
    PMPasoValoresATX VGSqlConn, "@i_empresa", 0, SQLVARCHAR, "451", "CodEmpresa", ""
    PMPasoValoresATX VGSqlConn, "@i_subempresa", 0, SQLVARCHAR, Trim$(Me.txt_empresa.Text), "SubEmpresa", ""
    PMPasoValoresATX VGSqlConn, "@i_tipoConsulta", 0, SQLVARCHAR, vl_tipo_cons, "Empresa", ""
    PMPasoValoresATX VGSqlConn, "@i_codigo", 0, SQLVARCHAR, Trim$(Ref.Text), "Codigo", ""

    If FMTransmitirRPCATX(VGSqlConn, "BBTSSRV", "cob_procesador", vl_procedure, True, "Transaccion Ok", "S", "N", "N", "144", "S", "S") = True Then
        FLTransmitir_consulta_Marglobal = True
        VTResult% = FMMapeaMatrizATX(VGSqlConn&, MatrizCnel())
        valor_pagar.Text = Format(FLBuscarItem("@o_valorTotal"), "#0.00")
            
        VLNombre = FLBuscarItem("@o_nombre")
        Me.Nombre.Text = VLNombre
            
        VLNumDocumento = FLBuscarItem("@o_numeroDocumento")
        VLIdentificacion = FLBuscarItem("@o_identificacion")
    Else
        FLTransmitir_consulta_Marglobal = False
        PMFinTransaccion
        PMChequeaATX VGSqlConn
        Ref.SetFocus
        Exit Function
    End If
    PMChequeaATX VGSqlConn
    PMFinTransaccion
    
    'CONSULTA DE COMISION
        
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 4050, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLVARCHAR, "C", "opcion", ""
    PMPasoValoresATX VGSqlConn, "@i_empresa", 0, SQLVARCHAR, Me.txt_empresa.Text, "empresa", ""
    PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Rubro Person", ""
        
    'Variables de salida
    PMPasoValoresATX VGSqlConn, "@o_comision", 1, SQLMONEY, 0, "Comision", ""
    PMPasoValoresATX VGSqlConn, "@o_tasa", 1, SQLMONEY, "0", "tasa", ""
    PMPasoValoresATX VGSqlConn, "@o_base_imp", 1, SQLMONEY, "0", "base_imp", ""
    PMPasoValoresATX VGSqlConn, "@o_impuesto", 1, SQLMONEY, "0", "impuesto", ""
        If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_val_servicios_varios", True, "Transaccion Ok", "S", "N", "N", "144", "S", "S") = True Then
            VLComision = FMRetParamATX(VGSqlConn, 1)
            VlbaseImp = FMRetParamATX(VGSqlConn, 3)
            VLiva = FMRetParamATX(VGSqlConn, 4)
        End If
        
        If VLComision = 0 Then
            Me.Comision.Enabled = False
        Else
            Me.Comision.Enabled = True
            Me.Comision.Text = VLComision
        End If
        
    'FMInitMap FPrincipal!pnlHelpLine, FPrincipal!pnlTransaccionLine, FPrincipal!Focos(0), FPrincipal!Focos(1), FPrincipal!Focos(2), FPrincipal!Focos(3), VGLogTransacciones$ 'msilvag RECMPS-26
        
    SGActivaSum = False
    efe.Enabled = True
    txt_empresa.Enabled = False
    cboTipoId.Enabled = False
    Ref.Enabled = False
    CantChq.Enabled = True
    Cheques.Enabled = True
    CboTipCta.Enabled = True
    Cta.Enabled = True
    Debito.Enabled = True
    efe.SetFocus

    PMChequeaATX VGSqlConn&
    PMFinTransaccion
    'FIN DE CONSULTA COMISION

End Function

Function FLTransmitir_consulta_Ecuaquimica() As Boolean
    'msilvag Inicio RECMPS-19
    Dim vl_procedure As String
    Dim vl_trx As String
    Dim vl_tipo_cons As String
    
    vl_tipo_cons = ""
    'msilvag Fin
    
    If Len(Trim$(txt_empresa.Text)) = 0 Then
        MsgBox "Campo empresa es Obligatorio para la consulta", vbCritical + vbOKOnly, "ATX"
        txt_empresa.SetFocus
        Exit Function
    End If
    
    If Len(Trim$(Ref.Text)) = 0 Then
        MsgBox "Campo código es Obligatorio para la consulta", vbCritical + vbOKOnly, "ATX"
        Ref.SetFocus
        Exit Function
    End If
        
    If Me.txt_empresa.Text = "9291" Then 'msilvag RECMPS-19
        If Me.CboTipoID.ListIndex = 0 Then
            If Len(Ref.Text) <> 10 Then
                MsgBox "Cédula debe ser de 10 dígitos", vbInformation, "Mensaje del Sistema"
                Ref.SetFocus
                Exit Function
            End If
        End If
    
        If Me.CboTipoID.ListIndex = 1 Then
            If Len(Ref.Text) <> 13 Then
                MsgBox "RUC debe ser de 13 dígitos", vbInformation, "Mensaje del Sistema"
                Ref.SetFocus
                Exit Function
            End If
        End If
    Else
'        If Me.cboTipoId.ListIndex = 0 Then
'            vl_tipo_cons = "1"
'        Else
            vl_tipo_cons = "2"
'        End If
    End If 'msilvag RECMPS-19
    
    If Me.txt_empresa.Text = "8460" Or Me.txt_empresa.Text = "1348" Then 'jg RECMPS-272
      vl_tipo_cons = "1"
    End If
       
    'msilvag Inicio RECMPS-19
    SGEmpresa = "DEPLINE" 'Me.txt_empresa.Text
    vl_procedure = ""
    vl_trx = ""
    If Me.txt_empresa.Text = "9291" Then
        vl_procedure = "fp_consulta_ecuaquimica"
        vl_trx = "62670"
    Else
        vl_procedure = "fp_con_depenlinea"
        vl_trx = "62675"
    End If
    'msilvag Fin
    
    'msilvag Inicio RECMPS-26
    VLGrupo = ""
    FPrincipal.Map.PMMapConfig "SHOWMESSAGE"
    
    PMChequea VGSqlConn&
    PMPasoValores VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "sv_grupo_empresas"
    PMPasoValores VGSqlConn&, "@i_tipo", 0, SQLCHAR, "V"
    PMPasoValores VGSqlConn&, "@i_codigo", 0, SQLVARCHAR, Trim$(Me.txt_empresa.Text)
    If FMTransmitirRPC(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "") Then
        PMMapeaVariableATX VGSqlConn&, VTDetalles$
        PMChequea VGSqlConn&
        VLGrupo = VTDetalles$
        PMChequea VGSqlConn&
    Else
        VLGrupo = ""
        PMChequea VGSqlConn&
        'Exit Function
    End If
    
    FMInitMap FPrincipal!pnlHelpLine, FPrincipal!pnlTransaccionLine, FPrincipal!Focos(0), FPrincipal!Focos(1), FPrincipal!Focos(2), FPrincipal!Focos(3), VGLogTransacciones$
    'msilvag Fin
    
    'DoEvents
    
    PMInicioTransaccion
    FLTransmitir_consulta_Ecuaquimica = False
    
    VG_empresa_imp144 = ""
    VG_des_empresa_imp144 = ""
    VG_cta_empresa_imp144 = ""
    VG_ref_imp144 = ""
    VG_nombre_imp144 = ""
    VG_efe_imp144 = 0
    VG_deb_imp144 = 0
    VG_cta_imp144 = ""
    VG_total144 = 0
    VG_reimpresion144 = False
    VGCantChq = 0
    VGCheques = 0
    VGAutoriza = "N"
    VLNom_Emp = ""

    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLVARCHAR, vl_trx, "Trn", ""
    'PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLVARCHAR, 62670, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Canal", ""
    If VLGrupo = "" Then 'msilvag RECMPS-26
        PMPasoValoresATX VGSqlConn, "@i_empresa", 0, SQLVARCHAR, Trim$(Me.txt_empresa.Text), "CodEmpresa", ""
    'msilvag Inicio RECMPS-26
    Else
        PMPasoValoresATX VGSqlConn, "@i_empresa", 0, SQLVARCHAR, Trim$(VLGrupo), "CodEmpresa", ""
    End If
    'msilvag Fin
    
    'msilvag Inicio RECMPS-19
    If Me.txt_empresa = "9291" Then
    PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, CStr(VGmoneda), "mon", ""
        PMPasoValoresATX VGSqlConn, "@i_tipoConsulta", 0, SQLVARCHAR, "C", "Empresa", ""
    Else
        PMPasoValoresATX VGSqlConn, "@i_subempresa", 0, SQLVARCHAR, Trim$(Me.txt_empresa.Text), "SubEmpresa", ""
        PMPasoValoresATX VGSqlConn, "@i_tipoConsulta", 0, SQLVARCHAR, vl_tipo_cons, "Empresa", ""
    End If
    
'    If VGTipoEjecucion% <> CGReverso% Then
'        PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLVARCHAR, "N", "TCORR", ""
'    End If
    'msilvag Fin
    PMPasoValoresATX VGSqlConn, "@i_codigo", 0, SQLVARCHAR, Trim$(Ref.Text), "Codigo", ""
'    If Me.txt_empresa = "9291" Then
'        PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, CStr(VGmoneda), "mon", ""
'    End If

    If FMTransmitirRPCATX(VGSqlConn, "BBTSSRV", "cob_procesador", vl_procedure, True, "Transaccion Ok", "S", "N", "N", "144", "S", "S") = True Then
    'If FMTransmitirRPCATX(VGSqlConn, "BBTSSRV", "cob_procesador", "fp_consulta_ecuaquimica", True, "Transaccion Ok", "S", "N", "N", "144", "S", "S") = True Then
        FLTransmitir_consulta_Ecuaquimica = True
        
        If Me.txt_empresa.Text = "9291" Then  'msilvag RECMPS-19
            VTResult% = FMMapeaMatrizATX(VGSqlConn&, MatrizCnel())
            
            Nombre.Text = FLBuscarItem("@o_nombre")
            valor_pagar.Text = FLBuscarItem("@o_valor")
            
            SGActivaSum = False
            efe.Enabled = True
            'Total.Enabled = True
            txt_empresa.Enabled = False
            CboTipoID.Enabled = False
            Ref.Enabled = False
            CantChq.Enabled = True
            Cheques.Enabled = True
            CboTipCta.Enabled = True
            Cta.Enabled = True
            Debito.Enabled = True
            efe.SetFocus
        'msilvag Inicio RECMPS-19
        Else
            'PMMapeaGridATX VGSqlConn, Me.grddato, False
            'PMChequeaATX VGSqlConn
            
            VTResult% = FMMapeaMatrizATX(VGSqlConn&, MatrizCnel())
            valor_pagar.Text = FLBuscarItem("@o_valorTotal")
            
            VLNombre = FLBuscarItem("@o_nombre")
            Me.Nombre.Text = VLNombre
            
            VLNumDocumento = FLBuscarItem("@o_numeroDocumento")
            VLIdentificacion = FLBuscarItem("@o_identificacion")
            
              'jg Inicio RECMPS-272
             If Me.txt_empresa.Text = "8460" Then
                valor_minimo.Text = FLBuscarItem("@o_valorMinimo")
             End If
            'jg Fin RECMPS-272
            
             'jg Inicio RECMPS-463
             If Me.txt_empresa.Text = "8462" Then
                valor_minimo.Text = 0.01
                VFecCont = FLBuscarItem("@o_fecCont")
                VNumDoc = FLBuscarItem("@o_numDoc")
                VTipDoc = FLBuscarItem("@o_tipDoc")
             End If
            'jg Fin RECMPS-463
            
        End If
        'msilvag fin
    Else
        FLTransmitir_consulta_Ecuaquimica = False
        PMFinTransaccion
        PMChequeaATX VGSqlConn
        Ref.SetFocus
        Exit Function
    End If
    PMChequeaATX VGSqlConn
    PMFinTransaccion
    'DoEvents
    
    
    If Me.txt_empresa <> "9291" Then
        'CONSULTA DE COMISION
        FPrincipal.Map.PMMapConfig "SHOWMESSAGE"  'msilvag RECMPS-26
        
        PMInicioTransaccion
        PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 4050, "Trn", ""
        PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLVARCHAR, "C", "opcion", ""
        'PMPasoValoresATX VGSqlConn, "@i_servi_person", 0, SQLVARCHAR, "CSPR", "Servicio Person", "" 'ICAE
        'PMPasoValoresATX VGSqlConn, "@i_rubro_person", 0, SQLVARCHAR, "DEPT", "Rubro Person", "" 'CCAE
        PMPasoValoresATX VGSqlConn, "@i_empresa", 0, SQLVARCHAR, Me.txt_empresa.Text, "empresa", ""
        PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Rubro Person", ""
        
        'Variables de salida
        PMPasoValoresATX VGSqlConn, "@o_comision", 1, SQLMONEY, 0, "Comision", ""
        PMPasoValoresATX VGSqlConn, "@o_tasa", 1, SQLMONEY, "0", "tasa", ""
        PMPasoValoresATX VGSqlConn, "@o_base_imp", 1, SQLMONEY, "0", "base_imp", ""
        PMPasoValoresATX VGSqlConn, "@o_impuesto", 1, SQLMONEY, "0", "impuesto", ""
        If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_val_servicios_varios", True, "Transaccion Ok", "S", "N", "N", "144", "S", "S") = True Then
            VLComision = FMRetParamATX(VGSqlConn, 1)
            VlbaseImp = FMRetParamATX(VGSqlConn, 3)
            VLiva = FMRetParamATX(VGSqlConn, 4)
        End If
        
        If VLComision = 0 Then
            Me.Comision.Enabled = False
        Else
            Me.Comision.Enabled = True
            Me.Comision.Text = VLComision
        End If
        
        FMInitMap FPrincipal!pnlHelpLine, FPrincipal!pnlTransaccionLine, FPrincipal!Focos(0), FPrincipal!Focos(1), FPrincipal!Focos(2), FPrincipal!Focos(3), VGLogTransacciones$ 'msilvag RECMPS-26
        
        'msilvag Inicio RECMPS-26
        SGActivaSum = False
        efe.Enabled = True
        'Total.Enabled = True
        txt_empresa.Enabled = False
        CboTipoID.Enabled = False
        Ref.Enabled = False
        CantChq.Enabled = True
        Cheques.Enabled = True
        CboTipCta.Enabled = True
        Cta.Enabled = True
        Debito.Enabled = True
        efe.SetFocus
        'msilvag Fin
        
        'jg Inicio RECMPS-272
         If Me.txt_empresa.Text = "8460" Then
            CantChq.Enabled = False
            Cheques.Enabled = False
            lbl_minPagar.Visible = True
            valor_minimo.Visible = True
         End If
        'jg Fin RECMPS-272
        
         'jg Inicio RECMPS-531
         If Me.txt_empresa.Text = "1348" Then  'RECMPS-531
            CantChq.Enabled = False
            Cheques.Enabled = False
         End If
         'jg Fin RECMPS-531
        
        'kbastida Inicio RECMPS-1478
         If Me.txt_empresa.Text = "8459" Then  'RECMPS-1478
            CantChq.Enabled = False
            Cheques.Enabled = False
         End If
         'kbastida Fin RECMPS-1478
        
        
         'jg Inicio RECMPS-463
         If Me.txt_empresa.Text = "8462" Then
            lbl_minPagar.Visible = True
            valor_minimo.Visible = True
         End If
        'jg Fin RECMPS-463
            
        PMChequeaATX VGSqlConn&
        PMFinTransaccion
        'FIN DE CONSULTA COMISION
    End If
    
End Function

Function FLTransmitir_consulta_CMA_MS() As Boolean
    Dim vl_procedure As String
    Dim vl_trx As String
    Dim vl_tipo_cons As String
    vl_tipo_cons = ""
    
    If Len(Trim$(txt_empresa.Text)) = 0 Then
        MsgBox "Campo empresa es Obligatorio para la consulta", vbCritical + vbOKOnly, "ATX"
        txt_empresa.SetFocus
        Exit Function
    End If
    
    If Len(Trim$(Ref.Text)) = 0 Then
        MsgBox "Campo código es Obligatorio para la consulta", vbCritical + vbOKOnly, "ATX"
        Ref.SetFocus
        Exit Function
    End If

    If Me.CboTipoID.ListIndex = 1 Then
        If Len(Ref.Text) <> 13 Then
            MsgBox "RUC debe ser de 13 dígitos", vbInformation, "Mensaje del Sistema"
            Ref.SetFocus
            Exit Function
        End If
    End If

    vl_tipo_cons = "2"
    SGEmpresa = "DEPLINE"
    vl_procedure = "fp_consulta_reca_ms"
    vl_trx = "62684"
    
    VLGrupo = ""
    FPrincipal.Map.PMMapConfig "SHOWMESSAGE"
    
    PMChequea VGSqlConn&
    PMPasoValores VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "sv_grupo_empresas"
    PMPasoValores VGSqlConn&, "@i_tipo", 0, SQLCHAR, "V"
    PMPasoValores VGSqlConn&, "@i_codigo", 0, SQLVARCHAR, Trim$(Me.txt_empresa.Text)
    If FMTransmitirRPC(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "") Then
        PMMapeaVariableATX VGSqlConn&, VTDetalles$
        PMChequea VGSqlConn&
        VLGrupo = VTDetalles$
        PMChequea VGSqlConn&
    Else
        VLGrupo = ""
        PMChequea VGSqlConn&
    End If
    FMInitMap FPrincipal!pnlHelpLine, FPrincipal!pnlTransaccionLine, FPrincipal!Focos(0), FPrincipal!Focos(1), FPrincipal!Focos(2), FPrincipal!Focos(3), VGLogTransacciones$
    
    'DoEvents
    PMInicioTransaccion
    FLTransmitir_consulta_CMA_MS = False
    
    VG_empresa_imp144 = ""
    VG_des_empresa_imp144 = ""
    VG_cta_empresa_imp144 = ""
    VG_ref_imp144 = ""
    VG_nombre_imp144 = ""
    VG_efe_imp144 = 0
    VG_deb_imp144 = 0
    VG_cta_imp144 = ""
    VG_total144 = 0
    VG_reimpresion144 = False
    VGCantChq = 0
    VGCheques = 0
    VGAutoriza = "N"
    VLNom_Emp = ""
    VLConvenio = "1929"
    VLTrn = "43569"
    '-- ************************* VARIABLE MICRO COBIS -- ************************
    PMPasoValoresATX VGSqlConn, "@i_trn", 0, SQLINT4, VLTrn, "Itrn", ""
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, vl_trx, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@e_canal", 0, SQLVARCHAR, "VEN", "canal", ""
    PMPasoValoresATX VGSqlConn, "@e_tipo_banca", 0, SQLVARCHAR, "BP", "BP", ""
    PMPasoValoresATX VGSqlConn, "@e_empresa", 0, SQLINT4, VLConvenio, "Empresa", ""
    PMPasoValoresATX VGSqlConn, "@e_convenio", 0, SQLVARCHAR, CInt(Trim(Me.txt_empresa.Text)), "Convenio", ""
    PMPasoValoresATX VGSqlConn, "@e_tipo_servicio", 0, SQLVARCHAR, "PAGO_ADUANA", "Tipo Servicio", ""
    PMPasoValoresATX VGSqlConn, "@e_servicio", 0, SQLVARCHAR, VLConvenio, "Servicio", ""
    PMPasoValoresATX VGSqlConn, "@e_tipo_identificador", 0, SQLVARCHAR, "1", "Tipo Identificador", ""
    PMPasoValoresATX VGSqlConn, "@s_date", 0, SQLVARCHAR, Format$(VGFechaProceso, "yyyy-mm-dd") + "T" + Format$(Time(), "hh:mm:ss"), "FechaLocal", ""
    PMPasoValoresATX VGSqlConn, "@s_ofi", 0, SQLINT4, str(VGOficina%), "VGOficina%", ""
    PMPasoValoresATX VGSqlConn, "@e_identificacion", 0, SQLVARCHAR, Trim$(Ref.Text), "Identificador", ""  'RUC -> codigoTipoIdentificador
    PMPasoValoresATX VGSqlConn, "@i_codigo", 0, SQLVARCHAR, Trim$(Ref.Text), "Codigo", ""
    
    '-- ************************* VARIABLE SALIDA -- ************************
    PMPasoValoresATX VGSqlConn, "@codigoRespuesta", 1, SQLINT4, 0, "cod", ""
    PMPasoValoresATX VGSqlConn, "@formaPago", 1, SQLVARCHAR, "", "formapago", ""
    PMPasoValoresATX VGSqlConn, "@nombreCliente", 1, SQLVARCHAR, "", "nombreCliente", ""
    PMPasoValoresATX VGSqlConn, "@montoTotal", 1, SQLVARCHAR, 0, "montoTotal", ""
    PMPasoValoresATX VGSqlConn, "@identificadorDeuda", 1, SQLVARCHAR, 0, "identificadorDeuda", ""
    PMPasoValoresATX VGSqlConn, "@mensajeUsuario", 1, SQLVARCHAR, 0, "mensajeUsuario", ""
    If FMTransmitirRPCATX(VGSqlConn, "RECSRV", "cob_procesador", vl_procedure, True, "Transaccion Ok", "S", "N", "N", "144", "S", "S") = True Then
    
        FLTransmitir_consulta_CMA_MS = True
        VTResult% = FMMapeaMatrizATX(VGSqlConn&, MatrizCnel())
        
        valor_pagar.Text = Format(FMRetParamATX(VGSqlConn, 4), "#0.00")    '@montoTotal
        VLNombre = FMRetParamATX(VGSqlConn, 2) '@nombreCliente
        Me.Nombre.Text = VLNombre
        VLNumDocumento = FMRetParamATX(VGSqlConn, 6) '@identificadorDeuda
        VLIdentificacion = FMRetParamATX(VGSqlConn, 6) '@identificadorDeuda
    Else
        FLTransmitir_consulta_CMA_MS = False
        PMFinTransaccion
        PMChequeaATX VGSqlConn
        Ref.SetFocus
        Exit Function
    End If
    PMChequeaATX VGSqlConn
    PMFinTransaccion
    'DoEvents
    
    'CONSULTA DE COMISION
    FPrincipal.Map.PMMapConfig "SHOWMESSAGE"  'msilvag RECMPS-26
        
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 4050, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLVARCHAR, "C", "opcion", ""
    PMPasoValoresATX VGSqlConn, "@i_empresa", 0, SQLVARCHAR, Me.txt_empresa.Text, "empresa", ""
    PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Rubro Person", ""
        
    'Variables de salida
    PMPasoValoresATX VGSqlConn, "@o_comision", 1, SQLMONEY, 0, "Comision", ""
    PMPasoValoresATX VGSqlConn, "@o_tasa", 1, SQLMONEY, "0", "tasa", ""
    PMPasoValoresATX VGSqlConn, "@o_base_imp", 1, SQLMONEY, "0", "base_imp", ""
    PMPasoValoresATX VGSqlConn, "@o_impuesto", 1, SQLMONEY, "0", "impuesto", ""
        
    If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_val_servicios_varios", True, "Transaccion Ok", "S", "N", "N", "144", "S", "S") = True Then
        VLComision = FMRetParamATX(VGSqlConn, 1)
        VlbaseImp = FMRetParamATX(VGSqlConn, 3)
        VLiva = FMRetParamATX(VGSqlConn, 4)
    End If
        
    If VLComision = 0 Then
        Me.Comision.Enabled = False
    Else
        Me.Comision.Enabled = True
        Me.Comision.Text = VLComision
    End If
        
    FMInitMap FPrincipal!pnlHelpLine, FPrincipal!pnlTransaccionLine, FPrincipal!Focos(0), FPrincipal!Focos(1), FPrincipal!Focos(2), FPrincipal!Focos(3), VGLogTransacciones$ 'msilvag RECMPS-26
        
    SGActivaSum = False
    efe.Enabled = True
    txt_empresa.Enabled = False
    CboTipoID.Enabled = False
    Ref.Enabled = False
    CantChq.Enabled = True
    Cheques.Enabled = True
    CboTipCta.Enabled = True
    Cta.Enabled = True
    Debito.Enabled = True
    efe.SetFocus
    PMChequeaATX VGSqlConn&
    PMFinTransaccion
    'FIN DE CONSULTA COMISION

End Function
Function FLBuscarItem(VLELemento As String) As String
    Dim I As Integer
    Dim hallado As Boolean
    I = 1
    hallado = False
    Do While I < 37 And Not hallado
        If MatrizCnel(0, I) = Trim$(VLELemento) Then
            hallado = True
        Else
            I = I + 1
        End If
    Loop
    If hallado Then
        FLBuscarItem = MatrizCnel(1, I)
    Else
        FLBuscarItem = ""
    End If
End Function

Function FLTransmitir_pago_Ecuaquimica() As Boolean

    'dpereirv Inicio RECMPS-19
    Dim vl_procedure As String
    Dim vl_trx As String
    Dim vldenominacion As String  'pholguiv 20191220
    
    vl_procedure = ""
    vl_trx = ""
    If Me.txt_empresa.Text = "9291" Then
        vl_procedure = "fp_pago_ecuaquimica"
        vl_trx = "62671"
    Else
        vl_procedure = "fp_pag_depenlinea"
        vl_trx = "62676"
    End If
    'dpereirv Fin
    
    
    
    VTIndicadorSum = 0
    PMInicioTransaccion
    FLTransmitir_pago_Ecuaquimica = False
    
    
    VG_empresa_imp144 = txt_empresa.Text
    VG_des_empresa_imp144 = Me.txt_des_empresa.Caption
    VG_ref_imp144 = Ref.Text
    VG_nombre_imp144 = Nombre.Text
    VG_efe_imp144 = efe.Text
    VG_cta_imp144 = Cta.ClipText
    VG_deb_imp144 = Debito.Text
    VGCantChq = CantChq.Text
    VGCheques = Cheques.Text
    VG_total144 = Total.Text - Comision.Text
    VGTrn144 = 4435
    VGTrn = IIf(VGTrn144 = "", 0, VGTrn144)
    
    If VGTipoEjecucion = CGNormal% Then
        If Me.txt_empresa.Text <> "9291" And Me.txt_empresa.Text <> "8460" And Me.txt_empresa.Text <> "8462" Then   ' RECMPS-223   RECMPS-463 JG
            If (FMCCurATX(Me.Total.Text) - FMCCurATX(Me.Comision.Text)) <> FMCCurATX(Me.valor_pagar.Text) Then
                MsgBox " Formas de pago no coinciden con Valor a Pagar"
            
                If Me.efe.Enabled Then
                    efe.SetFocus
                End If
                Exit Function
            End If
        End If
    End If
    
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, vl_trx, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Canal", ""
    PMPasoValoresATX VGSqlConn, "@i_fecha_trx", 0, SQLVARCHAR, Format$(VGFechaProceso, "yyyy-mm-dd") + "T" + Format$(Time(), "hh:mm:ss"), "FechaLocal", ""
    
    If VLGrupo = "" Then 'msilvag RECMPS-26
        PMPasoValoresATX VGSqlConn, "@i_empresa", 0, SQLVARCHAR, Trim$(Me.txt_empresa.Text), "Empresa", ""
    'msilvag Inicio RECMPS-26
    Else
        PMPasoValoresATX VGSqlConn, "@i_empresa", 0, SQLVARCHAR, Trim$(VLGrupo), "Empresa", ""
    End If
    'msilvag Fin
    
    PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, CStr(VGmoneda), "mon", ""
    
    If Me.txt_empresa.Text = "9291" Then
        If Me.CboTipoID.ListIndex = 0 Then
            PMPasoValoresATX VGSqlConn, "@i_tipoConsulta", 0, SQLVARCHAR, "C", "TipoConsulta", ""
        ElseIf Me.CboTipoID.ListIndex = 1 Then
            PMPasoValoresATX VGSqlConn, "@i_tipoConsulta", 0, SQLVARCHAR, "R", "TipoConsulta", ""
        Else
            PMPasoValoresATX VGSqlConn, "@i_tipoConsulta", 0, SQLVARCHAR, "P", "TipoConsulta", ""
        End If
        PMPasoValoresATX VGSqlConn, "@i_codigo", 0, SQLVARCHAR, Trim$(Ref.Text), "Codigo", ""
        PMPasoValoresATX VGSqlConn, "@i_tipo_cta", 0, SQLCHAR, (CboTipCta.Text), "TipoCta", ""
        PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
        If Me.Debito.Text > 0 Then
            PMPasoValoresATX VGSqlConn, "@i_nombre_cta", 0, SQLVARCHAR, NomCta.Text, "Nombre cuenta", ""
        End If
        PMPasoValoresATX VGSqlConn, "@i_total", 0, SQLMONEY, (Me.Total.Text), "Total pagado", ""

    Else
    
        'jg Inicio RECMPS-223
        If Me.txt_empresa.Text = "8460" Or Me.txt_empresa.Text = "1348" Then
            PMPasoValoresATX VGSqlConn, "@i_tipoConsulta", 0, SQLVARCHAR, "1", "TipoConsulta", ""
        Else
            PMPasoValoresATX VGSqlConn, "@i_tipoConsulta", 0, SQLVARCHAR, "2", "TipoConsulta", ""
        End If
        'jg Fin RECMPS-223
        
        PMPasoValoresATX VGSqlConn, "@i_subempresa", 0, SQLVARCHAR, Trim$(Me.txt_empresa.Text), "SubEmpresa", ""
        
          'jg Inicio RECMPS-463
        If Me.txt_empresa.Text = "8462" Then
            PMPasoValoresATX VGSqlConn, "@i_codigo", 0, SQLVARCHAR, Trim$(Ref.Text), "Codigo", ""
            PMPasoValoresATX VGSqlConn, "@i_fecCont", 0, SQLVARCHAR, VFecCont, "FechaContable", ""
            PMPasoValoresATX VGSqlConn, "@i_tipDoc", 0, SQLVARCHAR, VTipDoc, "TipoDoc", ""
            PMPasoValoresATX VGSqlConn, "@i_numDoc", 0, SQLVARCHAR, VNumDoc, "NumDoc", ""
        Else
        
            'KBastida RECMPS-1478'
            If Me.txt_empresa.Text = "8459" Then
                PMPasoValoresATX VGSqlConn, "@i_codigo", 0, SQLVARCHAR, VG_ref_imp144, "Codigo", ""
            Else
                PMPasoValoresATX VGSqlConn, "@i_codigo", 0, SQLVARCHAR, Trim$(VLIdentificacion), "Codigo", ""
            End If
            'KBastida RECMPS-1478'
        End If
        'jg Fin RECMPS-463
        
        
   
        
     
        PMPasoValoresATX VGSqlConn, "@i_mon_pago", 0, SQLCHAR, "USD", "Mon_pago", ""
        PMPasoValoresATX VGSqlConn, "@i_fecha_pago", 0, SQLVARCHAR, Format$(Date, "MM/DD/YYYY"), "Fecha_pago", ""
        PMPasoValoresATX VGSqlConn, "@i_hora_pago", 0, SQLVARCHAR, Format$(Time(), "HH:MM:SS"), "Hora_pago", ""
        PMPasoValoresATX VGSqlConn, "@i_cod_bco", 0, SQLCHAR, "BOL", "Codigo_bco", ""
        'Validar la forma de pago
        
        If Cheques.Text > 0 Then
            PMPasoValoresATX VGSqlConn, "@i_forma_pgo", 0, SQLCHAR, "CHQ", "Forma_pago", ""
        ElseIf efe.Text > 0 And Debito.Text = 0 Then
            PMPasoValoresATX VGSqlConn, "@i_forma_pgo", 0, SQLCHAR, "EFE", "Forma_pago", ""
        ElseIf Debito.Text > 0 And efe.Text = 0 Then
            PMPasoValoresATX VGSqlConn, "@i_forma_pgo", 0, SQLCHAR, "DEB", "Forma_pago", ""
        Else
            PMPasoValoresATX VGSqlConn, "@i_forma_pgo", 0, SQLCHAR, "EFE", "Forma_pago", ""
        End If
        
        If Me.txt_empresa = "6930" Then 'msilvag RECMPS-26
            PMPasoValoresATX VGSqlConn, "@i_num_doc", 0, SQLVARCHAR, VLNumDocumento, "Num_documento", ""
        'msilvag Inicio RECMPS-26
        Else
            PMPasoValoresATX VGSqlConn, "@i_num_doc", 0, SQLVARCHAR, Trim$(Ref.Text), "Num_documento", ""
        End If
        'msilvag Fin
        
        If Check_Certificado.Value = "1" Then
            PMPasoValoresATX VGSqlConn, "@i_ref_doc", 0, SQLVARCHAR, "S", "Ref_documento", ""
        Else
            'KBastida RECMPS-1478'
            If Me.txt_empresa = "8459" Then
                PMPasoValoresATX VGSqlConn, "@i_ref_doc", 0, SQLVARCHAR, Trim$(VLIdentificacion), "Ref_documento", ""
            Else
                PMPasoValoresATX VGSqlConn, "@i_ref_doc", 0, SQLVARCHAR, "N", "Ref_documento", ""
            End If
            'KBastida RECMPS-1478'
        End If
        
        PMPasoValoresATX VGSqlConn, "@i_chq_com", 0, SQLMONEY, (VLChq_com), "Com. Cheques", ""
        PMPasoValoresATX VGSqlConn, "@i_deb_com", 0, SQLMONEY, (VLDeb_com), "Com. Debito", ""
        PMPasoValoresATX VGSqlConn, "@i_efe_com", 0, SQLMONEY, (VLEfe_com), "Com. efectivo", ""
        PMPasoValoresATX VGSqlConn, "@i_comision", 0, SQLMONEY, (Comision.Text), "valor de la comision", ""
        If Me.Cta.ClipText <> "" Then
            PMPasoValoresATX VGSqlConn, "@i_tipo_cta", 0, SQLCHAR, (CboTipCta.Text), "TipoCta", ""
            PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
            If Me.Debito.Text > 0 Then
                PMPasoValoresATX VGSqlConn, "@i_nombre_cta", 0, SQLVARCHAR, NomCta.Text, "Nombre cuenta", ""
            End If
        Else
            'msilvaf Inicio RECMPS-26
            If VLTipCta_com = "" Then
                VLTipCta_com = "CTE"
            End If
            'msilvag Fin
            PMPasoValoresATX VGSqlConn, "@i_tipo_cta", 0, SQLCHAR, (VLTipCta_com), "TipoCta", ""
            PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (VLCta_com), "Cta", ""
        End If
        
        VLMonto = 0
        VLMonto = Me.Total.Text - Comision.Text
        PMPasoValoresATX VGSqlConn, "@i_total", 0, SQLMONEY, (VLMonto), "Total pagado", ""

    End If
        
    PMPasoValoresATX VGSqlConn, "@i_tipocanal", 0, SQLVARCHAR, "VENBCO", "tipocanal", ""
    PMPasoValoresATX VGSqlConn, "@i_nombre_suscrip", 0, SQLVARCHAR, Nombre.Text, "Nom. Cliente", ""
      
        
    If VGTipoEjecucion% <> CGReverso% Then
        PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLVARCHAR, "N", "TCORR", ""
    End If
        
    PMPasoValoresATX VGSqlConn, "@i_efectivo", 0, SQLMONEY, efe.Text, "Efectivo", ""
    PMPasoValoresATX VGSqlConn, "@i_aplcobis", 0, SQLCHAR, "S", "aplcobis", ""
    PMPasoValoresATX VGSqlConn, "@i_empname", 0, SQLVARCHAR, (txt_des_empresa), "NomEmp", ""
    PMPasoValoresATX VGSqlConn, "@i_valpagar", 0, SQLVARCHAR, (valor_pagar), "ValPag", ""
    PMPasoValoresATX VGSqlConn, "@i_autoriza", 0, SQLCHAR, VGAutoriza, "Autorizacion", ""
    PMPasoValoresATX VGSqlConn, "@i_cant_cheques", 0, SQLINT4, val(CantChq.Text), "CantChq", ""
    PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, (Cheques.Text), "Cheques", ""
    PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, Debito.Text, "Debito", ""
    
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

   
    '-------pholguiv 01/09/2020
    vldenominacion = ""
    For I% = 1 To SGNumDen
        'SGIngreso(I% - 1).cod_denom
        If val(SGIngreso(I% - 1).cant_ingr) > 0 And SGAcumulado = 0 Then
               vldenominacion = vldenominacion + CStr(SGIngreso(I% - 1).denominac) + "|" + CStr(SGIngreso(I% - 1).cant_ingr) + ";" ' "|" + CStr(SGIngreso(I% - 1).mont_ingr) + ";"
        Else
          If val(SGIngreso(I% - 1).cant_adi) > 0 And SGAcumuladoAdi > 0 Then
             vldenominacion = vldenominacion + CStr(SGIngreso(I% - 1).denominac) + "|" + CStr(SGIngreso(I% - 1).cant_adi) + ";" ' "|" + CStr(SGIngreso(I% - 1).mont_ingr) + ";"
          End If
        End If
        
    Next I%
    '-------pholguiv
    'PMPasoValoresATX VGSqlConn, "@i_denominaciones", 0, SQLVARCHAR, CStr(vldenominacion), "denom", ""        '<-- JPM lectora de billetes (deshabilitar)
    PMAParamBillAltaDenom  '<-- JPM lectora de billetes
    If FMTransmitirRPCATX(VGSqlConn, "BBTSSRV", "cob_procesador", vl_procedure, True, "Transaccion Ok", "S", "N", "S", "144", "S", "S") = True Then
        FLTransmitir_pago_Ecuaquimica = True
        VTResult% = FMMapeaMatrizATX(VGSqlConn&, MatrizCnel())
        
        If Me.txt_empresa.Text <> "9291" Then
            VLFechaContable = Mid(FLBuscarItem("@o_fecha_contable"), 1, 10)
        Else
            VLFechaContable = FLBuscarItem("@o_fecha_contable")
        End If
        VGFechaCorte144 = Format(VLFechaContable, "mm/dd/yyyy")
        VGHorario_pago144 = FLBuscarItem("@o_horario")
        SGSecTrn$ = FLBuscarItem("@o_ssn")
        PMChequeaATX VGSqlConn
        VLCambio% = False
        VTIndicadorSum = 1
        VG_reimpresion144 = True
        
        PMIniciaRegSum
''        efe.Enabled = True
'        Total.Enabled = True
'        txt_empresa.Enabled = False
'        cboTipoId.Enabled = False
'        Ref.Enabled = False
'        efe.SetFocus
    Else
        VG_reimpresion144 = False
        FLTransmitir_pago_Ecuaquimica = False
        VLCambio% = True
        VTIndicadorSum = 0
        PMChequeaATX VGSqlConn
'        Ref.SetFocus
    End If
    PMChequeaATX VGSqlConn
    PMFinTransaccion
    
     If FLTransmitir_pago_Ecuaquimica = True And val(VLDeb_com) <= 0 Then
        Call PLFactura
    End If
    'JPM Lectora de Billetes -->
    If FLTransmitir_pago_Ecuaquimica And (CCur(efe.Text) > 0 And ((VGDatPersBillAltDen.dataOK And VGTipoEjecucion = CGNormal%) Or VGTipoEjecucion = CGReverso%)) Then
      'Call PMGuardarDsglsBillete("144", SGSecTrn$, VGTrn144, rptBAD, CboTipCta.Text, Cta.ClipText)
      Call PMGuardarDsglsBillete("144", SGSecTrn$, VGTrn144, rptBAD, "REC", "")
      lectoraBill.Limpiar
    End If
    '<-- JPM Lectora de Billetes

   If VGTipoEjecucion% <> CGReverso% Then
      If (VTIndicadorSum = 1 And (Trim$(VGStatusCon) = "A" Or Trim$(VGStatusCon) = "")) Then
         SGPrimeraVez = 0
         PMGrabaDesglose VGTrn144, SGUsar, VLCambio%
         If VLCambio% = True Then
            MsgBox "Error en la Grabacion del Desglose. Favor comuniquese con su Supervisor.", vbCritical, "Error de Sistema"
         End If
         SGActual = 1
      ElseIf VTIndicadorSum = 0 Then
         SGActual = 0
      End If
   ElseIf VTIndicadorSum = 1 Then
      VLTsnTemp = VGTSN
      PMEgresoEfectivo SGUsar, VGTrn144
   End If
   If SGAcumulado < 0 Then
      VLDescargar = 1
   End If

End Function

Function FLTransmitir_pago_Marglobal() As Boolean

    'dpereirv Inicio RECMPS-19
    Dim vl_procedure As String
    Dim vl_trx As String
    Dim vldenominacion As String  'pholguiv 20191220
    
    vl_procedure = "fp_pag_depenlinea"
    vl_trx = "62676"
    
    
    
    VTIndicadorSum = 0
    PMInicioTransaccion
    FLTransmitir_pago_Marglobal = False
    
    
    VG_empresa_imp144 = txt_empresa.Text
    VG_des_empresa_imp144 = Me.txt_des_empresa.Caption
    VG_ref_imp144 = Ref.Text
    VG_nombre_imp144 = Nombre.Text
    VG_efe_imp144 = efe.Text
    VG_cta_imp144 = Cta.ClipText
    VG_deb_imp144 = Debito.Text
    VGCantChq = CantChq.Text
    VGCheques = Cheques.Text
    VG_total144 = Total.Text - Comision.Text
    VGTrn144 = 4435
    VGTrn = IIf(VGTrn144 = "", 0, VGTrn144)
    
    If VGTipoEjecucion = CGNormal% Then
        If Me.txt_empresa.Text <> "9291" And Me.txt_empresa.Text <> "8460" And Me.txt_empresa.Text <> "8462" Then   ' RECMPS-223   RECMPS-463 JG
            If (FMCCurATX(Me.Total.Text) - FMCCurATX(Me.Comision.Text)) <> FMCCurATX(Me.valor_pagar.Text) Then
                MsgBox " Formas de pago no coinciden con Valor a Pagar"
            
                If Me.efe.Enabled Then
                    efe.SetFocus
                End If
                Exit Function
            End If
        End If
    End If
    
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, vl_trx, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Canal", ""
    PMPasoValoresATX VGSqlConn, "@i_fecha_trx", 0, SQLVARCHAR, Format$(VGFechaProceso, "yyyy-mm-dd") + "T" + Format$(Time(), "hh:mm:ss"), "FechaLocal", ""
    PMPasoValoresATX VGSqlConn, "@i_empresa", 0, SQLVARCHAR, "451", "Empresa", ""
        PMPasoValoresATX VGSqlConn, "@i_subempresa", 0, SQLVARCHAR, Trim$(Me.txt_empresa.Text), "SubEmpresa", ""
    PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, CStr(VGmoneda), "mon", ""
    
    PMPasoValoresATX VGSqlConn, "@i_tipoConsulta", 0, SQLVARCHAR, "2", "TipoConsulta", ""
    PMPasoValoresATX VGSqlConn, "@i_codigo", 0, SQLVARCHAR, Trim$(VLIdentificacion), "Codigo", ""
        
      
 
     
        PMPasoValoresATX VGSqlConn, "@i_mon_pago", 0, SQLCHAR, "USD", "Mon_pago", ""
        PMPasoValoresATX VGSqlConn, "@i_fecha_pago", 0, SQLVARCHAR, Format$(Date, "MM/DD/YYYY"), "Fecha_pago", ""
        PMPasoValoresATX VGSqlConn, "@i_hora_pago", 0, SQLVARCHAR, Format$(Time(), "HH:MM:SS"), "Hora_pago", ""
        PMPasoValoresATX VGSqlConn, "@i_cod_bco", 0, SQLCHAR, "BOL", "Codigo_bco", ""
        'Validar la forma de pago
        
        If Cheques.Text > 0 Then
            PMPasoValoresATX VGSqlConn, "@i_forma_pgo", 0, SQLCHAR, "CHQ", "Forma_pago", ""
        ElseIf efe.Text > 0 And Debito.Text = 0 Then
            PMPasoValoresATX VGSqlConn, "@i_forma_pgo", 0, SQLCHAR, "EFE", "Forma_pago", ""
        ElseIf Debito.Text > 0 And efe.Text = 0 Then
            PMPasoValoresATX VGSqlConn, "@i_forma_pgo", 0, SQLCHAR, "DEB", "Forma_pago", ""
        Else
            PMPasoValoresATX VGSqlConn, "@i_forma_pgo", 0, SQLCHAR, "EFE", "Forma_pago", ""
        End If
        
        PMPasoValoresATX VGSqlConn, "@i_num_doc", 0, SQLVARCHAR, Trim$(Ref.Text), "Num_documento", ""
        
        If Check_Certificado.Value = "1" Then
            PMPasoValoresATX VGSqlConn, "@i_ref_doc", 0, SQLVARCHAR, "S", "Ref_documento", ""
        Else
            PMPasoValoresATX VGSqlConn, "@i_ref_doc", 0, SQLVARCHAR, "N", "Ref_documento", ""
        End If
        
        PMPasoValoresATX VGSqlConn, "@i_chq_com", 0, SQLMONEY, (VLChq_com), "Com. Cheques", ""
        PMPasoValoresATX VGSqlConn, "@i_deb_com", 0, SQLMONEY, (VLDeb_com), "Com. Debito", ""
        PMPasoValoresATX VGSqlConn, "@i_efe_com", 0, SQLMONEY, (VLEfe_com), "Com. efectivo", ""
        PMPasoValoresATX VGSqlConn, "@i_comision", 0, SQLMONEY, (Comision.Text), "valor de la comision", ""
        If Me.Cta.ClipText <> "" Then
            PMPasoValoresATX VGSqlConn, "@i_tipo_cta", 0, SQLCHAR, (CboTipCta.Text), "TipoCta", ""
            PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
            If Me.Debito.Text > 0 Then
                PMPasoValoresATX VGSqlConn, "@i_nombre_cta", 0, SQLVARCHAR, NomCta.Text, "Nombre cuenta", ""
            End If
        Else
            If VLTipCta_com = "" Then
                VLTipCta_com = "CTE"
            End If
            PMPasoValoresATX VGSqlConn, "@i_tipo_cta", 0, SQLCHAR, (VLTipCta_com), "TipoCta", ""
            PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (VLCta_com), "Cta", ""
        End If
        
        VLMonto = 0
        VLMonto = Me.Total.Text - Comision.Text
        PMPasoValoresATX VGSqlConn, "@i_total", 0, SQLMONEY, (VLMonto), "Total pagado", ""

    
        
    PMPasoValoresATX VGSqlConn, "@i_tipocanal", 0, SQLVARCHAR, "VENBCO", "tipocanal", ""
    PMPasoValoresATX VGSqlConn, "@i_nombre_suscrip", 0, SQLVARCHAR, Nombre.Text, "Nom. Cliente", ""
      
        
    If VGTipoEjecucion% <> CGReverso% Then
        PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLVARCHAR, "N", "TCORR", ""
    End If
        
    PMPasoValoresATX VGSqlConn, "@i_efectivo", 0, SQLMONEY, efe.Text, "Efectivo", ""
    PMPasoValoresATX VGSqlConn, "@i_aplcobis", 0, SQLCHAR, "S", "aplcobis", ""
    PMPasoValoresATX VGSqlConn, "@i_empname", 0, SQLVARCHAR, (txt_des_empresa), "NomEmp", ""
    PMPasoValoresATX VGSqlConn, "@i_valpagar", 0, SQLVARCHAR, (valor_pagar), "ValPag", ""
    PMPasoValoresATX VGSqlConn, "@i_autoriza", 0, SQLCHAR, VGAutoriza, "Autorizacion", ""
    PMPasoValoresATX VGSqlConn, "@i_cant_cheques", 0, SQLINT4, val(CantChq.Text), "CantChq", ""
    PMPasoValoresATX VGSqlConn, "@i_cant_chq", 0, SQLINT4, val(CantChq.Text), "CantChq", ""
    PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, (Cheques.Text), "Cheques", ""
    PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, Debito.Text, "Debito", ""
    
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

   
    '-------pholguiv 01/09/2020
    vldenominacion = ""
    For I% = 1 To SGNumDen
        'SGIngreso(I% - 1).cod_denom
        If val(SGIngreso(I% - 1).cant_ingr) > 0 And SGAcumulado = 0 Then
               vldenominacion = vldenominacion + CStr(SGIngreso(I% - 1).denominac) + "|" + CStr(SGIngreso(I% - 1).cant_ingr) + ";" ' "|" + CStr(SGIngreso(I% - 1).mont_ingr) + ";"
        Else
          If val(SGIngreso(I% - 1).cant_adi) > 0 And SGAcumuladoAdi > 0 Then
             vldenominacion = vldenominacion + CStr(SGIngreso(I% - 1).denominac) + "|" + CStr(SGIngreso(I% - 1).cant_adi) + ";" ' "|" + CStr(SGIngreso(I% - 1).mont_ingr) + ";"
          End If
        End If
        
    Next I%
    '-------pholguiv
    'PMPasoValoresATX VGSqlConn, "@i_denominaciones", 0, SQLVARCHAR, CStr(vldenominacion), "denom", ""        '<-- JPM lectora de billetes (deshabilitar)
    PMAParamBillAltaDenom  '<-- JPM lectora de billetes
    If FMTransmitirRPCATX(VGSqlConn, "BBTSSRV", "cob_procesador", vl_procedure, True, "Transaccion Ok", "S", "N", "S", "144", "S", "S") = True Then
        FLTransmitir_pago_Marglobal = True
        VTResult% = FMMapeaMatrizATX(VGSqlConn&, MatrizCnel())
        
        If Me.txt_empresa.Text <> "9291" Then
            VLFechaContable = Mid(FLBuscarItem("@o_fecha_contable"), 1, 10)
        Else
            VLFechaContable = FLBuscarItem("@o_fecha_contable")
        End If
        VGFechaCorte144 = Format(VLFechaContable, "mm/dd/yyyy")
        VGHorario_pago144 = FLBuscarItem("@o_horario")
        SGSecTrn$ = FLBuscarItem("@o_ssn")
        PMChequeaATX VGSqlConn
        VLCambio% = False
        VTIndicadorSum = 1
        VG_reimpresion144 = True
        
        PMIniciaRegSum
    Else
        VG_reimpresion144 = False
        FLTransmitir_pago_Marglobal = False
        VLCambio% = True
        VTIndicadorSum = 0
        PMChequeaATX VGSqlConn
    End If
    PMChequeaATX VGSqlConn
    PMFinTransaccion
    
     If FLTransmitir_pago_Marglobal = True And val(VLDeb_com) <= 0 Then
        Call PLFactura
    End If
    'JPM Lectora de Billetes -->
    If FLTransmitir_pago_Marglobal And (CCur(efe.Text) > 0 And ((VGDatPersBillAltDen.dataOK And VGTipoEjecucion = CGNormal%) Or VGTipoEjecucion = CGReverso%)) Then
      Call PMGuardarDsglsBillete("144", SGSecTrn$, VGTrn144, rptBAD, "REC", "")
      lectoraBill.Limpiar
    End If
    '<-- JPM Lectora de Billetes

   If VGTipoEjecucion% <> CGReverso% Then
      If (VTIndicadorSum = 1 And (Trim$(VGStatusCon) = "A" Or Trim$(VGStatusCon) = "")) Then
         SGPrimeraVez = 0
         PMGrabaDesglose VGTrn144, SGUsar, VLCambio%
         If VLCambio% = True Then
            MsgBox "Error en la Grabacion del Desglose. Favor comuniquese con su Supervisor.", vbCritical, "Error de Sistema"
         End If
         SGActual = 1
      ElseIf VTIndicadorSum = 0 Then
         SGActual = 0
      End If
   ElseIf VTIndicadorSum = 1 Then
      VLTsnTemp = VGTSN
      PMEgresoEfectivo SGUsar, VGTrn144
   End If
   If SGAcumulado < 0 Then
      VLDescargar = 1
   End If

End Function

Function FLTransmitir_pago_CMA_MS() As Boolean
    Dim vl_procedure As String
    Dim vl_trx As String
    Dim vldenominacion As String
    
    vl_procedure = "fp_pago_reca_ms"
    vl_trx = "62685"
    VTIndicadorSum = 0
    PMInicioTransaccion
    FLTransmitir_pago_CMA_MS = False
    
    VG_empresa_imp144 = txt_empresa.Text
    VG_des_empresa_imp144 = Me.txt_des_empresa.Caption
    VG_ref_imp144 = Ref.Text
    VG_nombre_imp144 = Nombre.Text
    VG_efe_imp144 = efe.Text
    VG_cta_imp144 = Cta.ClipText
    VG_deb_imp144 = Debito.Text
    VGCantChq = CantChq.Text
    VGCheques = Cheques.Text
    VG_total144 = Total.Text
    'VGTrn144 = 43569
    VLTrn = 43569
    VLConvenio = "1929"
    VGTrn144 = 4435
    'VGTrn = IIf(VGTrn144 = "", 0, VGTrn144) '
    VLHorario = "N"

    If VGTipoEjecucion = CGNormal% Then
        If (FMCCurATX(Me.Total.Text) - FMCCurATX(Me.Comision.Text)) <> FMCCurATX(Me.valor_pagar.Text) Then
                MsgBox " Formas de pago no coinciden con Valor a Pagar"
                If Me.efe.Enabled Then
                    efe.SetFocus
                End If
                Exit Function
        End If
    End If
    
    '***************** VALIDACION HORARIO ***********
    If VGHorarioDif = True Then
        If VLHorarioEmp = "N" Then
            If CCur(Cheques) > 0 Then
                VLTrn = "43569"
                VLHorario = "D"
            Else
                VLTrn = "43569"
                VLHorario = "N"
            End If
        Else
            VLTrn = "43569"
            VLHorario = "D"
        End If
    End If
    
    PMInicioTransaccion
    '***************** TRX DE REVERSO ***********
    If VGTipoEjecucion% = CGReverso% Then
        VLIndReverso = True
        vl_trx = "62690"
        vl_procedure = "fp_reverso_reca_ms"
    End If

    If VGTipoEjecucion% <> CGReverso% Then
        PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLVARCHAR, "N", "TCORR", ""
        PMPasoValoresATX VGSqlConn, "@e_corr", 0, SQLVARCHAR, "N", "TCORR", ""
    End If

    '***************** VALIDACION FORMA PAGO ***********
    VLMonto = Me.Total.Text - Comision.Text
    
    If Debito.Text > 0 Then
        VLTPCuenta = CboTipCta.Text
    End If
 
    '****** BRANCH *******************************************************
    PMPasoValoresATX VGSqlConn, "@i_moneda", 0, SQLINT1, str(FMObtenerMonedaForma("144")), "Moneda", ""
    PMPasoValoresATX VGSqlConn, "@i_val", 0, SQLMONEY, efe.Text, "Efectivo", ""
    PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, Debito.Text, "Debito", ""
    PMPasoValoresATX VGSqlConn, "@i_tipo_cta", 0, SQLCHAR, (VLTPCuenta), "TipoCta", ""
    PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, (Cheques.Text), "Cheques", ""
    PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cuenta", ""
    PMPasoValoresATX VGSqlConn, "@i_cant_cheques", 0, SQLINT4, val(CantChq.Text), "CantChq", ""
    PMPasoValoresATX VGSqlConn, "@i_cant_chq", 0, SQLINT4, val(CantChq.Text), "CantChq", ""
    PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Canal", ""
    PMPasoValoresATX VGSqlConn, "@i_empname", 0, SQLVARCHAR, (txt_des_empresa), "NomEmp", ""
    
    '****** MS-COBIS *******************************************************
    PMPasoValoresATX VGSqlConn, "@e_empresa", 0, SQLINT4, VLConvenio, "Empresa", ""
    PMPasoValoresATX VGSqlConn, "@i_empresa", 0, SQLINT4, CInt(Me.txt_empresa.Text), "Empresa", ""
    PMPasoValoresATX VGSqlConn, "@e_convenio", 0, SQLVARCHAR, CInt(Trim(Me.txt_empresa.Text)), "Convenio", ""
    PMPasoValoresATX VGSqlConn, "@e_tipo_servicio", 0, SQLVARCHAR, "PAGO_ADUANA", "Tipo Servicio", ""
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, vl_trx, "Trn Flujo", ""
    PMPasoValoresATX VGSqlConn, "@i_trn", 0, SQLINT4, VLTrn, "Itrn", ""
    PMPasoValoresATX VGSqlConn, "@e_tipo_banca", 0, SQLVARCHAR, "BP", "BP", ""
    PMPasoValoresATX VGSqlConn, "@e_tipo_identificador", 0, SQLVARCHAR, "1", "Tipo Identificador", ""

    '****** MS-PAGO CORE *******************************************************

    PMPasoValoresATX VGSqlConn, "@e_tipocta", 0, SQLVARCHAR, (VLTPCuenta), "TipoCta", ""
    PMPasoValoresATX VGSqlConn, "@e_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cuenta", ""
    PMPasoValoresATX VGSqlConn, "@i_tipoConsulta", 0, SQLVARCHAR, "2", "TipoConsulta", ""
    PMPasoValoresATX VGSqlConn, "@i_subempresa", 0, SQLVARCHAR, Trim$(Me.txt_empresa.Text), "SubEmpresa", ""
    PMPasoValoresATX VGSqlConn, "@i_codigo", 0, SQLVARCHAR, Trim$(Ref.Text), "Codigo", ""
    PMPasoValoresATX VGSqlConn, "@e_moneda", 0, SQLINT1, str(FMObtenerMonedaForma("144")), "Moneda", ""
    PMPasoValoresATX VGSqlConn, "@e_val", 0, SQLMONEY, efe.Text, "Efectivo", ""
    PMPasoValoresATX VGSqlConn, "@e_opcion", 0, SQLCHAR, "P", "Opcion", ""
    PMPasoValoresATX VGSqlConn, "@e_canal", 0, SQLVARCHAR, "VEN", "Canal", ""
    PMPasoValoresATX VGSqlConn, "@e_nombre", 0, SQLVARCHAR, Nombre.Text, "Nom. Cliente", ""
    PMPasoValoresATX VGSqlConn, "@e_total", 0, SQLMONEY, (VLMonto), "Total pagado", ""
    PMPasoValoresATX VGSqlConn, "@e_fecha_real", 0, SQLVARCHAR, Format(Date, "mm/dd/yyyy"), "FechaReal", ""
    PMPasoValoresATX VGSqlConn, "@srv", 0, SQLVARCHAR, "", "SRVDESA2", ""
    PMPasoValoresATX VGSqlConn, "@e_concepto", 0, SQLVARCHAR, Trim$(Ref.Text), "SRVDESA2", ""
    PMPasoValoresATX VGSqlConn, "@s_date", 0, SQLVARCHAR, Format$(VGFechaProceso, "yyyy-mm-dd") + "T" + Format$(Time(), "hh:mm:ss"), "FechaLocal", ""
    PMPasoValoresATX VGSqlConn, "@e_nombre_cta", 0, SQLVARCHAR, NomCta.Text, "Nombre cuenta", ""
    PMPasoValoresATX VGSqlConn, "@e_identificacion", 0, SQLVARCHAR, (Trim$(Ref.Text)), "Cod. Cliente", ""
    PMPasoValoresATX VGSqlConn, "@e_comision_tot", 0, SQLMONEY, (Comision.Text), "valor de la comision", ""
    PMPasoValoresATX VGSqlConn, "@s_sectrx", 1, SQLINT4, 0, "SecTrn", ""
    PMPasoValoresATX VGSqlConn, "@e_cant_cheques", 0, SQLINT4, val(CantChq.Text), "Cantidad de cheques", ""
    
    '****** VALOR PAGO*******************************************************
    PMPasoValoresATX VGSqlConn, "@e_efectivo", 0, SQLMONEY, (efe.Text), "efe", ""
    PMPasoValoresATX VGSqlConn, "@e_cheque", 0, SQLMONEY, (Cheques.Text), "Cheques", ""
    PMPasoValoresATX VGSqlConn, "@e_debito", 0, SQLMONEY, Debito.Text, "Debito", ""
    PMPasoValoresATX VGSqlConn, "@e_comision_efe", 0, SQLMONEY, (VLEfe_com), "Com. efectivo", ""
    PMPasoValoresATX VGSqlConn, "@e_comision_chq", 0, SQLMONEY, (VLChq_com), "Com. Cheques", ""
    PMPasoValoresATX VGSqlConn, "@e_comision_db", 0, SQLMONEY, (VLDeb_com), "Com. debito", ""

    '****** FORMA PAGO PARA FACTURA*******************************************
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

    vldenominacion = ""
    For I% = 1 To SGNumDen
        If val(SGIngreso(I% - 1).cant_ingr) > 0 And SGAcumulado = 0 Then
               vldenominacion = vldenominacion + CStr(SGIngreso(I% - 1).denominac) + "|" + CStr(SGIngreso(I% - 1).cant_ingr) + ";" ' "|" + CStr(SGIngreso(I% - 1).mont_ingr) + ";"
        Else
          If val(SGIngreso(I% - 1).cant_adi) > 0 And SGAcumuladoAdi > 0 Then
             vldenominacion = vldenominacion + CStr(SGIngreso(I% - 1).denominac) + "|" + CStr(SGIngreso(I% - 1).cant_adi) + ";" ' "|" + CStr(SGIngreso(I% - 1).mont_ingr) + ";"
          End If
        End If
    Next I%
    PMAParamBillAltaDenom  '<-- JPM lectora de billetes
    If FMTransmitirRPCATX(VGSqlConn, "RECSRV", "cob_procesador", vl_procedure, True, "Transaccion Ok", "S", "N", "S", "144", "S", "S") = True Then
        FLTransmitir_pago_CMA_MS = True
        VTResult% = FMMapeaMatrizATX(VGSqlConn&, MatrizCnel())
        
        VLFechaContable = Format$(VGFechaProceso, "yyyy-mm-dd") + "T" + Format$(Time(), "hh:mm:ss")
        VGFechaCorte144 = Format(VLFechaContable, "mm/dd/yyyy")
        SGSecTrn$ = FLBuscarItem("@referencia")
        VLSSnCorreccion = FLBuscarItem("@referencia")
        PMChequeaATX VGSqlConn
        VLCambio% = False
        VTIndicadorSum = 1
        VG_reimpresion144 = True
        PMIniciaRegSum
    Else
        VG_reimpresion144 = False
        FLTransmitir_pago_CMA_MS = False
        VLCambio% = True
        VTIndicadorSum = 0
        PMChequeaATX VGSqlConn
    End If

    PMChequeaATX VGSqlConn
    PMFinTransaccion
    
    If FLTransmitir_pago_CMA_MS = True And val(VLDeb_com) <= 0 Then
        Call PLFactura
    End If
    'JPM Lectora de Billetes -->
    If FLTransmitir_pago_CMA_MS And (CCur(efe.Text) > 0 And ((VGDatPersBillAltDen.dataOK And VGTipoEjecucion = CGNormal%) Or VGTipoEjecucion = CGReverso%)) Then
      Call PMGuardarDsglsBillete("144", SGSecTrn$, VGTrn144, rptBAD, "REC", "")
      lectoraBill.Limpiar
    End If
    '<-- JPM Lectora de Billetes

    If VGTipoEjecucion% <> CGReverso% Then
        If (VTIndicadorSum = 1 And (Trim$(VGStatusCon) = "A" Or Trim$(VGStatusCon) = "")) Then
            SGPrimeraVez = 0
            PMGrabaDesglose VGTrn144, SGUsar, VLCambio%
            If VLCambio% = True Then
                MsgBox "Error en la Grabacion del Desglose. Favor comuniquese con su Supervisor.", vbCritical, "Error de Sistema"
            End If
            SGActual = 1
        ElseIf VTIndicadorSum = 0 Then
            SGActual = 0
        End If
    ElseIf VTIndicadorSum = 1 Then
      VLTsnTemp = VGTSN
      PMEgresoEfectivo SGUsar, VGTrn144
    End If
   If SGAcumulado < 0 Then
      VLDescargar = 1
   End If
End Function
Private Function FLChequeos() As Boolean
On Error GoTo Error
    FLChequeos = False
    
'    If VLMoneda <> VGmoneda% Then
'        MsgBox "No se Puede Debitar a Cuentas con Moneda diferente a Moneda Base.", vbExclamation
'        Cta.SetFocus
'        FLChequeos = False
'        Exit Sub
'    End If



    If Trim$(Cheques.Text) <> "0.00" _
    And val(CantChq.Text) = 0 Then
        MsgBox "Debe Ingresar la cantidad de Cheques", vbCritical, "Mensaje del Sistema"
        FLChequeos = False
        If CantChq.Enabled Then
            CantChq.SetFocus
        End If
        Exit Function
    Else
        If val(CantChq.Text) <> 0 _
        And Trim$(Cheques.Text) = "0.00" Then
            MsgBox "Debe Ingresar El Monto del(los) Cheque(s)", vbCritical, "Mensaje del Sistema"
            FLChequeos = False
            Cheques.SetFocus
        Exit Function
        End If
    End If
    
    If FMCCurATX(valor_pagar.Text) = 0 Or Trim(valor_pagar.Text) = "" Then
        FLChequeos = False
        Exit Function
    End If
    
    'Validacion necesaria para No permitir Transacciones en caso de Valor Acumulado negativo
    If SGAcumulado < 0 And VGTipoEjecucion = CGNormal% Then
        MsgBox "Valor acumulado < 0 por Reverso. Transaccion No Permitida", vbInformation, "Mensaje del Sistema"
        FLChequeos = False
        Exit Function
    End If
   
   If (CDbl(efe.Text) + CDbl(Debito.Text) + CDbl(Cheques.Text)) = 0 Then
        FLChequeos = False
        Exit Function
    End If
    
    If (CDbl(efe.Text) + VLEfe_com) <> SGUsar Then
        MsgBox "El Monto Efetivo No Coincide con el Monto Desglosado, Verificar", vbCritical, "Mensaje del Sistema"
'        efe.Text = Format$(SGUsar, "####,###,##0.00")
        SGActivaSum = False
        PMIngresoEfectivo
        efe.Text = Format$(SGUsar, "####,###,##0.00")
        Exit Function
    End If
    
    If Trim(txt_empresa.Text) = "" Then
        MsgBox "El codigo de empresa es obligatorio"
        FLChequeos = False
        Me.txt_empresa.SetFocus
        Exit Function
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
  
  


If (FMCCurATX((Total.Text)) - Comision.Text) > FMCCurATX((valor_pagar.Text)) Then
    MsgBox " Valor excede el monto adeudado. Verifique...", vbCritical, "Mensaje del Servidor"
    FLChequeos = False
    efe.SetFocus
    Exit Function
End If

'jg Inicio RECMPS-223
If Me.txt_empresa.Text = "8460" Or Me.txt_empresa.Text = "8462" Then   'RECMPS-463
    If (FMCCurATX((Total.Text)) - Comision.Text) < FMCCurATX((valor_minimo.Text)) Then
        MsgBox " Valor inferior el monto mínimo. Verifique...", vbCritical, "Mensaje del Servidor"
        FLChequeos = False
        efe.SetFocus
        Exit Function
    End If
End If
'jg Fin RECMPS-223

If Me.txt_empresa.Text <> "9291" Then
  If VLTotCom <> FMCCurATX((Comision.Text)) Then
        MsgBox "Verifique el Campo Valor de Comision"
        Comision.SetFocus
        FLChequeos = False
        Exit Function
    End If
    
End If
  
  
FLChequeos = True
    Exit Function
Error:
FLChequeos = False

End Function

Sub PLTransmitir()

    If VGTipoEjecucion = CGNormal% Then
        If FLChequeos() = False Then
            Exit Sub
        End If
    End If
    obtenerCtaEmpresa
    
    If VGTipoEjecucion% <> CGReverso% Then 'msilvag RECMPS-26
        If FMCCurATX(efe) > 0 Or FMCCurATX(Cheques) > 0 Then
            If FLValidaConsep() = False Then
                Exit Sub
            End If
        End If
    End If  'msilvag RECMPS-26
    'JPM ContadorBillete -->
    If lectoraBill.HayAltaDenom Then
      If Not VGDatPersBillAltDen.dataOK Then
        MsgBox "Existen Billetes de Alta Denominación cuyos Número de Serie no se han confirmado", vbCritical, "Mensaje del Sistema"
        Exit Sub
      End If
    End If
    '<-- JPM ContadorBillete
    
    If txt_empresa.Text = "20717" Then
        If Not FLTransmitir_pago_CMA_MS() Then
            If (SGAcumulado + SGAcumuladoAdi) = 0 Then
                If Ref.Enabled = True Then
                    Ref.SetFocus
                End If
            End If
            Exit Sub
        End If
        ElseIf txt_empresa.Text = "22289" Then
                If Not FLTransmitir_pago_Marglobal() Then
            If (SGAcumulado + SGAcumuladoAdi) = 0 Then
                If Ref.Enabled = True Then
                    Ref.SetFocus
                End If
            End If
            Exit Sub
        End If

    Else
        If Not FLTransmitir_pago_Ecuaquimica() Then
            If (SGAcumulado + SGAcumuladoAdi) = 0 Then
                If Ref.Enabled = True Then
                    Ref.SetFocus
                End If
            End If
            Exit Sub
        End If
    End If
    
    imprimeComprobante 1, VG_cta_empresa_imp144
    If VGTipoEjecucion% <> CGReverso% Then
'        If MsgBox("Desea reimprimir el comprobante?", vbYesNo, "Mensaje") = vbYes Then
            imprimeComprobante 2, VG_cta_empresa_imp144
'        End If
    End If
    
    'Timbrado de Cheques
    timbradoCheque
    
    If SGAcumulado = 0 Then
        Form_KeyDown CGTeclaF2%, 0
    Else
        Form_KeyDown CGTeclaF2%, -1
    End If
    
End Sub
Sub obtenerCtaEmpresa()
  ReDim vcarreglo(50) As String
  'Obtenemos el Numero de CTA de la Empresa Ini
  PMInicioTransaccion

  PMPasoValores VGSqlConn&, "@t_trn", 0, SQLINT4, "3225"
  PMPasoValores VGSqlConn&, "@i_operacion", 0, SQLVARCHAR, "Q"
  PMPasoValores VGSqlConn&, "@i_empresa", 0, SQLINT4, txt_empresa.Text
  If FMTransmitirRPC(VGSqlConn&, ServerName$, "cob_pagos", "sp_tr_person_empresa", True, "") Then
    vtr% = FMMapeaArreglo(VGSqlConn&, vcarreglo())
    VLNom_Emp = vcarreglo(3)
    VLTipoCtaEmp = vcarreglo(7)
    VG_cta_empresa_imp144 = vcarreglo(8)
    PMChequea VGSqlConn&
  End If

  PMChequea VGSqlConn&
  PMFinTransaccion

End Sub


Sub imprimeComprobante(Opcion As Integer, Cuenta As String)
    SGActivaSum = True

    VGparformato$ = "01"
   If Not FMFormatPagina(VGparformato$, VGparlong$, VGpartop$, VGparleft$, VGparrig$) Then
      VGparlong$ = "66"
      VGpartop$ = "04"
      VGparleft$ = "20"
      VGparrig$ = "00"
   End If
     
   PMSetDetalle "v" + "Este pago sera procesado el " + VGFechaCorte144
   PMSetDetalle "v" + "Empresa: " + FMEspaciosATX(Trim(VG_empresa_imp144) + " " + Mid(Trim(VG_des_empresa_imp144), 1, 24), 28, CGJustificacionIzquierda)
   If Opcion = 1 Then
      PMSetDetalle "v" + "Cta. Emp.: " + FMEspaciosATX(Mid(Trim(Cuenta), 1, 10), 28, CGJustificacionIzquierda)
   Else
      PMSetDetalle "v" + "Cta. Emp.: " + FMEspaciosATX(Mid$(Cuenta, 1, 2) + "XXXXXX" + Mid$(Cuenta, 9, 2), 28, CGJustificacionIzquierda)
   End If
   PMSetDetalle "v" + "Codigo: " + Trim(VG_ref_imp144)
   PMSetDetalle "v" + "Nombre: " + Mid(UCase(VG_nombre_imp144), 1, 25)
'    PMSetDetalle "v" + "Valor de Pago: " + FMEspaciosATX(FMObtenerSimbolo("84") + Format(Me.Total.Text, VGFormatoMoney), 12, CGJustificacionDerecha) '+ Coms

   ef$ = ""
   If FMCCurATX((VG_efe_imp144)) > 0 Then
      'ef$ = "EFE. : " + FMEspaciosATX(FMObtenerSimbolo("144") + Format(VG_efe_imp144, VGFormatoMoney), 12, CGJustificacionDerecha) '+ "   "
      ef$ = "EFE. : " + FMEspaciosATX("", 6, 0) + FMEspaciosATX(FMObtenerSimbolo("144") + Format(VG_efe_imp144, VGFormatoMoney), 12, CGJustificacionDerecha) '+ "   "
   End If
   
   Chq$ = ""
   If FMCCurATX((VGCantChq)) > 0 Then
      'Chq$ = "CHQ. : " + FMEspaciosATX("(" + Trim(VGCantChq) + ")", 4, CGJustificacionIzquierda) + FMEspaciosATX(FMObtenerSimbolo("144") + Format(VGCheques, VGFormatoMoney), 12, CGJustificacionDerecha)
      Chq$ = "CHQ. : " + FMEspaciosATX("", 2, 0) + FMEspaciosATX("(" + Trim(VGCantChq) + ")", 4, CGJustificacionDerecha) + FMEspaciosATX(FMObtenerSimbolo("144") + Format(VGCheques, VGFormatoMoney), 12, CGJustificacionDerecha)
   End If
   
   If ef$ <> "" Or Chq$ <> "" Then
      PMSetDetalle "v" + ef$
      PMSetDetalle "v" + Chq$
   End If
   
    If VG_deb_imp144 <> "0.00" Then
        'PMSetDetalle "v" + "DEB. : " + FMEspaciosATX(FMObtenerSimbolo("144") + Format(Trim$(VG_deb_imp144), VGFormatoMoney), 12, CGJustificacionDerecha) + "   CTA.: " + Format(Trim$(VG_cta_imp144), "000-000000-0")
        PMSetDetalle "v" + "DEB. : " + FMEspaciosATX("", 6, 0) + FMEspaciosATX(FMObtenerSimbolo("144") + Format(Trim$(VG_deb_imp144), VGFormatoMoney), 12, CGJustificacionDerecha) + "   CTA.: " + Format(Trim$(VG_cta_imp144), "000-000000-0")
    End If
  
    VLNeto = FMCCurATX(VG_total144)
    PMSetDetalle "v" + "TOTAL: " + FMEspaciosATX("", 6, 0) + FMEspaciosATX(FMObtenerSimbolo("144") + Format(VLNeto, VGFormatoMoney), 12, CGJustificacionDerecha) '+ Coms
    
    If VLclave_acceso <> "" Then
        PMSetDetalle "v" + "Clave de Acceso/Autorizacion: "
        PMSetDetalle "v" + VLclave_acceso
    End If
   
    VGparleft$ = "10"
    VGpartop$ = "00"
    
   If VLTsnTemp% = 0 Then
      VLTsnTemp% = VGTSN%
   End If
   VLEtiqTrn = VGTrn144 + " " + "DEPOSITO ESPECIAL EN LINEA"
   'VLEtiqTrn = VGTrn144 + " " + "RECAUDACION EN LINEA"
   FMPRN_StdImpresion "IMPRESORA_1", False, CStr(VLTsnTemp%), "144", SGDatosDetalle, "Inserte papeleta", CStr(VGpartop$), 4, CStr(VGparleft$), , VLEtiqTrn, IIf(VGHorario_pago144 = "0", "", VGHorario_pago144), VGTrn144, , Trim$(str$(FMObtenerMonedaForma("144")))
 
End Sub

Public Sub PLReverso()
    'Sumadora ----->
    SGPrimeraVezRev = 0
    
    PMSetValorReverso txt_empresa, "@i_empresa"
    
    If Trim(txt_empresa.Text) = "9291" Then
        PMSetValorReverso txt_empresa, "@i_empresa"
        PMSetValorReverso txt_des_empresa, "@i_empname"
        PMSetValorReverso txt_campo, "@i_tipoConsulta"
        Select Case Trim(txt_campo.Text)
            Case "C"
                CboTipoID.ListIndex = 0
            Case "R"
                CboTipoID.ListIndex = 1
            Case "P"
                CboTipoID.ListIndex = 2
        End Select
        CboTipoID.Enabled = False
        PMSetValorReverso Ref, "@i_codigo"
        
        PMSetValorReverso efe, "@i_efectivo"
        PMSetValorReverso CantChq, "@i_cant_cheques"
        PMSetValorReverso Cheques, "@i_cheque"
        PMSetValorReverso Debito, "@i_debito"
        If Debito > 0 Then
            PMSetValorReverso NomCta, "@i_nombre_cta"
        End If
        PMSetValorReverso Total, "@i_total"
        PMSetValorReverso CboTipCta, "@i_tipo_cta"
        PMSetValorReverso Cta, "@i_cuenta"
        
        PMSetValorReverso Nombre, "@i_nombre_suscrip"
        PMSetValorReverso valor_pagar, "@i_valpagar"
        SGUsar = CDbl(efe.Text)
    'msilvag Inicio RECMPS-26
    'KBastida MS Reverso Ini
    ElseIf txt_empresa = "20717" Then
        PMSetValorReverso txt_empresa, "@e_convenio"
        PMSetValorReverso txt_des_empresa, "@i_empname"
        CboTipoID.Enabled = False
        PMSetValorReverso Ref, "@i_codigo"
        PMSetValorReverso Ref, "@e_concepto"
        
        PMSetValorReverso efe, "@e_efectivo"
        PMSetValorReverso CantChq, "@e_cant_cheques"
        PMSetValorReverso Cheques, "@e_cheque"
        PMSetValorReverso Debito, "@e_debito"
        If Debito > 0 Then
            PMSetValorReverso NomCta, "@e_nombre_cta"
            PMSetValorReverso CboTipCta, "@i_tipo_cta"
            PMSetValorReverso Cta, "@e_cuenta"
            PMSetValorReverso CboTipCta, "@e_tipocta"
        End If
        PMSetValorReverso Total, "@e_total"
        'If Cheques = "" Or efe = "" Then End If
        PMSetValorReverso Nombre, "@e_nombre"
        PMSetValorReverso valor_pagar, "@e_total"
        SGUsar = CDbl(efe.Text)
    ElseIf txt_empresa = "451" Then 'KBastida Marglobal
        txt_empresa = "22289"
        'PMSetValorReverso txt_empresa, "@i_empresa"
        PMSetValorReverso txt_des_empresa, "@i_empname"
        PMSetValorReverso txt_campo, "@i_tipoConsulta"
        VLTempEmpresa = txt_empresa
        cboTipoId.Clear
        cboTipoId.AddItem "CODIGO"
        cboTipoId.ListIndex = 0
        cboTipoId.Enabled = False
            
        PMSetValorReverso txt_campo, "@i_codigo"
        VLIdentificacion = Me.txt_campo.Text
        PMSetValorReverso Ref, "@i_num_doc"
        VLNumDocumento = Me.Ref.Text
            
        PMSetValorReverso txt_campo, "@i_ref_doc"
        If Me.txt_campo.Text = "S" Then
            Me.Check_Certificado.Value = "1"
        End If
        'comision
        PMSetValorReverso txt_campo, "@i_chq_com"
        VLChq_com = Me.txt_campo.Text
        PMSetValorReverso txt_campo, "@i_deb_com"
        VLDeb_com = Me.txt_campo.Text
        PMSetValorReverso txt_campo, "@i_efe_com"
        VLEfe_com = Me.txt_campo.Text
        PMSetValorReverso Comision, "@i_comision"

        PMSetValorReverso CboTipCta, "@i_tipo_cta"
        PMSetValorReverso Cta, "@i_cuenta"
        PMSetValorReverso efe, "@i_efectivo"
        PMSetValorReverso CantChq, "@i_cant_cheques"
        PMSetValorReverso Cheques, "@i_cheque"
        PMSetValorReverso Debito, "@i_debito"
        If Debito > 0 Then
            PMSetValorReverso NomCta, "@i_nombre_cta"
        End If
        PMSetValorReverso txt_campo, "@i_total"
        VLMonto = Me.txt_campo.Text
        'Me.Total.Text = VLMonto + CDbl(VLEfe_com)
        Me.Total.Text = VLMonto + CDbl(Comision)
            
        PMSetValorReverso Nombre, "@i_nombre_suscrip"
        PMSetValorReverso valor_pagar, "@i_valpagar"
        SGUsar = CDbl(efe.Text) + CDbl(VLEfe_com)
        VLTotCom = VLEfe_com + VLChq_com + VLDeb_com

    ElseIf VLTempEmpresa <> "20717" Or VLTempEmpresa <> "451" Then  'KBastida MS Reverso Fin
    
        'PMSetValorReverso txt_empresa, "@i_empresa"
        PMSetValorReverso txt_empresa, "@i_subempresa"
        PMSetValorReverso txt_des_empresa, "@i_empname"
        
        FPrincipal.Map.PMMapConfig "SHOWMESSAGE"
        
        'Verificar si la empresa pertenece a un grupo
        VLGrupo = ""
        PMChequea VGSqlConn&
        PMPasoValores VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "sv_grupo_empresas"
        PMPasoValores VGSqlConn&, "@i_tipo", 0, SQLCHAR, "V"
        PMPasoValores VGSqlConn&, "@i_codigo", 0, SQLVARCHAR, Trim$(Me.txt_empresa.Text)
        If FMTransmitirRPC(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "") Then
            PMMapeaVariableATX VGSqlConn&, VTDetalles$
            PMChequea VGSqlConn&
            VLGrupo = VTDetalles$
            PMChequea VGSqlConn&
        Else
            VLGrupo = ""
            PMChequea VGSqlConn&
        End If
        
        'Validar si permite reverso la empresa
        VLIndReverso = ""
        PMChequea VGSqlConn&
        PMPasoValores VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "sv_rev_atx_deplinea"
        PMPasoValores VGSqlConn&, "@i_tipo", 0, SQLCHAR, "V"
        PMPasoValores VGSqlConn&, "@i_codigo", 0, SQLVARCHAR, Trim$(Me.txt_empresa.Text)
        If FMTransmitirRPC(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "") Then
            PMMapeaVariableATX VGSqlConn&, VTDetalles$
            PMChequea VGSqlConn&
            VLIndReverso = VTDetalles$
            PMChequea VGSqlConn&
        Else
            VLIndReverso = ""
            PMChequea VGSqlConn&
        End If
        
        FMInitMap FPrincipal!pnlHelpLine, FPrincipal!pnlTransaccionLine, FPrincipal!Focos(0), FPrincipal!Focos(1), FPrincipal!Focos(2), FPrincipal!Focos(3), VGLogTransacciones$
        
        If VLIndReverso = "N" Or VLIndReverso = "" Then
            MsgBox "Empresa no tiene permitido realizar el reverso", vbInformation + vbOKOnly, "ATX"
            Exit Sub
        Else
            PMSetValorReverso txt_campo, "@i_tipoConsulta"
        
            CboTipoID.Clear
            CboTipoID.AddItem "CODIGO"
            CboTipoID.ListIndex = 0
            CboTipoID.Enabled = False
            
            PMSetValorReverso txt_campo, "@i_codigo"
            VLIdentificacion = Me.txt_campo.Text
            PMSetValorReverso Ref, "@i_num_doc"
            VLNumDocumento = Me.Ref.Text
            
            PMSetValorReverso txt_campo, "@i_ref_doc"
            If Me.txt_campo.Text = "S" Then
                Me.Check_Certificado.Value = "1"
            End If
            'comision
            PMSetValorReverso txt_campo, "@i_chq_com"
            VLChq_com = Me.txt_campo.Text
            PMSetValorReverso txt_campo, "@i_deb_com"
            VLDeb_com = Me.txt_campo.Text
            PMSetValorReverso txt_campo, "@i_efe_com"
            VLEfe_com = Me.txt_campo.Text
            PMSetValorReverso Comision, "@i_comision"

            PMSetValorReverso CboTipCta, "@i_tipo_cta"
            PMSetValorReverso Cta, "@i_cuenta"
            PMSetValorReverso efe, "@i_efectivo"
            PMSetValorReverso CantChq, "@i_cant_cheques"
            PMSetValorReverso Cheques, "@i_cheque"
            PMSetValorReverso Debito, "@i_debito"
            If Debito > 0 Then
                PMSetValorReverso NomCta, "@i_nombre_cta"
            End If
            
            
            If Trim(txt_empresa.Text) = "8462" Then
            
                PMSetValorReverso txt_campo, "@i_fecCont"
                VFecCont = Me.txt_campo.Text
                
                PMSetValorReverso txt_campo, "@i_tipDoc"
                VTipDoc = Me.txt_campo.Text
                
                PMSetValorReverso txt_campo, "@i_numDoc"
                VNumDoc = Me.txt_campo.Text
                
            End If
        
            
            
            PMSetValorReverso txt_campo, "@i_total"
            VLMonto = Me.txt_campo.Text
            Me.Total.Text = VLMonto + CDbl(VLEfe_com)
            
            PMSetValorReverso Nombre, "@i_nombre_suscrip"
            PMSetValorReverso valor_pagar, "@i_valpagar"
            SGUsar = CDbl(efe.Text) + CDbl(VLEfe_com)
            VLTotCom = VLEfe_com + VLChq_com + VLDeb_com
            
        End If
        
        
    End If
    'msilvag Fin
    
    
End Sub

Public Sub timbradoCheque()
  If FMCCurATX((Cheques.Text)) > 0 And VGTipoEjecucion% <> CGReverso% Then
    'IMPRESION DEL DETALLE DEL PAGO
    While MsgBox("Imprimir Cheque", vbYesNo) = vbYes
        PMInicioImpresion "IMPRESORA_1"
        PMBorrarDatosImpresion
        PMSetLineaImpresion "x" + "Inserte Cheque"
        PMSetLineaImpresion "<"
        PMSetLineaImpresion "!" & VGpartop$
        PMSetLineaImpresion "%N" & VGparleft$
        PMSetLineaImpresion "v" + "PARA DEPOSITAR EN LA CTA: " + VG_cta_empresa_imp144
        PMSetLineaImpresion "v" + "(" + txt_empresa.Text + ") " + Mid(VLNom_Emp, 1, 30)
        PMSetLineaImpresion ">"
        PMImprimir "IMPRESORA_1", False
        PMFinImpresion "IMPRESORA_1"
    Wend
  End If
End Sub

Function FLValidaConsep() As Boolean
    VLTrn = ""
    VLProcedure = ""
    VLBase = ""
        
    If VLTipoCtaEmp = "AHO" Then
        VLTipoCtaEmp = 4
        VLTrn = "4252"
        VLProcedure = "sp_ah_depositosl_rc"
        VLBase = "cob_ahorros"
    Else
        VLTipoCtaEmp = 3
        VLTrn = "3040"
        VLProcedure = "sp_tr_deposito_rc"
        VLBase = "cob_cuentas"
    End If
    
    FLValidaConsep = False
    
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_cta", 0, SQLVARCHAR, (VG_cta_empresa_imp144), "Cta", ""
    PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(FMObtenerMonedaForma("144")), "Moneda", ""
    PMPasoValoresATX VGSqlConn, "@i_efe", 0, SQLMONEY, (efe.Text), "Efe", "dpefectivo(D.general)N"
    PMPasoValoresATX VGSqlConn, "@i_loc", 0, SQLMONEY, (Cheques.Text), "Loc", "chlocales(D.general)N"
    VLMonto = FMCCurATX(efe.Text) + FMCCurATX(Cheques.Text)
    PMPasoValoresATX VGSqlConn, "@i_val", 0, SQLMONEY, Format$(VLMonto, "####,###,##0.00"), "TotalDepositado", "totaldepo(D.cob_cuentas)N"
    PMPasoValoresATX VGSqlConn, "@i_autoriza", 0, SQLCHAR, VGAutoriza, "Autorizacion", ""
    PMPasoValoresATX VGSqlConn, "@i_cant_chq", 0, SQLINT4, val(CantChq.Text), "CantChq", ""
    PMPasoValoresATX VGSqlConn, "@i_codigo", 0, SQLCHAR, (Ref.Text), "CodigoDep", ""
    PMPasoValoresATX VGSqlConn, "@i_ssn", 0, SQLINT4, (VGSecCaut), "SecAut", ""
    PMPasoValoresATX VGSqlConn, "@i_tipo_cta", 0, SQLVARCHAR, CStr(VLTipoCtaEmp), "TipoCta", ""
    PMPasoValoresATX VGSqlConn, "@i_impresora", 0, SQLVARCHAR, CStr(VGModeloImp), "Modelo Impr", ""
    PMPasoValoresATX VGSqlConn, "@o_nombre", 1, SQLVARCHAR, (Nombre.Text), "Nombre", ""
    PMPasoValoresATX VGSqlConn, "@o_impuesto", 1, SQLMONEY, CStr(VLMontoIcc), "oMontoIcc", ""
    If VLTipoCta = 4 Then  'Pholguiv 18Dic2014 ---Agregar Cta Basica
            PMPasoValoresATX VGSqlConn, "@i_cartola_new", 0, SQLCHAR, "N", "ConLib", ""
            PMPasoValoresATX VGSqlConn, "@o_neto", 1, SQLMONEY, "0", "0", ""
            PMPasoValoresATX VGSqlConn, "@o_sectrn", 1, SQLCHAR, "0", "SecTrn", ""
    Else
        PMPasoValoresATX VGSqlConn, "@o_neto", 1, SQLMONEY, "0", "0", ""
    End If
    PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, "0", "SecTrn", ""
    PMPasoValoresATX VGSqlConn, "@o_consulta", 1, SQLINT4, (VTIndicadorSum), "IndConAut", ""
    PMPasoValoresATX VGSqlConn, "@i_iden_dep", 0, SQLVARCHAR, Ref.Text, "ID Depositante.", ""
    PMPasoValoresATX VGSqlConn, "@i_val_consep", 0, SQLCHAR, "S", "ValConsep", ""


    If FMTransmitirRPCATX(VGSqlConn, "", VLBase, VLProcedure, True, "Transaccion Ok", "N", "N", "N", "144", "S", "S") = True Then
        FLValidaConsep = True
    Else
        FLValidaConsep = False
    End If
    PMChequeaATX VGSqlConn
    
End Function

'msilvag Inicio RECMPS-19
Private Sub txt_empresa_LostFocus()
    Masc_codigo.Text = ""
    Me.Masc_codigo.Visible = False
'    Me.Ref.Visible = True
    Ref.TabIndex = 2
    Masc_codigo.TabIndex = 3
    If Me.txt_empresa.Text = "9291" Then
        CboTipoID.Clear
        CboTipoID.AddItem "CEDULA"
        CboTipoID.AddItem "RUC"
        CboTipoID.AddItem "PASAPORTE"
        CboTipoID.ListIndex = 0
        Ref.MaxLength = 10
    Else
        CboTipoID.Clear
'       cboTipoId.AddItem "IDENTIFICACION"

        'jg Inicio RECMPS-272
        If Me.txt_empresa.Text = "8460" Or Me.txt_empresa.Text = "1348" Then
            CboTipoID.AddItem "CEDULA"
        Else
            CboTipoID.AddItem "CODIGO"
        End If
        'jg Fin RECMPS-272
        
        If Me.txt_empresa.Text = "20717" Then 'KBastida CMA
            Me.lblCobAlum.Caption = "Identificación"
        Else
            Me.lblCobAlum.Caption = "Código"
        End If
          
        CboTipoID.ListIndex = 0
        Ref.MaxLength = 20
        If Trim(Me.txt_empresa.Text) = "6930" Then
            Me.Masc_codigo.Visible = True
            Masc_codigo.Left = 1200
            Masc_codigo.TabIndex = 2
            Ref.TabIndex = 50
        Else
            Me.Masc_codigo.Visible = False
'            Me.Ref.Visible = True
            Ref.TabIndex = 2
            Masc_codigo.TabIndex = 3
        End If
    End If
End Sub
'msilvag Fin


Sub PLFactura()
  
                                    

 
    If Comision.Text > 0 And VLDeb_com = 0# Then
    Dim fr_secuencia As Long, fr_ssn As Long
    Dim fr_ced_ruc As String, fr_nombre As String, fr_fact_elect As String, fr_pto_estab As String, fr_pto_emis As String, _
        fr_fecha_validez As String, fr_nautorizacion As String, fr_valor As String, fr_iva As String, _
        fr_referencia As String, fr_servicio As String, nro_factura As String, fr_baseImp As String, fr_impresa As String, fr_fecha_ini_vig As String, fr_fecha_fin_vig As String
    Dim fr_descuento As String, fr_forma_pag As String, fr_porc_compensa As String, fr_porc_iva As String
    
    fr_ced_ruc = Replace(SGCedula, "_", "")     'Se obtiene de la pantalla de Comision
    fr_nombre = Trim(SGNombre)                  'Se obtiene de la pantalla de Comision
    fr_fact_elect = "S"
    fr_impresa = "S"
    
    fr_descuento = VGCompensacion
'    If fr_descuento > 0 Then
'        fr_valor = VGComision_original
'        If fr_valor = "0.00" Then
'            fr_valor = Comision.Text
'        End If
'    Else
        fr_valor = Comision.Text
'    End If
    fr_porc_iva = VGPorcentajeIVA
    fr_forma_pag = VGFormaPago
    fr_porc_compensa = VGPorcentajeComp

    
    fr_iva = VLiva
    fr_baseImp = VlbaseImp
    fr_referencia = (Trim(Ref))
    
    fr_servicio = "PAGO DEPOSITO EN LINEA"
    
    If VGTipoEjecucion% <> CGReverso% Then
       fr_ssn = CLng(SGSecTrn$)
            If FMFacturaRecaudacion("1", fr_secuencia, fr_ssn, fr_ced_ruc, fr_nombre, fr_fact_elect, _
                fr_pto_estab, fr_pto_emis, fr_fecha_validez, fr_nautorizacion, fr_valor, fr_iva, _
                fr_baseImp, fr_impresa, fr_referencia, fr_servicio, nro_factura, fr_fecha_ini_vig, fr_fecha_fin_vig, _
                fr_descuento, fr_forma_pag, fr_porc_compensa, fr_porc_iva) Then
    
                VLclave_acceso = fr_nautorizacion
                VLFecvenSRI = fr_fecha_validez
                VLSerie_Secuencia = nro_factura
                VLfact_elect = fr_fact_elect
                VLFecinivig = fr_fecha_ini_vig
                VLFecfinvig = fr_fecha_fin_vig
            End If
    Else
       fr_ssn = CLng(VGSSNCorr)
        VGTipoEjecucion% = CGNormal
        If Not FMFacturaRecaudacion("2", fr_secuencia, fr_ssn, fr_ced_ruc, fr_nombre, fr_fact_elect, _
            fr_pto_estab, fr_pto_emis, fr_fecha_validez, fr_nautorizacion, fr_valor, fr_iva, _
            fr_baseImp, fr_impresa, fr_referencia, fr_servicio, nro_factura, fr_fecha_ini_vig, fr_fecha_fin_vig) Then
            MsgBox "ERROR: En reverso de factura: " & CStr(fr_ssn)
        Else
            VLclave_acceso = fr_nautorizacion
        End If
        VGTipoEjecucion% = CGReverso
    End If
    End If
    
End Sub


