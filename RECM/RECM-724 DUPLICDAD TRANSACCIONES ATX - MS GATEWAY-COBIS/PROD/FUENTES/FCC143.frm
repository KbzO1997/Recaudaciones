VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "GRID32.OCX"
Object = "{0F1F1508-C40A-101B-AD04-00AA00575482}#1.0#0"; "mhrinp32.ocx"
Object = "{9AED8C43-3F39-11D1-8BB4-0000C039C248}#2.0#0"; "txtin.ocx"
Object = "{DECFDD03-1E4B-11D1-B65E-0000C039C248}#5.0#0"; "mskedit.ocx"
Begin VB.Form FCC143 
   BackColor       =   &H00C0C0C0&
   Caption         =   "RECARGAS PREPAGO"
   ClientHeight    =   6090
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4440
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   6090
   ScaleWidth      =   4440
   Begin VB.TextBox txtValor 
      Appearance      =   0  'Flat
      Enabled         =   0   'False
      Height          =   285
      Left            =   3600
      MaxLength       =   5
      TabIndex        =   10
      Top             =   1320
      Visible         =   0   'False
      Width           =   615
   End
   Begin VB.ComboBox CboTipoID 
      Enabled         =   0   'False
      Height          =   315
      ItemData        =   "FCC143.frx":0000
      Left            =   1440
      List            =   "FCC143.frx":000D
      Style           =   2  'Dropdown List
      TabIndex        =   21
      Tag             =   "CboProd"
      Top             =   4080
      Visible         =   0   'False
      Width           =   945
   End
   Begin VB.Frame Frame2 
      BackColor       =   &H00C0C0C0&
      Height          =   3135
      Left            =   120
      TabIndex        =   24
      Top             =   1700
      Width           =   4215
      Begin VB.TextBox NombreCliente 
         Appearance      =   0  'Flat
         Enabled         =   0   'False
         Height          =   285
         Left            =   1320
         TabIndex        =   23
         Top             =   2760
         Visible         =   0   'False
         Width           =   2775
      End
      Begin VB.TextBox Identificacion 
         Appearance      =   0  'Flat
         Enabled         =   0   'False
         Height          =   285
         Left            =   2280
         TabIndex        =   22
         Top             =   2400
         Visible         =   0   'False
         Width           =   1815
      End
      Begin MhinrelLib.MhRealInput MontoMax 
         Height          =   255
         Left            =   2640
         TabIndex        =   38
         Top             =   3240
         Width           =   1335
         _Version        =   65536
         _ExtentX        =   2355
         _ExtentY        =   450
         _StockProps     =   77
         TintColor       =   16711935
         CaretColor      =   -2147483642
      End
      Begin VB.ComboBox CboTipCta 
         Height          =   315
         ItemData        =   "FCC143.frx":001A
         Left            =   1320
         List            =   "FCC143.frx":001C
         Style           =   2  'Dropdown List
         TabIndex        =   14
         Tag             =   "CboProd"
         Top             =   840
         Width           =   1300
      End
      Begin VB.TextBox Nombre 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         Enabled         =   0   'False
         Height          =   285
         Left            =   1320
         Locked          =   -1  'True
         TabIndex        =   16
         Top             =   1200
         Width           =   2780
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
         Left            =   1320
         TabIndex        =   12
         ToolTipText     =   "Cantidad de Cheques"
         Top             =   540
         Width           =   495
         _Version        =   65536
         _ExtentX        =   873
         _ExtentY        =   503
         _StockProps     =   77
         Enabled         =   0   'False
         TintColor       =   16711935
         FillColor       =   16777215
         MinReal         =   0
         SpinChangeReal  =   0
         AutoHScroll     =   -1  'True
         CaretColor      =   -2147483642
         DecimalPlaces   =   0
         Separator       =   -1  'True
      End
      Begin MhinrelLib.MhRealInput efe 
         Height          =   285
         Left            =   1320
         TabIndex        =   11
         ToolTipText     =   "Valor en Efectivo"
         Top             =   240
         Width           =   2780
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
      Begin MhinrelLib.MhRealInput Cheques 
         Height          =   285
         Left            =   2760
         TabIndex        =   13
         ToolTipText     =   "Valor en Cheques"
         Top             =   540
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
         SpinChangeReal  =   0
         AutoHScroll     =   -1  'True
         CaretColor      =   -2147483642
         DecimalPlaces   =   2
         Separator       =   -1  'True
      End
      Begin MskeditLib.MaskInBox Cta 
         Height          =   285
         Left            =   2760
         TabIndex        =   15
         Tag             =   "Cta"
         Top             =   840
         Width           =   1335
         _Version        =   262144
         _ExtentX        =   2355
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
         Left            =   1320
         TabIndex        =   17
         Top             =   1500
         Width           =   2780
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
      Begin MhinrelLib.MhRealInput Comision 
         Height          =   285
         Left            =   1320
         TabIndex        =   19
         Top             =   2100
         Width           =   1050
         _Version        =   65536
         _ExtentX        =   1852
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
      Begin MhinrelLib.MhRealInput Total 
         Height          =   285
         Left            =   3000
         TabIndex        =   20
         ToolTipText     =   "Valor Total del Impuesto"
         Top             =   2100
         Width           =   1090
         _Version        =   65536
         _ExtentX        =   1923
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
         Left            =   1320
         TabIndex        =   18
         ToolTipText     =   "Valor Total del Impuesto"
         Top             =   1800
         Width           =   2780
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
      Begin MhinrelLib.MhRealInput MontoMin 
         Height          =   255
         Left            =   600
         TabIndex        =   37
         Top             =   3240
         Width           =   1095
         _Version        =   65536
         _ExtentX        =   1931
         _ExtentY        =   450
         _StockProps     =   77
         TintColor       =   16711935
         CaretColor      =   -2147483642
      End
      Begin VB.Label Etiqueta19 
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
         Left            =   120
         TabIndex        =   42
         Top             =   2760
         Visible         =   0   'False
         Width           =   720
      End
      Begin VB.Label Etiqueta18 
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Identificación:"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   210
         Left            =   120
         TabIndex        =   41
         Top             =   2400
         Visible         =   0   'False
         Width           =   1140
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
         TabIndex        =   36
         Top             =   1770
         Width           =   1215
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
         TabIndex        =   35
         Top             =   540
         Width           =   855
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
         Left            =   1920
         TabIndex        =   34
         Top             =   540
         Width           =   855
      End
      Begin VB.Label Etiqueta9 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
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
         TabIndex        =   33
         Top             =   240
         Width           =   720
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
         TabIndex        =   32
         Top             =   840
         Width           =   690
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
         TabIndex        =   31
         Top             =   1440
         Width           =   630
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
         TabIndex        =   30
         Top             =   1170
         Width           =   1065
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
         TabIndex        =   29
         Top             =   2100
         Width           =   825
      End
      Begin VB.Label Label1 
         Appearance      =   0  'Flat
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
         Left            =   2400
         TabIndex        =   28
         Top             =   2100
         Width           =   510
      End
   End
   Begin VB.Frame Frame1 
      BackColor       =   &H00C0C0C0&
      Height          =   1535
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   4215
      Begin VB.TextBox txt_nombreCliente 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   1440
         MaxLength       =   50
         TabIndex        =   50
         Top             =   960
         Visible         =   0   'False
         Width           =   2775
      End
      Begin VB.TextBox txt_contrato 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   1440
         MaxLength       =   13
         TabIndex        =   48
         Top             =   1200
         Visible         =   0   'False
         Width           =   2775
      End
      Begin VB.TextBox txt_celular 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   1320
         MaxLength       =   10
         TabIndex        =   8
         Top             =   900
         Visible         =   0   'False
         Width           =   1335
      End
      Begin VB.TextBox txt_cod_tar3 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   3600
         MaxLength       =   4
         TabIndex        =   7
         Top             =   1080
         Width           =   615
      End
      Begin VB.TextBox txt_cod_tar2 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   2000
         MaxLength       =   4
         TabIndex        =   6
         Top             =   900
         Width           =   615
      End
      Begin VB.TextBox txt_cod_tar1 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   1320
         MaxLength       =   4
         TabIndex        =   5
         Top             =   900
         Width           =   615
      End
      Begin VB.TextBox txtTemporal 
         Height          =   285
         Left            =   3480
         TabIndex        =   39
         Text            =   "Text1"
         Top             =   2000
         Width           =   735
      End
      Begin TxtinLib.TextValid txt_cod_servicio 
         Height          =   285
         Left            =   1320
         TabIndex        =   1
         ToolTipText     =   "Tipo de Servicio (F5 Ayuda)"
         Top             =   300
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
         TableName       =   "cl_serv_recarga"
         MinChar         =   0
         Error           =   0
      End
      Begin TxtinLib.TextValid txt_cod_empresa 
         Height          =   285
         Left            =   1320
         TabIndex        =   2
         ToolTipText     =   "Tipo de Empresa (F5 Ayuda)"
         Top             =   600
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
         TableName       =   ""
         MinChar         =   0
         Error           =   0
      End
      Begin TxtinLib.TextValid txt_monto_rec 
         Height          =   285
         Left            =   3360
         TabIndex        =   9
         ToolTipText     =   "Tipo de Monto (F5 Ayuda)"
         Top             =   840
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
         HelpLine        =   "Ingrese Tipo de Monto,  F5 Ayuda"
         Pendiente       =   ""
         Connection      =   -4908
         AsociatedLabelIndex=   0
         TableName       =   ""
         MinChar         =   0
         Error           =   0
      End
      Begin VB.Label lbl_nombre 
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
         Height          =   300
         Left            =   120
         TabIndex        =   49
         Top             =   1200
         Visible         =   0   'False
         Width           =   855
      End
      Begin VB.Label Label3 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Contrato:"
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
         Height          =   300
         Left            =   120
         TabIndex        =   47
         Top             =   960
         Visible         =   0   'False
         Width           =   855
      End
      Begin VB.Label Etiqueta21 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Monto:"
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
         Height          =   300
         Left            =   2760
         TabIndex        =   44
         Top             =   960
         Visible         =   0   'False
         Width           =   615
      End
      Begin VB.Label Etiqueta20 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Celular:"
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
         Height          =   300
         Left            =   120
         TabIndex        =   43
         Top             =   960
         Visible         =   0   'False
         Width           =   855
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
         Left            =   2000
         TabIndex        =   4
         Top             =   600
         Width           =   2100
      End
      Begin VB.Label txt_des_servicio 
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
         Left            =   2000
         TabIndex        =   3
         Top             =   300
         Width           =   2100
      End
      Begin VB.Label lblcodigo 
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
         Height          =   300
         Left            =   120
         TabIndex        =   27
         Top             =   1000
         Width           =   855
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
         Left            =   120
         TabIndex        =   26
         Top             =   650
         Width           =   855
      End
      Begin VB.Label lblservicio 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Servicio:"
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
         Top             =   300
         Width           =   765
      End
   End
   Begin MhinrelLib.MhRealInput decimal 
      Height          =   285
      Left            =   1320
      TabIndex        =   40
      ToolTipText     =   "Valor Total del Impuesto"
      Top             =   5160
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
      DecimalPlaces   =   0
      Separator       =   -1  'True
   End
   Begin MSGrid.Grid grdDetalle 
      Height          =   840
      Left            =   240
      TabIndex        =   45
      Top             =   4935
      Visible         =   0   'False
      Width           =   3855
      _Version        =   65536
      _ExtentX        =   6800
      _ExtentY        =   1482
      _StockProps     =   77
      BackColor       =   16777215
   End
   Begin VB.TextBox txtReverso 
      Height          =   285
      Left            =   4080
      TabIndex        =   46
      Text            =   "Text1"
      Top             =   240
      Visible         =   0   'False
      Width           =   255
   End
End
Attribute VB_Name = "FCC143"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'nchavezb 03/14/2011 NATALIA CHAVEZ
'NEMONICO 143: RECARGA DE PREPAGO DIRECTV
'TAREA: DTV-CU-1658
'********************************************************************************'
'*              MODIFICACIONES                                                  *'
'* REF  FECHA       AUTOR          DESCRIPCION                                  *'
'*  02  02/Oct/2017 Vanessa Miranda FACOFF-AP-SGC00029747-SGC00029748 Agregar   *'
'*      Clave de Acceso Facturación Electrónica Offline                         *'
'********************************************************************************'

Dim VLfirma As Boolean
Dim VLEmpresa As Integer
Dim MatrizPeaje(5, 5) As String
Dim VLCta As String
Dim VLTrn As String
Dim VLHorario As String
Dim VLautoriza As String
Dim VLCambio As Integer
Dim VLCodSerOK As Boolean
Dim VLMoneda As Integer
Dim VLDescMonCta As String
Dim VCodigo As String 'Guarda el codigo el numero de tarjeta inteligente de la recarga prepago
'Variables para factura
Dim VLTotCom As Currency
Dim VLEfe_com  As Currency
Dim VLChq_com As Currency
Dim VLDeb_com As Currency
Dim VLCta_com  As String
Dim VLTipCta_com As String
Dim VLCedula As String
Dim VLServicio As String
Dim VLImprCompComi As String
Dim VLFechaContable As String
Dim VLTsnTemporal As Integer

'MONTO MINIMO Y MAXIMO PARA RECARGA
Dim VLMontoMin As Currency
Dim VLMontoMax As Currency

'Variables de salida
Dim VLCodigoRespuesta As String
Dim VLNumeroSerie As String
Dim VLMonto As Currency
Dim VLPreAutorizacion As String
Dim VLCodAutorizacion As String
Dim VLSerie_Secuencia As String
Dim VLNombSuscr As String

Dim VLautoriSri As String
Dim VLFecvenSRI As String
Dim VLIdComercio As Integer

Dim valor_pagar As Currency
Dim VLFecinivig As String       'sme 06/08/2011
Dim VLFecfinvig As String       'sme 06/08/2011
Dim VLIdentificacion As String  'DAPV 09/13/2011
Dim VLtCTA As String 'DAPV - 09/14/2011
Dim VLNoVenta As String 'DAPV - 09/14/2011
Dim VLiva As Currency 'DAPV - 09/14/2011
Dim VLice As Currency 'DAPV - 09/14/2011
Dim VLNeto As Currency 'DAPV - 09/14/2011
Dim VLfechasta   As String 'DAPV - 09/14/2011
Dim VLfecdesde As String 'DAPV - 09/14/2011
Dim VLResolucion As String 'DAPV - 09/20/2011
Dim VLRucEmpresa As String 'DAPV - 09/20/2011
Dim VLDireccion As String 'DAPV - 09/20/2011
Dim VLRazon As String 'DAPV - 09/20/2011
Dim Vl_Ind_Efe As Integer 'DAPV - 09/20/2011
Dim VLTipoDocBroad As String 'DAPV - 18/OCT/2011
Dim VLminMovi As Currency 'DAPV - 19/OCT/2011
Dim VLmaxMovi As Currency 'DAPV - 19/OCT/2011
Dim vlrucbroadnet As String 'DAPV - 19/OCT/2011
Dim VLfecdesdeB As String   'DAPV - 08/Nov/2011
Dim VLfechastaB   As String  'DAPV - 08/Nov/2011
Dim VLautprov As String 'DAPV - 08/Nov/2011
Dim vlrazonb As String 'DAPV - 08/Nov/2011
Dim vl_direc1 As String 'DAPV - 08/Nov/2011
Dim vl_direc2 As String 'DAPV - 08/Nov/2011
Dim vl_telefono As String 'DAPV - 08/Nov/2011
Dim VGFechaProceso2 As String    'sme 09/20/2011
Dim VLDireccion1 As String 'DAPV - 11/Jul/2012
Dim VLDireccion2 As String 'DAPV - 11/Jul/2012
Dim VLDireccion3 As String 'DAPV - 11/Jul/2012
Dim VlbaseImp As Currency 'dpereirv
Dim vl_servidor_BUS As String  'Migracion SOA msilvag
Dim vtmatrizcps(2, 60) As String
Dim VLclave_acceso As String 'ref02 vmirandt

Dim VLautoriza2 As String
'msilvag Inicio
Dim VLProcesoClaro As String
Dim VLTerminalClaro As String
Dim VLOperacionClaro As String
Dim VLConsumerClaro As String
Dim VLTrxPago As String
Dim VLFechaPago As String
Dim VLHoraPago As String
Dim VLTerminalPago As String
Dim VLImportePago As String

'msilvag Fin

Private Sub CantChq_KeyPress(KeyAscii As Integer)
If CGTeclaENTER = KeyAscii% Then
        SendKeys "{TAB}"
  End If
End Sub

Private Sub CboTipCta_Click() 'DAPV - 09/14/2011
    VLtCTA = CboTipCta.Text
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
'INI DAPV - 09/12/2011 - Recargas Claro
VLIdentificacion = cboTipoId.Text
If VGTipoEjecucion% <> CGReverso% Then
    Identificacion.Text = ""
    Select Case VLIdentificacion
        Case "C"
            Identificacion.MaxLength = 10
        Case "R"
            Identificacion.MaxLength = 13
        Case "P"
            Identificacion.MaxLength = 20
    End Select
End If
'FIN DAPV - 09/12/2011 - Recargas Claro
End Sub

Private Sub CboTipoID_KeyDown(KeyCode As Integer, Shift As Integer)
'INI DAPV - 09/12/2011 - Recargas Claro
Select Case KeyCode%
    Case CGTeclaENTER%
        SendKeys "{TAB}"
    Case CGTeclaUP%, CGTeclaREPAG%
        SendKeys "+{TAB}"
    Case CGTeclaDOWN%, CGTeclaAVPAG%
        Identificacion.SetFocus
    End Select
'FIN DAPV - 09/12/2011 - Recargas Claro
End Sub

Private Sub Cheques_KeyPress(KeyAscii As Integer)
If CGTeclaENTER = KeyAscii% Then
        SendKeys "{TAB}"
   
  End If
End Sub

