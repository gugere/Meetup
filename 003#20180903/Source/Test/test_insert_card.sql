SET SERVEROUTPUT ON

select to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') Inicio from dual
/
DECLARE
   p_card_number      VARCHAR2(200);
   p_signature        BLOB;
   v_credit_card_id   v_credit_card.credit_card_id%TYPE;
   v_image_num        PLS_INTEGE;
   v_image_name       VARCHAR2(15);
BEGIN
   FOR i IN 1..100 LOOP
   
      p_card_number      := trim(regexp_replace(lpad(trunc(dbms_random.value * 10000000000000000),16,'0'),
                                                '([[:digit:]]{4})', '\1 ')  );
      
      v_image_num        := round(dbms_random.value(1,9) );
      v_image_name       := 'img_test_0' || v_image_num || '.png';
      
      p_signature        := pk_file.read_blob_file(
         p_dir_name    => pk_file.const_user_default_binary_dir,
         p_file_name   => v_image_name
      );
      
      v_credit_card_id   := credit_card_tapi.ins(
         p_card_number   => p_card_number,
         p_signature     => p_signature
      );      
      commit;
      dbms_lock.sleep(0.2);
   END LOOP;
END;
/
select to_char(sysdate,'dd/mm/yyyy hh24:mi:ss') fim from dual
/
/*
SELECT a.credit_card_id,
       a.final_card_number,
       --
       a.card_number.encrypted_data   encrypted_card_number,
       pk_decrypt.decrypt(
          a.card_number
       ) decrypted_card_number,
       --
       a.signature.encrypted_data     encrypted_signature,
       pk_decrypt.decrypt(
          a.signature
       ) decrypted_signature
       --, pk_decrypt.decrypt(
       --  pk_encrypt.encrypt(p_original_blob   => a.signature.encrypted_data)
       --  )test
       --delete
       
FROM credit_card a 

*/