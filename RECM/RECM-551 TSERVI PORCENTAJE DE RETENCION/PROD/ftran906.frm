VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "GRID32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0F1F1508-C40A-101B-AD04-00AA00575482}#1.0#0"; "mhrinp32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Begin VB.Form FTran906 
   AutoRedraw      =   -1  'True
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Personalizacion de Empresas"
   ClientHeight    =   9825
   ClientLeft      =   390
   ClientTop       =   2475
   ClientWidth     =   9300
   ClipControls    =   0   'False
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H80000008&
   Icon            =   "ftran906.frx":0000
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   9825
   ScaleWidth      =   9300
   Begin VB.Frame Fra1 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Datos de la Empresa"
      Enabled         =   0   'False
      ForeColor       =   &H000000FF&
      Height          =   7770
      Index           =   1
      Left            =   120
      TabIndex        =   46
      Top             =   1920
      Width           =   8175
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   10
         Left            =   6240
         MaxLength       =   5
         TabIndex        =   100
         Top             =   5545
         Width           =   585
      End
      Begin VB.CheckBox Chk_CobCom 
         Height          =   255
         Left            =   4560
         TabIndex        =   98
         Top             =   7380
         Width           =   255
      End
      Begin VB.Frame FrmCobCom 
         BackColor       =   &H00C0C0C0&
         Height          =   375
         Left            =   4920
         TabIndex        =   94
         Top             =   7280
         Visible         =   0   'False
         Width           =   2475
         Begin VB.OptionButton optCobCom 
            BackColor       =   &H00C0C0C0&
            Caption         =   "Diario"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   1
            Left            =   1440
            TabIndex        =   97
            Top             =   120
            Width           =   855
         End
         Begin VB.OptionButton optCobCom 
            BackColor       =   &H00C0C0C0&
            Caption         =   "Mensual"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   0
            Left            =   120
            TabIndex        =   96
            Top             =   120
            Width           =   1215
         End
      End
      Begin VB.OptionButton optBtnPago 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Sí"
         Height          =   195
         Index           =   0
         Left            =   1995
         TabIndex        =   92
         Top             =   3720
         Width           =   615
      End
      Begin VB.OptionButton optBtnPago 
         BackColor       =   &H00C0C0C0&
         Caption         =   "No"
         Height          =   195
         Index           =   1
         Left            =   2595
         TabIndex        =   91
         Top             =   3720
         Value           =   -1  'True
         Width           =   615
      End
      Begin VB.CommandButton btnConfiguracion 
         Caption         =   "Configuración"
         Enabled         =   0   'False
         Height          =   320
         Left            =   3360
         TabIndex        =   90
         Top             =   3720
         Width           =   1455
      End
      Begin VB.CheckBox ChkFactura 
         Height          =   255
         Left            =   1965
         TabIndex        =   87
         Top             =   7380
         Width           =   255
      End
      Begin VB.CommandButton limpiar 
         Caption         =   "Limpiar"
         Height          =   320
         Left            =   4920
         TabIndex        =   86
         Top             =   3120
         Width           =   1455
      End
      Begin VB.CommandButton eliminar 
         Caption         =   "Eliminar"
         Height          =   320
         Left            =   4920
         TabIndex        =   85
         Top             =   2760
         Width           =   1455
      End
      Begin VB.CommandButton agregar 
         Caption         =   "Transmitir"
         Height          =   320
         Left            =   4920
         TabIndex        =   84
         Top             =   2400
         Width           =   1455
      End
      Begin MSGrid.Grid Grid1 
         Height          =   1335
         Left            =   1965
         TabIndex        =   83
         Top             =   2280
         Width           =   2775
         _Version        =   65536
         _ExtentX        =   4895
         _ExtentY        =   2355
         _StockProps     =   77
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
         Cols            =   3
      End
      Begin VB.TextBox tipo_canal 
         Height          =   285
         Left            =   2400
         TabIndex        =   19
         Top             =   1920
         Width           =   540
      End
      Begin MhinrelLib.MhRealInput MhValorCanal 
         Height          =   285
         Left            =   4920
         TabIndex        =   20
         Top             =   1920
         Width           =   1260
         _Version        =   65536
         _ExtentX        =   2222
         _ExtentY        =   503
         _StockProps     =   77
         BackColor       =   9408399
         TintColor       =   16711935
         BevelStyle      =   2
         FillColor       =   16777215
         AutoHScroll     =   -1  'True
         CaretColor      =   -2147483642
      End
      Begin VB.CheckBox Check2 
         Caption         =   "Check2"
         Height          =   255
         Left            =   1965
         TabIndex        =   18
         Top             =   1920
         Width           =   255
      End
      Begin VB.CheckBox Check1 
         Caption         =   "Check1"
         Height          =   255
         Left            =   1965
         TabIndex        =   16
         Top             =   1560
         Width           =   255
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   9
         Left            =   4560
         MaxLength       =   5
         TabIndex        =   23
         Top             =   4105
         Width           =   465
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   8
         Left            =   2520
         MaxLength       =   5
         TabIndex        =   22
         Top             =   4105
         Width           =   700
      End
      Begin VB.CheckBox chkImpIva 
         Height          =   255
         Left            =   1965
         TabIndex        =   21
         Top             =   4105
         Width           =   210
      End
      Begin VB.TextBox txtCampo2 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   4
         Left            =   1965
         MaxLength       =   3
         TabIndex        =   33
         Top             =   6625
         Width           =   615
      End
      Begin VB.ComboBox Cmb_Region 
         Height          =   315
         ItemData        =   "ftran906.frx":030A
         Left            =   4200
         List            =   "ftran906.frx":031A
         Style           =   2  'Dropdown List
         TabIndex        =   34
         Top             =   6625
         Width           =   1575
      End
      Begin VB.TextBox txtCampo2 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   3
         Left            =   4200
         MaxLength       =   10
         TabIndex        =   36
         Top             =   6985
         Width           =   1215
      End
      Begin VB.TextBox txtCampo2 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   2
         Left            =   1965
         MaxLength       =   10
         TabIndex        =   35
         Top             =   6985
         Width           =   1215
      End
      Begin VB.CheckBox chkRefEstcta 
         Height          =   255
         Left            =   5760
         TabIndex        =   31
         Top             =   6305
         Width           =   255
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   7
         Left            =   2520
         MaxLength       =   6
         TabIndex        =   28
         Top             =   5545
         Width           =   700
      End
      Begin VB.CheckBox chkConta 
         Height          =   255
         Left            =   1965
         TabIndex        =   30
         Top             =   6305
         Width           =   255
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   6
         Left            =   1965
         MaxLength       =   5
         TabIndex        =   29
         Top             =   5905
         Width           =   855
      End
      Begin VB.CheckBox chkImpRet 
         Height          =   255
         Left            =   1965
         TabIndex        =   27
         Top             =   5545
         Width           =   255
      End
      Begin Threed.SSFrame frmLaborables 
         Height          =   345
         Left            =   3360
         TabIndex        =   13
         Top             =   1170
         Width           =   3255
         _Version        =   65536
         _ExtentX        =   5741
         _ExtentY        =   609
         _StockProps     =   14
         ForeColor       =   255
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Small Fonts"
            Size            =   6.76
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin Threed.SSOption optLaborables 
            Height          =   150
            Index           =   1
            Left            =   1800
            TabIndex        =   15
            TabStop         =   0   'False
            Top             =   120
            Width           =   1095
            _Version        =   65536
            _ExtentX        =   1931
            _ExtentY        =   265
            _StockProps     =   78
            Caption         =   "Laborables"
            ForeColor       =   8388608
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Small Fonts"
               Size            =   6.76
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
         Begin Threed.SSOption optLaborables 
            Height          =   180
            Index           =   0
            Left            =   360
            TabIndex        =   14
            Top             =   120
            Width           =   1215
            _Version        =   65536
            _ExtentX        =   2143
            _ExtentY        =   318
            _StockProps     =   78
            Caption         =   "Calendarios"
            ForeColor       =   8388608
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Small Fonts"
               Size            =   6.76
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            Value           =   -1  'True
         End
      End
      Begin MhinrelLib.MhRealInput MhValor 
         Height          =   285
         Left            =   2400
         TabIndex        =   17
         Top             =   1560
         Width           =   1260
         _Version        =   65536
         _ExtentX        =   2222
         _ExtentY        =   503
         _StockProps     =   77
         BackColor       =   9408399
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
         BevelStyle      =   2
         FillColor       =   16777215
         MaxReal         =   9000000000000
         AutoHScroll     =   -1  'True
         CaretColor      =   -2147483642
         Separator       =   -1  'True
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   5
         Left            =   1965
         MaxLength       =   100
         TabIndex        =   9
         Top             =   220
         Width           =   6135
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   4
         Left            =   1965
         MaxLength       =   6
         TabIndex        =   24
         Top             =   4510
         Width           =   855
      End
      Begin MSMask.MaskEdBox mskCuenta 
         Height          =   285
         Left            =   1965
         TabIndex        =   26
         Top             =   5185
         Width           =   1365
         _ExtentX        =   2408
         _ExtentY        =   503
         _Version        =   393216
         Appearance      =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         PromptChar      =   "_"
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   1
         Left            =   1965
         MaxLength       =   13
         TabIndex        =   10
         Top             =   540
         Width           =   2295
      End
      Begin VB.ComboBox CmbTipoID 
         Height          =   315
         Left            =   1965
         Style           =   2  'Dropdown List
         TabIndex        =   25
         Top             =   4825
         Width           =   1695
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   2
         Left            =   1965
         MaxLength       =   50
         TabIndex        =   11
         Top             =   860
         Width           =   5175
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   3
         Left            =   1965
         MaxLength       =   3
         TabIndex        =   12
         Top             =   1200
         Width           =   615
      End
      Begin VB.Frame Frame1 
         BackColor       =   &H00C0C0C0&
         Height          =   375
         Left            =   1920
         TabIndex        =   93
         Top             =   3600
         Width           =   1400
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   10
         Left            =   6840
         TabIndex        =   101
         Top             =   5545
         Width           =   1155
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Código Imp. Renta:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   28
         Left            =   4440
         TabIndex        =   99
         Top             =   5545
         Width           =   1650
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Cobro Comisión:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   27
         Left            =   3000
         TabIndex        =   95
         Top             =   7380
         Width           =   1380
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Servicio Botón Pago:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   26
         Left            =   120
         TabIndex        =   89
         Top             =   3720
         Width           =   1815
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Facturación Diaria:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   23
         Left            =   120
         TabIndex        =   88
         Top             =   7380
         Width           =   1635
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   2
         Left            =   3000
         TabIndex        =   82
         Top             =   1920
         Width           =   1665
      End
      Begin VB.Label Label1 
         BackColor       =   &H00C0C0C0&
         Height          =   375
         Left            =   3480
         TabIndex        =   81
         Top             =   2520
         Width           =   1455
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Costo x Canal:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   22
         Left            =   120
         TabIndex        =   80
         Top             =   1920
         Width           =   1245
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   9
         Left            =   5040
         TabIndex        =   79
         Top             =   4105
         Width           =   1395
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   8
         Left            =   3240
         TabIndex        =   78
         Top             =   4105
         Width           =   1035
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "IVA:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   18
         Left            =   120
         TabIndex        =   77
         Top             =   4105
         Width           =   495
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   6
         Left            =   2850
         TabIndex        =   71
         Top             =   5905
         Width           =   5145
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Dias Reintentos:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   17
         Left            =   120
         TabIndex        =   70
         Top             =   6625
         Width           =   1425
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Rubro:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   16
         Left            =   3600
         TabIndex        =   69
         Top             =   6985
         Width           =   585
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Código de Servicio:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   15
         Left            =   120
         TabIndex        =   68
         Top             =   6985
         Width           =   1680
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Región País :"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   24
         Left            =   3000
         TabIndex        =   66
         Top             =   6630
         Width           =   1185
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   7
         Left            =   3240
         TabIndex        =   60
         Top             =   5545
         Width           =   1095
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Referencia de Estado de Cuenta:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   13
         Left            =   2880
         TabIndex        =   59
         Top             =   6305
         Width           =   2850
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Gen.Contabilidad:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   11
         Left            =   120
         TabIndex        =   58
         Top             =   6305
         Width           =   1530
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Origen Catálogo:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   10
         Left            =   120
         TabIndex        =   57
         Top             =   5905
         Width           =   1440
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Ret. Imp. Renta:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   9
         Left            =   120
         TabIndex        =   56
         Top             =   5545
         Width           =   1425
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Costo x Transacción:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   8
         Left            =   120
         TabIndex        =   55
         Top             =   1560
         Width           =   1815
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Nombre:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   7
         Left            =   120
         TabIndex        =   54
         Top             =   220
         Width           =   720
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   4
         Left            =   2850
         TabIndex        =   53
         Top             =   4510
         Width           =   5145
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Forma de Pago"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   2
         Left            =   120
         TabIndex        =   52
         Top             =   4510
         Width           =   1290
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   1
         Left            =   3360
         TabIndex        =   51
         Top             =   5185
         Width           =   4635
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Cuenta:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   3
         Left            =   120
         TabIndex        =   45
         Top             =   5185
         Width           =   675
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Número de RUC:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   1
         Left            =   120
         TabIndex        =   47
         Top             =   540
         Width           =   1440
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Tipo Cta:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   4
         Left            =   120
         TabIndex        =   48
         Top             =   4825
         Width           =   795
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Dirección:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   6
         Left            =   120
         TabIndex        =   43
         Top             =   860
         Width           =   885
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Días de Floating:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   0
         Left            =   120
         TabIndex        =   44
         Top             =   1170
         Width           =   1485
      End
   End
   Begin VB.Frame Fra1 
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H000000FF&
      Height          =   495
      Index           =   3
      Left            =   120
      TabIndex        =   72
      Top             =   970
      Visible         =   0   'False
      Width           =   8175
      Begin VB.CheckBox chkConcGrupo 
         Height          =   255
         Left            =   1920
         TabIndex        =   74
         Top             =   200
         Width           =   255
      End
      Begin VB.CheckBox chkAcredGrupo 
         Height          =   255
         Left            =   5160
         TabIndex        =   73
         Top             =   200
         Width           =   255
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Conciliaciòn Grupo:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   25
         Left            =   120
         TabIndex        =   76
         Top             =   200
         Width           =   1680
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Acreditaciòn Grupo:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   21
         Left            =   3360
         TabIndex        =   75
         Top             =   200
         Width           =   1710
      End
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   4
      Left            =   8370
      TabIndex        =   39
      Tag             =   "8002"
      Top             =   2880
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "&Modificar"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8370
      TabIndex        =   41
      Top             =   4560
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "&Salir"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8370
      TabIndex        =   40
      Top             =   3720
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "&Limpiar"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8370
      TabIndex        =   38
      Top             =   2040
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "&Transmitir"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Enabled         =   0   'False
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   8370
      TabIndex        =   37
      Top             =   60
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "&Buscar"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Frame Fra1 
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H000000FF&
      Height          =   975
      Index           =   0
      Left            =   120
      TabIndex        =   42
      Top             =   0
      Width           =   8175
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   0
         Left            =   1320
         MaxLength       =   5
         TabIndex        =   0
         Top             =   170
         Width           =   700
      End
      Begin Threed.SSFrame frmGrupo 
         Height          =   345
         Left            =   2040
         TabIndex        =   1
         Top             =   525
         Width           =   1695
         _Version        =   65536
         _ExtentX        =   2990
         _ExtentY        =   609
         _StockProps     =   14
         ForeColor       =   255
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Small Fonts"
            Size            =   6.76
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Enabled         =   0   'False
         Begin Threed.SSOption optGrupo 
            Height          =   150
            Index           =   1
            Left            =   120
            TabIndex        =   2
            TabStop         =   0   'False
            Top             =   120
            Width           =   735
            _Version        =   65536
            _ExtentX        =   1296
            _ExtentY        =   265
            _StockProps     =   78
            Caption         =   "No"
            ForeColor       =   8388608
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Small Fonts"
               Size            =   6.76
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
         Begin Threed.SSOption optGrupo 
            Height          =   180
            Index           =   0
            Left            =   960
            TabIndex        =   3
            TabStop         =   0   'False
            Top             =   120
            Width           =   615
            _Version        =   65536
            _ExtentX        =   1085
            _ExtentY        =   317
            _StockProps     =   78
            Caption         =   "Si"
            ForeColor       =   8388608
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Small Fonts"
               Size            =   6.74
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
      End
      Begin Threed.SSFrame FrmPertGrupo 
         Height          =   345
         Left            =   5880
         TabIndex        =   4
         Top             =   525
         Width           =   1695
         _Version        =   65536
         _ExtentX        =   2990
         _ExtentY        =   609
         _StockProps     =   14
         ForeColor       =   255
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Small Fonts"
            Size            =   6.76
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Begin Threed.SSOption optGrupo 
            Height          =   150
            Index           =   3
            Left            =   120
            TabIndex        =   5
            TabStop         =   0   'False
            Top             =   120
            Width           =   615
            _Version        =   65536
            _ExtentX        =   1085
            _ExtentY        =   265
            _StockProps     =   78
            Caption         =   "No"
            ForeColor       =   8388608
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Small Fonts"
               Size            =   6.76
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
         Begin Threed.SSOption optGrupo 
            Height          =   180
            Index           =   2
            Left            =   960
            TabIndex        =   6
            TabStop         =   0   'False
            Top             =   120
            Width           =   615
            _Version        =   65536
            _ExtentX        =   1085
            _ExtentY        =   317
            _StockProps     =   78
            Caption         =   "Si"
            ForeColor       =   8388608
            BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
               Name            =   "Small Fonts"
               Size            =   6.74
               Charset         =   0
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
         End
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Pertenece a Grupo:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   12
         Left            =   4200
         TabIndex        =   65
         Top             =   600
         Visible         =   0   'False
         Width           =   1680
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         Caption         =   "Grupo:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   19
         Left            =   1320
         TabIndex        =   64
         Top             =   600
         Width           =   585
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Empresa"
         ForeColor       =   &H00800000&
         Height          =   285
         Index           =   5
         Left            =   120
         TabIndex        =   50
         Top             =   170
         Width           =   735
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   0
         Left            =   2040
         TabIndex        =   49
         Top             =   165
         Width           =   5265
      End
   End
   Begin VB.Frame Fra1 
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H000000FF&
      Height          =   855
      Index           =   2
      Left            =   120
      TabIndex        =   61
      Top             =   960
      Visible         =   0   'False
      Width           =   8175
      Begin VB.TextBox txtCampo2 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   1
         Left            =   1605
         MaxLength       =   6
         TabIndex        =   8
         Top             =   530
         Width           =   855
      End
      Begin VB.TextBox txtCampo2 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   0
         Left            =   1605
         MaxLength       =   6
         TabIndex        =   7
         Top             =   200
         Width           =   855
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Cod. Proveedor:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   14
         Left            =   120
         TabIndex        =   67
         Top             =   555
         Width           =   1395
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Codigo Grupo:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   20
         Left            =   120
         TabIndex        =   63
         Top             =   200
         Width           =   1230
      End
      Begin VB.Label lblDescripcion1 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   0
         Left            =   2490
         TabIndex        =   62
         Top             =   195
         Width           =   5265
      End
   End
   Begin MSGrid.Grid grdGrupos 
      Height          =   1335
      Left            =   120
      TabIndex        =   32
      Top             =   6710
      Visible         =   0   'False
      Width           =   8175
      _Version        =   65536
      _ExtentX        =   14420
      _ExtentY        =   2355
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
End
Attribute VB_Name = "FTran906"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim FechaProceso$
Dim VLFormato$
Dim VLTransmitir%
Dim VLInicio%
Dim tbling$
Dim secuencial$
Dim ValorPG As Double
Dim MontoPG As Double
Dim MaximoRows%
Dim VLFormatoFecha$
Dim VLPaso As Integer
Dim VLModifica As Integer
' Ref1: Boton de pagos
Dim estadoServicio As Integer
Dim nuevoEstado As Integer
Dim rucEmpresa As String
' Ref1

