-- TOGGLE XRAY PUBLIC ON/OFF v0.2 by B1313 (Original Script by Slynderdale)
if not markToggle then return end
if inGame() and isPlaying() and not inChat() then
    _togglePublicXRay = not _togglePublicXRay
    if _togglePublicXRay then
        markToggle(true)
        showHint("Публичный X-RAY (Включен)",3)
    else
        markClear()
        markToggle(false)
        markData()
        showHint("Публичный X-RAY (Выключен)",3)
    end
end