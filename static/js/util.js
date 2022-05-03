$(document).ready(function(){

    //? disable enter Key
    $(document).keypress(
      function(event){
        if (event.which == '13') {
          event.preventDefault();
        }
    });

  //? remove user button enabler
  function cpfEnable(string){
    inputData = String(string);
    if(inputData.length == 14){
      $('#verify_button').removeAttr('disabled');
    } else{
      $('#verify_button').attr('disabled','disabled');
    }
  }

  //? remove book button enabler
  function barCodeEnable(string){
    inputData = String(string);
    if(inputData.length > 0){
      $('#verify_button').removeAttr('disabled');
    } else{
      $('#verify_button').attr('disabled','disabled');
    }
  }

  $('#cpf_input').keyup(function(){ cpfEnable($('#cpf_input').val()); });
  $('#barcode_input').keyup(function(){ barCodeEnable($('#barcode_input').val()); });

  //? insert loan information on form inputs
  function load_loan_info(){
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

  $('#cpf_input').keyup(function(){load_loan_info();});
  $('#barcode_input').keyup(function(){load_loan_info();});

  function update_user_list(){
    $.ajax({
      
      url:"/add/loan",
      method:"POST",
      data: $('form#myform').serialize(),
      success:function(data)
        {
          
        }
    });
  };

})

  