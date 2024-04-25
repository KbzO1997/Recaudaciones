VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "GRID32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{0F1F1508-C40A-101B-AD04-00AA00575482}#1.0#0"; "mhrinp32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{00025600-0000-0000-C000-000000000046}#5.2#0"; "crystl32.ocx"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form FTran905 
   BackColor       =   &H00C0C0C0&
   ClientHeight    =   6765
   ClientLeft      =   1230
   ClientTop       =   2535
   ClientWidth     =   9435
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
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   6765
   ScaleWidth      =   9435
   Begin VB.TextBox txtCampo 
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
      Left            =   4710
      MaxLength       =   5
      TabIndex        =   45
      Top             =   6390
      Width           =   700
   End
   Begin MSFlexGridLib.MSFlexGrid grdMovimientos 
      Height          =   3375
      Left            =   75
      TabIndex        =   28
      Top             =   735
      Width           =   8175
      _ExtentX        =   14420
      _ExtentY        =   5953
      _Version        =   393216
      BackColor       =   16777215
      BackColorSel    =   12648447
      ForeColorSel    =   12582912
      BackColorBkg    =   14737632
      SelectionMode   =   1
   End
   Begin MhinrelLib.MhRealInput MhValor 
      Height          =   285
      Index           =   1
      Left            =   4710
      TabIndex        =   15
      Top             =   4830
      Width           =   1335
      _Version        =   65536
      _ExtentX        =   2355
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
      Enabled         =   0   'False
      TintColor       =   16711935
      BevelStyle      =   2
      FillColor       =   16777215
      MaxReal         =   9000000000000
      AutoHScroll     =   -1  'True
      CaretColor      =   -2147483642
      Separator       =   -1  'True
   End
   Begin MhinrelLib.MhRealInput MhValor 
      Height          =   285
      Index           =   0
      Left            =   1665
      TabIndex        =   14
      Top             =   4830
      Width           =   1335
      _Version        =   65536
      _ExtentX        =   2355
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
   Begin MSGrid.Grid grdMovimientosx 
      Height          =   975
      Left            =   120
      TabIndex        =   8
      Top             =   840
      Width           =   1815
      _Version        =   65536
      _ExtentX        =   3201
      _ExtentY        =   1720
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
   Begin Crystal.CrystalReport rptcomprobante 
      Left            =   7680
      Top             =   2160
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   348160
      WindowWidth     =   480
      WindowControlBox=   -1  'True
      WindowMaxButton =   -1  'True
      WindowMinButton =   -1  'True
      PrintFileType   =   2
      PrintFileLinesPerPage=   60
   End
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H80000008&
      Height          =   195
      Index           =   1
      Left            =   8160
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   11
      Top             =   405
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      FillColor       =   &H00808080&
      ForeColor       =   &H00808080&
      Height          =   195
      Index           =   0
      Left            =   8160
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   13
      Top             =   150
      Visible         =   0   'False
      Width           =   195
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   675
      Index           =   5
      Left            =   8460
      TabIndex        =   7
      Top             =   2580
      Width           =   900
      _Version        =   65536
      _ExtentX        =   1587
      _ExtentY        =   1191
      _StockProps     =   78
      Caption         =   "&Trasmitir"
      ForeColor       =   12582912
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
      BevelWidth      =   1
      Outline         =   0   'False
      Picture         =   "ftran905.frx":0000
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   675
      Index           =   4
      Left            =   8460
      TabIndex        =   5
      Top             =   4650
      Width           =   900
      _Version        =   65536
      _ExtentX        =   1587
      _ExtentY        =   1191
      _StockProps     =   78
      Caption         =   "&Salir"
      ForeColor       =   12582912
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelWidth      =   1
      Outline         =   0   'False
      Picture         =   "ftran905.frx":5612
   End
   Begin VB.TextBox txtCampo 
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
      Left            =   960
      MaxLength       =   5
      TabIndex        =   0
      Top             =   30
      Width           =   700
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   675
      Index           =   0
      Left            =   8475
      TabIndex        =   2
      Tag             =   "8005;8006"
      Top             =   0
      Width           =   900
      _Version        =   65536
      _ExtentX        =   1587
      _ExtentY        =   1191
      _StockProps     =   78
      Caption         =   "&Buscar"
      ForeColor       =   12582912
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelWidth      =   1
      Outline         =   0   'False
      Picture         =   "ftran905.frx":731C
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   675
      Index           =   2
      Left            =   8460
      TabIndex        =   6
      Tag             =   "8002"
      Top             =   3265
      Width           =   900
      _Version        =   65536
      _ExtentX        =   1587
      _ExtentY        =   1191
      _StockProps     =   78
      Caption         =   "&Modificar"
      ForeColor       =   12582912
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelWidth      =   1
      Outline         =   0   'False
      Picture         =   "ftran905.frx":9026
   End
   Begin MSMask.MaskEdBox mskValor 
      Height          =   285
      Index           =   0
      Left            =   960
      TabIndex        =   1
      Top             =   350
      Width           =   1350
      _ExtentX        =   2381
      _ExtentY        =   503
      _Version        =   393216
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   675
      Index           =   1
      Left            =   8460
      TabIndex        =   3
      Top             =   675
      Width           =   900
      _Version        =   65536
      _ExtentX        =   1587
      _ExtentY        =   1191
      _StockProps     =   78
      Caption         =   "Siguien&tes"
      ForeColor       =   12582912
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
      BevelWidth      =   1
      Outline         =   0   'False
      Picture         =   "ftran905.frx":AD30
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   675
      Index           =   3
      Left            =   8460
      TabIndex        =   4
      Top             =   3955
      Width           =   900
      _Version        =   65536
      _ExtentX        =   1587
      _ExtentY        =   1191
      _StockProps     =   78
      Caption         =   "&Limpiar"
      ForeColor       =   12582912
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelWidth      =   1
      Outline         =   0   'False
      Picture         =   "ftran905.frx":CA3A
   End
   Begin MhinrelLib.MhRealInput MhValor 
      Height          =   285
      Index           =   2
      Left            =   7020
      TabIndex        =   16
      Top             =   4830
      Width           =   1335
      _Version        =   65536
      _ExtentX        =   2355
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
   Begin MhinrelLib.MhRealInput MhValor 
      Height          =   285
      Index           =   3
      Left            =   7020
      TabIndex        =   26
      Top             =   4500
      Width           =   1335
      _Version        =   65536
      _ExtentX        =   2355
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
      MinReal         =   0
      AutoHScroll     =   -1  'True
      CaretColor      =   -2147483642
      DecimalPlaces   =   0
      Separator       =   -1  'True
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   6
      Left            =   8460
      TabIndex        =   29
      Top             =   1800
      Width           =   900
      _Version        =   65536
      _ExtentX        =   1587
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "&Provisional"
      ForeColor       =   12582912
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelWidth      =   1
      Outline         =   0   'False
      Picture         =   "ftran905.frx":EB74
   End
   Begin MhinrelLib.MhRealInput MhValor 
      Height          =   285
      Index           =   4
      Left            =   1665
      TabIndex        =   17
      Top             =   5130
      Width           =   1335
      _Version        =   65536
      _ExtentX        =   2355
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
   Begin MSGrid.Grid Grid1 
      Height          =   780
      Left            =   4710
      TabIndex        =   31
      Top             =   5145
      Width           =   3135
      _Version        =   65536
      _ExtentX        =   5530
      _ExtentY        =   1376
      _StockProps     =   77
      BackColor       =   16777215
      Rows            =   3
      Cols            =   4
      FixedCols       =   0
   End
   Begin MhinrelLib.MhRealInput MhValor 
      Height          =   285
      Index           =   5
      Left            =   1665
      TabIndex        =   33
      Top             =   5445
      Width           =   1335
      _Version        =   65536
      _ExtentX        =   2355
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
   Begin MhinrelLib.MhRealInput MhValor 
      Height          =   285
      Index           =   6
      Left            =   1665
      TabIndex        =   37
      Top             =   5760
      Width           =   1335
      _Version        =   65536
      _ExtentX        =   2355
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
   Begin MhinrelLib.MhRealInput MhValor 
      Height          =   285
      Index           =   7
      Left            =   1665
      TabIndex        =   39
      Top             =   6075
      Width           =   1335
      _Version        =   65536
      _ExtentX        =   2355
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
   Begin MhinrelLib.MhRealInput MhValor 
      Height          =   285
      Index           =   8
      Left            =   1665
      TabIndex        =   41
      Top             =   6390
      Width           =   1335
      _Version        =   65536
      _ExtentX        =   2355
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
   Begin MhinrelLib.MhRealInput MhValor 
      Height          =   285
      Index           =   9
      Left            =   4710
      TabIndex        =   43
      Top             =   6075
      Width           =   1335
      _Version        =   65536
      _ExtentX        =   2355
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
   Begin VB.Label lbl_pag 
      Height          =   240
      Left            =   6480
      TabIndex        =   47
      Top             =   6435
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Cont. Especial:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   16
      Left            =   3345
      TabIndex        =   46
      Top             =   6420
      Width           =   1305
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "IVA Exonerado:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   15
      Left            =   3345
      TabIndex        =   44
      Top             =   6090
      Width           =   1335
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Ret.IVA Serv.:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   14
      Left            =   210
      TabIndex        =   42
      Top             =   6420
      Width           =   1245
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "IVA Servicios:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   13
      Left            =   210
      TabIndex        =   40
      Top             =   6090
      Width           =   1215
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Ret.IVA Bienes:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   12
      Left            =   210
      TabIndex        =   38
      Top             =   5790
      Width           =   1365
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "IVA Bienes:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   11
      Left            =   210
      TabIndex        =   36
      Top             =   5460
      Width           =   1005
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Valor Guardado:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   10
      Left            =   210
      TabIndex        =   35
      Top             =   4845
      Width           =   1395
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Ret.Imp.:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   6120
      TabIndex        =   34
      Top             =   4845
      Width           =   795
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Costo x Canal."
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   9
      Left            =   3360
      TabIndex        =   32
      Top             =   5160
      Width           =   1245
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Base Imponible:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   8
      Left            =   210
      TabIndex        =   30
      Top             =   5160
      Width           =   1365
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Total Trx."
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   7
      Left            =   6120
      TabIndex        =   27
      Top             =   4545
      Width           =   840
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Costo x Rec."
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   3420
      TabIndex        =   25
      Top             =   4845
      Width           =   1110
   End
   Begin VB.Label lbldesfpago 
      BackColor       =   &H00FFFFFF&
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
      ForeColor       =   &H00C00000&
      Height          =   285
      Left            =   2550
      TabIndex        =   24
      Top             =   4500
      Width           =   3450
   End
   Begin VB.Label lblFpago 
      Alignment       =   2  'Center
      BackColor       =   &H00FFFFFF&
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
      ForeColor       =   &H00C00000&
      Height          =   285
      Left            =   1665
      TabIndex        =   23
      Top             =   4500
      Width           =   855
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Forma de Pago:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   210
      TabIndex        =   22
      Top             =   4545
      Width           =   1350
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Fecha de Pago"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   5640
      TabIndex        =   21
      Top             =   4245
      Width           =   1305
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Empresa:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   210
      TabIndex        =   20
      Top             =   4245
      Width           =   795
   End
   Begin VB.Label lblFecha 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00FFFFFF&
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
      ForeColor       =   &H00C00000&
      Height          =   285
      Left            =   7020
      TabIndex        =   19
      Top             =   4170
      Width           =   1335
   End
   Begin VB.Label lblSecuencial 
      Alignment       =   2  'Center
      BackColor       =   &H00FFFFFF&
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
      ForeColor       =   &H00C00000&
      Height          =   315
      Left            =   1665
      TabIndex        =   18
      Top             =   4170
      Width           =   855
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8385
      X2              =   8400
      Y1              =   0
      Y2              =   6780
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8370
      Y1              =   690
      Y2              =   695
   End
   Begin VB.Label lbldescripcion 
      BackColor       =   &H00E0E0E0&
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
      Height          =   285
      Index           =   0
      Left            =   1680
      TabIndex        =   12
      Top             =   30
      Width           =   6625
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Empresa"
      ForeColor       =   &H00800000&
      Height          =   285
      Index           =   1
      Left            =   120
      TabIndex        =   10
      Top             =   30
      Width           =   735
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Fecha"
      ForeColor       =   &H00800000&
      Height          =   285
      Index           =   5
      Left            =   120
      TabIndex        =   9
      Top             =   375
      Width           =   540
   End
