Function AudioControl {
    param (
    [parameter (Mandatory)] [ValidateSet('PlaySound','SetVolume','MuteToggle')] [String[]]$Mode,
    
    [ValidateSet('beep','ding','ding-da-ding','uhoh')] [String[]] $Sound,
    [ValidateSet('Play','DoNotPlay')] [String[]]$Action = "Play",
    [ValidateSet(1,2,3,4,5,6,7,8,9,10)] [Int32]$Repeat = 1,
    [ValidateSet(1000,1500,2000,2500,3000,3500,4000,4500)] $WaitMSecInbetween = 1000,

<#
.SYNOPSIS 

Control Audio by playing wav files, muting or setting the volume level

.EXAMPLE

PS> AudioControl -Mode PlaySound -Sound uhoh

.EXAMPLE

PS> AudioControl -Mode PlaySound -Sound error -WaitMSecInbetween 1500 -Repeat 2

.LINK

http://www.fabrikam.com/extension.html

.LINK
#>

    #SetVolume Parameters
    [int] $VolumeLevel
    )
                   
    Switch ($Mode) {
        PlaySound {
            Switch ($Sound) {
                beep {$PlayCommand = {[System.Media.SystemSounds]::Beep.Play()}}
                ding-da-ding {$PlayCommand = {[System.Media.SystemSounds]::Hand.Play()}}
                ding {$PlayCommand = {$Song = New-Object System.Media.SoundPlayer;$Song.SoundLocation = "$CRSPath\Sounds\ding.wav";$Song.Play()}}
                uhoh {$PlayCommand = {$Song = New-Object System.Media.SoundPlayer;$Song.SoundLocation = "$CRSPath\Sounds\uhoh.wav";$Song.Play()}}
            }
    
                IF ($Repeat -eq 1 -AND $WaitMSecInbetween -eq 1000) {Invoke-Command -ScriptBlock $PlayCommand}
                IF ($Repeat -gt 0) {$Counter = 1;DO {Invoke-Command -ScriptBlock $PlayCommand;$Counter++;Start-Sleep -Milliseconds $WaitMSecInbetween} UNTIL ($Counter -gt $Repeat)}
        }
        SetVolume {$wshShell = new-object -com wscript.shell;1..50 | % {$wshShell.SendKeys([char]174)};1..$VolumeLevel | % {$wshShell.SendKeys([char]175)}}
        MuteToggle {$wshShell = new-object -com wscript.shell;$wshShell.SendKeys([char]173)}
    }
} #Controls Audio