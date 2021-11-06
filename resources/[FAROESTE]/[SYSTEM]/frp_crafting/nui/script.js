window.addEventListener("message", function(event) {
    if (event.data.shouldOpen == true) {
        $('body').fadeIn();

        $('.item-column').html("");

        let selectedFirst = false;

        const wasSerializedToHashMap = !Array.isArray(event.data.data);

        $.each(event.data.data, function(cGroup, x) {

            cGroup = Number(cGroup);

            // Caso a configuração do crafting fique muito
            // grande, ela vai começar a ser serializada em hashmap
            // que vai fazer com que o indices continuem iguais ao do lua
            // então a gente não vai mais precisar compensar;
            
            if (!wasSerializedToHashMap)
            {
                cGroup += 1;
            }

            $.each(x, function(i, y) {
                $.each(Array.from(y), function(cIndex, z) {

                    cIndex += 1;

                    const output = z.output[0];
                    const item = output.item;
                    const name = output.name;

                    // const amount = output.amount;

                    $('.item-column').append(`
                        <div class="item ${!(selectedFirst) ? "selected" : ""}" data-cgroup="${cGroup}" data-cindex="${cIndex}">
                            <span class="title">
                                ${name}
                            </span>
                        </div>
                    `);

                    if (!(selectedFirst)) {
                        $.post("http://frp_crafting/getRecipe", JSON.stringify({ cGroup: cGroup, cIndex: cIndex }));

                        selectedFirst = true;
                    }
                });
            });
        });
    }

    if (event.data.shouldClose == true) {
        $("body").hide();

        $('.selected').removeClass('selected');

        $(".item-row").html("");

        $('.production-info').text("?");
    }

    if (event.data.recipes == true) {
        $(".item-row").html("");

        const time = event.data.data.time;

        const useIconDescription = event.data.data.useIconDescription;
        const useTextDescription = event.data.data.useTextDescription;

        const descriptionText = event.data.data.descriptionText;

        const iconDescriptionVisibilityFnName = useIconDescription ? 'show' : 'hide';
        const textDescriptionVisibilityFnName = useTextDescription ? 'show' : 'hide';

        $('.item-row')[iconDescriptionVisibilityFnName]();
        $('.bottom__item_description')[textDescriptionVisibilityFnName]();

        if (useIconDescription)
        {
            $.each(event.data.data, function(i, input) {

                if (!(isNaN(i))) {
    
                    i = parseInt(i);
    
                    const item = input.item;
                    const isActive = input.isActive;
    
                    $('.item-row').append(`
                        <div class="item ${isActive == true ? "" : "blocked"}">
                            <img src="nui://frp_inventory/nui/images/items/${item}.png" onerror="this.src='nui://frp_inventory/nui/images/_placeholder.png'" />
                        </div>
                    `);
    
                    if (i != Object.entries(event.data.data).filter(a => a[1].item).length) {
                        $('.item-row').append(`
                            <span>+</span>
                        `);
                    }
                }
            });
        }
        else if (useTextDescription)
        {
            $('.bottom__item_description__text').text(descriptionText ?? 'Descrição não definida, que merda aconteceu?');
        }

        $('.production-info').text(`Tempo de produção: ${time} secs`);
    }
});

$(".item-column").on("click", ".item", function(e) {

    const cGroup = $(this).data('cgroup');
    const cIndex = $(this).data('cindex');

    $('.selected').removeClass('selected');
    $(this).addClass('selected');

    $.post("http://frp_crafting/getRecipe", JSON.stringify({ cGroup: cGroup, cIndex: cIndex }));

    e.preventDefault();
})

$(document).ready(function() {
    $(document).keyup(function(e) {
        if (e.which == 27) { // ! ESC
            $.post("http://frp_crafting/shouldClose", JSON.stringify({}));
        }
    });
});