End
Attribute VB_Name = "FTran905"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'************************************************************************************
'*                                MODIFICACIONES
'************************************************************************************
'REF  FECHA       AUTOR               DESCRIPCIÓN
'************************************************************************************
'01  14/sep/2015  Miriam Lindao       Tarea: RETIVA-AP-SGC00021353-SGC00021355
'                                     Cambios por Retención de IVA Bienes y Servicios
'02  05/Jul/2019  Danny Olaya S       Pago de LC - Claro PostPago
'03  12/Mar/2020  Luis A. Gusñay C.   RECMPS-91 CLARO BATCH FINES DE SEMANA
'04  20/Mayo/2020 Luis A. Gusñay C.   RECMPS-135 CLARO BATCH FIJO FINES DE SEMANA
'************************************************************************************
Dim VLPaso As Integer
Dim VLTabla As String
Dim VLRows As Integer
Dim VLRowsArch As Integer
Dim VLBorrar As Integer
Dim VLRowsSel As Integer
Dim VLRowsSel2 As Integer
Dim VLSiguiente As String
Dim VLFormatoFecha As String
Dim VLFpago As String
Dim VLfecha_rec As String
Dim VLEstado As String
Dim VLRuc As String
Dim VLDireccion As String
Dim VLCuenta As String
Dim VLIRNA As String
Dim VLIRBB As String
Dim VLIRPD As String
Dim VLIRVL As String
Dim VLSec As String
Dim VLTitulo As String
Dim VLDir_Ofic As String
Dim VLRetimpret As String
Dim VLdesfpago As String
Dim VLNemfpago As String
Dim VLDias As String

Dim VSSec As String
Dim VSRetimpret As String
Dim VLFacElect As String

Dim VTR1%
Dim VLRubros(5, 20) As String
Dim swimpr As Double
Dim swDetalle As Boolean
Dim VTTotVal As String
Dim VTTotRet As String
Dim VTSession As String
Dim VTRegistro As Double
Dim contImp As Double
Dim VTSecEmpresa As Double
Dim VTTipEmpresa As Double

Dim VLExonerado As Boolean
Dim VTRazonSoc As String
Dim VTSecImpres As String         ' 02/14/2003
Dim VTFechaEfec As String         ' 02/14/2003
Dim VTUNOxMil As String
Dim VlFechapag As String
Dim VTPos  As Integer    'smerino
Dim VlNameFile As String 'smerino
Dim VGFechaProceso2 As String 'smerino
Dim VTFechaReg As String 'smerino belcorp

Dim VNSecEmpresa As Long 'ref002

'Constantes
Const IDYES = 6                 ' Yes button pressed
Const IDNO = 7                  ' No button pressed


Dim VLCta$, VLNombre$, VLMonto$, VLMonto1$, VLRecaudacion$, VLRetencion$, VLImpues$, VLCostoTrx$, VLNoTrx$

Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
    Case 0, 1
    '---> DGA 18/Ene/2006
        If Trim$(txtCampo(0)) = "" Then
            MsgBox "El codigo de empresa es obligatorio", 64
            txtCampo(0).SetFocus
            Exit Sub
        End If
        
        If FMVerFormato(mskValor(0), VLFormatoFecha$) = False Then
            MsgBox "La fecha debe estar en formato " & VLFormatoFecha$, 64
            mskValor(0).SetFocus
            Exit Sub
        End If
        
        PLBuscar (Index%)
        'buscar  'busca el costo por canal
    '<--- DGA 18/Ene/2006
    Case 2     'Modificar
      If VLEstado$ = "N" Then
         If Trim$(txtCampo(0)) = "" Then
           MsgBox "El codigo de empresa es obligatorio", 64
           txtCampo(0).SetFocus
           Exit Sub
         End If

         If Trim$(lblfecha) = "" Then
            MsgBox "La fecha de pago es obligatorio", 64
            txtCampo(0).SetFocus
            Exit Sub
         End If


         If Trim$(lblSecuencial) = "" Then
            MsgBox "El codigo de empresa es obligatorio", 64
            txtCampo(0).SetFocus
            Exit Sub
         End If

            'pregunta si desea borrar el registro
         VTMsg$ = "Desea Modificar Registro de Pago " + Chr(13)
         VTMsg$ = VTMsg$ + "Fecha de Pago: " + lblfecha + " - "
         VTMsg$ = VTMsg$ + "Valor: " + mhValor(0)
         VTResp% = MsgBox(VTMsg$, 36, "Pago")
         If VTResp% = IDYES Then
           PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4%, "3223"
           PMPasoValores SqlConn&, "@i_operacion", 0, SQLCHAR%, "U"
           PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT2%, lblSecuencial
           PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME%, lblfecha
           PMPasoValores SqlConn&, "@i_fecha_rec", 0, SQLDATETIME%, VLfecha_rec$
           PMPasoValores SqlConn&, "@i_costo_rec", 0, SQLMONEY%, mhValor(1)
           PMPasoValores SqlConn&, "@i_valor", 0, SQLMONEY%, mhValor(0)
           PMPasoValores SqlConn&, "@i_valor1", 0, SQLMONEY%, mhValor(4)
           PMPasoValores SqlConn&, "@i_sec_impres", 0, SQLVARCHAR%, VTSecImpres
           PMPasoValores SqlConn&, "@i_retimpret", 0, SQLMONEY%, mhValor(2)
           PMPasoValores SqlConn&, "@i_tot_trx", 0, SQLINT2%, mhValor(3).ValueReal
           
           'Ref002 Ini
           If lblSecuencial = 38 Then
            PMPasoValores SqlConn&, "@i_emp_dba", 0, SQLINT2%, VNSecEmpresa
           End If
           'Ref002 Fin
           PMPasoValores SqlConn&, "@i_pag", 0, SQLVARCHAR%, lbl_pag.Caption 'Ref003
           
           If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_tr_pago_empresa", True, "Ok... Consulta de movimientos EMELEC") Then
              PMChequea SqlConn&
              lblSecuencial = ""
              lblfecha = ""
              lblFpago.Caption = ""
              lbldesfpago = ""
              mhValor(0) = "0.00"
              mhValor(1) = "0.00"
              mhValor(2) = "0.00"
              mhValor(3) = "0"
              mhValor(4) = "0.00"
              
              PLBuscar (0)
              'MhValor(0).Enabled = False
           End If
         End If

   Else
        MsgBox "Registro con Estado de Pagado", 64
        Exit Sub
   End If

    Case 3
        VTSession = ""
        VTRegistro = 0
        'limpiar
        VLdesfpago = ""
        VLNemfpago = ""
        txtCampo(0).text = ""
        lblDescripcion(0) = ""
        PLLimpiar
    Case 4
        Unload FTran905
    Case 5
        VTR1% = 0
        VLdesfpago = Trim$(lbldesfpago.Caption)
        VLNemfpago = Trim$(lblFpago.Caption)
        'generacion de pago y comprobante
        If VLEstado$ = "N" Then
           If Trim$(txtCampo(0)) = "" Then
             MsgBox "El codigo de empresa es obligatorio", 64
             txtCampo(0).SetFocus
             Exit Sub
           End If

           If Trim$(lblfecha) = "" Then
              MsgBox "La fecha de pago es obligatorio", 64
              txtCampo(0).SetFocus
              Exit Sub
           End If


           If Trim$(lblSecuencial) = "" Then
              MsgBox "El codigo de empresa es obligatorio", 64
              txtCampo(0).SetFocus
              Exit Sub
           End If

           PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4%, "3227"
           PMPasoValores SqlConn&, "@i_operacion", 0, SQLCHAR%, "P"
           PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT2%, (lblSecuencial)
           PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME%, lblfecha
           PMPasoValores SqlConn&, "@i_fecha_rec", 0, SQLDATETIME%, VLfecha_rec$
           PMPasoValores SqlConn&, "@i_secuencia", 0, SQLINT4%, (lblSecuencial)
           PMPasoValores SqlConn&, "@i_valor", 0, SQLMONEY%, mhValor(0)
           
           'Ref002 Ini
           If lblSecuencial = 38 Then
            PMPasoValores SqlConn&, "@i_emp_dba", 0, SQLINT4%, VNSecEmpresa
           End If
           'Ref002 Fin
           PMPasoValores SqlConn&, "@i_pag", 0, SQLVARCHAR%, lbl_pag.Caption 'Ref003
           
           ' 02/14/2003
           PMPasoValores SqlConn&, "@i_sec_impres", 0, SQLVARCHAR%, Trim$(VTSecImpres)
           PMPasoValores SqlConn&, "@i_tip_empresa", 0, SQLINT4%, Trim$(VTTipEmpresa)

           PMPasoValores SqlConn&, "@o_cta", 1, SQLVARCHAR%, "          "
           PMPasoValores SqlConn&, "@o_nombre", 1, SQLVARCHAR%, Space(100) ' GYC 2004/Ene/06 "                                        "
           PMPasoValores SqlConn&, "@o_valor", 1, SQLMONEY%, ""
           PMPasoValores SqlConn&, "@o_costo_serv", 1, SQLMONEY%, ""
           PMPasoValores SqlConn&, "@o_retencion", 1, SQLMONEY%, ""
           PMPasoValores SqlConn&, "@o_recaudado", 1, SQLMONEY%, ""
           PMPasoValores SqlConn&, "@o_valor1", 1, SQLMONEY%, ""                   'Miguel Aldaz 02/29/2008
           '<Ref01 MLR: nuevos parámetros
           PMPasoValores SqlConn&, "@i_cont_esp", 0, SQLCHAR%, txtCampo(1).text
           PMPasoValores SqlConn&, "@i_retiva_bie", 0, SQLMONEY%, mhValor(6).text
           PMPasoValores SqlConn&, "@i_retiva_ser", 0, SQLMONEY%, mhValor(8).text
           'Fin Ref01>
           
           If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_tr_pago_empresa", True, "Ok... Consulta de movimientos EMELEC") Then
               VTCta$ = FMRetParam$(SqlConn&, 1)
               VTNombre$ = FMRetParam$(SqlConn&, 2)
               VTMonto$ = FMRetParam$(SqlConn&, 3)
               VTImpues$ = FMRetParam$(SqlConn&, 4)
               VTRetencion$ = FMRetParam$(SqlConn&, 5)
               VTRecaudacion$ = FMRetParam$(SqlConn&, 6)
               VTMonto1$ = FMRetParam$(SqlConn&, 7)                               'Miguel Aldaz 02/29/2008
               PMChequea SqlConn&
               VLFpago$ = Format$(VGFechaProceso$, VLFormatoFecha$)
               Call PLPersonEmpresa
               If Len(Trim$(VTCta$)) = 0 Then
                  VTCta$ = VLCuenta
               End If
              
              VLTitulo = "Original: Sujeto Pasivo Retenido"
               '<Ref001 MLR PLComprobante VTCta$, VTNombre$, VTMonto$, VTRecaudacion$, VTRetencion$, VTImpues$, VTMonto1$    'genera comprobante de nc realizada
               PLComprobante VTCta$, VTNombre$, VTMonto$, VTRecaudacion$, VTRetencion$, VTImpues$, VTMonto1$, mhValor(6).text, mhValor(8).text   'Ref001 MLR aumentar parámetros
               lblSecuencial = ""
               lblfecha = ""
               lblFpago.Caption = ""
               lbldesfpago = ""
               mhValor(0) = "0.00"
               mhValor(1) = "0.00"
               mhValor(4) = "0.00"
               
               PLBuscar (0)
           End If
         Else
            VTMsg$ = "Desea Reimprimir Comprobante de Pago " + Chr(13)
            VTMsg$ = VTMsg$ + "Fecha de Pago: " + lblfecha + " - "
            VTMsg$ = VTMsg$ + "Valor: " + mhValor(0)
            VTResp% = MsgBox(VTMsg$, 36, "Pago")
            If VTResp% = IDYES Then
               Call PLPersonEmpresa
               VLTitulo = "Copia: Agente de Retención"
               'PLComprobante VLCta$, VLNombre$, VLMonto$, VLRecaudacion$, VLRetencion$, VLImpues$    'genera comprobante de nc realizada
               '<Ref001 MLR PLComprobante VLCta$, VLNombre$, VLMonto$, VLRecaudacion$, VLRetencion$, VLImpues$, VLMonto1$    'Miguel Aldaz 02/29/2008
               PLComprobante VLCta$, VLNombre$, VLMonto$, VLRecaudacion$, VLRetencion$, VLImpues$, VLMonto1$, mhValor(6).text, mhValor(8).text    'Ref001 MLR aumentar parámetros
            End If
         End If
