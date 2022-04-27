$(document).ready(function(){
    
    function verify_data(){
        var url = document.getElementById('url').innerHTML;
        var method = document.getElementById('method').innerHTML;

        console.log(url)

        $.ajax({
            url:url,
            method:method,
            data: $('form#myform').serialize(),
            success:function(data)
            {
                if (data.status == 0){
                    $('#alert_title').html(data.title);
                    $('#alert_subtitle').html(data.subtitle);
                    $('#alert_msg').html(data.msg);
                    $('#alert_modal').modal('show'); 
                } else {
                    $('#action_modal').modal('show'); 
                }

            }
        });
  }

  $('#verify_button').click(function(){verify_data();});

});
