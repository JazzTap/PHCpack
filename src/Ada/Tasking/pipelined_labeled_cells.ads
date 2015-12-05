with Standard_Natural_Numbers;          use Standard_Natural_Numbers;
with Standard_Integer_Numbers;          use Standard_Integer_Numbers;
with Standard_Integer_Vectors;
with Standard_Floating_Vectors;
with Standard_Integer_VecVecs;
with Floating_Mixed_Subdivisions;       use Floating_Mixed_Subdivisions;
with Cell_Stack;                        use Cell_Stack;

package Pipelined_Labeled_Cells is

-- DESCRIPTION :
--   A pipeline of producing and processing cells consists in running
--   the MixedVol Algorithm with a callback function by one tasks.
--   The other tasks are processing the cells.

  procedure Produce_Cells
              ( nbequ,nbpts,r : in integer32; otp : in boolean;
                mtype,idx : in Standard_Integer_Vectors.Link_to_Vector;
                vtx : in Standard_Integer_VecVecs.Link_to_VecVec;
                lft : in Standard_Floating_Vectors.Link_to_Vector;
                cells : out CellStack; nbcells : out integer32;
                mixvol : out natural32 );

  -- DESCRIPTION :
  --   This code calls the mixedvol algorithm with a callback function.
  --   The callback function places the labels to the points in the
  --   mixed cells into a queue.

  -- ON ENTRY :
  --   nbequ    the number of equations in the input Laurent system;
  --   nbpts    the total number of points in the supports;
  --   r        number of different supports;
  --   otp      flag for intermediate output to screen;
  --   mtype    type of mixture;
  --   idx      index to the vertex set;
  --   vtx      vertex points;
  --   lft      lifting values for the vertex points.

  -- ON RETURN :
  --   cells    a stack of labels to the mixed cells;
  --   nbcells  number of mixed cells;
  --   mixvol   the mixed volume.

  procedure Process_Cells 
              ( idtask,nbequ,nbpts,r : in integer32; otp : in boolean;
                mtype,perm : in Standard_Integer_Vectors.Link_to_Vector;
                vtx : in Standard_Integer_VecVecs.Link_to_VecVec;
                lft : in Standard_Floating_Vectors.Link_to_Vector;
                mcc : in out Mixed_Subdivision;
                process : access procedure
                  ( r : in integer32;
                    mtype : in Standard_Integer_Vectors.Link_to_Vector;
                    mic : in out Mixed_Cell ) := null );

  -- DESCRIPTION :
  --   This code is executed by task with identification number
  --   equal to idtask.  The labels to the mixed cells are converted
  --   into mixed cells and stored in a mixed cell configuration.

  -- ON ENTRY :
  --   idtask   identification number of the task;
  --   nbequ    the number of equations in the input Laurent system;
  --   nbpts    the total number of points in the supports;
  --   otp      flag for intermediate output to screen;
  --   r        the number of distinct supports;
  --   mtype    type of mixture;
  --   perm     permutation used to permute the supports;
  --   vtx      coordinates of the vertex points;
  --   lft      lifting values for the vertex points.

  -- ON RETURN :
  --   mcc      the mixed cells processed by task with id idtask;
  --   process  optional callback procedure to process each mixed
  --            cell as soon as it is computed.

  procedure Pipelined_Mixed_Cells
              ( ntasks,nbequ,nbpts : in integer32; otp : in boolean;
                ind,cnt : in Standard_Integer_Vectors.Vector;
                support : in Standard_Integer_Vectors.Link_to_Vector;
                r : out integer32;
                mtype,perm : out Standard_Integer_Vectors.Link_to_Vector;
                sub : out Mixed_Subdivision; mv : out natural32;
                process : access procedure
                  ( r : in integer32;
                    mtype : in Standard_Integer_Vectors.Link_to_Vector;
                    mic : in out Mixed_Cell) := null );

  -- DESCRIPTION :
  --   Constructs a regular mixed cell configuration for the support.
  --   The production of the labels to the mixed cells is interlaced
  --   with the processing of the labels into a mixed cell format.

  -- ON ENTRY :
  --   ntasks   the number of tasks;
  --   nbequ    the number of equations in the input Laurent system;
  --   nbpts    the total number of points in the supports;
  --   otp      flag for intermediate output to screen;
  --   ind      ind(k) marks the beginning of the k-th support;
  --   cnt      cnt(k) counts the number of points in the k-th support;
  --   support  vector range 1..nbequ*nbpts with the coordinates of
  --            all points in the supports;
  --   process  optional callback procedure to process each mixed
  --            cell as soon as it is computed.

  -- ON RETURN :
  --   r        number of distinct supports;
  --   mtype    the type of mixture of the supports;
  --   perm     permutation of the supports;
  --   sub      a mixed cell configuration for a random lifting.

end Pipelined_Labeled_Cells;
