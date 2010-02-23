#!/usr/bin/perl

use strict;
use warnings;

use Test::More qw/no_plan/;

use Tenjin;

can_ok('Tenjin', 'new');

my $t = Tenjin->new({ path => ['t/', './'], postfix => '.html' });

ok($t, 'new Tenjin created');
isa_ok($t, 'Tenjin');
can_ok($t, 'render');

my $res = $t->render('test_tmpl.html', {
	scalar_variable		=> 'hello',
	hash_variable		=> { hash_value_key => 'sensible' },
	array_variable		=> [ undef, undef, 'world' ],
	this			=> { is => { a => { very => { deep => { hash => { structure => 'of' } } } } } },
	array_loop		=> [ 'soccer', 'sega', 'genesis' ],
	hash_loop		=> { 1992 => 'bad', 1993 => 'ok', 1994 => 'good', 1995 => 'perfect' },
	records_loop		=> [ { name => 'Ido Perlmuter', age => 25 }, { name => 'Noi Perlmuter', age => 13 } ],
	variable_if		=> 1,
	variable_if_else	=> undef,
	template_if_true	=> 'true.html',
	template_if_false	=> 'false.html',
	variable_expression_a	=> 2,
	variable_expression_b	=> 5,
	variable_function_arg	=> 'asf asdf asdfff',
});

for my $r (
    'foo foo foo foo foo foo foo foo foo foo foo foo',
    'scalar: hello',
    'hash: sensible',
    'array: world',
    'deep: of',
    'array_loop: soccersegagenesis',
    'hash_loop: 1992: bad1993: ok1994: good1995: perfect',
    'records_loop: Ido Perlmuter: 25Noi Perlmuter: 13',
    'true: true',
    'var_if: true',
    'true_false: true',
    'var_ifelse: false',
    'tmpl_true: true.html',
    'var_if_tmpl: true.html',
    'tmpl_true_false: true.html',
    'var_ifelse_tmpl: false.html',
    'expr: 22',
    'var_mult: 10',
    'var_long: 3',
    'substr: substring',
    'substr_var: as',
) {
    like($res, qr/^\Q$r\E$/m, $r);
}
