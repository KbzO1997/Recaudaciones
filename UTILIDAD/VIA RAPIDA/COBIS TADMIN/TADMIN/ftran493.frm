VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "GRID32.OCX"
Begin VB.Form FTran493 
   BackColor       =   &H00C0C0C0&
   Caption         =   "Mantenimiento de Transacciones a Contabilizar"
   ClientHeight    =   5355
   ClientLeft      =   2940
   ClientTop       =   2160
   ClientWidth     =   9150
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00FFFFFF&
   HelpContextID   =   210
   Icon            =   "ftran493.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   5355
   ScaleWidth      =   9150
   Tag             =   "10493"
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
      Height          =   240
      Index           =   10
      Left            =   6000
      MaxLength       =   5
      TabIndex        =   36
      Top             =   1035
      Width           =   495
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   790
      Index           =   6
      Left            =   8400
      TabIndex        =   34
      Tag             =   "3516"
      Top             =   2985
      Width           =   860
      _Version        =   65536
      _ExtentX        =   1517
      _ExtentY        =   1393
      _StockProps     =   78
      Caption         =   "&Eliminar"
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
      Picture         =   "ftran493.frx":030A
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
      Height          =   240
      Index           =   9
      Left            =   3105
      MaxLength       =   5
      TabIndex        =   6
      Top             =   1035
      Width           =   700
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
      Height          =   240
      Index           =   8
      Left            =   1560
      MaxLength       =   5
      TabIndex        =   4
      Top             =   1035
      Width           =   705
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   790
      Index           =   1
      Left            =   8400
      TabIndex        =   13
      Top             =   3780
      Width           =   860
      _Version        =   65536
      _ExtentX        =   1517
      _ExtentY        =   1393
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
      Picture         =   "ftran493.frx":0680
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
      Height          =   240
      Index           =   7
      Left            =   1560
      MaxLength       =   5
      TabIndex        =   0
      Top             =   15
      Width           =   700
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
      Height          =   240
      Index           =   6
      Left            =   1530
      MaxLength       =   5
      TabIndex        =   9
      Top             =   2205
      Visible         =   0   'False
      Width           =   700
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
      Height          =   240
      Index           =   5
      Left            =   1560
      MaxLength       =   25
      TabIndex        =   5
      Top             =   1290
      Width           =   705
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
      Height          =   240
      Index           =   4
      Left            =   1560
      MaxLength       =   5
      TabIndex        =   3
      Top             =   780
      Width           =   700
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
      Height          =   240
      Index           =   2
      Left            =   1530
      MaxLength       =   5
      TabIndex        =   10
      Top             =   2460
      Visible         =   0   'False
      Width           =   700
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
      Height          =   240
      Index           =   1
      Left            =   1560
      MaxLength       =   5
      TabIndex        =   2
      Top             =   525
      Width           =   700
   End
   Begin MSGrid.Grid grdRegistros 
      Height          =   3555
      Left            =   0
      TabIndex        =   24
      TabStop         =   0   'False
      Top             =   1800
      Width           =   8295
      _Version        =   65536
      _ExtentX        =   14631
      _ExtentY        =   6271
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   790
      Index           =   2
      Left            =   8400
      TabIndex        =   7
      Tag             =   "8001"
      Top             =   1395
      Width           =   860
      _Version        =   65536
      _ExtentX        =   1517
      _ExtentY        =   1393
      _StockProps     =   78
      Caption         =   "&Ingresar"
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
      Picture         =   "ftran493.frx":09F6
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   790
      Index           =   3
      Left            =   8400
      TabIndex        =   12
      Tag             =   "8002"
      Top             =   2190
      Width           =   860
      _Version        =   65536
      _ExtentX        =   1517
      _ExtentY        =   1393
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
      Enabled         =   0   'False
      Picture         =   "ftran493.frx":0D10
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   790
      Index           =   0
      Left            =   8400
      TabIndex        =   8
      Tag             =   "8005;8006"
      Top             =   15
      Width           =   860
      _Version        =   65536
      _ExtentX        =   1517
      _ExtentY        =   1393
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
      Picture         =   "ftran493.frx":102A
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   790
      Index           =   5
      Left            =   8400
      TabIndex        =   14
      Top             =   4575
      Width           =   860
      _Version        =   65536
      _ExtentX        =   1517
      _ExtentY        =   1393
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
      Picture         =   "ftran493.frx":13A0
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
      Height          =   240
      Index           =   3
      Left            =   1515
      MaxLength       =   64
      TabIndex        =   11
      Top             =   2760
      Visible         =   0   'False
      Width           =   6060
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
      Height          =   240
      Index           =   0
      Left            =   1560
      MaxLength       =   6
      TabIndex        =   1
      Top             =   270
      Width           =   700
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
      Height          =   240
      Index           =   8
      Left            =   6480
      TabIndex        =   37
      Top             =   1035
      Width           =   1830
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Moneda:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   2
      Left            =   5280
      TabIndex        =   35
      Top             =   1080
      Width           =   675
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
      Height          =   240
      Index           =   7
      Left            =   2265
      TabIndex        =   16
      Top             =   1290
      Width           =   6060
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
      Height          =   240
      Index           =   6
      Left            =   2265
      TabIndex        =   33
      Top             =   780
      Width           =   6060
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Estado:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   10
      Left            =   2400
      TabIndex        =   32
      Top             =   1080
      Width           =   600
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
      Height          =   240
      Index           =   5
      Left            =   3825
      TabIndex        =   31
      Top             =   1035
      Width           =   1350
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Código Valor:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   9
      Left            =   75
      TabIndex        =   30
      Top             =   1065
      Width           =   1065
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
      Height          =   240
      Index           =   4
      Left            =   2250
      TabIndex        =   29
      Top             =   2205
      Visible         =   0   'False
      Width           =   6060
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Producto:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   8
      Left            =   90
      TabIndex        =   28
      Top             =   15
      Width           =   780
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
      Height          =   240
      Index           =   3
      Left            =   2265
      TabIndex        =   27
      Top             =   15
      Width           =   6060
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Signo Créd/Déb:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   7
      Left            =   75
      TabIndex        =   26
      Top             =   2205
      Visible         =   0   'False
      Width           =   1260
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
      Height          =   240
      Index           =   2
      Left            =   2250
      TabIndex        =   17
      Top             =   2460
      Visible         =   0   'False
      Width           =   1995
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Valor a Contabilizar"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   6
      Left            =   60
      TabIndex        =   18
      Top             =   1305
      Width           =   1515
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Perfil Contable:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   5
      Left            =   75
      TabIndex        =   19
      Top             =   780
      Width           =   1215
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
      Height          =   240
      Index           =   1
      Left            =   2265
      TabIndex        =   20
      Top             =   525
      Width           =   6060
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
      Height          =   240
      Index           =   0
      Left            =   2265
      TabIndex        =   21
      Top             =   270
      Width           =   6060
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Indicador:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   4
      Left            =   75
      TabIndex        =   22
      Top             =   2460
      Visible         =   0   'False
      Width           =   765
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Causa ND/NC"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   3
      Left            =   75
      TabIndex        =   23
      Top             =   525
      Width           =   1080
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   -15
      X2              =   8355
      Y1              =   1560
      Y2              =   1545
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Lista de Transacciones a Contabilizar:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   1
      Left            =   45
      TabIndex        =   25
      Top             =   1605
      Width           =   2925
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderStyle     =   6  'Inside Solid
      BorderWidth     =   2
      Index           =   1
      X1              =   8355
      X2              =   8355
      Y1              =   0
      Y2              =   5340
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Cód. Transacción:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   0
      Left            =   90
      TabIndex        =   15
      Top             =   270
      Width           =   1410
   End
End
Attribute VB_Name = "FTran493"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim VLPaso As Integer
Dim VLTabla As String
Dim VLSecuencial As String


Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
    Case 0
        PLBuscar
    Case 1
        PLLimpiar
    Case 2
        PLIngresar
    Case 3
        PLModificar
    Case 5
        Unload FTran493
    Case 6
        PLEliminar

    End Select
End Sub

Sub CmdBoton_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Ingresar el programa"
    Case 1
        FPrincipal!pnlHelpLine.Caption = " Modificar el programa"
    Case 2
        FPrincipal!pnlHelpLine.Caption = " Eliminar el programa"
    Case 3
        FPrincipal!pnlHelpLine.Caption = " Consultar los programas existentes"
    Case 4
        FPrincipal!pnlHelpLine.Caption = " Limpiar la pantalla"
    Case 5
        FPrincipal!pnlHelpLine.Caption = " Salir de la pantalla"
    Case 6
        FPrincipal!pnlHelpLine.Caption = " Consulta de los parámetros asociados al programa"
    End Select
End Sub

Private Sub Form_Activate()
Me.SetFocus
End Sub

Sub Form_Load()

    FTran493.left = 15
    FTran493.top = 15
    FTran493.width = 9420
    FTran493.height = 5730
    VTFecha$ = Format$(Now, Get_Preferencia("FORMATO-FECHA"))
    VLFlag% = 0
    txtCampo(9).Text = "V"
    lblDescripcion(5).Caption = "VIGENTE"

End Sub

Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Sub grdRegistros_Click()

    grdRegistros.col = 0
    grdRegistros.SelStartCol = 1
    grdRegistros.SelEndCol = grdRegistros.Cols - 1
    If grdRegistros.Row = 0 Then
        grdRegistros.SelStartRow = 1
        grdRegistros.SelEndRow = 1
    Else
        grdRegistros.SelStartRow = grdRegistros.Row
        grdRegistros.SelEndRow = grdRegistros.Row
    End If

End Sub

Sub grdRegistros_DblClick()

    txtCampo(7).Enabled = False

    ' Verificar que existan transacciones para procesar
    If grdRegistros.Rows <= 2 Then
        grdRegistros.Row = 1
        grdRegistros.col = 1
        If Trim$(grdRegistros.Text) = "" Then
            MsgBox "No existen transacciones para procesar", 0 + 16, "Mensaje de Error"
            Exit Sub
        End If
    End If

    'Escoge los datos del registro a procesar

    'Codigo de transaccion
    grdRegistros.col = 1
    txtCampo(0).Text = Trim$(grdRegistros.Text)

'     PMPasoValores SqlConn%, "@t_trn", 0, SQLINT4, "10494"
    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, "10494"

'     PMPasoValores SqlConn%, "@i_operacion", 0, SQLCHAR, "H"
    PMPasoValores SqlConn&, "@i_operacion", 0, SQLCHAR, "H"

'     PMPasoValores SqlConn%, "@i_codigo", 0, SQLINT4, (txtcampo(0).Text)
    PMPasoValores SqlConn&, "@i_codigo", 0, SQLINT4, (txtCampo(0).Text)

'     If FMTransmitirRPC(SqlConn%, ServerName$, "cob_remesas", "sp_help_trn_contabilizar", False, "") Then
    If FMTransmitirRPC(SqlConn&, ServerName$, "cob_remesas", "sp_help_trn_contabilizar", False, "") Then

