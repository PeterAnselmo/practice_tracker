
$(document).ready(function(){
    $('body').on('click','button#record-practice', function(){
        item_id = $("div#practice-item").data("item-id");
        duration = $("p.elapsed-time-text").html();
        $.post('practices',{practice:{item_id: item_id}, duration:duration})
            .done(function(data){
                $(this).prop('disabled', true);
				$('#practice-save-success').show();
            })
            .fail(function(data){
                alert("There was an error saving!");
            });
    });

});
