Return-Path: <virtio-dev-return-9773-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 484F4986413
	for <virtio-dev@lists.oasis-open.org>; Thu, 11 Aug 2022 16:59:11 +0000 (UTC)
From: Patrick Mosca <pmosca@apple.com>
Message-id: <267A6CDA-ECA1-49A3-B5C9-0F458BB6658B@apple.com>
MIME-version: 1.0 (Mac OS X Mail 16.0 \(3731.0.8.1.1\))
Date: Thu, 11 Aug 2022 09:58:49 -0700
In-reply-to: <97C5284E-522F-4B35-A7F2-AEECA83148C9@apple.com>
References: <6355541D-E117-4E7F-B5D9-3CD0028ED7FF@apple.com>
 <20220605162839-mutt-send-email-mst@kernel.org>
 <F7C60FF0-08AC-4C61-B9C3-85C161818DE5@apple.com>
 <20220617062446-mutt-send-email-mst@kernel.org>
 <97C5284E-522F-4B35-A7F2-AEECA83148C9@apple.com>
Subject: Re: [virtio-dev] Clarification of VIRTIO_F_EVENT_IDX driver conditions.
Content-type: multipart/alternative;
 boundary="Apple-Mail=_8A709776-3B16-4C67-9F7D-909091C59E5B"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, Cameron Esfahani <dirty@apple.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--Apple-Mail=_8A709776-3B16-4C67-9F7D-909091C59E5B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Checking in here. Is the problem a little more clear now?

-Patrick Mosca

> On Jun 24, 2022, at 3:39 PM, Patrick Mosca <pmosca@apple.com> wrote:
>=20
>> Are you sure this is not an implementation bug?=20
>=20
> Possibly yes, but the specification could probably be made clearer to avo=
id such an implementation bug.
>=20
> My concern is that the helper method in question was originally part of t=
he 0.9.5 specification, even though it is no longer directly provided in th=
e 1.0+ versions of the specification.
>=20
> static inline int vring_need_event(uint16_t event_idx, uint16_t new_idx, =
uint16_t old_idx)
> {
> =09return (uint16_t)(new_idx - event_idx - 1) < (uint16_t)(new_idx - old_=
idx);
> }
>=20
> Neither the 0.9.5 nor the current specification mention any requirement o=
f notifying during a wrap, even though the Linux implementation correctly c=
hecks that unmentioned case, which was not provided in that 0.9.5 helper me=
thod or explicitly mentioned in the current specification.
>=20
> https://github.com/torvalds/linux/blob/7a68065eb9cd194cf03f135c9211eeb2d5=
c4c0a0/drivers/vhost/vringh.c#L522
>=20
> -Patrick Mosca
>=20
>> On Jun 17, 2022, at 3:30 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>=20
>> On Thu, Jun 16, 2022 at 01:53:38PM -0700, Patrick Mosca wrote:
>>> The issue may trigger in the unlikely uint16_t overflow case of
>>> computing the difference between two index positions.
>>=20
>> Are you sure this is not an implementation bug? I don't see
>> anywhere in the spec where we suggest computing the difference
>> between two index positions.
>>=20
>>> An
>>> example would be a network driver where the host and guest are
>>> producing and consuming steadily but at different rates. The
>>> producer is producing faster than the consumer such that the
>>> consumer never needed to be notified of new events, as it is
>>> still playing catch up processing the queue.  If the producer
>>> finally catches up to the consumer and the catchup occurs just
>>> past the overflow point, there exists a case where a
>>> notification must be sent but is not sent according to the
>>> current ruleset.=20
>>>=20
>>> -Patrick Mosca
>>=20
>> I don't see it sorry. Example?
>>=20
>> --=20
>> MST
>>=20
>=20


--Apple-Mail=_8A709776-3B16-4C67-9F7D-909091C59E5B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=
=3Dus-ascii"></head><body style=3D"overflow-wrap: break-word; -webkit-nbsp-=
mode: space; line-break: after-white-space;">Checking in here. Is the probl=
em a little more clear now?<div><br></div><div>-Patrick Mosca<br><div><br><=
blockquote type=3D"cite"><div>On Jun 24, 2022, at 3:39 PM, Patrick Mosca &l=
t;pmosca@apple.com&gt; wrote:</div><br class=3D"Apple-interchange-newline">=
<div><meta http-equiv=3D"content-type" content=3D"text/html; charset=3Dus-a=
scii"><div style=3D"overflow-wrap: break-word; -webkit-nbsp-mode: space; li=
ne-break: after-white-space;"><blockquote type=3D"cite">Are you sure this i=
s not an implementation bug?&nbsp;</blockquote><div><br></div>Possibly yes,=
 but the specification could probably be made clearer to avoid such an impl=
ementation bug.<div><br></div><div>My concern is that the helper method in =
question was originally part of the 0.9.5 specification, even though it is =
no longer directly provided in the 1.0+ versions of the specification.</div=
><div><br></div><div><div><i>static inline int vring_need_event(uint16_t ev=
ent_idx, uint16_t new_idx, uint16_t old_idx)</i></div><div><i>{</i></div><d=
iv><i><span class=3D"Apple-tab-span" style=3D"white-space:pre">=09</span>re=
turn (uint16_t)(new_idx - event_idx - 1) &lt; (uint16_t)(new_idx - old_idx)=
;</i></div><div><i>}</i></div><div><br></div><div>Neither the 0.9.5 nor the=
 current specification mention any requirement of notifying during a wrap, =
even though the Linux implementation correctly checks that unmentioned case=
, which was not provided in that 0.9.5 helper method or explicitly mentione=
d in the current specification.</div><div><br></div><div><div style=3D"disp=
lay: block;"><a href=3D"https://github.com/torvalds/linux/blob/7a68065eb9cd=
194cf03f135c9211eeb2d5c4c0a0/drivers/vhost/vringh.c#L522">https://github.co=
m/torvalds/linux/blob/7a68065eb9cd194cf03f135c9211eeb2d5c4c0a0/drivers/vhos=
t/vringh.c#L522</a><br></div></div><div style=3D"display: block;"><br></div=
><div style=3D"display: block;">-Patrick Mosca</div><div><br></div><div><bl=
ockquote type=3D"cite"><div>On Jun 17, 2022, at 3:30 AM, Michael S. Tsirkin=
 &lt;mst@redhat.com&gt; wrote:</div><br class=3D"Apple-interchange-newline"=
><div><div>On Thu, Jun 16, 2022 at 01:53:38PM -0700, Patrick Mosca wrote:<b=
r><blockquote type=3D"cite">The issue may trigger in the unlikely uint16_t =
overflow case of<br>computing the difference between two index positions.<b=
r></blockquote><br>Are you sure this is not an implementation bug? I don't =
see<br>anywhere in the spec where we suggest computing the difference<br>be=
tween two index positions.<br><br><blockquote type=3D"cite">An<br>example w=
ould be a network driver where the host and guest are<br>producing and cons=
uming steadily but at different rates. The<br>producer is producing faster =
than the consumer such that the<br>consumer never needed to be notified of =
new events, as it is<br>still playing catch up processing the queue. &nbsp;=
If the producer<br>finally catches up to the consumer and the catchup occur=
s just<br>past the overflow point, there exists a case where a<br>notificat=
ion must be sent but is not sent according to the<br>current ruleset. <br><=
br>-Patrick Mosca<br></blockquote><br>I don't see it sorry. Example?<br><br=
>-- <br>MST<br><br></div></div></blockquote></div><br></div></div></div></b=
lockquote></div><br></div></body></html>
--Apple-Mail=_8A709776-3B16-4C67-9F7D-909091C59E5B--

