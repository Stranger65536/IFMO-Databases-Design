use "film collection"
create table "countries"  
(
	"country id"	int				primary key identity,
	"name"			varchar(80)		not null
)
create table "people"
(
	"people id"			int				primary key identity,
	"first name"		varchar(80)		not null,
	"last name"			varchar(80)		not null,
	"birth date"		date			null,
	"country id"		int				foreign key references "countries" ("country id") null
)
create table "positions"
(
	"position id"	int				primary key identity,
	"name"			varchar(80)		unique not null,
	"description"	varchar(400)	null
)
create table "genres"
(
	"genre id"			int				primary key identity,
	"name"				varchar(80)		unique not null,
	"description"		varchar(400)	null
)
create table "file formats"
(
	"format id"		int				primary key identity,
	"name"			varchar(80)		unique not null,
	"description"	varchar(400)	null
)
create table "currencies"
(
	"currency id"		int				primary key identity,
	"name"				varchar(80)		unique not null,
	"symbol"			nchar(5)		null
)
create table "age restrictions"
(
	"restriction id"	int				primary key identity,
	"value"				varchar(80)		unique not null,
	"description"		varchar(400)	null
)
create table "mpaa rating"
(
	"rating id"			int				primary key identity,
	"name"				varchar(5)		unique not null,
	"description"		varchar(400)	null
)
create table "films info"
(
	"film id"				int				primary key,
	"english name"			varchar(80)		not null,
	"localized name"		nvarchar(80)	not null,
	"year"					date			null,
	"slogan"				varchar(400)	null,
	"duration"				time			not null,
	"number of viewers"		bigint			null,	
	"annotation"			varchar(8000)	null,
	"budget value"			bigint			null,
	"currency id"			int				foreign key references "currencies" ("currency id") null,
	"age restriction id"	int				foreign key references "age restrictions" ("restriction id") not null,
	"mpaa rating id"		int				foreign key references "mpaa rating" ("rating id") null
)
create table "films genre"
(
	"film id"				int		foreign key references "films info" ("film id") not null,
	"genre id"				int		foreign key references "genres" ("genre id") not null,
	primary key("film id", "genre id")
)
create table "people in film"
(
	"film id"				int		foreign key references "films info" ("film id") not null,
	"people id"				int		foreign key references "people" ("people id") not null,
	"position id"			int		foreign key references "positions" ("position id") not null,
	primary key("film id", "people id", "position id")
)
create table "codecs"
(
	"codec id"		int				primary key identity,
	"name"			varchar(80)		unique not null,
	"description"	varchar(400)	null
)
create table "aspect ratios"
(
	"ratio id"		int				primary key identity,
	"name"			varchar(80)		unique not null
)
create table "files info"
(
	"file id"					int				primary key,
	"film id"					int				foreign key references "films info" ("film id") not null,
	"link"						varchar(800)	not null unique,
	"file size"					bigint			not null,
	"frame resolution width"	int				not null,
	"frame resolution height"	int				not null,
	"format id"					int				foreign key references "file formats" ("format id") not null,
	"codec id"					int				foreign key references "codecs" ("codec id") not null,	
	"ratio id"					int				foreign key references "aspect ratios" ("ratio id") not null
)