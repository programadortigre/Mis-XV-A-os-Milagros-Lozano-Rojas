$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$out = Join-Path $root "assets\images"
New-Item -ItemType Directory -Force -Path $out | Out-Null
$videoOut = Join-Path $root "assets\video"
$audioOut = Join-Path $root "assets\audio"
New-Item -ItemType Directory -Force -Path $videoOut | Out-Null
New-Item -ItemType Directory -Force -Path $audioOut | Out-Null

$assets = @(
  @{f="background_movil_9x16.png";u="https://mis.xv-valerie.momentsbybl.com/__l5e/assets-v1/bc2590c1-7e5d-41b1-905f-0753543b0188/background_movil_9x16.png"},
  @{f="estela_destellos.png";u="https://mis.xv-valerie.momentsbybl.com/__l5e/assets-v1/54b25369-2841-4ee6-9900-7f8d497e2e8d/estela_destellos.png"},
  @{f="mariposa_01.png";u="https://mis.xv-valerie.momentsbybl.com/__l5e/assets-v1/98a20204-662f-40d9-bad0-650da2283960/mariposa_01.png"},
  @{f="mariposa_02.png";u="https://mis.xv-valerie.momentsbybl.com/__l5e/assets-v1/4b996bc4-bcc8-4ea2-8220-b9fb28e91ae1/mariposa_02.png"},
  @{f="mariposa_03.png";u="https://mis.xv-valerie.momentsbybl.com/__l5e/assets-v1/12b09e2f-b267-4556-b50c-a32515915b94/mariposa_03.png"},
  @{f="mariposa_04.png";u="https://mis.xv-valerie.momentsbybl.com/__l5e/assets-v1/e05109ce-a18f-4ad7-ba4d-0896b5b1ea1b/mariposa_04.png"},
  @{f="mariposa_05.png";u="https://mis.xv-valerie.momentsbybl.com/__l5e/assets-v1/70330454-b09e-4ff2-83c0-48a612927b77/mariposa_05.png"},
  @{f="mariposa_06.png";u="https://mis.xv-valerie.momentsbybl.com/__l5e/assets-v1/97225497-2760-46f2-8854-43be82bb62ff/mariposa_06.png"},
  @{f="mariposa_07.png";u="https://mis.xv-valerie.momentsbybl.com/__l5e/assets-v1/059ab533-93a2-4378-96cd-a7ef4cdfa114/mariposa_07.png"},
  @{f="marco_cristal_vertical.png";u="https://mis.xv-valerie.momentsbybl.com/__l5e/assets-v1/0d64d7e8-e904-4e37-a066-7c2f8ba39b72/marco_cristal_vertical.png"},
  @{f="foto_principal.jpg";u="https://mis.xv-valerie.momentsbybl.com/__l5e/assets-v1/b4ff208a-f367-4875-b5a1-f17b9fbdb0e1/foto_principal.jpg"},
  @{f="reloj_medianoche.png";u="https://mis.xv-valerie.momentsbybl.com/__l5e/assets-v1/ed6348d0-b776-436e-889e-6ca7ae1d4818/reloj_medianoche.png"},
  @{f="candelabro_icono.png";u="https://mis.xv-valerie.momentsbybl.com/__l5e/assets-v1/e86b5611-adc8-42e6-bcf9-226d09ecece3/candelabro_icono.png"},
  @{f="recuerdo_01.jpg";u="https://mis.xv-valerie.momentsbybl.com/__l5e/assets-v1/2120a61b-1822-4120-abe8-def653a645c8/recuerdo_01.jpg"},
  @{f="dress_caballero_sport.png";u="https://mis.xv-valerie.momentsbybl.com/__l5e/assets-v1/c29dfc8d-195b-4a29-93c1-b7c99e254add/dress_caballero_sport.png"},
  @{f="dress_dama_sport.png";u="https://mis.xv-valerie.momentsbybl.com/__l5e/assets-v1/ce6a7d50-48ac-4a79-8fdc-b7f437747ef3/dress_dama_sport.png"},
  @{f="sobre_valerie.png";u="https://mis.xv-valerie.momentsbybl.com/__l5e/assets-v1/f1139dc9-f559-4f58-9548-38147f1b9c0b/sobre_valerie.png"},
  @{f="zapatilla_cristal.png";u="https://mis.xv-valerie.momentsbybl.com/__l5e/assets-v1/72bb546d-697d-4e91-a029-dcbb8b994e5a/zapatilla_cristal.png"},
  @{f="logo_moments.png";u="https://mis.xv-valerie.momentsbybl.com/__l5e/assets-v1/dc66be49-d2fc-46ec-97c1-5f273017006e/logo_moments.png"}
)

foreach($a in $assets){
  $dest = Join-Path $out $a.f
  Write-Host "Descargando $($a.f)..."
  Invoke-WebRequest -Uri $a.u -OutFile $dest -UseBasicParsing
}

Invoke-WebRequest -Uri "https://mis.xv-valerie.momentsbybl.com/__l5e/assets-v1/cdeff1d2-3429-4f16-a9df-20035706a439/background_desktop_16x9.png" -OutFile (Join-Path $out "background_desktop_16x9.png") -UseBasicParsing
Invoke-WebRequest -Uri "https://mis.xv-valerie.momentsbybl.com/__l5e/assets-v1/43cb1d07-b0a9-4df8-904e-a6f2e03cae76/intro.mp4" -OutFile (Join-Path $videoOut "intro.mp4") -UseBasicParsing
Invoke-WebRequest -Uri "https://mis.xv-valerie.momentsbybl.com/__l5e/assets-v1/0ba7a248-a919-46e2-803b-abd61f0a7d5f/musica.mp3" -OutFile (Join-Path $audioOut "musica.mp3") -UseBasicParsing

$config = Join-Path $root "EDITAR_AQUI.js"
$content = Get-Content $config -Raw
$content = $content -replace 'assetMode:\s*"remote"', 'assetMode: "local"'
Set-Content -Path $config -Value $content -Encoding UTF8
Write-Host "Listo. Assets descargados y assetMode cambiado a local." -ForegroundColor Green
