\name{makeFeatureDbFromUCSC}

\alias{supportedUCSCFeatureDbTracks}
\alias{supportedUCSCFeatureDbTables} 
\alias{UCSCFeatureDbTableSchema}
\alias{makeFeatureDbFromUCSC}

\title{
  Making a FeatureDb object from annotations available at the
  UCSC Genome Browser
}
\description{
  WARNING: The FeatureDb/makeFeatureDbFromUCSC/features code base is
  no longer actively maintained and FeatureDb-related functionalities
  might get deprecated in the near future.

  The \code{makeFeatureDbFromUCSC} function allows the user
  to make a \link[GenomicFeatures]{FeatureDb} object from simple annotation
  tracks at UCSC.  The tracks in question must (at a minimum) have a start,
  end and a chromosome affiliation in order to be made into a
  \link[GenomicFeatures]{FeatureDb}.
  This function requires a precise declaration of its first three
  arguments to indicate which genome, track and table wish to be
  imported.  There are discovery functions provided to make this process
  go smoothly.
}
\usage{
supportedUCSCFeatureDbTracks(genome)

supportedUCSCFeatureDbTables(genome, track)
 
UCSCFeatureDbTableSchema(genome,
                         track,
                         tablename)

makeFeatureDbFromUCSC(
        genome,
        track,
        tablename,
        columns = UCSCFeatureDbTableSchema(genome,track,tablename),
        url="https://genome.ucsc.edu/cgi-bin/",
        goldenPath.url=getOption("UCSC.goldenPath.url"),
        chromCol, 
        chromStartCol, 
        chromEndCol,
        taxonomyId=NA)
}
\arguments{
  \item{genome}{genome abbreviation used by UCSC and listed in
    \code{\link{list_UCSC_genomes}()[ , "genome"]}.
        For example: \code{"hg18"}.}
  \item{track}{name of the UCSC track.  Use
    \code{supportedUCSCFeatureDbTracks} to get the list of available
        tracks for a particular genome}
  \item{tablename}{name of the UCSC table containing the annotations to
        retrieve. Use the \code{supportedUCSCFeatureDbTables} utility
        function to get the list of supported tables for a track.}
  \item{columns}{a named character vector to list out the names and
        types of the other columns that the downloaded track should
        have.  Use \code{UCSCFeatureDbTableSchema} to retrieve this
        information for a particular table.}
  \item{url,goldenPath.url}{use to specify the location of an
        alternate UCSC Genome Browser.}
  \item{chromCol}{If the schema comes back and the 'chrom' column has been 
        labeled something other than 'chrom', use this argument to indicate 
        what that column has been labeled as so we can properly designate it.
        This could happen (for example) with the knownGene track tables, which
        has no 'chromStart' or 'chromEnd' columns, but which DOES have columns
        that could reasonably substitute for these columns under particular 
        circumstances.  Therefore we allow these three columns to have arguments
        so that their definition can be re-specified}
  \item{chromStartCol}{Same thing as chromCol, but for renames of 'chromStart'}
  \item{chromEndCol}{Same thing as chromCol, but for renames of 'chromEnd'}
  \item{taxonomyId}{By default this value is NA and the organism
    inferred will be used to look up the correct value for this.  But
    you can use this argument to override that and supply your own
    valid taxId here.}
}
\details{
  \code{makeFeatureDbFromUCSC} is a convenience function that builds a
        tiny database from one of the UCSC track tables.

  \code{supportedUCSCFeatureDbTracks} is a convenience function that
        returns potential track names that could be used to make
        FeatureDb objects.

  \code{supportedUCSCFeatureDbTables} is a convenience function that
        returns potential table names for FeatureDb objects (table names
        go with a track name).

  \code{UCSCFeatureDbTableSchema} is a convenience function that creates a
        named vector of types for all the fields that can potentially be
        supported for a given track.  By default, this will be called on
        your specified tablename to include all of the fields in a track.
}

\value{
  A \link[GenomicFeatures]{FeatureDb} object for \code{makeFeatureDbFromUCSC}.
  Or in the case of \code{supportedUCSCFeatureDbTracks} and
  \code{UCSCFeatureDbTableSchema} a named character vector}

\author{M. Carlson}

\seealso{
  \code{\link{list_UCSC_genomes}}
}

\examples{
## Display the list of genomes available at UCSC:
list_UCSC_genomes()[ , "genome"]

## Display the list of Tracks supported by makeFeatureDbFromUCSC():
# supportedUCSCFeatureDbTracks("mm10")

## Display the list of tables supported by your track:
supportedUCSCFeatureDbTables(genome="mm10",
                             track="qPCR Primers")

## Display fields that could be passed in to colnames:
UCSCFeatureDbTableSchema(genome="mm10",
                         track="qPCR Primers",
                         tablename="qPcrPrimers")

## Retrieving a full transcript dataset for Mouse from UCSC:
fdb <- makeFeatureDbFromUCSC(genome="mm10",
                              track="qPCR Primers",
                              tablename="qPcrPrimers")
fdb
}
