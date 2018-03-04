Return-Path: virtio-dev-return-3407-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id D0E245818F05
	for <virtio-dev@lists.oasis-open.org>; Sun,  4 Mar 2018 05:05:40 -0800 (PST)
From: Yan Vugenfirer <yvugenfi@redhat.com>
Message-Id: <258F88CA-D946-4804-A65D-2EA0790A66AF@redhat.com>
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_6B1FB8D7-CD9C-4D4A-BBC5-4E292CC94F8F"
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Date: Sun, 4 Mar 2018 15:05:22 +0200
In-Reply-To: <20180302221831-mutt-send-email-mst@kernel.org>
References: <cover.1519961667.git.jbaron@akamai.com>
 <c9d3cf2fbc3c64bb28e0438185d85d95b2088127.1519961667.git.jbaron@akamai.com>
 <7fc612d0-9610-9b07-d054-bb1438898f47@redhat.com>
 <20180302221831-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] [PATCH 4/4] virtio-net: add linkspeed and duplex
 settings to virtio-net
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Jason Baron <jbaron@akamai.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--Apple-Mail=_6B1FB8D7-CD9C-4D4A-BBC5-4E292CC94F8F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On 2 Mar 2018, at 22:19, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Fri, Mar 02, 2018 at 03:14:01PM +0800, Jason Wang wrote:
>>=20
>>=20
>> On 2018=E5=B9=B403=E6=9C=8802=E6=97=A5 11:46, Jason Baron wrote:
>>> Although linkspeed and duplex can be set in a linux guest via =
'ethtool -s',
>>> this requires custom ethtool commands for virtio-net by default.
>>>=20
>>> Introduce a new feature flag, VIRTIO_NET_F_SPEED_DUPLEX, which =
allows
>>> the hypervisor to export a linkspeed and duplex setting. The user =
can
>>> subsequently overwrite it later if desired via: 'ethtool -s'.
>>>=20
>>> Linkspeed and duplex settings can be set as:
>>> '-device virtio-net,speed=3D10000,duplex=3Dfull'
>>=20
>> I was thinking whether or not it's better to decide the duplex by the =
type
>> of backends.
>>=20
>> E.g userspace and vhost-kernel implement a in fact half duplex. But =
dpdk
>> implement a full duplex.
>>=20
>> Thanks
>=20
> OTOH it's a priority for some people to be able to support migration
> between different backend types. Breaking that won't be nice.

I think that in this case we need a way to update the settings of link =
speed and link duplex (maybe add QMP command). Migration between =
different backend types should cause link down\link up events. And this =
is a time for a driver to re-read the settings and update the OS.

Best regards,
Yan.

>=20
>>>=20
>>> where speed is [0...INT_MAX], and duplex is ["half"|"full"].
>>>=20
>>> Signed-off-by: Jason Baron<jbaron@akamai.com>
>>> Cc: "Michael S. Tsirkin"<mst@redhat.com>
>>> Cc: Jason Wang<jasowang@redhat.com>
>>> Cc:virtio-dev@lists.oasis-open.org
>>> ---
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


--Apple-Mail=_6B1FB8D7-CD9C-4D4A-BBC5-4E292CC94F8F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; line-break: after-white-space;" class=3D""><br =
class=3D""><div><br class=3D""><blockquote type=3D"cite" class=3D""><div =
class=3D"">On 2 Mar 2018, at 22:19, Michael S. Tsirkin &lt;<a =
href=3D"mailto:mst@redhat.com" class=3D"">mst@redhat.com</a>&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><div class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">On Fri, Mar 02, 2018 at =
03:14:01PM +0800, Jason Wang wrote:</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><blockquote=
 type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; =
