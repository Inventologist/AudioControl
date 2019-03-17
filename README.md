# AudioControl
AudioControl gives you control over Volume, Mute, and Sound Playing (Both stock/internal Windows and External WAV files of your choice).

# Structure
Uses [System.Media.SystemSounds] and New-Object System.Media.SoundPlayer

# How to use AudioControl:
Call the function with the Mode you want it to be in and the Action you want it to perform

**EXAMPLE**:
<pre><code>
AudioControl -Mode PlaySound -Sound uhoh
AudioControl -Mode PlaySound -Sound ding -WaitMSecInbetween 1500 -Repeat 3
</code></pre>

**Be sure to Load up the module with**:  
<pre><code>
Import-Module $PathToModule\AudioControl.psm1
</code></pre>
