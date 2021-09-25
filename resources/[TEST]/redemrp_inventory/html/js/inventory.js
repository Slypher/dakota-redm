var type = "normal";
var disabled = false;
var mainindex = 0;
var secondindex = 0;
var disabledFunction = null;
var targetPlayerId = 0;
var mainInventoryItems = {};
var secondInventoryItems = {};
var activeCategoryInventory = "all";
var activeCategoryCrafting = "available";
var crafting = false;
var CraftingItems = {};

// $(function () {
//   inventorySetup(test);
//   secondInventorySetup(test);
//   MakeDragable();




// });


window.addEventListener("message", function (event) {
  if (event.data.type == 1) {
    CraftingItems = event.data.crafting;
    disabled = false;
    if (crafting) {
      $(".crafting").fadeIn();
      CreateCraftings(CraftingItems);
    } else {
      $(".inventory").fadeIn();
    }
    if (event.data.players){
      drawgivebuttons(event.data.players);
    }
    if (event.data.otherinventory) {
      $('.centerwrapper').css("margin-left", "23.5%");
      $(".otherInventory").fadeIn();
    } else {
      $('.centerwrapper').css("margin-left", "37%");
    }
    // show(event.data.inventory, event.data.otherinventory ,event.data.crafting);
    ;
    getItems(event.data.items, event.data.otheritems, event.data.target, event.data.weight, event.data.money);

    MakeDragable();
    if (crafting) {
      FilterItems(activeCategoryCrafting);
    } else {
      FilterItems(activeCategoryInventory);
    }

  } else if (event.data.type == 2) {
    $(".inventory").fadeOut();
    $(".crafting").fadeOut();
    $(".otherInventory").fadeOut();
    $(".site-cm-box").fadeOut();

    $(".item").remove();
    // $("#otherInventory").html("<div id=\"noSecondInventoryMessage\"></div>");
    // $("#noSecondInventoryMessage").html(invLocale.secondInventoryNotAvailable);
  }
});

function getItems(data, secondInventory, targetPlayer, weight, money) {
  targetPlayerId = targetPlayer;
  inventorySetup(data);
  if (secondInventory) {
    secondInventorySetup(secondInventory)
  }
  var weight_object = document.getElementById("weight");
  var w = Math.round(weight * 100) / 100 + "/24 KG";
  weight_object.innerHTML = money + "$<br>" + w;
}

function inventorySetup(items) {
  $("#playerInventory").html("");
  mainInventoryItems = items;
  $.each(items, function (index, item) {
    $("#playerInventory").append('<div id="item-' + index + '" data-category="' + item.category + '" class="slot item" style = "background-image: url(\'' + item.imgsrc + '\')">' +
      '<div class="item-count">' + item.amount + '</div></div>');
    $('#item-' + index).data('item', item);
    $('#item-' + index).data('inventory', "main");
    $('#item-' + index).attr('onmouseover', "Over(`" + item.label + "`, `" + item.description + "`)");
    mainindex = index;
    createContextMenu(item, '#item-', index);
  });
}

function createContextMenu(item, id, index) {

  var data = [];
  if (id != '#itemOther-' && id != '#itemCrafting-') {
    data.push({
      text: "Give",
      action: function () {
        if (disabled) {
          return;
        }
        var _item = item;
        $.post('http:/redemrp_inventory/giveItemSelected', JSON.stringify({ data: _item }),);
      }
    });

    data.push({
      text: "Drop",
      action: function () {
        if (disabled) {
          return;
        }
        var _item = item;
        $.post('http:/redemrp_inventory/dropitem', JSON.stringify({ data: _item }),);

      }
    });
  }
  if (id == '#itemOther-' || id == '#item-') {
    if (item.type == "item_standard" && item.amount > 1) {
      data.push({
        text: "Split",
        action: function () {
          if (disabled) {
            return;
          }
          if (id != '#itemOther-') {
            SplitHowMany(index, "main");
          } else {
            SplitHowMany(index, "second");
          }
        }
      });
    }
  }

  if (id == '#itemCrafting-') {
    if (item.amount >= 1) {
      data.push({
        text: "Craft",
        action: function () {
          if (disabled) {
            return;
          }
          CraftHowMany(item.name, item.amount, item.required[0].meta)
        }
      });
    }
  }


  if (data.length > 0) {
    $(id + index).contextMenu([data], {
      offsetX: 1,
      offsetY: 1,
    });
  }

}
function Over(item, desc) {
  if (item == null) {
    description.innerHTML = "";
  } else {
    $(".info-div").html("<h3>" + item + "</h3><p style ='font-family: HapnaSlabSerif-Medium;'>" + desc + "</p>");
  }
}

