Return-Path: virtio-dev-return-2619-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id B4021581911B
	for <virtio-dev@lists.oasis-open.org>; Fri, 20 Oct 2017 02:50:07 -0700 (PDT)
From: Lars Ganrot <lga@napatech.com>
Date: Fri, 20 Oct 2017 09:50:03 +0000
Message-ID: <ea698aaf8a2c40c0a8904485831f52ab@napatech.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [virtio-dev] packed ring layout proposal v3
To: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Michael,

I'm trying to understand your Sep 28 13:32 example (text copied below). I'v=
e in-lined my questions [#lga#].

>
> Let's assume device promised to consume packets in order
>
> ring size =3D 2
>
> Ring is 0 initialized.
>
> Device initially polls DESC[0].flags for WRAP bit to change.
>
> driver adds:
>
> DESC[0].addr =3D 1234
> DESC[0].id =3D 0
> DESC[0].flags =3D DESC_DRIVER | DESC_MORE | DESC_WRAP
>
> and
>
> DESC[0].addr =3D 5678

[#lga#] Is index 0 above a typo (makes more sense if it is 1)?

> DESC[1].id =3D 1
> DESC[1].flags =3D DESC_DRIVER | DESC_WRAP
>
> it now starts polling DESC[0] flags.
>
> Device reads 1234, executes it, does not use it.
>
> Device reads 5678, executes it, and uses it:
>
> DESC[0].id =3D 1
> DESC[0].flags =3D 0

[#lga#] Should above line be: "DESC[0].flags =3D  DESC[1].flags  & DESC_WRA=
P"?

>
> Device now polls DESC[0].flags for WRAP bit to change.
>
> Now driver sees that DRIVER bit has been cleared, so it nows that id
> is valid. I sees id 1, therefore id 0 and 1 has been read and are safe to=
 overwrite.

[#lga#] At this point, has the device returned both buffers *(1234) and *(5=
678) to the driver?
[#lga#] If so, how would out-of-order completion avoid head of line blockin=
g?
[#lga#] E.g. the device is done with id=3D1 and *(5678), but not id=3D0 and=
 *(1234).

>
> So it writes it out. It wrapped around to beginning of ring, so it
> flips the WRAP bit to 0 on all descriptors now:
>
> DESC[0].addr =3D 9ABC
> DESC[0].id =3D 0
> DESC[0].flags =3D DESC_DRIVER | DESC_MORE
>
> DESC[0].addr =3D DEF0
> DESC[0].id =3D 1
> DESC[0].flags =3D DESC_DRIVER

[#lga#] Index typo in all 3 lines above? DESC[1] makes more sense.

>
> Next round wrap will be 1 again.
>
> To summarise:
>
> DRIVER bit is used by driver to detect device has used one or more
> descriptors.  WRAP is is used by device to detect driver has made a
> new descriptor available.

Best Regards,

-Lars
Disclaimer: This email and any files transmitted with it may contain confid=
ential information intended for the addressee(s) only. The information is n=
ot to be surrendered or copied to unauthorized persons. If you have receive=
d this communication in error, please notify the sender immediately and del=
ete this e-mail from your system.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

