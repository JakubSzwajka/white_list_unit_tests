CLASS zcl_wlist01_db_mock DEFINITION
  PUBLIC
  INHERITING FROM zcl_wlist01_db
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS:
      check_cache REDEFINITION,
      save_response REDEFINITION,
      save_vies REDEFINITION.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_wlist01_db_mock IMPLEMENTATION.

  METHOD check_cache.

    CASE fvi_look_for.
      WHEN '3245174504'. "In cache


      WHEN '0155751913'. "Not In cache
        fvr_nips = '0155751913'.

      WHEN '755016841'. "In cache

      WHEN '227220243'. "Not In cache
        fvr_nips = '227220243'.

    ENDCASE.


  ENDMETHOD.

  METHOD save_response.

  ENDMETHOD.

  METHOD save_vies.

  ENDMETHOD.

ENDCLASS.
