*&---------------------------------------------------------------------*
*& Report ZALV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZALV.
*-----Step 1: Declare variables-------------------

TYPES: BEGIN OF TY_ALVSHOW,
         VBELN TYPE VBAK-VBELN,
         ERDAT TYPE VBAK-ERDAT,
         ERNAM TYPE VBAK-ERNAM,
         KUNNR TYPE VBAK-KUNNR,
         POSNR TYPE VBAP-POSNR,
         MATNR TYPE VBAP-MATNR,
         MATKL TYPE VBAP-MATKL,
         ZMENG TYPE VBAP-ZMENG,
         ZIEME TYPE VBAP-ZIEME,
         WERKS TYPE VBAP-WERKS,
         LGORT TYPE VBAP-LGORT,
       END OF TY_ALVSHOW.

DATA: LT_ALVSHOW TYPE TABLE OF TY_ALVSHOW,
      WA_ALVSHOW TYPE TY_ALVSHOW.

*-----Step 2: Internal table definition-------------------

DATA: LT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV,       "Internal table to store field catalog
      LS_FIELDCAT TYPE SLIS_FIELDCAT_ALV WITH HEADER LINE,
      LS_LAYOUT   TYPE SLIS_LAYOUT_ALV,           "Structure for ALV layout control
      IT_EVENT    TYPE SLIS_T_EVENT,              "Internal table for events
      LS_EVENT    TYPE SLIS_ALV_EVENT.

DATA LV_COLPOS TYPE I.
DATA: g_repid   TYPE sy-repid.

g_repid = sy-repid.

*-----Step 3: Read data from database-------------------

SELECT A~VBELN A~ERDAT A~ERNAM KUNNR POSNR MATNR MATKL ZMENG ZIEME WERKS LGORT
  FROM VBAK AS A INNER JOIN VBAP AS B ON A~VBELN = B~VBELN
  INTO TABLE LT_ALVSHOW UP TO 15 ROWS.

*-----Step 4: ALV grid display settings-------------*

LS_LAYOUT-ZEBRA = 'X'.
LS_LAYOUT-DETAIL_POPUP = 'X'.
LS_LAYOUT-DETAIL_TITLEBAR = 'Detailed Information'.
LS_LAYOUT-F2CODE = '&ETA'.
LS_LAYOUT-COLWIDTH_OPTIMIZE = 'X'.

"Field catalog

"Sales Document
LV_COLPOS = 1.
LS_FIELDCAT-FIELDNAME = 'VBELN'.
LS_FIELDCAT-COL_POS = LV_COLPOS.
LS_FIELDCAT-KEY = 'X'.
LS_FIELDCAT-DATATYPE = 'CHAR'.
LS_FIELDCAT-OUTPUTLEN = '10'.
LS_FIELDCAT-SELTEXT_M = 'Sales Document'.
APPEND LS_FIELDCAT TO LT_FIELDCAT.
CLEAR LS_FIELDCAT.

"Document Date
LV_COLPOS = LV_COLPOS + 1.
LS_FIELDCAT-FIELDNAME = 'ERDAT'.
LS_FIELDCAT-COL_POS = LV_COLPOS.
LS_FIELDCAT-DATATYPE = 'DATS'.
LS_FIELDCAT-OUTPUTLEN = '8'.
LS_FIELDCAT-SELTEXT_M = 'Sales Date'.
APPEND LS_FIELDCAT TO LT_FIELDCAT.
CLEAR LS_FIELDCAT.

"Creator
LV_COLPOS = LV_COLPOS + 1.
LS_FIELDCAT-FIELDNAME = 'ERNAM'.
LS_FIELDCAT-COL_POS = LV_COLPOS.
LS_FIELDCAT-DATATYPE = 'CHAR'.
LS_FIELDCAT-OUTPUTLEN = '12'.
LS_FIELDCAT-SELTEXT_M = 'Salesperson'.
APPEND LS_FIELDCAT TO LT_FIELDCAT.
CLEAR LS_FIELDCAT.

"Sold-to Party
LV_COLPOS = LV_COLPOS + 1.
LS_FIELDCAT-FIELDNAME = 'KUNNR'.
LS_FIELDCAT-COL_POS = LV_COLPOS.
LS_FIELDCAT-DATATYPE = 'CHAR'.
LS_FIELDCAT-OUTPUTLEN = '10'.
LS_FIELDCAT-SELTEXT_M = 'Sold-to Party'.
APPEND LS_FIELDCAT TO LT_FIELDCAT.
CLEAR LS_FIELDCAT.

"Item Number
LV_COLPOS = LV_COLPOS + 1.
LS_FIELDCAT-FIELDNAME = 'POSNR'.
LS_FIELDCAT-COL_POS = LV_COLPOS.
LS_FIELDCAT-DATATYPE = 'NUMC'.
LS_FIELDCAT-OUTPUTLEN = '6'.
LS_FIELDCAT-SELTEXT_M = 'Item Number'.
APPEND LS_FIELDCAT TO LT_FIELDCAT.
CLEAR LS_FIELDCAT.

"Material
LV_COLPOS = LV_COLPOS + 1.
LS_FIELDCAT-FIELDNAME = 'MATNR'.
LS_FIELDCAT-COL_POS = LV_COLPOS.
LS_FIELDCAT-DATATYPE = 'CHAR'.
LS_FIELDCAT-OUTPUTLEN = '18'.
LS_FIELDCAT-SELTEXT_M = 'Material'.
APPEND LS_FIELDCAT TO LT_FIELDCAT.
CLEAR LS_FIELDCAT.