'         PMMapeaObjeto SqlConn%, lbldescripcion(0)
        PMMapeaObjeto SqlConn&, lblDescripcion(0)

'         PMChequea SqlConn%
        PMChequea SqlConn&
    End If
        txtCampo(1).Enabled = True
        txtCampo(1).Text = ""
        lblDescripcion(1).Caption = ""
        txtCampo(1).Enabled = False
        
        Select Case Trim$(txtCampo(0).Text)
        
        '-- Para parametrizacion TRX 43160              !-- GYC 2018/Dic/20
        Case "43160"
            VLTabla$ = "cc_reverso_pago_ser_chq"
            txtCampo(1).Enabled = True
            
        '-- Visa Electron                               !-- GYC 2011/Jul/04
        Case "4043", "4044", "4045", "4046", "4047", "4048", "4049", "4050", "120044", "120045", "120046", "120048"
             VLTabla$ = "ve_causas_servicios"
             txtCampo(1).Enabled = True
        Case "3050", "3750", "3680", "3757", "3188" ' AME 12/17/2012
            VLTabla$ = "cc_causa_nd"
            txtCampo(1).Enabled = True
        Case "3909" 'TC 21/08/2008 EMISION DE CHEQUE
            VLTabla$ = "cc_causa_chq_ext"
            txtCampo(1).Enabled = True
        Case "4007" 'TC 10/17/2008
            VLTabla$ = "ah_transfer_inv"
            txtCampo(1).Enabled = True
            
        Case "3194", "3214", "3173", "3145", "3213", "43612", "43613" 'msilvag Trx Claro Paquetes
            VLTabla$ = "sv_empresas_luz"
            txtCampo(1).Enabled = True
        Case "3868"
            VLTabla$ = "cc_contable_comision"
            txtCampo(1).Enabled = True
        Case "3708", "4376"
            VLTabla$ = "cc_ajuste_deposito_cr"
            txtCampo(1).Enabled = True
        Case "3709", "4377"
            VLTabla$ = "cc_ajuste_deposito_db"
            txtCampo(1).Enabled = True
        Case "3048", "3679", "43088", "43536"
            VLTabla$ = "cc_causa_nc"
            txtCampo(1).Enabled = True
        Case "4253", "4255", "4279", "4284", "4996"
            VLTabla$ = "ah_causa_nc"
            txtCampo(1).Enabled = True
       '-- Case "4262", "4264", "4272", "4372", "4280"          '-- GYC 2011/Jul/27 '-- Visa Electron
       Case "4262", "4264", "4272", "4372", "4280", "4419", "4188" ' AME 12/17/2012
            VLTabla$ = "ah_causa_nd"
            txtCampo(1).Enabled = True
        Case "3032", "3335"
            VLTabla$ = "cc_causa_oioe"
            txtCampo(1).Enabled = True
        Case "3086"
            VLTabla$ = "cc_causa_oe"
            txtCampo(1).Enabled = True
        Case "3570"
            VLTabla$ = "cc_causa_nd"
        Case "3137", "3212", "3218", "3219", "3220", "3227", "3215", "3216", "3221", "4112", "43612", "43613"  'msilvag Trx Claro Paquetes '-- GYC 2007/Mar/30
            VLTabla$ = "sv_empresas_luz"
        Case "3113", "3232", "3761"
            VLTabla$ = "re_nom_colegio"
            txtCampo(1).Enabled = True
        Case "3255" 'PAGO TARJETA CORPORATIVA
            VLTabla$ = "sv_empresa_corp"
        Case "3208", "3304", "3305", "3306", "3307", "3796", "3797", "3799", "3814", "3818", "3827", "3795", "3739", "3742", "3743", "3748", "3749", "3794", "43555", "43556", "43557", "43558" '-- GYC 2005/Oct18
            VLTabla$ = "sv_courier_giro"
        Case "3303", "3735", "3747"                                  '-- GYC 2005/Oct18
            VLTabla$ = "cg_banco_corresponsal"
        Case "10476", "10480", "10402", "10403", "10404", "10462", "10463", "10464", "10472", "10473", "10474", "10482", "10483", "10484"
            VLTabla$ = "re_corresponsal"
            txtCampo(1).Enabled = True
        Case "10479", "10511", "10512", "10513", "10514", "10515", "10516", "10517", "10518", "10519", "10521", "10522", "10523", "10524", "10525", "10526", "10527", "10528", "10529", "10531", "10532", "10533", "10534", "10535", "10536", "10537", "10538", "10539", "10541", "10542", "10543", "10544", "10545", "10546", "10547", "10548", "10549", "10572", "10573"
            VLTabla$ = "re_corresponsal"
            txtCampo(1).Enabled = True
        Case "3113", "3232", "3761"
            VLTabla$ = "re_nom_colegio"
        Case "10300", "10301", "10302", "10310", "10311", "10312", "10313", "10314"
            VLTabla$ = "cl_oficina"
            txtCampo(1).Enabled = True
        Case "3800", "3809", "3273", "3272", "3619" ' wcj: 07/ago/2006 => 3619
            VLTabla$ = "fc_empresa"
            txtCampo(1).Enabled = True
        Case "3060", "3064", "3666"
            VLTabla$ = "cc_usodefondos"
            txtCampo(1).Enabled = True
         Case "3451", "3452", "3453", "3454", "3455", "3456", "3457", "4320", "4321", "4322", "4323"
           VLTabla$ = "cc_causas_liquidacion"
           txtCampo(1).Enabled = True
         Case "3366", "3372"
            VLTabla$ = "re_servicio_comision"
            txtCampo(1).Enabled = True
        Case "3493", "3490", "3491", "3492", "3281", "3869"
            VLTabla$ = "bz_causales_sat"
            txtCampo(1).Enabled = True
        Case "3868"
            VLTabla$ = "cc_contable_comision"
            txtCampo(1).Enabled = True
        Case "3870", "3875", "3874", "3721" ' ame 12/19/2012
            VLTabla$ = "cl_transf_env"
            txtCampo(1).Enabled = True
        Case "3770", "3775"
            VLTabla$ = "cl_transf_recib"
            txtCampo(1).Enabled = True
        '**** tc 20/05/2009 inicio ******
        Case "3091", "3584" 'CTE-CE-SGC00021257 mlindaor 06/22/2015 se aumenta trx 3584
            VLTabla$ = "cl_emi_cheque"
            txtCampo(1).Enabled = True
        Case "3582", "3648" 'CTE-CE-SGC00021257 mlindaor 06/22/2015 se aumenta trx 3648
            VLTabla$ = "cl_eli_cheque"
            txtCampo(1).Enabled = True
        '**** tc 20/05/2009 fin ******
        Case "3177", "3473"
            VLTabla$ = "cc_causa_paykard"
            txtCampo(1).Enabled = True
        Case "4018", "3925", "3926", "3927", "3928", "3916", "3917", "3919", "3922", "43612", "43613" 'lgusnay  RECMPS-171 'msilvag Trx Claro Paquetes
            VLTabla$ = "sv_empresas_luz"
            txtCampo(1).Enabled = True
        Case "3819", "3800", "3820", "3262"
            VLTabla$ = "fc_empresa"
            txtCampo(1).Enabled = True
        '**** tc 20/05/2009 fin ******
         Case "4252", "4246", "3040", "3553", "4435", "4436", "4437" 'smerino 02052020
           VLTabla$ = "ah_causa_deposito"
           txtCampo(1).Enabled = True
        Case "3704"
           VLTabla$ = "cc_nd_efectivo"
           txtCampo(1).Enabled = True
        Case "4963", "4964", "4968"       'JPM 25/may/2016 -->
           VLTabla$ = "sv_causas_bbp"
           txtCampo(1).Enabled = True     '<-- JPM 25/may/2016
        'PHOYOSV INI CTA.BAS CB-AP-SGC00018374-SGC00018901
        Case "120055": VLTabla$ = "bas_causa_interb": txtCampo(1).Enabled = True
        Case "120056": VLTabla$ = "bas_causa_interb": txtCampo(1).Enabled = True
        Case "120058": VLTabla$ = "bas_causa_interb": txtCampo(1).Enabled = True
        Case "120059": VLTabla$ = "bas_causa_nc": txtCampo(1).Enabled = True
        Case "120060": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
        Case "120061": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
        Case "120062": VLTabla$ = "bas_causa_deposito": txtCampo(1).Enabled = True
        Case "120063": VLTabla$ = "bas_causa_deposito": txtCampo(1).Enabled = True
        Case "120065": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
        Case "120066": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
        Case "120067": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
        Case "120068": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
        Case "120069": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
        Case "120070": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
        Case "120071": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
        Case "120072": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
        Case "120086": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
        Case "120087": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
        Case "120090": VLTabla$ = "bas_ajuste_deposito_cr": txtCampo(1).Enabled = True
        Case "120091": VLTabla$ = "bas_ajuste_deposito_db": txtCampo(1).Enabled = True
        Case "120161": VLTabla$ = "bas_causa_nc": txtCampo(1).Enabled = True
        'PHOYOSV FIN CTA.BAS CB-AP-SGC00018374-SGC00018901
        Case Else
            VLTabla$ = ""
            txtCampo(1).Enabled = True
            txtCampo(1).Text = ""
            lblDescripcion(1).Caption = ""
            txtCampo(1).Enabled = False
        End Select

    ' Descripcion de la transaccion a contabilizar
    grdRegistros.col = 2
    lblDescripcion(6).Caption = grdRegistros.Text

    ' Signo de Contabilizacion
    'gcagrdRegistros.Col = 3
    'gcatxtCampo(6).text = Trim$(grdRegistros.text)
    'gcaIf txtCampo(6).text = "C" Then
        'gcalbldescripcion(4).caption = "CREDITO"
    'gcaElse
        'gcalbldescripcion(4).caption = "DEBITO"
    'gcaEnd If

    ' Causa origen de la transaccion
    grdRegistros.col = 3
    If Trim$(grdRegistros.Text) <> "0" Then
        txtCampo(1).Text = Trim$(grdRegistros.Text)
        If VLTabla$ <> "" Then
            PMCatalogo "V", VLTabla$, txtCampo(1), lblDescripcion(1)
        End If
    End If

    ' Perfil contable
    grdRegistros.col = 4
    txtCampo(4).Text = grdRegistros.Text

    ' Causa destino de la transaccion
    grdRegistros.col = 5
    txtCampo(8).Text = grdRegistros.Text

    ' Indicador de la transaccion
    'gcagrdRegistros.Col = 7
    'gcaIf Trim$(grdRegistros.text) <> "0" Then
     'gca   txtCampo(2).text = Trim$(grdRegistros.text)
        'gcaPMCatalogo "V", "cc_tipo_indicador", txtCampo(2), lbldescripcion(2)
    'gcaEnd If

    ' Campo acontabilizar
    grdRegistros.col = 6
    txtCampo(5).Text = Trim$(grdRegistros.Text)
    txtCampo_LostFocus (5)
    ' Estado de la transaccion
    grdRegistros.col = 7
    txtCampo(9).Text = Trim$(grdRegistros.Text)
    If txtCampo(9).Text = "V" Then
        lblDescripcion(5).Caption = "VIGENTE"
    Else
        lblDescripcion(5).Caption = "CANCELADO"
    End If

    ' Guardar el secuenciial para la actualizacion
    grdRegistros.col = 9
    VLSecuencial$ = grdRegistros.Text

    ' Guardar la moneda con que actua
    grdRegistros.col = 10
    txtCampo(10).Text = Trim$(grdRegistros.Text)
    ' muestra la descripcion de la moneda seleccionada.  jlf sipecom 30032006
        If txtCampo(10).Text <> "" Then
             PMPasoValores SqlConn&, "@i_tabla", 0, SQLVARCHAR, "cl_moneda"
             PMPasoValores SqlConn&, "@i_tipo", 0, SQLCHAR, "V"
             PMPasoValores SqlConn&, "@i_codigo", 0, SQLVARCHAR, (txtCampo(10).Text)
             If FMTransmitirRPC(SqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, "") Then
                PMMapeaObjeto SqlConn&, lblDescripcion(8)
                SGMonedaTran = txtCampo(10).Text
                PMChequea SqlConn&
                'Inicio Sumadora con moneda
            Else
                txtCampo(10).Text = ""
                lblDescripcion(8).Caption = ""
            End If
       End If
        
        '    Select Case Val(txtcampo(10).Text)
        '        Case 99
        '            lblDescripcion(8).Caption = "AMBAS MONEDAS"
        '        Case 0
        '            lblDescripcion(8).Caption = "SUCRE"
        '        Case 1
        '            lblDescripcion(8).Caption = "DOLAR"
        '    End Select

    ' Actualizar y eliminar
    cmdBoton(3).Enabled = True
    cmdBoton(6).Enabled = True
    ' Ingresar
    cmdBoton(2).Enabled = False

