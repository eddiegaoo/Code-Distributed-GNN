mkdir results
for i in 1
do 
    for N_PARTITIONS in 8
    do
     for SAMPLING_RATE in 0.10
     do
        echo -e "\033[1mclean python processes\033[0m"
        sleep 1s && pkill -9 python3 && pkill -9 python && sleep 1s
        echo -e "\033[1m${N_PARTITIONS} partitions, ${SAMPLING_RATE} sampling rate\033[0m"
        python main.py \
          --dataset reddit \
          --dropout 0.5 \
          --lr 0.01 \
          --n-partitions ${N_PARTITIONS} \
          --n-epochs 3000 \
          --model graphsage \
          --sampling-rate ${SAMPLING_RATE} \
          --n-layers 4 \
          --n-hidden 256 \
          --log-every 10 \
          --inductive \
          --use-pp \
          |& tee results/reddit${i}_n${N_PARTITIONS}_p${SAMPLING_RATE}_full.txt
      done
    done
done
