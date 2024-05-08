VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "GRID32.OCX"
Object = "{0F1F1508-C40A-101B-AD04-00AA00575482}#1.0#0"; "mhrinp32.ocx"
Begin VB.Form FCC19_grid2 
   Caption         =   "MUNICIPIOS - 19 - TITULOS PENDIENTES"
   ClientHeight    =   2985
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6945
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2985
   ScaleWidth      =   6945
   Begin VB.TextBox txtciudadretiro 
      Height          =   285
      Left            =   4320
      TabIndex        =   13
      Top             =   360
      Visible         =   0   'False
      Width           =   2535
   End
   Begin VB.TextBox txtoficinaretiro 
      Height          =   285
      Left            =   4320
      TabIndex        =   12
      Top             =   0
      Visible         =   0   'False
      Width           =   2535
   End
   Begin MSGrid.Grid grdDetalle 
      Height          =   2415
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6900
      _Version        =   65536
      _ExtentX        =   12171
      _ExtentY        =   4260
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
   Begin VB.PictureBox pic_escoge 
      AutoSize        =   -1  'True
      BorderStyle     =   0  'None
      Height          =   165
      Left            =   7500
      Picture         =   "FCC19_grid2.frx":0000
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   5
      Top             =   1200
      Visible         =   0   'False
      Width           =   165
   End
   Begin VB.CommandButton cmdAceptar 
      Caption         =   "&Aceptar"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   4560
      TabIndex        =   1
      Top             =   2520
      Width           =   1095
   End
   Begin VB.CommandButton cmdSalir 
      Cancel          =   -1  'True
      Caption         =   "&Cancelar"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5760
      TabIndex        =   2
      Top             =   2520
      Width           =   1095
   End
   Begin MhinrelLib.MhRealInput Acumulador 
      Height          =   285
      Left            =   960
      TabIndex        =   4
      ToolTipText     =   "Valor Total de la Transacción"
      Top             =   2520
      Width           =   1035
      _Version        =   65536
      _ExtentX        =   1826
      _ExtentY        =   503
      _StockProps     =   77
      BackColor       =   12632256
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
   Begin VB.TextBox txtContribuyente 
      Height          =   285
      Left            =   1320
      Locked          =   -1  'True
      TabIndex        =   8
      Top             =   280
      Visible         =   0   'False
      Width           =   4335
   End
   Begin VB.TextBox txtCedula 
      Height          =   285
      Left            =   1320
      Locked          =   -1  'True
      TabIndex        =   9
      Top             =   0
      Visible         =   0   'False
      Width           =   2655
   End
   Begin MhinrelLib.MhRealInput Total 
      Height          =   285
      Left            =   3000
      TabIndex        =   10
      ToolTipText     =   "Valor Total de la Transacción"
      Top             =   2520
      Visible         =   0   'False
      Width           =   1035
      _Version        =   65536
      _ExtentX        =   1826
      _ExtentY        =   503
      _StockProps     =   77
      BackColor       =   12632256
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
   Begin VB.Label lblTotal 
      AutoSize        =   -1  'True
      Caption         =   "TOTAL->"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   2160
      TabIndex        =   11
      Top             =   2520
      Visible         =   0   'False
      Width           =   780
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      Caption         =   "Contribuyente"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   0
      TabIndex        =   7
      Top             =   280
      Visible         =   0   'False
      Width           =   1185
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "Cedula / Ruc"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   0
      TabIndex        =   6
      Top             =   0
      Visible         =   0   'False
      Width           =   1155
   End
   Begin VB.Label Label1 
      Caption         =   "Monto a pagar"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   120
      TabIndex        =   3
      Top             =   2520
      Width           =   855
   End
End
Attribute VB_Name = "FCC19_grid2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Public VLTrama As String
Dim VLArregloEspecial
Dim VLFlagMarca As Boolean
Dim VLFilaSeleccionada As Integer
Public VLCodMunicipio As String  'hy-14-agosto-2006
Public VLIdentificacion As String  'hy-14-agosto-2006
Public VLContribuyente As String  'hy-14-agosto-2006
Dim VLColumnaMonto As Integer    'hy-14-agosto-2006
Public VLTipoimp As String        'ame 07/08/2010