End Sub

Sub PLBuscar()

    ' La busqueda se realiza por producto

    If Trim$(txtCampo(7).Text) = "" Then
        MsgBox "Código de producto mandatorio", 0 + 16, "Mensaje de Error"
        txtCampo(7).SetFocus
        Exit Sub
    End If

    ' Traer las definciones de perfiles contables para un
    ' producto determinado

    VTRegistros% = 20
    VTSecuencial$ = "0"
    VTFlag% = False

    VTCodigoTrn$ = Trim$(txtCampo(0).Text)
    If VTCodigoTrn$ = "" Then
        VTBusqueda$ = "P"
        VTCodigoTrn$ = "0"
    Else
        VTBusqueda$ = "T"
    End If


    While VTRegistros% = 20


'         PMPasoValores SqlConn%, "@t_trn", 0, SQLINT4, "10494"
        PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, "10494"

'         PMPasoValores SqlConn%, "@i_operacion", 0, SQLCHAR, VTBusqueda$
        PMPasoValores SqlConn&, "@i_operacion", 0, SQLCHAR, VTBusqueda$

'         PMPasoValores SqlConn%, "@i_orden", 0, SQLINT4, VTSecuencial$
        PMPasoValores SqlConn&, "@i_orden", 0, SQLINT4, VTSecuencial$

'         PMPasoValores SqlConn%, "@i_prod", 0, SQLINT1, (txtcampo(7).Text)
        PMPasoValores SqlConn&, "@i_prod", 0, SQLINT1, (txtCampo(7).Text)

'         PMPasoValores SqlConn%, "@i_codtrn", 0, SQLINT4, VTCodigoTrn$
        PMPasoValores SqlConn&, "@i_codtrn", 0, SQLINT4, VTCodigoTrn$
'         If FMTransmitirRPC(SqlConn%, ServerName$, "cob_remesas", "sp_help_trn_contabilizar", True, "OK consulta de Transacciones a Contabilizar") Then
        If FMTransmitirRPC(SqlConn&, ServerName$, "cob_remesas", "sp_help_trn_contabilizar", True, "OK consulta de Transacciones a Contabilizar") Then
'             PMMapeaGrid SqlConn%, grdRegistros, VTFlag%
            PMMapeaGrid SqlConn&, grdRegistros, VTFlag%
'             PMChequea SqlConn%
            PMChequea SqlConn&
            VTFlag% = True
            VTRegistros% = val(grdRegistros.Tag)
            grdRegistros.Row = grdRegistros.Rows - 1
            grdRegistros.col = 9
            VTSecuencial$ = grdRegistros.Text
            grdRegistros.col = 1
            VTCodigoTrn$ = grdRegistros.Text
        Else
            VTRegistros% = 0
        End If

    Wend

End Sub

Sub PLEliminar()

    If VLSecuencial$ <> "" Then
        If (txtCampo(9).Text) = "V" Then
            MsgBox "El registro debe estar Inactivo para ser borrado"
            VLSecuencial = ""
            Exit Sub
        End If

        msg$ = "Esta seguro de eliminar la transacción "
        msg$ = msg$ + (txtCampo(0).Text) + " Perfil " + (txtCampo(4).Text)
        msg$ = msg$ + " ?"
        If Not MsgBox(msg$, 1 + 32 + 0, "Mensaje del Sistema") = 1 Then
            Exit Sub
        End If


'         PMPasoValores SqlConn%, "@t_trn", 0, SQLINT4, "10493"
        PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, "10493"

'         PMPasoValores SqlConn%, "@i_operacion", 0, SQLCHAR, "D"
        PMPasoValores SqlConn&, "@i_operacion", 0, SQLCHAR, "D"

'         PMPasoValores SqlConn%, "@i_sec", 0, SQLINT4, VLSecuencial$
        PMPasoValores SqlConn&, "@i_sec", 0, SQLINT4, VLSecuencial$

'         If FMTransmitirRPC(SqlConn%, ServerName$, "cob_remesas", "sp_mant_trn_contabilizar", True, "OK ingreso de Transacción a Contabilizar") Then
        If FMTransmitirRPC(SqlConn&, ServerName$, "cob_remesas", "sp_mant_trn_contabilizar", True, "OK ingreso de Transacción a Contabilizar") Then

'             PMChequea SqlConn%
            PMChequea SqlConn&
            txtCampo(0).SetFocus
            PLLimpiar
            PLBuscar
        End If

    Else
        MsgBox "Transacción a eliminarse no seleccionada", 0 + 16, "Mensaje de Error"
    End If


End Sub

Sub PLIngresar()

    ' Valida mandatoriedades

    If Trim$(txtCampo(7).Text) = "" Then
        MsgBox "El código de producto es mandatorio", 0 + 16, "Mensaje de Error"
        Exit Sub
    End If

'gca    If Trim$(txtCampo(6).Text) = "" Then
'gca        MsgBox "El signo de la transacción es mandatorio", 0 + 16, "Mensaje de Error"
'gca        Exit Sub
'gca    End If

    If Trim$(txtCampo(0).Text) = "" Then
        MsgBox "El código de transacción es mandatorio", 0 + 16, "Mensaje de Error"
        Exit Sub
    End If

    If Trim$(txtCampo(4).Text) = "" Then
        MsgBox "El código del perfil contable es mandatorio", 0 + 16, "Mensaje de Error"
        Exit Sub
    End If

    If Trim$(txtCampo(5).Text) = "" Then
        MsgBox "El valor a contabilizar es mandatorio", 0 + 16, "Mensaje de Error"
        Exit Sub
    End If

    If Trim$(txtCampo(1).Text) = "" Then
        VTCausaOrg$ = "0"
    Else
        VTCausaOrg$ = txtCampo(1).Text
    End If

    If Trim$(txtCampo(8).Text) = "" Then
        VTCausaDst$ = "0"
    Else
        VTCausaDst$ = txtCampo(8).Text
    End If

    If Trim$(txtCampo(10).Text) = "" Then
        MsgBox "El código de MONEDA es mandatorio", 0 + 16, "Mensaje de Error"
        Exit Sub
    End If

    '    Select Case Val(txtCampo(10).text)
    '        Case 99, 0, 1
    '        Case Else
    '            MsgBox "El código de MONEDA debe ser 99,0 o 1", 0 + 16, "Mensaje de Error"
    '            Exit Sub
    '    End Select
    
    
'aqui
    
    
    
    

    'gcaIf Trim$(txtCampo(2).Text) = "" Then
    'gca    VTIndicador$ = "0"
    'gcaElse
        'gcaVTIndicador$ = txtCampo(2).Text
    'gcaEnd If


'     PMPasoValores SqlConn%, "@t_trn", 0, SQLINT4, "10493"
    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, "10493"

'     PMPasoValores SqlConn%, "@i_operacion", 0, SQLCHAR, "I"
    PMPasoValores SqlConn&, "@i_operacion", 0, SQLCHAR, "I"

'     PMPasoValores SqlConn%, "@i_prod", 0, SQLINT1, (txtcampo(7).Text)
    PMPasoValores SqlConn&, "@i_prod", 0, SQLINT1, (txtCampo(7).Text)

'     'gcaPMPasoValores SqlConn%, "@i_credeb", 0, SQLCHAR, (txtCampo(6).Text)
    'gcaPMPasoValores SqlConn&, "@i_credeb", 0, SQLCHAR, (txtCampo(6).Text)

'     PMPasoValores SqlConn%, "@i_tran", 0, SQLINT4, (txtcampo(0).Text)
    PMPasoValores SqlConn&, "@i_tran", 0, SQLINT4, (txtCampo(0).Text)

'     PMPasoValores SqlConn%, "@i_causa_org", 0, SQLVARCHAR, VTCausaOrg$
    PMPasoValores SqlConn&, "@i_causa_org", 0, SQLVARCHAR, VTCausaOrg$

'     PMPasoValores SqlConn%, "@i_causa_dst", 0, SQLVARCHAR, VTCausaDst$
    PMPasoValores SqlConn&, "@i_causa_dst", 0, SQLVARCHAR, VTCausaDst$

'     'gcaPMPasoValores SqlConn%, "@i_indicador", 0, SQLINT1, VTIndicador$
    'gcaPMPasoValores SqlConn&, "@i_indicador", 0, SQLINT1, VTIndicador$

'     PMPasoValores SqlConn%, "@i_descripcion", 0, SQLVARCHAR, (lbldescripcion(6).Caption)
    PMPasoValores SqlConn&, "@i_descripcion", 0, SQLVARCHAR, (lblDescripcion(6).Caption)

'     PMPasoValores SqlConn%, "@i_perfil", 0, SQLVARCHAR, (txtcampo(4).Text)
    PMPasoValores SqlConn&, "@i_perfil", 0, SQLVARCHAR, (txtCampo(4).Text)

