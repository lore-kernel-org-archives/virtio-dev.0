Return-Path: <virtio-dev-return-9243-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9F8829865FD
	for <virtio-dev@lists.oasis-open.org>; Tue,  1 Feb 2022 23:57:22 +0000 (UTC)
MIME-Version: 1.0
From: Roman Kiryanov <rkir@google.com>
Date: Tue, 1 Feb 2022 15:57:10 -0800
Message-ID: <CAOGAQerz6dM+ZStRUiFaSmYCQJsbpij5=S+OU=Ck+bbUKOR+Pw@mail.gmail.com>
Subject: [virtio-dev] virtio-snd spec question
Content-Type: multipart/alternative; boundary="0000000000006ca9c205d6fda9ba"
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--0000000000006ca9c205d6fda9ba
Content-Type: text/plain; charset="UTF-8"

Hello,

I work in Android Studio Emulator and I am currently implementing a
virtio-snd device. We found a spec draft here:

https://github.com/oasis-tcs/virtio-spec/commit/e73c8cdf3e822fd83c26c6de964a947670f93cc3#diff-73045e70aeaf45f93087610437b705e2d320c82a9d29b4027721f5f5f3918dc5

It mentions four virtqueues: ctl, event, rx and tx. It is not very clear
where a virtio-snd device should put responses to the ctl requests from the
linux kernel driver. There is a kernel driver implementation and we have a
virtio-snd device implemented in another emulator, it uses the same
virtqueue (ctl) to put ctl responses and the current kernel driver seems
happy with this.

Do you know if this is expected behavior? I am far from an expert here, but
I believe the device and the kernel will race here by reading from the same
virtqueue: the device could read VirtQueueElement produced by itself before
the kernel if the kernel is not fast enough.

Thank you.

Regards,
Roman.

--0000000000006ca9c205d6fda9ba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>I work in Android Studio Emulato=
r and I am currently implementing a virtio-snd device. We found a spec draf=
t here:</div><div><br></div><div><a href=3D"https://github.com/oasis-tcs/vi=
rtio-spec/commit/e73c8cdf3e822fd83c26c6de964a947670f93cc3#diff-73045e70aeaf=
45f93087610437b705e2d320c82a9d29b4027721f5f5f3918dc5">https://github.com/oa=
sis-tcs/virtio-spec/commit/e73c8cdf3e822fd83c26c6de964a947670f93cc3#diff-73=
045e70aeaf45f93087610437b705e2d320c82a9d29b4027721f5f5f3918dc5</a><br></div=
><div><br></div><div>It mentions four virtqueues: ctl, event, rx and tx. It=
 is not very clear where a virtio-snd device should put responses to the ct=
l requests from the linux kernel driver. There is a kernel driver implement=
ation and we have a virtio-snd=C2=A0device implemented in another emulator,=
 it uses the same virtqueue (ctl) to put ctl responses and the current kern=
el driver seems happy with this.</div><div><br></div><div>Do you know if th=
is is expected behavior? I am far from an expert here, but I believe the de=
vice and the kernel will race here by reading from the same virtqueue: the =
device could read VirtQueueElement produced by itself before the kernel if =
the kernel is not fast enough.</div><div><br></div><div>Thank you.</div><di=
v><br></div><div>Regards,</div><div>Roman.</div></div>

--0000000000006ca9c205d6fda9ba--