Case 6
        VTR1% = 0
        VLdesfpago = Trim$(lbldesfpago.Caption)
        VLNemfpago = Trim$(lblFpago.Caption)
        'generacion de pago y comprobante
        If VLEstado$ = "N" Then    'P solo para la prueba
           If Trim$(txtCampo(0)) = "" Then
             MsgBox "El codigo de empresa es obligatorio", 64
             txtCampo(0).SetFocus
             Exit Sub
           End If

           If Trim$(lblfecha) = "" Then
              MsgBox "La fecha de pago es obligatorio", 64
              txtCampo(0).SetFocus
              Exit Sub
           End If

           VlFechapag$ = lblfecha.Caption
           If Trim$(lblSecuencial) = "" Then
              MsgBox "El codigo de empresa es obligatorio", 64
              txtCampo(0).SetFocus
              Exit Sub
           End If

            VTMsg$ = "Desea imprimir Comprobante Provisional de Pago " + Chr(13)
            VTMsg$ = VTMsg$ + "Fecha de Pago: " + lblfecha + " - "
            VTMsg$ = VTMsg$ + "Valor: " + mhValor(0)
            VTResp% = MsgBox(VTMsg$, 36, "Pago")
            If VTResp% = IDYES Then
               Call PLPersonEmpresa
               VLTitulo = "Copia: Agente de Retención"
               '<Ref001 MLR PLComprobanteProvisional VLCta$, VLNombre$, VLMonto$, VLRecaudacion$, VLRetencion$, VLImpues$     'genera comprobante de nc realizada
               PLComprobanteProvisional VLCta$, VLNombre$, VLMonto$, VLRecaudacion$, VLRetencion$, VLImpues$, mhValor(6).text, mhValor(8).text 'Ref001 MLR aumentar parámetros
            End If
         End If
 
End Select
End Sub

Private Sub Form_Activate()
    ' Solo Para las Pruebas
    'CurDir ("c:\cobis\tadmin\")
    'VGPath$ = "c:\cobis\tadmin"
    Me.SetFocus
End Sub

Sub buscar()  'SMERINO
Dim sige As Boolean
'traer la informacion.
sige = True
Grid1.Rows = 1
While sige = True
    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4%, "32238"
    PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "S"
    'PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME%, mskValor(0).Text
    PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME%, VTFechaReg 'VTFechaEfec
    PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT4%, Trim(txtCampo(0).text)
'    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4%, "3222"
'    'PMPasoValores SqlConn&, "@i_modo", 0, SQLINT2%, Modo
'    PMPasoValores SqlConn&, "@i_operacion", 0, SQLCHAR%, "S"
'    PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT2%, txtCampo(0)
'    PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME%, mskValor(0).Text
'    PMPasoValores SqlConn&, "@i_fecha_rec", 0, SQLDATETIME%, VLfecha_rec$
   ' If Grid1.Rows > 5 Then
     '  Grid1.Row = Grid1.Rows - 1
'        Grid1.Col = 1
'        PMPasoValores SqlConn&, "@i_provincia", 0, SQLCHAR, Grid1.Text
'        Grid1.Col = 2
'        PMPasoValores SqlConn&, "@i_ciudad", 0, SQLVARCHAR, Grid1.Text
  '  End If
      'If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_tr_pago_empresa", True, "Ok... Consulta de Pagos") Then
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
    
    'Me.Grid1.ColWidth(4) = 1
    
    

  Else
        MsgBox "No fue posible cargar los datos de los codigos de area"
        Exit Sub
    End If
Wend
End Sub

Sub Form_Load()
    FTran905.Left = 15
    FTran905.Top = 15
    FTran905.Width = 9675 '9440 smerino belcorp
    'FTran905.Height = 5730
    FTran905.Height = 7340 'Re001 se cambia tamaño de pantalla por nuevos campos'7090 '6200  'Miguel Aldaz 03/03/2007
    VLPaso% = True
    VLEstado$ = "N"

    PMBotonSeguridad FTran905, 2
    
    VLFormatoFecha$ = Get_Preferencia("FORMATO-FECHA")
    mskValor(0).Mask = FMMascaraFecha(VLFormatoFecha$)
    mskValor(0).text = Format$(VGFechaProceso$, VLFormatoFecha$)

    cmdBoton(0).Enabled = True
    cmdBoton(1).Enabled = False
    cmdBoton(5).Enabled = True

    VLRowsSel% = 0
    VLRowsSel2% = 0
End Sub

Sub grdMovimientos_Click()
    VLExonerado = False

    grdMovimientos.Col = 0
    'grdMovimientos.SelStartCol = 1
    'grdMovimientos.SelEndCol = grdMovimientos.Cols - 1
    If grdMovimientos.Cols < 3 Then Exit Sub
    If grdMovimientos.Rows < 2 Then Exit Sub
    
    grdMovimientos.Col = 4
    If Len(Trim$(grdMovimientos.text)) = 0 Then
       VTFechaEfec = Format$(VGFechaProceso$, VLFormatoFecha$)
      Else
       VTFechaEfec = grdMovimientos.text
    End If
    
    If VTFechaEfec = "" Then
       VTFechaEfec = Format$(VGFechaProceso$, VLFormatoFecha$)
    End If

    grdMovimientos.Col = 13
    If CCur(grdMovimientos.text) = 0 Then
       VLRetimpret$ = "0"
       VLExonerado = False
       mhValor(2).text = "0.00"
      Else
       VLExonerado = True
       VLRetimpret$ = grdMovimientos.text
       mhValor(2).text = grdMovimientos.text
    End If
    
    grdMovimientos.Col = 14
    If Len(Trim$(grdMovimientos.text)) = 0 Then
       VTTipEmpresa = 0
      Else
       VTTipEmpresa = grdMovimientos.text
    End If
    
    grdMovimientos.Col = 15
    If Len(Trim$(grdMovimientos.text)) = 0 Then
       VTSecEmpresa = 0
      Else
       VTSecEmpresa = grdMovimientos.text
    End If
    
    grdMovimientos.Col = 16
    If Len(Trim$(grdMovimientos.text)) = 0 Then
       VLSec = "0"
       VTSecImpres = ""                         ' 02/14/2003
      Else
       VLSec = grdMovimientos.text
       VTSecImpres = grdMovimientos.text        ' 02/14/2003
    End If

    grdMovimientos.Col = 19
    If Len(Trim$(grdMovimientos.text)) = 0 Then
       VLFacElect = "N"
    Else
       VLFacElect = grdMovimientos.text
    End If
    
'    If grdMovimientos.Row = 0 Then
'        'grdMovimientos.SelStartRow = 1
'        'grdMovimientos.SelEndRow = 1
'    Else
'        'grdMovimientos.SelStartRow = grdMovimientos.Row
'        'grdMovimientos.SelEndRow = grdMovimientos.Row
'    End If

End Sub

Sub grdMovimientos_DblClick()
    ' Verificar que existan Valores para anular
         
       VTPos = grdMovimientos.Row 'smerino variable que guarda la posicion del registro seleccionado
    If grdMovimientos.Rows <= 2 Then
        grdMovimientos.Row = 1
        grdMovimientos.Col = 1
        If Trim$(grdMovimientos.text) = "" Then
            MsgBox "No existen movimientos de pagos para escoger", 0 + 16, "Mensaje de Error"
            Exit Sub
        End If
    End If
    PLEscoger
    
    grdMovimientos.Col = 2  'belcorp
    If Len(Trim$(grdMovimientos.text)) = 0 Then
       VTFechaReg = Format$(VGFechaProceso$, VLFormatoFecha$)
      Else
       VTFechaReg = grdMovimientos.text
    End If
    
    buscar  'busca el costo por canal belcorp
End Sub

Sub grdMovimientos_KeyUp(KeyCode As Integer, Shift As Integer)
'    grdMovimientos.SelStartCol = 1
'    grdMovimientos.SelEndCol = grdMovimientos.Cols - 1
'    If grdMovimientos.Row = 0 Then
'        grdMovimientos.SelStartRow = 1
'        grdMovimientos.SelEndRow = 1
'    Else
'        grdMovimientos.SelStartRow = grdMovimientos.Row
'        grdMovimientos.SelEndRow = grdMovimientos.Row
'    End If

End Sub



Sub mhvalor_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Valor a Guardar"
    Case 1
        FPrincipal!pnlHelpLine.Caption = " Costo de Recaudacion"

    End Select
    mhValor(Index%).SelStart = 0
    mhValor(Index%).SelLength = Len(mhValor(Index%).text)

End Sub

Sub PLBuscar(inicio%)