'     PMPasoValores SqlConn%, "@i_contabiliza", 0, SQLVARCHAR, (txtcampo(5).Text)
    PMPasoValores SqlConn&, "@i_contabiliza", 0, SQLVARCHAR, (txtCampo(5).Text)

'     PMPasoValores SqlConn%, "@i_estado", 0, SQLVARCHAR, (txtcampo(9).Text)
    PMPasoValores SqlConn&, "@i_estado", 0, SQLCHAR, (txtCampo(9).Text)

'     PMPasoValores SqlConn%, "@i_mon", 0, SQLINT1, (txtcampo(10).Text)
    PMPasoValores SqlConn&, "@i_mon", 0, SQLINT1, (txtCampo(10).Text)

'     If FMTransmitirRPC(SqlConn%, ServerName$, "cob_remesas", "sp_mant_trn_contabilizar", True, "OK ingreso de Transacción a Contabilizar") Then
    If FMTransmitirRPC(SqlConn&, ServerName$, "cob_remesas", "sp_mant_trn_contabilizar", True, "OK ingreso de Transacción a Contabilizar") Then

'         PMChequea SqlConn%
        PMChequea SqlConn&
        txtCampo(0).SetFocus
    End If

End Sub

Sub PLLimpiar()
    ' Limpiar en niveles

    If (Trim$(txtCampo(6).Text) <> "") And (Trim$(txtCampo(4).Text) <> "") And (Trim$(txtCampo(5).Text) <> "") Then
        lblDescripcion(1).Caption = ""
        lblDescripcion(2).Caption = ""
        lblDescripcion(5).Caption = ""
        lblDescripcion(6).Caption = ""
        lblDescripcion(7).Caption = ""
        lblDescripcion(8).Caption = ""
        txtCampo(1).Text = ""
        txtCampo(2).Text = ""
        txtCampo(3).Text = ""
        txtCampo(4).Text = ""
        txtCampo(5).Text = ""
        txtCampo(8).Text = ""
        txtCampo(9).Text = ""
        txtCampo(10).Text = ""
    ElseIf Trim$(txtCampo(0).Text) <> "" Then
        lblDescripcion(0).Caption = ""
        txtCampo(0).Text = ""
        lblDescripcion(4).Caption = ""
        txtCampo(6).Text = ""
        PMLimpiaGrid grdRegistros
    Else
        For i% = 0 To 8
            lblDescripcion(i%).Caption = ""
        Next i%

        For i% = 0 To 10
            txtCampo(i%).Text = ""
        Next i%

        PMLimpiaGrid grdRegistros

    End If
    txtCampo(9).Text = "V"
    lblDescripcion(5).Caption = "VIGENTE"

    ' Actualizar y eliminar
    cmdBoton(3).Enabled = False
    cmdBoton(6).Enabled = False
    VLSecuencial$ = ""
    ' Ingresar
    cmdBoton(2).Enabled = True
    txtCampo(7).Enabled = True

End Sub

Sub PLModificar()

    If VLSecuencial$ <> "" Then

        ' Valida mandatoriedades

        If Trim$(txtCampo(7).Text) = "" Then
            MsgBox "El código de producto es mandatorio", 0 + 16, "Mensaje de Error"
            Exit Sub
        End If

        'gcaIf Trim$(txtCampo(6).text) = "" Then
            'gcaMsgBox "El signo de la transacción es mandatorio", 0 + 16, "Mensaje de Error"
            'gcaExit Sub
         'gcaEnd If

        If Trim$(txtCampo(0).Text) = "" Then
            MsgBox "El código de transacción es mandatorio", 0 + 16, "Mensaje de Error"
            Exit Sub
        End If

        If Trim$(txtCampo(4).Text) = "" Then
            MsgBox "El código del perfil contable es mandatorio", 0 + 16, "Mensaje de Error"
            Exit Sub
        End If

        If Trim$(txtCampo(5).Text) = "" Then
            MsgBox "El campo a contabilizar es mandatorio", 0 + 16, "Mensaje de Error"
            Exit Sub
        End If

        If Trim$(txtCampo(1).Text) = "" Then
            VTCausaOrg$ = "0"
        Else
            VTCausaOrg$ = txtCampo(1).Text
        End If

        If Trim$(txtCampo(8).Text) = "" Then
            VTCausaDst$ = "0"
        Else
            VTCausaDst$ = txtCampo(8).Text
        End If


        If Trim$(txtCampo(10).Text) = "" Then
            MsgBox "El código de MONEDA es mandatorio", 0 + 16, "Mensaje de Error"
            Exit Sub
        End If

'        Select Case Val(txtcampo(10).Text)
'            Case 99, 0, 1
'            Case Else
'                MsgBox "El código de MONEDA debe ser 99,0 o 1", 0 + 16, "Mensaje de Error"
'                Exit Sub
'        End Select

        'gcaIf Trim$(txtCampo(2).text) = "" Then
            'gcaVTIndicador$ = "0"
        'gcaElse
            'gcaVTIndicador$ = txtCampo(2).text
        'gcaEnd If


'         PMPasoValores SqlConn%, "@t_trn", 0, SQLINT4, "10493"
        PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, "10493"

'         PMPasoValores SqlConn%, "@i_operacion", 0, SQLCHAR, "U"
        PMPasoValores SqlConn&, "@i_operacion", 0, SQLCHAR, "U"

'         PMPasoValores SqlConn%, "@i_prod", 0, SQLINT1, (txtcampo(7).Text)
        PMPasoValores SqlConn&, "@i_prod", 0, SQLINT1, (txtCampo(7).Text)

'         'gcaPMPasoValores SqlConn%, "@i_credeb", 0, SQLCHAR, (txtCampo(6).text)
        'gcaPMPasoValores SqlConn&, "@i_credeb", 0, SQLCHAR, (txtCampo(6).text)

'         PMPasoValores SqlConn%, "@i_tran", 0, SQLINT4, (txtcampo(0).Text)
        PMPasoValores SqlConn&, "@i_tran", 0, SQLINT4, (txtCampo(0).Text)

'         PMPasoValores SqlConn%, "@i_causa_org", 0, SQLVARCHAR, VTCausaOrg$
        PMPasoValores SqlConn&, "@i_causa_org", 0, SQLVARCHAR, VTCausaOrg$

'         PMPasoValores SqlConn%, "@i_causa_dst", 0, SQLVARCHAR, VTCausaDst$
        PMPasoValores SqlConn&, "@i_causa_dst", 0, SQLVARCHAR, VTCausaDst$

'         'gcaPMPasoValores SqlConn%, "@i_indicador", 0, SQLINT1, VTIndicador$
        'gcaPMPasoValores SqlConn&, "@i_indicador", 0, SQLINT1, VTIndicador$

'         PMPasoValores SqlConn%, "@i_descripcion", 0, SQLVARCHAR, (lbldescripcion(6).Caption)
        PMPasoValores SqlConn&, "@i_descripcion", 0, SQLVARCHAR, (lblDescripcion(6).Caption)

'         PMPasoValores SqlConn%, "@i_perfil", 0, SQLVARCHAR, (txtcampo(4).Text)
        PMPasoValores SqlConn&, "@i_perfil", 0, SQLVARCHAR, (txtCampo(4).Text)

'         PMPasoValores SqlConn%, "@i_contabiliza", 0, SQLVARCHAR, (txtcampo(5).Text)
        PMPasoValores SqlConn&, "@i_contabiliza", 0, SQLVARCHAR, (txtCampo(5).Text)

'         PMPasoValores SqlConn%, "@i_estado", 0, SQLVARCHAR, (txtcampo(9).Text)
        PMPasoValores SqlConn&, "@i_estado", 0, SQLCHAR, (txtCampo(9).Text)

'         PMPasoValores SqlConn%, "@i_sec", 0, SQLINT4, VLSecuencial$
        PMPasoValores SqlConn&, "@i_sec", 0, SQLINT4, VLSecuencial$

'         PMPasoValores SqlConn%, "@i_mon", 0, SQLINT1, (txtcampo(10).Text)
        PMPasoValores SqlConn&, "@i_mon", 0, SQLINT1, (txtCampo(10).Text)

'         If FMTransmitirRPC(SqlConn%, ServerName$, "cob_remesas", "sp_mant_trn_contabilizar", True, "OK ingreso de Transacción a Contabilizar") Then
        If FMTransmitirRPC(SqlConn&, ServerName$, "cob_remesas", "sp_mant_trn_contabilizar", True, "OK ingreso de Transacción a Contabilizar") Then

'             PMChequea SqlConn%
            PMChequea SqlConn&
            txtCampo(0).SetFocus
            PLBuscar
            VLSecuencial$ = ""
        End If

    Else
        MsgBox "Transacción a modificarse no seleccionada", 0 + 16, "Mensaje de Error"
    End If

End Sub


Sub txtCampo_Change(Index As Integer)

    Select Case Index%
        Case 0, 1, 2, 4, 5, 7, 9
            VLPaso% = False
    End Select

End Sub

