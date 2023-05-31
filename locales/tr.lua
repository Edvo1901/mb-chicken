local Translations = {
    notify = {
        title = "Kasap",
    },
    success = {
        put_alive_chicken_in_trunk = "Tüm canlı tavukları bagaja koyun",
        keep_going_or_sell = "Ya paketlemeye devam edebilirsin ya da satabilirsin.",
        put_chicken_on_car = "Tüm tavuk etini bagaja koyun",
        catch_success = "Yoooo!! Tamamdır.",
        sold_chicken = "Bütün paketlenmiş tavukları $%{price} satıyorsun.",
    },
    error = {
        get_out_of_vehicle = "Araç içindeyken çalışmaya başlayamazsınız",
        no_alive_chicken = "İşlemek için canlı tavuğunuz yok",
        no_slaughtered_chicken = "İşleyecek tavuk etiniz yok",
        no_packaged_chicken = "Satmak için paketlenmiş tavuğunuz yok.",
        catch_failed = "Oh hayır!! Bir tavuğa mı yenildin???",
    },
    action = {
        get_started = "~g~[E]~w~ Tavuk yakalamaya başla",
        catching = "~o~[E]~b~ Yakalayın",
        cut_alive_chicken = "~g~[E]~w~ Tavuk işleyin",
        pack_chicken = "~g~[E]~w~ Tavuk paketleyin",
        stop_packing = "~g~[G]~w~ Paketlemeyi bırak",
        keep_packing = "~g~[E]~w~ Paketlemeye devam edin",
        sell_packing = "~g~[E]~w~ Tavuk sat",
        bring_close_to_vehicle = "Kutuyu aracınızın yanına getirin",
    },
    process = {
        packing = "Paketleniyor...",
        cutting = "Parçalanıyor...",
        selling = "Satılıyor...",
    }
}

if GetConvar('qb_locale', 'en') == 'tr' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
