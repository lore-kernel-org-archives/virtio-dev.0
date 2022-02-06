Return-Path: <virtio-dev-return-9251-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9B1929860EA
	for <virtio-dev@lists.oasis-open.org>; Sun,  6 Feb 2022 15:23:45 +0000 (UTC)
Message-ID: <6311e54b-f526-8838-ad32-b174da3e8643@opensynergy.com>
Date: Sun, 6 Feb 2022 16:23:36 +0100
References: <CAOGAQerz6dM+ZStRUiFaSmYCQJsbpij5=S+OU=Ck+bbUKOR+Pw@mail.gmail.com>
From: Anton Yakovlev <anton.yakovlev@opensynergy.com>
In-Reply-To: <CAOGAQerz6dM+ZStRUiFaSmYCQJsbpij5=S+OU=Ck+bbUKOR+Pw@mail.gmail.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] virtio-snd spec question
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Roman Kiryanov <rkir@google.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hello Roman,

On 02.02.2022 00:57, Roman Kiryanov wrote:
> Hello,
>=20
> I work in Android Studio Emulator and I am currently implementing a=20
> virtio-snd device. We found a spec draft here:
>=20
> https://github.com/oasis-tcs/virtio-spec/commit/e73c8cdf3e822fd83c26c6de9=
64a947670f93cc3#diff-73045e70aeaf45f93087610437b705e2d320c82a9d29b4027721f5=
f5f3918dc5=20
> <https://github.com/oasis-tcs/virtio-spec/commit/e73c8cdf3e822fd83c26c6de=
964a947670f93cc3#diff-73045e70aeaf45f93087610437b705e2d320c82a9d29b4027721f=
5f5f3918dc5>
>=20
> It mentions four virtqueues: ctl, event, rx and tx. It is not very clear=
=20
> where a virtio-snd device should put responses to the ctl requests from=
=20
> the linux kernel driver. There is a kernel driver implementation and we=
=20
> have a virtio-snd=C2=A0device implemented in another emulator, it uses th=
e=20
> same virtqueue (ctl) to put ctl responses and the current kernel driver=
=20
> seems happy with this.
>=20
> Do you know if this is expected behavior? I am far from an expert here,=
=20
> but I believe the device and the kernel will race here by reading from=20
> the same virtqueue: the device could read VirtQueueElement produced by=20
> itself before the kernel if the kernel is not fast enough.

Yes, this is the expected behavior of the device and you are doing
everything right.

The virtio specification describes kind of single-producer single-
consumer lockless queue way to work with virtqueues. And if both the
device and the driver (in this case, the Linux kernel) follow the
specification, then you don't have to worry about a possible race
condition.

--=20
Anton Yakovlev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