function drawgivebuttons(players) {
  var tsesdsd = players[0].data.data;
  var test = {
    players: []
  };
  for (x in players) {
    test["players"].push({ label: players[x].label, player: players[x].player });
  }
  if (test) {
    dialog.prompt({
      title: "Select player",
      button: "Confirm",
      required: false,
      item: test,
      // type: players,
      select: true,
      validate: function (value, data, player) {
        ////////console.log(player);
        ////////console.log(data);
        $.post('http:/redemrp_inventory/giveitem', JSON.stringify({ target: player, item: tsesdsd }));
        return true;
      }
    });
  }
}
function SplitHowMany(index, type) {
  dialog.prompt({
    title: "Amount",
    button: "Confirm",
    required: false,
    position: ['middle', 20],

    input: {
      type: "number"
    },
    validate: function (value) {
      ////////console.log(index);
      if (value > 0) {
        if (type == "main") {
          CreateSplitMainClone(index, value);
        } else {
          CreateSplitSecondClone(index, value);
        }
      }
      return true;
    }
  });
}


function CraftHowMany(name, a, m) {
  dialog.prompt({
    title: "Amount",
    button: "Confirm",
    required: false,
    position: ['middle', 20],

    input: {
      type: "number"
    },
    validate: function (value) {
      if (value > 0 && value <= a) {
        $.post('http:/redemrp_inventory/craft', JSON.stringify({
          name: name,
          amount: value,
          meta: m
        }));
      }
      return true;
    }
  });
}


function MakeDragable() {
  $('.item').draggable({
    helper: 'clone',
    appendTo: 'body',
    zIndex: 99999,
    revert: 'invalid',
    // handle: $(".slot"),
    // containment: ".container",
    start: function (event, ui) {
      $(ui.helper).css('width', `${$(event.target).width()}px`);
      $(ui.helper).css('padding-bottom', `${$(event.target).width()}px`);
      if (disabled) {
        $(this).stop();
        return;
      }

      // $(this).css('background-image', 'none');
      // itemData = $(this).data("item");
      // itemInventory = $(this).data("inventory");

      // if (itemInventory == "second" || !itemData.canRemove) {
      //   $("#drop").addClass("disabled");
      //   $("#give").addClass("disabled");
      // }

      // if (itemInventory == "second" || !itemData.usable) {
      //   $("#use").addClass("disabled");
      // }
    },
    // stop: function () {
    //   itemData = $(this).data("item");

    //   if (itemData !== undefined && itemData.name !== undefined) {
    //     // $(this).css('background-image', 'url(\'items/' + itemData.name + '.png\'');
    //     $("#drop").removeClass("disabled");
    //     $("#use").removeClass("disabled");
    //     $("#give").removeClass("disabled");
    //   }
    // }
  });
}
function CreateSplitMainClone(mindex, value) {
  ////////console.log(mindex);
  var iteminfo = $("#item-" + mindex).data('item');
  if (iteminfo.amount <= value) {
    return;
  }
  $("#item-" + mindex).remove();
  ////////console.log(iteminfo);
  var newvalue = iteminfo.amount - value;
  var cloneiteminfo = { ...iteminfo };
  cloneiteminfo.amount = parseInt(value);
  iteminfo.amount = parseInt(newvalue);
  mainindex++;
  secondInventoryItems
  // ////////console.log(cloneiteminfo);
  $("#playerInventory").append('<div id="item-' + mainindex + '"  data-category="' + iteminfo.category + '"class="slot item" style = "background-image: url(\'' + iteminfo.imgsrc + '\')">' +
    '<div class="item-count">' + iteminfo.amount + '</div></div>');
  $('#item-' + mainindex).data('item', iteminfo);
  $('#item-' + mainindex).data('inventory', "main");
  $('#item-' + mainindex).attr('onmouseover', "Over(`" + iteminfo.label + "`, `" + iteminfo.description + "`)");

  $("#playerInventory").append('<div id="item-' + mindex + '" data-category="' + cloneiteminfo.category + '" class="slot item" style = "background-image: url(\'' + cloneiteminfo.imgsrc + '\')">' +
    '<div class="item-count">' + cloneiteminfo.amount + '</div></div>');
  $('#item-' + mindex).data('item', cloneiteminfo);
  $('#item-' + mindex).data('inventory', "main");
  $('#item-' + mindex).attr('onmouseover', "Over(`" + cloneiteminfo.label + "`, `" + cloneiteminfo.description + "`)");
  MakeDragable();
  createContextMenu(iteminfo, '#item-', mainindex);
  createContextMenu(cloneiteminfo, '#item-', mindex);



}

