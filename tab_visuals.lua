local Tabs = _G.WNDS_UI.Tabs -- WAJIB ADA DI PALING ATAS

Tabs.Visuals:Section({ Title = "ESP & Rendering" })

Tabs.Visuals:Toggle({
    Title = "Enable ESP",
    Default = false,
    Callback = function(Value)
        print("ESP is: ", Value)
        -- Masukkan script ESP kamu di sini
    end
})
