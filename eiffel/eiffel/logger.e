indexing
	description: "Logger object.";
	version: "$Revision: 1.1 $";
	author: "Dustin Sallings <dustin@spy.net>";
	copyright: "2002";
	license: "See forum.txt.";

--
-- Copyright (c) 2002  Dustin Sallings
--
-- $Id: logger.e,v 1.1 2002/11/12 00:52:00 dustin Exp $
--
class LOGGER

inherit
	LOGGER_CONSTANTS

creation make

feature {NONE}
	-- test

	make is
	do
		debug_msg("This is a test debug.");
		info_msg("This is a test info.");
		warn_msg("This is a test warning.");
		error_msg("This is a test error.");
	end

feature {NONE}
	-- Logging implementation

	log_msg(level: INTEGER; msg: STRING) is
		-- Log a message at the given level.
		require
			level_is_valid(level);
			msg /= Void;
		local
			msg_ob: LOG_MSG;
		do
			!!msg_ob.make(level, msg)
			io.put_string(msg_ob.get_string)
		end -- log_msg

feature {ANY}
	-- Logging strings.

	debug_msg(msg: STRING) is
		-- Log a message at debug level.
		do
			log_msg(debug_level, msg);
		end

	info_msg(msg: STRING) is
		-- Log a message at info level.
		do
			log_msg(info_level, msg);
		end

	warn_msg(msg: STRING) is
		-- Log a message at warning level.
		do
			log_msg(warn_level, msg);
		end

	error_msg(msg: STRING) is
		-- Log a message at error level.
		do
			log_msg(error_level, msg);
		end

end -- class LOGGER