function CreateSplitSecondClone(sindex, value) {
  ////////console.log(sindex);
  var iteminfo = $("#itemOther-" + sindex).data('item');
  if (iteminfo.amount <= value) {
    return;
  }
  $("#itemOther-" + sindex).remove();
  ////////console.log(iteminfo);
  var newvalue = iteminfo.amount - value;
  var cloneiteminfo = { ...iteminfo };
  cloneiteminfo.amount = parseInt(value);
  iteminfo.amount = parseInt(newvalue);
  secondindex++;
  // secondInventoryItems
  // ////////console.log(cloneiteminfo);
  $("#secondInventory").append('<div id="itemOther-' + secondindex + '"  data-category="' + iteminfo.category + '"class="slot item" style = "background-image: url(\'' + iteminfo.imgsrc + '\')">' +
    '<div class="item-count">' + iteminfo.amount + '</div></div>');
  $('#itemOther-' + secondindex).data('item', iteminfo);
  $('#itemOther-' + secondindex).data('inventory', "second");
  $('#itemOther-' + secondindex).attr('onmouseover', "Over(`" + iteminfo.label + "`, `" + iteminfo.description + "`)");

  $("#secondInventory").append('<div id="itemOther-' + sindex + '"  data-category="' + cloneiteminfo.category + '"class="slot item" style = "background-image: url(\'' + cloneiteminfo.imgsrc + '\')">' +
    '<div class="item-count">' + cloneiteminfo.amount + '</div></div>');
  $('#itemOther-' + sindex).data('item', cloneiteminfo);
  $('#itemOther-' + sindex).data('inventory', "second");
  $('#itemOther-' + sindex).attr('onmouseover', "Over(`" + cloneiteminfo.label + "`, `" + cloneiteminfo.description + "`)");
  MakeDragable();
  createContextMenu(iteminfo, '#itemOther-', secondindex);
  createContextMenu(cloneiteminfo, '#itemOther-', sindex);

}


function secondInventorySetup(items) {
  secondInventoryItems = items;
  $("#secondInventory").html("");
  $.each(items, function (index, item) {
    $("#secondInventory").append('<div id="itemOther-' + index + '" class="slot item" style = "background-image: url(\'' + item.imgsrc + '\')">' +
      '<div class="item-count">' + item.amount + '</div></div>');
    $('#itemOther-' + index).data('item', item);
    $('#itemOther-' + index).data('inventory', "second");
    $('#itemOther-' + index).attr('onmouseover', "Over(`" + item.label + "`, `" + item.description + "`)");
    secondindex = index;
    MakeDragable();
    createContextMenu(item, '#itemOther-', index);
  });
}

function Interval(time) {
  var timer = false;
  this.start = function () {
    if (this.isRunning()) {
      clearInterval(timer);
      timer = false;
    }

    timer = setInterval(function () {
      disabled = false;
    }, time);
  };
  this.stop = function () {
    clearInterval(timer);
    timer = false;
  };
  this.isRunning = function () {
    return timer !== false;
  };
}

function disableInventory(ms) {
  disabled = true;

  if (disabledFunction === null) {
    disabledFunction = new Interval(ms);
    disabledFunction.start();
  } else {
    if (disabledFunction.isRunning()) {
      disabledFunction.stop();
    }

    disabledFunction.start();
  }
}

$(document).ready(function () {

  $('#playerInventory').on('dblclick', '.item', function () {
    itemData = $(this).data("item");
    if (itemData == undefined) {
      return;
    }
    itemInventory = $(this).data("inventory");
    if (itemInventory == "second") {
      return;
    }
    disableInventory(300);
    ////////console.log(itemData);
    $.post('http:/redemrp_inventory/useitem', JSON.stringify({ data: itemData }),);
  });

  $('#playerInventory').droppable({
    drop: function (event, ui) {
      itemData = ui.draggable.data("item");
      itemInventory = ui.draggable.data("inventory");

      if (itemInventory === "second") {
        disableInventory(500);
        // itemData.count = parseInt($("#slider_count").val())
        $.post('http:/redemrp_inventory/additem', JSON.stringify({ data: itemData, target: targetPlayerId }),);
      }
    }
  });

  $('#secondInventory').droppable({
    drop: function (event, ui) {
      itemData = ui.draggable.data("item");
      itemInventory = ui.draggable.data("inventory");
      ////////console.log("sdsdsfgfgfgfdsd");
      if (itemInventory === "main") {
        disableInventory(500);
        // itemData.amount = parseInt($("#slider_count").val())
        ////////console.log(itemData);

        $.post('http:/redemrp_inventory/removeitem', JSON.stringify({ data: itemData, target: targetPlayerId }),);

      }
    }
  });




});