'    Dim secuencia As Integer
    'If Trim$(txtcampo(0)) = "" Then
    '   MsgBox "El codigo de empresa es obligatorio", 64
    '   txtcampo(0).SetFocus
    '   Exit Sub
    'End If

    Modo = inicio%
    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4%, "3222"
    PMPasoValores SqlConn&, "@i_modo", 0, SQLINT2%, Modo
    PMPasoValores SqlConn&, "@i_operacion", 0, SQLCHAR%, "V"
    PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT2%, txtCampo(0)
    PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME%, mskValor(0).text
        
    If Modo = 1 Then
       grdMovimientos.Row = grdMovimientos.Rows - 1
       grdMovimientos.Col = 17
       VLnumsec = Trim$(Int(Val(grdMovimientos.text)))
       PMPasoValores SqlConn&, "@i_secuencia", 0, SQLINT4%, VLnumsec
    Else
       PMPasoValores SqlConn&, "@i_secuencia", 0, SQLINT4%, "0"
    End If
    If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_tr_pago_empresa", True, "Ok... Consulta de Pagos") Then
     If Modo = 0 Then
     
           'PgMapeaFlexG grdMovimientos, True, False, 0, 20, 19
           'PgMapeaFlexG grdMovimientos, True, False, 0, 20, 22
            'PgMapeaFlexG grdMovimientos, True, False, 0, 20, 25  'smerino
            PgMapeaFlexG grdMovimientos, True, False, 0, 20, 31  'Ref01 MLR se aumentan columnas
        Else
           'PgMapeaFlexG grdMovimientos, False, False, 0, 20, 19
           'PgMapeaFlexG grdMovimientos, False, False, 0, 20, 22
           'PgMapeaFlexG grdMovimientos, False, False, 0, 20, 25  'smerino
           PgMapeaFlexG grdMovimientos, False, False, 0, 20, 31 'Ref01 MLR se aumentan columnas
     
       End If
       FPrincipal!pnlTransaccionLine.Caption = "Búsqueda OK ... "
       PMChequea SqlConn&
       If grdMovimientos.Tag = "20" Then
          cmdBoton(1).Enabled = True
       Else
          cmdBoton(1).Enabled = False
       End If
    Else
       PMLimpiaGrid grdMovimientos
    End If

End Sub
Sub PLComprobanteProvisional(cta As String, Nombre As String, nc As String, recauda As String, retenci As String, Impuesto As String, p_retivabie As String, p_retivaserv As String) 'Ref001 MLR se aumentan parametros retenciones
    On Error GoTo Salir

    For i = 1 To 20
        rptcomprobante.Formulas(i) = ""
    Next i

    If CCur(nc) <= 0 Then
       MsgBox "NC no ha sido realizada aun", 64
       'Exit Sub
    End If

    Screen.MousePointer = 11
    VTFecha$ = Format(mskValor(0).text, "yyyymmdd")
    VTnombarch$ = Mid(lblDescripcion(0), 1, 6) & Mid(lblfecha.Caption, 4, 2) & ".doc"

    'Colocar el nombre del reporte
    ' App.Path &
    rptcomprobante.ReportFileName = App.Path & "\comppro.rpt"
    'descripfpago$ = "HEMOS EFECTUADO LA EMISION DE UNA " & VLdesfpago & " POR EL VALOR DE:"
    descripfpago$ = "HEMOS EFECTUADO LA EMISION DE UN COMPROBANTE PROVISIONAL QUE SERA EFECTIVIZADO EN " & VLDias & "  DIA(S) HABIL(ES) POR EL VALOR DE:"
    VTNomemp$ = lblDescripcion(0)

    If VLNemfpago <> "NCRCTA" Then
       retenci = IIf(Len(Trim$(retenci)) = 0, "0.00", retenci)
       Impuesto = IIf(Len(Trim$(Impuesto)) = 0, "0.00", Impuesto)
       VLRetimpret = IIf(Len(Trim$(VLRetimpret)) = 0, "0.00", VLRetimpret)
       nc = IIf(Len(Trim$(nc)) = 0, "0.00", nc)
       
       nc1 = CCur(nc) - (CCur(retenci) + CCur(VLRetimpret) + CCur(Impuesto) + CCur(p_retivabie) + CCur(p_retivaserv)) 'Ref001 MLR se aumentan retenciones
       nc1 = Format(Trim$(Str(nc1)), "###,###,##0.00")
      Else
       nc1 = nc
       nc1 = Format(Trim$(Str(nc1)), "###,###,##0.00")
    End If
    
    'Pasar los valores a las fórmulas
    rptcomprobante.Formulas(9) = "frecauda= '" + VLfecha_rec$ + " '  "
    rptcomprobante.Formulas(8) = "nomemp= '" + VTNomemp$ + "'"
    rptcomprobante.Formulas(7) = "desfpago= '" + descripfpago$ + "'"
    rptcomprobante.Formulas(3) = "nrocta= '" + VLCuenta$ + "'"
    rptcomprobante.Formulas(6) = "fpago= '" + VlFechapag$ + "'"
    
    If VLEstado$ = "NN" Then
       rptcomprobante.Formulas(2) = "nomcta= '" + Nombre + "'"
      Else
       rptcomprobante.Formulas(2) = "nomcta= '" + VTRazonSoc$ + "'"
    End If
    
    rptcomprobante.Formulas(1) = "montonc= '" + nc1 + "'"
    rptcomprobante.Formulas(4) = "recauda= '" + recauda + "'"
    rptcomprobante.Formulas(5) = "retenc= '" + retenci + "'"
    
    If VLNemfpago <> "NCRCTA" Then
       VLMontoLetra$ = FMConvNumletra1(CCur(nc1))
      Else
       VLMontoLetra$ = FMConvNumletra1(nc)
    End If
    
    rptcomprobante.Formulas(0) = "montoletras= '" + VLMontoLetra$ + "  DOLARES" + "'"
    rptcomprobante.Formulas(12) = "rubro1= '" + "VALORES EN RETENCION : " + "'"
    'rptcomprobante.Formulas(6) = "fpago= '" + VLFpago$ + "'"
    
    If CCur(VLRetimpret) > 0 And VLNemfpago <> "NCRCTA" Then
       rptcomprobante.Formulas(13) = "rubro3 = '" + "RETENCION IMPUESTO A LA RENTA " + "'"
       rptcomprobante.Formulas(14) = "impret = '" + VLRetimpret + "'"
    End If
    
    If CCur(Impuesto) > 0 And VLNemfpago <> "NCRCTA" Then
       rptcomprobante.Formulas(15) = "rubro2   = '" + "COMISION  (con costo " + VLCostoTrx$ + ")" + "'"
       rptcomprobante.Formulas(16) = "costorec = '" + Impuesto + "'"
    End If
    '<Ref001 MLR se presentan los nuevos campos
    If CCur(p_retivabie) > 0 Then
      rptcomprobante.Formulas(21) = "rubro4 = 'RETENCION IVA BIENES'"
      rptcomprobante.Formulas(16) = "costorec = '" + p_retivabie + "'"
    End If
    'Fin Ref001>
    rptcomprobante.Destination = 0 ' Solo Para las Pruebas      <2>
    rptcomprobante.PrintFileName = App.Path & "\" & VTnombarch$
    rptcomprobante.PrintFileType = 17
    rptcomprobante.Action = 1
Salir:
    Screen.MousePointer = 0
    MsgBox " (" & err & ")  " + Error, 64
    Exit Sub

