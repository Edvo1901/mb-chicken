local Translations = {
    notify = {
        title = "Nghề gà",
    },
    success = {
        put_alive_chicken_in_trunk = "Đã cất gà sống vào xe",
        keep_going_or_sell = "Bạn có thể tiếp tục đóng gói hoặc đem bán",
        put_chicken_on_car = "Đã để gà lên xe",
        catch_success = "Đã bắt được gà",
        sold_chicken = "Bạn đã bán toàn bộ thịt gà với giá $%{price}",
    },
    error = {
        get_out_of_vehicle = "Không thể bắt đầu công việc khi đang trong xe",
        no_alive_chicken = "Không có gà sống để mổ",
        no_slaughtered_chicken = "Không có thịt gà để đóng gói",
        no_packaged_chicken = "Không có thịt gà để bán",
        catch_failed = "Gà đã chạy thoát",
    },
    action = {
        get_started = "~g~[E]~w~ Bắt đầu bắt gà",
        catching = "~o~[E]~b~ Bắt gà",
        cut_alive_chicken = "~g~[E]~w~ Cắt thịt gà",
        pack_chicken = "~g~[E]~w~ Đóng gói thịt",
        stop_packing = "~g~[G]~w~ Dừng đóng gói",
        keep_packing = "~g~[E]~w~ Tiếp tục đóng gói",
        bring_close_to_vehicle = "Hãy mang gà tới gần xe",
    },
    process = {
        packing = "Đang đóng gói..",
        cutting = "Đang cắt thịt..",
        selling = "Đang bán gà..",
    }
}

if GetConvar('qb_locale', 'en') == 'vn' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end