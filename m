Return-Path: <virtio-dev-return-9353-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 085D898655E
	for <virtio-dev@lists.oasis-open.org>; Tue,  8 Mar 2022 16:41:19 +0000 (UTC)
From: Radu Ocica <rocica@blackberry.com>
Date: Tue, 8 Mar 2022 16:41:06 +0000
Message-ID: <1029e3596964438693266546f1f8b4d0@blackberry.com>
References: <20220307194716.1517565-1-anton.yakovlev@opensynergy.com>,<20220307194716.1517565-2-anton.yakovlev@opensynergy.com>
In-Reply-To: <20220307194716.1517565-2-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH 1/1] ALSA: virtio: add support for audio
 controls
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_1029e3596964438693266546f1f8b4d0blackberrycom_"
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jason Wang <jasowang@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--_000_1029e3596964438693266546f1f8b4d0blackberrycom_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"


+/* supported roles for control elements */
+enum {
+       VIRTIO_SND_CTL_ROLE_UNDEFINED =3D 0,
+       VIRTIO_SND_CTL_ROLE_VOLUME,
+       VIRTIO_SND_CTL_ROLE_MUTE,
+       VIRTIO_SND_CTL_ROLE_GAIN
+};

Regarding "role" values:

  1.  While a volume-joined control can be represented using a control with=
 "count"=3D1 and "role"=3DVIRTIO_SND_CTL_ROLE_VOLUME, it would not be clear=
 on the guest side whether this is a volume control for a one channel sink =
or joined volume control for a multi channel sink; similar comment for swit=
ch-joined (corresponding role would be VIRTIO_SND_CTL_ROLE_MUTE). Is the gu=
est driver supposed to look for a channel map with the same hda_fn_nid valu=
e and infer from the relation between audio control "count" value and chann=
el map "channels" value, whether this is joined volume/mute control or not?=
 Could this be addressed in a simpler fashion by having separate "role" bit=
 mask values for joined volume and mute control?
  2.  There is no representation for a cswitch-exclusive control, so that t=
he cswitch-exclusive capability can be recognized on the guest side
  3.  What is the difference between VIRTIO_SND_CTL_ROLE_VOLUME and VIRTIO_=
SND_CTL_ROLE_GAIN?
  4.  The posted guest driver implementation doesn't make any use of the "r=
ole" information provided by the host device as part of struct virtio_snd_c=
tl_info. Is there a plan to add that in a later revision of the guest drive=
r?

+/* supported value types for control elements */
+enum {
+       VIRTIO_SND_CTL_TYPE_BOOLEAN =3D 0,
+       VIRTIO_SND_CTL_TYPE_INTEGER,
+       VIRTIO_SND_CTL_TYPE_INTEGER64,
+       VIRTIO_SND_CTL_TYPE_ENUMERATED,
+       VIRTIO_SND_CTL_TYPE_BYTES,
+       VIRTIO_SND_CTL_TYPE_IEC958
+};
Regarding relationship between audio control "role" and "type":
If certain data types are assumed for controls with role VIRTIO_SND_CTL_ROL=
E_VOLUME, VIRTIO_SND_CTL_ROLE_MUTE or VIRTIO_SND_CTL_ROLE_GAIN, it should b=
e specified (e.g. BOOLEAN for VIRTIO_SND_CTL_ROLE_MUTE)


+/* supported access rights for control elements */
+enum {
+       VIRTIO_SND_CTL_ACCESS_READ =3D 0,
+       VIRTIO_SND_CTL_ACCESS_WRITE,
+       VIRTIO_SND_CTL_ACCESS_VOLATILE,
+       VIRTIO_SND_CTL_ACCESS_INACTIVE,
+       VIRTIO_SND_CTL_ACCESS_TLV_READ,
+       VIRTIO_SND_CTL_ACCESS_TLV_WRITE,
+       VIRTIO_SND_CTL_ACCESS_TLV_COMMAND
+};

Regarding TLVs:

  1.  The TLV type values are considered well known from ALSA; there are on=
ly a few common TLV type definitions (like db scale, db min/max, a few more=
); they could be defined in virtio-snd.h for the completeness of the specif=
ication. Otherwise a non ALSA based host that supports reporting db scale a=
nd db min/max would need to redefine these to match the ALSA definitions
  2.  The original extension proposal used to include the definition of str=
uct virtio_snd_ctl_tlv. It is removed in the guest driver implementation an=
d the guest driver seems to memcpy to/from the equivalent ALSA struct. For =
the completeness of the specification all data structures used should be de=
scribed as part of the specification. This is particularly important when t=
he host or guest don't use ALSA.

