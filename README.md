# how_to_submit_to_sunnyvale

## Step 1.

Confirm you can run
```bash
julia -t 12 --project=. my_script.jl 5 cats
```

## Step 2
Configure the .pbs file

## Step 3 
```bash
qsub manual_example.pbs 
```
Creep on your jobs with
```
qstat $JOBID
```
```
qstat -u bpennel
```