Private Sub Agregar_Click() 'SMERINO
Dim i As Integer
'valido que esten todos los datos
'For I% = 1 To 3
    If tipo_canal.text = "" Then
        MsgBox "Deben de estar ingresados todos los datos"
        Exit Sub
    End If
    
      If MhValorCanal.text = 0# Then
        MsgBox "Deben de estar ingresados todos los datos"
        Exit Sub
    End If
    'Next I%
PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4%, "32238"
PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "I"
'PMPasoValores SqlConn&, "@i_modo", 0, SQLVARCHAR, "I"
PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT4%, Trim(txtCampo(0).text)
PMPasoValores SqlConn&, "@i_canal", 0, SQLVARCHAR, tipo_canal.text
PMPasoValores SqlConn&, "@i_descripcion", 0, SQLVARCHAR, lblDescripcion(2).Caption
PMPasoValores SqlConn&, "@i_costo", 0, SQLMONEY%, (MhValorCanal)
'PMPasoValores SqlConn&, "@i_costo", 0, SQLVARCHAR, MhValorCanal.Text
If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_insert_costo", True, "Costo Comison Canal") Then
    PMChequea SqlConn&
    buscar
Else
    MsgBox "No fue posible ingresar esa parametrización de Monto por canal"
End If
End Sub

