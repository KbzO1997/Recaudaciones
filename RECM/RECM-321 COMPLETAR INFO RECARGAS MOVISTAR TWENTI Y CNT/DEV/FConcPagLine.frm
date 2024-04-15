VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{00025600-0000-0000-C000-000000000046}#5.2#0"; "crystl32.ocx"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.2#0"; "MSCOMCTL.OCX"
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Object = "{86CF1D34-0C5F-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCT2.OCX"
Begin VB.Form FConcPagLine 
   Caption         =   "Conciliación de Pagos en Linea"
   ClientHeight    =   6705
   ClientLeft      =   1215
   ClientTop       =   1890
   ClientWidth     =   9390
   Icon            =   "FConcPagLine.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   6705
   ScaleWidth      =   9390
   Begin VB.TextBox Mensaje 
      Height          =   285
      Left            =   8880
      TabIndex        =   49
      Top             =   840
      Visible         =   0   'False
      Width           =   495
   End
   Begin VB.Frame Frame4 
      Height          =   1290
      Left            =   4440
      TabIndex        =   34
      Top             =   5115
      Width           =   4365
      Begin VB.Label Label6 
         AutoSize        =   -1  'True
         Caption         =   "Totales Empresa:"
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
         Left            =   90
         TabIndex        =   45
         Top             =   150
         Width           =   1485
      End
      Begin VB.Label Label18 
         AutoSize        =   -1  'True
         Caption         =   "Pagos Ok:"
         Height          =   195
         Left            =   90
         TabIndex        =   44
         Top             =   450
         Width           =   750
      End
      Begin VB.Label Label19 
         AutoSize        =   -1  'True
         Caption         =   "Pagos solo en Empresa:"
         Height          =   195
         Left            =   90
         TabIndex        =   43
         Top             =   705
         Width           =   1710
      End
      Begin VB.Label Label20 
         AutoSize        =   -1  'True
         Caption         =   "Total procesados Emp:"
         Height          =   195
         Left            =   90
         TabIndex        =   42
         Top             =   960
         Width           =   1635
      End
      Begin VB.Label Label21 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "       No.                   Valor       "
         ForeColor       =   &H80000008&
         Height          =   195
         Left            =   1995
         TabIndex        =   41
         Top             =   210
         Width           =   2100
      End
      Begin VB.Label lblOkEmp 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "123"
         ForeColor       =   &H80000008&
         Height          =   240
         Left            =   1995
         TabIndex        =   40
         Top             =   435
         Width           =   1005
      End
      Begin VB.Label lblOkEmpValor 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "123465789.00"
         ForeColor       =   &H80000008&
         Height          =   240
         Left            =   3015
         TabIndex        =   39
         Top             =   435
         Width           =   1215
      End
      Begin VB.Label lblSoloEmp 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "123"
         ForeColor       =   &H80000008&
         Height          =   240
         Left            =   1995
         TabIndex        =   38
         Top             =   690
         Width           =   1005
      End
      Begin VB.Label lblSoloEmpValor 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "123465789.00"
         ForeColor       =   &H80000008&
         Height          =   240
         Left            =   3015
         TabIndex        =   37
         Top             =   690
         Width           =   1215
      End
      Begin VB.Label lblProcesEmp 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "123"
         ForeColor       =   &H80000008&
         Height          =   240
         Left            =   1995
         TabIndex        =   36
         Top             =   945
         Width           =   1005
      End
      Begin VB.Label lblProcesEmpValor 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "123465789.00"
         ForeColor       =   &H80000008&
         Height          =   240
         Left            =   3015
         TabIndex        =   35
         Top             =   945
         Width           =   1215
      End
   End
   Begin VB.Frame Frame3 
      Height          =   1290
      Left            =   15
      TabIndex        =   22
      Top             =   5115
      Width           =   4335
      Begin VB.Label Label17 
         AutoSize        =   -1  'True
         Caption         =   "Total procesados Bco:"
         Height          =   195
         Left            =   90
         TabIndex        =   33
         Top             =   960
         Width           =   1605
      End
      Begin VB.Label Label16 
         AutoSize        =   -1  'True
         Caption         =   "Pagos solo en Banco:"
         Height          =   195
         Left            =   90
         TabIndex        =   32
         Top             =   705
         Width           =   1560
      End
      Begin VB.Label Label15 
         AutoSize        =   -1  'True
         Caption         =   "Pagos Ok:"
         Height          =   195
         Left            =   90
         TabIndex        =   31
         Top             =   450
         Width           =   750
      End
      Begin VB.Label lblProcesBcoValor 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "123465789.00"
         ForeColor       =   &H80000008&
         Height          =   240
         Left            =   2985
         TabIndex        =   30
         Top             =   930
         Width           =   1215
      End
      Begin VB.Label lblProcesBco 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "123"
         ForeColor       =   &H80000008&
         Height          =   240
         Left            =   1965
         TabIndex        =   29
         Top             =   930
         Width           =   1005
      End
      Begin VB.Label lblSoloBcoValor 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "123465789.00"
         ForeColor       =   &H80000008&
         Height          =   240
         Left            =   2985
         TabIndex        =   28
         Top             =   675
         Width           =   1215
      End
      Begin VB.Label lblSoloBco 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "123"
         ForeColor       =   &H80000008&
         Height          =   240
         Left            =   1965
         TabIndex        =   27
         Top             =   675
         Width           =   1005
      End
      Begin VB.Label lblOkBcoValor 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "123465789.00"
         ForeColor       =   &H80000008&
         Height          =   240
         Left            =   2985
         TabIndex        =   26
         Top             =   420
         Width           =   1215
      End
      Begin VB.Label lblOkBco 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BorderStyle     =   1  'Fixed Single
         Caption         =   "123"
         ForeColor       =   &H80000008&
         Height          =   240
         Left            =   1965
         TabIndex        =   25
         Top             =   420
         Width           =   1005
      End
      Begin VB.Label Label7 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "       No.                   Valor       "
         ForeColor       =   &H80000008&
         Height          =   195
         Left            =   1965
         TabIndex        =   24
         Top             =   210
         Width           =   2100
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         Caption         =   "Totales Banco:"
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
         Left            =   90
         TabIndex        =   23
         Top             =   150
         Width           =   1305
      End
   End
   Begin VB.Frame Frame1 
      Height          =   1665
      Left            =   15
      TabIndex        =   12
      Top             =   -30
      Width           =   8790
      Begin VB.OptionButton optProc 
         Caption         =   "Devolver"
         ForeColor       =   &H00400000&
         Height          =   195
         Index           =   2
         Left            =   6240
         TabIndex        =   48
         Top             =   1395
         Visible         =   0   'False
         Width           =   990
      End
      Begin VB.OptionButton optProc 
         Caption         =   "Habilitar"
         ForeColor       =   &H00400000&
         Height          =   195
         Index           =   0
         Left            =   4290
         TabIndex        =   9
         Top             =   1395
         Value           =   -1  'True
         Width           =   885
      End
      Begin VB.OptionButton optProc 
         Caption         =   "Reversar"
         ForeColor       =   &H00400000&
         Height          =   195
         Index           =   1
         Left            =   5220
         TabIndex        =   10
         Top             =   1395
         Width           =   990
      End
      Begin VB.ComboBox cmdEstadoBco 
         Height          =   315
         Left            =   1695
         Style           =   2  'Dropdown List
         TabIndex        =   2
         Top             =   900
         Width           =   2505
      End
      Begin VB.ComboBox cmbEstadoEmp 
         Height          =   315
         Left            =   1695
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   1260
         Width           =   2505
      End
      Begin VB.TextBox txt_empresa 
         Height          =   285
         Left            =   1680
         MaxLength       =   5
         TabIndex        =   0
         Top             =   225
         Width           =   780
      End
      Begin MSComCtl2.DTPicker dtFecha 
         Height          =   300
         Left            =   1695
         TabIndex        =   1
         Top             =   555
         Width           =   2505
         _ExtentX        =   4419
         _ExtentY        =   529
         _Version        =   393216
         CalendarForeColor=   8388608
         Format          =   16908289
         CurrentDate     =   37847
      End
      Begin Threed.SSCommand cmdBoton 
         Height          =   750
         Index           =   0
         Left            =   4275
         TabIndex        =   4
         Top             =   555
         Width           =   870
         _Version        =   65536
         _ExtentX        =   1535
         _ExtentY        =   1323
         _StockProps     =   78
         Caption         =   "&Buscar"
         ForeColor       =   4194304
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelWidth      =   1
         Outline         =   0   'False
         Picture         =   "FConcPagLine.frx":030A
      End
      Begin Threed.SSCommand cmdBoton 
         Height          =   750
         Index           =   4
         Left            =   6045
         TabIndex        =   6
         Top             =   555
         Width           =   870
         _Version        =   65536
         _ExtentX        =   1535
         _ExtentY        =   1323
         _StockProps     =   78
         Caption         =   "&Procesar"
         ForeColor       =   4194304
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelWidth      =   1
         Outline         =   0   'False
         MouseIcon       =   "FConcPagLine.frx":0BE4
         Picture         =   "FConcPagLine.frx":0C00
      End
      Begin Threed.SSCommand cmdBoton 
         Height          =   750
         Index           =   2
         Left            =   6930
         TabIndex        =   7
         Top             =   555
         Width           =   870
         _Version        =   65536
         _ExtentX        =   1535
         _ExtentY        =   1323
         _StockProps     =   78
         Caption         =   "&Limpiar"
         ForeColor       =   4194304
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelWidth      =   1
         Outline         =   0   'False
         Picture         =   "FConcPagLine.frx":14DA
      End
      Begin Threed.SSCommand cmdBoton 
         Height          =   750
         Index           =   1
         Left            =   5160
         TabIndex        =   5
         Top             =   555
         Width           =   870
         _Version        =   65536
         _ExtentX        =   1535
         _ExtentY        =   1323
         _StockProps     =   78
         Caption         =   "&Confirmar"
         ForeColor       =   4194304
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelWidth      =   1
         Outline         =   0   'False
         Picture         =   "FConcPagLine.frx":1DB4
      End
      Begin Threed.SSCommand cmdBoton 
         Height          =   750
         Index           =   3
         Left            =   7815
         TabIndex        =   8
         Top             =   555
         Width           =   870
         _Version        =   65536
         _ExtentX        =   1535
         _ExtentY        =   1323
         _StockProps     =   78
         Caption         =   "Imprimir"
         ForeColor       =   4194304
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         BevelWidth      =   1
         Outline         =   0   'False
         Picture         =   "FConcPagLine.frx":268E
      End
      Begin VB.Label Label2 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000016&
         Caption         =   "Estado Banco:"
         BeginProperty Font 
            Name            =   "Tahoma"
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
         Top             =   915
         Width           =   1170
      End
      Begin VB.Label Label1 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000016&
         Caption         =   "Fecha de Proceso:"
         BeginProperty Font 
            Name            =   "Tahoma"
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
         Top             =   585
         Width           =   1515
      End
      Begin VB.Label Label3 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000016&
         Caption         =   "Estado Empresa:"
         BeginProperty Font 
            Name            =   "Tahoma"
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
         Top             =   1275
         Width           =   1395
      End
      Begin VB.Label Label4 
         Caption         =   "Empresa:"
         BeginProperty Font 
            Name            =   "Tahoma"
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
         TabIndex        =   14
         Top             =   255
         Width           =   1245
      End
      Begin VB.Label lbl_empresa 
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Left            =   2535
         TabIndex        =   13
         Top             =   225
         Width           =   6150
      End
   End
   Begin VB.Frame Frame2 
      Height          =   3510
      Left            =   15
      TabIndex        =   18
      Top             =   1605
      Width           =   8805
      Begin MSFlexGridLib.MSFlexGrid grdAlterno 
         Height          =   735
         Left            =   3000
         TabIndex        =   47
         Top             =   1800
         Visible         =   0   'False
         Width           =   4215
         _ExtentX        =   7435
         _ExtentY        =   1296
         _Version        =   393216
      End
      Begin Crystal.CrystalReport rptreporte 
         Left            =   7665
         Top             =   2910
         _ExtentX        =   741
         _ExtentY        =   741
         _Version        =   348160
         PrintFileLinesPerPage=   60
      End
      Begin VB.CheckBox chkTodos 
         Caption         =   "MarcarTodos"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00400000&
         Height          =   195
         Left            =   90
         TabIndex        =   19
         Top             =   165
         Width           =   1605
      End
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   8100
         Top             =   2760
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483634
         ImageWidth      =   17
         ImageHeight     =   16
         MaskColor       =   16777215
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   4
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FConcPagLine.frx":2F68
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FConcPagLine.frx":32FC
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FConcPagLine.frx":3FD6
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "FConcPagLine.frx":4CB0
               Key             =   ""
            EndProperty
         EndProperty
      End
      Begin MSFlexGridLib.MSFlexGrid grdConci 
         Height          =   3030
         Left            =   75
         TabIndex        =   11
         Top             =   435
         Width           =   8685
         _ExtentX        =   15319
         _ExtentY        =   5345
         _Version        =   393216
         BackColor       =   16777215
         BackColorSel    =   12648447
         ForeColorSel    =   12582912
         BackColorBkg    =   14737632
         SelectionMode   =   1
      End
      Begin MSFlexGridLib.MSFlexGrid gridCifra 
         Height          =   1395
         Left            =   2295
         TabIndex        =   46
         Top             =   990
         Width           =   1665
         _ExtentX        =   2937
         _ExtentY        =   2461
         _Version        =   393216
      End
      Begin VB.Label Label9 
         Caption         =   "No. Reg:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   6810
         TabIndex        =   21
         Top             =   165
         Width           =   780
      End
      Begin VB.Label lbl_registros 
         Alignment       =   2  'Center
         Appearance      =   0  'Flat
         BackColor       =   &H00E0E0E0&
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H000000C0&
         Height          =   225
         Left            =   7635
         TabIndex        =   20
         Top             =   150
         Width           =   1095
      End
   End
End
Attribute VB_Name = "FConcPagLine"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'*********************************************************
' REF FECHA       AUTOR           TAREA RATIONAL     DESCRIPCION
'   1 04/sep/2017 L. Chacha      MIGMSO-AP-SGC00029050-SGC00029055 Migracion OpenOffice
'   2 14/sep/2017 M. Aldaz       MIGMSO-AP-SGC00029050-SGC00029055 Migracion OpenOffice
'   3 20/sep/2017 M. Aldaz       MIGMSO-AP-SGC00029050-SGC00029055 Migracion OpenOffice
'   4 17/abr/2018 L. Chacha      MIGMSO-AP-SGC00029050-SGC00029055 Migracion OpenOffice
'   5 29/abr/2019 D. Olaya       RRCYT-4 - RECARGAS CNT Y TUENTI
'   6 29/abr/2019 D. Olaya       RRCYT-13 - RECARGAS CNT Y TUENTI
'*************************************************************

Dim VLMatrix(12, 70) As String
Dim VLFecha As String
Dim VScierre As String
'Habilitar los CheckBox del Habilitar O Reversar.
Dim habilitar As Boolean
Dim reversar As Boolean
Dim VLValorTotal As Variant
Dim VGEmpGrupo As String   'DAPV/03222012/CNEL
Dim vlGrupo  As String     'DAPV/03222012/CNEL
Dim VLCodGrupo As String
Dim vlcantidad As String 'smerino
Dim VLTOTAL As String 'smerino
Dim VlongArch As String 'smerino
Dim VlExiste_Dep As String  'dpereirv




Private Sub chktodos_Click()
Dim i As Integer
  For i = 1 To grdConci.Rows - 1
    grdConci.Row = i
    PLSeleccionGrid grdConci, 0, chkTodos
  Next i
End Sub


Private Sub cmdBoton_Click(Index As Integer)
    '-->lfcm 20-marzo-2008
    If Index <> 2 Then
       'Validar que se ingrese un Codigo de Empresa
       If Me.txt_empresa.text = "" Then
          MsgBox "Debe ingresar un Código de Empresa", vbOKOnly + vbInformation, "TSERVI"
          Exit Sub
       End If

 

    'lfcm 31-enero-2008
    Select Case Me.txt_empresa.text
        Case "1"
        Case "2"
        Case "118", "5994" 'CONECEL TVS dpereirv 'Porta AME 10/12/2008
        Case "2494" 'IESS TC 07/02/2008
        Case "2572", "2575", "6388" 'GAMC - 06/08/2008 - CTG    --TC CNTTTSV
        'Case "1127" 'lfcm 16-abril-2009
        Case "39", "40" 'msilvag Claro Paquetes 'Claro DAPV 15/sep/2011
        Case "4994", "825", "1127", "1719", "1330", "331", "4977", "4980", "4981", "4978", "4979", "8455" 'DAPV/03212012/CNEL
        Case "940" ', "1928" 'smerino
        Case "1342", "8456", "8457" 'Broadnet Recargas
        Case Else
            If Trim(VlExiste_Dep) <> "S" Then 'dpereirv
                '-->lfcm 03-julio-2007 Obtener empresas TvCable
                PMChequea SqlConn&
                PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
                PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "W"
                PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Me.txt_empresa.text
                If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_tvcable", True, "") Then
                
                    PMMapeaVariable SqlConn&, VLTvCable$
                    PMChequea SqlConn&
                    If VLTvCable$ <> "" Then
                        VLEmpTvCable = Me.txt_empresa.text
                        PMChequea SqlConn&
                    End If
                Else
                    VLEmpTvCable = ""
                    PMChequea SqlConn&
                End If
            End If 'If Trim(VlExiste_Dep) <> "S" Then 'dpereirv
            '--<lfcm 03-julio-2007 Obtener empresas TvCable
    End Select
    'lfcm 31-enero-2008
    
    End If
    '--<lfcm 20-marzo-2008

  Select Case Index
    Case 0  'Buscar
      'Validar que el campo de Empresa tenga datos previa Consulta
      If Me.txt_empresa.text = "" Then
        MsgBox "Codigo de Empresa es Obligatorio.", vbOKOnly + vbInformation, "TServi"
        Exit Sub
      End If
      
      
      Select Case Trim(Me.txt_empresa.text)
        Case "1"  'CATEG
           PLBuscarCATEGUsuario (0)
           'FormateoCampoHora
           
        Case "2"  'ETAPA
          LimpiaResultado
          grdAlterno.Rows = 1
          grdAlterno.Cols = 1
          grdAlterno.TextMatrix(0, 0) = ""
          grdAlterno.Visible = False
          cmdBoton(1).Enabled = False
          cmdBoton(3).Enabled = True
          PLBuscarETAPA Trim(Me.txt_empresa.text)
          VLFecha = Format(dtFecha, "yyyymmdd")
          
        Case "118", "5994" 'CONECEL TVS dpereirv   'Porta ame 10/12/2009
           PLBuscarPorta (0)

        Case "2494"  'IESS TC 07/02/2008
           PLBuscarIESS (0)
           
        Case "39", "40" 'msilvag Claro Paquetes 'Claro DAPV 15/sept/2011
            PLBuscarClaro (0)
          'lfcm 06-marzo-2007 Se incluye Machala y Portoviejo
          'Case "320", "334", "336", "338", "843", "1299"           'Empresas de TVCABLE
          'Case "320", "334", "336", "338", "843", "1299", "335", "337"          'Empresas de TVCABLE
        Case "1342", "8456", "8457" 'dolayas BROADNET
            PLBuscarBroadnet (0)
          Case VLEmpTvCable
              PLBuscarTVCABLE (0)
        Case "2572", "6388" 'GAMC - 06/08/2008 - CTG
            Call PLProcesoCTG("0", 0, "", "")
        Case "2575"  ' --TC CNTTTSV
            Call PLProcesoCNTTTSV("0", 0, "", "")
       ' Case "1127"                       'lfcm 16-abril-2009
       '   PLBuscarCnel (0)
        Case "940" ', "1928" 'smerino
         PLBuscarSenae (0)
      
        Case "4994", "825", "1127", "1719", "1330", "331", "4977", "4980", "4981", "4978", "4979", "8455"
              If Trim(Me.txt_empresa.text) = "1127" And Trim(VLCodGrupo) = "" Then
                PLBuscarCATEGUsuario (0)      'lfcm 16-abril-2009
              Else
                PLBuscarCnel (0)
              End If
      End Select
     
      If Trim(VlExiste_Dep) = "S" Then 'dpereirv
        PLBuscarSenae (0)
      End If
    
    Case 1  'Confirmar
      Select Case txt_empresa.text
        Case "2" 'ETAPA
          If MsgBox("Desea confirmar la conciliación", vbInformation + vbOKCancel, "Conciliación ETAPA") = vbOK Then
            PLConciliaETAPA
          End If
        
        'lfcm 06-marzo-2007 Se incluye Machala y Portoviejo
        'Case "320", "334", "336", "338", "843", "1299"   'Empresas del Grupo TVCABLE
        'Case "320", "334", "336", "338", "843", "1299", "335", "337"   'Empresas del Grupo TVCABLE
        Case VLEmpTvCable
            PLConfirmaTvCable
            'PLGeneraArchivoAjuste
        
        Case 1
            'lfcm Validar que se encuentre los Estados sean "TODOS"
            If cmdEstadoBco.text <> "TODOS" Then
                MsgBox "Los estados de Banco y Empresa debe indicar: TODOS", vbInformation + vbOKCancel, "TSERVI"
                Exit Sub
            End If
            
            If cmbEstadoEmp.text <> "TODOS" Then
                MsgBox "Los estados de Banco y Empresa debe indicar: TODOS", vbInformation + vbOKCancel, "TSERVI"
                Exit Sub
            End If
            
           'lfcm 26-feb-2008 Confirmacion de Concialicion CATEG
            PLConfirmaCATEG          'Confirmacion de Concialicion CATEG
        ' ***** TC proceso confirma IESS
        Case 2494
            If cmdEstadoBco.text <> "TODOS" Then
                MsgBox "Los estados de Banco y Empresa debe indicar: TODOS", vbInformation + vbOKCancel, "TSERVI"
                Exit Sub
            End If
            
            If cmbEstadoEmp.text <> "TODOS" Then
                MsgBox "Los estados de Banco y Empresa debe indicar: TODOS", vbInformation + vbOKCancel, "TSERVI"
                Exit Sub
            End If
            
            PLConfirmaIESS          'Confirmacion de Concialicion CATEG
         Case 2572, 6388 'GAMC - 08/08/2008 - CTG    --TC CNTTTSV
            If cmdEstadoBco.text <> "TODOS" Then
                MsgBox "Los estados de Banco y Empresa debe indicar: TODOS", vbInformation + vbOKCancel, "TSERVI"
                Exit Sub
            End If
            
            If cmbEstadoEmp.text <> "TODOS" Then
                MsgBox "Los estados de Banco y Empresa debe indicar: TODOS", vbInformation + vbOKCancel, "TSERVI"
                Exit Sub
            End If
            
            Call PLProcesoCTG("2", 0, "", "") 'Confirmacion de Concialicion CTG
        '*********************** fin tc
         Case 2575  '  --TC CNTTTSV
            If cmdEstadoBco.text <> "TODOS" Then
                MsgBox "Los estados de Banco y Empresa debe indicar: TODOS", vbInformation + vbOKCancel, "TSERVI"
                Exit Sub
            End If
            
            If cmbEstadoEmp.text <> "TODOS" Then
                MsgBox "Los estados de Banco y Empresa debe indicar: TODOS", vbInformation + vbOKCancel, "TSERVI"
                Exit Sub
            End If
            
            Call PLProcesoCNTTTSV("2", 0, "", "") 'Confirmacion de Concialicion CNTTTSV
        
         '-->EMELGUR 16-abril-2009
'         Case 1127
'             'Validar que se encuentre los Estados sean "TODOS"
'            If cmdEstadoBco.Text <> "TODOS" Then
'                MsgBox "Los estados de Banco y Empresa debe indicar: TODOS", vbInformation + vbOKCancel, "TSERVI"
'                Exit Sub
'            End If
'            If cmbEstadoEmp.Text <> "TODOS" Then
'                MsgBox "Los estados de Banco y Empresa debe indicar: TODOS", vbInformation + vbOKCancel, "TSERVI"
'                Exit Sub
'            End If
'           'Confirmacion de Concialicion CATEG
'            PLConfirmaEMELGUR          'Confirmacion de Concialicion CATEG
            
         '--<EMELGUR 16-abril-2009
         Case 118, "5994" 'CONECEL TVS dpereirv
            If cmdEstadoBco.text <> "TODOS" Then
                MsgBox "Los estados de Banco y Empresa debe indicar: TODOS", vbInformation + vbOKCancel, "TSERVI"
               Exit Sub
            End If

            If cmbEstadoEmp.text <> "TODOS" Then
                MsgBox "Los estados de Banco y Empresa debe indicar: TODOS", vbInformation + vbOKCancel, "TSERVI"
                Exit Sub
            End If

            PLConfirmaPorta          'Confirmacion de Concialicion Porta

        Case 39, 40 'msilvag Claro Paquetes 'Claro DAPV
            If cmdEstadoBco.text <> "TODOS" Then
                MsgBox "Los estados de Banco y Empresa debe indicar: TODOS", vbInformation + vbOKCancel, "TSERVI"
               Exit Sub
            End If

            If cmbEstadoEmp.text <> "TODOS" Then
                MsgBox "Los estados de Banco y Empresa debe indicar: TODOS", vbInformation + vbOKCancel, "TSERVI"
                Exit Sub
            End If
            
            PLConfirmaClaro
        
        Case 1342, 8456, 8457
            If cmdEstadoBco.text <> "TODOS" Then
                MsgBox "Los estados de Banco y Empresa debe indicar: TODOS", vbInformation + vbOKCancel, "TSERVI"
               Exit Sub
            End If

            If cmbEstadoEmp.text <> "TODOS" Then
                MsgBox "Los estados de Banco y Empresa debe indicar: TODOS", vbInformation + vbOKCancel, "TSERVI"
                Exit Sub
            End If
            
            PLConfirmaBroadnet
        
        Case "940" ', "1928"  'smerino validar que se encuentre los estados
         If cmdEstadoBco.text <> "TODOS" Then
                MsgBox "Los estados de Banco y Empresa debe indicar: TODOS", vbInformation + vbOKCancel, "TSERVI"
               Exit Sub
            End If

            If cmbEstadoEmp.text <> "TODOS" Then
                MsgBox "Los estados de Banco y Empresa debe indicar: TODOS", vbInformation + vbOKCancel, "TSERVI"
                Exit Sub
            End If
              'Confirmacion de Concialicion senae
                 PLConfirmaSenae    'Confirmacion de Concialicion SENAE
        'fin smerino
        
        Case "4994", "825", "1127", "1719", "1330", "331", "4977", "4980", "4981", "4978", "4979", "8455" 'DAPV/03212012/CNEL
            If Trim(Me.txt_empresa.text) = "1127" And Trim(VLCodGrupo) = "" Then
               'Validar que se encuentre los Estados sean "TODOS"
                 If cmdEstadoBco.text <> "TODOS" Then
                     MsgBox "Los estados de Banco y Empresa debe indicar: TODOS", vbInformation + vbOKCancel, "TSERVI"
                     Exit Sub
                 End If
                 If cmbEstadoEmp.text <> "TODOS" Then
                     MsgBox "Los estados de Banco y Empresa debe indicar: TODOS", vbInformation + vbOKCancel, "TSERVI"
                     Exit Sub
                 End If
                'Confirmacion de Concialicion CATEG
                   PLConfirmaEMELGUR          'Confirmacion de Concialicion CATEG
            Else
                If cmdEstadoBco.text <> "TODOS" Then
                    MsgBox "Los estados de Banco y Empresa debe indicar: TODOS", vbInformation + vbOKCancel, "TSERVI"
                   Exit Sub
                End If
    
                If cmbEstadoEmp.text <> "TODOS" Then
                    MsgBox "Los estados de Banco y Empresa debe indicar: TODOS", vbInformation + vbOKCancel, "TSERVI"
                    Exit Sub
                End If
                PLConfirmaCNEL
            End If
      End Select
    
    If Trim(VlExiste_Dep) = "S" Then 'dpereirv
        If cmdEstadoBco.text <> "TODOS" Then
            MsgBox "Los estados de Banco y Empresa debe indicar: TODOS", vbInformation + vbOKCancel, "TSERVI"
            Exit Sub
        End If

        If cmbEstadoEmp.text <> "TODOS" Then
            MsgBox "Los estados de Banco y Empresa debe indicar: TODOS", vbInformation + vbOKCancel, "TSERVI"
            Exit Sub
        End If
              
        PLConfirmaSenae
      End If
    
    Case 2  'Limpiar
        'PLLimpiar
      Select Case Me.txt_empresa
        Case Is = "2"
            PLLimpiar
        Case Else
            PLLimpiar
            Me.chkTodos.Value = False
     End Select
    
    
    Case 3  'Imprimir
      Select Case txt_empresa.text
        Case "1"  'CATEG
          'PLExportaExcelCATEG
          'INICIO (SIPECOM) LCHACHA OOF REF001
          'PLExportaExcelCATEG
          If validaOffice("OpenOffice") Then
              PLExportaExcelCATEGOOF
          Else
              PLExportaExcelCATEG
          End If
          'FIN (SIPECOM) LCHACHA OOF REF001
          
          
        Case "2"  'ETAPA
          PLImprimirETAPA
          'INICIO (SIPECOM) LCHACHA OOF REF001
          'PLExportaExcelEtapa
          If validaOffice("OpenOffice") Then
              PLExportaExcelEtapaOOF
          Else
              PLExportaExcelEtapa
          End If
          'FIN (SIPECOM) LCHACHA OOF REF001

          
          
        'lfcm 06-marzo-2007 Se incluye Machala y Portoviejo
        'Case "320", "334", "336", "338", "843", "1299"               'Empresas de TVCABLE
        'Case "320", "334", "336", "338", "843", "1299", "335", "337"               'Empresas de TVCABLE
        
        Case VLEmpTvCable
          cmdBoton(3).Enabled = True
          'INICIO (SIPECOM) LCHACHA OOF REF001
          'PLExportaExcelTVCABLE
          If validaOffice("OpenOffice") Then
            PLExportaExcelTVCABLEOOF
          Else
            PLExportaExcelTVCABLE
          End If
          'FIN (SIPECOM) LCHACHA OOF REF001
          
        Case "2494"  ' TC IESS 07/07/2008
          'INICIO (SIPECOM) LCHACHA OOF REF001
          'PLExportaExcelIESS
          If validaOffice("OpenOffice") Then
              PLExportaExcelIESSOOF
          Else
              PLExportaExcelIESS
          End If
          'FIN (SIPECOM) LCHACHA OOF REF001

        
        Case "2572", "6388" 'GAMC - 08/08/2008 - CTG
          Call PLProcesoCTG("3", 0, "", "")
          
        Case "2575" ' --TC CNTTTSV
          Call PLProcesoCNTTTSV("3", 0, "", "")
          
'        Case "1127"
'             PLExportaExcelCATEG
            
        Case "118", "5994" 'CONECEL TVS dpereirv  ' Porta 10/23/2008
          'INICIO (SIPECOM) MALDAZ OOF REF002
          If validaOffice("OpenOffice") Then
              PLExportaExcelPortaOOF
          Else
              PLExportaExcelPorta
          End If
          'FIN (SIPECOM) MALDAZ OOF REF002
          
        Case "39", "40"  'msilvag Claro Paquetes 'Claro DAPV 09/21/2011
           
          If validaOffice("OpenOffice") Then
              PLExportaExcelClaroOOF
          Else
              PLExportaExcelClaro
          End If
          
        Case "1342", "8456", "8457" 'Ref 05
           
          If validaOffice("OpenOffice") Then
              PLExportaExcelBroadnetOOF
          Else
              PLExportaExcelBroadnet
          End If
           
        Case "940" ', "1928" 'senae smerino
          'INICIO (SIPECOM) MALDAZ OOF REF003
        
          If validaOffice("OpenOffice") Then
              PLExportaExcelSenaeOOF
          Else
              PLExportaExcelSenae
          End If
          
          'FIN (SIPECOM) MALDAZ OOF REF003
          
        
        Case "4994", "825", "1127", "1719", "1330", "331", "4977", "4980", "4981", "4978", "4979", "8455" 'DAPV/03212012/CNEL
            If txt_empresa.text = "1127" And Trim(VLCodGrupo) = "" Then
               PLExportaExcelCATEG
               'INICIO (SIPECOM) MALDAZ OOF REF002
                If validaOffice("OpenOffice") Then
                    PLExportaExcelCATEGOOF
                Else
                    PLExportaExcelCATEG
                End If
               'FIN (SIPECOM) MALDAZ OOF REF002
            Else
              'INICIO (SIPECOM) MALDAZ OOF REF002
                If validaOffice("OpenOffice") Then
                    PLExportaExcelCNELOOF
                Else
                    PLExportaExcelCNEL
                End If
               'FIN (SIPECOM) MALDAZ OOF REF002
            End If
      End Select
      
    If Trim(VlExiste_Dep) = "S" Then 'dpereirv
       PLExportaExcelSenae
    End If
      
    Case 4  'Procesar
      Select Case txt_empresa.text
        Case "2"  'ETAPA
                        'msilvag Inicio
            Me.FLProcesarEtapa
'          If Format(dtFecha, "yyyymmdd") = VLFecha Then
'            PLProcesoWServiceETAPA
'          Else
'            MsgBox "Fecha Proceso no es igual a lo consultado", vbExclamation, "Conciliación ETAPA"
'          End If
                  'msilvag fin
        'lfcm 06-marzo-2007 Se incluye Machala y Portoviejo
        'Case "320", "334", "336", "338", "843", "1299"                   'Empresas de TVCABLE
        'Case "320", "334", "336", "338", "843", "1299", "335", "337"                  'Empresas de TVCABLE
        
        '**** TC llama proceso de ajuste IESS
        Case "2494"
            PLProcesarIESS
        
        Case "2572", "6388" 'TC CNTTTSV
            Call PLProcesoCTG("1", 0, "", "")
        
        Case "2575" 'TC CNTTTSV
            Call PLProcesoCNTTTSV("1", 0, "", "")
            
        Case VLEmpTvCable
            PLProcesarTVCABLE
        Case "118", "5994" 'CONECEL TVS dpereirv
            PLProcesarPorta
            
        Case "39", "40"  'msilvag Claro Paquetes 'Claro DAPV
            PLProcesarClaro
            
        Case "1342", "8456", "8457" 'RECARGAS BROADNET
            PLProcesarBroadnet
            
        Case "4994", "825", "1127", "1719", "1330", "331", "4977", "4980", "4981", "4978", "4979", "8455" 'DAPV/03212012/CNEL
            FLProcesarCnel
       
       End Select
      
  End Select
End Sub

Private Sub cmdEstadoBco_Click()
'    Valida_FormaPago 'DAPV

End Sub


Private Sub Form_Load()
    
    'Seteo las dimensiones de las formas
    DimensionesForma
    Setear_Controles 'DAPV
    
    'Cargo por default la fecha del dia
    dtFecha.Value = Date
    
    'Carga los valores de los Combos Estados Banco y Banred
    Me.cmdEstadoBco.AddItem "TODOS"
    Me.cmdEstadoBco.AddItem "SI"
    Me.cmdEstadoBco.AddItem "NO"
    
    Me.cmbEstadoEmp.AddItem "TODOS"
    Me.cmbEstadoEmp.AddItem "SI"
    Me.cmbEstadoEmp.AddItem "NO"
        
    Me.cmdEstadoBco.ListIndex = 0    'TODOS
    Me.cmbEstadoEmp.ListIndex = 0    'TODOS
    
    LimpiaResultado  'ANBE
    
    habilitar = False
    reversar = False

End Sub
Private Sub Setear_Controles() 'DAPV
    optProc(1).Caption = "Reversar"
    optProc(2).Visible = False
    optProc(0).Value = True
'    Frame1.Height = "1605"
'    Frame2.Top = "1605"
'    Frame3.Top = "5115"
'    Frame4.Top = "5115"
    'Label8.Visible = False
End Sub

Sub DimensionesForma()
'Dimensiones de la forma
    Me.Top = 15
    Me.Left = 15
    Me.Height = 6960
    Me.Width = 8970
    
End Sub

Private Sub grdConci_DblClick()
  PLSeleccionGrid grdConci, 0
End Sub

Private Sub PLSeleccionGrid(Grid As Object, ColIcon As Integer, Optional ChkBox_Todos As Object)
'ANBE para manejo del visto del grid con chkbox de todos
Dim iCol As Integer
Dim iRow As Integer
Dim iTip As Integer
Dim iPic As Integer

iCol = ColIcon 'Para la columna de marca
iPic = 2 'Para index de icon
Grid.Col = iCol

If ChkBox_Todos Is Nothing Then
  If Grid.CellPicture <> ImageList1.ListImages(iPic).Picture Then
    With Grid
      iRow = .RowSel
      .Row = iRow
      .Col = iCol
      .CellForeColor = vbBlue
      .CellAlignment = 6
      Set .CellPicture = ImageList1.ListImages(iPic).Picture
    End With
  Else
    With Grid
      .Col = iCol
      .CellForeColor = &H800000   ' vbBlack
      .CellAlignment = 1
      Set .CellPicture = Nothing
    End With
  End If
Else
  With ChkBox_Todos
    If .Value Then
    With Grid
      iRow = .RowSel
      .Row = iRow
      .Col = iCol
      .CellForeColor = vbBlue
      .CellAlignment = 6
      Set .CellPicture = ImageList1.ListImages(iPic).Picture
    End With
    Else
      With Grid
        .Col = iCol
        .CellForeColor = &H800000    'vbBlack
        .CellAlignment = 1
        Set .CellPicture = Nothing
      End With
    End If
  End With
End If
End Sub

Private Sub txt_empresa_GotFocus()
    'Seteo el mensaje a ver en el Panel
    FPrincipal!pnlHelpLine.Caption = " Código de la Empresa [F5 Ayuda]"
End Sub

Private Sub txt_empresa_KeyDown(KeyCode As Integer, Shift As Integer)
    'F5 - para buscar
    If KeyCode% = VGTeclaAyuda% Then
        VLTabla$ = "cc_empresa_rec_online"   'Catalogo de Empresas de Recaudacion en Linea
        PMPasoValores SqlConn&, "@i_tabla", 0, SQLCHAR, VLTabla$
        PMPasoValores SqlConn&, "@i_tipo", 0, SQLCHAR, "A"
        If FMTransmitirRPC(SqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txt_empresa.text & "]") Then
            VLPaso% = True
            
            PMMapeaListaH SqlConn&, FCatalogo!lstCatalogo, False
             
            PMChequea SqlConn&
            FCatalogo.Show 1
            txt_empresa.text = VGACatalogo.codigo$
            lbl_empresa.Caption = VGACatalogo.Descripcion$
            Valida_Objetos '-DAPV
            If Trim$(txt_empresa.text) = "" Then
                lbl_empresa.Caption = ""
                txt_empresa.SetFocus
            End If
        End If
    End If
End Sub
Private Sub Valida_Objetos() '-DAPV
    Setear_Controles
    'DimensionesForma
'    Height = 6960
    
    Select Case Trim(txt_empresa.text)
    Case 39, 40 ', 1342, 8456, 8457 'msilvag Claro Paquetes 'Claro 'Recargas Broadnet ref006
        optProc(1).Caption = "Revisar"
        optProc(2).Visible = True
        optProc(1).Value = True
'        Frame1.Height = "2025"
'        Frame2.Top = "1965"
'        Frame3.Top = "5475"
'        Frame4.Top = "5475"
        'Label8.Visible = True
'        Height = "7180"
    End Select
End Sub
Private Sub txt_empresa_KeyPress(KeyAscii As Integer)
    'Valido que solo se permita el ingreso de datos numericos al campo de empresa
    KeyAscii% = FMValidaTipoDato("N", KeyAscii%)
End Sub

Private Sub txt_empresa_LostFocus()
Dim TpArreglo() As String

  'Valido que el campo empresa tenga un valor previa consulta a catalogo
  If Me.txt_empresa.text = "" And Me.lbl_empresa.Caption <> "" Then
    Me.lbl_empresa.Caption = ""
    Exit Sub
  End If
  
  If Me.txt_empresa.text = "" Then
    Exit Sub
  End If
  
  VLTabla$ = "cc_empresa_rec_online"
  PMPasoValores SqlConn&, "@i_tabla", 0, SQLCHAR, VLTabla$
  PMPasoValores SqlConn&, "@i_tipo", 0, SQLCHAR, "V"
  PMPasoValores SqlConn&, "@i_codigo", 0, SQLVARCHAR, (txt_empresa.text)
  If FMTransmitirRPC(SqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txt_empresa.text & "]") Then
    PMMapeaObjeto SqlConn&, lbl_empresa
    PMChequea SqlConn&
    VLPaso% = True
    Valida_Objetos '-DAPV
  Else
    lbl_empresa.Caption = ""
    txt_empresa.text = ""
  End If
  
  PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4%, "43292"
  PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT4%, Trim(txt_empresa.text)
  If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_empresas_domicilia", True, " Consulta de la oficina " & "[" & txt_empresa.text & "]") Then
          ReDim TpArreglo(10)
          FMMapeaArreglo SqlConn&, TpArreglo()
          VLCodReg = TpArreglo(4)
          VLCodGrupo = TpArreglo(5)
          PMChequea SqlConn&
      Else
          VLdbtarj = ""
          VLCodReg = ""
          VLCodGrupo = ""
          VLEnLinea = ""
          PMChequea SqlConn&
      End If

  VlExiste_Dep = ""  'dpereirv
  Call ValidaEmpresaDepositoTemporal  'dpereirv
  
  Select Case txt_empresa.text
    Case "1"    'CATEG                                                    'lfcm 28-feb-2008
        optProc(0).Enabled = False: optProc(1).Enabled = False            'lfcm 28-feb-2008
    Case "2"    'ETAPA
                'msilvag Inicio
        optProc(0).Enabled = True: optProc(1).Enabled = True
        Label2.Enabled = True: Label3.Enabled = True
        cmdEstadoBco.Enabled = True: cmbEstadoEmp.Enabled = True
        cmdBoton(1).Enabled = True: cmdBoton(4).Enabled = True
                'msilvag Fin
    'lfcm 06-marzo-2007 Se incluye Machala y Portoviejo
    'Case "320", "334", "336", "338", "843"   'Empresas del Grupo TVCABLE
    Case "320", "334", "336", "338", "843", "1299", "335", "337"  'Empresas del Grupo TVCABLE
        optProc(0).Enabled = True: optProc(1).Enabled = True
        Label2.Enabled = True: Label3.Enabled = True
        cmdEstadoBco.Enabled = True: cmbEstadoEmp.Enabled = True
        cmdBoton(1).Enabled = True: cmdBoton(4).Enabled = True: cmdBoton(3).Enabled = True
    Case "2494"    'IESS                                                    'TC 07/07/2008
        cmdBoton(1).Enabled = False: cmdBoton(4).Enabled = False            'TC 07/07/2008
    Case "940" ', "1928"    'senae                                                   'TC 07/07/2008
        cmdBoton(1).Enabled = True: cmdBoton(4).Enabled = True
        optProc(0).Enabled = False: optProc(1).Enabled = False
    Case "2572", "2575", "6388" 'GAMC - CTG - 08/08/2008 --TC CNTTTSV
        cmdBoton(1).Enabled = False: cmdBoton(4).Enabled = False
     Case "4994", "825", "1127", "1719", "1330", "331", "4977", "4980", "4981", "4978", "4979", "8455" 'DAPV/03212012/CNEL
        If Trim(Me.txt_empresa.text) = "1127" And Trim(VLCodGrupo) = "" Then
          cmdBoton(1).Enabled = True: cmdBoton(4).Enabled = True
        Else
          cmdBoton(1).Enabled = False: cmdBoton(4).Enabled = False
        End If
  End Select
  
  If Trim(VlExiste_Dep) = "S" Then   'dpereirv
    cmdBoton(1).Enabled = True: cmdBoton(4).Enabled = True
    optProc(0).Enabled = False: optProc(1).Enabled = False
  End If
  
  'ANBE para ETAPA
  'If Trim(txt_empresa.Text) = "2" Then
  '  optProc(0).Enabled = False: optProc(1).Enabled = False
  '  Label2.Enabled = False: Label3.Enabled = False
  '  cmdEstadoBco.Enabled = False: cmbEstadoEmp.Enabled = False
  '  cmdBoton(1).Enabled = False: cmdBoton(4).Enabled = False
  'Else
  '  optProc(0).Enabled = True: optProc(1).Enabled = True
  '  Label2.Enabled = True: Label3.Enabled = True
  '  cmdEstadoBco.Enabled = True: cmbEstadoEmp.Enabled = True
  'End If
End Sub

Private Sub PLBuscarETAPA(Empresa As String, Optional NextRow As String)
'ANBE Busca data de ETAPA
Dim i, c As Integer
Dim Cant As Integer
Dim ArrWidth() As String
Dim SigRow As String

  PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
  PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "C"
  PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text)
  PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, IIf(Trim(NextRow) = "", "0", Trim(NextRow))
  PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
  PMPasoValores SqlConn&, "@i_status_bco", 0, SQLVARCHAR, Me.cmdEstadoBco.text 'msilvag Etapa
  PMPasoValores SqlConn&, "@i_status_emp", 0, SQLVARCHAR, Me.cmbEstadoEmp.text 'msilvag Etapa
  If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_pago_etapa", True, "Ok... Consulta de Pagos ETAPA") Then
    If Trim(NextRow) = "" Then
      PgMapeaFlexG grdConci, True, False, 0, 10, 23
    Else
      PgMapeaFlexG grdConci, False, False, 0, 10, 23
    End If
    PMChequea SqlConn&
    If grdConci.Tag = 10 Then
      grdConci.Row = grdConci.Rows - 1
      grdConci.Col = 22
      SigRow = grdConci.text
                        PLBuscarETAPA Trim(txt_empresa.text), SigRow
    Else
      Me.lbl_registros.Caption = (Me.grdConci.Rows - 1)
      NextRow = ""
      VLPaso% = True
      ArrWidth = Split("700,1100,1100,4000,1400,1500,1100,1300,1100,1100,1300,1100,1100,1100,0,0,0,0,0,0,0,0,0", ",") 'msilvag cnb fase 2 Junio/23/2016
      For c = 0 To (grdConci.Cols - 1)
        grdConci.Col = c
        grdConci.ColWidth(c) = ArrWidth(c)
      Next c
      Cant = 0
      For i = 1 To (grdConci.Rows - 1)
        If grdConci.TextMatrix(i, 17) = "S" Then grdConci.TextMatrix(i, 8) = "NO"
        If grdConci.TextMatrix(i, 17) = "N" Then grdConci.TextMatrix(i, 8) = "SI"
        If IsDate(grdConci.TextMatrix(i, 19)) Then Cant = Cant + 1 'msilvag cnb fase 2 Junio/23/2016
      Next i
      If Cant > 0 Then
        PLCantidadesETAPA
        'msilvag Inicio
        cmdBoton(1).Enabled = True: cmdBoton(4).Enabled = True
        'MsgBox "Fecha ya conciliada", vbInformation, "Conciliación ETAPA"
        Me.optProc(0).Enabled = True
        Me.optProc(1).Enabled = True
        Me.optProc(2).Enabled = True
        'msilvag Fin
      Else
        cmdBoton(3).Enabled = False
        cmdBoton(1).Enabled = False: cmdBoton(4).Enabled = True
      End If
    End If
  Else
    PMLimpiaGrid Me.grdConci
    LimpiaResultado
  End If
End Sub

Private Sub PLConciliaETAPA()
Dim i As Integer
Dim listo As Boolean

        'msilvag Inicio
    Respuesta = MsgBox("Desea Cerrar la Conciliacion", vbInformation + vbOKCancel, "TServi")
    If Respuesta = vbCancel Then
        Exit Sub
    End If
    'Confimacion de Activacion de Casilla: Marcar Todos
    If Me.chkTodos.Value = False Then
        MsgBox "Seleccione la Casilla: Marcar Todos", vbInformation + vbOKOnly, "TServi"
        Exit Sub
    End If
    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, "3791"
    PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "X"
    PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text)
    PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, 0
    PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
    PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, ""

    PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, ""
    PMPasoValores SqlConn&, "@o_existe", 1, SQLCHAR, Space(1)

    If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_pago_etapa", True, "Búsqueda de Datos") Then
        PMChequea SqlConn&
        MsgBox "La conciliacion se ha cerrado.", vbOKOnly + vbInformation, "TServi"
        Me.PLBuscarETAPAFile (0)
        Me.PLGeneraArchivoETAPA

    Else
        PMChequea SqlConn&
        Me.PLBuscarETAPAFile (0)
        Me.PLGeneraArchivoETAPA

    End If
  
    PLBuscarETAPA Trim(Me.txt_empresa.text)
    
    Me.chkTodos.Value = False
    If Me.grdConci.Rows > 1 Then Me.grdConci.topRow = 1
    If Me.grdConci.Rows > 1 Then Me.grdConci.LeftCol = 1
    
'  cmdBoton(3).Enabled = True
'  listo = True
'  For I = 1 To grdConci.Rows - 1
'    If Trim(grdConci.TextMatrix(I, 18)) = "" Then  'Verifico si esta pasado
'      grdConci.Row = I
'      PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
'      PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "U"
'      PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.Text)
'      PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
'      PMPasoValores SqlConn&, "@i_correctivo", 0, SQLVARCHAR, Trim(grdConci.TextMatrix(I, 7))
'      PMPasoValores SqlConn&, "@i_status_bco", 0, SQLVARCHAR, Trim(grdConci.TextMatrix(I, 8))
'      PMPasoValores SqlConn&, "@i_status_emp", 0, SQLVARCHAR, Trim(grdConci.TextMatrix(I, 9))
'      PMPasoValores SqlConn&, "@i_secuencial", 0, SQLINT4, Trim(grdConci.TextMatrix(I, 21))
'      PMPasoValores SqlConn&, "@i_serv_emp", 0, SQLVARCHAR, Trim(grdConci.TextMatrix(I, 15))
'      If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_pago_etapa", True, "Ok... Consulta de Pagos ETAPA") Then
'        PMChequea SqlConn&
'        grdConci.TextMatrix(I, 18) = "LISTO"
'      Else
'        cmdBoton(3).Enabled = False
'        listo = False
'        Exit For
'      End If
'    End If
'  Next I
'  If listo Then
'    cmdBoton(3).Enabled = True
'    cmdBoton(1).Enabled = False: cmdBoton(4).Enabled = False
'  End If
'msilvag Fin
End Sub

Private Sub PLProcesoWServiceETAPA()
  'ANBE WebService ETAPA
  Dim SoapEnte As New MSSOAPLib30.SoapClient30
  Dim vtdocxml  As New MSXML.DOMDocument
  Dim vthijo    As Object
  Dim vthijo2    As Object
  Dim padreXml  As Object
  Dim i, k, c As Integer
  Dim CanOk As Integer
  Dim ValOk As Double
  Dim CanBc As Integer
  Dim CanEp As Integer
  Dim ValBc As Double
  Dim ValEp As Double
  Dim TramaXml As String
  Dim carpeta As String
  Dim Nivel As Integer
  Dim Vlxml() As String  'Para crear el xml
  Dim Vlrow() As String  'Para crear el row
  Dim Convertidor As String
  Dim Cadena1 As String
  Dim Cadena2 As String
  Dim Empresa As String
  Dim Sschema As String
  Dim Link As String
  Dim CantRow As Integer
  Dim CodAgua As String
  
''  Lo comentado esta para armar una string de estructura xml
''  'Sschema = "<?xml version=" & Chr(34) & "1.0" & Chr(34) & " encoding=" & Chr(34) & "utf-8" & Chr(34) & "?><DataSet xmlns=" & Chr(34) & "http://tempuri.org/srvPagoOnline/Service1" & Chr(34) & ">"
''  Sschema = "<DataSet xmlns=" & Chr(34) & "http://tempuri.org/srvPagoOnline/Service1" & Chr(34) & ">"
''  Sschema = Sschema & "<xs:schema id=" & Chr(34) & "NewDataSet" & Chr(34) & " xmlns=" & Chr(34) & "" & Chr(34) & " xmlns:xs=" & Chr(34) & "http://www.w3.org/2001/XMLSchema" & Chr(34) & " xmlns:msdata=" & Chr(34) & "urn:schemas-microsoft-com:xml-msdata" & Chr(34) & ">"
''  Sschema = Sschema & "<xs:element name=" & Chr(34) & "NewDataSet" & Chr(34) & " msdata:IsDataSet=" & Chr(34) & "true" & Chr(34) & " msdata:Locale=" & Chr(34) & "es-ES" & Chr(34) & ">"
''  Sschema = Sschema & "<xs:complexType><xs:choice maxOccurs=" & Chr(34) & "unbounded" & Chr(34) & "><xs:element name=" & Chr(34) & "Table" & Chr(34) & "><xs:complexType><xs:sequence>"
''  Sschema = Sschema & "<xs:element name=" & Chr(34) & "BANCO" & Chr(34) & " type=" & Chr(34) & "xs:decimal" & Chr(34) & " minOccurs=" & Chr(34) & "0" & Chr(34) & "/>"
''  Sschema = Sschema & "<xs:element name=" & Chr(34) & "NUMEROTRANSACCION" & Chr(34) & " type=" & Chr(34) & "xs:decimal" & Chr(34) & " minOccurs=" & Chr(34) & "0" & Chr(34) & "/>"
''  Sschema = Sschema & "<xs:element name=" & Chr(34) & "NUMERODECUENTA" & Chr(34) & " type=" & Chr(34) & "xs:decimal" & Chr(34) & " minOccurs=" & Chr(34) & "0" & Chr(34) & "/>"
''  Sschema = Sschema & "<xs:element name=" & Chr(34) & "TIPOCUENTA" & Chr(34) & " type=" & Chr(34) & "xs:string" & Chr(34) & " minOccurs=" & Chr(34) & "0" & Chr(34) & "/>"
''  Sschema = Sschema & "<xs:element name=" & Chr(34) & "TELEFONO" & Chr(34) & " type=" & Chr(34) & "xs:decimal" & Chr(34) & " minOccurs=" & Chr(34) & "0" & Chr(34) & "/>"
''  Sschema = Sschema & "<xs:element name=" & Chr(34) & "SECTOR" & Chr(34) & " type=" & Chr(34) & "xs:decimal" & Chr(34) & " minOccurs=" & Chr(34) & "0" & Chr(34) & "/>"
''  Sschema = Sschema & "<xs:element name=" & Chr(34) & "SUBSECTOR" & Chr(34) & " type=" & Chr(34) & "xs:decimal" & Chr(34) & " minOccurs=" & Chr(34) & "0" & Chr(34) & "/>"
''  Sschema = Sschema & "<xs:element name=" & Chr(34) & "LECTURA" & Chr(34) & " type=" & Chr(34) & "xs:decimal" & Chr(34) & " minOccurs=" & Chr(34) & "0" & Chr(34) & "/>"
''  Sschema = Sschema & "<xs:element name=" & Chr(34) & "MONTO" & Chr(34) & " type=" & Chr(34) & "xs:decimal" & Chr(34) & " minOccurs=" & Chr(34) & "0" & Chr(34) & "/>"
''  Sschema = Sschema & "<xs:element name=" & Chr(34) & "AGENCIA" & Chr(34) & " type=" & Chr(34) & "xs:decimal" & Chr(34) & " minOccurs=" & Chr(34) & "0" & Chr(34) & "/>"
''  Sschema = Sschema & "<xs:element name=" & Chr(34) & "CAJERO" & Chr(34) & " type=" & Chr(34) & "xs:decimal" & Chr(34) & " minOccurs=" & Chr(34) & "0" & Chr(34) & "/>"
''  Sschema = Sschema & "<xs:element name=" & Chr(34) & "DIRECCIONCLIENTE" & Chr(34) & " type=" & Chr(34) & "xs:string" & Chr(34) & " minOccurs=" & Chr(34) & "0" & Chr(34) & "/>"
''  Sschema = Sschema & "</xs:sequence></xs:complexType></xs:element></xs:choice></xs:complexType></xs:element></xs:schema>"
''  Sschema = Sschema & "<diffgr:diffgram xmlns:msdata=" & Chr(34) & "urn:schemas-microsoft-com:xml-msdata" & Chr(34) & " xmlns:diffgr=" & Chr(34) & "urn:schemas-microsoft-com:xml-diffgram-v1" & Chr(34) & ">"
''
''  'Dim VlMatrix(12, 50) As String  'string,
''  Vlxml = Split("NewDataSet,Table,BANCO,NUMEROTRANSACCION,NUMERODECUENTA,TIPOCUENTA,TELEFONO,SECTOR,SUBSECTOR,LECTURA,MONTO,AGENCIA,CAJERO,DIRECCIONCLIENTE", ",")
''  Convertidor = "<%1>%2</%3>"
''  Cadena1 = ""
''  'Text1.Text = ""
''  Nivel = 1  ' xmlns=''  'diffgr:id='Table1' msdata:rowOrder='0'
''  For i = 0 To (Nivel - 1)
''    If i > 0 Then
''      Cadena1 = Replace(Cadena1, "%2", Convertidor)
''      Cadena1 = Replace(Cadena1, "%1", Vlxml(i))
''    Else
''      Cadena1 = Cadena1 & Replace(Convertidor, "%1", Vlxml(i) & " xmlns=" & Chr(34) & Chr(34))
''      Cadena1 = Replace(Cadena1, "%3", Vlxml(i))
''    End If
''  Next i
''  Cadena2 = ""
''  For K = 1 To grdConci.Rows - 1
''    Cadena2 = Cadena2 & "<" & Vlxml(Nivel) & " diffgr:id=" & Chr(34) & "Table" & K & Chr(34) & " msdata:rowOrder=" & Chr(34) & K - 1 & Chr(34) & ">"
''    For i = Nivel + 1 To UBound(Vlxml)
''      Convertidor = "<%1>%2</%1>"
''      Cadena2 = Cadena2 & Replace(Convertidor, "%1", Vlxml(i))
''      Select Case (i - Nivel)
''        Case 1: Cadena2 = Replace(Cadena2, "%2", "19")
''        Case 2: Cadena2 = Replace(Cadena2, "%2", IIf(grdConci.TextMatrix(K, 12) = "", "200600000" & K, grdConci.TextMatrix(K, 12)))
''        Case 3: Cadena2 = Replace(Cadena2, "%2", IIf(Trim(grdConci.TextMatrix(K, 19)) = "", "-1", ProcesaCta(grdConci.TextMatrix(K, 19))))
''        Case 4: Cadena2 = Replace(Cadena2, "%2", IIf(Trim(grdConci.TextMatrix(K, 20)) = "", "C", grdConci.TextMatrix(K, 20)))
''        Case 5: Cadena2 = Replace(Cadena2, "%2", IIf(Trim(grdConci.TextMatrix(K, 15)) = "1707", grdConci.TextMatrix(K, 2), "-1"))
''        Case 6: Cadena2 = Replace(Cadena2, "%2", IIf(Trim(grdConci.TextMatrix(K, 15)) = "1708", Mid(grdConci.TextMatrix(K, 2), 1, 2), "-1"))
''        Case 7: Cadena2 = Replace(Cadena2, "%2", IIf(Trim(grdConci.TextMatrix(K, 15)) = "1708", Mid(grdConci.TextMatrix(K, 2), 3, 2), "-1"))
''        Case 8: Cadena2 = Replace(Cadena2, "%2", IIf(Trim(grdConci.TextMatrix(K, 15)) = "1708", Mid(grdConci.TextMatrix(K, 2), 5, 5), "-1"))
''        Case 9: Cadena2 = Replace(Cadena2, "%2", grdConci.TextMatrix(K, 4))
''        Case 10: Cadena2 = Replace(Cadena2, "%2", grdConci.TextMatrix(K, 16))
''        Case 11: Cadena2 = Replace(Cadena2, "%2", "0") 'grdConci.TextMatrix(K, 10)
''        Case 12: Cadena2 = Replace(Cadena2, "%2", grdConci.TextMatrix(K, 13))
''      End Select
''    Next i
''    Cadena2 = Cadena2 & "</" & Vlxml(Nivel) & ">"
''  Next K
''  'Text1.Text = Sschema & Replace(Cadena1, "%2", Cadena2) & "</diffgr:diffgram></DataSet>"
'''Exit Sub

  'Capturo el link para webservicie en catalogo
  PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
  PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "I"
  PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text)
  If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_pago_etapa", True, "Ok... Consulta de Pagos ETAPA") Then
    PMMapeaVariable SqlConn&, Link
    PMChequea SqlConn&
  Else
    PMChequea SqlConn&
    Exit Sub
  End If

  On Error GoTo Error_Web
  TramaXml = ""
  SoapEnte.MSSoapInit Trim(Link) '"http://172.16.23.108/etapaservice/etapaservice.asmx?wsdl"
  SoapEnte.ConnectorProperty("Timeout") = 60000
  TramaXml = SoapEnte.getConciliacion(Trim(VLFecha))
  'TramaXml = SoapEnte.getConciliacion("20070110")
  'TramaXml = SoapEnte.setConciliacion(Format(dtFecha, "yyyymmdd"), Text1.Text)
  SoapEnte.ConnectorProperty("EndPointURL") = Trim(Link) '"http://172.16.23.108/etapaservice/etapaservice.asmx?wsdl"
  
  'Respaldo el xml a un archivo
  'carpeta = App.Path & "\ETAPA\"      'lfcm 06-marzo-2007 Cambio de Ruta
  carpeta = CurDir$ & "\ETAPA\"        'lfcm 06-marzo-2007 Cambio de Ruta
  If dir(carpeta, vbDirectory) = "" Then
    MkDir (carpeta)
  End If
  archivo = "[ETAPA_concilia_" & Format(dtFecha, "mmddyyyy") & "] " & Format(Date, "yyyymmdd") & Format(Time, "hhmmss") & ".xml"
  Open carpeta & archivo For Append As #69
    Print #69, Trim(TramaXml)
  Close #69
  CantRow = 0 'Para cantida del Row
  TramaXml = Mid(TramaXml, 39) ' Para quitar el (<?xml version="1.0" encoding="UTF-8"?>)
  vtdocxml.loadXML "<string>" & TramaXml & "</string>"
  grdAlterno.Cols = 15
  grdAlterno.Rows = 1
  Set padreXml = vtdocxml.selectSingleNode("/string")
  Set vthijo = padreXml.childNodes.item(0)
  For i = 0 To vthijo.childNodes.length - 1 'cantidad de registros
    If vthijo.Attributes Is Nothing = False Then
      grdAlterno.Rows = grdAlterno.Rows + 1
      grdAlterno.Row = i
      CantRow = CantRow + 1
      Set vthijo2 = vthijo.childNodes.item(i)
      For k = 0 To vthijo2.childNodes.length - 1 'cantidad de registros
        If vthijo2.Attributes Is Nothing = False Then
          grdAlterno.Col = k
          grdAlterno.text = vthijo2.childNodes.item(k).text
        End If
      Next k
    End If
  Next i
  If CantRow <= 0 Then
    MsgBox "No existe dato de conciliación por ETAPA", vbInformation, "ETAPA"
    Exit Sub
  End If
  'ANBE emulador de proceso webservice
  'Exit Sub
  For i = 1 To grdConci.Rows - 1
    grdConci.Row = i
    For k = 0 To grdAlterno.Rows - 1
      grdConci.Col = 2
      'If Trim(grdConci.TextMatrix(i, 12)) = Trim(grdAlterno.TextMatrix(K, 1)) And UCase(Trim(grdAlterno.TextMatrix(K, 12))) = "Y" Then
      CodAgua = Format(Trim(grdAlterno.TextMatrix(k, 5)), "0#") & Format(Trim(grdAlterno.TextMatrix(k, 6)), "0#") & Format(Trim(grdAlterno.TextMatrix(k, 7)), "0000#")
      If (Val(Trim(grdConci.TextMatrix(i, 2))) = Val(Trim(grdAlterno.TextMatrix(k, 4))) Or _
          (Trim(grdConci.TextMatrix(i, 2))) = CodAgua) And _
          UCase(Trim(grdAlterno.TextMatrix(k, 12))) = "Y" Then
        grdConci.TextMatrix(i, 9) = "SI"
        Exit For
      End If
    Next k
    If Trim(grdConci.TextMatrix(i, 9)) = "" Then
      grdConci.TextMatrix(i, 9) = "NO"
    End If
  Next i
  
  For i = 1 To grdConci.Rows - 1
    grdConci.Row = i
    'If (Trim(UCase(grdConci.TextMatrix(i, 8))) = Trim(UCase(grdConci.TextMatrix(i, 9)))) Then
    If UCase(grdConci.TextMatrix(i, 8)) = "SI" And _
       UCase(grdConci.TextMatrix(i, 9)) = "SI" Then
      grdConci.Col = 7
      grdConci.text = "OK"
    End If
    If UCase(grdConci.TextMatrix(i, 8)) = "NO" And _
       UCase(grdConci.TextMatrix(i, 9)) = "NO" Then
      grdConci.Col = 7
      grdConci.text = "No PROCESADO"
    End If
    If UCase(grdConci.TextMatrix(i, 8)) = "SI" And _
       UCase(grdConci.TextMatrix(i, 9)) = "NO" Then
      grdConci.Col = 7
      grdConci.text = "Aj HABILITAR"
    End If
    If UCase(grdConci.TextMatrix(i, 8)) = "NO" And _
       UCase(grdConci.TextMatrix(i, 9)) = "SI" Then
      grdConci.Col = 7
      grdConci.text = "Aj REVERSAR"
    End If
  Next i
  PLCantidadesETAPA
  cmdBoton(1).Enabled = True
  Exit Sub
Error_Web:
  MsgBox "Error en Proceso de concialiación ETAPA " & Chr(13) & err.Description
  cmdBoton(1).Enabled = False
End Sub

Private Sub PLCantidadesETAPA()
  'ANBE proceso de totales
  CanOk = 0: ValOk = 0
  CanBc = 0: ValBc = 0
  CanEp = 0: ValEp = 0
  For i = 1 To grdConci.Rows - 1
    grdConci.Col = 7
    grdConci.Row = i
    If UCase(Trim(grdConci.TextMatrix(i, 8))) = "SI" And UCase(Trim(grdConci.TextMatrix(i, 9))) = "SI" Then
      grdConci.Col = 4
      ValOk = ValOk + grdConci.text
      CanOk = CanOk + 1
    End If
    If UCase(Trim(grdConci.TextMatrix(i, 8))) = "SI" And UCase(Trim(grdConci.TextMatrix(i, 9))) = "NO" Then
      CanBc = CanBc + 1
      ValBc = ValBc + grdConci.TextMatrix(i, 4)
    End If
    If UCase(Trim(grdConci.TextMatrix(i, 8))) = "NO" And UCase(Trim(grdConci.TextMatrix(i, 9))) = "SI" Then
      CanEp = CanEp + 1
      ValEp = ValEp + grdConci.TextMatrix(i, 4)
    End If
  Next i
  'Totales Banco
  lblOkBco.Caption = CanOk: lblOkBcoValor.Caption = Format(ValOk, "#,###,##0.00")
  lblSoloBco.Caption = CanBc: lblSoloBcoValor.Caption = Format(ValBc, "#,###,##0.00")
  lblProcesBco.Caption = CInt(lblOkBco.Caption) + CInt(lblSoloBco.Caption)
  lblProcesBcoValor.Caption = Format((CDbl(lblOkBcoValor.Caption) + CDbl(lblSoloBcoValor.Caption)), "#,###,##0.00")
  'Total Empresa
  lblOkEmp.Caption = CanOk: lblOkEmpValor.Caption = Format(ValOk, "#,###,##0.00")
  lblSoloEmp.Caption = CanEp: lblSoloEmpValor.Caption = Format(ValEp, "#,###,##0.00")
  lblProcesEmp.Caption = CInt(lblOkEmp.Caption) + CInt(lblSoloEmp.Caption)
  lblProcesEmpValor.Caption = Format((CDbl(lblOkEmpValor.Caption) + CDbl(lblSoloEmpValor.Caption)), "#,###,##0.00")
End Sub

Private Function ProcesaCta(numcta As String) As String
'Para quitar los ceros a la derecha
Dim i As Integer

If Trim(numcta) = "" Then
  ProcesaCta = ""
  Exit Function
End If
For i = 1 To Len(numcta)
  If Mid(numcta, i, 1) > 0 Then
     ProcesaCta = Mid(numcta, i, Len(numcta))
     Exit For
  End If
Next i

End Function


Private Sub PLBorrador() 'ANBE Borrar solo para pruebas
Dim i As Integer
  For i = 1 To grdConci.Rows - 1
    grdConci.Row = i
    grdConci.Col = 1
    If UCase(Trim(grdConci.text)) = "TELEFONO" Then
      VLMatrix(4, i) = grdConci.TextMatrix(i, 2)
    ElseIf UCase(Trim(grdConci.text)) = "AGUA" Then
      VLMatrix(5, i) = Mid(Trim(grdConci.TextMatrix(i, 2)), 1, 2)
      VLMatrix(6, i) = Mid(Trim(grdConci.TextMatrix(i, 2)), 3, 2)
      VLMatrix(7, i) = Mid(Trim(grdConci.TextMatrix(i, 2)), 5, 5)
    End If
    VLMatrix(8, i) = Trim(grdConci.TextMatrix(i, 4))
    VLMatrix(12, i) = "C"
  Next i
  VLMatrix(12, 44) = "M"
  VLMatrix(12, 45) = "M"
  VLMatrix(12, 46) = "M"
  VLMatrix(12, 47) = "M"
End Sub
Private Sub PLImprimirETAPA()
  'ANBE Imprimi solictud de correcion RPT.
On Error GoTo ERROR_IMPRE
  Dim BaseDatos As Database
  Dim tabla1 As Table
  Dim archivo As String
  Dim c As Integer
  
  archivo = VGPath$ & "\Tservi.mdb"
  
  'Inicializar las tablas del reporte
  Set BaseDatos = OpenDatabase(archivo)
  Set tabla1 = BaseDatos.OpenTable("conETAPA")
  BaseDatos.Execute "delete from conETAPA"
  c = 0 'Para verificar si presento el rpt
  'Cargar la tabla con la información del grid
  For i% = 1 To grdConci.Rows - 1
    grdConci.Row = i%
    grdConci.Col = 7
    If UCase(Trim(Mid(Me.grdConci.text, 3))) = "REVERSAR" Or UCase(Trim(Mid(Me.grdConci.text, 3))) = "HABILITAR" Then
      c = c + 1
      tabla1.AddNew
      grdConci.Col = 1  'Servicio
      tabla1("servicio") = grdConci.text
      grdConci.Col = 4
      tabla1("valor") = grdConci.text
      grdConci.Col = 2  'Codigo
      tabla1("codigo") = grdConci.text
      grdConci.Col = 5  'Fecha Contable
      tabla1("fecha_conta") = grdConci.text
      grdConci.Col = 6  'Hora
      tabla1("hora") = grdConci.text
      grdConci.Col = 7  'Resultado
      tabla1("resultado") = Trim(Mid(Me.grdConci.text, 4))
      grdConci.Col = 10  'Usuario
      tabla1("cajero") = grdConci.text
      grdConci.Col = 11
      tabla1("agencia") = grdConci.text
      grdConci.Col = 12
      tabla1("transaccion") = grdConci.text
      grdConci.Col = 14
      tabla1("fecha_trn") = grdConci.text
      tabla1.Update
    End If
  Next i%
  
  tabla1.Close

  If c > 1 Then
    'Imprimir el reporte
    rptreporte.ReportFileName = App.Path + "\conETAPA.rpt"
    rptreporte.DataFiles(0) = archivo
    rptreporte.Destination = 0
    rptreporte.Action = 1
  End If
  
  BaseDatos.Close
  
  Exit Sub
ERROR_IMPRE:
  MsgBox "Error en generación de Reportes " & err & Error$
  BaseDatos.Close
  Exit Sub
  
End Sub

Private Sub LimpiaResultado()
  'Resultados 'ANBE
  Me.lblOkBco.Caption = "0"
  Me.lblSoloBco.Caption = "0"
  Me.lblProcesBco.Caption = "0"
  Me.lblOkBcoValor.Caption = "0.00"
  Me.lblSoloBcoValor.Caption = "0.00"
  Me.lblProcesBcoValor.Caption = "0.00"
  Me.lblOkEmp.Caption = "0"
  Me.lblSoloEmp.Caption = "0"
  Me.lblProcesEmp.Caption = "0"
  Me.lblOkEmpValor.Caption = "0.00"
  Me.lblSoloEmpValor.Caption = "0.00"
  Me.lblProcesEmpValor.Caption = "0.00"
  Me.lbl_registros = 0
End Sub


Private Sub PLExportaExcelEtapa()
'***************************************************************
'Objetivo:  Genera la exportación al documento de excel
'Input   :  ninguno
'Output  :  ninguno
'***************************************************************
'                    MODIFICACIONES
'FECHA        AUTOR               RAZON
'19/12/2006  Angelo Burbano E.
'***************************************************************
Dim oExcelApp   As Object
Dim oWs         As Object
Dim oWb         As Object
Dim sXlsTemplate As String
Dim iRow As Integer
Dim iCol As Integer
Dim busqueda As String
Dim bco1, bco2, bco3 As String
Dim emp1, emp2, emp3 As String


On Error GoTo ErrorHandler
sXlsTemplate = App.Path & "\xrptETAPA.xlt"

Set oExcelApp = CreateObject("EXCEL.APPLICATION")
oExcelApp.Visible = False
oExcelApp.Workbooks.Open Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True

Set oWs = oExcelApp.ActiveSheet
Set oWb = oExcelApp.ActiveWorkbook

Set oWs = oExcelApp.ActiveSheet
oWs.Cells(6, 1).Value = "REPORTE DE CONCILACION DE PAGO DE ETAPA"
oWs.Cells(7, 2).Value = "Empresa:  [" & Trim(txt_empresa.text) & "] " & UCase(Trim(lbl_empresa))
oWs.Cells(8, 2).Value = "Fecha Consulta: " & CStr(Now)
oWs.Cells(8, 6).Value = "Cantidad: " & Trim(lbl_registros)

oWs.Range("A10:L10").Interior.ColorIndex = 15
oWs.Range("A10:L10").Borders.LineStyle = 1

oWs.Cells(8, 1).Value = busqueda
For iRow = 0 To Me.grdConci.Rows - 1
    Screen.MousePointer = 11
    Me.grdConci.Row = iRow
    Me.grdConci.Col = 1
    oWs.Cells(10 + iRow, 1).Value = Me.grdConci.text
    Me.grdConci.Col = 2
    oWs.Cells(10 + iRow, 2).Value = Me.grdConci.text
    Me.grdConci.Col = 3
    oWs.Cells(10 + iRow, 3).Value = Me.grdConci.text
    Me.grdConci.Col = 4
    oWs.Cells(10 + iRow, 4).Value = Me.grdConci.text
    Me.grdConci.Col = 5
    oWs.Cells(10 + iRow, 5).Value = Me.grdConci.text
    Me.grdConci.Col = 6
    oWs.Cells(10 + iRow, 6).Value = Me.grdConci.text
    Me.grdConci.Col = 7
    oWs.Cells(10 + iRow, 7).Value = Me.grdConci.text
    Me.grdConci.Col = 8
    oWs.Cells(10 + iRow, 8).Value = Me.grdConci.text
    Me.grdConci.Col = 9
    oWs.Cells(10 + iRow, 9).Value = Me.grdConci.text
    Me.grdConci.Col = 10
    oWs.Cells(10 + iRow, 10).Value = Me.grdConci.text
    Me.grdConci.Col = 11
    oWs.Cells(10 + iRow, 11).Value = Me.grdConci.text
    Me.grdConci.Col = 12
    oWs.Cells(10 + iRow, 12).Value = Me.grdConci.text
    Screen.MousePointer = 0
Next iRow
oWs.Cells(13 + iRow, 1).Value = "TOTALES BANCO:"
oWs.Cells(13 + iRow, 1).Font.Bold = True
oWs.Cells(15 + iRow, 1).Value = Space(50) & "No." & Space(30) & "Valor"
oWs.Cells(15 + iRow, 1).Font.Bold = True
bco1 = lblOkBco & (Space(40 - Len(lblOkBco))) & lblOkBcoValor
oWs.Cells(16 + iRow, 1).Value = " Pagos Ok:" & Space(55) & bco1
bco2 = lblSoloBco & (Space(40 - Len(lblSoloBco))) & lblSoloBcoValor
oWs.Cells(17 + iRow, 1).Value = " Pagos solo en banco:" & Space(31) & bco2
bco3 = lblProcesBco & (Space(40 - Len(lblProcesBco))) & lblProcesBcoValor
oWs.Cells(18 + iRow, 1).Value = " Total procesados Bco:" & Space(29) & bco3
oWs.Cells(13 + iRow, 5).Value = "TOTALES EMPRESA:"
oWs.Cells(13 + iRow, 5).Font.Bold = True
oWs.Cells(15 + iRow, 5).Value = Space(50) & "No." & Space(30) & "Valor"
oWs.Cells(15 + iRow, 5).Font.Bold = True
emp1 = lblOkEmp & (Space(40 - Len(lblOkEmp))) & lblOkEmpValor
oWs.Cells(16 + iRow, 5).Value = " Pagos Ok:" & Space(55) & emp1
emp2 = lblSoloEmp & (Space(40 - Len(lblSoloEmp))) & lblSoloEmpValor
oWs.Cells(17 + iRow, 5).Value = " Pagos solo en Empresa:" & Space(26) & emp2
emp3 = lblProcesEmp & (Space(40 - Len(lblProcesEmp))) & lblProcesEmpValor
oWs.Cells(18 + iRow, 5).Value = " Total procesados Emp:" & Space(28) & emp3


oExcelApp.Visible = True
Set oWs = Nothing
Set oExcelApp = Nothing
Exit Sub

ErrorHandler:
    Screen.MousePointer = vbDefault
    MsgBox err.Description & " (" & CStr(err.Number) & ")", vbExclamation, "Excel Export"
    On Error Resume Next
    oExcelApp.Quit
    Set oWs = Nothing
    Set oExcelApp = Nothing
End Sub

'INICIO (SIPECOM) LCHACHA OOF REF001
Private Sub PLExportaExcelEtapaOOF()
Dim oExcelApp   As Object
Dim oWs         As Object
Dim oWb         As Object
Dim sXlsTemplate As String
Dim iRow As Integer
Dim iCol As Integer
Dim busqueda As String
Dim bco1, bco2, bco3 As String
Dim emp1, emp2, emp3 As String


On Error GoTo ErrorHandler

'INICIO (SIPECOM) LCHACHA OOF REF004
'sXlsTemplate = App.Path & "\xrptETAPA.xlt"
Dim sNewXlsFile As String
sNewXlsFile = "xrptETAPA" & Format$(Now, "YYYYMMDDHHMMSS") + ".ods"
FileCopy App.Path & "\xrptETAPA.xlt", Environ$("tmp") & "\" & sNewXlsFile
sXlsTemplate = Environ$("tmp") & "\" & sNewXlsFile
'FIN (SIPECOM) LCHACHA OOF REF004

'Set oExcelApp = CreateObject("EXCEL.APPLICATION")              '(SIPECOM) LCHACHA OOF REF001
Set oExcelApp = CreateObject("HOJAELECTRONICABB.APPLICATION")   '(SIPECOM) LCHACHA OOF REF001
'oExcelApp.Visible = False
'oExcelApp.Workbooks.Open Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True   '(SIPECOM) LCHACHA OOF REF001
oExcelApp.Workbooks.OpenW Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True, DestinationFile:="Pantalla"   '(SIPECOM) LCHACHA OOF REF001
Set oWs = oExcelApp.ActiveSheet
Set oWb = oExcelApp.ActiveWorkbook

Set oWs = oExcelApp.ActiveSheet
oWs.Cells(6, 1).Value = "REPORTE DE CONCILACION DE PAGO DE ETAPA"
oWs.Cells(7, 2).Value = "Empresa:  [" & Trim(txt_empresa.text) & "] " & UCase(Trim(lbl_empresa))
oWs.Cells(8, 2).Value = "Fecha Consulta: " & CStr(Now)
oWs.Cells(8, 6).Value = "Cantidad: " & Trim(lbl_registros)

oWs.Range("A10:L10").Interior.ColorIndex = 15
oWs.Range("A10:L10").Borders.LineStyle = 1

oWs.Cells(8, 1).Value = busqueda
For iRow = 0 To Me.grdConci.Rows - 1
    Screen.MousePointer = 11
    Me.grdConci.Row = iRow
    Me.grdConci.Col = 1
    oWs.Cells(CLng(10 + iRow), 1).Value = Me.grdConci.text
    Me.grdConci.Col = 2
    oWs.Cells(CLng(10 + iRow), 2).Value = Me.grdConci.text
    Me.grdConci.Col = 3
    oWs.Cells(CLng(10 + iRow), 3).Value = Me.grdConci.text
    Me.grdConci.Col = 4
    oWs.Cells(CLng(10 + iRow), 4).Value = Me.grdConci.text
    Me.grdConci.Col = 5
    oWs.Cells(CLng(10 + iRow), 5).Value = Me.grdConci.text
    Me.grdConci.Col = 6
    oWs.Cells(CLng(10 + iRow), 6).Value = Me.grdConci.text
    Me.grdConci.Col = 7
    oWs.Cells(CLng(10 + iRow), 7).Value = Me.grdConci.text
    Me.grdConci.Col = 8
    oWs.Cells(CLng(10 + iRow), 8).Value = Me.grdConci.text
    Me.grdConci.Col = 9
    oWs.Cells(CLng(10 + iRow), 9).Value = Me.grdConci.text
    Me.grdConci.Col = 10
    oWs.Cells(CLng(10 + iRow), 10).Value = Me.grdConci.text
    Me.grdConci.Col = 11
    oWs.Cells(CLng(10 + iRow), 11).Value = Me.grdConci.text
    Me.grdConci.Col = 12
    oWs.Cells(CLng(10 + iRow), 12).Value = Me.grdConci.text
    Screen.MousePointer = 0
Next iRow
oWs.Cells(CLng(13 + iRow), 1).Value = "TOTALES BANCO:"
oWs.Cells(CLng(13 + iRow), 1).Font.Bold = True
oWs.Cells(CLng(15 + iRow), 1).Value = Space(50) & "No." & Space(30) & "Valor"
oWs.Cells(CLng(15 + iRow), 1).Font.Bold = True
bco1 = lblOkBco & (Space(40 - Len(lblOkBco))) & lblOkBcoValor
oWs.Cells(CLng(16 + iRow), 1).Value = " Pagos Ok:" & Space(55) & bco1
bco2 = lblSoloBco & (Space(40 - Len(lblSoloBco))) & lblSoloBcoValor
oWs.Cells(CLng(17 + iRow), 1).Value = " Pagos solo en banco:" & Space(31) & bco2
bco3 = lblProcesBco & (Space(40 - Len(lblProcesBco))) & lblProcesBcoValor
oWs.Cells(CLng(18 + iRow), 1).Value = " Total procesados Bco:" & Space(29) & bco3
oWs.Cells(CLng(13 + iRow), 5).Value = "TOTALES EMPRESA:"
oWs.Cells(CLng(13 + iRow), 5).Font.Bold = True
oWs.Cells(CLng(15 + iRow), 5).Value = Space(50) & "No." & Space(30) & "Valor"
oWs.Cells(CLng(15 + iRow), 5).Font.Bold = True
emp1 = lblOkEmp & (Space(40 - Len(lblOkEmp))) & lblOkEmpValor
oWs.Cells(CLng(16 + iRow), 5).Value = " Pagos Ok:" & Space(55) & emp1
emp2 = lblSoloEmp & (Space(40 - Len(lblSoloEmp))) & lblSoloEmpValor
oWs.Cells(CLng(17 + iRow), 5).Value = " Pagos solo en Empresa:" & Space(26) & emp2
emp3 = lblProcesEmp & (Space(40 - Len(lblProcesEmp))) & lblProcesEmpValor
oWs.Cells(CLng(18 + iRow), 5).Value = " Total procesados Emp:" & Space(28) & emp3


'oExcelApp.Visible = True
Set oWs = Nothing
Set oExcelApp = Nothing
DoEvents
Exit Sub

ErrorHandler:
    Screen.MousePointer = vbDefault
    MsgBox err.Description & " (" & CStr(err.Number) & ")", vbExclamation, "Excel Export"
    'On Error Resume Next
    'oExcelApp.Quit
    Set oWs = Nothing
    Set oExcelApp = Nothing
End Sub
'FIN (SIPECOM) LCHACHA OOF REF001

Sub PLLimpiar()
  LoFormateaFlex
  Me.txt_empresa.text = ""
  Me.dtFecha.Value = Date
  Me.cmdEstadoBco.ListIndex = 0
  Me.cmbEstadoEmp.ListIndex = 0
  PMLimpiaGrid Me.grdConci
  Me.lbl_registros.Caption = ""
  Me.lbl_empresa.Caption = ""
  optProc(0).Enabled = True
  optProc(1).Enabled = True
  Label2.Enabled = True
  Label3.Enabled = True
  cmdBoton(1).Enabled = True
  'cmdBoton(3).Enabled = False 'tc 07/22/2008 porque no se volvia a activar cuando se consultaba
  LimpiaResultado
  Setear_Controles 'DAPV
  VlExiste_Dep = "" 'dpereirv
End Sub

Private Sub LoFormateaFlex()
Dim iCol As Integer
  With Me.grdConci
    .Row = 0
    .Cols = 2
    .ScrollBars = flexScrollBarBoth
    .Rows = 2
    .Clear
  End With
    grdConci.Col = 1
End Sub



'********************************************************************************
'                            CONCILIACION DE TVCABLE
'********************************************************************************




Sub PLBuscarTVCABLE(orden As Integer)
    'Hago la consulta de los primeros 15 resultados
    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
    PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "C"   'C = Consulta
    PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text)
    PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, orden
    PMPasoValores SqlConn&, "@i_fecha_proceso", 0, SQLDATETIME, (dtFecha)
    PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, Me.cmdEstadoBco.text
    PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, Me.cmbEstadoEmp.text
    If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_tvcable", True, "Ok... Consulta de Pagos TVCABLE") Then
        If orden = 0 Then
            PgMapeaFlexG grdConci, True, False, 0, 20, 14
        Else
            PgMapeaFlexG grdConci, False, False, 0, 20, 14
        End If
        PMChequea SqlConn&
        If Me.grdConci.Tag = "15" Then
            Me.grdConci.Col = 12
            Me.grdConci.Row = Me.grdConci.Rows - 1
            PLBuscarTVCABLE (Me.grdConci.text)
        Else
            'Elimino la Columna donde traje los secueciales para la busqueda
            'Me.grdConci.Cols = 11
            Me.lbl_registros.Caption = (Me.grdConci.Rows - 1)
                
            'Formato al Grid
            Me.grdConci.ColWidth(1) = 800  'Codigo
            Me.grdConci.ColWidth(2) = 2445  'Nombre Abonado
            Me.grdConci.ColWidth(3) = 1100  'Valor
            Me.grdConci.ColWidth(4) = 1100  'Fecha Cont.
            Me.grdConci.ColWidth(5) = 750   'Hora
            Me.grdConci.ColWidth(6) = 1300  'Resultado
            Me.grdConci.ColWidth(7) = 1100  'Status Bco
            Me.grdConci.ColWidth(8) = 1100  'Status Emp
            Me.grdConci.ColWidth(9) = 1000  'Usuario
            Me.grdConci.ColWidth(10) = 1100 'N° Autorizacion
            Me.grdConci.ColWidth(11) = 1100 'Secuencial
            'Me.grdConci.ColWidth(11) = 0 'Secuencial
            'Me.grdConci.ColWidth(12) = 1100 'Tipo Transaccion
            Me.grdConci.ColWidth(12) = 0 'Tipo Transaccion
            Me.grdConci.ColWidth(13) = 0  'Campo Autonumerico

            'PLFormatoHora
            PLSacaTotalesTVCABLE   'Barrido del Grid para sacar totales

        End If
    Else
        PMLimpiaGrid Me.grdConci
        
        'Resultados
        Me.lblOkBco.Caption = "0"
        Me.lblSoloBco.Caption = "0"
        Me.lblProcesBco.Caption = "0"
        Me.lblOkBcoValor.Caption = "0.00"
        Me.lblSoloBcoValor.Caption = "0.00"
        Me.lblProcesBcoValor.Caption = "0.00"
        
        Me.lblOkEmp.Caption = "0"
        Me.lblSoloEmp.Caption = "0"
        Me.lblProcesEmp.Caption = "0"
        Me.lblOkEmpValor.Caption = "0.00"
        Me.lblSoloEmpValor.Caption = "0.00"
        Me.lblProcesEmpValor.Caption = "0.00"
        Me.lbl_registros = 0
            
    End If
    
End Sub

Sub PLFormatoHora()
    Me.grdConci.Col = 5
    For L% = 1 To Me.grdConci.Rows - 1
        Me.grdConci.Row = L%
        Me.grdConci.text = Mid(Me.grdConci.text, 1, 2) & ":" & Mid(Me.grdConci.text, 3, 2) & ":" & Mid(Me.grdConci.text, 5, 2)
    Next L%
End Sub

Sub PLSacaTotalesTVCABLE()
    
    'Inicializo las variables a considerar en los totales
    Dim VLOkReg As Integer
    Dim VLOkRegBco As Integer
    
    Dim VLValorOk As Currency
    Dim VLValorOkBco As Currency
    
    Dim VLOkRegEmp As Integer
    Dim VLValorOkEmp As Currency
    
    Me.lblOkBco = 0
    Me.lblSoloBco = 0
    Me.lblProcesBco = 0
    
    Me.lblOkBcoValor = 0
    Me.lblSoloBcoValor = 0
    Me.lblProcesBcoValor = 0
    
    Me.lblOkEmp = 0
    Me.lblSoloEmp = 0
    Me.lblProcesEmp = 0
    
    Me.lblOkEmpValor = 0
    Me.lblSoloEmpValor = 0
    Me.lblProcesEmpValor = 0
    
    'Debug.Print grdConci.Rows - 1
    For j% = 1 To (grdConci.Rows - 1)
        'Seteo la fila a usar
        Me.grdConci.Row = j%
        
        Me.grdConci.Col = 7     'Columna con el estado de Banco
        VLEstBco = Me.grdConci.text
        Me.grdConci.Col = 8     'Columna con el estado de Emp
        VLEstEmp = Me.grdConci.text
    
        'Obtengo el valor de los pagos Ok en Bco y en Emp
        If VLEstBco = "SI" And VLEstEmp = "SI" Then
            Me.grdConci.Col = 3
            VLValorOk = VLValorOk + CCur(Me.grdConci.text)
            VLOkReg = VLOkReg + 1
        End If
    
        'Obtengo el valor de los pagos SI en Bco y NO en Emp
        If VLEstBco = "SI" And VLEstEmp = "NO" Then
            Me.grdConci.Col = 3
            VLValorOkBco = VLValorOkBco + CCur(Me.grdConci.text)
            VLOkRegBco = VLOkRegBco + 1
        End If
        
        'Obtengo el valor de los pagos NO en Bco y SI en Emp
        If VLEstBco = "NO" And VLEstEmp = "SI" Then
            Me.grdConci.Col = 3
            VLValorOkEmp = VLValorOkEmp + CCur(Me.grdConci.text)
            VLOkRegEmp = VLOkRegEmp + 1
        End If
        
'        'Botones Habilitar - Reversar
'        Me.grdConci.Col = 6
'        If Me.grdConci.Text = "POR HABILITAR" Then
'            habilitar = True
'        ElseIf Me.grdConci.Text = "POR REVERSAR" Then
'            reversar = True
'        End If

    Next j%

    'Sumatoria de los totales
    'Banco
    Me.lblOkBco = CInt(VLOkReg)
    Me.lblSoloBco = CInt(VLOkRegBco)
    Me.lblProcesBco = CInt(VLOkRegBco) + CInt(VLOkReg)
    Me.lblOkBcoValor = Format(CCur(VLValorOk), "0.00")
    Me.lblSoloBcoValor = Format(CCur(VLValorOkBco), "0.00")
    Me.lblProcesBcoValor = Format((CCur(VLValorOk) + CCur(VLValorOkBco)), "0.00")
    
    'Empresa Servicio
    Me.lblOkEmp = CInt(VLOkReg)
    Me.lblSoloEmp = CInt(VLOkRegEmp)
    Me.lblProcesEmp = CInt(VLOkRegEmp) + CInt(VLOkReg)
    Me.lblOkEmpValor = Format(CCur(VLValorOk), "0.00")
    Me.lblSoloEmpValor = Format(CCur(VLValorOkEmp), "0.00")
    Me.lblProcesEmpValor = Format((CCur(VLValorOk) + CCur(VLValorOkEmp)), "0.00")
    
End Sub

Sub PLSacaTotalesCATEG()
    
    'Inicializo las variables a considerar en los totales
    Dim VLOkReg As Integer
    Dim VLOkRegBco As Integer
    
    Dim VLValorOk As Currency
    Dim VLValorOkBco As Currency
    
    Dim VLOkRegEmp As Integer
    Dim VLValorOkEmp As Currency
    
    Me.lblOkBco = 0
    Me.lblSoloBco = 0
    Me.lblProcesBco = 0
    
    Me.lblOkBcoValor = 0
    Me.lblSoloBcoValor = 0
    Me.lblProcesBcoValor = 0
    
    Me.lblOkEmp = 0
    Me.lblSoloEmp = 0
    Me.lblProcesEmp = 0
    
    Me.lblOkEmpValor = 0
    Me.lblSoloEmpValor = 0
    Me.lblProcesEmpValor = 0
    
    'Debug.Print grdConci.Rows - 1
    For j% = 1 To (grdConci.Rows - 1)
        'Seteo la fila a usar
        Me.grdConci.Row = j%
        
        Me.grdConci.Col = 7     'Columna con el estado de Banco
        VLEstBco = Me.grdConci.text
        Me.grdConci.Col = 8     'Columna con el estado de Emp
        VLEstEmp = Me.grdConci.text
    
        'Obtengo el valor de los pagos Ok en Bco y en Emp
        If VLEstBco = "SI" And VLEstEmp = "SI" Then
            Me.grdConci.Col = 3
            VLValorOk = VLValorOk + CCur(Me.grdConci.text)
            VLOkReg = VLOkReg + 1
        End If
    
        'Obtengo el valor de los pagos SI en Bco y NO en Emp
        If VLEstBco = "SI" And VLEstEmp = "NO" Then
            Me.grdConci.Col = 3
            VLValorOkBco = VLValorOkBco + CCur(Me.grdConci.text)
            VLOkRegBco = VLOkRegBco + 1
        End If
        
        'Obtengo el valor de los pagos NO en Bco y SI en Emp
        If VLEstBco = "NO" And VLEstEmp = "SI" Then
            Me.grdConci.Col = 3
            VLValorOkEmp = VLValorOkEmp + CCur(Me.grdConci.text)
            VLOkRegEmp = VLOkRegEmp + 1
        End If
        
    Next j%

    'Sumatoria de los totales
    'Banco
    Me.lblOkBco = CInt(VLOkReg)
    Me.lblSoloBco = CInt(VLOkRegBco)
    Me.lblProcesBco = CInt(VLOkRegBco) + CInt(VLOkReg)
    Me.lblOkBcoValor = Format(CCur(VLValorOk), "0.00")
    Me.lblSoloBcoValor = Format(CCur(VLValorOkBco), "0.00")
    Me.lblProcesBcoValor = Format((CCur(VLValorOk) + CCur(VLValorOkBco)), "0.00")
    
    'Empresa Servicio
    Me.lblOkEmp = CInt(VLOkReg)
    Me.lblSoloEmp = CInt(VLOkRegEmp)
    Me.lblProcesEmp = CInt(VLOkRegEmp) + CInt(VLOkReg)
    Me.lblOkEmpValor = Format(CCur(VLValorOk), "0.00")
    Me.lblSoloEmpValor = Format(CCur(VLValorOkEmp), "0.00")
    Me.lblProcesEmpValor = Format((CCur(VLValorOk) + CCur(VLValorOkEmp)), "0.00")
    
End Sub


Private Sub PLExportaExcelTVCABLE()
Dim oExcelApp   As Object
Dim oWs         As Object
Dim oWb         As Object
Dim sXlsTemplate As String
Dim iRow As Integer
Dim iCol As Integer
Dim busqueda As String
Dim bco1, bco2, bco3 As String
Dim emp1, emp2, emp3 As String


On Error GoTo ErrorHandler
sXlsTemplate = App.Path & "\xrptTVCABLE.xlt"

Set oExcelApp = CreateObject("EXCEL.APPLICATION")              '(SIPECOM) LCHACHA OOF REF001
oExcelApp.Visible = False
oExcelApp.Workbooks.Open Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True   '(SIPECOM) LCHACHA OOF REF001
Set oWs = oExcelApp.ActiveSheet
Set oWb = oExcelApp.ActiveWorkbook

Set oWs = oExcelApp.ActiveSheet
oWs.Cells(6, 1).Value = "      Reporte de Pagos de TVCABLE - Empresa: (" & Me.txt_empresa & ") " & Me.lbl_empresa
'oWs.Cells(8, 2).Value = "Fecha Consulta: " & CStr(Now)
'oWs.Cells(8, 6).Value = "Cantidad: " & Trim(lbl_registros)

'oWs.Range("A10:L10").Interior.ColorIndex = 15
'oWs.Range("A10:L10").Borders.LineStyle = 1

'oWs.Cells(8, 1).Value = busqueda
For iRow = 1 To Me.grdConci.Rows - 1
    Screen.MousePointer = 11
    Me.grdConci.Row = iRow
    Me.grdConci.Col = 1
    oWs.Cells(8 + iRow, 1).Value = Me.grdConci.text
    Me.grdConci.Col = 2
    oWs.Cells(8 + iRow, 2).Value = Me.grdConci.text
    Me.grdConci.Col = 3
    oWs.Cells(8 + iRow, 3).Value = Me.grdConci.text
    Me.grdConci.Col = 4
    oWs.Cells(8 + iRow, 4).Value = Me.grdConci.text
    Me.grdConci.Col = 5
    oWs.Cells(8 + iRow, 5).Value = Me.grdConci.text
    Me.grdConci.Col = 6
    oWs.Cells(8 + iRow, 6).Value = Me.grdConci.text
    Me.grdConci.Col = 7
    oWs.Cells(8 + iRow, 7).Value = Me.grdConci.text
    Me.grdConci.Col = 8
    oWs.Cells(8 + iRow, 8).Value = Me.grdConci.text
    Me.grdConci.Col = 9
    oWs.Cells(8 + iRow, 9).Value = Me.grdConci.text
    Me.grdConci.Col = 10
    oWs.Cells(8 + iRow, 10).Value = Me.grdConci.text
    Me.grdConci.Col = 11
    oWs.Cells(8 + iRow, 11).Value = Me.grdConci.text
    Me.grdConci.Col = 12
    oWs.Cells(8 + iRow, 12).Value = Me.grdConci.text
    Screen.MousePointer = 0
Next iRow
oWs.Cells(13 + iRow, 1).Value = "TOTALES BANCO:"
oWs.Cells(13 + iRow, 1).Font.Bold = True
oWs.Cells(15 + iRow, 1).Value = Space(50) & "No." & Space(30) & "Valor"
oWs.Cells(15 + iRow, 1).Font.Bold = True
bco1 = lblOkBco & (Space(40 - Len(lblOkBco))) & lblOkBcoValor
oWs.Cells(16 + iRow, 1).Value = " Pagos Ok:" & Space(55) & bco1
bco2 = lblSoloBco & (Space(40 - Len(lblSoloBco))) & lblSoloBcoValor
oWs.Cells(17 + iRow, 1).Value = " Pagos solo en banco:" & Space(31) & bco2
bco3 = lblProcesBco & (Space(40 - Len(lblProcesBco))) & lblProcesBcoValor
oWs.Cells(18 + iRow, 1).Value = " Total procesados Bco:" & Space(29) & bco3
oWs.Cells(13 + iRow, 5).Value = "TOTALES EMPRESA:"
oWs.Cells(13 + iRow, 5).Font.Bold = True
oWs.Cells(15 + iRow, 5).Value = Space(50) & "No." & Space(30) & "Valor"
oWs.Cells(15 + iRow, 5).Font.Bold = True
emp1 = lblOkEmp & (Space(40 - Len(lblOkEmp))) & lblOkEmpValor
oWs.Cells(16 + iRow, 5).Value = " Pagos Ok:" & Space(55) & emp1
emp2 = lblSoloEmp & (Space(40 - Len(lblSoloEmp))) & lblSoloEmpValor
oWs.Cells(17 + iRow, 5).Value = " Pagos solo en Empresa:" & Space(26) & emp2
emp3 = lblProcesEmp & (Space(40 - Len(lblProcesEmp))) & lblProcesEmpValor
oWs.Cells(18 + iRow, 5).Value = " Total procesados Emp:" & Space(28) & emp3


oExcelApp.Visible = True
Set oWs = Nothing
Set oExcelApp = Nothing
Exit Sub

ErrorHandler:
    Screen.MousePointer = vbDefault
    MsgBox err.Description & " (" & CStr(err.Number) & ")", vbExclamation, "Excel Export"
    On Error Resume Next
    oExcelApp.Quit
    Set oWs = Nothing
    Set oExcelApp = Nothing
End Sub

'(SIPECOM) MALDAZ OOF REF003
Private Sub PLExportaExcelTVCABLEOOF()
Dim oExcelApp   As Object
Dim oWs         As Object
Dim oWb         As Object
Dim sXlsTemplate As String
Dim iRow As Integer
Dim iCol As Integer
Dim busqueda As String
Dim bco1, bco2, bco3 As String
Dim emp1, emp2, emp3 As String


On Error GoTo ErrorHandler

'INICIO (SIPECOM) LCHACHA OOF REF004
'sXlsTemplate = App.Path & "\xrptTVCABLE.xlt"
Dim sNewXlsFile As String
sNewXlsFile = "xrptTVCABLE" & Format$(Now, "YYYYMMDDHHMMSS") + ".ods"
FileCopy App.Path & "\xrptTVCABLE.xlt", Environ$("tmp") & "\" & sNewXlsFile
sXlsTemplate = Environ$("tmp") & "\" & sNewXlsFile
'FIN (SIPECOM) LCHACHA OOF REF004

'Set oExcelApp = CreateObject("EXCEL.APPLICATION")              '(SIPECOM) LCHACHA OOF REF001
Set oExcelApp = CreateObject("HOJAELECTRONICABB.APPLICATION")   '(SIPECOM) LCHACHA OOF REF001
'oExcelApp.Visible = False
'oExcelApp.Workbooks.Open Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True   '(SIPECOM) LCHACHA OOF REF001
oExcelApp.Workbooks.OpenW Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True, DestinationFile:="Pantalla"    '(SIPECOM) MALDAZ OOF REF003
Set oWs = oExcelApp.ActiveSheet
Set oWb = oExcelApp.ActiveWorkbook

Set oWs = oExcelApp.ActiveSheet
oWs.Cells(6, 1).Value = "      Reporte de Pagos de TVCABLE - Empresa: (" & Me.txt_empresa & ") " & Me.lbl_empresa
'oWs.Cells(8, 2).Value = "Fecha Consulta: " & CStr(Now)
'oWs.Cells(8, 6).Value = "Cantidad: " & Trim(lbl_registros)

'oWs.Range("A10:L10").Interior.ColorIndex = 15
'oWs.Range("A10:L10").Borders.LineStyle = 1

'oWs.Cells(8, 1).Value = busqueda
For iRow = 1 To Me.grdConci.Rows - 1
    Screen.MousePointer = 11
    Me.grdConci.Row = iRow
    Me.grdConci.Col = 1
    oWs.Cells(8 + iRow, 1).Value = Me.grdConci.text
    Me.grdConci.Col = 2
    oWs.Cells(8 + iRow, 2).Value = Me.grdConci.text
    Me.grdConci.Col = 3
    oWs.Cells(8 + iRow, 3).Value = Me.grdConci.text
    Me.grdConci.Col = 4
    oWs.Cells(8 + iRow, 4).Value = Me.grdConci.text
    Me.grdConci.Col = 5
    oWs.Cells(8 + iRow, 5).Value = Me.grdConci.text
    Me.grdConci.Col = 6
    oWs.Cells(8 + iRow, 6).Value = Me.grdConci.text
    Me.grdConci.Col = 7
    oWs.Cells(8 + iRow, 7).Value = Me.grdConci.text
    Me.grdConci.Col = 8
    oWs.Cells(8 + iRow, 8).Value = Me.grdConci.text
    Me.grdConci.Col = 9
    oWs.Cells(8 + iRow, 9).Value = Me.grdConci.text
    Me.grdConci.Col = 10
    oWs.Cells(8 + iRow, 10).Value = Me.grdConci.text
    Me.grdConci.Col = 11
    oWs.Cells(8 + iRow, 11).Value = Me.grdConci.text
    Me.grdConci.Col = 12
    oWs.Cells(8 + iRow, 12).Value = Me.grdConci.text
    Screen.MousePointer = 0
Next iRow
oWs.Cells(13 + iRow, 1).Value = "TOTALES BANCO:"
oWs.Cells(13 + iRow, 1).Font.Bold = True
oWs.Cells(15 + iRow, 1).Value = Space(50) & "No." & Space(30) & "Valor"
oWs.Cells(15 + iRow, 1).Font.Bold = True
bco1 = lblOkBco & (Space(40 - Len(lblOkBco))) & lblOkBcoValor
oWs.Cells(16 + iRow, 1).Value = " Pagos Ok:" & Space(55) & bco1
bco2 = lblSoloBco & (Space(40 - Len(lblSoloBco))) & lblSoloBcoValor
oWs.Cells(17 + iRow, 1).Value = " Pagos solo en banco:" & Space(31) & bco2
bco3 = lblProcesBco & (Space(40 - Len(lblProcesBco))) & lblProcesBcoValor
oWs.Cells(18 + iRow, 1).Value = " Total procesados Bco:" & Space(29) & bco3
oWs.Cells(13 + iRow, 5).Value = "TOTALES EMPRESA:"
oWs.Cells(13 + iRow, 5).Font.Bold = True
oWs.Cells(15 + iRow, 5).Value = Space(50) & "No." & Space(30) & "Valor"
oWs.Cells(15 + iRow, 5).Font.Bold = True
emp1 = lblOkEmp & (Space(40 - Len(lblOkEmp))) & lblOkEmpValor
oWs.Cells(16 + iRow, 5).Value = " Pagos Ok:" & Space(55) & emp1
emp2 = lblSoloEmp & (Space(40 - Len(lblSoloEmp))) & lblSoloEmpValor
oWs.Cells(17 + iRow, 5).Value = " Pagos solo en Empresa:" & Space(26) & emp2
emp3 = lblProcesEmp & (Space(40 - Len(lblProcesEmp))) & lblProcesEmpValor
oWs.Cells(18 + iRow, 5).Value = " Total procesados Emp:" & Space(28) & emp3


'oExcelApp.Visible = True
Set oWs = Nothing
Set oExcelApp = Nothing
DoEvents
Exit Sub

ErrorHandler:
    Screen.MousePointer = vbDefault
    MsgBox err.Description & " (" & CStr(err.Number) & ")", vbExclamation, "Excel Export"
 '   On Error Resume Next
 '   oExcelApp.Quit
    Set oWs = Nothing
    Set oExcelApp = Nothing
End Sub


Private Sub PLExportaExcelCATEG()
Dim oExcelApp   As Object
Dim oWs         As Object
Dim oWb         As Object
Dim sXlsTemplate As String
Dim iRow As Integer
Dim iCol As Integer
Dim busqueda As String
Dim bco1, bco2, bco3 As String
Dim emp1, emp2, emp3 As String

On Error GoTo ErrorHandler
'sXlsTemplate = App.Path & "\xrptCATEG.xlt"    'lfcm 08-mayo-2009
sXlsTemplate = App.Path & "\xrptLUZ.xlt"       'lfcm 08-mayo-2009

Set oExcelApp = CreateObject("EXCEL.APPLICATION")
oExcelApp.Visible = False
oExcelApp.Workbooks.Open Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True
Set oWs = oExcelApp.ActiveSheet
Set oWb = oExcelApp.ActiveWorkbook

Set oWs = oExcelApp.ActiveSheet
'oWs.Cells(6, 1).Value = "      Reporte de Pagos de CATEG - Empresa: (" & Me.txt_empresa & ") " & Me.lbl_empresa      'lfcm 08-mayo-2009
oWs.Cells(6, 1).Value = "      Reporte de Pagos de LUZ - Empresa: (" & Me.txt_empresa & ") " & Me.lbl_empresa         'lfcm 08-mayo-2009
'oWs.Cells(8, 2).Value = "Fecha Consulta: " & CStr(Now)
'oWs.Cells(8, 6).Value = "Cantidad: " & Trim(lbl_registros)

'oWs.Range("A10:L10").Interior.ColorIndex = 15
'oWs.Range("A10:L10").Borders.LineStyle = 1

'oWs.Cells(8, 1).Value = busqueda
For iRow = 1 To Me.grdConci.Rows - 1
    Screen.MousePointer = 11
    Me.grdConci.Row = iRow
    Me.grdConci.Col = 1
    oWs.Cells(8 + iRow, 1).Value = Me.grdConci.text
    Me.grdConci.Col = 2
    oWs.Cells(8 + iRow, 2).Value = Me.grdConci.text
    Me.grdConci.Col = 3
    oWs.Cells(8 + iRow, 3).Value = Me.grdConci.text
    Me.grdConci.Col = 4
    oWs.Cells(8 + iRow, 4).Value = Me.grdConci.text
    Me.grdConci.Col = 5
    oWs.Cells(8 + iRow, 5).Value = Me.grdConci.text
    Me.grdConci.Col = 6
    oWs.Cells(8 + iRow, 6).Value = Me.grdConci.text
    Me.grdConci.Col = 7
    oWs.Cells(8 + iRow, 7).Value = Me.grdConci.text
    Me.grdConci.Col = 8
    oWs.Cells(8 + iRow, 8).Value = Me.grdConci.text
    Me.grdConci.Col = 9
    oWs.Cells(8 + iRow, 9).Value = Me.grdConci.text
    Me.grdConci.Col = 10
    oWs.Cells(8 + iRow, 10).Value = Me.grdConci.text
    Me.grdConci.Col = 11
    oWs.Cells(8 + iRow, 11).Value = Me.grdConci.text
    Me.grdConci.Col = 12
    oWs.Cells(8 + iRow, 12).Value = Me.grdConci.text
    Me.grdConci.Col = 13
    oWs.Cells(8 + iRow, 13).Value = Me.grdConci.text
    Me.grdConci.Col = 14
    oWs.Cells(8 + iRow, 14).Value = Me.grdConci.text
    Me.grdConci.Col = 15
    oWs.Cells(8 + iRow, 15).Value = Me.grdConci.text
    Me.grdConci.Col = 16
    oWs.Cells(8 + iRow, 16).Value = Me.grdConci.text
    
    'Me.grdConci.Col = 17
    'oWs.Cells(8 + iRow, 17).Value = Me.grdConci.Text
    
    'Me.grdConci.Col = 18
    'oWs.Cells(8 + iRow, 18).Value = Me.grdConci.Text
    
    
    Screen.MousePointer = 0
Next iRow
oWs.Cells(13 + iRow, 1).Value = "TOTALES BANCO:"
oWs.Cells(13 + iRow, 1).Font.Bold = True
oWs.Cells(15 + iRow, 1).Value = Space(50) & "No." & Space(30) & "Valor"
oWs.Cells(15 + iRow, 1).Font.Bold = True
bco1 = lblOkBco & (Space(40 - Len(lblOkBco))) & lblOkBcoValor
oWs.Cells(16 + iRow, 1).Value = " Pagos Ok:" & Space(55) & bco1
bco2 = lblSoloBco & (Space(40 - Len(lblSoloBco))) & lblSoloBcoValor
oWs.Cells(17 + iRow, 1).Value = " Pagos solo en banco:" & Space(31) & bco2
bco3 = lblProcesBco & (Space(40 - Len(lblProcesBco))) & lblProcesBcoValor
oWs.Cells(18 + iRow, 1).Value = " Total procesados Bco:" & Space(29) & bco3
oWs.Cells(13 + iRow, 5).Value = "TOTALES EMPRESA:"
oWs.Cells(13 + iRow, 5).Font.Bold = True
oWs.Cells(15 + iRow, 5).Value = Space(50) & "No." & Space(30) & "Valor"
oWs.Cells(15 + iRow, 5).Font.Bold = True
emp1 = lblOkEmp & (Space(40 - Len(lblOkEmp))) & lblOkEmpValor
oWs.Cells(16 + iRow, 5).Value = " Pagos Ok:" & Space(55) & emp1
emp2 = lblSoloEmp & (Space(40 - Len(lblSoloEmp))) & lblSoloEmpValor
oWs.Cells(17 + iRow, 5).Value = " Pagos solo en Empresa:" & Space(26) & emp2
emp3 = lblProcesEmp & (Space(40 - Len(lblProcesEmp))) & lblProcesEmpValor
oWs.Cells(18 + iRow, 5).Value = " Total procesados Emp:" & Space(28) & emp3


oExcelApp.Visible = True
Set oWs = Nothing
Set oExcelApp = Nothing
Exit Sub

ErrorHandler:
    Screen.MousePointer = vbDefault
    MsgBox err.Description & " (" & CStr(err.Number) & ")", vbExclamation, "Excel Export"
    On Error Resume Next
    oExcelApp.Quit
    Set oWs = Nothing
    Set oExcelApp = Nothing
End Sub

'INICIO (SIPECOM) LCHACHA OOF REF001
Private Sub PLExportaExcelCATEGOOF()
Dim oExcelApp   As Object
Dim oWs         As Object
Dim oWb         As Object
Dim sXlsTemplate As String
Dim iRow As Integer
Dim iCol As Integer
Dim busqueda As String
Dim bco1, bco2, bco3 As String
Dim emp1, emp2, emp3 As String


On Error GoTo ErrorHandler
'sXlsTemplate = App.Path & "\xrptCATEG.xlt"    'lfcm 08-mayo-2009

'INICIO (SIPECOM) LCHACHA OOF REF004
'sXlsTemplate = App.Path & "\xrptLUZ.xlt"       'lfcm 08-mayo-2009
Dim sNewXlsFile As String
sNewXlsFile = "xrptLUZ" & Format$(Now, "YYYYMMDDHHMMSS") + ".ods"
FileCopy App.Path & "\xrptLUZ.xlt", Environ$("tmp") & "\" & sNewXlsFile
sXlsTemplate = Environ$("tmp") & "\" & sNewXlsFile
'FIN (SIPECOM) LCHACHA OOF REF004

Set oExcelApp = CreateObject("HOJAELECTRONICABB.APPLICATION")
'oExcelApp.Visible = False
oExcelApp.Workbooks.OpenW Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True, DestinationFile:="Pantalla"
Set oWs = oExcelApp.ActiveSheet
Set oWb = oExcelApp.ActiveWorkbook

Set oWs = oExcelApp.ActiveSheet
'oWs.Cells(6, 1).Value = "      Reporte de Pagos de CATEG - Empresa: (" & Me.txt_empresa & ") " & Me.lbl_empresa      'lfcm 08-mayo-2009
oWs.Cells(6, 1).Value = "      Reporte de Pagos de LUZ - Empresa: (" & Me.txt_empresa & ") " & Me.lbl_empresa         'lfcm 08-mayo-2009
'oWs.Cells(8, 2).Value = "Fecha Consulta: " & CStr(Now)
'oWs.Cells(8, 6).Value = "Cantidad: " & Trim(lbl_registros)

'oWs.Range("A10:L10").Interior.ColorIndex = 15
'oWs.Range("A10:L10").Borders.LineStyle = 1

'oWs.Cells(8, 1).Value = busqueda
For iRow = 1 To Me.grdConci.Rows - 1
    Screen.MousePointer = 11
    Me.grdConci.Row = iRow
    Me.grdConci.Col = 1
    oWs.Cells(CLng(8 + iRow), 1).Value = Me.grdConci.text
    Me.grdConci.Col = 2
    oWs.Cells(CLng(8 + iRow), 2).Value = Me.grdConci.text
    Me.grdConci.Col = 3
    oWs.Cells(CLng(8 + iRow), 3).Value = Me.grdConci.text
    Me.grdConci.Col = 4
    oWs.Cells(CLng(8 + iRow), 4).Value = Me.grdConci.text
    Me.grdConci.Col = 5
    oWs.Cells(CLng(8 + iRow), 5).Value = Me.grdConci.text
    Me.grdConci.Col = 6
    oWs.Cells(CLng(8 + iRow), 6).Value = Me.grdConci.text
    Me.grdConci.Col = 7
    oWs.Cells(CLng(8 + iRow), 7).Value = Me.grdConci.text
    Me.grdConci.Col = 8
    oWs.Cells(CLng(8 + iRow), 8).Value = Me.grdConci.text
    Me.grdConci.Col = 9
    oWs.Cells(CLng(8 + iRow), 9).Value = Me.grdConci.text
    Me.grdConci.Col = 10
    oWs.Cells(CLng(8 + iRow), 10).Value = Me.grdConci.text
    Me.grdConci.Col = 11
    oWs.Cells(CLng(8 + iRow), 11).Value = Me.grdConci.text
    Me.grdConci.Col = 12
    oWs.Cells(CLng(8 + iRow), 12).Value = Me.grdConci.text
    Me.grdConci.Col = 13
    oWs.Cells(CLng(8 + iRow), 13).Value = Me.grdConci.text
    Me.grdConci.Col = 14
    oWs.Cells(CLng(8 + iRow), 14).Value = Me.grdConci.text
    Me.grdConci.Col = 15
    oWs.Cells(CLng(8 + iRow), 15).Value = Me.grdConci.text
    Me.grdConci.Col = 16
    oWs.Cells(CLng(8 + iRow), 16).Value = Me.grdConci.text
    
    'Me.grdConci.Col = 17
    'oWs.Cells(8 + iRow, 17).Value = Me.grdConci.Text
    
    'Me.grdConci.Col = 18
    'oWs.Cells(8 + iRow, 18).Value = Me.grdConci.Text
    
    Screen.MousePointer = 0
Next iRow
oWs.Cells(CLng(13 + iRow), 1).Value = "TOTALES BANCO:"
'oWs.Cells(CLng(13 + iRow), 1).Font.Bold = True
oWs.Cells(CLng(15 + iRow), 1).Value = Space(50) & "No." & Space(30) & "Valor"
'oWs.Cells(CLng(15 + iRow), 1).Font.Bold = True
bco1 = lblOkBco & (Space(40 - Len(lblOkBco))) & lblOkBcoValor
oWs.Cells(CLng(16 + iRow), 1).Value = " Pagos Ok:" & Space(55) & bco1
bco2 = lblSoloBco & (Space(40 - Len(lblSoloBco))) & lblSoloBcoValor
oWs.Cells(CLng(17 + iRow), 1).Value = " Pagos solo en banco:" & Space(31) & bco2
bco3 = lblProcesBco & (Space(40 - Len(lblProcesBco))) & lblProcesBcoValor
oWs.Cells(CLng(18 + iRow), 1).Value = " Total procesados Bco:" & Space(29) & bco3
oWs.Cells(CLng(13 + iRow), 5).Value = "TOTALES EMPRESA:"
'oWs.Cells(CLng(13 + iRow), 5).Font.Bold = True
oWs.Cells(CLng(15 + iRow), 5).Value = Space(50) & "No." & Space(30) & "Valor"
'oWs.Cells(CLng(15 + iRow), 5).Font.Bold = True
emp1 = lblOkEmp & (Space(40 - Len(lblOkEmp))) & lblOkEmpValor
oWs.Cells(CLng(16 + iRow), 5).Value = " Pagos Ok:" & Space(55) & emp1
emp2 = lblSoloEmp & (Space(40 - Len(lblSoloEmp))) & lblSoloEmpValor
oWs.Cells(CLng(17 + iRow), 5).Value = " Pagos solo en Empresa:" & Space(26) & emp2
emp3 = lblProcesEmp & (Space(40 - Len(lblProcesEmp))) & lblProcesEmpValor
oWs.Cells(CLng(18 + iRow), 5).Value = " Total procesados Emp:" & Space(28) & emp3

'oExcelApp.Visible = True
Set oWs = Nothing
Set oExcelApp = Nothing
DoEvents
Exit Sub

ErrorHandler:
    Screen.MousePointer = vbDefault
    MsgBox err.Description & " (" & CStr(err.Number) & ")", vbExclamation, "Excel Export"
  '  On Error Resume Next
  '  oExcelApp.Quit
    Set oWs = Nothing
    Set oExcelApp = Nothing
End Sub
'FIN (SIPECOM) LCHACHA OOF REF001


Sub PLProcesarTVCABLE()
    'Validacion de Estados
    If Me.optProc(0).Value = True Then      'Habilitar
        If Not (Me.cmdEstadoBco.text = "SI" And Me.cmbEstadoEmp.text = "NO") Then
            MsgBox "Estados deben ser: " & Chr(13) & "ESTADO BANCO = SI           " & Chr(13) & "ESTADO EMPRESA = NO", vbInformation + vbOKOnly, "TServi"
            Exit Sub
        End If
    ElseIf Me.optProc(1).Value = True Then  'Reversar
        If Not (Me.cmdEstadoBco.text = "NO" And Me.cmbEstadoEmp.text = "SI") Then
            MsgBox "Estados deben ser: " & Chr(13) & "ESTADO BANCO = NO           " & Chr(13) & "ESTADO EMPRESA = SI", vbInformation + vbOKOnly, "TServi"
            Exit Sub
        End If
    End If
    
    'Verificacion de que solo se envie los reversos o solo habilitar
'    Me.grdConci.Col = 6
'    If Me.optProc(0).Value = True Then      'Habilitar
'        For R% = 1 To Me.grdConci.Rows - 1
'            If Me.grdConci.Text = "POR REVERSAR" Then
'                MsgBox "Resultado no puede ser: POR REVERSAR "
'                Exit Sub
'            ElseIf Me.grdConci.Text = "REVERSADO" Then
'                MsgBox "Resultado no puede ser: REVERSADO "
'                Exit Sub
'            End If
'        Next R%
'    ElseIf Me.optProc(1).Value = True Then  'Reversar
'        For R% = 1 To Me.grdConci.Rows - 1
'            If Me.grdConci.Text = "POR HABILITAR" Then
'                MsgBox "Resultado no puede ser: POR HABILITAR "
'                Exit Sub
'            ElseIf Me.grdConci.Text = "HABILITADO" Then
'                MsgBox "Resultado no puede ser: HABILITADO "
'                Exit Sub
'            End If
'        Next R%
'    End If

    If optProc(0).Value = False Then
        'Lcod_resultado = 2
        'Lcod_resultado_new = 4
        Lcod_resultado = "POR REVERSAR"
        Lcod_resultado_new = "REVERSADO"
    Else
        Lcod_resultado = "POR HABILITAR"
        Lcod_resultado_new = "HABILITADO"
    End If
            

  For j% = 1 To Me.grdConci.Rows - 1
    grdConci.Row = j
    
        If Me.grdConci.CellForeColor = vbBlue Then
            PMChequea SqlConn&
            PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR%, "M"   'Procesar
            PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
            PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text)
            PMPasoValores SqlConn&, "@i_fecha_proceso", 0, SQLDATETIME, (dtFecha)
            PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, Me.cmdEstadoBco.text
            PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, Me.cmbEstadoEmp.text
            PMPasoValores SqlConn&, "@i_sec", 0, SQLVARCHAR, Me.grdConci.TextMatrix(j, 10)
            PMPasoValores SqlConn&, "@i_dc_resultado", 0, SQLVARCHAR, Lcod_resultado
            PMPasoValores SqlConn&, "@i_dc_resultado_new", 0, SQLVARCHAR, Lcod_resultado_new
            If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_tvcable", True, "Búsqueda de Datos") Then
                PMChequea SqlConn&
            End If
                Me.grdConci.CellForeColor = vbBlack
                Me.grdConci.CellFontBold = False
                Set Me.grdConci.CellPicture = Nothing
                Me.grdConci.CellAlignment = 6
        End If
    Next j%

    'Actualizo el Flex
    Me.PLBuscarTVCABLE (0)
    
End Sub

Sub PLConfirmaTvCable()

    'Agregar validacion de que si está seguro de Cerrar la Conciliacion
    Respuesta = MsgBox("Desea Cerrar la Conciliacion", vbInformation + vbOKCancel, "TServi")
    If Respuesta = vbCancel Then
        Exit Sub
    End If
    
    
    'Confimacion de Activacion de Casilla: Marcar Todos
    If Me.chkTodos.Value = False Then
        MsgBox "Seleccione la Casilla: Marcar Todos", vbInformation + vbOKOnly, "TServi"
        Exit Sub
    End If

    PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR%, "P"   'Procesar
    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
    PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text)
    PMPasoValores SqlConn&, "@i_fecha_proceso", 0, SQLDATETIME, (dtFecha)
    'PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, Me.cmdEstadoBco.Text
    'PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, Me.cmbEstadoEmp.Text
    'PMPasoValores SqlConn&, "@i_sec", 0, SQLVARCHAR, Me.grdConci.TextMatrix(j, 10)
    'PMPasoValores SqlConn&, "@i_dc_resultado", 0, SQLVARCHAR, Lcod_resultado
    'PMPasoValores SqlConn&, "@i_dc_resultado_new", 0, SQLVARCHAR, Lcod_resultado_new
    If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_tvcable", True, "Búsqueda de Datos") Then
        PMChequea SqlConn&    'lfcm 13-julio-2007
        MsgBox "La conciliacion se ha cerrado.", vbOKOnly + vbInformation, "TServi"
        PLGeneraArchivoAjuste
    Else
        PMChequea SqlConn&    'lfcm 13-julio-2007
        PLGeneraArchivoAjuste
    End If
End Sub

Sub PLGeneraArchivoAjuste()
    
    Dim BCO_TRANS_FI_NBR As String
    Dim BCO_TRANS_ABA_NBR As String
    Dim BCO_TRANS_BR_NBR As String
    Dim BCO_APPL_NAME As String
    Dim BCO_ACCT_NBR As String
    Dim BCO_TRML_NBR As String
    Dim BCO_TRML_SEQ_NBR As String
    Dim BCO_OPERATING_FI_NBR As String
    Dim BCO_OPERATING_ABA_NBR As String
    Dim BCO_OPERATING_BR_NBR As String
    Dim BCO_TRAN_CODE As String
    Dim BCO_RESULT_CODE As String
    Dim BCO_TRAN_DATE As String
    Dim BCO_TRAN_TIME As String
    Dim BCO_FORCE_POST_ID As String
    Dim BCO_REVERSAL_IND As String
    Dim BCO_TRML_RECEIPT_NBR As String
    Dim BCO_BUSINESS_DATE As String
    Dim BCO_CARD_FI_NBR As String
    Dim BCO_CARD_BR_NBR As String
    Dim BCO_CARD_ACCT_NBR As String
    Dim BCO_CARD_APPL_CODE As String
    Dim BCO_AUTH_METHOD As String
    Dim BCO_AMT_TRANSFER As String
    
    ExtraccionDataTVCABLE (0)
    
End Sub



Sub ExtraccionDataTVCABLE(orden As Integer)
'--> Inicio de Extraccion de Data para la Generación del Archivo
    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
    PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "G"   'G = Generacion Archivo Ajuste
    PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text)
    PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, orden
    PMPasoValores SqlConn&, "@i_fecha_proceso", 0, SQLDATETIME, (dtFecha)
    If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_tvcable", True, "Ok... Consulta de Pagos TVCABLE") Then
        If orden = 0 Then
            PgMapeaFlexG grdAlterno, True, False, 0, 20, 14
        Else
            PgMapeaFlexG grdAlterno, False, False, 0, 20, 14
        End If
        PMChequea SqlConn&
        If Me.grdAlterno.Tag = "15" Then
            Me.grdAlterno.Col = 1   'Secuencial
            Me.grdAlterno.Row = Me.grdAlterno.Rows - 1
            ExtraccionDataTVCABLE (Me.grdAlterno.text)
        End If
        ExtraeCatcifrado
    Else
        PMChequea SqlConn&    'lfcm 13-julio-2007
        Exit Sub
    End If     '--> Fin de Extraccion de Data para la Generación del Archivo
    
    VTFecha$ = Me.dtFecha '"01/31/07"
    VTFecha$ = Mid(VTFecha$, 1, 2) & "/" & Mid(VTFecha$, 4, 2) & "/" & Mid(VTFecha$, 9, 2)
    VTnombarch$ = Me.lbl_empresa & Mid(VTFecha$, 4, 2) & ".txt"
    Open "c:\cobis\tadmin\" & VTnombarch$ For Output As #1
    
    VTFilas% = 1
    
    While VTFilas% <= Me.grdAlterno.Rows - 1
        
        grdAlterno.Row = VTFilas%
        
        VTFilas% = VTFilas% + 1
        
        BCO_TRANS_FI_NBR$ = Format(1007, "0000")
        BCO_TRANS_ABA_NBR$ = Format(21281, "0000000000")
        BCO_TRANS_BR_NBR$ = Format(1, "0000")
        BCO_APPL_NAME$ = Format(1, "00")
        
        Me.grdAlterno.Col = 2   'Localidad
        localidad = Format(Me.grdAlterno.text, "000")
        Me.grdAlterno.Col = 3   'Factura
        factura = Format(Me.grdAlterno.text, "000000000000000")
        BCO_ACCT_NBR$ = Format(localidad & factura, "000000000000000000")
        
        BCO_TRML_NBR$ = Format(0, "00000")
        
        Me.grdAlterno.Col = 4   'Sec de la cc_tran_servicio
        BCO_TRML_SEQ_NBR$ = Format(Me.grdAlterno.text, "000000")
        
        BCO_OPERATING_FI_NBR$ = Format(999, "0000")
        
        BCO_OPERATING_ABA_NBR$ = Format(2000, "0000000000")
        BCO_OPERATING_BR_NBR$ = Format(0, "0000")
        
        
        'Me.grdAlterno.Col = 5   'Tipo de trx de TvCable
        'BCO_TRAN_CODE$ = Format(Me.grdAlterno.Text, "0000")
        Me.grdAlterno.Col = 12   'Tipo de trx de TvCable
        
        
        
         '-->lfcm 03-julio-2007 Obtener empresas TvCable
            PMChequea SqlConn&
            PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
            PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "H"
            PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Me.txt_empresa.text
            If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_tvcable", True, "") Then
                PMMapeaVariable SqlConn&, VLTrnCable$
                PMChequea SqlConn&
                If VLTrnCable$ = "" Then
                    'VLEmpTvCable = Me.txt_empresa.Text
                    MsgBox "Transaccion no definida para la empresa", vbInformation + vbOKOnly, "TServi"
                    PMChequea SqlConn&
                    Exit Sub
                End If
            Else
                VLEmpTvCable = ""
                PMChequea SqlConn&
            End If
            '--<lfcm 03-julio-2007 Obtener empresas TvCable
            
        If Me.grdAlterno.text = "HABILITADO" Then
            BCO_TRAN_CODE$ = Mid(Trim$(VLTrnCable$), 2, 4)
        ElseIf Me.grdAlterno.text = "REVERSADO" Then
            BCO_TRAN_CODE$ = Mid(Trim$(VLTrnCable$), 2, 4)
        Else
            BCO_TRAN_CODE$ = "999+"
        End If
            
        'lfcm 23/May/2007 Indicador para TvCable de : Habilitar o Reversar
        'Para el caso de las empresas de Television (334 - 335 - 337 - 336 - 338 - 843)
'        If Trim$(VLTrnCable$) = "0480+" Then
'            Select Case Me.grdAlterno.Text
'                Case "HABILITADO":
'                    BCO_TRAN_CODE$ = "480+"     '"480+" indica que el contrato se envia a pagar por parte del Banco
'                Case "REVERSADO":
'                    BCO_TRAN_CODE$ = "480-"     '"480-" indica que el contrato se envia a reversar por parte del Banco
'                Case Else
'                    BCO_TRAN_CODE$ = "999+"     '"999+" indica que no se envia ni a Reversar ni a Habilitar
'            End Select
'        End If
        
        
'        If Trim$(VLTrnCable$) = "0580+" Then
'            Select Case Me.grdAlterno.Text
'                Case "HABILITADO":
'                    BCO_TRAN_CODE$ = "580+"     '"580+" indica que el contrato se envia a pagar por parte del Banco
'                Case "REVERSADO":
'                    BCO_TRAN_CODE$ = "580-"     '"580-" indica que el contrato se envia a reversar por parte del Banco
'                Case Else
'                    BCO_TRAN_CODE$ = "999+"     '"999+" indica que no se envia ni a Reversar ni a Habilitar
'            End Select
'        End If
        
        
'        If Me.txt_empresa.Text = "334" Or Me.txt_empresa.Text = "335" Or Me.txt_empresa.Text = "336" _
'        Or Me.txt_empresa.Text = "337" Or Me.txt_empresa.Text = "338" Or Me.txt_empresa.Text = "843" Then
'            Select Case Me.grdAlterno.Text
'                Case "HABILITADO":
'                    BCO_TRAN_CODE$ = "480+"     '"480+" indica que el contrato se envia a pagar por parte del Banco
'                Case "REVERSADO":
'                    BCO_TRAN_CODE$ = "480-"     '"480-" indica que el contrato se envia a reversar por parte del Banco
'                Case Else
'                    BCO_TRAN_CODE$ = "999+"     '"999+" indica que no se envia ni a Reversar ni a Habilitar
'            End Select
'        End If
        
        'Para el caso de las empresas de Internet
'        If Me.txt_empresa.Text = "320" Or Me.txt_empresa.Text = "1538" Then
'            Select Case Me.grdAlterno.Text
'                Case "HABILITADO":
'                    BCO_TRAN_CODE$ = "580+"     '"580+" indica que el contrato se envia a pagar por parte del Banco
'                Case "REVERSADO":
'                    BCO_TRAN_CODE$ = "580-"     '"580-" indica que el contrato se envia a reversar por parte del Banco
'                Case Else
'                    BCO_TRAN_CODE$ = "999+"     '"999+" indica que no se envia ni a Reversar ni a Habilitar
'            End Select
'        End If
        
        Me.grdAlterno.Col = 6   'Banco ResultCode
        BCO_RESULT_CODE$ = Format(Me.grdAlterno.text, "0000")
        
        Me.grdAlterno.Col = 7   'Fecha Real del Pago
        BCO_TRAN_DATE$ = Mid(Me.grdAlterno.text, 9, 2) & Mid(Me.grdAlterno.text, 1, 2) & Mid(Me.grdAlterno.text, 4, 2)
        BCO_TRAN_DATE$ = Format(BCO_TRAN_DATE$, "000000")
        
        Me.grdAlterno.Col = 8   'Hora Real del Pago
        BCO_TRAN_TIME$ = Mid(Me.grdAlterno.text, 1, 2) & Mid(Me.grdAlterno.text, 4, 2) & Mid(Me.grdAlterno.text, 7, 2)
        BCO_TRAN_TIME$ = Format(BCO_TRAN_TIME$, "000000")
        
        BCO_FORCE_POST_ID$ = Format(0, "0")
        BCO_REVERSAL_IND$ = Format(0, "0")
        
        BCO_TRML_RECEIPT_NBR$ = Format(0, "000000")
        
        Me.grdAlterno.Col = 9   'Fecha de Proceso
        BCO_BUSINESS_DATE$ = Mid(Me.grdAlterno.text, 9, 2) & Mid(Me.grdAlterno.text, 1, 2) & Mid(Me.grdAlterno.text, 4, 2)
        BCO_BUSINESS_DATE$ = Format(BCO_BUSINESS_DATE$, "000000")
        
        BCO_CARD_FI_NBR$ = Format(0, "0000")
        BCO_CARD_BR_NBR$ = Format(0, "0000")
        
        BCO_CARD_ACCT_NBR$ = Format(0, "000000000000000000")
        
        Me.grdAlterno.Col = 10  'BCO_CARD_APPL_CODE
        BCO_CARD_APPL_CODE$ = Format(Me.grdAlterno.text, "00")
        
        BCO_AUTH_METHOD$ = Format(" ", " ")
        
        'Este campo debe venir con el ultimo digito cifrado
        Me.grdAlterno.Col = 11  'Valor
        BCO_AMT_TRANSFER$ = Format(Me.grdAlterno.text * 100, "00000000000000")
        Me.gridCifra.Col = 2        'Valor Cifrado
        'Me.gridCifra.Row = 0
        t% = 1
        While t% <= Me.gridCifra.Rows - 1
            Me.gridCifra.Row = t%
            If Right(BCO_AMT_TRANSFER$, 1) = Me.gridCifra.text Then
                Me.gridCifra.Col = 1        'Valor Real
                BCO_AMT_TRANSFER$ = Mid(BCO_AMT_TRANSFER$, 1, 13) & Me.gridCifra.text
            End If
             t% = t% + 1
        Wend
        
        VTLineal$ = BCO_TRANS_FI_NBR & BCO_TRANS_ABA_NBR & BCO_TRANS_BR_NBR & BCO_APPL_NAME
        VTLineal$ = VTLineal$ & BCO_ACCT_NBR & BCO_TRML_NBR & BCO_TRML_SEQ_NBR & BCO_OPERATING_FI_NBR
        VTLineal$ = VTLineal$ & BCO_OPERATING_ABA_NBR & BCO_OPERATING_BR_NBR & BCO_TRAN_CODE & BCO_RESULT_CODE
        VTLineal$ = VTLineal$ & BCO_TRAN_DATE & BCO_TRAN_TIME & BCO_FORCE_POST_ID & BCO_REVERSAL_IND
        VTLineal$ = VTLineal$ & BCO_TRML_RECEIPT_NBR & BCO_BUSINESS_DATE & BCO_CARD_FI_NBR & BCO_CARD_BR_NBR
        VTLineal$ = VTLineal$ & BCO_CARD_ACCT_NBR & BCO_CARD_APPL_CODE & BCO_AUTH_METHOD & BCO_AMT_TRANSFER
    
        Print #1, VTLineal$
        
    Wend

    Close #1    ' Close file.

    MsgBox "Archivo Generado Exitosamente", vbOKOnly + vbInformation, "TServi"
    
End Sub


Sub ExtraeCatcifrado()
    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
    PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "X"   'X = Cifrado para el valor
    If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_tvcable", True, "Ok... Consulta de Pagos TVCABLE") Then
        PgMapeaFlexG Me.gridCifra, True, False, 0, 20, 14
        'Me.gridCifra.Rows = Me.gridCifra.Rows - 1
    End If
    PMChequea SqlConn&
End Sub



'*************************************************************************************************
' CATEG CATEG CATEG CATEG CATEG CATEG CATEG CATEG CATEG CATEG CATEG CATEG CATEG CATEG CATEG CATEG
'*************************************************************************************************

'Sub PLBuscarCATEGUsuario(orden As Integer)      'lfcm 23-agosto-2008
Sub PLBuscarCATEGUsuario(orden As Long)          'lfcm 23-agosto-2008
   'Hago la consulta de los primeros 15 resultados
   PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
   PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "S"   'C = Consulta
   PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text)
   PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, orden
   PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
   PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, Me.cmdEstadoBco.text
   PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, Me.cmbEstadoEmp.text
   If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_categ", True, "Ok... Consulta de Pagos TVCABLE") Then
      If orden = 0 Then
         PgMapeaFlexG grdConci, True, False, 0, 15, 17
      Else
         PgMapeaFlexG grdConci, False, False, 0, 15, 17
      End If
      PMChequea SqlConn&
      If Me.grdConci.Tag = "15" Then
         Me.grdConci.Col = 13
         Me.grdConci.Row = Me.grdConci.Rows - 1
         PLBuscarCATEGUsuario (Me.grdConci.text)
      Else
         'Elimino la Columna donde traje los secueciales para la busqueda
         'Me.grdConci.Cols = 11
         Me.lbl_registros.Caption = (Me.grdConci.Rows - 1)
                
         'Formato al Grid
         Me.grdConci.ColWidth(1) = 1000  'Codigo
         Me.grdConci.ColWidth(2) = 2445  'Nombre Abonado
         Me.grdConci.ColWidth(3) = 1100  'Valor
         Me.grdConci.ColWidth(4) = 1100  'Fecha Cont.
         Me.grdConci.ColWidth(5) = 750   'Hora
         Me.grdConci.ColWidth(6) = 1300  'Resultado
         Me.grdConci.ColWidth(7) = 1100  'Status Bco
         Me.grdConci.ColWidth(8) = 1100  'Status Emp
         Me.grdConci.ColWidth(9) = 1200  'Cod.Usuario
         Me.grdConci.ColAlignment(9) = 7
         Me.grdConci.ColWidth(10) = 1200  'Usuario
         Me.grdConci.ColAlignment(10) = 7
         Me.grdConci.ColWidth(11) = 1100 'N° Autorizacion
         Me.grdConci.ColWidth(12) = 1100 'Secuencia MIT
         Me.grdConci.ColWidth(13) = 1100 'Secuencia IFI
         Me.grdConci.ColWidth(14) = 1100 'Secuencial
         Me.grdConci.ColWidth(15) = 1100 'Canal
         Me.grdConci.ColWidth(16) = 1100 'Est.Conc.
         'PLFormatoHora
         PLSacaTotalesCATEG   'Barrido del Grid para sacar totales
      End If
   Else
      PMLimpiaGrid Me.grdConci    'lfcm 21-feb-2008
        
      'Resultados
      Me.lblOkBco.Caption = "0"
      Me.lblSoloBco.Caption = "0"
      Me.lblProcesBco.Caption = "0"
      Me.lblOkBcoValor.Caption = "0.00"
      Me.lblSoloBcoValor.Caption = "0.00"
      Me.lblProcesBcoValor.Caption = "0.00"
        
      Me.lblOkEmp.Caption = "0"
      Me.lblSoloEmp.Caption = "0"
      Me.lblProcesEmp.Caption = "0"
      Me.lblOkEmpValor.Caption = "0.00"
      Me.lblSoloEmpValor.Caption = "0.00"
      Me.lblProcesEmpValor.Caption = "0.00"
      Me.lbl_registros = 0
   End If
   If Me.grdConci.Rows > 1 Then Me.grdConci.topRow = 1      'lfcm 28-feb-2008
   If Me.grdConci.Rows > 1 Then Me.grdConci.LeftCol = 1     'lfcm 28-feb-2008
    
End Sub



'Sub PLBuscarCATEGFile(orden As Integer)     'lfcm 23-agosto-2008
Sub PLBuscarCATEGFile(orden As Long)         'lfcm 23-agosto-2008

   'Hago la consulta de los primeros 15 resultados
   PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
   PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "C"   'C = Consulta
   PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text)
   PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, orden
   PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
   PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, Me.cmdEstadoBco.text
   PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, Me.cmbEstadoEmp.text
   If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_categ", True, "Ok... Consulta de Pagos TVCABLE") Then
      If orden = 0 Then
         PgMapeaFlexG grdAlterno, True, False, 0, 15, 21
      Else
         PgMapeaFlexG grdAlterno, False, False, 0, 15, 21
      End If
      
      PMChequea SqlConn&
      
      If Me.grdAlterno.Tag = "15" Then
         Me.grdAlterno.Col = 13
         Me.grdAlterno.Row = Me.grdAlterno.Rows - 1
         PLBuscarCATEGFile (Me.grdAlterno.text)
      Else
         'Elimino la Columna donde traje los secueciales para la busqueda
         'Me.grdConci.Cols = 11
         Me.lbl_registros.Caption = (Me.grdAlterno.Rows - 1)
         'Formato al Grid
         'Me.grdConci.ColWidth(1) = 1000  'Codigo
         'Me.grdConci.ColWidth(2) = 2445  'Nombre Abonado
         'Me.grdConci.ColWidth(3) = 1100  'Valor
         'Me.grdConci.ColWidth(4) = 1100  'Fecha Cont.
         'Me.grdConci.ColWidth(5) = 750   'Hora
         'Me.grdConci.ColWidth(6) = 1300  'Resultado
         'Me.grdConci.ColWidth(7) = 1100  'Status Bco
         'Me.grdConci.ColWidth(8) = 1100  'Status Emp
         'Me.grdConci.ColWidth(9) = 1000  'Usuario
         'Me.grdConci.ColWidth(10) = 1100 'N° Autorizacion
         'Me.grdConci.ColWidth(11) = 1100 'Secuencial
         'Me.grdConci.ColWidth(11) = 1100 'Secuencial
         'Me.grdConci.ColWidth(12) = 1100 'Tipo Transaccion
         'Me.grdConci.ColWidth(12) = 0 'Tipo Transaccion
         'Me.grdConci.ColWidth(13) = 0  'Campo Autonumerico
         'Me.grdConci.ColWidth(14) = 1100  'Numero de Factura
         'Me.grdAlterno.ColWidth(15) = 1100  'Numero de Factura
         'Me.grdAlterno.ColWidth(19) = 1000  'Codigo de Resultado
         'Me.grdAlterno.ColWidth(20) = 1100  'Estado de Conciliacion
      End If
      
   Else
      PMLimpiaGrid Me.grdAlterno    'lfcm 21-feb-2008
   End If
End Sub




Sub PLConfirmaCATEG()
    'Agregar validacion de que si está seguro de Cerrar la Conciliacion
    Respuesta = MsgBox("Desea Cerrar la Conciliacion", vbInformation + vbOKCancel, "TServi")
    If Respuesta = vbCancel Then
        Exit Sub
    End If
    
    'Confimacion de Activacion de Casilla: Marcar Todos
    If Me.chkTodos.Value = False Then
        MsgBox "Seleccione la Casilla: Marcar Todos", vbInformation + vbOKOnly, "TServi"
        Exit Sub
    End If

    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
    PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR%, "X"
    PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text)
    PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, 0
    PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
    PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, ""
    PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, ""
    
    '-->20-marzo-2008
    'Agregar parametro de Output que indique si hay data cargada en la conciliación de ese día.
    PMPasoValores SqlConn, "@o_existe", 1, SQLCHAR, Space(1)
    '--<20-marzo-2008
    
    If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_categ", True, "Búsqueda de Datos") Then
        PMChequea SqlConn&
        MsgBox "La conciliacion se ha cerrado.", vbOKOnly + vbInformation, "TServi"
        
        'Me.PLBuscarCATEGFile (0)
        'PLGeneraArchivoConciliaCATEG
        
        vlexiste = FMRetParam(SqlConn, 1)
        If vlexiste = "S" Then
           Me.PLBuscarCATEGFile (0)
           PLGeneraArchivoConciliaCATEG
        Else
           'En el caso de que no exista recaudacion o conciliacion de esta fecha
           'se debe generar un registro con la cabecera unicamente.
           PLGeneraArchivoNoHayRecaudacion
        End If

    
    Else
        PMChequea SqlConn&
        vlexiste = FMRetParam(SqlConn, 1)
        If vlexiste = "S" Then
           Me.PLBuscarCATEGFile (0)
           PLGeneraArchivoConciliaCATEG
        Else
           'En el caso de que no exista recaudacion o conciliacion de esta fecha
           'se debe generar un registro con la cabecera unicamente.
           PLGeneraArchivoNoHayRecaudacion
        End If
    End If
    PLBuscarCATEGUsuario (0)  'Luego de la confirmacion realizo nuevamente la consulta _
                              para refrescar la columna que muestra el estado de la _
                              conciliacion en Pantalla
    Me.chkTodos.Value = False
    If Me.grdConci.Rows > 1 Then Me.grdConci.topRow = 1      'lfcm 28-feb-2008
    If Me.grdConci.Rows > 1 Then Me.grdConci.LeftCol = 1     'lfcm 28-feb-2008
End Sub


Sub PLGeneraArchivoConciliaCATEG()
 
    'Aplico formato al campo hora
    FormateoCampoHora

    'Abro el archivo para comenzar a grabar el detalle.
    'VTnombarch$ = "BANBBO" & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2) & ".DAT"
    'VTnombarch$ = "BANBOL" & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2) & ".DAT"
    If Me.txt_empresa.text = 1 Then
       VTnombarch$ = "BANBOL" & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2) & ".DAT"
    ElseIf Me.txt_empresa.text = 1127 Then
       VTnombarch$ = "BANCBOL" & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2) & Mid(Me.dtFecha, 9, 2) & ".DAT"
    End If
    
    If Me.grdAlterno.Rows = 1 Then Exit Sub   'lfcm 08-mayo-2009
    Open "c:\cobis\tadmin\" & VTnombarch$ For Output As #1

    'Registro de Cabecera
    FechaProceso$ = Mid(Me.dtFecha, 7, 4) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2)
    FechaRecaudacion$ = Mid(Me.dtFecha, 7, 4) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2)
    CodigoIfi$ = "0024"
    
    'Obtener el total recaudado
    Dim VLTotRecauda As Currency
    For t% = 1 To Me.grdAlterno.Rows - 1
        Me.grdAlterno.Row = t%
        Me.grdAlterno.Col = 6     'Columna que tiene el estado de la Conciliacion(OK-CA-BO)
        If Me.grdAlterno.text = "OK" Or Me.grdAlterno.text = "BO" Then
            Me.grdAlterno.Col = 3
            VLTotRecauda = VLTotRecauda + Me.grdAlterno.text
        End If
    Next t%
    
    VLCodSeg$ = ""
    'Codigo de seguridad asignado por la CATEG al BCO
    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
    PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "T"   'T = Parametro de Seguridad asigando al Banco
    PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text)
    PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, 0
    PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
    PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, Me.cmdEstadoBco.text
    PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, Me.cmbEstadoEmp.text
    'PMPasoValores SqlConn&, "@o_codseg", 1, SQLINT4, 0
    PMPasoValores SqlConn&, "@o_codseg", 1, SQLVARCHAR, "        "
    If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_categ", True, "Ok... Consulta de Pagos TVCABLE") Then
        PMChequea SqlConn
        VLCodSeg$ = FMRetParam$(SqlConn&, 1)
    End If
    
    'TotalRecaudado$ = "888888888888"
    TotalRecaudado$ = CStr(VLTotRecauda * 100)
    TotalRecaudado$ = Format(TotalRecaudado$, "000000000000")
    VLSpaces$ = String(105, "0")
    
    'Grabo el Registro de Cabecera
    VTLineal$ = "C"
    VTLineal$ = VTLineal$ + FechaProceso$ + FechaRecaudacion$ + CodigoIfi$
    VTLineal$ = VTLineal$ + TotalRecaudado$ + VLCodSeg$ + VLSpaces$
    Print #1, VTLineal$



    'Registro de Detalle
    Me.grdAlterno.Row = 1
    For j% = 1 To Me.grdAlterno.Rows - 1
    Me.grdAlterno.Row = j%
    
    FechaProceso$ = Mid(Me.dtFecha, 7, 4) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2)
    VLTipoMsg$ = "0210"
    VLTipoTrx$ = "000101"
    
    'Codigo de Cuenta
    Me.grdAlterno.Col = 1
    VLCodCuenta$ = Me.grdAlterno.text + Mid("                   ", 1, 19 - Len(Me.grdAlterno.text))
    
    'Numero de Factura
    Me.grdAlterno.Col = 14
    VLNumFactura$ = Mid("00000000000000000000", 1, 20 - Len(Me.grdAlterno.text)) + Me.grdAlterno.text
    
    'Codigo Ifi
    VLCodIfi$ = "0024"
    
    'Fecha Trx Local
    Me.grdAlterno.Col = 4
    VLFechaTrxLocal$ = Mid(Me.grdAlterno.text, 7, 4) & Mid(Me.grdAlterno.text, 1, 2) & Mid(Me.grdAlterno.text, 4, 2)
    VLFechaTrxLocal$ = Format(VLFechaTrxLocal$, "00000000")
    
    'Hora de Trx Local
    Me.grdAlterno.Col = 5
    VLHoraTrxLocal$ = Trim(Me.grdAlterno.text)
    VLHoraTrxLocal$ = Mid(VLHoraTrxLocal$, 1, 2) & Mid(VLHoraTrxLocal$, 3, 2) & Mid(VLHoraTrxLocal$, 5, 2)
    VLHoraTrxLocal$ = Format(VLHoraTrxLocal$, "000000")
    
    
    
    'Codigo de Operador
    Me.grdAlterno.Col = 9
    VLCodOperador$ = Trim(Me.grdAlterno.text)
    VLCodOperador$ = VLCodOperador$ + Mid("      ", 1, 6 - Len(VLCodOperador$))
    
    'Secuencia Ifi
    Me.grdAlterno.Col = 15
    VLSecIfi$ = Right(Me.grdAlterno.text, 6)
    VLSecIfi$ = Mid("000000", 1, 6 - Len(VLSecIfi$)) + VLSecIfi$
    
    
    'Codigo de Resultado
    VLCodResultado$ = ""
    VLEstBanco$ = ""
    VLEstCateg$ = ""
    'Me.grdConci.Col = 7
    'VLEstBanco$ = Trim(Me.grdConci.Text)
    'Me.grdConci.Col = 8
    'VLEstCateg$ = Trim(Me.grdConci.Text)
    'If VLEstBanco = "SI" And VLEstCateg = "SI" Then
    '    VLCodResultado$ = "00"
    'ElseIf VLEstBanco = "SI" And VLEstCateg = "NO" Then
    '    VLCodResultado$ = "01"
    'ElseIf VLEstBanco = "NO" And VLEstCateg = "SI" Then
    '    VLCodResultado$ = "02"
    'ElseIf VLEstBanco = "NO" And VLEstCateg = "NO" Then
    '    VLCodResultado$ = "03"
    'End If
    
    
    Me.grdAlterno.Col = 19
    VLCodResultado$ = Mid("00", 1, 2 - Len(grdAlterno.text)) + grdAlterno.text
    
    
    'Codigo Agencia
    'Me.grdConci.Col = 16
    'VLCodAgencia$ = Trim(Me.grdConci.Text)
    'VLCodAgencia$ = Mid("000000", 1, 6 - Len(VLCodAgencia$)) + VLCodAgencia$
    
    
    'Codigo de autorizacion
    Me.grdAlterno.Col = 10
    VLCodAutorizacion$ = Right(Me.grdAlterno.text, 6)    'Para el caso de los sec del Banco tomo los 6 ultimos
    VLCodAutorizacion$ = Mid("000000", 1, 6 - Len(VLCodAutorizacion$)) + VLCodAutorizacion$
    
    'Secuencia MIT
    Me.grdAlterno.Col = 11
    VLSecMit$ = Trim(Me.grdAlterno.text)
    VLSecMit$ = Mid("000000", 1, 6 - Len(VLSecMit$)) + VLSecMit$
    
    'Codigo Terminal
    Me.grdAlterno.Col = 16
    'Me.grdConci.Col = 9
    VLCodTerminal$ = Trim(Me.grdAlterno.text)
    'VLCodTerminal$ = Mid("0024000000000000", 1, 16 - Len(VLCodTerminal$)) + VLCodTerminal$ 'gmartillo 12/03/2008
   
    'Canal
    Me.grdAlterno.Col = 17
    VLCanal$ = Mid("   ", 1, 3 - Len(Me.grdAlterno.text)) + Me.grdAlterno.text
    
   'If VLCanal$ <> "DBA" Then 'gmartillo 12/03/2008
   If VLCanal$ <> "DAT" Then 'gmartillo 04/14/2009
       VLCodTerminal$ = Mid("0024000000000000", 1, 16 - Len(VLCodTerminal$)) + VLCodTerminal$ 'gmartillo 12/03/2008
    Else 'gmartillo 12/03/2008
       VLCodTerminal$ = VLCodTerminal$ + Mid("                ", 1, 16 - Len(VLCodTerminal$)) 'gmartillo 12/03/2008
    End If
   
    
    'If VLCanal$ = "DBA" Then gmartillo 12/03/2008
       ' VLCanal$ = "DAT" gmartillo 12/03/2008
    'End If gmartillo 12/03/2008
        
    'Valor Recaudado
    Me.grdAlterno.Col = 3
    VLValRecaudado$ = Format(Me.grdAlterno.text * 100, "000000000000")
    
    'Valor Adeudado
    Me.grdAlterno.Col = 18
    If Me.grdAlterno.text >= 0 Then
        VLValAdeudado$ = Format(Me.grdAlterno.text * 100, "000000000000")
    Else
        VLValAdeudado$ = Format(Me.grdAlterno.text * 100, "00000000000")
    End If
   
    'Estado de Conciliacion
    Me.grdAlterno.Col = 7
    VLEstBanco$ = Trim(Me.grdAlterno.text)
    Me.grdAlterno.Col = 8
    VLEstCateg$ = Trim(Me.grdAlterno.text)
    If VLEstBanco = "SI" And VLEstCateg = "SI" Then
        VLEstConcilia$ = "0"
    ElseIf VLEstBanco = "SI" And VLEstCateg = "NO" Then
        If VLCanal$ = "DAT" Then
           VLEstConcilia$ = "4"
        Else
           VLEstConcilia$ = "3"
        End If
    ElseIf VLEstBanco = "NO" And VLEstCateg = "SI" Then
        VLEstConcilia$ = "2"
    ElseIf VLEstBanco = "NO" And VLEstCateg = "NO" Then
        VLEstConcilia$ = "03"
    End If
    
    'Grabo el registro de Detalle
    VTLineal$ = "D"
    VTLineal$ = VTLineal$ + FechaProceso$ + VLTipoMsg$ + VLTipoTrx$ + VLCodCuenta$
    VTLineal$ = VTLineal$ + VLNumFactura$ + VLCodIfi$ + VLHoraTrxLocal$ + VLFechaTrxLocal$
    VTLineal$ = VTLineal$ + VLCodOperador$ + VLCodResultado$ + VLCodAutorizacion$ + VLSecIfi$
    VTLineal$ = VTLineal$ + VLCodTerminal$ + VLSecMit + VLCanal
    VTLineal$ = VTLineal$ + VLValAdeudado$ + VLValRecaudado$ + VLEstConcilia$

    Print #1, VTLineal$
    'Debug.Print VTLineal$
   
    Next j%
 
    'Cierro el archivo y muestro mensaje indicando la generacion exitosa del mismo.
    Close #1
    MsgBox "Archivo Generado Exitosamente", vbOKOnly + vbInformation, "TServi"

End Sub

Sub FormateoCampoHora()
    If Me.grdAlterno.Rows > 2 Then
       'Validar que el GRID TENGA REGISTROS. IMPORTANTE !!! DESARROLLAR
       Me.grdAlterno.Col = 5
       For s% = 2 To Me.grdAlterno.Rows - 1
          Me.grdAlterno.Row = s%
          Me.grdAlterno.text = Replace(Me.grdAlterno.text, ":", "")
       Next s
    End If
End Sub


Sub PLGeneraArchivoNoHayRecaudacion()
   'VTnombarch$ = "BANBOL" & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2) & ".DAT"
   If Me.txt_empresa.text = 1 Then
      VTnombarch$ = "BANBOL" & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2) & ".DAT"
   ElseIf Me.txt_empresa.text = 1127 Then
      VTnombarch$ = "BANCBOL" & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2) & Mid(Me.dtFecha, 9, 2) & ".DAT"
   End If
   
   
   Open "c:\cobis\tadmin\" & VTnombarch$ For Output As #1

    VLCodSeg$ = ""
    'Codigo de seguridad asignado por la CATEG al BCO
    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
    PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "T"   'T = Parametro de Seguridad asigando al Banco
    PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text)
    PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, 0
    PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
    PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, Me.cmdEstadoBco.text
    PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, Me.cmbEstadoEmp.text
    'PMPasoValores SqlConn&, "@o_codseg", 1, SQLINT4, 0
    PMPasoValores SqlConn&, "@o_codseg", 1, SQLVARCHAR, "        "
    If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_categ", True, "Ok... Consulta de Pagos TVCABLE") Then
        PMChequea SqlConn
        VLCodSeg$ = FMRetParam$(SqlConn&, 1)
    End If

   FechaProceso$ = Mid(Me.dtFecha, 7, 4) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2)
   FechaRecaudacion$ = Mid(Me.dtFecha, 7, 4) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2)
   CodigoIfi$ = "0024"
   TotalRecaudado$ = Format(0, "000000000000")
   VLSpaces$ = String(105, "0")

   VTLineal$ = ""
   VTLineal$ = "C"
   VTLineal$ = VTLineal$ + FechaProceso$ + FechaRecaudacion$ + CodigoIfi$
   VTLineal$ = VTLineal$ + TotalRecaudado$ + VLCodSeg$ + VLSpaces$

   Print #1, VTLineal$
   Close #1
   MsgBox "Archivo Generado Exitosamente", vbOKOnly + vbInformation, "TServi"

End Sub

'********* TC el procedimiento busca las conciliaciones del IESS que estan pendientes de conciliar
Sub PLBuscarIESS(orden As Long)
Dim VResul As String
    chkTodos.Value = 0
   'Hago la consulta de los primeros 15 resultados
   PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
   PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "S"   'C = Consulta
   PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text)
   PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, orden
   PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
   PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, Me.cmdEstadoBco.text
   PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, Me.cmbEstadoEmp.text
   If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_iess", True, "Ok... Consulta de Pagos IESS") Then
      If orden = 0 Then
         PgMapeaFlexG grdConci, True, False, 0, 15, 14
      Else
         PgMapeaFlexG grdConci, False, False, 0, 15, 14
      End If
      PMChequea SqlConn&
      If Me.grdConci.Tag = "15" Then
         Me.grdConci.Col = 11
         Me.grdConci.Row = Me.grdConci.Rows - 1
         PLBuscarIESS (Me.grdConci.text)
      Else
         'Elimino la Columna donde traje los secueciales para la busqueda
         Me.lbl_registros.Caption = (Me.grdConci.Rows - 1)
                
         'Formato al Grid
         Me.grdConci.ColWidth(1) = 1700  'Codigo
         Me.grdConci.ColWidth(2) = 2445  'Nombre Abonado
         Me.grdConci.ColWidth(3) = 1100  'Valor
         Me.grdConci.ColWidth(4) = 1100  'Fecha Cont.
         Me.grdConci.ColWidth(5) = 750   'Hora
         Me.grdConci.ColWidth(6) = 2300  'Resultado
         Me.grdConci.ColWidth(7) = 1100  'Status Bco
         Me.grdConci.ColWidth(8) = 1100  'Status Emp
         Me.grdConci.ColWidth(9) = 1200  'Usuario
         Me.grdConci.ColWidth(10) = 1100  'autorizacion
         Me.grdConci.ColAlignment(10) = 7
         Me.grdConci.ColWidth(11) = 1100 'N° Autorizacion
         Me.grdConci.ColWidth(12) = 1100 'Secuencia MIT
         Me.grdConci.ColWidth(13) = 0 'estado conciliacion
         PLSacaTotalesCATEG   'Barrido del Grid para sacar totales
         
         'activa botones de confirmacion y proceso
         If (Me.cmdEstadoBco.text <> "TODOS" Or Me.cmbEstadoEmp.text <> "TODOS") Then
            cmdBoton(1).Enabled = False
            cmdBoton(4).Enabled = False
         Else
            cmdBoton(1).Enabled = True
            cmdBoton(4).Enabled = False
         End If
         VScierre = "N"
         For k% = 1 To (grdConci.Rows - 1)
            grdConci.Row = k%
            grdConci.Col = 6
            VResul = Trim(grdConci.text)
            grdConci.Row = k%
            grdConci.Col = 13
            If Trim(grdConci.text) = "" And VResul <> "OK" Then
                cmdBoton(1).Enabled = False
                cmdBoton(4).Enabled = True
                Exit For
            End If
            If Trim(grdConci.text) = "S" Then
                VScierre = "S"
                Exit For
            End If
          Next k
          
      End If
      
   Else
      PMLimpiaGrid Me.grdConci
        
      'Resultados
      Me.lblOkBco.Caption = "0"
      Me.lblSoloBco.Caption = "0"
      Me.lblProcesBco.Caption = "0"
      Me.lblOkBcoValor.Caption = "0.00"
      Me.lblSoloBcoValor.Caption = "0.00"
      Me.lblProcesBcoValor.Caption = "0.00"
        
      Me.lblOkEmp.Caption = "0"
      Me.lblSoloEmp.Caption = "0"
      Me.lblProcesEmp.Caption = "0"
      Me.lblOkEmpValor.Caption = "0.00"
      Me.lblSoloEmpValor.Caption = "0.00"
      Me.lblProcesEmpValor.Caption = "0.00"
      Me.lbl_registros = 0
   End If
   
   If Me.grdConci.Rows > 1 Then Me.grdConci.topRow = 1
   If Me.grdConci.Rows > 1 Then Me.grdConci.LeftCol = 1
    
End Sub


Sub PLBuscarPorta(orden As Long)
Dim VResul As String
    chkTodos.Value = 0
   'Hago la consulta de los primeros 15 resultados
   PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 4851
  ' PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "S"
   'PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.Text)
   PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT4, Trim(txt_empresa.text) 'CONECEL TVS dpereirv
   PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, orden
   PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
   PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, Me.cmdEstadoBco.text
   PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, Me.cmbEstadoEmp.text
   If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_porta_S", True, "Ok... Consulta de Pagos Porta") Then
      If orden = 0 Then
         PgMapeaFlexG grdConci, True, False, 0, 15, 14
      Else
         PgMapeaFlexG grdConci, False, False, 0, 15, 14
      End If
      PMChequea SqlConn&
      If Me.grdConci.Tag = "15" Then
         Me.grdConci.Col = 11
         Me.grdConci.Row = Me.grdConci.Rows - 1
         PLBuscarPorta (Me.grdConci.text)
      Else
         'Elimino la Columna donde traje los secueciales para la busqueda
         Me.lbl_registros.Caption = (Me.grdConci.Rows - 1)
                
         'Formato al Grid
         Me.grdConci.ColWidth(1) = 1700  'Codigo
         Me.grdConci.ColWidth(2) = 2445  'Nombre Abonado
         Me.grdConci.ColWidth(3) = 1100  'Valor
         Me.grdConci.ColWidth(4) = 1100  'Fecha Cont.
         Me.grdConci.ColWidth(5) = 750   'Hora
         Me.grdConci.ColWidth(6) = 2300  'Resultado
         Me.grdConci.ColWidth(7) = 1100  'Status Bco
         Me.grdConci.ColWidth(8) = 1100  'Status Emp
         Me.grdConci.ColWidth(9) = 1200  'Usuario
         Me.grdConci.ColWidth(10) = 1100  'autorizacion
         Me.grdConci.ColAlignment(10) = 7
         Me.grdConci.ColWidth(11) = 1100 'Secuencia MIT 'N° Autorizacion
         Me.grdConci.ColWidth(12) = 1100 ' referencia 'Secuencia MIT
         Me.grdConci.ColWidth(13) = 0 'estado conciliacion
         PLSacaTotalesCATEG   'Barrido del Grid para sacar totales
         
         'activa botones de confirmacion y proceso
         If (Me.cmdEstadoBco.text <> "TODOS" Or Me.cmbEstadoEmp.text <> "TODOS") Then
            cmdBoton(1).Enabled = False
            cmdBoton(4).Enabled = False
         Else
            cmdBoton(1).Enabled = True
            cmdBoton(4).Enabled = False
         End If
         VScierre = "N"
         For k% = 1 To (grdConci.Rows - 1)
            grdConci.Row = k%
            grdConci.Col = 6
            VResul = Trim(grdConci.text)
            grdConci.Row = k%
            grdConci.Col = 13
            If Trim(grdConci.text) = "" And VResul <> "OK" Then
                cmdBoton(1).Enabled = False
                cmdBoton(4).Enabled = True
                Exit For
            End If
            If Trim(grdConci.text) = "S" Then
                VScierre = "S"
                Exit For
            End If
          Next k
          
      End If
      
   Else
      PMLimpiaGrid Me.grdConci
        
      'Resultados
      Me.lblOkBco.Caption = "0"
      Me.lblSoloBco.Caption = "0"
      Me.lblProcesBco.Caption = "0"
      Me.lblOkBcoValor.Caption = "0.00"
      Me.lblSoloBcoValor.Caption = "0.00"
      Me.lblProcesBcoValor.Caption = "0.00"
        
      Me.lblOkEmp.Caption = "0"
      Me.lblSoloEmp.Caption = "0"
      Me.lblProcesEmp.Caption = "0"
      Me.lblOkEmpValor.Caption = "0.00"
      Me.lblSoloEmpValor.Caption = "0.00"
      Me.lblProcesEmpValor.Caption = "0.00"
      Me.lbl_registros = 0
   End If
   
   If Me.grdConci.Rows > 1 Then Me.grdConci.topRow = 1
   If Me.grdConci.Rows > 1 Then Me.grdConci.LeftCol = 1
    
End Sub

Public Function PLProcesoCTG(ParOpcion1 As String, ParOpcion2 As Long, ParOpcion3 As String, ParOpcion4 As String) As Boolean

'*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-'
'Autor: German Medina C.                                       '
'Fecha: 06-Ago-2008                                            '
'Descripcion: Metodo que realiza los procesos necesarios para  '
'             la conciliacion de pagos con la CTG              '
'Opciones: Funciones del parametro parOpcion1                  '
'          0 - Consulta de pagos pendientes                    '
'          1 - Procesa ajustes de conciliacion                 '
'          2 - Confirmacion de la conciliacion                 '
'          3 - Genera el reporte de la conciliacion            '
'*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-'

    On Error GoTo Error
    Dim VResul As String
    
    Select Case ParOpcion1
        Case "0" 'OK
        '0 - Consulta de pagos pendientes
            chkTodos.Value = 0
            
            PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
            PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "S"
            PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT4, Trim(txt_empresa.text)
            PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, ParOpcion2
            PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
            If Me.cmdEstadoBco.text <> "TODOS" Then
                PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, Me.cmdEstadoBco.text
            End If
            If Me.cmbEstadoEmp.text <> "TODOS" Then
                PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, Me.cmbEstadoEmp.text
            End If
            If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_ctg", True, "Ok... Consulta de Pagos CTG") Then
                If ParOpcion2 = 0 Then
                   PgMapeaFlexG grdConci, True, False, 0, 17, 15  'msilvag Junio/23/2016 cnb fase 2
                   'PgMapeaFlexG grdConci, True, False, 0, 15, 13 'msilvag Junio/23/2016 cnb fase 2
                Else
                   PgMapeaFlexG grdConci, False, False, 0, 17, 15   'msilvag Junio/23/2016 cnb fase 2
                   'PgMapeaFlexG grdConci, False, False, 0, 15, 13 'msilvag Junio/23/2016 cnb fase 2
                End If
                PMChequea SqlConn&
                
            If Me.grdConci.Tag = "15" Then
                Me.grdConci.Col = 10
                Me.grdConci.Row = Me.grdConci.Rows - 1
                'PLBuscarIESS (Me.grdConci.Text)
                Call PLProcesoCTG("0", Me.grdConci.text, "", "")
            Else
                'Elimino la Columna donde traje los secueciales para la busqueda
                Me.lbl_registros.Caption = (Me.grdConci.Rows - 1)
                
                'Formato al Grid
                Me.grdConci.ColWidth(1) = 1700  'CEP
                Me.grdConci.ColWidth(2) = 2445  'Nombre
                Me.grdConci.ColWidth(3) = 1100  'Valor
                Me.grdConci.ColWidth(4) = 1100  'Fecha Cont.
                Me.grdConci.ColWidth(5) = 850   'Hora
                Me.grdConci.ColWidth(6) = 2300  'Resultado
                Me.grdConci.ColWidth(7) = 1100  'Status Bco
                Me.grdConci.ColWidth(8) = 1100  'Status Emp
                Me.grdConci.ColWidth(9) = 1200  'Usuario
                Me.grdConci.ColWidth(10) = 1200  'Secuencial
                'Me.grdConci.ColWidth(10) = 1100  'autorizacion
                'Me.grdConci.ColAlignment(10) = 7
                'Me.grdConci.ColWidth(11) = 1100 'N° Autorizacion
                'Me.grdConci.ColWidth(12) = 1100 'Secuencia MIT
                Me.grdConci.ColWidth(11) = 1100 'Tipo_trn
                Me.grdConci.ColWidth(12) = 1100 'msilvag Junio/23/2016 cnb fase 2 'estado conciliacion
                'Me.grdConci.ColWidth(12) = 0 'msilvag Junio/23/2016 cnb fase 2 'estado conciliacion
                
                PLSacaTotalesCATEG   'Barrido del Grid para sacar totales
                
                'activa botones de confirmacion y proceso
                If (Me.cmdEstadoBco.text <> "TODOS" Or Me.cmbEstadoEmp.text <> "TODOS") Then
                    cmdBoton(1).Enabled = False
                    cmdBoton(4).Enabled = False
                Else
                    cmdBoton(1).Enabled = True
                    cmdBoton(4).Enabled = False
                End If
                VScierre = "N"
                For k% = 1 To (grdConci.Rows - 1)
                    grdConci.Row = k%
                    grdConci.Col = 6
                    VResul = Trim(grdConci.text)
                    grdConci.Row = k%
                    grdConci.Col = 12
                    If Trim(grdConci.text) = "" And VResul <> "OK" Then
                        cmdBoton(1).Enabled = False
                        cmdBoton(4).Enabled = True
                        Exit For
                    End If
                    If Trim(grdConci.text) = "S" Then
                        VScierre = "S"
                        Exit For
                    End If
                Next k
            
            End If
            
            Else
                PMLimpiaGrid Me.grdConci
                
                'Resultados
                Me.lblOkBco.Caption = "0"
                Me.lblSoloBco.Caption = "0"
                Me.lblProcesBco.Caption = "0"
                Me.lblOkBcoValor.Caption = "0.00"
                Me.lblSoloBcoValor.Caption = "0.00"
                Me.lblProcesBcoValor.Caption = "0.00"
                
                Me.lblOkEmp.Caption = "0"
                Me.lblSoloEmp.Caption = "0"
                Me.lblProcesEmp.Caption = "0"
                Me.lblOkEmpValor.Caption = "0.00"
                Me.lblSoloEmpValor.Caption = "0.00"
                Me.lblProcesEmpValor.Caption = "0.00"
                Me.lbl_registros = 0
            End If
            
            If Me.grdConci.Rows > 1 Then Me.grdConci.topRow = 1
            If Me.grdConci.Rows > 1 Then Me.grdConci.LeftCol = 1
        Case "1" 'OK
        '1 - Procesa ajustes de conciliacion
            'Validacion de Estados
            If Me.optProc(0).Value = True Then      'Habilitar
                If Not (Me.cmdEstadoBco.text = "SI" And Me.cmbEstadoEmp.text = "NO") Then
                    MsgBox "Estados deben ser: " & Chr(13) & "ESTADO BANCO = SI           " & Chr(13) & "ESTADO EMPRESA = NO", vbInformation + vbOKOnly, "TServi"
                    Exit Function
                End If
            ElseIf Me.optProc(1).Value = True Then  'Reversar
                If Not (Me.cmdEstadoBco.text = "NO" And Me.cmbEstadoEmp.text = "SI") Then
                    MsgBox "Estados deben ser: " & Chr(13) & "ESTADO BANCO = NO           " & Chr(13) & "ESTADO EMPRESA = SI", vbInformation + vbOKOnly, "TServi"
                    Exit Function
                End If
            End If
            
            For j% = 1 To Me.grdConci.Rows - 1
            grdConci.Row = j
                If Me.grdConci.CellForeColor = vbBlue Then
                    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
                    PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR%, "M"
                    PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT4, Trim(txt_empresa.text)
                    PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, Trim(Me.grdConci.TextMatrix(j%, 10))
                    PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
                    If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_ctg", True, "Búsqueda de Datos") Then
                        PMChequea SqlConn&
                    End If
                        Me.grdConci.CellForeColor = vbBlack
                        Me.grdConci.CellFontBold = False
                        Set Me.grdConci.CellPicture = Nothing
                        Me.grdConci.CellAlignment = 6
                End If
            Next j%
            'Actualizo el Flex
            Call PLProcesoCTG("0", 0, "", "")
            
        Case "2" 'falta
        '2 - Confirmacion de la conciliacion
            'Agregar validacion de que si está seguro de Cerrar la Conciliacion
            Respuesta = MsgBox("Desea Cerrar la Conciliacion", vbInformation + vbOKCancel, "TServi")
            If Respuesta = vbCancel Then
                Exit Function
            End If
            
            'Confimacion de Activacion de Casilla: Marcar Todos
            If Me.chkTodos.Value = False Then
                MsgBox "Seleccione la Casilla: Marcar Todos", vbInformation + vbOKOnly, "TServi"
                Exit Function
            End If
        
            PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
            PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR%, "X"
            PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT4, Trim(txt_empresa.text)
            PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, 0
            PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
            PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, ""
            PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, ""
            
            'Agregar parametro de Output que indique si hay data cargada en la conciliación de ese día.
            PMPasoValores SqlConn, "@o_existe", 1, SQLCHAR, Space(1)
            If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_ctg", True, "Búsqueda de Datos") Then
                PMChequea SqlConn&
                vlexiste = FMRetParam(SqlConn, 1)
                If vlexiste = "S" Then
                    If VScierre <> "S" Then
                        MsgBox "La conciliacion se ha cerrado con exito.", vbOKOnly + vbInformation, "TServi"
                    Else
                        Respuesta = MsgBox("Registros ya fueron conciliados" & Chr(13) & "Desea volver a generar archivo de ajuste?", vbInformation + vbOKCancel, "TServi")
                        If Respuesta = vbCancel Then
                            Exit Function
                        End If
                    End If
                    'Me.PLBuscarIESSFile (0)
                    Call PLProcesoCTG("4", 0, "", "")
                    'PLGeneraArchivoConciliaIESS
                    Call PLProcesoCTG("5", 0, "", "")
                End If
            End If
            Call PLProcesoCTG("0", 0, "", "")
            Me.chkTodos.Value = False
            If Me.grdConci.Rows > 1 Then Me.grdConci.topRow = 1
            If Me.grdConci.Rows > 1 Then Me.grdConci.LeftCol = 1
        Case "3" 'OK
        '3 - Genera el reporte de la conciliacion
             'INICIO (SIPECOM) MALDAZ OOF REF002
             If validaOffice("OpenOffice") Then
                 PLProcesoCTGReporteOOF
             Else
                 PLProcesoCTGReporte
             End If
            'FIN (SIPECOM) MALDAZ OOF REF002
        
                
        Case "4"
            'VLValorTotal = ""
            PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
            PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "C"
            PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT4, Trim(txt_empresa.text)
            PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, ParOpcion2
            PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
            PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, Me.cmdEstadoBco.text
            PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, Me.cmbEstadoEmp.text
            PMPasoValores SqlConn&, "@o_total", 1, SQLMONEY, "0"
            
            If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_ctg", True, "Ok... Consulta de Pagos CTG") Then
               If ParOpcion2 = 0 Then
                    VLValorTotal = 0
                  'PgMapeaFlexG grdAlterno, True, False, 0, 15, 7      'lfcm 03-septiembre-2008
                   PgMapeaFlexG grdAlterno, True, False, 0, 15, 8      'lfcm 03-septiembre-2008
                   VLValorTotal = FMRetParam(SqlConn, 1)
               Else
                  'PgMapeaFlexG grdAlterno, False, False, 0, 15, 7     'lfcm 03-septiembre-2008
                   PgMapeaFlexG grdAlterno, False, False, 0, 15, 8     'lfcm 03-septiembre-2008
               End If
               
               
               PMChequea SqlConn&
               
               If Me.grdAlterno.Tag = "15" Then
                  Me.grdAlterno.Col = 2
                  Me.grdAlterno.Row = Me.grdAlterno.Rows - 1
                  'PLBuscarIESSFile (Me.grdAlterno.Text)
                  Call PLProcesoCTG("4", Me.grdAlterno.text, "", "")
               Else
                  Me.lbl_registros.Caption = (Me.grdAlterno.Rows - 1)
               End If
            Else
               PMLimpiaGrid Me.grdAlterno
            End If
        Case "5"
             
            'Aplico formato al campo hora
'            If Me.grdAlterno.Rows > 2 Then
'            'Validar que el GRID TENGA REGISTROS. IMPORTANTE !!! DESARROLLAR
'            Me.grdAlterno.Col = 3
'            For s% = 2 To Me.grdAlterno.Rows - 1
'                Me.grdAlterno.Row = s%
'                Me.grdAlterno.Text = Replace(Me.grdAlterno.Text, ":", "")
'                Next s
'            End If
        
            'Abro el archivo para comenzar a grabar el detalle.
            If Trim(Me.txt_empresa.text) = "6388" Then
                VTnombarch$ = "ATM_WEBBOLIV_AJU_" & Mid(Me.dtFecha, 4, 2) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 7, 4) & ".txt"    'lfcm 03-septiembre-2008
            Else
                VTnombarch$ = "CTG_WEBBBOL_AJU_" & Mid(Me.dtFecha, 4, 2) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 7, 4) & ".txt"    'lfcm 03-septiembre-2008
            End If
            'VTnombarch$ = "CTG_WEBBBOL_AJU_" & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 7, 4) & Mid(Me.dtFecha, 4, 2) & ".txt"     'lfcm 03-septiembre-2008
            Open "c:\cobis\tadmin\" & VTnombarch$ For Output As #1
        
            'Registro de Detalle
            If Me.grdAlterno.Rows > 1 Then
                 VLValorTotal = Mid(Trim(VLValorTotal * 100), 1, 19)
                 VLValorTotal = Format(Trim(VLValorTotal), "0000000000000000000")
                 VLValorTotal = Mid(VLValorTotal, 1, 17) & "," & Mid(VLValorTotal, 18, 2)
                 VLTipoRegisCab = "01"
                 VLRegistros = Me.grdAlterno.Rows - 1
                 'VLRegistros = Format(Trim(VLRegistros), "0000000000")       'lfcm 03-septiembre-2008
                 VLRegistros = Format(Trim(VLRegistros + 1), "0000000000")    'lfcm 03-septiembre-2008
                 If Trim(Me.txt_empresa.text) = "6388" Then
                    ReDim VTArreglo(30) As String
                    VLBanco = ""
                    PMChequea SqlConn&
                    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT2, 1579
                    PMPasoValores SqlConn&, "@i_operacion", 0, SQLVARCHAR, "Q"
                    PMPasoValores SqlConn&, "@i_nemonico", 0, SQLVARCHAR, "CEPMTG"
                    PMPasoValores SqlConn&, "@i_producto", 0, SQLVARCHAR, "CTE"
                    If FMTransmitirRPC(SqlConn&, ServerName$, "cobis", "sp_parametro", True, "Transaccion Ok") = True Then
                        VTR% = FMMapeaArreglo(SqlConn&, VTArreglo())
                        VLBanco = LTrim(RTrim(Trim(VTArreglo(4))))
                    End If
                    PMChequea SqlConn&
                 Else
                    VLBanco = "007"
                 End If
                 Me.grdAlterno.Col = 4
                 VLFecContbCab = Me.grdAlterno.text
                             
                 VTLineal$ = ""
                 VTLineal$ = VTLineal$ + VLTipoRegisCab + "|" + VLBanco + "|" + VLFecContbCab + "|" + VLValorTotal + "|" + VLRegistros
                 Print #1, VTLineal$
                 
                 'Registro del Detalle
                 For j% = 1 To Me.grdAlterno.Rows - 1
                      Me.grdAlterno.Row = j%
                      'CEP
                      Me.grdAlterno.Col = 1
                      VLCep$ = Me.grdAlterno.text
                      
                      'Secuencia Bco
                      Me.grdAlterno.Col = 2
                      VLSecBco$ = Trim(Me.grdAlterno.text)
                      'VLSecBco$ = "" & Space(15 - Len(VLSecBco$)) & VLSecBco$     'lfcm 03-septiembre-2008
                      If Trim(Me.txt_empresa.text) = "6388" Then
                        VLSecBco$ = "" & VLSecBco$ & Space(12 - Len(VLSecBco$))      'lfcm 03-septiembre-2008
                      Else
                        VLSecBco$ = "" & VLSecBco$ & Space(15 - Len(VLSecBco$))      'lfcm 03-septiembre-2008
                      End If
                      
                      
                      'Hora
                      Me.grdAlterno.Col = 3
                      VLFecHor$ = Trim(Me.grdAlterno.text)
                      
                      'Fecha contable
                      Me.grdAlterno.Col = 4
                      VLFecContb$ = Me.grdAlterno.text
                      'Mid(Me.grdAlterno.Text, 7, 4) & "-" & Mid(Me.grdAlterno.Text, 1, 2) & "-" & Mid(Me.grdAlterno.Text, 4, 2)
                      
                      'Valor
                      Me.grdAlterno.Col = 5
                      VLValor = Mid(Trim(grdAlterno.text * 100), 1, 11)
                      'VLValor = Format(Trim(VLValor), "0000000000000000000")
                      VLValor = Format(Trim(VLValor), "00000000000") 'GAMC - 15/08/2008
                      VLValor = Mid(VLValor, 1, 9) & "," & Mid(VLValor, 10, 2)
                                                       
                      'Estado
                      Me.grdAlterno.Col = 6
                      VLEstado = Me.grdAlterno.text
                                     
                      'FECHA PROCESO
                      FechaProceso$ = Mid(Me.dtFecha, 7, 4) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2)
                      VLTipoMsg$ = "0210"
                      VLTipoTrx$ = "000101"
                      
                      'Canal                                          'lfcm 03-septiembre-2008
                      Me.grdAlterno.Col = 7                           'lfcm 03-septiembre-2008
                      VLCTGCanal = ""                                 'lfcm 03-septiembre-2008
                      VLCTGCanal = Mid(Me.grdAlterno.text, 1, 3)      'lfcm 03-septiembre-2008
                      
                                       
                      'Grabo el registro de Detalle
                      'If VLEstConcilia$ <> "" Then
                      VTLineal$ = ""
                      'VTLineal$ = VTLineal$ + VLCep + "|" + VLSecBco$ + "|" + VLFecHor$ + "|" + VLFecContb$ + "|" + VLValor + "|" + VLEstado          'lfcm 03-septiembre-2008
                      If Trim(Me.txt_empresa.text) = "6388" Then
                        VTLineal$ = "02|" + VTLineal$ + VLSecBco$ + "|" + VLFecHor$ + "|" + VLFecContb$ + "|" + VLValor + "|" + VLEstado + "|" + VLCTGCanal     'lfcm 03-septiembre-2008
                      Else
                        VTLineal$ = "02|" + VTLineal$ + VLCep + "|" + VLSecBco$ + "|" + VLFecHor$ + "|" + VLFecContb$ + "|" + VLValor + "|" + VLEstado + "|" + VLCTGCanal    'lfcm 03-septiembre-2008
                      End If
                      Print #1, VTLineal$
                      'End If
                      'Debug.Print VTLineal$
                
                 Next j%
            Else
                VTLineal$ = ""
                VTLineal$ = VTLineal$ + "0"
'                VLFecContbCab = Mid(Me.dtFecha, 4, 2) + "/" + Mid(Me.dtFecha, 1, 2) + "/" + Mid(Me.dtFecha, 7, 4)
'                VTLineal$ = VTLineal$ + "01" + "|" + "BBO" + "|" + VLFecContbCab + "|" + "00000000000000000,00" + "|" + "0000000000"
                Print #1, VTLineal$
            End If
                

         
            'Cierro el archivo y muestro mensaje indicando la generacion exitosa del mismo.
            Close #1
            MsgBox "Archivo Generado Exitosamente", vbOKOnly + vbInformation, "TServi"

                        
    End Select
    
Error:
    PMChequea SqlConn&
    
    
End Function


'(SIPECOM) MALDAZ OOF REF002
Sub PLProcesoCTGReporte()
Dim oExcelApp   As Object
            Dim oWs         As Object
            Dim oWb         As Object
            Dim sXlsTemplate As String
            Dim iRow As Integer
            Dim iCol As Integer
            Dim busqueda As String
            Dim bco1, bco2, bco3 As String
            Dim emp1, emp2, emp3 As String
            
            
            On Error GoTo ErrorHandler

            sXlsTemplate = App.Path & "\xrptCTG.xlt"
            
            Set oExcelApp = CreateObject("EXCEL.APPLICATION")              '(SIPECOM) LCHACHA OOF REF001
            oExcelApp.Visible = False
            oExcelApp.Workbooks.Open Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True   '(SIPECOM) LCHACHA OOF REF001
            Set oWs = oExcelApp.ActiveSheet
            Set oWb = oExcelApp.ActiveWorkbook
            Set oWs = oExcelApp.ActiveSheet
            If Trim(txt_empresa.text) = "6388" Then
                oWs.Cells(6, 1).Value = "      Reporte de Pagos de EPMTG - Empresa: (" & Me.txt_empresa & ") " & Me.lbl_empresa
            Else
                oWs.Cells(6, 1).Value = "      Reporte de Pagos de CTG - Empresa: (" & Me.txt_empresa & ") " & Me.lbl_empresa
            End If
            For iRow = 1 To Me.grdConci.Rows - 1
                Screen.MousePointer = 11
                Me.grdConci.Row = iRow
                Me.grdConci.Col = 1
                oWs.Cells(8 + iRow, 1).Value = Me.grdConci.text
                Me.grdConci.Col = 2
                oWs.Cells(8 + iRow, 2).Value = Me.grdConci.text
                Me.grdConci.Col = 3
                oWs.Cells(8 + iRow, 3).Value = Me.grdConci.text
                Me.grdConci.Col = 4
                oWs.Cells(8 + iRow, 4).Value = Me.grdConci.text
                Me.grdConci.Col = 5
                oWs.Cells(8 + iRow, 5).Value = Me.grdConci.text
                Me.grdConci.Col = 6
                oWs.Cells(8 + iRow, 6).Value = Me.grdConci.text
                Me.grdConci.Col = 7
                oWs.Cells(8 + iRow, 7).Value = Me.grdConci.text
                Me.grdConci.Col = 8
                oWs.Cells(8 + iRow, 8).Value = Me.grdConci.text
                Me.grdConci.Col = 9
                oWs.Cells(8 + iRow, 9).Value = Me.grdConci.text
                Me.grdConci.Col = 10
                oWs.Cells(8 + iRow, 10).Value = Me.grdConci.text
                Me.grdConci.Col = 11
                oWs.Cells(8 + iRow, 11).Value = Me.grdConci.text
                'Me.grdConci.Col = 12
                'oWs.Cells(8 + iRow, 12).Value = Me.grdConci.Text
                
                Screen.MousePointer = 0
            Next iRow
            oWs.Cells(13 + iRow, 1).Value = "TOTALES BANCO:"
            oWs.Cells(13 + iRow, 1).Font.Bold = True
            oWs.Cells(15 + iRow, 1).Value = Space(50) & "No." & Space(30) & "Valor"
            oWs.Cells(15 + iRow, 1).Font.Bold = True
            bco1 = lblOkBco & (Space(40 - Len(lblOkBco))) & lblOkBcoValor
            oWs.Cells(16 + iRow, 1).Value = " Pagos Ok:" & Space(55) & bco1
            bco2 = lblSoloBco & (Space(40 - Len(lblSoloBco))) & lblSoloBcoValor
            oWs.Cells(17 + iRow, 1).Value = " Pagos solo en banco:" & Space(31) & bco2
            bco3 = lblProcesBco & (Space(40 - Len(lblProcesBco))) & lblProcesBcoValor
            oWs.Cells(18 + iRow, 1).Value = " Total procesados Bco:" & Space(29) & bco3
            oWs.Cells(13 + iRow, 5).Value = "TOTALES EMPRESA:"
            oWs.Cells(13 + iRow, 5).Font.Bold = True
            oWs.Cells(15 + iRow, 5).Value = Space(50) & "No." & Space(30) & "Valor"
            oWs.Cells(15 + iRow, 5).Font.Bold = True
            emp1 = lblOkEmp & (Space(40 - Len(lblOkEmp))) & lblOkEmpValor
            oWs.Cells(16 + iRow, 5).Value = " Pagos Ok:" & Space(55) & emp1
            emp2 = lblSoloEmp & (Space(40 - Len(lblSoloEmp))) & lblSoloEmpValor
            oWs.Cells(17 + iRow, 5).Value = " Pagos solo en Empresa:" & Space(26) & emp2
            emp3 = lblProcesEmp & (Space(40 - Len(lblProcesEmp))) & lblProcesEmpValor
            oWs.Cells(18 + iRow, 5).Value = " Total procesados Emp:" & Space(28) & emp3
            
            
            oExcelApp.Visible = True
            Set oWs = Nothing
            Set oExcelApp = Nothing
            Exit Sub
            
ErrorHandler:
                Screen.MousePointer = vbDefault
                MsgBox err.Description & " (" & CStr(err.Number) & ")", vbExclamation, "Excel Export"
                On Error Resume Next
                oExcelApp.Quit
                Set oWs = Nothing
                Set oExcelApp = Nothing
            
End Sub

'(SIPECOM) MALDAZ OOF REF002
Sub PLProcesoCTGReporteOOF()
Dim oExcelApp   As Object
            Dim oWs         As Object
            Dim oWb         As Object
            Dim sXlsTemplate As String
            Dim iRow As Integer
            Dim iCol As Integer
            Dim busqueda As String
            Dim bco1, bco2, bco3 As String
            Dim emp1, emp2, emp3 As String
            
            
            On Error GoTo ErrorHandler

            'INICIO (SIPECOM) LCHACHA OOF REF004
                        'sXlsTemplate = App.Path & "\xrptCTG.xlt"
                        Dim sNewXlsFile  As String
                        sNewXlsFile = "xrptCTG" & Format$(Now, "YYYYMMDDHHMMSS") + ".ods"
                        FileCopy App.Path & "\xrptCTG.xlt", Environ$("tmp") & "\" & sNewXlsFile
                        sXlsTemplate = Environ$("tmp") & "\" & sNewXlsFile
                        'FIN (SIPECOM) LCHACHA OOF REF004
    
            
            
            'Set oExcelApp = CreateObject("EXCEL.APPLICATION")              '(SIPECOM) LCHACHA OOF REF001
            Set oExcelApp = CreateObject("HOJAELECTRONICABB.APPLICATION")   '(SIPECOM) LCHACHA OOF REF001
            'oExcelApp.Visible = False
            'oExcelApp.Workbooks.Open Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True   '(SIPECOM) LCHACHA OOF REF001
            oExcelApp.Workbooks.OpenW Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True, DestinationFile:="Pantalla"   '(SIPECOM) LCHACHA OOF REF001
            Set oWs = oExcelApp.ActiveSheet
            Set oWb = oExcelApp.ActiveWorkbook
            Set oWs = oExcelApp.ActiveSheet
            If Trim(txt_empresa.text) = "6388" Then
                oWs.Cells(6, 1).Value = "      Reporte de Pagos de EPMTG - Empresa: (" & Me.txt_empresa & ") " & Me.lbl_empresa
            Else
                oWs.Cells(6, 1).Value = "      Reporte de Pagos de CTG - Empresa: (" & Me.txt_empresa & ") " & Me.lbl_empresa
            End If
            For iRow = 1 To Me.grdConci.Rows - 1
                Screen.MousePointer = 11
                Me.grdConci.Row = iRow
                Me.grdConci.Col = 1
                oWs.Cells(8 + iRow, 1).Value = Me.grdConci.text
                Me.grdConci.Col = 2
                oWs.Cells(8 + iRow, 2).Value = Me.grdConci.text
                Me.grdConci.Col = 3
                oWs.Cells(8 + iRow, 3).Value = Me.grdConci.text
                Me.grdConci.Col = 4
                oWs.Cells(8 + iRow, 4).Value = Me.grdConci.text
                Me.grdConci.Col = 5
                oWs.Cells(8 + iRow, 5).Value = Me.grdConci.text
                Me.grdConci.Col = 6
                oWs.Cells(8 + iRow, 6).Value = Me.grdConci.text
                Me.grdConci.Col = 7
                oWs.Cells(8 + iRow, 7).Value = Me.grdConci.text
                Me.grdConci.Col = 8
                oWs.Cells(8 + iRow, 8).Value = Me.grdConci.text
                Me.grdConci.Col = 9
                oWs.Cells(8 + iRow, 9).Value = Me.grdConci.text
                Me.grdConci.Col = 10
                oWs.Cells(8 + iRow, 10).Value = Me.grdConci.text
                Me.grdConci.Col = 11
                oWs.Cells(8 + iRow, 11).Value = Me.grdConci.text
                'Me.grdConci.Col = 12
                'oWs.Cells(8 + iRow, 12).Value = Me.grdConci.Text
                
                Screen.MousePointer = 0
            Next iRow
            oWs.Cells(13 + iRow, 1).Value = "TOTALES BANCO:"
            oWs.Cells(13 + iRow, 1).Font.Bold = True
            oWs.Cells(15 + iRow, 1).Value = Space(50) & "No." & Space(30) & "Valor"
            oWs.Cells(15 + iRow, 1).Font.Bold = True
            bco1 = lblOkBco & (Space(40 - Len(lblOkBco))) & lblOkBcoValor
            oWs.Cells(16 + iRow, 1).Value = " Pagos Ok:" & Space(55) & bco1
            bco2 = lblSoloBco & (Space(40 - Len(lblSoloBco))) & lblSoloBcoValor
            oWs.Cells(17 + iRow, 1).Value = " Pagos solo en banco:" & Space(31) & bco2
            bco3 = lblProcesBco & (Space(40 - Len(lblProcesBco))) & lblProcesBcoValor
            oWs.Cells(18 + iRow, 1).Value = " Total procesados Bco:" & Space(29) & bco3
            oWs.Cells(13 + iRow, 5).Value = "TOTALES EMPRESA:"
            oWs.Cells(13 + iRow, 5).Font.Bold = True
            oWs.Cells(15 + iRow, 5).Value = Space(50) & "No." & Space(30) & "Valor"
            oWs.Cells(15 + iRow, 5).Font.Bold = True
            emp1 = lblOkEmp & (Space(40 - Len(lblOkEmp))) & lblOkEmpValor
            oWs.Cells(16 + iRow, 5).Value = " Pagos Ok:" & Space(55) & emp1
            emp2 = lblSoloEmp & (Space(40 - Len(lblSoloEmp))) & lblSoloEmpValor
            oWs.Cells(17 + iRow, 5).Value = " Pagos solo en Empresa:" & Space(26) & emp2
            emp3 = lblProcesEmp & (Space(40 - Len(lblProcesEmp))) & lblProcesEmpValor
            oWs.Cells(18 + iRow, 5).Value = " Total procesados Emp:" & Space(28) & emp3
            
            
            'oExcelApp.Visible = True
            Set oWs = Nothing
            Set oExcelApp = Nothing
            DoEvents
            Exit Sub
            
ErrorHandler:
                Screen.MousePointer = vbDefault
                MsgBox err.Description & " (" & CStr(err.Number) & ")", vbExclamation, "Excel Export"
                'On Error Resume Next
                'oExcelApp.Quit
                Set oWs = Nothing
                Set oExcelApp = Nothing
            
End Sub
' ****** TC busca archivo IESS 07/04/2008
Sub PLConfirmaIESS()
    'Agregar validacion de que si está seguro de Cerrar la Conciliacion
    Respuesta = MsgBox("Desea Cerrar la Conciliacion", vbInformation + vbOKCancel, "TServi")
    If Respuesta = vbCancel Then
        Exit Sub
    End If
    
    'Confimacion de Activacion de Casilla: Marcar Todos
    If Me.chkTodos.Value = False Then
        MsgBox "Seleccione la Casilla: Marcar Todos", vbInformation + vbOKOnly, "TServi"
        Exit Sub
    End If

    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
    PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR%, "X"
    PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text)
    PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, 0
    PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
    PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, ""
    PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, ""
    
    'Agregar parametro de Output que indique si hay data cargada en la conciliación de ese día.
    PMPasoValores SqlConn, "@o_existe", 1, SQLCHAR, Space(1)
    If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_iess", True, "Búsqueda de Datos") Then
        PMChequea SqlConn&
        vlexiste = FMRetParam(SqlConn, 1)
        If vlexiste = "S" Then
            If VScierre <> "S" Then
                MsgBox "La conciliacion se ha cerrado con exito.", vbOKOnly + vbInformation, "TServi"
            Else
                Respuesta = MsgBox("Registros ya fueron conciliados" & Chr(13) & "Desea volver a generar archivo de ajuste?", vbInformation + vbOKCancel, "TServi")
                If Respuesta = vbCancel Then
                    Exit Sub
                End If
            End If
            Me.PLBuscarIESSFile (0)
            PLGeneraArchivoConciliaIESS
            PLBuscaIessOK (0)
            
            'INICIO (SIPECOM) MALDAZ OOF REF002
            If validaOffice("OpenOffice") Then
                archExcIessOKOOF
            Else
                archExcIessOK
            End If
            'FIN (SIPECOM) MALDAZ OOF REF002
        End If
    End If
    PLBuscarIESS (0)
    Me.chkTodos.Value = False
    If Me.grdConci.Rows > 1 Then Me.grdConci.topRow = 1
    If Me.grdConci.Rows > 1 Then Me.grdConci.LeftCol = 1
End Sub
Sub PLConfirmaPorta()
    'Agregar validacion de que si está seguro de Cerrar la Conciliacion
    Respuesta = MsgBox("Desea Cerrar la Conciliacion", vbInformation + vbOKCancel, "TServi")
    If Respuesta = vbCancel Then
        Exit Sub
    End If
    
    'Confimacion de Activacion de Casilla: Marcar Todos
    If Me.chkTodos.Value = False Then
        MsgBox "Seleccione la Casilla: Marcar Todos", vbInformation + vbOKOnly, "TServi"
        Exit Sub
    End If

    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 4851
    'PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR%, "X"
    'PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.Text)
    PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT4, Trim(txt_empresa.text) 'CONECEL TVS dpereirv
    PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, 0
    PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
    PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, ""
    PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, ""
    
    'Agregar parametro de Output que indique si hay data cargada en la conciliación de ese día.
    PMPasoValores SqlConn, "@o_existe", 1, SQLCHAR, Space(1)
    If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_porta_X", True, "Búsqueda de Datos") Then
        PMChequea SqlConn&
        vlexiste = FMRetParam(SqlConn, 1)
        If vlexiste = "S" Then
            If VScierre <> "S" Then
                MsgBox "La conciliacion se ha cerrado con exito.", vbOKOnly + vbInformation, "TServi"
            Else
                Respuesta = MsgBox("Registros ya fueron conciliados" & Chr(13) & "Desea volver a generar archivo de ajuste?", vbInformation + vbOKCancel, "TServi")
                If Respuesta = vbCancel Then
                    Exit Sub
                End If
            End If
            Me.PLBuscarPortaFile (0)
            PLGeneraArchivoConciliaPorta
            PLBuscaPortaOK (0)
            'INICIO (SIPECOM) MALDAZ OOF REF002
            If validaOffice("OpenOffice") Then
                archExcPortaOKOOF
            Else
                archExcPortaOK
            End If
            'FIN (SIPECOM) MALDAZ OOF REF002
        End If
    End If
    PLBuscarPorta (0)
    Me.chkTodos.Value = False
    If Me.grdConci.Rows > 1 Then Me.grdConci.topRow = 1
    If Me.grdConci.Rows > 1 Then Me.grdConci.LeftCol = 1
End Sub
' ****** TC busca archivo IESS 07/07/2008
Private Sub PLExportaExcelIESS()
Dim oExcelApp   As Object
Dim oWs         As Object
Dim oWb         As Object
Dim sXlsTemplate As String
Dim iRow As Long
Dim iCol As Long
Dim busqueda As String
Dim bco1 As String
Dim bco2 As String
Dim bco3 As String
Dim emp1 As String
Dim emp2 As String
Dim emp3 As String


On Error GoTo ErrorHandler
sXlsTemplate = App.Path & "\xrptIESS.xlt"

Set oExcelApp = CreateObject("EXCEL.APPLICATION")
oExcelApp.Visible = False
oExcelApp.Workbooks.Open Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True

Set oWs = oExcelApp.ActiveSheet
Set oWb = oExcelApp.ActiveWorkbook

Set oWs = oExcelApp.ActiveSheet
oWs.Cells(6, 1).Value = "      Reporte de Pagos de IESS - Empresa: (" & Me.txt_empresa & ") " & Me.lbl_empresa
For iRow = 1 To Me.grdConci.Rows - 1
    Screen.MousePointer = 11
    Me.grdConci.Row = iRow
    Me.grdConci.Col = 1
    oWs.Cells(8 + iRow, 1).Value = Me.grdConci.text
    Me.grdConci.Col = 2
    oWs.Cells(8 + iRow, 2).Value = Me.grdConci.text
    Me.grdConci.Col = 3
    oWs.Cells(8 + iRow, 3).Value = Me.grdConci.text
    Me.grdConci.Col = 4
    oWs.Cells(8 + iRow, 4).Value = Me.grdConci.text
    Me.grdConci.Col = 5
    oWs.Cells(8 + iRow, 5).Value = Me.grdConci.text
    Me.grdConci.Col = 6
    oWs.Cells(8 + iRow, 6).Value = Me.grdConci.text
    Me.grdConci.Col = 7
    oWs.Cells(8 + iRow, 7).Value = Me.grdConci.text
    Me.grdConci.Col = 8
    oWs.Cells(8 + iRow, 8).Value = Me.grdConci.text
    Me.grdConci.Col = 9
    oWs.Cells(8 + iRow, 9).Value = Me.grdConci.text
    Me.grdConci.Col = 10
    oWs.Cells(8 + iRow, 10).Value = Me.grdConci.text
    Me.grdConci.Col = 11
    oWs.Cells(8 + iRow, 11).Value = Me.grdConci.text
    Me.grdConci.Col = 12
    oWs.Cells(8 + iRow, 12).Value = Me.grdConci.text
    
    Screen.MousePointer = 0
Next iRow
oWs.Cells(13 + iRow, 1).Value = "TOTALES BANCO:"
oWs.Cells(13 + iRow, 1).Font.Bold = True
oWs.Cells(15 + iRow, 1).Value = Space(50) & "No." & Space(30) & "Valor"
oWs.Cells(15 + iRow, 1).Font.Bold = True
bco1 = lblOkBco & (Space(40 - Len(lblOkBco))) & lblOkBcoValor
oWs.Cells(16 + iRow, 1).Value = " Pagos Ok:" & Space(55) & bco1
bco2 = lblSoloBco & (Space(40 - Len(lblSoloBco))) & lblSoloBcoValor
oWs.Cells(17 + iRow, 1).Value = " Pagos solo en banco:" & Space(31) & bco2
bco3 = lblProcesBco & (Space(40 - Len(lblProcesBco))) & lblProcesBcoValor
oWs.Cells(18 + iRow, 1).Value = " Total procesados Bco:" & Space(29) & bco3
oWs.Cells(13 + iRow, 5).Value = "TOTALES EMPRESA:"
oWs.Cells(13 + iRow, 5).Font.Bold = True
oWs.Cells(15 + iRow, 5).Value = Space(50) & "No." & Space(30) & "Valor"
oWs.Cells(15 + iRow, 5).Font.Bold = True
emp1 = lblOkEmp & (Space(40 - Len(lblOkEmp))) & lblOkEmpValor
oWs.Cells(16 + iRow, 5).Value = " Pagos Ok:" & Space(55) & emp1
emp2 = lblSoloEmp & (Space(40 - Len(lblSoloEmp))) & lblSoloEmpValor
oWs.Cells(17 + iRow, 5).Value = " Pagos solo en Empresa:" & Space(26) & emp2
emp3 = lblProcesEmp & (Space(40 - Len(lblProcesEmp))) & lblProcesEmpValor
oWs.Cells(18 + iRow, 5).Value = " Total procesados Emp:" & Space(28) & emp3


oExcelApp.Visible = True
Set oWs = Nothing
Set oExcelApp = Nothing
Exit Sub

ErrorHandler:
    Screen.MousePointer = vbDefault
    MsgBox err.Description & " (" & CStr(err.Number) & ")", vbExclamation, "Excel Export"
    On Error Resume Next
    oExcelApp.Quit
    Set oWs = Nothing
    Set oExcelApp = Nothing
End Sub

'INICIO (SIPECOM) LCHACHA OOF REF001
Private Sub PLExportaExcelIESSOOF()
Dim oExcelApp   As Object
Dim oWs         As Object
Dim oWb         As Object
Dim sXlsTemplate As String
Dim iRow As Long
Dim iCol As Long
Dim busqueda As String
Dim bco1 As String
Dim bco2 As String
Dim bco3 As String
Dim emp1 As String
Dim emp2 As String
Dim emp3 As String


On Error GoTo ErrorHandler

'INICIO (SIPECOM) LCHACHA OOF REF004
'sXlsTemplate = App.Path & "\xrptIESS.xlt"
Dim sNewXlsFile As String
sNewXlsFile = "xrptIESS" & Format$(Now, "YYYYMMDDHHMMSS") + ".ods"
FileCopy App.Path & "\xrptIESS.xlt", Environ$("tmp") & "\" & sNewXlsFile
sXlsTemplate = Environ$("tmp") & "\" & sNewXlsFile
'FIN (SIPECOM) LCHACHA OOF REF004

Set oExcelApp = CreateObject("HOJAELECTRONICABB.APPLICATION")
'oExcelApp.Visible = False
oExcelApp.Workbooks.OpenW Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True, DestinationFile:="Pantalla"
Set oWs = oExcelApp.ActiveSheet
Set oWb = oExcelApp.ActiveWorkbook

Set oWs = oExcelApp.ActiveSheet
oWs.Cells(6, 1).Value = "      Reporte de Pagos de IESS - Empresa: (" & Me.txt_empresa & ") " & Me.lbl_empresa
For iRow = 1 To Me.grdConci.Rows - 1
    Screen.MousePointer = 11
    Me.grdConci.Row = iRow
    Me.grdConci.Col = 1
    oWs.Cells(CLng(8 + iRow), 1).Value = Me.grdConci.text
    Me.grdConci.Col = 2
    oWs.Cells(CLng(8 + iRow), 2).Value = Me.grdConci.text
    Me.grdConci.Col = 3
    oWs.Cells(CLng(8 + iRow), 3).Value = Me.grdConci.text
    Me.grdConci.Col = 4
    oWs.Cells(CLng(8 + iRow), 4).Value = Me.grdConci.text
    Me.grdConci.Col = 5
    oWs.Cells(CLng(8 + iRow), 5).Value = Me.grdConci.text
    Me.grdConci.Col = 6
    oWs.Cells(CLng(8 + iRow), 6).Value = Me.grdConci.text
    Me.grdConci.Col = 7
    oWs.Cells(CLng(8 + iRow), 7).Value = Me.grdConci.text
    Me.grdConci.Col = 8
    oWs.Cells(CLng(8 + iRow), 8).Value = Me.grdConci.text
    Me.grdConci.Col = 9
    oWs.Cells(CLng(8 + iRow), 9).Value = Me.grdConci.text
    Me.grdConci.Col = 10
    oWs.Cells(CLng(8 + iRow), 10).Value = Me.grdConci.text
    Me.grdConci.Col = 11
    oWs.Cells(CLng(8 + iRow), 11).Value = Me.grdConci.text
    Me.grdConci.Col = 12
    oWs.Cells(CLng(8 + iRow), 12).Value = Me.grdConci.text
    
    Screen.MousePointer = 0
Next iRow
oWs.Cells(CLng(13 + iRow), 1).Value = "TOTALES BANCO:"
'oWs.Cells(CLng(13 + iRow), 1).Font.Bold = True
oWs.Cells(CLng(15 + iRow), 1).Value = Space(50) & "No." & Space(30) & "Valor"
'oWs.Cells(CLng(15 + iRow), 1).Font.Bold = True
bco1 = lblOkBco & (Space(40 - Len(lblOkBco))) & lblOkBcoValor
oWs.Cells(CLng(16 + iRow), 1).Value = " Pagos Ok:" & Space(55) & bco1
bco2 = lblSoloBco & (Space(40 - Len(lblSoloBco))) & lblSoloBcoValor
oWs.Cells(CLng(17 + iRow), 1).Value = " Pagos solo en banco:" & Space(31) & bco2
bco3 = lblProcesBco & (Space(40 - Len(lblProcesBco))) & lblProcesBcoValor
oWs.Cells(CLng(18 + iRow), 1).Value = " Total procesados Bco:" & Space(29) & bco3
oWs.Cells(CLng(13 + iRow), 5).Value = "TOTALES EMPRESA:"
'oWs.Cells(CLng(13 + iRow), 5).Font.Bold = True
oWs.Cells(CLng(15 + iRow), 5).Value = Space(50) & "No." & Space(30) & "Valor"
'oWs.Cells(CLng(15 + iRow), 5).Font.Bold = True
emp1 = lblOkEmp & (Space(40 - Len(lblOkEmp))) & lblOkEmpValor
oWs.Cells(CLng(16 + iRow), 5).Value = " Pagos Ok:" & Space(55) & emp1
emp2 = lblSoloEmp & (Space(40 - Len(lblSoloEmp))) & lblSoloEmpValor
oWs.Cells(CLng(17 + iRow), 5).Value = " Pagos solo en Empresa:" & Space(26) & emp2
emp3 = lblProcesEmp & (Space(40 - Len(lblProcesEmp))) & lblProcesEmpValor
oWs.Cells(CLng(18 + iRow), 5).Value = " Total procesados Emp:" & Space(28) & emp3


'oExcelApp.Visible = True
Set oWs = Nothing
Set oExcelApp = Nothing
DoEvents
Exit Sub

ErrorHandler:
    Screen.MousePointer = vbDefault
    MsgBox err.Description & " (" & CStr(err.Number) & ")", vbExclamation, "Excel Export"
    'On Error Resume Next
    'oExcelApp.Quit
    Set oWs = Nothing
    Set oExcelApp = Nothing
End Sub
'FIN (SIPECOM) LCHACHA OOF REF001

'(SIPECOM) MALDAZ OOF REF002
Private Sub PLExportaExcelPorta()
Dim oExcelApp   As Object
Dim oWs         As Object
Dim oWb         As Object
Dim sXlsTemplate As String
Dim iRow As Long
Dim iCol As Long
Dim busqueda As String
Dim bco1 As String
Dim bco2 As String
Dim bco3 As String
Dim emp1 As String
Dim emp2 As String
Dim emp3 As String


On Error GoTo ErrorHandler
If (txt_empresa.text) = "5994" Then 'dpereirv CONECEL TVS
    sXlsTemplate = App.Path & "\xrptClaroDTH.xlt"
Else
    sXlsTemplate = App.Path & "\xrptPorta.xlt"
End If

Set oExcelApp = CreateObject("EXCEL.APPLICATION")                '(SIPECOM) LCHACHA OOF REF001
oExcelApp.Visible = False
oExcelApp.Workbooks.Open Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True   '(SIPECOM) LCHACHA OOF REF001
Set oWs = oExcelApp.ActiveSheet
Set oWb = oExcelApp.ActiveWorkbook

Set oWs = oExcelApp.ActiveSheet
oWs.Cells(6, 1).Value = "      Reporte de Pagos de Porta - Empresa: (" & Me.txt_empresa & ") " & Me.lbl_empresa
For iRow = 1 To Me.grdConci.Rows - 1
    Screen.MousePointer = 11
    Me.grdConci.Row = iRow
    Me.grdConci.Col = 1
    oWs.Cells(8 + iRow, 1).Value = Me.grdConci.text
    Me.grdConci.Col = 2
    oWs.Cells(8 + iRow, 2).Value = Me.grdConci.text
    Me.grdConci.Col = 3
    oWs.Cells(8 + iRow, 3).Value = Me.grdConci.text
    Me.grdConci.Col = 4
    oWs.Cells(8 + iRow, 4).Value = Me.grdConci.text
    Me.grdConci.Col = 5
    oWs.Cells(8 + iRow, 5).Value = Me.grdConci.text
    Me.grdConci.Col = 6
    oWs.Cells(8 + iRow, 6).Value = Me.grdConci.text
    Me.grdConci.Col = 7
    oWs.Cells(8 + iRow, 7).Value = Me.grdConci.text
    Me.grdConci.Col = 8
    oWs.Cells(8 + iRow, 8).Value = Me.grdConci.text
    Me.grdConci.Col = 9
    oWs.Cells(8 + iRow, 9).Value = Me.grdConci.text
    Me.grdConci.Col = 10
    oWs.Cells(8 + iRow, 10).Value = Me.grdConci.text
    Me.grdConci.Col = 11
    oWs.Cells(8 + iRow, 11).Value = Me.grdConci.text
    Me.grdConci.Col = 12
    oWs.Cells(8 + iRow, 12).Value = Me.grdConci.text
    
    Screen.MousePointer = 0
Next iRow
oWs.Cells(13 + iRow, 1).Value = "TOTALES BANCO:"
oWs.Cells(13 + iRow, 1).Font.Bold = True
oWs.Cells(15 + iRow, 1).Value = Space(50) & "No." & Space(30) & "Valor"
oWs.Cells(15 + iRow, 1).Font.Bold = True
bco1 = lblOkBco & (Space(40 - Len(lblOkBco))) & lblOkBcoValor
oWs.Cells(16 + iRow, 1).Value = " Pagos Ok:" & Space(55) & bco1
bco2 = lblSoloBco & (Space(40 - Len(lblSoloBco))) & lblSoloBcoValor
oWs.Cells(17 + iRow, 1).Value = " Pagos solo en banco:" & Space(31) & bco2
bco3 = lblProcesBco & (Space(40 - Len(lblProcesBco))) & lblProcesBcoValor
oWs.Cells(18 + iRow, 1).Value = " Total procesados Bco:" & Space(29) & bco3
oWs.Cells(13 + iRow, 5).Value = "TOTALES EMPRESA:"
oWs.Cells(13 + iRow, 5).Font.Bold = True
oWs.Cells(15 + iRow, 5).Value = Space(50) & "No." & Space(30) & "Valor"
oWs.Cells(15 + iRow, 5).Font.Bold = True
emp1 = lblOkEmp & (Space(40 - Len(lblOkEmp))) & lblOkEmpValor
oWs.Cells(16 + iRow, 5).Value = " Pagos Ok:" & Space(55) & emp1
emp2 = lblSoloEmp & (Space(40 - Len(lblSoloEmp))) & lblSoloEmpValor
oWs.Cells(17 + iRow, 5).Value = " Pagos solo en Empresa:" & Space(26) & emp2
emp3 = lblProcesEmp & (Space(40 - Len(lblProcesEmp))) & lblProcesEmpValor
oWs.Cells(18 + iRow, 5).Value = " Total procesados Emp:" & Space(28) & emp3


oExcelApp.Visible = True
Set oWs = Nothing
Set oExcelApp = Nothing
Exit Sub

ErrorHandler:
    Screen.MousePointer = vbDefault
    MsgBox err.Description & " (" & CStr(err.Number) & ")", vbExclamation, "Excel Export"
    On Error Resume Next
    oExcelApp.Quit
    Set oWs = Nothing
    Set oExcelApp = Nothing
End Sub

Private Sub PLExportaExcelPortaOOF()
Dim oExcelApp   As Object
Dim oWs         As Object
Dim oWb         As Object
Dim sXlsTemplate As String
Dim iRow As Long
Dim iCol As Long
Dim busqueda As String
Dim bco1 As String
Dim bco2 As String
Dim bco3 As String
Dim emp1 As String
Dim emp2 As String
Dim emp3 As String
Dim sNewXlsFile  As String      '(SIPECOM) LCHACHA OOF REF004

On Error GoTo ErrorHandler
If (txt_empresa.text) = "5994" Then 'dpereirv CONECEL TVS
    
        'INICIO (SIPECOM) LCHACHA OOF REF004
        'sXlsTemplate = App.Path & "\xrptClaroDTH.xlt"
        sNewXlsFile = "xrptClaroDTH" & Format$(Now, "YYYYMMDDHHMMSS") + ".ods"
        FileCopy App.Path & "\xrptClaroDTH.xlt", Environ$("tmp") & "\" & sNewXlsFile
        sXlsTemplate = Environ$("tmp") & "\" & sNewXlsFile
        'FIN (SIPECOM) LCHACHA OOF REF004
        
Else
    
        'INICIO (SIPECOM) LCHACHA OOF REF004
        'sXlsTemplate = App.Path & "\xrptPorta.xlt"
        sNewXlsFile = "xrptPorta" & Format$(Now, "YYYYMMDDHHMMSS") + ".ods"
        FileCopy App.Path & "\xrptPorta.xlt", Environ$("tmp") & "\" & sNewXlsFile
        sXlsTemplate = Environ$("tmp") & "\" & sNewXlsFile
        'FIN (SIPECOM) LCHACHA OOF REF004
        
End If

'Set oExcelApp = CreateObject("EXCEL.APPLICATION")                '(SIPECOM) LCHACHA OOF REF001
Set oExcelApp = CreateObject("HOJAELECTRONICABB.APPLICATION")     '(SIPECOM) LCHACHA OOF REF001
'oExcelApp.Visible = False
'oExcelApp.Workbooks.Open Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True   '(SIPECOM) LCHACHA OOF REF001
oExcelApp.Workbooks.OpenW Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True, DestinationFile:="Pantalla"  '(SIPECOM) LCHACHA OOF REF001
Set oWs = oExcelApp.ActiveSheet
Set oWb = oExcelApp.ActiveWorkbook

Set oWs = oExcelApp.ActiveSheet
oWs.Cells(6, 1).Value = "      Reporte de Pagos de Porta - Empresa: (" & Me.txt_empresa & ") " & Me.lbl_empresa
For iRow = 1 To Me.grdConci.Rows - 1
    Screen.MousePointer = 11
    Me.grdConci.Row = iRow
    Me.grdConci.Col = 1
    oWs.Cells(8 + iRow, 1).Value = Me.grdConci.text
    Me.grdConci.Col = 2
    oWs.Cells(8 + iRow, 2).Value = Me.grdConci.text
    Me.grdConci.Col = 3
    oWs.Cells(8 + iRow, 3).Value = Me.grdConci.text
    Me.grdConci.Col = 4
    oWs.Cells(8 + iRow, 4).Value = Me.grdConci.text
    Me.grdConci.Col = 5
    oWs.Cells(8 + iRow, 5).Value = Me.grdConci.text
    Me.grdConci.Col = 6
    oWs.Cells(8 + iRow, 6).Value = Me.grdConci.text
    Me.grdConci.Col = 7
    oWs.Cells(8 + iRow, 7).Value = Me.grdConci.text
    Me.grdConci.Col = 8
    oWs.Cells(8 + iRow, 8).Value = Me.grdConci.text
    Me.grdConci.Col = 9
    oWs.Cells(8 + iRow, 9).Value = Me.grdConci.text
    Me.grdConci.Col = 10
    oWs.Cells(8 + iRow, 10).Value = Me.grdConci.text
    Me.grdConci.Col = 11
    oWs.Cells(8 + iRow, 11).Value = Me.grdConci.text
    Me.grdConci.Col = 12
    oWs.Cells(8 + iRow, 12).Value = Me.grdConci.text
    
    Screen.MousePointer = 0
Next iRow
oWs.Cells(13 + iRow, 1).Value = "TOTALES BANCO:"
'oWs.Cells(13 + iRow, 1).Font.Bold = True
oWs.Cells(15 + iRow, 1).Value = Space(50) & "No." & Space(30) & "Valor"
'oWs.Cells(15 + iRow, 1).Font.Bold = True
bco1 = lblOkBco & (Space(40 - Len(lblOkBco))) & lblOkBcoValor
oWs.Cells(16 + iRow, 1).Value = " Pagos Ok:" & Space(55) & bco1
bco2 = lblSoloBco & (Space(40 - Len(lblSoloBco))) & lblSoloBcoValor
oWs.Cells(17 + iRow, 1).Value = " Pagos solo en banco:" & Space(31) & bco2
bco3 = lblProcesBco & (Space(40 - Len(lblProcesBco))) & lblProcesBcoValor
oWs.Cells(18 + iRow, 1).Value = " Total procesados Bco:" & Space(29) & bco3
oWs.Cells(13 + iRow, 5).Value = "TOTALES EMPRESA:"
'oWs.Cells(13 + iRow, 5).Font.Bold = True
oWs.Cells(15 + iRow, 5).Value = Space(50) & "No." & Space(30) & "Valor"
'oWs.Cells(15 + iRow, 5).Font.Bold = True
emp1 = lblOkEmp & (Space(40 - Len(lblOkEmp))) & lblOkEmpValor
oWs.Cells(16 + iRow, 5).Value = " Pagos Ok:" & Space(55) & emp1
emp2 = lblSoloEmp & (Space(40 - Len(lblSoloEmp))) & lblSoloEmpValor
oWs.Cells(17 + iRow, 5).Value = " Pagos solo en Empresa:" & Space(26) & emp2
emp3 = lblProcesEmp & (Space(40 - Len(lblProcesEmp))) & lblProcesEmpValor
oWs.Cells(18 + iRow, 5).Value = " Total procesados Emp:" & Space(28) & emp3

'oExcelApp.Visible = True
Set oWs = Nothing
Set oExcelApp = Nothing
DoEvents
Exit Sub

ErrorHandler:
    Screen.MousePointer = vbDefault
    MsgBox err.Description & " (" & CStr(err.Number) & ")", vbExclamation, "Excel Export"
    'On Error Resume Next
    'oExcelApp.Quit
    Set oWs = Nothing
    Set oExcelApp = Nothing
End Sub





' ****** TC busca archivo IESS 07/02/2008
Sub PLBuscarIESSFile(orden As Long)
   PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
   PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "C"
   PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text)
   PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, orden
   PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
   PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, Me.cmdEstadoBco.text
   PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, Me.cmbEstadoEmp.text
   If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_iess", True, "Ok... Consulta de Pagos IESS") Then
      If orden = 0 Then
         PgMapeaFlexG grdAlterno, True, False, 0, 15, 19
      Else
         PgMapeaFlexG grdAlterno, False, False, 0, 15, 19
      End If
      
      PMChequea SqlConn&
      
      If Me.grdAlterno.Tag = "15" Then
         Me.grdAlterno.Col = 11
         Me.grdAlterno.Row = Me.grdAlterno.Rows - 1
         PLBuscarIESSFile (Me.grdAlterno.text)
      Else
         Me.lbl_registros.Caption = (Me.grdAlterno.Rows - 1)
      End If
   Else
      PMLimpiaGrid Me.grdAlterno
   End If
End Sub
Sub PLBuscarPortaFile(orden As Long)
   PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 4851
   'PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "C"
   'PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.Text)
   PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT4, Trim(txt_empresa.text) 'CONECEL TVS dpereirv
   PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, orden
   PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
   PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, Me.cmdEstadoBco.text
   PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, Me.cmbEstadoEmp.text
   If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_porta_C", True, "Ok... Consulta de Pagos IESS") Then
      If orden = 0 Then
         PgMapeaFlexG grdAlterno, True, False, 0, 15, 19
      Else
         PgMapeaFlexG grdAlterno, False, False, 0, 15, 19
      End If
      
      PMChequea SqlConn&
      
      If Me.grdAlterno.Tag = "15" Then
         Me.grdAlterno.Col = 11
         Me.grdAlterno.Row = Me.grdAlterno.Rows - 1
         PLBuscarPortaFile (Me.grdAlterno.text)
      Else
         Me.lbl_registros.Caption = (Me.grdAlterno.Rows - 1)
      End If
   Else
      PMLimpiaGrid Me.grdAlterno
   End If
End Sub
' ****** TC busca archivo IESS 07/03/2008
Sub PLGeneraArchivoConciliaIESS()
 
    'Aplico formato al campo hora
    FormateoCampoHora

    'Abro el archivo para comenzar a grabar el detalle.
    VTnombarch$ = "BBOLIESS" & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2) & Mid(Me.dtFecha, 9, 2) & "AJU.DAT"
    Open "c:\cobis\tadmin\" & VTnombarch$ For Output As #1

    'Registro de Detalle
    'Me.grdAlterno.Row = 1
    For j% = 1 To Me.grdAlterno.Rows - 1
    Me.grdAlterno.Row = j%
    'FECHA PROCESO
    FechaProceso$ = Mid(Me.dtFecha, 7, 4) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2)
    VLTipoMsg$ = "0210"
    VLTipoTrx$ = "000101"
    
    'RUC/CEDULA
    Me.grdAlterno.Col = 1
    VLCodruc$ = Me.grdAlterno.text
    
    'sucursal
    Me.grdAlterno.Col = 14
    VLSucursal$ = Me.grdAlterno.text
    
    'rubro
    Me.grdAlterno.Col = 15
    VLRubro$ = Me.grdAlterno.text
    
    'comprobante
    Me.grdAlterno.Col = 16
    VLComp$ = Me.grdAlterno.text
    
    'Valor
    Me.grdAlterno.Col = 3
    VLValor$ = Format(Me.grdAlterno.text, "#.00")
    
    'Fecha contable
    Me.grdAlterno.Col = 4
    VLFecContb$ = Mid(Me.grdAlterno.text, 7, 4) & "-" & Mid(Me.grdAlterno.text, 1, 2) & "-" & Mid(Me.grdAlterno.text, 4, 2)
    
    'Fecha proceso
    Me.grdAlterno.Col = 18
    VFechaProc$ = Mid(Me.grdAlterno.text, 7, 4) & "-" & Mid(Me.grdAlterno.text, 1, 2) & "-" & Mid(Me.grdAlterno.text, 4, 2)
    
    'Secuencia Bco
    Me.grdAlterno.Col = 11
    VLSecBco$ = Trim(Me.grdAlterno.text)
   
    'tipo ajuste
    Me.grdAlterno.Col = 7
    VLEstBanco$ = Trim(Me.grdAlterno.text)
    Me.grdAlterno.Col = 8
    VLEstIess$ = Trim(Me.grdAlterno.text)
    If VLEstBanco = "SI" And VLEstIess$ = "SI" Then
        VLEstConcilia$ = ""
    ElseIf VLEstBanco = "SI" And VLEstIess$ = "NO" Then
        VLEstConcilia$ = "P"
    ElseIf VLEstBanco = "NO" And VLEstIess$ = "SI" Then
        VLEstConcilia$ = "RM"
    End If
    
    'Secuencia Iess
    Me.grdAlterno.Col = 17
    VLSecIess$ = Trim(Me.grdAlterno.text)
    
    'Grabo el registro de Detalle
    If VLEstConcilia$ <> "" Then
        VTLineal$ = ""
        VTLineal$ = VTLineal$ + VLCodruc$ + "|" + VLSucursal$ + "|" + VLRubro$ + "|" + VLComp$ + "|" + VLValor$ + "|" + VLFecContb$
        VTLineal$ = VTLineal$ + "|" + VFechaProc$ + "|" + VLSecBco$ + "|" + VLEstConcilia$ + "|" + VLSecIess$
    
        Print #1, VTLineal$
    End If
    'Debug.Print VTLineal$
   
    Next j%
 
    'Cierro el archivo y muestro mensaje indicando la generacion exitosa del mismo.
    Close #1
    MsgBox "Archivo Generado Exitosamente", vbOKOnly + vbInformation, "TServi"

End Sub
Sub PLGeneraArchivoConciliaPorta()
 
    'Aplico formato al campo hora
    FormateoCampoHora

    'Abro el archivo para comenzar a grabar el detalle.
    Select Case Trim(Me.txt_empresa.text) 'CONECEL TVS dpereirv
        Case "5994"
            VTnombarch$ = "REC" & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2) & Mid(Me.dtFecha, 9, 2) & "AJU_DTH.DAT"
        Case Else
            VTnombarch$ = "REC" & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2) & Mid(Me.dtFecha, 9, 2) & "AJU.DAT"
    End Select
    
    
    Open "c:\cobis\tadmin\" & VTnombarch$ For Output As #1

    'Registro de Detalle
    'Me.grdAlterno.Row = 1
    For j% = 1 To Me.grdAlterno.Rows - 1
    Me.grdAlterno.Row = j%
    'FECHA PROCESO
    FechaProceso$ = Mid(Me.dtFecha, 7, 4) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2)
    VLTipoMsg$ = "0210"
    VLTipoTrx$ = "000101"
    
    'Codigo Telefono
    Me.grdAlterno.Col = 1
    VLCodruc$ = Me.grdAlterno.text
    
    'sucursal
    Me.grdAlterno.Col = 14
    VLSucursal$ = Me.grdAlterno.text
    
    ''rubro
    'Me.grdAlterno.Col = 15
    'VLRubro$ = Me.grdAlterno.Text
    
    ''comprobante
    'Me.grdAlterno.Col = 16
    'VLComp$ = Me.grdAlterno.Text
    
    'Valor
    Me.grdAlterno.Col = 3
    VLValor$ = Format(Me.grdAlterno.text, "#.00")
    
    'Fecha contable
    Me.grdAlterno.Col = 4
    VLFecContb$ = Mid(Me.grdAlterno.text, 7, 4) & "-" & Mid(Me.grdAlterno.text, 1, 2) & "-" & Mid(Me.grdAlterno.text, 4, 2)
    
    'Fecha proceso
    Me.grdAlterno.Col = 17 '18
    VFechaProc$ = Mid(Me.grdAlterno.text, 7, 4) & "-" & Mid(Me.grdAlterno.text, 1, 2) & "-" & Mid(Me.grdAlterno.text, 4, 2)
    
    'Secuencia Bco
    Me.grdAlterno.Col = 11
    VLSecBco$ = Trim(Me.grdAlterno.text)
   
    'tipo ajuste
    Me.grdAlterno.Col = 7
    VLEstBanco$ = Trim(Me.grdAlterno.text)
    Me.grdAlterno.Col = 8
    VLEstIess$ = Trim(Me.grdAlterno.text)
    If VLEstBanco = "SI" And VLEstIess$ = "SI" Then
        VLEstConcilia$ = ""
    ElseIf VLEstBanco = "SI" And VLEstIess$ = "NO" Then
        VLEstConcilia$ = "P"
    ElseIf VLEstBanco = "NO" And VLEstIess$ = "SI" Then
        VLEstConcilia$ = "RM"
    End If
    
    'Secuencia Porta
    Me.grdAlterno.Col = 16 '17
    VLSecIess$ = Trim(Me.grdAlterno.text)
    
    'Grabo el registro de Detalle
    If VLEstConcilia$ <> "" Then
        VTLineal$ = ""
        'VTLineal$ = VTLineal$ + VLCodruc$ + "|" + VLSucursal$ + "|" + VLRubro$ + "|" + VLComp$ + "|" + VLValor$ + "|" + VLFecContb$
        VTLineal$ = VTLineal$ + VLCodruc$ + "|" + VLSucursal$ + "|" + VLValor$ + "|" + VLFecContb$
        VTLineal$ = VTLineal$ + "|" + VFechaProc$ + "|" + VLSecBco$ + "|" + VLEstConcilia$ + "|" + VLSecIess$
    
        Print #1, VTLineal$
    End If
    'Debug.Print VTLineal$
   
    Next j%
 
    'Cierro el archivo y muestro mensaje indicando la generacion exitosa del mismo.
    Close #1
    MsgBox "Archivo Generado Exitosamente", vbOKOnly + vbInformation, "TServi"

End Sub

'**** TC procesa ajuste de conciliacion IESS
Sub PLProcesarIESS()
    'Validacion de Estados
    If Me.optProc(0).Value = True Then      'Habilitar
        If Not (Me.cmdEstadoBco.text = "SI" And Me.cmbEstadoEmp.text = "NO") Then
            MsgBox "Estados deben ser: " & Chr(13) & "ESTADO BANCO = SI           " & Chr(13) & "ESTADO EMPRESA = NO", vbInformation + vbOKOnly, "TServi"
            Exit Sub
        End If
    ElseIf Me.optProc(1).Value = True Then  'Reversar
        If Not (Me.cmdEstadoBco.text = "NO" And Me.cmbEstadoEmp.text = "SI") Then
            MsgBox "Estados deben ser: " & Chr(13) & "ESTADO BANCO = NO           " & Chr(13) & "ESTADO EMPRESA = SI", vbInformation + vbOKOnly, "TServi"
            Exit Sub
        End If
    End If
    
   For j% = 1 To Me.grdConci.Rows - 1
    grdConci.Row = j
        If Me.grdConci.CellForeColor = vbBlue Then
            PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
            PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR%, "M"
            PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text)
            PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, Trim(Me.grdConci.TextMatrix(j%, 11))
            PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
            If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_iess", True, "Búsqueda de Datos") Then
                PMChequea SqlConn&
            End If
                Me.grdConci.CellForeColor = vbBlack
                Me.grdConci.CellFontBold = False
                Set Me.grdConci.CellPicture = Nothing
                Me.grdConci.CellAlignment = 6
        End If
    Next j%

    'Actualizo el Flex
    Me.PLBuscarIESS (0)
    
End Sub
Sub PLProcesarPorta()
    'Validacion de Estados
    If Me.optProc(0).Value = True Then      'Habilitar
        If Not (Me.cmdEstadoBco.text = "SI" And Me.cmbEstadoEmp.text = "NO") Then
            MsgBox "Estados deben ser: " & Chr(13) & "ESTADO BANCO = SI           " & Chr(13) & "ESTADO EMPRESA = NO", vbInformation + vbOKOnly, "TServi"
            Exit Sub
        End If
    ElseIf Me.optProc(1).Value = True Then  'Reversar
        If Not (Me.cmdEstadoBco.text = "NO" And Me.cmbEstadoEmp.text = "SI") Then
            MsgBox "Estados deben ser: " & Chr(13) & "ESTADO BANCO = NO           " & Chr(13) & "ESTADO EMPRESA = SI", vbInformation + vbOKOnly, "TServi"
            Exit Sub
        End If
    End If
    
   For j% = 1 To Me.grdConci.Rows - 1
    grdConci.Row = j
        If Me.grdConci.CellForeColor = vbBlue Then
            PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 4851
            'PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR%, "M"
            'PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.Text)
            PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT4, Trim(txt_empresa.text) 'CONECEL TVS dpereirv
            PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, Trim(Me.grdConci.TextMatrix(j%, 11))
            PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
            If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_porta_A", True, "Búsqueda de Datos") Then
                PMChequea SqlConn&
            End If
                Me.grdConci.CellForeColor = vbBlack
                Me.grdConci.CellFontBold = False
                Set Me.grdConci.CellPicture = Nothing
                Me.grdConci.CellAlignment = 6
        End If
    Next j%

    'Actualizo el Flex
    Me.PLBuscarPorta (0)
    
End Sub
'/* gmartillo 10/01/2008
Private Sub PLBuscaIessOK(orden As Long) 'archExcIessOK



   PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
   PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "E"
   PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, orden
   PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
   If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_iess", True, "Ok... Consulta de Pagos IESS") Then
      If orden = 0 Then
         PgMapeaFlexG grdAlterno, True, False, 0, 15, 16
      Else
         PgMapeaFlexG grdAlterno, False, False, 0, 15, 16
      End If
      PMChequea SqlConn&
      If Me.grdAlterno.Tag = "15" Then
         Me.grdAlterno.Col = 14
         Me.grdAlterno.Row = Me.grdAlterno.Rows - 1
         PLBuscaIessOK (Me.grdAlterno.text)
    End If
End If
End Sub
Private Sub PLBuscaPortaOK(orden As Long) 'archExcPortaOK

   PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 4851
  ' PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "E"
   PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, orden
   PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
   PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT4, Trim(txt_empresa.text) 'CONECEL TVS dpereirv
   If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_porta_E", True, "Ok... Consulta de Pagos Conecel") Then
      If orden = 0 Then
         PgMapeaFlexG grdAlterno, True, False, 0, 15, 15
      Else
         PgMapeaFlexG grdAlterno, False, False, 0, 15, 15
      End If
      PMChequea SqlConn&
      If Me.grdAlterno.Tag = "15" Then
         Me.grdAlterno.Col = 14
         Me.grdAlterno.Row = Me.grdAlterno.Rows - 1
         PLBuscaPortaOK (Me.grdAlterno.text)
    End If
End If
End Sub
Private Sub archExcIessOK()
Dim oExcelApp   As Object
Dim oWs         As Object
Dim oWb         As Object
Dim sXlsTemplate As String
Dim sNewXlsFile  As String
Dim Path As String
Dim iRow As Long
Dim iCol As Long

Dim totEfectivo As Currency
Dim trx As Long
Dim totCheque As Currency
Dim totND As Currency
Dim Total As Currency
Dim fecha As String

Dim vlefectivo As Currency  'tc 09172009
Dim vlcheque As Currency    'tc 09172009
Dim vlnd As Currency    'tc 09172009


Total = 0
totCheque = 0
totEfectivo = 0
totND = 0
trx = 0

vlefectivo = 0
vlcheque = 0
vlnd = 0


On Error GoTo ErrorHandler

        sXlsTemplate = App.Path & "\xrptRecaIESS.xlt"
        Path = "c:\cobis\tadmin\"
        sNewXlsFile = Path & "RecIESS" & Format(dtFecha, "MMDDYYYY") & ".xls"
        Set oExcelApp = CreateObject("EXCEL.APPLICATION")              '(SIPECOM) LCHACHA OOF REF001
        oExcelApp.Visible = False
        oExcelApp.Workbooks.Open Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True   '(SIPECOM) LCHACHA OOF REF001
        Set oWs = oExcelApp.ActiveSheet
        Set oWb = oExcelApp.ActiveWorkbook
        Set oWs = oExcelApp.ActiveSheet
        'oWs.Cells('fila', 'col'')
        
        For iRow = 1 To Me.grdAlterno.Rows - 1
            Screen.MousePointer = 11
            grdAlterno.Row = iRow

            grdAlterno.Col = 1
            oWs.Cells(15 + iRow, 1).Value = grdAlterno.text 'fecha
            fecha = grdAlterno.text
                        
            grdAlterno.Col = 2
            oWs.Cells(15 + iRow, 2).Value = grdAlterno.text 'ciudad

            grdAlterno.Col = 3
            oWs.Cells(15 + iRow, 3).Value = grdAlterno.text ' agencia

            grdAlterno.Col = 4
            oWs.Cells(15 + iRow, 4).Value = grdAlterno.text ' canal

            grdAlterno.Col = 5
            oWs.Cells(15 + iRow, 5).Value = grdAlterno.text 'cod_cajero

            grdAlterno.Col = 6
            oWs.Cells(15 + iRow, 6).Value = grdAlterno.text  ' monto total

            grdAlterno.Col = 7
            vlefectivo = CCur(IIf(grdAlterno.text = "", 0, grdAlterno.text))    'tc 09172009
            oWs.Cells(15 + iRow, 7).Value = grdAlterno.text   ' efectivo
            totEfectivo = totEfectivo + CCur(vlefectivo)

            grdAlterno.Col = 8
            vlcheque = CCur(IIf(grdAlterno.text = "", 0, grdAlterno.text))    'tc 09172009
            oWs.Cells(15 + iRow, 8).Value = grdAlterno.text  ' cheque
            totCheque = totCheque + CCur(vlcheque)
            
            grdAlterno.Col = 9
            vlnd = CCur(IIf(grdAlterno.text = "", 0, grdAlterno.text))    'tc 09172009
            oWs.Cells(15 + iRow, 9).Value = grdAlterno.text  ' N/D
            totND = totND + CCur(vlnd)

            grdAlterno.Col = 10
            oWs.Cells(15 + iRow, 10).Value = grdAlterno.text ' hora

            grdAlterno.Col = 11
            oWs.Cells(15 + iRow, 11).Value = grdAlterno.text ' cedula /RUC

            grdAlterno.Col = 12
            oWs.Cells(15 + iRow, 12).Value = grdAlterno.text ' Nombre

            grdAlterno.Col = 13
            oWs.Cells(15 + iRow, 13).Value = grdAlterno.text ' codigo_3 -- rubro
            
            grdAlterno.Col = 6
            oWs.Cells(15 + iRow, 14).Value = grdAlterno.text
            
            grdAlterno.Col = 6
            oWs.Cells(15 + iRow, 15).Value = grdAlterno.text
            
            grdAlterno.Col = 15
            oWs.Cells(15 + iRow, 16).Value = grdAlterno.text
            
            trx = trx + 1

    Next iRow
    Total = totCheque + totEfectivo + totND
    oWs.Cells(5, 3).Value = trx
    oWs.Cells(6, 3).Value = totEfectivo
    oWs.Cells(7, 3).Value = totCheque
    oWs.Cells(8, 3).Value = totND
    oWs.Cells(9, 3).Value = Total
    
    oWs.Cells(2, 2).Value = fecha
    oWs.Cells(3, 2).Value = fecha
    oExcelApp.Visible = True
    Screen.MousePointer = 0
    oExcelApp.DisplayAlerts = False
    oWb.SaveCopyAs (sNewXlsFile)

    oExcelApp.Quit
    Set oWs = Nothing
    Set oWb = Nothing
    Set oExcelApp = Nothing
    Exit Sub
    
ErrorHandler:
    Screen.MousePointer = vbDefault
    MsgBox err.Description & " (" & CStr(err.Number) & ")", vbExclamation, "Excel Export"
    On Error Resume Next
    oExcelApp.Quit
    Set oWs = Nothing
    Set oExcelApp = Nothing
End Sub

'(SIPECOM) MALDAZ OOF REF002

Private Sub archExcIessOKOOF()
Dim oExcelApp   As Object
Dim oWs         As Object
Dim oWb         As Object
Dim sXlsTemplate As String
Dim sNewXlsFile  As String
Dim Path As String
Dim iRow As Long
Dim iCol As Long

Dim totEfectivo As Currency
Dim trx As Long
Dim totCheque As Currency
Dim totND As Currency
Dim Total As Currency
Dim fecha As String

Dim vlefectivo As Currency  'tc 09172009
Dim vlcheque As Currency    'tc 09172009
Dim vlnd As Currency    'tc 09172009


Total = 0
totCheque = 0
totEfectivo = 0
totND = 0
trx = 0

vlefectivo = 0
vlcheque = 0
vlnd = 0


On Error GoTo ErrorHandler

                'INICIO (SIPECOM) LCHACHA OOF REF004
        'sXlsTemplate = App.Path & "\xrptRecaIESS.xlt"
                sNewXlsFile = "xrptRecaIESS" & Format$(Now, "YYYYMMDDHHMMSS") + ".ods"
                FileCopy App.Path & "\xrptRecaIESS.xlt", Environ$("tmp") & "\" & sNewXlsFile
                sXlsTemplate = Environ$("tmp") & "\" & sNewXlsFile
                'FIN (SIPECOM) LCHACHA OOF REF004
                
        Path = "c:\cobis\tadmin\"
        'sNewXlsFile = Path & "RecIESS" & Format(dtFecha, "MMDDYYYY") & ".xls"
        'Set oExcelApp = CreateObject("EXCEL.APPLICATION")              '(SIPECOM) LCHACHA OOF REF001
        Set oExcelApp = CreateObject("HOJAELECTRONICABB.APPLICATION")   '(SIPECOM) LCHACHA OOF REF001
        'oExcelApp.Visible = False
        'oExcelApp.Workbooks.Open Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True   '(SIPECOM) LCHACHA OOF REF001
        oExcelApp.Workbooks.OpenW Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True, DestinationFile:="Pantalla"   '(SIPECOM) MALDAZ OOF REF002
        Set oWs = oExcelApp.ActiveSheet
        Set oWb = oExcelApp.ActiveWorkbook
        Set oWs = oExcelApp.ActiveSheet
        'oWs.Cells('fila', 'col'')
        
        For iRow = 1 To Me.grdAlterno.Rows - 1
            Screen.MousePointer = 11
            grdAlterno.Row = iRow

            grdAlterno.Col = 1
            oWs.Cells(15 + iRow, 1).Value = grdAlterno.text 'fecha
            fecha = grdAlterno.text
                        
            grdAlterno.Col = 2
            oWs.Cells(15 + iRow, 2).Value = grdAlterno.text 'ciudad

            grdAlterno.Col = 3
            oWs.Cells(15 + iRow, 3).Value = grdAlterno.text ' agencia

            grdAlterno.Col = 4
            oWs.Cells(15 + iRow, 4).Value = grdAlterno.text ' canal

            grdAlterno.Col = 5
            oWs.Cells(15 + iRow, 5).Value = grdAlterno.text 'cod_cajero

            grdAlterno.Col = 6
            oWs.Cells(15 + iRow, 6).Value = grdAlterno.text  ' monto total

            grdAlterno.Col = 7
            vlefectivo = CCur(IIf(grdAlterno.text = "", 0, grdAlterno.text))    'tc 09172009
            oWs.Cells(15 + iRow, 7).Value = grdAlterno.text   ' efectivo
            totEfectivo = totEfectivo + CCur(vlefectivo)

            grdAlterno.Col = 8
            vlcheque = CCur(IIf(grdAlterno.text = "", 0, grdAlterno.text))    'tc 09172009
            oWs.Cells(15 + iRow, 8).Value = grdAlterno.text  ' cheque
            totCheque = totCheque + CCur(vlcheque)
            
            grdAlterno.Col = 9
            vlnd = CCur(IIf(grdAlterno.text = "", 0, grdAlterno.text))    'tc 09172009
            oWs.Cells(15 + iRow, 9).Value = grdAlterno.text  ' N/D
            totND = totND + CCur(vlnd)

            grdAlterno.Col = 10
            oWs.Cells(15 + iRow, 10).Value = grdAlterno.text ' hora

            grdAlterno.Col = 11
            oWs.Cells(15 + iRow, 11).Value = grdAlterno.text ' cedula /RUC

            grdAlterno.Col = 12
            oWs.Cells(15 + iRow, 12).Value = grdAlterno.text ' Nombre

            grdAlterno.Col = 13
            oWs.Cells(15 + iRow, 13).Value = grdAlterno.text ' codigo_3 -- rubro
            
            grdAlterno.Col = 6
            oWs.Cells(15 + iRow, 14).Value = grdAlterno.text
            
            grdAlterno.Col = 6
            oWs.Cells(15 + iRow, 15).Value = grdAlterno.text
            
            grdAlterno.Col = 15
            oWs.Cells(15 + iRow, 16).Value = grdAlterno.text
            
            trx = trx + 1

    Next iRow
    Total = totCheque + totEfectivo + totND
    oWs.Cells(5, 3).Value = trx
    oWs.Cells(6, 3).Value = totEfectivo
    oWs.Cells(7, 3).Value = totCheque
    oWs.Cells(8, 3).Value = totND
    oWs.Cells(9, 3).Value = Total
    
    oWs.Cells(2, 2).Value = fecha
    oWs.Cells(3, 2).Value = fecha
    'oExcelApp.Visible = True
    Screen.MousePointer = 0
    oExcelApp.DisplayAlerts = False
    oWb.SaveCopyAs (sNewXlsFile)

    'oExcelApp.Quit
    Set oWs = Nothing
    Set oWb = Nothing
    Set oExcelApp = Nothing
    DoEvents
    Exit Sub
    
ErrorHandler:
    Screen.MousePointer = vbDefault
    MsgBox err.Description & " (" & CStr(err.Number) & ")", vbExclamation, "Excel Export"
    'On Error Resume Next
    'oExcelApp.Quit
    Set oWs = Nothing
    Set oExcelApp = Nothing
End Sub


Private Sub archExcPortaOK()
Dim oExcelApp   As Object
Dim oWs         As Object
Dim oWb         As Object
Dim sXlsTemplate As String
Dim sNewXlsFile  As String
Dim Path As String
Dim iRow As Long
Dim iCol As Long

Dim totEfectivo As Currency
Dim trx As Long
Dim totCheque As Currency
Dim totND As Currency
Dim Total As Currency
Dim fecha As String

Dim vlefectivo As Currency
Dim vlcheque As Currency
Dim vlnd As Currency


Total = 0
totCheque = 0
totEfectivo = 0
totND = 0
trx = 0

vlefectivo = 0
vlcheque = 0
vlnd = 0


On Error GoTo ErrorHandler
Path = "c:\cobis\tadmin\"
            Select Case Trim(Me.txt_empresa.text) 'CONECEL TVS dpereirv
            Case "5994"
                sNewXlsFile = Path & "RecPorta" & Format(dtFecha, "MMDDYYYY") & "_DTH.xls"
            Case Else
                sNewXlsFile = Path & "RecPorta" & Format(dtFecha, "MMDDYYYY") & ".xls"
        End Select

        sXlsTemplate = App.Path & "\xrptRecaPorta.xlt"
        
        
        Set oExcelApp = CreateObject("EXCEL.APPLICATION")              '(SIPECOM) LCHACHA OOF REF001
        oExcelApp.Visible = False
        oExcelApp.Workbooks.Open Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True   '(SIPECOM) LCHACHA OOF REF001
        Set oWs = oExcelApp.ActiveSheet
        Set oWb = oExcelApp.ActiveWorkbook
        Set oWs = oExcelApp.ActiveSheet
        'oWs.Cells('fila', 'col'')
        
        For iRow = 1 To Me.grdAlterno.Rows - 1
            Screen.MousePointer = 11
            grdAlterno.Row = iRow

            grdAlterno.Col = 1
            oWs.Cells(15 + iRow, 1).Value = grdAlterno.text 'fecha
            fecha = grdAlterno.text
                        
            grdAlterno.Col = 2
            oWs.Cells(15 + iRow, 2).Value = grdAlterno.text 'ciudad

            grdAlterno.Col = 3
            oWs.Cells(15 + iRow, 3).Value = grdAlterno.text ' agencia

            grdAlterno.Col = 4
            oWs.Cells(15 + iRow, 4).Value = grdAlterno.text ' canal

            grdAlterno.Col = 5
            oWs.Cells(15 + iRow, 5).Value = grdAlterno.text 'cod_cajero

            grdAlterno.Col = 6
            oWs.Cells(15 + iRow, 6).Value = grdAlterno.text  ' monto total

            grdAlterno.Col = 7
            vlefectivo = CCur(IIf(grdAlterno.text = "", 0, grdAlterno.text))
            oWs.Cells(15 + iRow, 7).Value = grdAlterno.text   ' efectivo
            totEfectivo = totEfectivo + CCur(vlefectivo)

            grdAlterno.Col = 8
            vlcheque = CCur(IIf(grdAlterno.text = "", 0, grdAlterno.text))
            oWs.Cells(15 + iRow, 8).Value = grdAlterno.text  ' cheque
            totCheque = totCheque + CCur(vlcheque)
            
            grdAlterno.Col = 9
            vlnd = CCur(IIf(grdAlterno.text = "", 0, grdAlterno.text))
            oWs.Cells(15 + iRow, 9).Value = grdAlterno.text  ' N/D
            totND = totND + CCur(vlnd)

            grdAlterno.Col = 10
            oWs.Cells(15 + iRow, 10).Value = grdAlterno.text ' hora

            grdAlterno.Col = 11
            oWs.Cells(15 + iRow, 11).Value = grdAlterno.text ' Telefono

            grdAlterno.Col = 12
            oWs.Cells(15 + iRow, 12).Value = grdAlterno.text ' Nombre

            grdAlterno.Col = 13
            oWs.Cells(15 + iRow, 13).Value = grdAlterno.text ' referencia
            
            grdAlterno.Col = 6
            oWs.Cells(15 + iRow, 14).Value = grdAlterno.text
            
            grdAlterno.Col = 6
            oWs.Cells(15 + iRow, 15).Value = grdAlterno.text
            
                        trx = trx + 1

    Next iRow
    Total = totCheque + totEfectivo + totND
    oWs.Cells(5, 3).Value = trx
    oWs.Cells(6, 3).Value = totEfectivo
    oWs.Cells(7, 3).Value = totCheque
    oWs.Cells(8, 3).Value = totND
    oWs.Cells(9, 3).Value = Total
    
    oWs.Cells(2, 2).Value = fecha
    oWs.Cells(3, 2).Value = fecha
    oExcelApp.Visible = True
    Screen.MousePointer = 0
    oExcelApp.DisplayAlerts = False
    oWb.SaveCopyAs (sNewXlsFile)

    oExcelApp.Quit
    Set oWs = Nothing
    Set oWb = Nothing
    Set oExcelApp = Nothing
    Exit Sub

    
ErrorHandler:
    Screen.MousePointer = vbDefault
    MsgBox err.Description & " (" & CStr(err.Number) & ")", vbExclamation, "Excel Export"
    On Error Resume Next
    oExcelApp.Quit
    Set oWs = Nothing
    Set oExcelApp = Nothing
End Sub


Private Sub archExcPortaOKOOF()
Dim oExcelApp   As Object
Dim oWs         As Object
Dim oWb         As Object
Dim sXlsTemplate As String
Dim sNewXlsFile  As String
Dim Path As String
Dim iRow As Long
Dim iCol As Long

Dim totEfectivo As Currency
Dim trx As Long
Dim totCheque As Currency
Dim totND As Currency
Dim Total As Currency
Dim fecha As String

Dim vlefectivo As Currency
Dim vlcheque As Currency
Dim vlnd As Currency


Total = 0
totCheque = 0
totEfectivo = 0
totND = 0
trx = 0

vlefectivo = 0
vlcheque = 0
vlnd = 0


On Error GoTo ErrorHandler
Path = "c:\cobis\tadmin\"
            Select Case Trim(Me.txt_empresa.text) 'CONECEL TVS dpereirv
            Case "5994"
                sNewXlsFile = Path & "RecPorta" & Format(dtFecha, "MMDDYYYY") & "_DTH.xls"
            Case Else
                sNewXlsFile = Path & "RecPorta" & Format(dtFecha, "MMDDYYYY") & ".xls"
        End Select

                'INICIO (SIPECOM) LCHACHA OOF REF004
        'sXlsTemplate = App.Path & "\xrptRecaPorta.xlt"
                Dim sNewXlsFile_  As String
                sNewXlsFile_ = "xrptRecaPorta" & Format$(Now, "YYYYMMDDHHMMSS") + ".ods"
                FileCopy App.Path & "\xrptRecaPorta.xlt", Environ$("tmp") & "\" & sNewXlsFile_
                sXlsTemplate = Environ$("tmp") & "\" & sNewXlsFile_
                'FIN (SIPECOM) LCHACHA OOF REF004
        
        
        'Set oExcelApp = CreateObject("EXCEL.APPLICATION")              '(SIPECOM) LCHACHA OOF REF001
        Set oExcelApp = CreateObject("HOJAELECTRONICABB.APPLICATION")   '(SIPECOM) LCHACHA OOF REF001
        'oExcelApp.Visible = False
        'oExcelApp.Workbooks.Open Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True   '(SIPECOM) LCHACHA OOF REF001
        oExcelApp.Workbooks.OpenW Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True, DestinationFile:="Pantalla"   '(SIPECOM) LCHACHA OOF REF001
        Set oWs = oExcelApp.ActiveSheet
        Set oWb = oExcelApp.ActiveWorkbook
        Set oWs = oExcelApp.ActiveSheet
        'oWs.Cells('fila', 'col'')
        
        For iRow = 1 To Me.grdAlterno.Rows - 1
            Screen.MousePointer = 11
            grdAlterno.Row = iRow

            grdAlterno.Col = 1
            oWs.Cells(15 + iRow, 1).Value = grdAlterno.text 'fecha
            fecha = grdAlterno.text
                        
            grdAlterno.Col = 2
            oWs.Cells(15 + iRow, 2).Value = grdAlterno.text 'ciudad

            grdAlterno.Col = 3
            oWs.Cells(15 + iRow, 3).Value = grdAlterno.text ' agencia

            grdAlterno.Col = 4
            oWs.Cells(15 + iRow, 4).Value = grdAlterno.text ' canal

            grdAlterno.Col = 5
            oWs.Cells(15 + iRow, 5).Value = grdAlterno.text 'cod_cajero

            grdAlterno.Col = 6
            oWs.Cells(15 + iRow, 6).Value = grdAlterno.text  ' monto total

            grdAlterno.Col = 7
            vlefectivo = CCur(IIf(grdAlterno.text = "", 0, grdAlterno.text))
            oWs.Cells(15 + iRow, 7).Value = grdAlterno.text   ' efectivo
            totEfectivo = totEfectivo + CCur(vlefectivo)

            grdAlterno.Col = 8
            vlcheque = CCur(IIf(grdAlterno.text = "", 0, grdAlterno.text))
            oWs.Cells(15 + iRow, 8).Value = grdAlterno.text  ' cheque
            totCheque = totCheque + CCur(vlcheque)
            
            grdAlterno.Col = 9
            vlnd = CCur(IIf(grdAlterno.text = "", 0, grdAlterno.text))
            oWs.Cells(15 + iRow, 9).Value = grdAlterno.text  ' N/D
            totND = totND + CCur(vlnd)

            grdAlterno.Col = 10
            oWs.Cells(15 + iRow, 10).Value = grdAlterno.text ' hora

            grdAlterno.Col = 11
            oWs.Cells(15 + iRow, 11).Value = grdAlterno.text ' Telefono

            grdAlterno.Col = 12
            oWs.Cells(15 + iRow, 12).Value = grdAlterno.text ' Nombre

            grdAlterno.Col = 13
            oWs.Cells(15 + iRow, 13).Value = grdAlterno.text ' referencia
            
            grdAlterno.Col = 6
            oWs.Cells(15 + iRow, 14).Value = grdAlterno.text
            
            grdAlterno.Col = 6
            oWs.Cells(15 + iRow, 15).Value = grdAlterno.text
            
                        trx = trx + 1

    Next iRow
    Total = totCheque + totEfectivo + totND
    oWs.Cells(5, 3).Value = trx
    oWs.Cells(6, 3).Value = totEfectivo
    oWs.Cells(7, 3).Value = totCheque
    oWs.Cells(8, 3).Value = totND
    oWs.Cells(9, 3).Value = Total
    
    oWs.Cells(2, 2).Value = fecha
    oWs.Cells(3, 2).Value = fecha
    'oExcelApp.Visible = True
    Screen.MousePointer = 0
    oExcelApp.DisplayAlerts = False
    oWb.SaveCopyAs (sNewXlsFile)

    'oExcelApp.Quit
    Set oWs = Nothing
    Set oWb = Nothing
    Set oExcelApp = Nothing
    DoEvents
    Exit Sub

    
ErrorHandler:
    Screen.MousePointer = vbDefault
    MsgBox err.Description & " (" & CStr(err.Number) & ")", vbExclamation, "Excel Export"
    'On Error Resume Next
    'oExcelApp.Quit
    Set oWs = Nothing
    Set oExcelApp = Nothing
End Sub



Sub PLGeneraArchivoCNEL()
   'Aplico formato al campo hora
   FormateoCampoHora

    'Abro el archivo para comenzar a grabar el detalle.
    'VTnombarch$ = "BANBBO" & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2) & ".DAT"
    'VTnombarch$ = "BANBOL" & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2) & ".DAT"
    If Me.txt_empresa.text = 1 Then
       VTnombarch$ = "BANBOL" & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2) & ".DAT"
    ElseIf Me.txt_empresa.text = 1127 Then
       VTnombarch$ = "BANCBOL" & Mid(Me.dtFecha, 4, 2) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 9, 2) & ".DAT"
    End If
    
    Open "c:\cobis\tadmin\" & VTnombarch$ For Output As #1

    'Registro de Cabecera
    FechaProceso$ = Mid(Me.dtFecha, 7, 4) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2)
    FechaRecaudacion$ = Mid(Me.dtFecha, 7, 4) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2)
    CodigoIfi$ = "0024"
    
    'Obtener el total recaudado
    Dim VLTotRecauda As Currency
    For t% = 1 To Me.grdAlterno.Rows - 1
        Me.grdAlterno.Row = t%
        Me.grdAlterno.Col = 6     'Columna que tiene el estado de la Conciliacion(OK-CA-BO)
        If Me.grdAlterno.text = "OK" Or Me.grdAlterno.text = "BO" Then
            Me.grdAlterno.Col = 3
            VLTotRecauda = VLTotRecauda + Me.grdAlterno.text
        End If
    Next t%
    
    VLCodSeg$ = ""
    'Codigo de seguridad asignado por la CATEG al BCO
    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
    PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "T"   'T = Parametro de Seguridad asigando al Banco
    PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text)
    PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, 0
    PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
    PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, Me.cmdEstadoBco.text
    PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, Me.cmbEstadoEmp.text
    'PMPasoValores SqlConn&, "@o_codseg", 1, SQLINT4, 0
    PMPasoValores SqlConn&, "@o_codseg", 1, SQLVARCHAR, "        "
    If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_categ", True, "Ok... Consulta de Pagos TVCABLE") Then
        PMChequea SqlConn
        VLCodSeg$ = FMRetParam$(SqlConn&, 1)
    End If
    
    'TotalRecaudado$ = "888888888888"
    TotalRecaudado$ = CStr(VLTotRecauda * 100)
    TotalRecaudado$ = Format(TotalRecaudado$, "000000000000")
    VLSpaces$ = String(105, "0")
    
    'Grabo el Registro de Cabecera
    VTLineal$ = "C"
    VTLineal$ = VTLineal$ + FechaProceso$ + FechaRecaudacion$ + CodigoIfi$
    VTLineal$ = VTLineal$ + TotalRecaudado$ + VLCodSeg$ + VLSpaces$
    Print #1, VTLineal$



    'Registro de Detalle

    Me.grdAlterno.Row = 1
    For j% = 1 To Me.grdAlterno.Rows - 1
    Me.grdAlterno.Row = j%
    
    FechaProceso$ = Mid(Me.dtFecha, 7, 4) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2)
    VLTipoMsg$ = "0210"
    VLTipoTrx$ = "000101"
    
    'Codigo de Cuenta
    Me.grdAlterno.Col = 1
    VLCodCuenta$ = Me.grdAlterno.text + Mid("                   ", 1, 19 - Len(Me.grdAlterno.text))
    
    'Numero de Factura
    Me.grdAlterno.Col = 14
    VLNumFactura$ = Mid("00000000000000000000", 1, 20 - Len(Me.grdAlterno.text)) + Me.grdAlterno.text
    
    'Codigo Ifi
    VLCodIfi$ = "0024"
    
    'Fecha Trx Local
    Me.grdAlterno.Col = 4
    VLFechaTrxLocal$ = Mid(Me.grdAlterno.text, 7, 4) & Mid(Me.grdAlterno.text, 1, 2) & Mid(Me.grdAlterno.text, 4, 2)
    VLFechaTrxLocal$ = Format(VLFechaTrxLocal$, "00000000")
    
    'Hora de Trx Local
    Me.grdAlterno.Col = 5
    VLHoraTrxLocal$ = Trim(Me.grdAlterno.text)
    VLHoraTrxLocal$ = Mid(VLHoraTrxLocal$, 1, 2) & Mid(VLHoraTrxLocal$, 3, 2) & Mid(VLHoraTrxLocal$, 5, 2)
    VLHoraTrxLocal$ = Format(VLHoraTrxLocal$, "000000")
    
    
    
    'Codigo de Operador
    Me.grdAlterno.Col = 9
    VLCodOperador$ = Trim(Me.grdAlterno.text)
    VLCodOperador$ = VLCodOperador$ + Mid("      ", 1, 6 - Len(VLCodOperador$))
    
    'Secuencia Ifi
    Me.grdAlterno.Col = 15
    VLSecIfi$ = Right(Me.grdAlterno.text, 6)
    VLSecIfi$ = Mid("000000", 1, 6 - Len(VLSecIfi$)) + VLSecIfi$
    
    
    'Codigo de Resultado
    VLCodResultado$ = ""
    VLEstBanco$ = ""
    VLEstCateg$ = ""
    'Me.grdConci.Col = 7
    'VLEstBanco$ = Trim(Me.grdConci.Text)
    'Me.grdConci.Col = 8
    'VLEstCateg$ = Trim(Me.grdConci.Text)
    'If VLEstBanco = "SI" And VLEstCateg = "SI" Then
    '    VLCodResultado$ = "00"
    'ElseIf VLEstBanco = "SI" And VLEstCateg = "NO" Then
    '    VLCodResultado$ = "01"
    'ElseIf VLEstBanco = "NO" And VLEstCateg = "SI" Then
    '    VLCodResultado$ = "02"
    'ElseIf VLEstBanco = "NO" And VLEstCateg = "NO" Then
    '    VLCodResultado$ = "03"
    'End If
    
    
    Me.grdAlterno.Col = 19
    VLCodResultado$ = Mid("00", 1, 2 - Len(grdAlterno.text)) + grdAlterno.text
    
    
    'Codigo Agencia
    'Me.grdConci.Col = 16
    'VLCodAgencia$ = Trim(Me.grdConci.Text)
    'VLCodAgencia$ = Mid("000000", 1, 6 - Len(VLCodAgencia$)) + VLCodAgencia$
    
    
    'Codigo de autorizacion
    Me.grdAlterno.Col = 10
    VLCodAutorizacion$ = Right(Me.grdAlterno.text, 6)    'Para el caso de los sec del Banco tomo los 6 ultimos
    VLCodAutorizacion$ = Mid("000000", 1, 6 - Len(VLCodAutorizacion$)) + VLCodAutorizacion$
    
    'Secuencia MIT
    Me.grdAlterno.Col = 11
    VLSecMit$ = Trim(Me.grdAlterno.text)
    VLSecMit$ = Mid("000000", 1, 6 - Len(VLSecMit$)) + VLSecMit$
    
    'Codigo Terminal
    Me.grdAlterno.Col = 16
    'Me.grdConci.Col = 9
    VLCodTerminal$ = Trim(Me.grdAlterno.text)
    'VLCodTerminal$ = Mid("0024000000000000", 1, 16 - Len(VLCodTerminal$)) + VLCodTerminal$ 'gmartillo 12/03/2008
   
    'Canal
    Me.grdAlterno.Col = 17
    VLCanal$ = Mid("   ", 1, 3 - Len(Me.grdAlterno.text)) + Me.grdAlterno.text
    
   'If VLCanal$ <> "DBA" Then 'gmartillo 12/03/2008
   If VLCanal$ <> "DAT" Then 'gmartillo 04/14/2009
       VLCodTerminal$ = Mid("0024000000000000", 1, 16 - Len(VLCodTerminal$)) + VLCodTerminal$ 'gmartillo 12/03/2008
    Else 'gmartillo 12/03/2008
       VLCodTerminal$ = VLCodTerminal$ + Mid("                ", 1, 16 - Len(VLCodTerminal$)) 'gmartillo 12/03/2008
    End If
   
    
    'If VLCanal$ = "DBA" Then gmartillo 12/03/2008
       ' VLCanal$ = "DAT" gmartillo 12/03/2008
    'End If gmartillo 12/03/2008
        
    'Valor Recaudado
    Me.grdAlterno.Col = 3
    VLValRecaudado$ = Format(Me.grdAlterno.text * 100, "000000000000")
    
    'Valor Adeudado
    Me.grdAlterno.Col = 18
    If Me.grdAlterno.text >= 0 Then
        VLValAdeudado$ = Format(Me.grdAlterno.text * 100, "000000000000")
    Else
        VLValAdeudado$ = Format(Me.grdAlterno.text * 100, "00000000000")
    End If
   
    'Estado de Conciliacion
    Me.grdAlterno.Col = 7
    VLEstBanco$ = Trim(Me.grdAlterno.text)
    Me.grdAlterno.Col = 8
    VLEstCateg$ = Trim(Me.grdAlterno.text)
    If VLEstBanco = "SI" And VLEstCateg = "SI" Then
        VLEstConcilia$ = "0"
    ElseIf VLEstBanco = "SI" And VLEstCateg = "NO" Then
        If VLCanal$ = "DAT" Then
           VLEstConcilia$ = "4"
        Else
           VLEstConcilia$ = "3"
        End If
    ElseIf VLEstBanco = "NO" And VLEstCateg = "SI" Then
        VLEstConcilia$ = "2"
    ElseIf VLEstBanco = "NO" And VLEstCateg = "NO" Then
        VLEstConcilia$ = "03"
    End If
    
    'Grabo el registro de Detalle
    VTLineal$ = "D"
    VTLineal$ = VTLineal$ + FechaProceso$ + VLTipoMsg$ + VLTipoTrx$ + VLCodCuenta$
    VTLineal$ = VTLineal$ + VLNumFactura$ + VLCodIfi$ + VLHoraTrxLocal$ + VLFechaTrxLocal$
    VTLineal$ = VTLineal$ + VLCodOperador$ + VLCodResultado$ + VLCodAutorizacion$ + VLSecIfi$
    VTLineal$ = VTLineal$ + VLCodTerminal$ + VLSecMit + VLCanal
    VTLineal$ = VTLineal$ + VLValAdeudado$ + VLValRecaudado$ + VLEstConcilia$

    Print #1, VTLineal$
    'Debug.Print VTLineal$
   
    Next j%
 
    'Cierro el archivo y muestro mensaje indicando la generacion exitosa del mismo.
    Close #1
    MsgBox "Archivo Generado Exitosamente", vbOKOnly + vbInformation, "TServi"

End Sub
Sub PLConfirmaSenae()
    'Agregar validacion de que si está seguro de Cerrar la Conciliacion
    Respuesta = MsgBox("Desea Cerrar la Conciliacion", vbInformation + vbOKCancel, "TServi")
    If Respuesta = vbCancel Then
        Exit Sub
    End If
    'Confimacion de Activacion de Casilla: Marcar Todos
    If Me.chkTodos.Value = False Then
        MsgBox "Seleccione la Casilla: Marcar Todos", vbInformation + vbOKOnly, "TServi"
        Exit Sub
    End If
    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, "43369"  '"43295"
    PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT4, Trim(txt_empresa.text)
    PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, 0
    PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
    PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, ""
    PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, ""
    PMPasoValores SqlConn&, "@o_existe", 1, SQLCHAR, Space(1)
    If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_senae_x", True, "Búsqueda de Datos") Then
        PMChequea SqlConn&
        MsgBox "La conciliacion se ha cerrado.", vbOKOnly + vbInformation, "TServi"
'         PLBuscarSENAEFile (0)   'contecom
'         PLGeneraArchivoSenae    'contecom
    Else
        PMChequea SqlConn&
'        PLBuscarSENAEFile (0)   'contecom
'        PLGeneraArchivoSenae    'contecom
    End If
    
    PLBuscarSenae (0)
   ' PLBuscarCnel (0)  'Luego de la confirmacion realizo nuevamente la consulta _
                              para refrescar la columna que muestra el estado de la _
                              conciliacion en Pantalla
    Me.chkTodos.Value = False
    If Me.grdConci.Rows > 1 Then Me.grdConci.topRow = 1
    If Me.grdConci.Rows > 1 Then Me.grdConci.LeftCol = 1
End Sub

Sub PLConfirmaEMELGUR()
    'Agregar validacion de que si está seguro de Cerrar la Conciliacion
    Respuesta = MsgBox("Desea Cerrar la Conciliacion", vbInformation + vbOKCancel, "TServi")
    If Respuesta = vbCancel Then
        Exit Sub
    End If
    'Confimacion de Activacion de Casilla: Marcar Todos
    If Me.chkTodos.Value = False Then
        MsgBox "Seleccione la Casilla: Marcar Todos", vbInformation + vbOKOnly, "TServi"
        Exit Sub
    End If
    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
    PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR%, "X"
    PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text)
    PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, 0
    PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
    PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, ""
    PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, ""
    PMPasoValores SqlConn, "@o_existe", 1, SQLCHAR, Space(1)
    If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_categ", True, "Búsqueda de Datos") Then
        PMChequea SqlConn&
        MsgBox "La conciliacion se ha cerrado.", vbOKOnly + vbInformation, "TServi"
        vlexiste = FMRetParam(SqlConn, 1)
        If vlexiste = "S" Then
           Me.PLBuscarCATEGFile (0)
           PLGeneraArchivoConciliaEMELGUR
        Else
           PLGeneraArchivoNoHayRecaudacion
        End If
    Else
        PMChequea SqlConn&
        vlexiste = FMRetParam(SqlConn, 1)
        If vlexiste = "S" Then
           Me.PLBuscarCATEGFile (0)
           PLGeneraArchivoConciliaEMELGUR
        Else
           'En el caso de que no exista recaudacion o conciliacion de esta fecha
           'se debe generar un registro con la cabecera unicamente.
           PLGeneraArchivoNoHayRecaudacion
        End If
    End If
    PLBuscarCATEGUsuario (0)  'Luego de la confirmacion realizo nuevamente la consulta _
                              para refrescar la columna que muestra el estado de la _
                              conciliacion en Pantalla
    Me.chkTodos.Value = False
    If Me.grdConci.Rows > 1 Then Me.grdConci.topRow = 1
    If Me.grdConci.Rows > 1 Then Me.grdConci.LeftCol = 1
End Sub




Sub PLGeneraArchivoConciliaEMELGUR()
    'Aplico formato al campo hora
    FormateoCampoHora
    'Abro el archivo para comenzar a grabar el detalle.
    'VTnombarch$ = "BANBBO" & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2) & ".DAT"
    'VTnombarch$ = "BANBOL" & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2) & ".DAT"
    If Me.txt_empresa.text = 1 Then
       VTnombarch$ = "BANBOL" & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2) & ".DAT"
    ElseIf Me.txt_empresa.text = 1127 Then
       VTnombarch$ = "BANCBOL" & Mid(Me.dtFecha, 4, 2) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 9, 2) & ".DAT"
    End If
    
    Open "c:\cobis\tadmin\" & VTnombarch$ For Output As #1

    'Registro de Cabecera
    FechaProceso$ = Mid(Me.dtFecha, 7, 4) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2)
    FechaRecaudacion$ = Mid(Me.dtFecha, 7, 4) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2)
    
    'Obtener el total recaudado
    Dim VLTotRecauda As Currency
    For t% = 1 To Me.grdAlterno.Rows - 1
        Me.grdAlterno.Row = t%
        Me.grdAlterno.Col = 6     'Columna que tiene el estado de la Conciliacion(OK-CA-BO)
        If Me.grdAlterno.text = "OK" Or Me.grdAlterno.text = "BO" Then
            Me.grdAlterno.Col = 3
            VLTotRecauda = VLTotRecauda + Me.grdAlterno.text
        End If
    Next t%
    
    VLCodSeg$ = ""
    CodigoIfi$ = "0000"
    'Codigo de seguridad asignado por la CATEG al BCO
    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
    PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "T"   'T = Parametro de Seguridad asigando al Banco
    PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text)
    PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, 0
    PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
    PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, Me.cmdEstadoBco.text
    PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, Me.cmbEstadoEmp.text
    'PMPasoValores SqlConn&, "@o_codseg", 1, SQLINT4, 0
    PMPasoValores SqlConn&, "@o_codseg", 1, SQLVARCHAR, "        "
    PMPasoValores SqlConn&, "@o_codifi", 1, SQLVARCHAR, "    "
    If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_categ", True, "Ok... Consulta de Pagos TVCABLE") Then
        PMChequea SqlConn
        VLCodSeg$ = FMRetParam$(SqlConn&, 1)
        CodigoIfi$ = Format(FMRetParam$(SqlConn&, 2), "0000")
    End If
    
    'TotalRecaudado$ = "888888888888"
    TotalRecaudado$ = CStr(VLTotRecauda * 100)
    TotalRecaudado$ = Format(TotalRecaudado$, "000000000000")
    VLSpaces$ = String(106, "0")
    
    'Grabo el Registro de Cabecera
    VTLineal$ = "C"
    VTLineal$ = VTLineal$ + FechaProceso$ + FechaRecaudacion$ + CodigoIfi$
    VTLineal$ = VTLineal$ + TotalRecaudado$ + VLCodSeg$ + VLSpaces$
    Print #1, VTLineal$



    'Registro de Detalle

    Me.grdAlterno.Row = 1
    For j% = 1 To Me.grdAlterno.Rows - 1
    Me.grdAlterno.Row = j%
    
    FechaProceso$ = Mid(Me.dtFecha, 7, 4) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2)
    VLTipoMsg$ = "0210"
    VLTipoTrx$ = "000101"
    
    'Codigo de Cuenta
    Me.grdAlterno.Col = 1
    VLCodCuenta$ = Me.grdAlterno.text + Mid("                   ", 1, 19 - Len(Me.grdAlterno.text))
    
    'Numero de Factura
    Me.grdAlterno.Col = 14
    VLNumFactura$ = Mid("00000000000000000000", 1, 20 - Len(Me.grdAlterno.text)) + Me.grdAlterno.text
    
    'Codigo Ifi
    'VLCodIfi$ = "0024"
    VLCodIfi$ = CodigoIfi$
    
    'Fecha Trx Local
    Me.grdAlterno.Col = 4
    VLFechaTrxLocal$ = Mid(Me.grdAlterno.text, 7, 4) & Mid(Me.grdAlterno.text, 1, 2) & Mid(Me.grdAlterno.text, 4, 2)
    VLFechaTrxLocal$ = Format(VLFechaTrxLocal$, "00000000")
    
    'Hora de Trx Local
    Me.grdAlterno.Col = 5
    VLHoraTrxLocal$ = Trim(Me.grdAlterno.text)
    VLHoraTrxLocal$ = Mid(VLHoraTrxLocal$, 1, 2) & Mid(VLHoraTrxLocal$, 3, 2) & Mid(VLHoraTrxLocal$, 5, 2)
    VLHoraTrxLocal$ = Format(VLHoraTrxLocal$, "000000")
    
    
    
    'Codigo de Operador
    Me.grdAlterno.Col = 9
    VLCodOperador$ = Trim(Me.grdAlterno.text)
    VLCodOperador$ = VLCodOperador$ + Mid("      ", 1, 6 - Len(VLCodOperador$))
    
    'Secuencia Ifi
    Me.grdAlterno.Col = 15
    VLSecIfi$ = Right(Me.grdAlterno.text, 6)
    VLSecIfi$ = Mid("000000", 1, 6 - Len(VLSecIfi$)) + VLSecIfi$
    
    
    'Codigo de Resultado
    VLCodResultado$ = ""
    VLEstBanco$ = ""
    VLEstCateg$ = ""
    'Me.grdConci.Col = 7
    'VLEstBanco$ = Trim(Me.grdConci.Text)
    'Me.grdConci.Col = 8
    'VLEstCateg$ = Trim(Me.grdConci.Text)
    'If VLEstBanco = "SI" And VLEstCateg = "SI" Then
    '    VLCodResultado$ = "00"
    'ElseIf VLEstBanco = "SI" And VLEstCateg = "NO" Then
    '    VLCodResultado$ = "01"
    'ElseIf VLEstBanco = "NO" And VLEstCateg = "SI" Then
    '    VLCodResultado$ = "02"
    'ElseIf VLEstBanco = "NO" And VLEstCateg = "NO" Then
    '    VLCodResultado$ = "03"
    'End If
    
    
    Me.grdAlterno.Col = 19
    'VLCodResultado$ = Mid("00", 1, 2 - Len(grdAlterno.Text)) + grdAlterno.Text
    VLCodResultado$ = Mid("000", 1, 3 - Len(grdAlterno.text)) + grdAlterno.text
    
    
    'Codigo Agencia
    'Me.grdConci.Col = 16
    'VLCodAgencia$ = Trim(Me.grdConci.Text)
    'VLCodAgencia$ = Mid("000000", 1, 6 - Len(VLCodAgencia$)) + VLCodAgencia$
    
    
    'Codigo de autorizacion
    Me.grdAlterno.Col = 10
    VLCodAutorizacion$ = Right(Me.grdAlterno.text, 6)    'Para el caso de los sec del Banco tomo los 6 ultimos
    VLCodAutorizacion$ = Mid("000000", 1, 6 - Len(VLCodAutorizacion$)) + VLCodAutorizacion$
    
    'Secuencia MIT
    Me.grdAlterno.Col = 11
    VLSecMit$ = Trim(Me.grdAlterno.text)
    VLSecMit$ = Mid("000000", 1, 6 - Len(VLSecMit$)) + VLSecMit$
    
    'Codigo Terminal
    Me.grdAlterno.Col = 16
    'Me.grdConci.Col = 9
    VLCodTerminal$ = Trim(Me.grdAlterno.text)
    'VLCodTerminal$ = Mid("0024000000000000", 1, 16 - Len(VLCodTerminal$)) + VLCodTerminal$ 'gmartillo 12/03/2008
   
    'Canal
    Me.grdAlterno.Col = 17
    VLCanal$ = Mid("   ", 1, 3 - Len(Me.grdAlterno.text)) + Me.grdAlterno.text
    
   'If VLCanal$ <> "DBA" Then 'gmartillo 12/03/2008
   If VLCanal$ <> "DAT" Then 'gmartillo 04/14/2009
       VLCodTerminal$ = Mid("0017000000000000", 1, 16 - Len(VLCodTerminal$)) + VLCodTerminal$ 'gmartillo 12/03/2008
    Else 'gmartillo 12/03/2008
       VLCodTerminal$ = VLCodTerminal$ + Mid("                ", 1, 16 - Len(VLCodTerminal$)) 'gmartillo 12/03/2008
    End If
   
    
    'If VLCanal$ = "DBA" Then gmartillo 12/03/2008
       ' VLCanal$ = "DAT" gmartillo 12/03/2008
    'End If gmartillo 12/03/2008
        
    'Valor Recaudado
    Me.grdAlterno.Col = 3
    VLValRecaudado$ = Format(Me.grdAlterno.text * 100, "000000000000")
    
    'Valor Adeudado
    Me.grdAlterno.Col = 18
    If Me.grdAlterno.text >= 0 Then
        VLValAdeudado$ = Format(Me.grdAlterno.text * 100, "000000000000")
    Else
        VLValAdeudado$ = Format(Me.grdAlterno.text * 100, "00000000000")
    End If
   
    'Estado de Conciliacion
    Me.grdAlterno.Col = 7
    VLEstBanco$ = Trim(Me.grdAlterno.text)
    Me.grdAlterno.Col = 8
    VLEstCateg$ = Trim(Me.grdAlterno.text)
    If VLEstBanco = "SI" And VLEstCateg = "SI" Then
        'VLEstConcilia$ = "0"
        VLEstConcilia$ = "I"
    ElseIf VLEstBanco = "SI" And VLEstCateg = "NO" Then
        If VLCanal$ = "DAT" Then
           'VLEstConcilia$ = "4"
           VLEstConcilia$ = "F"
        Else
           'VLEstConcilia$ = "3"
           VLEstConcilia$ = "P"
        End If
    ElseIf VLEstBanco = "NO" And VLEstCateg = "SI" Then
        'VLEstConcilia$ = "2"
        VLEstConcilia$ = "R"
    ElseIf VLEstBanco = "NO" And VLEstCateg = "NO" Then
        VLEstConcilia$ = "03"
    End If
    
    'Grabo el registro de Detalle
    VTLineal$ = "D"
    VTLineal$ = VTLineal$ + FechaProceso$ + VLTipoMsg$ + VLTipoTrx$ + VLCodCuenta$
    VTLineal$ = VTLineal$ + VLNumFactura$ + VLCodIfi$ + VLHoraTrxLocal$ + VLFechaTrxLocal$
    VTLineal$ = VTLineal$ + VLCodOperador$ + VLCodResultado$ + VLCodAutorizacion$ + VLSecIfi$
    VTLineal$ = VTLineal$ + VLCodTerminal$ + VLSecMit + VLCanal
    VTLineal$ = VTLineal$ + VLValAdeudado$ + VLValRecaudado$ + VLEstConcilia$

    Print #1, VTLineal$
    'Debug.Print VTLineal$
   
    Next j%
 
    'Cierro el archivo y muestro mensaje indicando la generacion exitosa del mismo.
    Close #1
    MsgBox "Archivo Generado Exitosamente", vbOKOnly + vbInformation, "TServi"
End Sub

Public Function PLProcesoCNTTTSV(ParOpcion1 As String, ParOpcion2 As Long, ParOpcion3 As String, ParOpcion4 As String) As Boolean

'*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-'
'Autor: Tania Cumbicus                                       '
'Fecha: 21-Nov-2009                                            '
'Descripcion: Metodo que realiza los procesos necesarios para  '
'             la conciliacion de pagos con la CNTTTSV              '
'Opciones: Funciones del parametro parOpcion1                  '
'          0 - Consulta de pagos pendientes                    '
'          1 - Procesa ajustes de conciliacion                 '
'          2 - Confirmacion de la conciliacion                 '
'          3 - Genera el reporte de la conciliacion            '
'*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-'

    On Error GoTo Error
    Dim VResul As String
    Select Case ParOpcion1
        Case "0" 'OK
        '0 - Consulta de pagos pendientes
            chkTodos.Value = 0
            
            PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
            PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "S"
            PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text)
            PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, ParOpcion2
            PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
            If Me.cmdEstadoBco.text <> "TODOS" Then
                PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, Me.cmdEstadoBco.text
            End If
            If Me.cmbEstadoEmp.text <> "TODOS" Then
                PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, Me.cmbEstadoEmp.text
            End If
            If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_cntttsv", True, "Ok... Consulta de Pagos CNTTTSV") Then
                If ParOpcion2 = 0 Then
                   PgMapeaFlexG grdConci, True, False, 0, 15, 13
                Else
                   PgMapeaFlexG grdConci, False, False, 0, 15, 13
                End If
                PMChequea SqlConn&
                
            If Me.grdConci.Tag = "15" Then
                Me.grdConci.Col = 10
                Me.grdConci.Row = Me.grdConci.Rows - 1
                'PLBuscarIESS (Me.grdConci.Text)
                Call PLProcesoCNTTTSV("0", Me.grdConci.text, "", "")
            Else
                'Elimino la Columna donde traje los secueciales para la busqueda
                Me.lbl_registros.Caption = (Me.grdConci.Rows - 1)
                
                'Formato al Grid
                Me.grdConci.ColWidth(1) = 1700  'CEP
                Me.grdConci.ColWidth(2) = 2445  'Nombre
                Me.grdConci.ColWidth(3) = 1100  'Valor
                Me.grdConci.ColWidth(4) = 1100  'Fecha Cont.
                Me.grdConci.ColWidth(5) = 850   'Hora
                Me.grdConci.ColWidth(6) = 2300  'Resultado
                Me.grdConci.ColWidth(7) = 1100  'Status Bco
                Me.grdConci.ColWidth(8) = 1100  'Status Emp
                Me.grdConci.ColWidth(9) = 1200  'Usuario
                Me.grdConci.ColWidth(10) = 1200  'Secuencial
                'Me.grdConci.ColWidth(10) = 1100  'autorizacion
                'Me.grdConci.ColAlignment(10) = 7
                'Me.grdConci.ColWidth(11) = 1100 'N° Autorizacion
                'Me.grdConci.ColWidth(12) = 1100 'Secuencia MIT
                Me.grdConci.ColWidth(11) = 1100 'Tipo_trn
                Me.grdConci.ColWidth(12) = 0 'estado conciliacion
                
                PLSacaTotalesCATEG   'Barrido del Grid para sacar totales
                
                'activa botones de confirmacion y proceso
                If (Me.cmdEstadoBco.text <> "TODOS" Or Me.cmbEstadoEmp.text <> "TODOS") Then
                    cmdBoton(1).Enabled = False
                    cmdBoton(4).Enabled = False
                Else
                    cmdBoton(1).Enabled = True
                    cmdBoton(4).Enabled = False
                End If
                VScierre = "N"
                For k% = 1 To (grdConci.Rows - 1)
                    grdConci.Row = k%
                    grdConci.Col = 6
                    VResul = Trim(grdConci.text)
                    grdConci.Row = k%
                    grdConci.Col = 12
                    If Trim(grdConci.text) = "" And VResul <> "OK" Then
                        cmdBoton(1).Enabled = False
                        cmdBoton(4).Enabled = True
                        Exit For
                    End If
                    If Trim(grdConci.text) = "S" Then
                        VScierre = "S"
                        Exit For
                    End If
                Next k
            
            End If
            
            Else
                PMLimpiaGrid Me.grdConci
                
                'Resultados
                Me.lblOkBco.Caption = "0"
                Me.lblSoloBco.Caption = "0"
                Me.lblProcesBco.Caption = "0"
                Me.lblOkBcoValor.Caption = "0.00"
                Me.lblSoloBcoValor.Caption = "0.00"
                Me.lblProcesBcoValor.Caption = "0.00"
                
                Me.lblOkEmp.Caption = "0"
                Me.lblSoloEmp.Caption = "0"
                Me.lblProcesEmp.Caption = "0"
                Me.lblOkEmpValor.Caption = "0.00"
                Me.lblSoloEmpValor.Caption = "0.00"
                Me.lblProcesEmpValor.Caption = "0.00"
                Me.lbl_registros = 0
            End If
            
            If Me.grdConci.Rows > 1 Then Me.grdConci.topRow = 1
            If Me.grdConci.Rows > 1 Then Me.grdConci.LeftCol = 1
        Case "1" 'OK
        '1 - Procesa ajustes de conciliacion
            'Validacion de Estados
            If Me.optProc(0).Value = True Then      'Habilitar
                If Not (Me.cmdEstadoBco.text = "SI" And Me.cmbEstadoEmp.text = "NO") Then
                    MsgBox "Estados deben ser: " & Chr(13) & "ESTADO BANCO = SI           " & Chr(13) & "ESTADO EMPRESA = NO", vbInformation + vbOKOnly, "TServi"
                    Exit Function
                End If
            ElseIf Me.optProc(1).Value = True Then  'Reversar
                If Not (Me.cmdEstadoBco.text = "NO" And Me.cmbEstadoEmp.text = "SI") Then
                    MsgBox "Estados deben ser: " & Chr(13) & "ESTADO BANCO = NO           " & Chr(13) & "ESTADO EMPRESA = SI", vbInformation + vbOKOnly, "TServi"
                    Exit Function
                End If
            End If
            
            For j% = 1 To Me.grdConci.Rows - 1
            grdConci.Row = j
                If Me.grdConci.CellForeColor = vbBlue Then
                    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
                    PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR%, "M"
                    PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text)
                    PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, Trim(Me.grdConci.TextMatrix(j%, 10))
                    PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
                    If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_cntttsv", True, "Búsqueda de Datos") Then
                        PMChequea SqlConn&
                    End If
                        Me.grdConci.CellForeColor = vbBlack
                        Me.grdConci.CellFontBold = False
                        Set Me.grdConci.CellPicture = Nothing
                        Me.grdConci.CellAlignment = 6
                End If
            Next j%
            'Actualizo el Flex
            Call PLProcesoCNTTTSV("0", 0, "", "")
            
        Case "2" 'falta
        '2 - Confirmacion de la conciliacion
            'Agregar validacion de que si está seguro de Cerrar la Conciliacion
            Respuesta = MsgBox("Desea Cerrar la Conciliacion", vbInformation + vbOKCancel, "TServi")
            If Respuesta = vbCancel Then
                Exit Function
            End If
            
            'Confimacion de Activacion de Casilla: Marcar Todos
            If Me.chkTodos.Value = False Then
                MsgBox "Seleccione la Casilla: Marcar Todos", vbInformation + vbOKOnly, "TServi"
                Exit Function
            End If
        
            PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
            PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR%, "X"
            PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text)
            PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, 0
            PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
            PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, ""
            PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, ""
            
            'Agregar parametro de Output que indique si hay data cargada en la conciliación de ese día.
            PMPasoValores SqlConn, "@o_existe", 1, SQLCHAR, Space(1)
            If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_cntttsv", True, "Búsqueda de Datos") Then
                PMChequea SqlConn&
                vlexiste = FMRetParam(SqlConn, 1)
                If vlexiste = "S" Then
                    If VScierre <> "S" Then
                        MsgBox "La conciliacion se ha cerrado con exito.", vbOKOnly + vbInformation, "TServi"
                    Else
                        Respuesta = MsgBox("Registros ya fueron conciliados" & Chr(13) & "Desea volver a generar archivo de ajuste?", vbInformation + vbOKCancel, "TServi")
                        If Respuesta = vbCancel Then
                            Exit Function
                        End If
                    End If
                    'Me.PLBuscarIESSFile (0)
                    Call PLProcesoCNTTTSV("4", 0, "", "")
                    'PLGeneraArchivoConciliaIESS
                    Call PLProcesoCNTTTSV("5", 0, "", "")
                End If
            End If
            Call PLProcesoCNTTTSV("0", 0, "", "")
            Me.chkTodos.Value = False
            If Me.grdConci.Rows > 1 Then Me.grdConci.topRow = 1
            If Me.grdConci.Rows > 1 Then Me.grdConci.LeftCol = 1
        Case "3" 'OK
        
        '3 - Genera el reporte de la conciliacion
        
             'INICIO (SIPECOM) MALDAZ OOF REF002
             If validaOffice("OpenOffice") Then
                 PLProcesoCNTTTSVReporteOOF
             Else
                 PLProcesoCNTTTSVReporte
             End If
            'FIN (SIPECOM) MALDAZ OOF REF002
        

                
        Case "4"
            'VLValorTotal = ""
            PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
            PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "C"
            PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text)
            PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, ParOpcion2
            PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
            PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, Me.cmdEstadoBco.text
            PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, Me.cmbEstadoEmp.text
            PMPasoValores SqlConn&, "@o_total", 1, SQLMONEY, "0"
            
            If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_cntttsv", True, "Ok... Consulta de Pagos CNTTTSV") Then
               If ParOpcion2 = 0 Then
                    VLValorTotal = 0
                  'PgMapeaFlexG grdAlterno, True, False, 0, 15, 7      'lfcm 03-septiembre-2008
                   PgMapeaFlexG grdAlterno, True, False, 0, 15, 8      'lfcm 03-septiembre-2008
                   VLValorTotal = FMRetParam(SqlConn, 1)
               Else
                  'PgMapeaFlexG grdAlterno, False, False, 0, 15, 7     'lfcm 03-septiembre-2008
                   PgMapeaFlexG grdAlterno, False, False, 0, 15, 8     'lfcm 03-septiembre-2008
               End If
               
               
               PMChequea SqlConn&
               
               If Me.grdAlterno.Tag = "15" Then
                  Me.grdAlterno.Col = 2
                  Me.grdAlterno.Row = Me.grdAlterno.Rows - 1
                  'PLBuscarIESSFile (Me.grdAlterno.Text)
                  Call PLProcesoCNTTTSV("4", Me.grdAlterno.text, "", "")
                  
               Else
                  Me.lbl_registros.Caption = (Me.grdAlterno.Rows - 1)
               End If
            Else
               PMLimpiaGrid Me.grdAlterno
            End If
        Case "5"
             
            'Aplico formato al campo hora
'            If Me.grdAlterno.Rows > 2 Then
'            'Validar que el GRID TENGA REGISTROS. IMPORTANTE !!! DESARROLLAR
'            Me.grdAlterno.Col = 3
'            For s% = 2 To Me.grdAlterno.Rows - 1
'                Me.grdAlterno.Row = s%
'                Me.grdAlterno.Text = Replace(Me.grdAlterno.Text, ":", "")
'                Next s
'            End If
        
            'Abro el archivo para comenzar a grabar el detalle.
            VTnombarch$ = "CNTTTSV_WEBBBOL_AJU_" & Mid(Me.dtFecha, 4, 2) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 7, 4) & ".txt"    'lfcm 03-septiembre-2008
            Open "c:\cobis\tadmin\" & VTnombarch$ For Output As #1
        
            'Registro de Detalle
            If Me.grdAlterno.Rows > 1 Then
                 VLValorTotal = Mid(Trim(VLValorTotal * 100), 1, 19)
                 VLValorTotal = Format(Trim(VLValorTotal), "0000000000000000000")
                 VLValorTotal = Mid(VLValorTotal, 1, 17) & "," & Mid(VLValorTotal, 18, 2)
                 VLTipoRegisCab = "01"
                 VLRegistros = Me.grdAlterno.Rows - 1
                 'VLRegistros = Format(Trim(VLRegistros), "0000000000")       'lfcm 03-septiembre-2008
                 VLRegistros = Format(Trim(VLRegistros + 1), "0000000000")    'lfcm 03-septiembre-2008
                 VLBanco = "007"
                 Me.grdAlterno.Col = 4
                 VLFecContbCab = Me.grdAlterno.text
                             
                 VTLineal$ = ""
                 VTLineal$ = VTLineal$ + VLTipoRegisCab + "|" + VLBanco + "|" + VLFecContbCab + "|" + VLValorTotal + "|" + VLRegistros
                 Print #1, VTLineal$
                 
                 'Registro del Detalle
                 For j% = 1 To Me.grdAlterno.Rows - 1
                      Me.grdAlterno.Row = j%
                      'CEP
                      Me.grdAlterno.Col = 1
                      VLCep$ = Me.grdAlterno.text
                      
                      'Secuencia Bco
                      Me.grdAlterno.Col = 2
                      VLSecBco$ = Trim(Me.grdAlterno.text)
                      'VLSecBco$ = "" & Space(15 - Len(VLSecBco$)) & VLSecBco$     'lfcm 03-septiembre-2008
                      VLSecBco$ = "" & VLSecBco$ & Space(15 - Len(VLSecBco$))      'lfcm 03-septiembre-2008
                      
                      
                      'Hora
                      Me.grdAlterno.Col = 3
                      VLFecHor$ = Trim(Me.grdAlterno.text)
                      
                      'Fecha contable
                      Me.grdAlterno.Col = 4
                      VLFecContb$ = Me.grdAlterno.text
                      'Mid(Me.grdAlterno.Text, 7, 4) & "-" & Mid(Me.grdAlterno.Text, 1, 2) & "-" & Mid(Me.grdAlterno.Text, 4, 2)
                      
                      'Valor
                      Me.grdAlterno.Col = 5
                      VLValor = Mid(Trim(grdAlterno.text * 100), 1, 11)
                      'VLValor = Format(Trim(VLValor), "0000000000000000000")
                      VLValor = Format(Trim(VLValor), "00000000000") 'GAMC - 15/08/2008
                      VLValor = Mid(VLValor, 1, 9) & "," & Mid(VLValor, 10, 2)
                                                       
                      'Estado
                      Me.grdAlterno.Col = 6
                      VLEstado = Me.grdAlterno.text
                                     
                      'FECHA PROCESO
                      FechaProceso$ = Mid(Me.dtFecha, 7, 4) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2)
                      VLTipoMsg$ = "0210"
                      VLTipoTrx$ = "000101"
                      
                      'Canal                                          'lfcm 03-septiembre-2008
                      Me.grdAlterno.Col = 7                           'lfcm 03-septiembre-2008
                      VLCTGCanal = ""                                 'lfcm 03-septiembre-2008
                      VLCTGCanal = Mid(Me.grdAlterno.text, 1, 3)      'lfcm 03-septiembre-2008
                      
                                       
                      'Grabo el registro de Detalle
                      'If VLEstConcilia$ <> "" Then
                      VTLineal$ = ""
                      'VTLineal$ = VTLineal$ + VLCep + "|" + VLSecBco$ + "|" + VLFecHor$ + "|" + VLFecContb$ + "|" + VLValor + "|" + VLEstado          'lfcm 03-septiembre-2008
                      VTLineal$ = "02|" + VTLineal$ + VLCep + "|" + VLSecBco$ + "|" + VLFecHor$ + "|" + VLFecContb$ + "|" + VLValor + "|" + VLEstado + "|" + VLCTGCanal    'lfcm 03-septiembre-2008
                      Print #1, VTLineal$
                      'End If
                      'Debug.Print VTLineal$
                
                 Next j%
            Else
'                VTLineal$ = ""
'                VTLineal$ = VTLineal$ + "0"
'                Print #1, VTLineal$
                 VLValorTotal = "0"
                 VLValorTotal = Mid(Trim(VLValorTotal * 100), 1, 19)
                 VLValorTotal = Format(Trim(VLValorTotal), "0000000000000000000")
                 VLValorTotal = Mid(VLValorTotal, 1, 17) & "," & Mid(VLValorTotal, 18, 2)
                 VLTipoRegisCab = "01"
                 VLRegistros = 0
                 'VLRegistros = Format(Trim(VLRegistros), "0000000000")       'lfcm 03-septiembre-2008
                 VLRegistros = Format(Trim(VLRegistros + 1), "0000000000")    'lfcm 03-septiembre-2008
                 VLBanco = "007"
                 VLFecContbCab = Mid(Me.dtFecha, 4, 2) & "/" & Mid(Me.dtFecha, 1, 2) & "/" & Mid(Me.dtFecha, 7, 4)
                             
                 VTLineal$ = ""
                 VTLineal$ = VTLineal$ + VLTipoRegisCab + "|" + VLBanco + "|" + VLFecContbCab + "|" + VLValorTotal + "|" + VLRegistros
                 Print #1, VTLineal$

            End If
                

         
            'Cierro el archivo y muestro mensaje indicando la generacion exitosa del mismo.
            Close #1
            MsgBox "Archivo Generado Exitosamente", vbOKOnly + vbInformation, "TServi"

                        
    End Select
    
Error:
    PMChequea SqlConn&
    
End Function

'(SIPECOM) MALDAZ OOF REF002
Sub PLProcesoCNTTTSVReporteOOF()
            Dim oExcelApp   As Object
            Dim oWs         As Object
            Dim oWb         As Object
            Dim sXlsTemplate As String
            Dim iRow As Integer
            Dim iCol As Integer
            Dim busqueda As String
            Dim bco1, bco2, bco3 As String
            Dim emp1, emp2, emp3 As String
            
            
            On Error GoTo ErrorHandler
            
                        'INICIO (SIPECOM) LCHACHA OOF REF004
                        'sXlsTemplate = App.Path & "\xrptCNTTTSV.XLT"
                        Dim sNewXlsFile  As String
                        sNewXlsFile = "xrptCNTTTSV" & Format$(Now, "YYYYMMDDHHMMSS") + ".ods"
                        FileCopy App.Path & "\xrptCNTTTSV.xlt", Environ$("tmp") & "\" & sNewXlsFile
                        sXlsTemplate = Environ$("tmp") & "\" & sNewXlsFile
                        'FIN (SIPECOM) LCHACHA OOF REF004
            
            'Set oExcelApp = CreateObject("EXCEL.APPLICATION")              '(SIPECOM) LCHACHA OOF REF001
            Set oExcelApp = CreateObject("HOJAELECTRONICABB.APPLICATION")   '(SIPECOM) LCHACHA OOF REF001
            'oExcelApp.Visible = False
            'oExcelApp.Workbooks.Open Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True   '(SIPECOM) LCHACHA OOF REF001
            oExcelApp.Workbooks.OpenW Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True, DestinationFile:="Pantalla"  '(SIPECOM) LCHACHA OOF REF001
            Set oWs = oExcelApp.ActiveSheet
            Set oWb = oExcelApp.ActiveWorkbook
            
            Set oWs = oExcelApp.ActiveSheet
            oWs.Cells(6, 1).Value = "      Reporte de Pagos de CNTTTSV - Empresa: (" & Me.txt_empresa & ") " & Me.lbl_empresa
            For iRow = 1 To Me.grdConci.Rows - 1
                Screen.MousePointer = 11
                Me.grdConci.Row = iRow
                Me.grdConci.Col = 1
                oWs.Cells(8 + iRow, 1).Value = Me.grdConci.text
                Me.grdConci.Col = 2
                oWs.Cells(8 + iRow, 2).Value = Me.grdConci.text
                Me.grdConci.Col = 3
                oWs.Cells(8 + iRow, 3).Value = Me.grdConci.text
                Me.grdConci.Col = 4
                oWs.Cells(8 + iRow, 4).Value = Me.grdConci.text
                Me.grdConci.Col = 5
                oWs.Cells(8 + iRow, 5).Value = Me.grdConci.text
                Me.grdConci.Col = 6
                oWs.Cells(8 + iRow, 6).Value = Me.grdConci.text
                Me.grdConci.Col = 7
                oWs.Cells(8 + iRow, 7).Value = Me.grdConci.text
                Me.grdConci.Col = 8
                oWs.Cells(8 + iRow, 8).Value = Me.grdConci.text
                Me.grdConci.Col = 9
                oWs.Cells(8 + iRow, 9).Value = Me.grdConci.text
                Me.grdConci.Col = 10
                oWs.Cells(8 + iRow, 10).Value = Me.grdConci.text
                Me.grdConci.Col = 11
                oWs.Cells(8 + iRow, 11).Value = Me.grdConci.text
                'Me.grdConci.Col = 12
                'oWs.Cells(8 + iRow, 12).Value = Me.grdConci.Text
                
                Screen.MousePointer = 0
            Next iRow
            oWs.Cells(13 + iRow, 1).Value = "TOTALES BANCO:"
            oWs.Cells(13 + iRow, 1).Font.Bold = True
            oWs.Cells(15 + iRow, 1).Value = Space(50) & "No." & Space(30) & "Valor"
            oWs.Cells(15 + iRow, 1).Font.Bold = True
            bco1 = lblOkBco & (Space(40 - Len(lblOkBco))) & lblOkBcoValor
            oWs.Cells(16 + iRow, 1).Value = " Pagos Ok:" & Space(55) & bco1
            bco2 = lblSoloBco & (Space(40 - Len(lblSoloBco))) & lblSoloBcoValor
            oWs.Cells(17 + iRow, 1).Value = " Pagos solo en banco:" & Space(31) & bco2
            bco3 = lblProcesBco & (Space(40 - Len(lblProcesBco))) & lblProcesBcoValor
            oWs.Cells(18 + iRow, 1).Value = " Total procesados Bco:" & Space(29) & bco3
            oWs.Cells(13 + iRow, 5).Value = "TOTALES EMPRESA:"
            oWs.Cells(13 + iRow, 5).Font.Bold = True
            oWs.Cells(15 + iRow, 5).Value = Space(50) & "No." & Space(30) & "Valor"
            oWs.Cells(15 + iRow, 5).Font.Bold = True
            emp1 = lblOkEmp & (Space(40 - Len(lblOkEmp))) & lblOkEmpValor
            oWs.Cells(16 + iRow, 5).Value = " Pagos Ok:" & Space(55) & emp1
            emp2 = lblSoloEmp & (Space(40 - Len(lblSoloEmp))) & lblSoloEmpValor
            oWs.Cells(17 + iRow, 5).Value = " Pagos solo en Empresa:" & Space(26) & emp2
            emp3 = lblProcesEmp & (Space(40 - Len(lblProcesEmp))) & lblProcesEmpValor
            oWs.Cells(18 + iRow, 5).Value = " Total procesados Emp:" & Space(28) & emp3
            
            
            'oExcelApp.Visible = True
            Set oWs = Nothing
            Set oExcelApp = Nothing
            DoEvents
            Exit Sub
            
ErrorHandler:
                Screen.MousePointer = vbDefault
                MsgBox err.Description & " (" & CStr(err.Number) & ")", vbExclamation, "Excel Export"
                'On Error Resume Next
                'oExcelApp.Quit
                Set oWs = Nothing
                Set oExcelApp = Nothing
End Sub
'(SIPECOM) MALDAZ OOF REF002
Sub PLProcesoCNTTTSVReporte()
            Dim oExcelApp   As Object
            Dim oWs         As Object
            Dim oWb         As Object
            Dim sXlsTemplate As String
            Dim iRow As Integer
            Dim iCol As Integer
            Dim busqueda As String
            Dim bco1, bco2, bco3 As String
            Dim emp1, emp2, emp3 As String
            
            
            On Error GoTo ErrorHandler
            sXlsTemplate = App.Path & "\xrptCNTTTSV.XLT"
            
            Set oExcelApp = CreateObject("EXCEL.APPLICATION")              '(SIPECOM) LCHACHA OOF REF001
            oExcelApp.Visible = False
            oExcelApp.Workbooks.Open Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True   '(SIPECOM) LCHACHA OOF REF001
            Set oWs = oExcelApp.ActiveSheet
            Set oWb = oExcelApp.ActiveWorkbook
            
            Set oWs = oExcelApp.ActiveSheet
            oWs.Cells(6, 1).Value = "      Reporte de Pagos de CNTTTSV - Empresa: (" & Me.txt_empresa & ") " & Me.lbl_empresa
            For iRow = 1 To Me.grdConci.Rows - 1
                Screen.MousePointer = 11
                Me.grdConci.Row = iRow
                Me.grdConci.Col = 1
                oWs.Cells(8 + iRow, 1).Value = Me.grdConci.text
                Me.grdConci.Col = 2
                oWs.Cells(8 + iRow, 2).Value = Me.grdConci.text
                Me.grdConci.Col = 3
                oWs.Cells(8 + iRow, 3).Value = Me.grdConci.text
                Me.grdConci.Col = 4
                oWs.Cells(8 + iRow, 4).Value = Me.grdConci.text
                Me.grdConci.Col = 5
                oWs.Cells(8 + iRow, 5).Value = Me.grdConci.text
                Me.grdConci.Col = 6
                oWs.Cells(8 + iRow, 6).Value = Me.grdConci.text
                Me.grdConci.Col = 7
                oWs.Cells(8 + iRow, 7).Value = Me.grdConci.text
                Me.grdConci.Col = 8
                oWs.Cells(8 + iRow, 8).Value = Me.grdConci.text
                Me.grdConci.Col = 9
                oWs.Cells(8 + iRow, 9).Value = Me.grdConci.text
                Me.grdConci.Col = 10
                oWs.Cells(8 + iRow, 10).Value = Me.grdConci.text
                Me.grdConci.Col = 11
                oWs.Cells(8 + iRow, 11).Value = Me.grdConci.text
                'Me.grdConci.Col = 12
                'oWs.Cells(8 + iRow, 12).Value = Me.grdConci.Text
                
                Screen.MousePointer = 0
            Next iRow
            oWs.Cells(13 + iRow, 1).Value = "TOTALES BANCO:"
            oWs.Cells(13 + iRow, 1).Font.Bold = True
            oWs.Cells(15 + iRow, 1).Value = Space(50) & "No." & Space(30) & "Valor"
            oWs.Cells(15 + iRow, 1).Font.Bold = True
            bco1 = lblOkBco & (Space(40 - Len(lblOkBco))) & lblOkBcoValor
            oWs.Cells(16 + iRow, 1).Value = " Pagos Ok:" & Space(55) & bco1
            bco2 = lblSoloBco & (Space(40 - Len(lblSoloBco))) & lblSoloBcoValor
            oWs.Cells(17 + iRow, 1).Value = " Pagos solo en banco:" & Space(31) & bco2
            bco3 = lblProcesBco & (Space(40 - Len(lblProcesBco))) & lblProcesBcoValor
            oWs.Cells(18 + iRow, 1).Value = " Total procesados Bco:" & Space(29) & bco3
            oWs.Cells(13 + iRow, 5).Value = "TOTALES EMPRESA:"
            oWs.Cells(13 + iRow, 5).Font.Bold = True
            oWs.Cells(15 + iRow, 5).Value = Space(50) & "No." & Space(30) & "Valor"
            oWs.Cells(15 + iRow, 5).Font.Bold = True
            emp1 = lblOkEmp & (Space(40 - Len(lblOkEmp))) & lblOkEmpValor
            oWs.Cells(16 + iRow, 5).Value = " Pagos Ok:" & Space(55) & emp1
            emp2 = lblSoloEmp & (Space(40 - Len(lblSoloEmp))) & lblSoloEmpValor
            oWs.Cells(17 + iRow, 5).Value = " Pagos solo en Empresa:" & Space(26) & emp2
            emp3 = lblProcesEmp & (Space(40 - Len(lblProcesEmp))) & lblProcesEmpValor
            oWs.Cells(18 + iRow, 5).Value = " Total procesados Emp:" & Space(28) & emp3
            
            
            oExcelApp.Visible = True
            Set oWs = Nothing
            Set oExcelApp = Nothing
            Exit Sub
            
ErrorHandler:
                Screen.MousePointer = vbDefault
                MsgBox err.Description & " (" & CStr(err.Number) & ")", vbExclamation, "Excel Export"
                On Error Resume Next
                oExcelApp.Quit
                Set oWs = Nothing
                Set oExcelApp = Nothing
End Sub

Sub PLBuscarClaro(orden As Long) 'Claro DAPV 15/sep/2011
Dim VResul As String
    chkTodos.Value = 0
   'Hago la consulta de los primeros 15 resultados
   PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 43283
  ' PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "S"
   PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text)
   PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, orden
   PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
   PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, Me.cmdEstadoBco.text
   PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, Me.cmbEstadoEmp.text
   PMPasoValores SqlConn&, "@i_modo", 0, SQLINT2, 0
   
    If optProc(2).Value = True Then
        PMPasoValores SqlConn&, "@i_forma_pago", 0, SQLVARCHAR, "ND.CTA"
    End If
    If optProc(0).Value = True Then
        PMPasoValores SqlConn&, "@i_forma_pago", 0, SQLVARCHAR, "OTROS"
    End If
   If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_claro_s", True, "Ok... Consulta de Pagos Claro") Then
      If orden = 0 Then
         PgMapeaFlexG grdConci, True, False, 0, 15, 18  'RECMPS-477
      Else
         PgMapeaFlexG grdConci, False, False, 0, 15, 18 'RECMPS-477
      End If
      PMChequea SqlConn&
      If Me.grdConci.Tag = "15" Then
         Me.grdConci.Col = 11
         Me.grdConci.Row = Me.grdConci.Rows - 1
         PLBuscarClaro (Me.grdConci.text)
      Else
         'Elimino la Columna donde traje los secueciales para la busqueda
         Me.lbl_registros.Caption = (Me.grdConci.Rows - 1)
                
         'Formato al Grid
         Me.grdConci.ColWidth(1) = 1700  'Codigo
         Me.grdConci.ColWidth(2) = 2445  'Nombre Abonado
         Me.grdConci.ColWidth(3) = 1100  'Valor
         Me.grdConci.ColWidth(4) = 1100  'Fecha Trx.
         Me.grdConci.ColWidth(5) = 750   'Hora
         Me.grdConci.ColWidth(6) = 2300  'Resultado
         Me.grdConci.ColWidth(7) = 1100  'Status Bco
         Me.grdConci.ColWidth(8) = 1100  'Status Emp
         Me.grdConci.ColWidth(9) = 1200  'Usuario
         Me.grdConci.ColWidth(10) = 1100  'autorizacion
         Me.grdConci.ColAlignment(10) = 7
         Me.grdConci.ColWidth(11) = 1100 'Secuencia MIT 'N° Autorizacion
         Me.grdConci.ColWidth(12) = 1100 ' referencia 'Secuencia MIT
         Me.grdConci.ColWidth(13) = 750 'estado conciliacion
         Me.grdConci.ColWidth(14) = 1700 'Tipo CTa
         Me.grdConci.ColWidth(15) = 1700 'Canal 'RECMPS 477
         'Me.grdConci.ColWidth(15) = 1700 'CTA
         PLSacaTotalesClaro   'Barrido del Grid para sacar totales
         
         'activa botones de confirmacion y proceso
         If (Me.cmdEstadoBco.text <> "TODOS" Or Me.cmbEstadoEmp.text <> "TODOS") Then
            cmdBoton(1).Enabled = False
            cmdBoton(4).Enabled = False
         Else
            cmdBoton(1).Enabled = True
            cmdBoton(4).Enabled = False
         End If
         VScierre = "N"
         For k% = 1 To (grdConci.Rows - 1)
            grdConci.Row = k%
            grdConci.Col = 6
            VResul = Trim(grdConci.text)
            grdConci.Row = k%
            grdConci.Col = 13
            If Trim(grdConci.text) = "" And VResul <> "OK" Then
                cmdBoton(1).Enabled = False
                cmdBoton(4).Enabled = True
                Exit For
            End If
            If Trim(grdConci.text) = "S" Then
                VScierre = "S"
                Exit For
            End If
          Next k
          
      End If
      
   Else
      PMLimpiaGrid Me.grdConci
        
      'Resultados
      Me.lblOkBco.Caption = "0"
      Me.lblSoloBco.Caption = "0"
      Me.lblProcesBco.Caption = "0"
      Me.lblOkBcoValor.Caption = "0.00"
      Me.lblSoloBcoValor.Caption = "0.00"
      Me.lblProcesBcoValor.Caption = "0.00"
        
      Me.lblOkEmp.Caption = "0"
      Me.lblSoloEmp.Caption = "0"
      Me.lblProcesEmp.Caption = "0"
      Me.lblOkEmpValor.Caption = "0.00"
      Me.lblSoloEmpValor.Caption = "0.00"
      Me.lblProcesEmpValor.Caption = "0.00"
      Me.lbl_registros = 0
   End If
   
   If Me.grdConci.Rows > 1 Then Me.grdConci.topRow = 1
   If Me.grdConci.Rows > 1 Then Me.grdConci.LeftCol = 1
    
End Sub
Sub PLBuscarBroadnet(orden As Long) 'dolayas
Dim VResul As String
Dim VEmpresa As String
    chkTodos.Value = 0
   'Hago la consulta de los primeros 15 registros
   VEmpresa = Trim(txt_empresa.text)
   PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 43614
   
   If VEmpresa = "1342" Then 'MOVISTAR
      VEmpresa = "103"
   End If
   
   PMPasoValores SqlConn&, "@e_empresa", 0, SQLVARCHAR, VEmpresa
   PMPasoValores SqlConn&, "@e_siguiente", 0, SQLINT4, orden
   PMPasoValores SqlConn&, "@e_fecha", 0, SQLDATETIME, (dtFecha)
   PMPasoValores SqlConn&, "@e_estado_bco", 0, SQLVARCHAR, Me.cmdEstadoBco.text
   PMPasoValores SqlConn&, "@e_estado_emp", 0, SQLVARCHAR, Me.cmbEstadoEmp.text
'REF006 INI
'   PMPasoValores SqlConn&, "@e_modo", 0, SQLINT2, 0
   
'    If optProc(2).Value = True Then
'        PMPasoValores SqlConn&, "@e_forma_pago", 0, SQLVARCHAR, "ND.CTA"
'    End If
'    If optProc(0).Value = True Then
'        PMPasoValores SqlConn&, "@e_forma_pago", 0, SQLVARCHAR, "OTROS"
'    End If
'REF006 FIN
   If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "pa_pag_c_concilia_broadnet_s", True, "Ok... Consulta de Pagos Broadnet") Then
      If orden = 0 Then
         PgMapeaFlexG grdConci, True, False, 0, 15, 18
      Else
         PgMapeaFlexG grdConci, False, False, 0, 15, 18
      End If
      PMChequea SqlConn&
      If Me.grdConci.Tag = "15" Then
         Me.grdConci.Col = 11
         Me.grdConci.Row = Me.grdConci.Rows - 1
         PLBuscarBroadnet (Me.grdConci.text)
      Else
         'Elimino la Columna donde traje los secueciales para la busqueda
         Me.lbl_registros.Caption = (Me.grdConci.Rows - 1)
                
         'Formato al Grid
         Me.grdConci.ColWidth(1) = 1700  'Codigo
         Me.grdConci.ColWidth(2) = 2445  'Nombre Abonado
         Me.grdConci.ColWidth(3) = 1100  'Valor
         Me.grdConci.ColWidth(4) = 1100  'Fecha Trx.
         Me.grdConci.ColWidth(5) = 1100   'Hora
         Me.grdConci.ColWidth(6) = 2300  'Resultado
         Me.grdConci.ColWidth(7) = 1100  'Status Bco
         Me.grdConci.ColWidth(8) = 1100  'Status Emp
         Me.grdConci.ColWidth(9) = 1200  'Usuario
         Me.grdConci.ColWidth(10) = 1300 'Secuencia Broadnet
         Me.grdConci.ColAlignment(10) = 7
         Me.grdConci.ColWidth(11) = 1100 'Secuencia Banco
         Me.grdConci.ColWidth(12) = 1000 'Canal
         Me.grdConci.ColWidth(13) = 1100 'TipoTrx
         Me.grdConci.ColWidth(14) = 1100 'Estado conciliacion
         Me.grdConci.ColWidth(15) = 1300 'Fecha Real
         Me.grdConci.ColWidth(16) = 1700 'Tipo CTa
         Me.grdConci.ColWidth(17) = 1700 'Nro CTa
         PLSacaTotalesBroadnet   'Barrido del Grid para sacar totales
         
         'Activa botones de confirmacion y proceso
         If (Me.cmdEstadoBco.text <> "TODOS" Or Me.cmbEstadoEmp.text <> "TODOS") Then
            cmdBoton(1).Enabled = False
            cmdBoton(4).Enabled = False
         Else
            cmdBoton(1).Enabled = True
            cmdBoton(4).Enabled = False
         End If
         
         VScierre = "N"
         For k% = 1 To (grdConci.Rows - 1)
            grdConci.Row = k%
            grdConci.Col = 6
            VResul = Trim(grdConci.text)
            grdConci.Row = k%
            grdConci.Col = 14
            If Trim(grdConci.text) = "" And VResul <> "OK" Then
                cmdBoton(1).Enabled = False
                cmdBoton(4).Enabled = True
                Exit For
            End If
            If Trim(grdConci.text) = "S" Then
                VScierre = "S"
                Exit For
            End If
          Next k
          
      End If
      
   Else
      PMLimpiaGrid Me.grdConci
        
      'Resultados
      Me.lblOkBco.Caption = "0"
      Me.lblSoloBco.Caption = "0"
      Me.lblProcesBco.Caption = "0"
      Me.lblOkBcoValor.Caption = "0.00"
      Me.lblSoloBcoValor.Caption = "0.00"
      Me.lblProcesBcoValor.Caption = "0.00"
        
      Me.lblOkEmp.Caption = "0"
      Me.lblSoloEmp.Caption = "0"
      Me.lblProcesEmp.Caption = "0"
      Me.lblOkEmpValor.Caption = "0.00"
      Me.lblSoloEmpValor.Caption = "0.00"
      Me.lblProcesEmpValor.Caption = "0.00"
      Me.lbl_registros = 0
   End If
   
   If Me.grdConci.Rows > 1 Then Me.grdConci.topRow = 1
   If Me.grdConci.Rows > 1 Then Me.grdConci.LeftCol = 1
    
End Sub

'Private Sub Valida_FormaPago() 'DAPV
'    If cmdEstadoBco.Text = "SI" And cmbEstadoEmp = "NO" Then
'        Label8.Enabled = True
'        cmbFormaPago.Enabled = True
'    Else
'        Label8.Enabled = False
'        cmbFormaPago.Enabled = False
'        cmbFormaPago.ListIndex = 0
'    End If
'End Sub

Sub PLProcesarClaro() 'DAPV Procesar Claro
    'Validacion de Estados
    If Me.optProc(0).Value = True Then      'Habilitar
        If Not (Me.cmdEstadoBco.text = "SI" And Me.cmbEstadoEmp.text = "NO") Then
            MsgBox "Estados deben ser: " & Chr(13) & "ESTADO BANCO = SI           " & Chr(13) & "ESTADO EMPRESA = NO", vbInformation + vbOKOnly, "TServi"
            Exit Sub
        End If
'        If Not (Me.cmbFormaPago.Text = "OTROS") Then
'            MsgBox "Forma de Pago debe ser: " & Chr(13) & "FORMA DE PAGO = OTROS", vbInformation + vbOKOnly, "TServi"
'            Exit Sub
'        End If
    ElseIf Me.optProc(1).Value = True Then  'Revisar
        If Not (Me.cmdEstadoBco.text = "NO" And Me.cmbEstadoEmp.text = "SI") Then
            MsgBox "Estados deben ser: " & Chr(13) & "ESTADO BANCO = NO           " & Chr(13) & "ESTADO EMPRESA = SI", vbInformation + vbOKOnly, "TServi"
            Exit Sub
        End If
    ElseIf Me.optProc(2).Value = True Then  'Devolver
        If Not (Me.cmdEstadoBco.text = "SI" And Me.cmbEstadoEmp.text = "NO") Then
            MsgBox "Estados deben ser: " & Chr(13) & "ESTADO BANCO = SI           " & Chr(13) & "ESTADO EMPRESA = NO", vbInformation + vbOKOnly, "TServi"
            Exit Sub
        End If
'        If Not (Me.cmbFormaPago.Text = "ND.CTA") Then
'            MsgBox "Forma de Pago debe ser: " & Chr(13) & "FORMA DE PAGO = ND.CTA", vbInformation + vbOKOnly, "TServi"
'            Exit Sub
'        End If
    End If
    
   For j% = 1 To Me.grdConci.Rows - 1
    grdConci.Row = j
        If Me.grdConci.CellForeColor = vbBlue Then
        
            If optProc(2).Value = True Then  'ACREDITA LA DEVOLUCION
                PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 43288
                PMPasoValores SqlConn&, "@i_causa", 0, SQLINT4, Trim(txt_empresa.text)
                PMPasoValores SqlConn&, "@i_ssn", 0, SQLINT4, Trim(Me.grdConci.TextMatrix(j%, 11))
                PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
                PMPasoValores SqlConn&, "@i_ced_ruc", 0, SQLVARCHAR, Trim(Me.grdConci.TextMatrix(j%, 1))
                If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_claro_t", True, "Búsqueda de Datos") Then
                    PMChequea SqlConn&
                Else
                    Exit Sub
                End If
            End If
            
            
            PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 43284
            'PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR%, "M"
            PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text)
            PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, Trim(Me.grdConci.TextMatrix(j%, 11))
            PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
            'PMPasoValores SqlConn&, "@i_forma_pago", 0, SQLVARCHAR, Me.cmbFormaPago.Text
            If optProc(2).Value = True Then
                PMPasoValores SqlConn&, "@i_forma_pago", 0, SQLVARCHAR, "ND.CTA"
            End If
            If optProc(0).Value = True Then
                PMPasoValores SqlConn&, "@i_forma_pago", 0, SQLVARCHAR, "OTROS"
            End If
            
            If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_claro_a", True, "Búsqueda de Datos") Then
                PMChequea SqlConn&
            End If
                Me.grdConci.CellForeColor = vbBlack
                Me.grdConci.CellFontBold = False
                Set Me.grdConci.CellPicture = Nothing
                Me.grdConci.CellAlignment = 6
                
        End If
    Next j%

    'Actualizo el Flex
    Me.PLBuscarClaro (0)
    
End Sub
Sub PLProcesarBroadnet() 'ref05 Procesar Broadnet

  Dim VEmpresa As String
  
  VEmpresa = Trim(txt_empresa.text)
  
  If VEmpresa = "1342" Then
    VEmpresa = "103"
  End If

    If Me.optProc(0).Value = True Then 'Habilitar
        If Not (Me.cmdEstadoBco.text = "SI" And Me.cmbEstadoEmp.text = "NO") Then
            MsgBox "Estados deben ser: " & Chr(13) & "ESTADO BANCO = SI           " & Chr(13) & "ESTADO EMPRESA = NO", vbInformation + vbOKOnly, "TServi"
            Exit Sub
        End If
    ElseIf Me.optProc(1).Value = True Then  'Reversar
        If Not (Me.cmdEstadoBco.text = "NO" And Me.cmbEstadoEmp.text = "SI") Then
            MsgBox "Estados deben ser: " & Chr(13) & "ESTADO BANCO = NO           " & Chr(13) & "ESTADO EMPRESA = SI", vbInformation + vbOKOnly, "TServi"
            Exit Sub
        End If
    'REF006 INI
    'ElseIf Me.optProc(2).Value = True Then  'Devolver
    '    If Not (Me.cmdEstadoBco.text = "SI" And Me.cmbEstadoEmp.text = "NO") Then
    '        MsgBox "Estados deben ser: " & Chr(13) & "ESTADO BANCO = SI           " & Chr(13) & "ESTADO EMPRESA = NO", vbInformation + vbOKOnly, "TServi"
    '        Exit Sub
    'End If
        'REF006 FIN
    End If
    
   For j% = 1 To Me.grdConci.Rows - 1
    grdConci.Row = j
        If Me.grdConci.CellForeColor = vbBlue Then
        
'REF006 INI
'            If optProc(2).Value = True Then  'ACREDITA LA DEVOLUCION
'                PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 43619
'                PMPasoValores SqlConn&, "@e_causa", 0, SQLINT4, VEmpresa
'                PMPasoValores SqlConn&, "@e_ssn", 0, SQLINT4, Trim(Me.grdConci.TextMatrix(j%, 11))
'                PMPasoValores SqlConn&, "@e_fecha", 0, SQLDATETIME, (dtFecha)
'                If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "pa_pag_t_concilia_broadnet_t", True, "Búsqueda de Datos") Then
'                    PMChequea SqlConn&
'                Else
'                    Exit Sub
'                End If
'            End If
'REF006 FIN
            
            
            PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 43615
            PMPasoValores SqlConn&, "@e_empresa", 0, SQLVARCHAR, VEmpresa
            PMPasoValores SqlConn&, "@e_siguiente", 0, SQLINT4, Trim(Me.grdConci.TextMatrix(j%, 11))
            PMPasoValores SqlConn&, "@e_fecha", 0, SQLDATETIME, (dtFecha)
            PMPasoValores SqlConn&, "@e_forma_pago", 0, SQLVARCHAR, "ND.CTA"
'REF006 INI
'            If optProc(2).Value = True Then
'                PMPasoValores SqlConn&, "@e_forma_pago", 0, SQLVARCHAR, "ND.CTA"
'            End If
'            If optProc(0).Value = True Then
'                PMPasoValores SqlConn&, "@e_forma_pago", 0, SQLVARCHAR, "OTROS"
'            End If
'REF006 FIN
            
            If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "pa_pag_a_concilia_broadnet_a", True, "Búsqueda de Datos") Then
                PMChequea SqlConn&
            End If
                Me.grdConci.CellForeColor = vbBlack
                Me.grdConci.CellFontBold = False
                Set Me.grdConci.CellPicture = Nothing
                Me.grdConci.CellAlignment = 6
                
        End If
    Next j%

    'Actualizo el Flex
    Me.PLBuscarBroadnet (0)
    
End Sub


Sub PLSacaTotalesClaro()
    
    'Inicializo las variables a considerar en los totales
    Dim VLOkReg As Integer
    Dim VLOkRegBco As Integer
    
    Dim VLValorOk As Currency
    Dim VLValorOkBco As Currency
    
    Dim VLOkRegEmp As Integer
    Dim VLValorOkEmp As Currency
    
    Me.lblOkBco = 0
    Me.lblSoloBco = 0
    Me.lblProcesBco = 0
    
    Me.lblOkBcoValor = 0
    Me.lblSoloBcoValor = 0
    Me.lblProcesBcoValor = 0
    
    Me.lblOkEmp = 0
    Me.lblSoloEmp = 0
    Me.lblProcesEmp = 0
    
    Me.lblOkEmpValor = 0
    Me.lblSoloEmpValor = 0
    Me.lblProcesEmpValor = 0
    
    'Debug.Print grdConci.Rows - 1
    For j% = 1 To (grdConci.Rows - 1)
        'Seteo la fila a usar
        Me.grdConci.Row = j%
        
        Me.grdConci.Col = 7     'Columna con el estado de Banco
        VLEstBco = Me.grdConci.text
        Me.grdConci.Col = 8     'Columna con el estado de Emp
        VLEstEmp = Me.grdConci.text
    
        'Obtengo el valor de los pagos Ok en Bco y en Emp
        If VLEstBco = "SI" And VLEstEmp = "SI" Then
            Me.grdConci.Col = 3
            VLValorOk = VLValorOk + CCur(Me.grdConci.text)
            VLOkReg = VLOkReg + 1
        End If
    
        'Obtengo el valor de los pagos SI en Bco y NO en Emp
        If VLEstBco = "SI" And VLEstEmp = "NO" Then
            Me.grdConci.Col = 3
            VLValorOkBco = VLValorOkBco + CCur(Me.grdConci.text)
            VLOkRegBco = VLOkRegBco + 1
        End If
        
        'Obtengo el valor de los pagos NO en Bco y SI en Emp
        If VLEstBco = "NO" And VLEstEmp = "SI" Then
            Me.grdConci.Col = 3
            VLValorOkEmp = VLValorOkEmp + CCur(Me.grdConci.text)
            VLOkRegEmp = VLOkRegEmp + 1
        End If
        
    Next j%

    'Sumatoria de los totales
    'Banco
    Me.lblOkBco = CInt(VLOkReg)
    Me.lblSoloBco = CInt(VLOkRegBco)
    Me.lblProcesBco = CInt(VLOkRegBco) + CInt(VLOkReg)
    Me.lblOkBcoValor = Format(CCur(VLValorOk), "0.00")
    Me.lblSoloBcoValor = Format(CCur(VLValorOkBco), "0.00")
    Me.lblProcesBcoValor = Format((CCur(VLValorOk) + CCur(VLValorOkBco)), "0.00")
    
    'Empresa Servicio
    Me.lblOkEmp = CInt(VLOkReg)
    Me.lblSoloEmp = CInt(VLOkRegEmp)
    Me.lblProcesEmp = CInt(VLOkRegEmp) + CInt(VLOkReg)
    Me.lblOkEmpValor = Format(CCur(VLValorOk), "0.00")
    Me.lblSoloEmpValor = Format(CCur(VLValorOkEmp), "0.00")
    Me.lblProcesEmpValor = Format((CCur(VLValorOk) + CCur(VLValorOkEmp)), "0.00")
    
End Sub

Sub PLSacaTotalesBroadnet()
    
    'Inicializo las variables a considerar en los totales
    Dim VLOkReg As Integer
    Dim VLOkRegBco As Integer
    
    Dim VLValorOk As Currency
    Dim VLValorOkBco As Currency
    
    Dim VLOkRegEmp As Integer
    Dim VLValorOkEmp As Currency
    
    Me.lblOkBco = 0
    Me.lblSoloBco = 0
    Me.lblProcesBco = 0
    
    Me.lblOkBcoValor = 0
    Me.lblSoloBcoValor = 0
    Me.lblProcesBcoValor = 0
    
    Me.lblOkEmp = 0
    Me.lblSoloEmp = 0
    Me.lblProcesEmp = 0
    
    Me.lblOkEmpValor = 0
    Me.lblSoloEmpValor = 0
    Me.lblProcesEmpValor = 0
    
    For j% = 1 To (grdConci.Rows - 1)
        'Seteo la fila a usar
        Me.grdConci.Row = j%
        
        Me.grdConci.Col = 7     'Columna con el estado de Banco
        VLEstBco = Me.grdConci.text
        Me.grdConci.Col = 8     'Columna con el estado de Emp
        VLEstEmp = Me.grdConci.text
    
        'Obtengo el valor de los pagos Ok en Bco y en Emp
        If VLEstBco = "SI" And VLEstEmp = "SI" Then
            Me.grdConci.Col = 3
            VLValorOk = VLValorOk + CCur(Me.grdConci.text)
            VLOkReg = VLOkReg + 1
        End If
    
        'Obtengo el valor de los pagos SI en Bco y NO en Emp
        If VLEstBco = "SI" And VLEstEmp = "NO" Then
            Me.grdConci.Col = 3
            VLValorOkBco = VLValorOkBco + CCur(Me.grdConci.text)
            VLOkRegBco = VLOkRegBco + 1
        End If
        
        'Obtengo el valor de los pagos NO en Bco y SI en Emp
        If VLEstBco = "NO" And VLEstEmp = "SI" Then
            Me.grdConci.Col = 3
            VLValorOkEmp = VLValorOkEmp + CCur(Me.grdConci.text)
            VLOkRegEmp = VLOkRegEmp + 1
        End If
        
    Next j%

    'Sumatoria de los totales
    'Banco
    Me.lblOkBco = CInt(VLOkReg)
    Me.lblSoloBco = CInt(VLOkRegBco)
    Me.lblProcesBco = CInt(VLOkRegBco) + CInt(VLOkReg)
    Me.lblOkBcoValor = Format(CCur(VLValorOk), "0.00")
    Me.lblSoloBcoValor = Format(CCur(VLValorOkBco), "0.00")
    Me.lblProcesBcoValor = Format((CCur(VLValorOk) + CCur(VLValorOkBco)), "0.00")
    
    'Empresa Servicio
    Me.lblOkEmp = CInt(VLOkReg)
    Me.lblSoloEmp = CInt(VLOkRegEmp)
    Me.lblProcesEmp = CInt(VLOkRegEmp) + CInt(VLOkReg)
    Me.lblOkEmpValor = Format(CCur(VLValorOk), "0.00")
    Me.lblSoloEmpValor = Format(CCur(VLValorOkEmp), "0.00")
    Me.lblProcesEmpValor = Format((CCur(VLValorOk) + CCur(VLValorOkEmp)), "0.00")
    
End Sub

Private Sub PLExportaExcelClaro()
Dim oExcelApp   As Object
Dim oWs         As Object
Dim oWb         As Object
Dim sXlsTemplate As String
Dim iRow As Long
Dim iCol As Long
Dim busqueda As String
Dim bco1 As String
Dim bco2 As String
Dim bco3 As String
Dim emp1 As String
Dim emp2 As String
Dim emp3 As String


On Error GoTo ErrorHandler
sXlsTemplate = App.Path & "\xrptClaro.xlt"

Set oExcelApp = CreateObject("EXCEL.APPLICATION")            '(SIPECOM) LCHACHA OOF REF001
oExcelApp.Visible = False
oExcelApp.Workbooks.Open Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True   '(SIPECOM) LCHACHA OOF REF001
Set oWs = oExcelApp.ActiveSheet
Set oWb = oExcelApp.ActiveWorkbook

Set oWs = oExcelApp.ActiveSheet
oWs.Cells(6, 1).Value = "      Reporte de Pagos de Claro     - Empresa: (" & Me.txt_empresa & ") " & Me.lbl_empresa
For iRow = 1 To Me.grdConci.Rows - 1
    Screen.MousePointer = 11
    Me.grdConci.Row = iRow
    Me.grdConci.Col = 1
    oWs.Cells(8 + iRow, 1).Value = Me.grdConci.text
    Me.grdConci.Col = 2
    oWs.Cells(8 + iRow, 2).Value = Me.grdConci.text
    Me.grdConci.Col = 3
    oWs.Cells(8 + iRow, 3).Value = Me.grdConci.text
    Me.grdConci.Col = 4
    oWs.Cells(8 + iRow, 4).Value = Me.grdConci.text
    Me.grdConci.Col = 5
    oWs.Cells(8 + iRow, 5).Value = Me.grdConci.text
    Me.grdConci.Col = 6
    oWs.Cells(8 + iRow, 6).Value = Me.grdConci.text
    Me.grdConci.Col = 7
    oWs.Cells(8 + iRow, 7).Value = Me.grdConci.text
    Me.grdConci.Col = 8
    oWs.Cells(8 + iRow, 8).Value = Me.grdConci.text
    Me.grdConci.Col = 9
    oWs.Cells(8 + iRow, 9).Value = Me.grdConci.text
    Me.grdConci.Col = 10
    oWs.Cells(8 + iRow, 10).Value = Me.grdConci.text
    Me.grdConci.Col = 11
    oWs.Cells(8 + iRow, 11).Value = Me.grdConci.text
    Me.grdConci.Col = 12
    oWs.Cells(8 + iRow, 12).Value = Me.grdConci.text
    
    Screen.MousePointer = 0
Next iRow
oWs.Cells(13 + iRow, 1).Value = "TOTALES BANCO:"
oWs.Cells(13 + iRow, 1).Font.Bold = True
oWs.Cells(15 + iRow, 1).Value = Space(50) & "No." & Space(30) & "Valor"
oWs.Cells(15 + iRow, 1).Font.Bold = True
bco1 = lblOkBco & (Space(40 - Len(lblOkBco))) & lblOkBcoValor
oWs.Cells(16 + iRow, 1).Value = " Pagos Ok:" & Space(55) & bco1
bco2 = lblSoloBco & (Space(40 - Len(lblSoloBco))) & lblSoloBcoValor
oWs.Cells(17 + iRow, 1).Value = " Pagos solo en banco:" & Space(31) & bco2
bco3 = lblProcesBco & (Space(40 - Len(lblProcesBco))) & lblProcesBcoValor
oWs.Cells(18 + iRow, 1).Value = " Total procesados Bco:" & Space(29) & bco3
oWs.Cells(13 + iRow, 5).Value = "TOTALES EMPRESA:"
oWs.Cells(13 + iRow, 5).Font.Bold = True
oWs.Cells(15 + iRow, 5).Value = Space(50) & "No." & Space(30) & "Valor"
oWs.Cells(15 + iRow, 5).Font.Bold = True
emp1 = lblOkEmp & (Space(40 - Len(lblOkEmp))) & lblOkEmpValor
oWs.Cells(16 + iRow, 5).Value = " Pagos Ok:" & Space(55) & emp1
emp2 = lblSoloEmp & (Space(40 - Len(lblSoloEmp))) & lblSoloEmpValor
oWs.Cells(17 + iRow, 5).Value = " Pagos solo en Empresa:" & Space(26) & emp2
emp3 = lblProcesEmp & (Space(40 - Len(lblProcesEmp))) & lblProcesEmpValor
oWs.Cells(18 + iRow, 5).Value = " Total procesados Emp:" & Space(28) & emp3


oExcelApp.Visible = True
Set oWs = Nothing
Set oExcelApp = Nothing
Exit Sub

ErrorHandler:
    Screen.MousePointer = vbDefault
    MsgBox err.Description & " (" & CStr(err.Number) & ")", vbExclamation, "Excel Export"
'    On Error Resume Next
    oExcelApp.Quit
    Set oWs = Nothing
    Set oExcelApp = Nothing
End Sub
'ref 5
Private Sub PLExportaExcelBroadnet()
Dim oExcelApp   As Object
Dim oWs         As Object
Dim oWb         As Object
Dim sXlsTemplate As String
Dim iRow As Long
Dim iCol As Long
Dim busqueda As String
Dim bco1 As String
Dim bco2 As String
Dim bco3 As String
Dim emp1 As String
Dim emp2 As String
Dim emp3 As String

On Error GoTo ErrorHandler
sXlsTemplate = App.Path & "\xrptBroadnet.xlt"

Set oExcelApp = CreateObject("EXCEL.APPLICATION")
oExcelApp.Visible = False
oExcelApp.Workbooks.Open Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True
Set oWs = oExcelApp.ActiveSheet
Set oWb = oExcelApp.ActiveWorkbook

Set oWs = oExcelApp.ActiveSheet
oWs.Cells(6, 1).Value = "      Reporte de Pagos de Broadnet     - Empresa: (" & Me.txt_empresa & ") " & Me.lbl_empresa
For iRow = 1 To Me.grdConci.Rows - 1
    Screen.MousePointer = 11
    Me.grdConci.Row = iRow
    Me.grdConci.Col = 1
    oWs.Cells(8 + iRow, 1).Value = Me.grdConci.text
    Me.grdConci.Col = 2
    oWs.Cells(8 + iRow, 2).Value = Me.grdConci.text
    Me.grdConci.Col = 3
    oWs.Cells(8 + iRow, 3).Value = Me.grdConci.text
    Me.grdConci.Col = 4
    oWs.Cells(8 + iRow, 4).Value = Me.grdConci.text
    Me.grdConci.Col = 5
    oWs.Cells(8 + iRow, 5).Value = Me.grdConci.text
    Me.grdConci.Col = 6
    oWs.Cells(8 + iRow, 6).Value = Me.grdConci.text
    Me.grdConci.Col = 7
    oWs.Cells(8 + iRow, 7).Value = Me.grdConci.text
    Me.grdConci.Col = 8
    oWs.Cells(8 + iRow, 8).Value = Me.grdConci.text
    Me.grdConci.Col = 9
    oWs.Cells(8 + iRow, 9).Value = Me.grdConci.text
    Me.grdConci.Col = 10
    oWs.Cells(8 + iRow, 10).Value = Me.grdConci.text
    Me.grdConci.Col = 11
    oWs.Cells(8 + iRow, 11).Value = Me.grdConci.text
    Me.grdConci.Col = 12
    oWs.Cells(8 + iRow, 12).Value = Me.grdConci.text
    Me.grdConci.Col = 13
    oWs.Cells(8 + iRow, 13).Value = Me.grdConci.text
    Me.grdConci.Col = 14
    oWs.Cells(8 + iRow, 14).Value = Me.grdConci.text
    Me.grdConci.Col = 15
    oWs.Cells(8 + iRow, 15).Value = Me.grdConci.text
    Me.grdConci.Col = 16
    oWs.Cells(8 + iRow, 16).Value = Me.grdConci.text
    Me.grdConci.Col = 17
    oWs.Cells(8 + iRow, 17).Value = Me.grdConci.text
    Screen.MousePointer = 0
Next iRow
oWs.Cells(13 + iRow, 1).Value = "TOTALES BANCO:"
oWs.Cells(13 + iRow, 1).Font.Bold = True
oWs.Cells(15 + iRow, 1).Value = Space(50) & "No." & Space(30) & "Valor"
oWs.Cells(15 + iRow, 1).Font.Bold = True
bco1 = lblOkBco & (Space(40 - Len(lblOkBco))) & lblOkBcoValor
oWs.Cells(16 + iRow, 1).Value = " Pagos Ok:" & Space(55) & bco1
bco2 = lblSoloBco & (Space(40 - Len(lblSoloBco))) & lblSoloBcoValor
oWs.Cells(17 + iRow, 1).Value = " Pagos solo en banco:" & Space(31) & bco2
bco3 = lblProcesBco & (Space(40 - Len(lblProcesBco))) & lblProcesBcoValor
oWs.Cells(18 + iRow, 1).Value = " Total procesados Bco:" & Space(29) & bco3
oWs.Cells(13 + iRow, 5).Value = "TOTALES EMPRESA:"
oWs.Cells(13 + iRow, 5).Font.Bold = True
oWs.Cells(15 + iRow, 5).Value = Space(50) & "No." & Space(30) & "Valor"
oWs.Cells(15 + iRow, 5).Font.Bold = True
emp1 = lblOkEmp & (Space(40 - Len(lblOkEmp))) & lblOkEmpValor
oWs.Cells(16 + iRow, 5).Value = " Pagos Ok:" & Space(55) & emp1
emp2 = lblSoloEmp & (Space(40 - Len(lblSoloEmp))) & lblSoloEmpValor
oWs.Cells(17 + iRow, 5).Value = " Pagos solo en Empresa:" & Space(26) & emp2
emp3 = lblProcesEmp & (Space(40 - Len(lblProcesEmp))) & lblProcesEmpValor
oWs.Cells(18 + iRow, 5).Value = " Total procesados Emp:" & Space(28) & emp3

oExcelApp.Visible = True
Set oWs = Nothing
Set oExcelApp = Nothing
Exit Sub

ErrorHandler:
    Screen.MousePointer = vbDefault
    MsgBox err.Description & " (" & CStr(err.Number) & ")", vbExclamation, "Excel Export"
    oExcelApp.Quit
    Set oWs = Nothing
    Set oExcelApp = Nothing
End Sub

'(SIPECOM) MALDAZ OOF REF002
Private Sub PLExportaExcelClaroOOF()
Dim oExcelApp   As Object
Dim oWs         As Object
Dim oWb         As Object
Dim sXlsTemplate As String
Dim iRow As Long
Dim iCol As Long
Dim busqueda As String
Dim bco1 As String
Dim bco2 As String
Dim bco3 As String
Dim emp1 As String
Dim emp2 As String
Dim emp3 As String


On Error GoTo ErrorHandler

'INICIO (SIPECOM) LCHACHA OOF REF004
'sXlsTemplate = App.Path & "\xrptClaro.xlt"
Dim sNewXlsFile  As String
sNewXlsFile = "xrptClaro" & Format$(Now, "YYYYMMDDHHMMSS") + ".ods"
FileCopy App.Path & "\xrptClaro.xlt", Environ$("tmp") & "\" & sNewXlsFile
sXlsTemplate = Environ$("tmp") & "\" & sNewXlsFile
'FIN (SIPECOM) LCHACHA OOF REF004

'Set oExcelApp = CreateObject("EXCEL.APPLICATION")            '(SIPECOM) LCHACHA OOF REF001
Set oExcelApp = CreateObject("HOJAELECTRONICABB.APPLICATION") '(SIPECOM) LCHACHA OOF REF001
'oExcelApp.Visible = False
'oExcelApp.Workbooks.Open Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True   '(SIPECOM) LCHACHA OOF REF001
oExcelApp.Workbooks.OpenW Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True, DestinationFile:="Pantalla"   '(SIPECOM) LCHACHA OOF REF001
Set oWs = oExcelApp.ActiveSheet
Set oWb = oExcelApp.ActiveWorkbook

Set oWs = oExcelApp.ActiveSheet
oWs.Cells(6, 1).Value = "      Reporte de Pagos de Claro     - Empresa: (" & Me.txt_empresa & ") " & Me.lbl_empresa
For iRow = 1 To Me.grdConci.Rows - 1
    Screen.MousePointer = 11
    Me.grdConci.Row = iRow
    Me.grdConci.Col = 1
    oWs.Cells(8 + iRow, 1).Value = Me.grdConci.text
    Me.grdConci.Col = 2
    oWs.Cells(8 + iRow, 2).Value = Me.grdConci.text
    Me.grdConci.Col = 3
    oWs.Cells(8 + iRow, 3).Value = Me.grdConci.text
    Me.grdConci.Col = 4
    oWs.Cells(8 + iRow, 4).Value = Me.grdConci.text
    Me.grdConci.Col = 5
    oWs.Cells(8 + iRow, 5).Value = Me.grdConci.text
    Me.grdConci.Col = 6
    oWs.Cells(8 + iRow, 6).Value = Me.grdConci.text
    Me.grdConci.Col = 7
    oWs.Cells(8 + iRow, 7).Value = Me.grdConci.text
    Me.grdConci.Col = 8
    oWs.Cells(8 + iRow, 8).Value = Me.grdConci.text
    Me.grdConci.Col = 9
    oWs.Cells(8 + iRow, 9).Value = Me.grdConci.text
    Me.grdConci.Col = 10
    oWs.Cells(8 + iRow, 10).Value = Me.grdConci.text
    Me.grdConci.Col = 11
    oWs.Cells(8 + iRow, 11).Value = Me.grdConci.text
    Me.grdConci.Col = 12
    oWs.Cells(8 + iRow, 12).Value = Me.grdConci.text
    
    Screen.MousePointer = 0
Next iRow
oWs.Cells(13 + iRow, 1).Value = "TOTALES BANCO:"
'oWs.Cells(13 + iRow, 1).Font.Bold = True
oWs.Cells(15 + iRow, 1).Value = Space(50) & "No." & Space(30) & "Valor"
'oWs.Cells(15 + iRow, 1).Font.Bold = True
bco1 = lblOkBco & (Space(40 - Len(lblOkBco))) & lblOkBcoValor
oWs.Cells(16 + iRow, 1).Value = " Pagos Ok:" & Space(55) & bco1
bco2 = lblSoloBco & (Space(40 - Len(lblSoloBco))) & lblSoloBcoValor
oWs.Cells(17 + iRow, 1).Value = " Pagos solo en banco:" & Space(31) & bco2
bco3 = lblProcesBco & (Space(40 - Len(lblProcesBco))) & lblProcesBcoValor
oWs.Cells(18 + iRow, 1).Value = " Total procesados Bco:" & Space(29) & bco3
oWs.Cells(13 + iRow, 5).Value = "TOTALES EMPRESA:"
'oWs.Cells(13 + iRow, 5).Font.Bold = True
oWs.Cells(15 + iRow, 5).Value = Space(50) & "No." & Space(30) & "Valor"
'oWs.Cells(15 + iRow, 5).Font.Bold = True
emp1 = lblOkEmp & (Space(40 - Len(lblOkEmp))) & lblOkEmpValor
oWs.Cells(16 + iRow, 5).Value = " Pagos Ok:" & Space(55) & emp1
emp2 = lblSoloEmp & (Space(40 - Len(lblSoloEmp))) & lblSoloEmpValor
oWs.Cells(17 + iRow, 5).Value = " Pagos solo en Empresa:" & Space(26) & emp2
emp3 = lblProcesEmp & (Space(40 - Len(lblProcesEmp))) & lblProcesEmpValor
oWs.Cells(18 + iRow, 5).Value = " Total procesados Emp:" & Space(28) & emp3


'oExcelApp.Visible = True
Set oWs = Nothing
Set oExcelApp = Nothing
DoEvents
Exit Sub

ErrorHandler:
    Screen.MousePointer = vbDefault
    MsgBox err.Description & " (" & CStr(err.Number) & ")", vbExclamation, "Excel Export"
    'On Error Resume Next
    'oExcelApp.Quit
    Set oWs = Nothing
    Set oExcelApp = Nothing
End Sub
'dolaya REF5
Private Sub PLExportaExcelBroadnetOOF()
Dim oExcelApp   As Object
Dim oWs         As Object
Dim oWb         As Object
Dim sXlsTemplate As String
Dim iRow As Long
Dim iCol As Long
Dim busqueda As String
Dim bco1 As String
Dim bco2 As String
Dim bco3 As String
Dim emp1 As String
Dim emp2 As String
Dim emp3 As String


On Error GoTo ErrorHandler

Dim sNewXlsFile  As String
sNewXlsFile = "xrptBroadnet" & Format$(Now, "YYYYMMDDHHMMSS") + ".ods"
FileCopy App.Path & "\xrptBroadnet.xlt", Environ$("tmp") & "\" & sNewXlsFile
sXlsTemplate = Environ$("tmp") & "\" & sNewXlsFile

Set oExcelApp = CreateObject("HOJAELECTRONICABB.APPLICATION")
oExcelApp.Workbooks.OpenW Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True, DestinationFile:="Pantalla"
Set oWs = oExcelApp.ActiveSheet
Set oWb = oExcelApp.ActiveWorkbook

Set oWs = oExcelApp.ActiveSheet
oWs.Cells(6, 1).Value = "      Reporte de Pagos de Broadnet     - Empresa: (" & Me.txt_empresa & ") " & Me.lbl_empresa
For iRow = 1 To Me.grdConci.Rows - 1
    Screen.MousePointer = 11
    Me.grdConci.Row = iRow
    Me.grdConci.Col = 1
    oWs.Cells(8 + iRow, 1).Value = Me.grdConci.text
    Me.grdConci.Col = 2
    oWs.Cells(8 + iRow, 2).Value = Me.grdConci.text
    Me.grdConci.Col = 3
    oWs.Cells(8 + iRow, 3).Value = Me.grdConci.text
    Me.grdConci.Col = 4
    oWs.Cells(8 + iRow, 4).Value = Me.grdConci.text
    Me.grdConci.Col = 5
    oWs.Cells(8 + iRow, 5).Value = Me.grdConci.text
    Me.grdConci.Col = 6
    oWs.Cells(8 + iRow, 6).Value = Me.grdConci.text
    Me.grdConci.Col = 7
    oWs.Cells(8 + iRow, 7).Value = Me.grdConci.text
    Me.grdConci.Col = 8
    oWs.Cells(8 + iRow, 8).Value = Me.grdConci.text
    Me.grdConci.Col = 9
    oWs.Cells(8 + iRow, 9).Value = Me.grdConci.text
    Me.grdConci.Col = 10
    oWs.Cells(8 + iRow, 10).Value = Me.grdConci.text
    Me.grdConci.Col = 11
    oWs.Cells(8 + iRow, 11).Value = Me.grdConci.text
    Me.grdConci.Col = 12
    oWs.Cells(8 + iRow, 12).Value = Me.grdConci.text
    Me.grdConci.Col = 13
    oWs.Cells(8 + iRow, 13).Value = Me.grdConci.text
    Me.grdConci.Col = 14
    oWs.Cells(8 + iRow, 14).Value = Me.grdConci.text
    Me.grdConci.Col = 15
    oWs.Cells(8 + iRow, 15).Value = Me.grdConci.text
    Me.grdConci.Col = 16
    oWs.Cells(8 + iRow, 16).Value = Me.grdConci.text
    Me.grdConci.Col = 17
    oWs.Cells(8 + iRow, 17).Value = Me.grdConci.text
    Screen.MousePointer = 0
Next iRow
oWs.Cells(13 + iRow, 1).Value = "TOTALES BANCO:"
oWs.Cells(15 + iRow, 1).Value = Space(50) & "No." & Space(30) & "Valor"
bco1 = lblOkBco & (Space(40 - Len(lblOkBco))) & lblOkBcoValor
oWs.Cells(16 + iRow, 1).Value = " Pagos Ok:" & Space(55) & bco1
bco2 = lblSoloBco & (Space(40 - Len(lblSoloBco))) & lblSoloBcoValor
oWs.Cells(17 + iRow, 1).Value = " Pagos solo en banco:" & Space(31) & bco2
bco3 = lblProcesBco & (Space(40 - Len(lblProcesBco))) & lblProcesBcoValor
oWs.Cells(18 + iRow, 1).Value = " Total procesados Bco:" & Space(29) & bco3
oWs.Cells(13 + iRow, 5).Value = "TOTALES EMPRESA:"
oWs.Cells(15 + iRow, 5).Value = Space(50) & "No." & Space(30) & "Valor"
emp1 = lblOkEmp & (Space(40 - Len(lblOkEmp))) & lblOkEmpValor
oWs.Cells(16 + iRow, 5).Value = " Pagos Ok:" & Space(55) & emp1
emp2 = lblSoloEmp & (Space(40 - Len(lblSoloEmp))) & lblSoloEmpValor
oWs.Cells(17 + iRow, 5).Value = " Pagos solo en Empresa:" & Space(26) & emp2
emp3 = lblProcesEmp & (Space(40 - Len(lblProcesEmp))) & lblProcesEmpValor
oWs.Cells(18 + iRow, 5).Value = " Total procesados Emp:" & Space(28) & emp3

Set oWs = Nothing
Set oExcelApp = Nothing
DoEvents
Exit Sub

ErrorHandler:
    Screen.MousePointer = vbDefault
    MsgBox err.Description & " (" & CStr(err.Number) & ")", vbExclamation, "Excel Export"
    Set oWs = Nothing
    Set oExcelApp = Nothing
End Sub

Sub PLConfirmaClaro()
    'Agregar validacion de que si está seguro de Cerrar la Conciliacion
    Respuesta = MsgBox("Desea Cerrar la Conciliacion", vbInformation + vbOKCancel, "TServi")
    If Respuesta = vbCancel Then
        Exit Sub
    End If
    
    'Confimacion de Activacion de Casilla: Marcar Todos
    If Me.chkTodos.Value = False Then
        MsgBox "Seleccione la Casilla: Marcar Todos", vbInformation + vbOKOnly, "TServi"
        Exit Sub
    End If

    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 43285
    'PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR%, "X"
    PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text)
    PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, 0
    PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
    PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, ""
    PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, ""
    
    'Agregar parametro de Output que indique si hay data cargada en la conciliación de ese día.
    PMPasoValores SqlConn, "@o_existe", 1, SQLCHAR, Space(1)
    If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_claro_x", True, "Búsqueda de Datos") Then
        PMChequea SqlConn&
        vlexiste = FMRetParam(SqlConn, 1)
        If vlexiste = "S" Then
            If VScierre <> "S" Then
                MsgBox "La conciliacion se ha cerrado con exito.", vbOKOnly + vbInformation, "TServi"
            Else
                Respuesta = MsgBox("Registros ya fueron conciliados" & Chr(13) & "Desea volver a generar archivo de ajuste?", vbInformation + vbOKCancel, "TServi")
                If Respuesta = vbCancel Then
                    Exit Sub
                End If
            End If
            'Me.PLBuscarClaroFile (0)
            'PLGeneraArchivoConciliaClaro
            PLBuscaClaroOK (0)
            'INICIO (SIPECOM) MALDAZ OOF REF002
            If validaOffice("OpenOffice") Then
                archExcClaroOKOOF
            Else
                archExcClaroOK
            End If
            'FIN (SIPECOM) MALDAZ OOF REF002
        End If
    End If
    PLBuscarClaro (0)
    Me.chkTodos.Value = False
    If Me.grdConci.Rows > 1 Then Me.grdConci.topRow = 1
    If Me.grdConci.Rows > 1 Then Me.grdConci.LeftCol = 1
End Sub
Sub PLConfirmaBroadnet()

    Dim VEmpresa As String
    VEmpresa = Trim(txt_empresa.text)
    
    If VEmpresa = "1342" Then
      VEmpresa = "103"
    End If
    
    'Agregar validacion de que si está seguro de Cerrar la Conciliacion
    Respuesta = MsgBox("Desea Cerrar la Conciliacion", vbInformation + vbOKCancel, "TServi")
    If Respuesta = vbCancel Then
        Exit Sub
    End If
    
    'Confimacion de Activacion de Casilla: Marcar Todos
    If Me.chkTodos.Value = False Then
        MsgBox "Seleccione la Casilla: Marcar Todos", vbInformation + vbOKOnly, "TServi"
        Exit Sub
    End If

    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 43616
    PMPasoValores SqlConn&, "@e_empresa", 0, SQLVARCHAR, VEmpresa
    PMPasoValores SqlConn&, "@e_siguiente", 0, SQLINT4, 0
    PMPasoValores SqlConn&, "@e_fecha", 0, SQLDATETIME, (dtFecha)
    PMPasoValores SqlConn&, "@e_estado_bco", 0, SQLVARCHAR, ""
    PMPasoValores SqlConn&, "@e_estado_emp", 0, SQLVARCHAR, ""
    
    'Agregar parametro de Output que indique si hay data cargada en la conciliación de ese día.
    PMPasoValores SqlConn, "@s_existe", 1, SQLCHAR, Space(1)
    
    If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "pa_pag_a_concilia_broadnet_x", True, "Búsqueda de Datos") Then
        PMChequea SqlConn&
        vlexiste = FMRetParam(SqlConn, 1)
        If vlexiste = "S" Then
            If VScierre <> "S" Then
                MsgBox "La conciliacion se ha cerrado con exito.", vbOKOnly + vbInformation, "TServi"
            Else
                Respuesta = MsgBox("Registros ya fueron conciliados" & Chr(13) & "Desea volver a generar archivo de ajuste?", vbInformation + vbOKCancel, "TServi")
                If Respuesta = vbCancel Then
                    Exit Sub
                End If
            End If
            PLBuscaBroadnetOK (0)
            If validaOffice("OpenOffice") Then
                archExcBroadnetOKOOF (Trim(txt_empresa.text))
            Else
                archExcBroadnetOK (Trim(txt_empresa.text))
            End If
        End If
    End If
    PLBuscarBroadnet (0)
    Me.chkTodos.Value = False
    If Me.grdConci.Rows > 1 Then Me.grdConci.topRow = 1
    If Me.grdConci.Rows > 1 Then Me.grdConci.LeftCol = 1
End Sub

Sub PLBuscarClaroFile(orden As Long)
   PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 43287
   'PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "C"
   PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text)
   PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, orden
   PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
   PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, Me.cmdEstadoBco.text
   PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, Me.cmbEstadoEmp.text
   If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_claro_c", True, "Ok... Consulta de Pagos IESS") Then
      If orden = 0 Then
         PgMapeaFlexG grdAlterno, True, False, 0, 15, 19
      Else
         PgMapeaFlexG grdAlterno, False, False, 0, 15, 19
      End If
      
      PMChequea SqlConn&
      
      If Me.grdAlterno.Tag = "15" Then
         Me.grdAlterno.Col = 11
         Me.grdAlterno.Row = Me.grdAlterno.Rows - 1
         PLBuscarClaroFile (Me.grdAlterno.text)
      Else
         Me.lbl_registros.Caption = (Me.grdAlterno.Rows - 1)
      End If
   Else
      PMLimpiaGrid Me.grdAlterno
   End If
End Sub
Sub PLBuscarBroadnetFile(orden As Long)
   PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 43618
   PMPasoValores SqlConn&, "@e_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text)
   PMPasoValores SqlConn&, "@e_siguiente", 0, SQLINT4, orden
   PMPasoValores SqlConn&, "@e_fecha", 0, SQLDATETIME, (dtFecha)
   PMPasoValores SqlConn&, "@e_estado_bco", 0, SQLVARCHAR, Me.cmdEstadoBco.text
   PMPasoValores SqlConn&, "@e_estado_emp", 0, SQLVARCHAR, Me.cmbEstadoEmp.text
   If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "pa_pag_c_concilia_broadnet_c", True, "Ok... Consulta de Pagos IESS") Then
      If orden = 0 Then
         PgMapeaFlexG grdAlterno, True, False, 0, 15, 19
      Else
         PgMapeaFlexG grdAlterno, False, False, 0, 15, 19
      End If
      
      PMChequea SqlConn&
      
      If Me.grdAlterno.Tag = "15" Then
         Me.grdAlterno.Col = 11
         Me.grdAlterno.Row = Me.grdAlterno.Rows - 1
         PLBuscarBroadnetFile (Me.grdAlterno.text)
      Else
         Me.lbl_registros.Caption = (Me.grdAlterno.Rows - 1)
      End If
   Else
      PMLimpiaGrid Me.grdAlterno
   End If
End Sub

Sub PLGeneraArchivoConciliaClaro()
 
    'Aplico formato al campo hora
    FormateoCampoHora

    'Abro el archivo para comenzar a grabar el detalle.
    VTnombarch$ = "REC" & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2) & Mid(Me.dtFecha, 9, 2) & "AJU.DAT"
    Open "c:\cobis\tadmin\" & VTnombarch$ For Output As #1

    'Registro de Detalle
    'Me.grdAlterno.Row = 1
    For j% = 1 To Me.grdAlterno.Rows - 1
    Me.grdAlterno.Row = j%
    'FECHA PROCESO
    FechaProceso$ = Mid(Me.dtFecha, 7, 4) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2)
    VLTipoMsg$ = "0210"
    VLTipoTrx$ = "000101"
    
    'Codigo Telefono
    Me.grdAlterno.Col = 1
    VLCodruc$ = Me.grdAlterno.text
    
    'sucursal
    Me.grdAlterno.Col = 14
    VLSucursal$ = Me.grdAlterno.text
    
    ''rubro
    'Me.grdAlterno.Col = 15
    'VLRubro$ = Me.grdAlterno.Text
    
    ''comprobante
    'Me.grdAlterno.Col = 16
    'VLComp$ = Me.grdAlterno.Text
    
    'Valor
    Me.grdAlterno.Col = 3
    VLValor$ = Format(Me.grdAlterno.text, "#.00")
    
    'Fecha contable
    Me.grdAlterno.Col = 4
    VLFecContb$ = Mid(Me.grdAlterno.text, 7, 4) & "-" & Mid(Me.grdAlterno.text, 1, 2) & "-" & Mid(Me.grdAlterno.text, 4, 2)
    
    'Fecha proceso
    Me.grdAlterno.Col = 17 '18
    VFechaProc$ = Mid(Me.grdAlterno.text, 7, 4) & "-" & Mid(Me.grdAlterno.text, 1, 2) & "-" & Mid(Me.grdAlterno.text, 4, 2)
    
    'Secuencia Bco
    Me.grdAlterno.Col = 11
    VLSecBco$ = Trim(Me.grdAlterno.text)
   
    'tipo ajuste
    Me.grdAlterno.Col = 7
    VLEstBanco$ = Trim(Me.grdAlterno.text)
    Me.grdAlterno.Col = 8
    VLEstIess$ = Trim(Me.grdAlterno.text)
    If VLEstBanco = "SI" And VLEstIess$ = "SI" Then
        VLEstConcilia$ = ""
    ElseIf VLEstBanco = "SI" And VLEstIess$ = "NO" Then
        VLEstConcilia$ = "P"
    ElseIf VLEstBanco = "NO" And VLEstIess$ = "SI" Then
        VLEstConcilia$ = "RM"
    End If
    
    'Secuencia Porta
    Me.grdAlterno.Col = 16 '17
    VLSecIess$ = Trim(Me.grdAlterno.text)
    
    'Grabo el registro de Detalle
    If VLEstConcilia$ <> "" Then
        VTLineal$ = ""
        'VTLineal$ = VTLineal$ + VLCodruc$ + "|" + VLSucursal$ + "|" + VLRubro$ + "|" + VLComp$ + "|" + VLValor$ + "|" + VLFecContb$
        VTLineal$ = VTLineal$ + VLCodruc$ + "|" + VLSucursal$ + "|" + VLValor$ + "|" + VLFecContb$
        VTLineal$ = VTLineal$ + "|" + VFechaProc$ + "|" + VLSecBco$ + "|" + VLEstConcilia$ + "|" + VLSecIess$
    
        Print #1, VTLineal$
    End If
    'Debug.Print VTLineal$
   
    Next j%
 
    'Cierro el archivo y muestro mensaje indicando la generacion exitosa del mismo.
    Close #1
    MsgBox "Archivo Generado Exitosamente", vbOKOnly + vbInformation, "TServi"

End Sub
Private Sub PLBuscaClaroOK(orden As Long) 'archExcPortaOK

   PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 43286
  ' PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "E"
   PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, orden
   PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
   PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text) 'msilvag Claro Paquetes
   If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_claro_e", True, "Ok... Consulta de Pagos IESS") Then
      If orden = 0 Then
         PgMapeaFlexG grdAlterno, True, False, 0, 15, 15
      Else
         PgMapeaFlexG grdAlterno, False, False, 0, 15, 15
      End If
      PMChequea SqlConn&
      If Me.grdAlterno.Tag = "15" Then
         Me.grdAlterno.Col = 14
         Me.grdAlterno.Row = Me.grdAlterno.Rows - 1
         PLBuscaClaroOK (Me.grdAlterno.text)
    End If
End If
End Sub
Private Sub PLBuscaBroadnetOK(orden As Long)

  Dim VEmpresa As String

  VEmpresa = Trim(txt_empresa.text)

  If VEmpresa = "1342" Then
    VEmpresa = "103"
  End If

   PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 43617
   PMPasoValores SqlConn&, "@e_siguiente", 0, SQLINT4, orden
   PMPasoValores SqlConn&, "@e_fecha", 0, SQLDATETIME, (dtFecha)
   PMPasoValores SqlConn&, "@e_empresa", 0, SQLVARCHAR, VEmpresa
   If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "pa_pag_c_concilia_broadnet_e", True, "Ok... Consulta de Pagos Broadnet") Then
      If orden = 0 Then
         PgMapeaFlexG grdAlterno, True, False, 0, 15, 15
      Else
         PgMapeaFlexG grdAlterno, False, False, 0, 15, 15
      End If
      PMChequea SqlConn&
      If Me.grdAlterno.Tag = "15" Then
         Me.grdAlterno.Col = 14
         Me.grdAlterno.Row = Me.grdAlterno.Rows - 1
         PLBuscaBroadnetOK (Me.grdAlterno.text)
    End If
End If
End Sub


'(SIPECOM) MALDAZ OOF REF002

Private Sub archExcClaroOK()
Dim oExcelApp   As Object
Dim oWs         As Object
Dim oWb         As Object
Dim sXlsTemplate As String
Dim sNewXlsFile  As String
Dim Path As String
Dim iRow As Long
Dim iCol As Long

Dim totEfectivo As Currency
Dim trx As Long
Dim totCheque As Currency
Dim totND As Currency
Dim Total As Currency
Dim fecha As String

Dim vlefectivo As Currency
Dim vlcheque As Currency
Dim vlnd As Currency


Total = 0
totCheque = 0
totEfectivo = 0
totND = 0
trx = 0

vlefectivo = 0
vlcheque = 0
vlnd = 0


On Error GoTo ErrorHandler

        sXlsTemplate = App.Path & "\xrptRecaClaro.xlt"
        Path = "c:\cobis\tadmin\"
        sNewXlsFile = Path & "RecClaro" & Format(dtFecha, "MMDDYYYY") & ".xls"
        Set oExcelApp = CreateObject("EXCEL.APPLICATION")              '(SIPECOM) LCHACHA OOF REF001
        
        oExcelApp.Visible = False
        oExcelApp.Workbooks.Open Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True   '(SIPECOM) LCHACHA OOF REF001
        Set oWs = oExcelApp.ActiveSheet
        Set oWb = oExcelApp.ActiveWorkbook
        Set oWs = oExcelApp.ActiveSheet
        'oWs.Cells('fila', 'col'')
        
        For iRow = 1 To Me.grdAlterno.Rows - 1
            Screen.MousePointer = 11
            grdAlterno.Row = iRow

            grdAlterno.Col = 1
            oWs.Cells(15 + iRow, 1).Value = grdAlterno.text 'fecha
            fecha = grdAlterno.text
                        
            grdAlterno.Col = 2
            oWs.Cells(15 + iRow, 2).Value = grdAlterno.text 'ciudad

            grdAlterno.Col = 3
            oWs.Cells(15 + iRow, 3).Value = grdAlterno.text ' agencia

            grdAlterno.Col = 4
            oWs.Cells(15 + iRow, 4).Value = grdAlterno.text ' canal

            grdAlterno.Col = 5
            oWs.Cells(15 + iRow, 5).Value = grdAlterno.text 'cod_cajero

            grdAlterno.Col = 6
            oWs.Cells(15 + iRow, 6).Value = grdAlterno.text  ' monto total

            grdAlterno.Col = 7
            vlefectivo = CCur(IIf(grdAlterno.text = "", 0, grdAlterno.text))
            oWs.Cells(15 + iRow, 7).Value = grdAlterno.text   ' efectivo
            totEfectivo = totEfectivo + CCur(vlefectivo)

            grdAlterno.Col = 8
            vlcheque = CCur(IIf(grdAlterno.text = "", 0, grdAlterno.text))
            oWs.Cells(15 + iRow, 8).Value = grdAlterno.text  ' cheque
            totCheque = totCheque + CCur(vlcheque)
            
            grdAlterno.Col = 9
            vlnd = CCur(IIf(grdAlterno.text = "", 0, grdAlterno.text))
            oWs.Cells(15 + iRow, 9).Value = grdAlterno.text  ' N/D
            totND = totND + CCur(vlnd)

            grdAlterno.Col = 10
            oWs.Cells(15 + iRow, 10).Value = grdAlterno.text ' hora

            grdAlterno.Col = 11
            oWs.Cells(15 + iRow, 11).Value = grdAlterno.text ' Telefono

            grdAlterno.Col = 12
            oWs.Cells(15 + iRow, 12).Value = grdAlterno.text ' Nombre

            grdAlterno.Col = 13
            oWs.Cells(15 + iRow, 13).Value = grdAlterno.text ' referencia
            
            grdAlterno.Col = 6
            oWs.Cells(15 + iRow, 14).Value = grdAlterno.text
            
            grdAlterno.Col = 6
            oWs.Cells(15 + iRow, 15).Value = grdAlterno.text
            
            trx = trx + 1

    Next iRow
    Total = totCheque + totEfectivo + totND
    oWs.Cells(5, 3).Value = trx
    oWs.Cells(6, 3).Value = totEfectivo
    oWs.Cells(7, 3).Value = totCheque
    oWs.Cells(8, 3).Value = totND
    oWs.Cells(9, 3).Value = Total
    
    oWs.Cells(2, 2).Value = fecha
    oWs.Cells(3, 2).Value = fecha
    oExcelApp.Visible = True
    Screen.MousePointer = 0
    oExcelApp.DisplayAlerts = False
    oWb.SaveCopyAs (sNewXlsFile)

    oExcelApp.Quit
    Set oWs = Nothing
    Set oWb = Nothing
    Set oExcelApp = Nothing
    MsgBox "Archivo Generado Exitosamente", vbOKOnly + vbInformation, "TServi"
    Exit Sub
    
ErrorHandler:
    Screen.MousePointer = vbDefault
    MsgBox err.Description & " (" & CStr(err.Number) & ")", vbExclamation, "Excel Export"
    On Error Resume Next
    oExcelApp.Quit
    Set oWs = Nothing
    Set oExcelApp = Nothing
End Sub

Private Sub archExcBroadnetOK(codempresa As String)
Dim oExcelApp   As Object
Dim oWs         As Object
Dim oWb         As Object
Dim sXlsTemplate As String
Dim sNewXlsFile  As String
Dim Path As String
Dim iRow As Long
Dim iCol As Long

Dim totEfectivo As Currency
Dim trx As Long
Dim totCheque As Currency
Dim totND As Currency
Dim Total As Currency
Dim fecha As String

Dim vlefectivo As Currency
Dim vlcheque As Currency
Dim vlnd As Currency

Total = 0
totCheque = 0
totEfectivo = 0
totND = 0
trx = 0

vlefectivo = 0
vlcheque = 0
vlnd = 0

On Error GoTo ErrorHandler

        sXlsTemplate = App.Path & "\xrptRecaBroadnet.xlt"
        Path = "c:\cobis\tadmin\"
        sNewXlsFile = Path & "RecBroadnet_" & codempresa & "_" & Format(dtFecha, "MMDDYYYY") & ".xls"
        Set oExcelApp = CreateObject("EXCEL.APPLICATION")
        
        oExcelApp.Visible = False
        oExcelApp.Workbooks.Open Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True
        Set oWs = oExcelApp.ActiveSheet
        Set oWb = oExcelApp.ActiveWorkbook
        Set oWs = oExcelApp.ActiveSheet
                
        For iRow = 1 To Me.grdAlterno.Rows - 1
            Screen.MousePointer = 11
            grdAlterno.Row = iRow

            grdAlterno.Col = 1
            oWs.Cells(15 + iRow, 1).Value = grdAlterno.text
            fecha = grdAlterno.text
                        
            grdAlterno.Col = 2
            oWs.Cells(15 + iRow, 2).Value = grdAlterno.text

            grdAlterno.Col = 3
            oWs.Cells(15 + iRow, 3).Value = grdAlterno.text

            grdAlterno.Col = 4
            oWs.Cells(15 + iRow, 4).Value = grdAlterno.text

            grdAlterno.Col = 5
            oWs.Cells(15 + iRow, 5).Value = grdAlterno.text

            grdAlterno.Col = 6
            oWs.Cells(15 + iRow, 6).Value = grdAlterno.text

            grdAlterno.Col = 7
            vlefectivo = CCur(IIf(grdAlterno.text = "", 0, grdAlterno.text))
            oWs.Cells(15 + iRow, 7).Value = grdAlterno.text
            totEfectivo = totEfectivo + CCur(vlefectivo)

            grdAlterno.Col = 8
            vlcheque = CCur(IIf(grdAlterno.text = "", 0, grdAlterno.text))
            oWs.Cells(15 + iRow, 8).Value = grdAlterno.text
            totCheque = totCheque + CCur(vlcheque)
            
            grdAlterno.Col = 9
            vlnd = CCur(IIf(grdAlterno.text = "", 0, grdAlterno.text))
            oWs.Cells(15 + iRow, 9).Value = grdAlterno.text
            totND = totND + CCur(vlnd)

            grdAlterno.Col = 10
            oWs.Cells(15 + iRow, 10).Value = grdAlterno.text

            grdAlterno.Col = 11
            oWs.Cells(15 + iRow, 11).Value = grdAlterno.text

            grdAlterno.Col = 12
            oWs.Cells(15 + iRow, 12).Value = grdAlterno.text

            grdAlterno.Col = 13
            oWs.Cells(15 + iRow, 13).Value = grdAlterno.text
            
            grdAlterno.Col = 6
            oWs.Cells(15 + iRow, 14).Value = grdAlterno.text
            
            grdAlterno.Col = 6
            oWs.Cells(15 + iRow, 15).Value = grdAlterno.text
            
            trx = trx + 1

    Next iRow
    Total = totCheque + totEfectivo + totND
    oWs.Cells(5, 3).Value = trx
    oWs.Cells(6, 3).Value = totEfectivo
    oWs.Cells(7, 3).Value = totCheque
    oWs.Cells(8, 3).Value = totND
    oWs.Cells(9, 3).Value = Total
    
    oWs.Cells(2, 2).Value = fecha
    oWs.Cells(3, 2).Value = fecha
    oExcelApp.Visible = True
    Screen.MousePointer = 0
    oExcelApp.DisplayAlerts = False
    oWb.SaveCopyAs (sNewXlsFile)

    oExcelApp.Quit
    Set oWs = Nothing
    Set oWb = Nothing
    Set oExcelApp = Nothing
    MsgBox "Archivo Generado Exitosamente", vbOKOnly + vbInformation, "TServi"
    Exit Sub
    
ErrorHandler:
    Screen.MousePointer = vbDefault
    MsgBox err.Description & " (" & CStr(err.Number) & ")", vbExclamation, "Excel Export"
    On Error Resume Next
    oExcelApp.Quit
    Set oWs = Nothing
    Set oExcelApp = Nothing
End Sub

Private Sub archExcClaroOKOOF()
Dim oExcelApp   As Object
Dim oWs         As Object
Dim oWb         As Object
Dim sXlsTemplate As String
Dim sNewXlsFile  As String
Dim Path As String
Dim iRow As Long
Dim iCol As Long

Dim totEfectivo As Currency
Dim trx As Long
Dim totCheque As Currency
Dim totND As Currency
Dim Total As Currency
Dim fecha As String

Dim vlefectivo As Currency
Dim vlcheque As Currency
Dim vlnd As Currency


Total = 0
totCheque = 0
totEfectivo = 0
totND = 0
trx = 0

vlefectivo = 0
vlcheque = 0
vlnd = 0


On Error GoTo ErrorHandler

                'INICIO (SIPECOM) LCHACHA OOF REF004
        'sXlsTemplate = App.Path & "\xrptRecaClaro.xlt"
                Dim sNewXlsFile_  As String
                sNewXlsFile_ = "xrptRecaClaro" & Format$(Now, "YYYYMMDDHHMMSS") + ".ods"
                FileCopy App.Path & "\xrptRecaClaro.xlt", Environ$("tmp") & "\" & sNewXlsFile_
                sXlsTemplate = Environ$("tmp") & "\" & sNewXlsFile_
                'FIN (SIPECOM) LCHACHA OOF REF004
                
                
        Path = "c:\cobis\tadmin\"
        sNewXlsFile = Path & "RecClaro" & Format(dtFecha, "MMDDYYYY") & ".xls"
        'Set oExcelApp = CreateObject("EXCEL.APPLICATION")              '(SIPECOM) LCHACHA OOF REF001
        Set oExcelApp = CreateObject("HOJAELECTRONICABB.APPLICATION")   '(SIPECOM) LCHACHA OOF REF001
        'oExcelApp.Visible = False
        'oExcelApp.Workbooks.Open Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True   '(SIPECOM) LCHACHA OOF REF001
        oExcelApp.Workbooks.OpenW Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True, DestinationFile:="Pantalla"   '(SIPECOM) LCHACHA OOF REF001
        Set oWs = oExcelApp.ActiveSheet
        Set oWb = oExcelApp.ActiveWorkbook
        Set oWs = oExcelApp.ActiveSheet
        'oWs.Cells('fila', 'col'')
        
        For iRow = 1 To Me.grdAlterno.Rows - 1
            Screen.MousePointer = 11
            grdAlterno.Row = iRow

            grdAlterno.Col = 1
            oWs.Cells(15 + iRow, 1).Value = grdAlterno.text 'fecha
            fecha = grdAlterno.text
                        
            grdAlterno.Col = 2
            oWs.Cells(15 + iRow, 2).Value = grdAlterno.text 'ciudad

            grdAlterno.Col = 3
            oWs.Cells(15 + iRow, 3).Value = grdAlterno.text ' agencia

            grdAlterno.Col = 4
            oWs.Cells(15 + iRow, 4).Value = grdAlterno.text ' canal

            grdAlterno.Col = 5
            oWs.Cells(15 + iRow, 5).Value = grdAlterno.text 'cod_cajero

            grdAlterno.Col = 6
            oWs.Cells(15 + iRow, 6).Value = grdAlterno.text  ' monto total

            grdAlterno.Col = 7
            vlefectivo = CCur(IIf(grdAlterno.text = "", 0, grdAlterno.text))
            oWs.Cells(15 + iRow, 7).Value = grdAlterno.text   ' efectivo
            totEfectivo = totEfectivo + CCur(vlefectivo)

            grdAlterno.Col = 8
            vlcheque = CCur(IIf(grdAlterno.text = "", 0, grdAlterno.text))
            oWs.Cells(15 + iRow, 8).Value = grdAlterno.text  ' cheque
            totCheque = totCheque + CCur(vlcheque)
            
            grdAlterno.Col = 9
            vlnd = CCur(IIf(grdAlterno.text = "", 0, grdAlterno.text))
            oWs.Cells(15 + iRow, 9).Value = grdAlterno.text  ' N/D
            totND = totND + CCur(vlnd)

            grdAlterno.Col = 10
            oWs.Cells(15 + iRow, 10).Value = grdAlterno.text ' hora

            grdAlterno.Col = 11
            oWs.Cells(15 + iRow, 11).Value = grdAlterno.text ' Telefono

            grdAlterno.Col = 12
            oWs.Cells(15 + iRow, 12).Value = grdAlterno.text ' Nombre

            grdAlterno.Col = 13
            oWs.Cells(15 + iRow, 13).Value = grdAlterno.text ' referencia
            
            grdAlterno.Col = 6
            oWs.Cells(15 + iRow, 14).Value = grdAlterno.text
            
            grdAlterno.Col = 6
            oWs.Cells(15 + iRow, 15).Value = grdAlterno.text
            
            trx = trx + 1

    Next iRow
    Total = totCheque + totEfectivo + totND
    oWs.Cells(5, 3).Value = trx
    oWs.Cells(6, 3).Value = totEfectivo
    oWs.Cells(7, 3).Value = totCheque
    oWs.Cells(8, 3).Value = totND
    oWs.Cells(9, 3).Value = Total
    
    oWs.Cells(2, 2).Value = fecha
    oWs.Cells(3, 2).Value = fecha
    'oExcelApp.Visible = True
    Screen.MousePointer = 0
    oExcelApp.DisplayAlerts = False
    oWb.SaveCopyAs (sNewXlsFile)

    'oExcelApp.Quit
    Set oWs = Nothing
    Set oWb = Nothing
    Set oExcelApp = Nothing
    DoEvents
    MsgBox "Archivo Generado Exitosamente", vbOKOnly + vbInformation, "TServi"
    Exit Sub
    
ErrorHandler:
    Screen.MousePointer = vbDefault
    MsgBox err.Description & " (" & CStr(err.Number) & ")", vbExclamation, "Excel Export"
    'On Error Resume Next
    'oExcelApp.Quit
    Set oWs = Nothing
    Set oExcelApp = Nothing
End Sub

Private Sub archExcBroadnetOKOOF(codempresa As String)
Dim oExcelApp   As Object
Dim oWs         As Object
Dim oWb         As Object
Dim sXlsTemplate As String
Dim sNewXlsFile  As String
Dim Path As String
Dim iRow As Long
Dim iCol As Long

Dim totEfectivo As Currency
Dim trx As Long
Dim totCheque As Currency
Dim totND As Currency
Dim Total As Currency
Dim fecha As String

Dim vlefectivo As Currency
Dim vlcheque As Currency
Dim vlnd As Currency

Total = 0
totCheque = 0
totEfectivo = 0
totND = 0
trx = 0

vlefectivo = 0
vlcheque = 0
vlnd = 0

On Error GoTo ErrorHandler

        Dim sNewXlsFile_  As String
        sNewXlsFile_ = "xrptRecaBroadnet_" & codempresa & "_" & Format$(Now, "YYYYMMDDHHMMSS") + ".ods"
        FileCopy App.Path & "\xrptRecaBroadnet.xlt", Environ$("tmp") & "\" & sNewXlsFile_
        sXlsTemplate = Environ$("tmp") & "\" & sNewXlsFile_
                
        Path = "c:\cobis\tadmin\"
        sNewXlsFile = Path & "RecBroadnet_" & codempresa & "_" & Format(dtFecha, "MMDDYYYY") & ".xls"
        Set oExcelApp = CreateObject("HOJAELECTRONICABB.APPLICATION")
        oExcelApp.Workbooks.OpenW Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True, DestinationFile:="Pantalla"
        Set oWs = oExcelApp.ActiveSheet
        Set oWb = oExcelApp.ActiveWorkbook
        Set oWs = oExcelApp.ActiveSheet
        
        For iRow = 1 To Me.grdAlterno.Rows - 1
            Screen.MousePointer = 11
            grdAlterno.Row = iRow

            grdAlterno.Col = 1
            oWs.Cells(15 + iRow, 1).Value = grdAlterno.text
            fecha = grdAlterno.text
                        
            grdAlterno.Col = 2
            oWs.Cells(15 + iRow, 2).Value = grdAlterno.text

            grdAlterno.Col = 3
            oWs.Cells(15 + iRow, 3).Value = grdAlterno.text

            grdAlterno.Col = 4
            oWs.Cells(15 + iRow, 4).Value = grdAlterno.text

            grdAlterno.Col = 5
            oWs.Cells(15 + iRow, 5).Value = grdAlterno.text

            grdAlterno.Col = 6
            oWs.Cells(15 + iRow, 6).Value = grdAlterno.text

            grdAlterno.Col = 7
            vlefectivo = CCur(IIf(grdAlterno.text = "", 0, grdAlterno.text))
            oWs.Cells(15 + iRow, 7).Value = grdAlterno.text
            totEfectivo = totEfectivo + CCur(vlefectivo)

            grdAlterno.Col = 8
            vlcheque = CCur(IIf(grdAlterno.text = "", 0, grdAlterno.text))
            oWs.Cells(15 + iRow, 8).Value = grdAlterno.text
            totCheque = totCheque + CCur(vlcheque)
            
            grdAlterno.Col = 9
            vlnd = CCur(IIf(grdAlterno.text = "", 0, grdAlterno.text))
            oWs.Cells(15 + iRow, 9).Value = grdAlterno.text
            totND = totND + CCur(vlnd)

            grdAlterno.Col = 10
            oWs.Cells(15 + iRow, 10).Value = grdAlterno.text

            grdAlterno.Col = 11
            oWs.Cells(15 + iRow, 11).Value = grdAlterno.text

            grdAlterno.Col = 12
            oWs.Cells(15 + iRow, 12).Value = grdAlterno.text

            grdAlterno.Col = 13
            oWs.Cells(15 + iRow, 13).Value = grdAlterno.text
            
            grdAlterno.Col = 6
            oWs.Cells(15 + iRow, 14).Value = grdAlterno.text
            
            grdAlterno.Col = 6
            oWs.Cells(15 + iRow, 15).Value = grdAlterno.text
            
            trx = trx + 1

    Next iRow
    Total = totCheque + totEfectivo + totND
    oWs.Cells(5, 3).Value = trx
    oWs.Cells(6, 3).Value = totEfectivo
    oWs.Cells(7, 3).Value = totCheque
    oWs.Cells(8, 3).Value = totND
    oWs.Cells(9, 3).Value = Total
    oWs.Cells(2, 2).Value = fecha
    oWs.Cells(3, 2).Value = fecha
    Screen.MousePointer = 0
    oExcelApp.DisplayAlerts = False
    oWb.SaveCopyAs (sNewXlsFile)

    Set oWs = Nothing
    Set oWb = Nothing
    Set oExcelApp = Nothing
    DoEvents
    MsgBox "Archivo Generado Exitosamente", vbOKOnly + vbInformation, "TServi"
    Exit Sub
    
ErrorHandler:
    Screen.MousePointer = vbDefault
    MsgBox err.Description & " (" & CStr(err.Number) & ")", vbExclamation, "Excel Export"
    Set oWs = Nothing
    Set oExcelApp = Nothing
End Sub



Sub PLBuscarCnel(orden As Long) 'DAPV/03162012/CNEL
Dim VResul As String
    chkTodos.Value = 0
   'Hago la consulta de los primeros 15 resultados
   PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 43293
   PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT4, Trim(txt_empresa.text)
   PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, orden
   PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
   PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, Me.cmdEstadoBco.text
   PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, Me.cmbEstadoEmp.text
   PMPasoValores SqlConn&, "@i_modo", 0, SQLINT2, 0
   
   If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_cnel_s", True, "Ok... Consulta de Pagos Cnel") Then
      If orden = 0 Then
         PgMapeaFlexG grdConci, True, False, 0, 15, 18
      Else
         PgMapeaFlexG grdConci, False, False, 0, 15, 18
      End If
      PMChequea SqlConn&
      If Me.grdConci.Tag = "15" Then
         Me.grdConci.Col = 17
         Me.grdConci.Row = Me.grdConci.Rows - 1
         PLBuscarCnel (Me.grdConci.text)
      Else
         'Elimino la Columna donde traje los secueciales para la busqueda
         Me.lbl_registros.Caption = (Me.grdConci.Rows - 1)
                
         'Formato al Grid
         Me.grdConci.ColWidth(1) = 1100  'Codigo
         Me.grdConci.ColWidth(2) = 2445  'Nombre Abonado
         Me.grdConci.ColWidth(3) = 1100  'Valor
         Me.grdConci.ColWidth(4) = 1100  'Fecha Trx.
         Me.grdConci.ColWidth(5) = 750   'Hora
         Me.grdConci.ColWidth(6) = 1900  'Resultado
         Me.grdConci.ColWidth(7) = 1100  'Status Bco
         Me.grdConci.ColWidth(8) = 1100  'Status Emp
         Me.grdConci.ColWidth(9) = 1200  '
         Me.grdConci.ColWidth(10) = 1100  '
         Me.grdConci.ColAlignment(10) = 7
         Me.grdConci.ColWidth(11) = 1100 '
         Me.grdConci.ColWidth(12) = 1100 '
         Me.grdConci.ColWidth(13) = 750 '
         Me.grdConci.ColWidth(14) = 800 '
         Me.grdConci.ColWidth(15) = 900 '
         Me.grdConci.ColWidth(16) = 1200 '
         PLSacaTotalesCnel   'Barrido del Grid para sacar totales
         
         'activa botones de confirmacion y proceso
         If (Me.cmdEstadoBco.text <> "TODOS" Or Me.cmbEstadoEmp.text <> "TODOS") Then
            cmdBoton(1).Enabled = False
            cmdBoton(4).Enabled = False
         Else
            cmdBoton(1).Enabled = True
            cmdBoton(4).Enabled = False
         End If
         VScierre = "N"
         For k% = 1 To (grdConci.Rows - 1)
            grdConci.Row = k%
            grdConci.Col = 6
            VResul = Trim(grdConci.text)
            grdConci.Row = k%
            grdConci.Col = 15
            If Trim(grdConci.text) = "" And VResul <> "OK" Then
                cmdBoton(1).Enabled = False
                cmdBoton(4).Enabled = True
                Exit For
            End If
            If Trim(grdConci.text) = "S" Then
                VScierre = "S"
                Exit For
            End If
          Next k
          
      End If
      
   Else
      PMLimpiaGrid Me.grdConci
        
      'Resultados
      Me.lblOkBco.Caption = "0"
      Me.lblSoloBco.Caption = "0"
      Me.lblProcesBco.Caption = "0"
      Me.lblOkBcoValor.Caption = "0.00"
      Me.lblSoloBcoValor.Caption = "0.00"
      Me.lblProcesBcoValor.Caption = "0.00"
        
      Me.lblOkEmp.Caption = "0"
      Me.lblSoloEmp.Caption = "0"
      Me.lblProcesEmp.Caption = "0"
      Me.lblOkEmpValor.Caption = "0.00"
      Me.lblSoloEmpValor.Caption = "0.00"
      Me.lblProcesEmpValor.Caption = "0.00"
      Me.lbl_registros = 0
   End If
   
   If Me.grdConci.Rows > 1 Then Me.grdConci.topRow = 1
   If Me.grdConci.Rows > 1 Then Me.grdConci.LeftCol = 1
    
End Sub

Sub PLBuscarSenae(orden As Long) 'smerinom
Dim VResul As String
    chkTodos.Value = 0
   'Hago la consulta de los primeros 15 resultados
   PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 43367  '43293
   PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT4, Trim(txt_empresa.text)
   PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, orden
   PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
   PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, Me.cmdEstadoBco.text
   PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, Me.cmbEstadoEmp.text
   PMPasoValores SqlConn&, "@i_modo", 0, SQLINT2, 0
   
   If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_senae_s", True, "Ok... Consulta de Pagos Senae") Then
      If orden = 0 Then
         PgMapeaFlexG grdConci, True, False, 0, 15, 15
      Else
         PgMapeaFlexG grdConci, False, False, 0, 15, 15
      End If
      PMChequea SqlConn&
      If Me.grdConci.Tag = "15" Then
         Me.grdConci.Col = 14
         Me.grdConci.Row = Me.grdConci.Rows - 1
         PLBuscarSenae (Me.grdConci.text)
      Else
         'Elimino la Columna donde traje los secueciales para la busqueda
         Me.lbl_registros.Caption = (Me.grdConci.Rows - 1)
                
         'Formato al Grid
         Me.grdConci.ColWidth(1) = 1100  'Codigo
         Me.grdConci.ColWidth(2) = 1100  'Valor
         Me.grdConci.ColWidth(3) = 1100  'Valor nc
         Me.grdConci.ColWidth(4) = 1300  'valor comision.
         Me.grdConci.ColWidth(5) = 1100   'Fecha Trx.
         Me.grdConci.ColWidth(6) = 1100   'Hora  Resultado 1900
         Me.grdConci.ColWidth(7) = 900  'Resultado  Status Bco
         Me.grdConci.ColWidth(8) = 1200  'Status Bco
         Me.grdConci.ColWidth(9) = 1200  'Status Emp.
         Me.grdConci.ColWidth(10) = 1100  'N.Aut
         Me.grdConci.ColAlignment(10) = 7
         Me.grdConci.ColWidth(11) = 1100 'Sec
         Me.grdConci.ColWidth(12) = 1100 'Canal
         Me.grdConci.ColWidth(13) = 950 ' Est.Conc
         Me.grdConci.ColWidth(14) = 1200 'Secuencial
         'Me.grdConci.ColWidth(15) = 900 '
         'Me.grdConci.ColWidth(16) = 1200 '
          PLSacaTotalesSenae   'Barrido del Grid para sacar totales
         
         'activa botones de confirmacion y proceso
         If (Me.cmdEstadoBco.text <> "TODOS" Or Me.cmbEstadoEmp.text <> "TODOS") Then
            cmdBoton(1).Enabled = False
            cmdBoton(4).Enabled = False
         Else
            cmdBoton(1).Enabled = True
            cmdBoton(4).Enabled = False
         End If
         VScierre = "N"
         For k% = 1 To (grdConci.Rows - 1)
            grdConci.Row = k%
            grdConci.Col = 7 '6
            VResul = Trim(grdConci.text)
            grdConci.Row = k%
            grdConci.Col = 13 '15
            If Trim(grdConci.text) = "" And VResul <> "OK" Then
                cmdBoton(1).Enabled = False
                cmdBoton(4).Enabled = True
                Exit For
            End If
            If Trim(grdConci.text) = "S" Then
                VScierre = "S"
                Exit For
            End If
          Next k
          
      End If
      
   Else
      PMLimpiaGrid Me.grdConci
        
      'Resultados
      Me.lblOkBco.Caption = "0"
      Me.lblSoloBco.Caption = "0"
      Me.lblProcesBco.Caption = "0"
      Me.lblOkBcoValor.Caption = "0.00"
      Me.lblSoloBcoValor.Caption = "0.00"
      Me.lblProcesBcoValor.Caption = "0.00"
        
      Me.lblOkEmp.Caption = "0"
      Me.lblSoloEmp.Caption = "0"
      Me.lblProcesEmp.Caption = "0"
      Me.lblOkEmpValor.Caption = "0.00"
      Me.lblSoloEmpValor.Caption = "0.00"
      Me.lblProcesEmpValor.Caption = "0.00"
      Me.lbl_registros = 0
   End If
   
   If Me.grdConci.Rows > 1 Then Me.grdConci.topRow = 1
   If Me.grdConci.Rows > 1 Then Me.grdConci.LeftCol = 1
    
End Sub

Sub PLSacaTotalesCnel() 'DAPV/03212012/CNEL
    
    'Inicializo las variables a considerar en los totales
    Dim VLOkReg As Integer
    Dim VLOkRegBco As Integer
    
    Dim VLValorOk As Currency
    Dim VLValorOkBco As Currency
    
    Dim VLOkRegEmp As Integer
    Dim VLValorOkEmp As Currency
    
    Me.lblOkBco = 0
    Me.lblSoloBco = 0
    Me.lblProcesBco = 0
    
    Me.lblOkBcoValor = 0
    Me.lblSoloBcoValor = 0
    Me.lblProcesBcoValor = 0
    
    Me.lblOkEmp = 0
    Me.lblSoloEmp = 0
    Me.lblProcesEmp = 0
    
    Me.lblOkEmpValor = 0
    Me.lblSoloEmpValor = 0
    Me.lblProcesEmpValor = 0
    
    'Debug.Print grdConci.Rows - 1
    For j% = 1 To (grdConci.Rows - 1)
        'Seteo la fila a usar
        Me.grdConci.Row = j%
        
        Me.grdConci.Col = 7     'Columna con el estado de Banco
        VLEstBco = Me.grdConci.text
        Me.grdConci.Col = 8     'Columna con el estado de Emp
        VLEstEmp = Me.grdConci.text
    
        'Obtengo el valor de los pagos Ok en Bco y en Emp
        If VLEstBco = "SI" And VLEstEmp = "SI" Then
            Me.grdConci.Col = 3
            VLValorOk = VLValorOk + CCur(Me.grdConci.text)
            VLOkReg = VLOkReg + 1
        End If
    
        'Obtengo el valor de los pagos SI en Bco y NO en Emp
        If VLEstBco = "SI" And VLEstEmp = "NO" Then
            Me.grdConci.Col = 3
            VLValorOkBco = VLValorOkBco + CCur(Me.grdConci.text)
            VLOkRegBco = VLOkRegBco + 1
        End If
        
        'Obtengo el valor de los pagos NO en Bco y SI en Emp
        If VLEstBco = "NO" And VLEstEmp = "SI" Then
            Me.grdConci.Col = 3
            VLValorOkEmp = VLValorOkEmp + CCur(Me.grdConci.text)
            VLOkRegEmp = VLOkRegEmp + 1
        End If
        
    Next j%

    'Sumatoria de los totales
    'Banco
    Me.lblOkBco = CInt(VLOkReg)
    Me.lblSoloBco = CInt(VLOkRegBco)
    Me.lblProcesBco = CInt(VLOkRegBco) + CInt(VLOkReg)
    Me.lblOkBcoValor = Format(CCur(VLValorOk), "0.00")
    Me.lblSoloBcoValor = Format(CCur(VLValorOkBco), "0.00")
    Me.lblProcesBcoValor = Format((CCur(VLValorOk) + CCur(VLValorOkBco)), "0.00")
    
    'Empresa Servicio
    Me.lblOkEmp = CInt(VLOkReg)
    Me.lblSoloEmp = CInt(VLOkRegEmp)
    Me.lblProcesEmp = CInt(VLOkRegEmp) + CInt(VLOkReg)
    Me.lblOkEmpValor = Format(CCur(VLValorOk), "0.00")
    Me.lblSoloEmpValor = Format(CCur(VLValorOkEmp), "0.00")
    Me.lblProcesEmpValor = Format((CCur(VLValorOk) + CCur(VLValorOkEmp)), "0.00")
    
End Sub

Sub PLSacaTotalesSenae() 'smerinom
    
    'Inicializo las variables a considerar en los totales
    Dim VLOkReg As Integer
    Dim VLOkRegBco As Integer
    
    Dim VLValorOk As Currency
    Dim VLValorOkBco As Currency
    
    Dim VLOkRegEmp As Integer
    Dim VLValorOkEmp As Currency
    
    Me.lblOkBco = 0
    Me.lblSoloBco = 0
    Me.lblProcesBco = 0
    
    Me.lblOkBcoValor = 0
    Me.lblSoloBcoValor = 0
    Me.lblProcesBcoValor = 0
    
    Me.lblOkEmp = 0
    Me.lblSoloEmp = 0
    Me.lblProcesEmp = 0
    
    Me.lblOkEmpValor = 0
    Me.lblSoloEmpValor = 0
    Me.lblProcesEmpValor = 0
    
    'Debug.Print grdConci.Rows - 1
    For j% = 1 To (grdConci.Rows - 1)
        'Seteo la fila a usar
        Me.grdConci.Row = j%
        
        Me.grdConci.Col = 8 '7     'Columna con el estado de Banco
        VLEstBco = Me.grdConci.text
        Me.grdConci.Col = 9 '8     'Columna con el estado de Emp
        VLEstEmp = Me.grdConci.text
    
        'Obtengo el valor de los pagos Ok en Bco y en Emp
        If VLEstBco = "SI" And VLEstEmp = "SI" Then
            Me.grdConci.Col = 2 '3
            VLValorOk = VLValorOk + CCur(Me.grdConci.text)
            VLOkReg = VLOkReg + 1
        End If
    
        'Obtengo el valor de los pagos SI en Bco y NO en Emp
        If VLEstBco = "SI" And VLEstEmp = "NO" Then
            Me.grdConci.Col = 2 '3
            VLValorOkBco = VLValorOkBco + CCur(Me.grdConci.text)
            VLOkRegBco = VLOkRegBco + 1
        End If
        
        'Obtengo el valor de los pagos NO en Bco y SI en Emp
        If VLEstBco = "NO" And VLEstEmp = "SI" Then
            Me.grdConci.Col = 2 '3
            VLValorOkEmp = VLValorOkEmp + CCur(Me.grdConci.text)
            VLOkRegEmp = VLOkRegEmp + 1
        End If
        
    Next j%

    'Sumatoria de los totales
    'Banco
    Me.lblOkBco = CInt(VLOkReg)
    Me.lblSoloBco = CInt(VLOkRegBco)
    Me.lblProcesBco = CInt(VLOkRegBco) + CInt(VLOkReg)
    Me.lblOkBcoValor = Format(CCur(VLValorOk), "0.00")
    Me.lblSoloBcoValor = Format(CCur(VLValorOkBco), "0.00")
    Me.lblProcesBcoValor = Format((CCur(VLValorOk) + CCur(VLValorOkBco)), "0.00")
    
    'Empresa Servicio
    Me.lblOkEmp = CInt(VLOkReg)
    Me.lblSoloEmp = CInt(VLOkRegEmp)
    Me.lblProcesEmp = CInt(VLOkRegEmp) + CInt(VLOkReg)
    Me.lblOkEmpValor = Format(CCur(VLValorOk), "0.00")
    Me.lblSoloEmpValor = Format(CCur(VLValorOkEmp), "0.00")
    Me.lblProcesEmpValor = Format((CCur(VLValorOk) + CCur(VLValorOkEmp)), "0.00")
    
End Sub




Sub FLProcesarCnel() 'DAPV/03212012/cnel
    'Validacion de Estados
    If Me.optProc(0).Value = True Then      'Habilitar
        If Not (Me.cmdEstadoBco.text = "SI" And Me.cmbEstadoEmp.text = "NO") Then
            MsgBox "Estados deben ser: " & Chr(13) & "ESTADO BANCO = SI           " & Chr(13) & "ESTADO EMPRESA = NO", vbInformation + vbOKOnly, "TServi"
            Exit Sub
        End If
    ElseIf Me.optProc(1).Value = True Then  'reversar
        If Not (Me.cmdEstadoBco.text = "NO" And Me.cmbEstadoEmp.text = "SI") Then
            MsgBox "Estados deben ser: " & Chr(13) & "ESTADO BANCO = SI           " & Chr(13) & "ESTADO EMPRESA = NO", vbInformation + vbOKOnly, "TServi"
            Exit Sub
        End If
    End If
    
   For j% = 1 To Me.grdConci.Rows - 1
    grdConci.Row = j
        If Me.grdConci.CellForeColor = vbBlue Then
          
            PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 43294
            PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text)
            PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, Trim(Me.grdConci.TextMatrix(j%, 11))
            PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
            PMPasoValores SqlConn&, "@i_cod_seg", 0, SQLVARCHAR, "N"
            If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_cnel_a", True, "Búsqueda de Datos") Then
                PMChequea SqlConn&
            End If
                Me.grdConci.CellForeColor = vbBlack
                Me.grdConci.CellFontBold = False
                Set Me.grdConci.CellPicture = Nothing
                Me.grdConci.CellAlignment = 6
                
        End If
    Next j%

    'Actualizo el Flex
    Me.PLBuscarCnel (0)
    
End Sub
'msilvag Inicio
Sub FLProcesarEtapa()

    'Validacion de Estados
    If Me.optProc(0).Value = True Then      'Habilitar
        If Not (Me.cmdEstadoBco.text = "SI" And Me.cmbEstadoEmp.text = "NO") Then
            MsgBox "Estados deben ser: " & Chr(13) & "ESTADO BANCO = SI           " & Chr(13) & "ESTADO EMPRESA = NO", vbInformation + vbOKOnly, "TServi"
            Exit Sub
        End If
    ElseIf Me.optProc(1).Value = True Then  'reversar
        If Not (Me.cmdEstadoBco.text = "NO" And Me.cmbEstadoEmp.text = "SI") Then
            MsgBox "Estados deben ser: " & Chr(13) & "ESTADO BANCO = SI           " & Chr(13) & "ESTADO EMPRESA = NO", vbInformation + vbOKOnly, "TServi"
            Exit Sub
        End If
    End If
    
   For j% = 1 To Me.grdConci.Rows - 1
    grdConci.Row = j
        If Me.grdConci.CellForeColor = vbBlue Then
          
            PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
            PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "A"
            PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text)
            PMPasoValores SqlConn&, "@i_sec_servicio", 0, SQLVARCHAR, Trim(Me.grdConci.TextMatrix(j%, 12))
            PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
            If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_pago_etapa", True, "Búsqueda de Datos") Then
                PMChequea SqlConn&
            End If
                Me.grdConci.CellForeColor = vbBlack
                Me.grdConci.CellFontBold = False
                Set Me.grdConci.CellPicture = Nothing
                Me.grdConci.CellAlignment = 6
                
        End If
    Next j%
    
    PLBuscarETAPA Trim(Me.txt_empresa.text)
    
End Sub

'msilvag Fin



Private Sub PLExportaExcelSenae() 'smerinom senae
Dim oExcelApp   As Object
Dim oWs         As Object
Dim oWb         As Object
Dim sXlsTemplate As String
Dim iRow As Integer
Dim iCol As Integer
Dim busqueda As String
Dim bco1, bco2, bco3 As String
Dim emp1, emp2, emp3 As String


On Error GoTo ErrorHandler

sXlsTemplate = App.Path & "\xrptSENAE.xlt"


Set oExcelApp = CreateObject("EXCEL.APPLICATION")              '(SIPECOM) LCHACHA OOF REF001
oExcelApp.Visible = False
oExcelApp.Workbooks.Open Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True   '(SIPECOM) LCHACHA OOF REF001
Set oWs = oExcelApp.ActiveSheet
Set oWb = oExcelApp.ActiveWorkbook

Set oWs = oExcelApp.ActiveSheet

oWs.Cells(6, 1).Value = "      Reporte de Pagos de Aduaneros - Empresa: (" & Me.txt_empresa & ") " & Me.lbl_empresa


For iRow = 1 To Me.grdConci.Rows - 1
    Screen.MousePointer = 11
    Me.grdConci.Row = iRow
    Me.grdConci.Col = 1
    oWs.Cells(8 + iRow, 1).Value = Me.grdConci.text
    Me.grdConci.Col = 2
    oWs.Cells(8 + iRow, 2).Value = Me.grdConci.text
    Me.grdConci.Col = 3
    oWs.Cells(8 + iRow, 3).Value = Me.grdConci.text
    Me.grdConci.Col = 4
    oWs.Cells(8 + iRow, 4).Value = Me.grdConci.text
    Me.grdConci.Col = 5
    oWs.Cells(8 + iRow, 5).Value = Me.grdConci.text
    Me.grdConci.Col = 6
    oWs.Cells(8 + iRow, 6).Value = Me.grdConci.text
    Me.grdConci.Col = 7
    oWs.Cells(8 + iRow, 7).Value = Me.grdConci.text
    Me.grdConci.Col = 8
    oWs.Cells(8 + iRow, 8).Value = Me.grdConci.text
    Me.grdConci.Col = 9
    oWs.Cells(8 + iRow, 9).Value = Me.grdConci.text
    Me.grdConci.Col = 10
    oWs.Cells(8 + iRow, 10).Value = Me.grdConci.text
    Me.grdConci.Col = 11
    oWs.Cells(8 + iRow, 11).Value = Me.grdConci.text
    Me.grdConci.Col = 12
    oWs.Cells(8 + iRow, 12).Value = Me.grdConci.text
   ' Me.grdConci.Col = 13
    'oWs.Cells(8 + iRow, 13).Value = Me.grdConci.Text
   'Me.grdConci.Col = 14
    'oWs.Cells(8 + iRow, 14).Value = Me.grdConci.Text
    'Me.grdConci.Col = 15
    'oWs.Cells(8 + iRow, 15).Value = Me.grdConci.Text
    'Me.grdConci.Col = 16
    'oWs.Cells(8 + iRow, 16).Value = Me.grdConci.Text
    
    'Me.grdConci.Col = 17
    'oWs.Cells(8 + iRow, 17).Value = Me.grdConci.Text
    
    'Me.grdConci.Col = 18
    'oWs.Cells(8 + iRow, 18).Value = Me.grdConci.Text
    
    
    Screen.MousePointer = 0
Next iRow
oWs.Cells(13 + iRow, 1).Value = "TOTALES BANCO:"
oWs.Cells(13 + iRow, 1).Font.Bold = True
oWs.Cells(15 + iRow, 1).Value = Space(50) & "No." & Space(30) & "Valor"
oWs.Cells(15 + iRow, 1).Font.Bold = True
bco1 = lblOkBco & (Space(40 - Len(lblOkBco))) & lblOkBcoValor
oWs.Cells(16 + iRow, 1).Value = " Pagos Ok:" & Space(55) & bco1
bco2 = lblSoloBco & (Space(40 - Len(lblSoloBco))) & lblSoloBcoValor
oWs.Cells(17 + iRow, 1).Value = " Pagos solo en banco:" & Space(31) & bco2
bco3 = lblProcesBco & (Space(40 - Len(lblProcesBco))) & lblProcesBcoValor
oWs.Cells(18 + iRow, 1).Value = " Total procesados Bco:" & Space(29) & bco3
oWs.Cells(13 + iRow, 5).Value = "TOTALES EMPRESA:"
oWs.Cells(13 + iRow, 5).Font.Bold = True
oWs.Cells(15 + iRow, 5).Value = Space(50) & "No." & Space(30) & "Valor"
oWs.Cells(15 + iRow, 5).Font.Bold = True
emp1 = lblOkEmp & (Space(40 - Len(lblOkEmp))) & lblOkEmpValor
oWs.Cells(16 + iRow, 5).Value = " Pagos Ok:" & Space(55) & emp1
emp2 = lblSoloEmp & (Space(40 - Len(lblSoloEmp))) & lblSoloEmpValor
oWs.Cells(17 + iRow, 5).Value = " Pagos solo en Empresa:" & Space(26) & emp2
emp3 = lblProcesEmp & (Space(40 - Len(lblProcesEmp))) & lblProcesEmpValor
oWs.Cells(18 + iRow, 5).Value = " Total procesados Emp:" & Space(28) & emp3


oExcelApp.Visible = True
Set oWs = Nothing
Set oExcelApp = Nothing
Exit Sub

ErrorHandler:
    Screen.MousePointer = vbDefault
    MsgBox err.Description & " (" & CStr(err.Number) & ")", vbExclamation, "Excel Export"
    On Error Resume Next
    oExcelApp.Quit
    Set oWs = Nothing
    Set oExcelApp = Nothing
End Sub


'(SIPECOM) MALDAZ OOF REF003
Private Sub PLExportaExcelSenaeOOF() 'smerinom senae
Dim oExcelApp   As Object
Dim oWs         As Object
Dim oWb         As Object
Dim sXlsTemplate As String
Dim iRow As Integer
Dim iCol As Integer
Dim busqueda As String
Dim bco1, bco2, bco3 As String
Dim emp1, emp2, emp3 As String


On Error GoTo ErrorHandler

'INICIO (SIPECOM) LCHACHA OOF REF004
'sXlsTemplate = App.Path & "\xrptSENAE.xlt"
Dim sNewXlsFile  As String
sNewXlsFile = "xrptSENAE" & Format$(Now, "YYYYMMDDHHMMSS") + ".ods"
FileCopy App.Path & "\xrptSENAE.xlt", Environ$("tmp") & "\" & sNewXlsFile
sXlsTemplate = Environ$("tmp") & "\" & sNewXlsFile
'FIN (SIPECOM) LCHACHA OOF REF004

'Set oExcelApp = CreateObject("EXCEL.APPLICATION")              '(SIPECOM) LCHACHA OOF REF001
Set oExcelApp = CreateObject("HOJAELECTRONICABB.APPLICATION")   '(SIPECOM) LCHACHA OOF REF001
'oExcelApp.Visible = False
'oExcelApp.Workbooks.Open Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True   '(SIPECOM) LCHACHA OOF REF001
oExcelApp.Workbooks.OpenW Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True, DestinationFile:="Pantalla"    '(SIPECOM) MALDAZ OOF REF003
Set oWs = oExcelApp.ActiveSheet
Set oWb = oExcelApp.ActiveWorkbook

Set oWs = oExcelApp.ActiveSheet

oWs.Cells(6, 1).Value = "      Reporte de Pagos de Aduaneros - Empresa: (" & Me.txt_empresa & ") " & Me.lbl_empresa


For iRow = 1 To Me.grdConci.Rows - 1
    Screen.MousePointer = 11
    Me.grdConci.Row = iRow
    Me.grdConci.Col = 1
    oWs.Cells(8 + iRow, 1).Value = Me.grdConci.text
    Me.grdConci.Col = 2
    oWs.Cells(8 + iRow, 2).Value = Me.grdConci.text
    Me.grdConci.Col = 3
    oWs.Cells(8 + iRow, 3).Value = Me.grdConci.text
    Me.grdConci.Col = 4
    oWs.Cells(8 + iRow, 4).Value = Me.grdConci.text
    Me.grdConci.Col = 5
    oWs.Cells(8 + iRow, 5).Value = Me.grdConci.text
    Me.grdConci.Col = 6
    oWs.Cells(8 + iRow, 6).Value = Me.grdConci.text
    Me.grdConci.Col = 7
    oWs.Cells(8 + iRow, 7).Value = Me.grdConci.text
    Me.grdConci.Col = 8
    oWs.Cells(8 + iRow, 8).Value = Me.grdConci.text
    Me.grdConci.Col = 9
    oWs.Cells(8 + iRow, 9).Value = Me.grdConci.text
    Me.grdConci.Col = 10
    oWs.Cells(8 + iRow, 10).Value = Me.grdConci.text
    Me.grdConci.Col = 11
    oWs.Cells(8 + iRow, 11).Value = Me.grdConci.text
    Me.grdConci.Col = 12
    oWs.Cells(8 + iRow, 12).Value = Me.grdConci.text
   ' Me.grdConci.Col = 13
    'oWs.Cells(8 + iRow, 13).Value = Me.grdConci.Text
   'Me.grdConci.Col = 14
    'oWs.Cells(8 + iRow, 14).Value = Me.grdConci.Text
    'Me.grdConci.Col = 15
    'oWs.Cells(8 + iRow, 15).Value = Me.grdConci.Text
    'Me.grdConci.Col = 16
    'oWs.Cells(8 + iRow, 16).Value = Me.grdConci.Text
    
    'Me.grdConci.Col = 17
    'oWs.Cells(8 + iRow, 17).Value = Me.grdConci.Text
    
    'Me.grdConci.Col = 18
    'oWs.Cells(8 + iRow, 18).Value = Me.grdConci.Text
    
    
    Screen.MousePointer = 0
Next iRow
oWs.Cells(13 + iRow, 1).Value = "TOTALES BANCO:"
oWs.Cells(13 + iRow, 1).Font.Bold = True
oWs.Cells(15 + iRow, 1).Value = Space(50) & "No." & Space(30) & "Valor"
oWs.Cells(15 + iRow, 1).Font.Bold = True
bco1 = lblOkBco & (Space(40 - Len(lblOkBco))) & lblOkBcoValor
oWs.Cells(16 + iRow, 1).Value = " Pagos Ok:" & Space(55) & bco1
bco2 = lblSoloBco & (Space(40 - Len(lblSoloBco))) & lblSoloBcoValor
oWs.Cells(17 + iRow, 1).Value = " Pagos solo en banco:" & Space(31) & bco2
bco3 = lblProcesBco & (Space(40 - Len(lblProcesBco))) & lblProcesBcoValor
oWs.Cells(18 + iRow, 1).Value = " Total procesados Bco:" & Space(29) & bco3
oWs.Cells(13 + iRow, 5).Value = "TOTALES EMPRESA:"
oWs.Cells(13 + iRow, 5).Font.Bold = True
oWs.Cells(15 + iRow, 5).Value = Space(50) & "No." & Space(30) & "Valor"
oWs.Cells(15 + iRow, 5).Font.Bold = True
emp1 = lblOkEmp & (Space(40 - Len(lblOkEmp))) & lblOkEmpValor
oWs.Cells(16 + iRow, 5).Value = " Pagos Ok:" & Space(55) & emp1
emp2 = lblSoloEmp & (Space(40 - Len(lblSoloEmp))) & lblSoloEmpValor
oWs.Cells(17 + iRow, 5).Value = " Pagos solo en Empresa:" & Space(26) & emp2
emp3 = lblProcesEmp & (Space(40 - Len(lblProcesEmp))) & lblProcesEmpValor
oWs.Cells(18 + iRow, 5).Value = " Total procesados Emp:" & Space(28) & emp3


'oExcelApp.Visible = True
Set oWs = Nothing
Set oExcelApp = Nothing
DoEvents
Exit Sub

ErrorHandler:
    Screen.MousePointer = vbDefault
    MsgBox err.Description & " (" & CStr(err.Number) & ")", vbExclamation, "Excel Export"
 '   On Error Resume Next
 '   oExcelApp.Quit
    Set oWs = Nothing
    Set oExcelApp = Nothing
End Sub


Private Sub PLExportaExcelCNEL() 'DAPV/03212012/CNEL
Dim oExcelApp   As Object
Dim oWs         As Object
Dim oWb         As Object
Dim sXlsTemplate As String
Dim iRow As Integer
Dim iCol As Integer
Dim busqueda As String
Dim bco1, bco2, bco3 As String
Dim emp1, emp2, emp3 As String


On Error GoTo ErrorHandler
'sXlsTemplate = App.Path & "\xrptCATEG.xlt"    'lfcm 08-mayo-2009
sXlsTemplate = App.Path & "\xrptCNEL.xlt"       'lfcm 08-mayo-2009


Set oExcelApp = CreateObject("EXCEL.APPLICATION")                  '(SIPECOM) LCHACHA OOF REF001
oExcelApp.Visible = False
oExcelApp.Workbooks.Open Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True   '(SIPECOM) LCHACHA OOF REF001
Set oWs = oExcelApp.ActiveSheet
Set oWb = oExcelApp.ActiveWorkbook

Set oWs = oExcelApp.ActiveSheet
'oWs.Cells(6, 1).Value = "      Reporte de Pagos de CATEG - Empresa: (" & Me.txt_empresa & ") " & Me.lbl_empresa      'lfcm 08-mayo-2009
oWs.Cells(6, 1).Value = "      Reporte de Pagos de LUZ - Empresa: (" & Me.txt_empresa & ") " & Me.lbl_empresa         'lfcm 08-mayo-2009
'oWs.Cells(8, 2).Value = "Fecha Consulta: " & CStr(Now)
'oWs.Cells(8, 6).Value = "Cantidad: " & Trim(lbl_registros)

'oWs.Range("A10:L10").Interior.ColorIndex = 15
'oWs.Range("A10:L10").Borders.LineStyle = 1

'oWs.Cells(8, 1).Value = busqueda
For iRow = 1 To Me.grdConci.Rows - 1
    Screen.MousePointer = 11
    Me.grdConci.Row = iRow
    Me.grdConci.Col = 1
    oWs.Cells(8 + iRow, 1).Value = Me.grdConci.text
    Me.grdConci.Col = 2
    oWs.Cells(8 + iRow, 2).Value = Me.grdConci.text
    Me.grdConci.Col = 3
    oWs.Cells(8 + iRow, 3).Value = Me.grdConci.text
    Me.grdConci.Col = 4
    oWs.Cells(8 + iRow, 4).Value = Me.grdConci.text
    Me.grdConci.Col = 5
    oWs.Cells(8 + iRow, 5).Value = Me.grdConci.text
    Me.grdConci.Col = 6
    oWs.Cells(8 + iRow, 6).Value = Me.grdConci.text
    Me.grdConci.Col = 7
    oWs.Cells(8 + iRow, 7).Value = Me.grdConci.text
    Me.grdConci.Col = 8
    oWs.Cells(8 + iRow, 8).Value = Me.grdConci.text
    Me.grdConci.Col = 9
    oWs.Cells(8 + iRow, 9).Value = Me.grdConci.text
    Me.grdConci.Col = 10
    oWs.Cells(8 + iRow, 10).Value = Me.grdConci.text
    Me.grdConci.Col = 11
    oWs.Cells(8 + iRow, 11).Value = Me.grdConci.text
    Me.grdConci.Col = 12
    oWs.Cells(8 + iRow, 12).Value = Me.grdConci.text
    Me.grdConci.Col = 13
    oWs.Cells(8 + iRow, 13).Value = Me.grdConci.text
    Me.grdConci.Col = 14
    oWs.Cells(8 + iRow, 14).Value = Me.grdConci.text
    Me.grdConci.Col = 15
    oWs.Cells(8 + iRow, 15).Value = Me.grdConci.text
    Me.grdConci.Col = 16
    oWs.Cells(8 + iRow, 16).Value = Me.grdConci.text
    
    'Me.grdConci.Col = 17
    'oWs.Cells(8 + iRow, 17).Value = Me.grdConci.Text
    
    'Me.grdConci.Col = 18
    'oWs.Cells(8 + iRow, 18).Value = Me.grdConci.Text
    
    
    Screen.MousePointer = 0
Next iRow
oWs.Cells(13 + iRow, 1).Value = "TOTALES BANCO:"
oWs.Cells(13 + iRow, 1).Font.Bold = True
oWs.Cells(15 + iRow, 1).Value = Space(50) & "No." & Space(30) & "Valor"
oWs.Cells(15 + iRow, 1).Font.Bold = True
bco1 = lblOkBco & (Space(40 - Len(lblOkBco))) & lblOkBcoValor
oWs.Cells(16 + iRow, 1).Value = " Pagos Ok:" & Space(55) & bco1
bco2 = lblSoloBco & (Space(40 - Len(lblSoloBco))) & lblSoloBcoValor
oWs.Cells(17 + iRow, 1).Value = " Pagos solo en banco:" & Space(31) & bco2
bco3 = lblProcesBco & (Space(40 - Len(lblProcesBco))) & lblProcesBcoValor
oWs.Cells(18 + iRow, 1).Value = " Total procesados Bco:" & Space(29) & bco3
oWs.Cells(13 + iRow, 5).Value = "TOTALES EMPRESA:"
oWs.Cells(13 + iRow, 5).Font.Bold = True
oWs.Cells(15 + iRow, 5).Value = Space(50) & "No." & Space(30) & "Valor"
oWs.Cells(15 + iRow, 5).Font.Bold = True
emp1 = lblOkEmp & (Space(40 - Len(lblOkEmp))) & lblOkEmpValor
oWs.Cells(16 + iRow, 5).Value = " Pagos Ok:" & Space(55) & emp1
emp2 = lblSoloEmp & (Space(40 - Len(lblSoloEmp))) & lblSoloEmpValor
oWs.Cells(17 + iRow, 5).Value = " Pagos solo en Empresa:" & Space(26) & emp2
emp3 = lblProcesEmp & (Space(40 - Len(lblProcesEmp))) & lblProcesEmpValor
oWs.Cells(18 + iRow, 5).Value = " Total procesados Emp:" & Space(28) & emp3


oExcelApp.Visible = True
Set oWs = Nothing
Set oExcelApp = Nothing
DoEvents
Exit Sub

ErrorHandler:
    Screen.MousePointer = vbDefault
    MsgBox err.Description & " (" & CStr(err.Number) & ")", vbExclamation, "Excel Export"
    'On Error Resume Next
    'oExcelApp.Quit
    Set oWs = Nothing
    Set oExcelApp = Nothing
End Sub


Private Sub PLExportaExcelCNELOOF() 'DAPV/03212012/CNEL
Dim oExcelApp   As Object
Dim oWs         As Object
Dim oWb         As Object
Dim sXlsTemplate As String
Dim iRow As Integer
Dim iCol As Integer
Dim busqueda As String
Dim bco1, bco2, bco3 As String
Dim emp1, emp2, emp3 As String


On Error GoTo ErrorHandler
'sXlsTemplate = App.Path & "\xrptCATEG.xlt"    'lfcm 08-mayo-2009

'INICIO (SIPECOM) LCHACHA OOF REF004
'sXlsTemplate = App.Path & "\xrptCNEL.xlt"       'lfcm 08-mayo-2009
Dim sNewXlsFile  As String
sNewXlsFile = "xrptCNEL" & Format$(Now, "YYYYMMDDHHMMSS") + ".ods"
FileCopy App.Path & "\xrptCNEL.xlt", Environ$("tmp") & "\" & sNewXlsFile
sXlsTemplate = Environ$("tmp") & "\" & sNewXlsFile
'FIN (SIPECOM) LCHACHA OOF REF004

Set oExcelApp = CreateObject("HOJAELECTRONICABB.APPLICATION")       '(SIPECOM) LCHACHA OOF REF001
'oExcelApp.Visible = False

oExcelApp.Workbooks.OpenW Filename:=sXlsTemplate, ReadOnly:=True, ignoreReadOnlyRecommended:=True, DestinationFile:="Pantalla"  '(SIPECOM) LCHACHA OOF REF001
Set oWs = oExcelApp.ActiveSheet
Set oWb = oExcelApp.ActiveWorkbook

Set oWs = oExcelApp.ActiveSheet
'oWs.Cells(6, 1).Value = "      Reporte de Pagos de CATEG - Empresa: (" & Me.txt_empresa & ") " & Me.lbl_empresa      'lfcm 08-mayo-2009
oWs.Cells(6, 1).Value = "      Reporte de Pagos de LUZ - Empresa: (" & Me.txt_empresa & ") " & Me.lbl_empresa         'lfcm 08-mayo-2009
'oWs.Cells(8, 2).Value = "Fecha Consulta: " & CStr(Now)
'oWs.Cells(8, 6).Value = "Cantidad: " & Trim(lbl_registros)

'oWs.Range("A10:L10").Interior.ColorIndex = 15
'oWs.Range("A10:L10").Borders.LineStyle = 1

'oWs.Cells(8, 1).Value = busqueda
For iRow = 1 To Me.grdConci.Rows - 1
    Screen.MousePointer = 11
    Me.grdConci.Row = iRow
    Me.grdConci.Col = 1
    oWs.Cells(8 + iRow, 1).Value = Me.grdConci.text
    Me.grdConci.Col = 2
    oWs.Cells(8 + iRow, 2).Value = Me.grdConci.text
    Me.grdConci.Col = 3
    oWs.Cells(8 + iRow, 3).Value = Me.grdConci.text
    Me.grdConci.Col = 4
    oWs.Cells(8 + iRow, 4).Value = Me.grdConci.text
    Me.grdConci.Col = 5
    oWs.Cells(8 + iRow, 5).Value = Me.grdConci.text
    Me.grdConci.Col = 6
    oWs.Cells(8 + iRow, 6).Value = Me.grdConci.text
    Me.grdConci.Col = 7
    oWs.Cells(8 + iRow, 7).Value = Me.grdConci.text
    Me.grdConci.Col = 8
    oWs.Cells(8 + iRow, 8).Value = Me.grdConci.text
    Me.grdConci.Col = 9
    oWs.Cells(8 + iRow, 9).Value = Me.grdConci.text
    Me.grdConci.Col = 10
    oWs.Cells(8 + iRow, 10).Value = Me.grdConci.text
    Me.grdConci.Col = 11
    oWs.Cells(8 + iRow, 11).Value = Me.grdConci.text
    Me.grdConci.Col = 12
    oWs.Cells(8 + iRow, 12).Value = Me.grdConci.text
    Me.grdConci.Col = 13
    oWs.Cells(8 + iRow, 13).Value = Me.grdConci.text
    Me.grdConci.Col = 14
    oWs.Cells(8 + iRow, 14).Value = Me.grdConci.text
    Me.grdConci.Col = 15
    oWs.Cells(8 + iRow, 15).Value = Me.grdConci.text
    Me.grdConci.Col = 16
    oWs.Cells(8 + iRow, 16).Value = Me.grdConci.text
    
    'Me.grdConci.Col = 17
    'oWs.Cells(8 + iRow, 17).Value = Me.grdConci.Text
    
    'Me.grdConci.Col = 18
    'oWs.Cells(8 + iRow, 18).Value = Me.grdConci.Text
    
    
    Screen.MousePointer = 0
Next iRow
oWs.Cells(13 + iRow, 1).Value = "TOTALES BANCO:"
oWs.Cells(13 + iRow, 1).Font.Bold = True
oWs.Cells(15 + iRow, 1).Value = Space(50) & "No." & Space(30) & "Valor"
oWs.Cells(15 + iRow, 1).Font.Bold = True
bco1 = lblOkBco & (Space(40 - Len(lblOkBco))) & lblOkBcoValor
oWs.Cells(16 + iRow, 1).Value = " Pagos Ok:" & Space(55) & bco1
bco2 = lblSoloBco & (Space(40 - Len(lblSoloBco))) & lblSoloBcoValor
oWs.Cells(17 + iRow, 1).Value = " Pagos solo en banco:" & Space(31) & bco2
bco3 = lblProcesBco & (Space(40 - Len(lblProcesBco))) & lblProcesBcoValor
oWs.Cells(18 + iRow, 1).Value = " Total procesados Bco:" & Space(29) & bco3
oWs.Cells(13 + iRow, 5).Value = "TOTALES EMPRESA:"
oWs.Cells(13 + iRow, 5).Font.Bold = True
oWs.Cells(15 + iRow, 5).Value = Space(50) & "No." & Space(30) & "Valor"
oWs.Cells(15 + iRow, 5).Font.Bold = True
emp1 = lblOkEmp & (Space(40 - Len(lblOkEmp))) & lblOkEmpValor
oWs.Cells(16 + iRow, 5).Value = " Pagos Ok:" & Space(55) & emp1
emp2 = lblSoloEmp & (Space(40 - Len(lblSoloEmp))) & lblSoloEmpValor
oWs.Cells(17 + iRow, 5).Value = " Pagos solo en Empresa:" & Space(26) & emp2
emp3 = lblProcesEmp & (Space(40 - Len(lblProcesEmp))) & lblProcesEmpValor
oWs.Cells(18 + iRow, 5).Value = " Total procesados Emp:" & Space(28) & emp3


'oExcelApp.Visible = True
Set oWs = Nothing
Set oExcelApp = Nothing
DoEvents
Exit Sub

ErrorHandler:
    Screen.MousePointer = vbDefault
    MsgBox err.Description & " (" & CStr(err.Number) & ")", vbExclamation, "Excel Export"
    'On Error Resume Next
    'oExcelApp.Quit
    Set oWs = Nothing
    Set oExcelApp = Nothing
End Sub


Sub PLConfirmaCNEL() 'DAPV/03212012/CNEL
    'Agregar validacion de que si está seguro de Cerrar la Conciliacion
    Respuesta = MsgBox("Desea Cerrar la Conciliacion", vbInformation + vbOKCancel, "TServi")
    If Respuesta = vbCancel Then
        Exit Sub
    End If
    'Confimacion de Activacion de Casilla: Marcar Todos
    If Me.chkTodos.Value = False Then
        MsgBox "Seleccione la Casilla: Marcar Todos", vbInformation + vbOKOnly, "TServi"
        Exit Sub
    End If
    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, "43295"
    PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT4, Trim(txt_empresa.text)
    PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, 0
    PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
    PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, ""
    PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, ""
    PMPasoValores SqlConn&, "@o_existe", 1, SQLCHAR, Space(1)
    If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_cnel_x", True, "Búsqueda de Datos") Then
        PMChequea SqlConn&
        MsgBox "La conciliacion se ha cerrado.", vbOKOnly + vbInformation, "TServi"
        PLBuscarCNELFile (0)
            PLGeneraArchivoLuz
    Else
        PMChequea SqlConn&
        PLBuscarCNELFile (0)
            PLGeneraArchivoLuz
    End If
    
           
    PLBuscarCnel (0)  'Luego de la confirmacion realizo nuevamente la consulta _
                              para refrescar la columna que muestra el estado de la _
                              conciliacion en Pantalla
    Me.chkTodos.Value = False
    If Me.grdConci.Rows > 1 Then Me.grdConci.topRow = 1
    If Me.grdConci.Rows > 1 Then Me.grdConci.LeftCol = 1
End Sub


Sub PLGeneraArchivoLuz()
   'Aplico formato al campo hora
   FormateoCampoHora
    If vlGrupo = "S" Then
    'Abro el archivo para comenzar a grabar el detalle.
        VTnombarch$ = "BANCBOL" & Mid(Me.dtFecha, 4, 2) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 9, 4) & ".DAT"
    Else
        VTnombarch$ = "BANCBOL" & Trim(txt_empresa.text) & "_" & Mid(Me.dtFecha, 4, 2) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 9, 4) & ".DAT"
    End If
    Open "c:\cobis\tadmin\" & VTnombarch$ For Output As #1

    'Registro de Cabecera
    TipoRegistro$ = "C"
    FechaProceso$ = Mid(Me.dtFecha, 7, 4) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2)
    FechaRecaudacion$ = Mid(Me.dtFecha, 7, 4) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2)
    CodigoIfi$ = "0007"
    
    'Obtener el total recaudado
    Dim VLTotRecauda As Currency
    For t% = 1 To Me.grdConci.Rows - 1
        Me.grdConci.Row = t%
        Me.grdConci.Col = 6     'Columna que tiene el estado de la Conciliacion(OK-CA-BO)
        If Me.grdConci.text = "OK" Or Me.grdConci.text = "BO" Then
            Me.grdConci.Col = 3
            VLTotRecauda = VLTotRecauda + Me.grdConci.text
        End If
    Next t%
    
    VLCodSeg$ = ""
    'Codigo de seguridad asignado por CNEL al BCO
    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, "43294"
    PMPasoValores SqlConn&, "@i_cod_seg", 0, SQLVARCHAR, "S"
    PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
    PMPasoValores SqlConn&, "@o_codseg", 1, SQLVARCHAR, "          "
    If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_cnel_a", True, "Ok... Consulta de Pagos TVCABLE") Then
        PMChequea SqlConn
        VLCodSeg$ = FMRetParam$(SqlConn&, 1)
    End If
     PMChequea SqlConn
    
    'TotalRecaudado$ = "888888888888"
    TotalRecaudado$ = CStr(VLTotRecauda * 100)
    TotalRecaudado$ = Format(TotalRecaudado$, "000000000000")
    VLSpaces$ = String(111, "0")
    
    'Grabo el Registro de Cabecera
    VTLineal$ = "C"
    VTLineal$ = VTLineal$ + FechaProceso$ + FechaRecaudacion$ + CodigoIfi$
    VTLineal$ = VTLineal$ + TotalRecaudado$ + VLCodSeg$ + VLSpaces$
    Print #1, VTLineal$

    VLTotaLinea = 0
'Obtengo la cantidad de registros que hay en el grid
    For g% = 1 To Me.grdAlterno.Rows - 1
        VLTotaLinea = g%
    Next g%



    'Registro de Detalle
    For j% = 1 To Me.grdAlterno.Rows - 1
    Me.grdAlterno.Row = j%
    
    FechaProceso$ = Mid(Me.dtFecha, 7, 4) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2)
    VLTipoMsg$ = "0210"
    VLTipoTrx$ = "000101"
    
    'Codigo de Cuenta
    Me.grdAlterno.Col = 3
    VLCodCuenta$ = Me.grdAlterno.text + Mid("                   ", 1, 19 - Len(Me.grdAlterno.text))
    
    'Numero de Factura
    Me.grdAlterno.Col = 4
    VLNumFactura$ = Mid("00000000000000000000", 1, 20 - Len(Me.grdAlterno.text)) + Me.grdAlterno.text
    
    'Inst Financierqa
    Me.grdAlterno.Col = 5
    VLInstFinan$ = Mid("0000", 1, 4 - Len(Me.grdAlterno.text)) + Me.grdAlterno.text
    

    
    'Hora de Trx Local
    Me.grdAlterno.Col = 6
    VLHoraTrxLocal$ = Trim(Me.grdAlterno.text)
    VLHoraTrxLocal$ = Mid(VLHoraTrxLocal$, 1, 2) & Mid(VLHoraTrxLocal$, 3, 2) & Mid(VLHoraTrxLocal$, 5, 2)
    VLHoraTrxLocal$ = Format(VLHoraTrxLocal$, "000000")
    
    'Fecha Trx Local
    Me.grdAlterno.Col = 7
    VLFechaTrxLocal$ = Mid(Me.grdAlterno.text, 7, 4) & Mid(Me.grdAlterno.text, 1, 2) & Mid(Me.grdAlterno.text, 4, 2)
    VLFechaTrxLocal$ = Format(VLFechaTrxLocal$, "00000000")
    
    
    'Codigo de Operador
    Me.grdAlterno.Col = 8
    VLCodOperador$ = Trim(Me.grdAlterno.text)
    VLCodOperador$ = VLCodOperador$ + Mid("      ", 1, 6 - Len(VLCodOperador$))
    
    
    'Codigo resultado
    Me.grdAlterno.Col = 9
    VLCodResultado$ = Trim(Me.grdAlterno.text)
    VLCodResultado$ = Mid("000", 1, 3 - Len(VLCodResultado$)) + VLCodResultado$
    
       
    'Codigo de autorizacion
    Me.grdAlterno.Col = 10
    VLCodAutorizacion$ = Right(Me.grdAlterno.text, 6)    'Para el caso de los sec del Banco tomo los 6 ultimos
    VLCodAutorizacion$ = Mid("000000", 1, 6 - Len(VLCodAutorizacion$)) + VLCodAutorizacion$
    
    
    'Secuencia Ifi
    Me.grdAlterno.Col = 11
    VLSecIfi$ = Right(Me.grdAlterno.text, 6)
    VLSecIfi$ = Mid("000000", 1, 6 - Len(VLSecIfi$)) + VLSecIfi$
    
        
    'entidad autorizadora
    Me.grdAlterno.Col = 12
    VLEntAutor$ = Trim(Me.grdAlterno.text)
    VLEntAutor$ = Mid("000", 1, 3 - Len(VLEntAutor$)) + VLEntAutor$
    
    'codigo Servicio
    Me.grdAlterno.Col = 13
    VLCodServ$ = Trim(Me.grdAlterno.text)
    VLCodServ$ = Mid("000000", 1, 3 - Len(VLCodServ$)) + VLCodServ$
    
        
    
    'Codigo Ifi
    Me.grdAlterno.Col = 15
    VLCodIfi$ = Mid("0000", 1, 4 - Len(Me.grdAlterno.text)) + Me.grdAlterno.text
    
    'codigo Agencia
    Me.grdAlterno.Col = 16
    VLCodAgencia$ = Trim(Me.grdAlterno.text)
    VLCodAgencia$ = Mid("000000", 1, 6 - Len(VLCodAgencia$)) + VLCodAgencia$
    
    'Codigo Terminal
    Me.grdAlterno.Col = 17
    VLCodTerminal$ = Trim(Me.grdAlterno.text)
    VLCodTerminal$ = Mid("000000", 1, 6 - Len(VLCodTerminal$)) + VLCodTerminal$
   
 
 
 
    'Secuencia MIT
    Me.grdAlterno.Col = 18
    VLSecMit$ = Trim(Me.grdAlterno.text)
    VLSecMit$ = Mid("000000", 1, 6 - Len(VLSecMit$)) + VLSecMit$
    

    'Canal
    Me.grdAlterno.Col = 19
    VLCanal$ = Mid("   ", 1, 3 - Len(Me.grdAlterno.text)) + Me.grdAlterno.text

'   If VLCanal$ <> "DAT" Then
'       VLCodTerminal$ = Mid("0024000000000000", 1, 16 - Len(VLCodTerminal$)) + VLCodTerminal$
'    Else
'       VLCodTerminal$ = VLCodTerminal$ + Mid("                ", 1, 16 - Len(VLCodTerminal$)) 'gmartillo 12/03/2008
'    End If
   
      'Valor Adeudado
        Me.grdAlterno.Col = 20
    If Me.grdAlterno.text >= 0 Then
        VLValAdeudado$ = Format(Me.grdAlterno.text * 100, "000000000000")
    Else
        VLValAdeudado$ = Format(Me.grdAlterno.text * 100, "00000000000")
    End If
   
   
    'Valor Recaudado
    Me.grdAlterno.Col = 21
    VLValRecaudado$ = Format(Me.grdAlterno.text * 100, "000000000000")
    
  
    'Estado de Conciliacion
    Me.grdAlterno.Col = 22
    VLEstConcilia$ = Trim(Me.grdAlterno.text)
    
    
    'Grabo el registro de Detalle
    VTLineal$ = "D"
    VTLineal$ = VTLineal$ + FechaProceso$ + VLTipoMsg$ + VLTipoTrx$ + VLCodCuenta$
    VTLineal$ = VTLineal$ + VLNumFactura$ + VLInstFinan$ + VLHoraTrxLocal$ + VLFechaTrxLocal$
    VTLineal$ = VTLineal$ + VLCodOperador$ + VLCodResultado$ + VLCodAutorizacion$ + VLSecIfi$
    VTLineal$ = VTLineal$ + VLEntAutor$ + VLCodServ$ + VLCodIfi$ + VLCodAgencia$ + VLCodTerminal$ + VLSecMit + VLCanal
    VTLineal$ = VTLineal$ + VLValAdeudado$ + VLValRecaudado$ + VLEstConcilia$


'    If VLTotaLinea = j% Then
'    'Ultima linea, agregar caracter punto-y-coma para no hacer el salto
'    Print #1, VTLineal$;
'    Else
'    'No es la ultima linea, agrega salto
    Print #1, VTLineal$
'    End If

   
    Next j%
 
    'Cierro el archivo y muestro mensaje indicando la generacion exitosa del mismo.
    Close #1
    MsgBox "Archivo Generado Exitosamente", vbOKOnly + vbInformation, "TServi"

End Sub
'msilvag Inicio Generar Archivo ETAPA
Sub PLGeneraArchivoETAPA()
   'Aplico formato al campo hora
   FormateoCampoHora
   
   VTnombarch$ = "REM" & Mid(Me.dtFecha, 7, 4) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2) & "_000ET" & ".TXT"
    
    Open "c:\cobis\tadmin\" & VTnombarch$ For Output As #1

    'Registro de Cabecera
    TipoRegistro$ = "01"
    IdentArchivo$ = "RER"
    CodEntidad$ = "00023"
    codempresa$ = "ETAPA"
    ContenidoArchivo$ = "04"
    FechaProceso$ = Mid(Me.dtFecha, 7, 4) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2)
    FechaRecaudacion$ = Mid(Me.dtFecha, 7, 4) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2)
    
    
    CodigoIfi$ = "0007"
    
    'Obtener el total recaudado
    Dim VLTotRecauda As Currency
    Dim VlCantEtapa As Integer
    For t% = 1 To Me.grdConci.Rows - 1
        Me.grdConci.Row = t%
        Me.grdConci.Col = 7     'Columna que tiene el estado de la Conciliacion(OK-CA-BO)
        If Me.grdConci.text = "OK" Or Me.grdConci.text = "BO" Then
            Me.grdConci.Col = 4
            VLTotRecauda = VLTotRecauda + Me.grdConci.text
            VlCantEtapa = VlCantEtapa + 1
        End If
    Next t%
    
    VLCodSeg$ = ""
    'Codigo de seguridad asignado por CNEL al BCO
'    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, "43294"
'    PMPasoValores SqlConn&, "@i_cod_seg", 0, SQLVARCHAR, "S"
'    PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
'    PMPasoValores SqlConn&, "@o_codseg", 1, SQLVARCHAR, "          "
'    If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_cnel_a", True, "Ok... Consulta de Pagos TVCABLE") Then
'        PMChequea SqlConn
'        VLCodSeg$ = FMRetParam$(SqlConn&, 1)
'    End If
'     PMChequea SqlConn
    
    'TotalRecaudado$ = "888888888888"
    TotalRecaudado$ = CStr(VLTotRecauda * 100)
    TotalRecaudado$ = Format(TotalRecaudado$, "000000000000000")
    CantidadTrx$ = CStr(VlCantEtapa)
    CantidadTrx$ = Format(CantidadTrx$, "00000000")
    VLSpaces$ = String(68, " ")
    
    'Grabo el Registro de Cabecera
    VTLineal$ = "01"
    VTLineal$ = VTLineal$ + IdentArchivo$ + CodEntidad$
    VTLineal$ = VTLineal$ + codempresa$ + ContenidoArchivo$ + FechaProceso$
    VTLineal$ = VTLineal$ + FechaRecaudacion$ + CantidadTrx$ + TotalRecaudado$
    VTLineal$ = VTLineal$ + VLSpaces$
    Print #1, VTLineal$

    VLTotaLinea = 0
'Obtengo la cantidad de registros que hay en el grid
    For g% = 1 To Me.grdAlterno.Rows - 1
        VLTotaLinea = g%
    Next g%

    'Registro de Detalle
    For j% = 1 To Me.grdAlterno.Rows - 1
    Me.grdAlterno.Row = j%
    
    FechaProceso$ = Mid(Me.dtFecha, 7, 4) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2)
    VLTipoReg$ = "02"
    'Correctivo
    VlNovedad$ = "06"
    'obligacion del cliente
    Me.grdAlterno.Col = 1
    VLObligacion$ = Me.grdAlterno.text + Mid("               ", 1, 15 - Len(Me.grdAlterno.text))
    'Nombre cliente
    Me.grdAlterno.Col = 2
    VLNombreCli$ = Me.grdAlterno.text + Mid("                                        ", 1, 40 - Len(Me.grdAlterno.text))
    
    'referencia
    Me.grdAlterno.Col = 3
    VLRefere$ = Me.grdAlterno.text + Mid("               ", 1, 15 - Len(Me.grdAlterno.text))
    'ValorPagado
    Me.grdAlterno.Col = 4
    VLValorPagado$ = Format(Me.grdAlterno.text * 100, "0000000000")
    'FechaRecaudo
    Me.grdAlterno.Col = 5
    VLFechaRecaudo$ = Me.grdAlterno.text
    'Hora
    Me.grdAlterno.Col = 6
    VLFechaHora$ = Me.grdAlterno.text
    'FechaContable
    Me.grdAlterno.Col = 7
    VLFechaTrxLocal$ = Mid(Me.grdAlterno.text, 7, 4) & Mid(Me.grdAlterno.text, 1, 2) & Mid(Me.grdAlterno.text, 4, 2)
    VLFechaTrxLocal$ = Format(VLFechaTrxLocal$, "00000000")
    'Canal
    Me.grdAlterno.Col = 8
    VLCanal$ = Me.grdAlterno.text
    'FormaPago
    Me.grdAlterno.Col = 9
    VLFormPago$ = Me.grdAlterno.text + Mid("    ", 1, 4 - Len(Me.grdAlterno.text))
    'Id Transaccion
    Me.grdAlterno.Col = 10
    VLIdTrx$ = Me.grdAlterno.text

    VLTipoMsg$ = "0210"
    VLTipoTrx$ = "000101"
    
      
    'Grabo el registro de Detalle
    VTLineal$ = "02"
    VTLineal$ = VTLineal$ + VlNovedad$ + VLObligacion$ + VLNombreCli$ + VLRefere$
    VTLineal$ = VTLineal$ + VLValorPagado$ + VLFechaRecaudo$ + VLFechaHora$ + VLFechaTrxLocal$
    VTLineal$ = VTLineal$ + VLCodOperador$ + VLCodResultado$ + VLCodAutorizacion$ + VLSecIfi$
    VTLineal$ = VTLineal$ + VLCanal$ + VLFormPago$ + VLIdTrx$


'    If VLTotaLinea = j% Then
'    'Ultima linea, agregar caracter punto-y-coma para no hacer el salto
'    Print #1, VTLineal$;
'    Else
'    'No es la ultima linea, agrega salto
    Print #1, VTLineal$
'    End If

   
    Next j%
 
    'Cierro el archivo y muestro mensaje indicando la generacion exitosa del mismo.
    Close #1
    MsgBox "Archivo Generado Exitosamente", vbOKOnly + vbInformation, "TServi"

End Sub
'msilvag FIn

Sub PLGeneraArchivoSenae() 'smerino ajustes
  Dim val_nc2 As String 'smerino
   'Aplico formato al campo hora
   FormateoCampoHora
    
   If vlcantidad > 0 Then 'smerino10242012
   
   'VTnombarch$ = "C02DDABOL" & Mid(Me.dtFecha, 4, 2) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 9, 4) & ".TXT"
   VTnombarch$ = "C02DDABOL" & Mid(Me.dtFecha, 9, 2) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2) & ".TXT"
    
    Open "c:\cobis\tadmin\" & VTnombarch$ For Output As #1

    'Registro de Cabecera
    'tipo de registro
    TipoRegistro$ = "HE"
    'codigo de servicio
    CodServicio$ = "001002"
    'fecha de compensación
    FechaProceso$ = Mid(Me.dtFecha, 4, 2) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 7, 4)
    'longitud del archivo
    LongTotal$ = Mid("0000000000", 1, 10 - Len(VlongArch)) + VlongArch
    
    'total de registros
    VLTotaLinea = vlcantidad
    TotalRegistros$ = Mid("0000000000", 1, 10 - Len(VLTotaLinea)) + VLTotaLinea
    'monto
    VLTOTAL = VLTOTAL * 100
    TotalRecaudado$ = Mid("00000000000000000000", 1, 20 - Len(VLTOTAL)) + VLTOTAL

        
    
    'FechaProceso$ = Mid(Me.dtFecha, 7, 4) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2)
    'FechaRecaudacion$ = Mid(Me.dtFecha, 7, 4) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2)
    'CodigoIfi$ = "0007"
    
    'Obtener el total recaudado
   ' Dim VLTotRecauda As Currency
    'For t% = 1 To Me.grdConci.Rows - 1
      '  Me.grdConci.Row = t%
       ' Me.grdConci.Col = 6     'Columna que tiene el estado de la Conciliacion(OK-CA-BO)
       ' If Me.grdConci.Text = "OK" Or Me.grdConci.Text = "BO" Then
        '    Me.grdConci.Col = 3
        '    VLTotRecauda = VLTotRecauda + Me.grdConci.Text
        'End If
    'Next t%
    
   ' VLCodSeg$ = ""
    ''Codigo de seguridad asignado por CNEL al BCO
   ' PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, "43294"
    'PMPasoValores SqlConn&, "@i_cod_seg", 0, SQLVARCHAR, "S"
    'PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
    'PMPasoValores SqlConn&, "@o_codseg", 1, SQLVARCHAR, "          "
   ' If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_cnel_a", True, "Ok... Consulta de Pagos TVCABLE") Then
    '    PMChequea SqlConn
    '    VLCodSeg$ = FMRetParam$(SqlConn&, 1)
   ' End If
     'PMChequea SqlConn
    
    'TotalRecaudado$ = "888888888888"
    'TotalRecaudado$ = CStr(VLTotRecauda * 100)
    'TotalRecaudado$ = Format(TotalRecaudado$, "000000000000")
   ' VLSpaces$ = String(111, "0")
    
    'Grabo el Registro de Cabecera
    VTLineal$ = "HE"
    VTLineal$ = VTLineal$ + CodServicio$ + FechaProceso$ + LongTotal$ + TotalRegistros$ + TotalRecaudado$
    '+ FechaRecaudacion$ + CodigoIfi$
   ' VTLineal$ = VTLineal$ + TotalRecaudado$ + VLCodSeg$ + VLSpaces$
    Print #1, VTLineal$
   
    VLTotaLinea = 0
    
'smerino ajustes
'Obtengo la cantidad de registros que hay en el grid que extrae los ajustes
    
    For g% = 1 To Me.grdAlterno.Rows - 1
        VLTotaLinea = g%
    Next g%
   
   'Registro de Detalle
    For j% = 1 To Me.grdAlterno.Rows - 1
    Me.grdAlterno.Row = j%
    
    FechaProceso$ = Mid(Me.dtFecha, 7, 4) & Mid(Me.dtFecha, 1, 2) & Mid(Me.dtFecha, 4, 2)
    VLTipoMsg$ = "0210"
    VLTipoTrx$ = "000101"
    
    'tipo de registro
    TipoRegistro$ = "DR"
     'tipo de registro
    OrigenRegistro$ = "AD"
    'codigo de adquiriente
    CodAdqui$ = "000233"
    'codigo autorizador
    CodAut$ = "000034"
    'fecha y hora de la trx DDMMYYYYHHMISS
    Me.grdAlterno.Col = 3
    VLHoraTrxLocal$ = Trim(Me.grdAlterno.text)
    VLHoraTrxLocal$ = Mid(VLHoraTrxLocal$, 4, 2) & Mid(VLHoraTrxLocal$, 1, 2) & Mid(VLHoraTrxLocal$, 7, 4) & Mid(VLHoraTrxLocal$, 12, 2) & Mid(VLHoraTrxLocal$, 15, 2) & Mid(VLHoraTrxLocal$, 18, 2) 'smerino nuevos cambios
   'VLHoraTrxLocal$ = Mid(VLHoraTrxLocal$, 1, 2) & Mid(VLHoraTrxLocal$, 4, 2) & Mid(VLHoraTrxLocal$, 7, 4) & Mid(VLHoraTrxLocal$, 12, 2) & Mid(VLHoraTrxLocal$, 15, 2) & Mid(VLHoraTrxLocal$, 18, 2)
    'VLHoraTrxLocal$ = Format(VLHoraTrxLocal$, "000000")
    'codigo tipo de mensaje
    
    'VLTipoMsg$ = "0210"
    Me.grdAlterno.Col = 4
    VLTipoMsg$ = Mid("0000", 1, 4 - Len(Me.grdAlterno.text)) + Me.grdAlterno.text
    
    'subtipo de trx
    Me.grdAlterno.Col = 5
    VLTipoTrx$ = Mid("000000", 1, 6 - Len(Me.grdAlterno.text)) + Me.grdAlterno.text
    
    'Tipo de dispositivo
    Me.grdAlterno.Col = 6
    tipo_disp$ = Mid("0", 1, 1 - Len(Me.grdAlterno.text)) + Me.grdAlterno.text
    
    'secuencia de trx swift
    Me.grdAlterno.Col = 7
    sec_swift$ = Mid("000000", 1, 6 - Len(Me.grdAlterno.text)) + Me.grdAlterno.text
    
    'respuesta de trx
     Me.grdAlterno.Col = 8
    resp_trx$ = Mid("00", 1, 2 - Len(Me.grdAlterno.text)) + Me.grdAlterno.text
    
    'indicador de reversa
     Me.grdAlterno.Col = 9
     rev_trx$ = Mid("0", 1, 1 - Len(Me.grdAlterno.text)) + Me.grdAlterno.text
    
     'codigo de autorizacion
     Me.grdAlterno.Col = 10
     cod_aut$ = Mid("000000", 1, 6 - Len(Me.grdAlterno.text)) + Me.grdAlterno.text
     
       
     'codigo de agencia de recaudacion
     Me.grdAlterno.Col = 11
     cod_agen$ = Mid("000000", 1, 6 - Len(Me.grdAlterno.text)) + Me.grdAlterno.text
     
    'codigo de terminal  de recaudacion
     Me.grdAlterno.Col = 12
     cod_term$ = Trim(Me.grdAlterno.text)
     cod_term$ = cod_term$ + Mid("        ", 1, 8 - Len(cod_term$))
     
     'numero de comprobante
     Me.grdAlterno.Col = 13
     num_doc$ = Mid("0000000000000000", 1, 16 - Len(Me.grdAlterno.text)) + Me.grdAlterno.text
     
     'localidad del documento smerino
     Me.grdAlterno.Col = 14
     loc_doc$ = Mid("000000", 1, 6 - Len(Me.grdAlterno.text)) + Me.grdAlterno.text
     
     'numero de tarjeta
      Me.grdAlterno.Col = 15
      num_tar$ = Mid("00000000000000000000", 1, 20 - Len(Me.grdAlterno.text)) + Me.grdAlterno.text
     
     'codigo de la moneda
       Me.grdAlterno.Col = 16
       cod_mon$ = Mid("000", 1, 3 - Len(Me.grdAlterno.text)) + Me.grdAlterno.text
     
      'tipo de pago
       Me.grdAlterno.Col = 17
       tipo_pag$ = Mid("00", 1, 2 - Len(Me.grdAlterno.text)) + Me.grdAlterno.text
       
     
      'valor de la trx1
      Me.grdAlterno.Col = 18
      val_trx1$ = Me.grdAlterno.text 'smerino02182013
      val_total$ = Me.grdAlterno.text * 100
      val_total$ = Mid("00000000000000000000", 1, 20 - Len(val_total$)) + val_total$
   
     'valor de la trx2 nc
      Me.grdAlterno.Col = 19
      val_trx2$ = Me.grdAlterno.text 'smerino02182013
      val_nc2 = CDbl(val_trx2$) + CDbl(val_trx1$)
      val_nc$ = val_nc2 * 100  'smerino02182013
      val_nc$ = Mid("00000000000000000000", 1, 20 - Len(val_nc$)) + val_nc$
      
      'valor deL RESULTADO
      
      Me.grdAlterno.Col = 20
      Vlresultado$ = Me.grdAlterno.text
      
      If Vlresultado$ = 2 Then
          resp_proc$ = "REV"
      Else
        If Vlresultado$ = 3 Then
         resp_proc$ = "PAG"
        End If
        End If
       
       'codigo de respuesta de las trx
       'resp_proc$ = "000"
     
    'Grabo el registro de Detalle
    VTLineal$ = TipoRegistro$ + OrigenRegistro$ + CodAdqui$ + CodAut$ + VLHoraTrxLocal$
    VTLineal$ = VTLineal$ + VLTipoMsg$ + VLTipoTrx$ + tipo_disp$ + sec_swift$ + resp_trx$ + rev_trx$ + cod_aut$
    VTLineal$ = VTLineal$ + cod_agen$ + cod_term$ + num_doc$ + loc_doc$ + num_tar$ + cod_mon$ + tipo_pag$ + val_total$ + val_nc$ + resp_proc$
    
'    If VLTotaLinea = j% Then
'    'Ultima linea, agregar caracter punto-y-coma para no hacer el salto
'    Print #1, VTLineal$;
'    Else
'    'No es la ultima linea, agrega salto
    Print #1, VTLineal$
'    End If
    Next j%
 
    'Cierro el archivo y muestro mensaje indicando la generacion exitosa del mismo.
    Close #1
    MsgBox "Archivo Generado Exitosamente", vbOKOnly + vbInformation, "TServi"
End If 'fin smerino smerino10242012

End Sub

'msilvag Inicio Busca Archivo ETAPA
Sub PLBuscarETAPAFile(orden As Long)

   'Hago la consulta de los primeros 15 resultados
   PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, 3791
   PMPasoValores SqlConn&, "@i_opcion", 0, SQLCHAR, "F"
   PMPasoValores SqlConn&, "@i_empresa", 0, SQLVARCHAR, Trim(txt_empresa.text)
   PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, orden
   PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
   PMPasoValores SqlConn&, "@i_status_bco", 0, SQLVARCHAR, Me.cmdEstadoBco.text
   PMPasoValores SqlConn&, "@i_status_emp", 0, SQLVARCHAR, Me.cmbEstadoEmp.text
   
   If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_pago_etapa", True, "Ok... Consulta de Pagos Cbel") Then
      
      If orden = 0 Then
         PgMapeaFlexG grdAlterno, True, False, 0, 15, 24
      Else
         PgMapeaFlexG grdAlterno, False, False, 0, 15, 24
      End If
      
      PMChequea SqlConn&
      vlGrupo = FMRetParam(SqlConn&, 1)
      If Me.grdAlterno.Tag = "10" Then
         Me.grdAlterno.Col = 12  'msilvag cnb fase 2 Junio/23/2016
         Me.grdAlterno.Row = Me.grdAlterno.Rows - 1
         PLBuscarETAPAFile (Me.grdAlterno.text) 'msilvag cnb fase 2 Junio/23/2016
         'PLBuscarCNELFile (Me.grdAlterno.Text) 'msilvag cnb fase 2 Junio/23/2016
      Else
         'Elimino la Columna donde traje los secueciales para la busqueda
         'PLBuscarETAPAFile (Me.grdAlterno.Text) 'msilvag cnb fase 2 Junio/23/2016
         Me.lbl_registros.Caption = (Me.grdAlterno.Rows - 1)
      End If
      
   Else
      PMLimpiaGrid Me.grdAlterno
   End If
End Sub
'msilvag Fin

Sub PLBuscarCNELFile(orden As Long) 'DAPV/03222012/CNEL

   'Hago la consulta de los primeros 15 resultados
   PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, "43296"
   PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT4, Trim(txt_empresa.text)
   PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, orden
   PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
   PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, Me.cmdEstadoBco.text
   PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, Me.cmbEstadoEmp.text
   PMPasoValores SqlConn&, "@o_grupo", 1, SQLVARCHAR, "N"
   
   If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_cnel_e", True, "Ok... Consulta de Pagos Cbel") Then
      
      If orden = 0 Then
         PgMapeaFlexG grdAlterno, True, False, 0, 15, 24
      Else
         PgMapeaFlexG grdAlterno, False, False, 0, 15, 24
      End If
      
      PMChequea SqlConn&
      vlGrupo = FMRetParam(SqlConn&, 1)
      If Me.grdAlterno.Tag = "15" Then
         Me.grdAlterno.Col = 23
         Me.grdAlterno.Row = Me.grdAlterno.Rows - 1
         PLBuscarCNELFile (Me.grdAlterno.text)
      Else
         'Elimino la Columna donde traje los secueciales para la busqueda
         'Me.grdConci.Cols = 11
         Me.lbl_registros.Caption = (Me.grdAlterno.Rows - 1)
         'Formato al Grid
         'Me.grdConci.ColWidth(1) = 1000  'Codigo
         'Me.grdConci.ColWidth(2) = 2445  'Nombre Abonado
         'Me.grdConci.ColWidth(3) = 1100  'Valor
         'Me.grdConci.ColWidth(4) = 1100  'Fecha Cont.
         'Me.grdConci.ColWidth(5) = 750   'Hora
         'Me.grdConci.ColWidth(6) = 1300  'Resultado
         'Me.grdConci.ColWidth(7) = 1100  'Status Bco
         'Me.grdConci.ColWidth(8) = 1100  'Status Emp
         'Me.grdConci.ColWidth(9) = 1000  'Usuario
         'Me.grdConci.ColWidth(10) = 1100 'N° Autorizacion
         'Me.grdConci.ColWidth(11) = 1100 'Secuencial
         'Me.grdConci.ColWidth(11) = 1100 'Secuencial
         'Me.grdConci.ColWidth(12) = 1100 'Tipo Transaccion
         'Me.grdConci.ColWidth(12) = 0 'Tipo Transaccion
         'Me.grdConci.ColWidth(13) = 0  'Campo Autonumerico
         'Me.grdConci.ColWidth(14) = 1100  'Numero de Factura
         'Me.grdAlterno.ColWidth(15) = 1100  'Numero de Factura
         'Me.grdAlterno.ColWidth(19) = 1000  'Codigo de Resultado
         'Me.grdAlterno.ColWidth(20) = 1100  'Estado de Conciliacion
      End If
      
   Else
      PMLimpiaGrid Me.grdAlterno    'lfcm 21-feb-2008
   End If
End Sub

Sub PLBuscarSENAEFile(orden As Long) 'smerinom 10/02/2012

   'Hago la consulta de los primeros 15 resultados
   PMPasoValores SqlConn&, "@t_trn", 0, SQLINT4, "43371"   ' "43296"
   PMPasoValores SqlConn&, "@i_empresa", 0, SQLINT4, Trim(txt_empresa.text)
   PMPasoValores SqlConn&, "@i_siguiente", 0, SQLINT4, orden
   PMPasoValores SqlConn&, "@i_fecha", 0, SQLDATETIME, (dtFecha)
   PMPasoValores SqlConn&, "@i_estado_bco", 0, SQLVARCHAR, Me.cmdEstadoBco.text
   PMPasoValores SqlConn&, "@i_estado_emp", 0, SQLVARCHAR, Me.cmbEstadoEmp.text
   PMPasoValores SqlConn, "@o_num_int", 1, SQLINT4, ""  'SMERINO NOMA ISO
   PMPasoValores SqlConn, "@o_total", 1, SQLMONEY, ""
     

   If FMTransmitirRPC(SqlConn&, ServerName$, "cob_pagos", "sp_concilia_senae_e", True, "Ok... Consulta de Pagos SENAE") Then
      
      If orden = 0 Then
         PgMapeaFlexG grdAlterno, True, False, 0, 15, 22  '24
         
      Else
         PgMapeaFlexG grdAlterno, False, False, 0, 15, 22 '24
      End If
      
       vlcantidad = FMRetParam(SqlConn, 1)
       VLTOTAL = FMRetParam(SqlConn, 2)
       VlongArch = 56 + (160 * vlcantidad)
        
      PMChequea SqlConn&
      vlGrupo = FMRetParam(SqlConn&, 1)
      
      If Me.grdAlterno.Tag = "15" Then
         Me.grdAlterno.Col = 21  'antes era 23 cod del secuencialAHORA ES 21
         Me.grdAlterno.Row = Me.grdAlterno.Rows - 1
         PLBuscarSENAEFile (Me.grdAlterno.text)
        
      Else
         'Elimino la Columna donde traje los secueciales para la busqueda
         'Me.grdConci.Cols = 11
          Me.lbl_registros.Caption = (Me.grdAlterno.Rows - 1)

      End If
      
   Else
      PMLimpiaGrid Me.grdAlterno    'lfcm 21-feb-2008
   End If
End Sub
Sub ValidaEmpresaDepositoTemporal()
FPrincipal.Map.PMMapConfig "SHOWMESSAGE"
    PMPasoValores SqlConn&, "@i_tabla", 0, SQLCHAR, "sv_inst_dep_temporal"
    PMPasoValores SqlConn&, "@i_tipo", 0, SQLCHAR, "V"
    PMPasoValores SqlConn&, "@i_codigo", 0, SQLVARCHAR, Trim(txt_empresa.text)
    If FMTransmitirRPC(SqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Valida Empresa " & "[" & txt_empresa.text & "]") Then
        VlExiste_Dep = "S"
    Else
        VlExiste_Dep = "N"
    End If
    PMChequea SqlConn&
FMInitMap FPrincipal!pnlHelpLine, FPrincipal!pnlTransaccionLine, FPrincipal!Focos(0), FPrincipal!Focos(1), FPrincipal!Focos(2), FPrincipal!Focos(3), VGLogTransacciones$
End Sub