End Sub
Sub PLComprobante(cta As String, Nombre As String, nc As String, recauda As String, retenci As String, Impuesto As String, nc11 As String, p_retivabie As String, p_retivaserv As String)  'Ref001 MLR se aumentan parametros retenciones
    On Error GoTo Salir
    
     'smerino cambia formato de fecha de emision
        Dim Mes As String
        Dim dia As String
        Dim anio As String
        Dim mes2 As String
        
    

    For i = 1 To 24 'Ref001 MLR antes 20
        rptcomprobante.Formulas(i) = ""
    Next i

    If CCur(nc) <= 0 Then
       MsgBox "NC no ha sido realizada aun", 64
       'Exit Sub
    End If

    Screen.MousePointer = 11
    VTFecha$ = Format(mskValor(0).text, "yyyymmdd")
    VTnombarch$ = Mid(lblDescripcion(0), 1, 6) & Mid(lblfecha.Caption, 4, 2) & ".doc"

    'Colocar el nombre del reporte
    ' App.Path &
    rptcomprobante.ReportFileName = App.Path & "\comprec.rpt"
    
    'KBastida Ini
    If VLNemfpago = "PGINTB" Then
        descripfpago$ = "HEMOS EFECTUADO UNA TRANSFERENCIA INTERBANCARIA HACIA BANDRED POR EL VALOR DE:"
    Else
        descripfpago$ = "HEMOS EFECTUADO LA EMISION DE UNA " & VLdesfpago & " POR EL VALOR DE:"
    End If
    'KBastida Fin
    
    'descripfpago$ = "HEMOS EFECTUADO LA EMISION DE UNA " & VLdesfpago & " POR EL VALOR DE:"
    VTNomemp$ = lblDescripcion(0)

    If VLNemfpago <> "NCRCTA" Then
       retenci = IIf(Len(Trim$(retenci)) = 0, "0.00", retenci)
       Impuesto = IIf(Len(Trim$(Impuesto)) = 0, "0.00", Impuesto)
       VLRetimpret = IIf(Len(Trim$(VLRetimpret)) = 0, "0.00", VLRetimpret)
       nc = IIf(Len(Trim$(nc)) = 0, "0.00", nc)
       
       nc1 = CCur(nc) - (CCur(retenci) + CCur(VLRetimpret) + CCur(Impuesto) + CCur(p_retivabie) + CCur(p_retivaserv)) 'Ref001 MLR considerar retenciones
       nc1 = Format(Trim$(Str(nc1)), "###,###,##0.00")
      Else
       nc1 = nc
       nc1 = Format(Trim$(Str(nc1)), "###,###,##0.00")
    End If
    
    'Pasar los valores a las fórmulas
    rptcomprobante.Formulas(9) = "frecauda= '" + VLfecha_rec$ + " '  "
    rptcomprobante.Formulas(8) = "nomemp= '" + VTNomemp$ + "'"
    rptcomprobante.Formulas(7) = "desfpago= '" + descripfpago$ + "'"
    
    'KBastida Ini
    If VLNemfpago <> "PGINTB" Then
        rptcomprobante.Formulas(3) = "nrocta= '" + cta + "'"
    End If
    'KBastida Fin
    
    If VLEstado$ = "NN" Then
       rptcomprobante.Formulas(2) = "nomcta= '" + Nombre + "'"
      Else
       rptcomprobante.Formulas(2) = "nomcta= '" + VTRazonSoc$ + "'"
    End If
    
    rptcomprobante.Formulas(1) = "montonc= '" + nc1 + "'"
    rptcomprobante.Formulas(4) = "recauda= '" + recauda + "'"
    
    '--> lfcm 14-dic-2006
    If txtCampo(0) <> 1719 Then   'Emelmanabi
        rptcomprobante.Formulas(5) = "retenc= '" + retenci + "'"
    End If
    '<-- lfcm 14-dic-2006
    
    If VLNemfpago <> "NCRCTA" Then
       VLMontoLetra$ = FMConvNumletra1(CCur(nc1))
      Else
       VLMontoLetra$ = FMConvNumletra1(nc)
    End If
    
    rptcomprobante.Formulas(0) = "montoletras= '" + VLMontoLetra$ + "  DOLARES" + "'"
    
    '--> lfcm 14-dic-2006
    If txtCampo(0) <> 1719 Then   'Emelmanabi
        rptcomprobante.Formulas(12) = "rubro1= '" + "VALORES EN RETENCION : " + "'"
    End If
    '<-- lfcm 14-dic-2006
    
    rptcomprobante.Formulas(6) = "fpago= '" + VLFpago$ + "'"
    
    If CCur(VLRetimpret) > 0 And VLNemfpago <> "NCRCTA" Then
       rptcomprobante.Formulas(13) = "rubro3 = '" + "RETENCION IMPUESTO A LA RENTA " + "'"
       rptcomprobante.Formulas(14) = "impret = '" + VLRetimpret + "'"
    End If
    
    If CCur(Impuesto) > 0 And VLNemfpago <> "NCRCTA" Then
       rptcomprobante.Formulas(15) = "rubro2   = '" + "COMISION  (con costo " + VLCostoTrx$ + ")" + "'"
       rptcomprobante.Formulas(16) = "costorec = '" + Impuesto + "'"
    End If
    '<Ref001 MLR se presentan los nuevos campos
    If CCur(p_retivabie) > 0 Then
      rptcomprobante.Formulas(21) = "rubro4 = 'RETENCION IVA BIENES'"
      rptcomprobante.Formulas(22) = "retivabienes = '" + p_retivabie + "'"
    End If
    If CCur(p_retivaserv) > 0 Then
      rptcomprobante.Formulas(23) = "rubro5 = 'RETENCION IVA SERVICIOS'"
      rptcomprobante.Formulas(24) = "retivaserv = '" + p_retivaserv + "'"
    End If
    'Fin Ref001>
    rptcomprobante.Destination = 0 ' Solo Para las Pruebas      <2>
    rptcomprobante.PrintFileName = App.Path & "\" & VTnombarch$
    rptcomprobante.PrintFileType = 17
    rptcomprobante.Action = 1

    If VTTipEmpresa = 0 Then    ' Empresas de la Plancha
       swDetalle = False
       VLVerifArchDet$ = "N"
       PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4%, "3227"
       PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT2%, txtCampo(0)
       PMPasoValores SqlConn&, "@i_fechaefec", 0, SQLVARCHAR%, VTFechaEfec
       PMPasoValores SqlConn&, "@i_fecha_rec", 0, SQLDATETIME%, VLfecha_rec$
       PMPasoValores SqlConn&, "@i_operacion", 0, SQLCHAR, "K"
       
       'Ref002 Ini
       If txtCampo(0) = 38 Then
        PMPasoValores SqlConn&, "@i_emp_dba", 0, SQLINT2%, VNSecEmpresa
       End If
       'Ref002 Fin
       PMPasoValores SqlConn&, "@i_pag", 0, SQLVARCHAR%, lbl_pag.Caption 'Ref003
     
       If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_tr_pago_empresa", True, "Ok... Consulta de movimientos EMELEC") Then
          PMMapeaVariable SqlConn&, VLVerifArchDet$
          PMChequea SqlConn&
       End If
     Else
       VLVerifArchDet$ = "S"    ' Empresas de Servicios en Linea
    End If
    
    If VLVerifArchDet$ = "S" Then
       If VTTipEmpresa = 0 Then
          swDetalle = False
          If VLExonerado = True Then
             Call PLImprimir_Detalle_Plan   ' Empresas de la Plancha
          End If
        Else
          swDetalle = False
          If VLExonerado = True Then
             Call PLImprimir_Detalle_Linea  ' Empresas de Servicios en Linea
          End If
       End If
      Else
          VLRetimpret = VLRetimpret$
    End If
    
   
    If VLFacElect = "N" Then   'Miguel ALdaz Facturación electrónica
    
     If (CCur(VLRetimpret) > 0 And swDetalle = False) And VLExonerado = True Then
        For i = 1 To 20
            rptcomprobante.Formulas(i) = ""
        Next i
       
       'Colocar el nombre del reporte
       'rptcomprobante.ReportFileName = App.Path & "\ircmpret.rpt" 'smerimo se comenta para definir abajo si el reporte sera el anterior o el nuevo
              
        ' Parche Para Imprimir Comprobantes Anteriores
        vlFact = "ROLBAN." + Right("000" + txtCampo(0).text, 3) + "." + Mid(VLfecha_rec$, 1, 2) + Mid(VLfecha_rec$, 4, 2) + Mid(VLfecha_rec$, 7, 4)
        
      
      
        
        ' Parche Para Imprimir Comprobantes Anteriores
        'VLNoAutorizacion$ = Trim$(VLIRNA$)
         grdMovimientos.Col = 20
         If Len(Trim$(grdMovimientos.text)) = 0 Then
          VLNoAutorizacion$ = Trim$(VLIRNA$)
         Else
          VLNoAutorizacion$ = grdMovimientos.text
         End If
        If InStr(VLSec$, "-") = 0 Then
          VLSec$ = "000000000" & VLSec$ 'smerino
          VLnumcmpret$ = Trim$(VLIRBB$) + Trim$(VLIRPD$) + "-" + Right(Trim$(VLSec$), 9) 'smerino
        Else
          VLnumcmpret$ = VLSec$
        End If
        VLOficina$ = Trim$(FGenerales.txtCampo(1).text) + "-" + Trim$(FGenerales.lblDescripcion(1).Caption)
        VLMoneda$ = "DOLARES USD"
        
        'VLvalido$ = "Fecha de Validez " + Trim$(VLIRVL$)
        grdMovimientos.Col = 21
        If Len(Trim$(grdMovimientos.text)) = 0 Then
          VLvalido$ = "Fecha de Validez " + Trim$(VLIRVL$)
        Else
          VLvalido$ = "Fecha de Validez " + grdMovimientos.text
        End If
        
        'smerino muestra la empresa
         If VTPos <> 0 Then
        grdMovimientos.Row = VTPos
        grdMovimientos.Col = 1
        VTTipEmpresa2$ = grdMovimientos.text
        End If
        
        'smerino nombre del listado detallado del comprobante de retención
         VlNameFile$ = "Anexo" + "_" + Right("00000" + txtCampo(0).text, 5) + "_" + Mid(VLfecha_rec$, 1, 2) + Mid(VLfecha_rec$, 4, 2) + Mid(VLfecha_rec$, 7, 4) + "_" + Mid(VLnumcmpret$, 9, 9) + ".txt"
        'smerino
        
        If VTPos <> 0 Then
        grdMovimientos.Row = VTPos
        grdMovimientos.Col = 22
        VLfechautoriza$ = grdMovimientos.text
        End If
        
        If VTPos <> 0 Then
        grdMovimientos.Row = VTPos
        grdMovimientos.Col = 23
        VLvalidosri$ = grdMovimientos.text
        End If
        ''fin smerino
        
        VLDir_Ofic = VLDir_Ofic
        
        rptcomprobante.Formulas(0) = "cr_NoAutorizacion = '" + VLNoAutorizacion$ + "  " + "'"
        rptcomprobante.Formulas(1) = "cr_numcmpret = '" + VLnumcmpret$ + "  " + "'"
        rptcomprobante.Formulas(2) = "cr_oficina = '" + VLOficina$ + "  " + "'"
        rptcomprobante.Formulas(3) = "cr_ruc = '" + VLRuc$ + "  " + "'"
        rptcomprobante.Formulas(4) = "cr_direccion = '" + VLDireccion$ + "  " + "'"
        rptcomprobante.Formulas(5) = "cr_moneda = '" + VLMoneda$ + "  " + "'"
        rptcomprobante.Formulas(6) = "cr_valido = '" + VLvalido$ + "  " + "'"
        
        
        If VLEstado$ = "NN" Then
           rptcomprobante.Formulas(7) = "nomcta= '" + Nombre + "'"
          Else
           rptcomprobante.Formulas(7) = "nomcta= '" + VTRazonSoc$ + "'"
        End If
        
        'smerino cambia formato a la fecha de emision
        Mes = Mid(VLFpago$, 1, 2)
        dia = Mid(VLFpago$, 4, 2)
        anio = Mid(VLFpago$, 7, 4)
       
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
        
        VGFechaProceso2 = dia + "/" + mes2 + "/" + anio
          
    
        rptcomprobante.Formulas(8) = "fpago= '" + VLFpago$ + "'"
        'rptcomprobante.Formulas(8) = "fpago= '" + VGFechaProceso2 + "'"
      '  rptcomprobante.Formulas(9) = "montonc= '" + nc + "'"        Miguel Aldaz 02/29/2008 solo aqui uso valor de pn_valor_uno
        rptcomprobante.Formulas(9) = "montonc= '" + nc11 + "'"     ' envio VLMonto1$ en nc11 que es el campo pn_valor_uno de tabla pg_control_ncrecaudacion
        rptcomprobante.Formulas(10) = "retenc= '" + VLRetimpret + "'"
        rptcomprobante.Formulas(11) = "cr_lugar= '" + VLDir_Ofic + "'"
        rptcomprobante.Formulas(12) = "frecauda= '" + VLfecha_rec$ + " '  "
        rptcomprobante.Formulas(13) = "cr_titulo = '" + VLTitulo + " '  "
        rptcomprobante.Formulas(14) = "cr_factura = '" + vlFact + " '  "
        rptcomprobante.Formulas(15) = "cr_unoxmil = '" + VTUNOxMil + " '  "
       
        
        rptcomprobante.Destination = 0
        If Trim(VLfechautoriza$) = "" And Trim(VLvalidosri$) = "" Then 'smerino
           ' rptcomprobante.Formulas(16) = "anio = '" + anio + "  " + "'" 'smerino
            rptcomprobante.ReportFileName = App.Path & "\ircmpretant.rpt" 'smerino
            rptcomprobante.PrintFileName = App.Path & "\ircmpretant.rpt"
        Else
            rptcomprobante.ReportFileName = App.Path & "\ircmpret.rpt"
            rptcomprobante.Formulas(8) = "fpago= '" + VGFechaProceso2 + "'" 'smerino
            rptcomprobante.Formulas(16) = "cr_autoriza = '" + VLfechautoriza$ + "  " + "'" 'smerino
            rptcomprobante.Formulas(17) = "cr_validosri = '" + VLvalidosri$ + "  " + "'"   'smerino
            rptcomprobante.Formulas(18) = "cr_tipo_comp_vta = '" + VlNameFile$ + "  " + "'" 'smerino
            rptcomprobante.Formulas(19) = "cr_no_comp_vta = '" + VlNameFile$ + "  " + "'" 'smerino
            rptcomprobante.Formulas(20) = "anio = '" + anio + "  " + "'" 'smerino
            rptcomprobante.PrintFileName = App.Path & "\ircmpret.rpt"
        End If
        rptcomprobante.PrintFileType = 17
        rptcomprobante.Action = 1


        ' T("moneda") = VTMonedaImp
        ' T("Oficina") = Trim$(FGenerales.txtCampo(1).Text) + "-" + Trim$(FGenerales.lblDescripcion(1).Caption)
        ' T("usuario") = FLogin.txtCampo(1).Text
     End If