Sub buscar()  'SMERINO
Dim sige As Boolean
'traer la informacion.
sige = True
Grid1.Rows = 1
While sige = True
    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4%, "32238"
    PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "B"
    PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT4%, Trim(txtCampo(0).text)
   ' If Grid1.Rows > 5 Then
     '  Grid1.Row = Grid1.Rows - 1
'        Grid1.Col = 1
'        PMPasoValores SqlConn&, "@i_provincia", 0, SQLCHAR, Grid1.Text
'        Grid1.Col = 2
'        PMPasoValores SqlConn&, "@i_ciudad", 0, SQLVARCHAR, Grid1.Text
  '  End If
    If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_insert_costo", True, "Consulta de costo comision") Then
        If Grid1.Rows > 5 Then
            PMMapeaGrid SqlConn&, Grid1, True
         
        Else
            PMMapeaGrid SqlConn&, Grid1, False
            
       End If
        PMChequea SqlConn&
        If Val(Grid1.Tag) < 0 Then
            sige = True
        Else
            sige = False
    End If

    
    Me.Grid1.ColWidth(4) = 1
    
    

  Else
        MsgBox "No fue posible cargar los datos de los codigos de area"
        Exit Sub
    End If
Wend
End Sub

Private Sub btnConfiguracion_Click()
    'Dim configBtnPago As New frmConfBtnPago
    frmConfBtnPago!lblCodigoEmpresa.Caption = Me.txtCampo(0).text
    frmConfBtnPago!lblNombreEmpresa(0).Caption = Me.lblDescripcion(0).Caption
    frmConfBtnPago!lblRucEmpresa = txtCampo(1).text
    frmConfBtnPago!lblCuenta.Caption = Replace(mskCuenta.text, "-", "")
    frmConfBtnPago!lblTipoCuenta.Caption = CmbTipoID.text
    
    
    '' Verificar tarifa seleccionada
    ' Si esta seleccionado Costo por transaccion
    If Me.Check1.Value = 1 Then
        frmConfBtnPago!lblComision = mhValor.text
        frmConfBtnPago.Show vbModal
    ' Si esta seleccionado Costo por canal
    ElseIf Me.Check2.Value = 1 Then
        Grid1.Col = 1
        If Grid1.text <> "" And Grid1.Row > 0 Then
            tipo_canal.text = Grid1.text
            Grid1.Col = 2
            frmConfBtnPago!lblComision = Grid1.text
            frmConfBtnPago.Show vbModal
        Else
            MsgBox "No está configurado el costo del servicio."
        End If
    Else
        MsgBox "No está configurado el costo del servicio."
    End If
    'Else
    '    MsgBox "No está configurado el costo para el canal Botón de Pagos."
    'End If
End Sub

Private Sub Check1_Click()
Me.Check2.Value = 0
mhValor.Enabled = True
'Me.Check2.Enabled = False
Me.tipo_canal.text = ""
Me.lblDescripcion(2).Caption = ""
Me.MhValorCanal.text = ""
PMLimpiaGrid Grid1  'smerino belcorp
Me.tipo_canal.Enabled = False
Me.MhValorCanal.Enabled = False
Me.Agregar.Enabled = False
Me.Eliminar.Enabled = False
Me.Limpiar.Enabled = False
Me.Grid1.Enabled = True


End Sub

Private Sub Check2_Click()
Me.Check1.Value = 0
Me.tipo_canal.Enabled = True
Me.MhValorCanal.Enabled = True
Me.Agregar.Enabled = True
Me.Eliminar.Enabled = True
Me.Limpiar.Enabled = True
'Me.Check1.Enabled = False
Me.mhValor.text = 0#
mhValor.Enabled = False
buscar


End Sub

Private Sub Chk_CobCom_Click()
    If Chk_CobCom.Value = 1 Then
        FrmCobCom.Visible = True
    Else
        optCobCom(0).Value = False
        optCobCom(1).Value = False
        FrmCobCom.Visible = False
        
    End If

End Sub

Private Sub chkImpIva_Click()
   Select Case chkImpIva.Value
      Case 0
         txtCampo(8).text = ""
         txtCampo(8).Enabled = False
         lblDescripcion(8) = ""
      Case 1
         txtCampo(8).Enabled = True
   End Select
End Sub

Private Sub chkImpRet_Click()
   Select Case chkImpRet.Value
      Case 0
         txtCampo(7).text = ""
         txtCampo(7).Enabled = False
         lblDescripcion(7) = ""
         txtCampo(10).text = ""       'dpereirv 12/11/2018
         txtCampo(10).Enabled = False  'dpereirv 12/11/2018
         lblDescripcion(10) = "" 'dpereirv 12/11/2018
      Case 1
         txtCampo(7).Enabled = True
         txtCampo(10).Enabled = True 'dpereirv 12/11/2018
   End Select
End Sub

Sub CmbTipoID_Click()
  Select Case CmbTipoID.ListIndex
    Case 0

    If mskCuenta.ClipText <> "" Then
        If FMChequeaCtaCte((mskCuenta.ClipText)) Then

'             PMPasoValores SqlConn%, "@t_trn", 0, SQLVARCHAR, "3016"
            PMPasoValores SqlConn&, "@t_trn", 0, SQLVARCHAR, "3016"

'             PMPasoValores SqlConn%, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
            PMPasoValores SqlConn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)

'             PMPasoValores SqlConn%, "@i_mon", 0, SQLINT1, VGMoneda$
            PMPasoValores SqlConn&, "@i_mon", 0, SQLINT1, VGMoneda$

'             PMPasoValores SqlConn%, "@i_rol", 0, SQLINT1, VGRol$
            PMPasoValores SqlConn&, "@i_rol", 0, SQLINT1, VGRol$

'             PMPasoValores SqlConn%, "@i_cerrada", 0, SQLCHAR, "C"
            PMPasoValores SqlConn&, "@i_cerrada", 0, SQLCHAR, "C"

'             If FMTransmitirRPC(SqlConn%, ServerName$, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Cuenta " & "[" & mskCuenta.text & "]") Then
            If FMTransmitirRPC(SqlConn&, ServerName$, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Cuenta " & "[" & mskCuenta.text & "]") Then

'                 PMMapeaObjeto SqlConn%, lblDescripcion(1)
                PMMapeaObjeto SqlConn&, lblDescripcion(1)

'                 'PMMapeaObjetoAB SqlConn%, lblDescripcion(1), lblCliente
                'PMMapeaObjetoAB SqlConn&, lblDescripcion(1), lblCliente

'                 PMChequea SqlConn%
                PMChequea SqlConn&
                VLPaso% = True
            Else
                mskCuenta.text = FMMascara("", VGMascaraCtaCte$)
                lblDescripcion(1).Caption = ""
                mskCuenta.SetFocus
                VLPaso% = True
                Exit Sub
            End If
        Else
            MsgBox "El dígito verificador de la cuenta corriente está incorrecto", 0 + 16, "Mensaje de Error"
            mskCuenta.text = FMMascara("", VGMascaraCtaCte$)
            lblDescripcion(1).Caption = ""
            VLPaso% = True
            mskCuenta.SetFocus
            Exit Sub
        End If
    End If
'------------- AHORROS
   Case 1

     If mskCuenta.ClipText <> "" Then
        If FMChequeaCtaAho((mskCuenta.ClipText)) Then

'             PMPasoValores SqlConn%, "@t_trn", 0, SQLVARCHAR, "4206"
            PMPasoValores SqlConn&, "@t_trn", 0, SQLVARCHAR, "4206"

'             PMPasoValores SqlConn%, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
            PMPasoValores SqlConn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)

