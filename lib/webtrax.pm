package webtrax;
use Dancer ':syntax';

our $VERSION = '0.1';

# force login
before sub {
   if (! session('user') && request->path_info !~ m{^/login}) {
      var requested_path => request->path_info;
      request->path_info('/login');
   }
};

get '/' => sub {
    template 'index';
};

get '/login' => sub {
   # Display a login page; the original URL they requested is available as
   # vars->{requested_path}, so could be put in a hidden field in the form
   template 'login', { path => vars->{requested_path} };
};

post '/login' => sub {
   # Validate the username and password they supplied
   if (params->{user} eq 'bob' && params->{pass} eq 'letmein') {
      session user => params->{user};
      redirect params->{path} || '/';
   } else {
      redirect '/login?failed=1';
   }
};


get '/roles' => sub{
   template 'roles';
};

get '/goals' => sub{
   template 'goals';
};

get '/tasks' => sub{
   template 'tasks';
};


true;
