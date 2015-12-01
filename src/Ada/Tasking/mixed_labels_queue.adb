with Lists_of_Integer_Vectors;           use Lists_of_Integer_Vectors;
with Semaphore;

package body Mixed_Labels_Queue is

  labels : List;      -- pointer to the first label
  labels_last : List; -- pointer to the last label
  current : List;     -- pointer to the current label
  previous : List;    -- pointer to the previous label
  done : boolean;     -- state of the production
  appcnt : integer32; -- counts the number of appends
  nxtcnt : integer32; -- counts the number of next
  appsem : Semaphore.Lock; -- semaphore to append
  nxtsem : Semaphore.Lock; -- semaphore to next

  procedure Start is
  begin
    appcnt := 0;
    nxtcnt := 0;
    done := false;
  end Start;

  procedure Append ( idx : in Standard_Integer_Vectors.Link_to_Vector ) is
  begin
    Semaphore.Request(appsem);
    appcnt := appcnt + 1;
    Append(labels,labels_last,idx.all);
    Semaphore.Release(appsem);
  end Append;

  procedure Stop is
  begin
    done := true;
  end Stop;

  function Next return Standard_Integer_Vectors.Link_to_Vector is

    res : Standard_Integer_Vectors.Link_to_Vector := null;

  begin
    Semaphore.Request(nxtsem);
    if nxtcnt = 0
     then current := labels;
    end if;
    if Is_Null(current) then
      if not Is_Null(previous)      -- go back to previous, no longer last?
       then current := Tail_Of(previous);
      end if;
    end if;
    if not Is_Null(current) then
      nxtcnt := nxtcnt + 1;
      res := Head_Of(current);
      previous := current;          -- current may point to the last label
      current := Tail_Of(previous);
    end if;
    Semaphore.Release(nxtsem);
    return res;
  end Next;

  function Next_Counter return integer32 is
  begin
    return nxtcnt;
  end Next_Counter;

  function Stopped return boolean is
  begin
    return done;
  end Stopped;

  procedure Clear is
  begin
    Deep_Clear(labels);
  end Clear;

end Mixed_Labels_Queue;