word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D""><br class=3D""><br =
class=3D"">On 2018=E5=B9=B403=E6=9C=8802=E6=97=A5 11:46, Jason Baron =
wrote:<br class=3D""><blockquote type=3D"cite" class=3D"">Although =
linkspeed and duplex can be set in a linux guest via 'ethtool -s',<br =
class=3D"">this requires custom ethtool commands for virtio-net by =
default.<br class=3D""><br class=3D"">Introduce a new feature flag, =
VIRTIO_NET_F_SPEED_DUPLEX, which allows<br class=3D"">the hypervisor to =
export a linkspeed and duplex setting. The user can<br =
class=3D"">subsequently overwrite it later if desired via: 'ethtool =
-s'.<br class=3D""><br class=3D"">Linkspeed and duplex settings can be =
set as:<br class=3D"">'-device virtio-net,speed=3D10000,duplex=3Dfull'<br =
class=3D""></blockquote><br class=3D"">I was thinking whether or not =
it's better to decide the duplex by the type<br class=3D"">of =
backends.<br class=3D""><br class=3D"">E.g userspace and vhost-kernel =
implement a in fact half duplex. But dpdk<br class=3D"">implement a full =
duplex.<br class=3D""><br class=3D"">Thanks<br class=3D""></blockquote><br=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">OTOH it's a priority for some people to be able =
to support migration</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" class=3D"">between different backend types. =
Breaking that won't be nice.</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""></div></blockquote><div><br class=3D""></div><div>I think =
that in this case we need a way to update the settings of link speed and =
link duplex (maybe add QMP command). Migration between different backend =
types should cause link down\link up events. And this is a time for a =
driver to re-read the settings and update the OS.</div><div><br =
class=3D""></div><div>Best regards,</div><div>Yan.</div><div><br =
class=3D""></div><blockquote type=3D"cite" class=3D""><div class=3D""><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant-caps: normal; =
font-weight: normal; letter-spacing: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-size-adjust: auto; =
-webkit-text-stroke-width: 0px;" class=3D""><blockquote type=3D"cite" =
class=3D""><br class=3D"">where speed is [0...INT_MAX], and duplex is =
["half"|"full"].<br class=3D""><br class=3D"">Signed-off-by: Jason =
Baron&lt;<a href=3D"mailto:jbaron@akamai.com" =
class=3D"">jbaron@akamai.com</a>&gt;<br class=3D"">Cc: "Michael S. =
Tsirkin"&lt;<a href=3D"mailto:mst@redhat.com" =
class=3D"">mst@redhat.com</a>&gt;<br class=3D"">Cc: Jason Wang&lt;<a =
href=3D"mailto:jasowang@redhat.com" =
class=3D"">jasowang@redhat.com</a>&gt;<br class=3D"">Cc:<a =
href=3D"mailto:virtio-dev@lists.oasis-open.org" =
class=3D"">virtio-dev@lists.oasis-open.org</a><br class=3D"">---<br =
class=3D""></blockquote></blockquote><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; =
display: inline !important;" =
class=3D"">---------------------------------------------------------------=
------</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><span style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant-caps: =
normal; font-weight: normal; letter-spacing: normal; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; =
word-spacing: 0px; -webkit-text-stroke-width: 0px; float: none; display: =
inline !important;" class=3D"">To unsubscribe, <a =
href=3D"mailto:virtio-dev-unsubscribe@lists.oasis-open.org" =
class=3D"">e-mail: =
virtio-dev-unsubscribe@lists.oasis-open.org</a></span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant-caps: normal; font-weight: normal; letter-spacing: normal; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant-caps: normal; font-weight: normal; =
letter-spacing: normal; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; word-spacing: 0px; =
-webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">For additional commands, <a =
href=3D"mailto:virtio-dev-help@lists.oasis-open.org" class=3D"">e-mail: =
virtio-dev-help@lists.oasis-open.org</a></span></div></blockquote></div><b=
r class=3D""></body></html>=

--Apple-Mail=_6B1FB8D7-CD9C-4D4A-BBC5-4E292CC94F8F--
