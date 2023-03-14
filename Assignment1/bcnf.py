# Allison Tipan V00848862

# Counts the number of steps required to decompose a relation into BCNF.

from relation import *
from functional_dependency import *

# You should implement the static function declared
# in the ImplementMe class and submit this (and only this!) file.
# You are welcome to add supporting classes and methods in this file.
class ImplementMe:

    # This function consolidates all the relations and returns a unioned set.
    @staticmethod
    def RelationsUnion(relations):             
        
        # checks if there is only one relation, if so returns it.
        listofrelations = list(relations.relations)
        if len(listofrelations) == 1:
            return listofrelations[0]
            
        # creates an empty relation and populates with attributes from all relations in 'relations'
        else:
            super_relation = Relation({'to_pop'})
            super_relation.attributes.pop()
            
            for n in relations.relations:                 # iterate through each relation in set
                for attribute in n.attributes:          # itterate through each attribute in a relation
                    if attribute not in super_relation.attributes:

                        super_relation.attributes.add(attribute)        # adds new attributes to create super relation
                        
            
            return super_relation
        

    # This function finds the closure of a functional dependency and returns a set.
    @staticmethod
    def FindClosure(fds, FD):

        # creates the relation 'closure' and adds the left_hand_side attributes first.
        closure = Relation({'to_pop'})
        closure.attributes.pop()
        for x in FD.left_hand_side:
            closure.attributes.add(x)
        
        
        # iterate through all fds in set to add new attributes based on dependencies already in closure
        for i in range (0, len(fds.functional_dependencies)):     # max number of iterations
            
            for f in fds.functional_dependencies:
                flag = True
                for attr in f.left_hand_side:
                    if attr not in closure.attributes:
                        flag = False
                if flag:                                         # if left_hand_side is in closure, adds the right_hand_side attributes
                    for attribute in f.right_hand_side:
                        if attribute not in closure.attributes:
                            closure.attributes.add(attribute)
                
        return closure

    # this function doesn't actually need to be a function. but decided to keep it. 
    # returns true if the fd is a key/superkey
    @staticmethod
    def IsSuperKey(FD, relation, fds):
    
        fdclosure = ImplementMe.FindClosure(fds, FD)  
        return ((relation.attributes == fdclosure.attributes) or (relation.attributes.issubset(fdclosure.attributes)))

    # recursively looks through fds and splits relation based on if the fd is a key or not.
    @staticmethod
    def RecursionFunc(single_relation, originalRelations, fds, decomp):                  
        allSuperKey = True
        for FD in fds.functional_dependencies:
            
            if not ImplementMe.IsSuperKey(FD, single_relation,fds):
                allSuperKey = False
        
        # base case, if all fds are superkeys or there are no fds
        if ((allSuperKey == True) or (len(fds.functional_dependencies)==0)):
            single_decomp = RelationSet({single_relation})
            return single_decomp   
            
        else:
            for single_fd in fds.functional_dependencies:
                FDclosure = ImplementMe.FindClosure(fds, single_fd)         

                if not (single_relation.attributes == FDclosure.attributes):                     # if not superkey
                    
                    # computes complement  relation-closure+LHS
                    complement = Relation(single_relation.attributes.difference(FDclosure.attributes))
                    for attr in single_fd.left_hand_side:
                        complement.attributes.add(attr)

                            
                    # creating 2 empty fd sets to pass with respective relations
                    fdSet1 = FDSet({FunctionalDependency({'to_pop'},{'to_pop2'})})
                    fdSet2 = FDSet({FunctionalDependency({'to_pop'},{'to_pop2'})})
                    fdSet1.functional_dependencies.pop()
                    fdSet2.functional_dependencies.pop()
                    
                    # to grab all the attributes for easy comparison
                    for f in fds.functional_dependencies:
                        extract = set()
                        for a in f.left_hand_side:
                            extract.add(a)
                        for b in f.right_hand_side:
                            extract.add(b)
                        
                        
                        if extract.issubset(complement.attributes):       # split fds according to decomp'd attributes 
                            fdSet1.functional_dependencies.add(f)
                                
                        elif extract.issubset(FDclosure.attributes):
                            fdSet2.functional_dependencies.add(f)
                                
                        else:                                               # else, add to both
                            fdSet1.functional_dependencies.add(f)
                            fdSet2.functional_dependencies.add(f)
                   
                    
                    # recursive call on iteslf for the two new decomposed relations, saves the new decomposed set of relations and adds them to overall decomp set
                    var1 = ImplementMe.RecursionFunc(complement, originalRelations, fdSet1, decomp)
                    for s in var1.relations:
                        decomp.relations.add(s)
                   
                    var2 = ImplementMe.RecursionFunc(FDclosure, originalRelations, fdSet2, decomp)
                    for t in var2.relations:
                        decomp.relations.add(t)

                    return decomp
                else:
                    single_decomp = RelationSet({single_relation})
                    return single_decomp
                    
    


    # Returns the number of recursive steps required for BCNF decomposition
    #
    # The input is a set of relations and a set of functional dependencies.
    # The relations have *already* been decomposed.
    # This function determines how many recursive steps were required for that
    # decomposition or -1 if the relations are not a correct decomposition.
    @staticmethod
    def DecompositionSteps( relations, fds ):
        # get the union set if multiple relations in set
        starting_relation = ImplementMe.RelationsUnion(relations)
        
        # new relation set for my decomp
        decomp = RelationSet({Relation({'to_pop'})})
        decomp.relations.pop()

        # starts recursive call to break down relation based on fd closures
        my_decomp = ImplementMe.RecursionFunc(starting_relation, relations, fds, decomp)
        
        # if the returned set matches one given, returns the iteration count=(size of relationSet - 1)
        if my_decomp == relations:
            return len(my_decomp.relations)-1
        else:  
            pass
                
        # if not a match, returns -1
        return -1