Private Sub Cheques_LostFocus()
If Cheques.Text <> "" Or Cheques.Text <> "0.00" Then
           valor.Text = str(FMCCurATX((efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((Debito.Text)))
           Total.Text = str(FMCCurATX((valor.Text)) + FMCCurATX((Comision.Text)))
End If
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
           SGNombre = ""
           SGValida = "S"
     
           VLAcumulado = SGAcumulado
           VGUsar15 = efe.ValueReal
           SGUsar = VLEfe_com
           
           'msilvag RECA-CC-SGC00027998
           'SGEmpresa = "120"
           If Me.txt_cod_empresa = "120" Then
                SGNumCuenta = FCC143.Cta.Text 'ClipText
           End If
           'msilvag Fin
           
           'jrocafuf
           If Me.txt_cod_empresa = "8461" Then
                SGNumCuenta = FCC143.Cta.Text 'ClipText
           End If
           
           
           
           SGComision = Comision
           SGTipoCta = FCC143.CboTipCta.ListIndex
           'SGCedula = cedula.ClipText
           
           FCC112.Show 1
           VLEfe_com = FCC112.VLEfe_com
           VLChq_com = FCC112.VLChq_com
           VLDeb_com = FCC112.VLDeb_com
           VLTipCta_com = FCC112.VLTipCta_com
           VLCta_com = FCC112.VLCta_com
           VLCedula = SGCedula
           VLNombre_com = SGNombre
           VLTotCom = VLEfe_com + VLChq_com + VLDeb_com
           
           'msilvag Inicio RECA-CC-SGC00027895
            If Me.txt_cod_empresa = "120" Then
                If VLTotCom > 0 And VLDeb_com > 0 Then
                    Comision.Text = VLTotCom
                    Total.Text = CCur(Me.valor.Text) + CCur(Comision)
                End If
            End If
            'msilvag Fin
            
           SGUsar = VGUsar15
           efe.ValueReal = SGUsar
           
           SGAcumulado = VLAcumulado
           VGUsar15 = VLEfe_com
      End If
  End If
  
  If KeyCode% = CGTeclaENTER% Then
      SendKeys "{TAB}"
  End If
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
Dim VLMoneda2 As Integer
Dim temp_tipo_cta As Integer 'DAPV - 08/Nov/2011

    If Me.txt_cod_servicio.Text = "1" Or Me.txt_cod_servicio.Text = "3" Then 'TELEVISOR 'DAPV - 08/Nov/2011
     VLfirma = FMValidaFirma(VLfirma, CboTipCta.Text, Cta, "143", Nombre, VLMoneda, VLDescMonCta)
     VTipoDatoCta = LoNombreCta(CboTipCta.Text, Cta.ClipText, "143")
     Nombre.Text = VTipoDatoCta.NombreCta
        If Trim(Nombre.Text) = "" Then Exit Sub
            If VLfirma = True Then
            Me.Debito.Enabled = True
            Me.Debito.SetFocus
        End If
    
        If SGMonedaTran <> VLMoneda And Trim(Cta.ClipText) <> "" Then 'si cta es vacio esta vacio, moneda = 0
            SGMonedaTran = VLMoneda
            PMCargaIniSumadora VLMoneda
            PMIniciaIngreso 1
        End If
    End If
       
'INI DAPV - 09/13/2011 - Recargas Claro
If Me.txt_cod_servicio.Text = "2" Then 'CELULARES --DAPV
    If Me.txt_cod_empresa.Text = "39" Then 'CLARO
        If Cta.ClipText <> "" Then
            If VLtCTA = "AHO" Then
                temp_tipo_cta = 4
            Else
                temp_tipo_cta = 3
            End If
                If FMValidaCuenta(temp_tipo_cta, Cta, "143") Then
                    PMInicioTransaccion
                    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, "4009", "trn", ""
                    PMPasoValoresATX VGSqlConn, "@i_cta", 0, SQLVARCHAR, (Cta.ClipText), "cta", ""
                    PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, CStr(VGmoneda), "mon", ""
                    PMPasoValoresATX VGSqlConn, "@i_cerrada", 0, SQLCHAR, "C", "cer", ""
                    PMPasoValoresATX VGSqlConn, "@i_tipocta", 0, SQLVARCHAR, VLtCTA, "nombre", ""
                    PMPasoValoresATX VGSqlConn, "@o_cedula", 1, SQLVARCHAR, "0", "cedula", ""
                    PMPasoValoresATX VGSqlConn, "@o_nombre", 1, SQLVARCHAR, "0", "nombre", ""
                    If FMTransmitirRPCATX(VGSqlConn, "", "cob_ahorros", "sp_query_ced_cuentas", True, " Ok... Cuenta " & "[" & Cta.Text & "]", "S", "N", "N", "143", "S", "S") Then
                        If Me.txt_cod_empresa.Text <> "" Then
                            Identificacion.MaxLength = 13
'                            Identificacion.Text = FMRetParamATX(VGSqlConn, 2)
                            Nombre.Text = FMRetParamATX(VGSqlConn, 1)
                        End If
                        PMChequeaATX VGSqlConn
                        Identificacion.Enabled = False
                        NombreCliente.Enabled = False
                        Me.cboTipoId.Enabled = False
                    Else
                        Cta.Text = FMMascara("", "###-######-#")
                        If txt_cod_empresa.Text <> "" Then
                            NombreCliente.Text = ""
                            Identificacion.Text = ""
                        End If
                        Cta.SetFocus
                        PMFinTransaccion
                        Exit Sub
                    End If
                        PMFinTransaccion
                Else
                    Cta.Text = FMMascara("", "###-######-#")
                    If txt_cod_empresa.Text <> "" Then
                        NombreCliente.Text = ""
                        Identificacion.Text = ""
                    End If
                    Cta.SetFocus
                    Exit Sub
                End If
            Else
                If txt_cod_empresa.Text <> "" Then
'                    Identificacion.Enabled = True
'                    NombreCliente.Enabled = True
                    CboTipCta.Enabled = True
'                    CboTipoID.Enabled = True
                End If
                CboTipCta.Enabled = True
                If txt_cod_empresa.Text <> "" Then
                    NombreCliente.Text = ""
                    Identificacion.Text = ""
                    Identificacion.MaxLength = 10
                End If
        
            End If
            
        End If 'FIN CLARO -DAPV
             
            If VGTipoEjecucion% <> CGReverso% Then  'Muestra las Firma del Cliente
              VLfirma = FMValidaFirma(VLfirma, CboTipCta.Text, Cta, "143")
            End If
End If
'FIN DAPV - 09/13/2011 - Recargas Claro
  
End Sub

Private Sub Debito_KeyDown(KeyCode As Integer, Shift As Integer)
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

Private Sub Debito_LostFocus()
If Debito.Text <> "" Or Debito.Text <> "0.00" Then
           valor.Text = str(FMCCurATX((efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((Debito.Text)))
           Total.Text = str(FMCCurATX((valor.Text)) + FMCCurATX((Comision.Text)))
End If
End Sub

Sub Efe_Change()
  VLCambio% = True
End Sub

Private Sub Efe_GotFocus()
 FPrincipal!pnlHelpLine.Caption = "Valor en Efectivo"
      'Sumadora ----->
    If SGActivaSum = False Then
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
    Case CGTeclaENTER%
      SendKeys "{TAB}"
    Case CGTeclaMAS%
      efe.Text = FMCalculadora(FMObtenerTitulo("143") + "Efectivo:", 14, "143")
      SendKeys "{TAB}"
    Case CGTeclaPOR%
      efe.Text = FMSumadora(FMObtenerTitulo("143") + "Efectivo:", 14, "143")
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
    Case CGTeclaUP%, CGTeclaREPAG%
      Tipo.SetFocus
    Case CGTeclaDOWN%, CGTeclaAVPAG%
      SendKeys "{TAB}"
  End Select
End Sub

Private Sub Efe_KeyPress(KeyAscii As Integer)
KeyAscii = FMValidarNumero((efe.Text), VGLongitudMoney, KeyAscii, "143")
End Sub

Private Sub Efe_LostFocus()
If SGActivaSum = True Then
   Exit Sub
  End If
  
  If VGDecimales$ = "S" And (FMObtenerDecimales(FMObtenerMonedaForma("143")) > 0) Then
    efe.Text = str(FMCCurATX((efe.Text)) / FMObtenerFactorDecimal(FMObtenerMonedaForma("143")))
  End If
  
    If efe.Text <> "" Or efe.Text <> "0.00" Then
           valor.Text = str(FMCCurATX((efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((Debito.Text)))
           Total.Text = str(FMCCurATX((valor.Text)) + FMCCurATX((Comision.Text)))
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

Private Sub Form_Activate()
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
    
    'msilvag Inicio
    VGFormaPago = ""
    VGCom_aux = 0
    VGComision_original = 0
    VGCompensacion = 0
    VGPorcentajeComp = "0"
    VGPorcentajeIVA = "0"
    'msilvag Fin
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
    If Shift = CGTeclaCTRL% + CGTeclaALT% And KeyCode% = CGTeclaF9% Then
        PMObtenerMonedaForma "143"
        Exit Sub
    End If
    If Shift = CGTeclaCTRL% And KeyCode% = CGTeclaI% Then
        PMReimpresion
        Exit Sub
    End If
    If Shift = CGTeclaCTRL% And KeyCode% = CGTeclaF2% Then
        If VGTipoEjecucion% = CGNormal% Then
            PMSetEjecucionReverso
            If FMSupervisor("143") = True Then
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
        VlbaseImp = 0
        VLiva = 0
        txt_cod_servicio.Text = ""
        txt_des_servicio.Caption = ""
        'msilvag Inicio RECA-CC-SGC00027998
        SGEmpresa = ""
        SGNumCuenta = ""
        
        VGFormaPago = ""
        VGCom_aux = 0
        VGComision_original = 0
        VGCompensacion = 0
        VGPorcentajeComp = "0"
        VGPorcentajeIVA = "0"
        'msilvag Fin
        Limpiar_Forma 'DAPV - 09/12/2011 - Recargas Claro
    Case CGTeclaF3%
        'Sumadora ------>
        If VGTipoEjecucion% <> CGReverso% Then
            If (VGTipoConsAutom% = 1 And VGStatusCon = "A") Or VGTipoConsAutom% = 0 Then
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
            If FMSupervisor("143") = True Then
                VGAutoriza = "S"
            End If
        End If
    End Select
End Sub

Private Sub Form_Load()
   'Inicializar pantalla
    VLfirma = False
    VLCodSerOK = False
    'Sumadora  ----->
    SGUsar = 0
    SGActivaSum = False
    SGActual = 1
    '<-----
    VLTotCom = 0#
    VLEfe_com = 0#
    VLChq_com = 0#
    VLDeb_com = 0#
    VLCta_com = ""
    VLTipCta_com = ""
    VCodigo = ""
    VLCta = ""
    VLMonto = 0
    'Inicio Moneda cuenta
    VLMoneda = VGmoneda%
      
    VLCambio% = False
    'Me.Move VGLeft%, VGTop%, 4590, 4680
    Me.Move VGLeft%, VGTop%, 4590, 5100 'DAPV - 09/12/2011 - Recargas Claro
    Frame2.Height = "2500" 'DAPV - 09/12/2011 - Recargas Claro
    FCC143.Height = "4600" 'DAPV - 09/12/2011 - Recargas Claro
    cboTipoId.ListIndex = 0 'DAPV - 09/12/2011 - Recargas Claro
    
    CboTipCta.AddItem "CTE"
    CboTipCta.AddItem "AHO"
    CboTipCta.ListIndex = 0
    efe.DecimalPlaces = FMObtenerDecimales(VGmoneda%)
    Cheques.DecimalPlaces = FMObtenerDecimales(VGmoneda%)
    
    'msilvag Inicio
    VGFormaPago = ""
    VGCom_aux = 0
    VGComision_original = 0
    VGCompensacion = 0
    VGPorcentajeComp = "0"
    VGPorcentajeIVA = "0"
    'msilvag Fin
    
    If VGTipoLogon% = CGNormal% Then
        
        'Llamar catalogo de servicio y empresa
        txt_cod_servicio.Connection = VGMap
        Set txt_cod_servicio.AsociatedLabel = txt_des_servicio
        txt_cod_servicio.Enabled = True
        
        txt_cod_empresa.Connection = VGMap 'DAPV - 08/Nov/2011
        Set txt_cod_empresa.AsociatedLabel = txt_des_empresa
        txt_cod_empresa.Enabled = True
        
        txt_monto_rec.Connection = VGMap 'DAPV - 08/Nov/2011
         
    End If
    
       
    Call GpParametro 'DAPV - 09/14/2011
    
    If VGTipoEjecucion% = CGReverso% Then
      'Sumadora ----->
      SGPrimeraVezRev = 0
      '<----------
       PMSetValorReverso txtReverso, "@i_empresa"
       VLEmpresa = txtReverso.Text
      Select Case VLEmpresa
            Case 120:
                     Etiqueta18.Visible = False
                     Etiqueta19.Visible = False
                     Etiqueta20.Visible = False
                     txt_celular.Visible = False
                     Etiqueta21.Visible = False
                     txt_monto_rec.Visible = False
                     txtValor.Visible = False
                     cboTipoId.Visible = False
                     Identificacion.Visible = False
                     NombreCliente.Visible = False
                     txt_cod_tar3.Visible = True
                     txt_cod_tar2.Visible = True
                     txt_cod_tar1.Visible = True
                     Frame2.Height = "2500"
                     FCC143.Height = "4600"
                     PMSetValorReverso txt_cod_servicio, "@i_servicio"
                     PMSetValorReverso txt_cod_empresa, "@i_empresa"
                     PMSetValorReverso txt_des_empresa, "@i_des_empresa"
                     PMSetValorReverso txt_des_servicio, "@i_des_servicio"
                    'Numero de tarjeta inteligente
                     PMSetValorReverso txtTemporal, "@i_Codigo"
                     VCodigo = txtTemporal.Text
                     txt_cod_tar1 = Trim$(Mid$(txtTemporal, 1, 4))
                     txt_cod_tar2 = Trim$(Mid$(txtTemporal, 5, 4))
                     txt_cod_tar3 = Trim$(Mid$(txtTemporal, 9, 4))
                     txt_cod_tar1.Enabled = False
                     txt_cod_tar2.Enabled = False
                     txt_cod_tar3.Enabled = False
                     PMSetValorReverso efe, "@i_efectivo"
                     PMSetValorReverso CantChq, "@i_cant_cheques"
                     PMSetValorReverso Cheques, "@i_cheque"
                     PMSetValorReverso valor, "@i_subtotal"
                     PMSetValorReverso CboTipCta, "@i_tipo_cta"
                     PMSetValorReverso Cta, "@i_cuenta"
                     VLCta_com = Cta.ClipText
                     PMSetValorReverso Total, "@i_total"
                     PMSetValorReverso Debito, "@i_debito"
                     'msilvag Inicio RECA-CC-SGC00028146
                     If Me.Debito.Text > 0 Then
                        PMSetValorReverso Nombre, "@i_nombre_cta"
                     End If
                     'msilvag Fin
                     'Valores de Comision
                     PMSetValorReverso Comision, "@i_comision_efe"
                     VLEfe_com = Comision.ValueReal
                     PMSetValorReverso Comision, "@i_comision_chq"
                     VLChq_com = Comision.ValueReal
                     'msilvag Inicio RECA-CC-SGC00028146
                     PMSetValorReverso Comision, "@i_comision_db"
                     VLDeb_com = Comision.ValueReal
                     'msilvag Fin
                     VLTotCom = VLEfe_com + VLChq_com + VLDeb_com  'msilvag RECA-CC-SGC00028146
                     Comision = VLTotCom
                     'Codigo de autorizacion
                     PMSetValorReverso txtTemporal, "@o_Cod_Pre_Autorizacion"
                     VLPreAutorizacion = txtTemporal.Text
                     PMSetValorReverso txtTemporal, "@o_cod_autorizacion"
                     VLCodAutorizacion = txtTemporal.Text
                     PMSetValorReverso txtTemporal, "@o_nombre_suscrip"
                     VLNombSuscr = txtTemporal.Text
                     txt_monto_rec.Visible = False
        Case 103:
                    txt_cod_servicio.Text = 2
                    txt_des_servicio.Caption = "CELULAR"
                    Etiqueta18.Visible = True
                    Etiqueta19.Visible = True
                    Etiqueta20.Visible = True
                    txt_celular.Visible = True
                    Etiqueta21.Visible = True
        
                    cboTipoId.Visible = True
                    Identificacion.Visible = True
                    NombreCliente.Visible = True
                    txt_cod_tar3.Visible = False
                    txt_cod_tar2.Visible = False
                    txt_cod_tar1.Visible = False
                    Frame2.Height = "3100"
                    FCC143.Height = "5200"
                    Identificacion.Enabled = True
                    NombreCliente.Enabled = True
                    Me.cboTipoId.Enabled = True
                    txt_monto_rec.Enabled = True
                    txtValor.Visible = True
                    

                    PMSetValorReverso txt_cod_empresa, "@i_empresa"
                    txt_des_empresa.Caption = "MOVISTAR ACTV. MINUTOS"
                    PMSetValorReverso Me.txt_celular, "@i_telefono"
                    PMSetValorReverso Me.txtReverso, "@i_tipo_id"
 
                    Select Case txtReverso.Text
                          Case "C"
                              PMSetValorReverso Me.Identificacion, "@i_ced_ruc"
                              Me.cboTipoId.ListIndex = 0
                          Case "R"
                              PMSetValorReverso Me.Identificacion, "@i_ced_ruc"
                              cboTipoId.ListIndex = 1
                          Case "P"
                              PMSetValorReverso Me.Identificacion, "@i_pasaporte"
                              cboTipoId.ListIndex = 2
                    End Select
                    If Mid(Identificacion.Text, 1, 3) = "000" Then
                    Identificacion.Text = Mid(Identificacion.Text, 4, Len(Identificacion.Text))
                    End If
                    Me.txtReverso.Text = ""
                    PMSetValorReverso Me.Cta, "@i_cuenta"
                    PMSetValorReverso Me.txtReverso, "@i_tipo_id"
                    Select Case Me.txtReverso.Text
                          Case "CTE"
                              CboTipCta.ListIndex = 0
                          Case "AHO"
                              CboTipCta.ListIndex = 1
                    End Select
                    txtReverso.Text = ""
                    PMSetValorReverso Me.efe, "@i_val"
                    PMSetValorReverso Me.Debito, "@i_debito"
                    PMSetValorReverso Me.NombreCliente, "@i_nombre"
                    PMSetValorReverso Me.txtValor, "@i_total"
                    PMSetValorReverso Me.Total, "@i_total"
                    PMSetValorReverso valor, "@i_total"

                    PMSetValorReverso Me.CantChq, "@i_cant_chq"
                    PMSetValorReverso Me.Cheques, "@i_cheque"
                    cboTipoId.Enabled = False
                    txt_cod_empresa.Enabled = False
                    CboTipCta.Enabled = False
                    txt_cod_servicio.Enabled = False
        Case 8461:
                    
                    
                    PMSetValorReverso txt_cod_servicio, "@i_servicio"
                    PMSetValorReverso txt_cod_empresa, "@i_empresa"
                    PMSetValorReverso txt_des_empresa, "@i_des_empresa"
                    PMSetValorReverso txt_des_servicio, "@i_des_servicio"
                    PMSetValorReverso Me.txt_nombreCliente, "@i_nom_cliente"
                    PMSetValorReverso Me.txt_contrato, "@i_codigo"
                    
                    PMSetValorReverso txt_celular, "@o_trx_pago"
                    VLTrxPago = txt_celular.Text
                    PMSetValorReverso txt_celular, "@o_fecha_pago"
                    VLFechaPago = txt_celular.Text
                    PMSetValorReverso txt_celular, "@o_hora_pago"
                    VLHoraPago = txt_celular.Text
                    PMSetValorReverso txt_celular, "@o_terminal_pago"
                    VLTerminalPago = txt_celular.Text
                    PMSetValorReverso txt_celular, "@o_importe"
                    VLImportePago = txt_celular.Text
                    
                    
                    
'                    VLFechaPago = NombreCliente.Text
'                    VLHoraPago = txt_cod_tar2.Text
'                    VLTerminalPago = txt_cod_tar3.Text
'                    VLImportePago = txt_celular.Text
'
                    
                    PMSetValorReverso efe, "@i_efectivo"
                    PMSetValorReverso CantChq, "@i_cant_cheques"
                    PMSetValorReverso Cheques, "@i_cheque"
                    PMSetValorReverso valor, "@i_subtotal"
                    PMSetValorReverso CboTipCta, "@i_tipo_cta"
                    PMSetValorReverso Cta, "@i_cuenta"
                    VLCta_com = Cta.ClipText
                    PMSetValorReverso Total, "@i_total"
                    PMSetValorReverso Debito, "@i_debito"
                    
                    If Me.Debito.Text > 0 Then
                       PMSetValorReverso Nombre, "@i_nombre_cta"
                    End If
                    
                    'Valores de Comision
                    PMSetValorReverso Comision, "@i_comision_efe"
                    VLEfe_com = Comision.ValueReal
                    PMSetValorReverso Comision, "@i_comision_chq"
                    VLChq_com = Comision.ValueReal
                    PMSetValorReverso Comision, "@i_comision_db"
                    VLDeb_com = Comision.ValueReal
                    VLTotCom = VLEfe_com + VLChq_com + VLDeb_com  'msilvag RECA-CC-SGC00028146
                    Comision = VLTotCom
                    
                    Etiqueta18.Visible = False
                    Etiqueta19.Visible = False
                    Etiqueta20.Visible = False
                    txt_celular.Visible = False
                    Etiqueta21.Visible = False
                    txt_monto_rec.Visible = False
                    txtValor.Visible = False
                    cboTipoId.Visible = False
                    Identificacion.Visible = False
                    NombreCliente.Visible = False
                    txt_cod_tar3.Visible = False
                    txt_cod_tar2.Visible = False
                    txt_cod_tar1.Visible = False
                    Me.Label3.Visible = True
                    Me.txt_contrato.Visible = True 'jrocafuf
                    Me.lbl_nombre.Visible = True 'jrocafuf
                    Me.txt_nombreCliente.Visible = True 'jrocafuf
            
                    Frame1.Height = "1535"
                    Frame2.Height = "3100"
                    FCC143.Height = "4800"
                    
                    SGUsar = CDbl(efe.Text) + CDbl(VLEfe_com)
            
            End Select
      
      SGUsar = CDbl(efe.Text) + CDbl(VLEfe_com) 'por reverso sumadora
    End If

End Sub

Private Sub Form_Unload(Cancel As Integer)
  VGUsar15 = 0
  PMCerrarForma "143"
End Sub

Private Sub Identificacion_KeyDown(KeyCode As Integer, Shift As Integer)
'INI -DAPV - 09/12/2011 - Recargas Claro
Select Case KeyCode%
      Case CGTeclaSUPR%
         Identificacion.Text = ""
      Case CGTeclaENTER%
         SendKeys "{TAB}"
      Case CGTeclaUP%, CGTeclaREPAG%
         cboTipoId.SetFocus
      Case CGTeclaDOWN%, CGTeclaAVPAG%
         SendKeys "{TAB}"
End Select
'FIN -DAPV - 09/12/2011 - Recargas Claro
End Sub

Private Sub Identificacion_KeyPress(KeyAscii As Integer)
'INI -DAPV - 09/12/2011 - Recargas Claro
    KeyAscii% = Asc(Chr$(KeyAscii%))
    If Me.cboTipoId.Text = "P" Then
        If (KeyAscii% <> 8) And (KeyAscii% < 65 Or KeyAscii% > 90) And _
        (KeyAscii% < 48 Or KeyAscii% > 57) And (KeyAscii% < 97 Or KeyAscii% > 122) Then
            KeyAscii% = 0
        End If
    Else
         If Not (KeyAscii% = 8 Or KeyAscii% = 13 Or (KeyAscii% >= 48 And KeyAscii% <= 57)) Then
            KeyAscii% = 0
        End If
    End If
'FIN -DAPV - 09/12/2011 - Recargas Claro
End Sub

Private Sub lbl_contrato_Click()

End Sub

Private Sub Label2_Click()

End Sub

Private Sub NombreCliente_KeyDown(KeyCode As Integer, Shift As Integer)
'INI -DAPV - 09/12/2011 - Recargas Claro
Select Case KeyCode%
      Case CGTeclaSUPR%
         NombreCliente.Text = ""
      Case CGTeclaENTER%
         SendKeys "{TAB}"
      Case CGTeclaUP%, CGTeclaREPAG%
         Identificacion.SetFocus
      Case CGTeclaDOWN%, CGTeclaAVPAG%
         SendKeys "{TAB}"
End Select
'FIN -DAPV - 09/12/2011 - Recargas Claro
End Sub

Private Sub NombreCliente_KeyPress(KeyAscii As Integer) 'DAPV - 08/Nov/2011
     KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
End Sub

Private Sub Text1_Change()

End Sub

Private Sub txt_celular_KeyDown(KeyCode As Integer, Shift As Integer) 'DAPV - 08/Nov/2011
    Select Case KeyCode%
        Case CGTeclaSUPR%
           txt_celular.Text = ""
        Case CGTeclaENTER%
'           'SendKeys "{TAB}"
'           txt_monto_rec.SetFocus
        Case CGTeclaUP%, CGTeclaREPAG%
           txt_cod_empresa.SetFocus
        Case CGTeclaDOWN%, CGTeclaAVPAG%
           SendKeys "{TAB}"
    End Select
End Sub

Private Sub txt_celular_KeyPress(KeyAscii As Integer)
'INI -DAPV - 09/12/2011 - Recargas Claro
    If CGTeclaENTER = KeyAscii% Then
        SendKeys "{TAB}"
    End If
    
    If (KeyAscii% < 48 Or KeyAscii% > 57) And KeyAscii% <> 8 And KeyAscii% <> 46 Then
        KeyAscii% = 0
    End If
    

'FIN - DAPV - 09/12/2011 - Recargas Claro
End Sub


Private Sub txt_cod_empresa_Change()
txt_celular.Text = ""
txt_monto_rec.Text = ""
End Sub

Private Sub txt_cod_empresa_GotFocus()
FPrincipal!pnlHelpLine.Caption = "F5 Tipo de Empresa"
End Sub

Private Sub txt_cod_empresa_KeyDown(KeyCode As Integer, Shift As Integer)
Dim VTPaso%
  

If txt_cod_servicio = "1" Then 'DAPV - Televisores
    If KeyCode = vbKeyF5 Then
         txt_cod_empresa.TableName = "cl_emp_recarga"
        If txt_cod_empresa <> "" Then
            VLEmpresa = txt_cod_empresa.Text
         End If
    End If
End If

If txt_cod_servicio = "2" Then 'DAPV - 09/12/2011 - Recargas Claro
    If KeyCode = vbKeyF5 Then
         txt_cod_empresa.TableName = "cl_celular_recarga"
         If txt_cod_empresa <> "" Then
            VLEmpresa = txt_cod_empresa.Text
         End If

    End If
End If

If txt_cod_servicio = "3" Then 'DAPV - 09/12/2011 - Recargas Claro
    If KeyCode = vbKeyF5 Then
         txt_cod_empresa.TableName = "cl_emp_peaje"
         If txt_cod_empresa <> "" Then
            VLEmpresa = txt_cod_empresa.Text
         End If

    End If
End If

End Sub

Private Sub txt_cod_empresa_KeyPress(KeyAscii As Integer)
    If CGTeclaENTER = KeyCode Then
        SendKeys "{TAB}"
    ElseIf CGTeclaSUPR% = KeyCode Then
       txt_cod_empresa.Text = ""
    End If
End Sub

Private Sub txt_cod_empresa_LostFocus()
 
 Dim VTPaso%
 
    'msilvag:Inicio CLAPAQ-AP-SGC00032311-SGC00032329 - CLARO PAQUETES
    Me.Etiqueta21.Caption = "Monto"
    Me.Etiqueta21.Height = 300
    Me.Frame1.Top = 120
    If txt_cod_servicio = "3" Then
    Me.Frame1.Height = 1535
    Else
    Me.Frame1.Height = 1335
    End If
    Me.txt_cod_servicio.Left = 1320
    Me.txt_cod_empresa.Left = 1320
    Me.txt_celular.Left = 1320
    Me.txt_des_servicio.Left = 2000
    Me.txt_des_servicio.Width = 2100
    Me.txt_des_empresa.Left = 2000
    Me.txt_des_empresa.Width = 2100
    Me.Etiqueta21.Left = 2760
    'msilvag Fin
    
If txt_cod_servicio = "3" Then
   If txt_cod_empresa <> "" Then
     txt_contrato.SetFocus
     VLEmpresa = Trim(txt_cod_empresa)
   End If
End If
    
If txt_cod_servicio = "1" Then 'DAPV - 09/12/2011 - Recargas Claro
    If txt_cod_empresa <> "" Then
        txt_cod_empresa.TableName = "cl_emp_recarga"
        If Trim(txt_cod_empresa) <> "" Then
            VLEmpresa = Trim(txt_cod_empresa)
            Call FLConComision
        End If
    End If
    Else
    Comision.Text = "0.00"
End If
    
If txt_cod_servicio = "2" Then 'DAPV - 09/12/2011 - Recargas Claro
    If txt_cod_empresa <> "" Then
        txt_cod_empresa.TableName = "cl_celular_recarga"
        If Trim(txt_cod_empresa) <> "" Then
            VLEmpresa = Trim(txt_cod_empresa)
        End If
        
        'KBastidz Empresa: Tuenti y Movistar Compra Paquete Via Rapida
        'Or Trim(Me.txt_cod_empresa) = "19574" Or Trim(Me.txt_cod_empresa) = "19575"
        If Trim(txt_cod_empresa) = "103" Then  ' RECARGAS MOVISTAR --DAPV
            Identificacion.Text = "9999999999"
            Identificacion.Enabled = False
            cboTipoId.Enabled = False
            NombreCliente.Text = "CONSUMIDOR FINAL"
            NombreCliente.Enabled = False
            txtValor.Visible = True
            txtValor.Enabled = True
            txt_monto_rec.Visible = False
        'msilvag:Inicio CLAPAQ-AP-SGC00032311-SGC00032329 - CLARO PAQUETES
        ElseIf Trim(Me.txt_cod_empresa) = "40" Then
            Me.Etiqueta21.Caption = "Monto Paquetes"
            Me.Etiqueta21.Height = 450
            Me.Etiqueta21.Width = 790
            Me.Frame1.Top = 80
            Me.Frame1.Height = 1500
            
            Me.txt_cod_servicio.Left = 1020
            Me.txt_cod_empresa.Left = 1020
            Me.txt_celular.Left = 1020
            Me.txt_des_servicio.Left = 1700
            Me.txt_des_servicio.Width = 2395
            Me.txt_des_empresa.Left = 1700
            Me.txt_des_empresa.Width = 2395
            Me.Etiqueta21.Left = 2420
            
        
            txtValor.Visible = False
            txt_monto_rec.Visible = True
            Me.txt_monto_rec.TableName = "cl_valor_paquete_claro"
            Me.CantChq.Enabled = True
            Me.Cheques.Enabled = True
        'msilvag Fin
        
        'KBastidz Empresa: Tuenti y Movistar Compra Paquete Via Rapida
        ElseIf Trim(Me.txt_cod_empresa) = "19574" Or Trim(Me.txt_cod_empresa) = "19575" Then
            Me.Etiqueta21.Caption = "Monto Paquetes"
            Me.Etiqueta21.Height = 450
            Me.Etiqueta21.Width = 790
            Me.Frame1.Top = 80
            Me.Frame1.Height = 1500
            Identificacion.Text = "9999999999"
            NombreCliente.Text = "CONSUMIDOR FINAL"
            NombreCliente.Enabled = False
            Identificacion.Enabled = False
            Me.txt_cod_servicio.Left = 1020
            Me.txt_cod_empresa.Left = 1020
            Me.txt_celular.Left = 1020
            Me.txt_des_servicio.Left = 1700
            Me.txt_des_servicio.Width = 2395
            Me.txt_des_empresa.Left = 1700
            Me.txt_des_empresa.Width = 2395
            Me.Etiqueta21.Left = 2420
            
        
            txtValor.Visible = False
            txt_monto_rec.Visible = True
            If Trim(Me.txt_cod_empresa) = "19574" Then
                Me.txt_monto_rec.TableName = "cl_valor_paquetes_movis_online"
            Else
                Me.txt_monto_rec.TableName = "cl_valor_paquetes_tuent_online"
            End If
            
            Me.CantChq.Enabled = False
            Me.Cheques.Enabled = False
            Me.Comision.Enabled = False
        'KBastidz Fin
        
        Else
            txt_monto_rec.Visible = True
            Identificacion.Text = ""
'            Identificacion.Enabled = True
'            CboTipoID.Enabled = True
            NombreCliente.Text = ""
'            NombreCliente.Enabled = True
            txtValor.Visible = False
            Me.txt_monto_rec.TableName = "cl_valor_porta"
        End If
        
        
        'Consulta de direcciones Tiempo aire 'DAPV 12/Julio/2012
        PMInicioTransaccion
        PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 43354, "Trn", ""
        PMPasoValoresATX VGSqlConn, "@i_empresa", 0, SQLINT4, CInt(VLEmpresa), "Empresa", ""
        PMPasoValoresATX VGSqlConn, "@o_direccion1", 1, SQLVARCHAR, "X", "Direccion1", ""
        PMPasoValoresATX VGSqlConn, "@o_direccion2", 1, SQLVARCHAR, "X", "Direccion2", ""
        PMPasoValoresATX VGSqlConn, "@o_direccion3", 1, SQLVARCHAR, "X", "Direccion3", ""
        If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_catalogo_tiempo_aire", True, "Transaccion Ok", "S", "N", "N", "143", "S", "S") = True Then
            VLDireccion1 = FMRetParamATX(VGSqlConn, 1)
            VLDireccion2 = FMRetParamATX(VGSqlConn, 2)
            VLDireccion3 = FMRetParamATX(VGSqlConn, 3)
        End If
        PMChequeaATX VGSqlConn
        PMFinTransaccion
        
    Else
        Comision.Text = "0.00"
    End If
End If
End Sub

Private Sub txt_cod_servicio_Change()
    VLPaso% = False
    VLCambio% = True
    Limpiar_Forma 'DAPV - 08/Nov/2011
    
End Sub

Private Sub txt_cod_servicio_GotFocus()
FPrincipal!pnlHelpLine.Caption = "F5 Tipo de Servicio"
End Sub

Private Sub txt_cod_servicio_KeyPress(KeyAscii As Integer)
    If CGTeclaENTER = KeyCode Then
        SendKeys "{TAB}"
    ElseIf CGTeclaSUPR% = KeyCode Then
       txt_cod_servicio.Text = ""
    End If
End Sub

Private Function FLChequeos() As Boolean
On Error GoTo Error
    FLChequeos = False
    
     If txt_cod_servicio = "" Then
        MsgBox "El codigo de servicio es obligatorio"
        FLChequeos = False
        Me.txt_cod_servicio.SetFocus
        Exit Function
   End If

    If txt_cod_empresa = "" Then
        MsgBox "El codigo de empresa es obligatorio"
        FLChequeos = False
        Me.txt_cod_empresa.SetFocus
        Exit Function
    End If
    
    If VLTotCom <> FMCCurATX((Comision.Text)) Then
        MsgBox "Verifique el Campo Valor de Comision"
        Comision.SetFocus
        FLChequeos = False
        Exit Function
    End If
    
    If Trim(txt_cod_servicio.Text = "1") Then 'DAPV - 09/12/2011 - Recargas Claro
        If txt_cod_tar1 = "" And txt_cod_tar2 = "" And txt_cod_tar3 = "" Then
             MsgBox "El numero de la tarjeta inteligente de la recarga prepago es obligatorio"
             FLChequeos = False
             Me.txt_cod_tar1.Text = ""
             txt_cod_tar2.Text = ""
             txt_cod_tar3.Text = ""
             Me.txt_cod_tar1.SetFocus
             Exit Function
        End If
    End If

 If Cheques.Text <> "0.00" And CantChq.Text = "0" Then
        MsgBox "El campo Cant.Ch: es Mandatorio"
        FLChequeos = False
        Exit Function
 End If
 
 If Me.txt_cod_empresa <> "120" Then
    If Cta.ClipText <> "" And Debito.ValueReal = 0 Then
        MsgBox "El campo Debito: es Mandatorio"
        FLChequeos = False
        Exit Function
    End If
    If Cta.ClipText = "" And Debito.ValueReal > 0 Then
        MsgBox "El campo cuenta: es Mandatorio"
        FLChequeos = False
        Exit Function
    End If
 End If
 
 If CCur(Me.valor.Text) <> (CCur(Me.efe.Text) + CCur(Me.Debito.Text) + CCur(Me.Cheques.Text)) Then
        MsgBox "SubTotal a Pagar no coincide con el desglose"
        FLChequeos = False
        Exit Function
    End If
    
'Valido que no se cobren valores decimales
Me.decimal = CCur(Me.valor.Text)
    
If Round(Me.decimal) <> CCur(Me.valor.Text) Then
        MsgBox "El valor a Pagar no debe tener valores decimales"
        FLChequeos = False
        Exit Function
End If
 If VGTipoEjecucion% <> CGReverso% Then
'Valida monto minimo y maximo
If Trim(txt_cod_servicio.Text = "1") Then 'DAPV - 09/12/2011 - Recargas Claro
    If CCur(Me.valor.Text) < CCur(MontoMin.Text) Then
        MsgBox "Subtotal es menor al Monto Mínimo permitido"
        FLChequeos = False
        Exit Function
    End If
    
    If CCur(Me.valor.Text) > CCur(MontoMax.Text) Then
        MsgBox "Subtotal es mayor al Monto Maximo permitido"
        FLChequeos = False
        Exit Function
    End If
    End If
End If
    
If FMCCurATX((efe.Text)) > 0 And CCur(VLEfe_com) > 0 And VGTipoEjecucion = CGNormal% Then
     VTTotalDesglose = 0
        For i% = 1 To SGNumDen
            If SGIngreso(i% - 1).cant_ingr > 0 Then
                VTTotalDesglose = VTTotalDesglose + SGIngreso(i% - 1).mont_ingr
            End If
        Next i%
        If CCur(VTTotalDesglose + SGAcumulado) < (FMCCurATX((efe.Text)) + CCur(VLEfe_com)) Then
            MsgBox "Desglose menor a efectivo ingresado. Verifique...", vbCritical, "Mensaje del Servidor"
            FLChequeos = False
            Exit Function
        End If
  End If
  
  If Trim(txt_cod_servicio.Text = "2") Then 'DAPV - 09/12/2011 - Recargas Claroç
        If Trim(txt_cod_empresa.Text) = "103" Then
            If Trim(Identificacion.Text) = "" Then
                MsgBox "Número de Identificación es Obligatorio"
                FLChequeos = False
                Identificacion.Text = ""
                Identificacion.SetFocus
                Exit Function
            End If
        End If
        
    If txt_monto_rec.Text = "" And Trim(txt_cod_empresa.Text) = 39 Then 'DAPV - 08/Nov/2011
        MsgBox ("El campo Monto: es Mandatorio")
        FLChequeos = False
        Exit Function
    End If
    
    'KBastidz Empresa: Tuenti y Movistar Compra Paquete
   If txt_monto_rec.Text = "" And (Trim(txt_cod_empresa.Text) = 19574 Or Trim(txt_cod_empresa.Text) = 19575) Then 'DAPV - 08/Nov/2011
        MsgBox ("Valor Del Combo No Existe")
        FLChequeos = False
        Exit Function
    End If
    
    If txtValor.Text = "" And Trim(txt_cod_empresa.Text) = 103 Then 'DAPV - 08/Nov/2011
        MsgBox ("El campo Monto: es Mandatorio")
        FLChequeos = False
        Exit Function
    End If
    
   
    
    If txt_celular.Text = "" Then 'DAPV - 08/Nov/2011
        MsgBox "El campo Celular: es Mandatorio"
        FLChequeos = False
        Exit Function
    End If
    
    'If Len(Trim(txt_celular.Text)) <> 9 Then 'DAPV - 08/Nov/2011
     If Len(Trim(txt_celular.Text)) <> 10 Then 'DAPV - 08/01/2012
        MsgBox "El Número de celular debe tener 10 Dígitos"
        FLChequeos = False
        Exit Function
    End If
    
    If Trim(txt_cod_empresa.Text) = "103" Then
        If Trim(NombreCliente.Text) = "" Then 'DAPV - 08/Nov/2011o
            MsgBox "Nombre de Cliente es Obligatorio"
            FLChequeos = False
            NombreCliente.Text = ""
            NombreCliente.SetFocus
            Exit Function
        End If
    End If
    
   
    If txt_cod_empresa.Text = 39 Then
        If CCur(Total.Text) <> CCur(txt_monto_rec.Text) Then 'DAPV - 08/Nov/2011
            MsgBox "Valor Total no coincide con monto a recargar"
            FLChequeos = False
            Exit Function
        End If
    End If
    If txt_cod_empresa = 103 Then
         If CCur(Total.Text) <> CCur(txtValor.Text) Then  'DAPV - 08/Nov/2011
            MsgBox "Valor Total no coincide con monto a recargar"
            FLChequeos = False
            Exit Function
        End If
    End If
  End If
  
  If VGTipoEjecucion% <> CGReverso% Then 'DAPV - 08/Nov/2011
    If obtenerValores = False Then
        FLChequeos = False
        Exit Function
    End If
 End If

  
  
FLChequeos = True
    Exit Function
Error:
FLChequeos = False

End Function
Private Function obtenerValores() As Boolean '-DAPV -- 19/OCT/2011
obtenerValores = False
Select Case VLEmpresa
    Case 39, 40, 19574, 19575 'KBastidz Empresa: Tuenti y Movistar Compra Paquete
        If CCur(Total.Text) = CCur(txt_monto_rec.Text) Then
            obtenerValores = True
        Else
            MsgBox "Total no coincide con el valor ingresado", vbCritical
            obtenerValores = False
        End If
    Case 103
        valorMovistar
        If CCur(Total.Text) >= VLminMovi And CCur(Total.Text) <= VLmaxMovi Then
            obtenerValores = True
        Else
            MsgBox "El valor total debe estar entre: " + Format(CStr(VLminMovi), VGFormatoMoney) + " y " + Format(CStr(VLmaxMovi), VGFormatoMoney), vbCritical
            obtenerValores = False
        End If
    Case 120
        obtenerValores = True
    Case 8461
        obtenerValores = True
End Select
End Function
Private Sub valorMovistar()  'DAPV 19/OCT/2011

Dim VLarregloParametro(30) As String

PMInicioTransaccion
PMPasoValores VGSqlConn, "@t_trn", 0, SQLINT2, 1579
PMPasoValores VGSqlConn&, "@i_operacion", 0, SQLVARCHAR, "Q"
PMPasoValores VGSqlConn&, "@i_nemonico", 0, SQLVARCHAR, "MMOVI"
PMPasoValores VGSqlConn&, "@i_producto", 0, SQLVARCHAR, "CTE"
If FMTransmitirRPC(VGSqlConn, VGServerNameRec$, "cobis", "sp_parametro", True, "Transaccion Ok") = True Then
    VTR1% = FMMapeaArreglo(VGSqlConn&, VLarregloParametro())
    VLminMovi = CCur(LTrim(RTrim(Trim(VLarregloParametro(4)))))
Else
    VLminMovi = 5
End If
PMChequea VGSqlConn&
PMFinTransaccion


PMInicioTransaccion
PMPasoValores VGSqlConn, "@t_trn", 0, SQLINT2, 1579
PMPasoValores VGSqlConn&, "@i_operacion", 0, SQLVARCHAR, "Q"
PMPasoValores VGSqlConn&, "@i_nemonico", 0, SQLVARCHAR, "MXMOVI"
PMPasoValores VGSqlConn&, "@i_producto", 0, SQLVARCHAR, "CTE"
If FMTransmitirRPC(VGSqlConn, VGServerNameRec$, "cobis", "sp_parametro", True, "Transaccion Ok") = True Then
    VTR1% = FMMapeaArreglo(VGSqlConn&, VLarregloParametro())
    VLmaxMovi = CCur(LTrim(RTrim(Trim(VLarregloParametro(4)))))
Else
    VLmaxMovi = 50
End If
PMChequea VGSqlConn&
PMFinTransaccion

End Sub

Private Function FLConComision() As Integer 'nchavezb 03/15/2011
'Consulta el valor de comision por empresa
Dim valor As String

SGEmpresa = Me.txt_cod_empresa.Text

PMInicioTransaccion
PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 4038, "Trn", ""
PMPasoValoresATX VGSqlConn, "@i_empresa", 0, SQLINT4, val(txt_cod_empresa.Text), "Codigo de empresa", ""
'Variables de salida
PMPasoValoresATX VGSqlConn, "@o_comision", 1, SQLMONEY, 0, "comision", ""
PMPasoValoresATX VGSqlConn, "@o_monto_min", 1, SQLMONEY, 0, "MontoMin", ""
PMPasoValoresATX VGSqlConn, "@o_monto_max", 1, SQLMONEY, 0, "MontoMax", ""
PMPasoValoresATX VGSqlConn, "@o_idcomercio", 1, SQLINT4, 0, "IDCOMERCIO", ""
'INI - dpereirv
PMPasoValoresATX VGSqlConn, "@o_tasa", 1, SQLMONEY, "0", "tasa", ""
PMPasoValoresATX VGSqlConn, "@o_base_imp", 1, SQLMONEY, "0", "base_imp", ""
PMPasoValoresATX VGSqlConn, "@o_impuesto", 1, SQLMONEY, "0", "impuesto", ""
'FIN - dpereirv

If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_cons_comi_recarga_prepago", True, "Transaccion Ok", "S", "N", "N", "143", "S", "S") = True Then
    Comision = FMRetParamATX(VGSqlConn, 1)
    MontoMin = FMRetParamATX(VGSqlConn, 2)
    MontoMax = FMRetParamATX(VGSqlConn, 3)
    VLIdComercio = FMRetParamATX(VGSqlConn, 4)
    VlbaseImp = FMRetParamATX(VGSqlConn, 6) 'dpereirv
    VLiva = FMRetParamATX(VGSqlConn, 7) 'dpereirv
    PMChequeaATX VGSqlConn&
    PMFinTransaccion
Else
    Comision = 0#
    VLIdComercio = 0
    txt_cod_empresa.SetFocus
    PMChequeaATX VGSqlConn&
    PMFinTransaccion
End If
End Function

Private Sub txt_cod_servicio_LostFocus()
' INICIO -DAPV - 09/12/2011 - Recargas Claro

    'msilvag:Inicio CLAPAQ-AP-SGC00032311-SGC00032329 - CLARO PAQUETES
    Me.Etiqueta21.Caption = "Monto"
    Me.Etiqueta21.Height = 300
    Me.Frame1.Top = 120
    Me.Frame1.Height = 1335
    
        Me.txt_cod_servicio.Left = 1320
    Me.txt_cod_empresa.Left = 1320
    Me.txt_celular.Left = 1320
    Me.txt_des_servicio.Left = 2000
    Me.txt_des_servicio.Width = 2100
    Me.txt_des_empresa.Left = 2000
    Me.txt_des_empresa.Width = 2100
    Me.Etiqueta21.Left = 2760
    'msilvag Fin
    
    Select Case Trim$(txt_cod_servicio.Text)
    Case "1" ' Televisor
        If txt_cod_servicio.Text = "1" Then
            txt_cod_empresa.TableName = "cl_emp_recarga"
            Etiqueta18.Visible = False
            Etiqueta19.Visible = False
            Etiqueta20.Visible = False
            txt_celular.Visible = False
            Etiqueta21.Visible = False
            txt_monto_rec.Visible = False
            txtValor.Visible = False
            cboTipoId.Visible = False
            Identificacion.Visible = False
            NombreCliente.Visible = False
            Label3.Visible = False 'jrocafuf
            txt_contrato.Visible = False 'jrocafuf
            lbl_nombre.Visible = False 'jrocafuf
            txt_nombreCliente.Visible = False 'jrocafuf
            txt_cod_tar3.Visible = True
            txt_cod_tar2.Visible = True
            txt_cod_tar1.Visible = True
            Frame2.Height = "2500"
            FCC143.Height = "4600"
        End If
    Case "2" 'Celulares
        If txt_cod_servicio.Text = "2" Then
            txt_cod_empresa.TableName = "cl_celular_recarga"
            Etiqueta18.Visible = True
            Etiqueta19.Visible = True
            Etiqueta20.Visible = True
            txt_celular.Visible = True
            Etiqueta21.Visible = True

            cboTipoId.Visible = True
            Identificacion.Visible = True
            NombreCliente.Visible = True
            txt_cod_tar3.Visible = False
            txt_cod_tar2.Visible = False
            txt_cod_tar1.Visible = False
            Label3.Visible = False 'jrocafuf
            txt_contrato.Visible = False 'jrocafuf
            lbl_nombre.Visible = False 'jrocafuf
            txt_nombreCliente.Visible = False 'jrocafuf
            Frame2.Height = "3100"
            FCC143.Height = "5200"
            If Trim(txt_cod_empresa.Text) = "103" Then
                Identificacion.Enabled = True
                NombreCliente.Enabled = True
                Me.cboTipoId.Enabled = True
            End If
            cboTipoId.ListIndex = 0
            
            If VGTipoEjecucion% <> CGReverso% Then
            Identificacion.Text = ""
            Select Case VLIdentificacion
                Case "C"
                    Identificacion.MaxLength = 10
                Case "R"
                    Identificacion.MaxLength = 13
                Case "P"
                    Identificacion.MaxLength = 20
            End Select
            End If
            
            
        End If
    Case "3" ' Peaje
        If txt_cod_servicio.Text = "3" Then
            txt_cod_empresa.TableName = "cl_emp_peaje"
            Etiqueta18.Visible = False
            Etiqueta19.Visible = False
            Etiqueta20.Visible = False
            txt_celular.Visible = False
            Etiqueta21.Visible = False
            txt_monto_rec.Visible = False
            txtValor.Visible = False
            cboTipoId.Visible = False
            Identificacion.Visible = False
            NombreCliente.Visible = False
            txt_cod_tar3.Visible = False
            txt_cod_tar2.Visible = False
            txt_cod_tar1.Visible = False
            Label3.Visible = True
            txt_contrato.Enabled = True 'jrocafuf
            txt_contrato.Visible = True 'jrocafuf
            lbl_nombre.Visible = True 'jrocafuf
            txt_nombreCliente.Visible = True 'jrocafuf
            Frame1.Height = "1535"
            Frame2.Height = "3100"
            FCC143.Height = "4800"
        End If
    End Select
    
' FIN -DAPV - 09/12/2011 - Recargas Claro
  
End Sub

Private Sub txt_cod_tar1_Change()
 Vl_Ind_Efe = 0 'DAPV - 10/14/2011
End Sub

Private Sub txt_cod_tar1_GotFocus()
FPrincipal!pnlHelpLine.Caption = "Digite el codigo del Numero de tarjeta inteligente"
 Vl_Ind_Efe = 0 'DAPV - 10/14/2011
End Sub

Private Sub txt_cod_tar1_KeyPress(KeyAscii As Integer)
 If CGTeclaENTER = KeyAscii% Then
        SendKeys "{TAB}"
  End If
    
 If (KeyAscii% <> 8) And (KeyAscii% <> 32) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
        KeyAscii% = 0
    End If
End Sub

Private Sub txt_cod_tar1_LostFocus()

If txt_cod_servicio <> "" Then
    If txt_cod_empresa <> "" Then
        If txt_cod_tar1 <> "" And txt_cod_tar2 <> "" And txt_cod_tar3 <> "" Then
            'habilito seccion b
            efe.Enabled = True
            CantChq.Enabled = True
            Cheques.Enabled = True
            CboTipCta.Enabled = True
            Cta.Enabled = True
            Debito.Enabled = True
            Comision.Enabled = True
            If Vl_Ind_Efe = 0 Then 'DAPV - 10/14/2011
            efe.SetFocus
            Vl_Ind_Efe = 1
            End If
            VCodigo = txt_cod_tar1.Text + txt_cod_tar2.Text + txt_cod_tar3.Text
        End If
    End If
    End If
End Sub

Private Sub txt_cod_tar2_Change()
 Vl_Ind_Efe = 0 'DAPV - 10/14/2011
End Sub

Private Sub txt_cod_tar2_GotFocus()
FPrincipal!pnlHelpLine.Caption = "Digite el codigo del Numero de tarjeta inteligente"
Vl_Ind_Efe = 0 'DAPV - 10/14/2011
End Sub

Private Sub txt_cod_tar2_KeyPress(KeyAscii As Integer)
If CGTeclaENTER = KeyAscii% Then
        SendKeys "{TAB}"
   
  End If
 
 If (KeyAscii% <> 8) And (KeyAscii% <> 32) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
        KeyAscii% = 0
    End If
End Sub

Private Sub txt_cod_tar2_LostFocus()

If txt_cod_servicio <> "" Then
    If txt_cod_empresa <> "" Then
        If txt_cod_tar1 <> "" And txt_cod_tar2 <> "" And txt_cod_tar3 <> "" Then
            'habilito seccion b
            efe.Enabled = True
            CantChq.Enabled = True
            Cheques.Enabled = True
            CboTipCta.Enabled = True
            Cta.Enabled = True
            Debito.Enabled = True
            Comision.Enabled = True
            If Vl_Ind_Efe = 0 Then 'DAPV - 10/14/2011
            efe.SetFocus
            Vl_Ind_Efe = 1
            End If
            VCodigo = txt_cod_tar1.Text + txt_cod_tar2.Text + txt_cod_tar3.Text
        End If
    End If
    End If
End Sub

Private Sub txt_cod_tar3_Change()
 Vl_Ind_Efe = 0 'DAPV - 10/14/2011
End Sub

Private Sub txt_cod_tar3_GotFocus()
FPrincipal!pnlHelpLine.Caption = "Digite el codigo del Numero de tarjeta inteligente"
End Sub

Private Sub txt_cod_tar3_KeyPress(KeyAscii As Integer)
If CGTeclaENTER = KeyAscii% Then
        SendKeys "{TAB}"
   
  End If
 
 If (KeyAscii% <> 8) And (KeyAscii% <> 32) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
        KeyAscii% = 0
    End If
End Sub

Private Sub txt_cod_tar3_LostFocus() 'nchavezb 03/16/2011

If txt_cod_servicio <> "" Then
    If txt_cod_empresa <> "" Then
        If txt_cod_tar1 <> "" And txt_cod_tar2 <> "" And txt_cod_tar3 <> "" Then
            'habilito seccion b
            efe.Enabled = True
            CantChq.Enabled = True
            Cheques.Enabled = True
            CboTipCta.Enabled = True
            Cta.Enabled = True
            Debito.Enabled = True
            Comision.Enabled = True
            If Vl_Ind_Efe = 0 Then 'DAPV - 10/14/2011
                efe.SetFocus
                Vl_Ind_Efe = 1
            End If
            VCodigo = txt_cod_tar1.Text + txt_cod_tar2.Text + txt_cod_tar3.Text
        End If
    End If
End If
End Sub


Private Sub txt_contrato_GotFocus()
FPrincipal!pnlHelpLine.Caption = "Ingrese número de Contrato"
End Sub

Private Sub txt_contrato_KeyDown(KeyCode As Integer, Shift As Integer)
    
    Select Case KeyCode%
            Case CGTeclaSUPR%
                txt_contrato.Text = ""
            Case CGTeclaUP%, CGTeclaREPAG%
                SendKeys "+{TAB}"
            Case CGTeclaF5%
                    If Not FLTransmitir_consulta_peaje Then
                        Exit Sub
                    End If
    End Select
End Sub

Private Sub txt_contrato_KeyPress(KeyAscii As Integer)
    If (KeyAscii% <> 8) And ((KeyAscii% < 65) Or (KeyAscii% > 90)) Then
        If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            If (KeyAscii% <> 45) Then
                KeyAscii% = 0
            End If
        End If
    End If
    KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
End Sub

Private Sub txt_monto_rec_Change()
Vl_Ind_Efe = 0  'DAPV - Indicador para pantalla efectivo
End Sub

Private Sub txt_monto_rec_KeyDown(KeyCode As Integer, Shift As Integer)

' INI -DAPV - 09/12/2011 - Recargas Claro
    Select Case KeyCode%
          Case CGTeclaSUPR%
            txt_monto_rec.Text = ""
          Case CGTeclaENTER%
             SendKeys "{TAB}"
          Case CGTeclaUP%, CGTeclaREPAG%
             txt_celular.SetFocus
          Case CGTeclaDOWN%, CGTeclaAVPAG%
             SendKeys "{TAB}"
    End Select
' FIN -DAPV - 09/12/2011 - Recargas Claro
End Sub

Private Sub txt_monto_rec_KeyPress(KeyAscii As Integer)
'INI -DAPV - 09/12/2011 - Recargas Claro
    If CGTeclaENTER = KeyAscii% Then
        SendKeys "{TAB}"
    End If
    
    If VLEmpresa = 39 Or VLEmpresa = 40 Then 'msilvag
        KeyAscii% = 0
    Else
         If Not (KeyAscii% = 8 Or KeyAscii% = 13 Or (KeyAscii% >= 48 And KeyAscii% <= 57)) Then
            KeyAscii% = 0
        End If
    End If
'FIN - DAPV - 09/12/2011 - Recargas Claro
End Sub

Private Sub txt_monto_rec_LostFocus()
'INI -DAPV - 09/12/2011 - Recargas Claro
    If txt_cod_servicio <> "" Then
        If txt_cod_empresa <> "" Then
            If Trim(txt_celular) <> "" And Trim(txt_monto_rec) <> "" Then
                'habilito seccion b
                efe.Enabled = True
                CantChq.Enabled = True
                Cheques.Enabled = True
                If Me.txt_cod_empresa.Text = "40" Then
                    CantChq.Enabled = False
                    Cheques.Enabled = False
                End If
                
                CboTipCta.Enabled = True
                Cta.Enabled = True
                Debito.Enabled = True
                Comision.Enabled = True
                
                'KBastidz Empresa: Tuenti y Movistar Compra Paquete
                If Me.txt_cod_empresa.Text = "19574" Or Me.txt_cod_empresa.Text = "19575" Then
                    CantChq.Enabled = False
                    Cheques.Enabled = False
                    Comision.Enabled = False
                End If
                'KBastidz
                
                If Vl_Ind_Efe = 0 Then
                    efe.SetFocus
                    Vl_Ind_Efe = 1
                End If

                VCodigo = txt_celular.Text
            End If
        End If
    End If
'FIN - DAPV - 09/12/2011 - Recargas Claro
End Sub

Private Sub txtValor_Change()
    Vl_Ind_Efe = 0  'DAPV - Indicador para pantalla efectivo
End Sub

Private Sub Txtvalor_KeyDown(KeyCode As Integer, Shift As Integer)
Select Case KeyCode%
          Case CGTeclaSUPR%
            txtValor.Text = ""
          Case CGTeclaENTER%
             SendKeys "{TAB}"
          Case CGTeclaUP%, CGTeclaREPAG%
             txt_celular.SetFocus
          Case CGTeclaDOWN%, CGTeclaAVPAG%
             SendKeys "{TAB}"
    End Select
End Sub

Private Sub txtvalor_KeyPress(KeyAscii As Integer)
 If CGTeclaENTER = KeyAscii% Then
        SendKeys "{TAB}"
 End If
    
If Not (KeyAscii% = 8 Or KeyAscii% = 13 Or (KeyAscii% >= 48 And KeyAscii% <= 57)) Then
    KeyAscii% = 0
End If

End Sub

Private Sub txtvalor_LostFocus()
 If txt_cod_servicio <> "" Then
        If txt_cod_empresa <> "" Then
            If Trim(txt_celular) <> "" And Trim(txtValor) <> "" Then
                'habilito seccion b
                efe.Enabled = True
                CantChq.Enabled = True
                Cheques.Enabled = True
                CboTipCta.Enabled = True
                Cta.Enabled = True
                Debito.Enabled = True
                Comision.Enabled = True
                If Vl_Ind_Efe = 0 Then
                    efe.SetFocus
                    Vl_Ind_Efe = 1
                End If

                VCodigo = txt_celular.Text
            End If
        End If
    End If
End Sub

Private Sub valor_KeyPress(KeyAscii As Integer) 'nchavezb 03/16/2011
 KeyAscii = FMValidarNumero((valor.Text), VGLongitudMoney, KeyAscii, "143")
End Sub
Public Sub ImprimirComprobante() 'nchavezb 03/16/2011
    'INICIO-DAPV - 08/Nov/2011
    If txt_cod_servicio.Text = "1" Then
        ImprimeComprobPago1
    End If
    
    If txt_cod_servicio.Text = "2" Then
    impresiones = 1
      For j = 1 To UBound(SGNumImpresion)
         If Trim(SGNumImpresion(j).transaccion) = "4012" Then
            impresiones = SGNumImpresion(j).veces
            Exit For
         End If
      Next j
      If impresiones > 0 Then
         For h = 1 To impresiones
           ImprimeComprobPago2
           'impresiones
         Next h
      End If
        
    End If
    'FIN -DAPV - 08/Nov/2011
    'jrocafuf
    If txt_cod_servicio.Text = "3" Then
        ImprimeComprobPago3
    End If
    
End Sub

Public Sub ImprimeComprobPago1()
'LLAMADA A LA FUNCION DE FORMATOS
   
    VGparlong$ = "66"
    VGpartop$ = "00"
    VGparleft$ = "08"
    VGparrig$ = "00"
    Dim Codigo As String
    Codigo = Me.txt_cod_tar1.Text + " " + Me.txt_cod_tar2.Text + " " + Me.txt_cod_tar3
    Dim Fecha As String
    Fecha = Trim(Mid$(VLFechaContable, 1, 10))
    If Fecha > Format$(Date, "mm/dd/yyyy") Then
        VLTrn = "3927"
    End If
    
    'FIN DE LLAMADA A LA FUNCION
    'DETALLE DEL COMPROBANTE DE PAGO
    PMSetDetalle "!" & VGpartop$
    PMSetDetalle "%N" & VGparleft$
    PMSetDetalle "v" + "Este pago sera procesado el " + Trim(Mid$(VLFechaContable, 1, 10))
    PMSetDetalle "v" + "EMPRESA:" + Trim$(txt_cod_empresa.Text) + " " + Trim$(Mid$(txt_des_empresa.Caption, 1, 24)) + ".TARJETA INTELIGENTE:" + Trim$(Mid$(Codigo, 1, 14))
    'PMSetDetalle "v" + "TARJETA INTELIGENTE:" + Trim$(Mid$(Codigo, 1, 14))
    PMSetDetalle "v" + "NOMBRE:  " + Trim$(Mid$(UCase(VLNombSuscr), 1, 36))
    'PMSetDetalle "v" + "MONTO RECARGA   : " + FMEspaciosATX("USD.   " + Format(Trim$(valor), VGFormatoMoney), 13, CGJustificacionDerecha)
    If efe.Text <> "0.00" And Me.Cheques.Text <> "0.00" Then
    PMSetDetalle "v" + "EFE:    " + FMEspaciosATX("USD. " + Format(Trim$(efe.Text), VGFormatoMoney), 13, CGJustificacionDerecha) + "    " + "CHQ(1): " + FMEspaciosATX(Format(Trim$(Cheques.Text), VGFormatoMoney), 13, CGJustificacionDerecha)
    End If
    
    If efe.Text <> "0.00" And Me.Cheques.Text = "0.00" Then
    PMSetDetalle "v" + "EFE:    " + FMEspaciosATX("USD. " + Format(Trim$(efe.Text), VGFormatoMoney), 13, CGJustificacionDerecha)
    End If
    
    If efe.Text = "0.00" And Me.Cheques.Text <> "0.00" Then
    PMSetDetalle "v" + "CHQ(1): " + FMEspaciosATX(Format(Trim$(Cheques.Text), VGFormatoMoney), 13, CGJustificacionDerecha)
    End If
    
    If Debito.Text <> "0.00" Then
    PMSetDetalle "v" + "DEB:    " + FMEspaciosATX("USD. " + Format(Trim$(Debito.Text), VGFormatoMoney), 13, CGJustificacionDerecha) + "    " + "CTA:      " + Trim$(Cta.ClipText)
    End If
    PMSetDetalle "v" + "TOTAL:  " + FMEspaciosATX("USD. " + Format(Trim$(valor.Text), VGFormatoMoney), 13, CGJustificacionDerecha) + "     " + "No. AUT.: " + Trim$(VLCodAutorizacion)
    '***ref02 vmirandt inicio, se imprime al final del documento
    If VLclave_acceso <> "" Then
        PMSetDetalle "v" + "Clave de Acceso/Autorizacion: "
        PMSetDetalle "v" + VLclave_acceso
    End If
    'ref02 vmirandt
    
    If VGTipoEjecucion% <> CGReverso% Then
    PMSetDetalle "v" + "MUCHAS GRACIAS POR SU RECARGA. SU FACTURA ELECTRONICA ESTA "
    PMSetDetalle "v" + "DISPONIBLE EN: www.directv.com.ec. CONSULTAS SOBRE SU SALDO O "
    PMSetDetalle "v" + "INF. ADICIONAL AL TELF.02-3979197 SERVICIO AL CLIENTE"
    End If

    
    FMPRN_StdImpresion "IMPRESORA_1", False, VLTsnTemporal, "143", SGDatosDetalle, "Inserte papeleta", CStr(VGpartop$), 4, CStr(VGparleft$), , VLDescTrn, VLHorario, , , CStr(VLDesMon), VLTrn
 
        If VGTipoEjecucion = CGNormal% Then
            While MsgBox("Desea Reimprimir la papeleta para certificacion?", vbYesNo, "Mensaje") = vbYes
                PMReimpresion
            Wend
        End If
End Sub
Public Sub PLImprimeComprobante(original As String)

    Dim ced_ruc As String
    ced_ruc = Replace(SGCedula, "_", "")
    
        VGparlong$ = "66"  'smerino
        VGpartop$ = "00"
        VGparleft$ = "07" '05
        VGparrig$ = "00"


    VLTotal = Format(FMCCurATX((efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((Debito.Text)) + FMCCurATX((Comision.Text)), "###,###,###,##0.00")

    VLHorarioDifTemporal = VGHorarioDif
    If VLHorario = "N" Then
        VGHorarioDif = False
    Else
        VGHorarioDif = True
    End If

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
    PMSetDetalle "v" + "BANCO BOLIVARIANO C.A.   FACTURA"
    PMSetDetalle "v" + "RUC: 0990379017001       No. " + Trim$(VLSerie_Secuencia)
    PMSetDetalle "v" + "Junin 200 y Panama       Aut. SRI: " + Trim$(VLautoriSri)
    PMSetDetalle "v" + "CONTRIBUYENTE ESPECIAL   Fecha aut. " + Trim$(VLFecinivig)
    PMSetDetalle "v" + "NOTIFICACION No. 39 de Julio 18 de 1995 " + "Valido hasta :" + VLFecfinvig
    PMSetDetalle "v" + "RESOLUCION No. 6925 de Julio 4 de 1995"
    PMSetDetalle "v" + "Sr.(es): " + SGNombre
    PMSetDetalle "v" + "CI/RUC:  " + FMEspaciosATX(ced_ruc, 15, CGJustificacionIzquierda) + "Oficina : " + FMEspaciosATX(VGDes_Oficina$, 10, CGJustificacionIzquierda)
    'PMSetDetalle "v" + "Costo Servicio Recaudacion    Fecha: " + Format(VGFechaProceso, VGFormatoFecha$)
    PMSetDetalle "v" + "Costo Servicio Recaudacion    Fecha: " + VGFechaProceso2
    PMSetDetalle "v" + "Recarga Prepago:           " + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 8, CGJustificacionDerecha)
    PMSetDetalle "v" + "Subtotal: " + FMEspaciosATX(Format(VlbaseImp, VGFormatoMoney), 8, CGJustificacionDerecha) + " Iva 12%: " + Trim$(VLiva) 'dpereirv
    
             
    PMSetDetalle "v" + "VALOR TOTAL: " + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 5, CGJustificacionDerecha) + " Referencia: " + Trim$(VCodigo)
    
    If original = "O" Then
        PMSetDetalle "v" + "Caj: " + VGLogin$ + "      Original: Adquiriente"
    Else
        PMSetDetalle "v" + "Caj: " + VGLogin$ + "      Copia: Emisor"
    End If
    
    If VGModeloImp$ = "590" Then
        PMSetDetalle "%R" & 2
    End If
    
   FMPRN_StdImpresion "IMPRESORA_1", False, "", "143", SGDatosDetalle, "Inserte COMPROBANTE Cobro de Comisión", CStr(VGpartop$), 1, CStr(VGparleft$), , , , , False, , VLTrn

   VGHorarioDif = VLHorarioDifTemporal

'    PMInicioImpresion "IMPRESORA_1"
'    PMBorrarDatosImpresion
'
'    Dim ced_ruc As String
'    ced_ruc = Replace(SGCedula, "_", "")
'
'    VGparlong$ = "66"
'    VGpartop$ = "00"
'    VGparleft$ = "30"
'    VGparrig$ = "00"
'
'    PMSetLineaImpresion "x" + "Inserte COMPROBANTE Cobro Comision"
'    PMSetLineaImpresion "<"
'
'    VLTotal = Format(FMCCurATX((efe.Text)) + FMCCurATX((Cheques.Text)) + FMCCurATX((Debito.Text)) + FMCCurATX((Comision.Text)), "###,###,###,##0.00")
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
'    PMSetLineaImpresion "v" + "CI/RUC:  " + FMEspaciosATX(ced_ruc, 15, CGJustificacionIzquierda) + "Oficina : " + FMEspaciosATX(VGDes_Oficina$, 10, CGJustificacionIzquierda)
'    PMSetLineaImpresion "v" + "Costo Servicio Recaudacion    Fecha: " + Format(VGFechaProceso, VGFormatoFecha$)
'    PMSetLineaImpresion "v" + "Recarga Prepago:           " + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 8, CGJustificacionDerecha)
'    PMSetLineaImpresion "v" + "Subtotal: " + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 8, CGJustificacionDerecha) + " Iva 12%:    0.00"
'
'
'    PMSetLineaImpresion "v" + "VALOR TOTAL: " + FMEspaciosATX(Format(VLTotCom, VGFormatoMoney), 5, CGJustificacionDerecha) + " Referencia: " + Trim$(VCodigo)
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
'    VGHorarioDif = VLHorarioDifTemporal
End Sub



Sub PLTransmitir() 'nchavezb 03/16/2011
VLclave_acceso = "" '--ref02 vmirandt
    If VLMoneda <> VGmoneda% Then
        MsgBox "No se Puede Debitar a Cuentas con Moneda diferente a Moneda Base.", vbExclamation
        Cta.SetFocus
        Exit Sub
    End If
    
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
    
    If FLChequeos() = False Then
     Exit Sub
    End If
       If (CDbl(efe.Text) + VLEfe_com) <> SGUsar Then
      MsgBox "El Monto Efetivo No Coincide con el Monto Desglosado para el Deposito. Verificar", vbCritical, "Mensaje del Sistema"
      efe.Text = Format$(SGUsar, "####,###,##0.00")
      Exit Sub
  End If
  '<--------

  If FLTransmitir() = False Then
        'Sumadora ------->
        'IBICIO -DAPV - 08/Nov/2011
        If Trim(txt_cod_servicio.Text) = 2 Then 'solo para celulares
            If (SGAcumulado + SGAcumuladoAdi) = 0 Then
                If txt_cod_empresa.Enabled = True Then
                    txt_cod_empresa.SetFocus
                End If
            End If
        End If
        'FIN -DAPV - 08/Nov/2011
'        If (SGAcumulado + SGAcumuladoAdi) = 0 Then
'            If Tipo.Enabled = True Then
'                Tipo.SetFocus
'            End If
'        End If
        '<---------
    Exit Sub
  End If
   
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
      
 
    If VGTipoEjecucion = CGReverso And VGReversoLoger = "S" Then
        PMMsgError "Reverso OK", "", CGErrorInformativo
        FReverso!grdValores(0).Col = 4
        FReverso!grdValores(0).Text = "R"
    End If
    
       
       
     'If FLTransmitir() = True Then
       'Imprimir comprobante de Directv
      ImprimirComprobante
    'End If
    
    'INICIO- DAPV - 08/Nov/2011
' If VGTipoEjecucion = CGNormal% Then
'    If VLEmpresa <> 120 Then
'        If VLEmpresa = 103 Then
'            If VLTipoDocBroad = "S" Then 'Según la parametrizacion imprime la nota de venta
'                PLImprimeNotaVenta
'            Else
'                VLImprCompComi = "N" 'ESTE PARAMETRO DEBE QUITARSE CUANDO SE QUITE LAS PARTES MANUALES
'                If VLImprCompComi = "N" Then
'                    PLImpFactBroadnet "O"
'                    While MsgBox("Desea Reimprimir la Factura?", vbYesNo, "Mensaje") = vbYes
'                        PLImpFactBroadnet "C"
'                    Wend
'''                Else
'''                    MsgBox "Cliente tiene facturación electrónica imprimir comprobante por 24Online", vbInformation, "Sistema"
'                End If
'            End If
'          End If
'        End If
'    End If
        'FIN - DAPV - 08/Nov/2011
        
    
    If SGAcumulado = 0 Then
        Form_KeyDown CGTeclaF2%, 0
        Else
          Form_KeyDown CGTeclaF2%, -1
     End If
    
End Sub
Function FLVerificarCompraPaquete() As Integer
    Dim VLIndReverso As Boolean
    Dim flujo As String 'DAPV
    Dim tctaCSP As String 'DAPV
    Dim reverso As String 'DAPV
    Dim VLItrn As String
    Dim VLHorario As String
    Dim VLTPCuenta As String
    Dim VLarreglo(30) As String
    Dim VLcodRespuesta As String
    Dim resp_valida As String

    VLTrnF = "62684"
    flujo = "fp_valida_reca_ms"

	FLVerificarCompraPaquete = False

    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn, "@e_empresa", 0, SQLINT4, CInt(VLEmpresa), "Empresa", ""
    PMPasoValoresATX VGSqlConn, "@e_convenio", 0, SQLINT4, CInt(VLEmpresa), "Empresa", ""
    PMPasoValoresATX VGSqlConn, "@e_tipo_servicio", 0, SQLVARCHAR, "TELEFONIA_CELULAR", "Tipo Servicio", ""
    PMPasoValoresATX VGSqlConn, "@e_canal", 0, SQLVARCHAR, "VEN", "Canal", ""
    PMPasoValoresATX VGSqlConn, "@e_tipo_banca", 0, SQLVARCHAR, "BP", "BP", ""
    PMPasoValoresATX VGSqlConn, "@e_valida", 0, SQLCHAR&, "S", "Valida", ""
    PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
    PMPasoValoresATX VGSqlConn, "@i_trn", 0, SQLINT4, "62689", "i_trn", ""
    PMPasoValoresATX VGSqlConn, "@resp_valida", 1, SQLVARCHAR, "XX", "Valida", ""

    If FMTransmitirRPCATX(VGSqlConn, "RECSRV", "cob_procesador", flujo, True, "Transaccion Ok", "S", "N", "S", "143", "S", "S") = True Then
        VTResult% = FMMapeaMatrizATX(VGSqlConn&, vtmatrizcps())
        resp_valida = FMRetParamATX(VGSqlConn, 1)
        If resp_valida <> "0" Then
            MsgBox "NO PUDIMOS PROCESAR SU TRANSACCION, INTENTE NUEVAMENTE", vbExclamation, App.Title
            FLVerificarCompraPaquete = False
            PMFinTransaccion
            PMChequeaATX VGSqlConn
            Exit Function
        End If
		FLVerificarCompraPaquete = True
    Else
        MsgBox "NO PUDIMOS PROCESAR SU TRANSACCION, INTENTE NUEVAMENTE", vbExclamation, App.Title
        FLVerificarCompraPaquete = False
        PMChequeaATX VGSqlConn
    End If
    PMFinTransaccion

    Exit Function
    
Error:
    MsgBox "Error al transmitir la transaccion " & Chr(13) & "Error:" & Err.Description, vbCritical
    FLVerificarCompraPaquete = False
End Function
'
Function FLTransmitirCompraPaquete() As Integer 'kbastidz Compra Paquete Movistar Tuenti
     Dim VTIndicadorSum As Integer
    Dim VLIndReverso As Boolean
    Dim flujo As String 'DAPV
    Dim tctaCSP As String 'DAPV
    Dim reverso As String 'DAPV
    Dim VLItrn As String
    Dim VLHorario As String
    Dim VLTPCuenta As String
    Dim VLarreglo(30) As String
    Dim VLcodRespuesta As String
    VTIndicadorSum = 0
   
    'KBastidz Integracion TUENTI Y MOVISTAR ref: ViaRapida
        FLTransmitirCompraPaquete = True
            
            VLEmpresa = Trim(txt_cod_empresa.Text)
            VLTrn = "62685"
            flujo = "fp_pago_reca_ms"
            If CCur(Debito.Text) > 0 Then
                VLTPCuenta = VLtCTA
            End If
            PMInicioTransaccion
            
            'Variables Para El Branch
            PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLCHAR, "N", "@t_corr", ""
            PMPasoValoresATX VGSqlConn, "@i_moneda", 0, SQLINT1, str(FMObtenerMonedaForma("131")), "Moneda", ""
            PMPasoValoresATX VGSqlConn, "@i_val", 0, SQLMONEY, efe.Text, "Efectivo", ""
            'PMPasoValoresATX VGSqlConn, "@i_tipo_cta", 0, SQLCHAR, VLTPCuenta, "CboTipCta", ""
            PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, Cta.ClipText, "Cta", ""
            PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, Debito.Text, "Debito", ""
            
            'PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
            PMPasoValoresATX VGSqlConn, "@e_empresa", 0, SQLINT4, CInt(VLEmpresa), "Empresa", ""
            PMPasoValoresATX VGSqlConn, "@e_convenio", 0, SQLINT4, CInt(VLEmpresa), "Empresa", ""
            PMPasoValoresATX VGSqlConn, "@e_tipo_servicio", 0, SQLVARCHAR, "TELEFONIA_CELULAR", "Tipo Servicio", ""
            PMPasoValoresATX VGSqlConn, "@e_tipo_identificador", 0, SQLVARCHAR, "CELULAR", "Tipo Identificador", ""
            PMPasoValoresATX VGSqlConn, "@e_telefono", 0, SQLVARCHAR, Me.txt_celular.Text, "Celular", ""
            PMPasoValoresATX VGSqlConn, "@e_ced_ruc", 0, SQLVARCHAR, Trim(Right("0000000000000" + Identificacion.Text, 13)), "Cedula", ""
            PMPasoValoresATX VGSqlConn, "@e_cuenta", 0, SQLVARCHAR, Cta.ClipText, "Cta", ""
            PMPasoValoresATX VGSqlConn, "@e_tipocta", 0, SQLCHAR, VLTPCuenta, "CboTipCta", ""
            PMPasoValoresATX VGSqlConn, "@e_moneda", 0, SQLINT1, str(FMObtenerMonedaForma("131")), "Moneda", ""
            PMPasoValoresATX VGSqlConn, "@e_val", 0, SQLMONEY, efe.Text, "Efectivo", ""
            PMPasoValoresATX VGSqlConn, "@e_debito", 0, SQLMONEY, Debito.Text, "Debito", ""
            PMPasoValoresATX VGSqlConn, "@e_opcion", 0, SQLCHAR, "P", "Opcion", ""
            PMPasoValoresATX VGSqlConn, "@e_canal", 0, SQLVARCHAR, "VEN", "Canal", ""
            PMPasoValoresATX VGSqlConn, "@e_autoriza", 0, SQLCHAR, VGAutoriza, "Autorizacion", ""
            PMPasoValoresATX VGSqlConn, "@e_nombre", 0, SQLVARCHAR, "", "Nombre", ""
            PMPasoValoresATX VGSqlConn, "@e_total", 0, SQLMONEY, (Total.Text), "Total", ""
            PMPasoValoresATX VGSqlConn, "@e_tipo_id", 0, SQLCHAR, VLIdentificacion, "Tipo Id", ""
            PMPasoValoresATX VGSqlConn, "@e_fecha_real", 0, SQLVARCHAR, Format(Date, "mm/dd/yyyy"), "FechaReal", ""
            PMPasoValoresATX VGSqlConn, "@srv", 0, SQLVARCHAR, "", "SRVDESA2", ""
            If VLEmpresa = 19574 Then 'Movistar
                'Validacion Horario N/D
                If VGHorarioDif Then
                    VLItrn = "62689"
                    VLHorario = "D"
                Else
                    VLItrn = "62688"
                    VLHorario = "N"
                End If
                
            Else 'Tuenti
                'Validacion Horario N/D
                If VGHorarioDif Then
                    VLItrn = "62687"
                    VLHorario = "D"
                Else
                    VLItrn = "62686"
                    VLHorario = "N"
                End If
            End If
            PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLItrn, "Trn", ""
            PMPasoValoresATX VGSqlConn, "@i_trn", 0, SQLINT4, VLItrn, "i_trn", ""
            'Variables
            PMPasoValoresATX VGSqlConn, "@s_date", 0, SQLVARCHAR, Format$(VGFechaProceso, "yyyy-mm-dd") + "T" + Format$(Time(), "hh:mm:ss"), "FechaLocal", ""
            PMPasoValoresATX VGSqlConn, "@e_nombre_cta", 0, SQLVARCHAR, (Nombre.Text), "Nombre cuenta", ""
            PMPasoValoresATX VGSqlConn, "@e_comision_efe", 0, SQLMONEY, (VLEfe_com), "Com. efectivo", ""
            PMPasoValoresATX VGSqlConn, "@e_comision_chq", 0, SQLMONEY, (VLChq_com), "Com. Cheques", ""
            PMPasoValoresATX VGSqlConn, "@e_comision_db", 0, SQLMONEY, (VLDeb_com), "Com. Cheques", ""
            PMPasoValoresATX VGSqlConn, "@e_identificacion", 0, SQLVARCHAR, Me.txt_celular.Text, "Celular", ""
            PMPasoValoresATX VGSqlConn, "@e_comision_tot", 0, SQLMONEY, (Comision.Text), "valor de la comision", ""
            PMPasoValoresATX VGSqlConn, "@s_ssn_corr", 0, SQLINT4, val(SGSecTrn$), "", ""
            PMPasoValoresATX VGSqlConn, "@e_efectivo", 0, SQLMONEY, (efe.Text), "efe", ""
            PMPasoValoresATX VGSqlConn, "@s_sectrx", 1, SQLINT4, 0, "SecTrn", ""
            PMPasoValoresATX VGSqlConn, "@e_tipo_banca", 0, SQLVARCHAR, "BP", "BP", ""
            PMPasoValoresATX VGSqlConn, "@referencia", 0, SQLINT4, 0, "0", "sec"
                         
         If FMTransmitirRPCATX(VGSqlConn, "RECSRV", "cob_procesador", flujo, True, "Transaccion Ok", "S", "N", "S", "143", "S", "S") = True Then
       
                VTResult% = FMMapeaMatrizATX(VGSqlConn&, vtmatrizcps())
                VLTsnTemporal = VGTSN%
                PMChequeaATX VGSqlConn
                PMTotalesBranch "143"
                VLautprov = FLBuscarItem("@referencia")
                VLCambio% = False
                FLTransmitirCompraPaquete = True
                SGSecTrn$ = FLBuscarItem("@referencia")
                VLFechaContable = Format$(VGFechaProceso, "yyyy-mm-dd")
                    '------> Sumadora
                    VTIndicadorSum = 1
                    PMIniciaRegSum
                    '<-----
        Else
            VLCambio% = True
            FLTransmitirCompraPaquete = False
            'SGSecTrn$ = FMRetParamATX(VGSqlConn, 4)
            VTIndicadorSum = 0
            PMChequeaATX VGSqlConn
            '<------
        End If
                
        PMChequeaATX VGSqlConn
        If FMRetStatusATX(VGSqlConn) <> 0 Then
            VTIndicadorSum = 0
            VLCambio% = True
            FLTransmitirCompraPaquete = False
        End If
        PMChequeaATX VGSqlConn
               
        PMFinTransaccion
               


    
    If FLTransmitirCompraPaquete = True Then
      Call PLFactura
    End If
    
    'Sumadora -->
    If VGTipoEjecucion% <> CGReverso% Then   'Validacion por REVERSO
        If (VTIndicadorSum = 1 _
        And (Trim$(VGStatusCon) = "A" _
        Or Trim$(VGStatusCon) = "")) Then
            SGPrimeraVez = 0     ' ya no es primera vez
            PMGrabaDesglose VLItrn, CStr(SGUsar), VLCambio%
            If VLCambio% = True Then
                MsgBox "Error en la Grabacion del Desglose. Favor comuniquese con su Supervisor.", vbCritical, "Error de Sistema"
                FLTransmitirCompraPaquete = False
            End If
            SGActual = 1  'seteo Variable para borrar desglose
        ElseIf VTIndicadorSum = 0 Then
            SGActual = 0  'no borrar desglose en caso de Error en Transaccion
        End If
    ElseIf VTIndicadorSum = 1 Then                'Por REVERSO
              
        If Trim(txt_cod_servicio.Text) = "3" Then
            PMEgresoEfectivo SGUsar, VLTrn
        Else
            PMEgresoEfectivo SGUsar, VLTrn, VGSSNCorr&
        End If
        
    End If
    
    Exit Function
    
Error:
    MsgBox "Error al transmitir la transaccion " & Chr(13) & "Error:" & Err.Description, vbCritical
    FLTransmitirCompraPaquete = False
End Function
'jrocafuf
Function FLTransmitir_consulta_peaje() As Boolean
    
    Dim vl_procedure As String
    Dim vl_trx As String
    Dim vl_tipo_cons As String
    Dim vl_mensaje As String 'jrocafuf
    
    vl_tipo_cons = ""
    
    
    If Len(Trim$(Me.txt_cod_empresa.Text)) = 0 Then
        MsgBox "Campo empresa es Obligatorio para la consulta", vbCritical + vbOKOnly, "ATX"
        txt_cod_empresa.SetFocus
        Exit Function
    End If
    
    If Len(Trim$(Me.txt_contrato.Text)) = 0 Then
        MsgBox "Campo código es Obligatorio para la consulta", vbCritical + vbOKOnly, "ATX"
        txt_contrato.SetFocus
        Exit Function
    End If
            
    SGEmpresa = "8461"
    vl_procedure = ""
    vl_trx = ""
    
    If Me.txt_cod_empresa.Text = "8461" Then
        vl_procedure = "fp_con_peaje"
        vl_trx = "62680"
    End If

    VLGrupo = ""
    FPrincipal.Map.PMMapConfig "SHOWMESSAGE"
    
    PMChequea VGSqlConn&
    PMPasoValores VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "sv_grupo_empresas"
    PMPasoValores VGSqlConn&, "@i_tipo", 0, SQLCHAR, "V"
    PMPasoValores VGSqlConn&, "@i_codigo", 0, SQLVARCHAR, Trim$(Me.txt_cod_empresa.Text)
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
    FLTransmitir_consulta_peaje = False
    
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
    PMPasoValoresATX VGSqlConn, "@i_empresa", 0, SQLVARCHAR, Trim$(Me.txt_cod_empresa.Text), "CodEmpresa", ""
    PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, CStr(VGmoneda), "mon", ""
    PMPasoValoresATX VGSqlConn, "@i_tipoConsulta", 0, SQLVARCHAR, "C", "Empresa", ""
    PMPasoValoresATX VGSqlConn, "@i_subempresa", 0, SQLVARCHAR, Trim$(Me.txt_cod_empresa.Text), "SubEmpresa", ""
    PMPasoValoresATX VGSqlConn, "@i_codigo", 0, SQLVARCHAR, Trim$(Me.txt_contrato.Text), "Codigo", ""

    If FMTransmitirRPCATX(VGSqlConn, "BBTSSRV", "cob_procesador", vl_procedure, True, "Transaccion Ok", "S", "N", "N", "143", "S", "S") = True Then
    
        FLTransmitir_consulta_peaje = True
        
        If Me.txt_cod_empresa.Text = "8461" Then
            
            VTResult% = FMMapeaMatrizATX(VGSqlConn&, MatrizPeaje())

            If (FLBuscarItemPeaje("@o_Codigo_respuesta") = "0000") Then
                txt_nombreCliente.Text = FLBuscarItemPeaje("@o_nombre")
                
                SGActivaSum = False
                efe.Enabled = True
                txt_cod_empresa.Enabled = False
                cboTipoId.Enabled = False
                txt_contrato.Enabled = False
                txt_nombreCliente.Enabled = False
                CantChq.Enabled = False
                Cheques.Enabled = False
                CboTipCta.Enabled = True
                Cta.Enabled = True
                Debito.Enabled = True
                efe.SetFocus
                
            Else
                vl_mensaje = FLBuscarItemPeaje("@o_mensaje")
                MsgBox vl_mensaje, vbExclamation, App.Title
                FLTransmitir_consulta_peaje = False
                PMFinTransaccion
                PMChequeaATX VGSqlConn
                txt_contrato.SetFocus
                Exit Function
            End If

            

            

            
        
        Else

            VTResult% = FMMapeaMatrizATX(VGSqlConn&, MatrizPeaje())
            txt_nombreCliente.Text = FLBuscarItemPeaje("@o_nombre")
            
        End If
        
    Else
        FLTransmitir_consulta_peaje = False
        PMFinTransaccion
        PMChequeaATX VGSqlConn
        txt_contrato.SetFocus
        Exit Function
    End If
    PMChequeaATX VGSqlConn
    PMFinTransaccion
    'DoEvents
    
    If Me.txt_cod_empresa = "8461" Then
        'CONSULTA DE COMISION
        FPrincipal.Map.PMMapConfig "SHOWMESSAGE"
        
        PMInicioTransaccion
        PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 4050, "Trn", ""
        PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLVARCHAR, "C", "opcion", ""
        PMPasoValoresATX VGSqlConn, "@i_empresa", 0, SQLVARCHAR, Me.txt_cod_empresa.Text, "empresa", ""
        'PMPasoValoresATX VGSqlConn, "@i_servi_person", 0, SQLVARCHAR, "CSPR", "Servicio Person", ""
        'PMPasoValoresATX VGSqlConn, "@i_rubro_person", 0, SQLVARCHAR, "TPCV", "Rubro Person", ""
        PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Rubro Person", ""
        'Variables de salida
        PMPasoValoresATX VGSqlConn, "@o_comision", 1, SQLMONEY, 0, "Comision", ""
        PMPasoValoresATX VGSqlConn, "@o_tasa", 1, SQLMONEY, "0", "tasa", ""
        PMPasoValoresATX VGSqlConn, "@o_base_imp", 1, SQLMONEY, "0", "base_imp", ""
        PMPasoValoresATX VGSqlConn, "@o_impuesto", 1, SQLMONEY, "0", "impuesto", ""
        If FMTransmitirRPCATX(VGSqlConn, "", "cob_pagos", "sp_val_servicios_varios", True, "Transaccion Ok", "S", "N", "N", "143", "S", "S") = True Then
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
        
        
'            SGActivaSum = False
'            efe.Enabled = True
'            txt_cod_empresa.Enabled = False
'            cboTipoId.Enabled = False
'            txt_contrato.Enabled = False
'            CantChq.Enabled = True
'            Cheques.Enabled = True
'            CboTipCta.Enabled = True
'            Cta.Enabled = True
'            Debito.Enabled = True
'            efe.SetFocus
'
        PMChequeaATX VGSqlConn&
        PMFinTransaccion
        'FIN DE CONSULTA COMISION
    End If
    
    
    
End Function

'jrocafuf
Function FLTransmitir() As Integer 'nchavezb 03/16/2011
    Dim VTIndicadorSum As Integer
    Dim VLIndReverso As Boolean
    Dim flujo As String 'DAPV
    Dim tctaCSP As String 'DAPV
    Dim reverso As String 'DAPV
    Dim VLItrn As String
    Dim VLHorario As String
    Dim VLarreglo(30) As String
    
    VTIndicadorSum = 0
   
   'InvocaBoradnet kbastidz
    VLEmpresa = Trim(txt_cod_empresa.Text)
    
    If VLEmpresa = 19574 Or VLEmpresa = 19575 Then
          If FLVerificarCompraPaquete = True Then
            If FLTransmitirCompraPaquete = True Then
               FLTransmitir = True
            Else
               FLTransmitir = False
            End If
          Else
            FLTransmitir = False
          End If
          
          
          
          
          Exit Function
    End If
   'InvocaBroadnet kbastidz
  
   'jrocafuf
   If Trim(txt_cod_servicio.Text) <> "3" Then
        Consulta_parametro_OSB
   End If
        
        
   If Trim(txt_cod_servicio.Text) = "1" Then  'EMPRESAS RECARGAS'DAPV - 08/Nov/2011
               VLServicio = "Recaudacion"
               
               If VGHorarioDif Then
                   VLTrn = "3926"
               Else
                   VLTrn = "3925"
               End If
               VGTrn = IIf(VLTrn = "", 0, VLTrn)
               
               VLIndReverso = False
               If VGTipoEjecucion% = CGReverso% Then
                    VLIndReverso = True
               End If
               'VALIDACIONES
               Dim Fecha As String
               Fecha = Format$(Date, "yyyymmdd")
               
               Dim fr_ced_ruc As String
               fr_ced_ruc = Replace(SGCedula, "_", "")
               
               PMInicioTransaccion
                
               PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 62239, "Trn", ""
               PMPasoValoresATX VGSqlConn, "@i_TipoBusqueda", 0, SQLVARCHAR, "1", "Tipo busqueda", ""
               PMPasoValoresATX VGSqlConn, "@i_Codigo", 0, SQLVARCHAR, VCodigo, "Codigo para recarga", ""
               PMPasoValoresATX VGSqlConn, "@i_MontoRecarga", 0, SQLMONEY, (valor.Text), "", ""
               PMPasoValoresATX VGSqlConn, "@i_CodigoProducto", 0, SQLVARCHAR, "1", "1 Prepago", ""
               PMPasoValoresATX VGSqlConn, "@i_IdComercio", 0, SQLINT4, (VLIdComercio), "Codigo Id. Comercio", ""
               PMPasoValoresATX VGSqlConn, "@i_IdPuntoDeVenta", 0, SQLVARCHAR, String(8 - Len(Trim$(str$(VGOficina))), "0"), "Oficina", ""
               PMPasoValoresATX VGSqlConn, "@i_FechaTerminal", 0, SQLVARCHAR, Fecha, "fecha real", ""
               PMPasoValoresATX VGSqlConn, "@i_HoraTerminal", 0, SQLVARCHAR, Format$(Time(), "hhmmss"), "hora real", ""
               PMPasoValoresATX VGSqlConn, "@i_SeqTerminal", 0, SQLVARCHAR, "000", "Secuencial banco", ""
               '62242
               PMPasoValoresATX VGSqlConn, "@i_servicio", 0, SQLVARCHAR, val(txt_cod_servicio.Text), "SERVICIO", ""
               PMPasoValoresATX VGSqlConn, "@i_empresa", 0, SQLVARCHAR, val(txt_cod_empresa.Text), "EMPRESA", ""
               PMPasoValoresATX VGSqlConn, "@i_des_empresa", 0, SQLVARCHAR, (txt_des_empresa.Caption), "DESEMPRESA", ""
               PMPasoValoresATX VGSqlConn, "@i_des_servicio", 0, SQLVARCHAR, (txt_des_servicio.Caption), "SERVICIODES", ""
               PMPasoValoresATX VGSqlConn, "@i_efectivo", 0, SQLMONEY, (efe.Text), "efe", ""
               PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, (Cheques.Text), "Cheques", ""
               PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, (Debito.Text), "Debito", ""
               PMPasoValoresATX VGSqlConn, "@i_subtotal", 0, SQLMONEY, (valor.Text), "Subtotal", ""
               PMPasoValoresATX VGSqlConn, "@i_comision_tot", 0, SQLMONEY, (Comision.Text), "valor de la comision", ""
               PMPasoValoresATX VGSqlConn, "@i_comision_efe", 0, SQLMONEY, (VLEfe_com), "Com. efectivo", ""
               PMPasoValoresATX VGSqlConn, "@i_comision_chq", 0, SQLMONEY, (VLChq_com), "Com. Cheques", ""
               PMPasoValoresATX VGSqlConn, "@i_comision_db", 0, SQLMONEY, (VLDeb_com), "Com. Cheques", ""
               PMPasoValoresATX VGSqlConn, "@i_total", 0, SQLMONEY, (Total.Text), "Total pagado", ""
               PMPasoValoresATX VGSqlConn, "@i_cant_cheques", 0, SQLINT4, (CantChq.Text), "Cantidad de cheques", ""
               If Me.Cta.ClipText <> "" Then
                    PMPasoValoresATX VGSqlConn, "@i_tipo_cta", 0, SQLCHAR, CboTipCta.Text, "CboTipCta", ""
                    PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, Cta.ClipText, "Cta", ""
                    If Me.Debito.Text > 0 Then
                        PMPasoValoresATX VGSqlConn, "@i_nombre_cta", 0, SQLVARCHAR, (Nombre.Text), "Nombre cuenta", ""
                    End If
                Else
                    PMPasoValoresATX VGSqlConn, "@i_tipo_cta", 0, SQLCHAR, (VLTipCta_com), "CboTipCta", ""
                    PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (VLCta_com), "Cta", ""
                End If
               'PMPasoValoresATX VGSqlConn, "@i_tipo_cta", 0, SQLCHAR, (CboTipCta.Text), "Cantidad de cheques", ""
               'PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (Cta.ClipText), "Cta", ""
               'PMPasoValoresATX VGSqlConn, "@i_nombre_cta", 0, SQLVARCHAR, (Nombre.Text), "Nombre cuenta", ""
               PMPasoValoresATX VGSqlConn, "@i_autoriza", 0, SQLCHAR, VGAutoriza, "Autorizacion", ""
               PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Ventanilla", ""
               PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(FMObtenerMonedaForma("143")), "Moneda", ""
               
               If VGTipoEjecucion% = CGReverso% Then
                  VGReversoLoger$ = "N"
                   PMPasoValoresATX VGSqlConn, "@i_cod_pre_autorizacion", 0, SQLVARCHAR, VLPreAutorizacion, "Cod.Preautorizacion DIRECTV", ""
                   PMPasoValoresATX VGSqlConn, "@i_cod_autorizacion", 0, SQLVARCHAR, VLCodAutorizacion, "Cod.autorizacion DIRECTV", ""
                   'NombreSuscriptor
                   PMPasoValoresATX VGSqlConn, "@i_nombre_suscrip", 0, SQLVARCHAR, VLNombSuscr, "nombre suscriptor", ""
                   VGReversoLoger$ = "S"
               Else
                   PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLCHAR, "N", "@t_corr", ""
                   PMPasoValoresATX VGSqlConn, "@i_cod_pre_autorizacion", 0, SQLVARCHAR, "", "Cod.Preautorizacion DIRECTV", ""
                   PMPasoValoresATX VGSqlConn, "@i_cod_autorizacion", 0, SQLVARCHAR, "", "Cod.autorizacion DIRECTV", ""
                   'NombreSuscriptor
                   PMPasoValoresATX VGSqlConn, "@i_nombre_suscrip", 0, SQLVARCHAR, "", "nombre suscriptor", ""
                   'DATOS PARA LA FACTURA
                   PMPasoValoresATX VGSqlConn, "@i_ced_ruc", 0, SQLVARCHAR, Trim$(fr_ced_ruc), "Cedula factura", ""
                   PMPasoValoresATX VGSqlConn, "@i_nombre", 0, SQLVARCHAR, Trim$(VLNombre_com), "Nombre de factura comision", ""
                   PMPasoValoresATX VGSqlConn, "@i_servicio_fact", 0, SQLVARCHAR, VLServicio, "Servicio factura", ""
                End If
                
                'verificacion de la forma de pago
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
    
               'valores de salida
               'TRX 62242
               PMPasoValoresATX VGSqlConn, "@o_fecha_efectivo", 1, SQLVARCHAR, "XXXXXXXXXX", "Feccontable", ""
               PMPasoValoresATX VGSqlConn, "@o_ssn", 1, SQLINT4, 0, "0", "sec"
               PMPasoValoresATX VGSqlConn, "@o_autorisri", 1, SQLVARCHAR, "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", "", ""
               PMPasoValoresATX VGSqlConn, "@o_fecvensri", 1, SQLVARCHAR, "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", "", ""
               PMPasoValoresATX VGSqlConn, "@o_nota_venta", 1, SQLVARCHAR, "xxxxxxxxxxxxxxx", "", ""
               PMPasoValoresATX VGSqlConn, "@o_fact_elect", 1, SQLCHAR, "x", "", ""
               
               PMPasoValoresATX VGSqlConn, "@o_Cod_Pre_Autorizacion", 1, SQLVARCHAR, "xxxxxxxxxxxxxxx", "", ""
               PMPasoValoresATX VGSqlConn, "@o_cod_autorizacion", 1, SQLVARCHAR, "xxxxxxxxxxxxxx", "", ""
               
               'NombreSuscriptor
               PMPasoValoresATX VGSqlConn, "@o_nombre_suscrip", 1, SQLVARCHAR, "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", "", ""
               PMPasoValoresATX VGSqlConn, "@o_fecdessri", 1, SQLVARCHAR, "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", "", ""
               PMPasoValoresATX VGSqlConn, "@o_horario", 1, SQLCHAR, "x", "", ""
               'smerino nuevas variabls de autorizacion de sri
               PMPasoValoresATX VGSqlConn, "@o_fec_ini_vig_aut", 1, SQLVARCHAR, "x", "", ""
               PMPasoValoresATX VGSqlConn, "@o_fec_fin_vig_aut", 1, SQLVARCHAR, "x", "", ""
               'PMPasoValoresATX VGSqlConn, "@o_Codigo_respuesta", 1, SQLINT4, 0, "", ""
               'PMPasoValoresATX VGSqlConn, "@o_NumeroSerieTarjeta", 1, SQLVARCHAR, "xxxxxxxxxx", "", ""
               'PMPasoValoresATX VGSqlConn, "@o_Monto", 1, SQLMONEY, "", "", ""
               
            If FMTransmitirRPCATX(VGSqlConn, vl_servidor_BUS, "cob_procesador", "fp_recarga_electronica", True, "Transaccion Ok", "S", "N", "S", "143", "S", "S") = True Then 'dpereirv SOA fase2
            'If FMTransmitirRPCATX(VGSqlConn, "PSSRV1", "cob_procesador", "fp_recarga_electronica", True, "Transaccion Ok", "S", "N", "S", "143", "S", "S") = True Then
                 VTResult% = FMMapeaMatrizATX(VGSqlConn&, vtmatrizcps()) 'dpereirv SOA fase2
                 VLTsnTemporal = VGTSN%
                 PMChequeaATX VGSqlConn
                 PMTotalesBranch "143"
                 VLCambio% = False
                 '------> Sumadora
                 If vl_servidor_BUS = "PSSRV1" Then
                    SGSecTrn$ = FMRetParamATX(VGSqlConn, 2)
                    VLSSnCorreccion = FMRetParamATX(VGSqlConn, 2)
                         
                    
                    VLMG_ossn = FMRetParamATX(VGSqlConn, 2)
                    VLSsn = FMRetParamATX(VGSqlConn, 2)
                    VLMG_autorisri = FMRetParamATX(VGSqlConn, 3)
                    VLautoriSri = Trim(VLMG_autorisri)
                    VLMG_fecvensri = FMRetParamATX(VGSqlConn, 4)
                    VLFecvenSRI = Trim(VLMG_fecvensri)
                    'smerino fechas de vigencia de autorización de SRI
                    VLMG_Fecinivig = FMRetParamATX(VGSqlConn, 12)
                    VLFecinivig = Trim(VLMG_Fecinivig) 'sme 06/08/2011
                    VLMG_Fecfinvig = FMRetParamATX(VGSqlConn, 13)
                    VLFecfinvig = Trim(VLMG_Fecfinvig) 'sme 06/08/2011
                    'fin smerino
                    VLCodPreAutorizacion = FMRetParamATX(VGSqlConn, 7)
                    VLCodAutorizacion = FMRetParamATX(VGSqlConn, 8)
                    VLFechaContable = FMRetParamATX(VGSqlConn, 1)
                    VLSerie_Secuencia = FMRetParamATX(VGSqlConn, 5)
                    VLImprCompComi = FMRetParamATX(VGSqlConn, 6)
                    VLNombSuscr = FMRetParamATX(VGSqlConn, 9)
                Else
                    '------> Sumadora
                    SGSecTrn$ = FLBuscarItem("@o_ssn") 'FMRetParamATX(VGSqlConn, 2)
                    VLSSnCorreccion = FLBuscarItem("@o_ssn") 'FMRetParamATX(VGSqlConn, 2)
                    
                    VLMG_ossn = FLBuscarItem("@o_ssn") 'FMRetParamATX(VGSqlConn, 2)
                    VLSsn = FLBuscarItem("@o_ssn") 'FMRetParamATX(VGSqlConn, 2)
                    VLMG_autorisri = FLBuscarItem("@o_autorisri") 'FMRetParamATX(VGSqlConn, 3)
                    VLautoriSri = Trim(VLMG_autorisri)
                    VLMG_fecvensri = FLBuscarItem("@o_fecvensri") 'FMRetParamATX(VGSqlConn, 4)
                    VLFecvenSRI = Trim(VLMG_fecvensri)
                    'smerino fechas de vigencia de autorización de SRI
                    VLMG_Fecinivig = FLBuscarItem("@o_fec_ini_vig_aut") 'FMRetParamATX(VGSqlConn, 12)
                    VLFecinivig = Trim(VLMG_Fecinivig) 'sme 06/08/2011
                    VLMG_Fecfinvig = FLBuscarItem("@o_fec_fin_vig_aut") 'FMRetParamATX(VGSqlConn, 13)
                    VLFecfinvig = Trim(VLMG_Fecfinvig) 'sme 06/08/2011
                    'fin smerino
                    VLCodPreAutorizacion = FLBuscarItem("@o_Cod_Pre_Autorizacion") 'FMRetParamATX(VGSqlConn, 7)
                    VLCodAutorizacion = FLBuscarItem("@o_cod_autorizacion") 'FMRetParamATX(VGSqlConn, 8)
                    VLFechaContable = FLBuscarItem("@o_fecha_efectivo") 'FMRetParamATX(VGSqlConn, 1)
                    VLSerie_Secuencia = FLBuscarItem("@o_nota_venta") 'FMRetParamATX(VGSqlConn, 5)
                    VLImprCompComi = FLBuscarItem("@o_fact_elect") 'FMRetParamATX(VGSqlConn, 6)
                    VLNombSuscr = FLBuscarItem("@o_nombre_suscrip") 'FMRetParamATX(VGSqlConn, 9)
                End If
                
                 PMChequeaATX VGSqlConn
                   PMTotalesBranch "143"
                   FLTransmitir = True
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
                   FLTransmitir = False
                   'TPE ------> Sumadora
                   'dpereirv Inicio
                   If vl_servidor_BUS = "PSSRV1" Then
                        SGSecTrn$ = FMRetParamATX(VGSqlConn, 2)
                    Else
                        SGSecTrn$ = FLBuscarItem("@o_ssn") 'FMRetParamATX(VGSqlConn, 2)
                   End If
                   'dpereirv Fin
                   
                   VTIndicadorSum = 0
                   PMChequeaATX VGSqlConn
                   '<------
               End If
               PMChequeaATX VGSqlConn
               If FMRetStatusATX(VGSqlConn) <> 0 Then
                   VTIndicadorSum = 0
                   FLTransmitir = False
               End If
               PMFinTransaccion
    End If

    If Trim(txt_cod_servicio.Text) = "2" Then 'CELULARES RECARGA 'DAPV - 08/Nov/2011
        FLTransmitir = True
            
            VLEmpresa = Trim(txt_cod_empresa.Text)
            
            If VLEmpresa = 39 Then
                VLTrn = "62263"
                flujo = "fp_pago_claro"
            'msilvag Inicio CLAPAQ-AP-SGC00032311-SGC00032313
            ElseIf VLEmpresa = 40 Then
                VLTrn = "62672"
                flujo = "fp_recarga_claro"
            'msilvag Fin
            Else
                VLTrn = "62195"
                flujo = "mp_pago_movistar"
            End If
            
            If CCur(Debito.Text) > 0 Then
                If VLtCTA = "CTE" Then
                    tctaCSP = "CC"
                Else
                    tctaCSP = "CA"
                End If
            Else
                tctaCSP = "EF"
            End If
            
            'msilvag Inicio CLAPAQ-AP-SGC00032311-SGC00032313
            If VLEmpresa = 40 Then
                
                
                VLProcesoClaro = ""
                VLTerminalClaro = ""
                VLOperacionClaro = ""
                VLConsumerClaro = ""
            
                'Consulta Proceso Proveedor de Claro Paquetes
                PMChequea VGSqlConn&
                PMPasoValores VGSqlConn, "@t_trn", 0, SQLINT2, 1579
                PMPasoValores VGSqlConn&, "@i_operacion", 0, SQLVARCHAR, "Q"
                PMPasoValores VGSqlConn&, "@i_nemonico", 0, SQLVARCHAR, "PPCLP"
                PMPasoValores VGSqlConn&, "@i_producto", 0, SQLVARCHAR, "CTE"
                If FMTransmitirRPC(VGSqlConn, VGServerNameRec$, "cobis", "sp_parametro", True, "Transaccion Ok") = True Then
                  VTR1% = FMMapeaArreglo(VGSqlConn&, VLarreglo())
                  VLProcesoClaro = LTrim(RTrim(Trim(VLarreglo(4))))
                  'VLProcesoClaro = VLarreglo(4)
                Else
                  VLProcesoClaro = ""
                End If
                PMChequea VGSqlConn&
                
                'Consulta Terminal Host Claro Paquetes
                PMChequea VGSqlConn&
                PMPasoValores VGSqlConn, "@t_trn", 0, SQLINT2, 1579
                PMPasoValores VGSqlConn&, "@i_operacion", 0, SQLVARCHAR, "Q"
                PMPasoValores VGSqlConn&, "@i_nemonico", 0, SQLVARCHAR, "THCLP"
                PMPasoValores VGSqlConn&, "@i_producto", 0, SQLVARCHAR, "CTE"
                If FMTransmitirRPC(VGSqlConn, VGServerNameRec$, "cobis", "sp_parametro", True, "Transaccion Ok") = True Then
                  VTR1% = FMMapeaArreglo(VGSqlConn&, VLarreglo())
                  VLTerminalClaro = LTrim(RTrim(Trim(VLarreglo(4))))
                Else
                  VLTerminalClaro = ""
                End If
                PMChequea VGSqlConn&
                
                
                'Consulta Operacion del proveedor de Claro Paquetes
                PMChequea VGSqlConn&
                PMPasoValores VGSqlConn, "@t_trn", 0, SQLINT2, 1579
                PMPasoValores VGSqlConn&, "@i_operacion", 0, SQLVARCHAR, "Q"
                PMPasoValores VGSqlConn&, "@i_nemonico", 0, SQLVARCHAR, "OPCLP"
                PMPasoValores VGSqlConn&, "@i_producto", 0, SQLVARCHAR, "CTE"
                If FMTransmitirRPC(VGSqlConn, VGServerNameRec$, "cobis", "sp_parametro", True, "Transaccion Ok") = True Then
                  VTR1% = FMMapeaArreglo(VGSqlConn&, VLarreglo())
                  VLOperacionClaro = LTrim(RTrim(Trim(VLarreglo(4))))
                Else
                  VLOperacionClaro = ""
                End If
                PMChequea VGSqlConn&
                
                'Consulta Consumer ID Claro Paquetes
                PMChequea VGSqlConn&
                PMPasoValores VGSqlConn, "@t_trn", 0, SQLINT2, 1579
                PMPasoValores VGSqlConn&, "@i_operacion", 0, SQLVARCHAR, "Q"
                PMPasoValores VGSqlConn&, "@i_nemonico", 0, SQLVARCHAR, "CICLP"
                PMPasoValores VGSqlConn&, "@i_producto", 0, SQLVARCHAR, "CTE"
                If FMTransmitirRPC(VGSqlConn, VGServerNameRec$, "cobis", "sp_parametro", True, "Transaccion Ok") = True Then
                  VTR1% = FMMapeaArreglo(VGSqlConn&, VLarreglo())
                  VLConsumerClaro = LTrim(RTrim(Trim(VLarreglo(4))))
                Else
                  VLConsumerClaro = ""
                End If
                PMChequea VGSqlConn&
                
            End If
            'msilvag Fin
            
            On Error GoTo Error:
            PMInicioTransaccion

                        If vl_servidor_BUS <> "PSSRV1" Then
                                'msilvag Inicio
                                        If VGTipoEjecucion% <> CGReverso% Then
                                                PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLVARCHAR, "N", "TCorr", ""
                                        End If
                                'msilvag Fin
                        End If
            PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, VLTrn, "Trn", ""
            PMPasoValoresATX VGSqlConn, "@i_empresa", 0, SQLINT4, CInt(VLEmpresa), "Empresa", ""
            PMPasoValoresATX VGSqlConn, "@i_telefono", 0, SQLVARCHAR, Me.txt_celular.Text, "Celular", ""
    
            If VLIdentificacion <> "PAS" Then
                PMPasoValoresATX VGSqlConn, "@i_ced_ruc", 0, SQLVARCHAR, Trim(Right("0000000000000" + Identificacion.Text, 13)), "Cedula", ""
            Else
                PMPasoValoresATX VGSqlConn, "@i_pasaporte", 0, SQLVARCHAR, Trim(Identificacion.Text), "Pasaporte", ""
                PMPasoValoresATX VGSqlConn, "@i_ced_ruc", 0, SQLVARCHAR, "9999999999999", "Cedula", ""
            End If
    
            PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, Cta.ClipText, "Cta", ""
            PMPasoValoresATX VGSqlConn, "@i_tipocta", 0, SQLCHAR, VLtCTA, "CboTipCta", ""
            PMPasoValoresATX VGSqlConn, "@i_moneda", 0, SQLINT1, str(FMObtenerMonedaForma("131")), "Moneda", ""
            PMPasoValoresATX VGSqlConn, "@i_val", 0, SQLMONEY, efe.Text, "Efectivo", ""
            PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, Debito.Text, "Debito", ""
            PMPasoValoresATX VGSqlConn, "@i_opcion", 0, SQLCHAR, "P", "Opcion", ""
            PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Canal", ""
            If Me.txt_cod_empresa.Text = 39 Then
                PMPasoValoresATX VGSqlConn, "@i_canal_broadnet", 0, SQLVARCHAR, "03", "Canal", ""
            Else
                If Me.txt_cod_empresa.Text = 103 Then
                    PMPasoValoresATX VGSqlConn, "@i_canal_broadnet", 0, SQLVARCHAR, "08", "Canal", ""
                End If
            End If
            
            'msilvag CLAPAQ-AP-SGC00032311-SGC00032313
            If Me.txt_cod_empresa.Text = 40 Then
                
                PMPasoValoresATX VGSqlConn, "@i_proceProveedor", 0, SQLVARCHAR, VLProcesoClaro, "ProceProveedor", ""
                PMPasoValoresATX VGSqlConn, "@i_terminalHost", 0, SQLVARCHAR, VLTerminalClaro, "TerminalHost", ""
                PMPasoValoresATX VGSqlConn, "@i_opeProveedor", 0, SQLVARCHAR, VLOperacionClaro, "OpeProveedor", ""
                PMPasoValoresATX VGSqlConn, "@i_consumer", 0, SQLVARCHAR, VLConsumerClaro, "ConsumerID", ""
                'PMPasoValoresATX VGSqlConn, "@i_proceProveedor", 0, SQLVARCHAR, "132", "ProceProveedor", ""
                'PMPasoValoresATX VGSqlConn, "@i_terminalHost", 0, SQLVARCHAR, "172.16.30.152", "TerminalHost", ""
                'PMPasoValoresATX VGSqlConn, "@i_opeProveedor", 0, SQLVARCHAR, "RECARGA_DATOS", "OpeProveedor", ""
                'PMPasoValoresATX VGSqlConn, "@i_consumer", 0, SQLVARCHAR, "BOLIVARIANO_001", "ConsumerID", ""
                
            End If
            'msilvag Fin
            
            PMPasoValoresATX VGSqlConn, "@i_autoriza", 0, SQLCHAR, VGAutoriza, "Autorizacion", ""
            PMPasoValoresATX VGSqlConn, "@i_aplcobis", 0, SQLCHAR, "S", "aplcobis", ""
            PMPasoValoresATX VGSqlConn, "@i_nombre", 0, SQLVARCHAR, (Me.NombreCliente.Text), "Nombre", ""
            PMPasoValoresATX VGSqlConn, "@i_total", 0, SQLMONEY, (Total.Text), "Total", ""
            PMPasoValoresATX VGSqlConn, "@i_tipo_id", 0, SQLCHAR, VLIdentificacion, "Tipo Id", ""
            PMPasoValoresATX VGSqlConn, "@i_fecha_real", 0, SQLVARCHAR, Format(Date, "mm/dd/yyyy"), "FechaReal", ""
            PMPasoValoresATX VGSqlConn, "@i_cant_chq", 0, SQLINT1, CantChq.Text, "CantCheque", ""
            PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, Cheques.Text, "ValorCheque", ""
                        
            If VLEmpresa = 103 Then
                PMPasoValoresATX VGSqlConn, "@i_pfecha", 0, SQLVARCHAR, Format(Date, "YYYY-MM-DD"), "LocalTransactionDate", ""
                PMPasoValoresATX VGSqlConn, "@i_pservicecode", 0, SQLINT4, 827623, "CodeService", ""
                If CCur(Debito.Text) > 0 Then
                    If VLtCTA = "CTE" Then
                        PMPasoValoresATX VGSqlConn, "@i_pproccod", 0, SQLINT4, 20, "ProcessingCode", ""
                    Else
                        PMPasoValoresATX VGSqlConn, "@i_pproccod", 0, SQLINT4, 10, "ProcessingCode", ""
                    End If
                Else
                    PMPasoValoresATX VGSqlConn, "@i_pproccod", 0, SQLVARCHAR, "00", "ProcessingCode", ""
                End If
                PMPasoValoresATX VGSqlConn, "@i_pcodempresa", 0, SQLVARCHAR, "01", "CodEmpresa", ""
                PMPasoValoresATX VGSqlConn, "@i_pcodproducto", 0, SQLVARCHAR, "02", "CodProducto", ""
                PMPasoValoresATX VGSqlConn, "@i_phoralocal", 0, SQLVARCHAR, Format(Time, "HHMMSS"), "LocalTransactionTime", ""
                PMPasoValoresATX VGSqlConn, "@i_pfechacontable", 0, SQLVARCHAR, Format(Date, "YYYYMMDD"), "FechaContable", ""
            End If
            If VLEmpresa = 39 Then
                PMPasoValoresATX VGSqlConn, "@i_codmsg", 0, SQLINT1, 22, "CodMsg", ""
                PMPasoValoresATX VGSqlConn, "@i_ptipocta ", 0, SQLVARCHAR, tctaCSP, "TCtaCSP", ""
                PMPasoValoresATX VGSqlConn, "@i_pfecha", 0, SQLVARCHAR, Format(Date, "YYYY/DD/MM"), "LocalTransactionDate", ""
            End If
    
            If Me.txt_cod_empresa <> 40 Then
                PMPasoValoresATX VGSqlConn, "@o_horario", 1, SQLCHAR, "X", "Horario Pago", ""
                PMPasoValoresATX VGSqlConn, "@o_msg", 1, SQLVARCHAR, "X", "Mensaje", ""
                PMPasoValoresATX VGSqlConn, "@o_autorizacion", 1, SQLVARCHAR, "X", "Mensaje", ""
                PMPasoValoresATX VGSqlConn, "@o_sectrx", 1, SQLINT4, 0, "SecTrn", ""
                PMPasoValoresATX VGSqlConn, "@o_autoriza", 1, SQLVARCHAR, "X", "Autoriza", ""
                PMPasoValoresATX VGSqlConn, "@o_fecvensri", 1, SQLVARCHAR, "X", "FechaVencimiento", ""
                PMPasoValoresATX VGSqlConn, "@o_resolucion", 1, SQLVARCHAR, "X", "Resolucion", ""
                PMPasoValoresATX VGSqlConn, "@o_ruc_empresa", 1, SQLVARCHAR, "X", "RucEmpresa", ""
                PMPasoValoresATX VGSqlConn, "@o_direccion", 1, SQLVARCHAR, "X", "Direccion", ""
                If vl_servidor_BUS = "PSSRV1" Then
                    PMPasoValoresATX VGSqlConn, "@o_empresa", 1, SQLVARCHAR, "X", "Empresa", ""
                    PMPasoValoresATX VGSqlConn, "@o_notaventa", 1, SQLVARCHAR, "X", "NoVenta", ""
                End If
        
                If VLEmpresa = 39 Then
                    PMPasoValoresATX VGSqlConn, "@o_autoriza_proveedor", 1, SQLVARCHAR, "X", "aut_prov", ""
                    PMPasoValoresATX VGSqlConn, "@o_neto", 1, SQLMONEY, 0, "Neto", ""
                    PMPasoValoresATX VGSqlConn, "@o_iva", 1, SQLMONEY, 0, "Iva", ""
                    PMPasoValoresATX VGSqlConn, "@o_ice", 1, SQLMONEY, 0, "Ice", ""
                    PMPasoValoresATX VGSqlConn, "@o_fecdesde", 1, SQLVARCHAR, "X", "fecdesde", ""
                End If
            End If
            
            If Me.txt_cod_empresa = 40 Then
                PMPasoValoresATX VGSqlConn, "@o_cod_recarga", 1, SQLVARCHAR, "X", "CodRecarga", ""
            End If
            
            
            If VLEmpresa = 103 Then
                reverso = "S"
            Else
                reverso = "S"
            End If

        
         If FMTransmitirRPCATX(VGSqlConn, vl_servidor_BUS, "cob_procesador", flujo, True, "Transaccion Ok", "S", "N", reverso, "143", "S", "S") = True Then
            If vl_servidor_BUS = "PSSRV1" Then
                If VGTipoEjecucion% <> CGReverso% Then   'Validacion por REVERSO
                    PMMapeaGridATX VGSqlConn, grdDetalle, False
                    PMMapeaGridATX VGSqlConn, grdDetalle, False
                    PMMapeaGridATX VGSqlConn, grdDetalle, False
                End If
                
                PMChequeaATX VGSqlConn
                PMTotalesBranch "143"
                FLTransmitir = True
                VLCambio% = False
                '------> Sumadora
                VLHorario = FMRetParamATX(VGSqlConn, 1)
                SGSecTrn$ = FMRetParamATX(VGSqlConn, 4)
                VLautoriza = FMRetParamATX(VGSqlConn, 5)
                VLFecvenSRI = FMRetParamATX(VGSqlConn, 6)
                VLResolucion = FMRetParamATX(VGSqlConn, 7)
                VLRucEmpresa = FMRetParamATX(VGSqlConn, 8)
                VLDireccion = FMRetParamATX(VGSqlConn, 9)
                VLRazon = FMRetParamATX(VGSqlConn, 10)
                VLNoVenta = FMRetParamATX(VGSqlConn, 11)
                If VLEmpresa = 103 Then
                    VLautprov = FMRetParamATX(VGSqlConn, 3)
                End If
                PLTipoTransaccion VLHorario
                
                If VLEmpresa = 39 Then
                        VLautprov = FMRetParamATX(VGSqlConn, 12)
                        VLNeto = FMRetParamATX(VGSqlConn, 13)
                        VLiva = FMRetParamATX(VGSqlConn, 14)
                        VLice = FMRetParamATX(VGSqlConn, 15)
                Else
                If VGTipoEjecucion% <> CGReverso% Then   'Validacion por REVERSO
                        grdDetalle.Row = 1
                        grdDetalle.Col = 7
                        vlrazonb = grdDetalle.Text
                        grdDetalle.Row = 1
                        grdDetalle.Col = 6
                        vl_direc1 = Left(grdDetalle.Text, 22)
                        vl_direc2 = Mid(grdDetalle.Text, 23, Len(Trim(grdDetalle.Text)))
                        grdDetalle.Col = 5
                        vlrucbroadnet = grdDetalle.Text
                        grdDetalle.Col = 10
                        VLNeto = grdDetalle.Text
                        grdDetalle.Col = 11
                        VLiva = grdDetalle.Text
                End If
                End If
                                
                VTIndicadorSum = 1
                PMIniciaRegSum
                '<-----
            Else
                VTResult% = FMMapeaMatrizATX(VGSqlConn&, vtmatrizcps())
                PMChequeaATX VGSqlConn
                PMTotalesBranch "143"
                FLTransmitir = True
                VLCambio% = False
                '------> Sumadora
                
                'msilvag Inicio CLAPAQ-AP-SGC00032311-SGC00032313
                If Me.txt_cod_empresa = 40 Then
                    VLautprov = FLBuscarItem("@o_cod_recarga")
                    SGSecTrn$ = FLBuscarItem("@o_ssn")
                    
                    VLFecvenSRI = FLBuscarItem("@o_fecha_contable")
                    VLFecvenSRI = Left(VLFecvenSRI, 10)
                    VLFecvenSRI = Format(VLFecvenSRI, "mm/dd/yyyy")
                    
                    VLFechaContable = FLBuscarItem("@o_fecha_contable")
                    VLFechaContable = Left(VLFechaContable, 10)
                    VLFechaContable = Format(VLFechaContable, "mm/dd/yyyy")
                    VLHorario = FLBuscarItem("@o_horario")
                    
                    PLTipoTransaccion VLHorario
                    
                    If VGTipoEjecucion% <> CGReverso% Then
                      VLautoriza2 = FMRetParamATX(VGSqlConn, 1)
                    End If
                    
                    'PMChequeaATX VGSqlConn
                End If
                'msilvag FIn
                
                If Me.txt_cod_empresa <> 40 Then
                    VLHorario = FLBuscarItem("@o_horario") 'FMRetParamATX(VGSqlConn, 1)
                    SGSecTrn$ = FLBuscarItem("@o_sectrx") 'FMRetParamATX(VGSqlConn, 4)
                    VLautoriza = FLBuscarItem("@o_autoriza") 'FMRetParamATX(VGSqlConn, 5)
                    VLFecvenSRI = FLBuscarItem("@o_fecvensri") 'FMRetParamATX(VGSqlConn, 6)
                    VLResolucion = FLBuscarItem("@o_resolucion") 'FMRetParamATX(VGSqlConn, 7)
                    VLRucEmpresa = FLBuscarItem("@o_ruc_empresa") 'FMRetParamATX(VGSqlConn, 8)
                    VLDireccion = FLBuscarItem("@o_direccion") 'FMRetParamATX(VGSqlConn, 9)
                    VLRazon = FLBuscarItem("@o_empresa") 'FMRetParamATX(VGSqlConn, 10)
                    VLNoVenta = FLBuscarItem("@o_notaventa") 'FMRetParamATX(VGSqlConn, 11)
                    If VLEmpresa = 103 Then 'Movistar
                        VLFechaContable = FLBuscarItem("@o_fcontable")
                    Else
                        VLFechaContable = FLBuscarItem("@o_feccontable")
                    End If
                                                            
                    If VLEmpresa = 103 Then
                            VLautprov = FLBuscarItem("@o_autorizacion") 'FMRetParamATX(VGSqlConn, 3)
                    End If
                    PLTipoTransaccion VLHorario
                    If VLEmpresa = 39 Then
                            VLautprov = FLBuscarItem("@o_autoriza_proveedor") 'FMRetParamATX(VGSqlConn, 12)
                            VLNeto = FLBuscarItem("@o_neto") 'FMRetParamATX(VGSqlConn, 13)
                            VLiva = FLBuscarItem("@o_iva") 'FMRetParamATX(VGSqlConn, 14)
                            VLice = FLBuscarItem("@o_ice") 'FMRetParamATX(VGSqlConn, 15)
                    Else
                        If VGTipoEjecucion% <> CGReverso% Then   'Validacion por REVERSO
                            vlrazonb = VLRazon 'grdDetalle.Text
                            vl_direc1 = Left(VLDireccion, 22) 'Left(grdDetalle.Text, 22)
                            vl_direc2 = Mid(VLDireccion, 23, Len(Trim(VLDireccion))) 'Mid(grdDetalle.Text, 23, Len(Trim(grdDetalle.Text)))
                            vlrucbroadnet = VLRucEmpresa  'grdDetalle.Text
                            VLNeto = FLBuscarItem("@o_neto") 'grdDetalle.Text
    
                            VLiva = FLBuscarItem("@o_iva") 'grdDetalle.Text
    
                        End If
                    End If
                End If
                 
                VTIndicadorSum = 1
                PMIniciaRegSum
                                                '<-----
            End If
        Else
            VLCambio% = True
            FLTransmitir = False
            'TPE ------> Sumadora
                                If vl_servidor_BUS = "PSSRV1" Then
                                        SGSecTrn$ = FMRetParamATX(VGSqlConn, 4)
                                End If
            VTIndicadorSum = 0
            PMChequeaATX VGSqlConn
            
            '<------
        End If
                
                PMChequeaATX VGSqlConn
               
               If FMRetStatusATX(VGSqlConn) <> 0 Then
                  VTIndicadorSum = 0
                  VLCambio% = True
                  FLTransmitir = False
               End If
               PMChequeaATX VGSqlConn
               PMFinTransaccion
               
    End If
    
    'jrocafuf
    
    If Trim(txt_cod_servicio.Text) = "3" Then  'PEAJE 09/ABR/2021 JROCAFUF
               VLServicio = "Recaudacion"
               
               If VGHorarioDif Then
                   VLTrn = "3926"
               Else
                   VLTrn = "3925"
               End If
               VGTrn = IIf(VLTrn = "", 0, VLTrn)
               
               VLIndReverso = False
               If VGTipoEjecucion% = CGReverso% Then
                    VLIndReverso = True
               End If
               
               Fecha = Format$(Date, "yyyymmdd")
               fr_ced_ruc = Replace(SGCedula, "_", "")
               
               PMInicioTransaccion
                
               PMPasoValoresATX VGSqlConn, "@i_canal", 0, SQLVARCHAR, "VEN", "Ventanilla", ""
               PMPasoValoresATX VGSqlConn, "@t_trn", 0, SQLINT4, 62681, "Trn", ""
               PMPasoValoresATX VGSqlConn, "@o_ssn", 0, SQLINT4, 0, "0", "sec"
               PMPasoValoresATX VGSqlConn, "@i_codigo", 0, SQLVARCHAR, Me.txt_contrato.Text, "Codigo", ""
               PMPasoValoresATX VGSqlConn, "@i_nom_cliente", 0, SQLVARCHAR, Me.txt_nombreCliente.Text, "Nombre Cliente", ""
                                            
               PMPasoValoresATX VGSqlConn, "@i_SeqTerminal", 0, SQLVARCHAR, "000", "Secuencial banco", ""
               PMPasoValoresATX VGSqlConn, "@i_TipoBusqueda", 0, SQLVARCHAR, "1", "Tipo busqueda", ""
               PMPasoValoresATX VGSqlConn, "@i_MontoRecarga", 0, SQLMONEY, (valor.Text), "", ""
               PMPasoValoresATX VGSqlConn, "@i_CodigoProducto", 0, SQLVARCHAR, "1", "1 Prepago", ""
               PMPasoValoresATX VGSqlConn, "@i_IdComercio", 0, SQLINT4, (VLIdComercio), "Codigo Id. Comercio", ""
               PMPasoValoresATX VGSqlConn, "@i_IdPuntoDeVenta", 0, SQLVARCHAR, String(8 - Len(Trim$(str$(VGOficina))), "0"), "Oficina", ""
               PMPasoValoresATX VGSqlConn, "@i_FechaTerminal", 0, SQLVARCHAR, Fecha, "fecha real", ""
               PMPasoValoresATX VGSqlConn, "@i_HoraTerminal", 0, SQLVARCHAR, Format$(Time(), "hhmmss"), "hora real", ""
               
               PMPasoValoresATX VGSqlConn, "@i_servicio", 0, SQLVARCHAR, val(txt_cod_servicio.Text), "SERVICIO", ""
               PMPasoValoresATX VGSqlConn, "@i_empresa", 0, SQLVARCHAR, val(txt_cod_empresa.Text), "EMPRESA", ""
               PMPasoValoresATX VGSqlConn, "@i_des_empresa", 0, SQLVARCHAR, (txt_des_empresa.Caption), "DESEMPRESA", ""
               PMPasoValoresATX VGSqlConn, "@i_des_servicio", 0, SQLVARCHAR, (txt_des_servicio.Caption), "SERVICIODES", ""
               PMPasoValoresATX VGSqlConn, "@i_efectivo", 0, SQLMONEY, (efe.Text), "efe", ""
               PMPasoValoresATX VGSqlConn, "@i_cheque", 0, SQLMONEY, (Cheques.Text), "Cheques", ""
               PMPasoValoresATX VGSqlConn, "@i_debito", 0, SQLMONEY, (Debito.Text), "Debito", ""
               
               
               If VGTipoEjecucion% = CGReverso% Then
                   PMPasoValoresATX VGSqlConn, "@i_subtotal", 0, SQLMONEY, val(valor.Text) * 100, "Subtotal", ""
               Else
                   PMPasoValoresATX VGSqlConn, "@i_subtotal", 0, SQLMONEY, (valor.Text), "Subtotal", ""
               End If
               
               
               PMPasoValoresATX VGSqlConn, "@i_comision_tot", 0, SQLMONEY, (Comision.Text), "valor de la comision", ""
               PMPasoValoresATX VGSqlConn, "@i_comision_efe", 0, SQLMONEY, (VLEfe_com), "Com. efectivo", ""
               PMPasoValoresATX VGSqlConn, "@i_comision_chq", 0, SQLMONEY, (VLChq_com), "Com. Cheques", ""
               PMPasoValoresATX VGSqlConn, "@i_comision_db", 0, SQLMONEY, (VLDeb_com), "Com. Cheques", ""
               PMPasoValoresATX VGSqlConn, "@i_total", 0, SQLMONEY, (Total.Text), "Total pagado", ""
               PMPasoValoresATX VGSqlConn, "@i_cant_cheques", 0, SQLINT4, (CantChq.Text), "Cantidad de cheques", ""
               If Me.Cta.ClipText <> "" Then
                    PMPasoValoresATX VGSqlConn, "@i_tipo_cta", 0, SQLCHAR, CboTipCta.Text, "CboTipCta", ""
                    PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, Cta.ClipText, "Cta", ""
                    If Me.Debito.Text > 0 Then
                        PMPasoValoresATX VGSqlConn, "@i_nombre_cta", 0, SQLVARCHAR, (Nombre.Text), "Nombre cuenta", ""
                    End If
                Else
                    PMPasoValoresATX VGSqlConn, "@i_tipo_cta", 0, SQLCHAR, (VLTipCta_com), "CboTipCta", ""
                    PMPasoValoresATX VGSqlConn, "@i_cuenta", 0, SQLVARCHAR, (VLCta_com), "Cta", ""
                End If
               
               PMPasoValoresATX VGSqlConn, "@i_autoriza", 0, SQLCHAR, VGAutoriza, "Autorizacion", ""
               
               PMPasoValoresATX VGSqlConn, "@i_mon", 0, SQLINT1, str(FMObtenerMonedaForma("143")), "Moneda", ""
               
               If VGTipoEjecucion% = CGReverso% Then
                  VGReversoLoger$ = "N"
                   PMPasoValoresATX VGSqlConn, "@i_terminal", 0, SQLVARCHAR, VLTerminalPago, "TerminalPago", ""
                   PMPasoValoresATX VGSqlConn, "@i_fechaPago", 0, SQLVARCHAR, VLFechaPago, "FechaPago", ""
                   PMPasoValoresATX VGSqlConn, "@i_horaPago", 0, SQLVARCHAR, VLHoraPago, "HoraPago", ""
                   PMPasoValoresATX VGSqlConn, "@i_trx_pago", 0, SQLVARCHAR, VLTrxPago, "TrxPago", ""
                   PMPasoValoresATX VGSqlConn, "@i_importe", 0, SQLVARCHAR, VLImportePago, "ImportePago", ""
                   
                   'PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLCHAR, "S", "@t_corr", ""
                   
                   VGReversoLoger$ = "S"
                Else
                   PMPasoValoresATX VGSqlConn, "@t_corr", 0, SQLCHAR, "N", "@t_corr", ""
                End If
                
                'verificacion de la forma de pago
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
    
               'valores de salida
               'TRX 62242
               
               PMPasoValoresATX VGSqlConn, "@o_fecha_efectivo", 1, SQLVARCHAR, "XXXXXXXXXX", "FecContable", ""
               
               If VGTipoEjecucion% <> CGReverso% Then
                    ' Parametros para Reverso Pago Cvialco
                    PMPasoValoresATX VGSqlConn, "@o_trx_pago", 1, SQLVARCHAR, "XXXXXXXXXX", "TransPago", ""
                    PMPasoValoresATX VGSqlConn, "@o_fecha_pago", 1, SQLVARCHAR, "XXXXXXXXXXXXXXX", "FechaPago", ""
                    PMPasoValoresATX VGSqlConn, "@o_hora_pago", 1, SQLVARCHAR, "XXXXXXXXXXXXXXX", "HoraPago", ""
                    PMPasoValoresATX VGSqlConn, "@o_terminal_pago", 1, SQLVARCHAR, "XXXXXXXXXXXXXXX", "TerminalPago", ""
                    PMPasoValoresATX VGSqlConn, "@o_importe", 1, SQLVARCHAR, "XXXXXXXXXXXXXXX", "TerminalPago", ""
               End If
               
            If FMTransmitirRPCATX(VGSqlConn, "BBTSSRV", "cob_procesador", "sp_pag_peaje", True, "Transaccion Ok", "S", "N", "S", "143", "S", "S") = True Then
                 VTResult% = FMMapeaMatrizATX(VGSqlConn&, vtmatrizcps()) 'jrocafuf
                 VLTsnTemporal = VGTSN%
                 PMChequeaATX VGSqlConn
                 PMTotalesBranch "143"
                 VLCambio% = False
                 '------> Sumadora
                 If vl_servidor_BUS = "BBTSSRV" Then
                    SGSecTrn$ = FMRetParamATX(VGSqlConn, 2)
                    VLSSnCorreccion = FMRetParamATX(VGSqlConn, 2)
                         
                    
                    VLMG_ossn = FMRetParamATX(VGSqlConn, 2)
                    VLSsn = FMRetParamATX(VGSqlConn, 2)
                    VLMG_autorisri = FMRetParamATX(VGSqlConn, 3)
                    VLautoriSri = Trim(VLMG_autorisri)
                    VLMG_fecvensri = FMRetParamATX(VGSqlConn, 4)
                    VLFecvenSRI = Trim(VLMG_fecvensri)
                    'smerino fechas de vigencia de autorización de SRI
                    VLMG_Fecinivig = FMRetParamATX(VGSqlConn, 12)
                    VLFecinivig = Trim(VLMG_Fecinivig) 'sme 06/08/2011
                    VLMG_Fecfinvig = FMRetParamATX(VGSqlConn, 13)
                    VLFecfinvig = Trim(VLMG_Fecfinvig) 'sme 06/08/2011
                    'fin smerino
                    VLCodPreAutorizacion = FMRetParamATX(VGSqlConn, 7)
                    VLCodAutorizacion = FMRetParamATX(VGSqlConn, 8)
                    VLFechaContable = FMRetParamATX(VGSqlConn, 1)
                    VLSerie_Secuencia = FMRetParamATX(VGSqlConn, 5)
                    VLImprCompComi = FMRetParamATX(VGSqlConn, 6)
                    VLNombSuscr = FMRetParamATX(VGSqlConn, 9)
                Else
                    
                    SGSecTrn$ = FLBuscarItem("@o_ssn")
                    VLSSnCorreccion = FLBuscarItem("@o_ssn")
                    VLMG_ossn = FLBuscarItem("@o_ssn")
                    VLSsn = FLBuscarItem("@o_ssn")
                                   
                    VLTrxPago = FLBuscarItem("@o_trx_pago")
                    VLFechaPago = FLBuscarItem("@o_fecha_pago")
                    VLHoraPago = FLBuscarItem("@o_hora_pago")
                    VLTerminalPago = FLBuscarItem("@o_terminal_pago")
                    VLFechaContable = FLBuscarItem("@o_fecha_efectivo")
                    VLNombSuscr = FLBuscarItem("Me.txt_nombreCliente.Text")
                    VLImportePago = FLBuscarItem("@o_importe")
                    
                    
                    VLTrxPago = FMRetParamATX(VGSqlConn, 2)
                    VLFechaPago = FMRetParamATX(VGSqlConn, 3)
                    VLHoraPago = FMRetParamATX(VGSqlConn, 4)
                    VLTerminalPago = FMRetParamATX(VGSqlConn, 5)
                    VLImportePago = FMRetParamATX(VGSqlConn, 6)
                                        
                End If
                
                 PMChequeaATX VGSqlConn
                   PMTotalesBranch "143"
                   FLTransmitir = True
                   VLCambio% = False
                   VLCambioCedruc% = False
                   'TPE ------> Sumadora
                   SGSecTrn$ = FLBuscarItem("@o_ssn")
                   VTIndicadorSum = 1
                   PMIniciaRegSum
                   '<-----
               Else
                   VLCambio% = True
                   VLCambioCedruc% = True
                   FLTransmitir = False
                   'TPE ------> Sumadora
                   'dpereirv Inicio
                   If vl_servidor_BUS = "PSSRV1" Then
                        SGSecTrn$ = FMRetParamATX(VGSqlConn, 2)
                    Else
                        SGSecTrn$ = FLBuscarItem("@o_ssn") 'FMRetParamATX(VGSqlConn, 2)
                   End If
                   'dpereirv Fin
                   
                   VTIndicadorSum = 0
                   PMChequeaATX VGSqlConn
                   '<------
               End If
               PMChequeaATX VGSqlConn
               If FMRetStatusATX(VGSqlConn) <> 0 Then
                   VTIndicadorSum = 0
                   FLTransmitir = False
               End If
               PMFinTransaccion
    End If
    
    'jrocafuf
    
    If FLTransmitir = True Then
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
                FLTransmitir = False
            End If
            SGActual = 1  'seteo Variable para borrar desglose
        ElseIf VTIndicadorSum = 0 Then
            SGActual = 0  'no borrar desglose en caso de Error en Transaccion
        End If
    ElseIf VTIndicadorSum = 1 Then                'Por REVERSO
              
        If Trim(txt_cod_servicio.Text) = "3" Then
            PMEgresoEfectivo SGUsar, VLTrn
        Else
            PMEgresoEfectivo SGUsar, VLTrn, VGSSNCorr&
        End If
        
    End If
    
    Exit Function
    
Error:
    MsgBox "Error al transmitir la transaccion " & Chr(13) & "Error:" & Err.Description, vbCritical
    FLTransmitir = False
End Function




'msilvag Inicio RECA-CC-SGC00027998
Sub PLFactura()
              
    '**************************************
    'GUARDAR FACTURA - INI
    '**************************************
    If Comision.Text > 0 And VLDeb_com = 0# Then     'cuando la comisión es con debito a cuenta se debe reportar en factura resumen
    Dim fr_secuencia As Long, fr_ssn As Long
    Dim fr_ced_ruc As String, fr_nombre As String, fr_fact_elect As String, fr_pto_estab As String, fr_pto_emis As String, _
        fr_fecha_validez As String, fr_nautorizacion As String, fr_valor As String, fr_iva As String, _
        fr_referencia As String, fr_servicio As String, nro_factura As String, fr_baseImp As String, fr_impresa As String, fr_fecha_ini_vig As String, fr_fecha_fin_vig As String 'SMERINO
    Dim fr_descuento As String, fr_forma_pag As String, fr_porc_compensa As String, fr_porc_iva As String 'LBP RECA-CC-SGC00025869 30/07/2016
    
    fr_ced_ruc = Replace(SGCedula, "_", "")     'Se obtiene de la pantalla de Comision
    fr_nombre = Trim(SGNombre)                  'Se obtiene de la pantalla de Comision
    fr_fact_elect = "S"
    fr_impresa = "S" 'dpereirv
'    fr_valor = Comision.Text
    
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
    
    fr_iva = VLiva     'smerino"0" cambios iva
    fr_baseImp = VlbaseImp 'smerino
    fr_referencia = Trim(VCodigo) '(Trim(Ref))
    'If Trim(Servicio.Text) = "2" And Trim(Empresa.Text) = "8269" Then   'JPM TRB IWS -->
      'fr_servicio = lblAux.Caption
    'Else                                                                '<-- JPM TRB IWS
      fr_servicio = Trim(txt_des_empresa.Caption)
    'End If                                                              'JPM IWS
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
            fr_baseImp, fr_impresa, fr_referencia, fr_servicio, nro_factura, fr_fecha_ini_vig, fr_fecha_fin_vig) Then 'smerino
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
'msilvag Fin
Private Sub Limpiar_Forma() 'DAPV - 09/14/2011
'INI DAPV - 09/12/2011 - Recargas Claro
        txtValor.Text = ""
        VLMonto = 0 'msilvag
        
        Etiqueta18.Visible = False
        Etiqueta19.Visible = False
        Etiqueta20.Visible = False
        txt_celular.Visible = False
        Etiqueta21.Visible = False
        txt_monto_rec.Visible = True
        txtValor.Visible = False
        cboTipoId.Visible = False
        Identificacion.Visible = False
        NombreCliente.Visible = False
        
        Label3.Visible = False ' jrocafuf
        txt_contrato.Visible = False ' jrocafuf
        lbl_nombre.Visible = False 'jrocafuf
        txt_nombreCliente.Visible = False 'jrocafuf
        txt_cod_empresa.Enabled = True 'jrocafuf
        
        txt_cod_tar3.Visible = True
        txt_cod_tar2.Visible = True
        txt_cod_tar1.Visible = True
        txt_celular.Text = ""
        txt_monto_rec.Text = ""
        
        Identificacion.Text = ""
        NombreCliente.Text = ""
        Frame2.Height = "2500"
        FCC143.Height = "4600"
        'FIN DAPV - 09/12/2011 - Recargas Claro
        
        txt_cod_empresa.Text = ""
        txt_des_empresa.Caption = ""
        Me.txt_cod_tar1.Text = ""
        Me.txt_cod_tar2.Text = ""
        Me.txt_cod_tar3.Text = ""
        
        txt_contrato.Text = "" ' jrocafuf
        txt_nombreCliente.Text = "" ' jrocafuf
        
        efe.Text = "0.00"
        efe.Enabled = False
        CantChq.Text = "0"
        CantChq.Enabled = False
        Cheques.Text = "0.00"
        Cheques.Enabled = False
        VLTotCom = 0#
        VLEfe_com = 0#
        VLChq_com = 0#
        VLDeb_com = 0#
        VLCta_com = ""
        VLCta = ""
        VLIdComercio = 0
        VLTipCta_com = ""
        VCodigo = ""
        Debito.Enabled = False
        CboTipCta.ListIndex = 0
        CboTipCta.Enabled = False
        Cta.Text = ""
        Cta.Enabled = False
        Nombre.Text = ""
        Cheques.Enabled = False
        VLCta = ""
        valor = "0.00"
        Total = "0.00"
        Debito = "0.00"
        Me.decimal = "0.00"
        VLNombSuscr = ""
        MontoMin = "0.00"
        MontoMax = "0.00"
        Comision = "0.00"
        Vl_Ind_Efe = 0
        
        VLautoriza2 = ""  'msilvag  CLAPAQ-AP-SGC00032311-SGC00032313
        '------> Sumadora
       SGUsar = 0
       VGUsar15 = 0
       If Shift = 0 _
       And VGTipoConsAutom% = 0 _
        And VGTipoEjecucion% <> CGReverso% Then
        SGActual = 1
        FSumIng.Hide
        FSumIng.Form_KeyDown CGTeclaF2%, 0
        
        Unload FSumIng
   
        txt_cod_servicio.SetFocus
      End If
      SGActivaSum = False
       '<------
End Sub
Sub PLTipoTransaccion(parHorario As String) 'DAPV - 09/14/2011
       Select Case parHorario
              Case "N"
                 If VLEmpresa = 39 Then
                        VLTrn = "4012"
                 'msilvag CLAPAQ-AP-SGC00032311-SGC00032313
                 ElseIf VLEmpresa = 40 Then
                        VLTrn = "43612"
                 'msilvag FIn
                 Else
                        VLTrn = "4014"
                 End If
              Case "D"
                If VLEmpresa = 39 Then
                        VLTrn = "4013"
                 'msilvag CLAPAQ-AP-SGC00032311-SGC00032313
                 ElseIf VLEmpresa = 40 Then
                        VLTrn = "43613"
                 'msilvag FIn
                 Else
                        VLTrn = "4015"
                 End If
        End Select
End Sub
Public Sub ImprimeComprobPago2() 'DAPV - 09/14/2011

   If VGModeloImp$ = "5021" Or VGModeloImp$ = "590" Then
      VGpartop$ = "00"  ' Ubica la impresion con margen superior de n. Contando de abajo hacia arriba. Antes tenia un valor de 7
      VGparleft$ = "10"
   End If
   PMSetDetalle "v" + CStr(VGTSN%) + " " + Format(VGFechaProceso, VGFormatoFecha$) + " " + Format(Now, VGFormatoHora$) + " " + CStr(VGOficina%) + " " + CStr(FMObtenerMonedaForma("143")) + " " + VGLogin$
   PMSetDetalle "v" + "BCO. BOLIVARIANO SEC.:" + Trim(Format(VGFechaProceso, "yyyymmdd") & SGSecTrn)
   Select Case VLEmpresa
        Case 39
            PMSetDetalle "v" + VGMensImpr + FmObtenermodo() + " " + VLTrn + " RECARGAS PREPAGO " + IIf(VLHorario = "D", "H:D", "H:N")
        'msilvag CLAPAQ-AP-SGC00032311-SGC00032313
        Case 40
            PMSetDetalle "v" + VGMensImpr + FmObtenermodo() + " " + VLTrn + " RECARGA PAQUETES " + IIf(VLHorario = "D", "H:D", "H:N")
        'msilvag Fin
        Case 103
        If VGTipoEjecucion% <> CGReverso% Then
            PMSetDetalle "v" + VGMensImpr + FmObtenermodo() + " " + VLTrn + " RECARGAS PREPAGO " + IIf(VLHorario = "D", "H:D", "H:N")
        Else
            VGMensImpr = ""
            PMSetDetalle "v" + "Reverso " + FmObtenermodo() + " " + VLTrn + " RECARGAS PREPAGO " + IIf(VLHorario = "D", "H:D", "H:N")
        End If
   End Select
   PMSetDetalle "v" + "Este pago sera procesado el " + Format(VLFechaContable, VGFormatoFecha$) 'Format(VGFechaProceso, VGFormatoFecha$)
   PMSetDetalle "v" + "EMPRESA: " + Trim$(txt_cod_empresa.Text) + " " + Trim$(Mid$(txt_des_empresa.Caption, 1, 36))
   PMSetDetalle "v" + "CELULAR: " & Format(txt_celular.Text, "0000000000") + FMEspaciosATX("", 8, CGJustificacionDerecha) + "No. AUT.:" + (Trim(VLautprov)) '(Trim(VLAutoriza)) 'VLautprov
   PMSetDetalle "v" + "NOMBRE: " & Trim$(Mid$(UCase(NombreCliente), 1, 36)) 'Trim(NombreCliente.Text)
   PMSetDetalle "v" + "FECHA EMISION: " + Format(VGFechaProceso, VGFormatoFecha$) + FMEspaciosATX("", 8, CGJustificacionDerecha) + "FECHA ENVIO " & Format(VGFechaProceso, VGFormatoFecha$)

    If efe.Text <> "0.00" And Me.Cheques.Text <> "0.00" Then
    PMSetDetalle "v" + "EFE:    " + FMEspaciosATX("USD. " + Format(Trim$(efe.Text), VGFormatoMoney), 13, CGJustificacionDerecha) + "    " + "CHQ(1): " + FMEspaciosATX(Format(Trim$(Cheques.Text), VGFormatoMoney), 13, CGJustificacionDerecha)
    End If
    
    If efe.Text <> "0.00" And Me.Cheques.Text = "0.00" Then
    PMSetDetalle "v" + "EFE:    " + FMEspaciosATX("USD. " + Format(Trim$(efe.Text), VGFormatoMoney), 13, CGJustificacionDerecha)
    End If
    
    If efe.Text = "0.00" And Me.Cheques.Text <> "0.00" Then
    PMSetDetalle "v" + "CHQ(1): " + FMEspaciosATX(Format(Trim$(Cheques.Text), VGFormatoMoney), 13, CGJustificacionDerecha)
    End If
    
    If Debito.Text <> "0.00" Then
    PMSetDetalle "v" + "DEB:    " + FMEspaciosATX("USD. " + Format(Trim$(Debito.Text), VGFormatoMoney), 13, CGJustificacionDerecha) + "    " + "CTA:      " + Format(Cta.ClipText, "000-000000-0") 'Trim$(Cta.ClipText)
    End If
    
   PMSetDetalle "v" + "TOTAL:" + FMEspaciosATX("USD. " + Format((CCur(Me.Total.Text)), VGFormatoMoney), 17, CGJustificacionDerecha)
   '***ref02 vmirandt inicio, se imprime al final del documento
    If VLclave_acceso <> "" Then
        PMSetDetalle "v" + "Clave de Acceso/Autorizacion: "
        PMSetDetalle "v" + VLclave_acceso
        VGpartop$ = "00"
        VGparleft$ = "10"
    End If
    'ref02 vmirandt
      
      Select Case VLEmpresa
        Case 39
               PMSetDetalle "v" + "Gracias por tu compra de tiempo aire."
               PMSetDetalle "v" + "Para revisar tu factura ingresa a www.claro.com.ec" 'dpereirv FELECT
               PMSetDetalle "v" + FMEspaciosATX(CStr(""), 13, CGJustificacionDerecha) + FMEspaciosATX(CStr(""), 13, CGJustificacionDerecha) + FMEspaciosATX(CStr(""), 13, CGJustificacionDerecha) + "IP" + FMEspaciosATX(CStr(VGTSN%), 8, CGJustificacionDerecha)
        'msilvag Inicio CLAPAQ-AP-SGC00032311-SGC00032313
        Case 40
               PMSetDetalle "v" + "Gracias por tu compra de paquetes."
               PMSetDetalle "v" + "Para revisar tu factura ingresa a www.claro.com.ec"
               PMSetDetalle "v" + FMEspaciosATX(CStr(""), 13, CGJustificacionDerecha) + FMEspaciosATX(CStr(""), 13, CGJustificacionDerecha) + FMEspaciosATX(CStr(""), 13, CGJustificacionDerecha) + "IP" + FMEspaciosATX(CStr(VGTSN%), 8, CGJustificacionDerecha)
        'msilvag Fin
        Case 103
               PMSetDetalle "v" + "Gracias por tu compra de tiempo aire. Para revisar tu factura"
               PMSetDetalle "v" + "ingresa a http://www.facturas.ponlemas.com/" + "  IP " + FMEspaciosATX(CStr(VGTSN%), 8, CGJustificacionIzquierda)
        Case 19574
               PMSetDetalle "v" + "Gracias por tu compra de tiempo aire. Para revisar tu factura"
               PMSetDetalle "v" + "ingresa a http://www.facturas.ponlemas.com/" + "  IP " + FMEspaciosATX(CStr(VGTSN%), 8, CGJustificacionIzquierda)
        Case 19575
               PMSetDetalle "v" + "Gracias por tu compra de tiempo aire. Para revisar tu factura"
               PMSetDetalle "v" + "ingresa a http://www.facturas.ponlemas.com/" + "  IP " + FMEspaciosATX(CStr(VGTSN%), 8, CGJustificacionIzquierda)
   End Select
   FMPRN_StdImpresion "IMPRESORA_1", False, "", "143", SGDatosDetalle, "Inserte Papeleta", CStr(VGpartop$), 3, CStr(VGparleft$), , , , , False
   PMFinImpresion "IMPRESORA_1"

End Sub

'jrocafuf
Public Sub ImprimeComprobPago3()

   If VGModeloImp$ = "5021" Or VGModeloImp$ = "590" Then
      If VGTipoEjecucion% <> CGReverso% Then
        VGpartop$ = "00"  ' Ubica la impresion con margen superior de n. Contando de abajo hacia arriba. Antes tenia un valor de 7
      Else
        VGpartop$ = "02"
      End If
      VGparleft$ = "10"
   End If
   
   If VGTipoEjecucion% <> CGReverso% Then
      PMSetDetalle "v" + "       ."
   End If
   
   PMSetDetalle "v" + CStr(VGTSN%) + " " + Format(VGFechaProceso, VGFormatoFecha$) + " " + Format(Now, VGFormatoHora$) + " " + CStr(VGOficina%) + " " + CStr(FMObtenerMonedaForma("143")) + " " + VGLogin$
   PMSetDetalle "v" + "BCO. BOLIVARIANO SEC.:" + Trim(Format(VGFechaProceso, "yyyymmdd") & SGSecTrn)
   Select Case VLEmpresa
        Case 8461 ' Cvialco
            PMSetDetalle "v" + VGMensImpr + FmObtenermodo() + " " + VLTrn + " RECARGAS TELETAG " + IIf(VLHorario = "D", "H:D", "H:N")
   End Select
   
   If VGTipoEjecucion% <> CGReverso% Then
      PMSetDetalle "v" + "Este pago sera procesado el " + Format(VLFechaContable, VGFormatoFecha$)
   End If
   
   PMSetDetalle "v" + "EMPRESA: " + Trim$(txt_cod_empresa.Text) + " " + Trim$(Mid$(txt_des_empresa.Caption, 1, 36)) + "   " + "CODIGO: " & Format(Me.txt_contrato.Text, "0000000000000")
   'PMSetDetalle "v" + "CODIGO: " & Format(Me.txt_contrato.Text, "0000000000000") + FMEspaciosATX("", 8, CGJustificacionDerecha)
   PMSetDetalle "v" + "NOMBRE: " & Trim$(Mid$(UCase(Me.txt_nombreCliente.Text), 1, 36))
   'PMSetDetalle "v" + "FECHA EMISION: " + Format(VGFechaProceso, VGFormatoFecha$) + FMEspaciosATX("", 8, CGJustificacionDerecha) + "FECHA ENVIO " & Format(VGFechaProceso, VGFormatoFecha$)

    If efe.Text <> "0.00" And Me.Cheques.Text <> "0.00" Then
    PMSetDetalle "v" + "EFE:    " + FMEspaciosATX("USD. " + Format(Trim$(efe.Text), VGFormatoMoney), 13, CGJustificacionDerecha) + "    " + "CHQ(1): " + FMEspaciosATX(Format(Trim$(Cheques.Text), VGFormatoMoney), 13, CGJustificacionDerecha)
    End If
    
    If efe.Text <> "0.00" And Me.Cheques.Text = "0.00" Then
    PMSetDetalle "v" + "EFE:    " + FMEspaciosATX("USD. " + Format(Trim$(efe.Text), VGFormatoMoney), 13, CGJustificacionDerecha)
    End If
    
    If efe.Text = "0.00" And Me.Cheques.Text <> "0.00" Then
    PMSetDetalle "v" + "CHQ(1): " + FMEspaciosATX(Format(Trim$(Cheques.Text), VGFormatoMoney), 13, CGJustificacionDerecha)
    End If
    
    If Debito.Text <> "0.00" Then
    PMSetDetalle "v" + "DEB:    " + FMEspaciosATX("USD. " + Format(Trim$(Debito.Text), VGFormatoMoney), 13, CGJustificacionDerecha) + "    " + "CTA:      " + Format(Cta.ClipText, "000-000000-0") 'Trim$(Cta.ClipText)
    End If
    
   PMSetDetalle "v" + "TOTAL:" + FMEspaciosATX("USD. " + Format((CCur(Me.valor.Text)), VGFormatoMoney), 17, CGJustificacionDerecha)
   
    If VLclave_acceso <> "" Then
        PMSetDetalle "v" + "Clave de Acceso/Autorizacion: "
        PMSetDetalle "v" + VLclave_acceso
        VGpartop$ = "00"
        VGparleft$ = "10"
    End If
   
      
      Select Case VLEmpresa
        Case 8461
            If VGTipoEjecucion% <> CGReverso% Then
               PMSetDetalle "v" + "Gracias por tu recarga."
               PMSetDetalle "v" + FMEspaciosATX(CStr(""), 13, CGJustificacionDerecha) + FMEspaciosATX(CStr(""), 13, CGJustificacionDerecha) + FMEspaciosATX(CStr(""), 13, CGJustificacionDerecha) + "IP" + FMEspaciosATX(CStr(VGTSN%), 8, CGJustificacionDerecha)
            Else
               PMSetDetalle "v" + " "
               PMSetDetalle "v" + FMEspaciosATX(CStr(""), 13, CGJustificacionDerecha) + FMEspaciosATX(CStr(""), 13, CGJustificacionDerecha) + FMEspaciosATX(CStr(""), 13, CGJustificacionDerecha) + "IP" + FMEspaciosATX(CStr(VGTSN%), 8, CGJustificacionDerecha)
            End If
       End Select
   FMPRN_StdImpresion "IMPRESORA_1", False, "", "143", SGDatosDetalle, "Inserte Papeleta", CStr(VGpartop$), 3, CStr(VGparleft$), , , , , False
   PMFinImpresion "IMPRESORA_1"

End Sub
'jrocafuf


Sub PLImprimeFactura(original As String) 'DAPV - 09/14/2011
    If VGModeloImp$ = "5021" Or VGModeloImp$ = "590" Then
        VGpartop$ = "10"
        VGparleft$ = "0"
        VGparlong$ = "120"
        VGparrig$ = "00"
    End If
    
    PMSetDetalle "v" + "CONSORCIO ECUATORIANO                                   RUC: 1791251237001"
    PMSetDetalle "v" + "DE TELECOMUNICACIONES S.A." + FMEspaciosATX("FACTURA", 48, CGJustificacionDerecha)
    PMSetDetalle "v" + "CONECEL   " + FMEspaciosATX(Trim(VLNoVenta), 64, CGJustificacionDerecha)
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + FMEspaciosATX("No. AUTORIZACION", 74, CGJustificacionDerecha)
    PMSetDetalle "v" + FMEspaciosATX(Trim(VLautoriza), 74, CGJustificacionDerecha)
    PMSetDetalle "v" + FMEspaciosATX(Trim(VLDireccion1), 45, CGJustificacionIzquierda)
    
    PMSetDetalle "v" + FMEspaciosATX(Trim(VLDireccion2), 40, CGJustificacionIzquierda) + _
                       FMEspaciosATX(VLfecdesde, 34, CGJustificacionDerecha)
             
    PMSetDetalle "v" + FMEspaciosATX(Trim(VLDireccion3), 22, CGJustificacionIzquierda) + _
                       FMEspaciosATX(VLfechasta + " " + Trim(VLFecvenSRI), 52, CGJustificacionDerecha)

    PMSetDetalle "v" + " "
    PMSetDetalle "v" + FMEspaciosATX("Sr.(es): " + Trim$(Mid$(UCase(NombreCliente), 1, 36)), 45, CGJustificacionIzquierda) + _
                       FMEspaciosATX(" Fecha de Emision: " + Format(VGFechaProceso, VGFormatoFecha$), 29, CGJustificacionDerecha)
    PMSetDetalle "v" + FMEspaciosATX("RUC O CI: " + Identificacion.Text, 74, CGJustificacionIzquierda)
    
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + "Cantidad" + Space(8) + "Descripcion" + Space(20) + "    Precio" + Space(4) + "      Total" + Space(2)
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + FMEspaciosATX("   1    ", 16, CGJustificacionIzquierda) _
                     + FMEspaciosATX("Activacion Tiempo aire Celular", 31, CGJustificacionIzquierda) _
                     + FMEspaciosATX(Format$(VLNeto, "####,###,##0.00") + "      ", 16, CGJustificacionDerecha) _
                     + FMEspaciosATX(Format$(VLNeto, "####,###,##0.00") + "      ", 16, CGJustificacionDerecha)
                         
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + Space(40) + FMEspaciosATX("Subtotal 12%:   ", 16, CGJustificacionIzquierda) + FMEspaciosATX(Format$(VLNeto, "####,###,##0.00"), 10, CGJustificacionDerecha)
    PMSetDetalle "v" + Space(40) + FMEspaciosATX("Subtotal 0%:    ", 16, CGJustificacionIzquierda) + FMEspaciosATX("0.00", 10, CGJustificacionDerecha)
    PMSetDetalle "v" + Space(40) + FMEspaciosATX("Subtotal:       ", 16, CGJustificacionIzquierda) + FMEspaciosATX(Format$(VLNeto, "####,###,##0.00"), 10, CGJustificacionDerecha)
    PMSetDetalle "v" + Space(40) + FMEspaciosATX("IVA 12%:        ", 16, CGJustificacionIzquierda) + FMEspaciosATX(Format$(VLiva, "####,###,##0.00"), 10, CGJustificacionDerecha)
    PMSetDetalle "v" + Space(40) + FMEspaciosATX("VALOR TOTAL:    ", 16, CGJustificacionIzquierda) + FMEspaciosATX(Total, 10, CGJustificacionDerecha)
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + " "
    If original = "O" Then
        PMSetDetalle "v" + "Original: Adquiriente"
    Else
        PMSetDetalle "v" + "Copia: Emisor"
    End If
    PMSetDetalle "v" + FMEspaciosATX(Trim(parametros("CONVTA", "CTE")) + " RESOLUCION No. " + Trim(VLResolucion), 74, CGJustificacionDerecha)
    
    FMPRN_StdImpresion "IMPRESORA_1", False, "", "143", SGDatosDetalle, "Inserte comprobante grande para Factura", CStr(VGpartop$), 1, CStr(VGparleft$), , , , , False
    PMFinImpresion "IMPRESORA_1"
End Sub
Private Function parametros(Nemonico As String, Producto As String) As String 'DAPV - 09/14/2011
Dim VLarregloParametro(30) As String
PMInicioTransaccion
PMPasoValores VGSqlConn, "@t_trn", 0, SQLINT2, 1579
PMPasoValores VGSqlConn&, "@i_operacion", 0, SQLVARCHAR, "Q"
PMPasoValores VGSqlConn&, "@i_nemonico", 0, SQLVARCHAR, Nemonico
PMPasoValores VGSqlConn&, "@i_producto", 0, SQLVARCHAR, Producto
If FMTransmitirRPC(VGSqlConn, VGServerNameRec$, "cobis", "sp_parametro", True, "Transaccion Ok") = True Then
    VTR1% = FMMapeaArreglo(VGSqlConn&, VLarregloParametro())
    parametros = LTrim(RTrim(Trim(VLarregloParametro(4))))
Else
    parametros = ""
End If
PMChequea VGSqlConn&
PMFinTransaccion
End Function
Public Sub GpParametro() 'DAPV - 09/14/2011
If VGTipoEjecucion = CGNormal% Then

    ReDim VTArreglo(30) As String
    VLfecdesde = ""
    PMChequea VGSqlConn&
    PMPasoValores VGSqlConn, "@t_trn", 0, SQLINT2, 1579
    PMPasoValores VGSqlConn&, "@i_operacion", 0, SQLVARCHAR, "Q"
    PMPasoValores VGSqlConn&, "@i_nemonico", 0, SQLVARCHAR, "FECDES"
    PMPasoValores VGSqlConn&, "@i_producto", 0, SQLVARCHAR, "CTE"
    If FMTransmitirRPC(VGSqlConn, "", "cobis", "sp_parametro", True, "Transaccion Ok") = True Then
        VTR1% = FMMapeaArreglo(VGSqlConn&, VTArreglo())
        VLfecdesde = LTrim(RTrim(Trim(VTArreglo(2))))
    End If
    PMChequea VGSqlConn&
    
    
    PMChequea VGSqlConn&
    PMPasoValores VGSqlConn, "@t_trn", 0, SQLINT2, 1579
    PMPasoValores VGSqlConn&, "@i_operacion", 0, SQLVARCHAR, "Q"
    PMPasoValores VGSqlConn&, "@i_nemonico", 0, SQLVARCHAR, "FECDES"
    PMPasoValores VGSqlConn&, "@i_producto", 0, SQLVARCHAR, "CTE"
    If FMTransmitirRPC(VGSqlConn, "", "cobis", "sp_parametro", True, "Transaccion Ok") = True Then
        VTR1% = FMMapeaArreglo(VGSqlConn&, VTArreglo())
        VLfecdesde = VLfecdesde & " " & LTrim(RTrim(Trim(VTArreglo(4))))
    End If
    PMChequea VGSqlConn&
    
        ReDim VTArreglo(30) As String
        VLfechasta = ""
        PMChequea VGSqlConn&
        PMPasoValores VGSqlConn, "@t_trn", 0, SQLINT2, 1579
        PMPasoValores VGSqlConn&, "@i_operacion", 0, SQLVARCHAR, "Q"
        PMPasoValores VGSqlConn&, "@i_nemonico", 0, SQLVARCHAR, "FEHAST"
        PMPasoValores VGSqlConn&, "@i_producto", 0, SQLVARCHAR, "CTE"
        If FMTransmitirRPC(VGSqlConn, "", "cobis", "sp_parametro", True, "Transaccion Ok") = True Then
            VTR1% = FMMapeaArreglo(VGSqlConn&, VTArreglo())
            VLfechasta = LTrim(RTrim(Trim(VTArreglo(4))))
        End If
        PMChequea VGSqlConn&
        
        
        ReDim VTArreglo(30) As String
        VLTipoDocBroad = ""
        PMChequea VGSqlConn&
        PMPasoValores VGSqlConn, "@t_trn", 0, SQLINT2, 1579
        PMPasoValores VGSqlConn&, "@i_operacion", 0, SQLVARCHAR, "Q"
        PMPasoValores VGSqlConn&, "@i_nemonico", 0, SQLVARCHAR, "NEVNV"
        PMPasoValores VGSqlConn&, "@i_producto", 0, SQLVARCHAR, "CTE"
        If FMTransmitirRPC(VGSqlConn, "", "cobis", "sp_parametro", True, "Transaccion Ok") = True Then
            VTR1% = FMMapeaArreglo(VGSqlConn&, VTArreglo())
            VLTipoDocBroad = LTrim(RTrim(Trim(VTArreglo(4))))
        End If
        PMChequea VGSqlConn&
        
        ReDim VTArreglo(30) As String
        VLfecdesdeB = ""
        PMChequea VGSqlConn&
        PMPasoValores VGSqlConn, "@t_trn", 0, SQLINT2, 1579
        PMPasoValores VGSqlConn&, "@i_operacion", 0, SQLVARCHAR, "Q"
        PMPasoValores VGSqlConn&, "@i_nemonico", 0, SQLVARCHAR, "FDMOV"
        PMPasoValores VGSqlConn&, "@i_producto", 0, SQLVARCHAR, "CTE"
        If FMTransmitirRPC(VGSqlConn, "", "cobis", "sp_parametro", True, "Transaccion Ok") = True Then
            VTR1% = FMMapeaArreglo(VGSqlConn&, VTArreglo())
            VLfecdesdeB = LTrim(RTrim(Trim(VTArreglo(2))))
        End If
        PMChequea VGSqlConn&
    
    
        PMChequea VGSqlConn&
        PMPasoValores VGSqlConn, "@t_trn", 0, SQLINT2, 1579
        PMPasoValores VGSqlConn&, "@i_operacion", 0, SQLVARCHAR, "Q"
        PMPasoValores VGSqlConn&, "@i_nemonico", 0, SQLVARCHAR, "FDMOV"
        PMPasoValores VGSqlConn&, "@i_producto", 0, SQLVARCHAR, "CTE"
        If FMTransmitirRPC(VGSqlConn, "", "cobis", "sp_parametro", True, "Transaccion Ok") = True Then
            VTR1% = FMMapeaArreglo(VGSqlConn&, VTArreglo())
            VLfecdesdeB = VLfecdesdeB & " " & LTrim(RTrim(Trim(VTArreglo(4))))
        End If
        PMChequea VGSqlConn&
    
        ReDim VTArreglo(30) As String
        VLfechastaB = ""
        PMChequea VGSqlConn&
        PMPasoValores VGSqlConn, "@t_trn", 0, SQLINT2, 1579
        PMPasoValores VGSqlConn&, "@i_operacion", 0, SQLVARCHAR, "Q"
        PMPasoValores VGSqlConn&, "@i_nemonico", 0, SQLVARCHAR, "FEHASM"
        PMPasoValores VGSqlConn&, "@i_producto", 0, SQLVARCHAR, "CTE"
        If FMTransmitirRPC(VGSqlConn, "", "cobis", "sp_parametro", True, "Transaccion Ok") = True Then
            VTR1% = FMMapeaArreglo(VGSqlConn&, VTArreglo())
            VLfechastaB = LTrim(RTrim(Trim(VTArreglo(4))))
        End If
        PMChequea VGSqlConn&
    
        ReDim VTArreglo(30) As String
        vl_telefono = ""
        PMChequea VGSqlConn&
        PMPasoValores VGSqlConn, "@t_trn", 0, SQLINT2, 1579
        PMPasoValores VGSqlConn&, "@i_operacion", 0, SQLVARCHAR, "Q"
        PMPasoValores VGSqlConn&, "@i_nemonico", 0, SQLVARCHAR, "TLFBR"
        PMPasoValores VGSqlConn&, "@i_producto", 0, SQLVARCHAR, "ADM"
        If FMTransmitirRPC(VGSqlConn, "", "cobis", "sp_parametro", True, "Transaccion Ok") = True Then
            VTR1% = FMMapeaArreglo(VGSqlConn&, VTArreglo())
            vl_telefono = LTrim(RTrim(Trim(VTArreglo(4))))
        End If
        PMChequea VGSqlConn&
End If

End Sub

Sub PLImprimeNotaVenta() 'DAPV -103 - MOVISTAR - 18/OCT/2011
    PMInicioImpresion "IMPRESORA_1"
    PMBorrarDatosImpresion
    VGparlong$ = "66"
    VGpartop$ = "00"
    VGparleft$ = "10"
    VGparrig$ = "00"

     PMSetLineaImpresion "x" + "Inserte NOTA DE VENTA"
     PMSetLineaImpresion "<"
     If VLEmpresa <> 103 Then
        PMSetLineaImpresion "v" + "NOTA DE VENTA             ADQUIRIENTE - ORIGINAL"   'hy-16-ago-2005
    Else
        PMSetLineaImpresion "v" + "NOTA DE VENTA             ORIGINAL-ADQUIRIENTE"   'hy-16-ago-2005
    End If
     PMSetLineaImpresion "v" + "RUC.:                     " + Trim(VLRucEmpresa) '0990379017001"
     PMSetLineaImpresion "v" + Trim(VLRazon)  ' "CONSORCIO ECUATORIANO DE TELECOMUNICACIONES"
     If VLEmpresa <> 103 Then
          PMSetLineaImpresion "v" + Trim(parametros("CONVTA", "CTE")) + " RESOLUCION No. " + Trim(VLResolucion)  '"RESOLUCION No. 5368 de Junio 02 de 1995"
          PMSetLineaImpresion "v" + "DOC.: " + Trim(VLNoVenta)
     Else
          PMSetLineaImpresion "v" + "DOC.: " + Trim(VLNoVenta)
     End If
     
     PMSetLineaImpresion "v" + "AUTORIZ No:" + Trim(VLautoriza) + " VALIDEZ: " + Trim(VLFecvenSRI)
     PMSetLineaImpresion "v" + "Direccion: " + Mid(Trim(VLDireccion), 1, 51)
     If Len(Trim(VLDireccion)) > 52 Then
        PMSetLineaImpresion "v" + Mid(Trim(VLDireccion), 52, Len(Trim(VLDireccion)) - 51)
     End If
       
     PMSetLineaImpresion "v" + "Caj: " + VGLogin$ + " " + "Fecha: " + Format(VGFechaProceso, VGFormatoFecha$) + " " + Format(Now, VGFormatoHora$)
     PMSetLineaImpresion "v" + "RUC/C.I.:" + Identificacion.Text + " " + "Nombre:" + Mid(Trim(Me.NombreCliente.Text), 1, 33)

     If VLEmpresa <> 103 Then
        PMSetLineaImpresion "v" + "Servicio Recaudacion:Activacion Tiempo aire Celular" '+ FMEspaciosATX(FMObtenerSimbolo("143") + Format(subtotal.Text, VGFormatoMoney), 8, CGJustificacionDerecha)
     Else
        PMSetLineaImpresion "v" + "Servicio Recaudacion:Activacion Tiempo aire MOVISTAR" '+ FMEspaciosATX(FMObtenerSimbolo("143") + Format(subtotal.Text, VGFormatoMoney), 8, CGJustificacionDerecha)
     End If
    PMSetLineaImpresion "v" + "EFE.:" + FMEspaciosATX(FMObtenerSimbolo("143") + Format(efe.Text, VGFormatoMoney), 10, CGJustificacionDerecha) + "     CHQ.:" + FMEspaciosATX(FMObtenerSimbolo("143") + Format(Cheques.Text, VGFormatoMoney), 10, CGJustificacionDerecha) + "    DEB.:" + FMEspaciosATX(FMObtenerSimbolo("143") + Format(Debito.Text, VGFormatoMoney), 10, CGJustificacionDerecha)
    
    PMSetLineaImpresion "v" + "PAGO TOTAL (INCLUYE IVA):     " + FMEspaciosATX(FMObtenerSimbolo("143") + Format(FMCCurATX(Total.Text), VGFormatoMoney), 25, CGJustificacionDerecha)
                              
    PMSetLineaImpresion "v" + " "
    PMSetLineaImpresion "v" + " "
        
    If VGModeloImp$ = "590" Then
        PMSetLineaImpresion "!" & VGpartop$  '1
        PMSetLineaImpresion "%N" & VGparleft$ '"%N20"
        PMSetLineaImpresion "%R" & 8
    End If
    
    PMSetLineaImpresion ">"
    PMImprimir "IMPRESORA_1", False
    PMFinImpresion "IMPRESORA_1"
End Sub

Sub PLImpFactBroadnet(original As String) 'DAPV -103 - MOVISTAR - 18/OCT/2011
    If VGModeloImp$ = "5021" Or VGModeloImp$ = "590" Then
        VGpartop$ = "10"
        VGparleft$ = "0"
        VGparlong$ = "120"
        VGparrig$ = "00"
    End If
    
    PMSetDetalle "v" + vlrazonb + "                                           RUC: " & vlrucbroadnet
    PMSetDetalle "v" + "                          " + FMEspaciosATX("FACTURA", 48, CGJustificacionDerecha)
    PMSetDetalle "v" + "          " + FMEspaciosATX(Trim(VLNoVenta), 64, CGJustificacionDerecha)
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + FMEspaciosATX("No. AUTORIZACION", 74, CGJustificacionDerecha)
    PMSetDetalle "v" + FMEspaciosATX(Trim(VLautoriza), 74, CGJustificacionDerecha)
    
    PMSetDetalle "v" + "Telf: " + FMEspaciosATX(Trim(vl_telefono), 45, CGJustificacionIzquierda)
    
    PMSetDetalle "v" + FMEspaciosATX(Trim(vl_direc1), 45, CGJustificacionIzquierda)   '+ _

    PMSetDetalle "v" + FMEspaciosATX(Trim(vl_direc2), 35, CGJustificacionIzquierda) + _
                       FMEspaciosATX(VLfecdesdeB, 39, CGJustificacionDerecha)

    PMSetDetalle "v" + FMEspaciosATX("Guayaquil - Ecuador", 22, CGJustificacionIzquierda) + _
                       FMEspaciosATX(VLfechastaB + " " + Trim(VLFecvenSRI), 52, CGJustificacionDerecha)

    PMSetDetalle "v" + " "
    PMSetDetalle "v" + FMEspaciosATX("Sr.(es): " + Me.NombreCliente, 45, CGJustificacionIzquierda) + _
                       FMEspaciosATX(" Fecha de Emision: " + Format(VGFechaProceso, "DD/MM/YYYY"), 29, CGJustificacionDerecha)
    PMSetDetalle "v" + FMEspaciosATX("RUC O CI: " + Identificacion.Text, 74, CGJustificacionIzquierda)
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + "Cantidad" + Space(8) + "Descripcion" + Space(20) + "    Precio" + Space(4) + "      Total" + Space(2)
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + FMEspaciosATX("   1    ", 16, CGJustificacionIzquierda) _
                     + FMEspaciosATX("RECARGA MOVISTAR            ", 31, CGJustificacionIzquierda) _
                     + FMEspaciosATX(Format$(VLNeto, "####,###,##0.00") + "      ", 16, CGJustificacionDerecha) _
                     + FMEspaciosATX(Format$(VLNeto, "####,###,##0.00") + "      ", 16, CGJustificacionDerecha)
                                               
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + Space(40) + FMEspaciosATX("Subtotal 12%:   ", 16, CGJustificacionIzquierda) + FMEspaciosATX(Format$(VLNeto, "####,###,##0.00"), 10, CGJustificacionDerecha)
    PMSetDetalle "v" + Space(40) + FMEspaciosATX("Subtotal 0%:    ", 16, CGJustificacionIzquierda) + FMEspaciosATX("0.00", 10, CGJustificacionDerecha)
    PMSetDetalle "v" + Space(40) + FMEspaciosATX("Subtotal:       ", 16, CGJustificacionIzquierda) + FMEspaciosATX(Format$(VLNeto, "####,###,##0.00"), 10, CGJustificacionDerecha)
    PMSetDetalle "v" + Space(40) + FMEspaciosATX("IVA 12%:        ", 16, CGJustificacionIzquierda) + FMEspaciosATX(Format$(VLiva, "####,###,##0.00"), 10, CGJustificacionDerecha)
    PMSetDetalle "v" + Space(40) + FMEspaciosATX("VALOR TOTAL:    ", 16, CGJustificacionIzquierda) + FMEspaciosATX(Total, 10, CGJustificacionDerecha)
    PMSetDetalle "v" + " "
    PMSetDetalle "v" + " "
    If original = "O" Then
        PMSetDetalle "v" + "Original: Adquiriente"
    Else
        PMSetDetalle "v" + "Copia: Emisor"
    End If
    PMSetDetalle "v" + FMEspaciosATX(Trim(parametros("CONVTA", "CTE")) + " RESOLUCION # " + Trim(VLResolucion), 74, CGJustificacionIzquierda)
    
    FMPRN_StdImpresion "IMPRESORA_1", False, "", "143", SGDatosDetalle, "Inserte comprobante grande para Factura", CStr(VGpartop$), 1, CStr(VGparleft$), , , , , False
    PMFinImpresion "IMPRESORA_1"
End Sub

'msilvag Inicio Bus Fase 2
Private Sub Consulta_parametro_OSB()
    If VGTipoEjecucion% = CGReverso% Then
   VGTipoEjecucion% = CGNormal%
    PMChequeaATX VGSqlConn&
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "sv_servidor_servicios_soa", "", ""
    PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR, "V", "", ""
    PMPasoValoresATX VGSqlConn&, "@i_codigo", 0, SQLVARCHAR, (Me.txt_cod_empresa.Text), "", ""
    If FMTransmitirRPCATX(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "", "N", "S", "I", "0", "N", "N") Then
        PMMapeaObjetoATX VGSqlConn&, txtTemporal
        vl_servidor_BUS = txtTemporal
    End If
    PMChequeaATX VGSqlConn&
    PMFinTransaccion
    VGTipoEjecucion% = CGReverso%
Else
    PMChequeaATX VGSqlConn&
    PMInicioTransaccion
    PMPasoValoresATX VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "sv_servidor_servicios_soa", "", ""
    PMPasoValoresATX VGSqlConn&, "@i_tipo", 0, SQLCHAR, "V", "", ""
    PMPasoValoresATX VGSqlConn&, "@i_codigo", 0, SQLVARCHAR, (Me.txt_cod_empresa.Text), "", ""
    If FMTransmitirRPCATX(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "", "N", "S", "I", "0", "N", "N") Then
        PMMapeaObjetoATX VGSqlConn&, txtTemporal
        vl_servidor_BUS = txtTemporal
    End If
    PMChequeaATX VGSqlConn&
    PMFinTransaccion
End If


End Sub
'msilvag Fin

Function FLBuscarItem(VLELemento As String) As String
    Dim i As Integer
    Dim hallado As Boolean
    i = 1
    hallado = False
    Do While i < 53 And Not hallado
        
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


Function FLBuscarItemPeaje(VLELemento As String) As String
    Dim i As Integer
    Dim hallado As Boolean
    i = 1
    hallado = False
    Do While i < 53 And Not hallado
        
        If MatrizPeaje(0, i) = Trim$(VLELemento) Then
            hallado = True
        Else
            i = i + 1
        End If
    Loop
    If hallado Then
        FLBuscarItemPeaje = MatrizPeaje(1, i)
    Else
        FLBuscarItemPeaje = ""
    End If
End Function