+struct virtio_snd_ctl_info {
+       /* common header */
+       struct virtio_snd_info hdr;
+       /* element role (VIRTIO_SND_CTL_ROLE_XXX) */
+       __le32 role;
+       /* element value type (VIRTIO_SND_CTL_TYPE_XXX) */
+       __le32 type;
+       /* element access right bit map (1 << VIRTIO_SND_CTL_ACCESS_XXX) */
+       __le32 access;
+       /* # of members in the element value */
+       __le32 count;
+       /* index for an element with a non-unique name */
+       __le32 index;
+       /* name identifier string for the element */
+       __u8 name[44];
+       /* additional information about the element's value */
+       union {
+               /* VIRTIO_SND_CTL_TYPE_INTEGER */
+               struct {
+                       /* minimum supported value */
+                       __le32 min;
+                       /* maximum supported value */
+                       __le32 max;
+                       /* fixed step size for value (0 =3D variable size) =
*/
+                       __le32 step;
+               } integer;
+               /* VIRTIO_SND_CTL_TYPE_INTEGER64 */
+               struct {
+                       /* minimum supported value */
+                       __le64 min;
+                       /* maximum supported value */
+                       __le64 max;
+                       /* fixed step size for value (0 =3D variable size) =
*/
+                       __le64 step;
+               } integer64;
+               /* VIRTIO_SND_CTL_TYPE_ENUMERATED */
+               struct {
+                       /* # of options supported for value */
+                       __le32 items;
+               } enumerated;
+       } value;
+};

The field "name" of struct virtio_snd_ctl_info should have length 48 (or an=
other multiple of 8), to ensure 64 bit alignment for the integer64 union me=
mber below, regardless of alignment and packing attributes.

----------------------------------------------------------------------
This transmission (including any attachments) may contain confidential info=
rmation, privileged material (including material protected by the solicitor=
-client or other applicable privileges), or constitute non-public informati=
on. Any use of this information by anyone other than the intended recipient=
 is prohibited. If you have received this transmission in error, please imm=
ediately reply to the sender and delete this information from your system. =
Use, dissemination, distribution, or reproduction of this transmission by u=
nintended recipients is not authorized and may be unlawful.

--_000_1029e3596964438693266546f1f8b4d0blackberrycom_
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="iso-8859-1"

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p><br>
</p>
&#43;/* supported roles for control elements */<br>
<div style=3D"color: rgb(0, 0, 0);">
<div class=3D"PlainText">&#43;enum {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VIRTIO_SND_CTL_ROLE_UNDEFINED =3D=
 0,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VIRTIO_SND_CTL_ROLE_VOLUME,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VIRTIO_SND_CTL_ROLE_MUTE,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VIRTIO_SND_CTL_ROLE_GAIN<br>
&#43;};</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText"><span>Regarding &quot;role&quot; values:<br>
</span></div>
<div class=3D"PlainText">
<ol style=3D"margin-bottom: 0px; margin-top: 0px;">
<li><span>While a volume-joined control can be represented using a control =
with &quot;count&quot;=3D1 and &quot;role&quot;=3DVIRTIO_SND_CTL_ROLE_VOLUM=
E, it would not be clear on the guest side whether this is a volume control=
 for a one channel sink or joined volume control for a multi
 channel sink; similar comment for switch-joined (corresponding role would =
be VIRTIO_SND_CTL_ROLE_MUTE). Is the guest driver supposed to look for a ch=
annel map with the same hda_fn_nid value and infer from the relation betwee=
n audio control &quot;count&quot; value and
 channel map &quot;channels&quot; value, whether this is joined volume/mute=
 control or not? Could this be addressed in a simpler fashion by having sep=
arate &quot;role&quot; bit mask values for joined volume and mute control?<=
/span></li><li><span><span>There is no representation for a cswitch-exclusi=
ve control, so that the cswitch-exclusive capability can be recognized on t=
he guest side</span></span></li><li><span><span><span>What is the differenc=
e between VIRTIO_SND_CTL_ROLE_VOLUME and VIRTIO_SND_CTL_ROLE_GAIN?</span></=
span></span></li><li><span><span><span><span>The posted guest driver implem=
entation doesn't make any use of the &quot;role&quot; information provided =
by the host device as part of struct virtio_snd_ctl_info. Is there a plan t=
o add that in a later revision of the guest driver?</span><br>
</span></span></span></li></ol>
</div>
<div class=3D"PlainText"><br>
&#43;/* supported value types for control elements */<br>
&#43;enum {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VIRTIO_SND_CTL_TYPE_BOOLEAN =3D 0=
,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VIRTIO_SND_CTL_TYPE_INTEGER,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VIRTIO_SND_CTL_TYPE_INTEGER64,<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VIRTIO_SND_CTL_TYPE_ENUMERATED,<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VIRTIO_SND_CTL_TYPE_BYTES,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VIRTIO_SND_CTL_TYPE_IEC958<br>
&#43;};<br>
</div>
<div class=3D"PlainText"><span>Regarding relationship between audio control=
 &quot;role&quot; and &quot;type&quot;:<br>