'             PMPasoValores SqlConn%, "@i_mon", 0, SQLINT1, VGMoneda$
            PMPasoValores SqlConn&, "@i_mon", 0, SQLINT1, VGMoneda$

'             'PMPasoValores SqlConn%, "@i_cerrada", 0, SQLCHAR, "C"
            'PMPasoValores SqlConn&, "@i_cerrada", 0, SQLCHAR, "C"

'             If FMTransmitirRPC(SqlConn%, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Cuenta " & "[" & mskCuenta.text & "]") Then
            If FMTransmitirRPC(SqlConn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Cuenta " & "[" & mskCuenta.text & "]") Then

'                 PMMapeaObjeto SqlConn%, lblDescripcion(1)
                PMMapeaObjeto SqlConn&, lblDescripcion(1)

'                 PMChequea SqlConn%
                PMChequea SqlConn&
                VLPaso% = True
            Else
                mskCuenta.text = FMMascara("", VGMascaraCtaCte$)
                lblDescripcion(1).Caption = ""
                mskCuenta.SetFocus
                VLPaso% = True
                Exit Sub
            End If
        Else
            MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
            mskCuenta.text = FMMascara("", VGMascaraCtaCte$)
            lblDescripcion(1).Caption = ""
            VLPaso% = True
            mskCuenta.SetFocus
            Exit Sub
        End If
    End If
  End Select

End Sub

Sub cmdBoton_Click(Index As Integer)
   Select Case Index
      Case Is = 0
         Call PLConsultar
      Case Is = 1
         Call PLTransmitir(VLModifica%)
      Case Is = 2
         Call PLLimpiar
         Fra1(1).Enabled = False
         txtCampo(0).text = ""
         lblDescripcion(0) = ""
         txtCampo(0).SetFocus
      Case Is = 3
         Unload Me
      Case Is = 4
         Call PLTransmitir(VLModifica%)
   End Select
End Sub

Function FMValidaTipoDato(TipoDato As String, valor As Integer) As Integer
    FMValidaTipoDato = valor%
    Select Case TipoDato$
    Case "N"
        If (valor% <> 8) And (valor% <> 32) And ((valor% < 48) Or (valor% > 57)) Then
            FMValidaTipoDato = 0
        End If

    Case "A"
        If (valor% <> 8) And (valor% <> 32) And ((valor% < 65) Or (valor% > 90)) And ((valor% < 97) Or (valor% > 122)) And ((valor% < 48) Or (valor% > 57)) Then
            FMValidaTipoDato = 0
        Else
            FMValidaTipoDato = Asc(UCase$(Chr$(valor%)))
        End If

    Case "U"
        FMValidaTipoDato = Asc(UCase$(Chr$(valor%)))

    Case "L"
        FMValidaTipoDato = Asc(LCase$(Chr$(valor%)))

    Case "CU"
            If (valor% <> 8) And (valor% <> 32) And (valor% < 65 Or valor% > 90) And (valor% < 97 Or valor% > 122) Then
                FMValidaTipoDato = 0
            Else
                FMValidaTipoDato = Asc(UCase$(Chr$(valor%)))
            End If

    Case "CL"
            If (valor% <> 8) And (valor% <> 32) And (valor% < 65 Or valor% > 90) And (valor% < 97 Or valor% > 122) Then
                FMValidaTipoDato = 0
            Else
                FMValidaTipoDato = Asc(LCase$(Chr$(valor%)))
            End If

    Case "M"
        If (valor% <> 8) And (valor% <> 32) And (valor% <> 46) And ((valor% < 48) Or (valor% > 57)) Then
            FMValidaTipoDato = 0
        End If

    Case "D"
        If (valor% <> 8) And (valor% <> 32) And (valor% <> 47) And ((valor% < 48) Or (valor% > 57)) Then
            FMValidaTipoDato = 0
        End If

    End Select

End Function

Private Sub Command1_Click()

End Sub

Private Sub Eliminar_Click()

If tipo_canal.text <> "" And MhValorCanal.text <> "" Then
PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4%, "32238"
PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "E"
PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT4%, Trim(txtCampo(0).text)
PMPasoValores SqlConn&, "@i_canal", 0, SQLVARCHAR, tipo_canal.text
If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_insert_costo", True, "Costo Comison Canal") Then
        PMChequea SqlConn&
        buscar
        
        Me.Check2.Value = 0
        Me.tipo_canal.text = ""
        Me.lblDescripcion(2).Caption = ""
        Me.MhValorCanal.text = ""

    Else
        MsgBox "No fue posible eliminar esa parametrización de costo por canal"
    End If
Else
    MsgBox "Debe de especificar el costo del canal a eliminar"
End If

End Sub

Private Sub Form_Activate()
Me.SetFocus
End Sub

'
Sub Form_Load()
    Me.Top = 0
    Me.Left = 0

    VLFormatoFecha$ = Get_Preferencia("FORMATO-FECHA")
    VLFormatoHora$ = "hh:mm:ss"



    cmdBoton(1).Enabled = False
    cmdBoton(4).Enabled = False
    cmdBoton(1).Caption = "&Ingresar"
    CmbTipoID.AddItem "CTE"
    CmbTipoID.AddItem "AHO"
    CmbTipoID.ListIndex = 0
    Cmb_Region.ListIndex = 0  'DAPV/02082012/CNEL
    Me.Height = 9870  '6310 'DAPV/02082012/CNEL
    Fra1(1).Top = 1080 'DAPV/02082012/CNEL
    optGrupo(1).Value = True 'DAPV/02082012/CNEL
    optGrupo(3).Value = True 'DAPV/02082012/CNEL
    Me.Check1.Value = 0 'smerino belcorp
    Me.Check2.Value = 0 'smerino belcorp
    Me.Check1.Enabled = True 'smerino belcorp
    Me.Check2.Enabled = True 'smerino belcorp
    mhValor.Enabled = False 'smerino belcorp
    
    VLModifica% = 0
    mskCuenta.Mask = VGMascaraCtaCte$
End Sub

Private Sub Grid1_DblClick()
Grid1.Col = 1
If Grid1.text <> "" And Grid1.Row > 0 Then
    tipo_canal.text = Grid1.text
    Grid1.Col = 2
    MhValorCanal.text = Grid1.text
    Grid1.Col = 4
    lblDescripcion(2).Caption = Grid1.text
    
    
'    PMPasoValores SqlConn&, "@i_tabla", 0, SQLCHAR, "sv_canal_empresa"
'    PMPasoValores SqlConn&, "@i_tipo", 0, SQLCHAR, "A"
'    If FMTransmitirRPC(SqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtCampo(Index%).Text & "]") Then
'        VLPaso% = True
'        PMMapeaListaH SqlConn&, FCatalogo!lstCatalogo, False
'        PMChequea SqlConn&
'        FCatalogo.Show 1
'        'tipo_canal.Text = VGACatalogo.codigo$
'        lblDescripcion(2).Caption = VGACatalogo.Descripcion$
'        If Trim$(tipo_canal.Text) = "" Then
'           lblDescripcion(2).Caption = ""
'           tipo_canal.SetFocus
'           'VLPaso% = True
'       End If
'     End If
     
    'lblDescripcion(2).Text = Grid1.Text
    'Grid1.Col = 3
    'TxtDatos(3).Text = Grid1.Text
    'txtdatos_LostFocus (1)
    'txtdatos_LostFocus (2)
    'txtdatos_LostFocus (3)
End If
End Sub

Private Sub Limpiar_Click()

'Me.Check2.Value = 0
Me.tipo_canal.text = ""
Me.lblDescripcion(2).Caption = ""
Me.MhValorCanal.text = ""
PMLimpiaGrid Grid1  'smerino belcorp

End Sub

Sub mhvalor_GotFocus()
   FPrincipal!pnlHelpLine.Caption = "Costo por Transaccion cobrada"
   mhValor.SelStart = 0
   mhValor.SelLength = Len(mhValor.text)
End Sub

Sub MhValor_LostFocus()
       If VGDecimales$ = "#,##0" Then
          VTCodMoneda$ = "0"
       Else
          VTCodMoneda$ = "1"
       End If
       Call VerificarDecimales(mhValor, VTCodMoneda$)
End Sub

Private Sub MhValorCanal_GotFocus()
   FPrincipal!pnlHelpLine.Caption = "Costo por Transaccion cobrada por canal"
   MhValorCanal.SelStart = 0
   MhValorCanal.SelLength = Len(MhValorCanal.text)
End Sub

Private Sub MhValorCanal_LostFocus()
     If VGDecimales$ = "#,##0" Then
          VTCodMoneda$ = "0"
       Else
          VTCodMoneda$ = "1"
       End If
       Call VerificarDecimales(MhValorCanal, VTCodMoneda$)
End Sub

Sub mskCuenta_Change()
     VLPaso% = False
End Sub

Sub mskcuenta_GotFocus()
   FPrincipal!pnlHelpLine.Caption = "Número de la Cuenta de Credito"
   mskCuenta.SelStart = 0
   mskCuenta.SelLength = Len(mskCuenta.text)
End Sub

Sub mskCuenta_LostFocus()
    On Error Resume Next
If VLPaso% = False Then
  Select Case CmbTipoID.ListIndex
    Case 0

    If mskCuenta.ClipText <> "" Then
        If FMChequeaCtaCte((mskCuenta.ClipText)) Then

'             PMPasoValores SqlConn%, "@t_trn", 0, SQLVARCHAR, "3016"
            PMPasoValores SqlConn&, "@t_trn", 0, SQLVARCHAR, "3016"

'             PMPasoValores SqlConn%, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
            PMPasoValores SqlConn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)

