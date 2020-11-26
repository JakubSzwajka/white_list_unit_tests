CLASS lcl_wlist01_prog DEFINITION FOR TESTING
DURATION MEDIUM
RISK LEVEL HARMLESS.

  PUBLIC SECTION.
    DATA:
      cut_db_mocked    TYPE REF TO zcl_wlist01_prog_tst,
      cut_wlist_mocked TYPE REF TO zcl_wlist01_prog_tst,
      cut_vies_mocked  TYPE REF TO zcl_wlist01_prog_tst.

    DATA:
      mo_db_connector_stub TYPE REF TO zif_wlist01_db,
      mo_wlist_api         TYPE REF TO zcl_wlist01_api,
      mo_vies_api          TYPE REF TO zcl_wlist01_api_viese.


    METHODS:
      "! Check if the request for API with NIP number 3245174504
      "! return company name as 'NAZWA FIRMY 1'
      nip_search_request FOR TESTING,

      "! Check if the request for API with NIP number 882837568
      "! return company name as 'NAZWA FIRMY 14'
      regon10_search_request FOR TESTING,

      "! Check if the request for API with NIP number 79156739856513
      "! return company name as 'NAZWA FIRMY 1'
      regon14_search_request FOR TESTING.

  PROTECTED SECTION.

  PRIVATE SECTION.

    TYPES:
             gy_y_display_obj TYPE STANDARD TABLE OF zwl1_s_display_obj WITH DEFAULT KEY.

    METHODS:
      setup.

ENDCLASS.


CLASS lcl_wlist01_prog IMPLEMENTATION.

  METHOD setup.
    "Create Stub
    mo_db_connector_stub ?= cl_abap_testdouble=>create( 'ZIF_WLIST01_DB' ).

    "for nip 3245174504
    cl_abap_testdouble=>configure_call( mo_db_connector_stub )->set_parameter(
                                        name = 'fvr_nips' value = '3245174504' ).

    mo_db_connector_stub->check_cache( fvi_look_for = '3245174504'
                                       fvi_date = sy-datum
                                       fsi_oper_params = VALUE #( operation = zcl_wlist01_config=>mc_wlist
                                                                  raport    = zcl_wlist01_config=>mc_search_nips ) ).

    "for regon 882837568
    cl_abap_testdouble=>configure_call( mo_db_connector_stub )->set_parameter(
                                        name = 'fvr_nips' value = '882837568' ).

    mo_db_connector_stub->check_cache( fvi_look_for = '882837568'
                                       fvi_date = sy-datum
                                       fsi_oper_params = VALUE #( operation = zcl_wlist01_config=>mc_wlist
                                                                  raport    = zcl_wlist01_config=>mc_search_regons ) ).

    "for regon 79156739856513
    cl_abap_testdouble=>configure_call( mo_db_connector_stub )->set_parameter(
                                        name = 'fvr_nips' value = '79156739856513' ).

    mo_db_connector_stub->check_cache( fvi_look_for = '79156739856513'
                                       fvi_date = sy-datum
                                       fsi_oper_params = VALUE #( operation = zcl_wlist01_config=>mc_wlist
                                                                  raport    = zcl_wlist01_config=>mc_search_regons ) ).

    mo_vies_api = zcl_wlist01_config=>get_api_vies( ).
    mo_wlist_api = zcl_wlist01_config=>get_api_wlist( ).

    cut_db_mocked = NEW #( i_dbhandler = mo_db_connector_stub
                           i_vies_api = mo_vies_api
                           i_wlist_api = mo_wlist_api ).

  ENDMETHOD.

  METHOD nip_search_request.

    DATA:
          lt_response_alv TYPE gy_y_display_obj.

    TRY.

        cut_db_mocked->search_request(
        EXPORTING
          fvi_search_param  = CONV #( '3245174504' )
          fvi_date          = CONV #( sy-datum )
          fsi_oper_params   = VALUE #( operation = zcl_wlist01_config=>mc_wlist
                                       raport    = zcl_wlist01_config=>mc_search_nips )
        IMPORTING
          fte_response_alv  = lt_response_alv
      ).

        IF lt_response_alv IS NOT INITIAL.
          READ TABLE lt_response_alv INDEX 1 ASSIGNING FIELD-SYMBOL(<fs_response>).
          IF sy-subrc = 0.

            cl_abap_unit_assert=>assert_equals(
              EXPORTING
                act                  = <fs_response>-name
                exp                  = 'NAZWA FIRMY 1'
              quit                 = if_aunit_constants=>quit-no
            ).

          ELSE.
            cl_abap_unit_assert=>fail( msg = 'Index not found' ).
          ENDIF.
        ELSE.
          cl_abap_unit_assert=>fail( msg = 'Response empty' ).
        ENDIF.


      CATCH zcx_wlist01_error.
        cl_abap_unit_assert=>fail(  ).
    ENDTRY.

  ENDMETHOD.

  METHOD regon10_search_request.

    DATA:
          lt_response_alv TYPE gy_y_display_obj.

    TRY.

        cut_db_mocked->search_request(
        EXPORTING
          fvi_search_param  = CONV #( '882837568' )
          fvi_date          = CONV #( sy-datum )
          fsi_oper_params   = VALUE #( operation = zcl_wlist01_config=>mc_wlist
                                       raport    = zcl_wlist01_config=>mc_search_regons )
        IMPORTING
          fte_response_alv  = lt_response_alv
      ).

        IF lt_response_alv IS NOT INITIAL.
          READ TABLE lt_response_alv INDEX 1 ASSIGNING FIELD-SYMBOL(<fs_response>).
          IF sy-subrc = 0.

            cl_abap_unit_assert=>assert_equals(
              EXPORTING
                act                  = <fs_response>-name
                exp                  = 'NAZWA FIRMY 14'
              quit                 = if_aunit_constants=>quit-no
            ).

          ELSE.
            cl_abap_unit_assert=>fail( msg = 'Index not found' ).
          ENDIF.
        ELSE.
          cl_abap_unit_assert=>fail( msg = 'Response empty' ).
        ENDIF.

      CATCH zcx_wlist01_error.
        cl_abap_unit_assert=>fail(  ).
    ENDTRY.


  ENDMETHOD.

  METHOD regon14_search_request.

    DATA:
         lt_response_alv TYPE gy_y_display_obj.

    TRY.

        cut_db_mocked->search_request(
        EXPORTING
          fvi_search_param  = CONV #( '79156739856513' )
          fvi_date          = CONV #( sy-datum )
          fsi_oper_params   = VALUE #( operation = zcl_wlist01_config=>mc_wlist
                                       raport    = zcl_wlist01_config=>mc_search_regons )
        IMPORTING
          fte_response_alv  = lt_response_alv
      ).

        IF lt_response_alv IS NOT INITIAL.
          READ TABLE lt_response_alv INDEX 1 ASSIGNING FIELD-SYMBOL(<fs_response>).
          IF sy-subrc = 0.

            cl_abap_unit_assert=>assert_equals(
              EXPORTING
                act                  = <fs_response>-name
                exp                  = 'NAZWA FIRMY 1'
              quit                 = if_aunit_constants=>quit-no
            ).

          ELSE.
            cl_abap_unit_assert=>fail( msg = 'Index not found' ).
          ENDIF.
        ELSE.
          cl_abap_unit_assert=>fail( msg = 'Response empty' ).
        ENDIF.


      CATCH zcx_wlist01_error.
        cl_abap_unit_assert=>fail(  ).
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
