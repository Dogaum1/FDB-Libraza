$(document).ready(function(){

      function load_data(){
        $.ajax({
          
          url:"/add/loan",
          method:"POST",
          data: $('form#myform').serialize(),
          success:function(data)
            {
              $('#user_input').val(data.user);
              $('#book_input').val(data.book);
            }
        });
    }
    // loan auto complete
    $('#cpf_input').keyup(function(){load_data();});
    $('#barcode_input').keyup(function(){load_data();});

    $(document).keypress(
      function(event){
        if (event.which == '13') {
          event.preventDefault();
        }
    });

  });
  