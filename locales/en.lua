local Translations = {
    notify = {
        title = "CHICKEN JOB",
    },
    success = {
        put_alive_chicken_in_trunk = "Put all the alive chicken to the trunk",
        keep_going_or_sell = "You can either keep packing or go sell it",
        put_chicken_on_car = "Put all the chicken meat to the trunk",
        catch_success = "Yoooo!! You got it",
        sold_chicken = "You sell all the packaged chicken for $%{price}",
    },
    error = {
        get_out_of_vehicle = "You cannot start the work while in a vehicle",
        no_alive_chicken = "You dont have alive chicken to process",
        no_slaughtered_chicken = "You dont have chicken meat to process",
        no_packaged_chicken = "You dont have packaged chicken to sell",
        catch_failed = "Oh noo!! You lost to a chicken???",
    },
    action = {
        get_started = "~g~[E]~w~ Start catching chicken",
        catching = "~o~[E]~b~ Catch it",
        cut_alive_chicken = "~g~[E]~w~ Process chicken",
        pack_chicken = "~g~[E]~w~ Pack chicken",
        stop_packing = "~g~[G]~w~ Stop packing",
        keep_packing = "~g~[E]~w~ Keep packing",
        sell_packing = "~g~[E]~w~ Sell chicken",
        bring_close_to_vehicle = "Bring the box to your vehicle",
    },
    process = {
        packing = "Packing...",
        cutting = "Cutting...",
        selling = "Selling...",
    }
}

Lang = Lang or Locale:new({
    phrases = Translations,
    warnOnMissing = true
})