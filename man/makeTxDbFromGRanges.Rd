\name{makeTxDbFromGRanges}

\alias{makeTxDbFromGRanges}

\title{Make a TxDb object from a GRanges object}

\description{
  The \code{makeTxDbFromGRanges} function allows the user
  to extract gene, transcript, exon, and CDS information from a
  \link[GenomicRanges]{GRanges} object structured as GFF3 or GTF, and
  to return that information in a \link[GenomicFeatures]{TxDb} object.
}

\usage{
makeTxDbFromGRanges(gr, drop.stop.codons=FALSE, metadata=NULL, taxonomyId=NA)
}

\arguments{
  \item{gr}{
    A \link[GenomicRanges]{GRanges} object structured as GFF3 or GTF,
    typically obtained with \code{BiocIO::\link[BiocIO]{import}()}.
  }
  \item{drop.stop.codons}{
    \code{TRUE} or \code{FALSE}. If \code{TRUE}, then features of type
    \code{stop_codon} are ignored. Otherwise (the default) the stop codons
    are considered to be part of the CDS and merged to them.
  }
  \item{metadata}{
    A 2-column data frame containing meta information to be included in the
    \link[GenomicFeatures]{TxDb} object. This data frame is just passed to
    \code{\link{makeTxDb}}, which \code{makeTxDbFromGRanges} calls at the
    end to make the \link[GenomicFeatures]{TxDb} object from the information
    extracted from \code{gr}. See \code{?\link{makeTxDb}} for more information
    about the format of \code{metadata}.
  }
  \item{taxonomyId}{By default this value is NA which will result in
    an NA field since there is no reliable way to infer this from a
    GRanges object.  But you can use this argument to supply your own
    valid taxId here and if you do, then the Organism can be filled in
    as well}
}


\value{A \link[GenomicFeatures]{TxDb} object.}

\author{Hervé Pagès}

\seealso{
  \itemize{
    \item \code{\link{makeTxDbFromUCSC}}, \code{\link{makeTxDbFromBiomart}},
          and \code{\link{makeTxDbFromEnsembl}}, for making a
          \link[GenomicFeatures]{TxDb} object from online resources.

    \item \code{\link{makeTxDbFromGFF}} for making a
          \link[GenomicFeatures]{TxDb} object from a GFF or GTF file.

    \item The \code{\link[BiocIO]{import}} generic function in the
          \pkg{BiocIO} package.

    \item The \code{asGFF} method for \link[GenomicFeatures]{TxDb} objects
          (\link[GenomicFeatures]{asGFF,TxDb-method}) for the reverse of
          \code{makeTxDbFromGRanges}, that is, for turning a
          \link[GenomicFeatures]{TxDb} object into a
          \link[GenomicRanges]{GRanges} object structured as GFF.

    \item \link[GenomicFeatures]{TxDb} objects implemented in the
          \pkg{GenomicFeatures} package.

    \item \code{\link{makeTxDb}} for the low-level function used
          by the \code{makeTxDbFrom*} functions to make the
          \link[GenomicFeatures]{TxDb} object returned to the user.
  }
}

\examples{
library(BiocIO)  # for the import() function

## ---------------------------------------------------------------------
## WITH A GRanges OBJECT STRUCTURED AS GFF3
## ---------------------------------------------------------------------
GFF3_files <- system.file("extdata", "GFF3_files", package="txdbmaker")

path <- file.path(GFF3_files, "a.gff3")
gr <- import(path)
txdb <- makeTxDbFromGRanges(gr)
txdb

## Reverse operation:
gr2 <- asGFF(txdb)

## Sanity check (asGFF() does not propagate the CDS phase at the moment):
target <- as.list(txdb)
target$splicings$cds_phase <- NULL
stopifnot(identical(target, as.list(makeTxDbFromGRanges(gr2))))

## ---------------------------------------------------------------------
## WITH A GRanges OBJECT STRUCTURED AS GTF
## ---------------------------------------------------------------------
GTF_files <- system.file("extdata", "GTF_files", package="txdbmaker")

## test1.gtf was grabbed from http://mblab.wustl.edu/GTF22.html (5 exon
## gene with 3 translated exons):
path <- file.path(GTF_files, "test1.gtf")
gr <- import(path)
txdb <- makeTxDbFromGRanges(gr)
txdb

path <- file.path(GTF_files, "GCA_002204515.1_AaegL5.0_genomic.gtf.gz")
gr <- import(path)
txdb <- makeTxDbFromGRanges(gr)
txdb
}
