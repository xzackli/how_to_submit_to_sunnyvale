using Printf

param_list = [("cats", 1), ("dogs",2), ("dolphins",3), ("elephants",4)]

outdir = "/fs/lustre/scratch/zack/how_to_submit_to_sunnyvale/output/"
workdir = "/fs/lustre/scratch/zack/how_to_submit_to_sunnyvale/"
mkpath(joinpath(outdir, "scripts"))

for param in param_list

    animal, num = param
    exec_string = "julia --project=. -t 2 my_script.jl $(animal) $(num)" * raw" $PBS_JOBID"
    script_name = "job_$(animal)_$(num).pbs"
    
    PBS_script = """
#!/bin/bash -l
#PBS -l nodes=1:ppn=2
#PBS -l mem=8gb
#PBS -l walltime=1:00:00
#PBS -r n
#PBS -j oe
#PBS -q sandyq

# go to your working directory containing the batch script, code and data
cd $(workdir)

$(exec_string)
    """
    scriptfile = joinpath(outdir, "scripts", script_name)
    open(scriptfile, "w") do file write(file, PBS_script) end
    run(`qsub $scriptfile`)  # submit PBS file to cluster
end
