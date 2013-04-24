requires 'perl', '5.006';

on build => sub {
    requires 'CGI';
    requires 'ExtUtils::MakeMaker', '6.59';
    requires 'Test::More', '0.62';
};
