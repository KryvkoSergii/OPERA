# to run the script, copy feature, scripts datasets and src directories
# script example for running: sh scripts/eval_all.sh OPERA-GT 1280  >> out/multiple150.txt

pretrain_model=$1
if [ $# -gt 1 ]; then
        dim=$2
        echo 'Feature dimension:' $dim
else
        dim=0
        echo 'Baseline: no need to specify dimension'
fi

# task 1
#echo extracting feature from $pretrain_model for downstream Task1;
#python -u src/benchmark/processing/coviduk_processing.py --pretrain $pretrain_model --modality exhalation --dim $dim
#
#echo linear evaluation of $pretrain_model on downstream Task1;
#python src/benchmark/linear_eval.py --task coviduk --pretrain $pretrain_model --modality exhalation --dim $dim

# task 2 (53 GB of data)
echo extracting feature from $pretrain_model for downstream Task2;
python -u src/benchmark/processing/coviduk_processing.py --pretrain $pretrain_model --modality cough --dim $dim

echo linear evaluation of $pretrain_model on downstream Task2;
python src/benchmark/linear_eval.py --task coviduk --pretrain $pretrain_model --modality cough --dim $dim

## task 3 (53 GB of data)
#echo extracting feature from $pretrain_model for downstream Task3;
#python -u src/benchmark/processing/covid19sounds_processing.py --task 1  --pretrain $pretrain_model  --modality breath  --dim $dim
#
#echo linear evaluation of $pretrain_model on downstream Task3;
#python src/benchmark/linear_eval.py --task covid19sounds  --modality breath  --pretrain $pretrain_model  --dim $dim
#
## task 4 (COVID-19 Sounds requires request from academic institutions)
#echo extracting feature from $pretrain_model for downstream Task4;
#python -u src/benchmark/processing/covid19sounds_processing.py --task 1  --pretrain $pretrain_model  --modality cough  --dim $dim
#
#echo linear evaluation of $pretrain_model on downstream Task4;
#python src/benchmark/linear_eval.py --task covid19sounds  --modality cough  --pretrain $pretrain_model  --dim $dim
#
# task 5 (preccessed)
#echo extracting feature from $pretrain_model for downstream Task5;
#python -u src/benchmark/processing/coughvid_processing.py   --pretrain $pretrain_model  --label covid  --dim $dim
#
#echo linear evaluation of $pretrain_model on downstream Task5;
#python src/benchmark/linear_eval.py --task coughvidcovid --pretrain $pretrain_model --dim $dim
#
## task 7
echo extracting feature from $pretrain_model for downstream Task7;
python -u src/benchmark/processing/icbhi_processing.py  --pretrain $pretrain_model --dim $dim

echo linear evaluation of $pretrain_model on downstream Task7;
python src/benchmark/linear_eval.py --task icbhidisease  --pretrain $pretrain_model --dim $dim
#
## task 10
#echo extracting feature from $pretrain_model for downstream Task10;
#python -u src/benchmark/processing/kauh_processing.py --pretrain $pretrain_model --dim $dim
#
#echo linear evaluation of $pretrain_model on downstream Task10;
#python src/benchmark/linear_eval.py --task kauh --pretrain $pretrain_model --dim $dim



