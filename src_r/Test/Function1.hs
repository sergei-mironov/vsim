module Main where
import VSim.Runtime
 
elab :: Elab IO ()
elab
  = do 
  
       integer_standard_std <- alloc_ranged_type
                                 (alloc_range (int (-2147483648)) (int 2147483647))
       arr01_test <- alloc_array_type (alloc_range (int 0) (int 1))
                       integer_standard_std
       c1 <- alloc_constant integer_standard_std defval
       (severity_level_standard_std,
        [note, warning, error, failure]) <- alloc_enum_type 4
       (boolean_standard_std, [false, true]) <- alloc_enum_type 2
       p1_work <- alloc_function
                    (\ a1' ->
                       (do let a1 = a1'
                           return
                             (do 
                                 retf (alloc_constant integer_standard_std (
                                    assign (index (int 0) (pure a1))))
                                 fail "retf failed")))
       main_test <- alloc_process_let "main_test" []
                      (do i <- alloc_variable "i" arr01_test
                                 (aggregate [(access_all (assign (int 33)))])
                          x <- alloc_variable "x" integer_standard_std (assign (int 10))
                          return
                            (do (.=.) (pure x) (assign (call (p1_work << (pure i))))
                                report (t_image (pure x) integer_standard_std)
                                assert
                                return ()))
       return ()
main = do sim maxBound elab
