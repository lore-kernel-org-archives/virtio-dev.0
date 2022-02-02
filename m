Return-Path: <virtio-dev-return-9244-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 34892986606
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 Feb 2022 07:44:35 +0000 (UTC)
Date: Wed, 2 Feb 2022 02:44:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220202024251-mutt-send-email-mst@kernel.org>
References: <CAOGAQerz6dM+ZStRUiFaSmYCQJsbpij5=S+OU=Ck+bbUKOR+Pw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOGAQerz6dM+ZStRUiFaSmYCQJsbpij5=S+OU=Ck+bbUKOR+Pw@mail.gmail.com>
Subject: Re: [virtio-dev] virtio-snd spec question
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
To: Roman Kiryanov <rkir@google.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 01, 2022 at 03:57:10PM -0800, Roman Kiryanov wrote:
> Hello,
>=20
> I work in Android Studio Emulator and I am currently implementing a virti=
o-snd
> device. We found a spec draft here:
>=20
> https://github.com/oasis-tcs/virtio-spec/commit/
> e73c8cdf3e822fd83c26c6de964a947670f93cc3#
> diff-73045e70aeaf45f93087610437b705e2d320c82a9d29b4027721f5f5f3918dc5
>=20
> It mentions four virtqueues: ctl, event, rx and tx. It is not very clear =
where
> a virtio-snd device should put responses to the ctl requests from the lin=
ux
> kernel driver. There is a kernel driver implementation and we have a
> virtio-snd=A0device implemented in another emulator, it uses the same vir=
tqueue
> (ctl) to put ctl responses and the current kernel driver seems happy with=
 this.
>=20
> Do you know if this is expected behavior? I am far from an expert here, b=
ut I
> believe the device and the kernel will race here by reading from the same
> virtqueue: the device could read VirtQueueElement produced by itself befo=
re the
> kernel if the kernel is not fast enough.
>=20
> Thank you.
>=20
> Regards,
> Roman.

Could you explain a bit more? which function in the kernel driver are
you referring to?



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