'    Else
'     MsgBox "Cliente tiene facturación electrónica imprimir comprobante por 24Online", vbInformation, "Sistema"
    End If

    If CCur(Impuesto) > 0 And VLNemfpago = "NCRCTA" Then
        For i = 1 To 24
            rptcomprobante.Formulas(i) = ""
        Next i
       
       VTnombarch$ = Mid(lblDescripcion(0), 1, 4) & Mid(lblfecha.Caption, 4, 2) & "ND.doc"
       'Colocar el nombre del reporte
       rptcomprobante.ReportFileName = App.Path & "\Comprond.rpt"

       descripfpago$ = "HEMOS EFECTUADO LA EMISION DE UNA ND POR EL VALOR DE:"

       VTNomemp$ = lblDescripcion(0)

       'Pasar los valores a las fórmulas
       rptcomprobante.Formulas(9) = "frecauda= '" + VLfecha_rec$ + " '  "
       rptcomprobante.Formulas(8) = "nomemp= '" + VTNomemp$ + "'"
       rptcomprobante.Formulas(7) = "desfpago= '" + descripfpago$ + "'"
       rptcomprobante.Formulas(3) = "nrocta= '" + cta + "'"
       rptcomprobante.Formulas(2) = "nomcta= '" + VTRazonSoc$ + "'"     ' aanombre
       rptcomprobante.Formulas(1) = "montonc= '" + Impuesto + "'"
       rptcomprobante.Formulas(4) = "recauda= '" + recauda + "'"
       rptcomprobante.Formulas(5) = "retenc= '" + VLNoTrx$ + "'"
       VLMontoLetra$ = FMConvNumletra1(Impuesto)
       rptcomprobante.Formulas(0) = "montoletras= '" + VLMontoLetra$ + "  DOLARES" + "'"
       rptcomprobante.Formulas(6) = "fpago= '" + VLFpago$ + "'"
       rptcomprobante.Formulas(12) = "rubro1= '" + "COMISION (con costo " + VLCostoTrx$ + ")" + "'"

       rptcomprobante.Destination = 0 ' Solo Para Pruebas       <2>
       rptcomprobante.PrintFileName = App.Path & "\" & VTnombarch$
       rptcomprobante.PrintFileType = 17
       rptcomprobante.Action = 1
    End If

    VLdesfpago = ""
    VLNemfpago = ""
    Screen.MousePointer = 0
    Exit Sub

Salir:
    Screen.MousePointer = 0
    MsgBox " (" & err & ")  " + Error, 64
    Exit Sub
End Sub

Sub PLEscoger()
   ' VTPos = 0
    grdMovimientos.Col = 5
    mhValor(0).Enabled = True
    mhValor(0) = grdMovimientos.text
    
    'If Me.txtcampo(0).Text <> 1371 Then      'lfcm 10-abril-2008 EEQ debe leer el campo del Valor de Recaudacion. No el campo valor Base Imponible
    If Me.txtCampo(0).text <> 1371 And Me.txtCampo(0).text <> 1127 Then      'lfcm 10-abril-2008 EEQ debe leer el campo del Valor de Recaudacion. No el campo valor Base Imponible
       grdMovimientos.Col = 18
       mhValor(4).Enabled = True
       mhValor(4) = grdMovimientos.text
    End If                                   'lfcm 10-abril-2008 EEQ debe leer el campo del Valor de Recaudacion. No el campo valor Base Imponible
    
    VLRecaudacion$ = grdMovimientos.text
    'If CCur(grdMovimientos.Text) = 0 Then
    If CCur(grdMovimientos.text) = 0 And (Me.txtCampo(0).text <> 113 And Me.txtCampo(0).text <> 112) Then  'ame 04/07/2010
       MsgBox "Registro de Pago con Valor Cero"
       VLEstado$ = ""
       lblSecuencial.Caption = ""
       lblfecha.Caption = ""
       VLfecha_rec$ = ""
       lbldesfpago.Caption = ""
       lblFpago.Caption = ""
       mhValor(0) = ""
       mhValor(1) = ""
       mhValor(2) = ""
       mhValor(4) = ""
       PMLimpiaGrid Grid1  'smerino belcorp 'smerino belcorp
       Exit Sub
    End If
 
' Procedimiento para obtener los datos a modificar o trasmitir
   grdMovimientos.Col = 7
   VLEstado$ = Trim(grdMovimientos.text)
 '  If VLEstado$ = "N" Then
        grdMovimientos.Col = 1
        lblSecuencial.Caption = grdMovimientos.text
        grdMovimientos.Col = 3
        lblfecha.Caption = grdMovimientos.text
        grdMovimientos.Col = 2
        VLfecha_rec$ = grdMovimientos.text
        grdMovimientos.Col = 4
        If Trim(grdMovimientos.text) <> "" Then
           VLFpago$ = grdMovimientos.text
        Else
           VLFpago$ = ""
        End If
        grdMovimientos.Col = 6
        lblFpago.Caption = grdMovimientos.text

            PMPasoValores SqlConn&, "@i_tabla", 0, SQLCHAR, "sv_fpago_empresas"
            PMPasoValores SqlConn&, "@i_tipo", 0, SQLCHAR, "V"
            PMPasoValores SqlConn&, "@i_codigo", 0, SQLVARCHAR, (lblFpago.Caption)
            If FMTransmitirRPC(SqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtCampo(Index%).text & "]") Then
                PMMapeaObjeto SqlConn&, lbldesfpago
                PMChequea SqlConn&
            Else
                lbldesfpago = ""
            End If

        grdMovimientos.Col = 5
        mhValor(0).Enabled = True
        mhValor(0) = grdMovimientos.text
        VLRecaudacion$ = grdMovimientos.text

        grdMovimientos.Col = 18
        mhValor(4).Enabled = True
        mhValor(4) = grdMovimientos.text
        


        grdMovimientos.Col = 8
        mhValor(1).Enabled = True
        mhValor(1) = grdMovimientos.text
        VLImpues$ = grdMovimientos.text

        grdMovimientos.Col = 9
        VLRetencion$ = grdMovimientos.text
        VTretenc = CCur(VLRetencion$)
        VTrecaud = CCur(VLRecaudacion$)
        VTCosto = CCur(VLImpues$)
        VLRecaudacion$ = Format((VTrecaud + VTretenc), "###,###,##0.00")
        VLMonto$ = Format((VTrecaud), "###,###,##0.00")
        
        grdMovimientos.Col = 18
        VTrecaud1$ = grdMovimientos.text
        VLMonto1$ = Format((VTrecaud1), "###,###,##0.00")
        
        VLNombre$ = lblDescripcion(0)
        grdMovimientos.Col = 10
        VLCta$ = grdMovimientos.text
        grdMovimientos.Col = 11
        VLNoTrx$ = Format(grdMovimientos.text, "###,###,##0.00")
        grdMovimientos.Col = 12
        VLCostoTrx$ = Format((CCur(grdMovimientos.text) / CCur(VLNoTrx$)), "###,###,##0.00")

        grdMovimientos.Col = 11
        mhValor(3).Enabled = True
        mhValor(3) = grdMovimientos.text
        '<Ref001 MLR: agregar nuevos campos
        grdMovimientos.Col = 25 'Contribuyente Especial
        txtCampo(1).text = grdMovimientos.text
        
        grdMovimientos.Col = 26 'IVA Bienes
        mhValor(5).Enabled = True
        mhValor(5) = grdMovimientos.text
        
        grdMovimientos.Col = 27 'Ret IVA Bienes
        mhValor(6).Enabled = True
        mhValor(6) = grdMovimientos.text
        
        grdMovimientos.Col = 28 'IVA Servicios
        mhValor(7).Enabled = True
        mhValor(7) = grdMovimientos.text
        
        grdMovimientos.Col = 29 'Ret IVA Servicios
        mhValor(8).Enabled = True
        mhValor(8) = grdMovimientos.text
        
        grdMovimientos.Col = 30 'IVA Exonerado
        mhValor(9).Enabled = True
        mhValor(9) = grdMovimientos.text
        'Fin Ref001>
        
        'ref002 Ini
        If txtCampo(0) = 38 Then
         grdMovimientos.Col = 15 'Secuencia Empresa
         VNSecEmpresa = grdMovimientos.text
        End If
        'ref002 Fin
                
        'Ref003 Ini
        grdMovimientos.Col = 17
        lbl_pag.Caption = grdMovimientos.text
        'Ref003 Fin
       
        mhValor(0).SetFocus

End Sub

Sub PLLimpiar()
          PMLimpiaGrid grdMovimientos
          mskValor(0).Mask = FMMascaraFecha(VLFormatoFecha$)
          mskValor(0).text = Format$(VGFechaProceso$, VLFormatoFecha$)
          lblSecuencial = ""
          lblfecha = ""
          lblFpago.Caption = ""
          lbldesfpago = ""
          cmdBoton(1).Enabled = False
          'cmdBoton(2).Enabled = False
          mhValor(0) = "0.00"
          mhValor(1) = "0.00"
          mhValor(2) = "0.00"
          mhValor(3) = "0"
          mhValor(4) = "0.00"  'Miguel Aldaz 03/03/2007
          '<Ref001 MLR Limpiar campos nuevos
          mhValor(5) = "0.00"
          mhValor(6) = "0.00"
          mhValor(7) = "0.00"
          mhValor(8) = "0.00"
          mhValor(9) = "0.00"
          ' FIn Ref001>
          VLPaso% = True
          txtCampo(0).SetFocus
          VLRowsSel% = 0
          VLRowsSel2% = 0
          VLEstado$ = "N"
          
          PMLimpiaGrid Grid1  'smerino belcorp
          
End Sub

Sub txtCampo_Change(Index As Integer)
    Select Case Index%
        Case 0, 1, 2
            VLPaso% = False
    End Select

End Sub

Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Código de la Empresa [F5 Ayuda]"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).text)

End Sub

Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
    If KeyCode% = VGTeclaAyuda% Then
        Select Case Index%
            Case 0
                VLTabla$ = "sv_empresas_luz"
            Case Else
                 Exit Sub
        End Select

        PMPasoValores SqlConn&, "@i_tabla", 0, SQLCHAR, VLTabla$
        PMPasoValores SqlConn&, "@i_tipo", 0, SQLCHAR, "A"
        If FMTransmitirRPC(SqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtCampo(Index%).text & "]") Then
            VLPaso% = True

'             PMMapeaListaH sqlconn%, FCatalogo!lstCatalogo, False
            PMMapeaListaH SqlConn&, FCatalogo!lstCatalogo, False

'             PMChequea sqlconn%
            PMChequea SqlConn&
            FCatalogo.Show 1
            txtCampo(Index%).text = VGACatalogo.codigo$
            lblDescripcion(Index%).Caption = VGACatalogo.Descripcion$
            If Trim$(txtCampo(Index%).text) = "" Then
                lblDescripcion(Index%).Caption = ""
                txtCampo(Index%).SetFocus
            End If
        End If
    End If

End Sub

Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
        Case 0, 1
           KeyAscii% = FMValidaTipoDato("N", KeyAscii%)
    End Select

End Sub

Sub txtCampo_LostFocus(Index As Integer)
    If VLPaso% = True Then
        Exit Sub
    End If

    Select Case Index%
        Case 0
            VLTabla$ = "sv_empresas_luz"
    End Select

    Select Case Index%
        Case 0, 1
            PMPasoValores SqlConn&, "@i_tabla", 0, SQLCHAR, VLTabla$

'             PMPasoValores sqlconn%, "@i_tipo", 0, SQLCHAR, "V"
            PMPasoValores SqlConn&, "@i_tipo", 0, SQLCHAR, "V"

