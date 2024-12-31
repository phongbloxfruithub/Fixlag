-- Script tối ưu hóa cho Blox Fruits: Giảm một nửa đồ họa và hiệu ứng
local function optimizeGame()
    -- Giảm chất lượng đồ họa
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level03 -- Chất lượng đồ họa trung bình thấp

    -- Giảm hiệu ứng hạt, Trails, Beams (giảm một nửa thay vì tắt hoàn toàn)
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ParticleEmitter") then
            obj.Rate = obj.Rate * 0.5 -- Giảm số lượng hạt
        elseif obj:IsA("Trail") or obj:IsA("Beam") then
            obj.Enabled = false -- Tắt hoàn toàn
        end
    end

    -- Giảm ánh sáng
    local lighting = game:GetService("Lighting")
    lighting.Brightness = 1 -- Độ sáng vừa phải
    lighting.GlobalShadows = false -- Tắt bóng toàn cảnh
    lighting.OutdoorAmbient = Color3.new(0.6, 0.6, 0.6) -- Ánh sáng trung bình
    lighting.TimeOfDay = "14:00:00" -- Ánh sáng cố định ban ngày

    -- Giảm bóng của các đối tượng
    for _, part in ipairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CastShadow = false -- Tắt bóng vật thể
        end
    end

    -- Giảm kích thước và hiển thị Textures
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Texture") or obj:IsA("Decal") then
            obj.Transparency = 0.3 -- Làm mờ nhưng vẫn hiển thị
        end
    end

    -- Giảm âm thanh nhưng giữ lại những âm thanh quan trọng
    local soundService = game:GetService("SoundService")
    for _, sound in ipairs(soundService:GetDescendants()) do
        if sound:IsA("Sound") then
            sound.Volume = math.clamp(sound.Volume * 0.5, 0, 1) -- Giảm âm lượng còn 50%
        end
    end

    -- Tăng FPS bằng cách giảm tốc độ hiển thị các đối tượng xa
    local player = game.Players.LocalPlayer
    if player then
        local camera = workspace.CurrentCamera
        camera.FieldOfView = 70 -- Giảm góc nhìn để cải thiện FPS
    end
end

-- Kích hoạt script khi bắt đầu
optimizeGame()
game.Players.LocalPlayer.CharacterAdded:Connect(optimizeGame)