Sub txtcampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Código de la transacción por producto"
    Case 1
        FPrincipal!pnlHelpLine.Caption = " Causa asociada a la transacción [F5 Ayuda]"
    Case 2
        FPrincipal!pnlHelpLine.Caption = " Indicador de la transacción [F5 Ayuda]"
    Case 3
        FPrincipal!pnlHelpLine.Caption = " Descripción Contable de Transacción"
    Case 4
        FPrincipal!pnlHelpLine.Caption = " Código de Perfil Contable "
    Case 5
        FPrincipal!pnlHelpLine.Caption = " Nombre del campo a contabilizar"
    Case 6
        FPrincipal!pnlHelpLine.Caption = " Crédito [C] o Débito [D] "
    Case 7
        FPrincipal!pnlHelpLine.Caption = " Producto (3-CTE, 4-AHO, 10-REM)"
    Case 8
        FPrincipal!pnlHelpLine.Caption = " Causa destino por transacción"
    Case 9
        FPrincipal!pnlHelpLine.Caption = " Estado de la transacción a contabilizar [V/C]"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub

Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
    If KeyCode% <> VGTeclaAyuda% Then
        Exit Sub
    End If

    Select Case Index%
        Case 1
            'Causas
            If VLTabla$ = "" Then
                Exit Sub
            End If

            Select Case Trim$(txtCampo(0).Text)
            
            '-- Para parametrizacion TRX 43160              !-- GYC 2018/Dic/20
             Case "43160"
                VLTabla$ = "cc_reverso_pago_ser_chq"
                txtCampo(1).Enabled = True
            
            '-- Visa Electron                               !-- GYC 2011/Jul/04
            Case "4043", "4044", "4045", "4046", "4047", "4048", "4049", "4050", "120044", "120045", "120046", "120048"
                VLTabla$ = "ve_causas_servicios"
                txtCampo(1).Enabled = True
            Case "3050", "3750", "3570", "3751", "3757", "3188", "3866", "3918", "43065", "3471" ' AME 12/17/2012, JPM 10/01/2014 (IMO), JPM 08/Abr/2014 IVA Val.Susp
                VLTabla$ = "cc_causa_nd"
            Case "3194", "3214", "3173", "3145", "3213", "43612", "43613" 'msilvag Trx Claro Paquetes
                VLTabla$ = "sv_empresas_luz"
            Case "3868"
                VLTabla$ = "cc_contable_comision"
            Case "3708", "4376"
                VLTabla$ = "cc_ajuste_deposito_cr"
            Case "3709", "4377"
                VLTabla$ = "cc_ajuste_deposito_db"
            Case "3048", "43088", "43536"
                VLTabla$ = "cc_causa_nc"
            Case "4253", "4255", "4257", "4229", "4284", "4996"
                VLTabla$ = "ah_causa_nc"
            '-- Case "4262", "4264", "4272", "4373", "4570"         '-- GYC 2011/Jul/27 '-- Visa Electron
            Case "4262", "4264", "4272", "4372", "4570", "4419", "4188", "4189", "4248" ' AME 12/17/2012, JPM 08/Abr/2014 IVA Val.Susp
                VLTabla$ = "ah_causa_nd"
            Case "3032", "3335", "3484" ' AME 12/17/2012
                VLTabla$ = "cc_causa_oioe"
            Case "3086"
                VLTabla$ = "cc_causa_oe"
            Case "43149", "43150"  'smerinom GIROS
                VLTabla$ = "cnb_causa_giros"
             Case "4427" 'smerinom QUICKPAY
                VLTabla$ = "cnb_causa_quickpay"
            Case "3570"
                VLTabla$ = "cc_causa_nd"
            Case "3137", "3212", "3218", "3219", "3220", "3227", "3215", "3216", "3221", "4112", "43612", "43613" 'msilvag Trx Claro Paquetes  '-- GYC 2007/Mar/30
                VLTabla$ = "sv_empresas_luz"
            Case "3113", "3232", "3761"
                VLTabla$ = "re_nom_colegio"
                txtCampo(1).Enabled = True
            Case "3255" 'PAGO TARJETA CORPORATIVA
                VLTabla$ = "sv_empresa_corp"
            Case "3208", "3304", "3305", "3306", "3307", "3796", "3797", "3799", "3814", "3818", "3827", "3795", "3739", "3742", "3743", "3748", "3749", "3794", "43555", "43556", "43557", "43558" '-- GYC 2005/Oct18
                VLTabla$ = "sv_courier_giro"
            Case "3322", "3323"     '-- ESA 2006/Jun28
                VLTabla$ = "cg_banco"
            Case "3303", "3735", "3747"                                 '-- GYC 2005/Oct18
                VLTabla$ = "cg_banco_corresponsal"
            Case "10476", "10402", "10403", "10404", "10462", "10463", "10464", "10472", "10473", "10474", "10482", "10483", "10484"
                VLTabla$ = "re_corresponsal"
            Case "10511", "10512", "10513", "10514", "10515", "10516", "10517", "10518", "10519", "10521", "10522", "10523", "10524", "10525", "10526", "10527", "10528", "10529", "10531", "10532", "10533", "10534", "10535", "10536", "10537", "10538", "10539", "10541", "10542", "10543", "10544", "10545", "10546", "10547", "10548", "10549", "10572", "10573"
                VLTabla$ = "re_corresponsal"
            Case "3113", "3232", "3761"
                VLTabla$ = "re_nom_colegio"
            Case "10300", "10301", "10302", "10310", "10311", "10312", "10313", "10314"
                VLTabla$ = "cl_oficina"
                txtCampo(1).Enabled = True
            Case "3800", "3809", "3273", "3272", "3619" ' wcj: 07/ago/2006 => 3619
                VLTabla$ = "fc_empresa"
                txtCampo(1).Enabled = True
            Case "3666", "3060", "3064"
                VLTabla$ = "cc_usodefondos"
                txtCampo(1).Enabled = True
            Case "3493", "3490", "3491", "3492", "3281", "3869", "43083", "43084" 'AME 06/25/2013
                VLTabla$ = "bz_causales_sat"
                txtCampo(1).Enabled = True
                
             Case "3451", "3452", "3453", "3454", "3455", "3456", "3457", "4320", "4321", "4322", "4323"
                VLTabla$ = "cc_causas_liquidacion"
                txtCampo(1).Enabled = True
             Case "3366", "3372", "3497" ' AME 12/17/2012
             VLTabla$ = "re_servicio_comision"
                txtCampo(1).Enabled = True
           Case "3868"
            VLTabla$ = "cc_contable_comision"
            txtCampo(1).Enabled = True
           Case "3870", "3875", "3874", "3721" ' AME 12/19/2012
            VLTabla$ = "cl_transf_env"
            txtCampo(1).Enabled = True
        Case "3770", "3775"
            VLTabla$ = "cl_transf_recib"
            txtCampo(1).Enabled = True
        '**** tc 20/05/2009 inicio ******
        Case "3091", "3584" 'CTE-CE-SGC00021257 mlindaor 06/22/2015 se aumenta trx 3584
            VLTabla$ = "cl_emi_cheque"
            txtCampo(1).Enabled = True
        Case "3582", "3648" 'CTE-CE-SGC00021257 mlindaor 06/22/2015 se aumenta trx 3648
            VLTabla$ = "cl_eli_cheque"
            txtCampo(1).Enabled = True
        '**** tc 20/05/2009 fin ******
        '**** tc 20/05/2009 fin ******
        Case "4252", "4246", "3040", "3553", "4435", "4436", "4437" 'smerino 02042020
           VLTabla$ = "ah_causa_deposito"
           txtCampo(1).Enabled = True
           'ini cmeg 12Julio2006
        Case "120002", "120033", "120004", "120036", "120037", "120049", "120027", "120154", "120167", "120094"
            VLTabla$ = "vi_causas_nd_virtual"
            txtCampo(1).Enabled = True
        Case "120003", "120050"
            VLTabla$ = "vi_causas_nc_virtual"
            txtCampo(1).Enabled = True
           'fin cmeg 12Julio2006
        Case "3909" 'TC 08/21/2008
            VLTabla$ = "cc_causa_chq_ext"
            txtCampo(1).Enabled = True
            Case "4007" 'TC 10/17/2008
            VLTabla$ = "ah_transfer_inv"
            txtCampo(1).Enabled = True
            Case "3177", "3473", "4040", "4041", "4042", "3733"
            VLTabla$ = "cc_causa_paykard"
            txtCampo(1).Enabled = True
            Case "4018", "3925", "3926", "3927", "3928", "3916", "3917", "3919", "3922" 'lgusnay  RECMPS-171
            VLTabla$ = "sv_empresas_luz"
            txtCampo(1).Enabled = True
            Case "4317"  'smerino
            VLTabla$ = "cl_rever_transf"
            txtCampo(1).Enabled = True
            Case "4319"  'smerino
            VLTabla$ = "cl_rever_transf_dif"
            Case "3142" 'smerino ajustes sri
            VLTabla$ = "cl_tran_sri"
            txtCampo(1).Enabled = True
            Case "3331" 'smerino ajustes sri
            VLTabla$ = "cl_tran_sri"
            txtCampo(1).Enabled = True
            Case "3819", "3800", "3820", "3262"
            VLTabla$ = "fc_empresa"
            txtCampo(1).Enabled = True
            Case "43452"
            VLTabla$ = "pg_clientes_cnb"
            txtCampo(1).Enabled = True
            Case "3704"
            VLTabla$ = "cc_nd_efectivo"
            txtCampo(1).Enabled = True
            Case "4963", "4964", "4968"       'JPM 25/may/2016 -->
            VLTabla$ = "sv_causas_bbp"
            txtCampo(1).Enabled = True     '<-- JPM 25/may/2016
            'PHOYOSV INI CTA.BAS CB-AP-SGC00018374-SGC00018901
            Case "120055": VLTabla$ = "bas_causa_interb": txtCampo(1).Enabled = True
            Case "120056": VLTabla$ = "bas_causa_interb": txtCampo(1).Enabled = True
            Case "120058": VLTabla$ = "bas_causa_interb": txtCampo(1).Enabled = True
            Case "120059": VLTabla$ = "bas_causa_nc": txtCampo(1).Enabled = True
            Case "120060": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
            Case "120061": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
            Case "120062": VLTabla$ = "bas_causa_deposito": txtCampo(1).Enabled = True
            Case "120063": VLTabla$ = "bas_causa_deposito": txtCampo(1).Enabled = True
            Case "120065": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
            Case "120066": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
            Case "120067": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
            Case "120068": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
            Case "120069": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
            Case "120070": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
            Case "120071": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
            Case "120072": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
            Case "120086": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
            Case "120087": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
            Case "120090": VLTabla$ = "bas_ajuste_deposito_cr": txtCampo(1).Enabled = True
            Case "120091": VLTabla$ = "bas_ajuste_deposito_db": txtCampo(1).Enabled = True
            Case "120161": VLTabla$ = "bas_causa_nc": txtCampo(1).Enabled = True
            'PHOYOSV FIN CTA.BAS CB-AP-SGC00018374-SGC00018901
            Case "120174": VLTabla$ = "bas_causa_nc": txtCampo(1).Enabled = True    'pholguiv CTE-CC-SGC00025809 compensa Iva
            Case Else
                VLTabla$ = "cc_causa_nd"
        End Select


'             PMPasoValores SqlConn%, "@i_tabla", 0, SQLCHAR, VLTabla$
            PMPasoValores SqlConn&, "@i_tabla", 0, SQLCHAR, VLTabla$

'             PMPasoValores SqlConn%, "@i_tipo", 0, SQLCHAR, "A"
            PMPasoValores SqlConn&, "@i_tipo", 0, SQLCHAR, "A"

'             If FMTransmitirRPC(SqlConn%, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtcampo(Index%).Text & "]") Then
            If FMTransmitirRPC(SqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtCampo(Index%).Text & "]") Then
                VLPaso% = True
'                 PMMapeaListaH SqlConn%, FCatalogo!lstCatalogo, False
                PMMapeaListaH SqlConn&, FCatalogo!lstCatalogo, False
'                 PMChequea SqlConn%
                PMChequea SqlConn&
                FCatalogo.Show 1
                txtCampo(1).Text = VGACatalogo.codigo$
                lblDescripcion(1).Caption = VGACatalogo.Descripcion$
                If Trim$(txtCampo(1).Text) = "" Then
                    lblDescripcion(1).Caption = ""
                    txtCampo(1).SetFocus
                End If
            End If
        Case 2  'Indicadores

'             PMPasoValores SqlConn%, "@i_tabla", 0, SQLCHAR, "cc_tipo_indicador"
            PMPasoValores SqlConn&, "@i_tabla", 0, SQLCHAR, "cc_tipo_indicador"

