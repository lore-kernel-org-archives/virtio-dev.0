Return-Path: virtio-dev-return-2689-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id E071B58191C8
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Nov 2017 05:38:29 -0800 (PST)
From: Yan Vugenfirer <yvugenfi@redhat.com>
Message-Id: <181C9C1B-9119-4B1D-8327-0C5EFD42A5F5@redhat.com>
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_9BB90F23-AEFA-433E-B54C-8C33559F574C"
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Thu, 16 Nov 2017 15:38:21 +0200
In-Reply-To: <13ca7e373615efac74661590527067ee8966f027.1505923516.git.tgolembi@redhat.com>
References: <cover.1505923516.git.tgolembi@redhat.com>
 <13ca7e373615efac74661590527067ee8966f027.1505923516.git.tgolembi@redhat.com>
Subject: Re: [virtio-dev] [PATCH 1/1] virtio-balloon: include buffers and
 chached memory statistics
To: =?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel <qemu-devel@nongnu.org>, Wei Wang <wei.w.wang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--Apple-Mail=_9BB90F23-AEFA-433E-B54C-8C33559F574C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hello All,

Michael asked me to comment regarding the possibility to get this =
statistics on Windows.
By using Win32_OperatingSystem WMI class we can calculate the amount of =
cached memory =
(https://msdn.microsoft.com/en-us/library/aa394239(v=3Dvs.85).aspx =
<https://msdn.microsoft.com/en-us/library/aa394239(v=3Dvs.85).aspx> =
http://brandonlive.com/2010/02/21/measuring-memory-usage-in-windows-7/ =
<http://brandonlive.com/2010/02/21/measuring-memory-usage-in-windows-7/>),=
 but Windows doesn=E2=80=99t let to distinguish between =E2=80=9Ccached =
and buffers=E2=80=9D as far as I see.=20

Best regards,
Yan.

> On 20 Sep 2017, at 19:05, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD =
<tgolembi@redhat.com> wrote:
>=20
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>
> ---
> hw/virtio/virtio-balloon.c                      | 2 ++
> include/standard-headers/linux/virtio_balloon.h | 4 +++-
> 2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
> index a705e0ec55..0434784c14 100644
> --- a/hw/virtio/virtio-balloon.c
> +++ b/hw/virtio/virtio-balloon.c
> @@ -49,6 +49,8 @@ static const char *balloon_stat_names[] =3D {
>    [VIRTIO_BALLOON_S_MEMFREE] =3D "stat-free-memory",
>    [VIRTIO_BALLOON_S_MEMTOT] =3D "stat-total-memory",
>    [VIRTIO_BALLOON_S_AVAIL] =3D "stat-available-memory",
> +   [VIRTIO_BALLOON_S_BUFFERS] =3D "stat-linux-buffers",
> +   [VIRTIO_BALLOON_S_CACHED] =3D "stat-linux-cached",
>    [VIRTIO_BALLOON_S_NR] =3D NULL
> };
>=20
> diff --git a/include/standard-headers/linux/virtio_balloon.h =
b/include/standard-headers/linux/virtio_balloon.h
> index 9d06ccd066..d61efbfcee 100644
> --- a/include/standard-headers/linux/virtio_balloon.h
> +++ b/include/standard-headers/linux/virtio_balloon.h
> @@ -52,7 +52,9 @@ struct virtio_balloon_config {
> #define VIRTIO_BALLOON_S_MEMFREE  4   /* Total amount of free memory =
*/
> #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of memory */
> #define VIRTIO_BALLOON_S_AVAIL    6   /* Available memory as in /proc =
*/
> -#define VIRTIO_BALLOON_S_NR       7
> +#define VIRTIO_BALLOON_S_BUFFERS  7   /* Buffers memory as in /proc =
*/
> +#define VIRTIO_BALLOON_S_CACHED   8   /* Cached memory as in /proc */
> +#define VIRTIO_BALLOON_S_NR       9
>=20
> /*
>  * Memory statistics structure.
> --=20
> 2.14.1
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>=20


--Apple-Mail=_9BB90F23-AEFA-433E-B54C-8C33559F574C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D"">Hello All,<div class=3D""><br class=3D""></div><div =
class=3D"">Michael asked me to comment regarding the possibility to get =
this statistics on Windows.</div><div class=3D"">By =
using&nbsp;Win32_OperatingSystem WMI class we can calculate the amount =
of cached memory (<a =
href=3D"https://msdn.microsoft.com/en-us/library/aa394239(v=3Dvs.85).aspx"=
 =
class=3D"">https://msdn.microsoft.com/en-us/library/aa394239(v=3Dvs.85).as=
px</a>&nbsp;<a =
href=3D"http://brandonlive.com/2010/02/21/measuring-memory-usage-in-window=
s-7/" =
class=3D"">http://brandonlive.com/2010/02/21/measuring-memory-usage-in-win=
dows-7/</a>), but Windows doesn=E2=80=99t let to distinguish between =
=E2=80=9Ccached and buffers=E2=80=9D as far as I see.&nbsp;</div><div =
class=3D""><br class=3D""></div><div class=3D"">Best regards,</div><div =
class=3D"">Yan.</div><div class=3D""><br class=3D""><div><blockquote =
type=3D"cite" class=3D""><div class=3D"">On 20 Sep 2017, at 19:05, =
Tom=C3=A1=C5=A1 Golembiovsk=C3=BD &lt;<a =
href=3D"mailto:tgolembi@redhat.com" class=3D"">tgolembi@redhat.com</a>&gt;=
 wrote:</div><br class=3D"Apple-interchange-newline"><div class=3D""><div =
class=3D"">Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD &lt;<a =
href=3D"mailto:tgolembi@redhat.com" =
class=3D"">tgolembi@redhat.com</a>&gt;<br class=3D"">---<br class=3D""> =
hw/virtio/virtio-balloon.c =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;| 2 ++<br class=3D""> =
include/standard-headers/linux/virtio_balloon.h | 4 +++-<br class=3D""> =
2 files changed, 5 insertions(+), 1 deletion(-)<br class=3D""><br =
class=3D"">diff --git a/hw/virtio/virtio-balloon.c =
b/hw/virtio/virtio-balloon.c<br class=3D"">index a705e0ec55..0434784c14 =
100644<br class=3D"">--- a/hw/virtio/virtio-balloon.c<br class=3D"">+++ =
b/hw/virtio/virtio-balloon.c<br class=3D"">@@ -49,6 +49,8 @@ static =
const char *balloon_stat_names[] =3D {<br class=3D""> =
&nbsp;&nbsp;&nbsp;[VIRTIO_BALLOON_S_MEMFREE] =3D "stat-free-memory",<br =
class=3D""> &nbsp;&nbsp;&nbsp;[VIRTIO_BALLOON_S_MEMTOT] =3D =
"stat-total-memory",<br class=3D""> =
&nbsp;&nbsp;&nbsp;[VIRTIO_BALLOON_S_AVAIL] =3D =
"stat-available-memory",<br class=3D"">+ =
&nbsp;&nbsp;[VIRTIO_BALLOON_S_BUFFERS] =3D "stat-linux-buffers",<br =
class=3D"">+ &nbsp;&nbsp;[VIRTIO_BALLOON_S_CACHED] =3D =
"stat-linux-cached",<br class=3D""> =
&nbsp;&nbsp;&nbsp;[VIRTIO_BALLOON_S_NR] =3D NULL<br class=3D""> };<br =
class=3D""><br class=3D"">diff --git =
a/include/standard-headers/linux/virtio_balloon.h =
b/include/standard-headers/linux/virtio_balloon.h<br class=3D"">index =
9d06ccd066..d61efbfcee 100644<br class=3D"">--- =
a/include/standard-headers/linux/virtio_balloon.h<br class=3D"">+++ =
b/include/standard-headers/linux/virtio_balloon.h<br class=3D"">@@ -52,7 =
+52,9 @@ struct virtio_balloon_config {<br class=3D""> #define =
VIRTIO_BALLOON_S_MEMFREE &nbsp;4 &nbsp;&nbsp;/* Total amount of free =
memory */<br class=3D""> #define VIRTIO_BALLOON_S_MEMTOT &nbsp;&nbsp;5 =
&nbsp;&nbsp;/* Total amount of memory */<br class=3D""> #define =
VIRTIO_BALLOON_S_AVAIL &nbsp;&nbsp;&nbsp;6 &nbsp;&nbsp;/* Available =
memory as in /proc */<br class=3D"">-#define VIRTIO_BALLOON_S_NR =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;7<br class=3D"">+#define =
VIRTIO_BALLOON_S_BUFFERS &nbsp;7 &nbsp;&nbsp;/* Buffers memory as in =
/proc */<br class=3D"">+#define VIRTIO_BALLOON_S_CACHED &nbsp;&nbsp;8 =
&nbsp;&nbsp;/* Cached memory as in /proc */<br class=3D"">+#define =
VIRTIO_BALLOON_S_NR &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;9<br =
class=3D""><br class=3D""> /*<br class=3D""> &nbsp;* Memory statistics =
structure.<br class=3D"">-- <br class=3D"">2.14.1<br class=3D""><br =
class=3D""><br =
class=3D"">---------------------------------------------------------------=
------<br class=3D"">To unsubscribe, e-mail: <a =
href=3D"mailto:virtio-dev-unsubscribe@lists.oasis-open.org" =
class=3D"">virtio-dev-unsubscribe@lists.oasis-open.org</a><br =
class=3D"">For additional commands, e-mail: <a =
href=3D"mailto:virtio-dev-help@lists.oasis-open.org" =
class=3D"">virtio-dev-help@lists.oasis-open.org</a><br class=3D""><br =
class=3D""></div></div></blockquote></div><br =
class=3D""></div></body></html>=

--Apple-Mail=_9BB90F23-AEFA-433E-B54C-8C33559F574C--
