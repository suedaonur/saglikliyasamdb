USE [saglikliyasamdb]
GO
/****** Object:  StoredProcedure [dbo].[AddUserExercise]    Script Date: 5.01.2025 21:13:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Prosedür tanımladık ve parametreleri ekledik
CREATE PROCEDURE [dbo].[AddUserExercise]
    @KullaniciID INT,
    @HareketID INT,
    @EgzersizSuresi INT,
    @Tarih DATE
AS
BEGIN
    -- Kullanıcı egzersiz kaydı ekleme
    INSERT INTO UserExercises (KullaniciID, HareketID, EgzersizSuresi, Tarih)
    VALUES (@KullaniciID, @HareketID, @EgzersizSuresi, @Tarih);

    -- Kullanıcının ilerleme bilgilerini tutmak için değişken tanımlama
    DECLARE @Kilo DECIMAL(5,2);
    DECLARE @VucutYagOrani DECIMAL(5,2);
    DECLARE @KasKutlesi DECIMAL(5,2);

    -- Kullanıcının son ilerleme bilgilerini alır
    SELECT TOP 1 @Kilo = Kilo, @VucutYagOrani = VucutYagOrani, @KasKutlesi = KasKutlesi  --top1 sadece en son kaydı getirir değişkenlere değer atar
    FROM ProgressTracking
    WHERE KullaniciID = @KullaniciID
    ORDER BY Tarih DESC;

    -- Kullanıcının kaydettiğimiz yeni ilerleme kaydını ProgressTracking tablosuna ekler
    INSERT INTO ProgressTracking (KullaniciID, Kilo, VucutYagOrani, KasKutlesi, Tarih)
    VALUES (@KullaniciID, @Kilo, @VucutYagOrani, @KasKutlesi, @Tarih);
END;
GO