'             PMPasoValores SqlConn%, "@i_tipo", 0, SQLCHAR, "A"
            PMPasoValores SqlConn&, "@i_tipo", 0, SQLCHAR, "A"

'             If FMTransmitirRPC(SqlConn%, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtcampo(Index%).Text & "]") Then
            If FMTransmitirRPC(SqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtCampo(Index%).Text & "]") Then
                VLPaso% = True

'                 PMMapeaListaH SqlConn%, FCatalogo!lstCatalogo, False
                PMMapeaListaH SqlConn&, FCatalogo!lstCatalogo, False

'                 PMChequea SqlConn%
                PMChequea SqlConn&
                FCatalogo.Show 1
                txtCampo(2).Text = VGACatalogo.codigo$
                lblDescripcion(2).Caption = VGACatalogo.Descripcion$
                If Trim$(txtCampo(2).Text) = "" Then
                    lblDescripcion(2).Caption = ""
                    txtCampo(2).SetFocus
                End If
            End If
        Case 4
            ' Perfiles contables
    Case 5
        'VAlores a contabilizar



'         PMPasoValores SqlConn%, "@i_tabla", 0, SQLCHAR, "cc_valor_contab"
        PMPasoValores SqlConn&, "@i_tabla", 0, SQLCHAR, "cc_valor_contab"

'         PMPasoValores SqlConn%, "@i_tipo", 0, SQLCHAR, "A"
        PMPasoValores SqlConn&, "@i_tipo", 0, SQLCHAR, "A"

'         'PMPasoValores SqlConn%, "@i_codigo", 0, SQLVARCHAR, (txtcampo(5).Text)
        'PMPasoValores SqlConn&, "@i_codigo", 0, SQLVARCHAR, (txtcampo(5).Text)

'         If FMTransmitirRPC(SqlConn%, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtcampo(Index%).Text & "]") Then
        If FMTransmitirRPC(SqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtCampo(Index%).Text & "]") Then
            VLPaso% = True

'             PMMapeaListaH SqlConn%, FCatalogo!lstCatalogo, False
            PMMapeaListaH SqlConn&, FCatalogo!lstCatalogo, False

'             PMChequea SqlConn%
            PMChequea SqlConn&
            FCatalogo.Show 1
            txtCampo(5).Text = VGACatalogo.codigo$
            lblDescripcion(7).Caption = VGACatalogo.Descripcion$
            If Trim$(txtCampo(5).Text) = "" Then
                lblDescripcion(7).Caption = ""
                txtCampo(5).SetFocus
            End If
        End If

'         PMChequea SqlConn%
        PMChequea SqlConn&

        Case 7
            ' Producto a Contabilizar
            VLPaso% = True

'             PMPasoValores SqlConn%, "@t_trn", 0, SQLINT4, "10475"
            PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, "10475"

'             PMPasoValores SqlConn%, "@i_ope", 0, SQLCHAR, "A"
            PMPasoValores SqlConn&, "@i_ope", 0, SQLCHAR, "A"

'             If FMTransmitirRPC(SqlConn%, ServerName$, "cob_remesas", "sp_consulta_prod", True, " OK... Consulta de Productos COBIS") Then
            If FMTransmitirRPC(SqlConn&, ServerName$, "cob_remesas", "sp_consulta_prod", True, " OK... Consulta de Productos COBIS") Then

'                 PMMapeaListaH SqlConn%, FCatalogo!lstCatalogo, False
                PMMapeaListaH SqlConn&, FCatalogo!lstCatalogo, False

'                 PMChequea SqlConn%
                PMChequea SqlConn&
                FCatalogo.Show 1
                txtCampo(7).Text = VGACatalogo.codigo$
                lblDescripcion(3).Caption = VGACatalogo.Descripcion$
                If Trim$(txtCampo(7).Text) = "" Then
                    txtCampo(0).Text = ""
                    lblDescripcion(0).Caption = ""
                    lblDescripcion(3).Caption = ""
                    txtCampo(7).SetFocus
                End If
            End If
         Case Is = 10
                'VLPaso% = True
                If KeyCode = vbKeyF5 Then
                    PMPasoValores SqlConn&, "@i_tabla", 0, SQLVARCHAR, "cl_moneda"
                    PMPasoValores SqlConn&, "@i_tipo", 0, SQLCHAR, "A"
                    If FMTransmitirRPC(SqlConn&, ServerName$, "cobis", "sp_hp_catalogo", False, "") Then
                       PMMapeaListaH SqlConn&, FCatalogo!lstCatalogo, False
                       PMChequea SqlConn&
                       FCatalogo.Show 1
                       txtCampo(10).Text = VGACatalogo.codigo$
                       lblDescripcion(8).Caption = VGACatalogo.Descripcion$
                       
                       'SGMonedaTran = VGCodigoCatalogo$
                       'Inicio Sumadora con moneda
                       'PMCargaIniSumadora txtCampo.text
                   End If
                End If
            
            
    End Select
End Sub

Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)

    Select Case Index%
        Case 0, 1, 2, 4, 7, 8
           KeyAscii% = FMValidaTipoDato("N", KeyAscii%)
        Case 3
            KeyAscii% = FMValidaTipoDato("B", KeyAscii%)
        Case 5
            KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
        Case 6
            KeyAscii% = FMValidaTipoDato("A", KeyAscii%)
        Case 9
            KeyAscii% = FMValidaTipoDato("A", KeyAscii%)
    End Select

End Sub

Sub txtCampo_LostFocus(Index As Integer)

    Select Case Index%
    Case 0
        'Transacciones

        If VLPaso% = True Then
            Exit Sub
        End If

        If Trim$(txtCampo(0).Text) = "" Then
            Exit Sub
        End If

        If Trim$(txtCampo(7).Text) = "" Then
            MsgBox "Código de producto mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).Text = ""
            lblDescripcion(0).Caption = ""
            txtCampo(7).SetFocus
            Exit Sub
        End If

        ' Validar los rangos de transacciones de acuerdo al producto
        'VTTranVal% = Val(txtCampo(0).Text)
        VTTranVal = val(txtCampo(0).Text) 'cmeg 17Julio2006
        Select Case Trim$(txtCampo(7).Text)
        Case "3"
            'GMD: Cambio de números de transacciones
            'If VTTranVal% > 2999 Or (VTTranVal% < 2500 And VTTranVal% > 99) Then
            'If VTTranVal% < 3000 Or VTTranVal% > 3999 Then 'cmeg 17Julio2006
            '-- If (VTTranVal < 3000 Or VTTranVal > 3999) And VTTranVal <> 4007 And VTTranVal <> 4040 And VTTranVal <> 4041 And VTTranVal <> 4042 And VTTranVal <> 4112 Then   'cmeg 17Julio2006
            '--smerino4427 quickpayd incluir 4427
            '--KBastidz incluir 62689 Paquete Movistar HD - 62688 Paquete Movistar HN
            '--KBastidz incluir 62687 Paquete Tuenti HD - 62686 Paquete Tuenti HN
            If (VTTranVal < 3000 Or VTTranVal > 3999) And (VTTranVal < 43000 Or VTTranVal > 43999) And VTTranVal <> 4007 And VTTranVal <> 4040 And VTTranVal <> 4041 And VTTranVal <> 4042 And VTTranVal <> 4112 And VTTranVal <> 4043 And VTTranVal <> 4044 And VTTranVal <> 4045 And VTTranVal <> 4046 And VTTranVal <> 4047 And VTTranVal <> 4048 And VTTranVal <> 4049 And VTTranVal <> 4050 And VTTranVal <> 4317 And VTTranVal <> 4427 And VTTranVal <> 62688 And VTTranVal <> 62689 And VTTranVal <> 62686 And VTTranVal <> 62687 And VTTranVal <> 4319 _
                And InStr(1, "4012,4013,4014,4015,4017,4018,4813,4814,4815,4963,4964,4968,4435,4060,4061,4062,4063,4437", RTrim(LTrim(CStr(VTTranVal)))) = 0 Then                 'smerino 02042020-- GYC 2011/Jul/04  (Visa Electron)smerino  ' JPM 25/may/2016
                MsgBox "Código de transacción no pertenece a producto", 0 + 16, "Mensaje de Error"
                txtCampo(0).Text = ""
                lblDescripcion(0).Caption = ""
                txtCampo(0).SetFocus
                Exit Sub
            End If
        Case "4"
            'GMD: Cambio de números de transacciones
            'If VTTranVal% <= 200 Or VTTranVal% >= 302 Then
            'If VTTranVal% < 4000 Or VTTranVal% > 4999 Then 'cmeg 17Julio2006
            If (VTTranVal < 4000 Or VTTranVal > 4999) Then   'cmeg 17Julio2006
                MsgBox "Código de transacción no pertenece a producto", 0 + 16, "Mensaje de Error"
                txtCampo(0).Text = ""
                lblDescripcion(0).Caption = ""
                txtCampo(0).SetFocus
                Exit Sub
            End If
        Case "10"
            'GMD: Cambio de números de transacciones
            'If VTTranVal% <= 400 Or VTTranVal% >= 500 Then
            'If VTTranVal% < 10000 Or VTTranVal% >= 10999 Then 'cmeg 17Julio2006
            If VTTranVal < 10000 Or VTTranVal >= 10999 Then 'cmeg 17Julio2006
                MsgBox "Código de transacción no pertenece a producto", 0 + 16, "Mensaje de Error"
                txtCampo(0).Text = ""
                lblDescripcion(0).Caption = ""
                txtCampo(0).SetFocus
                Exit Sub
            End If
        
        Case "12"
            'PHOYOSV INI-03-MAR-2015 CTA.BAS CB-AP-SGC00018374-SGC00018901
            If VTTranVal < 120000 Or VTTranVal >= 120999 Then
                MsgBox "Código de transacción no pertenece a producto", 0 + 16, "Mensaje de Error"
                txtCampo(0).Text = ""
                lblDescripcion(0).Caption = ""
                txtCampo(0).SetFocus
                Exit Sub
            End If
            'PHOYOSV FIN-03-MAR-2015 CTA.BAS CB-AP-SGC00018374-SGC00018901
        End Select


'         PMPasoValores SqlConn%, "@t_trn", 0, SQLINT4, "10494"
        PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, "10494"

'         PMPasoValores SqlConn%, "@i_operacion", 0, SQLCHAR, "H"
        PMPasoValores SqlConn&, "@i_operacion", 0, SQLCHAR, "H"

'         PMPasoValores SqlConn%, "@i_codigo", 0, SQLINT4, (txtcampo(0).Text)
        PMPasoValores SqlConn&, "@i_codigo", 0, SQLINT4, (txtCampo(0).Text)

'         If FMTransmitirRPC(SqlConn%, ServerName$, "cob_remesas", "sp_help_trn_contabilizar", False, "") Then
        If FMTransmitirRPC(SqlConn&, ServerName$, "cob_remesas", "sp_help_trn_contabilizar", False, "") Then

