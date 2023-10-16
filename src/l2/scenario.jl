"""
    scenario.jl

# Description
Definitions of collections of experiences and how they are created from scenarios.

# Authors
- Sasha Petrenko <petrenkos@mst.edu> @AP6YC
"""

# -----------------------------------------------------------------------------
# ALIASES
# -----------------------------------------------------------------------------

"""
Alias for a queue of [`Experience`](@ref)s.
"""
const ExperienceQueue = Deque{Experience}

"""
Alias for a statistics dictionary being string keys mapping to any object.
"""
const StatsDict = Dict{String, Any}

# -----------------------------------------------------------------------------
# STRUCTS
# -----------------------------------------------------------------------------

"""
Container for the [`ExperienceQueue`](@ref) and some statistics about it.
"""
struct ExperienceQueueContainer
    """
    The [`ExperienceQueue`](@ref) itself.
    """
    queue::ExperienceQueue

    """
    The statistics about the queue.
    **NOTE** These statistics reflect the queue at construction, not after any processing.
    """
    stats::StatsDict
end

# -----------------------------------------------------------------------------
# CONSTRUCTORS
# -----------------------------------------------------------------------------

"""
Initializes an [`ExperienceQueueContainer`](@ref) from the provided scenario dictionary.

# Arguments
- `eqc::ExperienceQueueContainer`: the container with the queue and stats to initialize.
- `scenario_dict::AbstractDict`: the dictionary with the scenario regimes and block types.
"""
function initialize_exp_queue!(eqc::ExperienceQueueContainer, scenario_dict::AbstractDict)
    # Initialize the incremented counts and stats
    eqc.stats["n_train"] = 0    # Number of training blocks
    eqc.stats["n_test"] = 0     # Number of testing blocks
    exp_num = 0                 # Experience count
    block_num = 0               # Block count

    # Iterate over each learning/testing block
    for block in scenario_dict["scenario"]
        # Increment the block count
        block_num += 1
        # Get the block type as "train" or "test"
        block_type = block["type"]
        # Verify the block type
        sanitize_block_type(block_type)
        # Stats on the blocks
        if block_type == "train"
            eqc.stats["n_train"] += 1
        elseif block_type == "test"
            eqc.stats["n_test"] += 1
        end
        # Iterate over the regimes of the block
        for regime in block["regimes"]
            # Reinitialize the task-specific count
            task_num = 0
            # Iterate over each count within the current regime
            for _ in 1:regime["count"]
                # Increment the experience count
                exp_num += 1
                # Increment the task-specific count
                task_num += 1
                # Get the task name
                task_name = regime["task"]
                # Create a sequence number container for the block and experience
                seq = SequenceNums(block_num, exp_num, task_num)
                # Create an experience for all of the above
                exp = Experience(task_name, seq, block_type)
                # Add the experience to the top of the Deque
                push!(eqc.queue, exp)
            end
        end
    end

    # Post processing stats
    eqc.stats["length"] = length(eqc.queue)
    eqc.stats["n_blocks"] = block_num

    # Exit with no return
    return
end

"""
Creates an empty [`ExperienceQueueContainer`](@ref) with an empty queue and zeroed stats.
"""
function ExperienceQueueContainer()
    # Create an empty statistics container
    stats = StatsDict(
        "length" => 0,
        "n_blocks" => 0,
        "n_train" => 0,
        "n_test" => 0,
    )

    # Create an empty experience Deque
    exp_queue = Deque{Experience}()

    # Return the a container with the experiences
    return ExperienceQueueContainer(
        exp_queue,
        stats,
    )
end

"""
Creates a queue of [`Experience`](@ref)s from the scenario dictionary.

# Arguments
- `scenario_dict::AbstractDict`: the scenario dictionary.
"""
function ExperienceQueueContainer(scenario_dict::AbstractDict)
    # Create the empty queue container
    eqc = ExperienceQueueContainer()

    # Add the scenario to the queue
    initialize_exp_queue!(eqc, scenario_dict)

    # Return the populated queue.
    return eqc
end

# -----------------------------------------------------------------------------
# TYPE OVERLOADS
# -----------------------------------------------------------------------------

"""
Overload of the show function for [`ExperienceQueue`](@ref).

# Arguments
- `io::IO`: the current IO stream.
- `cont::ExperienceQueueContainer`: the [`ExperienceQueueContainer`](@ref) to print/display.
"""
function Base.show(io::IO, queue::ExperienceQueue)
    # compact = get(io, :compact, false)
    print(
        io,
        """
        ExperienceQueue of type $(ExperienceQueue)
        Length: $(length(queue))
        """
    )
end

"""
Overload of the show function for [`ExperienceQueueContainer`](@ref).

# Arguments
- `io::IO`: the current IO stream.
- `cont::ExperienceQueueContainer`: the [`ExperienceQueueContainer`](@ref) to print/display.
"""
function Base.show(io::IO, cont::ExperienceQueueContainer)
    # compact = get(io, :compact, false)
    print(
        io,
        """
        ExperienceQueueContainer
        ExperienceQueue
        \tType: $(ExperienceQueue)
        Stats:
        \tLength: $(cont.stats["length"])
        \tBlocks: $(cont.stats["n_blocks"])
        \tTrain blocks: $(cont.stats["n_train"])
        \tTest blocks: $(cont.stats["n_test"])
        """
    )
end

# -----------------------------------------------------------------------------
# FUNCTIONS
# -----------------------------------------------------------------------------

"""
Adds entry to a dictionary from a struct with fields.

Meant to be used with [`StatsDict`](@ref).

# Arguments
- `dict::AbstractDict`: the [`StatsDict`](@ref) dictionary to add entries to.
- `opts::Any`: a struct containing fields, presumably of options, to add as key-value entries to the dict.
"""
function fields_to_dict!(dict::AbstractDict, opts::Any)
    # Iterate over every fieldname of the type
    for name in fieldnames(typeof(opts))
        # Add an entry with a string name of the field and the value from the opts.
        dict[string(name)] = getfield(opts, name)
    end
end
