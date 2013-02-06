$(function () {
  var EXECUTE_NAGRESIGNAKO = new Object();
  EXECUTE_NAGRESIGNAKO.controller_name = $("body").attr("data-controller");
  EXECUTE_NAGRESIGNAKO.action_name = $("body").attr("data-action");
  
  //Run Common JS
  NAGRESIGNAKO.common.init();

  //Run Controller Specific JS
  if (NAGRESIGNAKO[EXECUTE_NAGRESIGNAKO.controller_name].init)
    NAGRESIGNAKO[EXECUTE_NAGRESIGNAKO.controller_name].init();

  //Run Action Specific JS
  if (NAGRESIGNAKO[EXECUTE_NAGRESIGNAKO.controller_name][EXECUTE_NAGRESIGNAKO.action_name])
    NAGRESIGNAKO[EXECUTE_NAGRESIGNAKO.controller_name][EXECUTE_NAGRESIGNAKO.action_name]();
  
});