Private Sub cmdAceptar_Click()
    'GAMC - 17/03/2008 - Municipio de Salinas - INI
    'If FCC19.municipio.Text = "2237" Then
    'If FCC19.municipio.Text = "2237" Or FCC19.municipio.Text = "2235" Then 'GAMC - 14/04/2008 - Municipio de Santa Elena
    'nchavezb 04/08/2011 Municipio Daule 1430
    'lcepeda 25/11/2022 Municipio Daule 1430 RECMPS-1892 OFICINA DE ENTREGA EN VENTANILLA - MUNICIPIO DE DAULE
    If FCC19.municipio.Text = "2237" Or FCC19.municipio.Text = "2235" Or FCC19.municipio.Text = "2236" Then  'Wise - 13/Agt/2008 - Municipio de Libertad --'25/11/2022-lcepeda -se omite el municipio de daule /*Or FCC19.municipio.Text = "1430"*/
        txtoficinaretiro.Text = ""
        Muni_2237 "2"
        If txtoficinaretiro.Text <> "" Then
            If CCur(Acumulador.Text) > 0 Then
                FCC19.txtPapeletaSamb.Text = Me.txtoficinaretiro.Text
                Unload Me
                Exit Sub
            End If
            MsgBox "El valor a cancelar no puede ser cero", vbInformation, "Aviso"
        Else
            MsgBox "Seleccionar la Oficina de Retiro del Título", vbInformation, "Aviso"
        End If
    Else
        'GAMC - 17/03/2008 - Este es el codigo antiguo
        If CCur(Acumulador.Text) > 0 Then
            'msilvag Inicio Migracion WebService
            If FCC19.municipio.Text = "7749" And FCC19.Tipo.Text = "001" Then
                'grdDetalleML.Col = 1
                Me.grdDetalle.Col = 1
                FCC19.Agno = Me.grdDetalle.Text
            End If
            'msilvag Fin
            Unload Me
            Exit Sub
        End If
        MsgBox "El valor a cancelar no puede ser cero", vbInformation, "Aviso"
    End If
    'GAMC - 17/03/2008 - Municipio de Salinas - FIN
End Sub


    
Private Sub cmdSalir_Click()
    Acumulador.Text = "0.00"
    Unload Me
End Sub

'-->hy-22-febrero-2007
Private Sub Form_Activate()
    If VLCodMunicipio = "1800" Then
        grdDetalle.Cols = 5  'ame 07/07/2010
    End If
    '-->hy-05-noviembre-2007
    If VLCodMunicipio = "2234" Then
        PLCalculaTotal
    End If
    '<--hy-05-noviembre-2007
    'GAMC - 23/02/2008 - INI
    'If VLCodMunicipio = "2319" Then
    'If VLCodMunicipio = "2319" Or VLCodMunicipio = "2237" Then 'GAMC - 05/03/2008
    'If VLCodMunicipio = "2319" Or VLCodMunicipio = "2237" Or VLCodMunicipio = "2235" Then 'GAMC - 14/04/2008
    'Or VLCodMunicipio = "1430" nchavezb 04/Agosto/2011 Municipio Daule
    If VLCodMunicipio = "2319" Or VLCodMunicipio = "2237" Or VLCodMunicipio = "2235" Or VLCodMunicipio = "2236" Or VLCodMunicipio = "1430" Then 'Wise Agreago Munc. Libertad=2236 - 13/Agt/2008
        PLCalculaTotal
    End If
    'GAMC - 23/02/2008 - FIN
End Sub
'<--hy-22-febrero-2007

