CLASS lcl_wlist01_prog DEFINITION FOR TESTING
DURATION SHORT
RISK LEVEL HARMLESS.

  PUBLIC SECTION.
    DATA:
      cut_db_mocked    TYPE REF TO zcl_wlist01_prog_tst,
      cut_wlist_mocked TYPE REF TO zcl_wlist01_prog_tst,
      cut_vies_mocked  TYPE REF TO zcl_wlist01_prog_tst.

    DATA:
      mo_db_connector_mocked TYPE REF TO zcl_wlist01_db,
      mo_wlist_api           TYPE REF TO zcl_wlist01_api,
      mo_vies_api            TYPE REF TO zcl_wlist01_api_viese.

    METHODS:
      check_3245174504_incache FOR TESTING.

  PROTECTED SECTION.

  PRIVATE SECTION.
    METHODS:
      setup.


ENDCLASS.


CLASS lcl_wlist01_prog IMPLEMENTATION.


  METHOD setup.

    mo_db_connector_mocked = NEW zcl_wlist01_db_mock( ).
    mo_vies_api = zcl_wlist01_config=>get_api_vies( ).
    mo_wlist_api = zcl_wlist01_config=>get_api_wlist( ).

    cut_db_mocked = NEW #( i_dbhandler = mo_db_connector_mocked
                           i_vies_api = mo_vies_api
                           i_wlist_api = mo_wlist_api ).

  ENDMETHOD.

  METHOD check_3245174504_incache.

    TRY.
*        mo_db_connector_mocked->check_cache(
*          EXPORTING
*            fvi_look_for    = '0155751913'
*            fsi_oper_params = VALUE #( operation = '' raport = '')
*            fvi_date        = sy-datum
*          IMPORTING
*            fvr_nips        = DATA(lv_nips)
*            ftr_responses   = DATA(lt_responses)
*        ).
*
*        cl_abap_unit_assert=>assert_initial(
*          EXPORTING
*            act              = lv_nips    " Actual data object
*            msg              = 'xxx'    " Description
**            level            =     " Severity (TOLERABLE, >CRITICAL<, FATAL)
**            quit             =     " Alter control flow/ quit test (NO, >METHOD<, CLASS)
**          RECEIVING
**            assertion_failed =     " Condition was not met (and QUIT = NO)
*        ).



      CATCH zcx_wlist01_error.
        cl_abap_unit_assert=>fail(  ).
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
