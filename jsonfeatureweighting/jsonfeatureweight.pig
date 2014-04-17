register 'lib/json-simple-1.1.jar';
register 'lib/elephant-bird-hadoop-compat-4.4.jar';
register 'lib/elephant-bird-pig-4.4.jar';

import 'tfidf.macro';

rawjson = load '/reco/dev/output/catalog/' using com.twitter.elephantbird.pig.load.JsonLoader('-nestedLoad') as (json:map[]);
productBag = foreach rawjson generate $0#'globalID' as globalId, $0#'categories' as categories;
Y = tfidf(productBag, 'globalId', 'categories');
Y = GROUP Y by globalId;
DUMP Y;