Public Sub Muni_2319(Opcion As String)
    'GAMC - 23/02/2008 - Emision incial
    Select Case Opcion
        Case "1"
            Me.txtoficinaretiro.Text = ""   'GAMC - 17/03/2008
            Label2.Visible = True
            Label2.Caption = "Cod. Predial"
            Label3.Visible = True
            txtCedula.Visible = True
            txtContribuyente.Visible = True
            lblTotal.Visible = True
            Total.Visible = True
            txtCedula.Text = Trim$(VLIdentificacion)
            txtContribuyente = Trim$(VLContribuyente)
            grdDetalle.Top = 650
            grdDetalle.Height = grdDetalle.Height - 650
            grdDetalle.Cols = 8
            grdDetalle.ColWidth(1) = 1500
            grdDetalle.ColWidth(2) = 500
            grdDetalle.ColWidth(3) = 500
            grdDetalle.ColWidth(4) = 500
            grdDetalle.ColWidth(5) = 1000
            grdDetalle.ColWidth(6) = 1000
            grdDetalle.ColWidth(7) = 1000
            grdDetalle.ColAlignment(1) = 0
            grdDetalle.ColAlignment(2) = 0
            grdDetalle.ColAlignment(3) = 0
            grdDetalle.ColAlignment(4) = 0
            grdDetalle.ColAlignment(5) = 0
            grdDetalle.ColAlignment(6) = 1
            
            grdDetalle.Row = 0
            grdDetalle.Col = 1
            grdDetalle.Text = "AÑO"
            grdDetalle.Col = 2
            grdDetalle.Text = "PRD. PAGO"
            grdDetalle.Col = 3
            grdDetalle.Text = "SEM/DDIV"
            grdDetalle.Col = 4
            grdDetalle.Text = "COD. TPO. IMP."
            grdDetalle.Col = 5
            grdDetalle.Text = "TIPO IMPUESTO"
            grdDetalle.Col = 6
            grdDetalle.Text = "MONTO"
            VLColumnaMonto = 6
        Case "2"
            'GAMC - 17/03/2008 - Municipio de Salinas - Seleccion de Oficina de retiro del Titulo
            PMPasoValores VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "cl_oficinas_tsalinas"
            PMPasoValores VGSqlConn&, "@i_tipo", 0, SQLCHAR, "A"
            If FMTransmitirRPC(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Oficina de Retiro - Municipio de Salinas") Then
               PMMapeaListaH VGSqlConn&, FCatalogo!lstValores, False
               PMChequea VGSqlConn&
               FCatalogo.Show 1
               If VGCodigoCatalogo$ <> "" Then
                txtoficinaretiro.Text = "(" & VGCodigoCatalogo$ & ")"
                txtoficinaretiro.Text = txtoficinaretiro.Text & VGDescripcionCatalogo$
               End If
            End If
    End Select
    
End Sub

Public Sub Muni_2237(Opcion As String)
    'GAMC - 18/03/2008 - Emision incial - Municipio de Salinas
    Select Case Opcion
        Case "1"
            Me.txtoficinaretiro.Text = ""
            Label2.Visible = True
            Label2.Caption = "Clave Catastral"
            Label3.Visible = True
            txtCedula.Visible = True
            txtContribuyente.Visible = True
            lblTotal.Visible = True
            Total.Visible = True
            txtCedula.Text = Trim$(VLIdentificacion)
            txtContribuyente = Trim$(VLContribuyente)
            grdDetalle.Top = 650
            grdDetalle.Height = grdDetalle.Height - 650
            grdDetalle.Cols = 8
            grdDetalle.ColWidth(1) = 800
            grdDetalle.ColWidth(2) = 500
            grdDetalle.ColWidth(3) = 1300
            grdDetalle.ColWidth(4) = 2000
            grdDetalle.ColWidth(5) = 500
            grdDetalle.ColWidth(6) = 1000
            'grdDetalle.ColWidth(7) = 1000
            grdDetalle.ColAlignment(1) = 0
            grdDetalle.ColAlignment(2) = 0
            grdDetalle.ColAlignment(3) = 0
            grdDetalle.ColAlignment(4) = 0
            grdDetalle.ColAlignment(5) = 0
            grdDetalle.ColAlignment(6) = 1
                        
            grdDetalle.Row = 0
            grdDetalle.Col = 1
            grdDetalle.Text = "AÑO"
            grdDetalle.Col = 2
            grdDetalle.Text = "PRD. PAGO"
            grdDetalle.Col = 3
            grdDetalle.Text = "COD. TPO. IMP."
            grdDetalle.Col = 4
            grdDetalle.Text = "TIPO IMPUESTO"
            grdDetalle.Col = 5
            grdDetalle.Text = "SEM-DIV"
            grdDetalle.Col = 6
            grdDetalle.Text = "MONTO"
            VLColumnaMonto = 6
        Case "2"
            PMPasoValores VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "cl_oficinas_tsalinas"
            PMPasoValores VGSqlConn&, "@i_tipo", 0, SQLCHAR, "A"
            If VLCodMunicipio <> "1430" Then 'lcepeda
                If FMTransmitirRPC(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Oficina de Retiro - Municipio de Salinas") Then
                   PMMapeaListaH VGSqlConn&, FCatalogo!lstValores, False
                   PMChequea VGSqlConn&
                   FCatalogo.Show 1
                   If VGCodigoCatalogo$ <> "" Then
                    txtoficinaretiro.Text = VGCodigoCatalogo$
                    txtciudadretiro.Text = VGDescripcionCatalogo$
                    
                    PMPasoValores VGSqlConn, "@t_trn", 0, SQLINT4, "3215"
                    PMPasoValores VGSqlConn, "@i_opcion", 0, SQLCHAR, "X"
                    PMPasoValores VGSqlConn, "@i_municipio", 0, SQLINT4, val(VLCodMunicipio)
                    PMPasoValores VGSqlConn, "@i_ofiretiro", 0, SQLVARCHAR, VGCodigoCatalogo$
                    PMPasoValores VGSqlConn, "@o_direccion", 1, SQLVARCHAR, Space(30)
                                   
                    If FMTransmitirRPC(VGSqlConn&, ServerName$, "cob_pagos", "sp_tr_municipio_recaudacion", True, " Oficina de Retiro - Municipio de Salinas") Then
                        txtciudadretiro.Text = txtciudadretiro.Text & " - " & FMRetParam(VGSqlConn&, 1)
                        FCC19.VLOficinaRetiro = txtciudadretiro.Text
                        PMChequea VGSqlConn&
                    End If
                    Else
                        MsgBox "No se puede obtener la ciudad", vbExclamation, App.Title
                   End If
                End If
            End If
    End Select
    
End Sub

Public Sub Muni_1430(Opcion As String)
    
    Select Case Opcion
        Case "1"
            Me.txtoficinaretiro.Text = ""
            Label2.Visible = True
            Label2.Caption = "Codigo Predio"
            Label3.Visible = True
            txtCedula.Visible = True
            txtContribuyente.Visible = True
            lblTotal.Visible = True
            Total.Visible = True
            txtCedula.Text = Trim$(VLIdentificacion)
            txtContribuyente = Trim$(VLContribuyente)
            grdDetalle.Top = 650
            grdDetalle.Height = grdDetalle.Height - 650
            grdDetalle.Cols = 8
            grdDetalle.ColWidth(1) = 800
            grdDetalle.ColWidth(2) = 500
            grdDetalle.ColWidth(3) = 1300
            grdDetalle.ColWidth(4) = 2000
            grdDetalle.ColWidth(5) = 500
            grdDetalle.ColWidth(6) = 1000
            'grdDetalle.ColWidth(7) = 1000
            grdDetalle.ColAlignment(1) = 0
            grdDetalle.ColAlignment(2) = 0
            grdDetalle.ColAlignment(3) = 0
            grdDetalle.ColAlignment(4) = 0
            grdDetalle.ColAlignment(5) = 0
            grdDetalle.ColAlignment(6) = 1
                        
            grdDetalle.Row = 0
            grdDetalle.Col = 1
            grdDetalle.Text = "AÑO"
            grdDetalle.Col = 2
            grdDetalle.Text = "PRD. PAGO"
            grdDetalle.Col = 3
            grdDetalle.Text = "COD. TPO. IMP."
            grdDetalle.Col = 4
            grdDetalle.Text = "TIPO IMPUESTO"
            grdDetalle.Col = 5
            grdDetalle.Text = "MONTO"
            VLColumnaMonto = 5
        Case "2"
            PMPasoValores VGSqlConn&, "@i_tabla", 0, SQLVARCHAR, "cl_oficinas_tsalinas"
            PMPasoValores VGSqlConn&, "@i_tipo", 0, SQLCHAR, "A"
            If FMTransmitirRPC(VGSqlConn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Oficina de Retiro - Municipio de Salinas") Then
               PMMapeaListaH VGSqlConn&, FCatalogo!lstValores, False
               PMChequea VGSqlConn&
               FCatalogo.Show 1
               If VGCodigoCatalogo$ <> "" Then
                txtoficinaretiro.Text = VGCodigoCatalogo$
                txtciudadretiro.Text = VGDescripcionCatalogo$
                
                PMPasoValores VGSqlConn, "@t_trn", 0, SQLINT4, "3215"
                PMPasoValores VGSqlConn, "@i_opcion", 0, SQLCHAR, "X"
                PMPasoValores VGSqlConn, "@i_municipio", 0, SQLINT4, val(VLCodMunicipio)
                PMPasoValores VGSqlConn, "@i_ofiretiro", 0, SQLVARCHAR, VGCodigoCatalogo$
                PMPasoValores VGSqlConn, "@o_direccion", 1, SQLVARCHAR, Space(30)
                               
                If FMTransmitirRPC(VGSqlConn&, ServerName$, "cob_pagos", "sp_tr_municipio_recaudacion", True, " Oficina de Retiro - Municipio de Salinas") Then
                    txtciudadretiro.Text = txtciudadretiro.Text & " - " & FMRetParam(VGSqlConn&, 1)
                    FCC19.VLOficinaRetiro = txtciudadretiro.Text
                    PMChequea VGSqlConn&
                End If
                Else
                    MsgBox "No se puede obtener la ciudad", vbExclamation, App.Title
               End If
            End If
    End Select
    
End Sub


Private Sub Form_Load()
    Me.Top = 1100
    Me.Left = 4000
    Select Case VLCodMunicipio
    'Case "2319" 'GAMC - 23/02/2008
    Case "2319", "2236" 'Wise M. Libertad=2236 - 18/02/2008
        Muni_2319 ("1")
    'Case "2237" 'GAMC - 18/03/2008
    ' Case "2237", "2235"
    Case "2237", "2235" 'GAMC - 14/04/2008 - Municipio de Santa Elena
        Muni_2237 ("1")
    Case "1430" 'nchavezb 04/08/2011 Aumentar 1430 Mun. Daule
        Muni_1430 ("1")
    Case "1433"
        Label2.Caption = "Cedula / Ruc" 'GAMC - 23/02/2008
        grdDetalle.Cols = 4 '4
        grdDetalle.ColWidth(1) = 800
        grdDetalle.ColWidth(2) = 800
        grdDetalle.ColWidth(3) = 1500
        grdDetalle.ColAlignment(1) = 2
        grdDetalle.ColAlignment(2) = 2
        grdDetalle.ColAlignment(3) = 1
        grdDetalle.Row = 0
        grdDetalle.Col = 1
        grdDetalle.Text = "AÑO"
        grdDetalle.Col = 2
        grdDetalle.Text = "SEM/DIV"
        grdDetalle.Col = 3
        grdDetalle.Text = "MONTO"
        VLColumnaMonto = 3
    Case "1417"
        Label2.Caption = "Cedula / Ruc" 'GAMC - 23/02/2008
        Label2.Visible = True
        Label3.Visible = True
        txtCedula.Visible = True
        txtContribuyente.Visible = True
        txtCedula.Text = Trim$(VLIdentificacion)
        txtContribuyente = Trim$(VLContribuyente)
        grdDetalle.Top = 650
        grdDetalle.Height = grdDetalle.Height - 650
        grdDetalle.Cols = 6
        grdDetalle.ColWidth(1) = 400
        grdDetalle.ColWidth(2) = 2100
        grdDetalle.ColWidth(3) = 450
        grdDetalle.ColWidth(4) = 650
        grdDetalle.ColWidth(5) = 1
        grdDetalle.ColAlignment(1) = 0
        grdDetalle.ColAlignment(2) = 0
        grdDetalle.ColAlignment(3) = 0
        grdDetalle.ColAlignment(4) = 1
        grdDetalle.Row = 0
        grdDetalle.Col = 1
        grdDetalle.Text = "COD"
        grdDetalle.Col = 2
        grdDetalle.Text = "IMPTO"
        grdDetalle.Col = 3
        grdDetalle.Text = "AÑO"
        grdDetalle.Col = 4
        grdDetalle.Text = "MONTO"
        VLColumnaMonto = 4
    '-->hy-22-febrero-2007
    Case "1800"
        Label2.Caption = "Cedula / Ruc" 'GAMC - 23/02/2008
        Label2.Visible = True
        Label3.Visible = True
        txtCedula.Visible = True
        txtContribuyente.Visible = True
        txtCedula.Text = Trim$(VLIdentificacion)
        txtContribuyente = Trim$(VLContribuyente)
        grdDetalle.Top = 650
        grdDetalle.Height = grdDetalle.Height - 650
        grdDetalle.Cols = 5  'ame 07/07/2010
        grdDetalle.ColWidth(1) = 400
        grdDetalle.ColWidth(2) = 2100
        grdDetalle.ColWidth(3) = 2100 'ame 07/07/2010
        grdDetalle.ColWidth(4) = 1 'ame 07/07/2010
        grdDetalle.ColAlignment(1) = 0
        grdDetalle.ColAlignment(2) = 0
        grdDetalle.ColAlignment(3) = 0
        grdDetalle.Row = 0
        grdDetalle.Col = 1
        If VLTipoimp = "002" Then
           grdDetalle.Text = "#DIV"
        Else
           grdDetalle.Text = "AÑO"
        End If
        grdDetalle.Col = 2
        grdDetalle.Text = "IMPUESTO"  'ame 07/07/2010
        grdDetalle.Col = 3
        grdDetalle.Text = "VALOR"  'ame 07/07/2010
        VLColumnaMonto = 3
    '<--hy-22-febrero-2007
    '-->hy-05-noviembre-2007
    Case "2234"
        Label2.Caption = "Cedula / Ruc" 'GAMC - 23/02/2008
        Label2.Visible = True
        Label3.Visible = True
        txtCedula.Visible = True
        txtContribuyente.Visible = True
        txtCedula.Text = Trim$(VLIdentificacion)
        txtContribuyente = Trim$(VLContribuyente)
        lblTotal.Visible = True
        Total.Visible = True
        grdDetalle.Top = 650
        grdDetalle.Height = grdDetalle.Height - 650
        grdDetalle.Cols = 12
        grdDetalle.ColWidth(1) = 400
        grdDetalle.ColWidth(2) = 400
        grdDetalle.ColWidth(3) = 400
        grdDetalle.ColWidth(4) = 1800
        grdDetalle.ColWidth(5) = 1200
        grdDetalle.ColWidth(6) = 1500
        grdDetalle.ColWidth(7) = 600
        grdDetalle.ColWidth(8) = 1
        grdDetalle.ColWidth(9) = 1
        grdDetalle.ColWidth(10) = 1
        grdDetalle.ColWidth(11) = 1
        grdDetalle.ColAlignment(1) = 0
        grdDetalle.ColAlignment(2) = 0
        grdDetalle.ColAlignment(3) = 0
        grdDetalle.ColAlignment(4) = 1
        grdDetalle.Row = 0
        grdDetalle.Col = 1
        grdDetalle.Text = "AÑO"
        grdDetalle.Col = 2
        grdDetalle.Text = "SEC"
        grdDetalle.Col = 3
        grdDetalle.Text = "CIMP"
        grdDetalle.Col = 4
        grdDetalle.Text = "IMPTO"
        grdDetalle.Col = 5
        grdDetalle.Text = "PREDIO"
        grdDetalle.Col = 6
        grdDetalle.Text = "DIRECCION"
        grdDetalle.Col = 7
        grdDetalle.Text = "TOTAL"
        grdDetalle.Col = 8
        grdDetalle.Text = "VALOR"
        grdDetalle.Col = 9
        grdDetalle.Text = "OTROS"
        grdDetalle.Col = 10
        grdDetalle.Text = "PRIORIDAD"
        grdDetalle.Col = 11
        grdDetalle.Text = "FECVEN"
        VLColumnaMonto = 7
    '<--hy-05-noviembre-2007
    'msilvag Inicio Migracion WebService
    Case "7749"
        Label2.Caption = "Cedula / Ruc" 'GAMC - 23/02/2008
        grdDetalle.Cols = 4 '4
        grdDetalle.ColWidth(1) = 800
        grdDetalle.ColWidth(2) = 800
        grdDetalle.ColWidth(3) = 1500
        grdDetalle.ColAlignment(1) = 2
        grdDetalle.ColAlignment(2) = 2
        grdDetalle.ColAlignment(3) = 1
        grdDetalle.Row = 0
        grdDetalle.Col = 1
        grdDetalle.Text = "AÑO"
        grdDetalle.Col = 2
        grdDetalle.Text = "SEM/DIV"
        grdDetalle.Col = 3
        grdDetalle.Text = "MONTO"
        VLColumnaMonto = 3
    'msilvag Fin
    
    End Select
    VLFlagMarca = False
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FCC19.ValorMun.Text = CCur(Acumulador.Text)
    If Not VLFlagMarca Then
        Exit Sub
    End If
    grdDetalle.Row = VLFilaSeleccionada
    Select Case VLCodMunicipio
    Case "1433"
        grdDetalle.Col = 1
        FCC19.Agno = Trim$(grdDetalle.Text)
        grdDetalle.Col = 2
        FCC19.Semestre = Trim$(grdDetalle.Text)
    Case "1417"
        grdDetalle.Col = 3
        FCC19.Agno = Trim$(grdDetalle.Text)
        grdDetalle.Col = 1
        FCC19.Impto = Trim$(grdDetalle.Text)
        grdDetalle.Col = 2
        FCC19.Impto.Tag = Trim$(grdDetalle.Text)
        grdDetalle.Col = 5
        FCC19.Agno.Tag = Trim$(grdDetalle.Text)
        FCC19.ValImpto = "0"
        FCC19.ValInteres = "0"
    '-->hy-22-febrero-2007
    Case "1800"
        grdDetalle.Col = 1
        FCC19.Agno = Trim$(grdDetalle.Text)
        grdDetalle.Col = 2  'ame 07/07/2010
        FCC19.descripcion = Trim$(grdDetalle.Text)
        FCC19.VLRubro = Trim$(grdDetalle.Text)
        grdDetalle.Col = 4  'ame 07/07/2010
        FCC19.VLItemSeleccionado = Trim$(grdDetalle.Text)
        FCC19.Contribuyente.Caption = txtContribuyente.Text
    '<--hy-22-febrero-2007
    '-->hy-05-noviembre-2007
    Case "2234"
        grdDetalle.Col = 1
        FCC19.Agno = Trim$(grdDetalle.Text)
        grdDetalle.Col = 2
        FCC19.Semestre = Trim$(grdDetalle.Text)
        grdDetalle.Col = 3
        FCC19.Impto = Trim$(grdDetalle.Text)
        grdDetalle.Col = 4
        FCC19.Impto.Tag = Trim$(grdDetalle.Text)
        grdDetalle.Col = 10
        FCC19.Prioridad = Trim$(grdDetalle.Text)
        grdDetalle.Col = 5
        FCC19.Predio = Trim$(grdDetalle.Text)
        grdDetalle.Col = 6
        FCC19.direccion = Trim$(grdDetalle.Text)
        FCC19.Contribuyente.Caption = txtContribuyente.Text
        grdDetalle.Col = 8
        FCC19.VLGridImpuestos = Trim$(grdDetalle.Text)
        grdDetalle.Col = 9
        FCC19.VLGridDescuentos = Trim$(grdDetalle.Text)
        grdDetalle.Col = 11
        FCC19.VLGridFecVen = Trim$(grdDetalle.Text)
        FCC19.VLRemoverFila = grdDetalle.Row
    '<--hy-05-noviembre-2007
    'Case "2319" 'GAMC - 23/02/2008 - MUNICIPIO DE SAMBORONDON
    Case "2319"
        grdDetalle.Col = 1
        FCC19.Agno = Trim$(grdDetalle.Text)
        grdDetalle.Col = 3
        FCC19.Semestre = Trim$(grdDetalle.Text)
        grdDetalle.Col = 4
        FCC19.Impto = Trim$(grdDetalle.Text)
        grdDetalle.Col = 5
        FCC19.Impto.Tag = Trim$(grdDetalle.Text)
        grdDetalle.Col = 2
        FCC19.Prioridad = Trim$(grdDetalle.Text)
        'grdDetalle.Col = 5
        'FCC19.Predio = Trim$(grdDetalle.Text)
        'grdDetalle.Col = 6
        'FCC19.direccion = Trim$(grdDetalle.Text)
        FCC19.Contribuyente.Caption = txtContribuyente.Text
        'grdDetalle.Col = 8
        'FCC19.VLGridImpuestos = Trim$(grdDetalle.Text)
        'grdDetalle.Col = 9
        'FCC19.VLGridDescuentos = Trim$(grdDetalle.Text)
        'grdDetalle.Col = 11
        'FCC19.VLGridFecVen = Trim$(grdDetalle.Text)
        FCC19.VLRemoverFila = grdDetalle.Row
    'Case "2237" 'GAMC - 18/03/2008 - Municipios de Salinas
    'Case "2237", "2235" 'GAMC - 14/04/2008 - Municipio de Santa Elena
    
    Case "2237", "2235", "2236"   'Wise - 14/Agt/2008 - Municipio de Libartad=2236
        grdDetalle.Col = 1
        FCC19.Agno = Trim$(grdDetalle.Text)
        grdDetalle.Col = 3
        FCC19.Impto = Trim$(grdDetalle.Text)
        grdDetalle.Col = 4
        FCC19.Impto.Tag = Trim$(grdDetalle.Text)
        grdDetalle.Col = 2
        FCC19.Prioridad = Trim$(grdDetalle.Text)
        grdDetalle.Col = 5
        FCC19.Semestre = Trim$(grdDetalle.Text)
        'grdDetalle.Col = 5
        'FCC19.Predio = Trim$(grdDetalle.Text)
        'grdDetalle.Col = 6
        'FCC19.direccion = Trim$(grdDetalle.Text)
        FCC19.Contribuyente.Caption = txtContribuyente.Text
        'grdDetalle.Col = 8
        'FCC19.VLGridImpuestos = Trim$(grdDetalle.Text)
        'grdDetalle.Col = 9
        'FCC19.VLGridDescuentos = Trim$(grdDetalle.Text)
        'grdDetalle.Col = 11
        'FCC19.VLGridFecVen = Trim$(grdDetalle.Text)
        FCC19.VLRemoverFila = grdDetalle.Row
    'nchavezb 04/Agosto/2011 Municipio Daule 1430
    Case "1430"
        grdDetalle.Col = 1
        FCC19.Agno = Trim$(grdDetalle.Text)
        grdDetalle.Col = 3
        FCC19.Impto = Trim$(grdDetalle.Text)
        grdDetalle.Col = 4
        FCC19.Impto.Tag = Trim$(grdDetalle.Text)
        'GrdDetalle.Col = 6
        'FCC19.cat1.Text = Trim$(GrdDetalle.Text)
        FCC19.Contribuyente.Caption = txtContribuyente.Text
        
        
    End Select
End Sub

Private Sub grdDetalle_DblClick()
    PLMarcar
End Sub

Private Sub grdDetalle_KeyPress(KeyAscii As Integer)
    If KeyAscii% = 13 Then
        PLMarcar
    End If
End Sub

Private Sub PLMarcar()
On Error GoTo Etiqueta_Error
    Dim VLPos As Integer
    Dim VLFila As Integer
    Dim VLColumna As Integer
    Dim VLImp1 As String
    Dim VLImp2 As String
    
    VLFila = grdDetalle.Row
    VLColumna = grdDetalle.Col
    
   If VLCodMunicipio = "1800" Then   'ame 07/07/2010
   
        If VLTipoimp = "003" And VLFila > 1 Then
            grdDetalle.Col = 2
            VLImp1 = Trim$(grdDetalle.Text)
            grdDetalle.Row = VLFila - 1
            VLImp2 = Trim$(grdDetalle.Text)
            grdDetalle.Row = VLFila
            grdDetalle.Col = VLColumna
            If VLImp1 = VLImp2 Then
               MsgBox "Debe seleccionar los registros en orden cronológico", vbInformation, "Aviso"
               Exit Sub
            End If
        End If
        
        If (VLFila <> 1 And VLTipoimp = "001") Or (VLFila <> 1 And VLFila <> 2 And VLTipoimp = "002") Then
            MsgBox "Debe seleccionar los registros en orden cronológico", vbInformation, "Aviso"
            Exit Sub
        End If
    End If

    
    If VLCodMunicipio <> "2234" And VLCodMunicipio <> "1800" Then   'hy-05-noviembre-2007 ' ame 07/07/2010
        If VLFila <> 1 Then
            MsgBox "Debe seleccionar los registros en orden cronológico", vbInformation, "Aviso"
            Exit Sub
        End If
    End If
    '-->hy-05-noviembre-2007
    'GAMC - 23/02/2008 - SE AGREGO 2319(SAMBORONDON)
    'GAMC - 05/03/2008 - SE AGREGO 2237(SALINAS)
    'GAMC - 14/04/2008 - SE AGREGO 2235(SANTA ELENA)
    'nchavezb 04/Agosto/20111 Municipio Daule 1430
    If VLCodMunicipio = "2234" Or VLCodMunicipio = "2319" Or VLCodMunicipio = "2237" Or VLCodMunicipio = "2235" Or VLCodMunicipio = "1430" Then
        If FLDeudaPenfiente() Then
            MsgBox "Debe seleccionar los registros en orden cronológico", vbInformation, "Aviso"
            Exit Sub
        End If
    End If
    '<--hy-05-noviembre-2007
    grdDetalle.Col = 1
    If Trim$(grdDetalle.Text) = "" Then
        Exit Sub
    End If
    grdDetalle.Col = 0
    If grdDetalle.Picture = "0" Then
        If Not VLFlagMarca Then
            grdDetalle.Picture = pic_escoge.Image
            VLFilaSeleccionada = grdDetalle.Row
            VLFlagMarca = True
        End If
    Else
        grdDetalle.Picture = LoadPicture("")
        VLFlagMarca = False
    End If
    PLCalculaAcumulador
    grdDetalle.Row = VLFila
    grdDetalle.Col = VLColumna
    Exit Sub
Etiqueta_Error:
    MsgBox "Debe seleccionar los registros en orden cronológico", vbInformation, "Aviso"
End Sub

Private Sub PLMarcarCasilleros()
    Dim VLFila As Integer
    For VLFila = 1 To grdDetalle.Rows - 1
        grdDetalle.Col = 0
        grdDetalle.Row = VLFila
        grdDetalle.Picture = pic_escoge.Image
    Next VLFila
    PLCalculaAcumulador
End Sub

Private Sub PLCalculaAcumulador()
    Dim VLFila As Integer
    Acumulador.Text = "0"
    VLTrama = ""
    For VLFila = 1 To grdDetalle.Rows - 1
        grdDetalle.Col = 0
        grdDetalle.Row = VLFila
        If grdDetalle.Picture <> "0" Then
            grdDetalle.Col = VLColumnaMonto  'hy-14-agosto-2006
            Acumulador.Text = CCur(Acumulador.Text) + CCur(grdDetalle.Text)
        End If
    Next VLFila
End Sub

Private Sub PLMarcarCasillerosMarcados()
    Dim VLFila As Integer
    Dim VLConteo As Integer
    Dim VLCodigo As String
    Dim VLFecha As String
    VLConteo = 0
    VLArregloEspecial = Split(VLTrama, ";")
    Do While Trim$(VLArregloEspecial(VLConteo)) <> ""
        VLCodigo = Trim$(VLArregloEspecial(VLConteo))
        VLConteo = VLConteo + 1
        VLFecha = Trim$(VLArregloEspecial(VLConteo))
        VLConteo = VLConteo + 1
        For VLFila = 1 To grdDetalle.Rows - 1
            grdDetalle.Col = 11
            grdDetalle.Row = VLFila
            If Trim$(grdDetalle.Text) = Trim$(VLCodigo) Then
                grdDetalle.Col = 2
                If Trim$(grdDetalle.Text) = Trim$(VLFecha) Then
                    grdDetalle.Col = 0
                    grdDetalle.Picture = pic_escoge.Image
                End If
            End If
        Next VLFila
    Loop
    PLCalculaAcumulador
End Sub

Private Function FLDeudaPenfiente() As Boolean
    Dim VLFecVen As String
    Dim VLFecVenFila As String
    Dim VLTipoImpto As String
    Dim VLTipoImptoOriginal As String
    Dim I As Integer
    Dim VLUbicacionOriginal As Integer
    
    If grdDetalle.Rows <= 2 Then
        Exit Function
    End If
    If grdDetalle.Row = 1 Then
        Exit Function
    End If
    
    'Buscar la fecvencimiento menor del impuesto
    VLUbicacionOriginal = grdDetalle.Row
    grdDetalle.Col = 11
    VLFecVen = Mid$(grdDetalle.Text, 7, 4) + Mid$(grdDetalle.Text, 1, 2) + Mid$(grdDetalle.Text, 4, 2)
    VLTipoImptoOriginal = Trim$(grdDetalle.Text)
    For I = 1 To grdDetalle.Rows - 1
        grdDetalle.Row = I
        grdDetalle.Col = 3
        VLTipoImpto = Trim$(grdDetalle.Text)
        grdDetalle.Col = 11
        VLFecVenFila = Mid$(grdDetalle.Text, 7, 4) + Mid$(grdDetalle.Text, 1, 2) + Mid$(grdDetalle.Text, 4, 2)
        If VLTipoImpto = VLTipoImptoOriginal Then
            If VLFecVenFila < VLFecVen Then
                VLFecVen = VLFecVenFila
            End If
        End If
    Next I
    
    'Validar el orden
    FLDeudaPenfiente = False
    For I = 1 To grdDetalle.Rows - 1
        grdDetalle.Row = I
        grdDetalle.Col = 3
        VLTipoImpto = Trim$(grdDetalle.Text)
        grdDetalle.Col = 11
        VLFecVenFila = Mid$(grdDetalle.Text, 7, 4) + Mid$(grdDetalle.Text, 1, 2) + Mid$(grdDetalle.Text, 4, 2)
        If VLTipoImpto <> VLTipoImptoOriginal Then
            If VLFecVenFila < VLFecVen Then
                FLDeudaPenfiente = True
                'Dejar el foco en la ubicacion original
                grdDetalle.Row = VLUbicacionOriginal
                Exit Function
            End If
        End If
    Next I
    
    'Dejar el foco en la ubicacion original
    grdDetalle.Row = VLUbicacionOriginal
End Function

'-->hy-05-noviembre-2007
Private Sub PLCalculaTotal()
    Dim VLFila As Integer
    Total.Text = "0"
    VLTrama = ""
    For VLFila = 1 To grdDetalle.Rows - 1
        grdDetalle.Row = VLFila
        grdDetalle.Col = VLColumnaMonto
        Total.Text = CCur(Total.Text) + CCur(grdDetalle.Text)
    Next VLFila
End Sub
'<--hy-05-noviembre-2007
Private Sub Total_AutoTerminate()

End Sub