function CreateCraftings(craftings) {

  $("#craftingInventory").html("");
  $.each(craftings, function (index, craft) {
    $("#craftingInventory").append('<div id="itemCrafting-' + index + '" data-category="' + craft.category + '" data-amount="' + craft.amount + '" class="slot item" style = "background-image: url(\'' + craft.imgsrc + '\')">' +
      '<div class="item-count">' + craft.amount + '</div></div>');
    $('#itemCrafting-' + index).data('item', craft);
    $('#itemCrafting-' + index).data('inventory', "second");
    if (craft.amount == 0) {
      $('#itemCrafting-' + index).css('opacity', 0.5);
    }
    var req = "";
    $.each(craft.required, function (i, info) {
      if (craft.blacklist) {
        req = req + "????????" + " x" + "?" + "<br>";
      } else {
        req = req + info.label + " x" + info.amount + "<br>";
      }

    });

    $('#itemCrafting-' + index).attr('onmouseover', "Over(`" + craft.label + "`, `" + req + "`)");
    createContextMenu(craft, '#itemCrafting-', index);
  });



}

$(document).keyup(function (e) {
  if (e.keyCode == 27 || e.keyCode == 66) { //hide eq

    $(".inventory").fadeOut();
    $(".crafting").fadeOut();
    $(".otherInventory").fadeOut();
    $(".site-cm-box").fadeOut();

    $(".item").remove();
    $.post('http:/redemrp_inventory/close');
  }

  if (e.keyCode == 67) { //hide eq
    crafting = !crafting;
    if (crafting) {
      //////console.log(CraftingItems);
      CreateCraftings(CraftingItems);
      $(".site-cm-box").fadeOut(0);
      $(".inventory").fadeOut(0);
      $(".crafting").fadeIn(0);
      $("." + activeCategoryInventory).removeClass('active');
      $("." + activeCategoryCrafting).addClass('active');
      FilterItems(activeCategoryCrafting);
    } else {
      $(".info-div").html("");
      $(".site-cm-box").fadeOut(0);
      $(".crafting").fadeOut(0);
      $(".inventory").fadeIn(0);
      $("." + activeCategoryCrafting).removeClass('active');
      $("." + activeCategoryInventory).addClass('active');
      FilterItems(activeCategoryInventory);
    }

  }

  if (e.keyCode == 69) { //q
    var idtest = "#q";
    if (crafting) {
      idtest = "#qc";
    }
    var li = $(idtest).parent().find('li.active'),
      active = li.next();

    var oldcategory = li.data('category');
    if (active.hasClass('button')) {
      var category = $(idtest).parent().find('li:first-of-type').data('category');
      li.removeClass('active');
      $("." + oldcategory).removeClass('active');
      $("." + category).addClass('active');
      $(idtest).parent().find('li:first-of-type').addClass('active');
      if (crafting) {
        activeCategoryCrafting = category;
      } else {
        activeCategoryInventory = category;
      }

      FilterItems(category);
    } else {
      var category = active.data('category');
      $("." + oldcategory).removeClass('active');
      $("." + category).addClass('active');
      li.removeClass('active');
      active.addClass('active');
      if (crafting) {
        activeCategoryCrafting = category;
      } else {
        activeCategoryInventory = category;
      }
      // //////console.log(category);
      FilterItems(category);
    }
  }

  if (e.keyCode == 81) { //q
    var idtest = "#e";
    if (crafting) {
      idtest = "#ec";
    }
    var li = $(idtest).parent().find('li.active'),
      active = li.prev();

    var oldcategory = li.data('category');
    if (active.hasClass('button')) {
      var category = $(idtest).parent().find('li:last-of-type').data('category');
      li.removeClass('active');
      $("." + oldcategory).removeClass('active');
      $("." + category).addClass('active');
      $(idtest).parent().find('li:last-of-type').addClass('active');
      if (crafting) {
        activeCategoryCrafting = category;
      } else {
        activeCategoryInventory = category;
      }
      FilterItems(category);
    } else {
      var category = active.data('category');
      $("." + oldcategory).removeClass('active');
      $("." + category).addClass('active');
      li.removeClass('active');
      active.addClass('active');
      if (crafting) {
        activeCategoryCrafting = category;
      } else {
        activeCategoryInventory = category;
      }
      FilterItems(category);

    }
  }
});

function FilterItems(category) {
  var cusid_ele = document.getElementById("playerInventory").getElementsByClassName('item');
  if (crafting) {
    cusid_ele = document.getElementById("craftingInventory").getElementsByClassName('item');
  }
  for (var i = 0; i < cusid_ele.length; ++i) {
    // //////console.log(i);
    var item = cusid_ele[i];
    var item_category = item.dataset.category;
    var amount = item.dataset.amount;
    // //////console.log(item_category);
    if (category == "all") {
      item.style.display = "block";
    } else if (category == "available" && amount == 0) {
      item.style.display = "none";
    } else if (category != item_category && category != "available") {
      item.style.display = "none";
    } else {
      item.style.display = "block";
    }

  }

}