'             PMMapeaObjeto SqlConn%, lbldescripcion(0)
            PMMapeaObjeto SqlConn&, lblDescripcion(0)

'             PMChequea SqlConn%
            PMChequea SqlConn&
            txtCampo(1).Text = ""
            lblDescripcion(1).Caption = ""
        Else
            txtCampo(0).Text = ""
            lblDescripcion(0).Caption = ""
            txtCampo(0).SetFocus
        End If

        Select Case Trim$(txtCampo(0).Text)
        
        '-- Para parametrizacion TRX 43160              !-- GYC 2018/Dic/20
        Case "43160"
            VLTabla$ = "cc_reverso_pago_ser_chq"
            txtCampo(1).Enabled = True
        
        '-- Visa Electron                               !-- GYC 2011/Jul/04
        Case "4043", "4044", "4045", "4046", "4047", "4048", "4049", "4050", "120044", "120045", "120046", "120048"
             VLTabla$ = "ve_causas_servicios"
             txtCampo(1).Enabled = True
        Case "3050", "3750", "3751", "3570", "3633", "3188", "3757", "3866", "3918", "43065", "3471"  'JPM 10/01/2014 (IMO), JPM 08/Abr/2014: IVA Val.Susp
            VLTabla$ = "cc_causa_nd"
            txtCampo(1).Enabled = True
        Case "3194", "3214", "3173", "3145", "3213", "4014", "4015", "4060", "4061", "4062", "4063", "43612", "43613", "62688", "62689", "62686", "62687" 'msilvag Trx Claro Paquetes Kbastidz 62688-62689 Movistar Paquete, KBastidz 62686-62687 Paquete Tuenti
            VLTabla$ = "sv_empresas_luz"
            txtCampo(1).Enabled = True
'        Case 3282, 43085
'             VLTabla$ = ""
'             txtCampo(1).Enabled = True
        Case "3868"
            VLTabla$ = "cc_contable_comision"
            txtCampo(1).Enabled = True
        Case "3708", "4376"
            VLTabla$ = "cc_ajuste_deposito_cr"
            txtCampo(1).Enabled = True
        Case "3709", "4377"
            VLTabla$ = "cc_ajuste_deposito_db"
            txtCampo(1).Enabled = True
        Case "3048", "43088", "43536"
            VLTabla$ = "cc_causa_nc"
            txtCampo(1).Enabled = True
        Case "4253", "4255", "4284", "4996"
            VLTabla$ = "ah_causa_nc"
            txtCampo(1).Enabled = True
        '-- Case "4262", "4264", "4272", "4372", "4373", "4570", "4248", "4188"      '-- GYC 2011/Jul/27 '-- Visa Electron
            Case "4262", "4264", "4272", "4372", "4373", "4570", "4248", "4188", "4419", "4189" 'JPM 08/Abr/2014: IVA Val.Susp
            VLTabla$ = "ah_causa_nd"
            txtCampo(1).Enabled = True
        Case "3032", "3335", "3484" ' AME 12/17/2012
            VLTabla$ = "cc_causa_oioe"
            txtCampo(1).Enabled = True
        Case "3086"
            VLTabla$ = "cc_causa_oe"
            txtCampo(1).Enabled = True
        Case "43149", "43150"  'smerinom GIROS
            VLTabla$ = "cnb_causa_giros"
            txtCampo(1).Enabled = True
        Case "4427" 'smerinom QUICKPAY
            VLTabla$ = "cnb_causa_quickpay"
            txtCampo(1).Enabled = True
        Case "3570"
            VLTabla$ = "cc_causa_nd"
            txtCampo(1).Enabled = True
        Case "10476", "10402", "10403", "10404", "10462", "10463", "10464", "10472", "10473", "10474", "10482", "10483", "10484"
            VLTabla$ = "re_corresponsal"
            txtCampo(1).Enabled = True
        Case "10479", "10511", "10512", "10513", "10514", "10515", "10516", "10517", "10518", "10519", "10521", "10522", "10523", "10524", "10525", "10526", "10527", "10528", "10529", "10531", "10532", "10533", "10534", "10535", "10536", "10537", "10538", "10539", "10541", "10542", "10543", "10544", "10545", "10546", "10547", "10548", "10549", "10572", "10573"
            VLTabla$ = "re_corresponsal"
            txtCampo(1).Enabled = True
        Case "3137", "3212", "3218", "3219", "3220", "3227", "3215", "3216", "3221", "4112", "43612", "43613" 'msilvag Trx Claro Paquetes '-- GYC 2007/Mar/30
            VLTabla$ = "sv_empresas_luz"
            txtCampo(1).Enabled = True
        Case "3113", "3232", "3761"
            VLTabla$ = "re_nom_colegio"
            txtCampo(1).Enabled = True
        Case "3255" 'PAGO TARJETA CORPORATIVA
            VLTabla$ = "sv_empresa_corp"
            txtCampo(1).Enabled = True
        Case "3208", "3304", "3305", "3306", "3307", "3796", "3797", "3799", "3814", "3818", "3827", "3795", "3739", "3742", "3743", "3748", "3749", "3794", "43555", "43556", "43557", "43558" '-- GYC 2005/Oct18
            VLTabla$ = "sv_courier_giro"
            txtCampo(1).Enabled = True          '-- ESA 2006/Jun28
        Case "3322", "3323"     '-- ESA 2006/Jun28
            VLTabla$ = "cg_banco"
            txtCampo(1).Enabled = True
        Case "3303", "3735", "3747"                                 '-- GYC 2005/Oct18
            VLTabla$ = "cg_banco_corresponsal"
        Case "3113", "3232", "3761"
            VLTabla$ = "re_nom_colegio"
        Case "10300", "10301", "10302", "10310", "10311", "10312", "10313", "10314"
            VLTabla$ = "cl_oficina"
            txtCampo(1).Enabled = True
            
        Case "3800", "3809", "3273", "3272", "3619" ' wcj: 07/ago/2006 => 3619
            VLTabla$ = "fc_empresa"
            txtCampo(1).Enabled = True
            
        Case "3060", "3064", "3666"
            VLTabla$ = "cc_usodefondos"
            txtCampo(1).Enabled = True
        Case "3451", "3452", "3453", "3454", "3455", "3456", "3457", "4320", "4321", "4322", "4323"
           VLTabla$ = "cc_causas_liquidacion"
           txtCampo(1).Enabled = True
           Case "3366", "3372", "3497" ' AME 12/17/2012
             VLTabla$ = "re_servicio_comision"
                txtCampo(1).Enabled = True
        Case "3868"
            VLTabla$ = "cc_contable_comision"
            txtCampo(1).Enabled = True
        Case "3493", "3490", "3491", "3492", "3281", "3869", "43083", "43084"
            VLTabla$ = "bz_causales_sat"
            txtCampo(1).Enabled = True
        Case "3870", "3875", "3874", "3721" 'ame 12/19/2012
            VLTabla$ = "cl_transf_env"
            txtCampo(1).Enabled = True
        Case "3770", "3775"
            VLTabla$ = "cl_transf_recib"
            txtCampo(1).Enabled = True
            
        '**** tc 20/05/2009 inicio ******
        Case "3091", "3584" 'CTE-CE-SGC00021257 mlindaor 06/22/2015 se aumenta trx 3584
            VLTabla$ = "cl_emi_cheque"
            txtCampo(1).Enabled = True
        Case "3582", "3648" 'CTE-CE-SGC00021257 mlindaor 06/22/2015 se aumenta trx 3648
            VLTabla$ = "cl_eli_cheque"
            txtCampo(1).Enabled = True
        '**** tc 20/05/2009 fin ******
        '**** tc 20/05/2009 fin ******
         Case "4252", "4246", "3040", "3553", "4435", "4436", "4437" 'smerino 02042020
            VLTabla$ = "ah_causa_deposito"
            txtCampo(1).Enabled = True
        'ini cmeg 17Julio2006
        Case "120002", "120004", "120036", "120037", "120049", "120027", "120154", "120167", "120094"
            VLTabla$ = "vi_causas_nd_virtual"
            txtCampo(1).Enabled = True
        Case "120003", "120050"
            VLTabla$ = "vi_causas_nc_virtual"
            txtCampo(1).Enabled = True
        'fin cmeg 17Julio2006
        Case "3909" 'TC 08/21/2008
            VLTabla$ = "cc_causa_chq_ext"
            txtCampo(1).Enabled = True
        Case "4007" 'TC 10/17/2008
            VLTabla$ = "ah_transfer_inv"
            txtCampo(1).Enabled = True
        Case "3177", "3473", "4040", "4041", "4042", "3733"
            VLTabla$ = "cc_causa_paykard"
            txtCampo(1).Enabled = True
        Case "4018", "3925", "3926", "3927", "3928", "3916", "3917", "3919", "3922", "43612", "43613" 'lgusnay  RECMPS-171 'msilvag Trx Claro Paquetes
            VLTabla$ = "sv_empresas_luz"
            txtCampo(1).Enabled = True
        Case "3819", "3800", "3820", "3262"
            VLTabla$ = "fc_empresa"
            txtCampo(1).Enabled = True
        Case "4317"  'smerino
            VLTabla$ = "cl_rever_transf"
            txtCampo(1).Enabled = True
        Case "4319"  'smerino
            VLTabla$ = "cl_rever_transf_dif"
            txtCampo(1).Enabled = True
        Case "3142" 'smerino ajustes sri
            VLTabla$ = "cl_tran_sri"
            txtCampo(1).Enabled = True
        Case "3331" 'smerino ajustes sri
            VLTabla$ = "cl_tran_sri"
            txtCampo(1).Enabled = True
        Case "43452"
            VLTabla$ = "pg_clientes_cnb"
            txtCampo(1).Enabled = True
        Case "3704"
            VLTabla$ = "cc_nd_efectivo"
            txtCampo(1).Enabled = True
        Case "4963", "4964", "4968"       'JPM 25/may/2016 -->
           VLTabla$ = "sv_causas_bbp"
           txtCampo(1).Enabled = True     '<-- JPM 25/may/2016
        'PHOYOSV INI CTA.BAS CB-AP-SGC00018374-SGC00018901
        Case "120055": VLTabla$ = "bas_causa_interb": txtCampo(1).Enabled = True
        Case "120056": VLTabla$ = "bas_causa_interb": txtCampo(1).Enabled = True
        Case "120058": VLTabla$ = "bas_causa_interb": txtCampo(1).Enabled = True
        Case "120059": VLTabla$ = "bas_causa_nc": txtCampo(1).Enabled = True
        Case "120060": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
        Case "120061": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
        Case "120062": VLTabla$ = "bas_causa_deposito": txtCampo(1).Enabled = True
        Case "120063": VLTabla$ = "bas_causa_deposito": txtCampo(1).Enabled = True
        Case "120065": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
        Case "120066": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
        Case "120067": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
        Case "120068": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
        Case "120069": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
        Case "120070": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
        Case "120071": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
        Case "120072": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
        Case "120086": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
        Case "120087": VLTabla$ = "bas_causa_nd": txtCampo(1).Enabled = True
        Case "120090": VLTabla$ = "bas_ajuste_deposito_cr": txtCampo(1).Enabled = True
        Case "120091": VLTabla$ = "bas_ajuste_deposito_db": txtCampo(1).Enabled = True
        Case "120161": VLTabla$ = "bas_causa_nc": txtCampo(1).Enabled = True
        'PHOYOSV FIN CTA.BAS CB-AP-SGC00018374-SGC00018901
        Case "120174": VLTabla$ = "bas_causa_nc": txtCampo(1).Enabled = True    'pholguiv CTE-CC-SGC00025809 compensa Iva
        Case Else
            VLTabla$ = ""
            txtCampo(1).Enabled = False
        End Select

        'ini cmeg 17Julio2006
        If Trim(Me.txtCampo(7).Text) = "12" Then
            txtCampo(1).Enabled = True
        End If
        'fin cmeg 17Julio2006
    Case 1

        'Causas

        If VLPaso% = True Then
            Exit Sub
        End If

        If Trim$(txtCampo(1).Text) = "" Then
            Exit Sub
        End If

        If VLTabla$ = "" Then
            MsgBox "Código de transacción mandatorio", 0 + 16, "Mensaje de Error"
            Exit Sub
        End If


