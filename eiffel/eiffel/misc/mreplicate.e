indexing
	description: "The Replicator...";
	version: "$Revision: 1.5 $";

class MREPLICATE

creation make

feature

	make is
		do
			!!db_from.make;
			db_from.set_dbname("modems");
			db_from.set_host("propaganda.spy.net");
			db_from.connect;

			!!db_to.make;
			db_to.set_dbname("modems");
			db_to.set_host("bleu");
			db_to.connect;

			rep_table("mod");
			set_seq("mod_id_seq", "mod", "id");
			rep_table("oem");
			set_seq("oem_id_seq", "oem", "id");
			rep_table("strings");
		end

feature {NONE}

	set_seq(seq, tbl, col: STRING) is
		-- Update a sequence with the latest version.
		require
			seq /= Void;
			tbl /= Void;
			col /= Void;
		local
			query: STRING;
			a: ARRAY[STRING];
		do
			query:="select max(" + col + ")+1 from " + tbl;

			db_to.query(query);
			check db_to.get_row end;
			a:=db_to.last_row;

			query:="select setval(" + seq + "(" + (a @ 0) + ")";

			io.put_string("Setting next " + seq + " to " + a @ 0 + ".%N");

			db_to.query(query);
		end

	rep_table(table: STRING) is
		-- Copy a table.
		local
			a: ARRAY[STRING];
			b: BOOLEAN;
			query: STRING;
			retry_attempt: INTEGER;
		do
			io.put_string("Replicating ");
			io.put_string(table);
			io.put_string(".%N");

			db_to.begin;
			query:="delete from " + table;
			db_to.query(query);

			query:="select * from " + table;
			db_from.query(query);

			from b:=db_from.get_row until b = false loop
				a:=db_from.last_row;

				query:="insert into " + table + " values(" + join(", ", a) +
					")";

				db_to.query(query);
				b:=db_from.get_row
			end

			db_to.commit;
		rescue
			if retry_attempt < max_retry_attempts then
				retry_attempt:=retry_attempt+1;
				retry
			end
		end

	join(with: STRING; a: ARRAY[STRING]): STRING is
		-- Join an array of strings with the given string
		require
			a /= Void;
			a.count > 0;
			with /= Void;
		local
			i: INTEGER;
		do
			!!Result.make(256);
			from
				i:=a.lower
			until
				i>=a.upper
			loop
				Result.append(db_to.quote(a @ i));
				Result.append(with);
				i:=i+1;
			end

			Result.append(db_to.quote(a @ a.upper));
		end

	max_retry_attempts: INTEGER is 3;

	db_from: PG;

	db_to: PG;
end