'             PMPasoValores SqlConn%, "@i_mon", 0, SQLINT1, VGMoneda$
            PMPasoValores SqlConn&, "@i_mon", 0, SQLINT1, VGMoneda$

'             PMPasoValores SqlConn%, "@i_rol", 0, SQLINT1, VGRol$
            PMPasoValores SqlConn&, "@i_rol", 0, SQLINT1, VGRol$

'             PMPasoValores SqlConn%, "@i_cerrada", 0, SQLCHAR, "C"
            PMPasoValores SqlConn&, "@i_cerrada", 0, SQLCHAR, "C"

'             If FMTransmitirRPC(SqlConn%, ServerName$, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Cuenta " & "[" & mskCuenta.text & "]") Then
            If FMTransmitirRPC(SqlConn&, ServerName$, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Cuenta " & "[" & mskCuenta.text & "]") Then

'                 PMMapeaObjeto SqlConn%, lblDescripcion(1)
                PMMapeaObjeto SqlConn&, lblDescripcion(1)

'                 'PMMapeaObjetoAB SqlConn%, lblDescripcion(1), lblCliente
                'PMMapeaObjetoAB SqlConn&, lblDescripcion(1), lblCliente

'                 PMChequea SqlConn%
                PMChequea SqlConn&
                VLPaso% = True
            Else
                mskCuenta.text = FMMascara("", VGMascaraCtaCte$)
                lblDescripcion(1).Caption = ""
                mskCuenta.SetFocus
                VLPaso% = True
                Exit Sub
            End If
        Else
            MsgBox "El dígito verificador de la cuenta corriente está incorrecto", 0 + 16, "Mensaje de Error"
            mskCuenta.text = FMMascara("", VGMascaraCtaCte$)
            lblDescripcion(1).Caption = ""
            VLPaso% = True
            mskCuenta.SetFocus
            Exit Sub
        End If
    End If
'------------- AHORROS
   Case 1

     If mskCuenta.ClipText <> "" Then
        If FMChequeaCtaAho((mskCuenta.ClipText)) Then

'             PMPasoValores SqlConn%, "@t_trn", 0, SQLVARCHAR, "4206"
            PMPasoValores SqlConn&, "@t_trn", 0, SQLVARCHAR, "4206"

'             PMPasoValores SqlConn%, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
            PMPasoValores SqlConn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)

'             PMPasoValores SqlConn%, "@i_mon", 0, SQLINT1, VGMoneda$
            PMPasoValores SqlConn&, "@i_mon", 0, SQLINT1, VGMoneda$

'             'PMPasoValores SqlConn%, "@i_cerrada", 0, SQLCHAR, "C"
            'PMPasoValores SqlConn&, "@i_cerrada", 0, SQLCHAR, "C"

