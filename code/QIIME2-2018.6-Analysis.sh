!/bin/bash
# AS A PART OF GOOD PRACTICES OF USING CHERRY-CREEK WE DO NOT RUN THE COMMANDS DIRECTLY FROM THE FRONT END, WE FIRST MAKE THE .PBS FILES DEPENDING OUR REQUIREDMENT AND SUBMIT THE JOB TO BE EXICUTED. SAMPLE .pbs FILE IS PROVIDED BELOW
PBS -j oe
PBS -q workq
PBS -m be
PBS -l ncpus=6,mem=110gb
PBS -l walltime=744:00:00
PBS -S /bin/bash

# Activate the QIIME2 environment as
module load conda
source activate qiime2-2018.6 # Select the appropriate version of the QIIME2.

"""
Analysis of C. diff diet data.
You need to import three files to begin the analysis. The R1 read file, R2 read file and barcode file (index file).
To begin analyzing the sequence data you need to download or copy it to the Cherry-Creek server. Have all three files in one folder.
Rename R1 file as forward.fastq.gz and R2 file as reverse.fastq.gz and barcode file as barcode.fastq.gz

Obtain Fastqc report of the fastq files to know about the quality and number of reads.
1. Read count: R1 18899092; R2 18899092
2. Sequence length: 151
"""

echo 'Step 1: Converting R1 and R2 files to qiime artifact. This will create the qiime artifact/object from the sequence and barcode file suitable for further analysis.'

cd /storage/hedlundlab/shrikant/Sequencing_data_Dec2018/

qiime tools import --type EMPPairedEndSequences --input-path seqdata --output-path dec2018_data.qza

echo 'Step 2: Demultiplexing Sequences. This will segregate the sequence reads into individual sample specific reads.'

qiime demux emp-paired --m-barcodes-file map.txt  --m-barcodes-column BarcodeSequence --i-seqs dec2018_data.qza --o-per-sample-sequences dec2018_demux.qza

qiime demux summarize --i-data dec2018_demux.qza --o-visualization dec2018_demux.qzv

echo 'Step 3: Denoising the sequence data using DADA2.'

qiime dada2 denoise-paired --i-demultiplexed-seqs dec2018_data_demux.qza --p-trim-left-f 10 --p-trim-left-r 10 --p-trunc-len-f 151 --p-trunc-len-r 151 --o-table dec2018_data_table.qza --o-representative-sequences dec2018_data_rep-seqs.qza --o-denoising-stats dec2018_data_denoising-stats.qza

echo 'Step 4: Merging the data from previous and  new sequencing runs'

# Step 4a: Change sample IDs, if there are duplicate samples in two runs. In this case, we ran few dummy samples from the previous run to check the sequencing batch effect, hence these are duplicate samples
#NOTE: Avoid using underscore '_' to indicate the new samples, since it is not recommended by QIIME2, try using dash '-' instead. Validate your metadata file using keemei and googlespreadsheet

qiime feature-table group --i-table dec2018_data_table.qza --m-metadata-file map_merge.txt --m-metadata-column NewSampleID --o-grouped-table idchanged_dec2018_table.qza --p-axis sample --p-mode sum
# (Here the NewSampleID column contains the new sample IDs to be used. Note we need to change the original sample IDs from this step onwards to these new once)

# Step4b: Merge the feature tables

qiime feature-table merge --i-tables table.qza --i-tables de2018_data_table.qza --o-merged-table merged_table.qza

echo 'Step 5: Merging the rep_seq.qza'

qiime feature-table merge-seqs --i-data dec2018_data_rep-seqs.qza --i-data rep-seqs.qza --o-merged-data merged-rep-seqs.qza

echo 'Step 6: Aligning merged rep_seq'

qiime alignment mafft --i-sequences merged-rep-seqs.qza --o-alignment aligned-merged-rep-seqs.qza

qiime alignment mask --i-alignment aligned-merged-rep-seqs.qza --o-masked-alignment masked-aligned-merged-rep-seqs.qza

echo 'Step 7: Creating phylogenetic tree'

qiime phylogeny fasttree --i-alignment masked-aligned-merged-rep-seqs.qza --o-tree unrooted-merged-tree.qza

qiime phylogeny midpoint-root --i-tree unrooted-merged-tree.qza --o-rooted-tree rooted-merged-tree.qza

echo 'Step 8: Assigning taxonomy to the rep_seq'

qiime feature-classifier classify-sklearn --i-classifier /storage/hedlundlab/shrikant/classifier_training/silva-trained-classifier.qza --i-reads merged-rep-seqs.qza --o-classification merged-taxonomy.qza --p-confidence 0.8 --p-n-jobs 1 --p-reads-per-batch 20000

echo 'Step 9: Filtering the OTUs/Sequence variants assigned to mitochondria, chloroplast, unassigned etc.'

qiime taxa filter-table --i-table merged_table.qza --i-taxonomy merged-taxonomy.qza --p-exclude mitochondria,chloroplast,eukaryota,unassigned --o-filtered-table filtered-merged-table.qza

echo 'Step 10: Filtering the mice study samples'

qiime feature-table filter-samples --i-table filtered-merged-table.qza --m-metadata-file samples-to-keep.txt --o-filtered-table filtered-final-table.qza

echo 'Step 11: Summarizing the mice study SV table'
qiime feature-table summarize --i-table filtered-final-table.qza --o-visualization filtered-final-table.qzv --m-sample-metadata-file map_merge.txt

echo 'Step 12: Exporting the SV/OTU table and taxonomy for phyloseq Analysis'

qiime tools export micestudy-table.qza --output-dir forphyloseq/
qiime tools export merged-taxonomy.qza --output-dir forphyloseq/
qiime tools export --input-path rooted-merged-tree.qza --output-path forphyloseq/tree

# Make phyloseq object using OTU/SV table, taxonomy table, phylogenetic tree and metedata file in phyloseq for downstream analysis.
