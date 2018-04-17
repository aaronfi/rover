## Aaron Fischer's interview write-up

I coded this using Ruby on Rails 4, having dusted off and repurposed old code from my http://www.gobblebreak.com project (a Boggle game website with many features).

### Show me the website!

http://interview-aaronfi.herokuapp.com

### How do I install this locally?

% git clone https://github.com/roverjobs/interview-aaronfi.git
% cd interview-aaronfi
% bundle install
% rake db:drop; rake db:create; rake db:migrate; rake db:seed
% rails server

Then open http://localhost:3000/

### How do I run your unit tests?

% cd interview-aaronfi
% rake

### How do I see your unit test coverage?

% cd interview-aaronfi
% open ./coverage/index.html

### Walk me through your approach.

I decomposed the Rover.com schema into four entities (users, dogs, sittings, and reviews), with future-proofing in mind.

The recovered sample data implies that dog owners and sitters do not overlap.  But really there should be nothing stopping someone from being both an owner and a sitter in the system at the same time.  So, I grouped both roles into the same "Users" entity.

Similarly, the sample data implies that only owners can leave reviews of sitters.  Nonetheless, I made Reviews its own entity, instead of just being attribute information on the Sittings table.  Why?  Doing so allows for sitters to also leave reviews owners (e.g. Uber's two-way review model).  And having all the review text confined to its own table just seemed cleaner.

Lastly, the sample data implies that the same set of dogs per owner were always dog-sat together as a group.  But really this is not a guarantee, as the same <owner,sitter> sitting from one day might include all dogs, but the next day might only include some of them.  So I made Dogs its own entity.  This would accommodate scenarios where dogs change ownership, and also a split payment use cases where two or more owners hire one sitter to sit their combined set of dogs.

For importing the data, I did not do anything robust or proper like writing an importer class that mapped the csv columns into the appropriate creation calls.  Rather I just rigged up an Excel spreadsheet to render the necessary code to be pasted into seeds.rb.  I've included this file at ./reviews.xlsx

The format of a sitting's start_date and end_date was not clear to me, so I just left them as strings, instead of a properly sanitized datetime value.

### What's lacking in your current solution that brings you great shame?

There's no load testing of any kind, so I can't make any guarantees for "search sorting and listing [scaling] well to a large number of records".  Also, a "large number of records" needs to be quanitified, along with desired latency targets for tp90, tp99, etc, performance metrics in the wild.

That said, the scores are currently computed with each insert, so sorting and listing cost is reduced to just an index scan on the user table.  Still, the confluence of reads and writes in one physical location is a service design smell.  It's not hard to imagine load hitting a point where one must sacrifice consistency by decoupling the reads from the writes.  Example:  cleaving off the sorting and listing operations to a dedicated place that only receives score updates every ~5 minutes from our central data repository of events (whether that be in a database table, a message broker's downstream aggregation job, or what not)

I also would prefer to write more unit tests to ensure my scoring logic correctly updates for all events in the wild (e.g. if a user changes their name, the sitter_score should be recalculated;  e.g. are deletes handled appropriately?).  

Lastly, the UI might have some rough areas (e.g. it's not quite mobile responsive).