'             PMPasoValores sqlconn%, "@i_codigo", 0, SQLVARCHAR, (txtcampo(Index%).Text)
            PMPasoValores SqlConn&, "@i_codigo", 0, SQLVARCHAR, (txtCampo(Index%).text)

'             If FMTransmitirRPC(sqlconn%, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtcampo(Index%).Text & "]") Then
            If FMTransmitirRPC(SqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtCampo(Index%).text & "]") Then

'                 PMMapeaObjeto sqlconn%, lbldescripcion(Index%)
                PMMapeaObjeto SqlConn&, lblDescripcion(Index%)

'                 PMChequea sqlconn%
                PMChequea SqlConn&
                PLLimpiar
                VLPaso% = True
            Else
                txtCampo(Index%).text = ""
                lblDescripcion(Index%).Caption = ""
                VLPaso% = True
                'txtCampo(Index%).SetFocus
            End If
    End Select
End Sub
Sub PLPersonEmpresa()

    ' Añadido Para Traer la Ruc y la Dirección
    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4%, "3227"
    PMPasoValores SqlConn&, "@i_operacion", 0, SQLCHAR%, "W"
    PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT2%, (lblSecuencial)
    PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME%, lblfecha
    PMPasoValores SqlConn&, "@i_fecha_rec", 0, SQLDATETIME%, VLfecha_rec$
    
    'Ref002 Ini
    If lblSecuencial = 38 Then
      PMPasoValores SqlConn&, "@i_emp_dba", 0, SQLINT2%, VNSecEmpresa
    End If
    'Ref002 Fin
    PMPasoValores SqlConn&, "@i_pag", 0, SQLVARCHAR%, lbl_pag.Caption 'Ref003
    
    PMPasoValores SqlConn&, "@o_ruc", 1, SQLVARCHAR%, "                                        "
    PMPasoValores SqlConn&, "@o_direccion", 1, SQLVARCHAR%, "                                        "
    PMPasoValores SqlConn&, "@o_cta", 1, SQLVARCHAR%, "                                        "
    PMPasoValores SqlConn&, "@o_irna", 1, SQLVARCHAR%, "                                        "
    PMPasoValores SqlConn&, "@o_irbb", 1, SQLVARCHAR%, "                                        "
    PMPasoValores SqlConn&, "@o_irpd", 1, SQLVARCHAR%, "                                        "
    PMPasoValores SqlConn&, "@o_irvl", 1, SQLVARCHAR%, "                                        "
    PMPasoValores SqlConn&, "@o_sec", 1, SQLVARCHAR%, "                                        "
    PMPasoValores SqlConn&, "@o_dir_ofic", 1, SQLVARCHAR%, "                                        "
    PMPasoValores SqlConn&, "@o_retimpret", 1, SQLMONEY%, "                                        "
    PMPasoValores SqlConn&, "@o_razonsoc", 1, SQLVARCHAR%, Space(100) ' GYC 2004/Ene/06 "                                        "
    PMPasoValores SqlConn&, "@o_dias", 1, SQLINT4%, "                                        "
    'PMPasoValores SqlConn&, "@o_por_retimp", 1, SQLVARCHAR%, Space$(64)        'lfcm 01-agosto-2007
    PMPasoValores SqlConn&, "@o_porc_retimp", 1, SQLVARCHAR%, Space$(64)        'lfcm 01-agosto-2007
    If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_tr_pago_empresa", True, "Ok... Consulta de movimientos EMELEC") Then
       VLRuc$ = FMRetParam$(SqlConn&, 2)
       VLDireccion$ = FMRetParam$(SqlConn&, 3)
       VLCuenta$ = FMRetParam$(SqlConn&, 1)
       VLIRNA$ = FMRetParam$(SqlConn&, 4)
       VLIRBB$ = FMRetParam$(SqlConn&, 5)
       VLIRPD$ = FMRetParam$(SqlConn&, 6)
       VLIRVL$ = FMRetParam$(SqlConn&, 7)
       VSSec$ = FMRetParam$(SqlConn&, 8)
       VLDir_Ofic$ = FMRetParam$(SqlConn&, 9)
       VSRetimpret$ = FMRetParam$(SqlConn&, 10)
       VTRazonSoc$ = FMRetParam$(SqlConn&, 11)
       VLDias$ = FMRetParam$(SqlConn&, 12)
       VTUNOxMil$ = FMRetParam$(SqlConn&, 13)
       PMChequea SqlConn&
       lblSecuencial = ""
       lblfecha = ""
       lblFpago.Caption = ""
       lbldesfpago = ""
       mhValor(0) = "0.00"
       mhValor(1) = "0.00"
       mhValor(4) = "0.00"  'Miguel Aldaz 03/03/2008
       PMLimpiaGrid Grid1  'smerino belcorp 'smerino belcorp
       PLBuscar (0)
    End If
    
End Sub
Sub PLimprimir_Plan()
    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4%, "3227"
    PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT2%, txtCampo(0)
    PMPasoValores SqlConn&, "@i_operacion", 0, SQLCHAR, "Z"
    
    'PMPasoValores SqlConn&, "@i_fechaefec", 0, SQLVARCHAR%, VTFechaEfec
    PMPasoValores SqlConn&, "@i_fechaefec", 0, SQLVARCHAR%, VLfecha_rec$
    
    PMPasoValores SqlConn&, "@i_secsri", 0, SQLINT4%, Trim$(Right(Trim$(VLSec$), 7))
    
    If VTRegistro > 0 Then
       PMPasoValores SqlConn&, "@i_registro", 0, SQLINT4%, Trim$(Str(VTRegistro))
       PMPasoValores SqlConn&, "@i_session", 0, SQLINT4%, Trim$(VTSession)
    End If
    
    If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_tr_pago_empresa", True, "Ok... Consulta de movimientos EMELEC") Then
        VTR1% = FMMapeaMatriz(SqlConn&, VLRubros())
        PMMapeaVariable SqlConn&, VLTotVal$
        PMMapeaVariable SqlConn&, VLTotRet$
        PMMapeaVariable SqlConn&, VLSession$
        
        If contImp = 1 Then
           VTTotVal$ = VLTotVal$
           VTTotRet$ = VLTotRet$
           VTSession$ = VLSession$
        End If
        
        ' Esto para el Caso de No Mapee Registro de Detalle
        If VLRubros(0, 1) = "" Then
          swimpr = 1
          VTR1% = 0
          VLRubros(0, 1) = 0
        End If
        
        If VTR1% = 0 Or VLRubros(0, 1) = 0 Then
          swimpr = 1
          VTR1% = 0
        End If
        
        PMChequea SqlConn&
        VTBusqueda = "D"
            
        argumento$ = "C:\cobis\tadmin\"
        'Set dbrl = OpenDatabase(VGPath$ & "\sermedio.mdb")
        Set dbrl = OpenDatabase(argumento$ & "\sermedio.mdb")
        Set dsrl = dbrl.CreateDynaset("retenciondetalle")

        For i% = 1 To VTR1%
            If i% <= VTR1% Then
               dsrl.AddNew
               If Len(Trim$(VLRubros(1, i%))) = 0 Then
                  vcodigo = "0"
                 Else
                  vcodigo = VLRubros(1, i%)
               End If
               
               If Len(Trim$(VLRubros(2, i%))) = 0 Then
                  vdetalle = "0"
                 Else
                  vdetalle = VLRubros(2, i%)
               End If
               
               dsrl("rd_empresa") = VLRubros(0, i%)
               dsrl("rd_codigo") = vcodigo ' VLRubros(1, i%)
               dsrl("rd_detalle") = vdetalle ' CCur(VLRubros(2, i%))  ' Mid(VLRubros(3, i%), 1, 12)
               dsrl("rd_valor") = VLRubros(3, i%)
               
               Select Case Trim$(VTUNOxMil)
                 Case "1 %"
                  'VTvalreal = fQuitarPunto(VLRubros(4, i%))
                   VTvalreal = Int(VLRubros(4, i%)) / 100
                   VTvalreal = Left(VTvalreal, 4)
                   VTvalreal = VLRubros(4, i%)
                 Case "1 x mil"
                  'VTvalreal = fQuitarPunto(VLRubros(4, i%))
                   VTvalreal = Int(VLRubros(4, i%)) / 1000
                   VTvalreal = Left(VTvalreal, 4)
                   VTvalreal = VLRubros(4, i%)
               End Select
               
               dsrl("rd_retimp") = VTvalreal
               dsrl.Update
            End If
        Next i%

        If VTR1% > 0 Then
           VTRegistro = Val(VLRubros(5, i% - 1))
           swDetalle = True
        End If

        dsrl.Close

     Else
       swimpr = 1
       Exit Sub
    End If

End Sub
Sub PLImprimir_Detalle_Plan()
        ' Eliminar los Datos de la Tabla
        argumento$ = "C:\cobis\tadmin\"
        Set dbrl = OpenDatabase(VGPath$ & "\sermedio.mdb")
        Set dbrl = OpenDatabase(argumento$ & "\sermedio.mdb")
        dbrl.Execute "DELETE FROM retenciondetalle"
        Set dsrl = dbrl.CreateDynaset("retenciondetalle")
        dsrl.Close
        VTRegistro = 0
        swimpr = 0
        contImp = 0

        For contImp = 1 To 15
            If swimpr = 0 Then
               PLimprimir_Plan
              Else
               Exit For
            End If
        Next contImp

        ' Imprimir el Reporte
        If swDetalle = True Then
           For i = 1 To 20
             rptcomprobante.Formulas(i) = ""
           Next i
         If VLFacElect = "N" Then
           ' Parche Para Imprimir Comprobantes Anteriores
           vlFact = "ROLBAN." + Right("000" + txtCampo(0).text, 3) + "." + Mid(VLFpago$, 1, 2) + Mid(VLFpago$, 4, 2) + Mid(VLFpago$, 7, 4)
           ' Parche Para Imprimir Comprobantes Anteriores
             
             grdMovimientos.Col = 20
             If Len(Trim$(grdMovimientos.text)) = 0 Then
              VLNoAutorizacion$ = Trim$(VLIRNA$)
             Else
              VLNoAutorizacion$ = grdMovimientos.text
             End If
            If InStr(VLSec$, "-") = 0 Then
              VLSec$ = "000000000" & VLSec$ 'smerino
              VLnumcmpret$ = Trim$(VLIRBB$) + Trim$(VLIRPD$) + "-" + Right(Trim$(VLSec$), 9) 'smerino
            Else
              VLnumcmpret$ = VLSec$
            End If
            VLOficina$ = Trim$(FGenerales.txtCampo(1).text) + "-" + Trim$(FGenerales.lblDescripcion(1).Caption)
            VLMoneda$ = "DOLARES USD"
            
            'VLvalido$ = "Fecha de Validez " + Trim$(VLIRVL$)
            grdMovimientos.Col = 21
            If Len(Trim$(grdMovimientos.text)) = 0 Then
              VLvalido$ = "Fecha de Validez " + Trim$(VLIRVL$)
            Else
              VLvalido$ = "Fecha de Validez " + grdMovimientos.text
            End If
           
           
           VLDir_Ofic = VLDir_Ofic
        
           rptcomprobante.Formulas(0) = "cr_NoAutorizacion = '" + VLNoAutorizacion$ + "  " + "'"
           rptcomprobante.Formulas(1) = "cr_numcmpret = '" + VLnumcmpret$ + "  " + "'"
           rptcomprobante.Formulas(2) = "cr_oficina = '" + VLOficina$ + "  " + "'"
           rptcomprobante.Formulas(3) = "cr_ruc = '" + VLRuc$ + "  " + "'"
           rptcomprobante.Formulas(4) = "cr_direccion = '" + VLDireccion$ + "  " + "'"
           rptcomprobante.Formulas(5) = "cr_moneda = '" + VLMoneda$ + "  " + "'"
           rptcomprobante.Formulas(6) = "cr_valido = '" + VLvalido$ + "  " + "'"
           rptcomprobante.Formulas(7) = "nomcta= '" + VTRazonSoc$ + "'"     ' Trim$(lblDescripcion(0))
           rptcomprobante.Formulas(8) = "fpago= '" + VLFpago$ + "'"
           rptcomprobante.Formulas(9) = "montonc= '" + nc + "'"
           rptcomprobante.Formulas(10) = "retenc= '" + VLRetimpret + "'"
           rptcomprobante.Formulas(11) = "cr_lugar= '" + VLDir_Ofic + "'"
           rptcomprobante.Formulas(12) = "frecauda= '" + VLfecha_rec$ + " '  "
           rptcomprobante.Formulas(13) = "cr_titulo = '" + VLTitulo + " '  "
           rptcomprobante.Formulas(14) = "cr_factura = '" + vlFact + " '  "
           rptcomprobante.Formulas(15) = "totBase = '" + Format(Trim$(VTTotVal$), "###,###,##0.00") + " '  "
           rptcomprobante.Formulas(16) = "totRet  = '" + Format(Trim$(VTTotRet$), "###,###,##0.00") + " '  "
           rptcomprobante.Formulas(17) = "cr_unoxmil = '" + VTUNOxMil + " '  "
           
           rptcomprobante.ReportFileName = App.Path & "\ircmpretdet.rpt"
           VGNombase$ = "sermedio.mdb"
           
           rptcomprobante.CopiesToPrinter = 1
           rptcomprobante.PrinterStartPage = rptcomprobante.ReportStartPage + 1
           rptcomprobante.PrinterStopPage = rptcomprobante.ReportLatestPage
           rptcomprobante.Destination = 0
           rptcomprobante.Action = 1
         End If
        End If
