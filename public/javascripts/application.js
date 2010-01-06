// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

Event.addBehavior.reassignAfterAjax = true;
Event.addBehavior({
    'div.pagination a' : Remote.Link
  })

function fadeIn(id_of_element){
	new Effect.Opacity(id_of_element, { from: 0, to: 1, duration: 0.5 });
 }
 
function fadeOut(id_of_element){
	new Effect.Opacity(id_of_element, { from: 1, to: 0, duration: 0.5 });
 }