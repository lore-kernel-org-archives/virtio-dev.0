Return-Path: <virtio-dev-return-9248-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5A7D298660F
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Feb 2022 22:01:41 +0000 (UTC)
Date: Wed, 2 Feb 2022 17:01:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220202165623-mutt-send-email-mst@kernel.org>
References: <CAOGAQerz6dM+ZStRUiFaSmYCQJsbpij5=S+OU=Ck+bbUKOR+Pw@mail.gmail.com>
 <20220202024251-mutt-send-email-mst@kernel.org>
 <CAOGAQer+uO55se7N9ndr4psGqyqaGB4pnzgysusSc_WR1zA6sg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOGAQer+uO55se7N9ndr4psGqyqaGB4pnzgysusSc_WR1zA6sg@mail.gmail.com>
Subject: Re: [virtio-dev] virtio-snd spec question
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Roman Kiryanov <rkir@google.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 02, 2022 at 10:43:38AM -0800, Roman Kiryanov wrote:
> Sure. This is how I expect the device side ctl listening loop should look=
 like:
>=20
> while (...) {
> =A0 =A0 request =3D virtqueue_pop(ctl_vq, ...); =A0//1
> =A0 =A0 =A0 =A0 response =3D virtqueue_pop(ctl_vq, ...);=A0 //2
> =A0 =A0 =A0 =A0 virtqueue_push(ctl_vq, response, response_size):=A0 //3
> =A0 =A0 virtqueue_push(ctl_vq, request, 0):=A0 //4
> }
>=20
> My understanding is that line 1 could read output from line 3 if the kern=
el is
> not fast=A0enough fetching the response.

Is this code from qemu then? In that case I don't see how. virtqueue_pop ge=
ts
an available buffer. virtqueue_push adds a used buffer, not an available
one. I think it's just the API that's confusing.

> On Tue, Feb 1, 2022 at 11:44 PM Michael S. Tsirkin <mst@redhat.com> wrote=
:
>=20
>     On Tue, Feb 01, 2022 at 03:57:10PM -0800, Roman Kiryanov wrote:
>     > Hello,
>     >
>     > I work in Android Studio Emulator and I am currently implementing a
>     virtio-snd
>     > device. We found a spec draft here:
>     >
>     > https://github.com/oasis-tcs/virtio-spec/commit/
>     > e73c8cdf3e822fd83c26c6de964a947670f93cc3#
>     > diff-73045e70aeaf45f93087610437b705e2d320c82a9d29b4027721f5f5f3918d=
c5
>     >
>     > It mentions four virtqueues: ctl, event, rx and tx. It is not very =
clear
>     where
>     > a virtio-snd device should put responses to the ctl requests from t=
he
>     linux
>     > kernel driver. There is a kernel driver implementation and we have =
a
>     > virtio-snd=A0device implemented in another emulator, it uses the sa=
me
>     virtqueue
>     > (ctl) to put ctl responses and the current kernel driver seems happ=
y with
>     this.
>     >
>     > Do you know if this is expected behavior? I am far from an expert h=
ere,
>     but I
>     > believe the device and the kernel will race here by reading from th=
e same
>     > virtqueue: the device could read VirtQueueElement produced by itsel=
f
>     before the
>     > kernel if the kernel is not fast enough.
>     >
>     > Thank you.
>     >
>     > Regards,
>     > Roman.
>=20
>     Could you explain a bit more? which function in the kernel driver are
>     you referring to?
>=20
>=20
>=20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

