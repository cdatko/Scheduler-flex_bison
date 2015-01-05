%{
#include <stdio.h>
#include <ctype.h>
int yylex ();
int yyerror (char* s);
%}

%token RBRACK
%token LBRACK
%token COMMA
%token DAY
%token NAME
%token NUM
%token CLASS
%token NOTHING

%% /* Grammar Rules */

done: needs
		{printf("found valid 'needs' list'\n");}
	| unavailable_list 
		{printf("found valid 'unavailable_list'\n");}
	| course_capabilities
		{printf("found valid 'course_capabilities' list\n");}
	| resource_entry
		{printf("found valid 'resource_entry' list\n");}
	| resources_list
		{printf("found valid 'resources list'\n");}
;

/* Needs */

needs: LBRACK needs_list RBRACK
; 

needs_part: LBRACK CLASS COMMA NUM COMMA DAY COMMA NUM COMMA NUM RBRACK
;

needs_list: needs_part | needs_list COMMA needs_part
;

/* Unavailable List */

unavailable_list: LBRACK unavailable RBRACK
;

unavailable_part: LBRACK DAY COMMA NUM COMMA NUM RBRACK
;

unavailable: unavailable_part | unavailable COMMA unavailable_part |
;

/* Course Capabilities List */

course_capabilities_list: CLASS | course_capabilities_list COMMA CLASS
;

course_capabilities: LBRACK course_capabilities_list RBRACK
;

/* Resource Entry */

resource_entry: LBRACK NAME COMMA course_capabilities COMMA unavailable_list RBRACK
;

/* Resources List */

resources: resource_entry | resources COMMA resource_entry
;

resources_list: LBRACK resources RBRACK
;
