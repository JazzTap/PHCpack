// Test on the operations in the Job Queue

#include <unistd.h>
#include "jobqueue.h"
#include "worker.h"

using namespace std;

int process_jobs ( int nbt, JobQueue* jobs );
/*
 * Processing the jobs with nbt threads. */

void* do_job ( void* args );
/*
 * Processes the jobs in the job queue, given in args. */

int main ( void )
{
   int nbr;
   cout << "Give the number of jobs : ";
   cin >> nbr;

   JobQueue jobs(nbr);

   jobs.write();

   while(1)
   {
      int nextjob = jobs.get_next_job();

      if(nextjob == -1) break;

      cout << "Index of the next job : " << nextjob
           << " with work " << jobs.work[nextjob] << endl;
   }

   *jobs.nextjob = -1; // reset the job queue
   int nbt;
   cout << "Give the number threads : ";
   cin >> nbt;

   int fail = process_jobs(nbt,&jobs);

   return 0;
}

int process_jobs ( int nbt, JobQueue* jobs )
{
   Worker *crew = (Worker*)calloc(nbt,sizeof(Worker));

   for(int i=0; i<nbt; i++) crew[i].idn = i;

   for(int i=0; i<nbt; i++) crew[i].write();

   for(int i=0; i<nbt; i++) crew[i].work(&do_job,(void*)jobs);

   for(int i=0; i<nbt; i++) crew[i].join();

   return 0;
}

void* do_job ( void* args )
{
   JobQueue *jobs = (JobQueue*) args;

   while(1)
   {
      int nextjob = jobs->get_next_job();

      if(nextjob == -1) break;

      cout << "Index of the next job : " << nextjob
           << " with work " << jobs->work[nextjob] << endl;

      sleep(jobs->work[nextjob]);
   }

   return NULL;
}