'             If FMTransmitirRPC(SqlConn%, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Cuenta " & "[" & mskCuenta.text & "]") Then
            If FMTransmitirRPC(SqlConn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Cuenta " & "[" & mskCuenta.text & "]") Then

'                 PMMapeaObjeto SqlConn%, lblDescripcion(1)
                PMMapeaObjeto SqlConn&, lblDescripcion(1)

'                 PMChequea SqlConn%
                PMChequea SqlConn&
                VLPaso% = True
            Else
                mskCuenta.text = FMMascara("", VGMascaraCtaCte$)
                lblDescripcion(1).Caption = ""
                mskCuenta.SetFocus
                VLPaso% = True
                Exit Sub
            End If
        Else
            MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
            mskCuenta.text = FMMascara("", VGMascaraCtaCte$)
            lblDescripcion(1).Caption = ""
            VLPaso% = True
            mskCuenta.SetFocus
            Exit Sub
        End If
    End If
  End Select
End If
End Sub

Sub PLConsultar()
    On Error Resume Next

   Dim retorno As Integer
   If Trim(txtCampo(0).text) = "" Then
      MsgBox "Debe el Codigo de la Empresa", 16, "Personalizacion de Empresa"
      txtCampo(0).SetFocus
      Exit Sub
   End If

   ReDim vcarreglo(50) As String
   PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4%, "3225"
   PMPasoValores SqlConn&, "@i_operacion", 0, SQLCHAR%, "Q"
   PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT4%, Trim(txtCampo(0).text)
   
   If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_tr_person_empresa", True, " Ok... Consulta de Tarjeta " & "[" & txtCampo(0).text & "]") Then
      VTR% = FMMapeaArreglo(SqlConn&, vcarreglo())
      PMChequea SqlConn&
      If VTR% <> 0 Then
         txtCampo(1) = vcarreglo(1)  'ruc
         txtCampo(2) = vcarreglo(2)  'direccion
         txtCampo(5) = vcarreglo(3)  'Nombre
         txtCampo(3) = vcarreglo(4)   'dias
         If vcarreglo(5) = "S" Then
            optLaborables(1).Value = True
         Else
            optLaborables(0).Value = True
         End If
         txtCampo(4) = vcarreglo(6)   'fpago
         txtCampo_LostFocus (4)
         VLModifica% = 1   '"M"
         Select Case vcarreglo(7)
            Case "CTE"
               CmbTipoID.ListIndex = 0
            Case "AHO"
               CmbTipoID.ListIndex = 1
         End Select
         If vcarreglo(8) <> "" Then
            mskCuenta.text = FMMascara(vcarreglo(8), VGMascaraCtaCte$)
            VLPaso% = False
            mskCuenta_LostFocus
         End If
         mhValor.text = vcarreglo(9)
         chkImpRet.Value = vcarreglo(10)
         chkImpIva.Value = vcarreglo(25)  ' iva  ame 12/15/2012
         txtCampo(6) = vcarreglo(11)
         chkConta.Value = vcarreglo(12)
         chkRefEstcta.Value = vcarreglo(14)
         If vcarreglo(15) <> "" Then
            txtCampo(7) = vcarreglo(15)
            txtCampo_LostFocus (7)
         End If
         
        If vcarreglo(26) <> "" Then    'porc iva  ame 12/15/2012
            txtCampo(8) = vcarreglo(26)
            txtCampo_LostFocus (8)
             
             
         End If
         txtCampo(9) = vcarreglo(27)
         txtCampo_LostFocus (9)
         
         If vcarreglo(16) = "S" Then 'DAPV/02092012/CNEL
            optGrupo(0).Value = True
            ConsultarGidGrupo
         Else
            optGrupo(0).Value = False
            optGrupo(1).Value = True
            PMLimpiaGrid grdGrupos
         End If
         
         If Trim(vcarreglo(17)) <> "" Then 'DAPV/02092012/CNEL
            optGrupo(2).Value = True
            txtCampo2(0).text = vcarreglo(17)
            txtCampo2(0).SetFocus
            txtCampo(0).SetFocus
            txtCampo2(1).text = vcarreglo(21)
        Else
            optGrupo(3).Value = True
            If vcarreglo(18) = "S" Then
                chkConcGrupo.Value = 1
            Else
                chkConcGrupo.Value = 0
            End If
            If vcarreglo(19) = "S" Then
                chkAcredGrupo.Value = 1
            Else
                chkAcredGrupo.Value = 0
            End If
        End If
         
        If vcarreglo(22) = "Costa" Then 'DAPV/02092012/CNEL
            Cmb_Region.ListIndex = 0
        End If
        If vcarreglo(22) = "Sierra" Then 'DAPV/02092012/CNEL
            Cmb_Region.ListIndex = 1
        End If
        If vcarreglo(22) = "Oriente" Then 'DAPV/02092012/CNEL
            Cmb_Region.ListIndex = 2
        End If
        If vcarreglo(22) = "Insular" Then 'DAPV/02092012/CNEL
            Cmb_Region.ListIndex = 3
        End If
         
        txtCampo2(4).text = vcarreglo(22) 'DAPV/02112012/CNEL
        txtCampo2(2).text = vcarreglo(23) 'DAPV/02112012/CNEL
        txtCampo2(3).text = vcarreglo(24) 'DAPV/02112012/CNEL
         
        If vcarreglo(28) = "S" Then   'smerino belcorp
            Me.Check2.Value = 0
            Me.Check1.Value = 0
         Else
            If mhValor.text = 0# Then
               Me.Check2.Value = 0
               Me.Check1.Value = 0
            Else
               Me.Check2.Value = 0
               Me.Check1.Value = 1
            End If
         End If
         ChkFactura.Value = IIf(vcarreglo(29) = "S", 1, 0)  'JPM 07/Abr/2016
         
         VLCobroCom = vcarreglo(30)
         
        If Trim(VLCobroCom) <> "" Then
            Chk_CobCom.Value = 1
            If Trim(VLCobroCom) = "M" Then
                optCobCom(0).Value = True
                optCobCom(1).Value = False
            Else
                optCobCom(0).Value = False
                optCobCom(1).Value = True
            End If
        Else
            Chk_CobCom.Value = 0
        End If
            
         If chkImpRet.Value = 1 Then   'dpereirv    11/12/2018
            txtCampo(10) = vcarreglo(31)
            txtCampo_LostFocus (10)
         End If
         
         cmdBoton(1).Enabled = False
         cmdBoton(4).Enabled = True
         VLPaso% = True
         txtCampo(5).SetFocus        'verificar si esta linea esta en el fuente original
         
         buscar 'smerino belcorp
         
         If Grid1.text <> "" And Grid1.Row > 0 Then
           Me.Check2.Value = 1
         End If
         
      Else
         cmdBoton(1).Enabled = True
         cmdBoton(1).Caption = "&Ingresar"
         VLModifica% = 0
      End If
   Else
      cmdBoton(4).Enabled = False
      cmdBoton(1).Enabled = True
      cmdBoton(1).Caption = "&Ingresar"
      txtCampo(0).SetFocus
   End If
   ' Ref1: Validar si empresa tiene configurado servicio de boton de pagos
   ValidarBtnPago
   ' Ref1
End Sub
Sub PLLimpiar()
    Chk_CobCom.Value = 0
    FrmCobCom.Visible = False
    optCobCom(0).Value = False
    optCobCom(1).Value = False
    
   chkImpRet.Value = 0
   chkImpIva.Value = 0
   chkConta.Value = 0
   ChkFactura.Value = 0         'JPM 07/Abr/2016
   chkRefEstcta.Value = 0
   For i% = 1 To 9
      txtCampo(i%).text = ""
   Next i%
   lblDescripcion(1) = ""
   lblDescripcion(4) = ""
   lblDescripcion(6) = ""
   lblDescripcion(7) = ""
   lblDescripcion(8) = ""
   lblDescripcion(9) = ""
   lblDescripcion(10) = "" 'dpereirv 11/12/2018
   mhValor = ""
   mskCuenta.text = FMMascara("", VGMascaraCtaCte$)
   VLModifica% = 0
   cmdBoton(4).Enabled = False
   VLPaso% = True
   
   PMLimpiaGrid grdGrupos      'DAPV/02102012/CNEL
   txtCampo2(0).text = ""           'DAPV/02092012/CNEL
   lblDescripcion1(0).Caption = ""  'DAPV/02092012/CNEL
   chkConcGrupo.Value = 0           'DAPV/02092012/CNEL
   chkAcredGrupo.Value = 0          'DAPV/02092012/CNEL
   Cmb_Region.ListIndex = 0         'DAPV/02082012/CNEL
   Me.Height = 9870 '6310                 'DAPV/02082012/CNEL
   frmGrupo.Enabled = False         'DAPV / 2082012 / CNEL
   FrmPertGrupo.Enabled = False         'DAPV / 2082012 / CNEL
   Fra1(1).Top = 1080  'DAPV/02082012/CNEL
   Fra1(2).Visible = False 'DAPV/02082012/CNEL
   Fra1(3).Visible = False 'DAPV/02082012/CNEL
   optGrupo(1).Value = True 'DAPV/02082012/CNEL
   optGrupo(3).Value = True 'DAPV/02082012/CNEL
   txtCampo2(1).text = ""           'DAPV/02102012/CNEL
   txtCampo2(2).text = ""           'DAPV/02102012/CNEL
   txtCampo2(3).text = ""           'DAPV/02102012/CNEL
   txtCampo2(4).text = ""           'DAPV/02102012/CNEL
   
   Me.Check1.Value = 0  'smerino belcorp
   Me.Check2.Value = 0 'smerino belcorp
   Me.tipo_canal.text = "" 'smerino belcorp
   Me.lblDescripcion(2).Caption = "" 'smerino belcorp
   Me.MhValorCanal = "" 'smerino belcorp
   PMLimpiaGrid Grid1  'smerino belcorp
  ' Me.Grid1.DataBindings=
   
 ' Ref1: Boton de pagos
 Me.optBtnPago(0).Value = False
 Me.optBtnPago(1).Value = True
 ' Ref1
   
   
   
   
   
End Sub

Sub PLSalir()
Me.Visible = False
End Sub

Sub PLTransmitir(opcion%)
   If Trim(txtCampo(0).text) = "" Then
      MsgBox "Debe ingresar el Codigo de la Empresa", 16, "Personalizacion de Empresas"
      txtCampo(0).SetFocus
      Exit Sub
   End If
   If Trim(txtCampo(1).text) = "" Then
      MsgBox "Debe ingresar el Numero de Ruc de la Empresa", 16, "Personalizacion de Empresas"
      txtCampo(1).SetFocus
      Exit Sub
   End If

   If Trim(txtCampo(2).text) = "" Then
      MsgBox "Debe ingresar la Direccion de la Empresa", 16, "Personalizacion de Empresas"
      txtCampo(2).SetFocus
      Exit Sub
   End If

    If optGrupo(2).Value = True Then 'DAPV/02092012/CNEL
        If Trim(txtCampo2(0).text) = "" Then
           MsgBox "Debe ingresar el còdigo de grupo al que pertenece", 16, "Personalizacion de Empresas"
           txtCampo2(0).SetFocus
           Exit Sub
        End If
    End If
    
    If Chk_CobCom.Value = 1 Then
        If optCobCom(0).Value = False And optCobCom(1).Value = False Then
            MsgBox "Debe seleccionr el tipo de cobro comisión", 16, "Personalizacion de Empresas"
           Exit Sub
        End If
    End If
    
   If Trim(txtCampo(3).text) = "" Then
      'MsgBox "Debe ingresar los días de floating", 16, "Personalizacion de Empresas"
      'txtcampo(3).SetFocus
      'Exit Sub
      txtCampo(3).text = "0"
   End If

   If optLaborables(1).Value = True Then
       VTLaborables = "S"
   Else
       VTLaborables = "N"
   End If


   If Trim(txtCampo(4).text) = "" Then
      MsgBox "Debe Ingresar la Forma de Pago", 16, "Personalizacion de Empresas"
      txtCampo(4).SetFocus
      Exit Sub
   End If

   If Trim(txtCampo(4).text) = "NCRCTA" Then
    If Trim(mskCuenta.ClipText) = "" Then
       MsgBox "Debe ingresar la cuenta a procesar", 16, "Mantenimiento de Saldos Pago Intereses"
       mskCuenta.SetFocus
       Exit Sub
    End If
   End If
   
   If chkImpRet.Value = 1 Then
        If Trim(txtCampo(7).text) = "" Then
            MsgBox "Debe Ingresar el porcentaje de retención", 16, "Personalizacion de Empresas"
            txtCampo(7).SetFocus
            Exit Sub
        End If
        
        If Trim(txtCampo(10).text) = "" Then
            MsgBox "Debe Ingresar el código de retención", 16, "Personalizacion de Empresas"
            txtCampo(10).SetFocus
            Exit Sub
        End If
   End If


   Dim tipoid As String * 3
   Select Case CmbTipoID.ListIndex
      Case 0
         tipoid = "CTE"
      Case 1
         tipoid = "AHO"
   End Select
   
   PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4%, "3225"
   If opcion% = 0 Then
      PMPasoValores SqlConn&, "@i_operacion", 0, SQLCHAR%, "I"
   Else
      PMPasoValores SqlConn&, "@i_operacion", 0, SQLCHAR%, "U"
   End If
   PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT4%, Trim(txtCampo(0).text)
   PMPasoValores SqlConn&, "@i_ruc", 0, SQLVARCHAR%, Trim(txtCampo(1).text)
   PMPasoValores SqlConn&, "@i_direccion", 0, SQLVARCHAR, Trim(txtCampo(2).text)
   PMPasoValores SqlConn&, "@i_dias", 0, SQLINT2%, Trim(txtCampo(3).text)
   PMPasoValores SqlConn&, "@i_laborables", 0, SQLCHAR%, VTLaborables
   PMPasoValores SqlConn&, "@i_fpago", 0, SQLVARCHAR%, Trim(txtCampo(4).text)
   PMPasoValores SqlConn&, "@i_tipo_cta", 0, SQLVARCHAR%, tipoid
   PMPasoValores SqlConn&, "@i_cta", 0, SQLVARCHAR%, (mskCuenta.ClipText)
   PMPasoValores SqlConn&, "@i_nombre", 0, SQLVARCHAR%, Trim(txtCampo(5).text)
   PMPasoValores SqlConn&, "@i_costo", 0, SQLMONEY%, (mhValor)
   PMPasoValores SqlConn&, "@i_impret", 0, SQLINT2%, chkImpRet.Value
 
   If Trim$(txtCampo(7).text) <> "" Then
      PMPasoValores SqlConn&, "@i_porc_retimp", 0, SQLFLT8%, Trim$(txtCampo(7).text)
   End If
   
   
   
   If Trim$(txtCampo(6).text) <> "" Then
      PMPasoValores SqlConn&, "@i_oricat", 0, SQLINT4%, Trim(txtCampo(6).text)
   Else
      PMPasoValores SqlConn&, "@i_oricat", 0, SQLINT4%, "0"
   End If
   PMPasoValores SqlConn&, "@i_porcentaje", 0, SQLINT4%, "0"
   PMPasoValores SqlConn&, "@i_conta", 0, SQLINT2%, chkConta.Value
   PMPasoValores SqlConn&, "@i_refestcta", 0, SQLINT2%, chkRefEstcta.Value
   
   If optGrupo(0).Value = True Then   'DAPV/02092012/CNEL
    PMPasoValores SqlConn&, "@i_grupo", 0, SQLCHAR%, "S"
        If chkConcGrupo.Value = 1 Then
            PMPasoValores SqlConn&, "@i_concilia_grp", 0, SQLCHAR%, "S"
        Else
            PMPasoValores SqlConn&, "@i_concilia_grp", 0, SQLCHAR%, "N"
        End If
        If chkAcredGrupo.Value = 1 Then
            PMPasoValores SqlConn&, "@i_acedita_grp", 0, SQLCHAR%, "S"
        Else
            PMPasoValores SqlConn&, "@i_acedita_grp", 0, SQLCHAR%, "N"
        End If
   Else
    PMPasoValores SqlConn&, "@i_grupo", 0, SQLCHAR%, "N"
   End If
   
   If optGrupo(2).Value = True Then 'DAPV/02092012/CNEL
    PMPasoValores SqlConn&, "@i_cod_grupo", 0, SQLINT4%, Trim(txtCampo2(0).text)
   End If
   
   'smerino
   
    If Check1.Value = 1 Then
            PMPasoValores SqlConn&, "@i_imdCost", 0, SQLCHAR%, "N"
        Else
            If Check2.Value = 1 Then
            PMPasoValores SqlConn&, "@i_imdCost", 0, SQLCHAR%, "S"
            End If
        End If
   
   'fin smerino
   
   
   PMPasoValores SqlConn&, "@i_region_pais", 0, SQLCHAR%, Trim(Cmb_Region.text) 'DAPV/02092012/CNEL
   PMPasoValores SqlConn&, "@i_cod_proveed", 0, SQLINT4%, Trim(txtCampo2(1).text) 'DAPV/02092012/CNEL
   PMPasoValores SqlConn&, "@i_dias_reint", 0, SQLINT4%, Trim(txtCampo2(4).text) 'DAPV/02092012/CNEL
   PMPasoValores SqlConn&, "@i_cod_serv", 0, SQLCHAR%, Trim(txtCampo2(2).text) 'DAPV/02092012/CNEL
   PMPasoValores SqlConn&, "@i_rubro", 0, SQLCHAR%, Trim(txtCampo2(3).text) 'DAPV/02092012/CNEL
   
   PMPasoValores SqlConn&, "@i_pe_impiva", 0, SQLINT2%, chkImpIva.Value
   If Trim$(txtCampo(8).text) <> "" Then
      PMPasoValores SqlConn&, "@i_porc_impiva", 0, SQLFLT8%, Trim$(txtCampo(8).text)
   End If
   PMPasoValores SqlConn&, "@i_serv_com", 0, SQLVARCHAR, Trim(txtCampo(9).text)
   PMPasoValores SqlConn&, "@i_fact_diaria", 0, SQLCHAR%, IIf(ChkFactura.Value = 1, "S", "N")        'JPM 07/Abr/2016
   
    If Chk_CobCom.Value = 1 Then
        If optCobCom(0).Value = True Then
            PMPasoValores SqlConn&, "@e_periodo_com", 0, SQLCHAR%, "M"
        Else
            PMPasoValores SqlConn&, "@e_periodo_com", 0, SQLCHAR%, "D"
        End If
    Else
        PMPasoValores SqlConn&, "@e_periodo_com", 0, SQLCHAR%, ""
    End If
   
   If chkImpRet.Value = 1 Then
        PMPasoValores SqlConn&, "@e_cod_ret", 0, SQLVARCHAR, Trim(txtCampo(10).text)
   End If
   
   ' Ref1: Validacion de estado del servicio del boton de pagos
   nuevoEstado = 0
   If Me.optBtnPago.item(0).Value Then
        nuevoEstado = 1
   End If
   rucEmpresa = Trim(txtCampo(1).text)
   Dim continuar As Boolean
   continuar = False
   ' Ref1
   
   If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_tr_person_empresa", True, " Ok... Consulta del Cliente " & "[" & txtCampo(1).text & "]") Then
      PMChequea SqlConn&
      Call PLLimpiar
      Fra1(1).Enabled = False
      cmdBoton(2).SetFocus
      continuar = True
   Else
      txtCampo(0).SetFocus
   End If
   ' Ref1: Validacion de estado del servicio del boton de pagos
   If continuar Then
        EstadoServicioBtnPago
   End If
   ' Ref2
End Sub


Private Sub optGrupo_Click(Index As Integer, Value As Integer) 'DAPV/02082012/CNEL
Select Case Index
    Case 0:
        FrmPertGrupo.Visible = False
        lblEtiqueta(12).Visible = False
        Me.Height = 9870 '8180
        grdGrupos.Visible = True
        grdGrupos.Top = 6310
        Fra1(1).Top = 1580
        Fra1(2).Visible = False
        Fra1(3).Visible = True
    Case 1:
        FrmPertGrupo.Visible = True
        lblEtiqueta(12).Visible = True
        Me.Height = 9870 ' 6310
        grdGrupos.Visible = False
        optGrupo(3).Value = True
        Fra1(3).Visible = False
        Me.Height = 9870 '6310
        Fra1(1).Top = 1080
    Case 2:
        Me.Height = 10305 '9870 '7160
        grdGrupos.Visible = False
        Fra1(1).Top = 1920
        Fra1(2).Visible = True
    Case 3:
        Me.Height = 9870 '6310
        grdGrupos.Visible = False
        Fra1(1).Top = 1080
        Fra1(2).Visible = False
        Fra1(3).Visible = False
        txtCampo2(0).text = ""
        lblDescripcion1(0).Caption = ""
        txtCampo2(1).text = ""
        chkConcGrupo.Value = 0
        chkAcredGrupo.Value = 0
End Select
End Sub

Private Sub Text1_Change()

End Sub

Private Sub tipo_canal_KeyDown(KeyCode As Integer, Shift As Integer)
   If KeyCode% = VGTeclaAyuda% Then
        Select Case Index%
            Case 0
                VLTabla$ = "sv_canal_empresa"
            Case Else
                 Exit Sub
        End Select
        PMPasoValores SqlConn&, "@i_tabla", 0, SQLCHAR, VLTabla$
        PMPasoValores SqlConn&, "@i_tipo", 0, SQLCHAR, "A"
        If FMTransmitirRPC(SqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtCampo(Index%).text & "]") Then
            VLPaso% = True
            PMMapeaListaH SqlConn&, FCatalogo!lstCatalogo, False
            PMChequea SqlConn&
            FCatalogo.Show 1
            tipo_canal.text = VGACatalogo.codigo$
            lblDescripcion(2).Caption = VGACatalogo.Descripcion$
            If Trim$(tipo_canal.text) = "" Then
               lblDescripcion(2).Caption = ""
               tipo_canal.SetFocus
               VLPaso% = True
            Else
               VLPaso% = True
'               If Index% = 0 Then
'                  Fra1(1).Enabled = True
'                  PLLimpiar
'                  cmdBoton(1).Enabled = True
'                  frmGrupo.Enabled = True 'DAPV/02082012/CNEL
'                  FrmPertGrupo.Enabled = True 'DAPV/02082012/CNEL
'               End If
            End If
        End If
    End If
End Sub

Private Sub tipo_canal_KeyPress(KeyAscii As Integer)
  Select Case Index%
        Case 0, 1, 3, 6
            KeyAscii% = FMValidaTipoDato("N", KeyAscii%)
        Case 2, 4, 5
            KeyAscii% = FMValidaTipoDato("U", KeyAscii%)
        Case 7, 8
            KeyAscii% = FMValidaTipoDato("M", KeyAscii%)
    End Select
End Sub

Sub txtCampo_Change(Index As Integer)
    VLPaso% = False
    Select Case Index
    Case 0:
        optGrupo(1).Value = True 'DAPV/02082012/CNEL
        optGrupo(3).Value = True 'DAPV/02082012/CNEL
    End Select
End Sub

Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Código de la Empresa [F5 Ayuda]"
    Case 1
        FPrincipal!pnlHelpLine.Caption = " Código de RUC"
    Case 2
        FPrincipal!pnlHelpLine.Caption = " Direccion de la Empresa"
    Case 3
        FPrincipal!pnlHelpLine.Caption = " Número de Días de Floating"
    Case 4
        FPrincipal!pnlHelpLine.Caption = " Código de Forma de Pago"
    Case 6
        FPrincipal!pnlHelpLine.Caption = " Colegios"
    Case 7
        FPrincipal!pnlHelpLine.Caption = " Porcentaje de Retención del Impuesto a la Renta"
    Case 8
        FPrincipal!pnlHelpLine.Caption = " Porcentaje del Impuesto IVA "
    Case 10
        FPrincipal!pnlHelpLine.Caption = " Código de Retención del Impuesto a la Renta"   'dpereirv 12/11/2018
        
    End Select
    

txtCampo(Index%).SelStart = 0
txtCampo(Index%).SelLength = Len(txtCampo(Index%).text)
VGPaso% = True
End Sub
Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
    If KeyCode% = VGTeclaAyuda% Then
        Select Case Index%
            Case 0
                VLTabla$ = "sv_empresas_luz"
            Case 4
                VLTabla$ = "sv_fpago_empresas"
            Case 6  ' RDG
                VLTabla$ = "re_nom_colegio"      ' RDG
            Case 7
                VLTabla$ = "sv_porc_retimp"
            Case 8
                VLTabla$ = "sv_porc_impiva"
            Case 9
                VLTabla$ = "re_servicio_comision"
            Case 10
                VLTabla$ = "sv_cod_retimp"   'dpereirv   11/12/2018
            Case Else
                 Exit Sub
        End Select
        PMPasoValores SqlConn&, "@i_tabla", 0, SQLCHAR, VLTabla$
        PMPasoValores SqlConn&, "@i_tipo", 0, SQLCHAR, "A"
        If FMTransmitirRPC(SqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtCampo(Index%).text & "]") Then
            VLPaso% = True
            PMMapeaListaH SqlConn&, FCatalogo!lstCatalogo, False
            PMChequea SqlConn&
            FCatalogo.Show 1
            txtCampo(Index%).text = VGACatalogo.codigo$
            lblDescripcion(Index%).Caption = VGACatalogo.Descripcion$
            If Trim$(txtCampo(Index%).text) = "" Then
               lblDescripcion(Index%).Caption = ""
               txtCampo(Index%).SetFocus
               VLPaso% = True
            Else
               VLPaso% = True
               If Index% = 0 Then
                  Fra1(1).Enabled = True
                  PLLimpiar
                  cmdBoton(1).Enabled = True
                  frmGrupo.Enabled = True 'DAPV/02082012/CNEL
                  FrmPertGrupo.Enabled = True 'DAPV/02082012/CNEL
               End If
            End If
        End If
    End If
End Sub

Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
        Case 0, 1, 3, 6
            KeyAscii% = FMValidaTipoDato("N", KeyAscii%)
        Case 2, 4, 5
            KeyAscii% = FMValidaTipoDato("U", KeyAscii%)
        Case 7, 8, 10
            KeyAscii% = FMValidaTipoDato("M", KeyAscii%)
    End Select
End Sub

Sub txtCampo_LostFocus(Index As Integer)
   txtCampo(Index).text = Trim$(txtCampo(Index).text)
   If VLPaso% = False Then
      Select Case Index%
         Case 0
            VLTabla$ = "sv_empresas_luz"
         Case 4
            VLTabla$ = "sv_fpago_empresas"
         Case 6
            VLTabla$ = "re_nom_colegio"
         Case 7
            VLTabla$ = "sv_porc_retimp"
         Case 8
          VLTabla$ = "sv_porc_impiva"
         Case 9
               VLTabla$ = "re_servicio_comision"
         Case 10
               VLTabla$ = "sv_cod_retimp"   'dpereirv  11/12/2018
         Case Else
            Exit Sub
      End Select
      If txtCampo(Index).text <> "" Then
         PMPasoValores SqlConn&, "@i_tabla", 0, SQLCHAR, VLTabla$
         PMPasoValores SqlConn&, "@i_tipo", 0, SQLCHAR, "V"
         PMPasoValores SqlConn&, "@i_codigo", 0, SQLVARCHAR, (txtCampo(Index%).text)
         If FMTransmitirRPC(SqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtCampo(Index%).text & "]") Then
            PMMapeaObjeto SqlConn&, lblDescripcion(Index%)
            PMChequea SqlConn&
            If Index% = 0 Then
               Fra1(1).Enabled = True
               PLLimpiar
               cmdBoton(1).Enabled = True
               frmGrupo.Enabled = True 'DAPV/02082012/CNEL
               FrmPertGrupo.Enabled = True 'DAPV/02082012/CNEL
            End If
            VLPaso% = True
         Else
            txtCampo(Index%).text = ""
            lblDescripcion(Index%).Caption = ""
            VLPaso% = True
         End If
      End If
   End If
    
   If txtCampo(Index).text = "" Then
    If Index <> 5 And Index <> 2 And Index <> 3 Then      'lfcm 31-julio-2007
      lblDescripcion(Index).Caption = ""
    End If                  'lfcm 31-julio-2007
   End If
End Sub

Sub VerificarDecimales(txtcontrol As Control, ByVal moneda As String)
   If CDbl(txtcontrol.text) - Fix(CDbl(txtcontrol.text)) > 0 Then
       If Trim(moneda) = "0" Then
          MsgBox "No puede Ingresar Cantidades con Centavos, en Sucres", 16, "T-Admin"
          txtcontrol.text = "0.00"
          txtcontrol.SetFocus
       End If
   End If
End Sub

Sub txtCampo2_Change(Index As Integer) 'DAPV/02092012/CNEL
    VLPaso% = False
End Sub

Sub txtCampo2_GotFocus(Index As Integer) 'DAPV/02092012/CNEL
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Código de Grupo [F5 Ayuda]"
    End Select

txtCampo2(Index%).SelStart = 0
txtCampo2(Index%).SelLength = Len(txtCampo(Index%).text)
VGPaso% = True
End Sub

Sub txtCampo2_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer) 'DAPV/02092012/CNEL
    If KeyCode% = VGTeclaAyuda% Then
        Select Case Index%
            Case 0
                 PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4%, "43290"
                 PMPasoValores SqlConn&, "@i_modo", 0, SQLINT2%, 0

                If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_tr_grupo_empresas", True, " Consulta de la oficina " & "[" & txtCampo(Index%).text & "]") Then
                    VLPaso% = True
                    PMMapeaListaH SqlConn&, FCatalogo!lstCatalogo, False
                    PMChequea SqlConn&
                    FCatalogo.Show 1
                    txtCampo2(Index%).text = VGACatalogo.codigo$
                    lblDescripcion1(Index%).Caption = VGACatalogo.Descripcion$
                    If Trim$(txtCampo2(Index%).text) = "" Then
                        lblDescripcion1(Index%).Caption = ""
                        txtCampo2(Index%).SetFocus
                        VLPaso% = True
                    Else
                        VLPaso% = True
                    End If
                End If
        End Select
    End If
