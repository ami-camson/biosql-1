--
-- SQL script to create the trigger(s) enabling the load API for
-- SGLD_Seqfeature_Locations.
--
-- Scaffold auto-generated by gen-api.pl.
--
--
-- $Id: Seqfeature_Locations.trg,v 1.1.1.2 2003-01-29 08:54:36 lapp Exp $
--

--
-- (c) Hilmar Lapp, hlapp at gnf.org, 2002.
-- (c) GNF, Genomics Institute of the Novartis Research Foundation, 2002.
--
-- You may distribute this module under the same terms as Perl.
-- Refer to the Perl Artistic License (see the license accompanying this
-- software package, or see http://www.perl.com/language/misc/Artistic.html)
-- for the terms under which you may use, modify, and redistribute this module.
-- 
-- THIS PACKAGE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
-- WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
-- MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
--

CREATE OR REPLACE TRIGGER BIUR_Seqfeature_Locations
       INSTEAD OF INSERT OR UPDATE
       ON SGLD_Seqfeature_Locations
       REFERENCING NEW AS new OLD AS old
       FOR EACH ROW
DECLARE
	pk		SG_SEQFEATURE_LOCATION.OID%TYPE DEFAULT :new.Loc_Oid;
	do_DML		INTEGER DEFAULT BSStd.DML_NO;
BEGIN
	IF INSERTING THEN
		do_DML := BSStd.DML_I;
	ELSE
		-- this is an update
		do_DML := BSStd.DML_UI;
	END IF;
	-- do insert or update (depending on whether it exists or not)
	pk := Loc.get_oid(
			Loc_OID => pk,
		        Loc_START_POS => Loc_START_POS,
			Loc_END_POS => Loc_END_POS,
			Loc_STRAND => Loc_STRAND,
			Loc_RANK => Loc_RANK,
			Loc_FEA_OID => FEA_OID_,
			Loc_ENT_OID => ENT_OID_,
			do_DML             => do_DML);
END;
/