User.create!(name:  "Tran Quang Huy",
             email: "huytran.301099@gmail.com",
             password:              "doimkroi",
             password_confirmation: "doimkroi",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)
Car.create!(name: "MARDA",
            namsx: "1990",
            color: "RED",
            price: 1000,
            user_id: 1)