End Sub

Sub txtCampo2_KeyPress(Index As Integer, KeyAscii As Integer) 'DAPV/02092012/CNEL
    Select Case Index%
        Case 0, 1, 4
            KeyAscii% = FMValidaTipoDato("N", KeyAscii%)
        Case 2, 3
            KeyAscii% = FMValidaTipoDato("CU", KeyAscii%)
    End Select
End Sub
Sub txtCampo2_LostFocus(Index As Integer) 'DAPV/02032012/CNEL
   txtCampo2(Index).text = Trim$(txtCampo2(Index).text)
   Select Case Index
        Case 0:
            If txtCampo2(Index).text <> "" Then
                PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4%, "43290"
                PMPasoValores SqlConn&, "@i_modo", 0, SQLINT2%, 1
                PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT4%, Trim(txtCampo2(0).text)
               
                If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_tr_grupo_empresas", True, " Consulta de la oficina " & "[" & txtCampo(Index%).text & "]") Then
                  PMMapeaObjeto SqlConn&, lblDescripcion1(Index%)
                  PMChequea SqlConn&
                  
                  VLPaso% = True
               Else
                  txtCampo2(Index%).text = ""
                  lblDescripcion1(Index%).Caption = ""
                  VLPaso% = True
               End If
            Else
                lblDescripcion1(Index%).Caption = ""
            End If
    End Select