End Sub
Sub PLImprimir_Detalle_Linea()
        ' Eliminar los Datos de la Tabla
        argumento$ = "C:\cobis\tadmin\"
        Set dbrl = OpenDatabase(VGPath$ & "\sermedio.mdb")
        dbrl.Execute "DELETE FROM retenciondetalle"
        Set dsrl = dbrl.CreateDynaset("retenciondetalle")
        dsrl.Close
        VTRegistro = 0
        swimpr = 0
        contImp = 0

        For contImp = 1 To 200
            If swimpr = 0 Then
               PLimprimir_Linea
              Else
               Exit For
            End If
        Next contImp

        ' Imprimir el Reporte
        If swDetalle = True Then
           For i = 1 To 20
             rptcomprobante.Formulas(i) = ""
           Next i
         If VLFacElect = "N" Then
           ' Parche Para Imprimir Comprobantes Anteriores
           vlFact = "ROLBAN." + Right("000" + txtCampo(0).text, 3) + "." + Mid(VLFpago$, 1, 2) + Mid(VLFpago$, 4, 2) + Mid(VLFpago$, 7, 4)
           ' Parche Para Imprimir Comprobantes Anteriores
            'VLNoAutorizacion$ = Trim$(VLIRNA$)
            
             grdMovimientos.Col = 20
             If Len(Trim$(grdMovimientos.text)) = 0 Then
              VLNoAutorizacion$ = Trim$(VLIRNA$)
             Else
              VLNoAutorizacion$ = grdMovimientos.text
             End If
            If InStr(VLSec$, "-") = 0 Then
              VLSec$ = "000000000" & VLSec$ 'smerino
              VLnumcmpret$ = Trim$(VLIRBB$) + Trim$(VLIRPD$) + "-" + Right(Trim$(VLSec$), 9) 'smerino
            Else
              VLnumcmpret$ = VLSec$
            End If
            VLOficina$ = Trim$(FGenerales.txtCampo(1).text) + "-" + Trim$(FGenerales.lblDescripcion(1).Caption)
            VLMoneda$ = "DOLARES USD"
            
            'VLvalido$ = "Fecha de Validez " + Trim$(VLIRVL$)
            grdMovimientos.Col = 21
            If Len(Trim$(grdMovimientos.text)) = 0 Then
              VLvalido$ = "Fecha de Validez " + Trim$(VLIRVL$)
            Else
              VLvalido$ = "Fecha de Validez " + grdMovimientos.text
            End If
           VLDir_Ofic = VLDir_Ofic
        
           rptcomprobante.Formulas(0) = "cr_NoAutorizacion = '" + VLNoAutorizacion$ + "  " + "'"
           rptcomprobante.Formulas(1) = "cr_numcmpret = '" + VLnumcmpret$ + "  " + "'"
           rptcomprobante.Formulas(2) = "cr_oficina = '" + VLOficina$ + "  " + "'"
           rptcomprobante.Formulas(3) = "cr_ruc = '" + VLRuc$ + "  " + "'"
           rptcomprobante.Formulas(4) = "cr_direccion = '" + VLDireccion$ + "  " + "'"
           rptcomprobante.Formulas(5) = "cr_moneda = '" + VLMoneda$ + "  " + "'"
           rptcomprobante.Formulas(6) = "cr_valido = '" + VLvalido$ + "  " + "'"
           rptcomprobante.Formulas(7) = "nomcta= '" + VTRazonSoc$ + "'"   ' Trim$(lblDescripcion(0))
           rptcomprobante.Formulas(8) = "fpago= '" + VLFpago$ + "'"
           rptcomprobante.Formulas(9) = "montonc= '" + nc + "'"
           rptcomprobante.Formulas(10) = "retenc= '" + VLRetimpret + "'"
           rptcomprobante.Formulas(11) = "cr_lugar= '" + VLDir_Ofic + "'"
           rptcomprobante.Formulas(12) = "frecauda= '" + VLfecha_rec$ + " '  "
           rptcomprobante.Formulas(13) = "cr_titulo = '" + VLTitulo + " '  "
           rptcomprobante.Formulas(14) = "cr_factura = '" + vlFact + " '  "
           
           rptcomprobante.Formulas(15) = "totBase = '" + Format(Trim$(VTTotVal$), "###,###,##0.00") + " '  "
           rptcomprobante.Formulas(16) = "totRet  = '" + Format(Trim$(VTTotRet$), "###,###,##0.00") + " '  "
           rptcomprobante.Formulas(17) = "cr_unoxmil = '" + VTUNOxMil + " '  "
           
           rptcomprobante.ReportFileName = App.Path & "\ircmpretdet.rpt"
           VGNombase$ = "sermedio.mdb"
           
           rptcomprobante.PrinterStartPage = rptcomprobante.ReportStartPage ' + 1
           rptcomprobante.PrinterStopPage = rptcomprobante.ReportLatestPage
           rptcomprobante.Destination = 0
           rptcomprobante.Action = 1
         End If
        End If
End Sub
Sub PLimprimir_Linea()
    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4%, "3227"
    PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT2%, txtCampo(0)
    PMPasoValores SqlConn&, "@i_operacion", 0, SQLCHAR, "Y"
    PMPasoValores SqlConn&, "@i_sec_servicio", 0, SQLINT4%, VTSecEmpresa
   
    'Ref002 Ini
    If lblSecuencial = 38 Then
      PMPasoValores SqlConn&, "@i_emp_dba", 0, SQLINT2%, VNSecEmpresa
    End If
    'Ref002 Fin
    PMPasoValores SqlConn&, "@i_pag", 0, SQLVARCHAR%, lbl_pag.Caption 'Ref003
    
    PMPasoValores SqlConn&, "@i_fechaefec", 0, SQLVARCHAR%, VTFechaEfec
    
    If VTRegistro > 0 Then
       PMPasoValores SqlConn&, "@i_registro", 0, SQLINT4%, Trim$(Str(VTRegistro))
       PMPasoValores SqlConn&, "@i_session", 0, SQLINT4%, Trim$(VTSession)
    End If
    
    If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_tr_pago_empresa", True, "Ok... Consulta de movimientos EMELEC") Then
        VTR1% = FMMapeaMatriz(SqlConn&, VLRubros())
        PMMapeaVariable SqlConn&, VLTotVal$
        PMMapeaVariable SqlConn&, VLTotRet$
        PMMapeaVariable SqlConn&, VLSession$
        
        If contImp = 1 Then
           VTTotVal$ = VLTotVal$
           VTTotRet$ = VLTotRet$
           VTSession$ = VLSession$
        End If
        
        ' Esto para el Caso de No Mapee Registro de Detalle
        If VLRubros(0, 1) = "" Then
          swimpr = 1
          VTR1% = 0
          VLRubros(0, 1) = 0
        End If
        
        If VTR1% = 0 Then
          swimpr = 1
        End If
         
        PMChequea SqlConn&
        VTBusqueda = "D"
        
        argumento$ = "C:\cobis\tadmin\"
        Set dbrl = OpenDatabase(VGPath$ & "\sermedio.mdb")
        Set dsrl = dbrl.CreateDynaset("retenciondetalle")

        For i% = 1 To VTR1%
            If i% <= VTR1% Then
               dsrl.AddNew
               
               If Len(Trim$(VLRubros(1, i%))) = 0 Then
                  vcodigo = "0"
                 Else
                  vcodigo = VLRubros(1, i%)
               End If
               
               If Len(Trim$(VLRubros(2, i%))) = 0 Then
                  vdetalle = "0"
                 Else
                  vdetalle = VLRubros(2, i%)
               End If
               
               dsrl("rd_empresa") = VLRubros(0, i%)
               dsrl("rd_codigo") = vcodigo
               dsrl("rd_detalle") = vdetalle ' VLRubros(2, i%)  ' Mid(VLRubros(3, i%), 1, 12)
               dsrl("rd_valor") = VLRubros(3, i%)
               
               Select Case Trim$(VTUNOxMil)
                 Case "1 %"
                  'VTvalreal = fQuitarPunto(VLRubros(4, i%))
                   VTvalreal = Int(VLRubros(4, i%)) / 100
                   VTvalreal = Left(VTvalreal, 4)
                 Case "1 x mil"
                  'VTvalreal = fQuitarPunto(VLRubros(4, i%))
                   VTvalreal = Int(VLRubros(4, i%)) / 1000
                   VTvalreal = Left(VTvalreal, 4)
               End Select
               
               dsrl("rd_retimp") = VTvalreal
               dsrl.Update
            End If
        Next i%

        If VTR1% > 0 Then
           VTRegistro = Val(VLRubros(5, i% - 1))
           swDetalle = True
        End If

        dsrl.Close

     Else
       swimpr = 1
       Exit Sub
    End If
    
End Sub
Public Function fQuitarPunto(Numero As String) As String
On Error GoTo pError
    pos = InStr(1, Numero, ".")
    lon = Len(Numero)
    ps1 = Mid(Numero, 1, pos - 1)
    ps2 = Mid(Numero, pos + 1, lon)
    fQuitarPunto = ps1 + ps2
    Exit Function

pError:
Exit Function
End Function