</span></div>
<div class=3D"PlainText"><span>If certain data types are assumed for contro=
ls with role VIRTIO_SND_CTL_ROLE_VOLUME, VIRTIO_SND_CTL_ROLE_MUTE or VIRTIO=
_SND_CTL_ROLE_GAIN, it should be specified (e.g. BOOLEAN for VIRTIO_SND_CTL=
_ROLE_MUTE)</span></div>
<div class=3D"PlainText"><span><br>
</span></div>
<div class=3D"PlainText"><br>
&#43;/* supported access rights for control elements */<br>
&#43;enum {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VIRTIO_SND_CTL_ACCESS_READ =3D 0,=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VIRTIO_SND_CTL_ACCESS_WRITE,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VIRTIO_SND_CTL_ACCESS_VOLATILE,<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VIRTIO_SND_CTL_ACCESS_INACTIVE,<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VIRTIO_SND_CTL_ACCESS_TLV_READ,<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VIRTIO_SND_CTL_ACCESS_TLV_WRITE,<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VIRTIO_SND_CTL_ACCESS_TLV_COMMAND=
<br>
&#43;};<br>
</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Regarding TLVs:</div>
<div class=3D"PlainText">
<ol style=3D"margin-bottom: 0px; margin-top: 0px;">
<li><span>The TLV type values are considered well known from ALSA; there ar=
e only a few common TLV type definitions (like db scale, db min/max, a few =
more); they could be defined in virtio-snd.h for the completeness of the sp=
ecification. Otherwise a non ALSA
 based host that supports reporting db scale and db min/max would need to r=
edefine these to match the ALSA definitions</span></li><li><span><span>The =
original extension proposal used to include the definition of struct virtio=
_snd_ctl_tlv. It is removed in the guest driver implementation and the gues=
t driver seems to memcpy to/from the equivalent ALSA struct. For the comple=
teness of the
 specification all data structures used should be described as part of the =
specification. This is particularly important when the host or guest don't =
use ALSA.</span></span></li></ol>
<div><br>
</div>
&#43;struct virtio_snd_ctl_info {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* common header */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct virtio_snd_info hdr;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* element role (VIRTIO_SND_CTL_R=
OLE_XXX) */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __le32 role;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* element value type (VIRTIO_SND=
_CTL_TYPE_XXX) */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __le32 type;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* element access right bit map (=
1 &lt;&lt; VIRTIO_SND_CTL_ACCESS_XXX) */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __le32 access;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* # of members in the element va=
lue */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __le32 count;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* index for an element with a no=
n-unique name */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __le32 index;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* name identifier string for the=
 element */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u8 name[44];<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* additional information about t=
he element's value */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; union {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* VIRTIO_SND_CTL_TYPE_INTEGER */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; struct {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* minimum s=
upported value */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __le32 min;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* maximum s=
upported value */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __le32 max;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* fixed ste=
p size for value (0 =3D variable size) */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __le32 step;=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; } integer;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* VIRTIO_SND_CTL_TYPE_INTEGER64 */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; struct {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* minimum s=
upported value */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __le64 min;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* maximum s=
upported value */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __le64 max;<=
br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* fixed ste=
p size for value (0 =3D variable size) */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __le64 step;=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; } integer64;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; /* VIRTIO_SND_CTL_TYPE_ENUMERATED */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; struct {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* # of opti=
ons supported for value */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __le32 items=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; } enumerated;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } value;<br>
&#43;};<br>
<br>
<span>The field &quot;name&quot; of struct virtio_snd_ctl_info should have =
length 48 (or another multiple of 8), to ensure 64 bit alignment for the in=
teger64 union member below, regardless of alignment and packing attributes.=
</span><br>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;"></span></font></div>
</div>

<HR>This transmission (including any attachments) may contain confidential =
information, privileged material (including material protected by the solic=
itor-client or other applicable privileges), or constitute non-public infor=
mation. Any use of this information by anyone other than the intended recip=
ient is prohibited. If you have received this transmission in error, please=
 immediately reply to the sender and delete this information from your syst=
em. Use, dissemination, distribution, or reproduction of this transmission =
by unintended recipients is not authorized and may be unlawful.<BR>
</body>
</html>

--_000_1029e3596964438693266546f1f8b4d0blackberrycom_--