End Sub


Sub ConsultarGidGrupo() 'DAPV/02092012/CNEL
   PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4%, "43291"
   PMPasoValores SqlConn&, "@i_modo", 0, SQLINT2%, 0
   PMPasoValores SqlConn&, "@i_cod_grupo", 0, SQLINT4%, Trim(txtCampo(0).text)
   If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_tr_regionales_grp", True, " Ok... Consulta de Tarjeta " & "[" & txtCampo(0).text & "]") Then
     PMMapeaGrid SqlConn&, grdGrupos, False
     PMChequea SqlConn&
   End If
End Sub

' Ref1: Metodos de Boton de Pagos
Private Sub optBtnPago_Click(Index As Integer)
Select Case Index
    Case 0:
        Me.btnConfiguracion.Enabled = True
    Case 1:
        Me.btnConfiguracion.Enabled = False
End Select
End Sub

Sub EliminarBtnPago()
   PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4%, "32712"
   PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT4%, Trim(txtCampo(0).text)
   If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "pa_pg_etbtnpago", True, " Ok... Eliminar toda parametrizacion de boton de pago.") Then
      PMChequea SqlConn&
   End If
End Sub

Sub ValidarBtnPago()
   estadoServicio = -1
   PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4%, "32713"
   PMPasoValores SqlConn&, "@i_ruc", 0, SQLVARCHAR%, Trim(txtCampo(1).text)
   PMPasoValores SqlConn&, "@o_existe", 1, SQLINT4%, -1
   If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "pa_pg_vbtnpago", True, " ") Then
      PMChequea SqlConn&
      estadoServicio = FMRetParam$(SqlConn&, 1)
   End If
   If estadoServicio > 0 Then
        Me.optBtnPago.item(0).Value = True
        Me.btnConfiguracion.Enabled = True
   End If
End Sub

Sub EstadoServicioBtnPago()
    If estadoServicio >= 0 Then
    ' Actualizar estado
        PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4%, "32715"
        PMPasoValores SqlConn&, "@i_ruc", 0, SQLVARCHAR%, rucEmpresa
        PMPasoValores SqlConn&, "@i_estado", 0, SQLINT4%, nuevoEstado
        If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "pa_pg_asbtnpgo", True, " ") Then
            PMChequea SqlConn&
            Call PLLimpiar
        End If
    Else
        If nuevoEstado = 1 Then
        ' Ingresar estado
            PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4%, "32714"
            PMPasoValores SqlConn&, "@i_ruc", 0, SQLVARCHAR%, rucEmpresa
            If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "pa_pg_isbtnpgo", True, " ") Then
                PMChequea SqlConn&
                Call PLLimpiar
            End If
        End If
    End If
End Sub
' Ref1
