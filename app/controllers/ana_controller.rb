class AnaController < ApplicationController
  def sayfa
    # 1. Bütün Ajanlar ve Senin İçin Hazırladığım Emojiler
    @ajan_listesi = [
      { isim: "Jett", emojiler: "💨 🗡️ 🇰🇷 🌪️" },
      { isim: "Raze", emojiler: "🚀 💣 🇧🇷 🎨" },
      { isim: "Phoenix", emojiler: "🔥 🇬🇧 👑 🍎" },
      { isim: "Sage", emojiler: "🧊 🧱 🇨🇳 ⛑️" },
      { isim: "Sova", emojiler: "🏹 🦅 🇷🇺 🎯" },
      { isim: "Viper", emojiler: "☣️ 🧪 🇺🇸 😷" },
      { isim: "Cypher", emojiler: "🤠 📷 🇲🇦 🕸️" },
      { isim: "Reyna", emojiler: "👁️ 💜 🇲🇽 😈" },
      { isim: "Killjoy", emojiler: "🤖 💻 🇩🇪 💛" },
      { isim: "Breach", emojiler: "💥 🔨 🇸🇪 🦾" },
      { isim: "Omen", emojiler: "👻 🌌 🗺️ 👁️‍🗨️" },
      { isim: "Brimstone", emojiler: "☄️ 📻 🇺🇸 👨‍✈️" }
    ]

    # Oyun ilk kez açılıyorsa veya sıfırlandıysa hafızayı kur
    session[:tur] ||= 0
    session[:skorlar] ||= []

    # Eğer oyun bittiyse ve yeniden başla dediyse sıfırla
    if params[:reset]
      session[:tur] = 0
      session[:skorlar] = []
    end

    @guncel_tur = session[:tur]
    @toplam_tur = @ajan_listesi.length

    # Eğer turlar bitmediyse güncel ajanı seç
    if @guncel_tur < @toplam_tur
      @guncel_ajan = @ajan_listesi[@guncel_tur]
    end

    # Kullanıcı combobox'tan ajanı seçip "Kilitle" butonuna bastıysa
    if request.post? && params[:secilen_ajan].present?
      tahmin = params[:secilen_ajan]
      dogru_cevap = @guncel_ajan[:isim]

      if tahmin == dogru_cevap
        session[:skorlar] << "dogru"
      else
        session[:skorlar] << "yanlis"
      end

      # Bir sonraki tura geç ve sayfayı yenile
      session[:tur] += 1
      redirect_to root_path
    end
  end
end