'         PMPasoValores SqlConn%, "@i_tabla", 0, SQLCHAR, VLTabla$
        PMPasoValores SqlConn&, "@i_tabla", 0, SQLCHAR, VLTabla$

'         PMPasoValores SqlConn%, "@i_tipo", 0, SQLCHAR, "V"
        PMPasoValores SqlConn&, "@i_tipo", 0, SQLCHAR, "V"

'         PMPasoValores SqlConn%, "@i_codigo", 0, SQLVARCHAR, (txtcampo(1).Text)
        PMPasoValores SqlConn&, "@i_codigo", 0, SQLVARCHAR, (txtCampo(1).Text)

'         If FMTransmitirRPC(SqlConn%, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtcampo(Index%).Text & "]") Then
        If FMTransmitirRPC(SqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtCampo(Index%).Text & "]") Then

'             PMMapeaObjeto SqlConn%, lbldescripcion(1)
            PMMapeaObjeto SqlConn&, lblDescripcion(1)

'             PMChequea SqlConn%
            PMChequea SqlConn&
        Else
            txtCampo(1).Text = ""
            lblDescripcion(1).Caption = ""
            txtCampo(1).SetFocus
        End If
    Case 2
        'Indicadores

        If VLPaso% = True Then
            Exit Sub
        End If

        If Trim$(txtCampo(2).Text) = "" Then
            Exit Sub
        End If


'         PMPasoValores SqlConn%, "@i_tabla", 0, SQLCHAR, "cc_tipo_indicador"
        PMPasoValores SqlConn&, "@i_tabla", 0, SQLCHAR, "cc_tipo_indicador"

'         PMPasoValores SqlConn%, "@i_tipo", 0, SQLCHAR, "V"
        PMPasoValores SqlConn&, "@i_tipo", 0, SQLCHAR, "V"

'         PMPasoValores SqlConn%, "@i_codigo", 0, SQLVARCHAR, (txtcampo(2).Text)
        PMPasoValores SqlConn&, "@i_codigo", 0, SQLVARCHAR, (txtCampo(2).Text)

'         If FMTransmitirRPC(SqlConn%, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtcampo(Index%).Text & "]") Then
        If FMTransmitirRPC(SqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtCampo(Index%).Text & "]") Then

'             PMMapeaObjeto SqlConn%, lbldescripcion(2)
            PMMapeaObjeto SqlConn&, lblDescripcion(2)

'             PMChequea SqlConn%
            PMChequea SqlConn&
        End If


    Case 4
        'perfiles contables

        If VLPaso% = True Then
            Exit Sub
        End If

        If Trim$(txtCampo(4).Text) = "" Then
            Exit Sub
        End If
        If Trim$(txtCampo(7).Text) = "" Then
            MsgBox "Defina primero el producto a contabilizar"
            txtCampo(0).SetFocus
            Exit Sub
        End If

        ReDim VTVector(4) As String

'         PMPasoValores SqlConn%, "@t_trn", 0, SQLINT4, "6907"
        PMPasoValores SqlConn&, "@t_trn", 0, SQLINT2, "6907"

'         PMPasoValores SqlConn%, "@i_operacion", 0, SQLCHAR, "S"
        PMPasoValores SqlConn&, "@i_operacion", 0, SQLCHAR, "S"

'         PMPasoValores SqlConn%, "@i_modo", 0, SQLINT2, "0"
        PMPasoValores SqlConn&, "@i_modo", 0, SQLINT2, "0"

'         PMPasoValores SqlConn%, "@i_perfil", 0, SQLVARCHAR, (txtcampo(4).Text)
        PMPasoValores SqlConn&, "@i_perfil", 0, SQLVARCHAR, (txtCampo(4).Text)

'         PMPasoValores SqlConn%, "@i_producto", 0, SQLINT1, (txtcampo(7).Text)
        PMPasoValores SqlConn&, "@i_producto", 0, SQLINT1, (txtCampo(7).Text)

'         PMPasoValores SqlConn%, "@i_empresa", 0, SQLINT1, "1"
        PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT1, "1"

'         If FMTransmitirRPC(SqlConn%, ServerName$, "cob_conta", "sp_perfil", True, " Consulta de la oficina " & "[" & txtcampo(Index%).Text & "]") Then
        If FMTransmitirRPC(SqlConn&, ServerName$, "cob_conta", "sp_perfil", True, " Consulta de la oficina " & "[" & txtCampo(Index%).Text & "]") Then

'             a% = FMMapeaArreglo(SqlConn%, VTVector())
            a% = FMMapeaArreglo(SqlConn&, VTVector())
            lblDescripcion(6).Caption = VTVector(3)
            VLPaso% = True
        Else
            txtCampo(4).SetFocus
        End If

'         PMChequea SqlConn%
        PMChequea SqlConn&


    Case 5
        'VAlores a contabilizar

        If VLPaso% = True Then
            Exit Sub
        End If

        If Trim$(txtCampo(5).Text) = "" Then
            Exit Sub
        End If


'         PMPasoValores SqlConn%, "@i_tabla", 0, SQLCHAR, "cc_valor_contab"
        PMPasoValores SqlConn&, "@i_tabla", 0, SQLCHAR, "cc_valor_contab"

'         PMPasoValores SqlConn%, "@i_tipo", 0, SQLCHAR, "V"
        PMPasoValores SqlConn&, "@i_tipo", 0, SQLCHAR, "V"

'         PMPasoValores SqlConn%, "@i_codigo", 0, SQLVARCHAR, (txtcampo(5).Text)
        PMPasoValores SqlConn&, "@i_codigo", 0, SQLVARCHAR, (txtCampo(5).Text)

'         If FMTransmitirRPC(SqlConn%, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtcampo(Index%).Text & "]") Then
        If FMTransmitirRPC(SqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtCampo(Index%).Text & "]") Then

'             PMMapeaObjeto SqlConn%, lbldescripcion(7)
            PMMapeaObjeto SqlConn&, lblDescripcion(7)
            VLPaso% = True
        End If

'         PMChequea SqlConn%
        PMChequea SqlConn&


    Case 6

        ' Signo de la transaccion

        If Trim$(txtCampo(6).Text) = "" Then
            Exit Sub
        End If

        If Trim$(txtCampo(7).Text) = "" Then
            MsgBox "Código de producto mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(6).Text = ""
            lblDescripcion(4).Caption = ""
            txtCampo(7).SetFocus
            Exit Sub
        End If

        If Trim$(txtCampo(0).Text) = "" Then
            MsgBox "Código de transacción mandatoria", 0 + 16, "Mensaje de Error"
            txtCampo(6).Text = ""
            lblDescripcion(4).Caption = ""
            txtCampo(0).SetFocus
            Exit Sub
        End If

        If Trim$(txtCampo(6).Text) = "D" Then
            lblDescripcion(4).Caption = "DEBITO"
        ElseIf Trim$(txtCampo(6).Text) = "C" Then
            lblDescripcion(4).Caption = "CREDITO"
        Else
            MsgBox "Signo de Transacción Erróneo", 0 + 16, "Mensaje de Error"
            txtCampo(6).Text = ""
            lblDescripcion(4).Caption = ""
            txtCampo(6).SetFocus
            Exit Sub
        End If

    Case 7
        'Productos COBIS

        If VLPaso% = True Then
            Exit Sub
        End If

        If Trim$(txtCampo(7).Text) = "" Then
            Exit Sub
        End If


'         PMPasoValores SqlConn%, "@t_trn", 0, SQLINT4, "10475"
        PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, "10475"

'         PMPasoValores SqlConn%, "@i_ope", 0, SQLCHAR, "V"
        PMPasoValores SqlConn&, "@i_ope", 0, SQLCHAR, "V"

'         PMPasoValores SqlConn%, "@i_producto", 0, SQLINT4, (txtcampo(7).Text)
        PMPasoValores SqlConn&, "@i_producto", 0, SQLINT4, (txtCampo(7).Text)

'         If FMTransmitirRPC(SqlConn%, ServerName$, "cob_remesas", "sp_consulta_prod", True, " Consulta de la oficina " & "[" & txtcampo(Index%).Text & "]") Then
        If FMTransmitirRPC(SqlConn&, ServerName$, "cob_remesas", "sp_consulta_prod", True, " Consulta de la oficina " & "[" & txtCampo(Index%).Text & "]") Then

'             PMMapeaObjeto SqlConn%, lbldescripcion(3)
            PMMapeaObjeto SqlConn&, lblDescripcion(3)

'             PMChequea SqlConn%
            PMChequea SqlConn&
        Else
            txtCampo(7).Text = ""
            lblDescripcion(3).Caption = ""
            txtCampo(7).SetFocus
        End If

        If txtCampo(7).Text = "3" Then
        End If

    Case 9

        ' Estado

        If Trim$(txtCampo(9).Text) = "" Then
            Exit Sub
        End If

        If Trim$(txtCampo(9).Text) = "V" Then
            lblDescripcion(5).Caption = "VIGENTE"
        ElseIf Trim$(txtCampo(9).Text) = "C" Then
            lblDescripcion(5).Caption = "CANCELADA"
        Else
            MsgBox "Estado de Transacción Erróneo", 0 + 16, "Mensaje de Error"
            txtCampo(9).Text = ""
            lblDescripcion(5).Caption = ""
            txtCampo(9).SetFocus
            Exit Sub
        End If

    End Select
End Sub