"Material Group
LV_COLPOS = LV_COLPOS + 1.
LS_FIELDCAT-FIELDNAME = 'MATKL'.
LS_FIELDCAT-COL_POS = LV_COLPOS.
LS_FIELDCAT-DATATYPE = 'CHAR'.
LS_FIELDCAT-OUTPUTLEN = '9'.
LS_FIELDCAT-SELTEXT_M = 'Material Group'.
APPEND LS_FIELDCAT TO LT_FIELDCAT.
CLEAR LS_FIELDCAT.

"Quantity
LV_COLPOS = LV_COLPOS + 1.
LS_FIELDCAT-FIELDNAME = 'ZMENG'.
LS_FIELDCAT-COL_POS = LV_COLPOS.
LS_FIELDCAT-DATATYPE = 'QUAN'.
LS_FIELDCAT-OUTPUTLEN = '13'.
LS_FIELDCAT-SELTEXT_M = 'Sales Quantity'.
LS_FIELDCAT-DECIMALS_OUT = 3.  "Specify decimals for quantity field
LS_FIELDCAT-DO_SUM = 'X'.      "Enable sum calculation
LS_FIELDCAT-EDIT = 'X'.        "Editable field
LS_FIELDCAT-INPUT = 'X'.       "Input allowed
APPEND LS_FIELDCAT TO LT_FIELDCAT.
CLEAR LS_FIELDCAT.

"Unit
LV_COLPOS = LV_COLPOS + 1.
LS_FIELDCAT-FIELDNAME = 'ZIEME'.
LS_FIELDCAT-COL_POS = LV_COLPOS.
LS_FIELDCAT-DATATYPE = 'UNIT'.
LS_FIELDCAT-OUTPUTLEN = '3'.
LS_FIELDCAT-SELTEXT_M = 'Unit'.
APPEND LS_FIELDCAT TO LT_FIELDCAT.
CLEAR LS_FIELDCAT.

"Plant
LV_COLPOS = LV_COLPOS + 1.
LS_FIELDCAT-FIELDNAME = 'WERKS'.
LS_FIELDCAT-COL_POS = LV_COLPOS.
LS_FIELDCAT-REF_TABNAME = 'VBAP'.
APPEND LS_FIELDCAT TO LT_FIELDCAT.
CLEAR LS_FIELDCAT.

"Storage Location
LV_COLPOS = LV_COLPOS + 1.
LS_FIELDCAT-FIELDNAME = 'LGORT'.
LS_FIELDCAT-COL_POS = LV_COLPOS.
LS_FIELDCAT-REF_TABNAME = 'VBAP'.
APPEND LS_FIELDCAT TO LT_FIELDCAT.
CLEAR LS_FIELDCAT.

*-----Step 5: Define events------------

LS_EVENT-NAME = 'USER_COMMAND'.   "User command event
LS_EVENT-FORM = 'FORM_USER_COMMAND'.
APPEND LS_EVENT TO IT_EVENT.
CLEAR LS_EVENT.

LS_EVENT-NAME = 'TOP_OF_PAGE'.    "Show title event
LS_EVENT-FORM = 'FORM_TOP_OF_PAGE'.
APPEND LS_EVENT TO IT_EVENT.
CLEAR LS_EVENT.

LS_EVENT-NAME = 'PF_STATUS_SET'.  "Set GUI status event
LS_EVENT-FORM = 'FORM_PF_STATUS_SET'.
APPEND LS_EVENT TO IT_EVENT.
CLEAR LS_EVENT.

*-----Step 6: Sorting------------

WA_SORT-FIELDNAME = 'VBELN'.
WA_SORT-DOWN = 'X'.
APPEND WA_SORT TO LT_SORT.
CLEAR WA_SORT.

*-----Step 7: Display ALV grid-----*

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
  EXPORTING
    I_CALLBACK_PROGRAM          = g_repid
    I_CALLBACK_PF_STATUS_SET    = 'FORM_PF_STATUS_SET'
    I_CALLBACK_USER_COMMAND     = 'FORM_USER_COMMAND'
    I_CALLBACK_TOP_OF_PAGE      = 'FORM_TOP_OF_PAGE'
    I_GRID_SETTINGS             = LS_SETTING
    IS_LAYOUT                   = LS_LAYOUT
    IT_FIELDCAT                 = LT_FIELDCAT
    IT_SORT                     = LT_SORT
    IT_EVENTS                   = IT_EVENT
  TABLES
    T_OUTTAB                    = LT_ALVSHOW
  EXCEPTIONS
    PROGRAM_ERROR               = 1
    OTHERS                      = 2.

IF SY-SUBRC <> 0.
* Implement suitable error handling here
ENDIF.

*-----Form definitions----------

FORM FORM_USER_COMMAND USING R_UCOMM LIKE SY-UCOMM
                              RS_SELFIELD TYPE SLIS_SELFIELD.
  DATA: LT_VBAP TYPE TABLE OF VBAP WITH HEADER LINE,
        WA_VBAP TYPE VBAP.

  CASE R_UCOMM.
    WHEN 'Z
